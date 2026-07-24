use async_trait::async_trait;
use std::collections::HashMap;

use crate::errors::NormalizerError;
use crate::traits::{EventNormalizer, NormalizationResult, RawEvent, SourceFormat};
use security_os_core::*;

pub struct EcsNormalizer;

impl EcsNormalizer {
    pub fn new() -> Self {
        Self
    }

    fn map_ecs_category(event_kind: &str, event_category: Option<&str>) -> EventCategory {
        match event_kind {
            "process" => EventCategory::Process,
            "network" => EventCategory::Network,
            "file" | "iam" => EventCategory::Filesystem,
            "authentication" | "login" => EventCategory::Authentication,
            "dns" => EventCategory::Dns,
            "tls" => EventCategory::Tls,
            "package" => EventCategory::SupplyChain,
            "registry" => EventCategory::ConfigurationDrift,
            "session" => EventCategory::Authentication,
            _ => {
                if let Some(cat) = event_category {
                    match cat {
                        "network" => EventCategory::Network,
                        "process" => EventCategory::Process,
                        "file" => EventCategory::Filesystem,
                        "authentication" => EventCategory::Authentication,
                        "web" => EventCategory::Api,
                        "dns" => EventCategory::Dns,
                        "iam" => EventCategory::Authentication,
                        "package" => EventCategory::SupplyChain,
                        _ => EventCategory::System,
                    }
                } else {
                    EventCategory::System
                }
            }
        }
    }

    fn map_ecs_action(event_action: &str) -> EventAction {
        match event_action {
            "start" | "info" => EventAction::Started,
            "end" => EventAction::Stopped,
            "error" => EventAction::Failed,
            "creation" => EventAction::Created,
            "deletion" => EventAction::Deleted,
            "change" => EventAction::Modified,
            "connection" => EventAction::Connected,
            "connection_attempt" => EventAction::Attempted,
            "denied" => EventAction::Blocked,
            "allowed" => EventAction::Allowed,
            _ => EventAction::Detected,
        }
    }

    fn parse_ecs_severity(severity: Option<&str>, risk_score: Option<f64>) -> Severity {
        if let Some(s) = severity {
            match s.to_lowercase().as_str() {
                "critical" => return Severity::Critical,
                "high" | "major" => return Severity::High,
                "medium" | "moderate" => return Severity::Medium,
                "low" | "minor" => return Severity::Low,
                "informational" | "info" => return Severity::Informational,
                _ => {}
            }
        }
        if let Some(score) = risk_score {
            if score >= 80.0 {
                Severity::Critical
            } else if score >= 50.0 {
                Severity::High
            } else if score >= 25.0 {
                Severity::Medium
            } else if score > 0.0 {
                Severity::Low
            } else {
                Severity::Informational
            }
        } else {
            Severity::Medium
        }
    }

    fn get_nested_str<'a>(payload: &'a serde_json::Value, keys: &[&str]) -> Option<&'a str> {
        let mut current = payload;
        for key in keys {
            current = current.get(*key)?;
        }
        current.as_str()
    }

    fn get_nested_u16(payload: &serde_json::Value, keys: &[&str]) -> Option<u16> {
        let mut current = payload;
        for key in keys {
            current = current.get(*key)?;
        }
        current.as_u64().map(|v| v as u16)
    }

    fn get_nested_u32(payload: &serde_json::Value, keys: &[&str]) -> Option<u32> {
        let mut current = payload;
        for key in keys {
            current = current.get(*key)?;
        }
        current.as_u64().map(|v| v as u32)
    }

    fn get_nested_u64(payload: &serde_json::Value, keys: &[&str]) -> Option<u64> {
        let mut current = payload;
        for key in keys {
            current = current.get(*key)?;
        }
        current.as_u64()
    }
}

impl Default for EcsNormalizer {
    fn default() -> Self {
        Self::new()
    }
}

#[async_trait]
impl EventNormalizer for EcsNormalizer {
    fn format(&self) -> SourceFormat {
        SourceFormat::Ecs
    }

    fn name(&self) -> &str {
        "ecs"
    }

