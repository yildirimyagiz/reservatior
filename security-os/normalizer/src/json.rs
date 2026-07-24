use async_trait::async_trait;
use chrono::{DateTime, Utc};

use crate::errors::NormalizerError;
use crate::traits::{EventNormalizer, NormalizationResult, RawEvent, SourceFormat};
use security_os_core::*;

pub struct JsonNormalizer;

impl JsonNormalizer {
    pub fn new() -> Self {
        Self
    }

    fn get_str<'a>(payload: &'a serde_json::Value, keys: &[&str]) -> Option<&'a str> {
        for key in keys {
            if let Some(v) = payload.get(*key) {
                if let Some(s) = v.as_str() {
                    return Some(s);
                }
            }
        }
        None
    }

    fn get_u32(payload: &serde_json::Value, keys: &[&str]) -> Option<u32> {
        for key in keys {
            if let Some(v) = payload.get(*key) {
                if let Some(n) = v.as_u64() {
                    return Some(n as u32);
                }
                if let Some(s) = v.as_str() {
                    if let Ok(n) = s.parse::<u32>() {
                        return Some(n);
                    }
                }
            }
        }
        None
    }

    fn get_u16(payload: &serde_json::Value, keys: &[&str]) -> Option<u16> {
        for key in keys {
            if let Some(v) = payload.get(*key) {
                if let Some(n) = v.as_u64() {
                    return Some(n as u16);
                }
                if let Some(s) = v.as_str() {
                    if let Ok(n) = s.parse::<u16>() {
                        return Some(n);
                    }
                }
            }
        }
        None
    }

    fn get_u64(payload: &serde_json::Value, keys: &[&str]) -> Option<u64> {
        for key in keys {
            if let Some(v) = payload.get(*key) {
                if let Some(n) = v.as_u64() {
                    return Some(n);
                }
                if let Some(s) = v.as_str() {
                    if let Ok(n) = s.parse::<u64>() {
                        return Some(n);
                    }
                }
            }
        }
        None
    }

    fn get_f64(payload: &serde_json::Value, keys: &[&str]) -> Option<f64> {
        for key in keys {
            if let Some(v) = payload.get(*key) {
                if let Some(n) = v.as_f64() {
                    return Some(n);
                }
                if let Some(s) = v.as_str() {
                    if let Ok(n) = s.parse::<f64>() {
                        return Some(n);
                    }
                }
            }
        }
        None
    }

    fn parse_timestamp(payload: &serde_json::Value) -> Option<DateTime<Utc>> {
        let keys = ["timestamp", "time", "ts", "timeStamp", "datetime", "created_at", "date", "@timestamp"];
        for key in &keys {
            if let Some(v) = payload.get(*key) {
                if let Some(s) = v.as_str() {
                    if let Ok(dt) = DateTime::parse_from_rfc3339(s) {
                        return Some(dt.with_timezone(&Utc));
                    }
                    if let Ok(dt) = DateTime::parse_from_str(s, "%Y-%m-%dT%H:%M:%S%.fZ") {
                        return Some(dt.with_timezone(&Utc));
                    }
                    if let Ok(dt) = DateTime::parse_from_str(s, "%Y-%m-%d %H:%M:%S%.f") {
                        return Some(dt.with_timezone(&Utc));
                    }
                }
                if let Some(n) = v.as_i64() {
                    if n > 1_000_000_000_000 {
                        return DateTime::from_timestamp_millis(n);
                    } else {
                        return DateTime::from_timestamp(n, 0);
                    }
                }
            }
        }
        None
    }

    fn parse_severity(payload: &serde_json::Value) -> Severity {
        let keys = ["severity", "level", "sev", "priority", "log_level", "loglevel"];
        for key in &keys {
            if let Some(v) = payload.get(*key) {
                if let Some(s) = v.as_str() {
                    return match s.to_lowercase().as_str() {
                        "critical" | "fatal" | "panic" | "emerg" => Severity::Critical,
                        "high" | "error" | "err" | "major" => Severity::High,
                        "medium" | "warn" | "warning" | "moderate" => Severity::Medium,
                        "low" | "info" | "informational" | "notice" | "minor" => Severity::Low,
                        "debug" | "trace" | "verbose" => Severity::Informational,
                        _ => Severity::Medium,
                    };
                }
                if let Some(n) = v.as_u64() {
                    return match n {
                        0..=1 => Severity::Informational,
                        2..=3 => Severity::Low,
                        4..=5 => Severity::Medium,
                        6..=7 => Severity::High,
                        _ => Severity::Critical,
                    };
                }
            }
        }
        Severity::Medium
    }

    fn infer_category(payload: &serde_json::Value) -> EventCategory {
        if Self::get_str(payload, &["type", "event_type", "eventType", "category"]).is_some() {
            let cat = Self::get_str(payload, &["type", "event_type", "eventType", "category"])
                .unwrap_or("")
                .to_lowercase();
            match cat.as_str() {
                "process" | "proc" => return EventCategory::Process,
                "network" | "net" | "connection" => return EventCategory::Network,
                "file" | "filesystem" => return EventCategory::Filesystem,
                "auth" | "authentication" | "login" => return EventCategory::Authentication,
                "dns" => return EventCategory::Dns,
                "tls" | "ssl" => return EventCategory::Tls,
                "api" | "http" | "web" => return EventCategory::Api,
                "container" | "docker" => return EventCategory::Container,
                "kubernetes" | "k8s" => return EventCategory::Kubernetes,
                _ => {}
            }
        }

        if payload.get("src_ip").is_some() || payload.get("dst_ip").is_some()
            || payload.get("source_ip").is_some() || payload.get("destination_ip").is_some()
            || payload.get("src").is_some() || payload.get("dst").is_some()
        {
            return EventCategory::Network;
        }
        if payload.get("pid").is_some() || payload.get("process_name").is_some()
            || payload.get("exe").is_some() || payload.get("command").is_some()
            || payload.get("cmdline").is_some()
        {
            return EventCategory::Process;
        }
        if payload.get("file_path").is_some() || payload.get("filepath").is_some()
            || payload.get("filename").is_some()
        {
            return EventCategory::Filesystem;
        }
        if payload.get("user").is_some() || payload.get("username").is_some()
            || payload.get("user_id").is_some()
        {
            return EventCategory::Authentication;
        }

        EventCategory::System
    }

    fn infer_action(payload: &serde_json::Value) -> EventAction {
        let keys = ["action", "event", "event_type", "eventType", "type"];
        for key in &keys {
            if let Some(s) = Self::get_str(payload, &[key]) {
                let lower = s.to_lowercase();
                if lower.contains("creat") || lower.contains("add") || lower.contains("new") {
                    return EventAction::Created;
                }
                if lower.contains("delet") || lower.contains("remov") {
                    return EventAction::Deleted;
                }
                if lower.contains("modif") || lower.contains("chang") || lower.contains("updat") {
                    return EventAction::Modified;
                }
                if lower.contains("connect") || lower.contains("open") {
                    return EventAction::Connected;
                }
                if lower.contains("disconnect") || lower.contains("close") {
                    return EventAction::Disconnected;
                }
                if lower.contains("fail") || lower.contains("error") {
                    return EventAction::Failed;
                }
                if lower.contains("block") || lower.contains("deny") || lower.contains("reject") {
                    return EventAction::Blocked;
                }
                if lower.contains("allow") || lower.contains("accept") || lower.contains("permit") {
                    return EventAction::Allowed;
                }
                if lower.contains("exec") || lower.contains("run") {
                    return EventAction::Executed;
                }
                if lower.contains("start") {
                    return EventAction::Started;
                }
                if lower.contains("stop") {
                    return EventAction::Stopped;
                }
            }
        }
        EventAction::Detected
    }

    fn infer_title(payload: &serde_json::Value) -> String {
        Self::get_str(payload, &["title", "name", "summary", "alert", "rule_name"])
            .map(String::from)
            .unwrap_or_else(|| {
                let cat = Self::infer_category(payload);
                let action = Self::infer_action(payload);
                format!("JSON Event: {:?} / {:?}", cat, action)
            })
    }

    fn infer_description(payload: &serde_json::Value) -> String {
        Self::get_str(payload, &["description", "message", "msg", "log", "detail", "text", "body"])
            .map(String::from)
            .unwrap_or_else(|| "No description available".into())
    }
}

