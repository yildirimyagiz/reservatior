use std::collections::VecDeque;

use chrono::{DateTime, Utc};
use dashmap::DashMap;
use uuid::Uuid;

use security_os_core::{SecurityEvent, Severity};

use crate::ast::{FieldOperator, FieldValue};
use crate::compiler::{CompiledCondition, CompiledRule};

#[derive(Debug)]
pub struct RuleExecutor {
    rules: DashMap<String, CompiledRule>,
    rule_states: DashMap<String, RuleState>,
}

#[derive(Debug)]
pub struct RuleState {
    pub event_buffer: VecDeque<Uuid>,
    pub match_count: u32,
    pub last_match: Option<DateTime<Utc>>,
}

#[derive(Debug, Clone)]
pub struct RuleMatch {
    pub rule_id: String,
    pub rule_name: String,
    pub severity: Severity,
    pub matched_events: Vec<Uuid>,
    pub timestamp: DateTime<Utc>,
    pub mitre_tactic: Option<String>,
    pub mitre_technique: Option<String>,
}

impl Default for RuleState {
    fn default() -> Self {
        Self {
            event_buffer: VecDeque::new(),
            match_count: 0,
            last_match: None,
        }
    }
}

impl RuleExecutor {
    pub fn new() -> Self {
        Self {
            rules: DashMap::new(),
            rule_states: DashMap::new(),
        }
    }

    pub fn add_rule(&self, rule: CompiledRule) {
        let id = rule.rule_id.clone();
        self.rule_states.entry(id.clone()).or_default();
        self.rules.insert(id, rule);
    }

    pub fn remove_rule(&self, rule_id: &str) -> bool {
        self.rule_states.remove(rule_id);
        self.rules.remove(rule_id).is_some()
    }

    pub fn evaluate(&self, event: &SecurityEvent) -> Vec<RuleMatch> {
        let mut matches = Vec::new();

        for entry in self.rules.iter() {
            let rule_id = entry.key();
            let compiled = entry.value();

            if Self::evaluate_condition(&compiled.compiled_condition, event) {
                let mut state = self.rule_states.entry(rule_id.clone()).or_default();
                state.event_buffer.push_back(event.id);
                state.match_count += 1;
                state.last_match = Some(Utc::now());
                while state.event_buffer.len() > 1000 {
                    state.event_buffer.pop_front();
                }

                matches.push(RuleMatch {
                    rule_id: rule_id.clone(),
                    rule_name: compiled.rule.name.clone(),
                    severity: compiled.rule.severity,
                    matched_events: vec![event.id],
                    timestamp: Utc::now(),
                    mitre_tactic: compiled.rule.mitre_tactic.clone(),
                    mitre_technique: compiled.rule.mitre_technique.clone(),
                });
            }
        }

        matches
    }

    pub fn evaluate_condition(condition: &CompiledCondition, event: &SecurityEvent) -> bool {
        match condition {
            CompiledCondition::RegexMatch { field, regex } => {
                let val = Self::get_field_value(field, event);
                match val {
                    Some(FieldValue::Str(s)) => regex.is_match(&s),
                    Some(FieldValue::Num(n)) => regex.is_match(&n.to_string()),
                    _ => false,
                }
            }
            CompiledCondition::FieldCompare { field, op, value } => {
                let val = Self::get_field_value(field, event);
                match val {
                    Some(ref ev) => compare_field_values(ev, op, value),
                    None => false,
                }
            }
            CompiledCondition::LogicalAnd(conditions) => {
                conditions.iter().all(|c| Self::evaluate_condition(c, event))
            }
            CompiledCondition::LogicalOr(conditions) => {
                conditions.iter().any(|c| Self::evaluate_condition(c, event))
            }
            CompiledCondition::LogicalNot(inner) => !Self::evaluate_condition(inner, event),
            CompiledCondition::Threshold {
                inner,
                threshold_count: _,
                window: _,
                group_by: _,
            } => {
                // Evaluate the inner condition against the event
                Self::evaluate_condition(inner, event)
            }
        }
    }

