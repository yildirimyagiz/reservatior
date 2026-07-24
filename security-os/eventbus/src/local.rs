use std::sync::Arc;

use async_trait::async_trait;
use dashmap::DashMap;
use tokio::sync::broadcast;
use tracing::{debug, warn};

use crate::errors::BusError;
use crate::traits::{BackendHealth, BusMessage, BusStats, EventSubscription, EventBusBackend};

const DEFAULT_CHANNEL_SIZE: usize = 10_000;

struct TopicChannel {
    sender: broadcast::Sender<BusMessage>,
}

pub struct LocalBackend {
    channels: DashMap<String, TopicChannel>,
    channel_size: usize,
    stats: Arc<LocalStats>,
}

struct LocalStats {
    messages_published: std::sync::atomic::AtomicU64,
    messages_consumed: std::sync::atomic::AtomicU64,
    messages_dropped: std::sync::atomic::AtomicU64,
    active_subscribers: std::sync::atomic::AtomicUsize,
}

impl LocalBackend {
    pub fn new(channel_size: Option<usize>) -> Self {
        Self {
            channels: DashMap::new(),
            channel_size: channel_size.unwrap_or(DEFAULT_CHANNEL_SIZE),
            stats: Arc::new(LocalStats {
                messages_published: std::sync::atomic::AtomicU64::new(0),
                messages_consumed: std::sync::atomic::AtomicU64::new(0),
                messages_dropped: std::sync::atomic::AtomicU64::new(0),
                active_subscribers: std::sync::atomic::AtomicUsize::new(0),
            }),
        }
    }

    fn get_or_create_channel(&self, topic: &str) -> broadcast::Sender<BusMessage> {
        self.channels
            .entry(topic.to_string())
            .or_insert_with(|| TopicChannel {
                sender: broadcast::channel(self.channel_size).0,
            })
            .sender
            .clone()
    }
}

#[async_trait]
impl EventBusBackend for LocalBackend {
    async fn publish(&self, message: BusMessage) -> Result<(), BusError> {
        let topic = message.topic.clone();
        let sender = self.get_or_create_channel(&topic);

        match sender.send(message) {
            Ok(_) => {
                self.stats
                    .messages_published
                    .fetch_add(1, std::sync::atomic::Ordering::Relaxed);
                debug!(topic = %topic, "message published to local bus");
                Ok(())
            }
            Err(_) => {
                self.stats
                    .messages_dropped
                    .fetch_add(1, std::sync::atomic::Ordering::Relaxed);
                warn!(topic = %topic, "no active subscribers, message dropped");
                Ok(())
            }
        }
    }

    async fn subscribe(&self, topic: &str) -> Result<Box<dyn EventSubscription>, BusError> {
        let sender = self.get_or_create_channel(topic);
        let receiver = sender.subscribe();

        self.stats
            .active_subscribers
            .fetch_add(1, std::sync::atomic::Ordering::Relaxed);

        debug!(topic = %topic, "new subscriber on local bus");

        Ok(Box::new(LocalSubscription {
            receiver,
            topic: topic.to_string(),
            stats: Arc::clone(&self.stats),
        }))
    }

    async fn health(&self) -> BackendHealth {
        BackendHealth::Healthy
    }

    async fn stats(&self) -> BusStats {
        BusStats {
            messages_published: self
                .stats
                .messages_published
                .load(std::sync::atomic::Ordering::Relaxed),
            messages_consumed: self
                .stats
                .messages_consumed
                .load(std::sync::atomic::Ordering::Relaxed),
            messages_dropped: self
                .stats
                .messages_dropped
                .load(std::sync::atomic::Ordering::Relaxed),
            active_subscribers: self
                .stats
                .active_subscribers
                .load(std::sync::atomic::Ordering::Relaxed),
            ..Default::default()
        }
    }

    fn name(&self) -> &str {
        "local"
    }
}

struct LocalSubscription {
    receiver: broadcast::Receiver<BusMessage>,
    topic: String,
    stats: Arc<LocalStats>,
}

