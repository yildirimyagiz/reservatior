use chrono::{DateTime, Utc};
use dashmap::DashMap;
use security_os_core::*;
use std::collections::HashMap;
use thiserror::Error;
use uuid::Uuid;

// ── Errors ────────────────────────────────────────────────────────────────────

#[derive(Error, Debug)]
pub enum StorageError {
    #[error("ClickHouse connection error: {0}")]
    Connection(String),

    #[error("Query error: {0}")]
    Query(String),

    #[error("Serialization error: {0}")]
    Serialization(String),

    #[error("Not found: {0}")]
    NotFound(String),
}

pub type Result<T> = std::result::Result<T, StorageError>;

// ── Event Filters ─────────────────────────────────────────────────────────────

#[derive(Debug, Clone, Default)]
pub struct EventFilters {
    pub category: Option<EventCategory>,
    pub severity: Option<Severity>,
    pub start_time: Option<DateTime<Utc>>,
    pub end_time: Option<DateTime<Utc>>,
    pub host_id: Option<String>,
    pub user_id: Option<String>,
    pub limit: Option<u64>,
}

// ── ClickHouse Table Schema ───────────────────────────────────────────────────

pub const SECURITY_EVENTS_DDL: &str = r#"
CREATE TABLE IF NOT EXISTS security_events (
    id UUID DEFAULT generateUUIDv4(),
    timestamp DateTime64(3, 'UTC'),
    category LowCardinality(String),
    action LowCardinality(String),
    severity LowCardinality(String),
    confidence Float64,
    source_collector LowCardinality(String),
    source_host_id String,
    source_host_name String,
    source_agent_id String,
    source_agent_version Nullable(String),
    source_process_name Nullable(String),
    source_process_id Nullable(UInt32),
    source_user_id Nullable(String),
    source_user_name Nullable(String),
    source_container_id Nullable(String),
    source_container_name Nullable(String),
    source_pod_name Nullable(String),
    source_namespace Nullable(String),
    source_service_name Nullable(String),
    title String,
    description String,
    metadata String,
    risk_score Float64,
    mitre_tactic Nullable(String),
    mitre_technique Nullable(String),
    mitre_id Nullable(String),
    correlation_id Nullable(UUID),
    parent_event_id Nullable(UUID),
    chain_id Nullable(UUID),
    incident_id Nullable(UUID),
    tags Array(String),
    ioc_matches String,
    affected_entities String,
    tenant_id Nullable(String),
    environment Nullable(String),
    region Nullable(String),
    cluster Nullable(String),
    node_name Nullable(String),
    pid Nullable(UInt32),
    ppid Nullable(UInt32),
    uid Nullable(UInt32),
    gid Nullable(UInt32),
    exe Nullable(String),
    cmdline Nullable(String),
    username Nullable(String),
    session Nullable(String),
    process_hash_sha256 Nullable(String),
    process_signature Nullable(String),
    process_reputation Nullable(String),
    file_path Nullable(String),
    file_hash_sha256 Nullable(String),
    file_size Nullable(UInt64),
    file_permissions Nullable(String),
    src_ip Nullable(String),
    dst_ip Nullable(String),
    src_port Nullable(UInt16),
    dst_port Nullable(UInt16),
    protocol Nullable(String),
    country Nullable(String),
    asn Nullable(String),
    risk_delta Nullable(Float64),
    business_context Nullable(String),
    revenue_impact Nullable(Float64),
    rule_id Nullable(String),
    rule_name Nullable(String),
    inserted_at DateTime64(3, 'UTC') DEFAULT now()
) ENGINE = MergeTree()
PARTITION BY toYYYYMM(timestamp)
ORDER BY (timestamp, source_host_id, category, action)
TTL timestamp + INTERVAL 90 DAY
SETTINGS index_granularity = 8192;
"#;

// ── ClickHouse Store ──────────────────────────────────────────────────────────

pub struct ClickhouseStore {
    pub host: String,
    pub port: u16,
    pub database: String,
    pub username: String,
    pub password: String,
}

impl ClickhouseStore {
    pub fn new(
        host: impl Into<String>,
        port: u16,
        database: impl Into<String>,
        username: impl Into<String>,
        password: impl Into<String>,
    ) -> Self {
        Self {
            host: host.into(),
            port,
            database: database.into(),
            username: username.into(),
            password: password.into(),
        }
    }

