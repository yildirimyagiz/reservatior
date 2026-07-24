use chrono::{DateTime, Utc};
use std::sync::Arc;

use crate::misp::{MispClient, MispAttribute};
use crate::sigma::SigmaRule;
use crate::stix::{StixIndicator, StixStore};
use crate::sigma::SigmaStore;
use security_os_core::SecurityEvent;

#[derive(Debug, Clone)]
pub struct EnrichedEvent {
    pub event: SecurityEvent,
    pub stix_matches: Vec<StixIndicator>,
    pub sigma_matches: Vec<SigmaRule>,
    pub misp_matches: Vec<MispAttribute>,
    pub enrichment_timestamp: DateTime<Utc>,
    pub confidence_boost: f64,
}

pub struct EnrichmentPipeline {
    stix_store: Arc<StixStore>,
    sigma_store: Arc<SigmaStore>,
    misp_client: Option<Arc<MispClient>>,
}

impl EnrichmentPipeline {
    pub fn new(stix_store: Arc<StixStore>, sigma_store: Arc<SigmaStore>) -> Self {
        Self {
            stix_store,
            sigma_store,
            misp_client: None,
        }
    }

    pub fn with_misp(&mut self, client: Arc<MispClient>) {
        self.misp_client = Some(client);
    }

    pub async fn enrich(&self, event: &SecurityEvent) -> EnrichedEvent {
        let stix_matches = self.match_stix(event);
        let sigma_matches = self.match_sigma(event);
        let misp_matches = self.match_misp(event).await;

        let match_count = stix_matches.len() + sigma_matches.len() + misp_matches.len();
        let confidence_boost = if match_count == 0 {
            0.0
        } else {
            let base = 0.1 * match_count as f64;
            base.min(0.5)
        };

        EnrichedEvent {
            event: event.clone(),
            stix_matches,
            sigma_matches,
            misp_matches,
            enrichment_timestamp: Utc::now(),
            confidence_boost,
        }
    }

    fn match_stix(&self, event: &SecurityEvent) -> Vec<StixIndicator> {
        self.stix_store.match_event(event)
    }

    fn match_sigma(&self, event: &SecurityEvent) -> Vec<SigmaRule> {
        let mut matches = Vec::new();

        for entry in self.sigma_store.rules.iter() {
            let rule = entry.value();
            let mut matched = false;

            if let Some(ref category) = rule.logsource.category {
                match category.as_str() {
                    "process_creation" => {
                        if event.exe.is_some() || event.cmdline.is_some() {
                            matched = true;
                        }
                    }
                    "network_connection" => {
                        if event.src_ip.is_some() || event.dst_ip.is_some() {
                            matched = true;
                        }
                    }
                    "file_event" | "file_rename" => {
                        if event.file_path.is_some() {
                            matched = true;
                        }
                    }
                    "webserver" => {
                        if event.protocol.as_deref() == Some("http")
                            || event.protocol.as_deref() == Some("https")
                        {
                            matched = true;
                        }
                    }
                    _ => {}
                }
            }

            if !matched {
                if let Some(ref product) = rule.logsource.product {
                    match product.as_str() {
                        "windows" => {
                            if event.source.host_name.to_lowercase().contains("win")
                                || event.exe.as_ref().map(|e| e.ends_with(".exe")).unwrap_or(false)
                            {
                                matched = true;
                            }
                        }
                        "linux" => {
                            if !event.source.host_name.to_lowercase().contains("win") {
                                matched = true;
                            }
                        }
                        _ => {}
                    }
                }
            }

            if !matched {
                let title_lower = rule.title.to_lowercase();
                let desc_lower = rule.description.to_lowercase();
                let combined = format!("{} {}", title_lower, desc_lower);

                if combined.contains("powershell") || combined.contains("cmd") {
                    if event.cmdline.is_some() {
                        matched = true;
                    }
                }
                if combined.contains("ssh") || combined.contains("telnet") {
                    if event.protocol.as_deref() == Some("ssh")
                        || event.dst_port == Some(22)
                    {
                        matched = true;
                    }
                }
            }

            if matched {
                matches.push(rule.clone());
            }
        }

        matches
    }

    async fn match_misp(&self, event: &SecurityEvent) -> Vec<MispAttribute> {
        let client = match self.misp_client {
            Some(ref c) => c,
            None => return Vec::new(),
        };

        let mut matches = Vec::new();

        let values_to_check = self.extract_searchable_values(event);

        for value in &values_to_check {
            match client.search_attributes(value).await {
                Ok(attrs) => {
                    for attr in attrs {
                        if !matches.iter().any(|m: &MispAttribute| m.value == attr.value) {
                            matches.push(attr);
                        }
                    }
                }
                Err(e) => {
                    tracing::warn!("MISP attribute search failed for '{}': {}", value, e);
                }
            }
        }

        matches
    }

