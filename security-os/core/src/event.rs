use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use uuid::Uuid;

// ── Event Categories ──────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub enum EventCategory {
    Process,
    Network,
    Filesystem,
    Container,
    Authentication,
    Api,
    Secrets,
    Cloud,
    Database,
    ConfigurationDrift,
    Behavior,
    ReservatiorBusiness,
    System,
    Kernel,
    Identity,
    Ssh,
    Kubernetes,
    Dns,
    Tls,
    Jwt,
    Cron,
    Sudo,
    Selinux,
    Apparmor,
    Usb,
    Gpu,
    Memory,
    SupplyChain,
    ThreatIntelligence,
    AiAbuse,
    Incident,
}

// ── Event Actions ─────────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub enum EventAction {
    Created,
    Started,
    Modified,
    Deleted,
    Stopped,
    Executed,
    Connected,
    Disconnected,
    Failed,
    Allowed,
    Blocked,
    Escalated,
    Rotated,
    Detected,
    Correlated,
    Analyzed,
    Responded,
    Attempted,
    Expired,
    Revoked,
    Suspended,
    Locked,
    Unlocked,
    Captured,
    Released,
    Refunded,
    Compensated,
    Imported,
    Received,
    Sent,
}

// ── Core Security Event ───────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SecurityEvent {
    pub id: Uuid,
    pub timestamp: DateTime<Utc>,
    pub category: EventCategory,
    pub action: EventAction,
    pub severity: crate::Severity,
    pub confidence: f64,
    pub source: EventSource,
    pub title: String,
    pub description: String,
    pub metadata: HashMap<String, serde_json::Value>,
    pub risk_score: f64,

    // ── MITRE ATT&CK ──
    pub mitre_tactic: Option<String>,
    pub mitre_technique: Option<String>,
    pub mitre_id: Option<String>,

    // ── Correlation ──
    pub correlation_id: Option<Uuid>,
    pub parent_event_id: Option<Uuid>,
    pub chain_id: Option<Uuid>,
    pub incident_id: Option<Uuid>,

    // ── Tags & Intelligence ──
    pub tags: Vec<String>,
    pub ioc_matches: Vec<IocMatch>,
    pub affected_entities: Vec<Entity>,

    // ── Multi-tenancy ──
    pub tenant_id: Option<String>,
    pub environment: Option<String>,

    // ── Infrastructure Context ──
    pub region: Option<String>,
    pub cluster: Option<String>,
    pub node_name: Option<String>,

    // ── Process Context ──
    pub pid: Option<u32>,
    pub ppid: Option<u32>,
    pub uid: Option<u32>,
    pub gid: Option<u32>,
    pub exe: Option<String>,
    pub cmdline: Option<String>,
    pub username: Option<String>,
    pub session: Option<String>,
    pub process_hash_sha256: Option<String>,
    pub process_signature: Option<String>,
    pub process_reputation: Option<String>,

    // ── File Context ──
    pub file_path: Option<String>,
    pub file_hash_sha256: Option<String>,
    pub file_size: Option<u64>,
    pub file_permissions: Option<String>,

    // ── Network Context ──
    pub src_ip: Option<String>,
    pub dst_ip: Option<String>,
    pub src_port: Option<u16>,
    pub dst_port: Option<u16>,
    pub protocol: Option<String>,
    pub country: Option<String>,
    pub asn: Option<String>,

    // ── Risk & Business ──
    pub risk_delta: Option<f64>,
    pub business_context: Option<String>,
    pub revenue_impact: Option<f64>,

    // ── Rule Match ──
    pub rule_id: Option<String>,
    pub rule_name: Option<String>,
}

// ── Event Source ──────────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EventSource {
    pub collector: String,
    pub host_id: String,
    pub host_name: String,
    pub agent_id: String,
    pub agent_version: Option<String>,
    pub process_name: Option<String>,
    pub process_id: Option<u32>,
    pub user_id: Option<String>,
    pub user_name: Option<String>,
    pub container_id: Option<String>,
    pub container_name: Option<String>,
    pub pod_name: Option<String>,
    pub namespace: Option<String>,
    pub service_name: Option<String>,
}

// ── IOC Match ─────────────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IocMatch {
    pub ioc_type: String,
    pub ioc_value: String,
    pub feed: String,
    pub feed_url: Option<String>,
    pub match_context: String,
    pub confidence: f64,
    pub first_seen: Option<DateTime<Utc>>,
    pub last_seen: Option<DateTime<Utc>>,
}

// ── Entity Types ──────────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub enum EntityType {
    Host,
    User,
    Process,
    Container,
    Pod,
    Namespace,
    Cluster,
    Ip,
    Domain,
    File,
    ApiKey,
    Jwt,
    Certificate,
    Hash,
    Url,
    Booking,
    Escrow,
    Payment,
    Commission,
    Worker,
    Webhook,
    Saga,
}

