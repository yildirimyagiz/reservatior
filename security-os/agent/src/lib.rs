pub mod agent;
pub mod collector;
pub mod config;
pub mod errors;
pub mod heartbeat;
pub mod identity;
pub mod lifecycle;
pub mod policy;

pub use agent::{Agent, AgentStats};
pub use collector::{Collector, CollectorHealth, CollectorStatus};
pub use config::{AgentConfig, TlsConfig};
pub use errors::AgentError;
pub use heartbeat::HeartbeatLoop;
pub use identity::{AgentIdentity, CertInfo};
pub use lifecycle::{AgentState, LifecycleManager, StateTransition};
pub use policy::PolicyManager;

#[cfg(test)]
mod tests {
    use super::*;
    use crate::collector::MockCollector;
    use security_os_core::bus::EventBus;
    use std::time::Duration;

    #[test]
    fn test_agent_identity_generate() {
        let identity = AgentIdentity::generate("test-host");
        assert!(!identity.agent_id.is_empty());
        assert_eq!(identity.hostname, "test-host");
        assert!(!identity.fingerprint.is_empty());
        assert!(!identity.is_enrolled());
    }

    #[test]
    fn test_agent_identity_fingerprint_deterministic() {
        let fp1 = AgentIdentity::fingerprint("agent-1", "host-a");
        let fp2 = AgentIdentity::fingerprint("agent-1", "host-a");
        assert_eq!(fp1, fp2);
    }

    #[test]
    fn test_agent_identity_fingerprint_unique() {
        let fp1 = AgentIdentity::fingerprint("agent-1", "host-a");
        let fp2 = AgentIdentity::fingerprint("agent-2", "host-a");
        assert_ne!(fp1, fp2);
    }

    #[test]
    fn test_agent_config_defaults() {
        let config = AgentConfig::defaults();
        assert!(!config.hostname.is_empty());
        assert_eq!(config.heartbeat_interval_secs, 30);
        assert_eq!(config.event_buffer_size, 10_000);
        assert!(!config.collectors.is_empty());
        assert!(config.tls.verify_server);
    }

    #[test]
    fn test_agent_config_validate_empty_server() {
        let mut config = AgentConfig::defaults();
        config.server_url = String::new();
        assert!(config.validate().is_err());
    }

    #[test]
    fn test_agent_config_validate_zero_heartbeat() {
        let mut config = AgentConfig::defaults();
        config.heartbeat_interval_secs = 0;
        assert!(config.validate().is_err());
    }

    #[test]
    fn test_lifecycle_manager_transitions() {
        let mut lm = LifecycleManager::new();
        assert_eq!(lm.current_state(), &AgentState::Unenrolled);
        assert!(!lm.is_active());

        lm.transition(AgentState::Enrolling, "start enroll").unwrap();
        assert_eq!(lm.current_state(), &AgentState::Enrolling);

        lm.transition(AgentState::Enrolled, "enrolled").unwrap();
        assert!(lm.is_active());

        lm.transition(AgentState::Connected, "connected").unwrap();
        assert!(lm.is_active());

        lm.transition(AgentState::Disconnected, "disconnected").unwrap();
        assert!(!lm.is_active());

        assert_eq!(lm.history().len(), 4);
    }

    #[test]
    fn test_lifecycle_manager_invalid_transition() {
        let mut lm = LifecycleManager::new();
        let result = lm.transition(AgentState::Connected, "bad transition");
        assert!(result.is_err());
    }

    #[test]
    fn test_policy_manager_add_remove() {
        let bus = EventBus::new(100);
        let pm = PolicyManager::new(bus);
        assert!(pm.current_version().is_none());
        assert!(pm.active_policies().is_empty());

        let mut policy = security_os_core::ResponsePolicy {
            id: "pol-1".to_string(),
            name: "test policy".to_string(),
            enabled: true,
            conditions: vec![],
            actions: vec![],
            cooldown_secs: 60,
            auto_response_enabled: false,
        };
        pm.apply_policy(policy).unwrap();
        assert_eq!(pm.active_policies().len(), 1);

        let removed = pm.remove_policy("pol-1");
        assert!(removed);
        assert!(pm.active_policies().is_empty());

        let not_removed = pm.remove_policy("pol-999");
        assert!(!not_removed);
    }

    #[test]
    fn test_heartbeat_loop_construction() {
        let bus = EventBus::new(100);
        let hb = HeartbeatLoop::new(
            "test-agent".to_string(),
            Duration::from_secs(30),
            bus,
        );
    }

    #[tokio::test]
    async fn test_mock_collector() {
        let mut collector = MockCollector::new("test-collector");
        assert_eq!(collector.name(), "test-collector");

        let health = collector.health().await;
        assert!(matches!(health.status, CollectorStatus::Stopped));

        collector.start().await.unwrap();
        let health = collector.health().await;
        assert!(matches!(health.status, CollectorStatus::Running { .. }));

        collector.stop().await.unwrap();
        let health = collector.health().await;
        assert!(matches!(health.status, CollectorStatus::Stopped));
    }

    #[tokio::test]
    async fn test_agent_construction_and_start() {
        let config = AgentConfig::defaults();
        let mut agent = Agent::new(config).unwrap();
        assert_eq!(agent.state(), &AgentState::Unenrolled);

        agent.start().await.unwrap();
        assert_eq!(agent.state(), &AgentState::Connected);

        let stats = agent.stats();
        assert!(stats.uptime_secs < 2);

        agent.stop().await.unwrap();
        assert_eq!(agent.state(), &AgentState::Disconnected);
    }

    #[tokio::test]
    async fn test_agent_register_collector() {
        let config = AgentConfig::defaults();
        let agent = Agent::new(config).unwrap();
        let collector: Box<dyn Collector> = Box::new(MockCollector::new("proc"));
        agent.register_collector(collector);
        assert_eq!(agent.stats().collectors_active, 1);
    }

    #[test]
    fn test_agent_identity_certificate_info_none() {
        let identity = AgentIdentity::generate("test-host");
        assert!(identity.certificate_info().is_none());
    }
}
