use async_trait::async_trait;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

use crate::errors::NormalizerError;
use security_os_core::SecurityEvent;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RawEvent {
    pub source_format: SourceFormat,
    pub payload: serde_json::Value,
    pub metadata: HashMap<String, String>,
    pub received_at: DateTime<Utc>,
    pub origin: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub enum SourceFormat {
    Sigma,
    OpenTelemetry,
    Cef,
    Ecs,
    Syslog,
    Json,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NormalizationResult {
    pub event: SecurityEvent,
    pub source_format: SourceFormat,
    pub confidence: f64,
    pub warnings: Vec<String>,
    pub unmapped_fields: Vec<String>,
}

#[async_trait]
pub trait EventNormalizer: Send + Sync {
    fn format(&self) -> SourceFormat;
    fn name(&self) -> &str;
    fn can_handle(&self, event: &RawEvent) -> bool;
    async fn normalize(&self, event: &RawEvent) -> std::result::Result<NormalizationResult, NormalizerError>;
    fn confidence(&self, event: &RawEvent) -> f64;
}
