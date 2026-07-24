use chrono::{DateTime, Utc};
use dashmap::DashMap;
use security_os_core::{EntityType, SecurityEvent, Severity};
use serde::{Deserialize, Serialize};

// ── Risk Config ───────────────────────────────────────────────────────────────

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RiskConfig {
    pub decay_rate: f64,
    pub max_history: usize,
    pub propagation_limit: f64,
}

impl Default for RiskConfig {
    fn default() -> Self {
        Self {
            decay_rate: 0.05,
            max_history: 100,
            propagation_limit: 50.0,
        }
    }
}

// ── Risk Node ─────────────────────────────────────────────────────────────────

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RiskNode {
    pub entity_type: EntityType,
    pub entity_value: String,
    pub base_risk: f64,
    pub propagated_risk: f64,
    pub total_risk: f64,
    pub last_updated: DateTime<Utc>,
    pub event_count: u64,
    pub risk_history: Vec<(DateTime<Utc>, f64)>,
}

impl RiskNode {
    fn new(entity_type: EntityType, entity_value: String, base_risk: f64) -> Self {
        let now = Utc::now();
        Self {
            entity_type,
            entity_value,
            base_risk,
            propagated_risk: 0.0,
            total_risk: base_risk,
            last_updated: now,
            event_count: 1,
            risk_history: vec![(now, base_risk)],
        }
    }
}

// ── Risk Edge ─────────────────────────────────────────────────────────────────

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RiskEdge {
    pub source: String,
    pub target: String,
    pub relationship: String,
    pub weight: f64,
    pub created_at: DateTime<Utc>,
}

// ── Risk Engine ───────────────────────────────────────────────────────────────

pub struct RiskEngine {
    nodes: DashMap<String, RiskNode>,
    edges: DashMap<String, RiskEdge>,
    config: RiskConfig,
}

impl RiskEngine {
    pub fn new(config: RiskConfig) -> Self {
        Self {
            nodes: DashMap::new(),
            edges: DashMap::new(),
            config,
        }
    }

    pub fn new_default() -> Self {
        Self::new(RiskConfig::default())
    }

    fn node_key(entity_type: &str, entity_value: &str) -> String {
        format!("{}:{}", entity_type, entity_value)
    }

    fn edge_key(source: &str, target: &str, relationship: &str) -> String {
        format!("{}->{}:{}", source, target, relationship)
    }

