use chrono::{DateTime, Duration, Utc};
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use std::collections::HashSet;
use tracing::warn;

const CRYPTO_MINING_PROCESSES: &[&str] = &[
    "xmrig",
    "xmr-stak",
    "ccminer",
    "cgminer",
    "bfgminer",
    "ethminer",
    "cpuminer",
    "minerd",
    "minergate",
    "monero",
    "cryptonight",
    "stratum+tcp",
];

const CRYPTO_MINING_PORTS: &[u16] = &[3333, 4444, 5555, 7777, 8888, 9999, 14433, 14444];

const ESCAPE_INDICATORS: &[&str] = &[
    "nsenter",
    "unshare",
    "mount --bind",
    "/proc/self/ns",
    "/proc/1/ns",
    "capsh",
    "setcap",
    "prctl",
    "seccomp",
    "/dev/sda",
    "/dev/vda",
    "sys_ptrace",
    "SYS_ADMIN",
];

const SUSPICIOUS_MOUNT_PATHS: &[&str] = &[
    "/host",
    "/hostfs",
    "/mnt/host",
    "/proc",
    "/sys",
];

#[derive(Debug, Clone)]
pub struct ContainerBaseline {
    pub container_id: String,
    pub image: String,
    pub allowed_processes: HashSet<String>,
    pub allowed_network_targets: HashSet<String>,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Clone)]
pub struct ContainerActivity {
    pub container_id: String,
    pub processes_spawned: Vec<String>,
    pub connections: Vec<String>,
    pub cpu_usage_history: Vec<f64>,
    pub last_seen: DateTime<Utc>,
}

pub struct ContainerEngine {
    baselines: DashMap<String, ContainerBaseline>,
    activity: DashMap<String, ContainerActivity>,
    escape_alert_cooldown: DashMap<String, DateTime<Utc>>,
    mining_alert_cooldown: DashMap<String, DateTime<Utc>>,
}

impl ContainerEngine {
    pub fn new() -> Self {
        Self {
            baselines: DashMap::new(),
            activity: DashMap::new(),
            escape_alert_cooldown: DashMap::new(),
            mining_alert_cooldown: DashMap::new(),
        }
    }

    fn register_baseline(
        &self,
        container_id: &str,
        image: &str,
        allowed_processes: Vec<String>,
        allowed_network: Vec<String>,
    ) {
        let baseline = ContainerBaseline {
            container_id: container_id.to_string(),
            image: image.to_string(),
            allowed_processes: allowed_processes.into_iter().collect(),
            allowed_network_targets: allowed_network.into_iter().collect(),
            created_at: Utc::now(),
        };
        self.baselines.insert(container_id.to_string(), baseline);
    }

    fn update_activity(&self, container_id: &str, event: &SecurityEvent) {
        let mut act = self
            .activity
            .entry(container_id.to_string())
            .or_insert_with(|| ContainerActivity {
                container_id: container_id.to_string(),
                processes_spawned: Vec::new(),
                connections: Vec::new(),
                cpu_usage_history: Vec::new(),
                last_seen: event.timestamp,
            });

        act.last_seen = event.timestamp;

        if let Some(proc_name) = &event.source.process_name {
            if !act.processes_spawned.contains(proc_name) {
                act.processes_spawned.push(proc_name.clone());
            }
        }

        if event.category == EventCategory::Network {
            if let Some(dest) = event.metadata.get("dest_ip").and_then(|v| v.as_str()) {
                let target = dest.to_string();
                if !act.connections.contains(&target) {
                    act.connections.push(target);
                }
            }
        }

        if let Some(cpu) = event.metadata.get("cpu_usage").and_then(|v| v.as_f64()) {
            act.cpu_usage_history.push(cpu);
            if act.cpu_usage_history.len() > 100 {
                act.cpu_usage_history.drain(0..50);
            }
        }
    }

