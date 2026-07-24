use chrono::{DateTime, Utc};
use dashmap::DashMap;
use reqwest::Client;
use security_os_core::{IocMatch, SecurityOsError, SecurityEvent, Severity};
use serde::{Deserialize, Serialize};
use std::time::Duration;
use tracing::{info, warn};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum IocType {
    Ip,
    Hash,
    Domain,
    Url,
    Email,
    Cve,
    Mutex,
    Registry,
    Yara,
    Filename,
}

impl IocType {
    pub fn as_str(&self) -> &'static str {
        match self {
            Self::Ip => "ip",
            Self::Hash => "hash",
            Self::Domain => "domain",
            Self::Url => "url",
            Self::Email => "email",
            Self::Cve => "cve",
            Self::Mutex => "mutex",
            Self::Registry => "registry",
            Self::Yara => "yara",
            Self::Filename => "filename",
        }
    }

    pub fn from_str(s: &str) -> Option<Self> {
        match s.to_lowercase().as_str() {
            "ip" | "ipv4" | "ipv6" => Some(Self::Ip),
            "hash" | "md5" | "sha1" | "sha256" => Some(Self::Hash),
            "domain" | "fqdn" => Some(Self::Domain),
            "url" | "uri" => Some(Self::Url),
            "email" => Some(Self::Email),
            "cve" => Some(Self::Cve),
            "mutex" => Some(Self::Mutex),
            "registry" => Some(Self::Registry),
            "yara" => Some(Self::Yara),
            "filename" | "file" => Some(Self::Filename),
            _ => None,
        }
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub enum IocSeverity {
    Info,
    Low,
    Medium,
    High,
    Critical,
}

impl IocSeverity {
    pub fn as_str(&self) -> &'static str {
        match self {
            Self::Info => "info",
            Self::Low => "low",
            Self::Medium => "medium",
            Self::High => "high",
            Self::Critical => "critical",
        }
    }

    pub fn from_str(s: &str) -> Self {
        match s.to_lowercase().as_str() {
            "critical" => Self::Critical,
            "high" => Self::High,
            "medium" => Self::Medium,
            "low" => Self::Low,
            _ => Self::Info,
        }
    }

    pub fn to_core_severity(&self) -> Severity {
        match self {
            Self::Info => Severity::Informational,
            Self::Low => Severity::Low,
            Self::Medium => Severity::Medium,
            Self::High => Severity::High,
            Self::Critical => Severity::Critical,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IocEntry {
    pub value: String,
    pub ioc_type: IocType,
    pub feed: String,
    pub severity: IocSeverity,
    pub confidence: f64,
    pub first_seen: DateTime<Utc>,
    pub last_seen: DateTime<Utc>,
    #[serde(default)]
    pub tags: Vec<String>,
    #[serde(default)]
    pub description: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IocFeedConfig {
    pub name: String,
    pub url: String,
    pub format: IocFeedFormat,
    #[serde(default = "default_api_key")]
    pub api_key: Option<String>,
    #[serde(default = "default_interval")]
    pub refresh_interval_secs: u64,
}

fn default_api_key() -> Option<String> {
    None
}

fn default_interval() -> u64 {
    3600
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum IocFeedFormat {
    AbuseIpDb,
    CisaKev,
    Generic,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IocCheckResult {
    pub matches: Vec<IocMatch>,
    pub score: f64,
}

pub struct IocEngine {
    pub ips: DashMap<String, IocEntry>,
    pub hashes: DashMap<String, IocEntry>,
    pub domains: DashMap<String, IocEntry>,
    pub urls: DashMap<String, IocEntry>,
    pub emails: DashMap<String, IocEntry>,
    pub cves: DashMap<String, IocEntry>,
    pub tor_exit_nodes: DashMap<String, ()>,
    pub client: Client,
}

impl IocEngine {
    pub fn new() -> Self {
        Self {
            ips: DashMap::new(),
            hashes: DashMap::new(),
            domains: DashMap::new(),
            urls: DashMap::new(),
            emails: DashMap::new(),
            cves: DashMap::new(),
            tor_exit_nodes: DashMap::new(),
            client: Client::builder()
                .timeout(Duration::from_secs(30))
                .build()
                .expect("failed to build HTTP client"),
        }
    }

    pub fn with_timeout(timeout: Duration) -> Self {
        Self {
            ips: DashMap::new(),
            hashes: DashMap::new(),
            domains: DashMap::new(),
            urls: DashMap::new(),
            emails: DashMap::new(),
            cves: DashMap::new(),
            tor_exit_nodes: DashMap::new(),
            client: Client::builder()
                .timeout(timeout)
                .build()
                .expect("failed to build HTTP client"),
        }
    }

    fn store_for_type(&self, ioc_type: &IocType) -> &DashMap<String, IocEntry> {
        match ioc_type {
            IocType::Ip => &self.ips,
            IocType::Hash => &self.hashes,
            IocType::Domain => &self.domains,
            IocType::Url => &self.urls,
            IocType::Email => &self.emails,
            IocType::Cve => &self.cves,
            _ => &self.domains,
        }
    }

    pub fn add_ioc(&self, entry: IocEntry) {
        let map = self.store_for_type(&entry.ioc_type);
        map.insert(entry.value.clone(), entry);
    }

    pub fn check_event(&self, event: &SecurityEvent) -> Vec<IocMatch> {
        let mut matches = Vec::new();

        for (_key, value) in &event.metadata {
            if let Some(s) = value.as_str() {
                self.check_value(s, &event.source.host_name, &mut matches);
            } else if let Some(s) = value.as_i64().map(|v| v.to_string()) {
                self.check_value(&s, &event.source.host_name, &mut matches);
            }
        }

        if let Some(ref proc) = event.source.process_name {
            self.check_value(proc, &event.source.host_name, &mut matches);
        }

        if let Some(ref user) = event.source.user_name {
            self.check_value(user, &event.source.host_name, &mut matches);
        }

        if let Some(ref container) = event.source.container_id {
            self.check_value(container, &event.source.host_name, &mut matches);
        }

        self.check_value(&event.description, &event.source.host_name, &mut matches);

        matches
    }

    fn check_value(&self, value: &str, host: &str, matches: &mut Vec<IocMatch>) {
        let lower = value.to_lowercase();

        for map in [&self.ips, &self.hashes, &self.domains, &self.urls, &self.emails, &self.cves] {
            if let Some(entry) = map.get(&lower) {
                matches.push(IocMatch {
                    ioc_type: entry.value().ioc_type.as_str().to_string(),
                    ioc_value: entry.value().value.clone(),
                    feed: entry.value().feed.clone(),
                    feed_url: None,
                    match_context: format!("matched '{}' in event from host '{}'", lower, host),
                    confidence: 1.0,
                    first_seen: None,
                    last_seen: None,
                });
            }
        }
    }

    pub fn load_from_json(&self, feed_name: &str, json: &str) -> Result<usize, SecurityOsError> {
        let parsed: serde_json::Value =
            serde_json::from_str(json).map_err(SecurityOsError::Serialization)?;
        let mut count = 0;

        if let Some(data_array) = parsed.get("data").and_then(|v| v.as_array()) {
            for item in data_array {
                if let Some(ip) = item.get("ipAddress").and_then(|v| v.as_str()) {
                    let confidence = item
                        .get("abuseConfidenceScore")
                        .and_then(|v| v.as_f64())
                        .unwrap_or(50.0)
                        / 100.0;
                    let severity = if confidence > 0.8 {
                        IocSeverity::Critical
                    } else if confidence > 0.6 {
                        IocSeverity::High
                    } else if confidence > 0.4 {
                        IocSeverity::Medium
                    } else if confidence > 0.2 {
                        IocSeverity::Low
                    } else {
                        IocSeverity::Info
                    };

                    let now = Utc::now();
                    self.add_ioc(IocEntry {
                        value: ip.to_lowercase(),
                        ioc_type: IocType::Ip,
                        feed: feed_name.to_string(),
                        severity,
                        confidence,
                        first_seen: now,
                        last_seen: now,
                        tags: vec!["abuseipdb".to_string()],
                        description: None,
                    });
                    count += 1;
                }
            }
        }

        if let Some(vulns) = parsed.get("vulnerabilities").and_then(|v| v.as_array()) {
            for item in vulns {
                if let Some(cve_id) = item.get("cveID").and_then(|v| v.as_str()) {
                    let product = item
                        .get("product")
                        .and_then(|v| v.as_str())
                        .unwrap_or("unknown");
                    let now = Utc::now();
                    self.add_ioc(IocEntry {
                        value: cve_id.to_lowercase(),
                        ioc_type: IocType::Cve,
                        feed: feed_name.to_string(),
                        severity: IocSeverity::High,
                        confidence: 1.0,
                        first_seen: now,
                        last_seen: now,
                        tags: vec!["cisa-kev".to_string(), product.to_string()],
                        description: Some(format!("Known exploited vulnerability for {}", product)),
                    });
                    count += 1;
                }
            }
        }

        if let Some(iocs_array) = parsed.get("iocs").and_then(|v| v.as_array()) {
            for item in iocs_array {
                let ioc_type_str = item.get("type").and_then(|v| v.as_str()).unwrap_or("");
                let value_str = item.get("value").and_then(|v| v.as_str()).unwrap_or("");
                let severity_str = item.get("severity").and_then(|v| v.as_str()).unwrap_or("info");

                if let Some(ioc_type) = IocType::from_str(ioc_type_str) {
                    if !value_str.is_empty() {
                        let now = Utc::now();
                        let confidence = item
                            .get("confidence")
                            .and_then(|v| v.as_f64())
                            .unwrap_or(50.0);
                        let tags: Vec<String> = item
                            .get("tags")
                            .and_then(|v| v.as_array())
                            .map(|arr| {
                                arr.iter()
                                    .filter_map(|v| v.as_str().map(String::from))
                                    .collect()
                            })
                            .unwrap_or_default();

                        self.add_ioc(IocEntry {
                            value: value_str.to_lowercase(),
                            ioc_type,
                            feed: feed_name.to_string(),
                            severity: IocSeverity::from_str(severity_str),
                            confidence: confidence / 100.0,
                            first_seen: now,
                            last_seen: now,
                            tags,
                            description: item
                                .get("description")
                                .and_then(|v| v.as_str())
                                .map(String::from),
                        });
                        count += 1;
                    }
                }
            }
        }

        info!("loaded {} IOCs from feed '{}'", count, feed_name);
        Ok(count)
    }

    pub fn load_greynoise(&self, json: &str) -> Result<usize, SecurityOsError> {
        let parsed: serde_json::Value =
            serde_json::from_str(json).map_err(SecurityOsError::Serialization)?;
        let mut count = 0;

        let ip = parsed
            .get("ip")
            .and_then(|v| v.as_str())
            .unwrap_or("");
        if ip.is_empty() {
            return Ok(0);
        }

        let noise = parsed.get("noise").and_then(|v| v.as_bool()).unwrap_or(false);
        let riot = parsed.get("riot").and_then(|v| v.as_bool()).unwrap_or(false);
        let classification = parsed
            .get("classification")
            .and_then(|v| v.as_str())
            .unwrap_or("unknown");

        let severity = match classification {
            "malicious" => IocSeverity::Critical,
            "suspicious" => IocSeverity::High,
            "benign" => IocSeverity::Info,
            _ => IocSeverity::Medium,
        };

        let confidence = if noise && !riot {
            0.9
        } else if riot {
            0.1
        } else {
            0.5
        };

        let mut tags = vec!["greynoise".to_string()];
        if noise {
            tags.push("noise".to_string());
        }
        if riot {
            tags.push("riot".to_string());
        }

        let now = Utc::now();
        self.add_ioc(IocEntry {
            value: ip.to_lowercase(),
            ioc_type: IocType::Ip,
            feed: "greynoise".to_string(),
            severity,
            confidence,
            first_seen: now,
            last_seen: now,
            tags,
            description: Some(format!(
                "GreyNoise classification: {}, noise: {}, riot: {}",
                classification, noise, riot
            )),
        });
        count += 1;

        info!("loaded {} IOCs from greynoise", count);
        Ok(count)
    }

    pub fn load_threatfox(&self, json: &str) -> Result<usize, SecurityOsError> {
        let parsed: serde_json::Value =
            serde_json::from_str(json).map_err(SecurityOsError::Serialization)?;
        let mut count = 0;
        let now = Utc::now();

        let data_array = match parsed.get("data").and_then(|v| v.as_array()) {
            Some(arr) => arr,
            None => return Ok(0),
        };

        for item in data_array {
            let ioc_value = match item.get("ioc").and_then(|v| v.as_str()) {
                Some(v) => v,
                None => continue,
            };
            let ioc_type_str = item
                .get("ioc_type")
                .and_then(|v| v.as_str())
                .unwrap_or("ip:port");
            let threat_type = item
                .get("threat_type")
                .and_then(|v| v.as_str())
                .unwrap_or("unknown");

            let (ioc_type, clean_value) = match ioc_type_str {
                "ip:port" => {
                    let parts: Vec<&str> = ioc_value.splitn(2, ':').collect();
                    (IocType::Ip, parts[0].to_string())
                }
                "ip" => (IocType::Ip, ioc_value.to_string()),
                "domain" => (IocType::Domain, ioc_value.to_string()),
                "url" => (IocType::Url, ioc_value.to_string()),
                "md5" | "sha1" | "sha256" => (IocType::Hash, ioc_value.to_string()),
                _ => (IocType::Ip, ioc_value.to_string()),
            };

            let severity = match threat_type {
                "botnet_cc" | "botnet_callback" => IocSeverity::Critical,
                "malware_download" | "malware_distribution" => IocSeverity::High,
                "cryptomining" => IocSeverity::Medium,
                _ => IocSeverity::Medium,
            };

            let tags: Vec<String> = item
                .get("tags")
                .and_then(|v| v.as_array())
                .map(|arr| {
                    let mut t: Vec<String> = arr
                        .iter()
                        .filter_map(|v| v.as_str().map(String::from))
                        .collect();
                    t.push("threatfox".to_string());
                    t
                })
                .unwrap_or_else(|| vec!["threatfox".to_string()]);

            self.add_ioc(IocEntry {
                value: clean_value.to_lowercase(),
                ioc_type,
                feed: "threatfox".to_string(),
                severity,
                confidence: 0.85,
                first_seen: now,
                last_seen: now,
                tags,
                description: Some(format!("ThreatFox threat type: {}", threat_type)),
            });
            count += 1;
        }

        info!("loaded {} IOCs from threatfox", count);
        Ok(count)
    }

    pub fn load_urlhaus(&self, json: &str) -> Result<usize, SecurityOsError> {
        let parsed: serde_json::Value =
            serde_json::from_str(json).map_err(SecurityOsError::Serialization)?;
        let mut count = 0;
        let now = Utc::now();

        let urls_array = match parsed.get("urls").and_then(|v| v.as_array()) {
            Some(arr) => arr,
            None => return Ok(0),
        };

        for item in urls_array {
            let url = match item.get("url").and_then(|v| v.as_str()) {
                Some(v) => v,
                None => continue,
            };
            let threat = item
                .get("threat")
                .and_then(|v| v.as_str())
                .unwrap_or("unknown");
            let url_status = item
                .get("url_status")
                .and_then(|v| v.as_str())
                .unwrap_or("unknown");

            let severity = match threat {
                "malware_download" => IocSeverity::Critical,
                "malware_upload" => IocSeverity::High,
                "phishing" => IocSeverity::High,
                "defacement" => IocSeverity::Medium,
                _ => IocSeverity::Medium,
            };

            let mut tags = vec!["urlhaus".to_string()];
            tags.push(threat.to_string());
            if url_status == "online" {
                tags.push("active".to_string());
            }

            self.add_ioc(IocEntry {
                value: url.to_lowercase(),
                ioc_type: IocType::Url,
                feed: "urlhaus".to_string(),
                severity,
                confidence: 0.9,
                first_seen: now,
                last_seen: now,
                tags,
                description: Some(format!(
                    "URLHaus threat: {}, status: {}",
                    threat, url_status
                )),
            });
            count += 1;
        }

        info!("loaded {} IOCs from urlhaus", count);
        Ok(count)
    }

    pub fn load_phishtank(&self, json: &str) -> Result<usize, SecurityOsError> {
        let parsed: serde_json::Value =
            serde_json::from_str(json).map_err(SecurityOsError::Serialization)?;
        let mut count = 0;
        let now = Utc::now();

        let results_array = match parsed.get("results").and_then(|v| v.as_array()) {
            Some(arr) => arr,
            None => return Ok(0),
        };

        for item in results_array {
            let url = match item.get("url").and_then(|v| v.as_str()) {
                Some(v) => v,
                None => continue,
            };
            let phish_id = item
                .get("phish_id")
                .and_then(|v| v.as_str())
                .unwrap_or("unknown");
            let target = item
                .get("target")
                .and_then(|v| v.as_str())
                .unwrap_or("unknown");

            let mut tags = vec!["phishtank".to_string()];
            tags.push(format!("target:{}", target));

            self.add_ioc(IocEntry {
                value: url.to_lowercase(),
                ioc_type: IocType::Url,
                feed: "phishtank".to_string(),
                severity: IocSeverity::High,
                confidence: 0.95,
                first_seen: now,
                last_seen: now,
                tags,
                description: Some(format!(
                    "PhishTank phish_id: {}, targeting: {}",
                    phish_id, target
                )),
            });
            count += 1;
        }

        info!("loaded {} IOCs from phishtank", count);
        Ok(count)
    }

    pub fn load_abusech(&self, json: &str) -> Result<usize, SecurityOsError> {
        let parsed: serde_json::Value =
            serde_json::from_str(json).map_err(SecurityOsError::Serialization)?;
        let mut count = 0;
        let now = Utc::now();

        let data_array = match parsed.get("data").and_then(|v| v.as_array()) {
            Some(arr) => arr,
            None => return Ok(0),
        };

        for item in data_array {
            if let Some(md5) = item.get("md5_hash").and_then(|v| v.as_str()) {
                let file_type = item
                    .get("file_type")
                    .and_then(|v| v.as_str())
                    .unwrap_or("unknown");

                self.add_ioc(IocEntry {
                    value: md5.to_lowercase(),
                    ioc_type: IocType::Hash,
                    feed: "abusech".to_string(),
                    severity: IocSeverity::High,
                    confidence: 0.95,
                    first_seen: now,
                    last_seen: now,
                    tags: vec!["abusech".to_string(), "md5".to_string()],
                    description: Some(format!("AbuseCH malware hash, type: {}", file_type)),
                });
                count += 1;
            }

            if let Some(sha256) = item.get("sha256_hash").and_then(|v| v.as_str()) {
                let file_type = item
                    .get("file_type")
                    .and_then(|v| v.as_str())
                    .unwrap_or("unknown");

                self.add_ioc(IocEntry {
                    value: sha256.to_lowercase(),
                    ioc_type: IocType::Hash,
                    feed: "abusech".to_string(),
                    severity: IocSeverity::Critical,
                    confidence: 0.98,
                    first_seen: now,
                    last_seen: now,
                    tags: vec!["abusech".to_string(), "sha256".to_string()],
                    description: Some(format!("AbuseCH malware hash, type: {}", file_type)),
                });
                count += 1;
            }
        }

        info!("loaded {} IOCs from abusech", count);
        Ok(count)
    }

    pub fn load_tor_exit_nodes(&self, json: &str) -> Result<usize, SecurityOsError> {
        let parsed: serde_json::Value =
            serde_json::from_str(json).map_err(SecurityOsError::Serialization)?;
        let mut count = 0;
        let now = Utc::now();

        let exit_nodes = match parsed.get("exit_nodes").and_then(|v| v.as_array()) {
            Some(arr) => arr,
            None => return Ok(0),
        };

        for node in exit_nodes {
            if let Some(ip) = node.as_str() {
                self.tor_exit_nodes
                    .insert(ip.to_lowercase(), ());
                self.add_ioc(IocEntry {
                    value: ip.to_lowercase(),
                    ioc_type: IocType::Ip,
                    feed: "tor_exit_nodes".to_string(),
                    severity: IocSeverity::Medium,
                    confidence: 1.0,
                    first_seen: now,
                    last_seen: now,
                    tags: vec!["tor".to_string(), "exit-node".to_string()],
                    description: Some("Known TOR exit node".to_string()),
                });
                count += 1;
            }
        }

        info!("loaded {} TOR exit nodes", count);
        Ok(count)
    }

    pub fn is_tor_exit_node(&self, ip: &str) -> bool {
        self.tor_exit_nodes.contains_key(&ip.to_lowercase())
    }

    pub async fn refresh_feeds(&self, feeds: &[IocFeedConfig]) {
        for feed in feeds {
            match self.fetch_feed(feed).await {
                Ok(count) => {
                    info!("refreshed feed '{}' with {} IOCs", feed.name, count);
                }
                Err(e) => {
                    warn!("failed to refresh feed '{}': {}", feed.name, e);
                }
            }
        }
    }

    async fn fetch_feed(&self, feed: &IocFeedConfig) -> Result<usize, SecurityOsError> {
        let mut request = self.client.get(&feed.url);

        if let Some(ref api_key) = feed.api_key {
            request = request.header("X-Api-Key", api_key.as_str());
            request = request.header("Authorization", format!("Bearer {}", api_key));
        }

        let response = request.send().await.map_err(|e| {
            SecurityOsError::Network(format!("failed to fetch feed '{}': {}", feed.name, e))
        })?;

        let body = response.text().await.map_err(|e| {
            SecurityOsError::Network(format!("failed to read feed '{}' body: {}", feed.name, e))
        })?;

        match feed.format {
            IocFeedFormat::AbuseIpDb | IocFeedFormat::CisaKev | IocFeedFormat::Generic => {
                self.load_from_json(&feed.name, &body)
            }
        }
    }

    pub fn start_refresh_loop(self: &std::sync::Arc<Self>, feeds: Vec<IocFeedConfig>, interval: Duration) {
        let engine = std::sync::Arc::clone(self);
        tokio::spawn(async move {
            let mut ticker = tokio::time::interval(interval);
            ticker.tick().await;
            loop {
                ticker.tick().await;
                engine.refresh_feeds(&feeds).await;
            }
        });
    }

    pub fn get_ioc_count(&self) -> usize {
        self.ips.len()
            + self.hashes.len()
            + self.domains.len()
            + self.urls.len()
            + self.emails.len()
            + self.cves.len()
    }

    pub fn lookup(&self, ioc_type: &IocType, value: &str) -> Option<IocEntry> {
        let map = self.store_for_type(ioc_type);
        map.get(&value.to_lowercase()).map(|r| r.value().clone())
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{
        EventAction, EventCategory, EventSource,
    };

    fn test_source() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "test-host".into(),
            agent_id: "agent-1".into(),
            process_name: Some("malware.exe".into()),
            process_id: Some(1234),
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
    fn test_load_generic_format() {
        let engine = IocEngine::new();
        let json = r#"{
            "iocs": [
                {"type": "ip", "value": "1.2.3.4", "severity": "high", "confidence": 80},
                {"type": "hash", "value": "abc123", "severity": "critical"},
                {"type": "domain", "value": "evil.com", "severity": "medium"}
            ]
        }"#;
        let count = engine.load_from_json("test-feed", json).unwrap();
        assert_eq!(count, 3);
        assert_eq!(engine.ips.len(), 1);
        assert_eq!(engine.hashes.len(), 1);
        assert_eq!(engine.domains.len(), 1);
    }

    #[test]
    fn test_load_abuseipdb_format() {
        let engine = IocEngine::new();
        let json = r#"{
            "data": [
                {"ipAddress": "10.0.0.1", "abuseConfidenceScore": 90},
                {"ipAddress": "10.0.0.2", "abuseConfidenceScore": 20}
            ]
        }"#;
        let count = engine.load_from_json("abuseipdb", json).unwrap();
        assert_eq!(count, 2);
    }

    #[test]
    fn test_check_event_matches() {
        let engine = IocEngine::new();
        let now = Utc::now();
        engine.add_ioc(IocEntry {
            value: "evil.com".into(),
            ioc_type: IocType::Domain,
            feed: "test".into(),
            severity: IocSeverity::High,
            confidence: 0.9,
            first_seen: now,
            last_seen: now,
            tags: vec![],
            description: None,
        });

        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            test_source(),
            "Suspicious connection",
            "Connected to known malicious domain",
        )
        .with_metadata("destination_host", serde_json::Value::String("evil.com".into()));

        let matches = engine.check_event(&event);
        assert_eq!(matches.len(), 1);
        assert_eq!(matches[0].ioc_value, "evil.com");
    }

    #[test]
    fn test_lookup() {
        let engine = IocEngine::new();
        let now = Utc::now();
        engine.add_ioc(IocEntry {
            value: "8.8.8.8".into(),
            ioc_type: IocType::Ip,
            feed: "test".into(),
            severity: IocSeverity::Low,
            confidence: 0.5,
            first_seen: now,
            last_seen: now,
            tags: vec![],
            description: None,
        });

        assert!(engine.lookup(&IocType::Ip, "8.8.8.8").is_some());
        assert!(engine.lookup(&IocType::Ip, "8.8.4.4").is_none());
        assert!(engine.lookup(&IocType::Hash, "8.8.8.8").is_none());
    }

    #[test]
    fn test_load_greynoise() {
        let engine = IocEngine::new();
        let json = r#"{"ip": "198.51.100.1", "noise": true, "riot": false, "classification": "malicious"}"#;
        let count = engine.load_greynoise(json).unwrap();
        assert_eq!(count, 1);
        let entry = engine.lookup(&IocType::Ip, "198.51.100.1").unwrap();
        assert_eq!(entry.severity, IocSeverity::Critical);
        assert!(entry.tags.contains(&"greynoise".to_string()));
        assert!(entry.tags.contains(&"noise".to_string()));
        assert_eq!(entry.confidence, 0.9);
    }

    #[test]
    fn test_load_greynoise_riot() {
        let engine = IocEngine::new();
        let json = r#"{"ip": "8.8.8.8", "noise": false, "riot": true, "classification": "benign"}"#;
        let count = engine.load_greynoise(json).unwrap();
        assert_eq!(count, 1);
        let entry = engine.lookup(&IocType::Ip, "8.8.8.8").unwrap();
        assert_eq!(entry.severity, IocSeverity::Info);
        assert!(entry.tags.contains(&"riot".to_string()));
        assert_eq!(entry.confidence, 0.1);
    }

    #[test]
    fn test_load_greynoise_suspicious() {
        let engine = IocEngine::new();
        let json = r#"{"ip": "10.20.30.40", "noise": true, "riot": false, "classification": "suspicious"}"#;
        let count = engine.load_greynoise(json).unwrap();
        assert_eq!(count, 1);
        let entry = engine.lookup(&IocType::Ip, "10.20.30.40").unwrap();
        assert_eq!(entry.severity, IocSeverity::High);
    }

    #[test]
    fn test_load_greynoise_empty_ip() {
        let engine = IocEngine::new();
        let json = r#"{"noise": true, "riot": false, "classification": "malicious"}"#;
        let count = engine.load_greynoise(json).unwrap();
        assert_eq!(count, 0);
    }

    #[test]
    fn test_load_threatfox() {
        let engine = IocEngine::new();
        let json = r#"{
            "data": [
                {"ioc": "192.168.1.100:4444", "ioc_type": "ip:port", "threat_type": "botnet_cc"},
                {"ioc": "evil-domain.com", "ioc_type": "domain", "threat_type": "malware_download"}
            ]
        }"#;
        let count = engine.load_threatfox(json).unwrap();
        assert_eq!(count, 2);

        let entry = engine.lookup(&IocType::Ip, "192.168.1.100").unwrap();
        assert_eq!(entry.severity, IocSeverity::Critical);
        assert!(entry.tags.contains(&"threatfox".to_string()));
        assert_eq!(entry.confidence, 0.85);

        let domain_entry = engine.lookup(&IocType::Domain, "evil-domain.com").unwrap();
        assert_eq!(domain_entry.severity, IocSeverity::High);
    }

    #[test]
    fn test_load_threatfox_empty_data() {
        let engine = IocEngine::new();
        let json = r#"{"data": []}"#;
        let count = engine.load_threatfox(json).unwrap();
        assert_eq!(count, 0);
    }

    #[test]
    fn test_load_threatfox_missing_data() {
        let engine = IocEngine::new();
        let json = r#"{"something": "else"}"#;
        let count = engine.load_threatfox(json).unwrap();
        assert_eq!(count, 0);
    }

    #[test]
    fn test_load_urlhaus() {
        let engine = IocEngine::new();
        let json = r#"{
            "urls": [
                {"url": "http://evil.com/malware.bin", "threat": "malware_download", "url_status": "online"},
                {"url": "http://phish.com/login", "threat": "phishing", "url_status": "offline"}
            ]
        }"#;
        let count = engine.load_urlhaus(json).unwrap();
        assert_eq!(count, 2);

        let entry = engine
            .urls
            .get("http://evil.com/malware.bin")
            .unwrap();
        assert_eq!(entry.value().severity, IocSeverity::Critical);
        assert!(entry.value().tags.contains(&"active".to_string()));
        assert!(entry.value().tags.contains(&"malware_download".to_string()));

        let phishing = engine
            .urls
            .get("http://phish.com/login")
            .unwrap();
        assert_eq!(phishing.value().severity, IocSeverity::High);
        assert!(!phishing.value().tags.contains(&"active".to_string()));
    }

    #[test]
    fn test_load_urlhaus_empty() {
        let engine = IocEngine::new();
        let json = r#"{"urls": []}"#;
        let count = engine.load_urlhaus(json).unwrap();
        assert_eq!(count, 0);
    }

    #[test]
    fn test_load_phishtank() {
        let engine = IocEngine::new();
        let json = r#"{
            "results": [
                {"url": "http://phishing-site.com/paypal", "phish_id": "12345", "target": "paypal"},
                {"url": "http://phishing-site.com/bank", "phish_id": "67890", "target": "bank_of_america"}
            ]
        }"#;
        let count = engine.load_phishtank(json).unwrap();
        assert_eq!(count, 2);

        let entry = engine
            .urls
            .get("http://phishing-site.com/paypal")
            .unwrap();
        assert_eq!(entry.value().severity, IocSeverity::High);
        assert_eq!(entry.value().confidence, 0.95);
        assert!(entry.value().tags.contains(&"phishtank".to_string()));
        assert!(entry.value().tags.contains(&"target:paypal".to_string()));
    }

    #[test]
    fn test_load_phishtank_empty() {
        let engine = IocEngine::new();
        let json = r#"{"results": []}"#;
        let count = engine.load_phishtank(json).unwrap();
        assert_eq!(count, 0);
    }

    #[test]
    fn test_load_abusech() {
        let engine = IocEngine::new();
        let json = r#"{
            "data": [
                {"md5_hash": "abc123def456", "sha256_hash": "aaa111bbb222ccc333", "file_type": "elf"},
                {"md5_hash": "789xyz", "file_type": "exe"}
            ]
        }"#;
        let count = engine.load_abusech(json).unwrap();
        assert_eq!(count, 3);

        let md5_entry = engine.lookup(&IocType::Hash, "abc123def456").unwrap();
        assert_eq!(md5_entry.severity, IocSeverity::High);
        assert!(md5_entry.tags.contains(&"abusech".to_string()));
        assert!(md5_entry.tags.contains(&"md5".to_string()));

        let sha256_entry = engine.lookup(&IocType::Hash, "aaa111bbb222ccc333").unwrap();
        assert_eq!(sha256_entry.severity, IocSeverity::Critical);
        assert_eq!(sha256_entry.confidence, 0.98);
        assert!(sha256_entry.tags.contains(&"sha256".to_string()));
    }

    #[test]
    fn test_load_abusech_empty() {
        let engine = IocEngine::new();
        let json = r#"{"data": []}"#;
        let count = engine.load_abusech(json).unwrap();
        assert_eq!(count, 0);
    }

    #[test]
    fn test_load_tor_exit_nodes() {
        let engine = IocEngine::new();
        let json = r#"{"exit_nodes": ["1.2.3.4", "5.6.7.8", "9.10.11.12"]}"#;
        let count = engine.load_tor_exit_nodes(json).unwrap();
        assert_eq!(count, 3);

        assert!(engine.is_tor_exit_node("1.2.3.4"));
        assert!(engine.is_tor_exit_node("5.6.7.8"));
        assert!(engine.is_tor_exit_node("9.10.11.12"));
        assert!(!engine.is_tor_exit_node("10.0.0.1"));

        let entry = engine.lookup(&IocType::Ip, "1.2.3.4").unwrap();
        assert_eq!(entry.severity, IocSeverity::Medium);
        assert!(entry.tags.contains(&"tor".to_string()));
        assert!(entry.tags.contains(&"exit-node".to_string()));
    }

    #[test]
    fn test_load_tor_exit_nodes_empty() {
        let engine = IocEngine::new();
        let json = r#"{"exit_nodes": []}"#;
        let count = engine.load_tor_exit_nodes(json).unwrap();
        assert_eq!(count, 0);
        assert!(!engine.is_tor_exit_node("1.2.3.4"));
    }

    #[test]
    fn test_is_tor_exit_node_case_insensitive() {
        let engine = IocEngine::new();
        let json = r#"{"exit_nodes": ["10.0.0.1"]}"#;
        engine.load_tor_exit_nodes(json).unwrap();
        assert!(engine.is_tor_exit_node("10.0.0.1"));
        assert!(engine.is_tor_exit_node("10.0.0.1"));
    }
}
