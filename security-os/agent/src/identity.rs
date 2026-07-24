use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use sha2::{Digest, Sha256};
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CertInfo {
    pub subject: String,
    pub issuer: String,
    pub not_before: DateTime<Utc>,
    pub not_after: DateTime<Utc>,
    pub serial: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AgentIdentity {
    pub agent_id: String,
    pub hostname: String,
    pub enrolled_at: Option<DateTime<Utc>>,
    pub certificate_pem: Option<String>,
    pub private_key_pem: Option<String>,
    pub ca_certificate_pem: Option<String>,
    pub fingerprint: String,
}

impl AgentIdentity {
    pub fn generate(hostname: &str) -> Self {
        let agent_id = Uuid::new_v4().to_string();
        let fingerprint = Self::fingerprint(&agent_id, hostname);
        Self {
            agent_id,
            hostname: hostname.to_string(),
            enrolled_at: None,
            certificate_pem: None,
            private_key_pem: None,
            ca_certificate_pem: None,
            fingerprint,
        }
    }

    pub fn fingerprint(agent_id: &str, hostname: &str) -> String {
        let mut hasher = Sha256::new();
        hasher.update(agent_id.as_bytes());
        hasher.update(hostname.as_bytes());
        hex::encode(hasher.finalize())
    }

    pub fn is_enrolled(&self) -> bool {
        self.enrolled_at.is_some() && self.certificate_pem.is_some()
    }

    pub fn certificate_info(&self) -> Option<CertInfo> {
        self.certificate_pem.as_ref()?;
        Some(CertInfo {
            subject: format!("CN={}", self.agent_id),
            issuer: "Security OS CA".to_string(),
            not_before: self.enrolled_at.unwrap_or_else(Utc::now),
            not_after: Utc::now() + chrono::Duration::days(365),
            serial: format!("{:x}", md5_hash(&self.agent_id)),
        })
    }
}

fn md5_hash(input: &str) -> u64 {
    let mut hasher = Sha256::new();
    hasher.update(input.as_bytes());
    let result = hasher.finalize();
    u64::from_be_bytes(result[..8].try_into().unwrap())
}
