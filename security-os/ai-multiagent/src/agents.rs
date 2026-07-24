use async_trait::async_trait;
use chrono::Utc;
use security_os_core::Severity;
use std::collections::HashMap;

use crate::errors::AiAgentError;
use crate::traits::{AgentAnalysis, AgentContext, AgentRole, AiAgent};

pub struct CollectorAgent {
    id: String,
}

impl CollectorAgent {
    pub fn new() -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
        }
    }
}

#[async_trait]
impl AiAgent for CollectorAgent {
    fn role(&self) -> AgentRole {
        AgentRole::Collector
    }

    fn name(&self) -> &str {
        "Collector Health Agent"
    }

    fn description(&self) -> &str {
        "Monitors collector health, data quality, and ingestion pipeline integrity"
    }

    async fn analyze(&self, context: &AgentContext) -> Result<AgentAnalysis, AiAgentError> {
        let start = std::time::Instant::now();
        let mut indicators = Vec::new();
        let mut recommended_actions = Vec::new();

        let event = &context.event;

        if event.source.collector.is_empty() {
            indicators.push("Event has empty collector identifier".to_string());
            recommended_actions.push("Verify collector registration and configuration".to_string());
        }

        if event.source.agent_version.is_none() {
            indicators.push("Collector agent version not reported".to_string());
            recommended_actions.push("Update collector to report version metadata".to_string());
        }

        let mut metadata = HashMap::new();
        metadata.insert(
            "collector".into(),
            serde_json::Value::String(event.source.collector.clone()),
        );
        metadata.insert(
            "host_id".into(),
            serde_json::Value::String(event.source.host_id.clone()),
        );

        let related_count = context.related_events.len();
        if related_count > 50 {
            indicators.push(format!(
                "High event volume from collector: {} related events",
                related_count
            ));
            recommended_actions.push("Review collector sampling rate and filtering".to_string());
        }

        let data_quality_score = if event.confidence < 0.5 {
            indicators.push(format!(
                "Low event confidence: {:.2}",
                event.confidence
            ));
            recommended_actions
                .push("Investigate data quality issues at collector source".to_string());
            0.4
        } else if event.confidence < 0.8 {
            0.7
        } else {
            0.95
        };

        metadata.insert(
            "data_quality_score".into(),
            serde_json::Value::Number(
                serde_json::Number::from_f64(data_quality_score).unwrap(),
            ),
        );

        let severity = if indicators.len() > 2 {
            Severity::High
        } else if indicators.len() > 0 {
            Severity::Medium
        } else {
            Severity::Low
        };

        let confidence = if indicators.is_empty() {
            0.85
        } else {
            0.6
        };

        Ok(AgentAnalysis {
            agent_role: AgentRole::Collector,
            agent_id: self.id.clone(),
            summary: format!(
                "Collector health analysis: {} indicators found, data quality score {:.2}",
                indicators.len(),
                data_quality_score
            ),
            confidence,
            severity,
            recommended_actions,
            mitre_tactics: Vec::new(),
            indicators,
            metadata,
            analysis_timestamp: Utc::now(),
            duration_ms: start.elapsed().as_millis() as u64,
        })
    }
}

pub struct DetectionAgent {
    id: String,
}

impl DetectionAgent {
    pub fn new() -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
        }
    }
}

#[async_trait]
impl AiAgent for DetectionAgent {
    fn role(&self) -> AgentRole {
        AgentRole::Detection
    }

    fn name(&self) -> &str {
        "Detection Rule Agent"
    }

    fn description(&self) -> &str {
        "Analyzes detection rules and alert validity"
    }

