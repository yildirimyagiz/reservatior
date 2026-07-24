use async_trait::async_trait;
use std::collections::HashMap;

use crate::errors::NormalizerError;
use crate::traits::{EventNormalizer, NormalizationResult, RawEvent, SourceFormat};
use security_os_core::*;

pub struct SigmaNormalizer;

impl SigmaNormalizer {
    pub fn new() -> Self {
        Self
    }

    fn map_logsource_category(category: &str) -> EventCategory {
        match category.to_lowercase().as_str() {
            "process_creation" | "create_process" => EventCategory::Process,
            "network_connection" | "firewall" => EventCategory::Network,
            "file_event" | "file_rename" | "file_delete" => EventCategory::Filesystem,
            "webserver" | "web_application" => EventCategory::Api,
            "authentication" | "logon" => EventCategory::Authentication,
            "dns" => EventCategory::Dns,
            "tls" | "ssl" => EventCategory::Tls,
            "powershell" | "ps_script" => EventCategory::Process,
            "wmi" => EventCategory::Process,
            "scheduled_task" => EventCategory::Cron,
            "registry" => EventCategory::ConfigurationDrift,
            "psmodule" => EventCategory::Process,
            "intrusion_detection" | "ids" => EventCategory::Network,
            _ => EventCategory::System,
        }
    }

    fn parse_severity(severity: &str) -> Severity {
        match severity.to_lowercase().as_str() {
            "critical" | "1" => Severity::Critical,
            "high" | "2" => Severity::High,
            "medium" | "3" => Severity::Medium,
            "low" | "4" => Severity::Low,
            _ => Severity::Informational,
        }
    }

    fn extract_mitre(tags: &[serde_json::Value]) -> (Option<String>, Option<String>, Option<String>) {
        let mut tactic = None;
        let mut technique = None;
        let mut id = None;

        for tag in tags {
            if let Some(s) = tag.as_str() {
                let lower = s.to_lowercase();
                if lower.starts_with("attack.t") {
                    id = Some(s.split('.').last().unwrap_or(s).to_string());
                } else if lower.starts_with("attack.") && !lower.starts_with("attack.t") {
                    tactic = Some(s.trim_start_matches("attack.").to_string());
                } else if lower.contains("technique") {
                    technique = Some(s.to_string());
                }
            }
        }

        (tactic, technique, id)
    }

    fn map_action_from_title(title: &str) -> EventAction {
        let lower = title.to_lowercase();
        if lower.contains("failed") || lower.contains("failure") {
            EventAction::Failed
        } else if lower.contains("create") || lower.contains("spawn") {
            EventAction::Created
        } else if lower.contains("delete") || lower.contains("removal") {
            EventAction::Deleted
        } else if lower.contains("modify") || lower.contains("change") {
            EventAction::Modified
        } else if lower.contains("connect") || lower.contains("connection") {
            EventAction::Connected
        } else if lower.contains("execute") || lower.contains("run") {
            EventAction::Executed
        } else if lower.contains("block") {
            EventAction::Blocked
        } else {
            EventAction::Detected
        }
    }
}

impl Default for SigmaNormalizer {
    fn default() -> Self {
        Self::new()
    }
}

#[async_trait]
impl EventNormalizer for SigmaNormalizer {
    fn format(&self) -> SourceFormat {
        SourceFormat::Sigma
    }

    fn name(&self) -> &str {
        "sigma"
    }

    fn can_handle(&self, event: &RawEvent) -> bool {
        event.source_format == SourceFormat::Sigma
            && (event.payload.get("title").is_some() || event.payload.get("logsource").is_some())
    }