// ── Entity ────────────────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Entity {
    pub entity_type: EntityType,
    pub value: String,
    pub risk_contribution: f64,
    pub metadata: HashMap<String, serde_json::Value>,
}

// ── Incident ──────────────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Incident {
    pub id: Uuid,
    pub title: String,
    pub description: String,
    pub severity: crate::Severity,
    pub status: IncidentStatus,
    pub mitre_tactic: Option<String>,
    pub mitre_technique: Option<String>,
    pub kill_chain_phase: Option<String>,
    pub root_cause: Option<String>,
    pub business_impact: Option<String>,
    pub affected_assets: Vec<Entity>,
    pub event_chain: Vec<Uuid>,
    pub risk_score: f64,
    pub false_positive_probability: Option<f64>,
    pub ai_summary: Option<String>,
    pub ai_recommended_actions: Vec<String>,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    pub resolved_at: Option<DateTime<Utc>>,
    pub responder: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub enum IncidentStatus {
    Open,
    Investigating,
    Contained,
    Eradicated,
    Recovered,
    Resolved,
    FalsePositive,
}

// ── Kill Chain Phases ─────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub enum KillChainPhase {
    Reconnaissance,
    Weaponization,
    Delivery,
    Exploitation,
    Installation,
    CommandAndControl,
    ActionsOnObjectives,
}

impl KillChainPhase {
    pub fn as_str(&self) -> &'static str {
        match self {
            Self::Reconnaissance => "Reconnaissance",
            Self::Weaponization => "Weaponization",
            Self::Delivery => "Delivery",
            Self::Exploitation => "Exploitation",
            Self::Installation => "Installation",
            Self::CommandAndControl => "Command and Control",
            Self::ActionsOnObjectives => "Actions on Objectives",
        }
    }
}

