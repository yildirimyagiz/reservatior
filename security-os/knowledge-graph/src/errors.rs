use thiserror::Error;

#[derive(Error, Debug)]
pub enum GraphError {
    #[error("Node not found: {0}")]
    NotFound(String),

    #[error("Cyclic edge detected: {0}")]
    CyclicEdge(String),

    #[error("Invalid node: {0}")]
    InvalidNode(String),

    #[error("Serialization error: {0}")]
    Serialization(String),

    #[error("Edge not found: {0}")]
    EdgeNotFound(String),
}

pub type Result<T> = std::result::Result<T, GraphError>;