    fn entity_type_str(et: &EntityType) -> &'static str {
        match et {
            EntityType::Host => "host",
            EntityType::User => "user",
            EntityType::Process => "process",
            EntityType::Container => "container",
            EntityType::Pod => "pod",
            EntityType::Namespace => "namespace",
            EntityType::Cluster => "cluster",
            EntityType::Ip => "ip",
            EntityType::Domain => "domain",
            EntityType::File => "file",
            EntityType::ApiKey => "api_key",
            EntityType::Certificate => "certificate",
            EntityType::Hash => "hash",
            EntityType::Url => "url",
            EntityType::Jwt => "jwt",
            EntityType::Booking => "booking",
            EntityType::Escrow => "escrow",
            EntityType::Payment => "payment",
            EntityType::Commission => "commission",
            EntityType::Worker => "worker",
            EntityType::Webhook => "webhook",
            EntityType::Saga => "saga",
        }
    }

    fn severity_base_weight(severity: &Severity) -> f64 {
        match severity {
            Severity::Informational => 5.0,
            Severity::Low => 15.0,
            Severity::Medium => 35.0,
            Severity::High => 65.0,
            Severity::Critical => 90.0,
        }
    }

    pub fn calculate_event_risk(&self, event: &SecurityEvent) -> f64 {
        let base = Self::severity_base_weight(&event.severity);
        let confidence = event.confidence;
        let mut score = base * confidence;

        if !event.ioc_matches.is_empty() {
            score += 20.0;
        }

        if event.risk_delta.is_some() {
            score += event.risk_delta.unwrap_or(0.0).abs();
        }

        if let Some(ref impact) = event.revenue_impact {
            score += (*impact * 0.1).min(20.0);
        }

        for entity in &event.affected_entities {
            let etype_str = Self::entity_type_str(&entity.entity_type);
            let key = Self::node_key(etype_str, &entity.value);
            if let Some(existing) = self.nodes.get(&key) {
                let repeat_bonus = (existing.event_count as f64).min(10.0) * 5.0;
                score += repeat_bonus;
            }
        }

        score.clamp(0.0, 100.0)
    }

    fn update_node(&self, entity_type: EntityType, entity_value: String, risk: f64, _event: &SecurityEvent) {
        let etype_str = Self::entity_type_str(&entity_type);
        let key = Self::node_key(etype_str, &entity_value);
        let now = Utc::now();

        self.nodes
            .entry(key)
            .and_modify(|node| {
                let elapsed_hours = (now - node.last_updated).num_minutes() as f64 / 60.0;
                let decay = (-self.config.decay_rate * elapsed_hours).exp();
                node.base_risk = node.base_risk * decay + risk;
                node.base_risk = node.base_risk.clamp(0.0, 100.0);
                node.last_updated = now;
                node.event_count += 1;
                node.risk_history.push((now, node.base_risk));
                if node.risk_history.len() > self.config.max_history {
                    node.risk_history.remove(0);
                }
                node.total_risk = node.base_risk + node.propagated_risk;
            })
            .or_insert_with(|| RiskNode::new(entity_type, entity_value, risk));
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let event_risk = self.calculate_event_risk(event);

        for entity in &event.affected_entities {
            self.update_node(entity.entity_type.clone(), entity.value.clone(), event_risk, event);
        }

        self.auto_discover_edges(event);
        self.propagate_risks();

        self.build_enriched_events(event, event_risk)
    }

    fn build_enriched_events(&self, event: &SecurityEvent, event_risk: f64) -> Vec<SecurityEvent> {
        let mut enriched = Vec::new();
        let risk_level = Self::get_risk_level(event_risk);

        for entity in &event.affected_entities {
            let etype_str = Self::entity_type_str(&entity.entity_type);
            let key = Self::node_key(etype_str, &entity.value);

            if let Some(node) = self.nodes.get(&key) {
                if node.propagated_risk > 0.0 && node.total_risk > self.config.propagation_limit {
                    let mut new_event = event.clone();
                    new_event.risk_score = node.total_risk;
                    new_event.tags.push(format!("propagated_risk:{}", risk_level));
                    new_event.tags.push(format!("entity:{}", key));
                    new_event.description = format!(
                        "{} | Propagated risk {} to {} [{}]",
                        new_event.description,
                        node.propagated_risk,
                        etype_str,
                        node.entity_value,
                    );
                    enriched.push(new_event);
                }
            }
        }

        enriched
    }

    pub fn add_edge(&mut self, source: &str, target: &str, relationship: &str, weight: f64) {
        let key = Self::edge_key(source, target, relationship);
        let edge = RiskEdge {
            source: source.to_string(),
            target: target.to_string(),
            relationship: relationship.to_string(),
            weight: weight.clamp(0.0, 1.0),
            created_at: Utc::now(),
        };
        self.edges.insert(key, edge);
    }

    pub fn get_node_risk(&self, entity_type: &str, entity_value: &str) -> Option<f64> {
        let key = Self::node_key(entity_type, entity_value);
        self.nodes.get(&key).map(|n| {
            let now = Utc::now();
            let elapsed_hours = (now - n.last_updated).num_minutes() as f64 / 60.0;
            let decay = (-self.config.decay_rate * elapsed_hours).exp();
            (n.base_risk * decay).clamp(0.0, 100.0)
        })
    }

    pub fn get_total_risk(&self, entity_type: &str, entity_value: &str) -> Option<f64> {
        let key = Self::node_key(entity_type, entity_value);
        self.nodes.get(&key).map(|n| {
            let now = Utc::now();
            let elapsed_hours = (now - n.last_updated).num_minutes() as f64 / 60.0;
            let decay = (-self.config.decay_rate * elapsed_hours).exp();
            let effective_base = n.base_risk * decay;
            let effective_propagated = n.propagated_risk * decay;
            (effective_base + effective_propagated).clamp(0.0, 100.0)
        })
    }

    pub fn propagate_risks(&mut self) {
        let mut risk_deltas: Vec<(String, f64)> = Vec::new();

        for edge_ref in self.edges.iter() {
            let edge = edge_ref.value();
            if let Some(source_node) = self.nodes.get(&edge.source) {
                let source_risk = source_node.base_risk + source_node.propagated_risk;
                let propagated = source_risk * edge.weight * self.config.decay_rate;
                if propagated > 0.1 {
                    risk_deltas.push((edge.target.clone(), propagated));
                }
            }
        }

        for (target_key, delta) in risk_deltas {
            if let Some(mut target_node) = self.nodes.get_mut(&target_key) {
                let new_propagated = (target_node.propagated_risk + delta).min(self.config.propagation_limit);
                target_node.propagated_risk = new_propagated;
                target_node.total_risk = (target_node.base_risk + target_node.propagated_risk).clamp(0.0, 100.0);
            }
        }
    }

    pub fn get_top_risks(&self, limit: usize) -> Vec<RiskNode> {
        let mut nodes: Vec<RiskNode> = self
            .nodes
            .iter()
            .map(|r| {
                let mut node = r.value().clone();
                let now = Utc::now();
                let elapsed_hours = (now - node.last_updated).num_minutes() as f64 / 60.0;
                let decay = (-self.config.decay_rate * elapsed_hours).exp();
                node.base_risk = (node.base_risk * decay).clamp(0.0, 100.0);
                node.propagated_risk = (node.propagated_risk * decay).clamp(0.0, 100.0);
                node.total_risk = (node.base_risk + node.propagated_risk).clamp(0.0, 100.0);
                node
            })
            .collect();

        nodes.sort_by(|a, b| b.total_risk.partial_cmp(&a.total_risk).unwrap_or(std::cmp::Ordering::Equal));
        nodes.truncate(limit);
        nodes
    }

    pub fn get_risk_level(score: f64) -> &'static str {
        if score >= 80.0 {
            "CRITICAL"
        } else if score >= 60.0 {
            "HIGH"
        } else if score >= 40.0 {
            "MEDIUM"
        } else {
            "LOW"
        }
    }

    pub fn auto_discover_edges(&mut self, event: &SecurityEvent) {
        let src_host = format!("host:{}", event.source.host_id);

        if let Some(ref user_id) = event.source.user_id {
            let user_key = Self::node_key("user", user_id);
            self.add_edge(&user_key, &src_host, "user_logged_into_host", 0.7);
            self.ensure_node(EntityType::User, user_id.clone());
        }

        if let Some(ref container_id) = event.source.container_id {
            let container_key = Self::node_key("container", container_id);
            self.add_edge(&container_key, &src_host, "container_runs_on_host", 0.8);
            self.ensure_node(EntityType::Container, container_id.clone());

            if let Some(ref pod_name) = event.source.pod_name {
                let pod_key = Self::node_key("pod", pod_name);
                self.add_edge(&container_key, &pod_key, "container_in_pod", 0.9);
                self.ensure_node(EntityType::Pod, pod_name.clone());
            }
        }

        if let Some(pid) = event.pid {
            let process_key = Self::node_key("process", &pid.to_string());
            self.add_edge(&process_key, &src_host, "process_on_host", 0.5);
            self.ensure_node(EntityType::Process, pid.to_string());
        }

        if let Some(ref src_ip) = event.src_ip {
            let ip_key = Self::node_key("ip", src_ip);
            self.add_edge(&ip_key, &src_host, "ip_connected_to_host", 0.4);
            self.ensure_node(EntityType::Ip, src_ip.clone());
        }

        self.ensure_node(EntityType::Host, event.source.host_id.clone());

        if let Some(ref booking_id) = event.metadata.get("booking_id").and_then(|v| v.as_str()) {
            if let Some(ref user_id) = event.source.user_id {
                let user_key = Self::node_key("user", user_id);
                let booking_key = Self::node_key("booking", booking_id);
                self.add_edge(&user_key, &booking_key, "user_made_booking", 0.6);
                self.ensure_node(EntityType::Booking, booking_id.to_string());
            }
        }

        if let Some(ref escrow_id) = event.metadata.get("escrow_id").and_then(|v| v.as_str()) {
            if let Some(ref booking_id) = event.metadata.get("booking_id").and_then(|v| v.as_str()) {
                let booking_key = Self::node_key("booking", booking_id);
                let escrow_key = Self::node_key("escrow", escrow_id);
                self.add_edge(&booking_key, &escrow_key, "booking_has_escrow", 0.8);
                self.ensure_node(EntityType::Escrow, escrow_id.to_string());
            }
        }

        if let Some(ref payment_id) = event.metadata.get("payment_id").and_then(|v| v.as_str()) {
            if let Some(ref escrow_id) = event.metadata.get("escrow_id").and_then(|v| v.as_str()) {
                let escrow_key = Self::node_key("escrow", escrow_id);
                let payment_key = Self::node_key("payment", payment_id);
                self.add_edge(&escrow_key, &payment_key, "escrow_has_payment", 0.9);
                self.ensure_node(EntityType::Payment, payment_id.to_string());
            }
        }

        if let Some(ref api_key_id) = event.metadata.get("api_key_id").and_then(|v| v.as_str()) {
            if let Some(ref user_id) = event.source.user_id {
                let user_key = Self::node_key("user", user_id);
                let api_key_key = Self::node_key("api_key", api_key_id);
                self.add_edge(&user_key, &api_key_key, "user_owns_api_key", 0.7);
                self.ensure_node(EntityType::ApiKey, api_key_id.to_string());
            }
        }

        if let Some(ref jwt_id) = event.metadata.get("jwt_id").and_then(|v| v.as_str()) {
            if let Some(ref user_id) = event.source.user_id {
                let user_key = Self::node_key("user", user_id);
                let jwt_key = Self::node_key("jwt", jwt_id);
                self.add_edge(&user_key, &jwt_key, "user_has_jwt", 0.6);
                self.ensure_node(EntityType::Jwt, jwt_id.to_string());
            }

            if let Some(ref api_key_id) = event.metadata.get("api_key_id").and_then(|v| v.as_str()) {
                let api_key_key = Self::node_key("api_key", api_key_id);
                let jwt_key = Self::node_key("jwt", jwt_id);
                self.add_edge(&api_key_key, &jwt_key, "api_key_generates_jwt", 0.8);
            }
        }
    }

    fn ensure_node(&self, entity_type: EntityType, entity_value: String) {
        let etype_str = Self::entity_type_str(&entity_type);
        let key = Self::node_key(etype_str, &entity_value);
        self.nodes.entry(key).or_insert_with(|| RiskNode::new(entity_type, entity_value, 0.0));
    }

    pub fn node_count(&self) -> usize {
        self.nodes.len()
    }

    pub fn edge_count(&self) -> usize {
        self.edges.len()
    }
}

