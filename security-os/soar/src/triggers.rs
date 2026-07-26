use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

use security_os_core::SecurityEvent;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum Trigger {
    Webhook { path: String, method: String },
    Cron { expression: String },
    EventCategory { category: String },
    SeverityAbove { severity: String },
    RiskScoreAbove { threshold: f64 },
    Manual,
    IocMatch { feed: String },
    IncidentCreated,
}

impl Trigger {
    pub fn description(&self) -> String {
        match self {
            Trigger::Webhook { path, method } => {
                format!("Webhook {} {}", method, path)
            }
            Trigger::Cron { expression } => {
                format!("Cron schedule: {}", expression)
            }
            Trigger::EventCategory { category } => {
                format!("Event category matches: {}", category)
            }
            Trigger::SeverityAbove { severity } => {
                format!("Severity above: {}", severity)
            }
            Trigger::RiskScoreAbove { threshold } => {
                format!("Risk score above: {}", threshold)
            }
            Trigger::Manual => "Manual trigger".to_string(),
            Trigger::IocMatch { feed } => {
                format!("IOC match from feed: {}", feed)
            }
            Trigger::IncidentCreated => "Incident created".to_string(),
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TriggerContext {
    pub trigger_type: String,
    pub event: Option<SecurityEvent>,
    pub metadata: HashMap<String, serde_json::Value>,
    pub timestamp: DateTime<Utc>,
}

impl TriggerContext {
    pub fn manual() -> Self {
        Self {
            trigger_type: "manual".to_string(),
            event: None,
            metadata: HashMap::new(),
            timestamp: Utc::now(),
        }
    }

    pub fn from_event(event: SecurityEvent) -> Self {
        Self {
            trigger_type: "event".to_string(),
            event: Some(event),
            metadata: HashMap::new(),
            timestamp: Utc::now(),
        }
    }

    pub fn with_metadata(mut self, key: impl Into<String>, value: serde_json::Value) -> Self {
        self.metadata.insert(key.into(), value);
        self
    }
}

pub fn severity_to_numeric(severity: &str) -> u8 {
    match severity.to_uppercase().as_str() {
        "INFO" | "INFORMATIONAL" => 0,
        "LOW" => 1,
        "MEDIUM" => 2,
        "HIGH" => 3,
        "CRITICAL" => 4,
        _ => 0,
    }
}

pub fn matches_trigger(trigger: &Trigger, context: &TriggerContext) -> bool {
    match trigger {
        Trigger::Webhook { path, method } => {
            context.trigger_type == "webhook"
                && context
                    .metadata
                    .get("path")
                    .and_then(|v| v.as_str())
                    .map(|p| p == path.as_str())
                    .unwrap_or(false)
                && context
                    .metadata
                    .get("method")
                    .and_then(|v| v.as_str())
                    .map(|m| m.eq_ignore_ascii_case(method.as_str()))
                    .unwrap_or(false)
        }
        Trigger::Cron { .. } => {
            context.trigger_type == "cron"
        }
        Trigger::EventCategory { category } => {
            if let Some(ref event) = context.event {
                format!("{:?}", event.category) == *category
            } else {
                false
            }
        }
        Trigger::SeverityAbove { severity } => {
            if let Some(ref event) = context.event {
                let min_severity = severity_to_numeric(severity);
                event.severity.numeric() > min_severity
            } else {
                false
            }
        }
        Trigger::RiskScoreAbove { threshold } => {
            if let Some(ref event) = context.event {
                event.risk_score > *threshold
            } else {
                false
            }
        }
        Trigger::Manual => context.trigger_type == "manual",
        Trigger::IocMatch { feed } => {
            if let Some(ref event) = context.event {
                event.ioc_matches.iter().any(|ioc| ioc.feed == *feed)
            } else {
                false
            }
        }
        Trigger::IncidentCreated => context.trigger_type == "incident_created",
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{EventAction, EventCategory, EventSource, IocMatch};

    fn make_test_event() -> SecurityEvent {
        let source = EventSource {
            collector: "test".to_string(),
            host_id: "host-1".to_string(),
            host_name: "test-host".to_string(),
            agent_id: "agent-1".to_string(),
            agent_version: None,
            process_name: None,
            process_id: None,
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            service_name: None,
        };
        SecurityEvent::new(
            EventCategory::Network,
            EventAction::Detected,
            source,
            "Test event",
            "Test event for trigger matching",
        )
    }

    #[test]
    fn test_webhook_trigger_matches() {
        let trigger = Trigger::Webhook {
            path: "/api/alerts".to_string(),
            method: "POST".to_string(),
        };
        let mut metadata = HashMap::new();
        metadata.insert(
            "path".to_string(),
            serde_json::Value::String("/api/alerts".to_string()),
        );
        metadata.insert(
            "method".to_string(),
            serde_json::Value::String("POST".to_string()),
        );
        let context = TriggerContext {
            trigger_type: "webhook".to_string(),
            event: None,
            metadata,
            timestamp: Utc::now(),
        };
        assert!(matches_trigger(&trigger, &context));
    }

    #[test]
    fn test_cron_trigger_matches() {
        let trigger = Trigger::Cron {
            expression: "0 */6 * * *".to_string(),
        };
        let context = TriggerContext {
            trigger_type: "cron".to_string(),
            event: None,
            metadata: HashMap::new(),
            timestamp: Utc::now(),
        };
        assert!(matches_trigger(&trigger, &context));
    }

    #[test]
    fn test_severity_trigger() {
        let trigger = Trigger::SeverityAbove {
            severity: "MEDIUM".to_string(),
        };
        let mut event = make_test_event();
        event.severity = security_os_core::Severity::Critical;
        let context = TriggerContext::from_event(event);
        assert!(matches_trigger(&trigger, &context));
    }

    #[test]
    fn test_ioc_match_trigger() {
        let trigger = Trigger::IocMatch {
            feed: "alienvault-otx".to_string(),
        };
        let mut event = make_test_event();
        event.ioc_matches.push(IocMatch {
            ioc_type: "ip".to_string(),
            ioc_value: "10.0.0.1".to_string(),
            feed: "alienvault-otx".to_string(),
            feed_url: None,
            match_context: "outbound connection".to_string(),
            confidence: 0.95,
            first_seen: None,
            last_seen: None,
        });
        let context = TriggerContext::from_event(event);
        assert!(matches_trigger(&trigger, &context));
    }
}