impl Default for JsonNormalizer {
    fn default() -> Self {
        Self::new()
    }
}

#[async_trait]
impl EventNormalizer for JsonNormalizer {
    fn format(&self) -> SourceFormat {
        SourceFormat::Json
    }

    fn name(&self) -> &str {
        "json"
    }

    fn can_handle(&self, event: &RawEvent) -> bool {
        event.source_format == SourceFormat::Json
            || event.payload.is_object()
    }

    async fn normalize(&self, event: &RawEvent) -> std::result::Result<NormalizationResult, NormalizerError> {
        let payload = &event.payload;
        let warnings = Vec::new();
        let mut unmapped = Vec::new();

        if !payload.is_object() {
            return Err(NormalizerError::Parse("JSON payload is not an object".into()));
        }

        let category = Self::infer_category(payload);
        let action = Self::infer_action(payload);
        let severity = Self::parse_severity(payload);
        let title = Self::infer_title(payload);
        let description = Self::infer_description(payload);

        let timestamp = Self::parse_timestamp(payload).unwrap_or_else(Utc::now);

        let src_ip = Self::get_str(payload, &["src_ip", "source_ip", "src", "source.ip", "sourceIp"])
            .map(String::from);
        let dst_ip = Self::get_str(payload, &["dst_ip", "destination_ip", "dst", "destination.ip", "destIp", "dest_ip"])
            .map(String::from);
        let src_port = Self::get_u16(payload, &["src_port", "source_port", "sport", "source.port"]);
        let dst_port = Self::get_u16(payload, &["dst_port", "destination_port", "dport", "dest.port"]);
        let protocol = Self::get_str(payload, &["protocol", "proto", "transport"]).map(String::from);

        let pid = Self::get_u32(payload, &["pid", "process_id", "processId"]);
        let ppid = Self::get_u32(payload, &["ppid", "parent_pid", "parentPid"]);
        let exe = Self::get_str(payload, &["exe", "executable", "process_path", "processPath", "binary"]).map(String::from);
        let cmdline = Self::get_str(payload, &["cmdline", "command_line", "commandLine", "command", "args"]).map(String::from);
        let process_name = Self::get_str(payload, &["process_name", "processName", "name", "proc"]).map(String::from);
        let username = Self::get_str(payload, &["user", "username", "user_name", "userName"]).map(String::from);
        let user_id = Self::get_u32(payload, &["uid", "user_id", "userId"]);

        let file_path = Self::get_str(payload, &["file_path", "filePath", "filepath", "path", "file", "filename"]).map(String::from);
        let file_hash = Self::get_str(payload, &["file_hash", "fileHash", "hash", "sha256", "hash_sha256"]).map(String::from);
        let file_size = Self::get_u64(payload, &["file_size", "fileSize", "size"]);
        let file_perms = Self::get_str(payload, &["file_permissions", "filePermissions", "permissions", "mode"]).map(String::from);

        let risk_score = Self::get_f64(payload, &["risk_score", "riskScore", "risk"]);

        let source = EventSource {
            collector: "json-normalizer".into(),
            host_id: Self::get_str(payload, &["host", "hostname", "host_id", "hostId", "host.name"])
                .unwrap_or("unknown")
                .into(),
            host_name: Self::get_str(payload, &["hostname", "host", "host_name", "hostName"])
                .unwrap_or("unknown")
                .into(),
            agent_id: Self::get_str(payload, &["agent_id", "agentId", "agent"])
                .unwrap_or("json-agent")
                .into(),
            agent_version: Self::get_str(payload, &["agent_version", "agentVersion"]).map(String::from),
            process_name,
            process_id: pid,
            user_id: user_id.map(|v| v.to_string()),
            user_name: username.clone(),
            container_id: Self::get_str(payload, &["container_id", "containerId", "container.id"]).map(String::from),
            container_name: Self::get_str(payload, &["container_name", "containerName", "container.name"]).map(String::from),
            pod_name: Self::get_str(payload, &["pod_name", "podName", "kubernetes.pod.name"]).map(String::from),
            namespace: Self::get_str(payload, &["namespace", "k8s_namespace", "kubernetes.namespace"]).map(String::from),
            service_name: Self::get_str(payload, &["service", "service_name", "serviceName", "service.name"]).map(String::from),
        };

        let mut security_event = SecurityEvent::new(category, action, source, title, description)
            .with_severity(severity);
        security_event.timestamp = timestamp;
        security_event.src_ip = src_ip;
        security_event.dst_ip = dst_ip;
        security_event.src_port = src_port;
        security_event.dst_port = dst_port;
        security_event.protocol = protocol;
        security_event.pid = pid;
        security_event.ppid = ppid;
        security_event.exe = exe;
        security_event.cmdline = cmdline;
        security_event.file_path = file_path;
        security_event.file_hash_sha256 = file_hash;
        security_event.file_size = file_size;
        security_event.file_permissions = file_perms;

        if let Some(score) = risk_score {
            security_event = security_event.with_risk_score(score);
        }

        if let Some(tags) = payload.get("tags").and_then(|v| v.as_array()) {
            security_event.tags = tags
                .iter()
                .filter_map(|v| v.as_str().map(String::from))
                .collect();
        }

        if let Some(mitre) = payload.get("mitre") {
            security_event.mitre_tactic = mitre.get("tactic").and_then(|v| v.as_str()).map(String::from);
            security_event.mitre_technique = mitre.get("technique").and_then(|v| v.as_str()).map(String::from);
            security_event.mitre_id = mitre.get("id").and_then(|v| v.as_str()).map(String::from);
        }

        if let Some(obj) = payload.as_object() {
            for k in obj.keys() {
                if !["timestamp", "time", "ts", "severity", "level", "type", "event_type",
                     "src_ip", "dst_ip", "src_port", "dst_port", "pid", "exe", "cmdline",
                     "user", "username", "file_path", "message", "title", "description",
                     "tags", "mitre", "action", "risk_score", "host", "hostname"].contains(&k.as_str())
                {
                    unmapped.push(k.clone());
                }
            }
        }

        let confidence = if payload.get("timestamp").is_some() || payload.get("time").is_some() {
            0.75
        } else {
            0.5
        };

        Ok(NormalizationResult {
            event: security_event,
            source_format: SourceFormat::Json,
            confidence,
            warnings,
            unmapped_fields: unmapped,
        })
    }

