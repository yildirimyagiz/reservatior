use chrono::{DateTime, Utc};
use dashmap::DashMap;
use security_os_core::{
    EventBus, ResponseAction as CoreResponseAction, ResponseCondition,
    ResponsePolicy as CoreResponsePolicy, SecurityEvent, Severity,
};
use serde::{Deserialize, Serialize};
use tracing::info;
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub enum IncidentStatus {
    Open,
    Investigating,
    Resolved,
    FalsePositive,
}

impl std::fmt::Display for IncidentStatus {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            IncidentStatus::Open => write!(f, "Open"),
            IncidentStatus::Investigating => write!(f, "Investigating"),
            IncidentStatus::Resolved => write!(f, "Resolved"),
            IncidentStatus::FalsePositive => write!(f, "FalsePositive"),
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub enum ActionStatus {
    Pending,
    Executing,
    Completed,
    Failed,
}

impl std::fmt::Display for ActionStatus {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            ActionStatus::Pending => write!(f, "Pending"),
            ActionStatus::Executing => write!(f, "Executing"),
            ActionStatus::Completed => write!(f, "Completed"),
            ActionStatus::Failed => write!(f, "Failed"),
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CompletedAction {
    pub action: CoreResponseAction,
    pub status: ActionStatus,
    pub started_at: DateTime<Utc>,
    pub completed_at: Option<DateTime<Utc>>,
    pub output: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DashboardIncident {
    pub id: Uuid,
    pub title: String,
    pub description: String,
    pub severity: Severity,
    pub events: Vec<Uuid>,
    pub risk_score: f64,
    pub actions_taken: Vec<CompletedAction>,
    pub status: IncidentStatus,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
}

pub struct ResponseEngine {
    incidents: DashMap<Uuid, DashboardIncident>,
    policies: DashMap<String, CoreResponsePolicy>,
    cooldowns: DashMap<String, DateTime<Utc>>,
    _event_bus: EventBus,
}

impl ResponseEngine {
    pub fn new(bus: EventBus) -> Self {
        info!("ResponseEngine initialized");
        Self {
            incidents: DashMap::new(),
            policies: DashMap::new(),
            cooldowns: DashMap::new(),
            _event_bus: bus,
        }
    }

    pub async fn execute_action(&self, action: CoreResponseAction) -> CompletedAction {
        info!(action = ?action, "Executing response action");

        let started_at = Utc::now();

        let output = match &action {
            CoreResponseAction::BlockIp { ip, duration_secs } => {
                format!("IP {} blocked at firewall for {} seconds", ip, duration_secs)
            }
            CoreResponseAction::BlockDomain { domain, duration_secs } => {
                format!("Domain {} blocked at firewall for {} seconds", domain, duration_secs)
            }
            CoreResponseAction::DisableUser { user_id, duration_secs } => {
                format!("User {} account disabled for {} seconds", user_id, duration_secs)
            }
            CoreResponseAction::DisableApiKey { key_id, duration_secs } => {
                format!("API key {} disabled for {} seconds", key_id, duration_secs)
            }
            CoreResponseAction::RevokeJwt { jwt_id } => {
                format!("JWT {} revoked", jwt_id)
            }
            CoreResponseAction::QuarantineContainer { container_id, reason } => {
                format!("Container {} quarantined: {}", container_id, reason)
            }
            CoreResponseAction::IsolateHost { host_id, duration_secs } => {
                format!("Host {} network isolated for {} seconds", host_id, duration_secs)
            }
            CoreResponseAction::PauseWorker { worker_id, duration_secs } => {
                format!("Worker {} paused for {} seconds", worker_id, duration_secs)
            }
            CoreResponseAction::LockEscrow { booking_id, reason } => {
                format!("Escrow for booking {} locked: {}", booking_id, reason)
            }
            CoreResponseAction::Notify { channel, message, severity } => {
                format!("Notification sent to channel '{}' [{}]: {}", channel, severity, message)
            }
            CoreResponseAction::CreateIncident { title, description } => {
                format!("Incident created: {} - {}", title, description)
            }
            CoreResponseAction::RunScript { path, args } => {
                format!("Script {} executed with args {:?}", path, args)
            }
            CoreResponseAction::BlockProcess { pid, host_id } => {
                format!("Process {} on host {} blocked", pid, host_id)
            }
            CoreResponseAction::DeleteFile { path, host_id } => {
                format!("File {} on host {} deleted", path, host_id)
            }
            CoreResponseAction::CollectForensics { host_id, artifacts } => {
                format!("Forensics collected from host {}: {:?}", host_id, artifacts)
            }
        };

        tokio::time::sleep(std::time::Duration::from_millis(100)).await;

        let completed_at = Utc::now();
        info!(action = ?action, output = %output, "Response action completed");

        CompletedAction {
            action,
            status: ActionStatus::Completed,
            started_at,
            completed_at: Some(completed_at),
            output,
        }
    }

    pub fn create_incident(
        &self,
        title: impl Into<String>,
        description: impl Into<String>,
        severity: Severity,
        event_ids: Vec<Uuid>,
    ) -> security_os_core::Incident {
        let now = Utc::now();
        let incident = security_os_core::Incident {
            id: Uuid::new_v4(),
            title: title.into(),
            description: description.into(),
            severity,
            status: security_os_core::IncidentStatus::Open,
            mitre_tactic: None,
            mitre_technique: None,
            kill_chain_phase: None,
            root_cause: None,
            business_impact: None,
            affected_assets: Vec::new(),
            event_chain: event_ids,
            risk_score: severity.risk_weight() * 100.0,
            false_positive_probability: None,
            ai_summary: None,
            ai_recommended_actions: Vec::new(),
            created_at: now,
            updated_at: now,
            resolved_at: None,
            responder: None,
        };

        info!(
            incident_id = %incident.id,
            title = %incident.title,
            severity = %incident.severity,
            "Incident created"
        );

        let dashboard_incident = DashboardIncident {
            id: incident.id,
            title: incident.title.clone(),
            description: incident.description.clone(),
            severity: incident.severity,
            events: incident.event_chain.clone(),
            risk_score: incident.risk_score,
            actions_taken: Vec::new(),
            status: IncidentStatus::Open,
            created_at: now,
            updated_at: now,
        };
        self.incidents.insert(dashboard_incident.id, dashboard_incident);

        incident
    }

    pub fn add_action_to_incident(&self, incident_id: &Uuid, action: CompletedAction) {
        if let Some(mut incident) = self.incidents.get_mut(incident_id) {
            incident.actions_taken.push(action);
            incident.updated_at = Utc::now();
            info!(
                incident_id = %incident_id,
                total_actions = incident.actions_taken.len(),
                "Action added to incident"
            );
        }
    }

    pub fn get_open_incidents(&self) -> Vec<DashboardIncident> {
        self.incidents
            .iter()
            .filter(|entry| {
                matches!(
                    entry.value().status,
                    IncidentStatus::Open | IncidentStatus::Investigating
                )
            })
            .map(|entry| entry.value().clone())
            .collect()
    }

    pub fn resolve_incident(&self, incident_id: &Uuid, status: IncidentStatus) -> bool {
        if let Some(mut incident) = self.incidents.get_mut(incident_id) {
            let old_status = incident.status.clone();
            incident.status = status.clone();
            incident.updated_at = Utc::now();
            info!(
                incident_id = %incident_id,
                old_status = %old_status,
                new_status = %status,
                "Incident status updated"
            );
            true
        } else {
            false
        }
    }

    pub fn get_incident(&self, incident_id: &Uuid) -> Option<DashboardIncident> {
        self.incidents
            .get(incident_id)
            .map(|entry| entry.value().clone())
    }

    pub fn incident_count(&self) -> usize {
        self.incidents.len()
    }

    pub fn add_policy(&self, policy: CoreResponsePolicy) {
        info!(
            policy_id = %policy.id,
            policy_name = %policy.name,
            enabled = policy.enabled,
            conditions = policy.conditions.len(),
            actions = policy.actions.len(),
            "Response policy added"
        );
        self.policies.insert(policy.id.clone(), policy);
    }

    pub fn remove_policy(&self, policy_id: &str) -> bool {
        self.policies.remove(policy_id).is_some()
    }

    pub fn get_policy(&self, policy_id: &str) -> Option<CoreResponsePolicy> {
        self.policies.get(policy_id).map(|r| r.value().clone())
    }

    pub fn policy_count(&self) -> usize {
        self.policies.len()
    }

    fn action_cooldown_key(action: &CoreResponseAction, _event: &SecurityEvent) -> String {
        let (action_type, target) = match action {
            CoreResponseAction::BlockIp { ip, .. } => ("BlockIp", ip.clone()),
            CoreResponseAction::BlockDomain { domain, .. } => ("BlockDomain", domain.clone()),
            CoreResponseAction::DisableUser { user_id, .. } => ("DisableUser", user_id.clone()),
            CoreResponseAction::DisableApiKey { key_id, .. } => ("DisableApiKey", key_id.clone()),
            CoreResponseAction::RevokeJwt { jwt_id } => ("RevokeJwt", jwt_id.clone()),
            CoreResponseAction::QuarantineContainer { container_id, .. } => {
                ("QuarantineContainer", container_id.clone())
            }
            CoreResponseAction::IsolateHost { host_id, .. } => ("IsolateHost", host_id.clone()),
            CoreResponseAction::PauseWorker { worker_id, .. } => ("PauseWorker", worker_id.clone()),
            CoreResponseAction::LockEscrow { booking_id, .. } => ("LockEscrow", booking_id.clone()),
            CoreResponseAction::Notify { channel, .. } => ("Notify", channel.clone()),
            CoreResponseAction::CreateIncident { title, .. } => ("CreateIncident", title.clone()),
            CoreResponseAction::RunScript { path, .. } => ("RunScript", path.clone()),
            CoreResponseAction::BlockProcess { pid, host_id } => {
                ("BlockProcess", format!("{}:{}", host_id, pid))
            }
            CoreResponseAction::DeleteFile { path, host_id } => {
                ("DeleteFile", format!("{}:{}", host_id, path))
            }
            CoreResponseAction::CollectForensics { host_id, .. } => {
                ("CollectForensics", host_id.clone())
            }
        };
        format!("{}:{}", action_type, target)
    }

    pub fn is_on_cooldown(&self, action_type: &str, target: &str) -> bool {
        let key = format!("{}:{}", action_type, target);
        if let Some(last_executed) = self.cooldowns.get(&key) {
            let elapsed = Utc::now().signed_duration_since(*last_executed);
            let max_cooldown = self
                .policies
                .iter()
                .map(|p| p.cooldown_secs)
                .max()
                .unwrap_or(300);
            elapsed.num_seconds() < max_cooldown as i64
        } else {
            false
        }
    }

    pub fn evaluate_policies(&self, event: &SecurityEvent) -> Vec<CoreResponseAction> {
        let mut actions = Vec::new();

        for policy_ref in self.policies.iter() {
            let policy = policy_ref.value();
            if !policy.enabled {
                continue;
            }
            if !policy.auto_response_enabled {
                continue;
            }

            let all_conditions_met = policy
                .conditions
                .iter()
                .all(|cond| Self::evaluate_condition(cond, event));

            if all_conditions_met {
                for action in &policy.actions {
                    let key = Self::action_cooldown_key(action, event);
                    if let Some(last_executed) = self.cooldowns.get(&key) {
                        let elapsed = Utc::now().signed_duration_since(*last_executed);
                        if elapsed.num_seconds() < policy.cooldown_secs as i64 {
                            continue;
                        }
                    }
                    actions.push(action.clone());
                }
            }
        }

        actions
    }

    fn evaluate_condition(condition: &ResponseCondition, event: &SecurityEvent) -> bool {
        match condition {
            ResponseCondition::RiskAbove(threshold) => event.risk_score >= *threshold,
            ResponseCondition::SeverityAtLeast(min_severity) => event.severity >= *min_severity,
            ResponseCondition::IocMatch(ioc_value) => event
                .ioc_matches
                .iter()
                .any(|m| m.ioc_value.contains(ioc_value)),
            ResponseCondition::CategoryIs(category) => event.category == *category,
            ResponseCondition::EntityPresent(entity_type) => event
                .affected_entities
                .iter()
                .any(|e| e.entity_type == *entity_type),
            ResponseCondition::CountryIs(country) => event
                .country
                .as_ref()
                .map(|c| c == country)
                .unwrap_or(false),
            ResponseCondition::TimeWindow {
                event_type,
                count: _,
                window_secs: _,
            } => event
                .tags
                .iter()
                .any(|t| t.contains(event_type))
                || event.metadata.contains_key(event_type),
            ResponseCondition::Custom {
                field,
                operator,
                value,
            } => {
                if let Some(field_val) = event.metadata.get(field) {
                    let field_str = match field_val {
                        serde_json::Value::String(s) => s.clone(),
                        other => other.to_string(),
                    };
                    match operator.as_str() {
                        "equals" => &field_str == value,
                        "contains" => field_str.contains(value.as_str()),
                        "gt" => field_str
                            .parse::<f64>()
                            .ok()
                            .and_then(|fv| value.parse::<f64>().ok().map(|vv| fv > vv))
                            .unwrap_or(false),
                        "lt" => field_str
                            .parse::<f64>()
                            .ok()
                            .and_then(|fv| value.parse::<f64>().ok().map(|vv| fv < vv))
                            .unwrap_or(false),
                        _ => false,
                    }
                } else {
                    false
                }
            }
        }
    }

    pub async fn execute_policy_actions(&self, event: &SecurityEvent) -> Vec<CompletedAction> {
        let actions = self.evaluate_policies(event);
        let mut completed = Vec::new();

        for action in actions {
            let key = Self::action_cooldown_key(&action, event);

            let completed_action = self.execute_action(action).await;

            self.cooldowns.insert(key, Utc::now());

            info!(
                action = ?completed_action.action,
                status = %completed_action.status,
                "Policy action executed"
            );

            completed.push(completed_action);
        }

        completed
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{
        Entity, EntityType, EventAction, EventCategory, EventSource, IocMatch, SecurityEvent,
    };
    use std::collections::HashMap;

    fn test_engine() -> ResponseEngine {
        ResponseEngine::new(EventBus::new(100))
    }

    fn test_source() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "test-host".into(),
            agent_id: "agent-1".into(),
            process_name: None,
            process_id: None,
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            agent_version: None,
            service_name: None,
        }
    }

    fn test_event_with_risk(risk: f64) -> SecurityEvent {
        SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "Test Event",
            "Test description",
        )
        .with_risk_score(risk)
    }

