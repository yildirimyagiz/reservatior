use std::collections::HashMap;
use chrono::{DateTime, Timelike, Utc};
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::{debug, warn};

const LARGE_TRANSFER_THRESHOLD: u64 = 10 * 1024 * 1024; // 10MB
const TIME_WINDOW_SECS: i64 = 300; // 5 minutes
const DNS_EXFIL_QUERY_THRESHOLD: usize = 100;
const DNS_EXFIL_LONG_SUBDOMAIN_LEN: usize = 50;
const CLOUD_UPLOAD_SPIKE_THRESHOLD: u64 = 50 * 1024 * 1024; // 50MB

#[derive(Debug, Clone)]
struct TransferRecord {
    bytes: u64,
    timestamp: DateTime<Utc>,
}

#[derive(Debug, Clone)]
struct DnsQueryRecord {
    subdomain_length: usize,
    timestamp: DateTime<Utc>,
}

#[derive(Debug, Clone)]
struct CloudUploadRecord {
    bytes: u64,
    timestamp: DateTime<Utc>,
}

pub struct DataExfiltrationEngine {
    per_ip_outbound_bytes: DashMap<String, Vec<TransferRecord>>,
    per_user_outbound_bytes: DashMap<String, Vec<TransferRecord>>,
    per_ip_dns_queries: DashMap<String, Vec<DnsQueryRecord>>,
    per_user_cloud_uploads: DashMap<String, Vec<CloudUploadRecord>>,
    per_ip_http_uploads: DashMap<String, Vec<TransferRecord>>,
}

impl DataExfiltrationEngine {
    pub fn new() -> Self {
        Self {
            per_ip_outbound_bytes: DashMap::new(),
            per_user_outbound_bytes: DashMap::new(),
            per_ip_dns_queries: DashMap::new(),
            per_user_cloud_uploads: DashMap::new(),
            per_ip_http_uploads: DashMap::new(),
        }
    }

    fn evict_old_records<T>(records: &mut Vec<T>, cutoff: DateTime<Utc>)
    where
        T: HasTimestamp,
    {
        records.retain(|r| r.timestamp() > cutoff);
    }

    fn detect_large_transfer(
        &self,
        dst_ip: &str,
        bytes: u64,
        user: Option<&str>,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        if bytes < LARGE_TRANSFER_THRESHOLD {
            return None;
        }

        let cutoff = Utc::now() - chrono::Duration::seconds(TIME_WINDOW_SECS);
        let total_in_window = self
            .per_ip_outbound_bytes
            .entry(dst_ip.to_string())
            .or_default()
            .iter()
            .filter(|r| r.timestamp > cutoff)
            .map(|r| r.bytes)
            .sum::<u64>()
            + bytes;

        if total_in_window <= LARGE_TRANSFER_THRESHOLD {
            return None;
        }

        let severity = if total_in_window > LARGE_TRANSFER_THRESHOLD * 10 {
            Severity::Critical
        } else if total_in_window > LARGE_TRANSFER_THRESHOLD * 5 {
            Severity::High
        } else {
            Severity::Medium
        };

        let mut event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Detected,
            source.clone(),
            format!(
                "Large outbound data transfer detected: {} bytes to {}",
                total_in_window, dst_ip
            ),
            format!(
                "User transferred {} bytes to IP {} within 5-minute window, exceeding {} byte threshold.",
                total_in_window, dst_ip, LARGE_TRANSFER_THRESHOLD
            ),
        )
        .with_severity(severity)
        .with_confidence(0.85)
        .with_risk_score(75.0)
        .with_mitre(
            "Exfiltration",
            "Exfiltration Over C2 Channel",
            "T1041",
        )
        .with_tag("data_exfiltration")
        .with_network(
            source.process_id.map(|p| p.to_string()).as_deref().unwrap_or("0"),
            dst_ip,
            0,
            0,
        );