    fn confidence(&self, event: &RawEvent) -> f64 {
        let mut score: f64 = 0.4;
        if event.payload.is_object() {
            score += 0.15;
        }
        if event.payload.get("timestamp").is_some() || event.payload.get("time").is_some() {
            score += 0.1;
        }
        if event.payload.get("severity").is_some() || event.payload.get("level").is_some() {
            score += 0.1;
        }
        if event.payload.get("message").is_some() || event.payload.get("description").is_some() {
            score += 0.1;
        }
        if event.payload.get("src_ip").is_some() || event.payload.get("source_ip").is_some() {
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

    fn make_json_event(payload: serde_json::Value) -> RawEvent {
        RawEvent {
            source_format: SourceFormat::Json,
            payload,
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        }
    }

    #[tokio::test]
    async fn test_normalize_json_full() {
        let norm = JsonNormalizer::new();
        let payload = serde_json::json!({
            "timestamp": "2024-01-15T10:30:00Z",
            "severity": "high",
            "type": "process",
            "action": "executed",
            "message": "Suspicious binary executed",
            "src_ip": "10.0.0.1",
            "dst_ip": "192.168.1.1",
            "pid": 4567,
            "exe": "/tmp/malware",
            "cmdline": "/tmp/malware --payload",
            "user": "attacker",
            "file_path": "/tmp/malware",
            "tags": ["suspicious", "malware"],
            "risk_score": 75.0
        });
        let event = make_json_event(payload);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.source_format, SourceFormat::Json);
        assert_eq!(result.event.severity, Severity::High);
        assert_eq!(result.event.src_ip.as_deref(), Some("10.0.0.1"));
        assert_eq!(result.event.pid, Some(4567));
        assert_eq!(result.event.exe.as_deref(), Some("/tmp/malware"));
        assert_eq!(result.event.risk_score, 75.0);
        assert!(result.event.tags.contains(&"suspicious".to_string()));
    }

    #[tokio::test]
    async fn test_normalize_json_minimal() {
        let norm = JsonNormalizer::new();
        let payload = serde_json::json!({
            "msg": "Something happened"
        });
        let event = make_json_event(payload);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.severity, Severity::Medium);
        assert_eq!(result.event.description, "Something happened");
    }

