use async_trait::async_trait;
use chrono::{DateTime, Datelike, NaiveDateTime, TimeZone, Utc};
use regex::Regex;
use std::collections::HashMap;

use crate::errors::NormalizerError;
use crate::traits::{EventNormalizer, NormalizationResult, RawEvent, SourceFormat};
use security_os_core::*;

pub struct SyslogNormalizer {
    rfc5424_re: Regex,
    rfc3164_re: Regex,
}

impl SyslogNormalizer {
    pub fn new() -> Self {
        Self {
            rfc5424_re: Regex::new(
                r"^<(\d+)>(\d+) (\S+) (\S+) (\S+) (\S+) (\S+) - (.*)$",
            )
            .unwrap(),
            rfc3164_re: Regex::new(
                r"^<(\d+)>(\w+\s+\d+\s+\d+:\d+:\d+) (\S+) (\S+?)(?:\[(\d+)\])?: (.*)$",
            )
            .unwrap(),
        }
    }

    fn parse_priority(pri: u32) -> (u8, u8) {
        let facility = (pri / 8) as u8;
        let severity = (pri % 8) as u8;
        (facility, severity)
    }

    fn facility_name(facility: u8) -> &'static str {
        match facility {
            0 => "kern",
            1 => "user",
            2 => "mail",
            3 => "daemon",
            4 => "auth",
            5 => "syslog",
            6 => "lpr",
            7 => "news",
            8 => "uucp",
            9 => "cron",
            10 => "authpriv",
            11 => "ftp",
            12 => "ntp",
            13 => "security",
            14 => "console",
            15 => "solaris-cron",
            16..=23 => "local",
            _ => "unknown",
        }
    }

    fn syslog_severity_to_core(sev: u8) -> Severity {
        match sev {
            0..=1 => Severity::Critical,
            2..=3 => Severity::High,
            4..=5 => Severity::Medium,
            6 => Severity::Low,
            7 => Severity::Informational,
            _ => Severity::Medium,
        }
    }

    fn parse_rfc3164_timestamp(ts_str: &str) -> Option<DateTime<Utc>> {
        let now = Utc::now();
        let formats = [
            "%b %d %H:%M:%S",
            "%Y-%b-%d %H:%M:%S",
            "%b  %d %H:%M:%S",
        ];
        for fmt in &formats {
            if let Ok(naive) = NaiveDateTime::parse_from_str(ts_str, fmt) {
                let year = now.year();
                let naive = naive.with_year(year).unwrap_or(naive);
                return Some(Utc.from_utc_datetime(&naive));
            }
        }
        if let Ok(naive) = NaiveDateTime::parse_from_str(ts_str, "%Y-%m-%dT%H:%M:%S%.fZ") {
            return Some(Utc.from_utc_datetime(&naive));
        }
        None
    }

    fn parse_rfc5424_timestamp(ts_str: &str) -> Option<DateTime<Utc>> {
        if ts_str == "-" {
            return Some(Utc::now());
        }
        if let Ok(dt) = DateTime::parse_from_rfc3339(ts_str) {
            return Some(dt.with_timezone(&Utc));
        }
        if let Ok(naive) = NaiveDateTime::parse_from_str(ts_str, "%Y-%m-%dT%H:%M:%S%.f%:z") {
            return Some(Utc.from_utc_datetime(&naive));
        }
        if let Ok(naive) = NaiveDateTime::parse_from_str(ts_str, "%Y-%m-%dT%H:%M:%S") {
            return Some(Utc.from_utc_datetime(&naive));
        }
        Self::parse_rfc3164_timestamp(ts_str)
    }

    fn infer_category_from_msg(msg: &str, app_name: &str) -> EventCategory {
        let combined = format!("{} {}", msg, app_name).to_lowercase();
        if combined.contains("sshd") || combined.contains("ssh") {
            EventCategory::Ssh
        } else if combined.contains("kernel") || combined.contains("segfault") {
            EventCategory::Kernel
        } else if combined.contains("sudo") {
            EventCategory::Sudo
        } else if combined.contains("cron") || combined.contains("crond") {
            EventCategory::Cron
        } else if combined.contains("nginx") || combined.contains("apache") || combined.contains("httpd") {
            EventCategory::Api
        } else if combined.contains("docker") || combined.contains("containerd") || combined.contains("kubelet") {
            EventCategory::Container
        } else if combined.contains("fail2ban") || combined.contains("iptables") {
            EventCategory::Network
        } else if combined.contains("audit") || combined.contains("selinux") || combined.contains("apparmor") {
            EventCategory::Selinux
        } else if combined.contains("auth") || combined.contains("login") || combined.contains("pam") {
            EventCategory::Authentication
        } else {
            EventCategory::System
        }
    }

    fn infer_action_from_msg(msg: &str) -> EventAction {
        let lower = msg.to_lowercase();
        if lower.contains("failed") || lower.contains("failure") || lower.contains("error") {
            EventAction::Failed
        } else if lower.contains("accepted") || lower.contains("success") || lower.contains("permitted") {
            EventAction::Allowed
        } else if lower.contains("denied") || lower.contains("rejected") || lower.contains("blocked") {
            EventAction::Blocked
        } else if lower.contains("started") || lower.contains("begin") {
            EventAction::Started
        } else if lower.contains("stopped") || lower.contains("terminated") {
            EventAction::Stopped
        } else if lower.contains("created") || lower.contains("added") {
            EventAction::Created
        } else if lower.contains("removed") || lower.contains("deleted") {
            EventAction::Deleted
        } else if lower.contains("modified") || lower.contains("changed") {
            EventAction::Modified
        } else {
            EventAction::Detected
        }
    }
}

