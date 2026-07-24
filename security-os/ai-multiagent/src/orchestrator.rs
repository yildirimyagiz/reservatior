use security_os_core::Severity;
use std::collections::HashMap;
use tracing::{info, warn};

use crate::errors::{AiAgentError, Result};
use crate::traits::{AgentAnalysis, AgentContext, AiAgent};

pub struct AgentOrchestrator {
    agents: Vec<Box<dyn AiAgent>>,
    consensus_threshold: f64,
    #[allow(dead_code)]
    max_parallel: usize,
}

#[derive(Debug, Clone)]
pub struct OrchestratorResult {
    pub analyses: Vec<AgentAnalysis>,
    pub consensus: ConsensusResult,
    pub overall_severity: Severity,
    pub overall_confidence: f64,
    pub recommended_actions: Vec<String>,
    pub analysis_duration_ms: u64,
}

#[derive(Debug, Clone)]
pub struct ConsensusResult {
    pub agreement_level: f64,
    pub majority_severity: Severity,
    pub dissenting_agents: Vec<String>,
    pub consensus_actions: Vec<String>,
}

impl AgentOrchestrator {
    pub fn new() -> Self {
        Self {
            agents: Vec::new(),
            consensus_threshold: 0.6,
            max_parallel: 7,
        }
    }

    pub fn add_agent(&mut self, agent: Box<dyn AiAgent>) {
        info!(
            "Added agent: {} ({})",
            agent.name(),
            format!("{:?}", agent.role())
        );
        self.agents.push(agent);
    }

    pub fn set_consensus_threshold(&mut self, threshold: f64) {
        self.consensus_threshold = threshold.clamp(0.0, 1.0);
    }

    pub async fn analyze_event(
        &self,
        context: &AgentContext,
    ) -> Result<OrchestratorResult> {
        let start = std::time::Instant::now();

        if self.agents.is_empty() {
            return Err(AiAgentError::InvalidContext(
                "No agents registered in orchestrator".to_string(),
            ));
        }

        let mut analyses = Vec::new();

        for agent in &self.agents {
            match agent.analyze(context).await {
                Ok(analysis) => {
                    analyses.push(analysis);
                }
                Err(e) => {
                    warn!(
                        "Agent {} failed: {}",
                        agent.name(),
                        e
                    );
                }
            }
        }

        if analyses.is_empty() {
            return Err(AiAgentError::AgentFailed {
                agent: "all".to_string(),
                reason: "All agents failed to produce analysis".to_string(),
            });
        }

        let consensus = Self::compute_consensus(&analyses);
        let overall_severity = consensus.majority_severity;
        let overall_confidence = if analyses.is_empty() {
            0.0
        } else {
            analyses.iter().map(|a| a.confidence).sum::<f64>() / analyses.len() as f64
        };
        let recommended_actions = Self::merge_actions(&analyses);

        let duration_ms = start.elapsed().as_millis() as u64;

        Ok(OrchestratorResult {
            analyses,
            consensus,
            overall_severity,
            overall_confidence,
            recommended_actions,
            analysis_duration_ms: duration_ms,
        })
    }

    pub async fn analyze_batch(
        &self,
        contexts: Vec<AgentContext>,
    ) -> Vec<Result<OrchestratorResult>> {
        let mut results = Vec::with_capacity(contexts.len());
        for context in contexts {
            results.push(self.analyze_event(&context).await);
        }
        results
    }

    pub fn compute_consensus(analyses: &[AgentAnalysis]) -> ConsensusResult {
        if analyses.is_empty() {
            return ConsensusResult {
                agreement_level: 0.0,
                majority_severity: Severity::Informational,
                dissenting_agents: Vec::new(),
                consensus_actions: Vec::new(),
            };
        }

        let mut severity_counts: HashMap<Severity, usize> = HashMap::new();
        for analysis in analyses {
            *severity_counts.entry(analysis.severity).or_insert(0) += 1;
        }

        let total = analyses.len();
        let (majority_severity, majority_count) = severity_counts
            .iter()
            .max_by_key(|(_, count)| *count)
            .map(|(sev, count)| (*sev, *count))
            .unwrap_or((Severity::Informational, 0));

        let agreement_level = majority_count as f64 / total as f64;

        let dissenting_agents: Vec<String> = analyses
            .iter()
            .filter(|a| a.severity != majority_severity)
            .map(|a| format!("{:?} ({})", a.agent_role, a.severity))
            .collect();

        let consensus_actions = Self::merge_actions(analyses);

        ConsensusResult {
            agreement_level,
            majority_severity,
            dissenting_agents,
            consensus_actions,
        }
    }

    pub fn merge_actions(analyses: &[AgentAnalysis]) -> Vec<String> {
        let mut seen = std::collections::HashSet::new();
        let mut merged = Vec::new();

        for analysis in analyses {
            for action in &analysis.recommended_actions {
                if seen.insert(action.clone()) {
                    merged.push(action.clone());
                }
            }
        }

        merged
    }
}
