use chrono::{DateTime, Datelike, Timelike, Utc};
use dashmap::DashMap;
use security_os_core::*;
use std::collections::{HashMap, HashSet};

#[derive(Debug, Clone)]
pub struct UserProfile {
    pub user_id: String,
    pub login_hours: HashSet<u32>,
    pub active_days: HashSet<u32>,
    pub typical_actions: HashMap<String, u32>,
    pub last_seen: DateTime<Utc>,
    pub last_source_ip: Option<String>,
    pub last_source_host: Option<String>,
}

impl UserProfile {
    pub fn new(user_id: String) -> Self {
        Self {
            user_id,
            login_hours: HashSet::new(),
            active_days: HashSet::new(),
            typical_actions: HashMap::new(),
            last_seen: Utc::now(),
            last_source_ip: None,
            last_source_host: None,
        }
    }
}

#[derive(Debug)]
pub struct BehaviorEngine {
    profiles: DashMap<String, UserProfile>,
}

impl BehaviorEngine {
    pub fn new() -> Self {
        Self {
            profiles: DashMap::new(),
        }
    }

    fn get_or_create_profile(&self, user_id: &str) -> UserProfile {
        self.profiles
            .entry(user_id.to_string())
            .or_insert_with(|| UserProfile::new(user_id.to_string()))
            .clone()
    }

    fn update_profile_from_event(&self, user_id: &str, event: &SecurityEvent) {
        if let Some(mut profile) = self.profiles.get_mut(user_id) {
            let hour = event.timestamp.hour();
            profile.login_hours.insert(hour);

            let weekday = event.timestamp.weekday().num_days_from_sunday();
            profile.active_days.insert(weekday);

            let action_key = format!("{:?}", event.category);
            *profile.typical_actions.entry(action_key).or_insert(0) += 1;

            profile.last_seen = event.timestamp;

            profile.last_source_ip = Some(event.source.host_id.clone());
            profile.last_source_host = Some(event.source.host_name.clone());
        }
    }

    fn detect_unusual_login_time(
        &self,
        user_id: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if event.category != EventCategory::Authentication {
            return None;
        }

        let profile = self.get_or_create_profile(user_id);
        let hour = event.timestamp.hour();

        if profile.login_hours.len() >= 5 && !profile.login_hours.contains(&hour) {
            let mut detection = SecurityEvent::new(
                EventCategory::Behavior,
                EventAction::Detected,
                event.source.clone(),
                "Unusual Login Time",
                format!(
                    "User {} logged in at hour {} which is outside their normal login pattern",
                    user_id, hour
                ),
            )
            .with_severity(Severity::Medium)
            .with_mitre(
                "Defense Evasion",
                "Valid Accounts: Default Accounts",
                "T1078",
            )
            .with_risk_score(45.0)
            .with_tag("behavior-anomaly")
            .with_tag("unusual-login-time")
            .with_parent_event(event.id);

            detection
                .metadata
                .insert("user_id".into(), serde_json::Value::String(user_id.into()));
            detection
                .metadata
                .insert("current_hour".into(), serde_json::json!(hour));
            detection.metadata.insert(
                "normal_hours".into(),
                serde_json::json!(profile.login_hours.iter().copied().collect::<Vec<_>>()),
            );

            Some(detection)
        } else {
            None
        }
    }

    fn detect_impossible_travel(
        &self,
        user_id: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if event.category != EventCategory::Authentication {
            return None;
        }

        let profile = self.get_or_create_profile(user_id);

        if let Some(ref last_host) = profile.last_source_host {
            let current_host = &event.source.host_name;
            let time_diff = event.timestamp.signed_duration_since(profile.last_seen);

            if last_host != current_host
                && time_diff.num_minutes().abs() < 60
                && profile.last_seen != DateTime::<Utc>::default()
            {
                let detection = SecurityEvent::new(
                    EventCategory::Behavior,
                    EventAction::Detected,
                    event.source.clone(),
                    "Impossible Travel Detected",
                    format!(
                        "User {} authenticated from {} then {} within {} minutes",
                        user_id,
                        last_host,
                        current_host,
                        time_diff.num_minutes().abs()
                    ),
                )
                .with_severity(Severity::High)
                .with_mitre(
                    "Defense Evasion",
                    "Valid Accounts: Default Accounts",
                    "T1078",
                )
                .with_risk_score(75.0)
                .with_tag("behavior-anomaly")
                .with_tag("impossible-travel")
                .with_parent_event(event.id);

                return Some(detection);
            }
        }

        None
    }

