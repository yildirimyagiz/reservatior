use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use std::fmt;

use crate::errors::AgentError;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum AgentState {
    Unenrolled,
    Enrolling,
    Enrolled,
    Connected,
    Disconnected,
    Error { reason: String },
}

impl fmt::Display for AgentState {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            AgentState::Unenrolled => write!(f, "Unenrolled"),
            AgentState::Enrolling => write!(f, "Enrolling"),
            AgentState::Enrolled => write!(f, "Enrolled"),
            AgentState::Connected => write!(f, "Connected"),
            AgentState::Disconnected => write!(f, "Disconnected"),
            AgentState::Error { reason } => write!(f, "Error: {}", reason),
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StateTransition {
    pub from: AgentState,
    pub to: AgentState,
    pub timestamp: DateTime<Utc>,
    pub reason: String,
}

#[derive(Debug, Clone)]
pub struct LifecycleManager {
    state: AgentState,
    state_changes: Vec<StateTransition>,
}

impl LifecycleManager {
    pub fn new() -> Self {
        Self {
            state: AgentState::Unenrolled,
            state_changes: Vec::new(),
        }
    }

    pub fn transition(&mut self, to: AgentState, reason: &str) -> Result<(), AgentError> {
        let from = self.state.clone();
        if !Self::is_valid_transition(&from, &to) {
            return Err(AgentError::LifecycleError(format!(
                "invalid transition from {} to {}",
                from, to
            )));
        }
        let transition = StateTransition {
            from,
            to: to.clone(),
            timestamp: Utc::now(),
            reason: reason.to_string(),
        };
        self.state_changes.push(transition);
        self.state = to;
        Ok(())
    }

    fn is_valid_transition(from: &AgentState, to: &AgentState) -> bool {
        matches!(
            (from, to),
            (AgentState::Unenrolled, AgentState::Enrolling)
                | (AgentState::Enrolling, AgentState::Enrolled)
                | (AgentState::Enrolling, AgentState::Error { .. })
                | (AgentState::Enrolled, AgentState::Connected)
                | (AgentState::Enrolled, AgentState::Disconnected)
                | (AgentState::Connected, AgentState::Disconnected)
                | (AgentState::Disconnected, AgentState::Connected)
                | (AgentState::Disconnected, AgentState::Enrolling)
                | (_, AgentState::Error { .. })
        )
    }

    pub fn current_state(&self) -> &AgentState {
        &self.state
    }

    pub fn history(&self) -> &[StateTransition] {
        &self.state_changes
    }

    pub fn is_active(&self) -> bool {
        matches!(
            self.state,
            AgentState::Enrolled | AgentState::Connected
        )
    }
}

impl Default for LifecycleManager {
    fn default() -> Self {
        Self::new()
    }
}