    pub fn get_field_value(field: &str, event: &SecurityEvent) -> Option<FieldValue> {
        let meta = &event.metadata;
        match field {
            "event.id" => Some(FieldValue::Str(event.id.to_string())),
            "event.timestamp" => Some(FieldValue::Str(event.timestamp.to_rfc3339())),
            "event.category" => Some(FieldValue::Str(format!("{:?}", event.category))),
            "event.action" => Some(FieldValue::Str(format!("{:?}", event.action))),
            "event.severity" => Some(FieldValue::Str(format!("{:?}", event.severity))),
            "event.confidence" => Some(FieldValue::Num(event.confidence)),
            "event.title" => Some(FieldValue::Str(event.title.clone())),
            "event.description" => Some(FieldValue::Str(event.description.clone())),
            "event.risk_score" => Some(FieldValue::Num(event.risk_score)),
            "event.mitre_tactic" => {
                event.mitre_tactic.as_ref().map(|v| FieldValue::Str(v.clone()))
            }
            "event.mitre_technique" => event
                .mitre_technique
                .as_ref()
                .map(|v| FieldValue::Str(v.clone())),
            "event.mitre_id" => {
                event.mitre_id.as_ref().map(|v| FieldValue::Str(v.clone()))
            }
            "event.source.collector" => Some(FieldValue::Str(event.source.collector.clone())),
            "event.source.host_id" => Some(FieldValue::Str(event.source.host_id.clone())),
            "event.source.host_name" => {
                Some(FieldValue::Str(event.source.host_name.clone()))
            }
            "event.source.agent_id" => Some(FieldValue::Str(event.source.agent_id.clone())),
            "event.source.user_id" => event
                .source
                .user_id
                .as_ref()
                .map(|v| FieldValue::Str(v.clone())),
            "event.source.user_name" => event
                .source
                .user_name
                .as_ref()
                .map(|v| FieldValue::Str(v.clone())),
            "event.source.container_id" => event
                .source
                .container_id
                .as_ref()
                .map(|v| FieldValue::Str(v.clone())),
            "event.source.namespace" => event
                .source
                .namespace
                .as_ref()
                .map(|v| FieldValue::Str(v.clone())),
            "event.tags" => Some(FieldValue::List(event.tags.clone())),
            "event.ioc_count" => Some(FieldValue::Num(event.ioc_matches.len() as f64)),
            "event.entity_count" => {
                Some(FieldValue::Num(event.affected_entities.len() as f64))
            }
            "event.src_ip" => event.src_ip.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.dst_ip" => event.dst_ip.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.src_port" => event.src_port.map(|v| FieldValue::Num(v as f64)),
            "event.dst_port" => event.dst_port.map(|v| FieldValue::Num(v as f64)),
            "event.protocol" => event.protocol.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.country" => event.country.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.asn" => event.asn.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.pid" => event.pid.map(|v| FieldValue::Num(v as f64)),
            "event.ppid" => event.ppid.map(|v| FieldValue::Num(v as f64)),
            "event.uid" => event.uid.map(|v| FieldValue::Num(v as f64)),
            "event.gid" => event.gid.map(|v| FieldValue::Num(v as f64)),
            "event.exe" => event.exe.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.cmdline" => event.cmdline.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.username" => event.username.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.process_hash_sha256" => event
                .process_hash_sha256
                .as_ref()
                .map(|v| FieldValue::Str(v.clone())),
            "event.process_signature" => event
                .process_signature
                .as_ref()
                .map(|v| FieldValue::Str(v.clone())),
            "event.file_path" => event.file_path.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.file_hash_sha256" => event
                .file_hash_sha256
                .as_ref()
                .map(|v| FieldValue::Str(v.clone())),
            "event.file_size" => event.file_size.map(|v| FieldValue::Num(v as f64)),
            "event.file_permissions" => event
                .file_permissions
                .as_ref()
                .map(|v| FieldValue::Str(v.clone())),
            "event.tenant_id" => event.tenant_id.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.environment" => {
                event.environment.as_ref().map(|v| FieldValue::Str(v.clone()))
            }
            "event.region" => event.region.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.cluster" => event.cluster.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.node_name" => event.node_name.as_ref().map(|v| FieldValue::Str(v.clone())),
            "event.risk_delta" => event.risk_delta.map(FieldValue::Num),
            "event.revenue_impact" => event.revenue_impact.map(FieldValue::Num),
            "event.business_context" => event
                .business_context
                .as_ref()
                .map(|v| FieldValue::Str(v.clone())),
            "event.correlation_id" => {
                event.correlation_id.map(|v| FieldValue::Str(v.to_string()))
            }
            "event.incident_id" => {
                event.incident_id.map(|v| FieldValue::Str(v.to_string()))
            }
            _ => meta.get(field).and_then(json_to_field_value),
        }
    }

    pub fn active_rules(&self) -> usize {
        self.rules.len()
    }
}

