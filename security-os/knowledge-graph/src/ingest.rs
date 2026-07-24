use std::collections::HashMap;
use std::sync::Arc;

use uuid::Uuid;

use security_os_core::{SecurityEvent, EventCategory, EventAction};

use crate::models::{EdgeRelationship, GraphEdge, GraphNode, NodeType};
use crate::memory_graph::MemoryGraph;

fn risk_number(val: f64) -> serde_json::Value {
    serde_json::Value::Number(
        serde_json::Number::from_f64(val).unwrap_or(serde_json::Number::from(0)),
    )
}

pub struct GraphIngester {
    graph: Arc<MemoryGraph>,
}

impl GraphIngester {
    pub fn new(graph: Arc<MemoryGraph>) -> Self {
        Self { graph }
    }

    pub fn ingest_event(&self, event: &SecurityEvent) -> Vec<(Uuid, Uuid)> {
        let mut created_edges = Vec::new();
        let entities = self.extract_entities(event);
        let mut node_ids: Vec<(String, NodeType, Uuid)> = Vec::new();

        for (label, node_type, props) in &entities {
            let node_id = self.ensure_node(label, node_type.clone(), props.clone());
            node_ids.push((label.clone(), node_type.clone(), node_id));
        }

        for i in 0..node_ids.len() {
            for j in (i + 1)..node_ids.len() {
                let (_, ref src_type, src_id) = node_ids[i];
                let (_, ref tgt_type, tgt_id) = node_ids[j];
                if let Some(rel) = Self::infer_relationship(src_type, tgt_type, event) {
                    let edge_id = self.ensure_edge(src_id, tgt_id, rel, event.risk_score);
                    created_edges.push((src_id, tgt_id));
                    let _ = edge_id;
                }
            }
        }

        created_edges
    }

    fn ensure_node(
        &self,
        label: &str,
        node_type: NodeType,
        props: HashMap<String, serde_json::Value>,
    ) -> Uuid {
        if let Some(existing) = self.graph.find_node_by_label(label) {
            self.graph.update_node(&existing.id, props);
            existing.id
        } else {
            let mut node = GraphNode::new(node_type, label);
            node.properties = props;
            node.risk_score = node
                .properties
                .get("risk_score")
                .and_then(|v| v.as_f64())
                .unwrap_or(0.0);
            let id = node.id;
            self.graph.add_node(node);
            id
        }
    }

    fn ensure_edge(
        &self,
        source: Uuid,
        target: Uuid,
        rel: EdgeRelationship,
        weight: f64,
    ) -> Uuid {
        let existing = self.graph.get_edges_from(&source).into_iter().find(|e| {
            e.target_id == target && e.relationship == rel
        });

        if let Some(edge) = existing {
            edge.id
        } else {
            let edge = GraphEdge::new(source, target, rel, weight);
            let id = edge.id;
            self.graph.add_edge(edge);
            id
        }
    }

