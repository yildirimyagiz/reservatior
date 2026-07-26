use chrono::{DateTime, Utc};
use dashmap::DashMap;

use crate::errors::FleetError;

#[derive(Debug, Clone)]
pub struct PolicyRecord {
    pub policy_id: String,
    pub name: String,
    pub version: u64,
    pub policy_data: serde_json::Value,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    pub target_groups: Vec<String>,
    pub target_agents: Vec<String>,
}

#[derive(Debug, Clone)]
pub struct PolicyDeployment {
    pub policy_id: String,
    pub agent_id: String,
    pub deployed_at: DateTime<Utc>,
    pub status: DeploymentStatus,
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum DeploymentStatus {
    Pending,
    Applied,
    Failed(String),
}

pub struct PolicyDistributor {
    policies: DashMap<String, PolicyRecord>,
    agent_policies: DashMap<String, Vec<String>>,
}

impl PolicyDistributor {
    pub fn new() -> Self {
        Self {
            policies: DashMap::new(),
            agent_policies: DashMap::new(),
        }
    }

    pub fn deploy_policy(&self, record: PolicyRecord) -> Result<(), FleetError> {
        let policy_id = record.policy_id.clone();

        for agent_id in &record.target_agents {
            self.agent_policies
                .entry(agent_id.clone())
                .or_insert_with(Vec::new);
            if let Some(mut policies) = self.agent_policies.get_mut(agent_id) {
                if !policies.contains(&policy_id) {
                    policies.push(policy_id.clone());
                }
            }
        }

        self.policies.insert(policy_id, record);
        Ok(())
    }

    pub fn get_policy(&self, policy_id: &str) -> Option<PolicyRecord> {
        self.policies.get(policy_id).map(|r| r.value().clone())
    }

    pub fn agent_policies(&self, agent_id: &str) -> Vec<PolicyRecord> {
        self.agent_policies
            .get(agent_id)
            .map(|entry| {
                entry
                    .value()
                    .iter()
                    .filter_map(|pid| self.policies.get(pid).map(|p| p.value().clone()))
                    .collect()
            })
            .unwrap_or_default()
    }

    pub fn update_policy(
        &self,
        policy_id: &str,
        data: serde_json::Value,
    ) -> Result<(), FleetError> {
        let mut policy = self
            .policies
            .get_mut(policy_id)
            .ok_or_else(|| FleetError::PolicyNotFound(policy_id.to_string()))?;

        policy.policy_data = data;
        policy.updated_at = Utc::now();
        policy.version += 1;
        Ok(())
    }

    pub fn remove_policy(&self, policy_id: &str) -> bool {
        if self.policies.remove(policy_id).is_none() {
            return false;
        }

        for mut entry in self.agent_policies.iter_mut() {
            entry.value_mut().retain(|pid| pid != policy_id);
        }

        true
    }

    pub fn list_policies(&self) -> Vec<PolicyRecord> {
        self.policies.iter().map(|r| r.value().clone()).collect()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn make_policy(policy_id: &str) -> PolicyRecord {
        PolicyRecord {
            policy_id: policy_id.to_string(),
            name: format!("Policy {}", policy_id),
            version: 1,
            policy_data: serde_json::json!({"rules": []}),
            created_at: Utc::now(),
            updated_at: Utc::now(),
            target_groups: Vec::new(),
            target_agents: vec!["a1".to_string(), "a2".to_string()],
        }
    }

    #[test]
    fn test_deploy_and_get() {
        let dist = PolicyDistributor::new();
        let policy = make_policy("p1");
        dist.deploy_policy(policy).unwrap();
        let got = dist.get_policy("p1").unwrap();
        assert_eq!(got.policy_id, "p1");
        assert_eq!(got.name, "Policy p1");
    }

    #[test]
    fn test_agent_policies() {
        let dist = PolicyDistributor::new();
        dist.deploy_policy(make_policy("p1")).unwrap();
        dist.deploy_policy(make_policy("p2")).unwrap();

        let a1_policies = dist.agent_policies("a1");
        assert_eq!(a1_policies.len(), 2);

        let a3_policies = dist.agent_policies("a3");
        assert!(a3_policies.is_empty());
    }

    #[test]
    fn test_update_policy() {
        let dist = PolicyDistributor::new();
        dist.deploy_policy(make_policy("p1")).unwrap();
        let new_data = serde_json::json!({"rules": [{"id": "r1"}]});
        dist.update_policy("p1", new_data.clone()).unwrap();
        let updated = dist.get_policy("p1").unwrap();
        assert_eq!(updated.version, 2);
        assert_eq!(updated.policy_data, new_data);
    }

    #[test]
    fn test_remove_policy() {
        let dist = PolicyDistributor::new();
        dist.deploy_policy(make_policy("p1")).unwrap();
        assert!(dist.remove_policy("p1"));
        assert!(dist.get_policy("p1").is_none());
        assert!(dist.agent_policies("a1").is_empty());
        assert!(!dist.remove_policy("nonexistent"));
    }
}
