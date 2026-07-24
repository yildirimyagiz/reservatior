use async_trait::async_trait;
use regex::Regex;
use std::collections::HashMap;

use crate::errors::NormalizerError;
use crate::traits::{EventNormalizer, NormalizationResult, RawEvent, SourceFormat};
use security_os_core::*;

pub struct CefNormalizer;

impl CefNormalizer {
    pub fn new() -> Self {
        Self
    }

    fn parse_cef_header(raw: &str) -> Option<(i32, String, String, String, String, String, u8, String)> {
        let caps = Regex::new(r"^CEF:(\d+)\|([^|]*)\|([^|]*)\|([^|]*)\|([^|]*)\|([^|]*)\|(\d+)\|(.*)$")
            .ok()?
            .captures(raw)?;

        let version: i32 = caps.get(1)?.as_str().parse().ok()?;
        let device_vendor = caps.get(2)?.as_str().to_string();
        let device_product = caps.get(3)?.as_str().to_string();
        let device_version = caps.get(4)?.as_str().to_string();
        let signature_id = caps.get(5)?.as_str().to_string();
        let name = caps.get(6)?.as_str().to_string();
        let severity: u8 = caps.get(7)?.as_str().parse().ok()?;
        let extension = caps.get(8)?.as_str().to_string();

        Some((
            version,
            device_vendor,
            device_product,
            device_version,
            signature_id,
            name,
            severity,
            extension,
        ))
    }

    fn parse_extension(ext_str: &str) -> HashMap<String, String> {
        let mut map = HashMap::new();
        let mut current_key = String::new();
        let mut current_val = String::new();
        let mut in_escape = false;

        for ch in ext_str.chars() {
            if in_escape {
                current_val.push(ch);
                in_escape = false;
                continue;
            }
            if ch == '\\' {
                in_escape = true;
                continue;
            }
            if ch == '=' && current_key.is_empty() {
                current_key = current_val.trim().to_string();
                current_val.clear();
                continue;
            }
            if ch == ' ' && !current_key.is_empty() && !current_val.ends_with('\\') {
                let key = current_key.clone();
                let val = current_val.trim().to_string();
                if !key.is_empty() {
                    map.insert(key, val);
                }
                current_key.clear();
                current_val.clear();
                continue;
            }
            current_val.push(ch);
        }
        if !current_key.is_empty() {
            map.insert(current_key, current_val.trim().to_string());
        }
        map
    }

    fn cef_severity_to_core(sev: u8) -> Severity {
        match sev {
            0..=2 => Severity::Low,
            3..=5 => Severity::Medium,
            6..=8 => Severity::High,
            9..=10 => Severity::Critical,
            _ => Severity::Medium,
        }
    }

    fn map_name_to_category(name: &str, vendor: &str, product: &str) -> EventCategory {
        let combined = format!("{} {} {}", name, vendor, product).to_lowercase();
        if combined.contains("process") || combined.contains("exec") || combined.contains("cmd") {
            EventCategory::Process
        } else if combined.contains("network") || combined.contains("firewall") || combined.contains("connection") {
            EventCategory::Network
        } else if combined.contains("file") || combined.contains("malware") {
            EventCategory::Filesystem
        } else if combined.contains("auth") || combined.contains("login") || combined.contains("logon") {
            EventCategory::Authentication
        } else if combined.contains("dns") {
            EventCategory::Dns
        } else if combined.contains("container") || combined.contains("docker") {
            EventCategory::Container
        } else if combined.contains("web") || combined.contains("http") || combined.contains("api") {
            EventCategory::Api
        } else {
            EventCategory::System
        }
    }

    fn infer_action(name: &str) -> EventAction {
        let lower = name.to_lowercase();
        if lower.contains("create") || lower.contains("spawn") {
            EventAction::Created
        } else if lower.contains("delete") || lower.contains("remove") {
            EventAction::Deleted
        } else if lower.contains("modify") || lower.contains("change") {
            EventAction::Modified
        } else if lower.contains("connect") || lower.contains("connection") {
            EventAction::Connected
        } else if lower.contains("disconnect") {
            EventAction::Disconnected
        } else if lower.contains("fail") {
            EventAction::Failed
        } else if lower.contains("block") || lower.contains("deny") {
            EventAction::Blocked
        } else if lower.contains("allow") || lower.contains("accept") {
            EventAction::Allowed
        } else if lower.contains("exec") || lower.contains("run") {
            EventAction::Executed
        } else {
            EventAction::Detected
        }
    }
}