    async fn normalize(&self, event: &RawEvent) -> std::result::Result<NormalizationResult, NormalizerError> {
        let payload = &event.payload;
        let mut warnings = Vec::new();
        let mut unmapped = Vec::new();

        let title = payload
            .get("title")
            .and_then(|v| v.as_str())
            .unwrap_or("Sigma Rule Match");
        let description = payload
            .get("description")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let severity = payload
            .get("level")
            .and_then(|v| v.as_str())
            .map(Self::parse_severity)
            .unwrap_or(Severity::Medium);

        let (category, action) = if let Some(logsource) = payload.get("logsource") {
            let cat = logsource
                .get("category")
                .and_then(|v| v.as_str())
                .map(Self::map_logsource_category)
                .unwrap_or(EventCategory::System);
            let act = Self::map_action_from_title(title);
            (cat, act)
        } else {
            warnings.push("No logsource field found".into());
            (EventCategory::System, EventAction::Detected)
        };

        let (mitre_tactic, mitre_technique, mitre_id) = payload
            .get("tags")
            .and_then(|v| v.as_array())
            .map(|tags| Self::extract_mitre(tags))
            .unwrap_or((None, None, None));

        let rule_id = payload
            .get("id")
            .and_then(|v| v.as_str())
            .map(|s| s.to_string())
            .or_else(|| {
                payload
                    .get("ruleid")
                    .and_then(|v| v.as_str())
                    .map(|s| s.to_string())
            });

        let rule_name = Some(title.to_string());

        let mut metadata = HashMap::new();
        if let Some(logo) = payload.get("author") {
            if let Some(s) = logo.as_str() {
                metadata.insert("sigma.author".into(), serde_json::Value::String(s.into()));
            }
        }
        if let Some(logsource) = payload.get("logsource") {
            if let Some(product) = logsource.get("product").and_then(|v| v.as_str()) {
                metadata.insert("sigma.product".into(), serde_json::Value::String(product.into()));
            }
            if let Some(service) = logsource.get("service").and_then(|v| v.as_str()) {
                metadata.insert("sigma.service".into(), serde_json::Value::String(service.into()));
            }
        }
        if let Some(detection) = payload.get("detection") {
            if let Some(cond) = detection.get("condition").and_then(|v| v.as_str()) {
                metadata.insert("sigma.detection.condition".into(), serde_json::Value::String(cond.into()));
            }
        }

        if payload.get("falsepositives").is_none() {
            unmapped.push("falsepositives".into());
        }

        let tags_vec: Vec<String> = payload
            .get("tags")
            .and_then(|v| v.as_array())
            .map(|arr| {
                arr.iter()
                    .filter_map(|v| v.as_str().map(String::from))
                    .collect()
            })
            .unwrap_or_default();

        let source = EventSource {
            collector: "sigma-normalizer".into(),
            host_id: event
                .origin
                .clone()
                .unwrap_or_else(|| "unknown".into()),
            host_name: "sigma-source".into(),
            agent_id: "sigma-agent".into(),
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

        let mut security_event = SecurityEvent::new(category, action, source, title, description)
            .with_severity(severity);

        if let Some(id) = mitre_id {
            security_event.mitre_id = Some(id);
        }
        if let Some(tactic) = mitre_tactic {
            security_event.mitre_tactic = Some(tactic);
        }
        if let Some(technique) = mitre_technique {
            security_event.mitre_technique = Some(technique);
        }

        for (k, v) in metadata {
            security_event.metadata.insert(k, v);
        }

        security_event.tags = tags_vec;
        security_event.rule_id = rule_id;
        security_event.rule_name = rule_name;

        let confidence = if payload.get("logsource").is_some() && payload.get("detection").is_some()
        {
            0.85
        } else {
            0.6
        };

        Ok(NormalizationResult {
            event: security_event,
            source_format: SourceFormat::Sigma,
            confidence,
            warnings,
            unmapped_fields: unmapped,
        })
    }

    fn confidence(&self, event: &RawEvent) -> f64 {
        let mut score: f64 = 0.5;
        if event.payload.get("title").is_some() {
            score += 0.1;
        }
        if event.payload.get("logsource").is_some() {
            score += 0.15;
        }
        if event.payload.get("detection").is_some() {
            score += 0.1;
        }
        if event.payload.get("tags").is_some() {
            score += 0.05;
        }
        if event.payload.get("level").is_some() {
            score += 0.05;
        }
        score.min(0.95)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;
    use std::collections::HashMap;

    fn make_sigma_event(payload: serde_json::Value) -> RawEvent {
        RawEvent {
            source_format: SourceFormat::Sigma,
            payload,
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        }
    }

    #[tokio::test]
    async fn test_normalize_sigma_basic() {
        let norm = SigmaNormalizer::new();
        let payload = serde_json::json!({
            "title": "Suspicious Process Created",
            "description": "Detects suspicious process creation",
            "level": "high",
            "logsource": {
                "category": "process_creation",
                "product": "windows"
            },
            "detection": {
                "condition": "selection",
                "selection": {"CommandLine|contains": "mimikatz"}
            },
            "tags": ["attack.t1003", "attack.credential_access"]
        });
        let event = make_sigma_event(payload);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.source_format, SourceFormat::Sigma);
        assert_eq!(result.event.severity, Severity::High);
        assert_eq!(result.event.category, EventCategory::Process);
        assert!(result.event.title.contains("Suspicious"));
    }

    #[tokio::test]
    async fn test_normalize_sigma_no_logsource() {
        let norm = SigmaNormalizer::new();
        let payload = serde_json::json!({
            "title": "Generic Alert",
            "level": "critical"
        });
        let event = make_sigma_event(payload);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.severity, Severity::Critical);
        assert!(!result.warnings.is_empty());
    }

