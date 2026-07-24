use chrono::{DateTime, Utc};
use dashmap::DashMap;

#[derive(Debug, Clone)]
pub struct UserProfile {
    pub user_id: String,
    pub username: String,
    pub login_patterns: LoginPatterns,
    pub known_ips: Vec<String>,
    pub known_devices: Vec<String>,
    pub normal_hours: Vec<u8>,
    pub risk_score: f64,
    pub anomaly_count: u32,
    pub last_login: Option<DateTime<Utc>>,
}

#[derive(Debug, Clone)]
pub struct LoginPatterns {
    pub avg_logins_per_day: f64,
    pub typical_auth_method: String,
    pub mfa_enabled: bool,
    pub failed_attempts: u32,
    pub last_failed: Option<DateTime<Utc>>,
}

pub struct UserMemory {
    users: DashMap<String, UserProfile>,
}

impl UserMemory {
    pub fn new() -> Self {
        Self {
            users: DashMap::new(),
        }
    }

    pub fn record_login(
        &self,
        user_id: &str,
        username: &str,
        ip: &str,
        method: &str,
        success: bool,
    ) {
        let now = Utc::now();
        let mut entry = self
            .users
            .entry(user_id.to_string())
            .or_insert_with(|| UserProfile {
                user_id: user_id.to_string(),
                username: username.to_string(),
                login_patterns: LoginPatterns {
                    avg_logins_per_day: 0.0,
                    typical_auth_method: method.to_string(),
                    mfa_enabled: false,
                    failed_attempts: 0,
                    last_failed: None,
                },
                known_ips: Vec::new(),
                known_devices: Vec::new(),
                normal_hours: Vec::new(),
                risk_score: 0.0,
                anomaly_count: 0,
                last_login: None,
            });

        if success {
            entry.last_login = Some(now);

            let hour = now.format("%H").to_string().parse::<u8>().unwrap_or(0);
            if !entry.normal_hours.contains(&hour) {
                entry.normal_hours.push(hour);
                entry.normal_hours.sort();
            }

            if !entry.known_ips.contains(&ip.to_string()) {
                entry.known_ips.push(ip.to_string());
            }
        } else {
            entry.login_patterns.failed_attempts += 1;
            entry.login_patterns.last_failed = Some(now);
            entry.risk_score = (entry.risk_score + 5.0).min(100.0);
        }
    }

    pub fn get_profile(&self, user_id: &str) -> Option<UserProfile> {
        self.users.get(user_id).map(|p| p.clone())
    }

    pub fn is_known_ip(&self, user_id: &str, ip: &str) -> bool {
        self.users
            .get(user_id)
            .map(|p| p.known_ips.contains(&ip.to_string()))
            .unwrap_or(false)
    }

    pub fn get_anomalous_users(&self) -> Vec<UserProfile> {
        self.users
            .iter()
            .filter(|p| p.risk_score > 50.0 || p.anomaly_count > 3)
            .map(|p| p.clone())
            .collect()
    }

    pub fn record_anomaly(&self, user_id: &str) {
        if let Some(mut profile) = self.users.get_mut(user_id) {
            profile.anomaly_count += 1;
            profile.risk_score = (profile.risk_score + 10.0).min(100.0);
        }
    }

    pub fn record_risk(&self, user_id: &str, risk_score: f64) {
        if let Some(mut profile) = self.users.get_mut(user_id) {
            profile.risk_score = risk_score.clamp(0.0, 100.0);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_record_login() {
        let memory = UserMemory::new();
        memory.record_login("u-1", "alice", "10.0.0.1", "password", true);

        let profile = memory.get_profile("u-1").expect("user should exist");
        assert_eq!(profile.username, "alice");
        assert!(profile.last_login.is_some());
        assert!(profile.known_ips.contains(&"10.0.0.1".to_string()));
        assert!(profile.normal_hours.len() > 0);
    }

    #[test]
    fn test_get_profile() {
        let memory = UserMemory::new();
        memory.record_login("u-1", "alice", "10.0.0.1", "password", true);

        let profile = memory.get_profile("u-1");
        assert!(profile.is_some());
        assert_eq!(profile.unwrap().user_id, "u-1");
    }

    #[test]
    fn test_is_known_ip() {
        let memory = UserMemory::new();
        memory.record_login("u-1", "alice", "10.0.0.1", "password", true);

        assert!(memory.is_known_ip("u-1", "10.0.0.1"));
        assert!(!memory.is_known_ip("u-1", "192.168.1.1"));
        assert!(!memory.is_known_ip("unknown", "10.0.0.1"));
    }

    #[test]
    fn test_anomalous_users() {
        let memory = UserMemory::new();
        memory.record_login("u-1", "alice", "10.0.0.1", "password", true);
        memory.record_login("u-2", "bob", "10.0.0.2", "password", true);

        memory.record_anomaly("u-2");
        memory.record_anomaly("u-2");
        memory.record_anomaly("u-2");
        memory.record_anomaly("u-2");

        let anomalous = memory.get_anomalous_users();
        assert_eq!(anomalous.len(), 1);
        assert_eq!(anomalous[0].user_id, "u-2");
    }

    #[test]
    fn test_record_anomaly() {
        let memory = UserMemory::new();
        memory.record_login("u-1", "alice", "10.0.0.1", "password", true);
        memory.record_anomaly("u-1");

        let profile = memory.get_profile("u-1").unwrap();
        assert_eq!(profile.anomaly_count, 1);
        assert!(profile.risk_score > 0.0);
    }
}