    fn detect_escape_attempt(
        &self,
        container_id: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if let Some(cooldown) = self.escape_alert_cooldown.get(container_id) {
            if event.timestamp - *cooldown < Duration::seconds(300) {
                return None;
            }
        }

        let mut indicators_found = Vec::new();

        let command_line = event
            .metadata
            .get("command_line")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let proc_name = event
            .source
            .process_name
            .as_deref()
            .unwrap_or("");

        let combined = format!("{} {}", proc_name, command_line).to_lowercase();

        for indicator in ESCAPE_INDICATORS {
            if combined.contains(&indicator.to_lowercase()) {
                indicators_found.push(*indicator);
            }
        }

        if let Some(mount_target) = event.metadata.get("mount_target").and_then(|v| v.as_str()) {
            for suspicious_path in SUSPICIOUS_MOUNT_PATHS {
                if mount_target.starts_with(suspicious_path) {
                    indicators_found.push("suspicious-mount");
                    break;
                }
            }
        }

        if let Some(caps) = event.metadata.get("capabilities").and_then(|v| v.as_str()) {
            if caps.contains("SYS_ADMIN") || caps.contains("sys_ptrace") {
                indicators_found.push("dangerous-capabilities");
            }
        }

        if event
            .metadata
            .get("pid_namespace")
            .and_then(|v| v.as_str())
            == Some("host")
        {
            indicators_found.push("host-pid-namespace");
        }

        if !indicators_found.is_empty() {
            self.escape_alert_cooldown
                .insert(container_id.to_string(), event.timestamp);

            let source = EventSource {
                collector: "container-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "container-engine-agent".to_string(),
                process_name: event.source.process_name.clone(),
                process_id: event.source.process_id,
                user_id: event.source.user_id.clone(),
                user_name: event.source.user_name.clone(),
                container_id: Some(container_id.to_string()),
                container_name: event.source.container_name.clone(),
                pod_name: event.source.pod_name.clone(),
                namespace: event.source.namespace.clone(),
            
                agent_version: None,
                service_name: None,
            };

            let mut escape_event = SecurityEvent::new(
                EventCategory::Container,
                EventAction::Detected,
                source,
                format!("Container escape attempt detected: {}", container_id),
                format!(
                    "Container '{}' shows indicators of escape attempt: [{}]. \
                     Command: '{}'. Container escape allows an attacker to break out \
                     of the container and gain access to the host system.",
                    container_id,
                    indicators_found.join(", "),
                    if command_line.is_empty() {
                        proc_name
                    } else {
                        command_line
                    },
                ),
            )
            .with_severity(Severity::Critical)
            .with_confidence(0.9)
            .with_risk_score(98.0)
            .with_mitre(
                "Privilege Escalation",
                "Escape to Host",
                "T1611",
            )
            .with_tag("container-escape")
            .with_tag("privilege-escalation");

            escape_event.metadata.insert(
                "indicators".to_string(),
                serde_json::Value::Array(
                    indicators_found
                        .iter()
                        .map(|i| serde_json::Value::String(i.to_string()))
                        .collect(),
                ),
            );
            if !command_line.is_empty() {
                escape_event.metadata.insert(
                    "command_line".to_string(),
                    serde_json::Value::String(command_line.to_string()),
                );
            }

            escape_event.affected_entities.push(Entity {
                entity_type: EntityType::Container,
                value: container_id.to_string(),
                risk_contribution: 50.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(escape_event);
        }

        None
    }

    fn detect_crypto_mining(
        &self,
        container_id: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if let Some(cooldown) = self.mining_alert_cooldown.get(container_id) {
            if event.timestamp - *cooldown < Duration::seconds(600) {
                return None;
            }
        }

        let mut mining_indicators = Vec::new();

        let proc_name = event
            .source
            .process_name
            .as_deref()
            .unwrap_or("")
            .to_lowercase();

        for mining_proc in CRYPTO_MINING_PROCESSES {
            if proc_name.contains(mining_proc) {
                mining_indicators.push(format!("mining-process:{}", mining_proc));
            }
        }

        let command_line = event
            .metadata
            .get("command_line")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_lowercase();

        for mining_proc in CRYPTO_MINING_PROCESSES {
            if command_line.contains(mining_proc) {
                let indicator = format!("command:{}", mining_proc);
                if !mining_indicators.contains(&indicator) {
                    mining_indicators.push(indicator);
                }
            }
        }

        if let Some(dest_port) = event.metadata.get("dest_port").and_then(|v| v.as_u64()) {
            if CRYPTO_MINING_PORTS.contains(&(dest_port as u16)) {
                mining_indicators
                    .push(format!("mining-port:{}", dest_port));
            }
        }

        if let Some(cpu) = event.metadata.get("cpu_usage").and_then(|v| v.as_f64()) {
            if cpu > 90.0 {
                mining_indicators.push(format!("high-cpu:{:.1}%", cpu));
            }
        }

        if let Some(cmd) = event.metadata.get("command_line").and_then(|v| v.as_str()) {
            let lower = cmd.to_lowercase();
            if lower.contains("stratum+tcp") || lower.contains("stratum+ssl") {
                mining_indicators.push("stratum-protocol".to_string());
            }
            if lower.contains("--donate-level=0") || lower.contains("--donate-level=1") {
                mining_indicators.push("low-donation-level".to_string());
            }
            if lower.contains("-o pool.") || lower.contains("-o stratum.") {
                mining_indicators.push("mining-pool-connection".to_string());
            }
        }

        if mining_indicators.len() >= 2 {
            self.mining_alert_cooldown
                .insert(container_id.to_string(), event.timestamp);

            let source = EventSource {
                collector: "container-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "container-engine-agent".to_string(),
                process_name: event.source.process_name.clone(),
                process_id: event.source.process_id,
                user_id: event.source.user_id.clone(),
                user_name: event.source.user_name.clone(),
                container_id: Some(container_id.to_string()),
                container_name: event.source.container_name.clone(),
                pod_name: event.source.pod_name.clone(),
                namespace: event.source.namespace.clone(),
            
                agent_version: None,
                service_name: None,
            };

            let mut mining_event = SecurityEvent::new(
                EventCategory::Container,
                EventAction::Detected,
                source,
                format!("Crypto mining detected in container: {}", container_id),
                format!(
                    "Container '{}' exhibits crypto mining behavior. Indicators: [{}]. \
                     This indicates unauthorized use of container resources for cryptocurrency \
                     mining, often associated with compromised containers.",
                    container_id,
                    mining_indicators.join(", "),
                ),
            )
            .with_severity(Severity::High)
            .with_confidence(0.85)
            .with_risk_score(80.0)
            .with_mitre(
                "Impact",
                "Resource Hijacking",
                "T1496",
            )
            .with_tag("crypto-mining")
            .with_tag("resource-abuse");

            mining_event.metadata.insert(
                "indicators".to_string(),
                serde_json::Value::Array(
                    mining_indicators
                        .iter()
                        .map(|i| serde_json::Value::String(i.clone()))
                        .collect(),
                ),
            );

            mining_event.affected_entities.push(Entity {
                entity_type: EntityType::Container,
                value: container_id.to_string(),
                risk_contribution: 40.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(mining_event);
        }

        None
    }

    fn detect_unexpected_communication(
        &self,
        container_id: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        let dest_ip = event
            .metadata
            .get("dest_ip")
            .and_then(|v| v.as_str())?;

        if let Some(baseline) = self.baselines.get(container_id) {
            if !baseline.allowed_network_targets.contains(dest_ip) {
                let act = self.activity.get(container_id)?;
                let dest_ip_string = dest_ip.to_string();
                let is_first_contact = !act.connections.contains(&dest_ip_string);

                drop(act);
                drop(baseline);

                if is_first_contact {
                    let source = EventSource {
                        collector: "container-engine".to_string(),
                        host_id: "unknown".to_string(),
                        host_name: "unknown".to_string(),
                        agent_id: "container-engine-agent".to_string(),
                        process_name: event.source.process_name.clone(),
                        process_id: event.source.process_id,
                        user_id: event.source.user_id.clone(),
                        user_name: event.source.user_name.clone(),
                        container_id: Some(container_id.to_string()),
                        container_name: event.source.container_name.clone(),
                        pod_name: event.source.pod_name.clone(),
                        namespace: event.source.namespace.clone(),
                    
                        agent_version: None,
                        service_name: None,
                    };

                    let mut comm_event = SecurityEvent::new(
                        EventCategory::Container,
                        EventAction::Detected,
                        source,
                        format!(
                            "Unexpected container-to-host communication: {} -> {}",
                            container_id, dest_ip
                        ),
                        format!(
                            "Container '{}' is communicating with IP '{}' which is not in its \
                             baseline allowed network list. This may indicate lateral movement \
                             or unauthorized data transfer.",
                            container_id, dest_ip,
                        ),
                    )
                    .with_severity(Severity::Medium)
                    .with_confidence(0.7)
                    .with_risk_score(60.0)
                    .with_mitre(
                        "Lateral Movement",
                        "Container Administration Command",
                        "T1610",
                    )
                    .with_tag("unexpected-communication");

                    comm_event.metadata.insert(
                        "dest_ip".to_string(),
                        serde_json::Value::String(dest_ip.to_string()),
                    );

                    comm_event.affected_entities.push(Entity {
                        entity_type: EntityType::Container,
                        value: container_id.to_string(),
                        risk_contribution: 30.0,
                    
                        metadata: std::collections::HashMap::new(),
                    });
                    comm_event.affected_entities.push(Entity {
                        entity_type: EntityType::Ip,
                        value: dest_ip.to_string(),
                        risk_contribution: 20.0,
                    
                        metadata: std::collections::HashMap::new(),
                    });

                    return Some(comm_event);
                }
            }
        }

        None
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        let container_id = event
            .source
            .container_id
            .clone()
            .or_else(|| {
                event
                    .metadata
                    .get("container_id")
                    .and_then(|v| v.as_str())
                    .map(|s| s.to_string())
            });

        let Some(cid) = container_id else {
            return detections;
        };

        self.update_activity(&cid, event);

        if let Some(escape_event) = self.detect_escape_attempt(&cid, event) {
            warn!(
                "Container escape detected in {}: {}",
                cid, escape_event.title
            );
            detections.push(escape_event);
        }

        if let Some(mining_event) = self.detect_crypto_mining(&cid, event) {
            warn!(
                "Crypto mining detected in {}: {}",
                cid, mining_event.title
            );
            detections.push(mining_event);
        }

        if event.category == EventCategory::Network {
            if let Some(comm_event) = self.detect_unexpected_communication(&cid, event) {
                warn!(
                    "Unexpected communication from {}: {}",
                    cid, comm_event.title
                );
                detections.push(comm_event);
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

    fn make_container_event(
        container_id: &str,
        proc_name: &str,
        command_line: &str,
    ) -> SecurityEvent {
        let mut metadata = HashMap::new();
        metadata.insert(
            "container_id".to_string(),
            serde_json::Value::String(container_id.to_string()),
        );
        if !command_line.is_empty() {
            metadata.insert(
                "command_line".to_string(),
                serde_json::Value::String(command_line.to_string()),
            );
        }

        let source = EventSource {
            collector: "test".to_string(),
            host_id: "test-host".to_string(),
            host_name: "test".to_string(),
            agent_id: "test-agent".to_string(),
            process_name: Some(proc_name.to_string()),
            process_id: Some(1000),
            user_id: None,
            user_name: None,
            container_id: Some(container_id.to_string()),
            container_name: Some("test-container".to_string()),
            pod_name: None,
            namespace: Some("default".to_string()),
        
            agent_version: None,
            service_name: None,
        };

        let mut event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Created,
            source,
            format!("Process in container: {}", proc_name),
            format!("Process {} created in container {}", proc_name, container_id),
        );
        event.metadata = metadata;
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = ContainerEngine::new();
        assert!(engine.baselines.is_empty());
        assert!(engine.activity.is_empty());
    }

    #[test]
    fn test_escape_detection() {
        let mut engine = ContainerEngine::new();
        let event = make_container_event(
            "abc123",
            "nsenter",
            "nsenter -t 1 -m -u -i -n -p -- /bin/bash",
        );
        let detections = engine.process_event(&event);
        assert_eq!(detections.len(), 1);
        assert_eq!(detections[0].severity, Severity::Critical);
    }

    #[test]
    fn test_mining_detection() {
        let mut engine = ContainerEngine::new();
        let mut event = make_container_event(
            "def456",
            "xmrig",
            "xmrig --donate-level=0 -o stratum+tcp://pool.example.com:3333",
        );
        event.metadata.insert(
            "cpu_usage".to_string(),
            serde_json::json!(95.0),
        );
        let detections = engine.process_event(&event);
        assert!(detections.iter().any(|d| d.severity == Severity::High));
    }
}