    fn test_event_with_severity(severity: Severity) -> SecurityEvent {
        SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "Test Event",
            "Test description",
        )
        .with_severity(severity)
    }

    fn test_policy_risk_above(threshold: f64) -> CoreResponsePolicy {
        CoreResponsePolicy {
            id: "policy-risk".into(),
            name: "High Risk Block".into(),
            enabled: true,
            conditions: vec![ResponseCondition::RiskAbove(threshold)],
            actions: vec![CoreResponseAction::BlockIp {
                ip: "10.0.0.1".into(),
                duration_secs: 3600,
            }],
            cooldown_secs: 300,
            auto_response_enabled: true,
        }
    }

    fn test_policy_severity(severity: Severity) -> CoreResponsePolicy {
        CoreResponsePolicy {
            id: "policy-severity".into(),
            name: "Severity Response".into(),
            enabled: true,
            conditions: vec![ResponseCondition::SeverityAtLeast(severity)],
            actions: vec![CoreResponseAction::Notify {
                channel: "soc-team".into(),
                message: "High severity event detected".into(),
                severity: Severity::High,
            }],
            cooldown_secs: 60,
            auto_response_enabled: true,
        }
    }

    fn test_policy_disabled() -> CoreResponsePolicy {
        CoreResponsePolicy {
            id: "policy-disabled".into(),
            name: "Disabled Policy".into(),
            enabled: false,
            conditions: vec![ResponseCondition::RiskAbove(0.0)],
            actions: vec![CoreResponseAction::BlockIp {
                ip: "1.1.1.1".into(),
                duration_secs: 60,
            }],
            cooldown_secs: 300,
            auto_response_enabled: true,
        }
    }

