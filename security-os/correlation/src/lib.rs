use chrono::{DateTime, Duration, Utc};
use dashmap::DashMap;
use security_os_core::*;
use std::collections::HashMap;
use uuid::Uuid;

// ── Correlation Configuration ─────────────────────────────────────────────────

#[derive(Debug, Clone)]
pub struct CorrelationConfig {
    pub window_secs: u64,
    pub max_chain_length: usize,
    pub risk_threshold: f64,
}

impl Default for CorrelationConfig {
    fn default() -> Self {
        Self {
            window_secs: 300,
            max_chain_length: 20,
            risk_threshold: 70.0,
        }
    }
}

// ── Attack Chain ──────────────────────────────────────────────────────────────

#[derive(Debug, Clone)]
pub struct AttackChain {
    pub id: Uuid,
    pub events: Vec<SecurityEvent>,
    pub kill_chain_phase: KillChainPhase,
    pub risk_score: f64,
    pub first_seen: DateTime<Utc>,
    pub last_seen: DateTime<Utc>,
    pub entities: Vec<Entity>,
    pub is_complete: bool,
}

// ── Correlation Engine ────────────────────────────────────────────────────────

pub struct CorrelationEngine {
    event_windows: DashMap<String, Vec<SecurityEvent>>,
    chains: DashMap<Uuid, AttackChain>,
    config: CorrelationConfig,
}

impl CorrelationEngine {
    pub fn new(config: CorrelationConfig) -> Self {
        Self {
            event_windows: DashMap::new(),
            chains: DashMap::new(),
            config,
        }
    }

    pub fn new_default() -> Self {
        Self::new(CorrelationConfig::default())
    }

    /// Main entry point. Ingests an event, updates windows/chains, returns correlation events.
    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut results = Vec::new();

        // 1. Insert into event windows keyed by host and user
        self.insert_into_windows(event);

        // 2. Attempt to attach event to an existing chain or start a new one
        self.update_chains(event);

        // 3. Check all active chains for kill chain completion
        let chain_ids: Vec<Uuid> = self.chains.iter().map(|r| *r.key()).collect();
        for chain_id in chain_ids {
            if let Some(chain) = self.chains.get(&chain_id) {
                if let Some(corr_event) = self.check_kill_chain(&chain) {
                    results.push(corr_event);
                }
            }
        }

        // 4. Temporal correlation on the host window
        let host_key = format!("host:{}", event.source.host_id);
        if let Some(window) = self.event_windows.get(&host_key) {
            let temporal = self.check_temporal_correlation(&window);
            results.extend(temporal);
        }

        // 5. Cross-entity correlation
        let all_events: Vec<SecurityEvent> = self
            .event_windows
            .iter()
            .flat_map(|r| r.value().clone())
            .collect();
        let cross = self.check_cross_entity(&all_events);
        results.extend(cross);

        // 6. Prune expired window entries
        self.prune_windows();