#[async_trait]
impl EventSubscription for LocalSubscription {
    async fn next(&mut self) -> Option<BusMessage> {
        match self.receiver.recv().await {
            Ok(msg) => {
                self.stats
                    .messages_consumed
                    .fetch_add(1, std::sync::atomic::Ordering::Relaxed);
                Some(msg)
            }
            Err(broadcast::error::RecvError::Lagged(n)) => {
                self.stats
                    .messages_dropped
                    .fetch_add(n as u64, std::sync::atomic::Ordering::Relaxed);
                warn!(topic = %self.topic, lagged = n, "subscriber lagged, messages dropped");
                None
            }
            Err(broadcast::error::RecvError::Closed) => None,
        }
    }

    fn topic(&self) -> &str {
        &self.topic
    }

    async fn unsubscribe(self: Box<Self>) -> Result<(), BusError> {
        self.stats
            .active_subscribers
            .fetch_sub(1, std::sync::atomic::Ordering::Relaxed);
        debug!(topic = %self.topic, "subscriber removed from local bus");
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{EventAction, EventCategory, EventSource};

    fn make_event() -> security_os_core::SecurityEvent {
        let source = EventSource {
            collector: "test".into(),
            host_id: "h1".into(),
            host_name: "test-host".into(),
            agent_id: "a1".into(),
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
        security_os_core::SecurityEvent::new(
            EventCategory::Process,
            EventAction::Created,
            source,
            "test",
            "desc",
        )
    }

    #[tokio::test]
    async fn test_publish_subscribe() {
        let backend = LocalBackend::new(None);
        let mut sub = backend.subscribe("topic-a").await.unwrap();
        let msg = BusMessage::new("topic-a", make_event());
        backend.publish(msg.clone()).await.unwrap();
        let received = sub.next().await.unwrap();
        assert_eq!(received.id, msg.id);
        let _ = Box::new(sub).unsubscribe().await;
    }

    #[tokio::test]
    async fn test_topic_isolation() {
        let backend = LocalBackend::new(None);
        let mut sub_a = backend.subscribe("topic-a").await.unwrap();
        let mut sub_b = backend.subscribe("topic-b").await.unwrap();

        let msg_a = BusMessage::new("topic-a", make_event());
        let msg_b = BusMessage::new("topic-b", make_event());

        backend.publish(msg_a).await.unwrap();
        backend.publish(msg_b).await.unwrap();

        let received_a = sub_a.next().await.unwrap();
        assert_eq!(received_a.topic, "topic-a");

        let received_b = sub_b.next().await.unwrap();
        assert_eq!(received_b.topic, "topic-b");

        let _ = Box::new(sub_a).unsubscribe().await;
        let _ = Box::new(sub_b).unsubscribe().await;
    }

    #[tokio::test]
    async fn test_multiple_subscribers() {
        let backend = LocalBackend::new(None);
        let mut sub1 = backend.subscribe("shared").await.unwrap();
        let mut sub2 = backend.subscribe("shared").await.unwrap();

        let msg = BusMessage::new("shared", make_event());
        backend.publish(msg).await.unwrap();

        let r1 = sub1.next().await.unwrap();
        let r2 = sub2.next().await.unwrap();
        assert_eq!(r1.topic, r2.topic);

        let _ = Box::new(sub1).unsubscribe().await;
        let _ = Box::new(sub2).unsubscribe().await;
    }

    #[tokio::test]
    async fn test_stats_tracking() {
        let backend = LocalBackend::new(None);
        let sub = backend.subscribe("t").await.unwrap();
        let msg = BusMessage::new("t", make_event());
        backend.publish(msg).await.unwrap();

        let stats = backend.stats().await;
        assert_eq!(stats.messages_published, 1);
        let _ = Box::new(sub).unsubscribe().await;
    }

    #[tokio::test]
    async fn test_health() {
        let backend = LocalBackend::new(None);
        assert!(matches!(backend.health().await, BackendHealth::Healthy));
    }
}