    fn can_handle(&self, event: &RawEvent) -> bool {
        if event.source_format == SourceFormat::Ecs {
            return true;
        }
        event.payload.get("@timestamp").is_some()
            || event.payload.get("event").is_some()
            || event.payload.get("ecs").is_some()
    }

    async fn normalize(&self, event: &RawEvent) -> std::result::Result<NormalizationResult, NormalizerError> {
        let payload = &event.payload;
        let warnings = Vec::new();
        let mut unmapped = Vec::new();

        let event_obj = payload.get("event").cloned().unwrap_or(serde_json::json!({}));

        let ecs_version = payload.get("ecs")
            .and_then(|e| e.get("version"))
            .and_then(|v| v.as_str())
            .map(String::from);

        let event_kind = event_obj.get("kind").and_then(|v| v.as_str()).unwrap_or("unknown");
        let event_category_str = event_obj.get("category")
            .and_then(|v| v.as_str())
            .or_else(|| event_obj.get("category").and_then(|v| v.as_array()).and_then(|arr| arr.first()).and_then(|v| v.as_str()));
        let event_action_str = event_obj.get("action").and_then(|v| v.as_str()).unwrap_or("unknown");
        let event_outcome = event_obj.get("outcome").and_then(|v| v.as_str());
        let severity_str = event_obj.get("severity")
            .and_then(|v| v.as_str())
            .or_else(|| event_obj.get("severity").and_then(|v| v.as_i64().map(|_| "")));
        let risk_score = event_obj.get("risk_score").and_then(|v| v.as_f64());

        let category = Self::map_ecs_category(event_kind, event_category_str);
        let action = Self::map_ecs_action(event_action_str);
        let severity = Self::parse_ecs_severity(severity_str, risk_score);

        let title = event_obj.get("module")
            .and_then(|v| v.as_str())
            .or_else(|| event_obj.get("dataset").and_then(|v| v.as_str()))
            .map(|s| format!("[ECS] {}", s))
            .unwrap_or_else(|| format!("[ECS] {} - {}", event_kind, event_action_str));

        let description = event_obj.get("original")
            .and_then(|v| v.as_str())
            .map(String::from)
            .unwrap_or_else(|| {
                event_obj.get("reason")
                    .and_then(|v| v.as_str())
                    .map(String::from)
                    .unwrap_or_else(|| format!("ECS event: {} / {}", event_kind, event_action_str))
            });

        let src_ip = Self::get_nested_str(payload, &["source", "ip"]).map(String::from);
        let dst_ip = Self::get_nested_str(payload, &["destination", "ip"]).map(String::from);
        let src_port = Self::get_nested_u16(payload, &["source", "port"]);
        let dst_port = Self::get_nested_u16(payload, &["destination", "port"]);
        let protocol = Self::get_nested_str(payload, &["network", "protocol"]).map(String::from);
        let process_name = Self::get_nested_str(payload, &["process", "name"]).map(String::from);
        let process_id = Self::get_nested_u32(payload, &["process", "pid"]);
        let parent_pid = Self::get_nested_u32(payload, &["process", "parent", "pid"]);
        let exe = Self::get_nested_str(payload, &["process", "executable"]).map(String::from);
        let cmdline = Self::get_nested_str(payload, &["process", "command_line"]).map(String::from);
        let username = Self::get_nested_str(payload, &["user", "name"]).map(String::from);
        let user_id = Self::get_nested_str(payload, &["user", "id"]).map(String::from);
        let file_path = Self::get_nested_str(payload, &["file", "path"]).map(String::from);
        let file_hash = Self::get_nested_str(payload, &["file", "hash", "sha256"]).map(String::from);
        let file_size = Self::get_nested_u64(payload, &["file", "size"]);
        let file_perms = Self::get_nested_str(payload, &["file", "mode"]).map(String::from);

        let host_name = Self::get_nested_str(payload, &["host", "name"]).map(String::from);
        let container_id = Self::get_nested_str(payload, &["container", "id"]).map(String::from);
        let container_name = Self::get_nested_str(payload, &["container", "name"]).map(String::from);
        let pod_name = Self::get_nested_str(payload, &["kubernetes", "pod", "name"]).map(String::from);
        let namespace = Self::get_nested_str(payload, &["kubernetes", "namespace"]).map(String::from);
        let cloud_region = Self::get_nested_str(payload, &["cloud", "region"]).map(String::from);

        let mut metadata = HashMap::new();
        if let Some(ref v) = ecs_version {
            metadata.insert("ecs.version".into(), serde_json::Value::String(v.to_string()));
        }
        if let Some(v) = event_obj.get("module").and_then(|v| v.as_str()) {
            metadata.insert("event.module".into(), serde_json::Value::String(v.into()));
        }
        if let Some(v) = event_obj.get("dataset").and_then(|v| v.as_str()) {
            metadata.insert("event.dataset".into(), serde_json::Value::String(v.into()));
        }
        if let Some(v) = event_outcome {
            metadata.insert("event.outcome".into(), serde_json::Value::String(v.into()));
        }
        if let Some(labels) = payload.get("labels") {
            if let Some(obj) = labels.as_object() {
                for (k, v) in obj {
                    metadata.insert(format!("label.{}", k), v.clone());
                }
            }
        }

        if Self::get_nested_str(payload, &["agent", "id"]).is_none() {
            unmapped.push("agent.id".into());
        }

        let mut mitre_tactic = None;
        let mut mitre_technique = None;
        let mut mitre_id = None;
        if let Some(threat) = payload.get("threat") {
            if let Some(tactic) = threat.get("tactic").and_then(|t| t.get("name")).and_then(|v| v.as_str()) {
                mitre_tactic = Some(tactic.into());
            }
            if let Some(technique) = threat.get("technique").and_then(|t| t.get("name")).and_then(|v| v.as_str()) {
                mitre_technique = Some(technique.into());
            }
            if let Some(id) = threat.get("technique").and_then(|t| t.get("id")).and_then(|v| v.as_str()) {
                mitre_id = Some(id.into());
            }
        }

        let tags: Vec<String> = payload.get("tags")
            .and_then(|v| v.as_array())
            .map(|arr| arr.iter().filter_map(|v| v.as_str().map(String::from)).collect())
            .unwrap_or_default();

        let source = EventSource {
            collector: "ecs-normalizer".into(),
            host_id: host_name.clone().unwrap_or_else(|| "unknown".into()),
            host_name: host_name.unwrap_or_else(|| "unknown".into()),
            agent_id: Self::get_nested_str(payload, &["agent", "id"]).unwrap_or("ecs-agent").into(),
            agent_version: Self::get_nested_str(payload, &["agent", "version"]).map(String::from),
            process_name,
            process_id,
            user_id,
            user_name: username,
            container_id,
            container_name,
            pod_name,
            namespace,
            service_name: Self::get_nested_str(payload, &["service", "name"]).map(String::from),
        };

        let mut security_event = SecurityEvent::new(category, action, source, title, description)
            .with_severity(severity);

        if let Some(score) = risk_score {
            security_event = security_event.with_risk_score(score);
        }

        security_event.src_ip = src_ip;
        security_event.dst_ip = dst_ip;
        security_event.src_port = src_port;
        security_event.dst_port = dst_port;
        security_event.protocol = protocol;
        security_event.pid = process_id;
        security_event.ppid = parent_pid;
        security_event.exe = exe;
        security_event.cmdline = cmdline;
        security_event.file_path = file_path;
        security_event.file_hash_sha256 = file_hash;
        security_event.file_size = file_size;
        security_event.file_permissions = file_perms;
        security_event.region = cloud_region;

        security_event.mitre_tactic = mitre_tactic;
        security_event.mitre_technique = mitre_technique;
        security_event.mitre_id = mitre_id;

        for (k, v) in metadata {
            security_event.metadata.insert(k, v);
        }
        security_event.tags = tags;

        let confidence = if ecs_version.is_some() || event_obj.get("kind").is_some() {
            0.85
        } else {
            0.5
        };

        Ok(NormalizationResult {
            event: security_event,
            source_format: SourceFormat::Ecs,
            confidence,
            warnings,
            unmapped_fields: unmapped,
        })
    }

