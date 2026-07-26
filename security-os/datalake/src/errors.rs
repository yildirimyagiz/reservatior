use thiserror::Error;

#[derive(Error, Debug)]
pub enum DataLakeError {
    #[error("Write failed: {0}")]
    WriteFailed(String),

    #[error("Schema mismatch: {0}")]
    SchemaMismatch(String),

    #[error("Partition error: {0}")]
    PartitionError(String),

    #[error("Tier migration failed: {0}")]
    TierMigrationFailed(String),

    #[error("ClickHouse error: {0}")]
    ClickHouseError(String),

    #[error("Serialization error: {0}")]
    Serialization(#[from] serde_json::Error),

    #[error("IO error: {0}")]
    Io(#[from] std::io::Error),
}
