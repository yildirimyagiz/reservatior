use std::collections::HashMap;
use chrono::{DateTime, Datelike, Timelike, Utc};
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::{debug, warn};

const AFTER_HOURS_START: u32 = 22; // 10 PM
const AFTER_HOURS_END: u32 = 6; // 6 AM
const MASS_DOWNLOAD_THRESHOLD: u64 = 100;
const SENSITIVE_PATHS: &[&str] = &[
    "/etc/shadow",
    "/etc/passwd",
    "/etc/sudoers",
    "/root/.ssh/",
    "/home/",
    "/var/log/auth.log",
    "/var/log/syslog",
    "/proc/",
    "/dev/",
    "/etc/ssl/private/",
    "/var/lib/mysql/",
    "/var/lib/postgresql/",
    "/backup/",
    "/secrets/",
    "/credentials/",
    "/api_keys/",
    ".env",
    "id_rsa",
    "authorized_keys",
];

const USB_DEVICE_PATHS: &[&str] = &[
    "/media/",
    "/mnt/usb",
    "/run/media/",
    "/Volumes/",
];

const SUSPICIOUS_EMAIL_PATTERNS: &[&str] = &[
    "forward",
    "auto-forward",
    "redirect",
    "rules",
    "delegate",
];

#[derive(Debug, Clone)]
struct FileAccessRecord {
    file_path: String,
    timestamp: DateTime<Utc>,
    bytes: u64,
}

#[derive(Debug, Clone)]
struct UserBaseline {
    typical_hours: Vec<u32>,
    avg_daily_files: f64,
    avg_daily_bytes: u64,
    known_sensitive_paths: Vec<String>,
    last_activity: DateTime<Utc>,
}

impl Default for UserBaseline {
    fn default() -> Self {
        Self {
            typical_hours: (8..18).collect(),
            avg_daily_files: 50.0,
            avg_daily_bytes: 100 * 1024 * 1024,
            known_sensitive_paths: Vec::new(),
            last_activity: Utc::now(),
        }
    }
}

pub struct InsiderThreatEngine {
    user_baselines: DashMap<String, UserBaseline>,
    user_file_accesses: DashMap<String, Vec<FileAccessRecord>>,
    user_download_counts: DashMap<String, u64>,
    user_sensitive_access: DashMap<String, Vec<String>>,
}

impl InsiderThreatEngine {
    pub fn new() -> Self {
        Self {
            user_baselines: DashMap::new(),
            user_file_accesses: DashMap::new(),
            user_download_counts: DashMap::new(),
            user_sensitive_access: DashMap::new(),
        }
    }

    fn is_after_hours(timestamp: DateTime<Utc>) -> bool {
        let hour = timestamp.hour();
        hour >= AFTER_HOURS_START || hour < AFTER_HOURS_END
    }

    fn is_sensitive_path(path: &str) -> bool {
        SENSITIVE_PATHS
            .iter()
            .any(|sp| path.contains(sp))
    }

    fn is_usb_path(path: &str) -> bool {
        USB_DEVICE_PATHS
            .iter()
            .any(|up| path.starts_with(up) || path.contains(up))
    }

    fn detect_after_hours_activity(
        &self,
        user: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if !Self::is_after_hours(event.timestamp) {
            return None;
        }

        let baseline = self
            .user_baselines
            .get(user)
            .map(|b| b.clone())
            .unwrap_or_default();

        let hour = event.timestamp.hour() as u32;
        if baseline.typical_hours.contains(&hour) {
            return None;
        }

        let mut event_det = SecurityEvent::new(
            EventCategory::Behavior,
            EventAction::Detected,
            event.source.clone(),
            format!("After-hours activity by user {}", user),
            format!(
                "User {} performed activity at {:02}:{:02} UTC, outside typical working hours. \
                 This may indicate unauthorized access.",
                user,
                event.timestamp.hour(),
                event.timestamp.minute()
            ),
        )
        .with_severity(Severity::Medium)
        .with_confidence(0.70)
        .with_risk_score(55.0)
        .with_mitre(
            "Initial Access",
            "Valid Accounts",
            "T1078",
        )
        .with_tag("after_hours_activity");

        event_det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: user.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        Some(event_det)
    }

