use chrono::{DateTime, Duration, Utc};
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, Severity,
};
use tracing::warn;

use security_os_core::SecurityEvent;

const MASS_MOD_THRESHOLD: u32 = 50;
const MASS_MOD_WINDOW_SECS: i64 = 60;
const SENSITIVE_PATHS: &[&str] = &[
    "/etc/passwd",
    "/etc/shadow",
    "/etc/sudoers",
    "/etc/ssh/sshd_config",
    "/etc/pam.d/",
    "/root/.ssh/authorized_keys",
    "/etc/crontab",
    "/var/log/auth.log",
    "/etc/hosts",
    "/etc/resolv.conf",
    "/etc/ld.so.preload",
];

const SUSPICIOUS_EXTENSIONS: &[&str] = &[
    ".key", ".pem", ".crt", ".p12", ".pfx", ".jks", ".keystore",
    ".env", ".credentials", ".secret", ".token",
];

#[derive(Debug, Clone)]
pub struct FileModRecord {
    pub path: String,
    pub timestamp: DateTime<Utc>,
}

#[derive(Debug, Clone)]
pub struct ModificationTracker {
    pub modifications: Vec<FileModRecord>,
}

impl ModificationTracker {
    fn new() -> Self {
        Self {
            modifications: Vec::new(),
        }
    }

    fn cleanup_old(&mut self, cutoff: DateTime<Utc>) {
        self.modifications.retain(|r| r.timestamp >= cutoff);
    }

    fn add_modification(&mut self, record: FileModRecord) {
        self.modifications.push(record);
    }
}

pub struct FilesystemEngine {
    modification_counters: DashMap<String, ModificationTracker>,
    sensitive_access_counters: DashMap<String, Vec<DateTime<Utc>>>,
    permission_escalation_cache: DashMap<String, Vec<String>>,
}

impl FilesystemEngine {
    pub fn new() -> Self {
        Self {
            modification_counters: DashMap::new(),
            sensitive_access_counters: DashMap::new(),
            permission_escalation_cache: DashMap::new(),
        }
    }

    fn is_sensitive_path(&self, path: &str) -> bool {
        let normalized = if let Some(stripped) = path.strip_suffix('/') {
            stripped
        } else {
            path
        };

        for sensitive in SENSITIVE_PATHS {
            if sensitive.ends_with('/') {
                if normalized.starts_with(sensitive.trim_end_matches('/')) {
                    return true;
                }
            } else if normalized == *sensitive {
                return true;
            }
        }

        if let Some(filename) = std::path::Path::new(normalized)
            .file_name()
            .and_then(|f| f.to_str())
        {
            for ext in SUSPICIOUS_EXTENSIONS {
                if filename.ends_with(ext) {
                    return true;
                }
            }
        }

        false
    }