impl Default for CefNormalizer {
    fn default() -> Self {
        Self::new()
    }
}

#[async_trait]
impl EventNormalizer for CefNormalizer {
    fn format(&self) -> SourceFormat {
        SourceFormat::Cef
    }

    fn name(&self) -> &str {
        "cef"
    }

    fn can_handle(&self, event: &RawEvent) -> bool {
        if event.source_format == SourceFormat::Cef {
            return true;
        }
        if let Some(s) = event.payload.get("raw").and_then(|v| v.as_str()) {
            return s.starts_with("CEF:");
        }
        if let Some(s) = event.payload.as_str() {
            return s.starts_with("CEF:");
        }
        false
    }

    async fn normalize(&self, event: &RawEvent) -> std::result::Result<NormalizationResult, NormalizerError> {
        let raw = if let Some(s) = event.payload.get("raw").and_then(|v| v.as_str()) {
            s.to_string()
        } else if let Some(s) = event.payload.as_str() {
            s.to_string()
        } else {
            return Err(NormalizerError::Parse("No CEF string found in payload".into()));
        };

        let warnings = Vec::new();
        let mut unmapped = Vec::new();

        let (version, device_vendor, device_product, device_version, signature_id, name, severity_num, extension_str) =
            Self::parse_cef_header(&raw).ok_or_else(|| NormalizerError::Parse("Failed to parse CEF header".into()))?;

        let ext = Self::parse_extension(&extension_str);

        let severity = Self::cef_severity_to_core(severity_num);
        let category = Self::map_name_to_category(&name, &device_vendor, &device_product);
        let action = Self::infer_action(&name);

        let src_ip = ext.get("src").or_else(|| ext.get("src_ip")).cloned();
        let dst_ip = ext.get("dst").or_else(|| ext.get("dst_ip")).cloned();
        let src_port = ext.get("spt").or_else(|| ext.get("src_port"))
            .and_then(|s| s.parse::<u16>().ok());
        let dst_port = ext.get("dpt").or_else(|| ext.get("dst_port"))
            .and_then(|s| s.parse::<u16>().ok());
        let protocol = ext.get("proto").or_else(|| ext.get("protocol")).cloned();
        let process_name = ext.get("app").or_else(|| ext.get("process")).cloned();
        let process_id = ext.get("dst_processId").or_else(|| ext.get("cs1"))
            .and_then(|s| s.parse::<u32>().ok());
        let file_path = ext.get("filePath").or_else(|| ext.get("fname")).cloned();
        let file_hash = ext.get("fileHash").or_else(|| ext.get("cs2")).cloned();
        let username = ext.get("duser").or_else(|| ext.get("suser")).cloned();

        let description_text = ext.get("msg")
            .or_else(|| ext.get("cs3"))
            .cloned()
            .unwrap_or_else(|| format!("CEF event from {} {} v{}", device_vendor, device_product, device_version));

        let title = format!("[CEF] {} - {} {}", device_vendor, device_product, name);

        let mut metadata = HashMap::new();
        metadata.insert("cef.version".into(), serde_json::json!(version));
        metadata.insert("cef.device_vendor".into(), serde_json::json!(device_vendor));
        metadata.insert("cef.device_product".into(), serde_json::json!(device_product));
        metadata.insert("cef.device_version".into(), serde_json::json!(device_version));
        metadata.insert("cef.signature_id".into(), serde_json::json!(signature_id));
        metadata.insert("cef.severity_raw".into(), serde_json::json!(severity_num));

        for k in ext.keys() {
            if !["src", "dst", "spt", "dpt", "proto", "app", "fname", "duser", "suser", "msg"]
                .contains(&k.as_str())
            {
                unmapped.push(k.clone());
            }
        }

        let source = EventSource {
            collector: "cef-normalizer".into(),
            host_id: device_vendor.clone(),
            host_name: format!("{}-{}", device_vendor, device_product),
            agent_id: signature_id.clone(),
            agent_version: Some(device_version.clone()),
            process_name,
            process_id,
            user_id: None,
            user_name: username,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            service_name: Some(device_product),
        };

        let mut security_event = SecurityEvent::new(category, action, source, title, description_text)
            .with_severity(severity);

        security_event.src_ip = src_ip;
        security_event.dst_ip = dst_ip;
        security_event.src_port = src_port;
        security_event.dst_port = dst_port;
        security_event.protocol = protocol;
        security_event.file_path = file_path;
        security_event.file_hash_sha256 = file_hash;

        for (k, v) in metadata {
            security_event.metadata.insert(k, v);
        }

        security_event.rule_id = Some(signature_id);

        let confidence = if version >= 0 && !name.is_empty() {
            0.8
        } else {
            0.5
        };

        Ok(NormalizationResult {
            event: security_event,
            source_format: SourceFormat::Cef,
            confidence,
            warnings,
            unmapped_fields: unmapped,
        })
    }

