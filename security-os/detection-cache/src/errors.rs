use thiserror::Error;

#[derive(Error, Debug)]
pub enum CacheError {
    #[error("Cache overflow: {0}")]
    Overflow(String),

    #[error("Invalid parameter: {0}")]
    InvalidParam(String),

    #[error("Not found: {0}")]
    NotFound(String),
}
