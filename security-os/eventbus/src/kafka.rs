use async_trait::async_trait;

use crate::errors::BusError;
use crate::traits::{BackendHealth, BusMessage, BusStats, EventSubscription, EventBusBackend};

pub struct KafkaBackend {
    _brokers: String,
}

impl KafkaBackend {
    pub async fn new(brokers: &str) -> Result<Self, BusError> {
        #[cfg(feature = "kafka")]
        {
            let _ = brokers;
            Ok(Self {
                _brokers: brokers.to_string(),
            })
        }
        #[cfg(not(feature = "kafka"))]
        {
            Err(BusError::BackendUnavailable {
                backend: "kafka".into(),
                reason: "Kafka feature is not enabled".into(),
            })
        }
    }
}

#[async_trait]
impl EventBusBackend for KafkaBackend {
    async fn publish(&self, _message: BusMessage) -> Result<(), BusError> {
        #[cfg(feature = "kafka")]
        {
            todo!("Kafka publish implementation")
        }
        #[cfg(not(feature = "kafka"))]
        {
            Err(BusError::BackendUnavailable {
                backend: "kafka".into(),
                reason: "Kafka feature is not enabled".into(),
            })
        }
    }

    async fn subscribe(&self, _topic: &str) -> Result<Box<dyn EventSubscription>, BusError> {
        #[cfg(feature = "kafka")]
        {
            todo!("Kafka subscribe implementation")
        }
        #[cfg(not(feature = "kafka"))]
        {
            Err(BusError::BackendUnavailable {
                backend: "kafka".into(),
                reason: "Kafka feature is not enabled".into(),
            })
        }
    }

    async fn health(&self) -> BackendHealth {
        #[cfg(feature = "kafka")]
        {
            todo!("Kafka health check")
        }
        #[cfg(not(feature = "kafka"))]
        {
            BackendHealth::Disconnected
        }
    }

    async fn stats(&self) -> BusStats {
        BusStats::default()
    }

    fn name(&self) -> &str {
        "kafka"
    }
}
