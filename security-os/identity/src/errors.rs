use thiserror::Error;

#[derive(Error, Debug, Clone)]
pub enum IdentityError {
    #[error("Authentication failed: {0}")]
    AuthenticationFailed(String),

    #[error("Token expired")]
    TokenExpired,

    #[error("Token invalid: {0}")]
    TokenInvalid(String),

    #[error("Provider error: {0}")]
    ProviderError(String),

    #[error("Not found: {0}")]
    NotFound(String),

    #[error("Permission denied: {0}")]
    PermissionDenied(String),

    #[error("Configuration error: {0}")]
    ConfigurationError(String),

    #[error("Rate limited: {0}")]
    RateLimit(String),
}
