use async_trait::async_trait;
use std::collections::HashMap;

use crate::errors::NormalizerError;
use crate::traits::{EventNormalizer, NormalizationResult, RawEvent, SourceFormat};
use security_os_core::*;

pub struct OtelNormalizer;

impl OtelNormalizer {
    pub fn new() -> Self {
        Self
    }

    fn map_otel_span_status(status_code: &str) -> Severity {
        match status_code.to_uppercase().as_str() {
            "STATUS_CODE_ERROR" | "ERROR" => Severity::High,
            "STATUS_CODE_UNSET" | "UNSET" => Severity::Low,
            "STATUS_CODE_OK" | "OK" => Severity::Informational,
            _ => Severity::Medium,
        }
    }

    fn map_otel_severity_number(sev_num: i64) -> Severity {
        match sev_num {
            1..=4 => Severity::Low,
            5..=8 => Severity::Medium,
            9..=12 => Severity::High,
            13..=24 => Severity::Critical,
            _ => Severity::Informational,
        }
    }

    fn map_scope_to_category(scope_name: &str) -> EventCategory {
        match scope_name.to_lowercase().as_str() {
            s if s.contains("process") => EventCategory::Process,
            s if s.contains("network") => EventCategory::Network,
            s if s.contains("file") || s.contains("filesystem") => EventCategory::Filesystem,
            s if s.contains("container") || s.contains("docker") => EventCategory::Container,
            s if s.contains("auth") || s.contains("security") => EventCategory::Authentication,
            s if s.contains("http") || s.contains("api") => EventCategory::Api,
            s if s.contains("dns") => EventCategory::Dns,
            s if s.contains("system") => EventCategory::System,
            s if s.contains("k8s") || s.contains("kubernetes") => EventCategory::Kubernetes,
            _ => EventCategory::System,
        }
    }

    fn extract_resource_attr(resource: &serde_json::Value, key: &str) -> Option<String> {
        resource
            .get("attributes")
            .and_then(|attrs| attrs.get(key))
            .and_then(|v| v.as_str().or_else(|| v.as_i64().map(|_| "")))
            .map(|s| s.to_string())
    }

    fn extract_from_attrs(attrs: &serde_json::Value, key: &str) -> Option<String> {
        attrs.get(key).and_then(|v| v.as_str().map(String::from))
    }
}

impl Default for OtelNormalizer {
    fn default() -> Self {
        Self::new()
    }
}

#[async_trait]
impl EventNormalizer for OtelNormalizer {
    fn format(&self) -> SourceFormat {
        SourceFormat::OpenTelemetry
    }

    fn name(&self) -> &str {
        "opentelemetry"
    }

    fn can_handle(&self, event: &RawEvent) -> bool {
        event.source_format == SourceFormat::OpenTelemetry
            && (event.payload.get("resourceSpans").is_some()
                || event.payload.get("resourceLogs").is_some()
                || event.payload.get("resourceMetrics").is_some()
                || event.payload.get("scopeSpans").is_some()
                || event.payload.get("scopeLogs").is_some())
    }

