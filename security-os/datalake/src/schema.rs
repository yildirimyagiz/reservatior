use dashmap::DashMap;
use serde::{Deserialize, Serialize};
use security_os_core::SecurityEvent;

use crate::errors::DataLakeError;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum DataType {
    Bool,
    Int32,
    Int64,
    Float32,
    Float64,
    String,
    Binary,
    Timestamp,
    Date,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ColumnDef {
    pub name: String,
    pub data_type: DataType,
    pub nullable: bool,
    pub description: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EventSchema {
    pub name: String,
    pub version: u32,
    pub columns: Vec<ColumnDef>,
    pub partition_columns: Vec<String>,
}

impl EventSchema {
    pub fn default_security_schema() -> Self {
        Self {
            name: "security_event".to_string(),
            version: 1,
            columns: vec![
                ColumnDef { name: "id".to_string(), data_type: DataType::String, nullable: false, description: Some("Event UUID".to_string()) },
                ColumnDef { name: "timestamp".to_string(), data_type: DataType::Timestamp, nullable: false, description: Some("Event timestamp".to_string()) },
                ColumnDef { name: "category".to_string(), data_type: DataType::String, nullable: false, description: Some("Event category".to_string()) },
                ColumnDef { name: "action".to_string(), data_type: DataType::String, nullable: false, description: Some("Event action".to_string()) },
                ColumnDef { name: "severity".to_string(), data_type: DataType::String, nullable: false, description: Some("Event severity".to_string()) },
                ColumnDef { name: "confidence".to_string(), data_type: DataType::Float64, nullable: false, description: Some("Confidence score".to_string()) },
                ColumnDef { name: "source_host".to_string(), data_type: DataType::String, nullable: false, description: Some("Source hostname".to_string()) },
                ColumnDef { name: "title".to_string(), data_type: DataType::String, nullable: false, description: Some("Event title".to_string()) },
                ColumnDef { name: "description".to_string(), data_type: DataType::String, nullable: false, description: Some("Event description".to_string()) },
                ColumnDef { name: "risk_score".to_string(), data_type: DataType::Float64, nullable: false, description: Some("Risk score".to_string()) },
                ColumnDef { name: "src_ip".to_string(), data_type: DataType::String, nullable: true, description: Some("Source IP".to_string()) },
                ColumnDef { name: "dst_ip".to_string(), data_type: DataType::String, nullable: true, description: Some("Destination IP".to_string()) },
                ColumnDef { name: "src_port".to_string(), data_type: DataType::Int32, nullable: true, description: Some("Source port".to_string()) },
                ColumnDef { name: "dst_port".to_string(), data_type: DataType::Int32, nullable: true, description: Some("Destination port".to_string()) },
                ColumnDef { name: "region".to_string(), data_type: DataType::String, nullable: true, description: Some("Deployment region".to_string()) },
                ColumnDef { name: "mitre_tactic".to_string(), data_type: DataType::String, nullable: true, description: Some("MITRE tactic".to_string()) },
                ColumnDef { name: "mitre_technique".to_string(), data_type: DataType::String, nullable: true, description: Some("MITRE technique".to_string()) },
                ColumnDef { name: "tags".to_string(), data_type: DataType::String, nullable: true, description: Some("Comma-separated tags".to_string()) },
            ],
            partition_columns: vec!["timestamp".to_string(), "category".to_string(), "severity".to_string(), "region".to_string()],
        }
    }

    pub fn from_json(json: &serde_json::Value) -> Result<Self, DataLakeError> {
        let schema: EventSchema = serde_json::from_value(json.clone())?;
        schema.validate()?;
        Ok(schema)
    }

    pub fn to_json(&self) -> Result<serde_json::Value, DataLakeError> {
        Ok(serde_json::to_value(self)?)
    }

    pub fn validate(&self) -> Result<(), DataLakeError> {
        if self.name.is_empty() {
            return Err(DataLakeError::SchemaMismatch("Schema name cannot be empty".to_string()));
        }
        if self.version == 0 {
            return Err(DataLakeError::SchemaMismatch("Schema version must be >= 1".to_string()));
        }
        if self.columns.is_empty() {
            return Err(DataLakeError::SchemaMismatch("Schema must have at least one column".to_string()));
        }
        let mut names = std::collections::HashSet::new();
        for col in &self.columns {
            if !names.insert(&col.name) {
                return Err(DataLakeError::SchemaMismatch(format!("Duplicate column name: {}", col.name)));
            }
        }
        for part_col in &self.partition_columns {
            if !self.columns.iter().any(|c| &c.name == part_col) {
                return Err(DataLakeError::SchemaMismatch(format!(
                    "Partition column '{}' not found in columns",
                    part_col
                )));
            }
        }
        Ok(())
    }
}

pub struct SchemaRegistry {
    schemas: DashMap<String, EventSchema>,
}

impl SchemaRegistry {
    pub fn new() -> Self {
        Self { schemas: DashMap::new() }
    }

    pub fn register(&self, schema: EventSchema) -> Result<(), DataLakeError> {
        schema.validate()?;
        let key = format!("{}:v{}", schema.name, schema.version);
        self.schemas.insert(key, schema);
        Ok(())
    }

    pub fn get(&self, name: &str) -> Option<EventSchema> {
        self.schemas.get(name).map(|s| s.value().clone())
    }

    pub fn list(&self) -> Vec<EventSchema> {
        self.schemas.iter().map(|entry| entry.value().clone()).collect()
    }

    pub fn validate_event(&self, schema_name: &str, event: &SecurityEvent) -> Result<(), DataLakeError> {
        let schema = self.get(schema_name)
            .ok_or_else(|| DataLakeError::SchemaMismatch(format!("Schema '{}' not found", schema_name)))?;

        let mut event_map = std::collections::HashMap::new();
        event_map.insert("id", serde_json::Value::String(event.id.to_string()));
        event_map.insert("timestamp", serde_json::Value::String(event.timestamp.to_rfc3339()));
        event_map.insert("category", serde_json::Value::String(format!("{:?}", event.category)));
        event_map.insert("action", serde_json::Value::String(format!("{:?}", event.action)));
        event_map.insert("severity", serde_json::Value::String(format!("{}", event.severity)));
        event_map.insert("confidence", serde_json::json!(event.confidence));
        event_map.insert("title", serde_json::Value::String(event.title.clone()));
        event_map.insert("description", serde_json::Value::String(event.description.clone()));
        event_map.insert("risk_score", serde_json::json!(event.risk_score));

        for col in &schema.columns {
            if !col.nullable {
                if let Some(val) = event_map.get(col.name.as_str()) {
                    if val.is_null() {
                        return Err(DataLakeError::SchemaMismatch(format!(
                            "Non-nullable column '{}' has null value",
                            col.name
                        )));
                    }
                }
            }
        }
        Ok(())
    }
}

impl Default for SchemaRegistry {
    fn default() -> Self {
        Self::new()
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
        .with_severity(Severity::Medium)
    }

    #[test]
    fn test_default_security_schema() {
        let schema = EventSchema::default_security_schema();
        assert_eq!(schema.name, "security_event");
        assert_eq!(schema.version, 1);
        assert!(!schema.columns.is_empty());
        assert!(!schema.partition_columns.is_empty());
        assert!(schema.validate().is_ok());
    }

    #[test]
    fn test_schema_validate() {
        let mut schema = EventSchema::default_security_schema();
        assert!(schema.validate().is_ok());

        schema.name = String::new();
        assert!(schema.validate().is_err());

        schema.name = "valid".to_string();
        schema.version = 0;
        assert!(schema.validate().is_err());

        schema.version = 1;
        schema.columns.clear();
        assert!(schema.validate().is_err());

        schema.columns.push(ColumnDef {
            name: "col".to_string(),
            data_type: DataType::String,
            nullable: true,
            description: None,
        });
        schema.columns.push(ColumnDef {
            name: "col".to_string(),
            data_type: DataType::Int32,
            nullable: false,
            description: None,
        });
        assert!(schema.validate().is_err());

        schema.columns.clear();
        schema.columns.push(ColumnDef {
            name: "id".to_string(),
            data_type: DataType::String,
            nullable: false,
            description: None,
        });
        schema.partition_columns = vec!["nonexistent".to_string()];
        assert!(schema.validate().is_err());
    }

    #[test]
    fn test_registry_register_and_get() {
        let registry = SchemaRegistry::new();
        let schema = EventSchema::default_security_schema();
        let key = format!("{}:v{}", schema.name, schema.version);

        registry.register(schema.clone()).unwrap();
        let retrieved = registry.get(&key);
        assert!(retrieved.is_some());
        assert_eq!(retrieved.unwrap().name, "security_event");

        assert!(registry.get("nonexistent").is_none());
    }

    #[test]
    fn test_validate_event() {
        let registry = SchemaRegistry::new();
        let schema = EventSchema::default_security_schema();
        registry.register(schema).unwrap();

        let event = test_event();
        let key = "security_event:v1";
        assert!(registry.validate_event(key, &event).is_ok());
        assert!(registry.validate_event("nonexistent", &event).is_err());
    }
}
