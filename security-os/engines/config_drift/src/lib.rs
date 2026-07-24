use chrono::{DateTime, Utc};
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use sha2::{Digest, Sha256};
use tracing::{debug, warn};

#[derive(Debug, Clone)]
pub struct ConfigBaseline {
    pub path: String,
    pub sha256: String,
    pub last_checked: DateTime<Utc>,
    pub contents: String,
}

pub struct ConfigDriftEngine {
    baselines: DashMap<String, ConfigBaseline>,
}

impl ConfigDriftEngine {
    pub fn new() -> Self {
        Self {
            baselines: DashMap::new(),
        }
    }

    pub fn register_baseline(&self, path: &str, contents: &str) {
        let hash = Self::compute_sha256(contents);
        self.baselines.insert(
            path.to_string(),
            ConfigBaseline {
                path: path.to_string(),
                sha256: hash,
                last_checked: Utc::now(),
                contents: contents.to_string(),
            },
        );
        debug!("Registered config baseline for {}", path);
    }

    pub fn compute_sha256(contents: &str) -> String {
        let mut hasher = Sha256::new();
        hasher.update(contents.as_bytes());
        let result = hasher.finalize();
        hex::encode(result)
    }

    fn get_string_meta(event: &SecurityEvent, key: &str) -> Option<String> {
        event
            .metadata
            .get(key)
            .and_then(|v| v.as_str())
            .map(|s| s.to_string())
    }

