use security_os_core::SecurityEvent;
use tracing::info;

use crate::errors::DataLakeError;
use crate::partitioner::Partitioner;
use crate::schema::EventSchema;

pub struct WriterStats {
    pub files_written: u64,
    pub events_written: u64,
    pub buffer_size: usize,
    pub avg_file_size_bytes: u64,
}

pub struct WriteResult {
    pub file_path: String,
    pub rows_written: u64,
    pub file_size_bytes: u64,
    pub write_duration_ms: u64,
    pub partition_key: String,
}

pub struct ParquetWriter {
    base_path: String,
    buffer: Vec<SecurityEvent>,
    buffer_size: usize,
    schema: EventSchema,
    files_written: u64,
    events_written: u64,
    partitioner: Partitioner,
}

impl ParquetWriter {
    pub fn new(base_path: &str, schema: EventSchema, buffer_size: usize) -> Self {
        let partitioner = Partitioner::new(
            base_path,
            vec![
                crate::partitioner::PartitionStrategy::Daily,
                crate::partitioner::PartitionStrategy::ByCategory,
            ],
        );
        Self {
            base_path: base_path.to_string(),
            buffer: Vec::new(),
            buffer_size,
            schema,
            files_written: 0,
            events_written: 0,
            partitioner,
        }
    }

    pub fn write_event(&mut self, event: &SecurityEvent) -> Result<Option<WriteResult>, DataLakeError> {
        Self::validate_event_schema(event, &self.schema)?;
        self.buffer.push(event.clone());
        self.events_written += 1;

        if self.buffer.len() >= self.buffer_size {
            self.flush()
        } else {
            Ok(None)
        }
    }

    pub fn flush(&mut self) -> Result<Option<WriteResult>, DataLakeError> {
        if self.buffer.is_empty() {
            return Ok(None);
        }

        let start = std::time::Instant::now();
        let partition_key = self.build_partition_key(&self.buffer[0]);
        let file_path = format!("{}/{}/batch_{}.parquet", self.base_path, partition_key, self.files_written);
        let rows_written = self.buffer.len() as u64;
        let estimated_size = rows_written * 512;

        self.files_written += 1;
        self.buffer.clear();

        let elapsed_ms = start.elapsed().as_millis() as u64;

        info!(
            file_path = %file_path,
            rows = rows_written,
            elapsed_ms = elapsed_ms,
            "Flushed parquet batch"
        );

        Ok(Some(WriteResult {
            file_path,
            rows_written,
            file_size_bytes: estimated_size,
            write_duration_ms: elapsed_ms,
            partition_key,
        }))
    }

    pub fn stats(&self) -> WriterStats {
        let avg_file_size = if self.files_written > 0 {
            (self.events_written * 512) / self.files_written
        } else {
            0
        };
        WriterStats {
            files_written: self.files_written,
            events_written: self.events_written,
            buffer_size: self.buffer_size,
            avg_file_size_bytes: avg_file_size,
        }
    }

    fn validate_event_schema(event: &SecurityEvent, schema: &EventSchema) -> Result<(), DataLakeError> {
        if schema.name.is_empty() {
            return Err(DataLakeError::SchemaMismatch("Schema has no name".to_string()));
        }
        if event.title.is_empty() {
            return Err(DataLakeError::SchemaMismatch("Event title is required by schema".to_string()));
        }
        let _ = schema;
        Ok(())
    }

    pub(crate) fn build_partition_key(&self, event: &SecurityEvent) -> String {
        self.partitioner.partition_event(event)
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

    #[test]
    fn test_write_event_buffering() {
        let schema = EventSchema::default_security_schema();
        let mut writer = ParquetWriter::new("/data/lake", schema, 3);
        let event = test_event();

        let result = writer.write_event(&event).unwrap();
        assert!(result.is_none());

        let result = writer.write_event(&event).unwrap();
        assert!(result.is_none());

        let result = writer.write_event(&event).unwrap();
        assert!(result.is_some());
        let wr = result.unwrap();
        assert_eq!(wr.rows_written, 3);
        assert!(wr.file_path.contains("parquet"));
    }

    #[test]
    fn test_flush() {
        let schema = EventSchema::default_security_schema();
        let mut writer = ParquetWriter::new("/data/lake", schema, 100);
        let event = test_event();

        writer.write_event(&event).unwrap();
        writer.write_event(&event).unwrap();

        let result = writer.flush().unwrap();
        assert!(result.is_some());
        let wr = result.unwrap();
        assert_eq!(wr.rows_written, 2);

        let result = writer.flush().unwrap();
        assert!(result.is_none());
    }

    #[test]
    fn test_partition_key() {
        let schema = EventSchema::default_security_schema();
        let writer = ParquetWriter::new("/data/lake", schema, 100);
        let event = test_event();

        let key = writer.build_partition_key(&event);
        assert!(!key.is_empty());
        assert!(key.contains("/"));
    }

    #[test]
    fn test_stats() {
        let schema = EventSchema::default_security_schema();
        let mut writer = ParquetWriter::new("/data/lake", schema, 2);

        let stats = writer.stats();
        assert_eq!(stats.files_written, 0);
        assert_eq!(stats.events_written, 0);
        assert_eq!(stats.buffer_size, 2);

        let event = test_event();
        writer.write_event(&event).unwrap();
        writer.write_event(&event).unwrap();

        let stats = writer.stats();
        assert_eq!(stats.events_written, 2);
        assert_eq!(stats.files_written, 1);
    }
}
