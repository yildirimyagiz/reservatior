use dashmap::DashMap;

use security_os_core::ResponsePolicy;

#[derive(Debug)]
pub struct RegionPolicyManager {
    global_policies: DashMap<String, ResponsePolicy>,
    region_policies: DashMap<String, DashMap<String, ResponsePolicy>>,
}

impl RegionPolicyManager {
    pub fn new() -> Self {
        Self {
            global_policies: DashMap::new(),
            region_policies: DashMap::new(),
        }
    }

    pub fn set_global_policy(&self, policy: ResponsePolicy) {
        self.global_policies
            .insert(policy.id.clone(), policy);
    }

    pub fn set_region_policy(&self, region: &str, policy: ResponsePolicy) {
        let region_map = self
            .region_policies
            .entry(region.to_string())
            .or_insert_with(DashMap::new);
        region_map.insert(policy.id.clone(), policy);
    }

    pub fn get_effective_policies(&self, region: &str) -> Vec<ResponsePolicy> {
        let mut policies: Vec<ResponsePolicy> = self
            .global_policies
            .iter()
            .filter(|p| p.value().enabled)
            .map(|p| p.value().clone())
            .collect();

        if let Some(region_map) = self.region_policies.get(region) {
            let region_pols: Vec<ResponsePolicy> = region_map
                .iter()
                .filter(|p| p.value().enabled)
                .map(|p| p.value().clone())
                .collect();
            policies.extend(region_pols);
        }

        policies
    }

    pub fn remove_region_policy(&self, region: &str, policy_id: &str) -> bool {
        match self.region_policies.get(region) {
            Some(region_map) => region_map.remove(policy_id).is_some(),
            None => false,
        }
    }

    pub fn remove_global_policy(&self, policy_id: &str) -> bool {
        self.global_policies.remove(policy_id).is_some()
    }

    pub fn regions_with_policies(&self) -> Vec<String> {
        self.region_policies
            .iter()
            .filter(|entry| !entry.value().is_empty())
            .map(|entry| entry.key().clone())
            .collect()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{ResponseAction, ResponseCondition, Severity};

    fn make_policy(id: &str, name: &str) -> ResponsePolicy {
        ResponsePolicy {
            id: id.to_string(),
            name: name.to_string(),
            enabled: true,
            conditions: vec![ResponseCondition::RiskAbove(50.0)],
            actions: vec![ResponseAction::Notify {
                channel: "default".to_string(),
                message: "test".to_string(),
                severity: Severity::Medium,
            }],
            cooldown_secs: 300,
            auto_response_enabled: false,
        }
    }

    #[test]
    fn test_global_policy() {
        let mgr = RegionPolicyManager::new();
        let policy = make_policy("gp-1", "Global Policy");
        mgr.set_global_policy(policy);

        let policies = mgr.get_effective_policies("us-east-1");
        assert_eq!(policies.len(), 1);
        assert_eq!(policies[0].id, "gp-1");
    }

    #[test]
    fn test_region_policy() {
        let mgr = RegionPolicyManager::new();
        let policy = make_policy("rp-1", "Region Policy");
        mgr.set_region_policy("eu-west-1", policy);

        let policies = mgr.get_effective_policies("eu-west-1");
        assert_eq!(policies.len(), 1);
        assert_eq!(policies[0].id, "rp-1");
    }

    #[test]
    fn test_effective_policies_combines_global_and_region() {
        let mgr = RegionPolicyManager::new();
        mgr.set_global_policy(make_policy("gp-1", "Global"));
        mgr.set_region_policy("us-west-2", make_policy("rp-1", "US West"));

        let policies = mgr.get_effective_policies("us-west-2");
        assert_eq!(policies.len(), 2);
        let ids: Vec<&str> = policies.iter().map(|p| p.id.as_str()).collect();
        assert!(ids.contains(&"gp-1"));
        assert!(ids.contains(&"rp-1"));
    }

    #[test]
    fn test_remove_policies() {
        let mgr = RegionPolicyManager::new();
        mgr.set_global_policy(make_policy("gp-1", "Global"));
        mgr.set_region_policy("ap-south-1", make_policy("rp-1", "AP"));

        assert!(mgr.remove_global_policy("gp-1"));
        assert!(!mgr.remove_global_policy("gp-1"));
        assert_eq!(mgr.get_effective_policies("ap-south-1").len(), 1);

        assert!(mgr.remove_region_policy("ap-south-1", "rp-1"));
        assert!(!mgr.remove_region_policy("ap-south-1", "rp-1"));
        assert_eq!(mgr.get_effective_policies("ap-south-1").len(), 0);
    }

    #[test]
    fn test_regions_with_policies() {
        let mgr = RegionPolicyManager::new();
        mgr.set_region_policy("us-east-1", make_policy("p1", "P1"));
        mgr.set_region_policy("eu-west-1", make_policy("p2", "P2"));
        mgr.set_region_policy("us-east-1", make_policy("p3", "P3"));

        let mut regions = mgr.regions_with_policies();
        regions.sort();
        assert_eq!(regions, vec!["eu-west-1", "us-east-1"]);
    }
}
