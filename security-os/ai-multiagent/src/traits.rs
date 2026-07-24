use async_trait::async_trait;
use chrono::{DateTime, Utc};
use security_os_core::{SecurityEvent, Severity};
use std::collections::HashMap;

use crate::errors::AiAgentError;

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub enum AgentRole {
    Collector,
    Detection,
    Threat,
    Malware,
    Cloud,
    Business,
    SOC,
}

#[derive(Debug, Clone)]
pub struct AgentAnalysis {
    pub agent_role: AgentRole,
    pub agent_id: String,
    pub summary: String,
    pub confidence: f64,
    pub severity: Severity,
    pub recommended_actions: Vec<String>,
    pub mitre_tactics: Vec<String>,
    pub indicators: Vec<String>,
    pub metadata: HashMap<String, serde_json::Value>,
    pub analysis_timestamp: DateTime<Utc>,
    pub duration_ms: u64,
}

#[derive(Debug, Clone)]
pub struct AgentContext {
    pub event: SecurityEvent,
    pub incident_id: Option<String>,
    pub related_events: Vec<SecurityEvent>,
    pub risk_score: f64,
    pub threat_intel: Vec<String>,
    pub historical_context: Option<String>,
    pub additional_data: HashMap<String, serde_json::Value>,
}

#[async_trait]
pub trait AiAgent: Send + Sync {
    fn role(&self) -> AgentRole;
    fn name(&self) -> &str;
    fn description(&self) -> &str;
    async fn analyze(&self, context: &AgentContext) -> Result<AgentAnalysis, AiAgentError>;
}