    fn detect_mass_modifications(
        &self,
        source_ip: &str,
        tracker: &ModificationTracker,
        now: DateTime<Utc>,
    ) -> Option<SecurityEvent> {
        let window_start = now - Duration::seconds(MASS_MOD_WINDOW_SECS);
        let recent_mods: Vec<&FileModRecord> = tracker
            .modifications
            .iter()
            .filter(|r| r.timestamp >= window_start)
            .collect();

        if recent_mods.len() as u32 >= MASS_MOD_THRESHOLD {
            let source = EventSource {
                collector: "filesystem-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "filesystem-engine-agent".to_string(),
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

            let paths: Vec<&str> = recent_mods.iter().map(|r| r.path.as_str()).collect();
            let unique_extensions: Vec<String> = paths
                .iter()
                .filter_map(|p| std::path::Path::new(p)
                    .extension()
                    .and_then(|e| e.to_str())
                    .map(|e| e.to_string())
                )
                .collect::<std::collections::HashSet<_>>()
                .into_iter()
                .collect();

            let mut event = SecurityEvent::new(
                EventCategory::Filesystem,
                EventAction::Detected,
                source,
                format!("Mass file modifications detected (possible ransomware)"),
                format!(
                    "Process/user '{}' modified {} files within {} seconds. \
                     This behavior is consistent with ransomware encryption activity. \
                     Modified extensions: [{}]. Sample paths: [{}]",
                    source_ip,
                    recent_mods.len(),
                    MASS_MOD_WINDOW_SECS,
                    unique_extensions.join(", "),
                    paths.iter().take(5).cloned().collect::<Vec<_>>().join(", "),
                ),
            )
            .with_severity(Severity::Critical)
            .with_confidence(0.85)
            .with_risk_score(95.0)
            .with_mitre(
                "Impact",
                "Data Encrypted for Impact",
                "T1486",
            )
            .with_tag("ransomware")
            .with_tag("mass-file-modification");

            event.metadata.insert(
                "file_count".to_string(),
                serde_json::Value::Number(recent_mods.len().into()),
            );
            event.metadata.insert(
                "extensions".to_string(),
                serde_json::Value::Array(
                    unique_extensions
                        .iter()
                        .map(|e| serde_json::Value::String(e.clone()))
                        .collect(),
                ),
            );
            event.metadata.insert(
                "sample_paths".to_string(),
                serde_json::Value::Array(
                    paths
                        .iter()
                        .take(10)
                        .map(|p| serde_json::Value::String(p.to_string()))
                        .collect(),
                ),
            );

            event.affected_entities.push(Entity {
                entity_type: EntityType::Host,
                value: source_ip.to_string(),
                risk_contribution: 50.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(event);
        }

        None
    }

    fn detect_sensitive_file_access(
        &self,
        user_id: &str,
        path: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if !self.is_sensitive_path(path) {
            return None;
        }

        let mut user_access = self
            .sensitive_access_counters
            .entry(user_id.to_string())
            .or_insert_with(Vec::new);
        user_access.push(event.timestamp);

        let cutoff = event.timestamp - Duration::seconds(300);
        user_access.retain(|ts| *ts >= cutoff);

        let access_count = user_access.len();

        if access_count >= 3 {
            let source = EventSource {
                collector: "filesystem-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "filesystem-engine-agent".to_string(),
                process_name: event.source.process_name.clone(),
                process_id: event.source.process_id,
                user_id: Some(user_id.to_string()),
                user_name: event.source.user_name.clone(),
                container_id: event.source.container_id.clone(),
                container_name: event.source.container_name.clone(),
                pod_name: event.source.pod_name.clone(),
                namespace: event.source.namespace.clone(),
            
                agent_version: None,
                service_name: None,
            };

            let mut access_event = SecurityEvent::new(
                EventCategory::Filesystem,
                EventAction::Detected,
                source,
                format!(
                    "Unusual sensitive file access pattern by user {}",
                    user_id
                ),
                format!(
                    "User '{}' accessed {} sensitive files within 5 minutes. \
                     Accessed path: '{}'. This may indicate credential harvesting or \
                     data collection activity.",
                    user_id, access_count, path,
                ),
            )
            .with_severity(Severity::Medium)
            .with_confidence(0.7)
            .with_risk_score(60.0)
            .with_mitre(
                "Credential Access",
                "Unsecured Credentials: Credentials in Files",
                "T1552.001",
            )
            .with_tag("sensitive-file-access");

            access_event.metadata.insert(
                "access_count".to_string(),
                serde_json::Value::Number(access_count.into()),
            );
            access_event.metadata.insert(
                "path".to_string(),
                serde_json::Value::String(path.to_string()),
            );

            access_event.affected_entities.push(Entity {
                entity_type: EntityType::User,
                value: user_id.to_string(),
                risk_contribution: 30.0,
            
                metadata: std::collections::HashMap::new(),
            });
            access_event.affected_entities.push(Entity {
                entity_type: EntityType::File,
                value: path.to_string(),
                risk_contribution: 20.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(access_event);
        }

        None
    }

    fn detect_permission_escalation(
        &self,
        event: &SecurityEvent,
        path: &str,
    ) -> Option<SecurityEvent> {
        let new_permissions = event
            .metadata
            .get("new_permissions")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let old_permissions = event
            .metadata
            .get("old_permissions")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let owner = event
            .metadata
            .get("owner")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let new_owner = event
            .metadata
            .get("new_owner")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let mut is_suspicious = false;
        let mut reason = String::new();

        if !new_permissions.is_empty() && !old_permissions.is_empty() {
            let had_suid = old_permissions.contains("s") || old_permissions.contains("S");
            let has_suid = new_permissions.contains("s") || new_permissions.contains("S");

            if !had_suid && has_suid {
                is_suspicious = true;
                reason = format!(
                    "SUID bit was set on '{}' (was: {}, now: {})",
                    path, old_permissions, new_permissions
                );
            }

            let had_world_write = old_permissions.contains("w");
            let new_last3 = if new_permissions.len() >= 3 {
                &new_permissions[new_permissions.len() - 3..]
            } else {
                ""
            };
            let has_world_write = new_last3.contains('w');

            if !had_world_write && has_world_write {
                is_suspicious = true;
                reason = format!(
                    "World-writable permission added to '{}' (was: {}, now: {})",
                    path, old_permissions, new_permissions
                );
            }

            if new_permissions.contains("777") || new_permissions.contains("666") {
                is_suspicious = true;
                reason = format!(
                    "Overly permissive permissions set on '{}' (now: {})",
                    path, new_permissions
                );
            }
        }

        if !owner.is_empty() && !new_owner.is_empty() && owner != new_owner {
            let sensitive_owners = ["root", "www-data", "mysql", "postgres", "sshd"];
            if sensitive_owners.contains(&new_owner) && owner != "root" {
                is_suspicious = true;
                reason = format!(
                    "Ownership of '{}' transferred from '{}' to privileged user '{}'",
                    path, owner, new_owner
                );
            }
        }

        if is_suspicious {
            let source = EventSource {
                collector: "filesystem-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "filesystem-engine-agent".to_string(),
                process_name: event.source.process_name.clone(),
                process_id: event.source.process_id,
                user_id: event.source.user_id.clone(),
                user_name: event.source.user_name.clone(),
                container_id: event.source.container_id.clone(),
                container_name: event.source.container_name.clone(),
                pod_name: event.source.pod_name.clone(),
                namespace: event.source.namespace.clone(),
            
                agent_version: None,
                service_name: None,
            };

            let mut perm_event = SecurityEvent::new(
                EventCategory::Filesystem,
                EventAction::Detected,
                source,
                format!("File permission escalation detected: {}", path),
                format!(
                    "{}. This could indicate an attempt to establish persistence \
                     or escalate privileges on the system.",
                    reason,
                ),
            )
            .with_severity(Severity::High)
            .with_confidence(0.8)
            .with_risk_score(75.0)
            .with_mitre(
                "Persistence",
                "Event Triggered Execution: Trap",
                "T1546.005",
            )
            .with_tag("permission-escalation");

            perm_event
                .metadata
                .insert("path".to_string(), serde_json::json!(path));
            if !old_permissions.is_empty() {
                perm_event.metadata.insert(
                    "old_permissions".to_string(),
                    serde_json::json!(old_permissions),
                );
            }
            if !new_permissions.is_empty() {
                perm_event.metadata.insert(
                    "new_permissions".to_string(),
                    serde_json::json!(new_permissions),
                );
            }

            perm_event.affected_entities.push(Entity {
                entity_type: EntityType::File,
                value: path.to_string(),
                risk_contribution: 30.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(perm_event);
        }

        None
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        if event.category == EventCategory::Filesystem
            && (event.action == EventAction::Modified
                || event.action == EventAction::Created
                || event.action == EventAction::Deleted)
        {
            let path = event
                .metadata
                .get("path")
                .and_then(|v| v.as_str())
                .or_else(|| event.metadata.get("file_path").and_then(|v| v.as_str()))
                .unwrap_or("unknown")
                .to_string();

            let user_id = event
                .source
                .user_id
                .clone()
                .unwrap_or_else(|| "system".to_string());

            let tracker_key = user_id.clone();
            {
                let mut tracker = self
                    .modification_counters
                    .entry(tracker_key)
                    .or_insert_with(ModificationTracker::new);

                let window_start = event.timestamp - Duration::seconds(MASS_MOD_WINDOW_SECS * 2);
                tracker.cleanup_old(window_start);

                tracker.add_modification(FileModRecord {
                    path: path.clone(),
                    timestamp: event.timestamp,
                });

                if let Some(mass_event) =
                    self.detect_mass_modifications(&user_id, &tracker, event.timestamp)
                {
                    warn!(
                        "Mass file modifications detected for {}: {}",
                        user_id, mass_event.title
                    );
                    detections.push(mass_event);
                }
            }

            if let Some(sensitive_event) =
                self.detect_sensitive_file_access(&user_id, &path, event)
            {
                warn!(
                    "Sensitive file access detected: {}",
                    sensitive_event.title
                );
                detections.push(sensitive_event);
            }

            if event.action == EventAction::Modified {
                if let Some(perm_event) = self.detect_permission_escalation(event, &path) {
                    warn!(
                        "Permission escalation detected: {}",
                        perm_event.title
                    );
                    detections.push(perm_event);
                }
            }
        }

        detections
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;
    use std::collections::HashMap;
    use uuid::Uuid;

    fn make_file_event(
        path: &str,
        action: EventAction,
        user_id: &str,
    ) -> SecurityEvent {
        let mut metadata = HashMap::new();
        metadata.insert(
            "path".to_string(),
            serde_json::Value::String(path.to_string()),
        );

        let source = EventSource {
            collector: "test".to_string(),
            host_id: "test-host".to_string(),
            host_name: "test".to_string(),
            agent_id: "test-agent".to_string(),
            process_name: None,
            process_id: None,
            user_id: Some(user_id.to_string()),
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
        
            agent_version: None,
            service_name: None,
        };

        let mut event = SecurityEvent::new(
            EventCategory::Filesystem,
            action,
            source,
            format!("File action: {}", path),
            format!("File {} was modified", path),
        );
        event.metadata = metadata;
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = FilesystemEngine::new();
        assert!(engine.modification_counters.is_empty());
    }

    #[test]
    fn test_sensitive_path_detection() {
        let engine = FilesystemEngine::new();
        assert!(engine.is_sensitive_path("/etc/passwd"));
        assert!(engine.is_sensitive_path("/etc/shadow"));
        assert!(engine.is_sensitive_path("/root/.ssh/authorized_keys"));
        assert!(!engine.is_sensitive_path("/tmp/test.txt"));
        assert!(engine.is_sensitive_path("/app/server.key"));
    }
}
