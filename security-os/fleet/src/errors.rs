use thiserror::Error;

#[derive(Debug, Error)]
pub enum FleetError {
    #[error("agent not found: {0}")]
    NotFound(String),

    #[error("agent already registered: {0}")]
    AlreadyRegistered(String),

    #[error("enrollment rejected: {0}")]
    EnrollmentRejected(String),

    #[error("policy not found: {0}")]
    PolicyNotFound(String),

    #[error("unauthorized: {0}")]
    Unauthorized(String),

    #[error("no CA configured for certificate issuance")]
    NoCaConfigured,

    #[error("enrollment request not pending: {0}")]
    NotPending(String),

    #[error("enrollment already processed: {0}")]
    AlreadyProcessed(String),
}