        results
    }

    /// Returns all currently active (incomplete) chains.
    pub fn get_active_chains(&self) -> Vec<AttackChain> {
        self.chains
            .iter()
            .filter(|r| !r.value().is_complete)
            .map(|r| r.value().clone())
            .collect()
    }

    // ── Internal: Window Management ──────────────────────────────────────────

    fn insert_into_windows(&self, event: &SecurityEvent) {
        // Host window
        let host_key = format!("host:{}", event.source.host_id);
        self.event_windows
            .entry(host_key)
            .or_default()
            .push(event.clone());

        // User window
        if let Some(ref user_id) = event.source.user_id {
            let user_key = format!("user:{}", user_id);
            self.event_windows
                .entry(user_key)
                .or_default()
                .push(event.clone());
        }

        // Container window
        if let Some(ref container_id) = event.source.container_id {
            let container_key = format!("container:{}", container_id);
            self.event_windows
                .entry(container_key)
                .or_default()
                .push(event.clone());
        }

        // IP window (src_ip)
        if let Some(ref src_ip) = event.src_ip {
            let ip_key = format!("ip:{}", src_ip);
            self.event_windows
                .entry(ip_key)
                .or_default()
                .push(event.clone());
        }
    }

    fn prune_windows(&self) {
        let cutoff = Utc::now() - Duration::seconds(self.config.window_secs as i64);
        for mut entry in self.event_windows.iter_mut() {
            entry.value_mut().retain(|e| e.timestamp > cutoff);
        }
    }

    // ── Internal: Chain Management ───────────────────────────────────────────

    fn update_chains(&self, event: &SecurityEvent) {
        // Find an existing chain that shares an entity with this event
        let mut matched_chain_id: Option<Uuid> = None;
        for chain_ref in self.chains.iter() {
            let chain = chain_ref.value();
            if self.events_share_entity(&chain.events, event) {
                // Check temporal proximity
                let elapsed = (event.timestamp - chain.last_seen).num_seconds();
                if elapsed >= 0 && elapsed <= self.config.window_secs as i64 {
                    matched_chain_id = Some(chain.id);
                    break;
                }
            }
        }

        if let Some(chain_id) = matched_chain_id {
            if let Some(mut chain) = self.chains.get_mut(&chain_id) {
                chain.events.push(event.clone());
                chain.last_seen = event.timestamp;
                // Merge entities
                for entity in &event.affected_entities {
                    if !chain.entities.iter().any(|e| e.entity_type == entity.entity_type && e.value == entity.value) {
                        chain.entities.push(entity.clone());
                    }
                }
                chain.kill_chain_phase = self.classify_phase(&chain.events);
                chain.risk_score = self.calculate_chain_risk(&chain);
                chain.is_complete = chain.kill_chain_phase == KillChainPhase::ActionsOnObjectives;
            }
        } else {
            // Start a new chain
            let phase = self.classify_single_phase(event);
            let chain = AttackChain {
                id: Uuid::new_v4(),
                events: vec![event.clone()],
                kill_chain_phase: phase,
                risk_score: event.risk_score,
                first_seen: event.timestamp,
                last_seen: event.timestamp,
                entities: event.affected_entities.clone(),
                is_complete: false,
            };
            self.chains.insert(chain.id, chain);
        }
    }

    fn events_share_entity(&self, chain_events: &[SecurityEvent], new_event: &SecurityEvent) -> bool {
        for ce in chain_events {
            // Same host
            if ce.source.host_id == new_event.source.host_id {
                return true;
            }
            // Same user
            if ce.source.user_id.is_some()
                && ce.source.user_id == new_event.source.user_id
            {
                return true;
            }
            // Same container
            if ce.source.container_id.is_some()
                && ce.source.container_id == new_event.source.container_id
            {
                return true;
            }
            // Same src_ip
            if ce.src_ip.is_some() && ce.src_ip == new_event.src_ip {
                return true;
            }
        }
        false
    }

    // ── Kill Chain Classification ────────────────────────────────────────────

    fn classify_single_phase(&self, event: &SecurityEvent) -> KillChainPhase {
        match event.category {
            EventCategory::Ssh | EventCategory::Authentication | EventCategory::Dns => {
                KillChainPhase::Reconnaissance
            }
            EventCategory::ConfigurationDrift | EventCategory::Kubernetes => {
                KillChainPhase::Weaponization
            }
            EventCategory::Container | EventCategory::Tls => KillChainPhase::Delivery,
            EventCategory::Sudo | EventCategory::Identity => KillChainPhase::Exploitation,
            EventCategory::Process => KillChainPhase::Installation,
            EventCategory::Network | EventCategory::Jwt => KillChainPhase::CommandAndControl,
            EventCategory::ReservatiorBusiness | EventCategory::Api => {
                KillChainPhase::ActionsOnObjectives
            }
            _ => KillChainPhase::Reconnaissance,
        }
    }

    fn classify_phase(&self, events: &[SecurityEvent]) -> KillChainPhase {
        let has = |cat: EventCategory| -> bool {
            events.iter().any(|e| e.category == cat)
        };
        let has_action = |act: EventAction| -> bool {
            events.iter().any(|e| e.action == act)
        };

        // Business logic attack
        if has(EventCategory::ReservatiorBusiness)
            && has_action(EventAction::Modified)
            && events
                .iter()
                .any(|e| e.file_path.as_deref() == Some("escrow") || e.tags.contains(&"escrow".to_string()))
        {
            return KillChainPhase::ActionsOnObjectives;
        }

        // Container escape: container + process + host network + file mod
        if has(EventCategory::Container)
            && has(EventCategory::Process)
            && has(EventCategory::Network)
            && has_action(EventAction::Modified)
        {
            return KillChainPhase::ActionsOnObjectives;
        }

        // Full chain: SSH + sudo + network outbound + file mod
        if has(EventCategory::Ssh)
            && has(EventCategory::Sudo)
            && has(EventCategory::Network)
            && has_action(EventAction::Modified)
        {
            return KillChainPhase::ActionsOnObjectives;
        }

        // C2 + exfiltration: process + file mod + network
        if has(EventCategory::Process)
            && has_action(EventAction::Modified)
            && has(EventCategory::Network)
        {
            return KillChainPhase::CommandAndControl;
        }

        // Account compromise: auth failure threshold + successful auth + admin action
        let auth_failures = events
            .iter()
            .filter(|e| e.category == EventCategory::Authentication && e.action == EventAction::Failed)
            .count();
        let auth_success = events
            .iter()
            .filter(|e| e.category == EventCategory::Authentication && e.action != EventAction::Failed)
            .count();
        if auth_failures >= 3 && auth_success > 0 {
            return KillChainPhase::ActionsOnObjectives;
        }

        // Determine latest phase based on event ordering
        let latest = events.iter().max_by_key(|e| e.timestamp);
        if let Some(latest_event) = latest {
            return self.classify_single_phase(latest_event);
        }

        KillChainPhase::Reconnaissance
    }

    // ── Kill Chain Detection ─────────────────────────────────────────────────

    fn check_kill_chain(&self, chain: &AttackChain) -> Option<SecurityEvent> {
        if chain.events.len() < 2 {
            return None;
        }

        let pattern = self.detect_chain_pattern(chain);
        let (title, severity, risk_delta, tactic, technique, mitre_id) = match pattern {
            ChainPattern::LateralMovement => (
                "Lateral Movement Detected",
                Severity::High,
                30.0,
                "Lateral Movement",
                "Remote Services / Valid Accounts",
                "TA0008",
            ),
            ChainPattern::C2Exfiltration => (
                "C2 Communication & Data Exfiltration Detected",
                Severity::Critical,
                50.0,
                "Exfiltration",
                "Exfiltration Over C2 Channel",
                "TA0010",
            ),
            ChainPattern::AccountCompromise => (
                "Account Compromise Detected",
                Severity::Critical,
                45.0,
                "Credential Access",
                "Brute Force / Password Spraying",
                "TA0006",
            ),
            ChainPattern::BusinessLogicAttack => (
                "Business Logic Attack Detected",
                Severity::Critical,
                60.0,
                "Impact",
                "Data Manipulation / Escrow Tampering",
                "TA0040",
            ),
            ChainPattern::ContainerEscape => (
                "Container Escape Detected",
                Severity::Critical,
                55.0,
                "Privilege Escalation",
                "Escape to Host",
                "TA0004",
            ),
            ChainPattern::None => return None,
        };

        let max_risk = chain
            .events
            .iter()
            .map(|e| e.risk_score)
            .fold(0.0_f64, f64::max);

        let mut event = SecurityEvent::new(
            EventCategory::Behavior,
            EventAction::Detected,
            chain.events[0].source.clone(),
            title,
            format!(
                "Correlated {} events into kill chain: {}",
                chain.events.len(),
                chain.kill_chain_phase.as_str()
            ),
        )
        .with_severity(severity)
        .with_risk_score((max_risk + risk_delta).clamp(0.0, 100.0))
        .with_risk_delta(risk_delta)
        .with_mitre(tactic, technique, mitre_id)
        .with_tag("kill-chain")
        .with_tag(pattern.as_tag())
        .with_correlation_id(chain.id);

        for e in &chain.events {
            event = event.with_parent_event(e.id);
        }
        for entity in &chain.entities {
            event = event.with_entity(entity.clone());
        }

        Some(event)
    }

    fn detect_chain_pattern(&self, chain: &AttackChain) -> ChainPattern {
        let has_cat = |cat: EventCategory| -> bool {
            chain.events.iter().any(|e| e.category == cat)
        };
        let has_action = |act: EventAction| -> bool {
            chain.events.iter().any(|e| e.action == act)
        };

        // Booking created + escrow modified + payment changed = Business Logic Attack
        if has_cat(EventCategory::ReservatiorBusiness)
            && has_action(EventAction::Modified)
            && chain
                .events
                .iter()
                .any(|e| e.tags.contains(&"escrow".to_string()) || e.tags.contains(&"payment".to_string()))
        {
            return ChainPattern::BusinessLogicAttack;
        }

        // Container + process + host network + file mod = Container Escape
        if has_cat(EventCategory::Container)
            && has_cat(EventCategory::Process)
            && has_cat(EventCategory::Network)
            && has_action(EventAction::Modified)
        {
            return ChainPattern::ContainerEscape;
        }

        // SSH + sudo + network outbound + file mod = Lateral Movement
        if has_cat(EventCategory::Ssh)
            && has_cat(EventCategory::Sudo)
            && has_cat(EventCategory::Network)
            && has_action(EventAction::Modified)
        {
            return ChainPattern::LateralMovement;
        }

        // Process + file mod + network outbound = C2 + Exfiltration
        if has_cat(EventCategory::Process)
            && has_action(EventAction::Modified)
            && has_cat(EventCategory::Network)
        {
            return ChainPattern::C2Exfiltration;
        }

        // Auth failure threshold + successful auth + admin action
        let auth_failures = chain
            .events
            .iter()
            .filter(|e| e.category == EventCategory::Authentication && e.action == EventAction::Failed)
            .count();
        let auth_success = chain
            .events
            .iter()
            .filter(|e| e.category == EventCategory::Authentication && e.action != EventAction::Failed)
            .count();
        if auth_failures >= 3 && auth_success > 0 && has_cat(EventCategory::Api) {
            return ChainPattern::AccountCompromise;
        }

        ChainPattern::None
    }

    // ── Temporal Correlation ─────────────────────────────────────────────────

    fn check_temporal_correlation(&self, events: &[SecurityEvent]) -> Vec<SecurityEvent> {
        if events.len() < 2 {
            return Vec::new();
        }

        let window = Duration::seconds(self.config.window_secs as i64);
        let mut results = Vec::new();

        // Group events by consecutive time proximity
        let mut sorted = events.to_vec();
        sorted.sort_by_key(|e| e.timestamp);

        let mut group: Vec<&SecurityEvent> = Vec::new();
        let mut group_start = sorted[0].timestamp;

        for event in &sorted {
            if (event.timestamp - group_start) <= window {
                group.push(event);
            } else {
                if group.len() >= 2 {
                    if let Some(corr) = self.build_temporal_event(&group) {
                        results.push(corr);
                    }
                }
                group = vec![event];
                group_start = event.timestamp;
            }
        }
        if group.len() >= 2 {
            if let Some(corr) = self.build_temporal_event(&group) {
                results.push(corr);
            }
        }

        results
    }

    fn build_temporal_event(&self, events: &[&SecurityEvent]) -> Option<SecurityEvent> {
        let categories: Vec<String> = events
            .iter()
            .map(|e| format!("{:?}", e.category))
            .collect();
        let unique_categories: Vec<&str> = categories
            .iter()
            .map(|s| s.as_str())
            .collect::<std::collections::HashSet<_>>()
            .into_iter()
            .collect();

        if unique_categories.len() < 2 {
            return None; // Need variety for correlation to be meaningful
        }

        let max_risk = events
            .iter()
            .map(|e| e.risk_score)
            .fold(0.0_f64, f64::max);

        let mut event = SecurityEvent::new(
            EventCategory::Behavior,
            EventAction::Correlated,
            events[0].source.clone(),
            "Temporal Correlation",
            format!(
                "Detected {} events across {:?} within {}s window",
                events.len(),
                unique_categories,
                self.config.window_secs,
            ),
        )
        .with_severity(Severity::Medium)
        .with_risk_score((max_risk + 10.0).clamp(0.0, 100.0))
        .with_risk_delta(10.0)
        .with_tag("temporal-correlation");

        for e in events {
            event = event.with_parent_event(e.id);
        }

        Some(event)
    }

    // ── Cross-Entity Correlation ─────────────────────────────────────────────

    fn check_cross_entity(&self, events: &[SecurityEvent]) -> Vec<SecurityEvent> {
        if events.len() < 3 {
            return Vec::new();
        }

        let mut results = Vec::new();

        // Build entity -> events map
        let mut entity_map: HashMap<String, Vec<&SecurityEvent>> = HashMap::new();
        for event in events {
            let keys = self.entity_keys(event);
            for key in keys {
                entity_map.entry(key).or_default().push(event);
            }
        }

        // Find events that span multiple entity types
        for (_entity_key, entity_events) in &entity_map {
            if entity_events.len() < 2 {
                continue;
            }

            let categories: std::collections::HashSet<EventCategory> =
                entity_events.iter().map(|e| e.category.clone()).collect();

            if categories.len() >= 3 {
                let max_risk = entity_events
                    .iter()
                    .map(|e| e.risk_score)
                    .fold(0.0_f64, f64::max);

                let mut event = SecurityEvent::new(
                    EventCategory::Behavior,
                    EventAction::Correlated,
                    entity_events[0].source.clone(),
                    "Cross-Entity Correlation",
                    format!(
                        "Detected {} events across {} distinct categories linked by shared entity",
                        entity_events.len(),
                        categories.len(),
                    ),
                )
                .with_severity(Severity::High)
                .with_risk_score((max_risk + 20.0).clamp(0.0, 100.0))
                .with_risk_delta(20.0)
                .with_tag("cross-entity-correlation");

                for e in entity_events {
                    event = event.with_parent_event(e.id);
                }

                results.push(event);
            }
        }

        results
    }

    fn entity_keys(&self, event: &SecurityEvent) -> Vec<String> {
        let mut keys = Vec::new();
        keys.push(format!("host:{}", event.source.host_id));
        if let Some(ref user) = event.source.user_id {
            keys.push(format!("user:{}", user));
        }
        if let Some(ref container) = event.source.container_id {
            keys.push(format!("container:{}", container));
        }
        if let Some(ref ip) = event.src_ip {
            keys.push(format!("ip:{}", ip));
        }
        if let Some(ref ip) = event.dst_ip {
            keys.push(format!("ip:{}", ip));
        }
        for entity in &event.affected_entities {
            keys.push(format!(
                "{}:{}",
                format!("{:?}", entity.entity_type).to_lowercase(),
                entity.value
            ));
        }
        keys
    }

    // ── Risk Calculation ─────────────────────────────────────────────────────

    fn calculate_chain_risk(&self, chain: &AttackChain) -> f64 {
        let base: f64 = chain.events.iter().map(|e| e.risk_score).sum::<f64>()
            / chain.events.len() as f64;

        let length_bonus = (chain.events.len() as f64).min(10.0) * 2.0;
        let phase_bonus = match chain.kill_chain_phase {
            KillChainPhase::ActionsOnObjectives => 25.0,
            KillChainPhase::CommandAndControl => 20.0,
            KillChainPhase::Installation => 15.0,
            KillChainPhase::Exploitation => 12.0,
            KillChainPhase::Delivery => 8.0,
            KillChainPhase::Weaponization => 5.0,
            KillChainPhase::Reconnaissance => 2.0,
        };

        let entity_count_bonus = (chain.entities.len() as f64).min(5.0) * 3.0;

        (base + length_bonus + phase_bonus + entity_count_bonus).clamp(0.0, 100.0)
    }
}

