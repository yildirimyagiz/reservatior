use reqwest::Client;
use security_os_core::SecurityEvent;
use serde::{Deserialize, Serialize};
use std::time::Duration;
use tracing::{info, warn};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IncidentAnalysis {
    pub summary: String,
    pub threat_classification: String,
    pub mitre_tactic: String,
    pub mitre_technique: String,
    pub root_cause: String,
    pub recommended_response: Vec<String>,
    pub false_positive_probability: f64,
    pub confidence: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AiAnalysis {
    pub summary: String,
    pub kill_chain_phase: Option<String>,
    pub mitre_tactic: String,
    pub mitre_technique: String,
    pub root_cause: String,
    pub false_positive_probability: f64,
    pub confidence: f64,
    pub business_impact: String,
    pub affected_assets: Vec<String>,
    pub recommended_response: Vec<String>,
    pub evidence_summary: String,
    pub similar_incidents: Vec<String>,
}

#[derive(Debug, Serialize)]
struct LlmMessage {
    role: String,
    content: String,
}

#[derive(Debug, Serialize)]
struct LlmRequest {
    model: String,
    messages: Vec<LlmMessage>,
    temperature: f64,
    max_tokens: u32,
}

#[derive(Debug, Deserialize)]
struct LlmResponse {
    choices: Vec<LlmChoice>,
}

#[derive(Debug, Deserialize)]
struct LlmChoice {
    message: LlmChoiceMessage,
}

#[derive(Debug, Deserialize)]
struct LlmChoiceMessage {
    content: String,
}

pub struct AiEngine {
    api_url: String,
    api_key: String,
    model: String,
    threshold: f64,
    client: Client,
}

impl AiEngine {
    pub fn new(api_url: String, api_key: String, model: String, threshold: f64) -> Self {
        let client = Client::builder()
            .timeout(Duration::from_secs(60))
            .build()
            .expect("failed to build HTTP client");

        Self {
            api_url,
            api_key,
            model,
            threshold,
            client,
        }
    }

    pub async fn analyze_incident(
        &self,
        events: &[SecurityEvent],
        risk_score: f64,
    ) -> Option<IncidentAnalysis> {
        if risk_score < self.threshold {
            info!(
                "risk score {} below threshold {}, skipping AI analysis",
                risk_score, self.threshold
            );
            return None;
        }

        let prompt = self.build_prompt(events, risk_score);
        let request = LlmRequest {
            model: self.model.clone(),
            messages: vec![LlmMessage {
                role: "user".into(),
                content: prompt,
            }],
            temperature: 0.3,
            max_tokens: 2048,
        };

        let endpoint = format!("{}/v1/chat/completions", self.api_url.trim_end_matches('/'));

        let response = match self
            .client
            .post(&endpoint)
            .header("Authorization", format!("Bearer {}", self.api_key))
            .json(&request)
            .send()
            .await
        {
            Ok(r) => r,
            Err(e) => {
                warn!("AI API request failed: {}", e);
                return None;
            }
        };

        if !response.status().is_success() {
            let status = response.status();
            let body = response.text().await.unwrap_or_default();
            warn!("AI API returned {}: {}", status, body);
            return None;
        }

        let llm_response: LlmResponse = match response.json().await {
            Ok(r) => r,
            Err(e) => {
                warn!("failed to parse AI API response: {}", e);
                return None;
            }
        };

        let content = match llm_response.choices.first() {
            Some(c) => c.message.content.clone(),
            None => {
                warn!("AI API returned no choices");
                return None;
            }
        };

        match self.parse_analysis(&content) {
            Some(analysis) => {
                info!("AI analysis completed with confidence {:.2}", analysis.confidence);
                Some(analysis)
            }
            None => {
                warn!("failed to parse AI analysis from response");
                None
            }
        }
    }

    pub async fn analyze_with_context(
        &self,
        events: &[SecurityEvent],
        risk_score: f64,
        correlation_chains: &[String],
    ) -> Option<AiAnalysis> {
        if risk_score < self.threshold {
            info!(
                "risk score {} below threshold {}, skipping context-aware AI analysis",
                risk_score, self.threshold
            );
            return None;
        }

        let prompt = self.build_context_prompt(events, risk_score, correlation_chains);
        let request = LlmRequest {
            model: self.model.clone(),
            messages: vec![LlmMessage {
                role: "user".into(),
                content: prompt,
            }],
            temperature: 0.2,
            max_tokens: 4096,
        };

        let endpoint = format!("{}/v1/chat/completions", self.api_url.trim_end_matches('/'));

        let response = match self
            .client
            .post(&endpoint)
            .header("Authorization", format!("Bearer {}", self.api_key))
            .json(&request)
            .send()
            .await
        {
            Ok(r) => r,
            Err(e) => {
                warn!("AI context API request failed: {}", e);
                return None;
            }
        };

        if !response.status().is_success() {
            let status = response.status();
            let body = response.text().await.unwrap_or_default();
            warn!("AI context API returned {}: {}", status, body);
            return None;
        }

        let llm_response: LlmResponse = match response.json().await {
            Ok(r) => r,
            Err(e) => {
                warn!("failed to parse AI context API response: {}", e);
                return None;
            }
        };

        let content = match llm_response.choices.first() {
            Some(c) => c.message.content.clone(),
            None => {
                warn!("AI context API returned no choices");
                return None;
            }
        };

        match self.parse_ai_analysis(&content) {
            Some(analysis) => {
                info!(
                    "AI context analysis completed with confidence {:.2}",
                    analysis.confidence
                );
                Some(analysis)
            }
            None => {
                warn!("failed to parse AI context analysis from response");
                None
            }
        }
    }

    pub fn build_kill_chain_analysis(&self, events: &[SecurityEvent]) -> String {
        let formatted_events: String = events
            .iter()
            .enumerate()
            .map(|(i, e)| {
                let kill_chain = e
                    .tags
                    .iter()
                    .find(|t| {
                        matches!(
                            t.as_str(),
                            "Reconnaissance"
                                | "Weaponization"
                                | "Delivery"
                                | "Exploitation"
                                | "Installation"
                                | "Command and Control"
                                | "Actions on Objectives"
                        )
                    })
                    .map(|s| s.as_str())
                    .unwrap_or("Unknown");

                format!(
                    "Event {}:\n  ID: {}\n  Timestamp: {}\n  Category: {:?}\n  Action: {:?}\n  Severity: {:?}\n  Title: {}\n  Kill Chain: {}\n  MITRE: {:?}/{:?}/{:?}\n  Source Host: {}\n  Tags: {:?}\n",
                    i + 1,
                    e.id,
                    e.timestamp,
                    e.category,
                    e.action,
                    e.severity,
                    e.title,
                    kill_chain,
                    e.mitre_tactic,
                    e.mitre_technique,
                    e.mitre_id,
                    e.source.host_name,
                    e.tags,
                )
            })
            .collect();

        format!(
            r#"Perform a kill chain analysis on these security events.

Identify:
1. Which kill chain phase(s) are represented
2. Progression through the kill chain (if multi-stage)
3. Which phase the attacker is currently in
4. Predicted next phase based on observed behavior
5. Gaps in detection coverage

Kill Chain Phases: Reconnaissance -> Weaponization -> Delivery -> Exploitation -> Installation -> Command and Control -> Actions on Objectives

Respond with valid JSON in this exact format:
{{
  "current_phase": "...",
  "phases_observed": ["phase1", "phase2"],
  "progression_analysis": "...",
  "predicted_next_phase": "...",
  "detection_gaps": ["gap1", "gap2"],
  "confidence": 0.0
}}

Events:
{}"#,
            formatted_events
        )
    }

    pub fn build_business_impact_analysis(&self, events: &[SecurityEvent]) -> String {
        let formatted_events: String = events
            .iter()
            .enumerate()
            .map(|(i, e)| {
                format!(
                    "Event {}:\n  ID: {}\n  Category: {:?}\n  Severity: {:?}\n  Title: {}\n  Description: {}\n  Business Context: {:?}\n  Revenue Impact: {:?}\n  Affected Assets: {:?}\n  Source Host: {} ({})\n  Tags: {:?}\n",
                    i + 1,
                    e.id,
                    e.category,
                    e.severity,
                    e.title,
                    e.description,
                    e.business_context,
                    e.revenue_impact,
                    e.affected_entities
                        .iter()
                        .map(|a| format!("{:?}:{}", a.entity_type, a.value))
                        .collect::<Vec<_>>(),
                    e.source.host_name,
                    e.source.host_id,
                    e.tags,
                )
            })
            .collect();

        format!(
            r#"Analyze the business impact of these security events for the Reservatior platform (property rental/escrow system).

Consider:
1. Impact on reservation processing and escrow transactions
2. Risk to payment processing and financial data
3. Impact on customer trust and platform availability
4. Regulatory compliance implications (PCI-DSS, GDPR)
5. Revenue impact from downtime or data breach
6. Supply chain and third-party integration risks

Respond with valid JSON in this exact format:
{{
  "business_impact_summary": "...",
  "affected_services": ["service1", "service2"],
  "revenue_risk": "...",
  "customer_impact": "...",
  "compliance_risk": "...",
  "recovery_priority": "critical|high|medium|low",
  "estimated_recovery_time": "...",
  "confidence": 0.0
}}

Events:
{}"#,
            formatted_events
        )
    }

    pub fn calculate_confidence(&self, events_count: u32, risk_score: f64) -> f64 {
        let base_confidence = (risk_score / 100.0).min(1.0);
        let evidence_bonus = if events_count >= 10 {
            0.15
        } else if events_count >= 5 {
            0.10
        } else if events_count >= 2 {
            0.05
        } else {
            0.0
        };
        let diminishing = 1.0 / (1.0 + (events_count as f64 / 20.0).ln());
        let raw = base_confidence * diminishing + evidence_bonus;
        raw.clamp(0.1, 0.99)
    }

    fn build_prompt(&self, events: &[SecurityEvent], risk_score: f64) -> String {
        let formatted_events: String = events
            .iter()
            .enumerate()
            .map(|(i, e)| {
                format!(
                    "Event {}:\n  ID: {}\n  Timestamp: {}\n  Category: {:?}\n  Action: {:?}\n  Severity: {:?}\n  Title: {}\n  Description: {}\n  Confidence: {:.2}\n  Source Host: {}\n  Source Agent: {}\n  MITRE: {:?}/{:?}/{:?}\n  Tags: {:?}\n  Metadata: {}\n",
                    i + 1,
                    e.id,
                    e.timestamp,
                    e.category,
                    e.action,
                    e.severity,
                    e.title,
                    e.description,
                    e.confidence,
                    e.source.host_name,
                    e.source.agent_id,
                    e.mitre_tactic,
                    e.mitre_technique,
                    e.mitre_id,
                    e.tags,
                    serde_json::to_string(&e.metadata).unwrap_or_default(),
                )
            })
            .collect();

        format!(
            r#"Analyze these security events and provide:
1. Summary of the incident
2. Threat classification
3. MITRE ATT&CK tactic and technique
4. Root cause analysis
5. Recommended response actions
6. False positive probability (0-1)

Respond with valid JSON in this exact format:
{{
  "summary": "...",
  "threat_classification": "...",
  "mitre_tactic": "...",
  "mitre_technique": "...",
  "root_cause": "...",
  "recommended_response": ["action1", "action2"],
  "false_positive_probability": 0.0,
  "confidence": 0.0
}}

Events:
{}
Risk Score: {:.0}/100"#,
            formatted_events, risk_score
        )
    }

    fn build_context_prompt(
        &self,
        events: &[SecurityEvent],
        risk_score: f64,
        correlation_chains: &[String],
    ) -> String {
        let formatted_events: String = events
            .iter()
            .enumerate()
            .map(|(i, e)| {
                let kill_chain = e
                    .tags
                    .iter()
                    .find(|t| {
                        matches!(
                            t.as_str(),
                            "Reconnaissance"
                                | "Weaponization"
                                | "Delivery"
                                | "Exploitation"
                                | "Installation"
                                | "Command and Control"
                                | "Actions on Objectives"
                        )
                    })
                    .map(|s| s.as_str())
                    .unwrap_or("Unknown");

                format!(
                    "Event {}:\n  ID: {}\n  Timestamp: {}\n  Category: {:?}\n  Action: {:?}\n  Severity: {:?}\n  Title: {}\n  Description: {}\n  Confidence: {:.2}\n  Risk Score: {}\n  Source Host: {} ({})\n  MITRE: {:?}/{:?}/{:?}\n  Kill Chain: {}\n  Tags: {:?}\n  IOC Matches: {:?}\n  Affected Entities: {:?}\n  Business Context: {:?}\n  Metadata: {}\n",
                    i + 1,
                    e.id,
                    e.timestamp,
                    e.category,
                    e.action,
                    e.severity,
                    e.title,
                    e.description,
                    e.confidence,
                    e.risk_score,
                    e.source.host_name,
                    e.source.host_id,
                    e.mitre_tactic,
                    e.mitre_technique,
                    e.mitre_id,
                    kill_chain,
                    e.tags,
                    e.ioc_matches
                        .iter()
                        .map(|m| format!("{}:{}", m.ioc_type, m.ioc_value))
                        .collect::<Vec<_>>(),
                    e.affected_entities
                        .iter()
                        .map(|a| format!("{:?}:{}", a.entity_type, a.value))
                        .collect::<Vec<_>>(),
                    e.business_context,
                    serde_json::to_string(&e.metadata).unwrap_or_default(),
                )
            })
            .collect();

        let chains_str = if correlation_chains.is_empty() {
            "No correlation chains available.".to_string()
        } else {
            correlation_chains
                .iter()
                .enumerate()
                .map(|(i, c)| format!("Chain {}: {}", i + 1, c))
                .collect::<Vec<_>>()
                .join("\n")
        };

        format!(
            r#"Perform deep security analysis with full context on these events for the Reservatior platform.

Provide:
1. Comprehensive incident summary with kill chain positioning
2. MITRE ATT&CK mapping (tactic, technique, sub-technique)
3. Root cause analysis with evidence chain
4. Business impact on Reservatior (reservations, escrow, payments)
5. Affected assets and services
6. False positive probability assessment
7. Recommended response actions (prioritized)
8. Similar known incidents or patterns
9. Evidence quality assessment

Correlation Chains:
{}

Respond with valid JSON in this exact format:
{{
  "summary": "...",
  "kill_chain_phase": "...",
  "mitre_tactic": "...",
  "mitre_technique": "...",
  "root_cause": "...",
  "false_positive_probability": 0.0,
  "confidence": 0.0,
  "business_impact": "...",
  "affected_assets": ["asset1", "asset2"],
  "recommended_response": ["action1", "action2"],
  "evidence_summary": "...",
  "similar_incidents": ["incident_ref1", "incident_ref2"]
}}

Events:
{}
Risk Score: {:.0}/100"#,
            chains_str, formatted_events, risk_score
        )
    }

    fn parse_analysis(&self, content: &str) -> Option<IncidentAnalysis> {
        let trimmed = content.trim();

        let json_str = if let Some(start) = trimmed.find('{') {
            if let Some(end) = trimmed.rfind('}') {
                &trimmed[start..=end]
            } else {
                trimmed
            }
        } else {
            trimmed
        };

        serde_json::from_str(json_str).ok()
    }

    fn parse_ai_analysis(&self, content: &str) -> Option<AiAnalysis> {
        let trimmed = content.trim();

        let json_str = if let Some(start) = trimmed.find('{') {
            if let Some(end) = trimmed.rfind('}') {
                &trimmed[start..=end]
            } else {
                trimmed
            }
        } else {
            trimmed
        };

        serde_json::from_str(json_str).ok()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{
        Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
    };

    fn test_source() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "test-host".into(),
            agent_id: "agent-1".into(),
            process_name: Some("suspicious.exe".into()),
            process_id: Some(5678),
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
        
            agent_version: None,
            service_name: None,
        }
    }

    #[test]
    fn test_threshold_skip() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let tokio_rt = tokio::runtime::Runtime::new().unwrap();
        tokio_rt.block_on(async {
            let result = engine.analyze_incident(&[], 50.0).await;
            assert!(result.is_none());
        });
    }

    #[test]
    fn test_build_prompt() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "C2 Communication",
            "Outbound connection to known C2 server",
        )
        .with_severity(Severity::Critical)
        .with_confidence(0.95)
        .with_entity(Entity {
            entity_type: EntityType::Ip,
            value: "1.2.3.4".into(),
            risk_contribution: 0.0,
        
            metadata: std::collections::HashMap::new(),
        });

        let prompt = engine.build_prompt(&[event], 85.0);
        assert!(prompt.contains("Analyze these security events"));
        assert!(prompt.contains("Risk Score: 85/100"));
        assert!(prompt.contains("C2 Communication"));
    }

    #[test]
    fn test_parse_analysis_valid() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let json = r#"{
            "summary": "A C2 beacon was detected",
            "threat_classification": "Command and Control",
            "mitre_tactic": "Command and Control",
            "mitre_technique": "Application Layer Protocol",
            "root_cause": "Compromised host communicating with C2",
            "recommended_response": ["Isolate host", "Block IP"],
            "false_positive_probability": 0.1,
            "confidence": 0.92
        }"#;

        let analysis = engine.parse_analysis(json).unwrap();
        assert_eq!(analysis.threat_classification, "Command and Control");
        assert_eq!(analysis.false_positive_probability, 0.1);
        assert_eq!(analysis.recommended_response.len(), 2);
    }

    #[test]
    fn test_parse_analysis_with_markdown_fences() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let content = r#"Here is the analysis:

