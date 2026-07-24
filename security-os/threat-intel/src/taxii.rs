use chrono::{DateTime, Utc};
use reqwest::{Client, StatusCode};

use crate::errors::{Result, ThreatIntelError};
use crate::stix::{StixObject, StixParser};

pub struct TaxiiClient {
    base_url: String,
    username: Option<String>,
    password: Option<String>,
    client: Client,
}

#[derive(Debug, Clone)]
pub struct TaxiiCollection {
    pub id: String,
    pub title: String,
    pub description: Option<String>,
    pub can_read: bool,
    pub can_write: bool,
}

#[derive(Debug, Clone)]
pub struct TaxiiDiscovery {
    pub title: Option<String>,
    pub description: Option<String>,
    pub api_roots: Vec<String>,
}

impl TaxiiClient {
    pub fn new(
        base_url: &str,
        username: Option<String>,
        password: Option<String>,
    ) -> Self {
        let client = Client::builder()
            .timeout(std::time::Duration::from_secs(30))
            .build()
            .expect("failed to build TAXII HTTP client");

        Self {
            base_url: base_url.trim_end_matches('/').to_string(),
            username,
            password,
            client,
        }
    }

    fn build_request(&self, url: &str) -> reqwest::RequestBuilder {
        let mut request = self.client
            .get(url)
            .header("Accept", "application/taxii+json;version=2.1");

        if let (Some(ref user), Some(ref pass)) = (&self.username, &self.password) {
            request = request.basic_auth(user.as_str(), Some(pass.as_str()));
        }

        request
    }

    pub async fn discovery(&self) -> Result<TaxiiDiscovery> {
        let url = format!("{}/", self.base_url);
        let response = self
            .build_request(&url)
            .send()
            .await
            .map_err(|e| ThreatIntelError::Network(format!("TAXII discovery failed: {}", e)))?;

        let status = response.status();
        if status == StatusCode::UNAUTHORIZED {
            return Err(ThreatIntelError::Unauthorized(
                "TAXII server requires authentication".into(),
            ));
        }
        if status == StatusCode::TOO_MANY_REQUESTS {
            return Err(ThreatIntelError::RateLimit(
                "TAXII server rate limit exceeded".into(),
            ));
        }
        if !status.is_success() {
            return Err(ThreatIntelError::Network(format!(
                "TAXII discovery returned status {}",
                status
            )));
        }

        let body: serde_json::Value = response.json().await.map_err(|e| {
            ThreatIntelError::Parse(format!("failed to parse TAXII discovery response: {}", e))
        })?;

        let title = body
            .get("title")
            .and_then(|v| v.as_str())
            .map(String::from);
        let description = body
            .get("description")
            .and_then(|v| v.as_str())
            .map(String::from);
        let api_roots = body
            .get("api_roots")
            .and_then(|v| v.as_array())
            .map(|arr| {
                arr.iter()
                    .filter_map(|v| v.as_str().map(String::from))
                    .collect()
            })
            .unwrap_or_default();

        Ok(TaxiiDiscovery {
            title,
            description,
            api_roots,
        })
    }

    pub async fn get_collections(&self) -> Result<Vec<TaxiiCollection>> {
        let url = format!("{}/collections/", self.base_url);
        let response = self
            .build_request(&url)
            .send()
            .await
            .map_err(|e| ThreatIntelError::Network(format!("TAXII get_collections failed: {}", e)))?;

        let status = response.status();
        if status == StatusCode::UNAUTHORIZED {
            return Err(ThreatIntelError::Unauthorized(
                "TAXII server requires authentication".into(),
            ));
        }
        if status == StatusCode::TOO_MANY_REQUESTS {
            return Err(ThreatIntelError::RateLimit(
                "TAXII server rate limit exceeded".into(),
            ));
        }
        if !status.is_success() {
            return Err(ThreatIntelError::Network(format!(
                "TAXII collections returned status {}",
                status
            )));
        }

        let body: serde_json::Value = response.json().await.map_err(|e| {
            ThreatIntelError::Parse(format!("failed to parse TAXII collections: {}", e))
        })?;

        let mut collections = Vec::new();
        if let Some(arr) = body.get("collections").and_then(|v| v.as_array()) {
            for item in arr {
                collections.push(TaxiiCollection {
                    id: string_or(item, "id", ""),
                    title: string_or(item, "title", ""),
                    description: item
                        .get("description")
                        .and_then(|v| v.as_str())
                        .map(String::from),
                    can_read: item.get("can_read").and_then(|v| v.as_bool()).unwrap_or(false),
                    can_write: item.get("can_write").and_then(|v| v.as_bool()).unwrap_or(false),
                });
            }
        }

        Ok(collections)
    }

