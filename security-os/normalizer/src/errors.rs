use thiserror::Error;

#[derive(Error, Debug, Clone)]
pub enum NormalizerError {
    #[error("Failed to parse event: {0}")]
    Parse(String),

    #[error("Unsupported format: {0}")]
    Unsupported(String),

    #[error("Missing required field: {0}")]
    MissingField(String),

    #[error("Type conversion error: {0}")]
    Conversion(String),

    #[error("Normalization failed: {0}")]
    Failed(String),
}

impl From<serde_json::Error> for NormalizerError {
    fn from(e: serde_json::Error) -> Self {
        NormalizerError::Parse(e.to_string())
    }
}