// ── Chain Pattern ─────────────────────────────────────────────────────────────

#[derive(Debug, Clone, PartialEq, Eq)]
enum ChainPattern {
    LateralMovement,
    C2Exfiltration,
    AccountCompromise,
    BusinessLogicAttack,
    ContainerEscape,
    None,
}

impl ChainPattern {
    fn as_tag(&self) -> &'static str {
        match self {
            Self::LateralMovement => "lateral-movement",
            Self::C2Exfiltration => "c2-exfiltration",
            Self::AccountCompromise => "account-compromise",
            Self::BusinessLogicAttack => "business-logic-attack",
            Self::ContainerEscape => "container-escape",
            Self::None => "unknown",
        }
    }
}

// ── Tests ─────────────────────────────────────────────────────────────────────

#[cfg(test)]
mod tests {
    use super::*;
    fn make_source(host: &str, user: Option<&str>, container: Option<&str>) -> EventSource {
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
            container_id: container.map(|s| s.into()),
            container_name: container.map(|s| s.into()),
            pod_name: None,
            namespace: None,
            service_name: None,
        }
    }

    fn make_event(
        category: EventCategory,
        action: EventAction,
        source: EventSource,
        risk: f64,
        tags: Vec<String>,
    ) -> SecurityEvent {
        let mut e = SecurityEvent::new(category, action, source, "test event", "desc")
            .with_risk_score(risk);
        e.tags = tags;
        e
    }

    #[test]
    fn test_engine_default_config() {
        let engine = CorrelationEngine::new_default();
        assert_eq!(engine.config.window_secs, 300);
        assert_eq!(engine.config.max_chain_length, 20);
        assert!((engine.config.risk_threshold - 70.0).abs() < f64::EPSILON);
    }

    #[test]
    fn test_single_event_no_correlation() {
        let mut engine = CorrelationEngine::new_default();
        let src = make_source("host-1", Some("user-1"), None);
        let event = make_event(
            EventCategory::Process,
            EventAction::Started,
            src,
            10.0,
            vec![],
        );
        let results = engine.process_event(&event);
        // Single event should not produce correlation events
        assert!(results.is_empty());
    }

    #[test]
    fn test_lateral_movement_kill_chain() {
        let mut engine = CorrelationEngine::new_default();
        let src = make_source("host-1", Some("user-1"), None);

        let t1 = Utc::now();
        let mut ssh_event = make_event(
            EventCategory::Ssh,
            EventAction::Connected,
            src.clone(),
            20.0,
            vec![],
        );
        ssh_event.timestamp = t1;

        let mut sudo_event = make_event(
            EventCategory::Sudo,
            EventAction::Escalated,
            src.clone(),
            25.0,
            vec![],
        );
        sudo_event.timestamp = t1 + Duration::seconds(10);

        let mut net_event = make_event(
            EventCategory::Network,
            EventAction::Connected,
            src.clone(),
            15.0,
            vec![],
        );
        net_event.timestamp = t1 + Duration::seconds(20);

        let mut fs_event = make_event(
            EventCategory::Filesystem,
            EventAction::Modified,
            src.clone(),
            30.0,
            vec![],
        );
        fs_event.timestamp = t1 + Duration::seconds(30);

        engine.process_event(&ssh_event);
        engine.process_event(&sudo_event);
        engine.process_event(&net_event);
        let results = engine.process_event(&fs_event);

        let kill_chain_events: Vec<&SecurityEvent> = results
            .iter()
            .filter(|e| e.tags.contains(&"kill-chain".to_string()))
            .collect();

        assert!(
            !kill_chain_events.is_empty(),
            "Should detect lateral movement kill chain"
        );
        assert!(
            kill_chain_events
                .iter()
                .any(|e| e.tags.contains(&"lateral-movement".to_string())),
            "Should tag as lateral-movement"
        );
    }

    #[test]
    fn test_c2_exfiltration_chain() {
        let mut engine = CorrelationEngine::new_default();
        let src = make_source("host-2", Some("user-2"), None);

        let t1 = Utc::now();
        let mut proc_event = make_event(
            EventCategory::Process,
            EventAction::Executed,
            src.clone(),
            20.0,
            vec![],
        );
        proc_event.timestamp = t1;

        let mut fs_event = make_event(
            EventCategory::Filesystem,
            EventAction::Modified,
            src.clone(),
            25.0,
            vec![],
        );
        fs_event.timestamp = t1 + Duration::seconds(5);

        let mut net_event = make_event(
            EventCategory::Network,
            EventAction::Connected,
            src.clone(),
            30.0,
            vec![],
        );
        net_event.timestamp = t1 + Duration::seconds(10);

        engine.process_event(&proc_event);
        engine.process_event(&fs_event);
        let results = engine.process_event(&net_event);

        let kill_chain_events: Vec<&SecurityEvent> = results
            .iter()
            .filter(|e| e.tags.contains(&"kill-chain".to_string()))
            .collect();

        assert!(
            !kill_chain_events.is_empty(),
            "Should detect C2/exfiltration chain"
        );
        assert!(
            kill_chain_events
                .iter()
                .any(|e| e.tags.contains(&"c2-exfiltration".to_string())),
            "Should tag as c2-exfiltration"
        );
    }

    #[test]
    fn test_account_compromise_chain() {
        let mut engine = CorrelationEngine::new_default();
        let src = make_source("host-3", Some("user-3"), None);

        let t1 = Utc::now();

        // Multiple auth failures
        for i in 0..4 {
            let mut fail = make_event(
                EventCategory::Authentication,
                EventAction::Failed,
                src.clone(),
                10.0,
                vec![],
            );
            fail.timestamp = t1 + Duration::seconds(i * 2);
            engine.process_event(&fail);
        }

        // Successful auth
        let mut success = make_event(
            EventCategory::Authentication,
            EventAction::Allowed,
            src.clone(),
            15.0,
            vec![],
        );
        success.timestamp = t1 + Duration::seconds(10);
        engine.process_event(&success);

        // Admin API action
        let mut api_event = make_event(
            EventCategory::Api,
            EventAction::Executed,
            src.clone(),
            30.0,
            vec![],
        );
        api_event.timestamp = t1 + Duration::seconds(12);
        let results = engine.process_event(&api_event);

        let kill_chain_events: Vec<&SecurityEvent> = results
            .iter()
            .filter(|e| e.tags.contains(&"kill-chain".to_string()))
            .collect();

        assert!(
            !kill_chain_events.is_empty(),
            "Should detect account compromise chain"
        );
        assert!(
            kill_chain_events
                .iter()
                .any(|e| e.tags.contains(&"account-compromise".to_string())),
            "Should tag as account-compromise"
        );
    }

    #[test]
    fn test_business_logic_attack_chain() {
        let mut engine = CorrelationEngine::new_default();
        let src = make_source("host-4", Some("admin-1"), None);

        let t1 = Utc::now();

        let mut booking_event = make_event(
            EventCategory::ReservatiorBusiness,
            EventAction::Created,
            src.clone(),
            10.0,
            vec!["booking".into()],
        );
        booking_event.timestamp = t1;
        engine.process_event(&booking_event);

        let mut escrow_event = make_event(
            EventCategory::ReservatiorBusiness,
            EventAction::Modified,
            src.clone(),
            30.0,
            vec!["escrow".into()],
        );
        escrow_event.timestamp = t1 + Duration::seconds(5);
        engine.process_event(&escrow_event);

        let mut payment_event = make_event(
            EventCategory::ReservatiorBusiness,
            EventAction::Modified,
            src.clone(),
            40.0,
            vec!["payment".into()],
        );
        payment_event.timestamp = t1 + Duration::seconds(10);
        let results = engine.process_event(&payment_event);

        let kill_chain_events: Vec<&SecurityEvent> = results
            .iter()
            .filter(|e| e.tags.contains(&"kill-chain".to_string()))
            .collect();

        assert!(
            !kill_chain_events.is_empty(),
            "Should detect business logic attack"
        );
        assert!(
            kill_chain_events
                .iter()
                .any(|e| e.tags.contains(&"business-logic-attack".to_string())),
            "Should tag as business-logic-attack"
        );
    }

    #[test]
    fn test_container_escape_chain() {
        let mut engine = CorrelationEngine::new_default();
        let src = make_source("host-5", Some("user-5"), Some("container-abc"));

        let t1 = Utc::now();

        let mut container_event = make_event(
            EventCategory::Container,
            EventAction::Started,
            src.clone(),
            15.0,
            vec![],
        );
        container_event.timestamp = t1;
        engine.process_event(&container_event);

        let mut proc_event = make_event(
            EventCategory::Process,
            EventAction::Executed,
            src.clone(),
            20.0,
            vec![],
        );
        proc_event.timestamp = t1 + Duration::seconds(3);
        engine.process_event(&proc_event);

        let mut net_event = make_event(
            EventCategory::Network,
            EventAction::Connected,
            src.clone(),
            25.0,
            vec![],
        );
        net_event.timestamp = t1 + Duration::seconds(6);
        engine.process_event(&net_event);

        let mut fs_event = make_event(
            EventCategory::Filesystem,
            EventAction::Modified,
            src.clone(),
            35.0,
            vec![],
        );
        fs_event.timestamp = t1 + Duration::seconds(9);
        let results = engine.process_event(&fs_event);

        let kill_chain_events: Vec<&SecurityEvent> = results
            .iter()
            .filter(|e| e.tags.contains(&"kill-chain".to_string()))
            .collect();

        assert!(
            !kill_chain_events.is_empty(),
            "Should detect container escape chain"
        );
        assert!(
            kill_chain_events
                .iter()
                .any(|e| e.tags.contains(&"container-escape".to_string())),
            "Should tag as container-escape"
        );
    }

    #[test]
    fn test_get_active_chains() {
        let mut engine = CorrelationEngine::new_default();
        let src = make_source("host-1", Some("user-1"), None);

        let mut ssh_event = make_event(
            EventCategory::Ssh,
            EventAction::Connected,
            src.clone(),
            20.0,
            vec![],
        );
        ssh_event.timestamp = Utc::now();
        engine.process_event(&ssh_event);

        let chains = engine.get_active_chains();
        assert_eq!(chains.len(), 1);
        assert!(!chains[0].is_complete);
    }

    #[test]
    fn test_chain_risk_increases_with_length() {
        let src = make_source("host-1", Some("user-1"), None);

        let short_chain = AttackChain {
            id: Uuid::new_v4(),
            events: vec![make_event(
                EventCategory::Process,
                EventAction::Started,
                src.clone(),
                20.0,
                vec![],
            )],
            kill_chain_phase: KillChainPhase::Reconnaissance,
            risk_score: 20.0,
            first_seen: Utc::now(),
            last_seen: Utc::now(),
            entities: vec![],
            is_complete: false,
        };

        let long_chain = AttackChain {
            id: Uuid::new_v4(),
            events: (0..8)
                .map(|i| {
                    make_event(
                        EventCategory::Process,
                        EventAction::Started,
                        src.clone(),
                        20.0 + i as f64 * 5.0,
                        vec![],
                    )
                })
                .collect(),
            kill_chain_phase: KillChainPhase::ActionsOnObjectives,
            risk_score: 50.0,
            first_seen: Utc::now(),
            last_seen: Utc::now(),
            entities: vec![],
            is_complete: false,
        };

        let engine = CorrelationEngine::new_default();
        let short_risk = engine.calculate_chain_risk(&short_chain);
        let long_risk = engine.calculate_chain_risk(&long_chain);

        assert!(
            long_risk > short_risk,
            "Longer chain with later phase should have higher risk: {} > {}",
            long_risk,
            short_risk
        );
    }
}