    async fn analyze(&self, context: &AgentContext) -> Result<AgentAnalysis, AiAgentError> {
        let start = std::time::Instant::now();
        let mut indicators = Vec::new();
        let mut recommended_actions = Vec::new();
        let mut metadata = HashMap::new();

        let event = &context.event;

        if let Some(ref rule_id) = event.rule_id {
            indicators.push(format!("Triggered rule: {} ({})", rule_id, event.rule_name.as_deref().unwrap_or("unnamed")));
            metadata.insert(
                "rule_id".into(),
                serde_json::Value::String(rule_id.clone()),
            );
        } else {
            indicators.push("Event not triggered by a detection rule".to_string());
        }

        if event.severity >= Severity::High {
            indicators.push(format!("High severity event: {}", event.severity));
            recommended_actions.push("Verify detection rule tuning for false positive reduction".to_string());
        }

        for ioc in &event.ioc_matches {
            indicators.push(format!(
                "IOC correlation: {} matched {} from {}",
                ioc.ioc_value, ioc.ioc_type, ioc.feed
            ));
        }

        if let Some(ref tactic) = event.mitre_tactic {
            indicators.push(format!("MITRE tactic detected: {}", tactic));
            metadata.insert(
                "mitre_tactic".into(),
                serde_json::Value::String(tactic.clone()),
            );
            recommended_actions
                .push("Map to detection coverage matrix and identify gaps".to_string());
        }

        let rule_effectiveness = if event.rule_id.is_some() {
            if event.confidence > 0.8 {
                0.9
            } else {
                0.6
            }
        } else {
            0.3
        };

        metadata.insert(
            "rule_effectiveness".into(),
            serde_json::Value::Number(
                serde_json::Number::from_f64(rule_effectiveness).unwrap(),
            ),
        );

        let severity = if indicators.len() > 3 {
            Severity::Critical
        } else if indicators.len() > 1 {
            Severity::High
        } else if !indicators.is_empty() {
            Severity::Medium
        } else {
            Severity::Informational
        };

        let confidence = if indicators.is_empty() {
            0.3
        } else if event.rule_id.is_some() {
            0.8
        } else {
            0.5
        };

        Ok(AgentAnalysis {
            agent_role: AgentRole::Detection,
            agent_id: self.id.clone(),
            summary: format!(
                "Detection analysis: {} indicators, rule effectiveness {:.2}",
                indicators.len(),
                rule_effectiveness
            ),
            confidence,
            severity,
            recommended_actions,
            mitre_tactics: event.mitre_tactic.clone().into_iter().collect(),
            indicators,
            metadata,
            analysis_timestamp: Utc::now(),
            duration_ms: start.elapsed().as_millis() as u64,
        })
    }
}

pub struct ThreatAgent {
    id: String,
}

impl ThreatAgent {
    pub fn new() -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
        }
    }
}

#[async_trait]
impl AiAgent for ThreatAgent {
    fn role(&self) -> AgentRole {
        AgentRole::Threat
    }

    fn name(&self) -> &str {
        "Threat Intelligence Agent"
    }

    fn description(&self) -> &str {
        "Correlates events with threat intelligence feeds and IOCs"
    }