// ── Response Policy ───────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ResponsePolicy {
    pub id: String,
    pub name: String,
    pub enabled: bool,
    pub conditions: Vec<ResponseCondition>,
    pub actions: Vec<ResponseAction>,
    pub cooldown_secs: u64,
    pub auto_response_enabled: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum ResponseCondition {
    RiskAbove(f64),
    CategoryIs(EventCategory),
    SeverityAtLeast(crate::Severity),
    IocMatch(String),
    EntityPresent(EntityType),
    CountryIs(String),
    TimeWindow { event_type: String, count: u32, window_secs: u64 },
    Custom { field: String, operator: String, value: String },
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum ResponseAction {
    BlockIp { ip: String, duration_secs: u64 },
    BlockDomain { domain: String, duration_secs: u64 },
    DisableUser { user_id: String, duration_secs: u64 },
    DisableApiKey { key_id: String, duration_secs: u64 },
    RevokeJwt { jwt_id: String },
    QuarantineContainer { container_id: String, reason: String },
    IsolateHost { host_id: String, duration_secs: u64 },
    PauseWorker { worker_id: String, duration_secs: u64 },
    LockEscrow { booking_id: String, reason: String },
    Notify { channel: String, message: String, severity: crate::Severity },
    CreateIncident { title: String, description: String },
    RunScript { path: String, args: Vec<String> },
    BlockProcess { pid: u32, host_id: String },
    DeleteFile { path: String, host_id: String },
    CollectForensics { host_id: String, artifacts: Vec<String> },
}

// ── Security Knowledge Graph Node ─────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KnowledgeGraphNode {
    pub id: Uuid,
    pub node_type: String,
    pub label: String,
    pub properties: HashMap<String, serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KnowledgeGraphEdge {
    pub id: Uuid,
    pub source: Uuid,
    pub target: Uuid,
    pub relationship: String,
    pub weight: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KnowledgeGraph {
    pub nodes: Vec<KnowledgeGraphNode>,
    pub edges: Vec<KnowledgeGraphEdge>,
}

// ── Agent Heartbeat ───────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AgentHeartbeat {
    pub agent_id: String,
    pub hostname: String,
    pub ip: String,
    pub agent_version: String,
    pub uptime_secs: u64,
    pub events_processed: u64,
    pub events_per_second: f64,
    pub cpu_usage: f64,
    pub memory_usage_mb: f64,
    pub disk_usage_percent: f64,
    pub active_collectors: Vec<String>,
    pub policy_version: Option<String>,
    pub certificate_expiry: Option<DateTime<Utc>>,
    pub last_update: DateTime<Utc>,
}

// ── Policy Version ────────────────────────────────────────────────────────────
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PolicyVersion {
    pub version: u64,
    pub hash: String,
    pub applied_at: DateTime<Utc>,
    pub rules_count: u32,
    pub response_policies_count: u32,
}

// ── SecurityEvent Builder ─────────────────────────────────────────────────────
impl SecurityEvent {
    pub fn new(
        category: EventCategory,
        action: EventAction,
        source: EventSource,
        title: impl Into<String>,
        description: impl Into<String>,
    ) -> Self {
        Self {
            id: Uuid::new_v4(),
            timestamp: Utc::now(),
            category,
            action,
            severity: crate::Severity::Informational,
            confidence: 1.0,
            source,
            title: title.into(),
            description: description.into(),
            metadata: HashMap::new(),
            risk_score: 0.0,
            mitre_tactic: None,
            mitre_technique: None,
            mitre_id: None,
            correlation_id: None,
            parent_event_id: None,
            chain_id: None,
            incident_id: None,
            tags: Vec::new(),
            ioc_matches: Vec::new(),
            affected_entities: Vec::new(),
            tenant_id: None,
            environment: None,
            region: None,
            cluster: None,
            node_name: None,
            pid: None,
            ppid: None,
            uid: None,
            gid: None,
            exe: None,
            cmdline: None,
            username: None,
            session: None,
            process_hash_sha256: None,
            process_signature: None,
            process_reputation: None,
            file_path: None,
            file_hash_sha256: None,
            file_size: None,
            file_permissions: None,
            src_ip: None,
            dst_ip: None,
            src_port: None,
            dst_port: None,
            protocol: None,
            country: None,
            asn: None,
            risk_delta: None,
            business_context: None,
            revenue_impact: None,
            rule_id: None,
            rule_name: None,
        }
    }

    pub fn with_severity(mut self, severity: crate::Severity) -> Self {
        self.severity = severity;
        self
    }

    pub fn with_confidence(mut self, confidence: f64) -> Self {
        self.confidence = confidence.clamp(0.0, 1.0);
        self
    }

    pub fn with_risk_score(mut self, score: f64) -> Self {
        self.risk_score = score.clamp(0.0, 100.0);
        self
    }

    pub fn with_risk_delta(mut self, delta: f64) -> Self {
        self.risk_delta = Some(delta);
        self
    }

    pub fn with_metadata(mut self, key: impl Into<String>, value: serde_json::Value) -> Self {
        self.metadata.insert(key.into(), value);
        self
    }

    pub fn with_mitre(mut self, tactic: &str, technique: &str, id: &str) -> Self {
        self.mitre_tactic = Some(tactic.into());
        self.mitre_technique = Some(technique.into());
        self.mitre_id = Some(id.into());
        self
    }

    pub fn with_correlation_id(mut self, id: Uuid) -> Self {
        self.correlation_id = Some(id);
        self
    }

    pub fn with_parent_event(mut self, id: Uuid) -> Self {
        self.parent_event_id = Some(id);
        self
    }

    pub fn with_chain_id(mut self, id: Uuid) -> Self {
        self.chain_id = Some(id);
        self
    }

    pub fn with_incident_id(mut self, id: Uuid) -> Self {
        self.incident_id = Some(id);
        self
    }

    pub fn with_tag(mut self, tag: impl Into<String>) -> Self {
        self.tags.push(tag.into());
        self
    }

    pub fn with_ioc_match(mut self, ioc: IocMatch) -> Self {
        self.ioc_matches.push(ioc);
        self
    }

    pub fn with_entity(mut self, entity: Entity) -> Self {
        self.affected_entities.push(entity);
        self
    }

    pub fn with_tenant(mut self, tenant_id: impl Into<String>) -> Self {
        self.tenant_id = Some(tenant_id.into());
        self
    }

    pub fn with_environment(mut self, env: impl Into<String>) -> Self {
        self.environment = Some(env.into());
        self
    }

    pub fn with_region(mut self, region: impl Into<String>) -> Self {
        self.region = Some(region.into());
        self
    }

    pub fn with_cluster(mut self, cluster: impl Into<String>) -> Self {
        self.cluster = Some(cluster.into());
        self
    }

    pub fn with_network(mut self, src_ip: &str, dst_ip: &str, src_port: u16, dst_port: u16) -> Self {
        self.src_ip = Some(src_ip.into());
        self.dst_ip = Some(dst_ip.into());
        self.src_port = Some(src_port);
        self.dst_port = Some(dst_port);
        self
    }

    pub fn with_process(mut self, pid: u32, ppid: u32, exe: &str) -> Self {
        self.pid = Some(pid);
        self.ppid = Some(ppid);
        self.exe = Some(exe.into());
        self
    }

    pub fn with_file(mut self, path: &str) -> Self {
        self.file_path = Some(path.into());
        self
    }

    pub fn with_business_context(mut self, ctx: impl Into<String>) -> Self {
        self.business_context = Some(ctx.into());
        self
    }

    pub fn with_revenue_impact(mut self, impact: f64) -> Self {
        self.revenue_impact = Some(impact);
        self
    }

    pub fn with_rule(mut self, rule_id: &str, rule_name: &str) -> Self {
        self.rule_id = Some(rule_id.into());
        self.rule_name = Some(rule_name.into());
        self
    }

    pub fn with_kill_chain(self, phase: KillChainPhase) -> Self {
        self.with_tag(phase.as_str())
    }
}
