use thiserror::Error;

#[derive(Debug, Error)]
pub enum BusError {
    #[error("failed to publish message to topic '{topic}': {reason}")]
    PublishFailed { topic: String, reason: String },

    #[error("failed to subscribe to topic '{topic}': {reason}")]
    SubscribeFailed { topic: String, reason: String },

    #[error("backend '{backend}' is unavailable: {reason}")]
    BackendUnavailable { backend: String, reason: String },

    #[error("serialization error: {0}")]
    Serialization(#[from] serde_json::Error),

    #[error("channel lagged by {0} messages")]
    Lagged(u64),

    #[error("backend disconnected")]
    Disconnected,

    #[error("backpressure: rate limit exceeded for topic '{topic}', {pending} pending messages")]
    RateLimited { topic: String, pending: usize },

    #[error("message expired: id={id}, age={age_secs}s, max_age={max_age_secs}s")]
    MessageExpired {
        id: String,
        age_secs: u64,
        max_age_secs: u64,
    },

    #[error("dead letter queue full (max_size={max_size})")]
    DeadLetterQueueFull { max_size: usize },

    #[error("no healthy backend available for topic '{topic}'")]
    NoHealthyBackend { topic: String },

    #[error("{0}")]
    Other(String),
}
