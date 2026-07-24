use std::collections::{HashMap, HashSet};
use std::time::Duration;

use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, SecurityOsError,
    Severity,
};
use sysinfo::{ProcessesToUpdate, System};
use tracing::{debug, info, warn};

pub struct ProcessCollector {
    allowed_binaries: HashSet<String>,
    baseline: HashMap<u32, ProcessInfo>,
}

#[derive(Debug, Clone)]
struct ProcessInfo {
    pid: u32,
    name: String,
    cmd: String,
    uid: u32,
}

impl ProcessCollector {
    pub fn new(allowed_binaries: Vec<String>) -> Self {
        let allowed_binaries: HashSet<String> =
            allowed_binaries.into_iter().map(|b| b.to_lowercase()).collect();

        let mut sys = System::new_all();
        sys.refresh_processes(ProcessesToUpdate::All);
        let baseline = Self::snapshot_processes(&sys);

        info!(
            baseline_count = baseline.len(),
            allowed_count = allowed_binaries.len(),
            "Process collector initialized"
        );

        Self {
            allowed_binaries,
            baseline,
        }
    }

    fn snapshot_processes(sys: &System) -> HashMap<u32, ProcessInfo> {
        sys.processes()
            .iter()
            .map(|(pid, proc_)| {
                let pid_u32 = pid.as_u32();
                let info = ProcessInfo {
                    pid: pid_u32,
                    name: proc_.name().to_string_lossy().to_string(),
                    cmd: proc_
                        .cmd()
                        .iter()
                        .map(|s| s.to_string_lossy().to_string())
                        .collect::<Vec<_>>()
                        .join(" "),
                    uid: proc_.user_id().map(|u| **u).unwrap_or(0),
                };
                (pid_u32, info)
            })
            .collect()
    }

    pub fn scan(&mut self) -> Vec<SecurityEvent> {
        let mut sys = System::new_all();
        sys.refresh_processes(ProcessesToUpdate::All);
        let current = Self::snapshot_processes(&sys);

        let mut events = Vec::new();

        let current_pids: HashSet<u32> = current.keys().copied().collect();
        let baseline_pids: HashSet<u32> = self.baseline.keys().copied().collect();

        for pid in current_pids.difference(&baseline_pids) {
            if let Some(proc_info) = current.get(pid) {
                let is_allowed = self.allowed_binaries.contains(&proc_info.name.to_lowercase());
                let severity = if is_allowed {
                    Severity::Informational
                } else {
                    warn!(
                        pid = proc_info.pid,
                        name = %proc_info.name,
                        "Unexpected process detected"
                    );
                    Severity::Medium
                };

                let mut event = SecurityEvent::new(
                    EventCategory::Process,
                    EventAction::Created,
                    source_from_process(proc_info, "process-collector"),
                    format!("Process created: {}", proc_info.name),
                    format!(
                        "New process detected (PID {}): {} {}",
                        proc_info.pid, proc_info.name, proc_info.cmd
                    ),
                )
                .with_severity(severity)
                .with_mitre("Execution", "Command and Scripting Interpreter", "T1059")
                .with_entity(Entity {
                    entity_type: EntityType::Process,
                    value: proc_info.name.clone(),
                    risk_contribution: if is_allowed { 0.0 } else { 15.0 },
                    metadata: HashMap::new(),
                })
                .with_tag(if is_allowed {
                    "allowed-process"
                } else {
                    "unexpected-process"
                });

                event.metadata.insert(
                    "pid".into(),
                    serde_json::Value::Number(proc_info.pid.into()),
                );
                event.metadata.insert(
                    "uid".into(),
                    serde_json::Value::Number(proc_info.uid.into()),
                );
                event
                    .metadata
                    .insert("cmd".into(), serde_json::Value::String(proc_info.cmd.clone()));

                events.push(event);
            }
        }

        for pid in baseline_pids.difference(&current_pids) {
            if let Some(proc_info) = self.baseline.get(pid) {
                let mut event = SecurityEvent::new(
                    EventCategory::Process,
                    EventAction::Stopped,
                    source_from_process(proc_info, "process-collector"),
                    format!("Process terminated: {}", proc_info.name),
                    format!(
                        "Process terminated (PID {}): {} {}",
                        proc_info.pid, proc_info.name, proc_info.cmd
                    ),
                )
                .with_severity(Severity::Informational)
                .with_mitre("Execution", "Command and Scripting Interpreter", "T1059")
                .with_entity(Entity {
                    entity_type: EntityType::Process,
                    value: proc_info.name.clone(),
                    risk_contribution: 0.0,
                    metadata: HashMap::new(),
                })
                .with_tag("process-terminated");

                event.metadata.insert(
                    "pid".into(),
                    serde_json::Value::Number(proc_info.pid.into()),
                );
                event.metadata.insert(
                    "uid".into(),
                    serde_json::Value::Number(proc_info.uid.into()),
                );
                event
                    .metadata
                    .insert("cmd".into(), serde_json::Value::String(proc_info.cmd.clone()));

                events.push(event);
            }
        }

        self.baseline = current;

        debug!(events_generated = events.len(), "Process scan completed");
        events
    }

    pub async fn run(
        &mut self,
        event_bus: security_os_core::EventBus,
        scan_interval: Duration,
    ) -> Result<(), SecurityOsError> {
        info!(
            interval_ms = scan_interval.as_millis() as u64,
            "Process collector starting"
        );

        loop {
            let events = self.scan();
            for event in events {
                debug!(
                    event_id = %event.id,
                    title = %event.title,
                    severity = %event.severity,
                    "Publishing process event"
                );
                event_bus.publish(event);
            }
            tokio::time::sleep(scan_interval).await;
        }
    }
}

fn source_from_process(info: &ProcessInfo, collector: &str) -> EventSource {
    let hostname = System::host_name().unwrap_or_else(|| "unknown".into());

    EventSource {
        collector: collector.into(),
        host_id: hostname.clone(),
        host_name: hostname,
        agent_id: "reservatior-edr-001".into(),
        process_name: Some(info.name.clone()),
        process_id: Some(info.pid),
        user_id: Some(info.uid.to_string()),
        user_name: None,
        container_id: None,
        container_name: None,
        pod_name: None,
        namespace: None,
        agent_version: None,
        service_name: None,
    }
}
