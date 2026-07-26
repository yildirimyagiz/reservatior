use thiserror::Error;

#[derive(Debug, Error)]
pub enum MultiRegionError {
    #[error("peer unavailable: {0}")]
    PeerUnavailable(String),

    #[error("sync failed: {0}")]
    SyncFailed(String),

    #[error("routing error: {0}")]
    RoutingError(String),

    #[error("policy conflict: {0}")]
    PolicyConflict(String),

    #[error("not found: {0}")]
    NotFound(String),
}
