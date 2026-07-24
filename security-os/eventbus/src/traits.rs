use async_trait::async_trait;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use uuid::Uuid;

use crate::errors::BusError;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BusMessage {
    pub id: Uuid,
    pub event: security_os_core::SecurityEvent,
    pub topic: String,
    pub timestamp: DateTime<Utc>,
    pub retry_count: u32,
    pub headers: HashMap<String, String>,
}

impl BusMessage {
    pub fn new(topic: impl Into<String>, event: security_os_core::SecurityEvent) -> Self {
        Self {
            id: Uuid::new_v4(),
            event,
            topic: topic.into(),
            timestamp: Utc::now(),
            retry_count: 0,
            headers: HashMap::new(),
        }
    }

    pub fn with_retry_count(mut self, count: u32) -> Self {
        self.retry_count = count;
        self
    }

    pub fn with_header(mut self, key: impl Into<String>, value: impl Into<String>) -> Self {
        self.headers.insert(key.into(), value.into());
        self
    }
}

#[derive(Debug, Clone, Default)]
pub struct BusStats {
    pub messages_published: u64,
    pub messages_consumed: u64,
    pub messages_dropped: u64,
    pub messages_retried: u64,
    pub active_subscribers: usize,
    pub backpressure_events: u64,
    pub dead_letter_count: u64,
    pub avg_latency_us: u64,
}

#[derive(Debug, Clone)]
pub enum BackendHealth {
    Healthy,
    Degraded { reason: String },
    Unhealthy { reason: String },
    Disconnected,
}

#[async_trait]
pub trait EventBusBackend: Send + Sync {
    async fn publish(&self, message: BusMessage) -> Result<(), BusError>;
    async fn subscribe(&self, topic: &str) -> Result<Box<dyn EventSubscription>, BusError>;
    async fn health(&self) -> BackendHealth;
    async fn stats(&self) -> BusStats;
    fn name(&self) -> &str;
}

#[async_trait]
pub trait EventSubscription: Send + Sync {
    async fn next(&mut self) -> Option<BusMessage>;
    fn topic(&self) -> &str;
    async fn unsubscribe(self: Box<Self>) -> Result<(), BusError>;
}