    fn confidence(&self, event: &RawEvent) -> f64 {
        let mut score: f64 = 0.3;
        if event.payload.get("ecs").is_some() {
            score += 0.2;
        }
        if event.payload.get("@timestamp").is_some() {
            score += 0.1;
        }
        if event.payload.get("event").is_some() {
            score += 0.15;
        }
        if event.payload.get("source").is_some() || event.payload.get("destination").is_some() {
            score += 0.1;
        }
        score.min(0.95)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;
    use std::collections::HashMap;

    fn make_ecs_event(payload: serde_json::Value) -> RawEvent {
        RawEvent {
            source_format: SourceFormat::Ecs,
            payload,
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        }
    }

    #[tokio::test]
    async fn test_normalize_ecs_full() {
        let norm = EcsNormalizer::new();
        let payload = serde_json::json!({
            "@timestamp": "2024-01-15T10:30:00Z",
            "ecs": {"version": "8.11.0"},
            "event": {
                "kind": "event",
                "category": ["network"],
                "action": "connection_attempted",
                "outcome": "success",
                "risk_score": 45.0
            },
            "source": {"ip": "10.0.0.1", "port": 54321},
            "destination": {"ip": "172.16.0.5", "port": 443},
            "network": {"protocol": "tcp"},
            "host": {"name": "web-server-1"},
            "process": {"name": "curl", "pid": 12345}
        });
        let event = make_ecs_event(payload);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.source_format, SourceFormat::Ecs);
        assert_eq!(result.event.src_ip.as_deref(), Some("10.0.0.1"));
        assert_eq!(result.event.dst_ip.as_deref(), Some("172.16.0.5"));
        assert_eq!(result.event.src_port, Some(54321));
        assert_eq!(result.event.dst_port, Some(443));
        assert_eq!(result.event.severity, Severity::Medium);
        assert_eq!(result.event.pid, Some(12345));
    }

