use dashmap::DashMap;
use regex::Regex;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::debug;

struct SecretPattern {
    name: &'static str,
    regex: Regex,
    description: &'static str,
}

pub struct SecretsEngine {
    patterns: Vec<SecretPattern>,
    cooldown: DashMap<String, std::time::Instant>,
}

impl SecretsEngine {
    pub fn new() -> Self {
        let patterns = vec![
            SecretPattern {
                name: "aws-access-key",
                regex: Regex::new(r"(?:^|[^A-Za-z0-9/+=])(AKIA[0-9A-Z]{16})(?:[^A-Za-z0-9/+=]|$)")
                    .expect("invalid regex"),
                description: "AWS Access Key ID",
            },
            SecretPattern {
                name: "aws-secret-key",
                regex: Regex::new(
                    r#"(?:aws.?secret.?access.?key|secret.?key)\s*[:=]\s*['"]?([A-Za-z0-9/+=]{40})['"]?"#,
                )
                .expect("invalid regex"),
                description: "AWS Secret Access Key",
            },
            SecretPattern {
                name: "github-token",
                regex: Regex::new(r"(?:ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9_]{36,}")
                    .expect("invalid regex"),
                description: "GitHub Personal Access Token",
            },
            SecretPattern {
                name: "generic-api-key",
                regex: Regex::new(
                    r#"(?:api[_-]?key|apikey|api[_-]?secret)\s*[:=]\s*['"]?([A-Za-z0-9_\-]{20,})['"]?"#,
                )
                .expect("invalid regex"),
                description: "Generic API Key",
            },
            SecretPattern {
                name: "jwt-token",
                regex: Regex::new(r"eyJ[A-Za-z0-9_-]{10,}\.eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_\-]{10,}")
                    .expect("invalid regex"),
                description: "JSON Web Token (JWT)",
            },
            SecretPattern {
                name: "private-key",
                regex: Regex::new(r"-----BEGIN (?:RSA |EC |DSA |OPENSSH )?PRIVATE KEY-----")
                    .expect("invalid regex"),
                description: "Private Key",
            },
            SecretPattern {
                name: "database-url",
                regex: Regex::new(
                    r#"(?:mysql|postgres|postgresql|mongodb|redis|amqp|mssql):\/\/[^:]+:[^@\s]{3,}@[^\s]+"#,
                )
                .expect("invalid regex"),
                description: "Database Connection String with Password",
            },
            SecretPattern {
                name: "generic-secret",
                regex: Regex::new(
                    r#"(?:secret|password|passwd|pwd)\s*[:=]\s*['"]([^'"]{8,})['"]"#,
                )
                .expect("invalid regex"),
                description: "Generic Secret/Password",
            },
        ];

        Self {
            patterns,
            cooldown: DashMap::new(),
        }
    }

    fn scan_text(&self, text: &str) -> Vec<&SecretPattern> {
        let mut found = Vec::new();
        for pattern in &self.patterns {
            if pattern.regex.is_match(text) {
                found.push(pattern);
            }
        }
        found
    }

    fn check_text_for_secrets(
        &self,
        text: &str,
        source: &EventSource,
        affected_entity: Option<&str>,
    ) -> Vec<SecurityEvent> {
        let mut events = Vec::new();

        let matched = self.scan_text(text);
        if matched.is_empty() {
            return events;
        }

        let dedup_key = matched
            .iter()
            .map(|p| p.name)
            .collect::<Vec<_>>()
            .join(",");

        if let Some(last) = self.cooldown.get(&dedup_key) {
            if last.elapsed() < std::time::Duration::from_secs(60) {
                return events;
            }
        }
        self.cooldown
            .insert(dedup_key, std::time::Instant::now());

        for pattern in matched {
            let detection_source = EventSource {
                collector: "secrets-engine".to_string(),
                host_id: source.host_id.clone(),
                host_name: source.host_name.clone(),
                agent_id: "secrets-engine-agent".to_string(),
                process_name: source.process_name.clone(),
                process_id: source.process_id,
                user_id: source.user_id.clone(),
                user_name: source.user_name.clone(),
                container_id: source.container_id.clone(),
                container_name: source.container_name.clone(),
                pod_name: source.pod_name.clone(),
                namespace: source.namespace.clone(),
            
                agent_version: None,
                service_name: None,
            };

            let mut event = SecurityEvent::new(
                EventCategory::Secrets,
                EventAction::Detected,
                detection_source,
                format!("Leaked secret detected: {}", pattern.description),
                format!(
                    "A {} was found in the scanned content. \
                     Secrets in code or logs can be exploited for unauthorized access.",
                    pattern.description,
                ),
            )
            .with_severity(Severity::High)
            .with_confidence(0.85)
            .with_risk_score(85.0)
            .with_mitre(
                "Credential Access",
                "Credentials In Files",
                "T1552.001",
            )
            .with_tag("secret-leak")
            .with_tag(pattern.name)
            .with_metadata("secret_type", serde_json::json!(pattern.name))
            .with_metadata("secret_description", serde_json::json!(pattern.description));

            if let Some(entity_val) = affected_entity {
                event = event.with_entity(Entity {
                    entity_type: EntityType::File,
                    value: entity_val.to_string(),
                    risk_contribution: 40.0,
                
                    metadata: std::collections::HashMap::new(),
                });
            }

            debug!(
                "Secret detected: type={}, source_host={}",
                pattern.name, source.host_name
            );

            events.push(event);
        }

        events
    }

