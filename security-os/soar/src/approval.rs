use chrono::{DateTime, Duration, Utc};
use dashmap::DashMap;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

use crate::errors::SoarError;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ApprovalRequest {
    pub request_id: String,
    pub execution_id: String,
    pub step_id: String,
    pub playbook_name: String,
    pub step_name: String,
    pub action_description: String,
    pub requested_at: DateTime<Utc>,
    pub timeout: Duration,
    pub status: ApprovalStatus,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub enum ApprovalStatus {
    Pending,
    Approved(String),
    Rejected(String, String),
    Expired,
}

pub struct ApprovalManager {
    pending: DashMap<String, ApprovalRequest>,
}

impl ApprovalManager {
    pub fn new() -> Self {
        Self {
            pending: DashMap::new(),
        }
    }

    pub fn request_approval(&self, request: ApprovalRequest) -> Result<(), SoarError> {
        let request_id = request.request_id.clone();
        tracing::info!(
            request_id = %request_id,
            execution_id = %request.execution_id,
            step = %request.step_name,
            action = %request.action_description,
            "Approval requested"
        );
        self.pending.insert(request_id, request);
        Ok(())
    }

    pub fn approve(&self, request_id: &str, approver: &str) -> Result<(), SoarError> {
        self.pending
            .get_mut(request_id)
            .ok_or_else(|| SoarError::ApprovalRequired(format!(
                "Approval request {} not found",
                request_id
            )))
            .map(|mut req| {
                req.status = ApprovalStatus::Approved(approver.to_string());
                tracing::info!(
                    request_id = %request_id,
                    approver = %approver,
                    "Approval granted"
                );
            })
    }

    pub fn reject(
        &self,
        request_id: &str,
        approver: &str,
        reason: &str,
    ) -> Result<(), SoarError> {
        self.pending
            .get_mut(request_id)
            .ok_or_else(|| SoarError::ApprovalRequired(format!(
                "Approval request {} not found",
                request_id
            )))
            .map(|mut req| {
                req.status = ApprovalStatus::Rejected(
                    approver.to_string(),
                    reason.to_string(),
                );
                tracing::info!(
                    request_id = %request_id,
                    approver = %approver,
                    reason = %reason,
                    "Approval rejected"
                );
            })
    }

    pub fn get_pending(&self) -> Vec<ApprovalRequest> {
        self.pending
            .iter()
            .filter(|r| r.status == ApprovalStatus::Pending)
            .map(|r| r.value().clone())
            .collect()
    }

    pub fn is_approved(&self, request_id: &str) -> bool {
        self.pending
            .get(request_id)
            .map(|r| matches!(r.status, ApprovalStatus::Approved(_)))
            .unwrap_or(false)
    }

    pub fn check_timeouts(&self) -> Vec<String> {
        let now = Utc::now();
        let mut timed_out = Vec::new();

        for mut entry in self.pending.iter_mut() {
            if entry.status == ApprovalStatus::Pending {
                let elapsed = now - entry.requested_at;
                if elapsed > entry.timeout {
                    entry.status = ApprovalStatus::Expired;
                    timed_out.push(entry.request_id.clone());
                    tracing::warn!(
                        request_id = %entry.request_id,
                        "Approval request timed out"
                    );
                }
            }
        }

        timed_out
    }

    pub fn create_request(
        execution_id: &str,
        step_id: &str,
        playbook_name: &str,
        step_name: &str,
        action_description: &str,
        timeout_secs: u64,
    ) -> ApprovalRequest {
        ApprovalRequest {
            request_id: Uuid::new_v4().to_string(),
            execution_id: execution_id.to_string(),
            step_id: step_id.to_string(),
            playbook_name: playbook_name.to_string(),
            step_name: step_name.to_string(),
            action_description: action_description.to_string(),
            requested_at: Utc::now(),
            timeout: Duration::seconds(timeout_secs as i64),
            status: ApprovalStatus::Pending,
        }
    }
}

impl Default for ApprovalManager {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn make_test_request(execution_id: &str) -> ApprovalRequest {
        ApprovalManager::create_request(
            execution_id,
            "step-1",
            "Test Playbook",
            "Block Malicious IP",
            "Block IP 10.0.0.1 for 3600 seconds",
            300,
        )
    }

    #[test]
    fn test_request_approval() {
        let manager = ApprovalManager::new();
        let request = make_test_request("exec-1");
        let request_id = request.request_id.clone();
        manager.request_approval(request).unwrap();
        assert!(manager.is_approved(&request_id) == false);
        assert_eq!(manager.get_pending().len(), 1);
    }

    #[test]
    fn test_approve_request() {
        let manager = ApprovalManager::new();
        let request = make_test_request("exec-1");
        let request_id = request.request_id.clone();
        manager.request_approval(request).unwrap();
        manager.approve(&request_id, "soc-analyst-1").unwrap();
        assert!(manager.is_approved(&request_id));
        assert_eq!(manager.get_pending().len(), 0);
    }

    #[test]
    fn test_reject_request() {
        let manager = ApprovalManager::new();
        let request = make_test_request("exec-1");
        let request_id = request.request_id.clone();
        manager.request_approval(request).unwrap();
        manager
            .reject(&request_id, "soc-analyst-1", "Too aggressive")
            .unwrap();
        assert!(!manager.is_approved(&request_id));
        assert_eq!(manager.get_pending().len(), 0);
    }

    #[test]
    fn test_check_timeouts() {
        let manager = ApprovalManager::new();
        let mut request = make_test_request("exec-1");
        request.timeout = Duration::seconds(-1);
        let request_id = request.request_id.clone();
        manager.request_approval(request).unwrap();
        let timed_out = manager.check_timeouts();
        assert_eq!(timed_out.len(), 1);
        assert_eq!(timed_out[0], request_id);
    }
}