    fn extract_entities(
        &self,
        event: &SecurityEvent,
    ) -> Vec<(String, NodeType, HashMap<String, serde_json::Value>)> {
        let mut entities = Vec::new();
        let risk = event.risk_score;

        if !event.source.host_id.is_empty() {
            let mut props = HashMap::new();
            props.insert(
                "host_name".into(),
                serde_json::Value::String(event.source.host_name.clone()),
            );
            props.insert(
                "host_id".into(),
                serde_json::Value::String(event.source.host_id.clone()),
            );
            props.insert("risk_score".into(), risk_number(risk));
            entities.push((
                event.source.host_id.clone(),
                NodeType::Host,
                props,
            ));
        }

        if let Some(ref user) = event.source.user_name {
            if !user.is_empty() {
                let mut props = HashMap::new();
                props.insert(
                    "user_name".into(),
                    serde_json::Value::String(user.clone()),
                );
                if let Some(ref uid) = event.source.user_id {
                    props.insert(
                        "user_id".into(),
                        serde_json::Value::String(uid.clone()),
                    );
                }
                props.insert("risk_score".into(), risk_number(risk));
                entities.push((user.clone(), NodeType::User, props));
            }
        }

        if let Some(ref ip) = event.src_ip {
            if !ip.is_empty() {
                let mut props = HashMap::new();
                props.insert(
                    "ip_address".into(),
                    serde_json::Value::String(ip.clone()),
                );
                props.insert("risk_score".into(), risk_number(risk));
                entities.push((format!("ip:{}", ip), NodeType::Ip, props));
            }
        }

        if let Some(ref ip) = event.dst_ip {
            if !ip.is_empty() && event.src_ip.as_deref() != Some(ip.as_str()) {
                let mut props = HashMap::new();
                props.insert(
                    "ip_address".into(),
                    serde_json::Value::String(ip.clone()),
                );
                props.insert("risk_score".into(), risk_number(risk));
                entities.push((format!("ip:{}", ip), NodeType::Ip, props));
            }
        }

        if let Some(pid) = event.pid {
            if let Some(ref exe) = event.exe {
                let mut props = HashMap::new();
                props.insert(
                    "pid".into(),
                    serde_json::Value::Number(serde_json::Number::from(pid)),
                );
                props.insert(
                    "exe".into(),
                    serde_json::Value::String(exe.clone()),
                );
                if let Some(ref cmdline) = event.cmdline {
                    props.insert(
                        "cmdline".into(),
                        serde_json::Value::String(cmdline.clone()),
                    );
                }
                if let Some(ref hash) = event.process_hash_sha256 {
                    props.insert(
                        "hash_sha256".into(),
                        serde_json::Value::String(hash.clone()),
                    );
                }
                props.insert("risk_score".into(), risk_number(risk));
                entities.push((
                    format!("{}:{}", exe, pid),
                    NodeType::Process,
                    props,
                ));
            }
        }

        if let Some(ref container_id) = event.source.container_id {
            if !container_id.is_empty() {
                let mut props = HashMap::new();
                props.insert(
                    "container_id".into(),
                    serde_json::Value::String(container_id.clone()),
                );
                if let Some(ref name) = event.source.container_name {
                    props.insert(
                        "container_name".into(),
                        serde_json::Value::String(name.clone()),
                    );
                }
                if let Some(ref pod) = event.source.pod_name {
                    props.insert(
                        "pod_name".into(),
                        serde_json::Value::String(pod.clone()),
                    );
                }
                if let Some(ref ns) = event.source.namespace {
                    props.insert(
                        "namespace".into(),
                        serde_json::Value::String(ns.clone()),
                    );
                }
                props.insert("risk_score".into(), risk_number(risk));
                entities.push((
                    container_id.clone(),
                    NodeType::Container,
                    props,
                ));
            }
        }

        if let Some(ref file_path) = event.file_path {
            if !file_path.is_empty() {
                let mut props = HashMap::new();
                props.insert(
                    "path".into(),
                    serde_json::Value::String(file_path.clone()),
                );
                if let Some(ref hash) = event.file_hash_sha256 {
                    props.insert(
                        "hash_sha256".into(),
                        serde_json::Value::String(hash.clone()),
                    );
                }
                props.insert("risk_score".into(), risk_number(risk));
                entities.push((file_path.clone(), NodeType::File, props));
            }
        }

        if let Some(ref ctx) = event.business_context {
            if !ctx.is_empty() {
                let mut props = HashMap::new();
                props.insert(
                    "context".into(),
                    serde_json::Value::String(ctx.clone()),
                );
                if let Some(rev) = event.revenue_impact {
                    props.insert("revenue_impact".into(), risk_number(rev));
                }
                props.insert("risk_score".into(), risk_number(risk));
                let node_type = match event.category {
                    EventCategory::ReservatiorBusiness => {
                        if ctx.contains("booking") {
                            NodeType::Booking
                        } else if ctx.contains("escrow") {
                            NodeType::Escrow
                        } else if ctx.contains("payment") {
                            NodeType::Payment
                        } else if ctx.contains("commission") {
                            NodeType::Commission
                        } else if ctx.contains("worker") {
                            NodeType::Worker
                        } else if ctx.contains("saga") {
                            NodeType::Saga
                        } else {
                            NodeType::Booking
                        }
                    }
                    _ => NodeType::Booking,
                };
                entities.push((ctx.clone(), node_type, props));
            }
        }

        for entity in &event.affected_entities {
            let mut props = HashMap::new();
            props.insert(
                "risk_contribution".into(),
                risk_number(entity.risk_contribution),
            );
            props.extend(entity.metadata.clone());
            props.insert("risk_score".into(), risk_number(risk));
            let node_type = match entity.entity_type {
                security_os_core::EntityType::Host => NodeType::Host,
                security_os_core::EntityType::User => NodeType::User,
                security_os_core::EntityType::Process => NodeType::Process,
                security_os_core::EntityType::Container => NodeType::Container,
                security_os_core::EntityType::Pod => NodeType::Pod,
                security_os_core::EntityType::Namespace => NodeType::Namespace,
                security_os_core::EntityType::Cluster => NodeType::Cluster,
                security_os_core::EntityType::Ip => NodeType::Ip,
                security_os_core::EntityType::Domain => NodeType::Domain,
                security_os_core::EntityType::File => NodeType::File,
                security_os_core::EntityType::ApiKey => NodeType::ApiKey,
                security_os_core::EntityType::Jwt => NodeType::Jwt,
                security_os_core::EntityType::Certificate => NodeType::Certificate,
                security_os_core::EntityType::Hash => NodeType::Hash,
                security_os_core::EntityType::Url => NodeType::Url,
                security_os_core::EntityType::Booking => NodeType::Booking,
                security_os_core::EntityType::Escrow => NodeType::Escrow,
                security_os_core::EntityType::Payment => NodeType::Payment,
                security_os_core::EntityType::Commission => NodeType::Commission,
                security_os_core::EntityType::Worker => NodeType::Worker,
                security_os_core::EntityType::Webhook => NodeType::Url,
                security_os_core::EntityType::Saga => NodeType::Saga,
            };
            entities.push((entity.value.clone(), node_type, props));
        }

        entities
    }

