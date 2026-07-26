use chrono::{DateTime, Utc};
use security_os_core::{EventCategory, SecurityEvent, Severity};
use std::collections::HashMap;
use std::sync::RwLock;

#[derive(Debug, Clone)]
pub enum PartitionStrategy {
    Daily,
    Hourly,
    ByCategory,
    ByRegion,
    BySeverity,
    Composite(Vec<PartitionStrategy>),
}

#[derive(Debug, Clone)]
pub struct Partition {
    pub key: String,
    pub path: String,
    pub event_count: u64,
    pub created_at: DateTime<Utc>,
    pub last_event_at: DateTime<Utc>,
}

pub struct Partitioner {
    strategies: Vec<PartitionStrategy>,
    output_path: String,
    partitions: RwLock<HashMap<String, Partition>>,
}

impl Partitioner {
    pub fn new(output_path: &str, strategies: Vec<PartitionStrategy>) -> Self {
        Self {
            strategies,
            output_path: output_path.to_string(),
            partitions: RwLock::new(HashMap::new()),
        }
    }

    pub fn partition_event(&self, event: &SecurityEvent) -> String {
        let key = Self::build_key(event, &self.strategies);
        let path = self.partition_key_to_path(&key);

        let mut partitions = self.partitions.write().unwrap();
        let now = Utc::now();
        partitions.entry(key.clone()).and_modify(|p| {
            p.event_count += 1;
            p.last_event_at = now;
        }).or_insert_with(|| Partition {
            key: key.clone(),
            path: path.clone(),
            event_count: 1,
            created_at: now,
            last_event_at: now,
        });

        path
    }

    pub fn partition_key_to_path(&self, key: &str) -> String {
        format!("{}/{}", self.output_path, key)
    }

    pub fn list_partitions(&self) -> Vec<Partition> {
        let partitions = self.partitions.read().unwrap();
        partitions.values().cloned().collect()
    }

    fn build_key(event: &SecurityEvent, strategies: &[PartitionStrategy]) -> String {
        let mut parts = Vec::new();
        for strategy in strategies {
            match strategy {
                PartitionStrategy::Daily => {
                    let ts = event.timestamp.naive_utc().date();
                    parts.push(ts.format("date=%Y-%m-%d").to_string());
                }
                PartitionStrategy::Hourly => {
                    let ts = event.timestamp.naive_utc();
                    parts.push(ts.format("date=%Y-%m-%d/hour=%H").to_string());
                }
                PartitionStrategy::ByCategory => {
                    parts.push(format!("category={}", category_to_string(&event.category)));
                }
                PartitionStrategy::ByRegion => {
                    let region = event.region.as_deref().unwrap_or("unknown");
                    parts.push(format!("region={}", region));
                }
                PartitionStrategy::BySeverity => {
                    parts.push(format!("severity={}", severity_to_string(&event.severity)));
                }
                PartitionStrategy::Composite(inner) => {
                    let composite = Self::build_key(event, inner);
                    parts.push(composite);
                }
            }
        }
        parts.join("/")
    }
}

fn category_to_string(cat: &EventCategory) -> String {
    match cat {
        EventCategory::Process => "process",
        EventCategory::Network => "network",
        EventCategory::Filesystem => "filesystem",
        EventCategory::Container => "container",
        EventCategory::Authentication => "authentication",
        EventCategory::Api => "api",
        EventCategory::Secrets => "secrets",
        EventCategory::Cloud => "cloud",
        EventCategory::Database => "database",
        EventCategory::ConfigurationDrift => "config_drift",
        EventCategory::Behavior => "behavior",
        EventCategory::ReservatiorBusiness => "business",
        EventCategory::System => "system",
        EventCategory::Kernel => "kernel",
        EventCategory::Identity => "identity",
        EventCategory::Ssh => "ssh",
        EventCategory::Kubernetes => "kubernetes",
        EventCategory::Dns => "dns",
        EventCategory::Tls => "tls",
        EventCategory::Jwt => "jwt",
        EventCategory::Cron => "cron",
        EventCategory::Sudo => "sudo",
        EventCategory::Selinux => "selinux",
        EventCategory::Apparmor => "apparmor",
        EventCategory::Usb => "usb",
        EventCategory::Gpu => "gpu",
        EventCategory::Memory => "memory",
        EventCategory::SupplyChain => "supply_chain",
        EventCategory::ThreatIntelligence => "threat_intel",
        EventCategory::AiAbuse => "ai_abuse",
        EventCategory::Incident => "incident",
    }
    .to_string()
}

fn severity_to_string(sev: &Severity) -> String {
    match sev {
        Severity::Informational => "informational",
        Severity::Low => "low",
        Severity::Medium => "medium",
        Severity::High => "high",
        Severity::Critical => "critical",
    }
    .to_string()
}

pub fn partition_by_date(event: &SecurityEvent, format: &str) -> String {
    let ts = event.timestamp.naive_utc();
    match format {
        "daily" => ts.format("date=%Y-%m-%d").to_string(),
        "hourly" => ts.format("date=%Y-%m-%d/hour=%H").to_string(),
        "monthly" => ts.format("date=%Y-%m").to_string(),
        _ => ts.format("date=%Y-%m-%d").to_string(),
    }
}

pub fn partition_by_category(event: &SecurityEvent) -> String {
    format!("category={}", category_to_string(&event.category))
}

pub fn partition_by_region(event: &SecurityEvent) -> String {
    let region = event.region.as_deref().unwrap_or("unknown");
    format!("region={}", region)
}

pub fn partition_by_severity(event: &SecurityEvent) -> String {
    format!("severity={}", severity_to_string(&event.severity))
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{EventAction, EventSource};
    fn default_source() -> EventSource {
        EventSource {
            collector: "test".to_string(),
            host_id: "host-1".to_string(),
            host_name: "test-host".to_string(),
            agent_id: "agent-1".to_string(),
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

    fn test_event() -> SecurityEvent {
        SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            default_source(),
            "Test",
            "Test event",
        )
        .with_region("us-east-1")
    }

    #[test]
    fn test_daily_partition() {
        let partitioner = Partitioner::new("/data", vec![PartitionStrategy::Daily]);
        let event = test_event();
        let path = partitioner.partition_event(&event);
        assert!(path.contains("date="));
        assert!(path.starts_with("/data/"));
    }

    #[test]
    fn test_by_category() {
        let event = test_event();
        let result = partition_by_category(&event);
        assert_eq!(result, "category=network");
    }

    #[test]
    fn test_by_region() {
        let event = test_event();
        let result = partition_by_region(&event);
        assert_eq!(result, "region=us-east-1");
    }

    #[test]
    fn test_composite_partition() {
        let strategies = vec![
            PartitionStrategy::Daily,
            PartitionStrategy::ByCategory,
            PartitionStrategy::BySeverity,
        ];
        let partitioner = Partitioner::new("/data", strategies);
        let event = test_event();
        let path = partitioner.partition_event(&event);
        assert!(path.contains("date="));
        assert!(path.contains("category="));
        assert!(path.contains("severity="));
    }
}