    pub fn connection_string(&self) -> String {
        format!(
            "http://{}:{}?database={}&user={}&password={}",
            self.host, self.port, self.database, self.username, self.password
        )
    }

    pub fn create_table_ddl(&self) -> String {
        SECURITY_EVENTS_DDL.to_string()
    }

    pub fn insert_dml(&self, event: &SecurityEvent) -> String {
        let meta_json =
            serde_json::to_string(&event.metadata).unwrap_or_default();
        let ioc_json =
            serde_json::to_string(&event.ioc_matches).unwrap_or_default();
        let entities_json =
            serde_json::to_string(&event.affected_entities).unwrap_or_default();
        let tags_json: Vec<String> = event.tags.iter().map(|t| t.to_string()).collect();

        format!(
            "INSERT INTO security_events (\
                id, timestamp, category, action, severity, confidence, \
                source_collector, source_host_id, source_host_name, source_agent_id, \
                source_agent_version, source_process_name, source_process_id, \
                source_user_id, source_user_name, source_container_id, \
                source_container_name, source_pod_name, source_namespace, source_service_name, \
                title, description, metadata, risk_score, \
                mitre_tactic, mitre_technique, mitre_id, \
                correlation_id, parent_event_id, chain_id, incident_id, \
                tags, ioc_matches, affected_entities, \
                tenant_id, environment, region, cluster, node_name, \
                pid, ppid, uid, gid, exe, cmdline, username, session, \
                process_hash_sha256, process_signature, process_reputation, \
                file_path, file_hash_sha256, file_size, file_permissions, \
                src_ip, dst_ip, src_port, dst_port, protocol, country, asn, \
                risk_delta, business_context, revenue_impact, rule_id, rule_name\
            ) VALUES (\
                '{}', '{}', '{}', '{}', '{}', {}, \
                '{}', '{}', '{}', '{}', \
                {}, {}, {}, \
                {}, {}, {}, \
                {}, {}, {}, {}, \
                '{}', '{}', '{}', {}, \
                {}, {}, {}, \
                {}, {}, {}, {}, \
                [{}], '{}', '{}', \
                {}, {}, {}, {}, {}, \
                {}, {}, {}, {}, {}, {}, {}, {}, \
                {}, {}, {}, \
                {}, {}, {}, {}, \
                {}, {}, {}, {}, {}, {}, {}, \
                {}, {}, {}, {}, {}\
            )",
            event.id,
            event.timestamp.to_rfc3339(),
            format!("{:?}", event.category),
            format!("{:?}", event.action),
            format!("{}", event.severity),
            event.confidence,
            event.source.collector,
            event.source.host_id,
            event.source.host_name,
            event.source.agent_id,
            opt_str(&event.source.agent_version),
            opt_str(&event.source.process_name),
            opt_u32(event.source.process_id),
            opt_str(&event.source.user_id),
            opt_str(&event.source.user_name),
            opt_str(&event.source.container_id),
            opt_str(&event.source.container_name),
            opt_str(&event.source.pod_name),
            opt_str(&event.source.namespace),
            opt_str(&event.source.service_name),
            escape_sql(&event.title),
            escape_sql(&event.description),
            escape_sql(&meta_json),
            event.risk_score,
            opt_str(&event.mitre_tactic),
            opt_str(&event.mitre_technique),
            opt_str(&event.mitre_id),
            opt_uuid(event.correlation_id),
            opt_uuid(event.parent_event_id),
            opt_uuid(event.chain_id),
            opt_uuid(event.incident_id),
            tags_json
                .iter()
                .map(|t| format!("'{}'", escape_sql(t)))
                .collect::<Vec<_>>()
                .join(", "),
            escape_sql(&ioc_json),
            escape_sql(&entities_json),
            opt_str(&event.tenant_id),
            opt_str(&event.environment),
            opt_str(&event.region),
            opt_str(&event.cluster),
            opt_str(&event.node_name),
            opt_u32(event.pid),
            opt_u32(event.ppid),
            opt_u32(event.uid),
            opt_u32(event.gid),
            opt_str(&event.exe),
            opt_str(&event.cmdline),
            opt_str(&event.username),
            opt_str(&event.session),
            opt_str(&event.process_hash_sha256),
            opt_str(&event.process_signature),
            opt_str(&event.process_reputation),
            opt_str(&event.file_path),
            opt_str(&event.file_hash_sha256),
            opt_u64(event.file_size),
            opt_str(&event.file_permissions),
            opt_str(&event.src_ip),
            opt_str(&event.dst_ip),
            opt_u16(event.src_port),
            opt_u16(event.dst_port),
            opt_str(&event.protocol),
            opt_str(&event.country),
            opt_str(&event.asn),
            opt_f64(event.risk_delta),
            opt_str(&event.business_context),
            opt_f64(event.revenue_impact),
            opt_str(&event.rule_id),
            opt_str(&event.rule_name),
        )
    }
}