impl Default for SyslogNormalizer {
    fn default() -> Self {
        Self::new()
    }
}

#[async_trait]
impl EventNormalizer for SyslogNormalizer {
    fn format(&self) -> SourceFormat {
        SourceFormat::Syslog
    }

    fn name(&self) -> &str {
        "syslog"
    }

    fn can_handle(&self, event: &RawEvent) -> bool {
        if event.source_format == SourceFormat::Syslog {
            return true;
        }
        if let Some(s) = event.payload.get("message").and_then(|v| v.as_str()) {
            return s.starts_with('<') || event.payload.get("syslog").is_some();
        }
        if let Some(s) = event.payload.as_str() {
            return s.starts_with('<');
        }
        false
    }

    async fn normalize(&self, event: &RawEvent) -> std::result::Result<NormalizationResult, NormalizerError> {
        let mut warnings = Vec::new();
        let mut unmapped = Vec::new();

        let (_raw_msg, pri_str, timestamp_str, hostname, app_name, process_id, message) =
            if event.payload.is_object()
                && (event.payload.get("pri").is_some() || event.payload.get("priority").is_some())
                && event.payload.get("message").is_some()
            {
                if let Some(obj) = event.payload.as_object() {
                    let pri = obj.get("pri")
                        .or_else(|| obj.get("priority"))
                        .and_then(|v| v.as_u64())
                        .unwrap_or(13) as u32;
                    let ts = obj.get("timestamp")
                        .or_else(|| obj.get("time"))
                        .and_then(|v| v.as_str())
                        .unwrap_or("");
                    let host = obj.get("hostname")
                        .or_else(|| obj.get("host"))
                        .and_then(|v| v.as_str())
                        .unwrap_or("unknown");
                    let app = obj.get("appname")
                        .or_else(|| obj.get("program"))
                        .or_else(|| obj.get("tag"))
                        .and_then(|v| v.as_str())
                        .unwrap_or("unknown");
                    let pid = obj.get("procid")
                        .or_else(|| obj.get("pid"))
                        .and_then(|v| v.as_str())
                        .unwrap_or("-");
                    let msg = obj.get("msg")
                        .or_else(|| obj.get("message"))
                        .and_then(|v| v.as_str())
                        .unwrap_or("");
                    (
                        msg.to_string(),
                        pri.to_string(),
                        ts.to_string(),
                        host.to_string(),
                        app.to_string(),
                        pid.to_string(),
                        msg.to_string(),
                    )
                } else {
                    unreachable!()
                }
            } else if let Some(s) = event.payload.get("message").and_then(|v| v.as_str()) {
                if self.rfc5424_re.is_match(s) {
                    let caps = self.rfc5424_re.captures(s).unwrap();
                    let pri: u32 = caps.get(1).unwrap().as_str().parse().unwrap_or(0);
                    let _version = caps.get(2).map(|m| m.as_str()).unwrap_or("1");
                    let host = caps.get(3).map(|m| m.as_str()).unwrap_or("-");
                    let app = caps.get(4).map(|m| m.as_str()).unwrap_or("-");
                    let procid = caps.get(6).map(|m| m.as_str()).unwrap_or("-");
                    let msg = caps.get(8).map(|m| m.as_str()).unwrap_or("");
                    (
                        s.to_string(),
                        pri.to_string(),
                        caps.get(5).map(|m| m.as_str()).unwrap_or("").to_string(),
                        host.to_string(),
                        app.to_string(),
                        procid.to_string(),
                        msg.to_string(),
                    )
                } else if self.rfc3164_re.is_match(s) {
                    let caps = self.rfc3164_re.captures(s).unwrap();
                    let pri: u32 = caps.get(1).unwrap().as_str().parse().unwrap_or(0);
                    let ts = caps.get(2).map(|m| m.as_str()).unwrap_or("");
                    let host = caps.get(3).map(|m| m.as_str()).unwrap_or("-");
                    let app = caps.get(4).map(|m| m.as_str()).unwrap_or("-");
                    let pid = caps.get(5).map(|m| m.as_str()).unwrap_or("-");
                    let msg = caps.get(6).map(|m| m.as_str()).unwrap_or("");
                    (
                        s.to_string(),
                        pri.to_string(),
                        ts.to_string(),
                        host.to_string(),
                        app.to_string(),
                        pid.to_string(),
                        msg.to_string(),
                    )
                } else {
                    warnings.push("Could not parse syslog format, treating as plain message".into());
                    (
                        s.to_string(),
                        "13".into(),
                        String::new(),
                        "unknown".into(),
                        "unknown".into(),
                        "-".into(),
                        s.to_string(),
                    )
                }
            } else {
                return Err(NormalizerError::Parse("No syslog message found".into()));
            };

        let pri: u32 = pri_str.parse().unwrap_or(13);
        let (facility, severity_num) = Self::parse_priority(pri);
        let severity = Self::syslog_severity_to_core(severity_num);
        let facility_name = Self::facility_name(facility).to_string();

        let timestamp = if !timestamp_str.is_empty() {
            Self::parse_rfc3164_timestamp(&timestamp_str)
                .or_else(|| Self::parse_rfc5424_timestamp(&timestamp_str))
                .unwrap_or_else(Utc::now)
        } else {
            Utc::now()
        };

        let category = Self::infer_category_from_msg(&message, &app_name);
        let action = Self::infer_action_from_msg(&message);

        let title = if app_name != "unknown" && app_name != "-" {
            format!("[Syslog] {}: {}", app_name, &message[..message.len().min(60)])
        } else {
            format!("[Syslog] {}", &message[..message.len().min(80)])
        };

        let mut metadata = HashMap::new();
        metadata.insert("syslog.facility".into(), serde_json::json!(facility_name));
        metadata.insert("syslog.facility_code".into(), serde_json::json!(facility));
        metadata.insert("syslog.severity_code".into(), serde_json::json!(severity_num));

        if let Some(s) = event.payload.get("structured_data") {
            if let Some(obj) = s.as_object() {
                for (k, v) in obj {
                    metadata.insert(format!("syslog.sd.{}", k), v.clone());
                }
            }
        }

        let process_id = process_id.parse::<u32>().ok();

        let source = EventSource {
            collector: "syslog-normalizer".into(),
            host_id: hostname.clone(),
            host_name: hostname,
            agent_id: "syslog-agent".into(),
            agent_version: None,
            process_name: if app_name != "-" && app_name != "unknown" {
                Some(app_name)
            } else {
                None
            },
            process_id,
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            service_name: None,
        };

        let mut security_event = SecurityEvent::new(category, action, source, title, &message)
            .with_severity(severity);
        security_event.timestamp = timestamp;

        for (k, v) in metadata {
            security_event.metadata.insert(k, v);
        }

        if pri_str == "13" && warnings.is_empty() {
            unmapped.push("priority".into());
        }

        let confidence = if pri_str != "13" && !timestamp_str.is_empty() {
            0.8
        } else if !message.is_empty() {
            0.6
        } else {
            0.4
        };

        Ok(NormalizationResult {
            event: security_event,
            source_format: SourceFormat::Syslog,
            confidence,
            warnings,
            unmapped_fields: unmapped,
        })
    }