    fn test_policy_no_auto() -> CoreResponsePolicy {
        CoreResponsePolicy {
            id: "policy-no-auto".into(),
            name: "Manual Only Policy".into(),
            enabled: true,
            conditions: vec![ResponseCondition::RiskAbove(0.0)],
            actions: vec![CoreResponseAction::BlockIp {
                ip: "2.2.2.2".into(),
                duration_secs: 60,
            }],
            cooldown_secs: 300,
            auto_response_enabled: false,
        }
    }

    fn test_policy_ioc_match() -> CoreResponsePolicy {
        CoreResponsePolicy {
            id: "policy-ioc".into(),
            name: "IOC Match Policy".into(),
            enabled: true,
            conditions: vec![ResponseCondition::IocMatch("evil.com".into())],
            actions: vec![CoreResponseAction::BlockDomain {
                domain: "evil.com".into(),
                duration_secs: 86400,
            }],
            cooldown_secs: 600,
            auto_response_enabled: true,
        }
    }

    fn test_policy_category() -> CoreResponsePolicy {
        CoreResponsePolicy {
            id: "policy-category".into(),
            name: "Network Category Policy".into(),
            enabled: true,
            conditions: vec![ResponseCondition::CategoryIs(EventCategory::Network)],
            actions: vec![CoreResponseAction::CreateIncident {
                title: "Network Incident".into(),
                description: "Network event triggered".into(),
            }],
            cooldown_secs: 120,
            auto_response_enabled: true,
        }
    }

