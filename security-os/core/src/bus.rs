use crate::event::SecurityEvent;
use tokio::sync::broadcast;
use tracing::{debug, info};

#[derive(Clone)]
pub struct EventBus {
    sender: broadcast::Sender<SecurityEvent>,
}

impl EventBus {
    pub fn new(channel_size: usize) -> Self {
        let (sender, _) = broadcast::channel(channel_size);
        info!(channel_size, "EventBus initialized");
        Self { sender }
    }

    pub fn publish(&self, event: SecurityEvent) {
        debug!(
            event_id = %event.id,
            category = ?event.category,
            severity = %event.severity,
            title = %event.title,
            "Event published"
        );
        let _ = self.sender.send(event);
    }

    pub fn subscribe(&self) -> broadcast::Receiver<SecurityEvent> {
        self.sender.subscribe()
    }

    pub fn subscriber_count(&self) -> usize {
        self.sender.receiver_count()
    }
}
