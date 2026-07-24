use chrono::{DateTime, Utc};
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::{debug, warn};

#[derive(Debug, Clone)]
pub struct ProcessInfo {
    pub pid: u32,
    pub name: String,
    pub parent_pid: Option<u32>,
    pub start_time: DateTime<Utc>,
    pub command_line: String,
}

#[derive(Debug, Clone)]
pub struct ProcessTree {
    pub children: Vec<u32>,
}

pub struct ProcessEngine {
    processes: DashMap<u32, ProcessInfo>,
    process_trees: DashMap<u32, ProcessTree>,
    spoofing_baselines: DashMap<String, Vec<String>>,
}

impl ProcessEngine {
    pub fn new() -> Self {
        let engine = Self {
            processes: DashMap::new(),
            process_trees: DashMap::new(),
            spoofing_baselines: DashMap::new(),
        };

        engine.register_known_binaries();
        engine
    }

    fn register_known_binaries(&self) {
        let web_servers = vec![
            "nginx".to_string(),
            "apache2".to_string(),
            "httpd".to_string(),
            "caddy".to_string(),
        ];
        self.spoofing_baselines
            .insert("web_server".to_string(), web_servers);

        let db_servers = vec![
            "mysqld".to_string(),
            "postgres".to_string(),
            "mongod".to_string(),
            "redis-server".to_string(),
        ];
        self.spoofing_baselines
            .insert("db_server".to_string(), db_servers);

        let system_procs = vec![
            "kworker".to_string(),
            "ksoftirqd".to_string(),
            "migration".to_string(),
            "rcu_sched".to_string(),
            "watchdog".to_string(),
            "sshd".to_string(),
            "systemd".to_string(),
            "dbus-daemon".to_string(),
        ];
        self.spoofing_baselines
            .insert("system".to_string(), system_procs);
    }

    fn get_parent_process(&self, pid: u32) -> Option<ProcessInfo> {
        self.processes
            .get(&pid)
            .map(|entry| entry.value().clone())
    }

    fn track_process(&self, info: ProcessInfo) {
        if let Some(parent_pid) = info.parent_pid {
            self.process_trees
                .entry(parent_pid)
                .or_insert_with(|| ProcessTree {
                    children: Vec::new(),
                })
                .children
                .push(info.pid);
        }
        self.processes.insert(info.pid, info);
    }

