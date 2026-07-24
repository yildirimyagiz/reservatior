use std::time::{Duration, Instant};

use dashmap::DashMap;
use security_os_core::bus::EventBus;
use security_os_core::event::ResponsePolicy;
use security_os_normalizer::{NormalizerPipeline, NormalizerRegistry, default_registry};
use tokio::sync::broadcast;

use crate::collector::Collector;
use crate::config::AgentConfig;
use crate::errors::AgentError;
use crate::heartbeat::HeartbeatLoop;
use crate::identity::AgentIdentity;
use crate::lifecycle::{AgentState, LifecycleManager};
use crate::policy::PolicyManager;

#[derive(Debug, Clone)]
pub struct AgentStats {
    pub uptime_secs: u64,
    pub events_processed: u64,
    pub events_per_second: f64,
    pub collectors_active: usize,
    pub policies_active: usize,
    pub state: AgentState,
}

pub struct Agent {
    config: AgentConfig,
    identity: AgentIdentity,
    bus: EventBus,
    normalizer: NormalizerPipeline,
    lifecycle: LifecycleManager,
    heartbeat: HeartbeatLoop,
    policy_manager: PolicyManager,
    collectors: DashMap<String, Box<dyn Collector>>,
    shutdown_tx: broadcast::Sender<()>,
    started_at: Option<Instant>,
    events_processed: u64,
}

impl Agent {
    pub fn new(config: AgentConfig) -> Result<Self, AgentError> {
        let hostname = config.hostname.clone();
        let identity = match &config.agent_id {
            Some(id) => AgentIdentity {
                agent_id: id.clone(),
                hostname: hostname.clone(),
                enrolled_at: None,
                certificate_pem: None,
                private_key_pem: None,
                ca_certificate_pem: None,
                fingerprint: AgentIdentity::fingerprint(id, &hostname),
            },
            None => AgentIdentity::generate(&hostname),
        };

        let bus = EventBus::new(10_000);
        let registry = default_registry();
        let normalizer = NormalizerPipeline::new(registry);
        let lifecycle = LifecycleManager::new();
        let heartbeat = HeartbeatLoop::new(
            identity.agent_id.clone(),
            Duration::from_secs(config.heartbeat_interval_secs),
            bus.clone(),
        );
        let policy_manager = PolicyManager::new(bus.clone());
        let (shutdown_tx, _) = broadcast::channel(1);

        Ok(Self {
            config,
            identity,
            bus,
            normalizer,
            lifecycle,
            heartbeat,
            policy_manager,
            collectors: DashMap::new(),
            shutdown_tx,
            started_at: None,
            events_processed: 0,
        })
    }

    pub async fn start(&mut self) -> Result<(), AgentError> {
        if self.lifecycle.current_state() == &AgentState::Unenrolled {
            self.lifecycle
                .transition(AgentState::Enrolling, "auto-enroll on start")?;
            self.lifecycle
                .transition(AgentState::Enrolled, "auto-enrolled on start")?;
        }
        self.lifecycle
            .transition(AgentState::Connected, "agent started")?;
        self.started_at = Some(Instant::now());
        tracing::info!(
            agent_id = %self.identity.agent_id,
            hostname = %self.identity.hostname,
            "agent started"
        );
        Ok(())
    }

    pub async fn stop(&mut self) -> Result<(), AgentError> {
        self.heartbeat.shutdown();
        let _ = self.shutdown_tx.send(());
        self.lifecycle
            .transition(AgentState::Disconnected, "agent stopped")?;
        tracing::info!(agent_id = %self.identity.agent_id, "agent stopped");
        Ok(())
    }

    pub async fn enroll(&mut self, server_url: &str) -> Result<(), AgentError> {
        self.lifecycle
            .transition(AgentState::Enrolling, "enrollment started")?;
        tracing::info!(server = server_url, "enrolling agent");
        self.lifecycle
            .transition(AgentState::Enrolled, "enrollment completed")?;
        Ok(())
    }

    pub fn register_collector(&self, collector: Box<dyn Collector>) {
        let name = collector.name().to_string();
        tracing::info!(collector = %name, "registered collector");
        self.collectors.insert(name, collector);
    }

    pub fn state(&self) -> &AgentState {
        self.lifecycle.current_state()
    }

    pub fn stats(&self) -> AgentStats {
        let uptime = self
            .started_at
            .map(|t| t.elapsed().as_secs())
            .unwrap_or(0);
        let eps = if uptime > 0 {
            self.events_processed as f64 / uptime as f64
        } else {
            0.0
        };

        AgentStats {
            uptime_secs: uptime,
            events_processed: self.events_processed,
            events_per_second: eps,
            collectors_active: self.collectors.len(),
            policies_active: self.policy_manager.active_policies().len(),
            state: self.lifecycle.current_state().clone(),
        }
    }

    pub fn identity(&self) -> &AgentIdentity {
        &self.identity
    }

    pub fn config(&self) -> &AgentConfig {
        &self.config
    }

    pub fn bus(&self) -> &EventBus {
        &self.bus
    }

    pub fn normalizer(&self) -> &NormalizerPipeline {
        &self.normalizer
    }

    pub fn policy_manager(&self) -> &PolicyManager {
        &self.policy_manager
    }

    pub fn apply_policy(&self, policy: ResponsePolicy) -> Result<(), AgentError> {
        self.policy_manager.apply_policy(policy)
    }
}