    fn detect_mass_file_download(
        &self,
        user: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        let mut count = self
            .user_download_counts
            .entry(user.to_string())
            .or_insert(0);
        *count += 1;
        let current_count = *count;
        drop(count);

        if current_count < MASS_DOWNLOAD_THRESHOLD {
            return None;
        }

        let mut event_det = SecurityEvent::new(
            EventCategory::Behavior,
            EventAction::Detected,
            event.source.clone(),
            format!("Mass file download by user {}", user),
            format!(
                "User {} has downloaded {} files. Mass downloads may indicate data theft.",
                user, current_count
            ),
        )
        .with_severity(Severity::High)
        .with_confidence(0.80)
        .with_risk_score(75.0)
        .with_mitre(
            "Exfiltration",
            "Exfiltration Over Web Service",
            "T1567",
        )
        .with_tag("mass_download");

        event_det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: user.to_string(),
            risk_contribution: 50.0,
            metadata: HashMap::new(),
        });

        Some(event_det)
    }

    fn detect_sensitive_resource_access(
        &self,
        user: &str,
        path: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if !Self::is_sensitive_path(path) {
            return None;
        }

        let mut accessed = self
            .user_sensitive_access
            .entry(user.to_string())
            .or_default();

        if accessed.contains(&path.to_string()) {
            return None;
        }
        accessed.push(path.to_string());
        drop(accessed);

        let severity = if path.contains("shadow") || path.contains("private") || path.contains("id_rsa") {
            Severity::Critical
        } else if path.contains("secret") || path.contains("credential") || path.contains(".env") {
            Severity::High
        } else {
            Severity::Medium
        };

        let mut event_det = SecurityEvent::new(
            EventCategory::Filesystem,
            EventAction::Detected,
            event.source.clone(),
            format!("Sensitive resource access by user {}: {}", user, path),
            format!(
                "User {} accessed sensitive resource '{}'. \
                 This may indicate unauthorized data access or reconnaissance.",
                user, path
            ),
        )
        .with_severity(severity)
        .with_confidence(0.85)
        .with_risk_score(70.0)
        .with_mitre(
            "Initial Access",
            "Valid Accounts",
            "T1078",
        )
        .with_file(path)
        .with_tag("sensitive_resource_access");

        event_det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: user.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });
        event_det.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: path.to_string(),
            risk_contribution: 30.0,
            metadata: HashMap::new(),
        });

        Some(event_det)
    }

    fn detect_usb_data_exfiltration(
        &self,
        user: &str,
        path: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if !Self::is_usb_path(path) {
            return None;
        }

        let mut event_det = SecurityEvent::new(
            EventCategory::Usb,
            EventAction::Detected,
            event.source.clone(),
            format!("USB data exfiltration attempt by user {}", user),
            format!(
                "User {} wrote data to USB device at path '{}'. \
                 USB data transfers may indicate data exfiltration.",
                user, path
            ),
        )
        .with_severity(Severity::High)
        .with_confidence(0.80)
        .with_risk_score(72.0)
        .with_mitre(
            "Exfiltration",
            "Exfiltration Over Physical Medium",
            "T1052",
        )
        .with_file(path)
        .with_tag("usb_exfiltration");

        event_det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: user.to_string(),
            risk_contribution: 50.0,
            metadata: HashMap::new(),
        });

        Some(event_det)
    }

    fn detect_abnormal_email_patterns(
        &self,
        user: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        let subject = event
            .metadata
            .get("email_subject")
            .and_then(|v| v.as_str())
            .unwrap_or("");
        let body = event
            .metadata
            .get("email_body")
            .and_then(|v| v.as_str())
            .unwrap_or("");
        let combined = format!("{} {}", subject, body).to_lowercase();

        let matched_pattern = SUSPICIOUS_EMAIL_PATTERNS
            .iter()
            .find(|p| combined.contains(*p));

        let pattern = matched_pattern?;

        let mut event_det = SecurityEvent::new(
            EventCategory::Behavior,
            EventAction::Detected,
            event.source.clone(),
            format!("Suspicious email pattern from user {}: {}", user, pattern),
            format!(
                "User {} sent email with suspicious pattern '{}' in subject/body. \
                 This may indicate data exfiltration or unauthorized forwarding.",
                user, pattern
            ),
        )
        .with_severity(Severity::Medium)
        .with_confidence(0.65)
        .with_risk_score(50.0)
        .with_mitre(
            "Initial Access",
            "Valid Accounts",
            "T1078",
        )
        .with_tag("abnormal_email_pattern");

        event_det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: user.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        Some(event_det)
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        let user = match event.username.as_deref() {
            Some(u) => u.to_string(),
            None => return detections,
        };

        // Update baseline
        self.user_baselines
            .entry(user.clone())
            .or_insert_with(UserBaseline::default);

        // Track file access
        if event.category == EventCategory::Filesystem
            && (event.action == EventAction::Created || event.action == EventAction::Modified)
        {
            if let Some(ref path) = event.file_path {
                let bytes = event.file_size.unwrap_or(0);
                self.user_file_accesses
                    .entry(user.clone())
                    .or_default()
                    .push(FileAccessRecord {
                        file_path: path.clone(),
                        timestamp: event.timestamp,
                        bytes,
                    });

                // Check sensitive resource access
                if let Some(det) =
                    self.detect_sensitive_resource_access(&user, path, event)
                {
                    warn!("Sensitive resource access: {}", det.title);
                    detections.push(det);
                }

                // Check USB exfiltration
                if let Some(det) =
                    self.detect_usb_data_exfiltration(&user, path, event)
                {
                    warn!("USB exfiltration attempt: {}", det.title);
                    detections.push(det);
                }
            }
        }

        // Detect after-hours activity
        if let Some(det) = self.detect_after_hours_activity(&user, event) {
            warn!("After-hours activity: {}", det.title);
            detections.push(det);
        }

        // Detect mass file downloads
        if event.category == EventCategory::Filesystem && event.action == EventAction::Created {
            if let Some(det) = self.detect_mass_file_download(&user, event) {
                warn!("Mass file download: {}", det.title);
                detections.push(det);
            }
        }

        // Detect abnormal email patterns
        if event.category == EventCategory::Network
            && event
                .metadata
                .get("protocol")
                .and_then(|v| v.as_str())
                .map(|p| p.eq_ignore_ascii_case("smtp"))
                .unwrap_or(false)
        {
            if let Some(det) = self.detect_abnormal_email_patterns(&user, event) {
                warn!("Abnormal email pattern: {}", det.title);
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

    fn make_source() -> EventSource {
        EventSource {
            collector: "test".to_string(),
            host_id: "test-host".to_string(),
            host_name: "test".to_string(),
            agent_id: "test-agent".to_string(),
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
        }
    }

    fn make_file_event(
        user: &str,
        path: &str,
        action: EventAction,
    ) -> SecurityEvent {
        let source = make_source();
        let mut event = SecurityEvent::new(
            EventCategory::Filesystem,
            action,
            source,
            format!("File event: {}", path),
            format!("Event on file {}", path),
        );
        event.file_path = Some(path.to_string());
        event.username = Some(user.to_string());
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = InsiderThreatEngine::new();
        assert!(engine.user_baselines.is_empty());
        assert!(engine.user_file_accesses.is_empty());
    }

    #[test]
    fn test_sensitive_resource_access() {
        let mut engine = InsiderThreatEngine::new();
        let event = make_file_event("alice", "/etc/shadow", EventAction::Created);
        let detections = engine.process_event(&event);
        assert!(detections.iter().any(|d| d.severity == Severity::Critical && d.mitre_id.as_deref() == Some("T1078")));
    }

    #[test]
    fn test_usb_exfiltration() {
        let mut engine = InsiderThreatEngine::new();
        let event = make_file_event("bob", "/media/usb/backup.tar.gz", EventAction::Created);
        let detections = engine.process_event(&event);
        assert!(detections.iter().any(|d| d.tags.contains(&"usb_exfiltration".to_string())));
    }

    #[test]
    fn test_mass_download() {
        let mut engine = InsiderThreatEngine::new();
        for _ in 0..101 {
            let event = make_file_event("alice", "/data/file.txt", EventAction::Created);
            let detections = engine.process_event(&event);
            if detections.iter().any(|d| d.tags.contains(&"mass_download".to_string())) {
                return;
            }
        }
        panic!("Expected mass download detection");
    }

    #[test]
    fn test_non_sensitive_path_ignored() {
        let mut engine = InsiderThreatEngine::new();
        let event = make_file_event("alice", "/tmp/notes.txt", EventAction::Created);
        let detections = engine.process_event(&event);
        let has_critical = detections.iter().any(|d| d.severity == Severity::Critical);
        assert!(!has_critical);
    }
}