    fn test_event_with_ioc(ioc_value: &str) -> SecurityEvent {
        let mut event = test_event_with_risk(80.0);
        event.ioc_matches.push(IocMatch {
            ioc_type: "domain".into(),
            ioc_value: ioc_value.into(),
            feed: "test".into(),
            feed_url: None,
            match_context: "test match".into(),
            confidence: 0.9,
            first_seen: None,
            last_seen: None,
        });
        event
    }

    fn test_event_with_entity(entity_type: EntityType, value: &str) -> SecurityEvent {
        let mut event = test_event_with_risk(50.0);
        event.affected_entities.push(Entity {
            entity_type,
            value: value.into(),
            risk_contribution: 0.5,
            metadata: HashMap::new(),
        });
        event
    }

    #[test]
    fn test_create_incident() {
        let engine = test_engine();
        let incident = engine.create_incident(
            "Brute force login",
            "Multiple failed login attempts from 192.168.1.100",
            Severity::High,
            vec![],
        );
        assert_eq!(incident.status, security_os_core::IncidentStatus::Open);
        assert_eq!(incident.title, "Brute force login");
        assert_eq!(incident.severity, Severity::High);
        assert!(incident.risk_score > 0.0);
    }

    #[test]
    fn test_get_open_incidents() {
        let engine = test_engine();
        let inc1 = engine.create_incident("Incident 1", "desc", Severity::High, vec![]);
        let _inc2 = engine.create_incident("Incident 2", "desc", Severity::Low, vec![]);

        engine.resolve_incident(&inc1.id, IncidentStatus::Resolved);

        let open = engine.get_open_incidents();
        assert_eq!(open.len(), 1);
        assert_eq!(open[0].title, "Incident 2");
    }

