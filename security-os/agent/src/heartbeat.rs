use std::time::Duration;

use chrono::Utc;
use security_os_core::bus::EventBus;
use security_os_core::{SecurityEvent, EventCategory, EventAction, EventSource, Severity};
use tokio::sync::broadcast;

use crate::collector::CollectorHealth;
use crate::errors::AgentError;

pub struct HeartbeatLoop {
    agent_id: String,
    interval: Duration,
    bus: EventBus,
    shutdown: broadcast::Sender<()>,
}

impl HeartbeatLoop {
    pub fn new(agent_id: String, interval: Duration, bus: EventBus) -> Self {
        let (shutdown, _) = broadcast::channel(1);
        Self {
            agent_id,
            interval,
            bus,
            shutdown,
        }
    }

    pub async fn start(&self, collector_health: Vec<CollectorHealth>) -> Result<(), AgentError> {
        let mut interval = tokio::time::interval(self.interval);
        let mut shutdown_rx = self.shutdown.subscribe();

        loop {
            tokio::select! {
                _ = interval.tick() => {
                    let heartbeat = self.build_heartbeat_event(&collector_health);
                    self.bus.publish(heartbeat);
                }
                _ = shutdown_rx.recv() => {
                    tracing::info!("heartbeat loop shutting down");
                    break;
                }
            }
        }
        Ok(())
    }

    pub fn shutdown(&self) {
        let _ = self.shutdown.send(());
    }

    fn build_heartbeat_event(
        &self,
        collector_health: &[CollectorHealth],
    ) -> SecurityEvent {
        let hostname = hostname::get()
            .map(|h| h.to_string_lossy().to_string())
            .unwrap_or_else(|_| "unknown".to_string());
        let active: Vec<String> = collector_health
            .iter()
            .map(|h| h.name.clone())
            .collect();
        let event = SecurityEvent::new(
            EventCategory::System,
            EventAction::Created,
            EventSource {
                collector: "heartbeat".to_string(),
                host_id: self.agent_id.clone(),
                host_name: hostname,
                agent_id: self.agent_id.clone(),
                agent_version: Some(env!("CARGO_PKG_VERSION").to_string()),
                process_name: None,
                process_id: None,
                user_id: None,
                user_name: None,
                container_id: None,
                container_name: None,
                pod_name: None,
                namespace: None,
                service_name: None,
            },
            "Agent Heartbeat",
            format!("Active collectors: {}", active.join(", ")),
        )
        .with_severity(Severity::Informational)
        .with_metadata("active_collectors", serde_json::to_value(&active).unwrap());
        event
    }
}
