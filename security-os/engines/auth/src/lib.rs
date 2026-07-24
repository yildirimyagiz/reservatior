use chrono::{DateTime, Duration, Utc};
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::warn;

const BRUTE_FORCE_THRESHOLD: usize = 5;
const BRUTE_FORCE_WINDOW_SECS: i64 = 300;
const CREDENTIAL_STUFFING_THRESHOLD: usize = 10;
const CREDENTIAL_STUFFING_USER_THRESHOLD: usize = 5;
const CREDENTIAL_STUFFING_WINDOW_SECS: i64 = 600;

#[derive(Debug, Clone)]
pub struct FailedAttempt {
    pub timestamp: DateTime<Utc>,
    pub username: String,
    pub source_ip: String,
    pub target_user: String,
}

#[derive(Debug, Clone)]
pub struct IpTracker {
    pub failed_attempts: Vec<FailedAttempt>,
    pub unique_users_targeted: Vec<String>,
}

impl IpTracker {
    fn new() -> Self {
        Self {
            failed_attempts: Vec::new(),
            unique_users_targeted: Vec::new(),
        }
    }

    fn cleanup_old(&mut self, cutoff: DateTime<Utc>) {
        self.failed_attempts.retain(|a| a.timestamp >= cutoff);
        self.unique_users_targeted.retain(|u| {
            self.failed_attempts.iter().any(|a| &a.target_user == u)
        });
    }

    fn add_attempt(&mut self, attempt: FailedAttempt) {
        if !self
            .unique_users_targeted
            .contains(&attempt.target_user)
        {
            self.unique_users_targeted.push(attempt.target_user.clone());
        }
        self.failed_attempts.push(attempt);
    }
}

#[derive(Debug, Clone)]
pub struct UserTracker {
    pub failed_attempts: Vec<FailedAttempt>,
    pub source_ips: Vec<String>,
}

impl UserTracker {
    fn new() -> Self {
        Self {
            failed_attempts: Vec::new(),
            source_ips: Vec::new(),
        }
    }

    fn cleanup_old(&mut self, cutoff: DateTime<Utc>) {
        self.failed_attempts.retain(|a| a.timestamp >= cutoff);
        self.source_ips.retain(|ip| {
            self.failed_attempts.iter().any(|a| &a.source_ip == ip)
        });
    }

    fn add_attempt(&mut self, attempt: FailedAttempt) {
        if !self.source_ips.contains(&attempt.source_ip) {
            self.source_ips.push(attempt.source_ip.clone());
        }
        self.failed_attempts.push(attempt);
    }
}

pub struct AuthEngine {
    ip_trackers: DashMap<String, IpTracker>,
    user_trackers: DashMap<String, UserTracker>,
    success_baseline: DashMap<String, Vec<DateTime<Utc>>>,
    lockout_cache: DashMap<String, DateTime<Utc>>,
}

impl AuthEngine {
    pub fn new() -> Self {
        Self {
            ip_trackers: DashMap::new(),
            user_trackers: DashMap::new(),
            success_baseline: DashMap::new(),
            lockout_cache: DashMap::new(),
        }
    }

