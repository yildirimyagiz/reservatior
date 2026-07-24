use chrono::Utc;
use security_os_core::Severity;
use tracing::info;

use crate::errors::{AiAgentError, Result};
use crate::traits::{AgentContext, AgentRole, AiAgent};

pub struct DebateSession {
    topic: String,
    participants: Vec<Box<dyn AiAgent>>,
    rounds: Vec<DebateRound>,
    max_rounds: u32,
}

#[derive(Debug, Clone)]
pub struct DebateRound {
    pub round_number: u32,
    pub arguments: Vec<AgentArgument>,
    pub timestamp: chrono::DateTime<Utc>,
}

#[derive(Debug, Clone)]
pub struct AgentArgument {
    pub agent_role: AgentRole,
    pub position: String,
    pub evidence: Vec<String>,
    pub confidence: f64,
}

#[derive(Debug, Clone)]
pub struct DebateResolution {
    pub resolution: String,
    pub winning_position: String,
    pub confidence: f64,
    pub rounds_played: u32,
    pub agent_agreement: f64,
}

impl DebateSession {
    pub fn new(topic: String, max_rounds: u32) -> Self {
        Self {
            topic,
            participants: Vec::new(),
            rounds: Vec::new(),
            max_rounds,
        }
    }

    pub fn add_participant(&mut self, agent: Box<dyn AiAgent>) {
        info!(
            "Debate participant added: {} ({:?})",
            agent.name(),
            agent.role()
        );
        self.participants.push(agent);
    }

    pub async fn conduct_debate(
        &mut self,
        context: &AgentContext,
    ) -> Result<DebateResolution> {
        if self.participants.is_empty() {
            return Err(AiAgentError::DebateFailed(
                "No participants registered for debate".to_string(),
            ));
        }

        for round_num in 1..=self.max_rounds {
            info!(
                "Debate round {} of {} on topic: {}",
                round_num, self.max_rounds, self.topic
            );

            let mut arguments = Vec::new();

            for participant in &self.participants {
                let analysis = participant
                    .analyze(context)
                    .await
                    .map_err(|e| AiAgentError::DebateFailed(format!(
                        "Agent {:?} failed during debate round {}: {}",
                        participant.role(),
                        round_num,
                        e
                    )))?;

                let argument = AgentArgument {
                    agent_role: analysis.agent_role,
                    position: analysis.summary,
                    evidence: analysis.indicators,
                    confidence: analysis.confidence,
                };

                arguments.push(argument);
            }

            let round = DebateRound {
                round_number: round_num,
                arguments,
                timestamp: Utc::now(),
            };

            self.rounds.push(round);

            if self.has_reached_agreement() {
                info!(
                    "Debate reached agreement after {} rounds",
                    round_num
                );
                break;
            }
        }

        Ok(self.determine_resolution())
    }

    fn has_reached_agreement(&self) -> bool {
        if self.rounds.is_empty() {
            return false;
        }

        let last_round = self.rounds.last().unwrap();
        if last_round.arguments.len() < 2 {
            return true;
        }

        let confidences: Vec<f64> = last_round.arguments.iter().map(|a| a.confidence).collect();
        let avg_confidence = confidences.iter().sum::<f64>() / confidences.len() as f64;
        let variance = confidences
            .iter()
            .map(|c| (c - avg_confidence).powi(2))
            .sum::<f64>()
            / confidences.len() as f64;

        variance < 0.05 && avg_confidence > 0.6
    }

    pub fn determine_resolution(&self) -> DebateResolution {
        if self.rounds.is_empty() {
            return DebateResolution {
                resolution: format!(
                    "No debate rounds completed for topic: {}",
                    self.topic
                ),
                winning_position: "Undetermined".to_string(),
                confidence: 0.0,
                rounds_played: 0,
                agent_agreement: 0.0,
            };
        }

        let last_round = self.rounds.last().unwrap();

        let mut role_severities: std::collections::HashMap<AgentRole, Vec<Severity>> =
            std::collections::HashMap::new();

        for arg in &last_round.arguments {
            role_severities
                .entry(arg.agent_role.clone())
                .or_default()
                .push(if arg.confidence > 0.7 {
                    Severity::High
                } else if arg.confidence > 0.4 {
                    Severity::Medium
                } else {
                    Severity::Low
                });
        }

        let best_argument = last_round
            .arguments
            .iter()
            .max_by(|a, b| {
                a.confidence
                    .partial_cmp(&b.confidence)
                    .unwrap_or(std::cmp::Ordering::Equal)
            })
            .unwrap();

        let all_confidences: Vec<f64> = last_round.arguments.iter().map(|a| a.confidence).collect();
        let avg_confidence = all_confidences.iter().sum::<f64>() / all_confidences.len() as f64;
        let variance = all_confidences
            .iter()
            .map(|c| (c - avg_confidence).powi(2))
            .sum::<f64>()
            / all_confidences.len() as f64;
        let agreement = (1.0 - variance).clamp(0.0, 1.0);

        let consensus_position = if last_round.arguments.len() >= 2 {
            let mut counts: std::collections::HashMap<String, usize> = std::collections::HashMap::new();
            for arg in &last_round.arguments {
                *counts.entry(arg.position.clone()).or_insert(0) += 1;
            }
            counts
                .into_iter()
                .max_by_key(|(_, count)| *count)
                .map(|(pos, _)| pos)
                .unwrap_or_else(|| best_argument.position.clone())
        } else {
            best_argument.position.clone()
        };

        DebateResolution {
            resolution: format!(
                "Debate on '{}' concluded after {} rounds. Best argument by {:?} with {:.0}% confidence.",
                self.topic,
                self.rounds.len(),
                best_argument.agent_role,
                best_argument.confidence * 100.0
            ),
            winning_position: consensus_position,
            confidence: best_argument.confidence,
            rounds_played: self.rounds.len() as u32,
            agent_agreement: agreement,
        }
    }
}
