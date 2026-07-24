use serde::{Deserialize, Serialize};
use std::path::Path;

use crate::errors::AgentError;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AgentConfig {
    pub agent_id: Option<String>,
    pub hostname: String,
    pub server_url: String,
    pub heartbeat_interval_secs: u64,
    pub event_buffer_size: usize,
    pub collectors: Vec<String>,
    pub tls: TlsConfig,
    pub tenant_id: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TlsConfig {
    pub cert_path: Option<String>,
    pub key_path: Option<String>,
    pub ca_path: Option<String>,
    pub verify_server: bool,
}

impl Default for TlsConfig {
    fn default() -> Self {
        Self {
            cert_path: None,
            key_path: None,
            ca_path: None,
            verify_server: true,
        }
    }
}

impl AgentConfig {
    pub fn defaults() -> Self {
        let hostname = hostname::get()
            .map(|h| h.to_string_lossy().into_owned())
            .unwrap_or_else(|_| "unknown".to_string());

        Self {
            agent_id: None,
            hostname,
            server_url: "https://security-os.local:8443".to_string(),
            heartbeat_interval_secs: 30,
            event_buffer_size: 10_000,
            collectors: vec![
                "process".to_string(),
                "network".to_string(),
                "file".to_string(),
            ],
            tls: TlsConfig::default(),
            tenant_id: None,
        }
    }

    pub fn load_from_file(path: impl AsRef<Path>) -> Result<Self, AgentError> {
        let content = std::fs::read_to_string(path.as_ref())
            .map_err(|e| AgentError::ConfigError(format!("failed to read {}: {}", path.as_ref().display(), e)))?;
        let config: Self = toml::from_str(&content)
            .map_err(|e| AgentError::ConfigError(format!("failed to parse {}: {}", path.as_ref().display(), e)))?;
        config.validate()?;
        Ok(config)
    }

    pub fn validate(&self) -> Result<(), AgentError> {
        if self.server_url.is_empty() {
            return Err(AgentError::ConfigError(
                "server_url must not be empty".to_string(),
            ));
        }
        if self.heartbeat_interval_secs == 0 {
            return Err(AgentError::ConfigError(
                "heartbeat_interval_secs must be > 0".to_string(),
            ));
        }
        if self.event_buffer_size == 0 {
            return Err(AgentError::ConfigError(
                "event_buffer_size must be > 0".to_string(),
            ));
        }
        Ok(())
    }
}
