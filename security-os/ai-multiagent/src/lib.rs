pub mod traits;
pub mod agents;
pub mod orchestrator;
pub mod debate;
pub mod llm_client;
pub mod errors;

pub use traits::*;
pub use agents::*;
pub use orchestrator::*;
pub use debate::*;
pub use llm_client::*;
pub use errors::*;

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;
    use security_os_core::{
        Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
    };
    use std::collections::HashMap;
    use std::sync::atomic::Ordering;

    fn test_source() -> EventSource {
        EventSource {
            collector: "process".to_string(),
            host_id: "host-1".to_string(),
            host_name: "test-host".to_string(),
            agent_id: "agent-1".to_string(),
            agent_version: Some("1.0.0".to_string()),
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
            test_source(),
            "Suspicious connection",
            "Outbound connection to known C2 server",
        )
        .with_severity(Severity::High)
        .with_confidence(0.85)
        .with_risk_score(75.0)
    }

    fn test_context() -> AgentContext {
        AgentContext {
            event: test_event(),
            incident_id: Some("INC-001".to_string()),
            related_events: vec![],
            risk_score: 75.0,
            threat_intel: vec!["APT28 beacon pattern".to_string()],
            historical_context: Some("Similar events seen on this host before".to_string()),
            additional_data: HashMap::new(),
        }
    }

    // ─── Traits Tests ─────────────────────────────────────────────────────────

    #[test]
    fn test_agent_context_construction() {
        let event = test_event();
        let context = AgentContext {
            event: event.clone(),
            incident_id: Some("INC-123".to_string()),
            related_events: vec![event],
            risk_score: 85.0,
            threat_intel: vec!["Known C2 IP".to_string()],
            historical_context: Some("Previously compromised host".to_string()),
            additional_data: HashMap::new(),
        };

        assert_eq!(context.incident_id.unwrap(), "INC-123");
        assert_eq!(context.related_events.len(), 1);
        assert_eq!(context.risk_score, 85.0);
        assert_eq!(context.threat_intel.len(), 1);
    }

    #[test]
    fn test_agent_analysis_creation() {
        let analysis = AgentAnalysis {
            agent_role: AgentRole::Threat,
            agent_id: "test-agent-id".to_string(),
            summary: "Threat analysis complete".to_string(),
            confidence: 0.85,
            severity: Severity::High,
            recommended_actions: vec!["Block IP".to_string()],
            mitre_tactics: vec!["Command and Control".to_string()],
            indicators: vec!["IOC match".to_string()],
            metadata: HashMap::new(),
            analysis_timestamp: chrono::Utc::now(),
            duration_ms: 42,
        };

        assert_eq!(analysis.agent_role, AgentRole::Threat);
        assert_eq!(analysis.confidence, 0.85);
        assert_eq!(analysis.severity, Severity::High);
        assert_eq!(analysis.recommended_actions.len(), 1);
        assert_eq!(analysis.duration_ms, 42);
    }

    // ─── Agents Tests ─────────────────────────────────────────────────────────

    #[tokio::test]
    async fn test_collector_agent_analyze() {
        let agent = CollectorAgent::new();
        let context = test_context();
        let result = agent.analyze(&context).await.unwrap();
        assert_eq!(result.agent_role, AgentRole::Collector);
        assert!(!result.summary.is_empty());
        assert!(result.confidence > 0.0);
    }

    #[tokio::test]
    async fn test_detection_agent_analyze() {
        let agent = DetectionAgent::new();
        let mut event = test_event();
        event.rule_id = Some("RULE-001".to_string());
        event.rule_name = Some("C2 Beacon Detection".to_string());
        let context = AgentContext {
            event,
            incident_id: None,
            related_events: vec![],
            risk_score: 60.0,
            threat_intel: vec![],
            historical_context: None,
            additional_data: HashMap::new(),
        };
        let result = agent.analyze(&context).await.unwrap();
        assert_eq!(result.agent_role, AgentRole::Detection);
        assert!(result.indicators.iter().any(|i| i.contains("RULE-001")));
    }

    #[tokio::test]
    async fn test_threat_agent_analyze() {
        let agent = ThreatAgent::new();
        let mut event = test_event();
        event.mitre_tactic = Some("Command and Control".to_string());
        event.mitre_technique = Some("Application Layer Protocol".to_string());
        let context = AgentContext {
            event,
            incident_id: None,
            related_events: vec![],
            risk_score: 80.0,
            threat_intel: vec!["APT28 attribution".to_string()],
            historical_context: None,
            additional_data: HashMap::new(),
        };
        let result = agent.analyze(&context).await.unwrap();
        assert_eq!(result.agent_role, AgentRole::Threat);
        assert!(result.indicators.len() >= 2);
    }

    #[tokio::test]
    async fn test_malware_agent_analyze() {
        let agent = MalwareAgent::new();
        let mut event = test_event();
        event.file_hash_sha256 =
            Some("abc123def456abc123def456abc123def456abc123def456abc123def456abcd".to_string());
        event.file_path = Some("/tmp/suspicious.bin".to_string());
        let context = AgentContext {
            event,
            incident_id: None,
            related_events: vec![],
            risk_score: 70.0,
            threat_intel: vec![],
            historical_context: None,
            additional_data: HashMap::new(),
        };
        let result = agent.analyze(&context).await.unwrap();
        assert_eq!(result.agent_role, AgentRole::Malware);
        assert!(result.indicators.len() >= 2);
    }

    #[tokio::test]
    async fn test_cloud_agent_analyze() {
        let agent = CloudAgent::new();
        let mut source = test_source();
        source.container_id = Some("ctr-abc123".to_string());
        source.pod_name = Some("web-app-pod".to_string());
        source.namespace = Some("production".to_string());
        let event = SecurityEvent::new(
            EventCategory::Container,
            EventAction::Started,
            source,
            "Container started",
            "New container in production",
        );
        let context = AgentContext {
            event,
            incident_id: None,
            related_events: vec![],
            risk_score: 40.0,
            threat_intel: vec![],
            historical_context: None,
            additional_data: HashMap::new(),
        };
        let result = agent.analyze(&context).await.unwrap();
        assert_eq!(result.agent_role, AgentRole::Cloud);
        assert!(result.indicators.len() >= 2);
    }

    #[tokio::test]
    async fn test_business_agent_analyze() {
        let agent = BusinessAgent::new();
        let mut event = test_event();
        event.category = EventCategory::ReservatiorBusiness;
        event.business_context = Some("escrow-payment-processing".to_string());
        event.revenue_impact = Some(25000.0);
        event.affected_entities = vec![Entity {
            entity_type: EntityType::Escrow,
            value: "ESC-001".to_string(),
            risk_contribution: 0.5,
            metadata: HashMap::new(),
        }];
        let context = AgentContext {
            event,
            incident_id: None,
            related_events: vec![],
            risk_score: 90.0,
            threat_intel: vec![],
            historical_context: None,
            additional_data: HashMap::new(),
        };
        let result = agent.analyze(&context).await.unwrap();
        assert_eq!(result.agent_role, AgentRole::Business);
        assert!(result.indicators.len() >= 2);
        assert!(result
            .recommended_actions
            .iter()
            .any(|a| a.contains("financial")));
    }

    #[tokio::test]
    async fn test_soc_agent_analyze() {
        let agent = SocAgent::new();
        let context = test_context();
        let result = agent.analyze(&context).await.unwrap();
        assert_eq!(result.agent_role, AgentRole::SOC);
        assert!(!result.summary.is_empty());
        assert!(result.confidence > 0.0);
    }

    // ─── Orchestrator Tests ───────────────────────────────────────────────────

    #[tokio::test]
    async fn test_orchestrator_add_agents() {
        let mut orchestrator = AgentOrchestrator::new();
        orchestrator.add_agent(Box::new(CollectorAgent::new()));
        orchestrator.add_agent(Box::new(DetectionAgent::new()));
        orchestrator.add_agent(Box::new(ThreatAgent::new()));
        let context = test_context();
        let result = orchestrator.analyze_event(&context).await.unwrap();
        assert_eq!(result.analyses.len(), 3);
    }

    #[tokio::test]
    async fn test_orchestrator_analyze_event() {
        let mut orchestrator = AgentOrchestrator::new();
        orchestrator.add_agent(Box::new(ThreatAgent::new()));
        orchestrator.add_agent(Box::new(DetectionAgent::new()));
        orchestrator.add_agent(Box::new(SocAgent::new()));
        let context = test_context();
        let result = orchestrator.analyze_event(&context).await.unwrap();
        assert!(!result.analyses.is_empty());
        assert!(result.overall_confidence > 0.0);
        assert!(!result.recommended_actions.is_empty());
    }

    #[test]
    fn test_orchestrator_compute_consensus() {
        let analyses = vec![
            AgentAnalysis {
                agent_role: AgentRole::Threat,
                agent_id: "a1".to_string(),
                summary: "High threat".to_string(),
                confidence: 0.8,
                severity: Severity::High,
                recommended_actions: vec!["Block IP".to_string()],
                mitre_tactics: vec![],
                indicators: vec![],
                metadata: HashMap::new(),
                analysis_timestamp: Utc::now(),
                duration_ms: 10,
            },
            AgentAnalysis {
                agent_role: AgentRole::Detection,
                agent_id: "a2".to_string(),
                summary: "High detection".to_string(),
                confidence: 0.7,
                severity: Severity::High,
                recommended_actions: vec!["Tune rules".to_string()],
                mitre_tactics: vec![],
                indicators: vec![],
                metadata: HashMap::new(),
                analysis_timestamp: Utc::now(),
                duration_ms: 10,
            },
            AgentAnalysis {
                agent_role: AgentRole::Business,
                agent_id: "a3".to_string(),
                summary: "Medium business".to_string(),
                confidence: 0.6,
                severity: Severity::Medium,
                recommended_actions: vec!["Notify team".to_string()],
                mitre_tactics: vec![],
                indicators: vec![],
                metadata: HashMap::new(),
                analysis_timestamp: Utc::now(),
                duration_ms: 10,
            },
        ];

        let consensus = AgentOrchestrator::compute_consensus(&analyses);
        assert_eq!(consensus.majority_severity, Severity::High);
        assert!(consensus.agreement_level > 0.5);
        assert!(!consensus.dissenting_agents.is_empty());
        assert!(!consensus.consensus_actions.is_empty());
    }

    #[test]
    fn test_orchestrator_merge_actions() {
        let analyses = vec![
            AgentAnalysis {
                agent_role: AgentRole::Threat,
                agent_id: "a1".to_string(),
                summary: "s".to_string(),
                confidence: 0.8,
                severity: Severity::High,
                recommended_actions: vec!["Block IP".to_string(), "Investigate IOC".to_string()],
                mitre_tactics: vec![],
                indicators: vec![],
                metadata: HashMap::new(),
                analysis_timestamp: Utc::now(),
                duration_ms: 10,
            },
            AgentAnalysis {
                agent_role: AgentRole::Detection,
                agent_id: "a2".to_string(),
                summary: "s".to_string(),
                confidence: 0.7,
                severity: Severity::High,
                recommended_actions: vec!["Block IP".to_string(), "Tune rules".to_string()],
                mitre_tactics: vec![],
                indicators: vec![],
                metadata: HashMap::new(),
                analysis_timestamp: Utc::now(),
                duration_ms: 10,
            },
        ];

        let merged = AgentOrchestrator::merge_actions(&analyses);
        assert_eq!(merged.len(), 3);
        assert!(merged.contains(&"Block IP".to_string()));
        assert!(merged.contains(&"Investigate IOC".to_string()));
        assert!(merged.contains(&"Tune rules".to_string()));
    }

    // ─── Debate Tests ─────────────────────────────────────────────────────────

    #[test]
    fn test_debate_create_session() {
        let mut session = DebateSession::new("Is this a true positive?".to_string(), 3);
        session.add_participant(Box::new(ThreatAgent::new()));
        session.add_participant(Box::new(BusinessAgent::new()));
        let resolution = session.determine_resolution();
        assert_eq!(resolution.rounds_played, 0);
    }

    #[tokio::test]
    async fn test_debate_conduct() {
        let mut session = DebateSession::new("Threat severity assessment".to_string(), 2);
        session.add_participant(Box::new(ThreatAgent::new()));
        session.add_participant(Box::new(DetectionAgent::new()));
        session.add_participant(Box::new(SocAgent::new()));
        let context = test_context();
        let resolution = session.conduct_debate(&context).await.unwrap();
        assert!(resolution.rounds_played >= 1);
        assert!(resolution.rounds_played <= 2);
        assert!(!resolution.resolution.is_empty());
    }

    #[test]
    fn test_debate_determine_resolution() {
        let session = DebateSession::new("Test topic".to_string(), 3);
        let resolution = session.determine_resolution();
        assert_eq!(resolution.rounds_played, 0);
        assert_eq!(resolution.confidence, 0.0);
    }

    // ─── LLM Client Tests ────────────────────────────────────────────────────

    #[tokio::test]
    async fn test_mock_llm_client() {
        let client = MockLlmClient::new(vec![
            "First response".to_string(),
            "Second response".to_string(),
        ]);

        let result1 = client.complete("prompt1", None).await.unwrap();
        assert_eq!(result1, "First response");

        let result2 = client.complete("prompt2", None).await.unwrap();
        assert_eq!(result2, "Second response");

        let result3 = client.complete("prompt3", None).await.unwrap();
        assert_eq!(result3, "First response");
    }

    #[tokio::test]
    async fn test_mock_llm_client_call_counting() {
        let client = MockLlmClient::new(vec!["response".to_string()]);

        assert_eq!(client.call_count.load(Ordering::Relaxed), 0);

        let _ = client.complete("p1", None).await.unwrap();
        assert_eq!(client.call_count.load(Ordering::Relaxed), 1);

        let _ = client.complete("p2", Some("ctx")).await.unwrap();
        assert_eq!(client.call_count.load(Ordering::Relaxed), 2);

        let _ = client.complete("p3", None).await.unwrap();
        assert_eq!(client.call_count.load(Ordering::Relaxed), 3);
    }
}
