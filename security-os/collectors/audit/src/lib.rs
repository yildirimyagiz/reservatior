use std::fs::File;
use std::io::{Read, Seek, SeekFrom};
use std::path::PathBuf;
use std::time::Duration;

use security_os_core::{EventAction, EventCategory, EventSource, SecurityEvent, Severity};
use tracing::{debug, info, warn};

const SENSITIVE_PATHS: &[&str] = &[
    "/etc/shadow",
    "/etc/passwd",
    "/etc/sudoers",
    "/etc/ssh/sshd_config",
    "/root/.ssh",
    "/home",
    "/etc/pam.d",
    "/var/log/auth.log",
];

const PRIVILEGE_BINARIES: &[&str] = &["/usr/bin/su", "/usr/bin/sudo", "/usr/bin/passwd"];

pub struct AuditCollector {
    log_path: PathBuf,
    last_position: u64,
    host_id: String,
    host_name: String,
    agent_id: String,
}

#[derive(Debug, Default)]
struct AuditRecord {
    syscall: Option<String>,
    exe: Option<String>,
    uid: Option<String>,
    auid: Option<String>,
    success: Option<String>,
    exit: Option<String>,
    comm: Option<String>,
    key: Option<String>,
    path: Option<String>,
    record_type: Option<String>,
}

impl AuditCollector {
    pub fn new(log_path: PathBuf) -> Self {
        let hostname = hostname::get()
            .map(|h| h.to_string_lossy().into_owned())
            .unwrap_or_else(|_| "unknown".into());

        let last_position = std::fs::metadata(&log_path)
            .map(|m| m.len())
            .unwrap_or(0);

        info!(
            log_path = %log_path.display(),
            initial_position = last_position,
            "Audit collector initialized"
        );

        Self {
            log_path,
            last_position,
            host_id: hostname.clone(),
            host_name: hostname,
            agent_id: "audit-collector-0".into(),
        }
    }

    fn make_source(&self) -> EventSource {
        EventSource {
            collector: "audit".into(),
            host_id: self.host_id.clone(),
            host_name: self.host_name.clone(),
            agent_id: self.agent_id.clone(),
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
        }
    }

    fn parse_line(line: &str) -> Option<SecurityEvent> {
        let trimmed = line.trim();
        if trimmed.is_empty() {
            return None;
        }

        let mut record = AuditRecord::default();

        // Extract record type from the line (e.g., type=SYSCALL, type=EXECVE)
        if let Some(type_start) = trimmed.find("type=") {
            let rest = &trimmed[type_start + 5..];
            if let Some(type_end) = rest.find(' ') {
                record.record_type = Some(rest[..type_end].to_string());
            } else {
                record.record_type = Some(rest.to_string());
            }
        }

        // Parse key=value pairs by splitting on spaces and handling quoted values
        for token in trimmed.split_whitespace() {
            if let Some(eq_pos) = token.find('=') {
                let key = &token[..eq_pos];
                let value_part = &token[eq_pos + 1..];

                let value = if value_part.starts_with('"') && value_part.ends_with('"') && value_part.len() >= 2 {
                    &value_part[1..value_part.len() - 1]
                } else {
                    value_part
                };

                Self::assign_field(&mut record, key, value);
            }
        }

        Self::build_event(record)
    }

    fn assign_field(record: &mut AuditRecord, key: &str, value: &str) {
        match key {
            "syscall" => record.syscall = Some(value.to_string()),
            "exe" => record.exe = Some(value.to_string()),
            "uid" => record.uid = Some(value.to_string()),
            "auid" => record.auid = Some(value.to_string()),
            "success" => record.success = Some(value.to_string()),
            "exit" => record.exit = Some(value.to_string()),
            "comm" => record.comm = Some(value.to_string()),
            "key" => record.key = Some(value.to_string()),
            "path" => record.path = Some(value.to_string()),
            _ => {}
        }
    }

