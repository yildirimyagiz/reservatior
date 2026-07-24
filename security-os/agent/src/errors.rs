use thiserror::Error;

#[derive(Debug, Error)]
pub enum AgentError {
    #[error("enrollment failed: {0}")]
    EnrollmentFailed(String),

    #[error("agent is not enrolled")]
    NotEnrolled,

    #[error("collector '{name}' failed: {reason}")]
    CollectorFailed { name: String, reason: String },

    #[error("bus error: {0}")]
    BusError(String),

    #[error("config error: {0}")]
    ConfigError(String),

    #[error("identity error: {0}")]
    IdentityError(String),

    #[error("policy error: {0}")]
    PolicyError(String),

    #[error("lifecycle error: {0}")]
    LifecycleError(String),
}

impl From<serde_json::Error> for AgentError {
    fn from(e: serde_json::Error) -> Self {
        AgentError::ConfigError(e.to_string())
    }
}