    fn confidence(&self, event: &RawEvent) -> f64 {
        let raw = event.payload.get("raw").and_then(|v| v.as_str())
            .or_else(|| event.payload.as_str())
            .unwrap_or("");
        if raw.starts_with("CEF:") && raw.matches('|').count() >= 7 {
            0.85
        } else if raw.starts_with("CEF:") {
            0.6
        } else {
            0.3
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;
    use std::collections::HashMap;

    const SAMPLE_CEF: &str = "CEF:0|Acme|Firewall|1.0|NET-001|Connection Allowed|3|src=10.0.0.1 dst=192.168.1.1 spt=443 dpt=80 proto=tcp msg=Outbound connection";

    fn make_cef_event(raw: &str) -> RawEvent {
        RawEvent {
            source_format: SourceFormat::Cef,
            payload: serde_json::json!({"raw": raw}),
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        }
    }

    #[tokio::test]
    async fn test_normalize_cef_basic() {
        let norm = CefNormalizer::new();
        let event = make_cef_event(SAMPLE_CEF);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.source_format, SourceFormat::Cef);
        assert_eq!(result.event.severity, Severity::Medium);
        assert_eq!(result.event.src_ip.as_deref(), Some("10.0.0.1"));
        assert_eq!(result.event.dst_ip.as_deref(), Some("192.168.1.1"));
        assert_eq!(result.event.src_port, Some(443));
        assert_eq!(result.event.dst_port, Some(80));
        assert!(result.event.title.contains("Firewall"));
    }

    #[tokio::test]
    async fn test_normalize_cef_high_severity() {
        let norm = CefNormalizer::new();
        let cef = "CEF:0|Vendor|Product|2.0|SIG-001|Malware Detected|9|src=192.168.1.100 dst=10.0.0.5 spt=12345 dpt=8080 proto=tcp msg=Malware hash match";
        let event = make_cef_event(cef);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.severity, Severity::Critical);
        assert!(result.event.title.contains("Malware"));
    }

    #[tokio::test]
    async fn test_cef_parse_extension() {
        let ext = CefNormalizer::parse_extension("src=10.0.0.1 dst=192.168.1.1 spt=443 msg=Hello\\ World");
        assert_eq!(ext.get("src").unwrap(), "10.0.0.1");
        assert_eq!(ext.get("dst").unwrap(), "192.168.1.1");
        assert_eq!(ext.get("spt").unwrap(), "443");
        assert_eq!(ext.get("msg").unwrap(), "Hello World");
    }

    #[test]
    fn test_cef_severity_mapping() {
        assert_eq!(CefNormalizer::cef_severity_to_core(1), Severity::Low);
        assert_eq!(CefNormalizer::cef_severity_to_core(4), Severity::Medium);
        assert_eq!(CefNormalizer::cef_severity_to_core(7), Severity::High);
        assert_eq!(CefNormalizer::cef_severity_to_core(10), Severity::Critical);
    }

    #[test]
    fn test_cef_category_inference() {
        assert_eq!(CefNormalizer::map_name_to_category("Process Created", "MS", "Windows",), EventCategory::Process);
        assert_eq!(CefNormalizer::map_name_to_category("Connection Blocked", "PaloAlto", "Firewall",), EventCategory::Network);
        assert_eq!(CefNormalizer::map_name_to_category("User Login", "Okta", "SSO",), EventCategory::Authentication);
    }

    #[test]
    fn test_cef_confidence() {
        let norm = CefNormalizer::new();
        let valid = RawEvent {
            source_format: SourceFormat::Cef,
            payload: serde_json::json!({"raw": SAMPLE_CEF}),
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        };
        assert!(norm.confidence(&valid) >= 0.8);

        let invalid = RawEvent {
            source_format: SourceFormat::Cef,
            payload: serde_json::json!({"raw": "not cef"}),
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        };
        assert!(norm.confidence(&invalid) < 0.4);
    }
}
