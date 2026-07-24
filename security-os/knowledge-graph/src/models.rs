use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use uuid::Uuid;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum NodeType {
    Host,
    User,
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
    Process,
    Network,
    Saga,
}

impl NodeType {
    pub fn as_str(&self) -> &'static str {
        match self {
            Self::Host => "Host",
            Self::User => "User",
            Self::Container => "Container",
            Self::Pod => "Pod",
            Self::Namespace => "Namespace",
            Self::Cluster => "Cluster",
            Self::Ip => "Ip",
            Self::Domain => "Domain",
            Self::File => "File",
            Self::ApiKey => "ApiKey",
            Self::Jwt => "Jwt",
            Self::Certificate => "Certificate",
            Self::Hash => "Hash",
            Self::Url => "Url",
            Self::Booking => "Booking",
            Self::Escrow => "Escrow",
            Self::Payment => "Payment",
            Self::Commission => "Commission",
            Self::Worker => "Worker",
            Self::Process => "Process",
            Self::Network => "Network",
            Self::Saga => "Saga",
        }
    }
}

impl std::fmt::Display for NodeType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.as_str())
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum EdgeRelationship {
    Owns,
    Started,
    Called,
    Accessed,
    Modified,
    Created,
    Deleted,
    Authenticated,
    Connected,
    Contains,
    DependsOn,
    Communicates,
    Compromised,
    Escalated,
    Exfiltrated,
}

impl EdgeRelationship {
    pub fn as_str(&self) -> &'static str {
        match self {
            Self::Owns => "OWNS",
            Self::Started => "STARTED",
            Self::Called => "CALLED",
            Self::Accessed => "ACCESSED",
            Self::Modified => "MODIFIED",
            Self::Created => "CREATED",
            Self::Deleted => "DELETED",
            Self::Authenticated => "AUTHENTICATED",
            Self::Connected => "CONNECTED",
            Self::Contains => "CONTAINS",
            Self::DependsOn => "DEPENDS_ON",
            Self::Communicates => "COMMUNICATES",
            Self::Compromised => "COMPROMISED",
            Self::Escalated => "ESCALATED",
            Self::Exfiltrated => "EXFILTRATED",
        }
    }
}

impl std::fmt::Display for EdgeRelationship {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "{}", self.as_str())
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GraphNode {
    pub id: Uuid,
    pub node_type: NodeType,
    pub label: String,
    pub properties: HashMap<String, serde_json::Value>,
    pub risk_score: f64,
    pub first_seen: DateTime<Utc>,
    pub last_seen: DateTime<Utc>,
    pub event_count: u64,
}

impl GraphNode {
    pub fn new(node_type: NodeType, label: impl Into<String>) -> Self {
        let now = Utc::now();
        Self {
            id: Uuid::new_v4(),
            node_type,
            label: label.into(),
            properties: HashMap::new(),
            risk_score: 0.0,
            first_seen: now,
            last_seen: now,
            event_count: 1,
        }
    }

    pub fn type_key(&self) -> String {
        self.node_type.to_string()
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GraphEdge {
    pub id: Uuid,
    pub source_id: Uuid,
    pub target_id: Uuid,
    pub relationship: EdgeRelationship,
    pub weight: f64,
    pub properties: HashMap<String, serde_json::Value>,
    pub first_seen: DateTime<Utc>,
    pub last_seen: DateTime<Utc>,
    pub event_count: u64,
}

impl GraphEdge {
    pub fn new(
        source_id: Uuid,
        target_id: Uuid,
        relationship: EdgeRelationship,
        weight: f64,
    ) -> Self {
        let now = Utc::now();
        Self {
            id: Uuid::new_v4(),
            source_id,
            target_id,
            relationship,
            weight,
            properties: HashMap::new(),
            first_seen: now,
            last_seen: now,
            event_count: 1,
        }
    }

    pub fn relationship_key(&self) -> String {
        self.relationship.to_string()
    }
}

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct GraphStats {
    pub total_nodes: usize,
    pub total_edges: usize,
    pub nodes_by_type: HashMap<String, usize>,
    pub edges_by_type: HashMap<String, usize>,
    pub avg_degree: f64,
    pub connected_components: usize,
}