    async fn normalize(&self, event: &RawEvent) -> std::result::Result<NormalizationResult, NormalizerError> {
        let payload = &event.payload;
        let mut warnings = Vec::new();
        let unmapped = Vec::new();

        let (resource, scope, span_or_log) = if let Some(resource_spans) = payload.get("resourceSpans").and_then(|v| v.as_array()).and_then(|a| a.first()) {
            let res = resource_spans.get("resource").cloned().unwrap_or(serde_json::json!({}));
            let scope_span = resource_spans.get("scopeSpans")
                .and_then(|v| v.as_array())
                .and_then(|arr| arr.first())
                .cloned()
                .unwrap_or(serde_json::json!({}));
            let span = scope_span.get("spans")
                .and_then(|v| v.as_array())
                .and_then(|arr| arr.first())
                .cloned()
                .unwrap_or(serde_json::json!({}));
            (res, scope_span.get("scope").cloned().unwrap_or(serde_json::json!({})), span)
        } else if let Some(resource_logs) = payload.get("resourceLogs").and_then(|v| v.as_array()).and_then(|a| a.first()) {
            let res = resource_logs.get("resource").cloned().unwrap_or(serde_json::json!({}));
            let scope_log = resource_logs.get("scopeLogs")
                .and_then(|v| v.as_array())
                .and_then(|arr| arr.first())
                .cloned()
                .unwrap_or(serde_json::json!({}));
            let log = scope_log.get("logRecords")
                .and_then(|v| v.as_array())
                .and_then(|arr| arr.first())
                .cloned()
                .unwrap_or(serde_json::json!({}));
            (res, scope_log.get("scope").cloned().unwrap_or(serde_json::json!({})), log)
        } else if let Some(scope_spans) = payload.get("scopeSpans").and_then(|v| v.as_array()).and_then(|a| a.first()) {
            let scope = scope_spans.get("scope").cloned().unwrap_or(serde_json::json!({}));
            let span = scope_spans.get("spans")
                .and_then(|v| v.as_array())
                .and_then(|arr| arr.first())
                .cloned()
                .unwrap_or(serde_json::json!({}));
            (serde_json::json!({}), scope, span)
        } else if let Some(scope_logs) = payload.get("scopeLogs").and_then(|v| v.as_array()).and_then(|a| a.first()) {
            let scope = scope_logs.get("scope").cloned().unwrap_or(serde_json::json!({}));
            let log = scope_logs.get("logRecords")
                .and_then(|v| v.as_array())
                .and_then(|arr| arr.first())
                .cloned()
                .unwrap_or(serde_json::json!({}));
            (serde_json::json!({}), scope, log)
        } else {
            warnings.push("No recognizable OTEL structure found".into());
            (serde_json::json!({}), serde_json::json!({}), serde_json::json!({}))
        };

        let scope_name = scope.get("name").and_then(|v| v.as_str()).unwrap_or("unknown");
        let category = Self::map_scope_to_category(scope_name);

        let service_name = Self::extract_resource_attr(&resource, "service.name")
            .unwrap_or_else(|| "unknown".into());
        let host_name = Self::extract_resource_attr(&resource, "host.name")
            .or_else(|| Self::extract_resource_attr(&resource, "host.hostname"))
            .unwrap_or_else(|| "unknown".into());
        let service_version = Self::extract_resource_attr(&resource, "service.version");

        let is_log_record = payload.get("resourceLogs").is_some() || payload.get("scopeLogs").is_some();

        let (title, description, severity) = if is_log_record {
            let body = span_or_log.get("body")
                .and_then(|v| v.as_str())
                .unwrap_or("OTEL Log Record");
            let _sev_text = span_or_log.get("severityText")
                .and_then(|v| v.as_str())
                .unwrap_or("INFO");
            let sev_num = span_or_log.get("severityNumber")
                .and_then(|v| v.as_i64())
                .unwrap_or(9);
            let severity = Self::map_otel_severity_number(sev_num);
            let title = format!("OTEL Log: {}", &body[..body.len().min(80)]);
            (title, body.to_string(), severity)
        } else {
            let name = span_or_log.get("name").and_then(|v| v.as_str()).unwrap_or("unknown-span");
            let status_code = span_or_log.get("status")
                .and_then(|s| s.get("code"))
                .and_then(|v| v.as_str())
                .unwrap_or("STATUS_CODE_UNSET");
            let severity = Self::map_otel_span_status(status_code);
            let status_msg = span_or_log.get("status")
                .and_then(|s| s.get("message"))
                .and_then(|v| v.as_str())
                .unwrap_or("");
            let title = format!("OTEL Span: {}", name);
            let description = if status_msg.is_empty() {
                format!("Span '{}' completed with status {}", name, status_code)
            } else {
                status_msg.to_string()
            };
            (title, description, severity)
        };

        let mut metadata = HashMap::new();
        if let Some(attrs) = resource.get("attributes") {
            if let Some(obj) = attrs.as_object() {
                for (k, v) in obj {
                    if k.contains("service.") || k.contains("host.") {
                        metadata.insert(format!("otel.resource.{}", k), v.clone());
                    }
                }
            }
        }
        if let Some(scope_attrs) = scope.get("attributes") {
            if let Some(obj) = scope_attrs.as_object() {
                for (k, v) in obj {
                    metadata.insert(format!("otel.scope.{}", k), v.clone());
                }
            }
        }

        let trace_id = span_or_log.get("traceId").and_then(|v| v.as_str());
        let span_id = span_or_log.get("spanId").and_then(|v| v.as_str());

        let mut src_ip = None;
        let mut dst_ip = None;
        if let Some(attrs) = span_or_log.get("attributes") {
            if let Some(ip) = Self::extract_from_attrs(attrs, "net.peer.ip")
                .or_else(|| Self::extract_from_attrs(attrs, "net.peer.ip")) {
                src_ip = Some(ip);
            }
            if let Some(ip) = Self::extract_from_attrs(attrs, "net.host.ip") {
                dst_ip = Some(ip);
            }
        }

        let agent_version = service_version.or_else(|| {
            Self::extract_resource_attr(&resource, "telemetry.sdk.version")
        });

        let source = EventSource {
            collector: "otel-normalizer".into(),
            host_id: host_name.clone(),
            host_name,
            agent_id: service_name.clone(),
            agent_version,
            process_name: Self::extract_resource_attr(&resource, "process.executable.name"),
            process_id: Self::extract_resource_attr(&resource, "process.pid")
                .and_then(|s| s.parse::<u32>().ok()),
            user_id: Self::extract_resource_attr(&resource, "user.id"),
            user_name: Self::extract_resource_attr(&resource, "user.name"),
            container_id: Self::extract_resource_attr(&resource, "container.id"),
            container_name: Self::extract_resource_attr(&resource, "container.name"),
            pod_name: Self::extract_resource_attr(&resource, "k8s.pod.name"),
            namespace: Self::extract_resource_attr(&resource, "k8s.namespace.name"),
            service_name: Some(service_name),
        };

        let action = if is_log_record {
            EventAction::Detected
        } else {
            EventAction::Started
        };

        let mut security_event = SecurityEvent::new(category, action, source, &title, description)
            .with_severity(severity);

        if let Some(tid) = trace_id {
            security_event.metadata.insert("otel.trace_id".into(), serde_json::Value::String(tid.into()));
        }
        if let Some(sid) = span_id {
            security_event.metadata.insert("otel.span_id".into(), serde_json::Value::String(sid.into()));
        }
        security_event.metadata.insert("otel.scope".into(), serde_json::Value::String(scope_name.into()));

        for (k, v) in metadata {
            security_event.metadata.insert(k, v);
        }

        if src_ip.is_some() {
            security_event.src_ip = src_ip;
        }
        if dst_ip.is_some() {
            security_event.dst_ip = dst_ip;
        }

        let confidence = if payload.get("resourceSpans").is_some() || payload.get("resourceLogs").is_some() {
            0.85
        } else {
            0.65
        };

        Ok(NormalizationResult {
            event: security_event,
            source_format: SourceFormat::OpenTelemetry,
            confidence,
            warnings,
            unmapped_fields: unmapped,
        })
    }

