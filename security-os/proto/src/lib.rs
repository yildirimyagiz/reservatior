use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use uuid::Uuid;

pub use security_os_core::*;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EventBatch {
    pub batch_id: Uuid,
    pub timestamp: DateTime<Utc>,
    pub events: Vec<SecurityEvent>,
}

impl EventBatch {
    pub fn new(events: Vec<SecurityEvent>) -> Self {
        Self {
            batch_id: Uuid::new_v4(),
            timestamp: Utc::now(),
            events,
        }
    }
}

impl From<Vec<SecurityEvent>> for EventBatch {
    fn from(events: Vec<SecurityEvent>) -> Self {
        Self::new(events)
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AlertNotification {
    pub event_id: Uuid,
    pub severity: Severity,
    pub title: String,
    pub description: String,
    pub recipients: Vec<String>,
    pub created_at: DateTime<Utc>,
}

impl AlertNotification {
    pub fn new(
        event_id: Uuid,
        severity: Severity,
        title: impl Into<String>,
        description: impl Into<String>,
        recipients: Vec<String>,
    ) -> Self {
        Self {
            event_id,
            severity,
            title: title.into(),
            description: description.into(),
            recipients,
            created_at: Utc::now(),
        }
    }
}

impl From<&SecurityEvent> for AlertNotification {
    fn from(event: &SecurityEvent) -> Self {
        Self {
            event_id: event.id,
            severity: event.severity,
            title: event.title.clone(),
            description: event.description.clone(),
            recipients: Vec::new(),
            created_at: event.timestamp,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AgentStatus {
    pub agent_id: String,
    pub hostname: String,
    pub uptime_secs: u64,
    pub events_processed: u64,
    pub version: String,
    pub last_heartbeat: DateTime<Utc>,
}

impl AgentStatus {
    pub fn new(
        agent_id: impl Into<String>,
        hostname: impl Into<String>,
        version: impl Into<String>,
    ) -> Self {
        Self {
            agent_id: agent_id.into(),
            hostname: hostname.into(),
            uptime_secs: 0,
            events_processed: 0,
            version: version.into(),
            last_heartbeat: Utc::now(),
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum IncidentStatus {
    Open,
    Investigating,
    Resolved,
    FalsePositive,
}

impl std::fmt::Display for IncidentStatus {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Open => write!(f, "Open"),
            Self::Investigating => write!(f, "Investigating"),
            Self::Resolved => write!(f, "Resolved"),
            Self::FalsePositive => write!(f, "FalsePositive"),
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IncidentReport {
    pub id: Uuid,
    pub title: String,
    pub events: Vec<Uuid>,
    pub risk_score: f64,
    pub created_at: DateTime<Utc>,
    pub status: IncidentStatus,
}

impl IncidentReport {
    pub fn new(title: impl Into<String>) -> Self {
        Self {
            id: Uuid::new_v4(),
            title: title.into(),
            events: Vec::new(),
            risk_score: 0.0,
            created_at: Utc::now(),
            status: IncidentStatus::Open,
        }
    }

    pub fn with_event(mut self, event_id: Uuid) -> Self {
        self.events.push(event_id);
        self
    }

    pub fn with_risk_score(mut self, score: f64) -> Self {
        self.risk_score = score.clamp(0.0, 100.0);
        self
    }

    pub fn with_status(mut self, status: IncidentStatus) -> Self {
        self.status = status;
        self
    }
}

impl From<&SecurityEvent> for IncidentReport {
    fn from(event: &SecurityEvent) -> Self {
        Self {
            id: Uuid::new_v4(),
            title: event.title.clone(),
            events: vec![event.id],
            risk_score: event.risk_score,
            created_at: Utc::now(),
            status: IncidentStatus::Open,
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum ActionType {
    BlockIp,
    LockUser,
    QuarantineContainer,
    Notify,
    IsolateHost,
}

impl std::fmt::Display for ActionType {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::BlockIp => write!(f, "BlockIp"),
            Self::LockUser => write!(f, "LockUser"),
            Self::QuarantineContainer => write!(f, "QuarantineContainer"),
            Self::Notify => write!(f, "Notify"),
            Self::IsolateHost => write!(f, "IsolateHost"),
        }
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
pub enum ResponseActionStatus {
    Pending,
    Executing,
    Completed,
    Failed,
}

impl std::fmt::Display for ResponseActionStatus {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::Pending => write!(f, "Pending"),
            Self::Executing => write!(f, "Executing"),
            Self::Completed => write!(f, "Completed"),
            Self::Failed => write!(f, "Failed"),
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ResponseAction {
    pub action_type: ActionType,
    pub target: String,
    pub parameters: HashMap<String, serde_json::Value>,
    pub status: ResponseActionStatus,
}

impl ResponseAction {
    pub fn new(action_type: ActionType, target: impl Into<String>) -> Self {
        Self {
            action_type,
            target: target.into(),
            parameters: HashMap::new(),
            status: ResponseActionStatus::Pending,
        }
    }

    pub fn with_parameter(mut self, key: impl Into<String>, value: serde_json::Value) -> Self {
        self.parameters.insert(key.into(), value);
        self
    }

    pub fn with_status(mut self, status: ResponseActionStatus) -> Self {
        self.status = status;
        self
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{EventAction, EventCategory, EventSource};

    fn test_source() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "h1".into(),
            host_name: "testhost".into(),
            agent_id: "a1".into(),
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

    #[test]
    fn test_event_batch_from_vec() {
        let events = vec![SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "Test",
            "Desc",
        )];
        let batch: EventBatch = events.into();
        assert_eq!(batch.events.len(), 1);
        assert!(!batch.batch_id.is_nil());
    }

    #[test]
    fn test_alert_notification_from_event() {
        let event = SecurityEvent::new(
            EventCategory::Authentication,
            EventAction::Failed,
            test_source(),
            "Auth failed",
            "Bad login",
        )
        .with_severity(Severity::High);

        let alert = AlertNotification::from(&event);
        assert_eq!(alert.event_id, event.id);
        assert_eq!(alert.severity, Severity::High);
        assert_eq!(alert.title, "Auth failed");
    }

    #[test]
    fn test_incident_from_event() {
        let event = SecurityEvent::new(
            EventCategory::Container,
            EventAction::Detected,
            test_source(),
            "Suspicious container",
            "Cryptominer detected",
        )
        .with_risk_score(85.0);

        let incident = IncidentReport::from(&event);
        assert_eq!(incident.events, vec![event.id]);
        assert_eq!(incident.risk_score, 85.0);
        assert_eq!(incident.status, IncidentStatus::Open);
    }

    #[test]
    fn test_response_action_builder() {
        let action = ResponseAction::new(ActionType::BlockIp, "10.0.0.1")
            .with_parameter("duration_secs", serde_json::json!(3600))
            .with_status(ResponseActionStatus::Pending);

        assert_eq!(action.action_type, ActionType::BlockIp);
        assert_eq!(action.target, "10.0.0.1");
        assert_eq!(
            action.parameters["duration_secs"],
            serde_json::json!(3600)
        );
    }

    #[test]
    fn test_incident_builder() {
        let id1 = Uuid::new_v4();
        let id2 = Uuid::new_v4();
        let incident = IncidentReport::new("Data exfiltration")
            .with_event(id1)
            .with_event(id2)
            .with_risk_score(92.0)
            .with_status(IncidentStatus::Investigating);

        assert_eq!(incident.events, vec![id1, id2]);
        assert_eq!(incident.status, IncidentStatus::Investigating);
    }

    #[test]
    fn test_agent_status_builder() {
        let agent = AgentStatus::new("agent-1", "web-server-01", "0.5.0");
        assert_eq!(agent.agent_id, "agent-1");
        assert_eq!(agent.hostname, "web-server-01");
        assert_eq!(agent.version, "0.5.0");
    }

    #[test]
    fn test_incident_status_display() {
        assert_eq!(IncidentStatus::Open.to_string(), "Open");
        assert_eq!(IncidentStatus::Investigating.to_string(), "Investigating");
        assert_eq!(IncidentStatus::Resolved.to_string(), "Resolved");
        assert_eq!(IncidentStatus::FalsePositive.to_string(), "FalsePositive");
    }

    #[test]
    fn test_action_type_display() {
        assert_eq!(ActionType::BlockIp.to_string(), "BlockIp");
        assert_eq!(ActionType::LockUser.to_string(), "LockUser");
        assert_eq!(
            ActionType::QuarantineContainer.to_string(),
            "QuarantineContainer"
        );
        assert_eq!(ActionType::Notify.to_string(), "Notify");
        assert_eq!(ActionType::IsolateHost.to_string(), "IsolateHost");
    }
}
