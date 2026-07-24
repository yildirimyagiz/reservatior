use chrono::{DateTime, Utc};
use dashmap::DashMap;
use security_os_core::SecurityEvent;

#[derive(Debug, Clone)]
pub struct HostProfile {
    pub host_id: String,
    pub hostname: String,
    pub baseline: HostBaseline,
    pub anomalies: Vec<HostAnomaly>,
    pub risk_trend: Vec<RiskDataPoint>,
    pub first_seen: DateTime<Utc>,
    pub last_seen: DateTime<Utc>,
    pub total_events: u64,
}

#[derive(Debug, Clone)]
pub struct HostBaseline {
    pub normal_processes: Vec<String>,
    pub normal_connections: Vec<NetworkBaseline>,
    pub normal_users: Vec<String>,
    pub normal_hours: Vec<u8>,
    pub avg_events_per_hour: f64,
}

#[derive(Debug, Clone)]
pub struct NetworkBaseline {
    pub remote_ip: String,
    pub port: u16,
    pub frequency: f64,
}

#[derive(Debug, Clone)]
pub struct HostAnomaly {
    pub anomaly_type: String,
    pub description: String,
    pub severity: security_os_core::Severity,
    pub detected_at: DateTime<Utc>,
    pub confidence: f64,
}

#[derive(Debug, Clone)]
pub struct RiskDataPoint {
    pub timestamp: DateTime<Utc>,
    pub risk_score: f64,
}

pub struct HostMemory {
    hosts: DashMap<String, HostProfile>,
}

impl HostMemory {
    pub fn new() -> Self {
        Self {
            hosts: DashMap::new(),
        }
    }

    pub fn update_baseline(&self, host_id: &str, hostname: &str, event: &SecurityEvent) {
        let mut entry = self
            .hosts
            .entry(host_id.to_string())
            .or_insert_with(|| HostProfile {
                host_id: host_id.to_string(),
                hostname: hostname.to_string(),
                baseline: HostBaseline {
                    normal_processes: Vec::new(),
                    normal_connections: Vec::new(),
                    normal_users: Vec::new(),
                    normal_hours: Vec::new(),
                    avg_events_per_hour: 0.0,
                },
                anomalies: Vec::new(),
                risk_trend: Vec::new(),
                first_seen: Utc::now(),
                last_seen: Utc::now(),
                total_events: 0,
            });

        entry.last_seen = event.timestamp;
        entry.total_events += 1;

        if let Some(exe) = &event.exe {
            if !entry.baseline.normal_processes.contains(exe) {
                entry.baseline.normal_processes.push(exe.clone());
            }
        }

        if let (Some(_src_ip), Some(src_port)) = (&event.src_ip, &event.src_port) {
            let remote_ip = event.dst_ip.clone().unwrap_or_default();
            let exists = entry.baseline.normal_connections.iter().any(|c| {
                c.remote_ip == remote_ip && c.port == *src_port
            });
            if !exists {
                entry.baseline.normal_connections.push(NetworkBaseline {
                    remote_ip,
                    port: *src_port,
                    frequency: 1.0,
                });
            }
        }

        if let Some(username) = &event.username {
            if !entry.baseline.normal_users.contains(username) {
                entry.baseline.normal_users.push(username.clone());
            }
        }

        let hour = event.timestamp.format("%H").to_string().parse::<u8>().unwrap_or(0);
        if !entry.baseline.normal_hours.contains(&hour) {
            entry.baseline.normal_hours.push(hour);
            entry.baseline.normal_hours.sort();
        }

        let hours_elapsed = (event.timestamp - entry.first_seen).num_hours() as f64;
        if hours_elapsed > 0.0 {
            entry.baseline.avg_events_per_hour = entry.total_events as f64 / hours_elapsed;
        }
    }

    pub fn record_anomaly(&self, host_id: &str, anomaly: HostAnomaly) {
        if let Some(mut profile) = self.hosts.get_mut(host_id) {
            profile.anomalies.push(anomaly);
        }
    }

    pub fn record_risk(&self, host_id: &str, risk_score: f64) {
        if let Some(mut profile) = self.hosts.get_mut(host_id) {
            profile.risk_trend.push(RiskDataPoint {
                timestamp: Utc::now(),
                risk_score,
            });
        }
    }

    pub fn get_profile(&self, host_id: &str) -> Option<HostProfile> {
        self.hosts.get(host_id).map(|p| p.clone())
    }