    fn build_event(record: AuditRecord) -> Option<SecurityEvent> {
        let record_type = record.record_type.as_deref().unwrap_or("");
        let success = record.success.as_deref().unwrap_or("yes");
        let exe = record.exe.as_deref().unwrap_or("");
        let syscall = record.syscall.as_deref().unwrap_or("");
        let uid = record.uid.as_deref().unwrap_or("0");
        let auid = record.auid.as_deref().unwrap_or("");
        let comm = record.comm.as_deref().unwrap_or("");
        let key = record.key.as_deref().unwrap_or("");
        let path = record.path.as_deref().unwrap_or("");

        match record_type {
            "SYSCALL" => Self::build_syscall_event(success, exe, syscall, uid, auid, comm, key),
            "EXECVE" => Self::build_execve_event(exe, comm, uid, auid),
            "PATH" => Self::build_path_event(path, exe, uid, auid),
            "USER_AUTH" | "USER_ACCT" | "USER_LOGIN" => {
                Self::build_auth_event(record_type, success, exe, uid, auid, comm)
            }
            _ => None,
        }
    }

    fn build_syscall_event(
        success: &str,
        exe: &str,
        syscall: &str,
        uid: &str,
        auid: &str,
        comm: &str,
        key: &str,
    ) -> Option<SecurityEvent> {
        let source = EventSource {
            collector: "audit".into(),
            host_id: "unknown".into(),
            host_name: "unknown".into(),
            agent_id: "audit-collector-0".into(),
            process_name: Some(comm.to_string()),
            process_id: None,
            user_id: Some(uid.to_string()),
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            agent_version: None,
            service_name: None,
        };

        // Failed syscall - High severity
        if success == "no" {
            let mut event = SecurityEvent::new(
                EventCategory::Authentication,
                EventAction::Failed,
                source,
                format!("Failed syscall: {} by {}", syscall, comm),
                format!(
                    "Syscall '{}' failed for exe='{}', uid={}, comm='{}', key='{}'",
                    syscall, exe, uid, comm, key
                ),
            )
            .with_severity(Severity::High)
            .with_risk_score(75.0)
            .with_tag("audit")
            .with_tag("syscall-failure")
            .with_tag("failed");

            event.metadata.insert(
                "syscall".into(),
                serde_json::Value::String(syscall.to_string()),
            );
            event.metadata.insert(
                "exe".into(),
                serde_json::Value::String(exe.to_string()),
            );
            event.metadata.insert(
                "uid".into(),
                serde_json::Value::String(uid.to_string()),
            );
            event.metadata.insert(
                "auid".into(),
                serde_json::Value::String(auid.to_string()),
            );
            event.metadata.insert(
                "comm".into(),
                serde_json::Value::String(comm.to_string()),
            );
            event.metadata.insert(
                "key".into(),
                serde_json::Value::String(key.to_string()),
            );

            return Some(event);
        }

        // Log tampering detection - check for syscalls that modify audit logs
        if (syscall == "truncate" || syscall == "unlink" || syscall == "rename")
            && exe.contains("audit")
        {
            let mut event = SecurityEvent::new(
                EventCategory::Authentication,
                EventAction::Modified,
                source,
                format!("Potential log tampering: {} on {}", syscall, exe),
                format!(
                    "Audit log manipulation detected: syscall='{}', exe='{}', uid={}, comm='{}'",
                    syscall, exe, uid, comm
                ),
            )
            .with_severity(Severity::High)
            .with_mitre(
                "Defense Evasion",
                "Indicator Removal: Timestomp",
                "T1070",
            )
            .with_risk_score(90.0)
            .with_tag("audit")
            .with_tag("log-tampering")
            .with_tag("defense-evasion");

            event.metadata.insert(
                "syscall".into(),
                serde_json::Value::String(syscall.to_string()),
            );
            event.metadata.insert(
                "exe".into(),
                serde_json::Value::String(exe.to_string()),
            );

            return Some(event);
        }

        None
    }