    fn detect_config_modification(
        &self,
        event: &SecurityEvent,
        file_path: &str,
        current_contents: &str,
    ) -> Option<SecurityEvent> {
        let baseline = self.baselines.get(file_path)?;
        let current_hash = Self::compute_sha256(current_contents);

        if current_hash == baseline.sha256 {
            return None;
        }

        debug!("Config modification detected for {}", file_path);

        let source = Self::make_source(event, "config-drift-engine");
        let mut det = SecurityEvent::new(
            EventCategory::ConfigurationDrift,
            EventAction::Detected,
            source,
            format!("Configuration file modified: {}", file_path),
            format!(
                "Configuration file '{}' has been modified. Baseline hash: {}, Current hash: {}. \
                 This may indicate unauthorized configuration changes.",
                file_path, baseline.sha256, current_hash
            ),
        )
        .with_severity(Severity::High)
        .with_confidence(0.95)
        .with_risk_score(85.0)
        .with_mitre(
            "Impact",
            "Data Manipulation: Stored Data Manipulation",
            "T1565.001",
        )
        .with_tag("config-drift")
        .with_tag("modification");

        det.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: file_path.to_string(),
            risk_contribution: 50.0,
            metadata: std::collections::HashMap::new(),
        });

        Some(det)
    }

    fn detect_permission_change(
        &self,
        event: &SecurityEvent,
        file_path: &str,
    ) -> Option<SecurityEvent> {
        if !self.baselines.contains_key(file_path) {
            return None;
        }

        let old_perms = Self::get_string_meta(event, "old_permissions");
        let new_perms = Self::get_string_meta(event, "new_permissions");

        if old_perms == new_perms || new_perms.is_none() {
            return None;
        }

        let new_p = new_perms.unwrap();
        let old_p = old_perms.unwrap_or_else(|| "unknown".to_string());

        debug!(
            "Permission change detected for {}: {} -> {}",
            file_path, old_p, new_p
        );

        let source = Self::make_source(event, "config-drift-engine");
        let mut det = SecurityEvent::new(
            EventCategory::ConfigurationDrift,
            EventAction::Detected,
            source,
            format!("Config permission change: {}", file_path),
            format!(
                "Configuration file '{}' permissions changed from {} to {}. \
                 Unexpected permission changes may indicate tampering.",
                file_path, old_p, new_p
            ),
        )
        .with_severity(Severity::Medium)
        .with_confidence(0.85)
        .with_risk_score(65.0)
        .with_mitre(
            "Impact",
            "Data Manipulation: Stored Data Manipulation",
            "T1565.001",
        )
        .with_tag("config-drift")
        .with_tag("permission-change");

        det.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: file_path.to_string(),
            risk_contribution: 40.0,
            metadata: std::collections::HashMap::new(),
        });

        Some(det)
    }

    fn detect_new_config_in_monitored_dir(
        &self,
        event: &SecurityEvent,
        file_path: &str,
    ) -> Option<SecurityEvent> {
        let dir = std::path::Path::new(file_path)
            .parent()
            .and_then(|p| p.to_str())
            .unwrap_or("");

        let is_monitored = self.baselines.iter().any(|entry| {
            let baseline_dir = std::path::Path::new(&entry.value().path)
                .parent()
                .and_then(|p| p.to_str())
                .unwrap_or("");
            baseline_dir == dir && !baseline_dir.is_empty()
        });

        if !is_monitored {
            return None;
        }

        if self.baselines.contains_key(file_path) {
            return None;
        }

        debug!("New config file in monitored directory: {}", file_path);

        let source = Self::make_source(event, "config-drift-engine");
        let mut det = SecurityEvent::new(
            EventCategory::ConfigurationDrift,
            EventAction::Detected,
            source,
            format!("New config file in monitored directory: {}", file_path),
            format!(
                "New configuration file '{}' appeared in monitored directory '{}'. \
                 This may indicate unauthorized configuration deployment.",
                file_path, dir
            ),
        )
        .with_severity(Severity::Low)
        .with_confidence(0.7)
        .with_risk_score(40.0)
        .with_mitre(
            "Impact",
            "Data Manipulation: Stored Data Manipulation",
            "T1565.001",
        )
        .with_tag("config-drift")
        .with_tag("new-file");

        det.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: file_path.to_string(),
            risk_contribution: 30.0,
            metadata: std::collections::HashMap::new(),
        });

        Some(det)
    }

    fn make_source(event: &SecurityEvent, agent_id: &str) -> EventSource {
        EventSource {
            collector: event.source.collector.clone(),
            host_id: event.source.host_id.clone(),
            host_name: event.source.host_name.clone(),
            agent_id: agent_id.to_string(),
            agent_version: None,
            process_name: event.source.process_name.clone(),
            process_id: event.source.process_id,
            user_id: event.source.user_id.clone(),
            user_name: event.source.user_name.clone(),
            container_id: event.source.container_id.clone(),
            container_name: event.source.container_name.clone(),
            pod_name: event.source.pod_name.clone(),
            namespace: event.source.namespace.clone(),
            service_name: None,
        }
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        if event.category != EventCategory::Filesystem
            && event.category != EventCategory::ConfigurationDrift
        {
            return detections;
        }

        let file_path =
            Self::get_string_meta(event, "file_path").or_else(|| Self::get_string_meta(event, "path"));

        let file_path = match file_path {
            Some(p) => p,
            None => return detections,
        };

        if event.action == EventAction::Modified {
            if let Some(current_contents) = Self::get_string_meta(event, "file_contents") {
                if let Some(det) =
                    self.detect_config_modification(event, &file_path, &current_contents)
                {
                    warn!("Config drift detection: {}", det.title);
                    detections.push(det);
                }
            }

            if let Some(det) = self.detect_permission_change(event, &file_path) {
                warn!("Config drift detection: {}", det.title);
                detections.push(det);
            }
        }

        if event.action == EventAction::Created {
            if let Some(det) = self.detect_new_config_in_monitored_dir(event, &file_path) {
                warn!("Config drift detection: {}", det.title);
                detections.push(det);
            }
        }

        detections
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::HashMap;

    fn make_test_event(
        category: EventCategory,
        action: EventAction,
        metadata: HashMap<String, serde_json::Value>,
    ) -> SecurityEvent {
        let source = EventSource {
            collector: "test".to_string(),
            host_id: "test-host".to_string(),
            host_name: "test".to_string(),
            agent_id: "test-agent".to_string(),
            process_name: None,
            process_id: None,
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
        
            agent_version: None,
            service_name: None,
        };

        let mut event = SecurityEvent::new(category, action, source, "test event", "test desc");
        event.metadata = metadata;
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = ConfigDriftEngine::new();
        assert!(engine.baselines.is_empty());
    }

    #[test]
    fn test_register_baseline() {
        let engine = ConfigDriftEngine::new();
        engine.register_baseline("/etc/nginx/nginx.conf", "worker_processes 1;");

        assert!(engine.baselines.contains_key("/etc/nginx/nginx.conf"));
        let baseline = engine.baselines.get("/etc/nginx/nginx.conf").unwrap();
        assert_eq!(baseline.path, "/etc/nginx/nginx.conf");
        assert!(!baseline.sha256.is_empty());
        assert_eq!(baseline.contents, "worker_processes 1;");
    }

    #[test]
    fn test_compute_sha256() {
        let hash1 = ConfigDriftEngine::compute_sha256("hello world");
        let hash2 = ConfigDriftEngine::compute_sha256("hello world");
        let hash3 = ConfigDriftEngine::compute_sha256("hello world!");

        assert_eq!(hash1, hash2);
        assert_ne!(hash1, hash3);
        assert_eq!(hash1.len(), 64);
    }

    #[test]
    fn test_config_modification_detection() {
        let mut engine = ConfigDriftEngine::new();
        engine.register_baseline("/etc/nginx/nginx.conf", "worker_processes 1;");

        let mut metadata = HashMap::new();
        metadata.insert(
            "file_path".to_string(),
            serde_json::Value::String("/etc/nginx/nginx.conf".to_string()),
        );
        metadata.insert(
            "file_contents".to_string(),
            serde_json::Value::String("worker_processes 4;".to_string()),
        );

        let event = make_test_event(EventCategory::Filesystem, EventAction::Modified, metadata);
        let detections = engine.process_event(&event);

        assert_eq!(detections.len(), 1);
        assert_eq!(detections[0].severity, Severity::High);
        assert_eq!(detections[0].mitre_id.as_deref(), Some("T1565.001"));
        assert!(detections[0].title.contains("modified"));
    }

    #[test]
    fn test_no_drift_when_same_content() {
        let mut engine = ConfigDriftEngine::new();
        engine.register_baseline("/etc/nginx/nginx.conf", "worker_processes 1;");

        let mut metadata = HashMap::new();
        metadata.insert(
            "file_path".to_string(),
            serde_json::Value::String("/etc/nginx/nginx.conf".to_string()),
        );
        metadata.insert(
            "file_contents".to_string(),
            serde_json::Value::String("worker_processes 1;".to_string()),
        );

        let event = make_test_event(EventCategory::Filesystem, EventAction::Modified, metadata);
        let detections = engine.process_event(&event);

        assert!(detections.is_empty());
    }

    #[test]
    fn test_permission_change_detection() {
        let mut engine = ConfigDriftEngine::new();
        engine.register_baseline("/etc/app/config.toml", "key = \"value\"");

        let mut metadata = HashMap::new();
        metadata.insert(
            "file_path".to_string(),
            serde_json::Value::String("/etc/app/config.toml".to_string()),
        );
        metadata.insert(
            "old_permissions".to_string(),
            serde_json::Value::String("0644".to_string()),
        );
        metadata.insert(
            "new_permissions".to_string(),
            serde_json::Value::String("0777".to_string()),
        );

        let event = make_test_event(EventCategory::Filesystem, EventAction::Modified, metadata);
        let detections = engine.process_event(&event);

        assert_eq!(detections.len(), 1);
        assert_eq!(detections[0].severity, Severity::Medium);
        assert!(detections[0].title.contains("permission change"));
    }

    #[test]
    fn test_permission_change_no_detection_for_unknown_file() {
        let mut engine = ConfigDriftEngine::new();

        let mut metadata = HashMap::new();
        metadata.insert(
            "file_path".to_string(),
            serde_json::Value::String("/etc/unknown.conf".to_string()),
        );
        metadata.insert(
            "old_permissions".to_string(),
            serde_json::Value::String("0644".to_string()),
        );
        metadata.insert(
            "new_permissions".to_string(),
            serde_json::Value::String("0777".to_string()),
        );

        let event = make_test_event(EventCategory::Filesystem, EventAction::Modified, metadata);
        let detections = engine.process_event(&event);

        assert!(detections.is_empty());
    }

    #[test]
    fn test_new_config_in_monitored_dir() {
        let mut engine = ConfigDriftEngine::new();
        engine.register_baseline("/etc/app/old.conf", "old content");

        let mut metadata = HashMap::new();
        metadata.insert(
            "file_path".to_string(),
            serde_json::Value::String("/etc/app/new.conf".to_string()),
        );

        let event = make_test_event(EventCategory::Filesystem, EventAction::Created, metadata);
        let detections = engine.process_event(&event);

        assert_eq!(detections.len(), 1);
        assert_eq!(detections[0].severity, Severity::Low);
        assert!(detections[0].title.contains("New config file"));
    }

    #[test]
    fn test_new_file_in_unmonitored_dir_no_detection() {
        let mut engine = ConfigDriftEngine::new();
        engine.register_baseline("/etc/app/config.toml", "key = \"value\"");

        let mut metadata = HashMap::new();
        metadata.insert(
            "file_path".to_string(),
            serde_json::Value::String("/tmp/unrelated/new.conf".to_string()),
        );

        let event = make_test_event(EventCategory::Filesystem, EventAction::Created, metadata);
        let detections = engine.process_event(&event);

        assert!(detections.is_empty());
    }

    #[test]
    fn test_non_filesystem_event_ignored() {
        let mut engine = ConfigDriftEngine::new();
        engine.register_baseline("/etc/nginx/nginx.conf", "worker_processes 1;");

        let mut metadata = HashMap::new();
        metadata.insert(
            "file_path".to_string(),
            serde_json::Value::String("/etc/nginx/nginx.conf".to_string()),
        );
        metadata.insert(
            "file_contents".to_string(),
            serde_json::Value::String("worker_processes 4;".to_string()),
        );

        let event = make_test_event(EventCategory::Process, EventAction::Modified, metadata);
        let detections = engine.process_event(&event);

        assert!(detections.is_empty());
    }

    #[test]
    fn test_event_without_file_path_ignored() {
        let mut engine = ConfigDriftEngine::new();
        engine.register_baseline("/etc/nginx/nginx.conf", "worker_processes 1;");

        let event = make_test_event(EventCategory::Filesystem, EventAction::Modified, HashMap::new());
        let detections = engine.process_event(&event);

        assert!(detections.is_empty());
    }

    #[test]
    fn test_configuration_drift_category_also_works() {
        let mut engine = ConfigDriftEngine::new();
        engine.register_baseline("/etc/app/config.toml", "key = \"value\"");

        let mut metadata = HashMap::new();
        metadata.insert(
            "file_path".to_string(),
            serde_json::Value::String("/etc/app/config.toml".to_string()),
        );
        metadata.insert(
            "file_contents".to_string(),
            serde_json::Value::String("key = \"hacked\"".to_string()),
        );

        let event = make_test_event(
            EventCategory::ConfigurationDrift,
            EventAction::Modified,
            metadata,
        );
        let detections = engine.process_event(&event);

        assert_eq!(detections.len(), 1);
        assert_eq!(detections[0].severity, Severity::High);
    }
}
