use std::collections::HashMap;

use reqwest::Client;
use serde::{Deserialize, Serialize};
use security_os_core::SecurityEvent;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct HealthStatus {
    pub status: String,
    pub version: String,
    pub uptime_secs: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StatsResponse {
    pub total_events: u64,
    pub by_category: HashMap<String, u64>,
    pub by_severity: HashMap<String, u64>,
}

#[derive(Debug, thiserror::Error)]
pub enum SecurityOsClientError {
    #[error("HTTP error: {0}")]
    Http(#[from] reqwest::Error),

    #[error("Connection failed: {0}")]
    Connection(String),

    #[error("Request timeout")]
    Timeout,

    #[error("Serialization error: {0}")]
    Serialization(String),

    #[error("Server error ({status}): {message}")]
    Server { status: u16, message: String },

    #[error("Not found: {0}")]
    NotFound(String),

    #[error("SSE stream error: {0}")]
    StreamError(String),
}

pub type Result<T> = std::result::Result<T, SecurityOsClientError>;

pub struct SecurityOsClient {
    base_url: String,
    http: Client,
}

impl SecurityOsClient {
    pub fn new(base_url: String) -> Self {
        Self {
            base_url,
            http: Client::new(),
        }
    }

    pub async fn health_check(&self) -> Result<HealthStatus> {
        let url = format!("{}/api/health", self.base_url);
        let resp = self
            .http
            .get(&url)
            .send()
            .await
            .map_err(|e| {
                if e.is_timeout() {
                    SecurityOsClientError::Timeout
                } else if e.is_connect() {
                    SecurityOsClientError::Connection(e.to_string())
                } else {
                    SecurityOsClientError::Http(e)
                }
            })?;

        let status = resp.status();
        if !status.is_success() {
            let msg = resp.text().await.unwrap_or_default();
            return Err(SecurityOsClientError::Server {
                status: status.as_u16(),
                message: msg,
            });
        }

        let body: HealthStatus = resp.json().await.map_err(SecurityOsClientError::Http)?;
        Ok(body)
    }

    pub async fn get_events(
        &self,
        limit: Option<u32>,
        category: Option<String>,
    ) -> Result<Vec<SecurityEvent>> {
        let mut url = format!("{}/api/events", self.base_url);
        let mut params: Vec<String> = Vec::new();
        if let Some(l) = limit {
            params.push(format!("limit={}", l));
        }
        if let Some(c) = &category {
            params.push(format!("category={}", c));
        }
        if !params.is_empty() {
            url.push('?');
            url.push_str(&params.join("&"));
        }

        let resp = self.http.get(&url).send().await.map_err(|e| {
            if e.is_timeout() {
                SecurityOsClientError::Timeout
            } else if e.is_connect() {
                SecurityOsClientError::Connection(e.to_string())
            } else {
                SecurityOsClientError::Http(e)
            }
        })?;

        let status = resp.status();
        if !status.is_success() {
            let msg = resp.text().await.unwrap_or_default();
            return Err(SecurityOsClientError::Server {
                status: status.as_u16(),
                message: msg,
            });
        }

        let events: Vec<SecurityEvent> = resp.json().await.map_err(SecurityOsClientError::Http)?;
        Ok(events)
    }

    pub async fn get_event(&self, id: &str) -> Result<SecurityEvent> {
        let url = format!("{}/api/events/{}", self.base_url, id);
        let resp = self.http.get(&url).send().await.map_err(|e| {
            if e.is_timeout() {
                SecurityOsClientError::Timeout
            } else if e.is_connect() {
                SecurityOsClientError::Connection(e.to_string())
            } else {
                SecurityOsClientError::Http(e)
            }
        })?;

        let status = resp.status();
        if status == reqwest::StatusCode::NOT_FOUND {
            return Err(SecurityOsClientError::NotFound(format!(
                "Event {} not found",
                id
            )));
        }
        if !status.is_success() {
            let msg = resp.text().await.unwrap_or_default();
            return Err(SecurityOsClientError::Server {
                status: status.as_u16(),
                message: msg,
            });
        }

        let event: SecurityEvent = resp.json().await.map_err(SecurityOsClientError::Http)?;
        Ok(event)
    }

    pub async fn get_stats(&self) -> Result<StatsResponse> {
        let url = format!("{}/api/stats", self.base_url);
        let resp = self.http.get(&url).send().await.map_err(|e| {
            if e.is_timeout() {
                SecurityOsClientError::Timeout
            } else if e.is_connect() {
                SecurityOsClientError::Connection(e.to_string())
            } else {
                SecurityOsClientError::Http(e)
            }
        })?;

        let status = resp.status();
        if !status.is_success() {
            let msg = resp.text().await.unwrap_or_default();
            return Err(SecurityOsClientError::Server {
                status: status.as_u16(),
                message: msg,
            });
        }

        let stats: StatsResponse = resp.json().await.map_err(SecurityOsClientError::Http)?;
        Ok(stats)
    }

    pub async fn stream_events(&self) -> Result<tokio::sync::mpsc::Receiver<SecurityEvent>> {
        let url = format!("{}/api/events/stream", self.base_url);
        let resp = self
            .http
            .get(&url)
            .header("Accept", "text/event-stream")
            .send()
            .await
            .map_err(|e| {
                if e.is_connect() {
                    SecurityOsClientError::Connection(e.to_string())
                } else {
                    SecurityOsClientError::Http(e)
                }
            })?;

        let status = resp.status();
        if !status.is_success() {
            let msg = resp.text().await.unwrap_or_default();
            return Err(SecurityOsClientError::Server {
                status: status.as_u16(),
                message: msg,
            });
        }

        let (tx, rx) = tokio::sync::mpsc::channel(256);

        tokio::spawn(async move {
            let mut resp = resp;
            let mut buffer = String::new();

            loop {
                let chunk = match resp.chunk().await {
                    Ok(Some(c)) => c,
                    Ok(None) => break,
                    Err(e) => {
                        tracing::warn!("SSE stream read error: {}", e);
                        break;
                    }
                };

                buffer.push_str(&String::from_utf8_lossy(&chunk));

                while let Some(line_end) = buffer.find("\n\n") {
                    let event_block = buffer[..line_end].to_string();
                    buffer = buffer[line_end + 2..].to_string();

                    for line in event_block.lines() {
                        if let Some(data) = line.strip_prefix("data: ") {
                            match serde_json::from_str::<SecurityEvent>(data) {
                                Ok(event) => {
                                    if tx.send(event).await.is_err() {
                                        return;
                                    }
                                }
                                Err(e) => {
                                    tracing::warn!("Failed to parse SSE event: {}", e);
                                }
                            }
                        }
                    }
                }
            }
        });

        Ok(rx)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{EventAction, EventCategory, EventSource};

    fn test_event_source() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "h1".into(),
            host_name: "testhost".into(),
            agent_id: "a1".into(),
            process_name: None,
            process_id: None,
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
        
            agent_version: None,
            service_name: None,
        }
    }

    #[test]
    fn test_client_creation() {
        let client = SecurityOsClient::new("http://localhost:8080".into());
        assert_eq!(client.base_url, "http://localhost:8080");
    }

    #[test]
    fn test_health_status_deserialize() {
        let json = r#"{"status":"ok","version":"1.0.0","uptime_secs":3600}"#;
        let hs: HealthStatus = serde_json::from_str(json).unwrap();
        assert_eq!(hs.status, "ok");
        assert_eq!(hs.version, "1.0.0");
        assert_eq!(hs.uptime_secs, 3600);
    }

    #[test]
    fn test_stats_response_deserialize() {
        let json = r#"{"total_events":42,"by_category":{"Network":10,"Process":32},"by_severity":{"High":5,"Low":37}}"#;
        let sr: StatsResponse = serde_json::from_str(json).unwrap();
        assert_eq!(sr.total_events, 42);
        assert_eq!(sr.by_category["Network"], 10);
        assert_eq!(sr.by_severity["High"], 5);
    }

    #[test]
    fn test_event_serialization_roundtrip() {
        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_event_source(),
            "Test event",
            "A test event",
        );
        let json = serde_json::to_string(&event).unwrap();
        let deser: SecurityEvent = serde_json::from_str(&json).unwrap();
        assert_eq!(event.id, deser.id);
        assert_eq!(event.title, deser.title);
    }

    #[test]
    fn test_error_display() {
        let err = SecurityOsClientError::NotFound("test".into());
        assert!(err.to_string().contains("test"));

        let err = SecurityOsClientError::Server {
            status: 500,
            message: "internal".into(),
        };
        assert!(err.to_string().contains("500"));
    }
}
