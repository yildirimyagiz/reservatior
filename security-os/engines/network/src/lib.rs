use chrono::{DateTime, Duration, Utc};
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use std::collections::{HashMap, VecDeque};
use tracing::warn;

const PORT_SCAN_THRESHOLD: usize = 15;
const PORT_SCAN_WINDOW_SECS: i64 = 60;
const EXFIL_THRESHOLD_BYTES: u64 = 50_000_000;
const BEACON_MIN_SAMPLES: usize = 5;
const BEACON_JITTER_THRESHOLD: f64 = 0.15;

#[derive(Debug, Clone)]
pub struct ConnectionRecord {
    pub dest_ip: String,
    pub dest_port: u16,
    pub timestamp: DateTime<Utc>,
    pub bytes_out: u64,
    pub bytes_in: u64,
    pub protocol: String,
}

#[derive(Debug, Clone)]
pub struct ConnectionTracker {
    pub connections: VecDeque<ConnectionRecord>,
    pub unique_ports: Vec<(u16, DateTime<Utc>)>,
    pub total_bytes_out: u64,
    pub total_bytes_in: u64,
}

impl ConnectionTracker {
    fn new() -> Self {
        Self {
            connections: VecDeque::new(),
            unique_ports: Vec::new(),
            total_bytes_out: 0,
            total_bytes_in: 0,
        }
    }

    fn cleanup_old(&mut self, cutoff: DateTime<Utc>) {
        while let Some(front) = self.connections.front() {
            if front.timestamp < cutoff {
                self.connections.pop_front();
            } else {
                break;
            }
        }
        self.unique_ports
            .retain(|(_, ts)| *ts >= cutoff);
    }

    fn add_connection(&mut self, record: ConnectionRecord) {
        self.total_bytes_out += record.bytes_out;
        self.total_bytes_in += record.bytes_in;

        if !self.unique_ports.iter().any(|(p, _)| *p == record.dest_port) {
            self.unique_ports.push((record.dest_port, record.timestamp));
        }

        self.connections.push_back(record);
    }
}

pub struct NetworkEngine {
    trackers: DashMap<String, ConnectionTracker>,
    known_beacon_targets: DashMap<String, Vec<String>>,
}

impl NetworkEngine {
    pub fn new() -> Self {
        let engine = Self {
            trackers: DashMap::new(),
            known_beacon_targets: DashMap::new(),
        };
        engine
    }