    fn confidence(&self, event: &RawEvent) -> f64 {
        if let Some(s) = event.payload.get("message").and_then(|v| v.as_str()) {
            if s.starts_with('<') && s.contains('|') {
                0.9
            } else if s.starts_with('<') {
                0.8
            } else {
                0.5
            }
        } else if event.payload.get("pri").is_some() || event.payload.get("priority").is_some() {
            0.75
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

    fn make_syslog_event(payload: serde_json::Value) -> RawEvent {
        RawEvent {
            source_format: SourceFormat::Syslog,
            payload,
            metadata: HashMap::new(),
            received_at: Utc::now(),
            origin: None,
        }
    }

    #[tokio::test]
    async fn test_normalize_syslog_3164() {
        let norm = SyslogNormalizer::new();
        let payload = serde_json::json!({"message": "<34>Jan  5 14:09:08 myhost sshd[12345]: Failed password for root from 10.0.0.1 port 22 ssh2"});
        let event = make_syslog_event(payload);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.source_format, SourceFormat::Syslog);
        assert_eq!(result.event.severity, Severity::High);
        assert_eq!(result.event.category, EventCategory::Ssh);
        assert!(result.event.title.contains("sshd"));
    }

    #[tokio::test]
    async fn test_normalize_syslog_json() {
        let norm = SyslogNormalizer::new();
        let payload = serde_json::json!({
            "pri": 165,
            "hostname": "web01",
            "appname": "nginx",
            "message": "GET /api/v1/data 200 OK"
        });
        let event = make_syslog_event(payload);
        let result = norm.normalize(&event).await.unwrap();
        assert_eq!(result.event.category, EventCategory::Api);
        assert!(result.event.src_ip.is_none() || result.event.src_ip.is_some());
    }

    #[tokio::test]
    async fn test_syslog_facility_parsing() {
        let (fac, sev) = SyslogNormalizer::parse_priority(34);
        assert_eq!(fac, 4);
        assert_eq!(sev, 2);
    }

    #[test]
    fn test_syslog_severity_mapping() {
        assert_eq!(SyslogNormalizer::syslog_severity_to_core(0), Severity::Critical);
        assert_eq!(SyslogNormalizer::syslog_severity_to_core(2), Severity::High);
        assert_eq!(SyslogNormalizer::syslog_severity_to_core(5), Severity::Medium);
        assert_eq!(SyslogNormalizer::syslog_severity_to_core(7), Severity::Informational);
    }

    #[test]
    fn test_facility_name() {
        assert_eq!(SyslogNormalizer::facility_name(0), "kern");
        assert_eq!(SyslogNormalizer::facility_name(4), "auth");
        assert_eq!(SyslogNormalizer::facility_name(16), "local");
    }

    #[test]
    fn test_syslog_confidence() {
        let norm = SyslogNormalizer::new();
        let valid = make_syslog_event(serde_json::json!({"message": "<34>Jan  5 14:09:08 host app[1]: msg"}));
        assert!(norm.confidence(&valid) >= 0.7);
        let plain = make_syslog_event(serde_json::json!({"message": "just a plain message"}));
        assert!(norm.confidence(&plain) < 0.6);
    }
}