// ── Tests ─────────────────────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{
        Entity, EntityType, EventAction, EventCategory, EventSource, IocMatch,
    };
    use std::collections::HashMap;

    fn test_source() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "test-host".into(),
            agent_id: "agent-1".into(),
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

    fn source_with_entities() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "test-host".into(),
            agent_id: "agent-1".into(),
            agent_version: None,
            process_name: None,
            process_id: None,
            user_id: Some("user-1".into()),
            user_name: Some("alice".into()),
            container_id: Some("ctr-1".into()),
            container_name: Some("app-ctr".into()),
            pod_name: Some("pod-1".into()),
            namespace: Some("default".into()),
            service_name: None,
        }
    }

    #[test]
    fn test_node_creation_via_process_event() {
        let mut engine = RiskEngine::new_default();
        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "Suspicious connection",
            "C2 beacon detected",
        )
        .with_severity(Severity::High)
        .with_confidence(0.9)
        .with_entity(Entity {
            entity_type: EntityType::Ip,
            value: "1.2.3.4".into(),
            risk_contribution: 0.0,
            metadata: HashMap::new(),
        });

        engine.process_event(&event);
        assert_eq!(engine.node_count(), 2);
        assert!(engine.get_node_risk("ip", "1.2.3.4").is_some());
        assert!(engine.get_node_risk("host", "host-1").is_some());
    }

    #[test]
    fn test_edge_creation() {
        let mut engine = RiskEngine::new_default();
        engine.add_edge("user:u1", "host:h1", "user_logged_into_host", 0.7);
        engine.add_edge("host:h1", "container:c1", "container_runs_on_host", 0.8);

        assert_eq!(engine.edge_count(), 2);
        let key = RiskEngine::edge_key("user:u1", "host:h1", "user_logged_into_host");
        assert!(engine.edges.contains_key(&key));
    }

    #[test]
    fn test_risk_propagation() {
        let mut engine = RiskEngine::new_default();

        engine.nodes.insert(
            "host:h1".into(),
            RiskNode::new(EntityType::Host, "h1".into(), 80.0),
        );
        engine.nodes.insert(
            "user:u1".into(),
            RiskNode::new(EntityType::User, "u1".into(), 10.0),
        );
        engine.add_edge("host:h1", "user:u1", "host_contains_user", 0.8);

        engine.propagate_risks();

        let user = engine.nodes.get("user:u1").unwrap();
        assert!(user.propagated_risk > 0.0);
        assert!(user.total_risk > user.base_risk);
    }

    #[test]
    fn test_top_risks_ordering() {
        let engine = RiskEngine::new_default();

        engine.nodes.insert(
            "ip:10.0.0.1".into(),
            RiskNode::new(EntityType::Ip, "10.0.0.1".into(), 30.0),
        );
        engine.nodes.insert(
            "ip:10.0.0.2".into(),
            RiskNode::new(EntityType::Ip, "10.0.0.2".into(), 90.0),
        );
        engine.nodes.insert(
            "ip:10.0.0.3".into(),
            RiskNode::new(EntityType::Ip, "10.0.0.3".into(), 60.0),
        );

        let top = engine.get_top_risks(3);
        assert_eq!(top.len(), 3);
        assert!(top[0].total_risk >= top[1].total_risk);
        assert!(top[1].total_risk >= top[2].total_risk);
        assert_eq!(top[0].entity_value, "10.0.0.2");
    }

    #[test]
    fn test_risk_levels() {
        assert_eq!(RiskEngine::get_risk_level(95.0), "CRITICAL");
        assert_eq!(RiskEngine::get_risk_level(80.0), "CRITICAL");
        assert_eq!(RiskEngine::get_risk_level(70.0), "HIGH");
        assert_eq!(RiskEngine::get_risk_level(60.0), "HIGH");
        assert_eq!(RiskEngine::get_risk_level(50.0), "MEDIUM");
        assert_eq!(RiskEngine::get_risk_level(40.0), "MEDIUM");
        assert_eq!(RiskEngine::get_risk_level(20.0), "LOW");
        assert_eq!(RiskEngine::get_risk_level(0.0), "LOW");
    }

    #[test]
    fn test_auto_edge_discovery_user_host() {
        let mut engine = RiskEngine::new_default();
        let event = SecurityEvent::new(
            EventCategory::Authentication,
            EventAction::Connected,
            source_with_entities(),
            "User login",
            "User logged in",
        )
        .with_severity(Severity::Medium)
        .with_confidence(1.0);

        engine.process_event(&event);

        let edge_key = RiskEngine::edge_key("user:user-1", "host:host-1", "user_logged_into_host");
        assert!(engine.edges.contains_key(&edge_key));

        let ctr_key = RiskEngine::edge_key("container:ctr-1", "host:host-1", "container_runs_on_host");
        assert!(engine.edges.contains_key(&ctr_key));

        let pod_key = RiskEngine::edge_key("container:ctr-1", "pod:pod-1", "container_in_pod");
        assert!(engine.edges.contains_key(&pod_key));
    }

    #[test]
    fn test_auto_edge_discovery_business_events() {
        let mut engine = RiskEngine::new_default();
        let mut source = test_source();
        source.user_id = Some("user-1".into());

        let event = SecurityEvent::new(
            EventCategory::ReservatiorBusiness,
            EventAction::Created,
            source,
            "Business event",
            "Booking created",
        )
        .with_severity(Severity::Low)
        .with_confidence(1.0)
        .with_metadata("booking_id", serde_json::Value::String("bk-1".into()))
        .with_metadata("escrow_id", serde_json::Value::String("esc-1".into()))
        .with_metadata("payment_id", serde_json::Value::String("pay-1".into()));

        engine.process_event(&event);

        let booking_edge = RiskEngine::edge_key("user:user-1", "booking:bk-1", "user_made_booking");
        assert!(engine.edges.contains_key(&booking_edge));

        let escrow_edge = RiskEngine::edge_key("booking:bk-1", "escrow:esc-1", "booking_has_escrow");
        assert!(engine.edges.contains_key(&escrow_edge));

        let payment_edge = RiskEngine::edge_key("escrow:esc-1", "payment:pay-1", "escrow_has_payment");
        assert!(engine.edges.contains_key(&payment_edge));
    }

    #[test]
    fn test_ioc_bonus_in_risk_calculation() {
        let engine = RiskEngine::new_default();

        let event_with_ioc = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "IOC match",
            "IP matched threat intel",
        )
        .with_severity(Severity::Medium)
        .with_confidence(1.0)
        .with_ioc_match(IocMatch {
            ioc_type: "ip".into(),
            ioc_value: "1.2.3.4".into(),
            feed: "test".into(),
            feed_url: None,
            match_context: "test match".into(),
            confidence: 1.0,
            first_seen: None,
            last_seen: None,
        });

        let score_with = engine.calculate_event_risk(&event_with_ioc);

        let event_without = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "No IOC",
            "Normal connection",
        )
        .with_severity(Severity::Medium)
        .with_confidence(1.0);

        let score_without = engine.calculate_event_risk(&event_without);
        assert!(score_with > score_without);
    }

    #[test]
    fn test_severity_base_weights() {
        assert_eq!(RiskEngine::severity_base_weight(&Severity::Informational), 5.0);
        assert_eq!(RiskEngine::severity_base_weight(&Severity::Low), 15.0);
        assert_eq!(RiskEngine::severity_base_weight(&Severity::Medium), 35.0);
        assert_eq!(RiskEngine::severity_base_weight(&Severity::High), 65.0);
        assert_eq!(RiskEngine::severity_base_weight(&Severity::Critical), 90.0);
    }

    #[test]
    fn test_get_total_risk_includes_propagation() {
        let mut engine = RiskEngine::new_default();

        engine.nodes.insert(
            "host:h1".into(),
            RiskNode::new(EntityType::Host, "h1".into(), 90.0),
        );
        engine.nodes.insert(
            "user:u1".into(),
            RiskNode::new(EntityType::User, "u1".into(), 5.0),
        );
        engine.add_edge("host:h1", "user:u1", "host_compromises_user", 0.9);

        engine.propagate_risks();

        let base_only = engine.get_node_risk("user", "u1").unwrap();
        let total = engine.get_total_risk("user", "u1").unwrap();
        assert!(total > base_only);
    }

    #[test]
    fn test_config_default() {
        let config = RiskConfig::default();
        assert_eq!(config.decay_rate, 0.05);
        assert_eq!(config.max_history, 100);
        assert_eq!(config.propagation_limit, 50.0);
    }

    #[test]
    fn test_auto_edge_ip_to_host() {
        let mut engine = RiskEngine::new_default();
        let source = test_source();
        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            source,
            "Connection from IP",
            "External connection",
        )
        .with_severity(Severity::Low)
        .with_confidence(1.0)
        .with_network("192.168.1.100", "10.0.0.1", 443, 8080);

        engine.process_event(&event);

        let ip_edge = RiskEngine::edge_key("ip:192.168.1.100", "host:host-1", "ip_connected_to_host");
        assert!(engine.edges.contains_key(&ip_edge));
    }
}