fn opt_str(val: &Option<String>) -> String {
    match val {
        Some(s) => format!("'{}'", escape_sql(s)),
        None => "NULL".into(),
    }
}

fn opt_u32(val: Option<u32>) -> String {
    match val {
        Some(v) => v.to_string(),
        None => "NULL".into(),
    }
}

fn opt_u64(val: Option<u64>) -> String {
    match val {
        Some(v) => v.to_string(),
        None => "NULL".into(),
    }
}

fn opt_u16(val: Option<u16>) -> String {
    match val {
        Some(v) => v.to_string(),
        None => "NULL".into(),
    }
}

fn opt_f64(val: Option<f64>) -> String {
    match val {
        Some(v) => v.to_string(),
        None => "NULL".into(),
    }
}

fn opt_uuid(val: Option<Uuid>) -> String {
    match val {
        Some(v) => format!("'{}'", v),
        None => "NULL".into(),
    }
}

fn escape_sql(s: &str) -> String {
    s.replace('\'', "''")
}

// ── Memory Store (Fallback for Testing) ───────────────────────────────────────

pub struct MemoryStore {
    events: DashMap<Uuid, SecurityEvent>,
}

impl MemoryStore {
    pub fn new() -> Self {
        Self {
            events: DashMap::new(),
        }
    }

    pub async fn insert(&self, event: SecurityEvent) -> Result<()> {
        self.events.insert(event.id, event);
        Ok(())
    }

    pub async fn batch_insert(&self, events: Vec<SecurityEvent>) -> Result<()> {
        for event in events {
            self.events.insert(event.id, event);
        }
        Ok(())
    }

    pub async fn query(&self, filters: EventFilters) -> Result<Vec<SecurityEvent>> {
        let mut results: Vec<SecurityEvent> = self
            .events
            .iter()
            .map(|r| r.value().clone())
            .filter(|e| {
                if let Some(ref cat) = filters.category {
                    if e.category != *cat {
                        return false;
                    }
                }
                if let Some(ref sev) = filters.severity {
                    if e.severity != *sev {
                        return false;
                    }
                }
                if let Some(start) = filters.start_time {
                    if e.timestamp < start {
                        return false;
                    }
                }
                if let Some(end) = filters.end_time {
                    if e.timestamp > end {
                        return false;
                    }
                }
                if let Some(ref host) = filters.host_id {
                    if e.source.host_id != *host {
                        return false;
                    }
                }
                if let Some(ref user) = filters.user_id {
                    if e.source.user_id.as_ref() != Some(user) {
                        return false;
                    }
                }
                true
            })
            .collect();

        results.sort_by(|a, b| b.timestamp.cmp(&a.timestamp));

        if let Some(limit) = filters.limit {
            results.truncate(limit as usize);
        }

        Ok(results)
    }

    pub async fn count_by_category(&self) -> Result<HashMap<String, u64>> {
        let mut counts: HashMap<String, u64> = HashMap::new();
        for entry in self.events.iter() {
            let cat = format!("{:?}", entry.value().category);
            *counts.entry(cat).or_default() += 1;
        }
        Ok(counts)
    }

    pub async fn count_by_severity(&self) -> Result<HashMap<String, u64>> {
        let mut counts: HashMap<String, u64> = HashMap::new();
        for entry in self.events.iter() {
            let sev = format!("{}", entry.value().severity);
            *counts.entry(sev).or_default() += 1;
        }
        Ok(counts)
    }

    pub async fn cleanup(&self, older_than: DateTime<Utc>) -> Result<u64> {
        let mut removed = 0u64;
        let keys: Vec<Uuid> = self
            .events
            .iter()
            .filter(|e| e.value().timestamp < older_than)
            .map(|e| *e.key())
            .collect();
        for key in keys {
            self.events.remove(&key);
            removed += 1;
        }
        Ok(removed)
    }
}

