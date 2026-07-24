use thiserror::Error;

#[derive(Error, Debug)]
pub enum AiAgentError {
    #[error("Agent {agent} failed: {reason}")]
    AgentFailed {
        agent: String,
        reason: String,
    },

    #[error("LLM error: {0}")]
    LlmError(String),

    #[error("Timeout after {0}ms")]
    Timeout(u64),

    #[error("Consensus not reached: agreement {agreement:.2} below threshold {threshold:.2}")]
    ConsensusNotReached {
        agreement: f64,
        threshold: f64,
    },

    #[error("Invalid context: {0}")]
    InvalidContext(String),

    #[error("Debate failed: {0}")]
    DebateFailed(String),
}

pub type Result<T> = std::result::Result<T, AiAgentError>;
