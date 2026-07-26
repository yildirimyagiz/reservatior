use chrono::{DateTime, Utc};
use dashmap::DashMap;
use std::collections::HashMap;

use crate::errors::FleetError;

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum AgentStatus {
    Enrolling,
    Online,
    Offline,
    Disabled,
    Error(String),
}

#[derive(Debug, Clone)]
pub struct AgentRecord {
    pub agent_id: String,
    pub hostname: String,
    pub ip: String,
    pub agent_version: String,
    pub os_type: String,
    pub os_version: String,
    pub enrolled_at: DateTime<Utc>,
    pub last_heartbeat: Option<DateTime<Utc>>,
    pub status: AgentStatus,
    pub tags: Vec<String>,
    pub group: Option<String>,
    pub certificate_fingerprint: Option<String>,
    pub policy_version: Option<String>,
    pub capabilities: Vec<String>,
}

#[derive(Debug, Clone, Default)]
pub struct FleetStats {
    pub total_agents: usize,
    pub online: usize,
    pub offline: usize,
    pub enrolling: usize,
    pub disabled: usize,
    pub error: usize,
    pub groups: HashMap<String, usize>,
    pub os_distribution: HashMap<String, usize>,
    pub version_distribution: HashMap<String, usize>,
}

pub struct AgentRegistry {
    agents: DashMap<String, AgentRecord>,
}

impl AgentRegistry {
    pub fn new() -> Self {
        Self {
            agents: DashMap::new(),
        }
    }

    pub fn register(&self, record: AgentRecord) -> Result<(), FleetError> {
        if self.agents.contains_key(&record.agent_id) {
            return Err(FleetError::AlreadyRegistered(record.agent_id));
        }
        self.agents.insert(record.agent_id.clone(), record);
        Ok(())
    }

    pub fn unregister(&self, agent_id: &str) -> bool {
        self.agents.remove(agent_id).is_some()
    }

    pub fn get(&self, agent_id: &str) -> Option<AgentRecord> {
        self.agents.get(agent_id).map(|r| r.clone())
    }

    pub fn list_all(&self) -> Vec<AgentRecord> {
        self.agents.iter().map(|r| r.value().clone()).collect()
    }

    pub fn list_by_group(&self, group: &str) -> Vec<AgentRecord> {
        self.agents
            .iter()
            .filter(|r| r.value().group.as_deref() == Some(group))
            .map(|r| r.value().clone())
            .collect()
    }

    pub fn list_by_tag(&self, tag: &str) -> Vec<AgentRecord> {
        self.agents
            .iter()
            .filter(|r| r.value().tags.iter().any(|t| t == tag))
            .map(|r| r.value().clone())
            .collect()
    }

    pub fn list_by_status(&self, status: &AgentStatus) -> Vec<AgentRecord> {
        self.agents
            .iter()
            .filter(|r| &r.value().status == status)
            .map(|r| r.value().clone())
            .collect()
    }

    pub fn update_status(&self, agent_id: &str, status: AgentStatus) -> bool {
        if let Some(mut record) = self.agents.get_mut(agent_id) {
            record.status = status;
            true
        } else {
            false
        }
    }

    pub fn add_tag(&self, agent_id: &str, tag: &str) -> bool {
        if let Some(mut record) = self.agents.get_mut(agent_id) {
            if !record.tags.iter().any(|t| t == tag) {
                record.tags.push(tag.to_string());
            }
            true
        } else {
            false
        }
    }

    pub fn remove_tag(&self, agent_id: &str, tag: &str) -> bool {
        if let Some(mut record) = self.agents.get_mut(agent_id) {
            record.tags.retain(|t| t != tag);
            true
        } else {
            false
        }
    }

    pub fn set_group(&self, agent_id: &str, group: &str) -> bool {
        if let Some(mut record) = self.agents.get_mut(agent_id) {
            record.group = Some(group.to_string());
            true
        } else {
            false
        }
    }

    pub fn stats(&self) -> FleetStats {
        let mut stats = FleetStats::default();
        for entry in self.agents.iter() {
            let record = entry.value();
            stats.total_agents += 1;
            match &record.status {
                AgentStatus::Online => stats.online += 1,
                AgentStatus::Offline => stats.offline += 1,
                AgentStatus::Enrolling => stats.enrolling += 1,
                AgentStatus::Disabled => stats.disabled += 1,
                AgentStatus::Error(_) => stats.error += 1,
            }
            if let Some(ref group) = record.group {
                *stats.groups.entry(group.clone()).or_insert(0) += 1;
            }
            *stats
                .os_distribution
                .entry(record.os_type.clone())
                .or_insert(0) += 1;
            *stats
                .version_distribution
                .entry(record.agent_version.clone())
                .or_insert(0) += 1;
        }
        stats
    }