    pub fn process_event(&self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut all_events = Vec::new();

        let metadata_text = event
            .metadata
            .iter()
            .map(|(k, v)| format!("{}: {}", k, v))
            .collect::<Vec<_>>()
            .join("\n");

        let source_info = event
            .metadata
            .get("source_file")
            .or_else(|| event.metadata.get("file_path"))
            .or_else(|| event.metadata.get("config_file"))
            .or_else(|| event.metadata.get("log_path"))
            .and_then(|v| v.as_str());

        let affected = source_info.map(|s| s.to_string());

        let texts = [
            Some(event.title.as_str()),
            Some(event.description.as_str()),
            Some(metadata_text.as_str()),
        ];

        let mut matched_types: Vec<String> = Vec::new();

        for text_opt in texts {
            if let Some(text) = text_opt {
                let events =
                    self.check_text_for_secrets(text, &event.source, affected.as_deref());
                for e in events {
                    let secret_type = e
                        .metadata
                        .get("secret_type")
                        .and_then(|v| v.as_str())
                        .unwrap_or("")
                        .to_string();
                    if !matched_types.contains(&secret_type) {
                        matched_types.push(secret_type);
                        all_events.push(e);
                    }
                }
            }
        }

        all_events
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;
    use std::collections::HashMap;

    fn default_source() -> EventSource {
        EventSource {
            collector: "test".to_string(),
            host_id: "test-host".to_string(),
            host_name: "test".to_string(),
            agent_id: "test-agent".to_string(),
            process_name: Some("test-proc".to_string()),
            process_id: Some(1000),
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
        
            agent_version: None,
            service_name: None,
        }
    }

    fn make_event_with_text(title: &str, description: &str, metadata: HashMap<String, serde_json::Value>) -> SecurityEvent {
        let mut event = SecurityEvent::new(
            EventCategory::System,
            EventAction::Started,
            default_source(),
            title,
            description,
        );
        event.metadata = metadata;
        event
    }

    #[test]
    fn test_new_engine() {
        let engine = SecretsEngine::new();
        assert_eq!(engine.patterns.len(), 8);
    }

    #[test]
    fn test_detect_aws_key() {
        let engine = SecretsEngine::new();
        let event = make_event_with_text(
            "config loaded",
            "Access key: AKIAIOSFODNN7EXAMPLE",
            HashMap::new(),
        );
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(detections.iter().any(|d| {
            d.metadata
                .get("secret_type")
                .and_then(|v| v.as_str())
                == Some("aws-access-key")
        }));
    }

    #[test]
    fn test_detect_private_key() {
        let engine = SecretsEngine::new();
        let event = make_event_with_text(
            "file scan",
            "Found: -----BEGIN RSA PRIVATE KEY----- in /tmp/key.pem",
            HashMap::new(),
        );
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(detections.iter().any(|d| {
            d.metadata
                .get("secret_type")
                .and_then(|v| v.as_str())
                == Some("private-key")
        }));
        assert_eq!(detections[0].severity, Severity::High);
    }

    #[test]
    fn test_detect_database_url() {
        let engine = SecretsEngine::new();
        let event = make_event_with_text(
            "startup",
            "Connecting to postgres://admin:s3cret123@db.example.com:5432/myapp",
            HashMap::new(),
        );
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(detections.iter().any(|d| {
            d.metadata
                .get("secret_type")
                .and_then(|v| v.as_str())
                == Some("database-url")
        }));
    }

    #[test]
    fn test_detect_jwt() {
        let engine = SecretsEngine::new();
        let event = make_event_with_text(
            "auth debug",
            "Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIn0.dozjgNryP4J3jVmNHl0w5N_XgL0n3I9PlFUP0THsR8U",
            HashMap::new(),
        );
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
    }

    #[test]
    fn test_detect_secret_in_metadata() {
        let engine = SecretsEngine::new();
        let mut metadata = HashMap::new();
        metadata.insert(
            "api_token".to_string(),
            serde_json::json!("AKIAIOSFODNN7EXAMPLE"),
        );
        let event = make_event_with_text("config event", "configuration loaded", metadata);
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
    }

    #[test]
    fn test_no_false_positive_on_clean_text() {
        let engine = SecretsEngine::new();
        let event = make_event_with_text(
            "all good",
            "System started successfully, no issues found.",
            HashMap::new(),
        );
        let detections = engine.process_event(&event);
        assert!(detections.is_empty());
    }

    #[test]
    fn test_detection_has_mitre_t1552_001() {
        let engine = SecretsEngine::new();
        let event = make_event_with_text(
            "scan",
            "Found ghp_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnop12",
            HashMap::new(),
        );
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert_eq!(
            detections[0].mitre_id.as_deref(),
            Some("T1552.001")
        );
    }

    #[test]
    fn test_affected_entity_set_when_file_path_in_metadata() {
        let engine = SecretsEngine::new();
        let mut metadata = HashMap::new();
        metadata.insert(
            "source_file".to_string(),
            serde_json::json!("/etc/app/config.yml"),
        );
        let event = make_event_with_text(
            "config scan",
            "AKIAIOSFODNN7EXAMPLE key found in config",
            metadata,
        );
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(!detections[0].affected_entities.is_empty());
        assert_eq!(detections[0].affected_entities[0].value, "/etc/app/config.yml");
    }
}