        event.affected_entities.push(Entity {
            entity_type: EntityType::Ip,
            value: dst_ip.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        if let Some(u) = user {
            event.affected_entities.push(Entity {
                entity_type: EntityType::User,
                value: u.to_string(),
                risk_contribution: 30.0,
            metadata: HashMap::new(),
            });
        }

        Some(event)
    }

    fn detect_dns_exfiltration(
        &self,
        src_ip: &str,
        subdomain: &str,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        if subdomain.len() < DNS_EXFIL_LONG_SUBDOMAIN_LEN {
            return None;
        }

        let cutoff = Utc::now() - chrono::Duration::seconds(TIME_WINDOW_SECS);

        {
            let mut queries = self
                .per_ip_dns_queries
                .entry(src_ip.to_string())
                .or_default();
            Self::evict_old_records(&mut queries, cutoff);
            queries.push(DnsQueryRecord {
                subdomain_length: subdomain.len(),
                timestamp: Utc::now(),
            });
        }

        let query_count = {
            let queries = self.per_ip_dns_queries.get(src_ip)?;
            queries
                .iter()
                .filter(|r| r.timestamp > cutoff)
                .count()
        };

        if query_count < DNS_EXFIL_QUERY_THRESHOLD {
            return None;
        }

        let mut event = SecurityEvent::new(
            EventCategory::Dns,
            EventAction::Detected,
            source.clone(),
            format!(
                "DNS exfiltration detected from {}: {} queries with long subdomains",
                src_ip, query_count
            ),
            format!(
                "IP {} made {} DNS queries with subdomains longer than {} characters within 5 minutes, \
                 indicating possible DNS-based data exfiltration.",
                src_ip, query_count, DNS_EXFIL_LONG_SUBDOMAIN_LEN
            ),
        )
        .with_severity(Severity::High)
        .with_confidence(0.80)
        .with_risk_score(82.0)
        .with_mitre(
            "Exfiltration",
            "Exfiltration Over Alternative Protocol",
            "T1048",
        )
        .with_tag("dns_exfiltration");

        event.affected_entities.push(Entity {
            entity_type: EntityType::Ip,
            value: src_ip.to_string(),
            risk_contribution: 50.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    fn detect_http_upload_anomaly(
        &self,
        dst_ip: &str,
        bytes: u64,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        if bytes < LARGE_TRANSFER_THRESHOLD {
            return None;
        }

        let cutoff = Utc::now() - chrono::Duration::seconds(TIME_WINDOW_SECS);
        {
            let mut uploads = self
                .per_ip_http_uploads
                .entry(dst_ip.to_string())
                .or_default();
            Self::evict_old_records(&mut uploads, cutoff);
            uploads.push(TransferRecord {
                bytes,
                timestamp: Utc::now(),
            });
        }

        let total_upload_bytes: u64 = {
            let uploads = self.per_ip_http_uploads.get(dst_ip)?;
            uploads
                .iter()
                .filter(|r| r.timestamp > cutoff)
                .map(|r| r.bytes)
                .sum()
        };

        if total_upload_bytes < LARGE_TRANSFER_THRESHOLD * 3 {
            return None;
        }

        let mut event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Detected,
            source.clone(),
            format!(
                "HTTP upload anomaly: {} bytes uploaded to {}",
                total_upload_bytes, dst_ip
            ),
            format!(
                "Abnormal HTTP upload volume of {} bytes to {} detected within 5 minutes.",
                total_upload_bytes, dst_ip
            ),
        )
        .with_severity(Severity::Medium)
        .with_confidence(0.75)
        .with_risk_score(65.0)
        .with_mitre(
            "Exfiltration",
            "Exfiltration Over Web Service",
            "T1567",
        )
        .with_tag("http_upload_anomaly");

        event.affected_entities.push(Entity {
            entity_type: EntityType::Ip,
            value: dst_ip.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    fn detect_cloud_upload_spike(
        &self,
        user: &str,
        bytes: u64,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        let cutoff = Utc::now() - chrono::Duration::seconds(TIME_WINDOW_SECS);
        {
            let mut uploads = self
                .per_user_cloud_uploads
                .entry(user.to_string())
                .or_default();
            Self::evict_old_records(&mut uploads, cutoff);
            uploads.push(CloudUploadRecord {
                bytes,
                timestamp: Utc::now(),
            });
        }

        let total_bytes: u64 = {
            let uploads = self.per_user_cloud_uploads.get(user)?;
            uploads
                .iter()
                .filter(|r| r.timestamp > cutoff)
                .map(|r| r.bytes)
                .sum()
        };

        if total_bytes < CLOUD_UPLOAD_SPIKE_THRESHOLD {
            return None;
        }

        let severity = if total_bytes > CLOUD_UPLOAD_SPIKE_THRESHOLD * 5 {
            Severity::Critical
        } else {
            Severity::High
        };

        let mut event = SecurityEvent::new(
            EventCategory::Cloud,
            EventAction::Detected,
            source.clone(),
            format!(
                "Cloud storage upload spike by user {}: {} bytes",
                user, total_bytes
            ),
            format!(
                "User {} uploaded {} bytes to cloud storage within 5 minutes, exceeding {} byte threshold.",
                user, total_bytes, CLOUD_UPLOAD_SPIKE_THRESHOLD
            ),
        )
        .with_severity(severity)
        .with_confidence(0.80)
        .with_risk_score(78.0)
        .with_mitre(
            "Exfiltration",
            "Exfiltration Over Web Service",
            "T1567",
        )
        .with_tag("cloud_upload_spike");

        event.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: user.to_string(),
            risk_contribution: 50.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        let dst_ip = event.dst_ip.clone();
        let src_ip = event.src_ip.clone();
        let user = event.username.clone();
        let file_size = event.file_size.unwrap_or(0);
        let now = Utc::now();
        let cutoff = now - chrono::Duration::seconds(TIME_WINDOW_SECS);

        // Large outbound transfer detection
        if event.category == EventCategory::Network
            && (event.action == EventAction::Connected || event.action == EventAction::Sent)
        {
            if let Some(ref ip) = dst_ip {
                if file_size > 0 {
                    // Record per-IP
                    self.per_ip_outbound_bytes
                        .entry(ip.clone())
                        .or_default()
                        .push(TransferRecord {
                            bytes: file_size,
                            timestamp: event.timestamp,
                        });

                    // Record per-user
                    if let Some(ref u) = user {
                        self.per_user_outbound_bytes
                            .entry(u.clone())
                            .or_default()
                            .push(TransferRecord {
                                bytes: file_size,
                                timestamp: event.timestamp,
                            });
                    }

                    // Evict old
                    if let Some(mut records) = self.per_ip_outbound_bytes.get_mut(ip) {
                        Self::evict_old_records(&mut records, cutoff);
                    }

                    if let Some(det) = self.detect_large_transfer(
                        ip,
                        file_size,
                        user.as_deref(),
                        &event.source,
                    ) {
                        warn!("Large transfer detected: {}", det.title);
                        detections.push(det);
                    }
                }
            }
        }

        // DNS exfiltration
        if event.category == EventCategory::Dns && event.action == EventAction::Sent {
            if let Some(ref sip) = src_ip {
                if let Some(subdomain) = event
                    .metadata
                    .get("query_name")
                    .and_then(|v| v.as_str())
                {
                    if let Some(det) =
                        self.detect_dns_exfiltration(sip, subdomain, &event.source)
                    {
                        warn!("DNS exfiltration detected: {}", det.title);
                        detections.push(det);
                    }
                }
            }
        }

        // HTTP upload anomaly
        if event.category == EventCategory::Network
            && event.action == EventAction::Sent
            && event
                .metadata
                .get("http_method")
                .and_then(|v| v.as_str())
                .map(|m| m.eq_ignore_ascii_case("POST") || m.eq_ignore_ascii_case("PUT"))
                .unwrap_or(false)
        {
            if let Some(ref ip) = dst_ip {
                if file_size > 0 {
                    if let Some(det) =
                        self.detect_http_upload_anomaly(ip, file_size, &event.source)
                    {
                        warn!("HTTP upload anomaly: {}", det.title);
                        detections.push(det);
                    }
                }
            }
        }

        // Cloud upload spike
        if event.category == EventCategory::Cloud
            && (event.action == EventAction::Created || event.action == EventAction::Sent)
        {
            if let Some(ref u) = user {
                if file_size > 0 {
                    if let Some(det) =
                        self.detect_cloud_upload_spike(u, file_size, &event.source)
                    {
                        warn!("Cloud upload spike: {}", det.title);
                        detections.push(det);
                    }
                }
            }
        }

        detections
    }
}

trait HasTimestamp {
    fn timestamp(&self) -> DateTime<Utc>;
}

impl HasTimestamp for TransferRecord {
    fn timestamp(&self) -> DateTime<Utc> {
        self.timestamp
    }
}

impl HasTimestamp for DnsQueryRecord {
    fn timestamp(&self) -> DateTime<Utc> {
        self.timestamp
    }
}

impl HasTimestamp for CloudUploadRecord {
    fn timestamp(&self) -> DateTime<Utc> {
        self.timestamp
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

    fn make_network_event(dst_ip: &str, bytes: u64, user: Option<&str>) -> SecurityEvent {
        let source = make_source();
        let mut event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Sent,
            source,
            "Outbound data transfer".to_string(),
            format!("Transfer of {} bytes to {}", bytes, dst_ip),
        );
        event.file_size = Some(bytes);
        event.dst_ip = Some(dst_ip.to_string());
        if let Some(u) = user {
            event.username = Some(u.to_string());
        }
        event
    }

    fn make_dns_event(src_ip: &str, subdomain: &str) -> SecurityEvent {
        let source = make_source();
        let mut event = SecurityEvent::new(
            EventCategory::Dns,
            EventAction::Sent,
            source,
            "DNS query".to_string(),
            format!("DNS query for {}", subdomain),
        );
        event.src_ip = Some(src_ip.to_string());
        event.metadata.insert(
            "query_name".to_string(),
            serde_json::Value::String(subdomain.to_string()),
        );
        event
    }

    fn make_cloud_upload_event(user: &str, bytes: u64) -> SecurityEvent {
        let source = make_source();
        let mut event = SecurityEvent::new(
            EventCategory::Cloud,
            EventAction::Created,
            source,
            "Cloud upload".to_string(),
            format!("User {} uploaded {} bytes", user, bytes),
        );
        event.file_size = Some(bytes);
        event.username = Some(user.to_string());
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = DataExfiltrationEngine::new();
        assert!(engine.per_ip_outbound_bytes.is_empty());
        assert!(engine.per_user_outbound_bytes.is_empty());
        assert!(engine.per_ip_dns_queries.is_empty());
    }

    #[test]
    fn test_large_transfer_detected() {
        let mut engine = DataExfiltrationEngine::new();
        let event = make_network_event("10.0.0.99", 20 * 1024 * 1024, Some("alice"));
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert_eq!(detections[0].severity, Severity::Medium);
        assert!(detections[0].mitre_id.as_deref() == Some("T1041"));
    }

    #[test]
    fn test_small_transfer_ignored() {
        let mut engine = DataExfiltrationEngine::new();
        let event = make_network_event("10.0.0.99", 1024, Some("alice"));
        let detections = engine.process_event(&event);
        assert!(detections.is_empty());
    }

    #[test]
    fn test_dns_exfiltration() {
        let mut engine = DataExfiltrationEngine::new();
        let long_subdomain = "a".repeat(60);
        for _ in 0..120 {
            let event = make_dns_event("192.168.1.50", &long_subdomain);
            let detections = engine.process_event(&event);
            if !detections.is_empty() {
                assert_eq!(detections[0].severity, Severity::High);
                assert!(detections[0].mitre_id.as_deref() == Some("T1048"));
                assert!(detections[0]
                    .tags
                    .contains(&"dns_exfiltration".to_string()));
                return;
            }
        }
        panic!("Expected DNS exfiltration detection");
    }

    #[test]
    fn test_cloud_upload_spike() {
        let mut engine = DataExfiltrationEngine::new();
        let event = make_cloud_upload_event("bob", 60 * 1024 * 1024);
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(detections[0]
            .tags
            .contains(&"cloud_upload_spike".to_string()));
    }

}