    fn build_execve_event(
        exe: &str,
        comm: &str,
        uid: &str,
        auid: &str,
    ) -> Option<SecurityEvent> {
        let exe_lower = exe.to_lowercase();
        let is_privilege_bin = PRIVILEGE_BINARIES.iter().any(|p| exe_lower.contains(p));

        if is_privilege_bin {
            let severity = if uid == "0" {
                Severity::Medium
            } else {
                Severity::High
            };

            let mut event = SecurityEvent::new(
                EventCategory::Authentication,
                EventAction::Escalated,
                EventSource {
                    collector: "audit".into(),
                    host_id: "unknown".into(),
                    host_name: "unknown".into(),
                    agent_id: "audit-collector-0".into(),
                    process_name: Some(comm.to_string()),
                    process_id: None,
                    user_id: Some(uid.to_string()),
                    user_name: None,
                    container_id: None,
                    container_name: None,
                    pod_name: None,
                    namespace: None,
                    agent_version: None,
                    service_name: None,
                },
                format!("Privilege escalation: {} executed", exe),
                format!(
                    "Binary '{}' executed by uid={}, auid={}, comm='{}'",
                    exe, uid, auid, comm
                ),
            )
            .with_severity(severity)
            .with_mitre(
                "Privilege Escalation",
                "Abuse Elevation Control Mechanism",
                "T1548",
            )
            .with_risk_score(if severity == Severity::High { 85.0 } else { 50.0 })
            .with_tag("audit")
            .with_tag("privilege-escalation")
            .with_tag("T1548");

            event.metadata.insert(
                "exe".into(),
                serde_json::Value::String(exe.to_string()),
            );
            event.metadata.insert(
                "uid".into(),
                serde_json::Value::String(uid.to_string()),
            );
            event.metadata.insert(
                "auid".into(),
                serde_json::Value::String(auid.to_string()),
            );
            event.metadata.insert(
                "comm".into(),
                serde_json::Value::String(comm.to_string()),
            );
            event.metadata.insert(
                "action_type".into(),
                serde_json::Value::String("privilege-escalation".into()),
            );

            return Some(event);
        }

        None
    }

    fn build_path_event(path: &str, exe: &str, uid: &str, auid: &str) -> Option<SecurityEvent> {
        let path_lower = path.to_lowercase();
        let is_sensitive = SENSITIVE_PATHS.iter().any(|sp| path_lower.contains(sp));

        if is_sensitive {
            let mut event = SecurityEvent::new(
                EventCategory::Filesystem,
                EventAction::Executed,
                EventSource {
                    collector: "audit".into(),
                    host_id: "unknown".into(),
                    host_name: "unknown".into(),
                    agent_id: "audit-collector-0".into(),
                    process_name: None,
                    process_id: None,
                    user_id: Some(uid.to_string()),
                    user_name: None,
                    container_id: None,
                    container_name: None,
                    pod_name: None,
                    namespace: None,
                    agent_version: None,
                    service_name: None,
                },
                format!("Sensitive file access: {}", path),
                format!(
                    "Access to sensitive path '{}' by exe='{}', uid={}, auid='{}'",
                    path, exe, uid, auid
                ),
            )
            .with_severity(Severity::High)
            .with_risk_score(80.0)
            .with_tag("audit")
            .with_tag("sensitive-file-access");

            event.metadata.insert(
                "path".into(),
                serde_json::Value::String(path.to_string()),
            );
            event.metadata.insert(
                "exe".into(),
                serde_json::Value::String(exe.to_string()),
            );
            event.metadata.insert(
                "uid".into(),
                serde_json::Value::String(uid.to_string()),
            );
            event.metadata.insert(
                "auid".into(),
                serde_json::Value::String(auid.to_string()),
            );

            return Some(event);
        }

        None
    }

    fn build_auth_event(
        record_type: &str,
        success: &str,
        exe: &str,
        uid: &str,
        auid: &str,
        comm: &str,
    ) -> Option<SecurityEvent> {
        let action = if success == "yes" {
            EventAction::Executed
        } else {
            EventAction::Failed
        };

        let severity = if success == "no" {
            Severity::Medium
        } else {
            Severity::Informational
        };

        let title = format!(
            "Auth event: {} (success={})",
            record_type, success
        );
        let description = format!(
            "Authentication event type='{}', exe='{}', uid={}, auid={}, comm='{}'",
            record_type, exe, uid, auid, comm
        );

        let mut event = SecurityEvent::new(
            EventCategory::Authentication,
            action,
            EventSource {
                collector: "audit".into(),
                host_id: "unknown".into(),
                host_name: "unknown".into(),
                agent_id: "audit-collector-0".into(),
                process_name: Some(comm.to_string()),
                process_id: None,
                user_id: Some(uid.to_string()),
                user_name: None,
                container_id: None,
                container_name: None,
                pod_name: None,
                namespace: None,
                agent_version: None,
                service_name: None,
            },
            title,
            description,
        )
        .with_severity(severity)
        .with_risk_score(severity.risk_weight() * 60.0)
        .with_tag("audit")
        .with_tag("authentication");

        event.metadata.insert(
            "record_type".into(),
            serde_json::Value::String(record_type.to_string()),
        );
        event.metadata.insert(
            "success".into(),
            serde_json::Value::String(success.to_string()),
        );
        event.metadata.insert(
            "exe".into(),
            serde_json::Value::String(exe.to_string()),
        );
        event.metadata.insert(
            "uid".into(),
            serde_json::Value::String(uid.to_string()),
        );
        event.metadata.insert(
            "auid".into(),
            serde_json::Value::String(auid.to_string()),
        );

        Some(event)
    }