    async fn analyze(&self, context: &AgentContext) -> Result<AgentAnalysis, AiAgentError> {
        let start = std::time::Instant::now();
        let mut indicators = Vec::new();
        let mut recommended_actions = Vec::new();
        let mut metadata = HashMap::new();

        let event = &context.event;

        if !event.ioc_matches.is_empty() {
            for ioc in &event.ioc_matches {
                indicators.push(format!(
                    "IOC match: {} ({})",
                    ioc.ioc_value, ioc.feed
                ));
                recommended_actions.push(format!(
                    "Investigate IOC {} and pivot to related infrastructure",
                    ioc.ioc_value
                ));
            }
        }

        if let Some(ref tactic) = event.mitre_tactic {
            indicators.push(format!("MITRE tactic: {}", tactic));
        }
        if let Some(ref technique) = event.mitre_technique {
            indicators.push(format!("MITRE technique: {}", technique));
        }

        for ti in &context.threat_intel {
            indicators.push(format!("Threat intel reference: {}", ti));
        }

        if !event.tags.is_empty() {
            for tag in &event.tags {
                indicators.push(format!("Tag: {}", tag));
            }
        }

        if let Some(ref country) = event.country {
            indicators.push(format!("Geographic origin: {}", country));
            recommended_actions.push(format!(
                "Review traffic from {} for additional IOCs",
                country
            ));
        }

        metadata.insert(
            "ioc_count".into(),
            serde_json::Value::Number(serde_json::Number::from(event.ioc_matches.len())),
        );
        metadata.insert(
            "threat_intel_count".into(),
            serde_json::Value::Number(serde_json::Number::from(context.threat_intel.len())),
        );

        let severity = if indicators.len() > 3 {
            Severity::Critical
        } else if indicators.len() > 1 {
            Severity::High
        } else if !indicators.is_empty() {
            Severity::Medium
        } else {
            Severity::Low
        };

        let confidence = if indicators.is_empty() {
            0.3
        } else {
            0.7
        };

        Ok(AgentAnalysis {
            agent_role: AgentRole::Threat,
            agent_id: self.id.clone(),
            summary: format!(
                "Threat analysis: {} indicators found",
                indicators.len()
            ),
            confidence,
            severity,
            recommended_actions,
            mitre_tactics: event.mitre_tactic.clone().into_iter().collect(),
            indicators,
            metadata,
            analysis_timestamp: Utc::now(),
            duration_ms: start.elapsed().as_millis() as u64,
        })
    }
}

pub struct MalwareAgent {
    id: String,
}

impl MalwareAgent {
    pub fn new() -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
        }
    }
}

#[async_trait]
impl AiAgent for MalwareAgent {
    fn role(&self) -> AgentRole {
        AgentRole::Malware
    }

    fn name(&self) -> &str {
        "Malware Analysis Agent"
    }

    fn description(&self) -> &str {
        "Analyzes malware indicators, file hashes, and behavioral signatures"
    }

    async fn analyze(&self, context: &AgentContext) -> Result<AgentAnalysis, AiAgentError> {
        let start = std::time::Instant::now();
        let mut indicators = Vec::new();
        let mut recommended_actions = Vec::new();
        let mut metadata = HashMap::new();

        let event = &context.event;

        if let Some(ref hash) = event.file_hash_sha256 {
            indicators.push(format!("File hash: {}...", &hash[..hash.len().min(16)]));
            recommended_actions.push(format!(
                "Submit hash {} to sandbox for detonation analysis",
                &hash[..hash.len().min(16)]
            ));
            metadata.insert(
                "file_hash".into(),
                serde_json::Value::String(hash.clone()),
            );
        }

        if let Some(ref path) = event.file_path {
            indicators.push(format!("Suspicious file path: {}", path));
            if path.starts_with("/tmp/") || path.starts_with("/dev/shm/") {
                indicators.push("File located in world-writable directory".to_string());
                recommended_actions
                    .push("Quarantine file and check for persistence mechanisms".to_string());
            }
        }

        if let Some(ref exe) = event.exe {
            indicators.push(format!("Executable: {}", exe));
        }

        if let Some(ref cmdline) = event.cmdline {
            if cmdline.contains("curl") || cmdline.contains("wget") {
                indicators.push(format!("Network download in command: {}", cmdline));
                recommended_actions
                    .push("Check downloaded payload for malicious content".to_string());
            }
            if cmdline.contains("base64") || cmdline.contains("eval") {
                indicators.push("Obfuscated command execution detected".to_string());
                recommended_actions.push("Deobfuscate and analyze payload".to_string());
            }
        }

        if let Some(ref reputation) = event.process_reputation {
            if reputation == "malicious" || reputation == "suspicious" {
                indicators.push(format!("Process reputation: {}", reputation));
                recommended_actions.push("Block process and isolate affected host".to_string());
            }
        }

        for ioc in &event.ioc_matches {
            if ioc.ioc_type == "hash" {
                indicators.push(format!("Hash IOC match: {}", ioc.ioc_value));
            }
        }

        metadata.insert(
            "file_analysis_required".into(),
            serde_json::Value::Bool(event.file_hash_sha256.is_some()),
        );

        let severity = if indicators.len() > 3 {
            Severity::Critical
        } else if indicators.len() > 1 {
            Severity::High
        } else if !indicators.is_empty() {
            Severity::Medium
        } else {
            Severity::Low
        };

        let confidence = if indicators.is_empty() {
            0.2
        } else {
            0.65
        };

        Ok(AgentAnalysis {
            agent_role: AgentRole::Malware,
            agent_id: self.id.clone(),
            summary: format!(
                "Malware analysis: {} indicators found",
                indicators.len()
            ),
            confidence,
            severity,
            recommended_actions,
            mitre_tactics: Vec::new(),
            indicators,
            metadata,
            analysis_timestamp: Utc::now(),
            duration_ms: start.elapsed().as_millis() as u64,
        })
    }
}