impl Default for MemoryStore {
    fn default() -> Self {
        Self::new()
    }
}

// ── Tests ─────────────────────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Duration;

    fn make_source(host: &str, user: Option<&str>) -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: host.into(),
            host_name: host.into(),
            agent_id: "agent-1".into(),
            agent_version: Some("1.0".into()),
            process_name: None,
            process_id: None,
            user_id: user.map(|s| s.into()),
            user_name: user.map(|s| s.into()),
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            service_name: None,
        }
    }

    fn make_event(cat: EventCategory, act: EventAction, host: &str) -> SecurityEvent {
        SecurityEvent::new(cat, act, make_source(host, Some("user-1")), "test", "desc")
    }

    #[tokio::test]
    async fn test_insert_and_query() {
        let store = MemoryStore::new();
        let event = make_event(EventCategory::Process, EventAction::Started, "host-1");
        let id = event.id;
        store.insert(event).await.unwrap();

        let results = store.query(EventFilters::default()).await.unwrap();
        assert_eq!(results.len(), 1);
        assert_eq!(results[0].id, id);
    }

    #[tokio::test]
    async fn test_batch_insert() {
        let store = MemoryStore::new();
        let events: Vec<SecurityEvent> = (0..5)
            .map(|i| make_event(
                if i % 2 == 0 { EventCategory::Process } else { EventCategory::Network },
                EventAction::Started,
                "host-1",
            ))
            .collect();
        store.batch_insert(events).await.unwrap();

        let results = store.query(EventFilters::default()).await.unwrap();
        assert_eq!(results.len(), 5);
    }

    #[tokio::test]
    async fn test_query_filter_by_category() {
        let store = MemoryStore::new();
        store.insert(make_event(EventCategory::Process, EventAction::Started, "h1")).await.unwrap();
        store.insert(make_event(EventCategory::Network, EventAction::Connected, "h1")).await.unwrap();
        store.insert(make_event(EventCategory::Process, EventAction::Executed, "h1")).await.unwrap();

        let filters = EventFilters {
            category: Some(EventCategory::Process),
            ..Default::default()
        };
        let results = store.query(filters).await.unwrap();
        assert_eq!(results.len(), 2);
        assert!(results.iter().all(|e| e.category == EventCategory::Process));
    }

    #[tokio::test]
    async fn test_query_filter_by_host() {
        let store = MemoryStore::new();
        store.insert(make_event(EventCategory::Process, EventAction::Started, "host-1")).await.unwrap();
        store.insert(make_event(EventCategory::Process, EventAction::Started, "host-2")).await.unwrap();

        let filters = EventFilters {
            host_id: Some("host-1".into()),
            ..Default::default()
        };
        let results = store.query(filters).await.unwrap();
        assert_eq!(results.len(), 1);
        assert_eq!(results[0].source.host_id, "host-1");
    }

    #[tokio::test]
    async fn test_query_filter_by_severity() {
        let store = MemoryStore::new();
        let mut e1 = make_event(EventCategory::Process, EventAction::Started, "h1");
        e1.severity = Severity::Low;
        let mut e2 = make_event(EventCategory::Process, EventAction::Started, "h1");
        e2.severity = Severity::Critical;
        store.insert(e1).await.unwrap();
        store.insert(e2).await.unwrap();

        let filters = EventFilters {
            severity: Some(Severity::Critical),
            ..Default::default()
        };
        let results = store.query(filters).await.unwrap();
        assert_eq!(results.len(), 1);
        assert_eq!(results[0].severity, Severity::Critical);
    }

    #[tokio::test]
    async fn test_query_limit() {
        let store = MemoryStore::new();
        for _ in 0..10 {
            store.insert(make_event(EventCategory::Process, EventAction::Started, "h1")).await.unwrap();
        }

        let filters = EventFilters {
            limit: Some(3),
            ..Default::default()
        };
        let results = store.query(filters).await.unwrap();
        assert_eq!(results.len(), 3);
    }

    #[tokio::test]
    async fn test_count_by_category() {
        let store = MemoryStore::new();
        store.insert(make_event(EventCategory::Process, EventAction::Started, "h1")).await.unwrap();
        store.insert(make_event(EventCategory::Process, EventAction::Started, "h1")).await.unwrap();
        store.insert(make_event(EventCategory::Network, EventAction::Connected, "h1")).await.unwrap();

        let counts = store.count_by_category().await.unwrap();
        assert_eq!(counts.get("Process"), Some(&2));
        assert_eq!(counts.get("Network"), Some(&1));
    }

    #[tokio::test]
    async fn test_count_by_severity() {
        let store = MemoryStore::new();
        let mut e1 = make_event(EventCategory::Process, EventAction::Started, "h1");
        e1.severity = Severity::Low;
        let mut e2 = make_event(EventCategory::Process, EventAction::Started, "h1");
        e2.severity = Severity::Low;
        let mut e3 = make_event(EventCategory::Process, EventAction::Started, "h1");
        e3.severity = Severity::Critical;
        store.insert(e1).await.unwrap();
        store.insert(e2).await.unwrap();
        store.insert(e3).await.unwrap();

        let counts = store.count_by_severity().await.unwrap();
        assert_eq!(counts.get("LOW"), Some(&2));
        assert_eq!(counts.get("CRITICAL"), Some(&1));
    }

    #[tokio::test]
    async fn test_cleanup_removes_old_events() {
        let store = MemoryStore::new();

        let mut old_event = make_event(EventCategory::Process, EventAction::Started, "h1");
        old_event.timestamp = Utc::now() - Duration::hours(48);
        store.insert(old_event).await.unwrap();

        let mut new_event = make_event(EventCategory::Process, EventAction::Started, "h1");
        new_event.timestamp = Utc::now();
        store.insert(new_event).await.unwrap();

        let cutoff = Utc::now() - Duration::hours(24);
        let removed = store.cleanup(cutoff).await.unwrap();
        assert_eq!(removed, 1);

        let remaining = store.query(EventFilters::default()).await.unwrap();
        assert_eq!(remaining.len(), 1);
    }

    #[tokio::test]
    async fn test_query_time_range() {
        let store = MemoryStore::new();

        let mut e1 = make_event(EventCategory::Process, EventAction::Started, "h1");
        e1.timestamp = Utc::now() - Duration::hours(10);
        let mut e2 = make_event(EventCategory::Process, EventAction::Started, "h1");
        e2.timestamp = Utc::now() - Duration::hours(5);
        let mut e3 = make_event(EventCategory::Process, EventAction::Started, "h1");
        e3.timestamp = Utc::now();
        store.insert(e1).await.unwrap();
        store.insert(e2).await.unwrap();
        store.insert(e3).await.unwrap();

        let filters = EventFilters {
            start_time: Some(Utc::now() - Duration::hours(6)),
            end_time: Some(Utc::now() - Duration::hours(2)),
            ..Default::default()
        };
        let results = store.query(filters).await.unwrap();
        assert_eq!(results.len(), 1);
    }

    #[test]
    fn test_clickhouse_ddl_is_valid() {
        assert!(SECURITY_EVENTS_DDL.contains("CREATE TABLE"));
        assert!(SECURITY_EVENTS_DDL.contains("MergeTree"));
        assert!(SECURITY_EVENTS_DDL.contains("security_events"));
    }

    #[test]
    fn test_clickhouse_insert_dml() {
        let store = ClickhouseStore::new("localhost", 8123, "default", "default", "");
        let event = make_event(EventCategory::Process, EventAction::Started, "host-1");
        let dml = store.insert_dml(&event);
        assert!(dml.starts_with("INSERT INTO security_events"));
        assert!(dml.contains(&event.id.to_string()));
    }

    #[test]
    fn test_clickhouse_connection_string() {
        let store = ClickhouseStore::new("ch.example.com", 9000, "security", "admin", "secret");
        let cs = store.connection_string();
        assert_eq!(
            cs,
            "http://ch.example.com:9000?database=security&user=admin&password=secret"
        );
    }

    #[tokio::test]
    async fn test_query_filter_by_user() {
        let store = MemoryStore::new();
        store.insert(make_event(EventCategory::Process, EventAction::Started, "h1")).await.unwrap();
        let mut e2 = make_event(EventCategory::Process, EventAction::Started, "h1");
        e2.source.user_id = Some("other-user".into());
        store.insert(e2).await.unwrap();

        let filters = EventFilters {
            user_id: Some("user-1".into()),
            ..Default::default()
        };
        let results = store.query(filters).await.unwrap();
        assert_eq!(results.len(), 1);
    }
}