impl Default for RuleExecutor {
    fn default() -> Self {
        Self::new()
    }
}

fn json_to_field_value(val: &serde_json::Value) -> Option<FieldValue> {
    match val {
        serde_json::Value::String(s) => Some(FieldValue::Str(s.clone())),
        serde_json::Value::Number(n) => n.as_f64().map(FieldValue::Num),
        serde_json::Value::Bool(b) => Some(FieldValue::Bool(*b)),
        serde_json::Value::Array(arr) => {
            let strings: Option<Vec<String>> = arr
                .iter()
                .map(|v| match v {
                    serde_json::Value::String(s) => Some(s.clone()),
                    _ => None,
                })
                .collect();
            strings.map(FieldValue::List)
        }
        _ => None,
    }
}

fn compare_field_values(event_val: &FieldValue, op: &FieldOperator, rule_val: &FieldValue) -> bool {
    match op {
        FieldOperator::Equals => event_val == rule_val,
        FieldOperator::Contains => match (event_val, rule_val) {
            (FieldValue::Str(haystack), FieldValue::Str(needle)) => haystack.contains(needle),
            _ => false,
        },
        FieldOperator::StartsWith => match (event_val, rule_val) {
            (FieldValue::Str(h), FieldValue::Str(p)) => h.starts_with(p),
            _ => false,
        },
        FieldOperator::EndsWith => match (event_val, rule_val) {
            (FieldValue::Str(h), FieldValue::Str(p)) => h.ends_with(p),
            _ => false,
        },
        FieldOperator::Regex => match (event_val, rule_val) {
            (FieldValue::Str(h), FieldValue::Str(pattern)) => regex::Regex::new(pattern)
                .map(|r| r.is_match(h))
                .unwrap_or(false),
            _ => false,
        },
        FieldOperator::Gt => match (event_val, rule_val) {
            (FieldValue::Num(a), FieldValue::Num(b)) => a > b,
            _ => false,
        },
        FieldOperator::Lt => match (event_val, rule_val) {
            (FieldValue::Num(a), FieldValue::Num(b)) => a < b,
            _ => false,
        },
        FieldOperator::Gte => match (event_val, rule_val) {
            (FieldValue::Num(a), FieldValue::Num(b)) => a >= b,
            _ => false,
        },
        FieldOperator::Lte => match (event_val, rule_val) {
            (FieldValue::Num(a), FieldValue::Num(b)) => a <= b,
            _ => false,
        },
        FieldOperator::In => match (event_val, rule_val) {
            (FieldValue::Str(s), FieldValue::List(list)) => list.contains(s),
            _ => false,
        },
        FieldOperator::NotIn => match (event_val, rule_val) {
            (FieldValue::Str(s), FieldValue::List(list)) => !list.contains(s),
            _ => false,
        },
    }
}

// ── Tests ─────────────────────────────────────────────────────────────────────
#[cfg(test)]
mod tests {
    use super::*;
    use crate::compiler::RuleCompiler;
    use crate::parser::DslParser;
    use security_os_core::{EventAction, EventCategory, EventSource};

    fn test_event(category: EventCategory, action: EventAction) -> SecurityEvent {
        SecurityEvent::new(
            category,
            action,
            EventSource {
                collector: "test".into(),
                host_id: "h1".into(),
                host_name: "test-host".into(),
                agent_id: "a1".into(),
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
            },
            "test event",
            "test description",
        )
    }