pub struct CloudAgent {
    id: String,
}

impl CloudAgent {
    pub fn new() -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
        }
    }
}

#[async_trait]
impl AiAgent for CloudAgent {
    fn role(&self) -> AgentRole {
        AgentRole::Cloud
    }

    fn name(&self) -> &str {
        "Cloud Infrastructure Agent"
    }

    fn description(&self) -> &str {
        "Analyzes cloud infrastructure events, container orchestration, and IAM"
    }

    async fn analyze(&self, context: &AgentContext) -> Result<AgentAnalysis, AiAgentError> {
        let start = std::time::Instant::now();
        let mut indicators = Vec::new();
        let mut recommended_actions = Vec::new();
        let mut metadata = HashMap::new();

        let event = &context.event;

        if let Some(ref container_id) = event.source.container_id {
            indicators.push(format!("Container: {}", container_id));
            metadata.insert(
                "container_id".into(),
                serde_json::Value::String(container_id.clone()),
            );
        }

        if let Some(ref pod_name) = event.source.pod_name {
            indicators.push(format!("Pod: {}", pod_name));
            recommended_actions.push(format!(
                "Inspect pod {} for anomalous configurations",
                pod_name
            ));
        }

        if let Some(ref namespace) = event.source.namespace {
            indicators.push(format!("Namespace: {}", namespace));
            if namespace == "kube-system" {
                indicators.push("Event in privileged kube-system namespace".to_string());
                recommended_actions.push("Review RBAC policies for kube-system access".to_string());
            }
        }

        if let Some(ref cluster) = event.cluster {
            indicators.push(format!("Cluster: {}", cluster));
        }

        if let Some(ref region) = event.region {
            indicators.push(format!("Region: {}", region));
        }

        if event.category == security_os_core::EventCategory::Container
            || event.category == security_os_core::EventCategory::Kubernetes
        {
            indicators.push(format!(
                "Cloud/container category event: {:?}",
                event.category
            ));
            recommended_actions.push("Review container security policies".to_string());
        }

        if event.action == security_os_core::EventAction::Escalated {
            indicators.push("Privilege escalation in cloud context".to_string());
            recommended_actions
                .push("Audit IAM role assignments and service accounts".to_string());
            recommended_actions.push("Check for container escape indicators".to_string());
        }

        metadata.insert(
            "cloud_event".into(),
            serde_json::Value::Bool(true),
        );

        let severity = if indicators.len() > 3 {
            Severity::Critical
        } else if indicators.len() > 1 {
            Severity::High
        } else if !indicators.is_empty() {
            Severity::Medium
        } else {
            Severity::Low
        };

        let confidence = if indicators.is_empty() {
            0.3
        } else {
            0.7
        };

        Ok(AgentAnalysis {
            agent_role: AgentRole::Cloud,
            agent_id: self.id.clone(),
            summary: format!(
                "Cloud infrastructure analysis: {} indicators found",
                indicators.len()
            ),
            confidence,
            severity,
            recommended_actions,
            mitre_tactics: event.mitre_tactic.clone().into_iter().collect(),
            indicators,
            metadata,
            analysis_timestamp: Utc::now(),
            duration_ms: start.elapsed().as_millis() as u64,
        })
    }
}