    #[tokio::test]
    async fn test_sigma_confidence() {
        let norm = SigmaNormalizer::new();
        let full = make_sigma_event(serde_json::json!({
            "title": "Test",
            "logsource": {"category": "process_creation", "product": "linux"},
            "detection": {"condition": "sel"},
            "level": "high",
            "tags": ["attack.t1059"]
        }));
        let high = norm.confidence(&full);
        assert!(high >= 0.9, "Expected >=0.9, got {}", high);

        let minimal = make_sigma_event(serde_json::json!({"title": "X"}));
        let low = norm.confidence(&minimal);
        assert!(low < 0.7, "Expected <0.7, got {}", low);
    }

    #[test]
    fn test_logsource_category_mapping() {
        assert_eq!(SigmaNormalizer::map_logsource_category("process_creation"), EventCategory::Process);
        assert_eq!(SigmaNormalizer::map_logsource_category("network_connection"), EventCategory::Network);
        assert_eq!(SigmaNormalizer::map_logsource_category("file_event"), EventCategory::Filesystem);
        assert_eq!(SigmaNormalizer::map_logsource_category("authentication"), EventCategory::Authentication);
        assert_eq!(SigmaNormalizer::map_logsource_category("unknown_stuff"), EventCategory::System);
    }

    #[test]
    fn test_severity_parsing() {
        assert_eq!(SigmaNormalizer::parse_severity("critical"), Severity::Critical);
        assert_eq!(SigmaNormalizer::parse_severity("high"), Severity::High);
        assert_eq!(SigmaNormalizer::parse_severity("medium"), Severity::Medium);
        assert_eq!(SigmaNormalizer::parse_severity("low"), Severity::Low);
        assert_eq!(SigmaNormalizer::parse_severity("unknown"), Severity::Informational);
    }

    #[test]
    fn test_action_from_title() {
        assert_eq!(SigmaNormalizer::map_action_from_title("Process Created"), EventAction::Created);
        assert_eq!(SigmaNormalizer::map_action_from_title("File Deleted"), EventAction::Deleted);
        assert_eq!(SigmaNormalizer::map_action_from_title("Connection Failed"), EventAction::Failed);
        assert_eq!(SigmaNormalizer::map_action_from_title("Something Detected"), EventAction::Detected);
    }
}