    fn detect_brute_force(
        &self,
        source_ip: &str,
        tracker: &IpTracker,
        now: DateTime<Utc>,
    ) -> Option<SecurityEvent> {
        let window_start = now - Duration::seconds(BRUTE_FORCE_WINDOW_SECS);
        let recent_failures: Vec<&FailedAttempt> = tracker
            .failed_attempts
            .iter()
            .filter(|a| a.timestamp >= window_start)
            .collect();

        if recent_failures.len() >= BRUTE_FORCE_THRESHOLD {
            let target_users: Vec<&str> = recent_failures
                .iter()
                .map(|a| a.target_user.as_str())
                .collect::<std::collections::HashSet<_>>()
                .into_iter()
                .collect();

            let source = EventSource {
                collector: "auth-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "auth-engine-agent".to_string(),
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

            let mut brute_event = SecurityEvent::new(
                EventCategory::Authentication,
                EventAction::Detected,
                source,
                format!("Brute force attack detected from {}", source_ip),
                format!(
                    "Source IP '{}' failed authentication {} times within {} seconds. \
                     Targeted users: [{}]. This indicates a brute force attack attempt.",
                    source_ip,
                    recent_failures.len(),
                    BRUTE_FORCE_WINDOW_SECS,
                    target_users.join(", "),
                ),
            )
            .with_severity(Severity::Critical)
            .with_confidence(0.95)
            .with_risk_score(90.0)
            .with_mitre(
                "Credential Access",
                "Brute Force",
                "T1110",
            )
            .with_tag("brute-force")
            .with_tag("credential-access");

            brute_event.metadata.insert(
                "failure_count".to_string(),
                serde_json::Value::Number(recent_failures.len().into()),
            );
            brute_event.metadata.insert(
                "targeted_users".to_string(),
                serde_json::Value::Array(
                    target_users
                        .iter()
                        .map(|u| serde_json::Value::String(u.to_string()))
                        .collect(),
                ),
            );
            brute_event.metadata.insert(
                "window_seconds".to_string(),
                serde_json::Value::Number(BRUTE_FORCE_WINDOW_SECS.into()),
            );

            brute_event.affected_entities.push(Entity {
                entity_type: EntityType::Ip,
                value: source_ip.to_string(),
                risk_contribution: 50.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(brute_event);
        }

        None
    }

    fn detect_credential_stuffing(
        &self,
        source_ip: &str,
        tracker: &IpTracker,
        now: DateTime<Utc>,
    ) -> Option<SecurityEvent> {
        let window_start = now - Duration::seconds(CREDENTIAL_STUFFING_WINDOW_SECS);
        let recent_failures: Vec<&FailedAttempt> = tracker
            .failed_attempts
            .iter()
            .filter(|a| a.timestamp >= window_start)
            .collect();

        let unique_users: Vec<&str> = recent_failures
            .iter()
            .map(|a| a.target_user.as_str())
            .collect::<std::collections::HashSet<_>>()
            .into_iter()
            .collect();

        if recent_failures.len() >= CREDENTIAL_STUFFING_THRESHOLD
            && unique_users.len() >= CREDENTIAL_STUFFING_USER_THRESHOLD
        {
            let source = EventSource {
                collector: "auth-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "auth-engine-agent".to_string(),
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

            let mut stuffing_event = SecurityEvent::new(
                EventCategory::Authentication,
                EventAction::Detected,
                source,
                format!("Credential stuffing detected from {}", source_ip),
                format!(
                    "Source IP '{}' attempted to authenticate against {} different users \
                     with {} total failures within {} seconds. This pattern is consistent \
                     with credential stuffing attacks using leaked username/password databases.",
                    source_ip,
                    unique_users.len(),
                    recent_failures.len(),
                    CREDENTIAL_STUFFING_WINDOW_SECS,
                ),
            )
            .with_severity(Severity::Critical)
            .with_confidence(0.9)
            .with_risk_score(92.0)
            .with_mitre(
                "Credential Access",
                "Brute Force: Credential Stuffing",
                "T1110.004",
            )
            .with_tag("credential-stuffing");

            stuffing_event.metadata.insert(
                "unique_users".to_string(),
                serde_json::Value::Number(unique_users.len().into()),
            );
            stuffing_event.metadata.insert(
                "total_failures".to_string(),
                serde_json::Value::Number(recent_failures.len().into()),
            );
            stuffing_event.metadata.insert(
                "targeted_users".to_string(),
                serde_json::Value::Array(
                    unique_users
                        .iter()
                        .map(|u| serde_json::Value::String(u.to_string()))
                        .collect(),
                ),
            );

            stuffing_event.affected_entities.push(Entity {
                entity_type: EntityType::Ip,
                value: source_ip.to_string(),
                risk_contribution: 50.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(stuffing_event);
        }

        None
    }

    fn detect_privilege_escalation(
        &self,
        event: &SecurityEvent,
        username: &str,
    ) -> Option<SecurityEvent> {
        let action_type = event
            .metadata
            .get("action_type")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let target_role = event
            .metadata
            .get("target_role")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let previous_role = event
            .metadata
            .get("previous_role")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let mut is_suspicious = false;
        let mut reason = String::new();

        if action_type == "role_change" || action_type == "sudo_grant" {
            let privileged_roles = ["admin", "root", "superuser", "sysadmin", "operator"];
            if privileged_roles.contains(&target_role) {
                is_suspicious = true;
                reason = format!(
                    "User '{}' was granted privileged role '{}' (was: '{}')",
                    username, target_role, previous_role
                );
            }
        }

        if action_type == "password_reset" {
            let reset_by = event
                .metadata
                .get("reset_by")
                .and_then(|v| v.as_str())
                .unwrap_or("");

            if reset_by == username {
                is_suspicious = true;
                reason = format!(
                    "User '{}' performed a self-service password reset, which may indicate \
                     account takeover preparation",
                    username,
                );
            }
        }

        if action_type == "mfa_disabled" {
            is_suspicious = true;
            reason = format!(
                "MFA was disabled for user '{}' which weakens account security",
                username,
            );
        }

        if action_type == "api_key_created" {
            let key_permissions = event
                .metadata
                .get("key_permissions")
                .and_then(|v| v.as_str())
                .unwrap_or("");

            if key_permissions.contains("admin") || key_permissions.contains("*") {
                is_suspicious = true;
                reason = format!(
                    "User '{}' created an API key with broad permissions: '{}'",
                    username, key_permissions,
                );
            }
        }

        if action_type == "session_hijack_detected" {
            is_suspicious = true;
            reason = format!(
                "Possible session hijacking detected for user '{}'",
                username,
            );
        }

        if is_suspicious {
            let source = EventSource {
                collector: "auth-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "auth-engine-agent".to_string(),
                process_name: event.source.process_name.clone(),
                process_id: event.source.process_id,
                user_id: Some(username.to_string()),
                user_name: event.source.user_name.clone(),
                container_id: event.source.container_id.clone(),
                container_name: event.source.container_name.clone(),
                pod_name: event.source.pod_name.clone(),
                namespace: event.source.namespace.clone(),
            
                agent_version: None,
                service_name: None,
            };

            let mut escalation_event = SecurityEvent::new(
                EventCategory::Authentication,
                EventAction::Detected,
                source,
                format!("Privilege escalation detected for user: {}", username),
                format!(
                    "{}. This could indicate an attacker elevating their \
                     privileges within the system.",
                    reason,
                ),
            )
            .with_severity(Severity::High)
            .with_confidence(0.85)
            .with_risk_score(80.0)
            .with_mitre(
                "Privilege Escalation",
                "Account Manipulation: Additional Cloud Credentials",
                "T1098.001",
            )
            .with_tag("privilege-escalation");

            escalation_event.metadata.insert(
                "action_type".to_string(),
                serde_json::Value::String(action_type.to_string()),
            );
            escalation_event.metadata.insert(
                "target_role".to_string(),
                serde_json::Value::String(target_role.to_string()),
            );

            escalation_event.affected_entities.push(Entity {
                entity_type: EntityType::User,
                value: username.to_string(),
                risk_contribution: 40.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(escalation_event);
        }

        None
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        if event.category == EventCategory::Authentication {
            if event.action == EventAction::Failed {
                let source_ip = event
                    .metadata
                    .get("source_ip")
                    .and_then(|v| v.as_str())
                    .or_else(|| event.metadata.get("src_ip").and_then(|v| v.as_str()))
                    .unwrap_or("unknown")
                    .to_string();

                let target_user = event
                    .source
                    .user_name
                    .clone()
                    .or_else(|| {
                        event
                            .metadata
                            .get("target_user")
                            .and_then(|v| v.as_str())
                            .map(|s| s.to_string())
                    })
                    .unwrap_or_else(|| "unknown".to_string());

                let attempt = FailedAttempt {
                    timestamp: event.timestamp,
                    username: target_user.clone(),
                    source_ip: source_ip.clone(),
                    target_user: target_user.clone(),
                };

                {
                    let mut ip_tracker = self
                        .ip_trackers
                        .entry(source_ip.clone())
                        .or_insert_with(IpTracker::new);

                    let window_start =
                        event.timestamp - Duration::seconds(BRUTE_FORCE_WINDOW_SECS * 2);
                    ip_tracker.cleanup_old(window_start);
                    ip_tracker.add_attempt(attempt.clone());
                }

                {
                    let mut user_tracker = self
                        .user_trackers
                        .entry(target_user.clone())
                        .or_insert_with(UserTracker::new);

                    let window_start =
                        event.timestamp - Duration::seconds(BRUTE_FORCE_WINDOW_SECS * 2);
                    user_tracker.cleanup_old(window_start);
                    user_tracker.add_attempt(attempt);
                }

                if let Some(ip_tracker) = self.ip_trackers.get(&source_ip) {
                    if let Some(brute_event) =
                        self.detect_brute_force(&source_ip, &ip_tracker, event.timestamp)
                    {
                        warn!(
                            "Brute force detected from {}: {}",
                            source_ip, brute_event.title
                        );
                        detections.push(brute_event);
                    }

                    if let Some(stuffing_event) = self.detect_credential_stuffing(
                        &source_ip,
                        &ip_tracker,
                        event.timestamp,
                    ) {
                        warn!(
                            "Credential stuffing detected from {}: {}",
                            source_ip, stuffing_event.title
                        );
                        detections.push(stuffing_event);
                    }
                }
            }

            if let Some(username) = &event.source.user_name {
                if event.action == EventAction::Escalated
                    || event.action == EventAction::Modified
                    || event.action == EventAction::Created
                {
                    if let Some(escalation_event) =
                        self.detect_privilege_escalation(event, username)
                    {
                        warn!(
                            "Privilege escalation detected for {}: {}",
                            username, escalation_event.title
                        );
                        detections.push(escalation_event);
                    }
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

    fn make_auth_event(
        action: EventAction,
        source_ip: &str,
        target_user: &str,
    ) -> SecurityEvent {
        let mut metadata = HashMap::new();
        metadata.insert(
            "source_ip".to_string(),
            serde_json::Value::String(source_ip.to_string()),
        );
        metadata.insert(
            "target_user".to_string(),
            serde_json::Value::String(target_user.to_string()),
        );

        let source = EventSource {
            collector: "test".to_string(),
            host_id: "test-host".to_string(),
            host_name: "test".to_string(),
            agent_id: "test-agent".to_string(),
            process_name: None,
            process_id: None,
            user_id: None,
            user_name: Some(target_user.to_string()),
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
        
            agent_version: None,
            service_name: None,
        };

        let action_label = action_str(&action).to_string();
        let mut event = SecurityEvent::new(
            EventCategory::Authentication,
            action,
            source,
            format!("Auth event: {} by {}", action_label, target_user),
            format!("Authentication event for user {}", target_user),
        );
        event.metadata = metadata;
        event
    }

    fn action_str(action: &EventAction) -> &str {
        match action {
            EventAction::Failed => "failed login",
            EventAction::Escalated => "privilege escalation",
            EventAction::Modified => "modified",
            EventAction::Created => "created",
            _ => "other",
        }
    }

    #[test]
    fn test_engine_creation() {
        let engine = AuthEngine::new();
        assert!(engine.ip_trackers.is_empty());
        assert!(engine.user_trackers.is_empty());
    }

    #[test]
    fn test_brute_force_detection() {
        let mut engine = AuthEngine::new();
        let mut detections_total = Vec::new();

        for i in 0..6 {
            let event = make_auth_event(
                EventAction::Failed,
                "10.0.0.100",
                &format!("user{}", i),
            );
            let d = engine.process_event(&event);
            detections_total.extend(d);
        }

        assert!(detections_total.iter().any(|d| {
            d.severity == Severity::Critical
                && d.mitre_id.as_deref() == Some("T1110")
        }));
    }

    #[test]
    fn test_credential_stuffing_detection() {
        let mut engine = AuthEngine::new();
        let mut detections_total = Vec::new();

        for i in 0..12 {
            let event = make_auth_event(
                EventAction::Failed,
                "10.0.0.200",
                &format!("victim{}", i),
            );
            let d = engine.process_event(&event);
            detections_total.extend(d);
        }

        assert!(detections_total.iter().any(|d| {
            d.tags.contains(&"credential-stuffing".to_string())
        }));
    }
}