    fn infer_relationship(
        src_type: &NodeType,
        tgt_type: &NodeType,
        event: &SecurityEvent,
    ) -> Option<EdgeRelationship> {
        match (src_type, tgt_type) {
            (NodeType::Host, NodeType::Ip) | (NodeType::Ip, NodeType::Host) => {
                Some(EdgeRelationship::Connected)
            }
            (NodeType::User, NodeType::Host) | (NodeType::Host, NodeType::User) => {
                Some(EdgeRelationship::Authenticated)
            }
            (NodeType::Host, NodeType::Process) | (NodeType::Process, NodeType::Host) => {
                Some(EdgeRelationship::Started)
            }
            (NodeType::Host, NodeType::Container) | (NodeType::Container, NodeType::Host) => {
                Some(EdgeRelationship::Contains)
            }
            (NodeType::Process, NodeType::Ip) | (NodeType::Ip, NodeType::Process) => {
                Some(EdgeRelationship::Communicates)
            }
            (NodeType::Container, NodeType::Ip) | (NodeType::Ip, NodeType::Container) => {
                Some(EdgeRelationship::Communicates)
            }
            (NodeType::Host, NodeType::File) | (NodeType::File, NodeType::Host) => {
                match event.action {
                    EventAction::Created => Some(EdgeRelationship::Created),
                    EventAction::Modified => Some(EdgeRelationship::Modified),
                    EventAction::Deleted => Some(EdgeRelationship::Deleted),
                    _ => Some(EdgeRelationship::Accessed),
                }
            }
            (NodeType::User, NodeType::Container) | (NodeType::Container, NodeType::User) => {
                Some(EdgeRelationship::Authenticated)
            }
            (NodeType::Ip, NodeType::Ip) => {
                if event.category == EventCategory::Network {
                    Some(EdgeRelationship::Communicates)
                } else {
                    None
                }
            }
            (NodeType::Host, NodeType::Booking)
            | (NodeType::Booking, NodeType::Host)
            | (NodeType::Host, NodeType::Escrow)
            | (NodeType::Escrow, NodeType::Host)
            | (NodeType::Host, NodeType::Payment)
            | (NodeType::Payment, NodeType::Host) => {
                Some(EdgeRelationship::Accessed)
            }
            (NodeType::Booking, NodeType::Escrow)
            | (NodeType::Booking, NodeType::Payment)
            | (NodeType::Escrow, NodeType::Payment) => {
                Some(EdgeRelationship::DependsOn)
            }
            _ => None,
        }
    }
}
