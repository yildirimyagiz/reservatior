pub mod backpressure;
pub mod dead_letter;
pub mod distributed;
pub mod errors;
pub mod traits;

#[cfg(feature = "local")]
pub mod local;
#[cfg(feature = "nats")]
pub mod nats;
#[cfg(feature = "kafka")]
pub mod kafka;

pub use backpressure::{BackpressureConfig, BackpressureManager};
pub use dead_letter::{DeadLetterConfig, DeadLetterEntry, DeadLetterQueue};
pub use distributed::DistributedEventBus;
pub use errors::BusError;
pub use traits::{BackendHealth, BusMessage, BusStats, EventSubscription, EventBusBackend};

#[cfg(feature = "local")]
pub use local::LocalBackend;
#[cfg(feature = "nats")]
pub use nats::NatsBackend;
#[cfg(feature = "kafka")]
pub use kafka::KafkaBackend;
