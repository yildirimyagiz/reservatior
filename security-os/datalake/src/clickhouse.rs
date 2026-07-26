use dashmap::DashMap;
use security_os_core::SecurityEvent;
use tracing::info;

use crate::errors::DataLakeError;

pub struct InMemoryBackend {
    events: DashMap<String, serde_json::Value>,
}

impl InMemoryBackend {
    pub fn new() -> Self {
        Self {
            events: DashMap::new(),
        }
    }
}

impl Default for InMemoryBackend {
    fn default() -> Self {
        Self::new()
    }
}

pub enum ClickHouseBackend {
    ClickHouse { url: String, database: String },
    InMemory(InMemoryBackend),
}

pub struct ClickHouseClient {
    backend: ClickHouseBackend,
    _batch_size: usize,
    buffer: Vec<serde_json::Value>,
}

impl ClickHouseClient {
    pub fn new_in_memory() -> Self {
        Self {
            backend: ClickHouseBackend::InMemory(InMemoryBackend::new()),
            _batch_size: 1000,
            buffer: Vec::new(),
        }
    }

    pub fn new_clickhouse(url: &str, database: &str) -> Self {
        Self {
            backend: ClickHouseBackend::ClickHouse {
                url: url.to_string(),
                database: database.to_string(),
            },
            _batch_size: 1000,
            buffer: Vec::new(),
        }
    }

    pub async fn insert_event(&self, event: &SecurityEvent) -> Result<(), DataLakeError> {
        let value = serde_json::to_value(event)?;
        match &self.backend {
            ClickHouseBackend::InMemory(backend) => {
                backend.events.insert(event.id.to_string(), value);
                Ok(())
            }
            ClickHouseBackend::ClickHouse { url, database } => {
                info!(
                    url = %url,
                    database = %database,
                    event_id = %event.id,
                    "Inserting event into ClickHouse (simulated)"
                );
                Ok(())
            }
        }
    }

    pub async fn insert_batch(&self, events: &[SecurityEvent]) -> Result<usize, DataLakeError> {
        let mut count = 0;
        for event in events {
            self.insert_event(event).await?;
            count += 1;
        }
        Ok(count)
    }

    pub async fn query(&self, query: &str) -> Result<Vec<serde_json::Value>, DataLakeError> {
        match &self.backend {
            ClickHouseBackend::InMemory(backend) => {
                let results: Vec<serde_json::Value> = backend.events.iter()
                    .map(|entry| entry.value().clone())
                    .collect();
                info!(query = %query, result_count = results.len(), "In-memory query executed");
                Ok(results)
            }
            ClickHouseBackend::ClickHouse { url, database } => {
                info!(
                    url = %url,
                    database = %database,
                    query = %query,
                    "Executing ClickHouse query (simulated)"
                );
                Ok(Vec::new())
            }
        }
    }

    pub async fn count_events(&self) -> Result<u64, DataLakeError> {
        match &self.backend {
            ClickHouseBackend::InMemory(backend) => {
                Ok(backend.events.len() as u64)
            }
            ClickHouseBackend::ClickHouse { url, database } => {
                info!(
                    url = %url,
                    database = %database,
                    "Counting events in ClickHouse (simulated)"
                );
                Ok(0)
            }
        }
    }

    pub async fn health_check(&self) -> bool {
        match &self.backend {
            ClickHouseBackend::InMemory(_) => true,
            ClickHouseBackend::ClickHouse { url, database } => {
                info!(
                    url = %url,
                    database = %database,
                    "ClickHouse health check (simulated)"
                );
                true
            }
        }
    }

    pub fn flush_buffer(&self) -> Result<usize, DataLakeError> {
        let _ = &self.buffer;
        Ok(0)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{EventAction, EventCategory, EventSource, Severity};
    fn default_source() -> EventSource {
        EventSource {
            collector: "test".to_string(),
            host_id: "host-1".to_string(),
            host_name: "test-host".to_string(),
            agent_id: "agent-1".to_string(),
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
        }
    }

    fn test_event() -> SecurityEvent {
        SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            default_source(),
            "Test Event",
            "A test security event",
        )
        .with_severity(Severity::High)
    }

    #[tokio::test]
    async fn test_insert_event() {
        let client = ClickHouseClient::new_in_memory();
        let event = test_event();

        let result = client.insert_event(&event).await;
        assert!(result.is_ok());

        let count = client.count_events().await.unwrap();
        assert_eq!(count, 1);
    }

    #[tokio::test]
    async fn test_insert_batch() {
        let client = ClickHouseClient::new_in_memory();
        let events: Vec<SecurityEvent> = (0..5).map(|_| test_event()).collect();

        let inserted = client.insert_batch(&events).await.unwrap();
        assert_eq!(inserted, 5);

        let count = client.count_events().await.unwrap();
        assert_eq!(count, 5);
    }

    #[tokio::test]
    async fn test_count_events() {
        let client = ClickHouseClient::new_in_memory();

        let count = client.count_events().await.unwrap();
        assert_eq!(count, 0);

        client.insert_event(&test_event()).await.unwrap();
        client.insert_event(&test_event()).await.unwrap();

        let count = client.count_events().await.unwrap();
        assert_eq!(count, 2);
    }

    #[tokio::test]
    async fn test_in_memory_query() {
        let client = ClickHouseClient::new_in_memory();
        client.insert_event(&test_event()).await.unwrap();

        let results = client.query("SELECT * FROM events").await.unwrap();
        assert_eq!(results.len(), 1);

        let health = client.health_check().await;
        assert!(health);
    }
}