    fn detect_port_scan(
        &self,
        src_ip: &str,
        tracker: &ConnectionTracker,
        now: DateTime<Utc>,
    ) -> Option<SecurityEvent> {
        let window_start = now - Duration::seconds(PORT_SCAN_WINDOW_SECS);
        let recent_ports: Vec<u16> = tracker
            .unique_ports
            .iter()
            .filter(|(_, ts)| *ts >= window_start)
            .map(|(port, _)| *port)
            .collect();

        if recent_ports.len() >= PORT_SCAN_THRESHOLD {
            let source = EventSource {
                collector: "network-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "network-engine-agent".to_string(),
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

            let port_list: Vec<String> = recent_ports.iter().map(|p| p.to_string()).collect();
            let mut event = SecurityEvent::new(
                EventCategory::Network,
                EventAction::Detected,
                source,
                format!("Port scan detected from {}", src_ip),
                format!(
                    "Source IP {} connected to {} different ports within {} seconds. \
                     Ports scanned: [{}]. This indicates reconnaissance activity.",
                    src_ip,
                    recent_ports.len(),
                    PORT_SCAN_WINDOW_SECS,
                    port_list.join(", "),
                ),
            )
            .with_severity(Severity::High)
            .with_confidence(0.9)
            .with_risk_score(80.0)
            .with_mitre(
                "Discovery",
                "Network Service Discovery",
                "T1046",
            )
            .with_tag("port-scan")
            .with_tag("reconnaissance");

            event.metadata.insert(
                "scanned_ports".to_string(),
                serde_json::Value::Array(
                    recent_ports
                        .iter()
                        .map(|p| serde_json::Value::Number((*p).into()))
                        .collect(),
                ),
            );
            event.metadata.insert(
                "port_count".to_string(),
                serde_json::Value::Number(recent_ports.len().into()),
            );

            event.affected_entities.push(Entity {
                entity_type: EntityType::Ip,
                value: src_ip.to_string(),
                risk_contribution: 40.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(event);
        }

        None
    }

    fn detect_exfiltration(
        &self,
        src_ip: &str,
        tracker: &ConnectionTracker,
    ) -> Option<SecurityEvent> {
        if tracker.total_bytes_out > EXFIL_THRESHOLD_BYTES {
            let source = EventSource {
                collector: "network-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "network-engine-agent".to_string(),
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

            let gb_out = tracker.total_bytes_out as f64 / 1_000_000_000.0;
            let mut event = SecurityEvent::new(
                EventCategory::Network,
                EventAction::Detected,
                source,
                format!("Possible data exfiltration from {}", src_ip),
                format!(
                    "Source IP {} has transferred {:.2} GB outbound, exceeding the {:.0} MB threshold. \
                     This may indicate data exfiltration.",
                    src_ip,
                    gb_out,
                    EXFIL_THRESHOLD_BYTES as f64 / 1_000_000.0,
                ),
            )
            .with_severity(Severity::Critical)
            .with_confidence(0.8)
            .with_risk_score(90.0)
            .with_mitre(
                "Exfiltration",
                "Exfiltration Over C2 Channel",
                "T1041",
            )
            .with_tag("data-exfiltration");

            event.metadata.insert(
                "bytes_out".to_string(),
                serde_json::Value::Number(tracker.total_bytes_out.into()),
            );
            event.metadata.insert(
                "gb_out".to_string(),
                serde_json::json!(gb_out),
            );

            event.affected_entities.push(Entity {
                entity_type: EntityType::Ip,
                value: src_ip.to_string(),
                risk_contribution: 50.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(event);
        }

        None
    }

    fn detect_beaconing(
        &self,
        src_ip: &str,
        tracker: &ConnectionTracker,
    ) -> Option<SecurityEvent> {
        if tracker.connections.len() < BEACON_MIN_SAMPLES {
            return None;
        }

        let conn_list: Vec<&ConnectionRecord> = tracker.connections.iter().collect();
        let dest_groups: HashMap<String, Vec<&ConnectionRecord>> =
            conn_list.into_iter().fold(HashMap::new(), |mut acc, c| {
                acc.entry(format!("{}:{}", c.dest_ip, c.dest_port))
                    .or_default()
                    .push(c);
                acc
            });

        for (target_key, conns) in &dest_groups {
            if conns.len() < BEACON_MIN_SAMPLES {
                continue;
            }

            let mut intervals: Vec<i64> = Vec::new();
            for window in conns.windows(2) {
                let diff = window[1].timestamp - window[0].timestamp;
                intervals.push(diff.num_milliseconds());
            }

            if intervals.is_empty() {
                continue;
            }

            let mean_interval =
                intervals.iter().sum::<i64>() as f64 / intervals.len() as f64;

            if mean_interval < 1000.0 {
                continue;
            }

            let variance: f64 = intervals
                .iter()
                .map(|&i| {
                    let diff = i as f64 - mean_interval;
                    diff * diff
                })
                .sum::<f64>()
                / intervals.len() as f64;

            let std_dev = variance.sqrt();
            let jitter = if mean_interval > 0.0 {
                std_dev / mean_interval
            } else {
                1.0
            };

            if jitter < BEACON_JITTER_THRESHOLD && conns.len() >= BEACON_MIN_SAMPLES {
                let source = EventSource {
                    collector: "network-engine".to_string(),
                    host_id: "unknown".to_string(),
                    host_name: "unknown".to_string(),
                    agent_id: "network-engine-agent".to_string(),
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

                let avg_interval_secs = mean_interval / 1000.0;
                let mut event = SecurityEvent::new(
                    EventCategory::Network,
                    EventAction::Detected,
                    source,
                    format!("C2 beaconing detected: {} -> {}", src_ip, target_key),
                    format!(
                        "Source IP {} is communicating with {} at regular intervals of ~{:.1}s \
                         (jitter: {:.1}%). This pattern is consistent with command-and-control \
                         beaconing behavior. {} samples observed.",
                        src_ip,
                        target_key,
                        avg_interval_secs,
                        jitter * 100.0,
                        conns.len(),
                    ),
                )
                .with_severity(Severity::Critical)
                .with_confidence(0.85)
                .with_risk_score(95.0)
                .with_mitre(
                    "Command and Control",
                    "Application Layer Protocol",
                    "T1071",
                )
                .with_tag("c2-beaconing");

                event
                    .metadata
                    .insert("target".to_string(), serde_json::json!(target_key));
                event.metadata.insert(
                    "avg_interval_ms".to_string(),
                    serde_json::json!(mean_interval),
                );
                event
                    .metadata
                    .insert("jitter".to_string(), serde_json::json!(jitter));
                event.metadata.insert(
                    "sample_count".to_string(),
                    serde_json::Value::Number(conns.len().into()),
                );

                event.affected_entities.push(Entity {
                    entity_type: EntityType::Ip,
                    value: src_ip.to_string(),
                    risk_contribution: 50.0,
                
                    metadata: std::collections::HashMap::new(),
                });

                let dest_parts: Vec<&str> = target_key.split(':').collect();
                if let Some(dest_ip) = dest_parts.first() {
                    event.affected_entities.push(Entity {
                        entity_type: EntityType::Ip,
                        value: dest_ip.to_string(),
                        risk_contribution: 30.0,
                    
                        metadata: std::collections::HashMap::new(),
                    });
                }

                return Some(event);
            }
        }

        None
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        if event.category == EventCategory::Network
            && (event.action == EventAction::Connected
                || event.action == EventAction::Created)
        {
            let src_ip = event
                .metadata
                .get("src_ip")
                .and_then(|v| v.as_str())
                .or_else(|| event.metadata.get("source_ip").and_then(|v| v.as_str()))
                .unwrap_or("unknown")
                .to_string();

            let dest_ip = event
                .metadata
                .get("dest_ip")
                .and_then(|v| v.as_str())
                .or_else(|| event.metadata.get("destination_ip").and_then(|v| v.as_str()))
                .unwrap_or("unknown")
                .to_string();

            let dest_port = event
                .metadata
                .get("dest_port")
                .and_then(|v| v.as_u64())
                .or_else(|| event.metadata.get("destination_port").and_then(|v| v.as_u64()))
                .unwrap_or(0) as u16;

            let bytes_out = event
                .metadata
                .get("bytes_out")
                .and_then(|v| v.as_u64())
                .unwrap_or(0);

            let bytes_in = event
                .metadata
                .get("bytes_in")
                .and_then(|v| v.as_u64())
                .unwrap_or(0);

            let protocol = event
                .metadata
                .get("protocol")
                .and_then(|v| v.as_str())
                .unwrap_or("tcp")
                .to_string();

            let record = ConnectionRecord {
                dest_ip,
                dest_port,
                timestamp: event.timestamp,
                bytes_out,
                bytes_in,
                protocol,
            };

            self.trackers
                .entry(src_ip.clone())
                .or_insert_with(ConnectionTracker::new)
                .add_connection(record);

            if let Some(mut tracker) = self.trackers.get_mut(&src_ip) {
                let now = event.timestamp;
                let window_start = now - Duration::seconds(PORT_SCAN_WINDOW_SECS * 2);
                tracker.cleanup_old(window_start);

                if let Some(scan_event) = self.detect_port_scan(&src_ip, &tracker, now) {
                    warn!("Port scan detected from {}: {}", src_ip, scan_event.title);
                    detections.push(scan_event);
                }

                if let Some(exfil_event) = self.detect_exfiltration(&src_ip, &tracker) {
                    warn!(
                        "Exfiltration detected from {}: {}",
                        src_ip, exfil_event.title
                    );
                    detections.push(exfil_event);
                }

                if let Some(beacon_event) = self.detect_beaconing(&src_ip, &tracker) {
                    warn!(
                        "Beaconing detected from {}: {}",
                        src_ip, beacon_event.title
                    );
                    detections.push(beacon_event);
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

    fn make_network_event(
        src_ip: &str,
        dest_ip: &str,
        dest_port: u16,
        bytes_out: u64,
        bytes_in: u64,
    ) -> SecurityEvent {
        let mut metadata = HashMap::new();
        metadata.insert(
            "src_ip".to_string(),
            serde_json::Value::String(src_ip.to_string()),
        );
        metadata.insert(
            "dest_ip".to_string(),
            serde_json::Value::String(dest_ip.to_string()),
        );
        metadata.insert(
            "dest_port".to_string(),
            serde_json::Value::Number(dest_port.into()),
        );
        metadata.insert(
            "bytes_out".to_string(),
            serde_json::Value::Number(bytes_out.into()),
        );
        metadata.insert(
            "bytes_in".to_string(),
            serde_json::Value::Number(bytes_in.into()),
        );
        metadata.insert(
            "protocol".to_string(),
            serde_json::Value::String("tcp".to_string()),
        );

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

        let mut event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            source,
            "Network connection".to_string(),
            "Test connection".to_string(),
        );
        event.metadata = metadata;
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = NetworkEngine::new();
        assert!(engine.trackers.is_empty());
    }

    #[test]
    fn test_track_connection() {
        let mut engine = NetworkEngine::new();
        let event = make_network_event("10.0.0.1", "10.0.0.2", 443, 1024, 2048);
        engine.process_event(&event);
        assert!(engine.trackers.contains_key("10.0.0.1"));
    }
}
