use async_trait::async_trait;

use crate::errors::BusError;
use crate::traits::{BackendHealth, BusMessage, BusStats, EventSubscription, EventBusBackend};

pub struct NatsBackend {
    _url: String,
}

impl NatsBackend {
    pub async fn new(url: &str) -> Result<Self, BusError> {
        #[cfg(feature = "nats")]
        {
            let _ = url;
            Ok(Self {
                _url: url.to_string(),
            })
        }
        #[cfg(not(feature = "nats"))]
        {
            Err(BusError::BackendUnavailable {
                backend: "nats".into(),
                reason: "NATS feature is not enabled".into(),
            })
        }
    }
}

#[async_trait]
impl EventBusBackend for NatsBackend {
    async fn publish(&self, _message: BusMessage) -> Result<(), BusError> {
        #[cfg(feature = "nats")]
        {
            todo!("NATS publish implementation")
        }
        #[cfg(not(feature = "nats"))]
        {
            Err(BusError::BackendUnavailable {
                backend: "nats".into(),
                reason: "NATS feature is not enabled".into(),
            })
        }
    }

    async fn subscribe(&self, _topic: &str) -> Result<Box<dyn EventSubscription>, BusError> {
        #[cfg(feature = "nats")]
        {
            todo!("NATS subscribe implementation")
        }
        #[cfg(not(feature = "nats"))]
        {
            Err(BusError::BackendUnavailable {
                backend: "nats".into(),
                reason: "NATS feature is not enabled".into(),
            })
        }
    }

    async fn health(&self) -> BackendHealth {
        #[cfg(feature = "nats")]
        {
            todo!("NATS health check")
        }
        #[cfg(not(feature = "nats"))]
        {
            BackendHealth::Disconnected
        }
    }

    async fn stats(&self) -> BusStats {
        BusStats::default()
    }

    fn name(&self) -> &str {
        "nats"
    }
}
