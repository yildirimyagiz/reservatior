#[cfg(test)]
mod integration_tests {
    use crate::*;
    use crate::traits::{RawEvent, SourceFormat};
    use chrono::Utc;
    use std::collections::HashMap;

    fn raw_event(format: SourceFormat, payload: serde_json::Value) -> RawEvent {
        RawEvent {
            source_format: format,
            payload,
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        }
    }

    #[tokio::test]
    async fn test_sigma_normalizer_end_to_end() {
        let norm = SigmaNormalizer::new();
        let event = raw_event(SourceFormat::Sigma, serde_json::json!({
            "title": "Suspicious Scheduled Task",
            "description": "Detects creation of suspicious scheduled tasks",
            "level": "high",
            "logsource": {
                "category": "scheduled_task",
                "product": "windows"
            },
            "detection": {
                "condition": "selection",
                "selection": {"TaskName|contains": "evil"}
            },
            "tags": ["attack.t1053", "attack.persistence"],
            "author": "SOC Team"
        }));
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.severity, security_os_core::Severity::High);
        assert_eq!(result.event.category, security_os_core::EventCategory::Cron);
        assert_eq!(result.event.action, security_os_core::EventAction::Detected);
        assert!(result.event.rule_name.as_deref().unwrap().contains("Scheduled Task"));
    }

    #[tokio::test]
    async fn test_otel_normalizer_end_to_end() {
        let norm = OtelNormalizer::new();
        let event = raw_event(SourceFormat::OpenTelemetry, serde_json::json!({
            "resourceSpans": [{
                "resource": {
                    "attributes": {
                        "service.name": "auth-service",
                        "host.name": "prod-01"
                    }
                },
                "scopeSpans": [{
                    "scope": {"name": "http-server", "version": "1.0"},
                    "spans": [{
                        "name": "POST /api/v2/login",
                        "traceId": "abcdef1234567890",
                        "spanId": "1234567890abcdef",
                        "status": {"code": "STATUS_CODE_OK"}
                    }]
                }]
            }]
        }));
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.severity, security_os_core::Severity::Informational);
        assert!(result.event.title.contains("POST /api/v2/login"));
        assert_eq!(result.event.source.host_name, "prod-01");
    }

    #[tokio::test]
    async fn test_cef_normalizer_end_to_end() {
        let norm = CefNormalizer::new();
        let cef_raw = "CEF:0|PaloAlto|PAN-OS|10.0|TRAFFIC|Allow|3|src=10.1.1.1 dst=10.2.2.2 spt=45678 dpt=443 proto=tcp app=https msg=Outbound traffic allowed";
        let event = raw_event(SourceFormat::Cef, serde_json::json!({"raw": cef_raw}));
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.src_ip.as_deref(), Some("10.1.1.1"));
        assert_eq!(result.event.dst_ip.as_deref(), Some("10.2.2.2"));
        assert_eq!(result.event.src_port, Some(45678));
        assert_eq!(result.event.dst_port, Some(443));
        assert_eq!(result.event.severity, security_os_core::Severity::Medium);
    }

    #[tokio::test]
    async fn test_ecs_normalizer_end_to_end() {
        let norm = EcsNormalizer::new();
        let event = raw_event(SourceFormat::Ecs, serde_json::json!({
            "@timestamp": "2024-06-15T12:00:00Z",
            "ecs": {"version": "8.12.0"},
            "event": {
                "kind": "alert",
                "category": "network",
                "action": "connection_attempted",
                "outcome": "failure"
            },
            "source": {"ip": "192.168.1.100", "port": 12345},
            "destination": {"ip": "10.0.0.1", "port": 22},
            "network": {"protocol": "tcp"},
            "host": {"name": "firewall-01"},
            "process": {"name": "ssh", "pid": 9999}
        }));
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.src_ip.as_deref(), Some("192.168.1.100"));
        assert_eq!(result.event.dst_port, Some(22));
        assert_eq!(result.event.pid, Some(9999));
        assert_eq!(result.event.source.host_name, "firewall-01");
    }

    #[tokio::test]
    async fn test_syslog_normalizer_end_to_end() {
        let norm = SyslogNormalizer::new();
        let event = raw_event(SourceFormat::Syslog, serde_json::json!({
            "message": "<34>Jan  5 14:09:08 webhost nginx[5432]: 10.0.0.1 - - [05/Jan/2024:14:09:08 +0000] GET /admin HTTP/1.1 403"
        }));
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.severity, security_os_core::Severity::High);
        assert_eq!(result.event.category, security_os_core::EventCategory::Api);
        assert!(result.event.title.contains("nginx"));
    }

    #[tokio::test]
    async fn test_json_normalizer_end_to_end() {
        let norm = JsonNormalizer::new();
        let event = raw_event(SourceFormat::Json, serde_json::json!({
            "timestamp": "2024-03-20T09:15:00Z",
            "severity": "critical",
            "type": "authentication",
            "action": "failed",
            "message": "Multiple failed login attempts detected",
            "src_ip": "203.0.113.42",
            "username": "admin",
            "pid": 8888,
            "tags": ["brute-force", "auth"]
        }));
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.severity, security_os_core::Severity::Critical);
        assert_eq!(result.event.src_ip.as_deref(), Some("203.0.113.42"));
        assert_eq!(result.event.category, security_os_core::EventCategory::Authentication);
        assert!(result.event.tags.contains(&"brute-force".to_string()));
    }

    #[test]
    fn test_default_registry_creation() {
        let reg = default_registry();
        assert!(reg.get("sigma").is_some());
        assert!(reg.get("opentelemetry").is_some());
        assert!(reg.get("cef").is_some());
        assert!(reg.get("ecs").is_some());
        assert!(reg.get("syslog").is_some());
        assert!(reg.get("json").is_some());
        assert_eq!(reg.count(), 6);
    }

    #[tokio::test]
    async fn test_pipeline_selects_best_normalizer() {
        let reg = default_registry();
        let pipeline = NormalizerPipeline::new(reg);

        let event = raw_event(SourceFormat::Json, serde_json::json!({
            "timestamp": "2024-01-01T00:00:00Z",
            "severity": "medium",
            "type": "network",
            "src_ip": "10.0.0.1",
            "dst_ip": "10.0.0.2",
            "message": "Connection established"
        }));
        let result = pipeline.normalize(&event).await.unwrap();
        assert_eq!(result.source_format, SourceFormat::Json);
    }

    #[tokio::test]
    async fn test_pipeline_unsupported_format() {
        let reg = default_registry();
        let pipeline = NormalizerPipeline::new(reg);
        let event = raw_event(SourceFormat::Syslog, serde_json::json!({"not": "a syslog message"}));
        let result = pipeline.normalize(&event).await;
        assert!(result.is_err());
    }

    #[test]
    fn test_raw_event_creation() {
        let event = raw_event(SourceFormat::Sigma, serde_json::json!({"test": true}));
        assert_eq!(event.source_format, SourceFormat::Sigma);
        assert!(event.metadata.is_empty());
        assert!(event.origin.is_none());
    }

    #[test]
    fn test_source_format_equality() {
        assert_eq!(SourceFormat::Sigma, SourceFormat::Sigma);
        assert_ne!(SourceFormat::Json, SourceFormat::Syslog);
        let mut set = std::collections::HashSet::new();
        set.insert(SourceFormat::Cef);
        set.insert(SourceFormat::Cef);
        assert_eq!(set.len(), 1);
    }
}