    #[tokio::test]
    async fn test_json_confidence() {
        let norm = JsonNormalizer::new();
        let rich = make_json_event(serde_json::json!({
            "timestamp": "2024-01-01T00:00:00Z",
            "severity": "high",
            "message": "test",
            "src_ip": "1.2.3.4"
        }));
        assert!(norm.confidence(&rich) >= 0.7);

        let sparse = make_json_event(serde_json::json!({"foo": "bar"}));
        assert!(norm.confidence(&sparse) < 0.6);
    }

    #[test]
    fn test_severity_parsing() {
        assert_eq!(JsonNormalizer::parse_severity(&serde_json::json!({"severity": "critical"})), Severity::Critical);
        assert_eq!(JsonNormalizer::parse_severity(&serde_json::json!({"level": "error"})), Severity::High);
        assert_eq!(JsonNormalizer::parse_severity(&serde_json::json!({"severity": "warning"})), Severity::Medium);
        assert_eq!(JsonNormalizer::parse_severity(&serde_json::json!({"severity": "info"})), Severity::Low);
        assert_eq!(JsonNormalizer::parse_severity(&serde_json::json!({})), Severity::Medium);
    }

    #[test]
    fn test_category_inference() {
        assert_eq!(JsonNormalizer::infer_category(&serde_json::json!({"type": "process"})), EventCategory::Process);
        assert_eq!(JsonNormalizer::infer_category(&serde_json::json!({"type": "network"})), EventCategory::Network);
        assert_eq!(JsonNormalizer::infer_category(&serde_json::json!({"src_ip": "1.1.1.1"})), EventCategory::Network);
        assert_eq!(JsonNormalizer::infer_category(&serde_json::json!({"pid": 123})), EventCategory::Process);
    }

    #[test]
    fn test_action_inference() {
        assert_eq!(JsonNormalizer::infer_action(&serde_json::json!({"action": "create"})), EventAction::Created);
        assert_eq!(JsonNormalizer::infer_action(&serde_json::json!({"action": "delete"})), EventAction::Deleted);
        assert_eq!(JsonNormalizer::infer_action(&serde_json::json!({"action": "connect"})), EventAction::Connected);
        assert_eq!(JsonNormalizer::infer_action(&serde_json::json!({})), EventAction::Detected);
    }
}
