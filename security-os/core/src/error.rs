use thiserror::Error;

#[derive(Error, Debug)]
pub enum SecurityOsError {
    #[error("Event bus error: {0}")]
    EventBus(String),

    #[error("Storage error: {0}")]
    Storage(String),

    #[error("Collector error: {0}")]
    Collector(String),

    #[error("Engine error: {0}")]
    Engine(String),

    #[error("Rule engine error: {0}")]
    RuleEngine(String),

    #[error("IOC error: {0}")]
    Ioc(String),

    #[error("API error: {0}")]
    Api(String),

    #[error("Configuration error: {0}")]
    Config(String),

    #[error("Authentication error: {0}")]
    Auth(String),

    #[error("IO error: {0}")]
    Io(#[from] std::io::Error),

    #[error("Serialization error: {0}")]
    Serialization(#[from] serde_json::Error),

    #[error("Database error: {0}")]
    Database(String),

    #[error("Network error: {0}")]
    Network(String),

    #[error("Permission denied: {0}")]
    PermissionDenied(String),

    #[error("Not found: {0}")]
    NotFound(String),

    #[error("Timeout: {0}")]
    Timeout(String),

    #[error("Rate limited: {0}")]
    RateLimited(String),
}

pub type Result<T> = std::result::Result<T, SecurityOsError>;
