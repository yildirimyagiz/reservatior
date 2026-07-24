use async_trait::async_trait;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

use crate::errors::AgentError;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum CollectorStatus {
    Stopped,
    Starting,
    Running { events_per_second: f64 },
    Error { message: String },
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CollectorHealth {
    pub name: String,
    pub status: CollectorStatus,
    pub events_collected: u64,
    pub last_event_at: Option<DateTime<Utc>>,
    pub uptime_secs: u64,
}

#[async_trait]
pub trait Collector: Send + Sync {
    fn name(&self) -> &str;
    async fn start(&mut self) -> Result<(), AgentError>;
    async fn stop(&mut self) -> Result<(), AgentError>;
    async fn health(&self) -> CollectorHealth;
}

#[cfg(test)]
pub struct MockCollector {
    name: String,
    running: bool,
    events: u64,
}

#[cfg(test)]
impl MockCollector {
    pub fn new(name: &str) -> Self {
        Self {
            name: name.to_string(),
            running: false,
            events: 0,
        }
    }
}

#[cfg(test)]
#[async_trait]
impl Collector for MockCollector {
    fn name(&self) -> &str {
        &self.name
    }

    async fn start(&mut self) -> Result<(), AgentError> {
        self.running = true;
        Ok(())
    }

    async fn stop(&mut self) -> Result<(), AgentError> {
        self.running = false;
        Ok(())
    }

    async fn health(&self) -> CollectorHealth {
        CollectorHealth {
            name: self.name.clone(),
            status: if self.running {
                CollectorStatus::Running {
                    events_per_second: 42.0,
                }
            } else {
                CollectorStatus::Stopped
            },
            events_collected: self.events,
            last_event_at: if self.running { Some(Utc::now()) } else { None },
            uptime_secs: 0,
        }
    }
}