    fn detect_dormant_account(
        &self,
        user_id: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        let profile = self.get_or_create_profile(user_id);
        let duration = event.timestamp.signed_duration_since(profile.last_seen);
        let days_since_active = duration.num_days();

        if days_since_active > 30 && profile.last_seen != DateTime::<Utc>::default() {
            let detection = SecurityEvent::new(
                EventCategory::Behavior,
                EventAction::Detected,
                event.source.clone(),
                "Dormant Account Reactivation",
                format!(
                    "Account {} was inactive for {} days and has been reactivated",
                    user_id, days_since_active
                ),
            )
            .with_severity(Severity::Medium)
            .with_mitre(
                "Defense Evasion",
                "Valid Accounts: Default Accounts",
                "T1078",
            )
            .with_risk_score(40.0)
            .with_tag("behavior-anomaly")
            .with_tag("dormant-account")
            .with_parent_event(event.id);

            return Some(detection);
        }

        None
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let user_id = match event.source.user_id.as_deref() {
            Some(uid) => uid.to_string(),
            None => return Vec::new(),
        };

        let mut detections = Vec::new();

        if let Some(detection) = self.detect_unusual_login_time(&user_id, event) {
            detections.push(detection);
        }

        if let Some(detection) = self.detect_impossible_travel(&user_id, event) {
            detections.push(detection);
        }

        if let Some(detection) = self.detect_dormant_account(&user_id, event) {
            detections.push(detection);
        }

        self.update_profile_from_event(&user_id, event);

        detections
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn make_event(
        category: EventCategory,
        action: EventAction,
        user_id: Option<&str>,
        host_name: &str,
        host_id: &str,
    ) -> SecurityEvent {
        let source = EventSource {
            collector: "test".into(),
            host_id: host_id.into(),
            host_name: host_name.into(),
            agent_id: "agent-1".into(),
            process_name: None,
            process_id: None,
            user_id: user_id.map(|s| s.into()),
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
        
            agent_version: None,
            service_name: None,
        };
        SecurityEvent::new(category, action, source, "Test Event", "Test description")
    }

    #[test]
    fn test_new_engine() {
        let engine = BehaviorEngine::new();
        assert!(engine.profiles.is_empty());
    }

    #[test]
    fn test_process_event_no_user_id() {
        let mut engine = BehaviorEngine::new();
        let event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            None,
            "host1",
            "h1",
        );
        let detections = engine.process_event(&event);
        assert!(detections.is_empty());
    }

    #[test]
    fn test_process_event_creates_profile() {
        let mut engine = BehaviorEngine::new();
        let event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            Some("user1"),
            "host1",
            "h1",
        );
        engine.process_event(&event);
        assert!(engine.profiles.contains_key("user1"));
    }

    #[test]
    fn test_unusual_login_time_detection() {
        let mut engine = BehaviorEngine::new();

        // Build profile with hours 1-5
        for h in 1..=5 {
            let event = make_event(
                EventCategory::Authentication,
                EventAction::Connected,
                Some("user1"),
                "host1",
                "h1",
            );
            let mut event = event;
            event.timestamp = Utc::now()
                .date_naive()
                .and_hms_opt(h, 0, 0)
                .unwrap()
                .and_utc();
            engine.process_event(&event);
        }

        // Now trigger at hour 23 which is outside normal hours
        let event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            Some("user1"),
            "host1",
            "h1",
        );
        let mut event = event;
        event.timestamp = Utc::now()
            .date_naive()
            .and_hms_opt(23, 0, 0)
            .unwrap()
            .and_utc();

        let detections = engine.process_event(&event);
        assert!(
            !detections.is_empty(),
            "Should detect unusual login time"
        );
        assert_eq!(detections[0].title, "Unusual Login Time");
        assert_eq!(detections[0].severity, Severity::Medium);
        assert_eq!(
            detections[0].mitre_id.as_deref(),
            Some("T1078")
        );
    }

    #[test]
    fn test_impossible_travel_detection() {
        let mut engine = BehaviorEngine::new();

        // First login from NYC
        let event1 = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            Some("user1"),
            "nyc-host",
            "nyc-1",
        );
        let mut event1 = event1;
        event1.timestamp = Utc::now()
            .checked_sub_signed(chrono::Duration::minutes(30))
            .unwrap();
        engine.process_event(&event1);

        // Second login from London within 30 minutes
        let event2 = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            Some("user1"),
            "london-host",
            "lon-1",
        );
        let detections = engine.process_event(&event2);
        assert!(
            !detections.is_empty(),
            "Should detect impossible travel"
        );
        assert_eq!(detections[0].title, "Impossible Travel Detected");
        assert_eq!(detections[0].severity, Severity::High);
    }

    #[test]
    fn test_dormant_account_detection() {
        let mut engine = BehaviorEngine::new();

        // Set last_seen to 60 days ago
        let past_event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            Some("user1"),
            "host1",
            "h1",
        );
        let mut past_event = past_event;
        past_event.timestamp = Utc::now()
            .checked_sub_signed(chrono::Duration::days(60))
            .unwrap();
        engine.process_event(&past_event);

        // Now send a new event
        let new_event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            Some("user1"),
            "host1",
            "h1",
        );
        let detections = engine.process_event(&new_event);
        assert!(
            !detections.is_empty(),
            "Should detect dormant account reactivation"
        );
        assert_eq!(detections[0].title, "Dormant Account Reactivation");
        assert_eq!(detections[0].severity, Severity::Medium);
    }

    #[test]
    fn test_no_dormant_if_recent() {
        let mut engine = BehaviorEngine::new();

        // Set last_seen to 5 days ago
        let past_event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            Some("user1"),
            "host1",
            "h1",
        );
        let mut past_event = past_event;
        past_event.timestamp = Utc::now()
            .checked_sub_signed(chrono::Duration::days(5))
            .unwrap();
        engine.process_event(&past_event);

        let new_event = make_event(
            EventCategory::Authentication,
            EventAction::Connected,
            Some("user1"),
            "host1",
            "h1",
        );
        let detections = engine.process_event(&new_event);
        assert!(
            detections.is_empty(),
            "Should not detect dormant if inactive < 30 days"
        );
    }
}
