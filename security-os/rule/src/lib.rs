use chrono::{DateTime, Utc};
use dashmap::DashMap;
use regex::Regex;
use security_os_core::*;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Rule {
    pub id: String,
    pub name: String,
    pub description: String,
    pub enabled: bool,
    pub severity: Severity,
    pub risk_score: f64,
    pub condition: Condition,
    pub mitre_id: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum Condition {
    And(Vec<Condition>),
    Or(Vec<Condition>),
    Not(Box<Condition>),
    FieldEquals {
        field: String,
        value: String,
    },
    FieldContains {
        field: String,
        value: String,
    },
    FieldMatches {
        field: String,
        pattern: String,
    },
    Threshold {
        event_type: String,
        count: u32,
        window_secs: i64,
    },
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RuleMatch {
    pub rule_id: String,
    pub matched_at: DateTime<Utc>,
    pub risk_contribution: f64,
}

#[derive(Debug)]
pub struct RuleEngine {
    rules: Vec<Rule>,
    threshold_counters: DashMap<String, Vec<DateTime<Utc>>>,
}

impl RuleEngine {
    pub fn new() -> Self {
        Self {
            rules: Vec::new(),
            threshold_counters: DashMap::new(),
        }
    }

    pub fn load_rules(&mut self, rules: Vec<Rule>) {
        self.rules.extend(rules);
    }

    pub fn extract_field(event: &SecurityEvent, field: &str) -> Option<String> {
        match field {
            "category" => Some(format!("{:?}", event.category)),
            "action" => Some(format!("{:?}", event.action)),
            "severity" => Some(format!("{:?}", event.severity)),
            "title" => Some(event.title.clone()),
            "description" => Some(event.description.clone()),
            "source.collector" => Some(event.source.collector.clone()),
            "source.host_id" => Some(event.source.host_id.clone()),
            "source.host_name" => Some(event.source.host_name.clone()),
            "source.agent_id" => Some(event.source.agent_id.clone()),
            "source.user_id" => event.source.user_id.clone(),
            "source.user_name" => event.source.user_name.clone(),
            "source.process_name" => event.source.process_name.clone(),
            "source.container_id" => event.source.container_id.clone(),
            "source.container_name" => event.source.container_name.clone(),
            "source.pod_name" => event.source.pod_name.clone(),
            "source.namespace" => event.source.namespace.clone(),
            key if key.starts_with("metadata.") => {
                let meta_key = &key[9..];
                event.metadata.get(meta_key).map(|v| match v {
                    serde_json::Value::String(s) => s.clone(),
                    other => other.to_string(),
                })
            }
            _ => None,
        }
    }

    fn evaluate_condition(
        &self,
        condition: &Condition,
        event: &SecurityEvent,
        history: &[SecurityEvent],
    ) -> bool {
        match condition {
            Condition::And(conditions) => {
                conditions
                    .iter()
                    .all(|c| self.evaluate_condition(c, event, history))
            }
            Condition::Or(conditions) => {
                conditions
                    .iter()
                    .any(|c| self.evaluate_condition(c, event, history))
            }
            Condition::Not(inner) => !self.evaluate_condition(inner, event, history),
            Condition::FieldEquals { field, value } => {
                Self::extract_field(event, field)
                    .map(|f| f == *value)
                    .unwrap_or(false)
            }
            Condition::FieldContains { field, value } => {
                Self::extract_field(event, field)
                    .map(|f| f.contains(value.as_str()))
                    .unwrap_or(false)
            }
            Condition::FieldMatches { field, pattern } => {
                if let Ok(re) = Regex::new(pattern) {
                    Self::extract_field(event, field)
                        .map(|f| re.is_match(&f))
                        .unwrap_or(false)
                } else {
                    false
                }
            }
            Condition::Threshold {
                event_type,
                count,
                window_secs,
            } => {
                let now = Utc::now();
                let window_start =
                    now - chrono::Duration::seconds(*window_secs);

                let timestamps = self
                    .threshold_counters
                    .entry(event_type.clone())
                    .or_insert_with(Vec::new);

                let matching_count = timestamps
                    .iter()
                    .filter(|t| **t >= window_start)
                    .count() as u32;

                matching_count >= *count
            }
        }
    }

    fn record_threshold_event(&self, event: &SecurityEvent) {
        let event_type = format!("{:?}", event.category);
        let mut timestamps = self
            .threshold_counters
            .entry(event_type)
            .or_insert_with(Vec::new);
        timestamps.push(event.timestamp);
    }

    pub fn evaluate(
        &self,
        event: &SecurityEvent,
        history: &[SecurityEvent],
    ) -> Vec<RuleMatch> {
        self.record_threshold_event(event);

        let mut matches = Vec::new();

        for rule in &self.rules {
            if !rule.enabled {
                continue;
            }

            if self.evaluate_condition(&rule.condition, event, history) {
                matches.push(RuleMatch {
                    rule_id: rule.id.clone(),
                    matched_at: Utc::now(),
                    risk_contribution: rule.risk_score,
                });
            }
        }

        matches
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn make_event(
        category: EventCategory,
        action: EventAction,
        title: &str,
        description: &str,
    ) -> SecurityEvent {
        let source = EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "test-host".into(),
            agent_id: "agent-1".into(),
            process_name: Some("sshd".into()),
            process_id: Some(1234),
            user_id: Some("user1".into()),
            user_name: Some("alice".into()),
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
        
            agent_version: None,
            service_name: None,
        };
        SecurityEvent::new(category, action, source, title, description)
    }

    #[test]
    fn test_new_engine() {
        let engine = RuleEngine::new();
        assert!(engine.rules.is_empty());
    }

    #[test]
    fn test_simple_field_equals() {
        let mut engine = RuleEngine::new();
        engine.load_rules(vec![Rule {
            id: "r1".into(),
            name: "Test Rule".into(),
            description: "Test".into(),
            enabled: true,
            severity: Severity::High,
            risk_score: 50.0,
            condition: Condition::FieldEquals {
                field: "category".into(),
                value: "Authentication".into(),
            },
            mitre_id: None,
        }]);

        let event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            "Auth Event",
            "User logged in",
        );

        let matches = engine.evaluate(&event, &[]);
        assert_eq!(matches.len(), 1);
        assert_eq!(matches[0].rule_id, "r1");
        assert_eq!(matches[0].risk_contribution, 50.0);
    }

    #[test]
    fn test_field_equals_no_match() {
        let mut engine = RuleEngine::new();
        engine.load_rules(vec![Rule {
            id: "r1".into(),
            name: "Test Rule".into(),
            description: "Test".into(),
            enabled: true,
            severity: Severity::High,
            risk_score: 50.0,
            condition: Condition::FieldEquals {
                field: "category".into(),
                value: "Network".into(),
            },
            mitre_id: None,
        }]);

        let event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            "Auth Event",
            "User logged in",
        );

        let matches = engine.evaluate(&event, &[]);
        assert!(matches.is_empty());
    }

    #[test]
    fn test_regex_match() {
        let mut engine = RuleEngine::new();
        engine.load_rules(vec![Rule {
            id: "r1".into(),
            name: "Regex Rule".into(),
            description: "Test regex".into(),
            enabled: true,
            severity: Severity::Medium,
            risk_score: 30.0,
            condition: Condition::FieldMatches {
                field: "title".into(),
                pattern: r"(?i)login.*failed".into(),
            },
            mitre_id: None,
        }]);

        let event = make_event(
            EventCategory::Authentication,
            EventAction::Failed,
            "Login Failed for user admin",
            "Failed login attempt",
        );

        let matches = engine.evaluate(&event, &[]);
        assert_eq!(matches.len(), 1);
    }

    #[test]
    fn test_regex_no_match() {
        let mut engine = RuleEngine::new();
        engine.load_rules(vec![Rule {
            id: "r1".into(),
            name: "Regex Rule".into(),
            description: "Test regex".into(),
            enabled: true,
            severity: Severity::Medium,
            risk_score: 30.0,
            condition: Condition::FieldMatches {
                field: "title".into(),
                pattern: r"(?i)login.*failed".into(),
            },
            mitre_id: None,
        }]);

        let event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            "Successful Login",
            "User logged in successfully",
        );

        let matches = engine.evaluate(&event, &[]);
        assert!(matches.is_empty());
    }

    #[test]
    fn test_and_combinator() {
        let mut engine = RuleEngine::new();
        engine.load_rules(vec![Rule {
            id: "r1".into(),
            name: "AND Rule".into(),
            description: "Both conditions must match".into(),
            enabled: true,
            severity: Severity::High,
            risk_score: 70.0,
            condition: Condition::And(vec![
                Condition::FieldEquals {
                    field: "category".into(),
                    value: "Authentication".into(),
                },
                Condition::FieldEquals {
                    field: "severity".into(),
                    value: "High".into(),
                },
            ]),
            mitre_id: None,
        }]);

        // Both match
        let event = make_event(
            EventCategory::Authentication,
            EventAction::Failed,
            "High Severity Auth Event",
            "Critical auth failure",
        );
        let mut event = event;
        event.severity = Severity::High;

        let matches = engine.evaluate(&event, &[]);
        assert_eq!(matches.len(), 1);

        // Only one matches
        let event2 = make_event(
            EventCategory::Authentication,
            EventAction::Failed,
            "Medium Auth Event",
            "Auth failure",
        );

        let matches2 = engine.evaluate(&event2, &[]);
        assert!(matches2.is_empty());
    }

    #[test]
    fn test_or_combinator() {
        let mut engine = RuleEngine::new();
        engine.load_rules(vec![Rule {
            id: "r1".into(),
            name: "OR Rule".into(),
            description: "Either condition matches".into(),
            enabled: true,
            severity: Severity::Medium,
            risk_score: 40.0,
            condition: Condition::Or(vec![
                Condition::FieldEquals {
                    field: "category".into(),
                    value: "Authentication".into(),
                },
                Condition::FieldEquals {
                    field: "category".into(),
                    value: "Network".into(),
                },
            ]),
            mitre_id: None,
        }]);

        let event = make_event(
            EventCategory::Network,
            EventAction::Connected,
            "Network Event",
            "Connection established",
        );

        let matches = engine.evaluate(&event, &[]);
        assert_eq!(matches.len(), 1);
    }

    #[test]
    fn test_not_combinator() {
        let mut engine = RuleEngine::new();
        engine.load_rules(vec![Rule {
            id: "r1".into(),
            name: "NOT Rule".into(),
            description: "Negate condition".into(),
            enabled: true,
            severity: Severity::Low,
            risk_score: 20.0,
            condition: Condition::Not(Box::new(Condition::FieldEquals {
                field: "category".into(),
                value: "Authentication".into(),
            })),
            mitre_id: None,
        }]);

        // Should NOT match Authentication
        let event1 = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            "Auth Event",
            "User logged in",
        );
        let matches1 = engine.evaluate(&event1, &[]);
        assert!(matches1.is_empty());

        // Should match non-Authentication
        let event2 = make_event(
            EventCategory::Network,
            EventAction::Connected,
            "Network Event",
            "Connection",
        );
        let matches2 = engine.evaluate(&event2, &[]);
        assert_eq!(matches2.len(), 1);
    }

    #[test]
    fn test_disabled_rule() {
        let mut engine = RuleEngine::new();
        engine.load_rules(vec![Rule {
            id: "r1".into(),
            name: "Disabled Rule".into(),
            description: "Should not match".into(),
            enabled: false,
            severity: Severity::High,
            risk_score: 50.0,
            condition: Condition::FieldEquals {
                field: "category".into(),
                value: "Authentication".into(),
            },
            mitre_id: None,
        }]);

        let event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            "Auth Event",
            "User logged in",
        );

        let matches = engine.evaluate(&event, &[]);
        assert!(matches.is_empty());
    }

    #[test]
    fn test_threshold_condition() {
        let mut engine = RuleEngine::new();
        engine.load_rules(vec![Rule {
            id: "r1".into(),
            name: "Threshold Rule".into(),
            description: "Alert on 3+ events".into(),
            enabled: true,
            severity: Severity::Critical,
            risk_score: 90.0,
            condition: Condition::Threshold {
                event_type: "Authentication".into(),
                count: 3,
                window_secs: 300,
            },
            mitre_id: None,
        }]);

        let event = make_event(
            EventCategory::Authentication,
            EventAction::Failed,
            "Failed Login",
            "Auth failure",
        );

        // First two events should not trigger
        let matches1 = engine.evaluate(&event, &[]);
        assert!(matches1.is_empty());

        let matches2 = engine.evaluate(&event, &[]);
        assert!(matches2.is_empty());

        // Third event triggers threshold
        let matches3 = engine.evaluate(&event, &[]);
        assert_eq!(matches3.len(), 1);
        assert_eq!(matches3[0].risk_contribution, 90.0);
    }

    #[test]
    fn test_extract_field_metadata() {
        let mut event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            "Auth Event",
            "User logged in",
        );
        event.metadata.insert(
            "src_ip".into(),
            serde_json::Value::String("192.168.1.100".into()),
        );

        let value = RuleEngine::extract_field(&event, "metadata.src_ip");
        assert_eq!(value.as_deref(), Some("192.168.1.100"));
    }

    #[test]
    fn test_extract_field_unknown() {
        let event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            "Auth Event",
            "User logged in",
        );

        let value = RuleEngine::extract_field(&event, "nonexistent.field");
        assert!(value.is_none());
    }

    #[test]
    fn test_field_contains() {
        let mut engine = RuleEngine::new();
        engine.load_rules(vec![Rule {
            id: "r1".into(),
            name: "Contains Rule".into(),
            description: "Test contains".into(),
            enabled: true,
            severity: Severity::Medium,
            risk_score: 35.0,
            condition: Condition::FieldContains {
                field: "description".into(),
                value: "admin".into(),
            },
            mitre_id: None,
        }]);

        let event = make_event(
            EventCategory::Authentication,
            EventAction::Failed,
            "Auth Event",
            "Failed login for admin user",
        );

        let matches = engine.evaluate(&event, &[]);
        assert_eq!(matches.len(), 1);
    }
}