    #[tokio::test]
    async fn test_normalize_ecs_file_event() {
        let norm = EcsNormalizer::new();
        let payload = serde_json::json!({
            "@timestamp": "2024-01-15T10:30:00Z",
            "ecs": {"version": "8.11.0"},
            "event": {"kind": "event", "category": "file", "action": "creation"},
            "file": {"path": "/tmp/suspicious.exe", "hash": {"sha256": "abc123"}, "size": 1048576}
        });
        let event = make_ecs_event(payload);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.file_path.as_deref(), Some("/tmp/suspicious.exe"));
        assert_eq!(result.event.file_hash_sha256.as_deref(), Some("abc123"));
        assert_eq!(result.event.file_size, Some(1048576));
    }

    #[test]
    fn test_ecs_category_mapping() {
        assert_eq!(EcsNormalizer::map_ecs_category("process", None), EventCategory::Process);
        assert_eq!(EcsNormalizer::map_ecs_category("network", None), EventCategory::Network);
        assert_eq!(EcsNormalizer::map_ecs_category("unknown", Some("dns")), EventCategory::Dns);
    }

    #[test]
    fn test_ecs_severity_parsing() {
        assert_eq!(EcsNormalizer::parse_ecs_severity(Some("critical"), None), Severity::Critical);
        assert_eq!(EcsNormalizer::parse_ecs_severity(Some("high"), None), Severity::High);
        assert_eq!(EcsNormalizer::parse_ecs_severity(None, Some(90.0)), Severity::Critical);
        assert_eq!(EcsNormalizer::parse_ecs_severity(None, Some(10.0)), Severity::Low);
    }

    #[test]
    fn test_ecs_confidence() {
        let norm = EcsNormalizer::new();
        let full = make_ecs_event(serde_json::json!({
            "ecs": {"version": "8.11.0"},
            "@timestamp": "2024-01-15T10:30:00Z",
            "event": {"kind": "event"}
        }));
        assert!(norm.confidence(&full) >= 0.7);
        let empty = make_ecs_event(serde_json::json!({}));
        assert!(norm.confidence(&empty) < 0.5);
    }
}