    pub fn count(&self) -> usize {
        self.agents.len()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn make_record(agent_id: &str) -> AgentRecord {
        AgentRecord {
            agent_id: agent_id.to_string(),
            hostname: format!("host-{}", agent_id),
            ip: "10.0.0.1".to_string(),
            agent_version: "1.0.0".to_string(),
            os_type: "linux".to_string(),
            os_version: "6.1.0".to_string(),
            enrolled_at: Utc::now(),
            last_heartbeat: None,
            status: AgentStatus::Enrolling,
            tags: Vec::new(),
            group: None,
            certificate_fingerprint: None,
            policy_version: None,
            capabilities: Vec::new(),
        }
    }

    #[test]
    fn test_register_and_get() {
        let registry = AgentRegistry::new();
        let record = make_record("a1");
        registry.register(record).unwrap();
        let got = registry.get("a1").unwrap();
        assert_eq!(got.agent_id, "a1");
        assert_eq!(got.hostname, "host-a1");
    }

    #[test]
    fn test_register_duplicate_fails() {
        let registry = AgentRegistry::new();
        registry.register(make_record("a1")).unwrap();
        let result = registry.register(make_record("a1"));
        assert!(result.is_err());
    }

    #[test]
    fn test_list_all() {
        let registry = AgentRegistry::new();
        registry.register(make_record("a1")).unwrap();
        registry.register(make_record("a2")).unwrap();
        registry.register(make_record("a3")).unwrap();
        let all = registry.list_all();
        assert_eq!(all.len(), 3);
    }

    #[test]
    fn test_list_by_group() {
        let registry = AgentRegistry::new();
        let mut r1 = make_record("a1");
        r1.group = Some("web".to_string());
        registry.register(r1).unwrap();
        let mut r2 = make_record("a2");
        r2.group = Some("db".to_string());
        registry.register(r2).unwrap();
        let mut r3 = make_record("a3");
        r3.group = Some("web".to_string());
        registry.register(r3).unwrap();

        let web = registry.list_by_group("web");
        assert_eq!(web.len(), 2);
        let db = registry.list_by_group("db");
        assert_eq!(db.len(), 1);
    }

    #[test]
    fn test_list_by_status() {
        let registry = AgentRegistry::new();
        let mut r1 = make_record("a1");
        r1.status = AgentStatus::Online;
        registry.register(r1).unwrap();
        let mut r2 = make_record("a2");
        r2.status = AgentStatus::Offline;
        registry.register(r2).unwrap();

        let online = registry.list_by_status(&AgentStatus::Online);
        assert_eq!(online.len(), 1);
        assert_eq!(online[0].agent_id, "a1");
    }

    #[test]
    fn test_update_status() {
        let registry = AgentRegistry::new();
        registry.register(make_record("a1")).unwrap();
        assert!(registry.update_status("a1", AgentStatus::Online));
        let got = registry.get("a1").unwrap();
        assert_eq!(got.status, AgentStatus::Online);

        assert!(!registry.update_status("nonexistent", AgentStatus::Online));
    }

    #[test]
    fn test_add_tag() {
        let registry = AgentRegistry::new();
        registry.register(make_record("a1")).unwrap();
        assert!(registry.add_tag("a1", "production"));
        assert!(registry.add_tag("a1", "critical"));
        assert!(registry.add_tag("a1", "production"));
        let got = registry.get("a1").unwrap();
        assert_eq!(got.tags.len(), 2);

        let by_tag = registry.list_by_tag("production");
        assert_eq!(by_tag.len(), 1);
    }

    #[test]
    fn test_stats() {
        let registry = AgentRegistry::new();
        let mut r1 = make_record("a1");
        r1.status = AgentStatus::Online;
        r1.group = Some("web".to_string());
        r1.os_type = "linux".to_string();
        registry.register(r1).unwrap();

        let mut r2 = make_record("a2");
        r2.status = AgentStatus::Offline;
        r2.group = Some("web".to_string());
        r2.os_type = "windows".to_string();
        registry.register(r2).unwrap();

        let mut r3 = make_record("a3");
        r3.status = AgentStatus::Error("crash".to_string());
        r3.group = None;
        r3.os_type = "linux".to_string();
        registry.register(r3).unwrap();

        let stats = registry.stats();
        assert_eq!(stats.total_agents, 3);
        assert_eq!(stats.online, 1);
        assert_eq!(stats.offline, 1);
        assert_eq!(stats.error, 1);
        assert_eq!(*stats.groups.get("web").unwrap(), 2);
        assert_eq!(*stats.os_distribution.get("linux").unwrap(), 2);
        assert_eq!(*stats.os_distribution.get("windows").unwrap(), 1);
    }
}
