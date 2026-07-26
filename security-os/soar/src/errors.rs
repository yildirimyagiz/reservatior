use thiserror::Error;

#[derive(Error, Debug)]
pub enum SoarError {
    #[error("Playbook not found: {0}")]
    PlaybookNotFound(String),

    #[error("Execution failed: {0}")]
    ExecutionFailed(String),

    #[error("Approval required for step: {0}")]
    ApprovalRequired(String),

    #[error("Timeout: {0}")]
    Timeout(String),

    #[error("Step failed: {0}")]
    StepFailed(String),

    #[error("Execution cancelled: {0}")]
    Cancelled(String),

    #[error("Invalid playbook: {0}")]
    InvalidPlaybook(String),

    #[error("Fleet error: {0}")]
    Fleet(String),

    #[error("Core error: {0}")]
    Core(String),
}

pub type Result<T> = std::result::Result<T, SoarError>;
