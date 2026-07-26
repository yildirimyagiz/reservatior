use chrono::{DateTime, Duration, Utc};
use dashmap::DashMap;
use std::time::Duration as StdDuration;

pub struct HeartbeatTracker {
    last_heartbeats: DashMap<String, DateTime<Utc>>,
    timeout_secs: u64,
    check_interval_secs: u64,
}

impl HeartbeatTracker {
    pub fn new(timeout_secs: u64, check_interval_secs: u64) -> Self {
        Self {
            last_heartbeats: DashMap::new(),
            timeout_secs,
            check_interval_secs,
        }
    }

    pub fn record(&self, agent_id: &str) {
        self.last_heartbeats
            .insert(agent_id.to_string(), Utc::now());
    }

    pub fn last_heartbeat(&self, agent_id: &str) -> Option<DateTime<Utc>> {
        self.last_heartbeats.get(agent_id).map(|r| *r.value())
    }

    pub fn is_online(&self, agent_id: &str) -> bool {
        self.last_heartbeats
            .get(agent_id)
            .map(|r| {
                let elapsed = Utc::now() - *r.value();
                elapsed < Duration::seconds(self.timeout_secs as i64)
            })
            .unwrap_or(false)
    }

    pub fn is_timed_out(&self, agent_id: &str) -> bool {
        self.last_heartbeats
            .get(agent_id)
            .map(|r| {
                let elapsed = Utc::now() - *r.value();
                elapsed >= Duration::seconds(self.timeout_secs as i64)
            })
            .unwrap_or(false)
    }

    pub fn offline_agents(&self) -> Vec<String> {
        let timeout = Duration::seconds(self.timeout_secs as i64);
        self.last_heartbeats
            .iter()
            .filter(|r| {
                let elapsed = Utc::now() - *r.value();
                elapsed >= timeout
            })
            .map(|r| r.key().clone())
            .collect()
    }

    pub fn online_agents(&self) -> Vec<String> {
        let timeout = Duration::seconds(self.timeout_secs as i64);
        self.last_heartbeats
            .iter()
            .filter(|r| {
                let elapsed = Utc::now() - *r.value();
                elapsed < timeout
            })
            .map(|r| r.key().clone())
            .collect()
    }

    pub fn timeout_duration(&self) -> StdDuration {
        StdDuration::from_secs(self.timeout_secs)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_record_and_is_online() {
        let tracker = HeartbeatTracker::new(30, 10);
        tracker.record("a1");
        assert!(tracker.is_online("a1"));
        assert_eq!(tracker.last_heartbeat("a1").is_some(), true);
    }

    #[test]
    fn test_not_online_without_heartbeat() {
        let tracker = HeartbeatTracker::new(30, 10);
        assert!(!tracker.is_online("nonexistent"));
        assert!(!tracker.is_timed_out("nonexistent"));
    }

    #[test]
    fn test_is_timed_out() {
        let tracker = HeartbeatTracker::new(0, 10);
        tracker.record("a1");
        assert!(tracker.is_timed_out("a1"));
    }

    #[test]
    fn test_offline_agents() {
        let tracker = HeartbeatTracker::new(0, 10);
        tracker.record("a1");
        tracker.record("a2");
        let offline = tracker.offline_agents();
        assert_eq!(offline.len(), 2);
        assert!(offline.contains(&"a1".to_string()));
        assert!(offline.contains(&"a2".to_string()));
    }
}
