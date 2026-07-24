use reqwest::{Client, StatusCode};

use crate::errors::{Result, ThreatIntelError};

pub struct MispClient {
    base_url: String,
    api_key: String,
    client: Client,
}

#[derive(Debug, Clone)]
pub struct MispEvent {
    pub id: Option<u64>,
    pub uuid: String,
    pub info: String,
    pub date: String,
    pub threat_level: Option<u8>,
    pub analysis: Option<u8>,
    pub distribution: Option<u8>,
    pub attributes: Vec<MispAttribute>,
    pub tags: Vec<String>,
}

#[derive(Debug, Clone)]
pub struct MispAttribute {
    pub category: String,
    pub r#type: String,
    pub value: String,
    pub comment: Option<String>,
    pub to_ids: bool,
}

impl MispClient {
    pub fn new(base_url: &str, api_key: String) -> Self {
        let client = Client::builder()
            .timeout(std::time::Duration::from_secs(30))
            .build()
            .expect("failed to build MISP HTTP client");

        Self {
            base_url: base_url.trim_end_matches('/').to_string(),
            api_key,
            client,
        }
    }

    fn build_request(&self, url: &str) -> reqwest::RequestBuilder {
        self.client
            .get(url)
            .header("Authorization", &self.api_key)
            .header("Accept", "application/json")
            .header("Content-Type", "application/json")
    }

    pub async fn fetch_events(&self, page: u32, limit: u32) -> Result<Vec<MispEvent>> {
        let url = format!(
            "{}/events/index/page:{}/limit:{}",
            self.base_url, page, limit
        );

        let response = self
            .build_request(&url)
            .send()
            .await
            .map_err(|e| ThreatIntelError::Network(format!("MISP fetch_events failed: {}", e)))?;

        let status = response.status();
        if status == StatusCode::UNAUTHORIZED {
            return Err(ThreatIntelError::Unauthorized(
                "MISP API key is invalid".into(),
            ));
        }
        if status == StatusCode::TOO_MANY_REQUESTS {
            return Err(ThreatIntelError::RateLimit(
                "MISP rate limit exceeded".into(),
            ));
        }
        if !status.is_success() {
            return Err(ThreatIntelError::Network(format!(
                "MISP fetch_events returned status {}",
                status
            )));
        }

        let body: serde_json::Value = response.json().await.map_err(|e| {
            ThreatIntelError::Parse(format!("failed to parse MISP events response: {}", e))
        })?;

        let mut events = Vec::new();
        if let Some(arr) = body.get("response").and_then(|v| v.as_array()) {
            for item in arr {
                if let Some(event_json) = item.get("Event") {
                    match self.parse_misp_event(event_json) {
                        Ok(event) => events.push(event),
                        Err(e) => {
                            tracing::warn!("failed to parse MISP event: {}", e);
                        }
                    }
                }
            }
        }

        Ok(events)
    }

    pub async fn fetch_event(&self, event_id: u64) -> Result<MispEvent> {
        let url = format!("{}/events/{}", self.base_url, event_id);

        let response = self
            .build_request(&url)
            .send()
            .await
            .map_err(|e| ThreatIntelError::Network(format!("MISP fetch_event failed: {}", e)))?;

        let status = response.status();
        if status == StatusCode::UNAUTHORIZED {
            return Err(ThreatIntelError::Unauthorized(
                "MISP API key is invalid".into(),
            ));
        }
        if status == StatusCode::NOT_FOUND {
            return Err(ThreatIntelError::NotFound(format!(
                "MISP event {} not found",
                event_id
            )));
        }
        if status == StatusCode::TOO_MANY_REQUESTS {
            return Err(ThreatIntelError::RateLimit(
                "MISP rate limit exceeded".into(),
            ));
        }
        if !status.is_success() {
            return Err(ThreatIntelError::Network(format!(
                "MISP fetch_event returned status {}",
                status
            )));
        }

        let body: serde_json::Value = response.json().await.map_err(|e| {
            ThreatIntelError::Parse(format!("failed to parse MISP event response: {}", e))
        })?;

        if let Some(event_json) = body.get("Event") {
            self.parse_misp_event(event_json)
        } else {
            Err(ThreatIntelError::Parse(
                "missing Event field in MISP response".into(),
            ))
        }
    }

    pub async fn search_attributes(&self, value: &str) -> Result<Vec<MispAttribute>> {
        let url = format!("{}/attributes/restSearch", self.base_url);

        let search_body = serde_json::json!({
            "value": value,
        });

        let request = self
            .client
            .post(&url)
            .header("Authorization", &self.api_key)
            .header("Accept", "application/json")
            .header("Content-Type", "application/json")
            .json(&search_body);

        let response = request
            .send()
            .await
            .map_err(|e| ThreatIntelError::Network(format!("MISP search_attributes failed: {}", e)))?;

        let status = response.status();
        if status == StatusCode::UNAUTHORIZED {
            return Err(ThreatIntelError::Unauthorized(
                "MISP API key is invalid".into(),
            ));
        }
        if status == StatusCode::TOO_MANY_REQUESTS {
            return Err(ThreatIntelError::RateLimit(
                "MISP rate limit exceeded".into(),
            ));
        }
        if !status.is_success() {
            return Err(ThreatIntelError::Network(format!(
                "MISP search_attributes returned status {}",
                status
            )));
        }

        let body: serde_json::Value = response.json().await.map_err(|e| {
            ThreatIntelError::Parse(format!("failed to parse MISP attribute search: {}", e))
        })?;

        let mut attributes = Vec::new();
        if let Some(response_arr) = body.get("response").and_then(|v| v.as_array()) {
            for item in response_arr {
                if let Some(attr_json) = item.get("Attribute") {
                    match Self::parse_misp_attribute(attr_json) {
                        Ok(attr) => attributes.push(attr),
                        Err(e) => {
                            tracing::warn!("failed to parse MISP attribute: {}", e);
                        }
                    }
                }
            }
        }

        Ok(attributes)
    }