pub struct BusinessAgent {
    id: String,
}

impl BusinessAgent {
    pub fn new() -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
        }
    }
}

#[async_trait]
impl AiAgent for BusinessAgent {
    fn role(&self) -> AgentRole {
        AgentRole::Business
    }

    fn name(&self) -> &str {
        "Business Impact Agent"
    }

    fn description(&self) -> &str {
        "Assesses business impact on Reservatior operations, escrow, and payments"
    }

    async fn analyze(&self, context: &AgentContext) -> Result<AgentAnalysis, AiAgentError> {
        let start = std::time::Instant::now();
        let mut indicators = Vec::new();
        let mut recommended_actions = Vec::new();
        let mut metadata = HashMap::new();

        let event = &context.event;

        if let Some(ref ctx) = event.business_context {
            indicators.push(format!("Business context: {}", ctx));
            if ctx.contains("escrow") || ctx.contains("payment") {
                indicators.push("Financial system involved".to_string());
                recommended_actions
                    .push("Notify financial operations team".to_string());
                recommended_actions.push("Verify transaction integrity".to_string());
            }
            if ctx.contains("booking") {
                indicators.push("Booking system involved".to_string());
                recommended_actions.push("Check reservation data integrity".to_string());
            }
        }

        if let Some(impact) = event.revenue_impact {
            if impact > 10000.0 {
                indicators.push(format!("High revenue impact: ${:.2}", impact));
                recommended_actions.push("Escalate to executive incident response".to_string());
            } else if impact > 1000.0 {
                indicators.push(format!("Moderate revenue impact: ${:.2}", impact));
                recommended_actions.push("Notify business continuity team".to_string());
            }
            metadata.insert(
                "revenue_impact".into(),
                serde_json::Value::Number(
                    serde_json::Number::from_f64(impact).unwrap(),
                ),
            );
        }

        if event.category == security_os_core::EventCategory::ReservatiorBusiness {
            indicators.push("Reservatior business event".to_string());
            recommended_actions
                .push("Review business logic for tampering".to_string());
        }

        if event.risk_score > 70.0 {
            indicators.push(format!("High risk score: {:.1}", event.risk_score));
            recommended_actions
                .push("Activate business continuity plan".to_string());
        }

        for entity in &event.affected_entities {
            match entity.entity_type {
                security_os_core::EntityType::Booking => {
                    indicators.push(format!("Affected booking: {}", entity.value));
                }
                security_os_core::EntityType::Escrow => {
                    indicators.push(format!("Affected escrow: {}", entity.value));
                    recommended_actions.push(format!(
                        "Freeze escrow {} pending investigation",
                        entity.value
                    ));
                }
                security_os_core::EntityType::Payment => {
                    indicators.push(format!("Affected payment: {}", entity.value));
                    recommended_actions.push("Review recent payment transactions".to_string());
                }
                _ => {}
            }
        }

        metadata.insert(
            "business_analysis".into(),
            serde_json::Value::Bool(true),
        );

        let severity = if indicators.len() > 3 {
            Severity::Critical
        } else if indicators.len() > 1 {
            Severity::High
        } else if !indicators.is_empty() {
            Severity::Medium
        } else {
            Severity::Low
        };

        let confidence = if indicators.is_empty() {
            0.4
        } else {
            0.75
        };

        Ok(AgentAnalysis {
            agent_role: AgentRole::Business,
            agent_id: self.id.clone(),
            summary: format!(
                "Business impact analysis: {} indicators found",
                indicators.len()
            ),
            confidence,
            severity,
            recommended_actions,
            mitre_tactics: Vec::new(),
            indicators,
            metadata,
            analysis_timestamp: Utc::now(),
            duration_ms: start.elapsed().as_millis() as u64,
        })
    }
}