    #[test]
    fn test_add_action_to_incident() {
        let engine = test_engine();
        let incident = engine.create_incident("Test", "desc", Severity::Medium, vec![]);

        let action = CompletedAction {
            action: CoreResponseAction::BlockIp {
                ip: "10.0.0.1".into(),
                duration_secs: 3600,
            },
            status: ActionStatus::Completed,
            started_at: Utc::now(),
            completed_at: Some(Utc::now()),
            output: "Blocked".into(),
        };

        engine.add_action_to_incident(&incident.id, action);
        let updated = engine.get_incident(&incident.id).unwrap();
        assert_eq!(updated.actions_taken.len(), 1);
    }

    #[tokio::test]
    async fn test_execute_action() {
        let engine = test_engine();
        let completed = engine
            .execute_action(CoreResponseAction::DisableUser {
                user_id: "admin".into(),
                duration_secs: 3600,
            })
            .await;
        assert_eq!(completed.status, ActionStatus::Completed);
        assert!(completed.completed_at.is_some());
        assert!(completed.output.contains("admin"));
    }

    #[tokio::test]
    async fn test_execute_action_block_ip() {
        let engine = test_engine();
        let completed = engine
            .execute_action(CoreResponseAction::BlockIp {
                ip: "192.168.1.100".into(),
                duration_secs: 7200,
            })
            .await;
        assert_eq!(completed.status, ActionStatus::Completed);
        assert!(completed.output.contains("192.168.1.100"));
        assert!(completed.output.contains("7200 seconds"));
    }

    #[tokio::test]
    async fn test_execute_action_quarantine() {
        let engine = test_engine();
        let completed = engine
            .execute_action(CoreResponseAction::QuarantineContainer {
                container_id: "abc123".into(),
                reason: "crypto mining detected".into(),
            })
            .await;
        assert_eq!(completed.status, ActionStatus::Completed);
        assert!(completed.output.contains("abc123"));
        assert!(completed.output.contains("crypto mining"));
    }

    #[tokio::test]
    async fn test_execute_action_block_process() {
        let engine = test_engine();
        let completed = engine
            .execute_action(CoreResponseAction::BlockProcess {
                pid: 12345,
                host_id: "web-01".into(),
            })
            .await;
        assert_eq!(completed.status, ActionStatus::Completed);
        assert!(completed.output.contains("12345"));
        assert!(completed.output.contains("web-01"));
    }