    fn confidence(&self, event: &RawEvent) -> f64 {
        let mut score: f64 = 0.4;
        if event.payload.get("resourceSpans").is_some() || event.payload.get("resourceLogs").is_some() {
            score += 0.2;
        }
        if event.payload.get("scopeSpans").is_some() || event.payload.get("scopeLogs").is_some() {
            score += 0.1;
        }
        let payload_str = event.payload.to_string();
        if payload_str.contains("traceId") || payload_str.contains("spanId") {
            score += 0.1;
        }
        if payload_str.contains("severityNumber") || payload_str.contains("severityText") {
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

    fn make_otel_event(payload: serde_json::Value) -> RawEvent {
        RawEvent {
            source_format: SourceFormat::OpenTelemetry,
            payload,
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        }
    }

    #[tokio::test]
    async fn test_normalize_otel_span() {
        let norm = OtelNormalizer::new();
        let payload = serde_json::json!({
            "resourceSpans": [{
                "resource": {
                    "attributes": {
                        "service.name": "auth-service",
                        "host.name": "node-1"
                    }
                },
                "scopeSpans": [{
                    "scope": {"name": "http-server"},
                    "spans": [{
                        "name": "GET /api/login",
                        "traceId": "abc123",
                        "spanId": "def456",
                        "status": {"code": "STATUS_CODE_ERROR", "message": "401 Unauthorized"}
                    }]
                }]
            }]
        });
        let event = make_otel_event(payload);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.source_format, SourceFormat::OpenTelemetry);
        assert_eq!(result.event.severity, Severity::High);
        assert!(result.event.title.contains("GET /api/login"));
    }

    #[tokio::test]
    async fn test_normalize_otel_log() {
        let norm = OtelNormalizer::new();
        let payload = serde_json::json!({
            "resourceLogs": [{
                "resource": {
                    "attributes": {
                        "service.name": "worker"
                    }
                },
                "scopeLogs": [{
                    "scope": {"name": "logging"},
                    "logRecords": [{
                        "body": "Disk space critical",
                        "severityNumber": 14,
                        "severityText": "FATAL"
                    }]
                }]
            }]
        });
        let event = make_otel_event(payload);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.severity, Severity::Critical);
        assert!(result.event.title.contains("Disk space"));
    }

    #[tokio::test]
    async fn test_otel_can_handle() {
        let norm = OtelNormalizer::new();
        let otel_event = make_otel_event(serde_json::json!({"scopeSpans": []}));
        assert!(norm.can_handle(&otel_event));
        let json_event = RawEvent {
            source_format: SourceFormat::Json,
            payload: serde_json::json!({}),
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        };
        assert!(!norm.can_handle(&json_event));
    }

    #[test]
    fn test_severity_mapping() {
        assert_eq!(OtelNormalizer::map_otel_span_status("STATUS_CODE_ERROR"), Severity::High);
        assert_eq!(OtelNormalizer::map_otel_span_status("STATUS_CODE_OK"), Severity::Informational);
        assert_eq!(OtelNormalizer::map_otel_severity_number(10), Severity::High);
        assert_eq!(OtelNormalizer::map_otel_severity_number(20), Severity::Critical);
    }

    #[test]
    fn test_scope_category_mapping() {
        assert_eq!(OtelNormalizer::map_scope_to_category("process-metrics"), EventCategory::Process);
        assert_eq!(OtelNormalizer::map_scope_to_category("http-server"), EventCategory::Api);
        assert_eq!(OtelNormalizer::map_scope_to_category("container-runtime"), EventCategory::Container);
        assert_eq!(OtelNormalizer::map_scope_to_category("something-unknown"), EventCategory::System);
    }
}
