use chrono::{DateTime, Duration, Utc};
use dashmap::DashMap;

use crate::errors::FleetError;

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum EnrollmentStatus {
    Pending,
    Approved,
    Rejected { reason: String },
    CertificateIssued {
        cert_pem: String,
        expires_at: DateTime<Utc>,
    },
}

#[derive(Debug, Clone)]
pub struct EnrollmentRequest {
    pub agent_id: String,
    pub hostname: String,
    pub ip: String,
    pub csr: String,
    pub requested_at: DateTime<Utc>,
    pub status: EnrollmentStatus,
}

#[derive(Debug, Clone)]
pub struct EnrollmentResponse {
    pub agent_id: String,
    pub certificate_pem: String,
    pub ca_certificate_pem: String,
    pub expires_at: DateTime<Utc>,
}

pub struct EnrollmentManager {
    pending: DashMap<String, EnrollmentRequest>,
    ca_cert: Option<String>,
    #[allow(dead_code)]
    ca_key: Option<String>,
}

impl EnrollmentManager {
    pub fn new() -> Self {
        Self {
            pending: DashMap::new(),
            ca_cert: None,
            ca_key: None,
        }
    }

    pub fn with_ca(ca_cert: String, ca_key: String) -> Self {
        Self {
            pending: DashMap::new(),
            ca_cert: Some(ca_cert),
            ca_key: Some(ca_key),
        }
    }

    pub fn request_enrollment(&self, request: EnrollmentRequest) -> Result<(), FleetError> {
        if self.pending.contains_key(&request.agent_id) {
            return Err(FleetError::AlreadyRegistered(request.agent_id));
        }
        self.pending.insert(request.agent_id.clone(), request);
        Ok(())
    }

    pub fn approve_enrollment(
        &self,
        agent_id: &str,
    ) -> Result<EnrollmentResponse, FleetError> {
        let mut entry = self
            .pending
            .get_mut(agent_id)
            .ok_or_else(|| FleetError::NotFound(agent_id.to_string()))?;

        if entry.status != EnrollmentStatus::Pending {
            return Err(FleetError::AlreadyProcessed(agent_id.to_string()));
        }

        let ca_cert_pem = self
            .ca_cert
            .clone()
            .ok_or_else(|| FleetError::NoCaConfigured)?;

        let expires_at = Utc::now() + Duration::days(365);
        let cert_pem = format!(
            "CERTIFICATE:agent_id={};expires={}",
            agent_id,
            expires_at.to_rfc3339()
        );

        entry.status = EnrollmentStatus::CertificateIssued {
            cert_pem: cert_pem.clone(),
            expires_at,
        };

        Ok(EnrollmentResponse {
            agent_id: agent_id.to_string(),
            certificate_pem: cert_pem,
            ca_certificate_pem: ca_cert_pem,
            expires_at,
        })
    }

    pub fn reject_enrollment(
        &self,
        agent_id: &str,
        reason: &str,
    ) -> Result<(), FleetError> {
        let mut entry = self
            .pending
            .get_mut(agent_id)
            .ok_or_else(|| FleetError::NotFound(agent_id.to_string()))?;

        if entry.status != EnrollmentStatus::Pending {
            return Err(FleetError::AlreadyProcessed(agent_id.to_string()));
        }

        entry.status = EnrollmentStatus::Rejected {
            reason: reason.to_string(),
        };

        Err(FleetError::EnrollmentRejected(reason.to_string()))
    }

    pub fn get_pending(&self) -> Vec<EnrollmentRequest> {
        self.pending
            .iter()
            .filter(|r| r.value().status == EnrollmentStatus::Pending)
            .map(|r| r.value().clone())
            .collect()
    }

    pub fn is_enrolled(&self, agent_id: &str) -> bool {
        self.pending
            .get(agent_id)
            .map(|r| matches!(r.status, EnrollmentStatus::CertificateIssued { .. }))
            .unwrap_or(false)
    }

    pub fn auto_approve(
        &self,
        agent_id: &str,
    ) -> Result<EnrollmentResponse, FleetError> {
        self.approve_enrollment(agent_id)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn make_request(agent_id: &str) -> EnrollmentRequest {
        EnrollmentRequest {
            agent_id: agent_id.to_string(),
            hostname: format!("host-{}", agent_id),
            ip: "10.0.0.1".to_string(),
            csr: "BEGIN CERTIFICATE REQUEST...".to_string(),
            requested_at: Utc::now(),
            status: EnrollmentStatus::Pending,
        }
    }

    #[test]
    fn test_request_enrollment() {
        let mgr = EnrollmentManager::new();
        let req = make_request("a1");
        mgr.request_enrollment(req).unwrap();
        let pending = mgr.get_pending();
        assert_eq!(pending.len(), 1);
        assert_eq!(pending[0].agent_id, "a1");
    }

    #[test]
    fn test_approve_enrollment() {
        let mgr =
            EnrollmentManager::with_ca("ca-cert".to_string(), "ca-key".to_string());
        mgr.request_enrollment(make_request("a1")).unwrap();
        let resp = mgr.approve_enrollment("a1").unwrap();
        assert_eq!(resp.agent_id, "a1");
        assert!(!resp.certificate_pem.is_empty());
        assert_eq!(resp.ca_certificate_pem, "ca-cert");
        assert!(mgr.is_enrolled("a1"));
    }

    #[test]
    fn test_reject_enrollment() {
        let mgr = EnrollmentManager::new();
        mgr.request_enrollment(make_request("a1")).unwrap();
        let result = mgr.reject_enrollment("a1", "unauthorized host");
        assert!(result.is_err());
        let pending = mgr.get_pending();
        assert!(pending.is_empty());
    }

    #[test]
    fn test_auto_approve() {
        let mgr =
            EnrollmentManager::with_ca("ca-cert".to_string(), "ca-key".to_string());
        mgr.request_enrollment(make_request("a1")).unwrap();
        let resp = mgr.auto_approve("a1").unwrap();
        assert_eq!(resp.agent_id, "a1");
        assert!(mgr.is_enrolled("a1"));
    }

    #[test]
    fn test_is_enrolled_not_found() {
        let mgr = EnrollmentManager::new();
        assert!(!mgr.is_enrolled("nonexistent"));
    }
}