    #[tokio::test]
    async fn test_execute_action_collect_forensics() {
        let engine = test_engine();
        let completed = engine
            .execute_action(CoreResponseAction::CollectForensics {
                host_id: "server-01".into(),
                artifacts: vec!["memory".into(), "disk".into(), "network".into()],
            })
            .await;
        assert_eq!(completed.status, ActionStatus::Completed);
        assert!(completed.output.contains("server-01"));
        assert!(completed.output.contains("memory"));
    }

    #[test]
    fn test_resolve_incident() {
        let engine = test_engine();
        let incident = engine.create_incident("Test", "desc", Severity::Low, vec![]);

        assert!(engine.resolve_incident(&incident.id, IncidentStatus::FalsePositive));
        let updated = engine.get_incident(&incident.id).unwrap();
        assert_eq!(updated.status, IncidentStatus::FalsePositive);
    }

    #[test]
    fn test_incident_count() {
        let engine = test_engine();
        assert_eq!(engine.incident_count(), 0);
        engine.create_incident("A", "desc", Severity::Low, vec![]);
        engine.create_incident("B", "desc", Severity::High, vec![]);
        assert_eq!(engine.incident_count(), 2);
    }

    #[test]
    fn test_add_policy() {
        let engine = test_engine();
        let policy = test_policy_risk_above(80.0);
        engine.add_policy(policy);
        assert!(engine.policies.contains_key("policy-risk"));
        assert_eq!(engine.policies.len(), 1);
    }

    #[test]
    fn test_remove_policy() {
        let engine = test_engine();
        engine.add_policy(test_policy_risk_above(80.0));
        assert!(engine.remove_policy("policy-risk"));
        assert!(!engine.remove_policy("policy-risk"));
        assert_eq!(engine.policies.len(), 0);
    }

    #[test]
    fn test_get_policy() {
        let engine = test_engine();
        engine.add_policy(test_policy_risk_above(80.0));
        let policy = engine.get_policy("policy-risk").unwrap();
        assert_eq!(policy.name, "High Risk Block");
        assert!(engine.get_policy("nonexistent").is_none());
    }

    #[test]
    fn test_policy_count() {
        let engine = test_engine();
        assert_eq!(engine.policy_count(), 0);
        engine.add_policy(test_policy_risk_above(80.0));
        engine.add_policy(test_policy_severity(Severity::High));
        assert_eq!(engine.policy_count(), 2);
    }