    pub fn parse_misp_event(&self, json: &serde_json::Value) -> Result<MispEvent> {
        let uuid = json
            .get("uuid")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();
        let info = json
            .get("info")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();
        let date = json
            .get("date")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();

        let id = json.get("id").and_then(|v| {
            if let Some(s) = v.as_str() {
                s.parse::<u64>().ok()
            } else {
                v.as_u64()
            }
        });

        let threat_level = json.get("threat_level_id").and_then(|v| {
            if let Some(s) = v.as_str() {
                s.parse::<u8>().ok()
            } else {
                v.as_u64().map(|n| n as u8)
            }
        });

        let analysis = json.get("analysis").and_then(|v| {
            if let Some(s) = v.as_str() {
                s.parse::<u8>().ok()
            } else {
                v.as_u64().map(|n| n as u8)
            }
        });

        let distribution = json.get("distribution").and_then(|v| {
            if let Some(s) = v.as_str() {
                s.parse::<u8>().ok()
            } else {
                v.as_u64().map(|n| n as u8)
            }
        });

        let mut attributes = Vec::new();
        if let Some(attr_array) = json.get("Attribute").and_then(|v| v.as_array()) {
            for attr_json in attr_array {
                match Self::parse_misp_attribute(attr_json) {
                    Ok(attr) => attributes.push(attr),
                    Err(e) => {
                        tracing::warn!("failed to parse MISP attribute in event: {}", e);
                    }
                }
            }
        }

        let tags = json
            .get("Tag")
            .and_then(|v| v.as_array())
            .map(|arr| {
                arr.iter()
                    .filter_map(|t| {
                        t.get("name")
                            .and_then(|v| v.as_str())
                            .map(String::from)
                            .or_else(|| t.as_str().map(String::from))
                    })
                    .collect()
            })
            .unwrap_or_default();

        Ok(MispEvent {
            id,
            uuid,
            info,
            date,
            threat_level,
            analysis,
            distribution,
            attributes,
            tags,
        })
    }

    pub fn parse_misp_attribute(json: &serde_json::Value) -> Result<MispAttribute> {
        let category = json
            .get("category")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();
        let attr_type = json
            .get("type")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();
        let value = json
            .get("value")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();
        let comment = json
            .get("comment")
            .and_then(|v| v.as_str())
            .filter(|s| !s.is_empty())
            .map(String::from);
        let to_ids = json
            .get("to_ids")
            .and_then(|v| v.as_bool())
            .unwrap_or(false);

        Ok(MispAttribute {
            category,
            r#type: attr_type,
            value,
            comment,
            to_ids,
        })
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_misp_event_parsing() {
        let client = MispClient::new("https://misp.local", "key123".into());

        let json: serde_json::Value = serde_json::from_str(r#"{
            "id": "42",
            "uuid": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
            "info": "APT28 Phishing Campaign",
            "date": "2025-07-01",
            "threat_level_id": "1",
            "analysis": "2",
            "distribution": "0",
            "Attribute": [
                {
                    "category": "Network activity",
                    "type": "ip-dst",
                    "value": "198.51.100.23",
                    "comment": "C2 server",
                    "to_ids": true
                },
                {
                    "category": "Payload delivery",
                    "type": "sha256",
                    "value": "abcdef1234567890abcdef1234567890",
                    "to_ids": true
                }
            ],
            "Tag": [
                {"name": "apt28"},
                {"name": "phishing"}
            ]
        }"#).unwrap();

        let event = client.parse_misp_event(&json).unwrap();
        assert_eq!(event.id, Some(42));
        assert_eq!(event.uuid, "a1b2c3d4-e5f6-7890-abcd-ef1234567890");
        assert_eq!(event.info, "APT28 Phishing Campaign");
        assert_eq!(event.date, "2025-07-01");
        assert_eq!(event.threat_level, Some(1));
        assert_eq!(event.analysis, Some(2));
        assert_eq!(event.attributes.len(), 2);
        assert!(event.tags.contains(&"apt28".to_string()));
        assert!(event.tags.contains(&"phishing".to_string()));
    }

    #[test]
    fn test_misp_attribute_parsing() {
        let json: serde_json::Value = serde_json::from_str(r#"{
            "category": "Network activity",
            "type": "domain",
            "value": "evil.example.com",
            "comment": "Known phishing domain",
            "to_ids": true
        }"#).unwrap();

        let attr = MispClient::parse_misp_attribute(&json).unwrap();
        assert_eq!(attr.category, "Network activity");
        assert_eq!(attr.r#type, "domain");
        assert_eq!(attr.value, "evil.example.com");
        assert_eq!(attr.comment, Some("Known phishing domain".into()));
        assert!(attr.to_ids);
    }

    #[test]
    fn test_misp_client_construction() {
        let client = MispClient::new("https://misp.example.com/", "my-api-key".into());
        assert_eq!(client.base_url, "https://misp.example.com");
        assert_eq!(client.api_key, "my-api-key");

        let client2 = MispClient::new("https://misp.local", "key".into());
        assert_eq!(client2.base_url, "https://misp.local");
    }
}