    pub fn scan(&mut self) -> Vec<SecurityEvent> {
        let mut events = Vec::new();

        let mut file = match File::open(&self.log_path) {
            Ok(f) => f,
            Err(e) => {
                warn!(
                    log_path = %self.log_path.display(),
                    error = %e,
                    "Failed to open audit log"
                );
                return events;
            }
        };

        // Seek to last position
        if let Err(e) = file.seek(SeekFrom::Start(self.last_position)) {
            warn!(error = %e, "Failed to seek audit log");
            return events;
        }

        let mut buffer = String::new();
        if let Err(e) = file.read_to_string(&mut buffer) {
            warn!(error = %e, "Failed to read audit log");
            return events;
        }

        // Update position for next read (current position = last_position + bytes read)
        self.last_position = self.last_position + buffer.len() as u64;

        // Handle log rotation: if new data is smaller than expected, reset position
        if let Ok(metadata) = std::fs::metadata(&self.log_path) {
            if metadata.len() < self.last_position {
                warn!("Audit log appears to have been rotated, resetting position");
                self.last_position = 0;

                // Re-read from start
                let mut file = match File::open(&self.log_path) {
                    Ok(f) => f,
                    Err(_) => return events,
                };
                buffer.clear();
                if file.read_to_string(&mut buffer).is_err() {
                    return events;
                }
                self.last_position = buffer.len() as u64;
            }
        }

        for line in buffer.lines() {
            if let Some(event) = Self::parse_line(line) {
                debug!(
                    event_id = %event.id,
                    title = %event.title,
                    severity = %event.severity,
                    "Audit event parsed"
                );
                events.push(event);
            }
        }

        debug!(events_generated = events.len(), new_position = self.last_position, "Audit scan completed");
        events
    }

    pub async fn run(mut self, bus: security_os_core::EventBus, interval: Duration) {
        info!(
            log_path = %self.log_path.display(),
            interval_ms = interval.as_millis() as u64,
            "Audit collector starting"
        );

        loop {
            let events = self.scan();
            for event in events {
                debug!(
                    event_id = %event.id,
                    title = %event.title,
                    severity = %event.severity,
                    "Publishing audit event"
                );
                bus.publish(event);
            }
            tokio::time::sleep(interval).await;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_syscall_line() {
        let line = "type=SYSCALL msg=audit(1234567890.123:456): arch=c000003e syscall=59 success=no pkey=0 exe=\"/usr/bin/bash\" uid=1000 auid=1000 comm=\"test\" key=\"exec\"";
        let event = AuditCollector::parse_line(line).expect("Should parse syscall line");
        assert_eq!(event.category, EventCategory::Authentication);
        assert!(event.tags.contains(&"audit".to_string()));
        assert!(event.tags.contains(&"syscall-failure".to_string()));
        assert_eq!(event.severity, Severity::High);
    }

    #[test]
    fn test_parse_execve_privilege() {
        let line = "type=EXECVE msg=audit(1234567890.123:456): argc=1 a0=\"sudo\" exe=\"/usr/bin/sudo\" uid=1000 auid=1000 comm=\"test\"";
        let event = AuditCollector::parse_line(line).expect("Should parse execve line");
        assert_eq!(event.category, EventCategory::Authentication);
        assert!(event.tags.contains(&"privilege-escalation".to_string()));
    }

    #[test]
    fn test_parse_empty_line() {
        assert!(AuditCollector::parse_line("").is_none());
        assert!(AuditCollector::parse_line("   ").is_none());
    }
}