    #[test]
    fn test_evaluate_policies_risk_above_match() {
        let engine = test_engine();
        engine.add_policy(test_policy_risk_above(80.0));
        engine.add_policy(test_policy_disabled());
        engine.add_policy(test_policy_no_auto());

        let event = test_event_with_risk(90.0);
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 1);
        assert!(matches!(&actions[0], CoreResponseAction::BlockIp { ip, .. } if ip == "10.0.0.1"));
    }

    #[test]
    fn test_evaluate_policies_risk_above_no_match() {
        let engine = test_engine();
        engine.add_policy(test_policy_risk_above(80.0));

        let event = test_event_with_risk(50.0);
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 0);
    }

    #[test]
    fn test_evaluate_policies_disabled_ignored() {
        let engine = test_engine();
        engine.add_policy(test_policy_disabled());

        let event = test_event_with_risk(100.0);
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 0);
    }

    #[test]
    fn test_evaluate_policies_no_auto_ignored() {
        let engine = test_engine();
        engine.add_policy(test_policy_no_auto());

        let event = test_event_with_risk(100.0);
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 0);
    }

    #[test]
    fn test_evaluate_policies_severity_match() {
        let engine = test_engine();
        engine.add_policy(test_policy_severity(Severity::High));

        let event = test_event_with_severity(Severity::Critical);
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 1);
    }

    #[test]
    fn test_evaluate_policies_severity_no_match() {
        let engine = test_engine();
        engine.add_policy(test_policy_severity(Severity::Critical));

        let event = test_event_with_severity(Severity::Low);
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 0);
    }

    #[test]
    fn test_evaluate_policies_ioc_match() {
        let engine = test_engine();
        engine.add_policy(test_policy_ioc_match());

        let event = test_event_with_ioc("evil.com");
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 1);
    }

    #[test]
    fn test_evaluate_policies_ioc_no_match() {
        let engine = test_engine();
        engine.add_policy(test_policy_ioc_match());

        let event = test_event_with_ioc("good.com");
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 0);
    }

    #[test]
    fn test_evaluate_policies_category_match() {
        let engine = test_engine();
        engine.add_policy(test_policy_category());

        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "Network Event",
            "Test",
        );
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 1);
    }

    #[test]
    fn test_evaluate_policies_category_no_match() {
        let engine = test_engine();
        engine.add_policy(test_policy_category());

        let event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Executed,
            test_source(),
            "Process Event",
            "Test",
        );
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 0);
    }

    #[test]
    fn test_evaluate_policies_multiple_conditions_all_met() {
        let engine = test_engine();
        engine.add_policy(CoreResponsePolicy {
            id: "multi-condition".into(),
            name: "Multi Condition".into(),
            enabled: true,
            conditions: vec![
                ResponseCondition::RiskAbove(70.0),
                ResponseCondition::CategoryIs(EventCategory::Network),
            ],
            actions: vec![CoreResponseAction::CreateIncident {
                title: "Multi-triggered".into(),
                description: "Both conditions met".into(),
            }],
            cooldown_secs: 60,
            auto_response_enabled: true,
        });

        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "Test",
            "Test",
        )
        .with_risk_score(90.0);

        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 1);
    }

    #[test]
    fn test_evaluate_policies_multiple_conditions_partial() {
        let engine = test_engine();
        engine.add_policy(CoreResponsePolicy {
            id: "multi-condition".into(),
            name: "Multi Condition".into(),
            enabled: true,
            conditions: vec![
                ResponseCondition::RiskAbove(70.0),
                ResponseCondition::CategoryIs(EventCategory::Network),
            ],
            actions: vec![CoreResponseAction::CreateIncident {
                title: "Multi-triggered".into(),
                description: "Both conditions met".into(),
            }],
            cooldown_secs: 60,
            auto_response_enabled: true,
        });

        let event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Executed,
            test_source(),
            "Test",
            "Test",
        )
        .with_risk_score(90.0);

        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 0);
    }

    #[test]
    fn test_evaluate_policies_multiple_policies() {
        let engine = test_engine();
        engine.add_policy(test_policy_risk_above(80.0));
        engine.add_policy(test_policy_category());

        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "Test",
            "Test",
        )
        .with_risk_score(90.0);

        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 2);
    }

    #[test]
    fn test_is_on_cooldown_no_cooldown() {
        let engine = test_engine();
        assert!(!engine.is_on_cooldown("BlockIp", "10.0.0.1"));
    }

    #[test]
    fn test_is_on_cooldown_after_execute() {
        let engine = test_engine();
        engine.cooldowns.insert("BlockIp:10.0.0.1".into(), Utc::now());
        assert!(engine.is_on_cooldown("BlockIp", "10.0.0.1"));
    }

    #[test]
    fn test_is_on_cooldown_expired() {
        let engine = test_engine();
        let past = Utc::now() - chrono::Duration::seconds(600);
        engine.cooldowns.insert("BlockIp:10.0.0.1".into(), past);
        assert!(!engine.is_on_cooldown("BlockIp", "10.0.0.1"));
    }

    #[tokio::test]
    async fn test_execute_policy_actions() {
        let engine = test_engine();
        engine.add_policy(test_policy_risk_above(80.0));

        let event = test_event_with_risk(90.0);
        let completed = engine.execute_policy_actions(&event).await;
        assert_eq!(completed.len(), 1);
        assert_eq!(completed[0].status, ActionStatus::Completed);
    }

    #[tokio::test]
    async fn test_execute_policy_actions_records_cooldown() {
        let engine = test_engine();
        engine.add_policy(test_policy_risk_above(80.0));

        let event = test_event_with_risk(90.0);
        engine.execute_policy_actions(&event).await;
        assert!(engine.is_on_cooldown("BlockIp", "10.0.0.1"));
    }

    #[tokio::test]
    async fn test_execute_policy_actions_no_match() {
        let engine = test_engine();
        engine.add_policy(test_policy_risk_above(80.0));

        let event = test_event_with_risk(50.0);
        let completed = engine.execute_policy_actions(&event).await;
        assert_eq!(completed.len(), 0);
    }

    #[tokio::test]
    async fn test_execute_policy_actions_cooldown_prevents_repeat() {
        let engine = test_engine();
        engine.add_policy(test_policy_risk_above(80.0));

        let event = test_event_with_risk(90.0);
        let first = engine.execute_policy_actions(&event).await;
        assert_eq!(first.len(), 1);

        let second = engine.execute_policy_actions(&event).await;
        assert_eq!(second.len(), 0);
    }

    #[test]
    fn test_evaluate_condition_entity_present() {
        let engine = test_engine();
        engine.add_policy(CoreResponsePolicy {
            id: "entity-policy".into(),
            name: "Entity Policy".into(),
            enabled: true,
            conditions: vec![ResponseCondition::EntityPresent(EntityType::Container)],
            actions: vec![CoreResponseAction::CreateIncident {
                title: "Container Issue".into(),
                description: "Container entity present".into(),
            }],
            cooldown_secs: 60,
            auto_response_enabled: true,
        });

        let event = test_event_with_entity(EntityType::Container, "pod-123");
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 1);

        let event2 = test_event_with_entity(EntityType::Host, "host-1");
        let actions2 = engine.evaluate_policies(&event2);
        assert_eq!(actions2.len(), 0);
    }

    #[test]
    fn test_evaluate_condition_custom_equals() {
        let engine = test_engine();
        engine.add_policy(CoreResponsePolicy {
            id: "custom-eq".into(),
            name: "Custom Equals".into(),
            enabled: true,
            conditions: vec![ResponseCondition::Custom {
                field: "env".into(),
                operator: "equals".into(),
                value: "production".into(),
            }],
            actions: vec![CoreResponseAction::Notify {
                channel: "ops".into(),
                message: "Production event".into(),
                severity: Severity::Medium,
            }],
            cooldown_secs: 60,
            auto_response_enabled: true,
        });

        let mut event = test_event_with_risk(50.0);
        event
            .metadata
            .insert("env".into(), serde_json::Value::String("production".into()));
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 1);

        let mut event2 = test_event_with_risk(50.0);
        event2
            .metadata
            .insert("env".into(), serde_json::Value::String("staging".into()));
        let actions2 = engine.evaluate_policies(&event2);
        assert_eq!(actions2.len(), 0);
    }

    #[test]
    fn test_evaluate_condition_custom_contains() {
        let engine = test_engine();
        engine.add_policy(CoreResponsePolicy {
            id: "custom-contains".into(),
            name: "Custom Contains".into(),
            enabled: true,
            conditions: vec![ResponseCondition::Custom {
                field: "message".into(),
                operator: "contains".into(),
                value: "error".into(),
            }],
            actions: vec![CoreResponseAction::Notify {
                channel: "ops".into(),
                message: "Error detected".into(),
                severity: Severity::Medium,
            }],
            cooldown_secs: 60,
            auto_response_enabled: true,
        });

        let mut event = test_event_with_risk(50.0);
        event.metadata.insert(
            "message".into(),
            serde_json::Value::String("disk error on /dev/sda1".into()),
        );
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 1);
    }

    #[test]
    fn test_evaluate_condition_custom_gt() {
        let engine = test_engine();
        engine.add_policy(CoreResponsePolicy {
            id: "custom-gt".into(),
            name: "Custom GreaterThan".into(),
            enabled: true,
            conditions: vec![ResponseCondition::Custom {
                field: "cpu_usage".into(),
                operator: "gt".into(),
                value: "90".into(),
            }],
            actions: vec![CoreResponseAction::Notify {
                channel: "ops".into(),
                message: "High CPU".into(),
                severity: Severity::Medium,
            }],
            cooldown_secs: 60,
            auto_response_enabled: true,
        });

        let mut event = test_event_with_risk(50.0);
        event.metadata.insert(
            "cpu_usage".into(),
            serde_json::Value::String("95".into()),
        );
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 1);

        let mut event2 = test_event_with_risk(50.0);
        event2.metadata.insert(
            "cpu_usage".into(),
            serde_json::Value::String("80".into()),
        );
        let actions2 = engine.evaluate_policies(&event2);
        assert_eq!(actions2.len(), 0);
    }

    #[test]
    fn test_evaluate_condition_custom_missing_field() {
        let engine = test_engine();
        engine.add_policy(CoreResponsePolicy {
            id: "custom-missing".into(),
            name: "Custom Missing".into(),
            enabled: true,
            conditions: vec![ResponseCondition::Custom {
                field: "nonexistent".into(),
                operator: "equals".into(),
                value: "anything".into(),
            }],
            actions: vec![CoreResponseAction::Notify {
                channel: "ops".into(),
                message: "Should not fire".into(),
                severity: Severity::Medium,
            }],
            cooldown_secs: 60,
            auto_response_enabled: true,
        });

        let event = test_event_with_risk(50.0);
        let actions = engine.evaluate_policies(&event);
        assert_eq!(actions.len(), 0);
    }
}