```json
{
    "summary": "test",
    "threat_classification": "Malware",
    "mitre_tactic": "Execution",
    "mitre_technique": "Command and Scripting Interpreter",
    "root_cause": "user opened malicious attachment",
    "recommended_response": ["quarantine"],
    "false_positive_probability": 0.05,
    "confidence": 0.88
}
```"#;

        let analysis = engine.parse_analysis(content).unwrap();
        assert_eq!(analysis.summary, "test");
    }

    #[test]
    fn test_parse_analysis_invalid() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        assert!(engine.parse_analysis("not json at all").is_none());
    }

    #[test]
    fn test_analyze_with_context_skip_below_threshold() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let tokio_rt = tokio::runtime::Runtime::new().unwrap();
        tokio_rt.block_on(async {
            let result = engine.analyze_with_context(&[], 30.0, &[]).await;
            assert!(result.is_none());
        });
    }

    #[test]
    fn test_build_kill_chain_analysis() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "C2 Beacon",
            "Outbound connection detected",
        )
        .with_tag("Command and Control")
        .with_mitre("Command and Control", "Application Layer Protocol", "T1071");

        let prompt = engine.build_kill_chain_analysis(&[event]);
        assert!(prompt.contains("kill chain analysis"));
        assert!(prompt.contains("Command and Control"));
        assert!(prompt.contains("Reconnaissance"));
        assert!(prompt.contains("Actions on Objectives"));
    }

    #[test]
    fn test_build_kill_chain_analysis_no_phase() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Executed,
            test_source(),
            "Suspicious Process",
            "Unknown process executed",
        );

        let prompt = engine.build_kill_chain_analysis(&[event]);
        assert!(prompt.contains("Kill Chain: Unknown"));
    }

    #[test]
    fn test_build_business_impact_analysis() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let event = SecurityEvent::new(
            EventCategory::ReservatiorBusiness,
            EventAction::Detected,
            test_source(),
            "Escrow Tampering",
            "Unauthorized modification of escrow transaction",
        )
        .with_business_context("escrow-payment-processing")
        .with_revenue_impact(50000.0);

        let prompt = engine.build_business_impact_analysis(&[event]);
        assert!(prompt.contains("Reservatior"));
        assert!(prompt.contains("escrow"));
        assert!(prompt.contains("payment"));
        assert!(prompt.contains("Escrow Tampering"));
    }

    #[test]
    fn test_build_context_prompt() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "C2 Communication",
            "Outbound connection to known C2 server",
        )
        .with_severity(Severity::Critical);

        let chains = vec![
            "SSH brute force -> lateral movement -> C2".to_string(),
            "Phishing -> credential theft -> data exfil".to_string(),
        ];

        let prompt = engine.build_context_prompt(&[event], 90.0, &chains);
        assert!(prompt.contains("deep security analysis"));
        assert!(prompt.contains("Chain 1: SSH brute force"));
        assert!(prompt.contains("Chain 2: Phishing"));
        assert!(prompt.contains("Risk Score: 90/100"));
    }

    #[test]
    fn test_build_context_prompt_no_chains() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let prompt = engine.build_context_prompt(&[], 50.0, &[]);
        assert!(prompt.contains("No correlation chains available"));
    }

    #[test]
    fn test_parse_ai_analysis_valid() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let json = r#"{
            "summary": "Multi-stage attack detected",
            "kill_chain_phase": "Command and Control",
            "mitre_tactic": "Command and Control",
            "mitre_technique": "Ingress Tool Transfer",
            "root_cause": "Phishing email led to credential compromise",
            "false_positive_probability": 0.05,
            "confidence": 0.94,
            "business_impact": "High - escrow system potentially compromised",
            "affected_assets": ["web-server-1", "escrow-api", "payment-processor"],
            "recommended_response": ["Isolate affected hosts", "Block C2 IPs", "Rotate credentials"],
            "evidence_summary": "Three correlated events showing progression from initial access to C2 establishment",
            "similar_incidents": ["INC-2024-001", "INC-2024-015"]
        }"#;

        let analysis = engine.parse_ai_analysis(json).unwrap();
        assert_eq!(analysis.kill_chain_phase.unwrap(), "Command and Control");
        assert_eq!(analysis.business_impact, "High - escrow system potentially compromised");
        assert_eq!(analysis.affected_assets.len(), 3);
        assert_eq!(analysis.similar_incidents.len(), 2);
        assert_eq!(analysis.evidence_summary, "Three correlated events showing progression from initial access to C2 establishment");
    }

    #[test]
    fn test_parse_ai_analysis_with_fences() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let content = r#"```json
{
    "summary": "test",
    "kill_chain_phase": "Exploitation",
    "mitre_tactic": "Initial Access",
    "mitre_technique": "Phishing",
    "root_cause": "test root cause",
    "false_positive_probability": 0.1,
    "confidence": 0.8,
    "business_impact": "test impact",
    "affected_assets": [],
    "recommended_response": [],
    "evidence_summary": "test evidence",
    "similar_incidents": []
}
```"#;

        let analysis = engine.parse_ai_analysis(content).unwrap();
        assert_eq!(analysis.kill_chain_phase.unwrap(), "Exploitation");
    }

    #[test]
    fn test_parse_ai_analysis_invalid() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        assert!(engine.parse_ai_analysis("not json at all").is_none());
    }

    #[test]
    fn test_calculate_confidence_high_events_high_risk() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let conf = engine.calculate_confidence(15, 90.0);
        assert!(conf > 0.5);
        assert!(conf <= 0.99);
    }

    #[test]
    fn test_calculate_confidence_low_events_low_risk() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let conf = engine.calculate_confidence(1, 20.0);
        assert!(conf >= 0.1);
        assert!(conf < 0.5);
    }

    #[test]
    fn test_calculate_confidence_single_event() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let conf = engine.calculate_confidence(1, 50.0);
        assert!(conf >= 0.1);
        assert!(conf <= 0.99);
    }

    #[test]
    fn test_calculate_confidence_many_events() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let conf = engine.calculate_confidence(50, 80.0);
        assert!(conf >= 0.1);
        assert!(conf <= 0.99);
    }

    #[test]
    fn test_calculate_confidence_bounds() {
        let engine = AiEngine::new(
            "http://localhost:8080".into(),
            "test-key".into(),
            "gpt-4".into(),
            70.0,
        );

        let low = engine.calculate_confidence(1, 0.0);
        assert!(low >= 0.1);

        let high = engine.calculate_confidence(100, 100.0);
        assert!(high <= 0.99);
    }
}
