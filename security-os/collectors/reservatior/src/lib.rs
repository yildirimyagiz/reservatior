use std::time::Duration;

use reqwest::Client;
use serde::{Deserialize, Serialize};
use security_os_core::{
    EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::{debug, info, warn};

const WATCHED_EVENTS: &[&str] = &[
    "auth.login",
    "auth.failed",
    "booking.created",
    "payment.received",
    "admin.created",
    "role.changed",
    "escrow.released",
];

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BusinessEvent {
    pub id: String,
    pub event_type: String,
    pub timestamp: String,
    pub data: serde_json::Value,
    pub actor_id: Option<String>,
    pub actor_email: Option<String>,
    pub target_id: Option<String>,
    pub metadata: Option<serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EventListResponse {
    pub events: Vec<BusinessEvent>,
    pub next_cursor: Option<String>,
    pub total: u64,
}

pub struct ReservatiorCollector {
    api_url: String,
    api_token: String,
    watch_events: Vec<String>,
    last_seen_id: Option<String>,
    client: Client,
    host_id: String,
    host_name: String,
    agent_id: String,
}

impl ReservatiorCollector {
    pub fn new(api_url: String, api_token: String, watch_events: Vec<String>) -> Self {
        let hostname = hostname::get()
            .map(|h| h.to_string_lossy().into_owned())
            .unwrap_or_else(|_| "unknown".into());

        let client = Client::builder()
            .timeout(Duration::from_secs(30))
            .build()
            .expect("Failed to create HTTP client");

        info!(
            api_url = %api_url,
            watch_events = ?watch_events,
            "Reservatior collector initialized"
        );

        Self {
            api_url,
            api_token,
            watch_events,
            last_seen_id: None,
            client,
            host_id: hostname.clone(),
            host_name: hostname,
            agent_id: "reservatior-collector-0".into(),
        }
    }

    fn make_source(&self) -> EventSource {
        EventSource {
            collector: "reservatior".into(),
            host_id: self.host_id.clone(),
            host_name: self.host_name.clone(),
            agent_id: self.agent_id.clone(),
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

    async fn fetch_events(&self) -> Result<EventListResponse, reqwest::Error> {
        let url = format!("{}/api/v1/events", self.api_url);

        let mut query_params = vec![("limit", "100".to_string())];

        if let Some(ref cursor) = self.last_seen_id {
            query_params.push(("after", cursor.clone()));
        }

        if !self.watch_events.is_empty() {
            let events_param = self.watch_events.join(",");
            query_params.push(("types", events_param));
        }

        let response = self
            .client
            .get(&url)
            .bearer_auth(&self.api_token)
            .query(&query_params)
            .send()
            .await?
            .error_for_status()?
            .json::<EventListResponse>()
            .await;

        response
    }

    fn map_business_event_to_security(&self, biz_event: &BusinessEvent) -> Option<SecurityEvent> {
        let event_type = biz_event.event_type.as_str();

        let (category, action, severity, title, description, risk_score, mitre) = match event_type {
            "auth.failed" => (
                EventCategory::Authentication,
                EventAction::Failed,
                Severity::Medium,
                format!("Authentication failed: {}", biz_event.event_type),
                format!(
                    "Failed authentication attempt by actor_id={}, email={}",
                    biz_event.actor_id.as_deref().unwrap_or("unknown"),
                    biz_event.actor_email.as_deref().unwrap_or("unknown")
                ),
                60.0,
                None,
            ),
            "admin.created" => (
                EventCategory::Authentication,
                EventAction::Created,
                Severity::High,
                "New admin account created".to_string(),
                format!(
                    "Admin account created: actor_id={}, target_id={}",
                    biz_event.actor_id.as_deref().unwrap_or("unknown"),
                    biz_event.target_id.as_deref().unwrap_or("unknown")
                ),
                85.0,
                Some(("Privilege Escalation", "Abuse Elevation Control Mechanism", "T1548")),
            ),
            "role.changed" => (
                EventCategory::Authentication,
                EventAction::Escalated,
                Severity::High,
                "User role changed - potential privilege escalation".to_string(),
                format!(
                    "Role changed for target_id={}, by actor_id={}",
                    biz_event.target_id.as_deref().unwrap_or("unknown"),
                    biz_event.actor_id.as_deref().unwrap_or("unknown")
                ),
                80.0,
                Some(("Privilege Escalation", "Abuse Elevation Control Mechanism", "T1548")),
            ),
            "booking.created" => (
                EventCategory::ReservatiorBusiness,
                EventAction::Created,
                Severity::Informational,
                "New booking created".to_string(),
                format!(
                    "Booking created: target_id={}, by actor_id={}",
                    biz_event.target_id.as_deref().unwrap_or("unknown"),
                    biz_event.actor_id.as_deref().unwrap_or("unknown")
                ),
                10.0,
                None,
            ),
            "payment.received" => (
                EventCategory::ReservatiorBusiness,
                EventAction::Created,
                Severity::Informational,
                "Payment received".to_string(),
                format!(
                    "Payment received: target_id={}, by actor_id={}",
                    biz_event.target_id.as_deref().unwrap_or("unknown"),
                    biz_event.actor_id.as_deref().unwrap_or("unknown")
                ),
                10.0,
                None,
            ),
            "escrow.released" => (
                EventCategory::ReservatiorBusiness,
                EventAction::Created,
                Severity::Medium,
                "Escrow funds released".to_string(),
                format!(
                    "Escrow released: target_id={}, by actor_id={}",
                    biz_event.target_id.as_deref().unwrap_or("unknown"),
                    biz_event.actor_id.as_deref().unwrap_or("unknown")
                ),
                45.0,
                None,
            ),
            "auth.login" => (
                EventCategory::Authentication,
                EventAction::Executed,
                Severity::Informational,
                "Successful login".to_string(),
                format!(
                    "Login by actor_id={}, email={}",
                    biz_event.actor_id.as_deref().unwrap_or("unknown"),
                    biz_event.actor_email.as_deref().unwrap_or("unknown")
                ),
                5.0,
                None,
            ),
            _ => {
                debug!(
                    event_type = %biz_event.event_type,
                    "Ignoring unwatched event type"
                );
                return None;
            }
        };

        let mut event = SecurityEvent::new(
            category,
            action,
            self.make_source(),
            title,
            description,
        )
        .with_severity(severity)
        .with_risk_score(risk_score)
        .with_tag("reservatior")
        .with_tag("business-event")
        .with_tag(event_type);

        if let Some((tactic, technique, id)) = mitre {
            event = event.with_mitre(tactic, technique, id);
        }

        // Populate metadata
        event.metadata.insert(
            "event_id".into(),
            serde_json::Value::String(biz_event.id.clone()),
        );
        event.metadata.insert(
            "event_type".into(),
            serde_json::Value::String(biz_event.event_type.clone()),
        );
        event.metadata.insert(
            "timestamp".into(),
            serde_json::Value::String(biz_event.timestamp.clone()),
        );

        if let Some(ref actor_id) = biz_event.actor_id {
            event.metadata.insert(
                "actor_id".into(),
                serde_json::Value::String(actor_id.clone()),
            );
        }
        if let Some(ref actor_email) = biz_event.actor_email {
            event.metadata.insert(
                "actor_email".into(),
                serde_json::Value::String(actor_email.clone()),
            );
        }
        if let Some(ref target_id) = biz_event.target_id {
            event.metadata.insert(
                "target_id".into(),
                serde_json::Value::String(target_id.clone()),
            );
        }
        if !biz_event.data.is_null() {
            event
                .metadata
                .insert("event_data".into(), biz_event.data.clone());
        }
        if let Some(ref meta) = biz_event.metadata {
            event
                .metadata
                .insert("extra_metadata".into(), meta.clone());
        }

        Some(event)
    }

    pub async fn scan(&mut self) -> Vec<SecurityEvent> {
        let mut events = Vec::new();

        let response = match self.fetch_events().await {
            Ok(resp) => resp,
            Err(e) => {
                warn!(
                    api_url = %self.api_url,
                    error = %e,
                    "Failed to fetch events from Reservatior API"
                );
                return events;
            }
        };

        debug!(
            fetched_count = response.events.len(),
            "Fetched events from Reservatior API"
        );

        for biz_event in &response.events {
            // Skip already-seen events
            if let Some(ref last_id) = self.last_seen_id {
                if &biz_event.id <= last_id {
                    continue;
                }
            }

            if let Some(security_event) = self.map_business_event_to_security(biz_event) {
                debug!(
                    event_id = %security_event.id,
                    biz_event_id = %biz_event.id,
                    event_type = %biz_event.event_type,
                    severity = %security_event.severity,
                    "Business event mapped to security event"
                );
                events.push(security_event);
            }

            // Update last seen ID
            self.last_seen_id = Some(biz_event.id.clone());
        }

        // If we got a cursor, use it for next request
        if let Some(cursor) = response.next_cursor {
            self.last_seen_id = Some(cursor);
        }

        debug!(
            events_generated = events.len(),
            last_seen_id = ?self.last_seen_id,
            "Reservatior scan completed"
        );

        events
    }

    pub async fn run(mut self, bus: security_os_core::EventBus, interval: Duration) {
        info!(
            api_url = %self.api_url,
            interval_ms = interval.as_millis() as u64,
            "Reservatior collector starting"
        );

        loop {
            let events = self.scan().await;
            for event in events {
                debug!(
                    event_id = %event.id,
                    title = %event.title,
                    severity = %event.severity,
                    "Publishing Reservatior security event"
                );
                bus.publish(event);
            }
            tokio::time::sleep(interval).await;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_new_collector() {
        let collector = ReservatiorCollector::new(
            "http://localhost:8080".to_string(),
            "test-token".to_string(),
            vec!["auth.failed".to_string(), "admin.created".to_string()],
        );

        assert_eq!(collector.api_url, "http://localhost:8080");
        assert_eq!(collector.api_token, "test-token");
        assert_eq!(collector.watch_events.len(), 2);
        assert!(collector.last_seen_id.is_none());
    }

    #[test]
    fn test_map_auth_failed() {
        let collector = ReservatiorCollector::new(
            "http://localhost:8080".to_string(),
            "test-token".to_string(),
            WATCHED_EVENTS.iter().map(|s| s.to_string()).collect(),
        );

        let biz_event = BusinessEvent {
            id: "evt-001".to_string(),
            event_type: "auth.failed".to_string(),
            timestamp: "2024-01-01T00:00:00Z".to_string(),
            data: serde_json::json!({"reason": "invalid_password"}),
            actor_id: Some("user-123".to_string()),
            actor_email: Some("test@example.com".to_string()),
            target_id: None,
            metadata: None,
        };

        let event = collector
            .map_business_event_to_security(&biz_event)
            .expect("Should map auth.failed event");

        assert_eq!(event.category, EventCategory::Authentication);
        assert_eq!(event.action, EventAction::Failed);
        assert_eq!(event.severity, Severity::Medium);
        assert!(event.tags.contains(&"auth.failed".to_string()));
        assert!(event
            .metadata
            .contains_key(&"actor_email".to_string()));
    }

    #[test]
    fn test_map_admin_created() {
        let collector = ReservatiorCollector::new(
            "http://localhost:8080".to_string(),
            "test-token".to_string(),
            WATCHED_EVENTS.iter().map(|s| s.to_string()).collect(),
        );

        let biz_event = BusinessEvent {
            id: "evt-002".to_string(),
            event_type: "admin.created".to_string(),
            timestamp: "2024-01-01T00:00:00Z".to_string(),
            data: serde_json::json!({}),
            actor_id: Some("admin-1".to_string()),
            actor_email: Some("admin@example.com".to_string()),
            target_id: Some("new-admin-1".to_string()),
            metadata: None,
        };

        let event = collector
            .map_business_event_to_security(&biz_event)
            .expect("Should map admin.created event");

        assert_eq!(event.category, EventCategory::Authentication);
        assert_eq!(event.action, EventAction::Created);
        assert_eq!(event.severity, Severity::High);
        assert!(event.mitre_id.as_deref() == Some("T1548"));
        assert!(event.tags.contains(&"admin.created".to_string()));
    }

    #[test]
    fn test_unwatched_event_returns_none() {
        let collector = ReservatiorCollector::new(
            "http://localhost:8080".to_string(),
            "test-token".to_string(),
            vec!["auth.failed".to_string()],
        );

        let biz_event = BusinessEvent {
            id: "evt-003".to_string(),
            event_type: "unknown.event".to_string(),
            timestamp: "2024-01-01T00:00:00Z".to_string(),
            data: serde_json::json!({}),
            actor_id: None,
            actor_email: None,
            target_id: None,
            metadata: None,
        };

        assert!(collector.map_business_event_to_security(&biz_event).is_none());
    }
}
