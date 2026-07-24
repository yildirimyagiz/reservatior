use std::sync::Arc;
use std::time::Duration;

use async_trait::async_trait;
use dashmap::DashMap;
use tokio::sync::RwLock;
use tracing::{debug, info, warn};

use crate::errors::BusError;
use crate::traits::{BackendHealth, BusMessage, BusStats, EventSubscription, EventBusBackend};

pub struct DistributedEventBus {
    primary: Arc<dyn EventBusBackend>,
    fallbacks: Arc<RwLock<Vec<Arc<dyn EventBusBackend>>>>,
    topic_routes: DashMap<String, String>,
    health_check_interval: Duration,
}

impl DistributedEventBus {
    pub fn new(primary: Arc<dyn EventBusBackend>) -> Self {
        Self {
            primary,
            fallbacks: Arc::new(RwLock::new(Vec::new())),
            topic_routes: DashMap::new(),
            health_check_interval: Duration::from_secs(30),
        }
    }

    pub fn with_health_check_interval(mut self, interval: Duration) -> Self {
        self.health_check_interval = interval;
        self
    }

    pub fn route_topic(&self, topic: &str, backend_name: &str) {
        self.topic_routes
            .insert(topic.to_string(), backend_name.to_string());
    }

    pub async fn add_fallback(&self, backend: Arc<dyn EventBusBackend>) {
        info!(backend = backend.name(), "adding fallback backend");
        self.fallbacks.write().await.push(backend);
    }

    fn resolve_backend(&self, topic: &str) -> Option<String> {
        self.topic_routes
            .get(topic)
            .map(|r| r.value().clone())
    }

    async fn find_healthy_backend(
        &self,
        topic: &str,
    ) -> Result<Arc<dyn EventBusBackend>, BusError> {
        if let Some(name) = self.resolve_backend(topic) {
            let fallbacks = self.fallbacks.read().await;
            for fb in fallbacks.iter() {
                if fb.name() == name && matches!(fb.health().await, BackendHealth::Healthy) {
                    return Ok(Arc::clone(fb));
                }
            }
        }

        if matches!(self.primary.health().await, BackendHealth::Healthy) {
            return Ok(Arc::clone(&self.primary));
        }

        let fallbacks = self.fallbacks.read().await;
        for fb in fallbacks.iter() {
            if matches!(fb.health().await, BackendHealth::Healthy) {
                return Ok(Arc::clone(fb));
            }
        }

        Err(BusError::NoHealthyBackend {
            topic: topic.to_string(),
        })
    }

    pub async fn start_health_loop(self: Arc<Self>) {
        loop {
            tokio::time::sleep(self.health_check_interval).await;
            let health = self.primary.health().await;
            match health {
                BackendHealth::Healthy => {}
                BackendHealth::Degraded { ref reason } => {
                    warn!(reason = %reason, "primary backend degraded");
                }
                BackendHealth::Unhealthy { ref reason } => {
                    warn!(reason = %reason, "primary backend unhealthy, checking fallbacks");
                    let fallbacks = self.fallbacks.read().await;
                    for fb in fallbacks.iter() {
                        let h = fb.health().await;
                        debug!(backend = fb.name(), health = ?h, "fallback backend health");
                    }
                }
                BackendHealth::Disconnected => {
                    warn!("primary backend disconnected, checking fallbacks");
                    let fallbacks = self.fallbacks.read().await;
                    for fb in fallbacks.iter() {
                        let h = fb.health().await;
                        debug!(backend = fb.name(), health = ?h, "fallback backend health");
                    }
                }
            }
        }
    }
}

#[async_trait]
impl EventBusBackend for DistributedEventBus {
    async fn publish(&self, message: BusMessage) -> Result<(), BusError> {
        let backend = self.find_healthy_backend(&message.topic).await?;
        backend.publish(message).await
    }

    async fn subscribe(&self, topic: &str) -> Result<Box<dyn EventSubscription>, BusError> {
        let backend = self.find_healthy_backend(topic).await?;
        backend.subscribe(topic).await
    }

    async fn health(&self) -> BackendHealth {
        match self.primary.health().await {
            BackendHealth::Healthy => BackendHealth::Healthy,
            other => {
                let fallbacks = self.fallbacks.read().await;
                for fb in fallbacks.iter() {
                    if matches!(fb.health().await, BackendHealth::Healthy) {
                        return BackendHealth::Degraded {
                            reason: format!(
                                "primary unhealthy, using fallback '{}'",
                                fb.name()
                            ),
                        };
                    }
                }
                other
            }
        }
    }

    async fn stats(&self) -> BusStats {
        self.primary.stats().await
    }

    fn name(&self) -> &str {
        "distributed"
    }
}