    pub async fn get_objects(
        &self,
        collection_id: &str,
        added_after: Option<DateTime<Utc>>,
    ) -> Result<Vec<serde_json::Value>> {
        let mut url = format!(
            "{}/collections/{}/objects/",
            self.base_url, collection_id
        );
        if let Some(dt) = added_after {
            url = format!("{}?added_after={}", url, dt.to_rfc3339());
        }

        let response = self
            .build_request(&url)
            .send()
            .await
            .map_err(|e| ThreatIntelError::Network(format!("TAXII get_objects failed: {}", e)))?;

        let status = response.status();
        if status == StatusCode::UNAUTHORIZED {
            return Err(ThreatIntelError::Unauthorized(
                "TAXII server requires authentication".into(),
            ));
        }
        if status == StatusCode::NOT_FOUND {
            return Err(ThreatIntelError::NotFound(format!(
                "collection '{}' not found",
                collection_id
            )));
        }
        if status == StatusCode::TOO_MANY_REQUESTS {
            return Err(ThreatIntelError::RateLimit(
                "TAXII server rate limit exceeded".into(),
            ));
        }
        if !status.is_success() {
            return Err(ThreatIntelError::Network(format!(
                "TAXII objects returned status {}",
                status
            )));
        }

        let body: serde_json::Value = response.json().await.map_err(|e| {
            ThreatIntelError::Parse(format!("failed to parse TAXII objects: {}", e))
        })?;

        let objects = body
            .get("objects")
            .and_then(|v| v.as_array())
            .cloned()
            .unwrap_or_default();

        Ok(objects)
    }

    pub async fn add_objects(
        &self,
        collection_id: &str,
        objects: &[serde_json::Value],
    ) -> Result<()> {
        let url = format!(
            "{}/collections/{}/objects/",
            self.base_url, collection_id
        );

        let envelope = serde_json::json!({
            "type": "bundle",
            "objects": objects,
        });

        let mut request = self.client
            .post(&url)
            .header("Content-Type", "application/taxii+json;version=2.1")
            .header("Accept", "application/taxii+json;version=2.1")
            .json(&envelope);

        if let (Some(ref user), Some(ref pass)) = (&self.username, &self.password) {
            request = request.basic_auth(user.as_str(), Some(pass.as_str()));
        }

        let response = request
            .send()
            .await
            .map_err(|e| ThreatIntelError::Network(format!("TAXII add_objects failed: {}", e)))?;

        let status = response.status();
        if status == StatusCode::UNAUTHORIZED {
            return Err(ThreatIntelError::Unauthorized(
                "TAXII server requires authentication".into(),
            ));
        }
        if status == StatusCode::FORBIDDEN {
            return Err(ThreatIntelError::Unauthorized(
                "not authorized to write to this collection".into(),
            ));
        }
        if status == StatusCode::TOO_MANY_REQUESTS {
            return Err(ThreatIntelError::RateLimit(
                "TAXII server rate limit exceeded".into(),
            ));
        }
        if !status.is_success() && status != StatusCode::ACCEPTED {
            return Err(ThreatIntelError::Network(format!(
                "TAXII add_objects returned status {}",
                status
            )));
        }

        tracing::info!(
            "added {} objects to TAXII collection '{}'",
            objects.len(),
            collection_id
        );
        Ok(())
    }

    pub async fn poll(&self, collection_id: &str) -> Result<Vec<StixObject>> {
        let objects = self.get_objects(collection_id, None).await?;
        let mut stix_objects = Vec::new();

        for obj_json in &objects {
            match StixParser::parse_object(obj_json) {
                Ok(obj) => stix_objects.push(obj),
                Err(e) => {
                    tracing::warn!("failed to parse STIX object from TAXII: {}", e);
                }
            }
        }

        tracing::info!(
            "polled {} STIX objects from TAXII collection '{}'",
            stix_objects.len(),
            collection_id
        );
        Ok(stix_objects)
    }
}

fn string_or(json: &serde_json::Value, key: &str, default: &str) -> String {
    json.get(key)
        .and_then(|v| v.as_str())
        .unwrap_or(default)
        .to_string()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_taxii_client_construction() {
        let client = TaxiiClient::new(
            "https://taxii.example.com/taxii2/",
            Some("user".into()),
            Some("pass".into()),
        );
        assert_eq!(client.base_url, "https://taxii.example.com/taxii2");
        assert!(client.username.is_some());
        assert!(client.password.is_some());

        let anon = TaxiiClient::new("https://taxii.example.com", None, None);
        assert!(anon.username.is_none());
    }

    #[test]
    fn test_collection_parsing() {
        let json: serde_json::Value = serde_json::from_str(r#"{
            "collections": [
                {
                    "id": "coll-001",
                    "title": "High-Fidelity IOCs",
                    "description": "Curated threat indicators",
                    "can_read": true,
                    "can_write": false
                },
                {
                    "id": "coll-002",
                    "title": "Community Feed",
                    "can_read": true,
                    "can_write": true
                }
            ]
        }"#).unwrap();

        let mut collections = Vec::new();
        if let Some(arr) = json.get("collections").and_then(|v| v.as_array()) {
            for item in arr {
                collections.push(TaxiiCollection {
                    id: string_or(item, "id", ""),
                    title: string_or(item, "title", ""),
                    description: item.get("description").and_then(|v| v.as_str()).map(String::from),
                    can_read: item.get("can_read").and_then(|v| v.as_bool()).unwrap_or(false),
                    can_write: item.get("can_write").and_then(|v| v.as_bool()).unwrap_or(false),
                });
            }
        }

        assert_eq!(collections.len(), 2);
        assert_eq!(collections[0].id, "coll-001");
        assert_eq!(collections[0].title, "High-Fidelity IOCs");
        assert!(collections[0].can_read);
        assert!(!collections[0].can_write);
        assert_eq!(collections[1].id, "coll-002");
        assert!(collections[1].can_write);
    }
}