    fn detect_suspicious_chain(&self, pid: u32) -> Option<SecurityEvent> {
        let process = self.processes.get(&pid)?;
        let current = process.value().clone();
        drop(process);

        let mut chain = vec![current.clone()];
        let mut current_pid = current.parent_pid;

        while let Some(ppid) = current_pid {
            if let Some(parent) = self.processes.get(&ppid) {
                let parent_info = parent.value().clone();
                chain.push(parent_info.clone());
                current_pid = parent_info.parent_pid;
            } else {
                break;
            }
        }

        if chain.len() >= 3 {
            let child = &chain[0];
            let grandparent = &chain[2];

            let suspicious_pairs: Vec<(&str, &str)> = vec![
                ("nginx", "sh"),
                ("nginx", "bash"),
                ("nginx", "dash"),
                ("nginx", "zsh"),
                ("apache2", "sh"),
                ("apache2", "bash"),
                ("httpd", "sh"),
                ("httpd", "bash"),
                ("postgres", "sh"),
                ("postgres", "bash"),
                ("mysqld", "sh"),
                ("mysqld", "bash"),
                ("redis-server", "sh"),
                ("redis-server", "bash"),
                ("caddy", "sh"),
                ("caddy", "bash"),
                ("node", "sh"),
                ("node", "bash"),
                ("java", "sh"),
                ("java", "bash"),
                ("python", "sh"),
                ("python", "bash"),
            ];

            let child_name = child.name.to_lowercase();
            let grandparent_name = grandparent.name.to_lowercase();

            for (parent_pattern, child_pattern) in &suspicious_pairs {
                if grandparent_name.contains(parent_pattern)
                    && (child_name == *child_pattern || child_name.starts_with(child_pattern))
                {
                    let source = EventSource {
                        collector: "process-engine".to_string(),
                        host_id: "unknown".to_string(),
                        host_name: "unknown".to_string(),
                        agent_id: "process-engine-agent".to_string(),
                        process_name: Some(child.name.clone()),
                        process_id: Some(child.pid),
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
                        EventCategory::Process,
                        EventAction::Detected,
                        source,
                        format!(
                            "Suspicious process chain: {} -> {} -> {}",
                            grandparent.name, chain[1].name, child.name
                        ),
                        format!(
                            "Process {} (PID {}) spawned {} (PID {}) which spawned shell {} (PID {}). \
                             Web servers and database processes should not spawn interactive shells.",
                            grandparent.name,
                            grandparent.pid,
                            chain[1].name,
                            chain[1].pid,
                            child.name,
                            child.pid,
                        ),
                    )
                    .with_severity(Severity::High)
                    .with_confidence(0.9)
                    .with_risk_score(85.0)
                    .with_mitre(
                        "Execution",
                        "Command and Scripting Interpreter: Unix Shell",
                        "T1059.004",
                    );

                    event.affected_entities.push(Entity {
                        entity_type: EntityType::Process,
                        value: format!("{}:{}", child.pid, child.name),
                        risk_contribution: 40.0,
                    
                        metadata: std::collections::HashMap::new(),
                    });
                    event.affected_entities.push(Entity {
                        entity_type: EntityType::Process,
                        value: format!("{}:{}", grandparent.pid, grandparent.name),
                        risk_contribution: 30.0,
                    
                        metadata: std::collections::HashMap::new(),
                    });

                    return Some(event);
                }
            }
        }

        None
    }

