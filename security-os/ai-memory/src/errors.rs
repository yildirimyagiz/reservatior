use thiserror::Error;

#[derive(Error, Debug)]
pub enum MemoryError {
    #[error("Not found: {0}")]
    NotFound(String),

    #[error("Duplicate entry: {0}")]
    Duplicate(String),

    #[error("Serialization error: {0}")]
    Serialization(String),

    #[error("Storage error: {0}")]
    Storage(String),
}

pub type Result<T> = std::result::Result<T, MemoryError>;
