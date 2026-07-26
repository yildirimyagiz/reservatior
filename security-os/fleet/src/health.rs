use chrono::{DateTime, Utc};
use dashmap::DashMap;
use std::collections::HashMap;

use security_os_core::Severity;

#[derive(Debug, Clone)]
pub struct AgentHealthReport {
    pub agent_id: String,
    pub cpu_usage: f64,
    pub memory_usage_mb: f64,
    pub disk_usage_percent: f64,
    pub events_per_second: f64,
    pub active_collectors: Vec<String>,
    pub uptime_secs: u64,
    pub reported_at: DateTime<Utc>,
}

#[derive(Debug, Clone)]
pub struct HealthAlert {
    pub agent_id: String,
    pub alert_type: HealthAlertType,
    pub message: String,
    pub severity: Severity,
    pub timestamp: DateTime<Utc>,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum HealthAlertType {
    HighCpu,
    HighMemory,
    HighDisk,
    LowThroughput,
    CollectorDown,
}

const CPU_THRESHOLD: f64 = 90.0;
const MEMORY_THRESHOLD_MB: f64 = 8192.0;
const DISK_THRESHOLD: f64 = 90.0;
const THROUGHPUT_MIN: f64 = 0.1;

pub struct HealthMonitor {
    agent_health: DashMap<String, AgentHealthReport>,
}

impl HealthMonitor {
    pub fn new() -> Self {
        Self {
            agent_health: DashMap::new(),
        }
    }

    pub fn update_health(&self, report: AgentHealthReport) -> Vec<HealthAlert> {
        let mut alerts = Vec::new();
        let now = Utc::now();

        if report.cpu_usage > CPU_THRESHOLD {
            alerts.push(HealthAlert {
                agent_id: report.agent_id.clone(),
                alert_type: HealthAlertType::HighCpu,
                message: format!(
                    "CPU usage at {:.1}% exceeds threshold of {:.0}%",
                    report.cpu_usage, CPU_THRESHOLD
                ),
                severity: if report.cpu_usage > 95.0 {
                    Severity::Critical
                } else {
                    Severity::High
                },
                timestamp: now,
            });
        }

        if report.memory_usage_mb > MEMORY_THRESHOLD_MB {
            alerts.push(HealthAlert {
                agent_id: report.agent_id.clone(),
                alert_type: HealthAlertType::HighMemory,
                message: format!(
                    "Memory usage at {:.0} MB exceeds threshold of {:.0} MB",
                    report.memory_usage_mb, MEMORY_THRESHOLD_MB
                ),
                severity: if report.memory_usage_mb > 16384.0 {
                    Severity::Critical
                } else {
                    Severity::High
                },
                timestamp: now,
            });
        }

        if report.disk_usage_percent > DISK_THRESHOLD {
            alerts.push(HealthAlert {
                agent_id: report.agent_id.clone(),
                alert_type: HealthAlertType::HighDisk,
                message: format!(
                    "Disk usage at {:.1}% exceeds threshold of {:.0}%",
                    report.disk_usage_percent, DISK_THRESHOLD
                ),
                severity: if report.disk_usage_percent > 95.0 {
                    Severity::Critical
                } else {
                    Severity::Medium
                },
                timestamp: now,
            });
        }

        if report.events_per_second < THROUGHPUT_MIN && report.uptime_secs > 60 {
            alerts.push(HealthAlert {
                agent_id: report.agent_id.clone(),
                alert_type: HealthAlertType::LowThroughput,
                message: format!(
                    "Throughput at {:.2} events/sec is below minimum threshold",
                    report.events_per_second
                ),
                severity: Severity::Medium,
                timestamp: now,
            });
        }

        self.agent_health.insert(report.agent_id.clone(), report);
        alerts
    }

    pub fn get_health(&self, agent_id: &str) -> Option<AgentHealthReport> {
        self.agent_health.get(agent_id).map(|r| r.value().clone())
    }

    pub fn unhealthy_agents(&self) -> Vec<String> {
        self.agent_health
            .iter()
            .filter(|r| {
                let h = r.value();
                h.cpu_usage > CPU_THRESHOLD
                    || h.memory_usage_mb > MEMORY_THRESHOLD_MB
                    || h.disk_usage_percent > DISK_THRESHOLD
                    || (h.events_per_second < THROUGHPUT_MIN && h.uptime_secs > 60)
            })
            .map(|r| r.key().clone())
            .collect()
    }

    pub fn health_summary(&self) -> HashMap<String, AgentHealthReport> {
        self.agent_health
            .iter()
            .map(|r| (r.key().clone(), r.value().clone()))
            .collect()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn make_report(agent_id: &str, cpu: f64, mem: f64, disk: f64, eps: f64) -> AgentHealthReport {
        AgentHealthReport {
            agent_id: agent_id.to_string(),
            cpu_usage: cpu,
            memory_usage_mb: mem,
            disk_usage_percent: disk,
            events_per_second: eps,
            active_collectors: vec!["proc".to_string(), "net".to_string()],
            uptime_secs: 3600,
            reported_at: Utc::now(),
        }
    }

    #[test]
    fn test_update_health_generates_alerts() {
        let monitor = HealthMonitor::new();
        let report = make_report("a1", 95.0, 9000.0, 92.0, 50.0);
        let alerts = monitor.update_health(report);
        assert_eq!(alerts.len(), 3);
        assert!(alerts.iter().any(|a| a.alert_type == HealthAlertType::HighCpu));
        assert!(alerts.iter().any(|a| a.alert_type == HealthAlertType::HighMemory));
        assert!(alerts.iter().any(|a| a.alert_type == HealthAlertType::HighDisk));
    }

    #[test]
    fn test_get_health() {
        let monitor = HealthMonitor::new();
        let report = make_report("a1", 50.0, 4096.0, 60.0, 10.0);
        monitor.update_health(report);
        let got = monitor.get_health("a1").unwrap();
        assert_eq!(got.cpu_usage, 50.0);
        assert!(monitor.get_health("nonexistent").is_none());
    }

    #[test]
    fn test_unhealthy_agents() {
        let monitor = HealthMonitor::new();
        monitor.update_health(make_report("a1", 95.0, 4096.0, 60.0, 10.0));
        monitor.update_health(make_report("a2", 30.0, 2048.0, 40.0, 50.0));
        monitor.update_health(make_report("a3", 50.0, 12000.0, 60.0, 10.0));

        let unhealthy = monitor.unhealthy_agents();
        assert!(unhealthy.contains(&"a1".to_string()));
        assert!(unhealthy.contains(&"a3".to_string()));
        assert!(!unhealthy.contains(&"a2".to_string()));
    }

    #[test]
    fn test_healthy_agent_no_alerts() {
        let monitor = HealthMonitor::new();
        let report = make_report("a1", 20.0, 1024.0, 30.0, 100.0);
        let alerts = monitor.update_health(report);
        assert!(alerts.is_empty());
    }
}
