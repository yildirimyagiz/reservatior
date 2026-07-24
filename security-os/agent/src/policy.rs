use dashmap::DashMap;
use security_os_core::bus::EventBus;
use security_os_core::event::{ResponsePolicy, PolicyVersion};

use crate::errors::AgentError;

pub struct PolicyManager {
    current_version: Option<PolicyVersion>,
    bus: EventBus,
    policies: DashMap<String, ResponsePolicy>,
}

impl PolicyManager {
    pub fn new(bus: EventBus) -> Self {
        Self {
            current_version: None,
            bus,
            policies: DashMap::new(),
        }
    }

    pub fn apply_policy(&self, policy: ResponsePolicy) -> Result<(), AgentError> {
        let id = policy.id.clone();
        self.policies.insert(id.clone(), policy);
        tracing::info!("applied policy {}", id);
        Ok(())
    }

    pub fn remove_policy(&self, policy_id: &str) -> bool {
        let removed = self.policies.remove(policy_id).is_some();
        if removed {
            tracing::info!("removed policy {}", policy_id);
        }
        removed
    }

    pub fn current_version(&self) -> Option<&PolicyVersion> {
        self.current_version.as_ref()
    }

    pub fn active_policies(&self) -> Vec<ResponsePolicy> {
        self.policies.iter().map(|entry| entry.value().clone()).collect()
    }
}
