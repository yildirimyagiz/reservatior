use chrono::{DateTime, Utc};
use std::collections::VecDeque;
use std::sync::atomic::{AtomicU64, Ordering};
use std::sync::Arc;
use std::time::Duration;
use tokio::sync::Mutex;

use crate::errors::BusError;
use crate::traits::BusMessage;

#[derive(Debug, Clone)]
pub struct DeadLetterConfig {
    pub max_size: usize,
    pub ttl: Duration,
}

impl Default for DeadLetterConfig {
    fn default() -> Self {
        Self {
            max_size: 10_000,
            ttl: Duration::from_secs(3600),
        }
    }
}

#[derive(Debug, Clone)]
pub struct DeadLetterEntry {
    pub message: BusMessage,
    pub reason: String,
    pub added_at: DateTime<Utc>,
    pub last_attempt: DateTime<Utc>,
}

pub struct DeadLetterQueue {
    config: DeadLetterConfig,
    entries: Arc<Mutex<VecDeque<DeadLetterEntry>>>,
    total_added: Arc<AtomicU64>,
    total_evicted: Arc<AtomicU64>,
}

impl DeadLetterQueue {
    pub fn new(config: DeadLetterConfig) -> Self {
        Self {
            config,
            entries: Arc::new(Mutex::new(VecDeque::new())),
            total_added: Arc::new(AtomicU64::new(0)),
            total_evicted: Arc::new(AtomicU64::new(0)),
        }
    }

    pub async fn add(&self, message: BusMessage, reason: impl Into<String>) -> Result<(), BusError> {
        let mut entries = self.entries.lock().await;

        let now = Utc::now();
        while entries.len() >= self.config.max_size {
            entries.pop_front();
            self.total_evicted.fetch_add(1, Ordering::Relaxed);
        }

        let entry = DeadLetterEntry {
            message,
            reason: reason.into(),
            added_at: now,
            last_attempt: now,
        };
        entries.push_back(entry);
        self.total_added.fetch_add(1, Ordering::Relaxed);
        Ok(())
    }

    pub async fn evict_expired(&self) -> u64 {
        let mut entries = self.entries.lock().await;
        let now = Utc::now();
        let mut evicted = 0u64;

        while let Some(front) = entries.front() {
            let age = now
                .signed_duration_since(front.added_at)
                .to_std()
                .unwrap_or_default();
            if age > self.config.ttl {
                entries.pop_front();
                evicted += 1;
            } else {
                break;
            }
        }

        self.total_evicted.fetch_add(evicted, Ordering::Relaxed);
        evicted
    }

    pub async fn peek(&self) -> Option<DeadLetterEntry> {
        let entries = self.entries.lock().await;
        entries.front().cloned()
    }

    pub async fn drain(&self, max: usize) -> Vec<DeadLetterEntry> {
        let mut entries = self.entries.lock().await;
        let mut result = Vec::new();
        for _ in 0..max.min(entries.len()) {
            if let Some(entry) = entries.pop_front() {
                result.push(entry);
            }
        }
        result
    }

    pub async fn len(&self) -> usize {
        self.entries.lock().await.len()
    }

    pub async fn is_empty(&self) -> bool {
        self.entries.lock().await.is_empty()
    }

    pub fn total_added(&self) -> u64 {
        self.total_added.load(Ordering::Relaxed)
    }

    pub fn total_evicted(&self) -> u64 {
        self.total_evicted.load(Ordering::Relaxed)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{EventAction, EventCategory, EventSource};

    fn make_message() -> BusMessage {
        let source = EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "test-host".into(),
            agent_id: "agent-1".into(),
            agent_version: None,
            process_name: None,
            process_id: None,
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            service_name: None,
        };
        let event = security_os_core::SecurityEvent::new(
            EventCategory::Process,
            EventAction::Created,
            source,
            "test event",
            "test description",
        );
        BusMessage::new("test.topic", event)
    }

    #[tokio::test]
    async fn test_add_and_len() {
        let dlq = DeadLetterQueue::new(DeadLetterConfig::default());
        assert!(dlq.is_empty().await);
        dlq.add(make_message(), "test reason").await.unwrap();
        assert_eq!(dlq.len().await, 1);
        assert_eq!(dlq.total_added(), 1);
    }

    #[tokio::test]
    async fn test_evict_expired() {
        let config = DeadLetterConfig {
            max_size: 100,
            ttl: Duration::from_millis(1),
        };
        let dlq = DeadLetterQueue::new(config);
        dlq.add(make_message(), "reason").await.unwrap();
        tokio::time::sleep(Duration::from_millis(10)).await;
        let evicted = dlq.evict_expired().await;
        assert_eq!(evicted, 1);
        assert!(dlq.is_empty().await);
    }

    #[tokio::test]
    async fn test_max_size_eviction() {
        let config = DeadLetterConfig {
            max_size: 3,
            ttl: Duration::from_secs(3600),
        };
        let dlq = DeadLetterQueue::new(config);
        for _ in 0..5 {
            dlq.add(make_message(), "r").await.unwrap();
        }
        assert_eq!(dlq.len().await, 3);
        assert_eq!(dlq.total_evicted(), 2);
    }

    #[tokio::test]
    async fn test_drain() {
        let dlq = DeadLetterQueue::new(DeadLetterConfig::default());
        for _ in 0..5 {
            dlq.add(make_message(), "r").await.unwrap();
        }
        let drained = dlq.drain(3).await;
        assert_eq!(drained.len(), 3);
        assert_eq!(dlq.len().await, 2);
    }
}