    fn extract_searchable_values(&self, event: &SecurityEvent) -> Vec<String> {
        let mut values = Vec::new();

        if let Some(ref ip) = event.src_ip {
            values.push(ip.clone());
        }
        if let Some(ref ip) = event.dst_ip {
            values.push(ip.clone());
        }
        if let Some(ref hash) = event.file_hash_sha256 {
            values.push(hash.clone());
        }
        if let Some(ref hash) = event.process_hash_sha256 {
            values.push(hash.clone());
        }
        if let Some(ref path) = event.file_path {
            values.push(path.clone());
        }
        if let Some(ref domain) = event.metadata.get("domain").and_then(|v| v.as_str()) {
            values.push(domain.to_string());
        }
        if let Some(ref url) = event.metadata.get("url").and_then(|v| v.as_str()) {
            values.push(url.to_string());
        }

        values
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::sigma::{SigmaLogsource, SigmaStore};
    use crate::stix::{StixBundle, StixObject, StixParser};
    use security_os_core::{EventAction, EventCategory, EventSource};

    fn test_source() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "test-host".into(),
            agent_id: "agent-1".into(),
            agent_version: None,
            process_name: Some("powershell.exe".into()),
            process_id: Some(42),
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            service_name: None,
        }
    }

    fn test_event() -> SecurityEvent {
        SecurityEvent::new(
            EventCategory::Process,
            EventAction::Executed,
            test_source(),
            "Suspicious process",
            "PowerShell spawned by Word",
        )
        .with_network("10.0.0.1", "192.168.1.100", 49152, 443)
        .with_process(42, 100, "powershell.exe")
        .with_metadata("domain", serde_json::Value::String("evil.example.com".into()))
    }

    #[tokio::test]
    async fn test_enrich_event() {
        let stix_store = Arc::new(StixStore::new());
        let sigma_store = Arc::new(SigmaStore::new());

        let ind_json: serde_json::Value = serde_json::from_str(r#"{
            "type": "indicator",
            "id": "indicator--enrich1",
            "name": "Evil Domain",
            "pattern": "[domain-name:value = 'evil.example.com']",
            "pattern_type": "stix",
            "valid_from": "2025-01-01T00:00:00Z",
            "labels": ["malicious-activity"]
        }"#).unwrap();

        let indicator = StixParser::parse_indicator(&ind_json).unwrap();
        stix_store.add_bundle(StixBundle {
            id: "bundle--e1".into(),
            spec_version: "2.1".into(),
            objects: vec![StixObject::Indicator(indicator)],
        });

        sigma_store.add_rule(crate::sigma::SigmaRule {
            id: "sigma-enrich1".into(),
            title: "Suspicious PowerShell".into(),
            status: "stable".into(),
            description: "PowerShell execution".into(),
            author: "test".into(),
            date: "2025-01-01".into(),
            logsource: SigmaLogsource {
                category: Some("process_creation".into()),
                product: Some("windows".into()),
                service: None,
            },
            detection: "{}".into(),
            falsepositives: vec![],
            level: "high".into(),
            tags: vec!["attack.t1059.001".into()],
            references: vec![],
        });

        let pipeline = EnrichmentPipeline::new(stix_store, sigma_store);
        let event = test_event();
        let enriched = pipeline.enrich(&event).await;

        assert_eq!(enriched.stix_matches.len(), 1);
        assert_eq!(enriched.sigma_matches.len(), 1);
        assert!(enriched.confidence_boost > 0.0);
    }

    #[tokio::test]
    async fn test_match_stix() {
        let stix_store = Arc::new(StixStore::new());
        let sigma_store = Arc::new(SigmaStore::new());

        let ind_json: serde_json::Value = serde_json::from_str(r#"{
            "type": "indicator",
            "id": "indicator--match1",
            "name": "Known C2 IP",
            "pattern": "[ipv4-addr:value = '192.168.1.100']",
            "pattern_type": "stix",
            "valid_from": "2025-01-01T00:00:00Z"
        }"#).unwrap();

        let indicator = StixParser::parse_indicator(&ind_json).unwrap();
        stix_store.add_bundle(StixBundle {
            id: "bundle--m1".into(),
            spec_version: "2.1".into(),
            objects: vec![StixObject::Indicator(indicator)],
        });

        let pipeline = EnrichmentPipeline::new(stix_store, sigma_store);
        let event = test_event();
        let matches = pipeline.match_stix(&event);
        assert_eq!(matches.len(), 1);
        assert_eq!(matches[0].name, "Known C2 IP");
    }

    #[tokio::test]
    async fn test_match_sigma() {
        let stix_store = Arc::new(StixStore::new());
        let sigma_store = Arc::new(SigmaStore::new());

        sigma_store.add_rule(crate::sigma::SigmaRule {
            id: "sigma-match1".into(),
            title: "Network Connection".into(),
            status: "stable".into(),
            description: "Detects network connections".into(),
            author: "test".into(),
            date: "2025-01-01".into(),
            logsource: SigmaLogsource {
                category: Some("network_connection".into()),
                product: None,
                service: None,
            },
            detection: "{}".into(),
            falsepositives: vec![],
            level: "medium".into(),
            tags: vec![],
            references: vec![],
        });

        sigma_store.add_rule(crate::sigma::SigmaRule {
            id: "sigma-no-match".into(),
            title: "Webserver Log".into(),
            status: "stable".into(),
            description: "Webserver events".into(),
            author: "test".into(),
            date: "2025-01-01".into(),
            logsource: SigmaLogsource {
                category: Some("webserver".into()),
                product: None,
                service: None,
            },
            detection: "{}".into(),
            falsepositives: vec![],
            level: "low".into(),
            tags: vec![],
            references: vec![],
        });

        let pipeline = EnrichmentPipeline::new(stix_store, sigma_store);
        let event = test_event();
        let matches = pipeline.match_sigma(&event);
        assert_eq!(matches.len(), 1);
        assert_eq!(matches[0].id, "sigma-match1");
    }
}