    fn detect_spoofing(&self, pid: u32) -> Option<SecurityEvent> {
        let process = self.processes.get(&pid)?;
        let info = process.value().clone();

        let mut is_suspicious = false;
        let mut spoofing_indicator = String::new();

        if info.name.to_lowercase().contains("kworker") && info.pid > 1000 {
            is_suspicious = true;
            spoofing_indicator = "kworker name used by non-kernel process".to_string();
        }

        if let Some(cmd) = info.command_line.split_whitespace().next() {
            let basename = std::path::Path::new(cmd)
                .file_name()
                .map(|f| f.to_string_lossy().to_string())
                .unwrap_or_default();

            if basename != info.name {
                let cmdline_base = basename.to_lowercase();
                let proc_name = info.name.to_lowercase();

                let spoofing_pairs = vec![
                    ("sshd", "kworker"),
                    ("systemd", "kworker"),
                    ("dbus-daemon", "kworker"),
                    ("cron", "kworker"),
                    ("sshd", "migration"),
                    ("systemd", "migration"),
                ];

                for (real_proc, fake_name) in &spoofing_pairs {
                    if cmdline_base.contains(real_proc) && proc_name.contains(fake_name) {
                        is_suspicious = true;
                        spoofing_indicator = format!(
                            "Process claims to be {} but command line indicates {}",
                            fake_name, real_proc
                        );
                        break;
                    }
                }
            }
        }

        if info.pid > 1000
            && !info.command_line.is_empty()
            && info.name.to_lowercase() != "sh"
            && info.name.to_lowercase() != "bash"
            && info.name.to_lowercase() != "dash"
        {
            let looks_like_system = info.name.starts_with('[') && info.name.ends_with(']');
            if !looks_like_system && info.name.to_lowercase().starts_with("kworker") {
                is_suspicious = true;
                spoofing_indicator =
                    "Process masquerading as kernel worker thread".to_string();
            }
        }

        if is_suspicious {
            let source = EventSource {
                collector: "process-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "process-engine-agent".to_string(),
                process_name: Some(info.name.clone()),
                process_id: Some(info.pid),
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
                EventCategory::Process,
                EventAction::Detected,
                source,
                format!("Process name spoofing detected: PID {} ({})", info.pid, info.name),
                format!(
                    "Process with PID {} has suspicious name '{}'. {}.",
                    info.pid, info.name, spoofing_indicator
                ),
            )
            .with_severity(Severity::High)
            .with_confidence(0.85)
            .with_risk_score(80.0)
            .with_mitre(
                "Defense Evasion",
                "Process Injection: Process Hollowing",
                "T1055.012",
            );

            event.affected_entities.push(Entity {
                entity_type: EntityType::Process,
                value: format!("{}:{}", info.pid, info.name),
                risk_contribution: 40.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(event);
        }

        None
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        if event.category == EventCategory::Process
            && (event.action == EventAction::Created || event.action == EventAction::Started)
        {
            let pid = event
                .source
                .process_id
                .unwrap_or(0);
            let name = event
                .source
                .process_name
                .clone()
                .unwrap_or_else(|| "unknown".to_string());

            let parent_pid = event
                .metadata
                .get("parent_pid")
                .and_then(|v| v.as_u64())
                .map(|v| v as u32);

            let command_line = event
                .metadata
                .get("command_line")
                .and_then(|v| v.as_str())
                .unwrap_or("")
                .to_string();

            let process_info = ProcessInfo {
                pid,
                name: name.clone(),
                parent_pid,
                start_time: event.timestamp,
                command_line,
            };

            self.track_process(process_info);

            debug!("Tracking process {} (PID {})", name, pid);

            if let Some(suspicious_chain_event) = self.detect_suspicious_chain(pid) {
                warn!(
                    "Detected suspicious process chain for PID {}: {}",
                    pid,
                    suspicious_chain_event.title
                );
                detections.push(suspicious_chain_event);
            }

            if let Some(spoof_event) = self.detect_spoofing(pid) {
                warn!(
                    "Detected process spoofing for PID {}: {}",
                    pid,
                    spoof_event.title
                );
                detections.push(spoof_event);
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

    fn make_test_event(
        pid: u32,
        name: &str,
        parent_pid: Option<u32>,
        command_line: &str,
    ) -> SecurityEvent {
        let mut metadata = HashMap::new();
        if let Some(ppid) = parent_pid {
            metadata.insert(
                "parent_pid".to_string(),
                serde_json::Value::Number(serde_json::Number::from(ppid)),
            );
        }
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
            process_name: Some(name.to_string()),
            process_id: Some(pid),
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
            EventCategory::Process,
            EventAction::Created,
            source,
            format!("Process created: {}", name),
            format!("Process {} with PID {} created", name, pid),
        );
        event.metadata = metadata;
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = ProcessEngine::new();
        assert!(engine.processes.is_empty());
    }

    #[test]
    fn test_track_process() {
        let mut engine = ProcessEngine::new();
        let event = make_test_event(100, "nginx", Some(1), "/usr/sbin/nginx");
        engine.process_event(&event);
        assert!(engine.processes.contains_key(&100));
    }

    #[test]
    fn test_suspicious_chain_detection() {
        let mut engine = ProcessEngine::new();

        let web_event = make_test_event(500, "nginx", Some(1), "/usr/sbin/nginx");
        engine.process_event(&web_event);

        let mid_event = make_test_event(501, "php-fpm", Some(500), "/usr/sbin/php-fpm");
        engine.process_event(&mid_event);

        let shell_event = make_test_event(502, "bash", Some(501), "/bin/bash");
        let detections = engine.process_event(&shell_event);

        assert_eq!(detections.len(), 1);
        assert_eq!(detections[0].severity, Severity::High);
        assert!(detections[0].mitre_id.as_deref() == Some("T1059.004"));
    }

    #[test]
    fn test_spoofing_detection() {
        let mut engine = ProcessEngine::new();

        let event = make_test_event(5000, "kworker", Some(1), "/usr/sbin/sshd");
        let detections = engine.process_event(&event);

        assert_eq!(detections.len(), 1);
        assert_eq!(detections[0].severity, Severity::High);
    }
}