    pub fn get_anomalies(&self, host_id: &str) -> Vec<HostAnomaly> {
        self.hosts
            .get(host_id)
            .map(|p| p.anomalies.clone())
            .unwrap_or_default()
    }

    pub fn risk_trend(&self, host_id: &str, hours: u32) -> Vec<RiskDataPoint> {
        let cutoff = Utc::now() - chrono::Duration::hours(hours as i64);
        self.hosts
            .get(host_id)
            .map(|p| {
                p.risk_trend
                    .iter()
                    .filter(|dp| dp.timestamp >= cutoff)
                    .cloned()
                    .collect()
            })
            .unwrap_or_default()
    }

    pub fn hosts_at_risk(&self, threshold: f64) -> Vec<String> {
        self.hosts
            .iter()
            .filter(|p| {
                p.risk_trend
                    .last()
                    .map(|dp| dp.risk_score >= threshold)
                    .unwrap_or(false)
            })
            .map(|p| p.host_id.clone())
            .collect()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;
    use security_os_core::{
        EventAction, EventCategory, EventSource, SecurityEvent, Severity,
    };

    fn make_source() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "web-01".into(),
            agent_id: "agent-1".into(),
            agent_version: Some("1.0".into()),
            process_name: None,
            process_id: None,
            user_id: Some("uid-1000".into()),
            user_name: Some("alice".into()),
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            service_name: None,
        }
    }

    fn make_event() -> SecurityEvent {
        SecurityEvent::new(
            EventCategory::Process,
            EventAction::Executed,
            make_source(),
            "Process started",
            "Test process event",
        )
    }

    #[test]
    fn test_update_baseline() {
        let memory = HostMemory::new();
        let mut event = make_event();
        event.exe = Some("/usr/bin/nginx".into());
        event.username = Some("www-data".into());
        event.src_ip = Some("10.0.0.1".into());
        event.src_port = Some(443);

        memory.update_baseline("host-1", "web-01", &event);

        let profile = memory.get_profile("host-1").expect("host should exist");
        assert_eq!(profile.hostname, "web-01");
        assert_eq!(profile.total_events, 1);
        assert!(profile.baseline.normal_processes.contains(&"/usr/bin/nginx".to_string()));
        assert!(profile.baseline.normal_users.contains(&"www-data".to_string()));
        assert_eq!(profile.baseline.normal_connections.len(), 1);
    }

    #[test]
    fn test_record_anomaly() {
        let memory = HostMemory::new();
        memory.update_baseline("host-1", "web-01", &make_event());

        let anomaly = HostAnomaly {
            anomaly_type: "process_spawn".to_string(),
            description: "Unknown process detected".to_string(),
            severity: Severity::High,
            detected_at: Utc::now(),
            confidence: 0.85,
        };

        memory.record_anomaly("host-1", anomaly);
        let anomalies = memory.get_anomalies("host-1");
        assert_eq!(anomalies.len(), 1);
        assert_eq!(anomalies[0].anomaly_type, "process_spawn");
    }

    #[test]
    fn test_get_profile() {
        let memory = HostMemory::new();
        memory.update_baseline("host-1", "web-01", &make_event());

        let profile = memory.get_profile("host-1");
        assert!(profile.is_some());
        let profile = profile.unwrap();
        assert_eq!(profile.host_id, "host-1");
        assert_eq!(profile.hostname, "web-01");
        assert_eq!(profile.total_events, 1);
    }

    #[test]
    fn test_risk_trend() {
        let memory = HostMemory::new();
        memory.update_baseline("host-1", "web-01", &make_event());

        memory.record_risk("host-1", 30.0);
        memory.record_risk("host-1", 60.0);
        memory.record_risk("host-1", 90.0);

        let trend = memory.risk_trend("host-1", 1);
        assert_eq!(trend.len(), 3);
        assert_eq!(trend[0].risk_score, 30.0);
        assert_eq!(trend[2].risk_score, 90.0);
    }

    #[test]
    fn test_hosts_at_risk() {
        let memory = HostMemory::new();
        memory.update_baseline("host-1", "web-01", &make_event());
        memory.update_baseline("host-2", "db-01", &make_event());

        memory.record_risk("host-1", 30.0);
        memory.record_risk("host-2", 85.0);

        let at_risk = memory.hosts_at_risk(50.0);
        assert_eq!(at_risk.len(), 1);
        assert_eq!(at_risk[0], "host-2");
    }

    #[test]
    fn test_anomalies_nonexistent_host() {
        let memory = HostMemory::new();
        let anomalies = memory.get_anomalies("nonexistent");
        assert!(anomalies.is_empty());
    }
}