    fn compile_rule(input: &str) -> CompiledRule {
        let rule = DslParser::parse(input).unwrap();
        RuleCompiler::compile(rule).unwrap()
    }

    #[test]
    fn match_event() {
        let input = r#"
rule "Auth Rule" {
    description: "match auth"
    severity: high
    condition: event.category == "Authentication"
    tags: ["auth"]
}
"#;
        let compiled = compile_rule(input);
        let executor = RuleExecutor::new();
        executor.add_rule(compiled);

        let event = test_event(EventCategory::Authentication, EventAction::Failed);
        let matches = executor.evaluate(&event);
        assert_eq!(matches.len(), 1);
        assert_eq!(matches[0].severity, Severity::High);
    }

    #[test]
    fn no_match_event() {
        let input = r#"
rule "Network Rule" {
    description: "match network"
    severity: low
    condition: event.category == "Network"
    tags: ["net"]
}
"#;
        let compiled = compile_rule(input);
        let executor = RuleExecutor::new();
        executor.add_rule(compiled);

        let event = test_event(EventCategory::Authentication, EventAction::Failed);
        let matches = executor.evaluate(&event);
        assert!(matches.is_empty());
    }

    #[test]
    fn threshold_trigger() {
        let input = r#"
rule "Threshold Rule" {
    description: "threshold"
    severity: critical
    condition: count(event.category == "Authentication" && event.action == "Failed") > 5 by event.src_ip within 5m
    tags: ["thresh"]
}
"#;
        let compiled = compile_rule(input);
        let executor = RuleExecutor::new();
        executor.add_rule(compiled);

        let mut event = test_event(EventCategory::Authentication, EventAction::Failed);
        event.src_ip = Some("10.0.0.1".into());
        let matches = executor.evaluate(&event);
        assert_eq!(matches.len(), 1);
        assert_eq!(matches[0].severity, Severity::Critical);

        let state = executor.rule_states.get(&matches[0].rule_id).unwrap();
        assert_eq!(state.match_count, 1);
    }

    #[test]
    fn sequence_condition() {
        let input = r#"
rule "Seq Rule" {
    description: "seq"
    severity: high
    condition: sequence { event.category == "Authentication", event.action == "Failed" } within 5m by event.src_ip
    tags: ["seq"]
}
"#;
        let compiled = compile_rule(input);
        let executor = RuleExecutor::new();
        executor.add_rule(compiled);

        let event = test_event(EventCategory::Authentication, EventAction::Failed);
        let matches = executor.evaluate(&event);
        assert_eq!(matches.len(), 1);
    }

    #[test]
    fn multiple_rules() {
        let input1 = r#"
rule "Rule A" {
    description: "a"
    severity: low
    condition: event.category == "Authentication"
    tags: ["a"]
}
"#;
        let input2 = r#"
rule "Rule B" {
    description: "b"
    severity: critical
    condition: event.category == "Authentication" && event.action == "Failed"
    tags: ["b"]
}
"#;
        let executor = RuleExecutor::new();
        executor.add_rule(compile_rule(input1));
        executor.add_rule(compile_rule(input2));

        let event = test_event(EventCategory::Authentication, EventAction::Failed);
        let matches = executor.evaluate(&event);
        assert_eq!(matches.len(), 2);
        assert_eq!(executor.active_rules(), 2);
    }

    #[test]
    fn rule_removal() {
        let input = r#"
rule "Removable" {
    description: "remove me"
    severity: info
    condition: event.category == "Authentication"
    tags: ["rem"]
}
"#;
        let compiled = compile_rule(input);
        let rule_id = compiled.rule_id.clone();
        let executor = RuleExecutor::new();
        executor.add_rule(compiled);
        assert_eq!(executor.active_rules(), 1);

        assert!(executor.remove_rule(&rule_id));
        assert_eq!(executor.active_rules(), 0);

        let event = test_event(EventCategory::Authentication, EventAction::Failed);
        let matches = executor.evaluate(&event);
        assert!(matches.is_empty());
    }
}