pub struct SocAgent {
    id: String,
}

impl SocAgent {
    pub fn new() -> Self {
        Self {
            id: uuid::Uuid::new_v4().to_string(),
        }
    }
}

#[async_trait]
impl AiAgent for SocAgent {
    fn role(&self) -> AgentRole {
        AgentRole::SOC
    }

    fn name(&self) -> &str {
        "SOC Coordination Agent"
    }

    fn description(&self) -> &str {
        "Provides overall SOC coordination and final verdict on security events"
    }

    async fn analyze(&self, context: &AgentContext) -> Result<AgentAnalysis, AiAgentError> {
        let start = std::time::Instant::now();
        let mut indicators = Vec::new();
        let mut recommended_actions = Vec::new();
        let mut metadata = HashMap::new();

        let event = &context.event;

        if let Some(ref incident_id) = context.incident_id {
            indicators.push(format!("Linked to incident: {}", incident_id));
            metadata.insert(
                "incident_id".into(),
                serde_json::Value::String(incident_id.clone()),
            );
        }

        let related_count = context.related_events.len();
        if related_count > 0 {
            indicators.push(format!("{} related events in timeline", related_count));
            recommended_actions.push("Review full event timeline for kill chain progression".to_string());
        }

        if event.severity >= Severity::Critical {
            indicators.push("Critical severity assessment".to_string());
            recommended_actions.push("Initiate major incident response procedures".to_string());
            recommended_actions.push("Notify SOC management".to_string());
            recommended_actions.push("Begin evidence preservation".to_string());
        } else if event.severity >= Severity::High {
            indicators.push("High severity assessment".to_string());
            recommended_actions.push("Assign to senior analyst for investigation".to_string());
        }

        if !event.ioc_matches.is_empty() {
            indicators.push(format!(
                "{} IOC matches requiring investigation",
                event.ioc_matches.len()
            ));
            recommended_actions.push("Add IOCs to blocklist after validation".to_string());
        }

        if event.risk_score > 80.0 {
            indicators.push(format!("Critical risk score: {:.1}", event.risk_score));
            recommended_actions.push("Prioritize for immediate response".to_string());
        }

        if let Some(ref historical) = context.historical_context {
            indicators.push(format!(
                "Historical context available: {}",
                &historical[..historical.len().min(64)]
            ));
        }

        let overall_threat_level = if event.severity >= Severity::Critical && event.risk_score > 80.0 {
            "CRITICAL"
        } else if event.severity >= Severity::High || event.risk_score > 60.0 {
            "HIGH"
        } else if event.severity >= Severity::Medium || event.risk_score > 40.0 {
            "MEDIUM"
        } else {
            "LOW"
        };

        metadata.insert(
            "overall_threat_level".into(),
            serde_json::Value::String(overall_threat_level.into()),
        );
        metadata.insert(
            "related_event_count".into(),
            serde_json::Value::Number(serde_json::Number::from(related_count)),
        );

        let severity = event.severity;
        let confidence = (event.confidence * 0.7 + context.risk_score / 100.0 * 0.3).min(0.95);

        Ok(AgentAnalysis {
            agent_role: AgentRole::SOC,
            agent_id: self.id.clone(),
            summary: format!(
                "SOC coordination: threat level {} with {} indicators",
                overall_threat_level,
                indicators.len()
            ),
            confidence,
            severity,
            recommended_actions,
            mitre_tactics: event.mitre_tactic.clone().into_iter().collect(),
            indicators,
            metadata,
            analysis_timestamp: Utc::now(),
            duration_ms: start.elapsed().as_millis() as u64,
        })
    }
}
