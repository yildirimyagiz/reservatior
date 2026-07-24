use chrono::{DateTime, Utc};
use dashmap::DashMap;
use regex::Regex;
use serde_json::Value;

use crate::errors::{Result, ThreatIntelError};
use security_os_core::SecurityEvent;

#[derive(Debug, Clone)]
pub struct StixBundle {
    pub id: String,
    pub spec_version: String,
    pub objects: Vec<StixObject>,
}

#[derive(Debug, Clone)]
pub enum StixObject {
    AttackPattern(StixAttackPattern),
    Campaign(StixCampaign),
    Indicator(StixIndicator),
    IntrusionSet(StixIntrusionSet),
    Malware(StixMalware),
    ThreatActor(StixThreatActor),
    Tool(StixTool),
    Vulnerability(StixVulnerability),
    Report(StixReport),
    Relationship(StixRelationship),
    Observable(StixObservable),
}

#[derive(Debug, Clone)]
pub struct StixAttackPattern {
    pub id: String,
    pub name: String,
    pub description: Option<String>,
    pub kill_chain_phases: Vec<String>,
}

#[derive(Debug, Clone)]
pub struct StixCampaign {
    pub id: String,
    pub name: String,
    pub description: Option<String>,
    pub first_seen: Option<DateTime<Utc>>,
    pub last_seen: Option<DateTime<Utc>>,
    pub objective: Option<String>,
}

#[derive(Debug, Clone)]
pub struct StixIndicator {
    pub id: String,
    pub name: String,
    pub description: Option<String>,
    pub pattern: String,
    pub pattern_type: String,
    pub valid_from: DateTime<Utc>,
    pub valid_until: Option<DateTime<Utc>>,
    pub labels: Vec<String>,
    pub kill_chain_phases: Vec<String>,
    pub confidence: Option<u32>,
}

#[derive(Debug, Clone)]
pub struct StixIntrusionSet {
    pub id: String,
    pub name: String,
    pub description: Option<String>,
    pub aliases: Vec<String>,
    pub first_seen: Option<DateTime<Utc>>,
    pub last_seen: Option<DateTime<Utc>>,
}

#[derive(Debug, Clone)]
pub struct StixMalware {
    pub id: String,
    pub name: String,
    pub is_family: bool,
    pub labels: Vec<String>,
    pub kill_chain_phases: Vec<String>,
    pub first_seen: Option<DateTime<Utc>>,
    pub last_seen: Option<DateTime<Utc>>,
}

#[derive(Debug, Clone)]
pub struct StixThreatActor {
    pub id: String,
    pub name: String,
    pub description: Option<String>,
    pub threat_actor_types: Vec<String>,
    pub sophistication: Option<String>,
    pub goals: Vec<String>,
}

#[derive(Debug, Clone)]
pub struct StixTool {
    pub id: String,
    pub name: String,
    pub description: Option<String>,
    pub tool_types: Vec<String>,
    pub kill_chain_phases: Vec<String>,
}

#[derive(Debug, Clone)]
pub struct StixVulnerability {
    pub id: String,
    pub name: String,
    pub description: Option<String>,
    pub cve_id: Option<String>,
    pub cvss_score: Option<f64>,
}

#[derive(Debug, Clone)]
pub struct StixReport {
    pub id: String,
    pub name: String,
    pub description: Option<String>,
    pub published: DateTime<Utc>,
    pub report_types: Vec<String>,
    pub object_refs: Vec<String>,
}

#[derive(Debug, Clone)]
pub struct StixRelationship {
    pub id: String,
    pub relationship_type: String,
    pub source_ref: String,
    pub target_ref: String,
    pub description: Option<String>,
}

#[derive(Debug, Clone)]
pub struct StixObservable {
    pub id: String,
    pub object_type: String,
    pub value: String,
    pub description: Option<String>,
}

pub struct StixParser;

impl StixParser {
    pub fn parse_bundle(json: &Value) -> Result<StixBundle> {
        let id = json
            .get("id")
            .and_then(|v| v.as_str())
            .unwrap_or("unknown")
            .to_string();
        let spec_version = json
            .get("spec_version")
            .and_then(|v| v.as_str())
            .unwrap_or("2.1")
            .to_string();

        let mut objects = Vec::new();
        if let Some(obj_array) = json.get("objects").and_then(|v| v.as_array()) {
            for obj_json in obj_array {
                let obj = Self::parse_object(obj_json)?;
                objects.push(obj);
            }
        }

        Ok(StixBundle {
            id,
            spec_version,
            objects,
        })
    }

    pub fn parse_object(json: &Value) -> Result<StixObject> {
        let obj_type = json
            .get("type")
            .and_then(|v| v.as_str())
            .ok_or_else(|| ThreatIntelError::Parse("missing 'type' field".into()))?;

        match obj_type {
            "attack-pattern" => Ok(StixObject::AttackPattern(Self::parse_attack_pattern(json)?)),
            "campaign" => Ok(StixObject::Campaign(Self::parse_campaign(json)?)),
            "indicator" => Ok(StixObject::Indicator(Self::parse_indicator(json)?)),
            "intrusion-set" => Ok(StixObject::IntrusionSet(Self::parse_intrusion_set(json)?)),
            "malware" => Ok(StixObject::Malware(Self::parse_malware(json)?)),
            "threat-actor" => Ok(StixObject::ThreatActor(Self::parse_threat_actor(json)?)),
            "tool" => Ok(StixObject::Tool(Self::parse_tool(json)?)),
            "vulnerability" => Ok(StixObject::Vulnerability(Self::parse_vulnerability(json)?)),
            "report" => Ok(StixObject::Report(Self::parse_report(json)?)),
            "relationship" => Ok(StixObject::Relationship(Self::parse_relationship(json)?)),
            "artifact" | "file" | "ipv4-addr" | "ipv6-addr" | "domain-name" | "url" => {
                Ok(StixObject::Observable(Self::parse_observable(json)?))
            }
            other => Err(ThreatIntelError::Parse(format!(
                "unsupported STIX type: {}",
                other
            ))),
        }
    }

    fn parse_attack_pattern(json: &Value) -> Result<StixAttackPattern> {
        Ok(StixAttackPattern {
            id: string_or(json, "id", "unknown"),
            name: string_or(json, "name", "unknown"),
            description: json
                .get("description")
                .and_then(|v| v.as_str())
                .map(String::from),
            kill_chain_phases: extract_kill_chain(json),
        })
    }

    fn parse_campaign(json: &Value) -> Result<StixCampaign> {
        Ok(StixCampaign {
            id: string_or(json, "id", "unknown"),
            name: string_or(json, "name", "unknown"),
            description: optional_string(json, "description"),
            first_seen: optional_datetime(json, "first_seen"),
            last_seen: optional_datetime(json, "last_seen"),
            objective: optional_string(json, "objective"),
        })
    }

    pub fn parse_indicator(json: &Value) -> Result<StixIndicator> {
        let valid_from = optional_datetime(json, "valid_from")
            .unwrap_or_else(Utc::now);

        Ok(StixIndicator {
            id: string_or(json, "id", "unknown"),
            name: string_or(json, "name", "unknown"),
            description: optional_string(json, "description"),
            pattern: string_or(json, "pattern", ""),
            pattern_type: string_or(json, "pattern_type", "stix"),
            valid_from,
            valid_until: optional_datetime(json, "valid_until"),
            labels: extract_string_array(json, "labels"),
            kill_chain_phases: extract_kill_chain(json),
            confidence: json
                .get("confidence")
                .and_then(|v| v.as_u64())
                .map(|v| v as u32),
        })
    }

    fn parse_intrusion_set(json: &Value) -> Result<StixIntrusionSet> {
        Ok(StixIntrusionSet {
            id: string_or(json, "id", "unknown"),
            name: string_or(json, "name", "unknown"),
            description: optional_string(json, "description"),
            aliases: extract_string_array(json, "aliases"),
            first_seen: optional_datetime(json, "first_seen"),
            last_seen: optional_datetime(json, "last_seen"),
        })
    }

    pub fn parse_malware(json: &Value) -> Result<StixMalware> {
        Ok(StixMalware {
            id: string_or(json, "id", "unknown"),
            name: string_or(json, "name", "unknown"),
            is_family: json
                .get("is_family")
                .and_then(|v| v.as_bool())
                .unwrap_or(false),
            labels: extract_string_array(json, "labels"),
            kill_chain_phases: extract_kill_chain(json),
            first_seen: optional_datetime(json, "first_seen"),
            last_seen: optional_datetime(json, "last_seen"),
        })
    }

    fn parse_threat_actor(json: &Value) -> Result<StixThreatActor> {
        Ok(StixThreatActor {
            id: string_or(json, "id", "unknown"),
            name: string_or(json, "name", "unknown"),
            description: optional_string(json, "description"),
            threat_actor_types: extract_string_array(json, "threat_actor_types"),
            sophistication: optional_string(json, "sophistication"),
            goals: extract_string_array(json, "goals"),
        })
    }

    fn parse_tool(json: &Value) -> Result<StixTool> {
        Ok(StixTool {
            id: string_or(json, "id", "unknown"),
            name: string_or(json, "name", "unknown"),
            description: optional_string(json, "description"),
            tool_types: extract_string_array(json, "tool_types"),
            kill_chain_phases: extract_kill_chain(json),
        })
    }

    fn parse_vulnerability(json: &Value) -> Result<StixVulnerability> {
        let cve_id = optional_string(json, "cve_id")
            .or_else(|| {
                if let Some(references) = json.get("external_references").and_then(|v| v.as_array()) {
                    for ref_obj in references {
                        if let Some(source_name) = ref_obj.get("source_name").and_then(|v| v.as_str()) {
                            if source_name == "cve" {
                                return ref_obj.get("external_id").and_then(|v| v.as_str()).map(String::from);
                            }
                        }
                    }
                }
                None
            });
        Ok(StixVulnerability {
            id: string_or(json, "id", "unknown"),
            name: string_or(json, "name", "unknown"),
            description: optional_string(json, "description"),
            cve_id,
            cvss_score: json
                .get("x_cvss_score")
                .and_then(|v| v.as_f64()),
        })
    }

    fn parse_report(json: &Value) -> Result<StixReport> {
        Ok(StixReport {
            id: string_or(json, "id", "unknown"),
            name: string_or(json, "name", "unknown"),
            description: optional_string(json, "description"),
            published: optional_datetime(json, "published").unwrap_or_else(Utc::now),
            report_types: extract_string_array(json, "report_types"),
            object_refs: extract_string_array(json, "object_refs"),
        })
    }

    pub fn parse_relationship(json: &Value) -> Result<StixRelationship> {
        Ok(StixRelationship {
            id: string_or(json, "id", "unknown"),
            relationship_type: string_or(json, "relationship_type", "unknown"),
            source_ref: string_or(json, "source_ref", "unknown"),
            target_ref: string_or(json, "target_ref", "unknown"),
            description: optional_string(json, "description"),
        })
    }

    fn parse_observable(json: &Value) -> Result<StixObservable> {
        let obj_type = string_or(json, "type", "unknown");
        let value = match obj_type.as_str() {
            "ipv4-addr" | "ipv6-addr" => {
                json.get("value")
                    .and_then(|v| v.as_str())
                    .unwrap_or("")
                    .to_string()
            }
            "domain-name" => {
                json.get("value")
                    .and_then(|v| v.as_str())
                    .unwrap_or("")
                    .to_string()
            }
            "url" => {
                json.get("value")
                    .and_then(|v| v.as_str())
                    .unwrap_or("")
                    .to_string()
            }
            "file" => {
                let hashes = json.get("hashes").and_then(|v| v.as_object());
                if let Some(h) = hashes {
                    if let Some(sha256) = h.get("SHA-256").and_then(|v| v.as_str()) {
                        sha256.to_string()
                    } else if let Some(md5) = h.get("MD5").and_then(|v| v.as_str()) {
                        md5.to_string()
                    } else {
                        String::new()
                    }
                } else {
                    String::new()
                }
            }
            "artifact" => {
                json.get("payload_bin")
                    .and_then(|v| v.as_str())
                    .unwrap_or("")
                    .to_string()
            }
            _ => String::new(),
        };

        Ok(StixObservable {
            id: string_or(json, "id", "unknown"),
            object_type: obj_type,
            value,
            description: optional_string(json, "description"),
        })
    }

    /// Extract IoC values from STIX indicator patterns.
    pub fn extract_iocs_from_pattern(pattern: &str) -> Vec<(String, String)> {
        let mut iocs = Vec::new();

        let ipv4_re = Regex::new(r"ipv4-addr:value\s*=\s*'([\d.]+)'").unwrap();
        for cap in ipv4_re.captures_iter(pattern) {
            if let Some(val) = cap.get(1) {
                iocs.push(("ip".to_string(), val.as_str().to_string()));
            }
        }

        let ipv6_re = Regex::new(r"ipv6-addr:value\s*=\s*'([\da-fA-F:]+)'").unwrap();
        for cap in ipv6_re.captures_iter(pattern) {
            if let Some(val) = cap.get(1) {
                iocs.push(("ip".to_string(), val.as_str().to_string()));
            }
        }

        let domain_re = Regex::new(r"domain-name:value\s*=\s*'([^']+)'").unwrap();
        for cap in domain_re.captures_iter(pattern) {
            if let Some(val) = cap.get(1) {
                iocs.push(("domain".to_string(), val.as_str().to_string()));
            }
        }

        let url_re = Regex::new(r"url:value\s*=\s*'([^']+)'").unwrap();
        for cap in url_re.captures_iter(pattern) {
            if let Some(val) = cap.get(1) {
                iocs.push(("url".to_string(), val.as_str().to_string()));
            }
        }

        let file_sha256_re = Regex::new(r"file:hashes\.'SHA-256'\s*=\s*'([a-fA-F0-9]{64})'").unwrap();
        for cap in file_sha256_re.captures_iter(pattern) {
            if let Some(val) = cap.get(1) {
                iocs.push(("sha256".to_string(), val.as_str().to_string()));
            }
        }

        let file_md5_re = Regex::new(r"file:hashes\.'MD5'\s*=\s*'([a-fA-F0-9]{32})'").unwrap();
        for cap in file_md5_re.captures_iter(pattern) {
            if let Some(val) = cap.get(1) {
                iocs.push(("md5".to_string(), val.as_str().to_string()));
            }
        }

        iocs
    }
}

pub struct StixStore {
    bundles: DashMap<String, StixBundle>,
    indicators: DashMap<String, StixIndicator>,
    malware: DashMap<String, StixMalware>,
}

impl StixStore {
    pub fn new() -> Self {
        Self {
            bundles: DashMap::new(),
            indicators: DashMap::new(),
            malware: DashMap::new(),
        }
    }

    pub fn add_bundle(&self, bundle: StixBundle) {
        for obj in &bundle.objects {
            match obj {
                StixObject::Indicator(ind) => {
                    self.indicators.insert(ind.id.clone(), ind.clone());
                }
                StixObject::Malware(mal) => {
                    self.malware.insert(mal.id.clone(), mal.clone());
                }
                _ => {}
            }
        }
        self.bundles.insert(bundle.id.clone(), bundle);
    }

    pub fn lookup_indicator(&self, pattern: &str) -> Option<StixIndicator> {
        for entry in self.indicators.iter() {
            if entry.value().pattern == pattern {
                return Some(entry.value().clone());
            }
        }
        None
    }

    pub fn get_indicators(&self) -> Vec<StixIndicator> {
        self.indicators
            .iter()
            .map(|r| r.value().clone())
            .collect()
    }

    pub fn get_malware(&self) -> Vec<StixMalware> {
        self.malware.iter().map(|r| r.value().clone()).collect()
    }

    pub fn total_objects(&self) -> usize {
        let mut total = 0;
        for bundle in self.bundles.iter() {
            total += bundle.value().objects.len();
        }
        total
    }

    /// Match a SecurityEvent against STIX indicators.
    pub fn match_event(&self, event: &SecurityEvent) -> Vec<StixIndicator> {
        let mut matches = Vec::new();
        for entry in self.indicators.iter() {
            let ind = entry.value();
            let iocs = StixParser::extract_iocs_from_pattern(&ind.pattern);
            for (_ioc_type, ioc_value) in &iocs {
                let lower = ioc_value.to_lowercase();
                if let Some(ref ip) = event.src_ip {
                    if ip.to_lowercase() == lower {
                        matches.push(ind.clone());
                        continue;
                    }
                }
                if let Some(ref ip) = event.dst_ip {
                    if ip.to_lowercase() == lower {
                        matches.push(ind.clone());
                        continue;
                    }
                }
                if let Some(ref path) = event.file_path {
                    if path.to_lowercase().contains(&lower) {
                        matches.push(ind.clone());
                        continue;
                    }
                }
                if let Some(ref hash) = event.file_hash_sha256 {
                    if hash.to_lowercase() == lower {
                        matches.push(ind.clone());
                        continue;
                    }
                }
                if let Some(ref hash) = event.process_hash_sha256 {
                    if hash.to_lowercase() == lower {
                        matches.push(ind.clone());
                        continue;
                    }
                }
                if let Some(ref url) = event.metadata.get("url").and_then(|v| v.as_str()) {
                    if url.to_lowercase() == lower {
                        matches.push(ind.clone());
                        continue;
                    }
                }
                if let Some(ref domain) = event.metadata.get("domain").and_then(|v| v.as_str()) {
                    if domain.to_lowercase() == lower {
                        matches.push(ind.clone());
                        continue;
                    }
                }
            }
        }
        matches
    }
}

impl Default for StixStore {
    fn default() -> Self {
        Self::new()
    }
}

fn string_or(json: &Value, key: &str, default: &str) -> String {
    json.get(key)
        .and_then(|v| v.as_str())
        .unwrap_or(default)
        .to_string()
}

fn optional_string(json: &Value, key: &str) -> Option<String> {
    json.get(key)
        .and_then(|v| v.as_str())
        .map(String::from)
}

fn optional_datetime(json: &Value, key: &str) -> Option<DateTime<Utc>> {
    json.get(key)
        .and_then(|v| v.as_str())
        .and_then(|s| DateTime::parse_from_rfc3339(s).ok())
        .map(|dt| dt.with_timezone(&Utc))
}

fn extract_string_array(json: &Value, key: &str) -> Vec<String> {
    json.get(key)
        .and_then(|v| v.as_array())
        .map(|arr| {
            arr.iter()
                .filter_map(|v| v.as_str().map(String::from))
                .collect()
        })
        .unwrap_or_default()
}

fn extract_kill_chain(json: &Value) -> Vec<String> {
    json.get("kill_chain_phases")
        .and_then(|v| v.as_array())
        .map(|arr| {
            arr.iter()
                .filter_map(|phase| {
                    let phase_name = phase.get("phase_name").and_then(|v| v.as_str())?;
                    let kill_chain = phase.get("kill_chain_name").and_then(|v| v.as_str()).unwrap_or("unknown");
                    Some(format!("{}:{}", kill_chain, phase_name))
                })
                .collect()
        })
        .unwrap_or_default()
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn test_parse_stix_bundle() {
        let json: Value = serde_json::from_str(r#"{
            "type": "bundle",
            "id": "bundle--1234",
            "spec_version": "2.1",
            "objects": [
                {
                    "type": "indicator",
                    "id": "indicator--abcd",
                    "name": "Test IOC",
                    "pattern": "[ipv4-addr:value = '10.0.0.1']",
                    "pattern_type": "stix",
                    "valid_from": "2025-01-15T00:00:00Z",
                    "labels": ["malicious-activity"],
                    "confidence": 85
                },
                {
                    "type": "malware",
                    "id": "malware--efgh",
                    "name": "Emotet",
                    "is_family": true,
                    "labels": ["trojan", "banker"]
                }
            ]
        }"#).unwrap();

        let bundle = StixParser::parse_bundle(&json).unwrap();
        assert_eq!(bundle.id, "bundle--1234");
        assert_eq!(bundle.spec_version, "2.1");
        assert_eq!(bundle.objects.len(), 2);
    }

    #[test]
    fn test_parse_stix_indicator() {
        let json: Value = serde_json::from_str(r#"{
            "type": "indicator",
            "id": "indicator--test123",
            "name": "Known C2 IP",
            "description": "Command and control server",
            "pattern": "[ipv4-addr:value = '192.168.1.100']",
            "pattern_type": "stix",
            "valid_from": "2025-06-01T12:00:00Z",
            "valid_until": "2025-12-31T23:59:59Z",
            "labels": ["c2", "malicious-activity"],
            "kill_chain_phases": [{"kill_chain_name": "lockheed-martin-cyber-kill-chain", "phase_name": "command-and-control"}],
            "confidence": 95
        }"#).unwrap();

        let indicator = StixParser::parse_indicator(&json).unwrap();
        assert_eq!(indicator.id, "indicator--test123");
        assert_eq!(indicator.name, "Known C2 IP");
        assert_eq!(indicator.pattern, "[ipv4-addr:value = '192.168.1.100']");
        assert!(indicator.valid_until.is_some());
        assert_eq!(indicator.confidence, Some(95));
        assert!(indicator.labels.contains(&"c2".to_string()));
    }

    #[test]
    fn test_parse_stix_malware() {
        let json: Value = serde_json::from_str(r#"{
            "type": "malware",
            "id": "malware--xyz",
            "name": "TrickBot",
            "is_family": true,
            "labels": ["trojan", "banker", "ransomware"],
            "first_seen": "2024-01-01T00:00:00Z",
            "last_seen": "2025-03-15T00:00:00Z"
        }"#).unwrap();

        let malware = StixParser::parse_malware(&json).unwrap();
        assert_eq!(malware.id, "malware--xyz");
        assert_eq!(malware.name, "TrickBot");
        assert!(malware.is_family);
        assert_eq!(malware.labels.len(), 3);
        assert!(malware.first_seen.is_some());
        assert!(malware.last_seen.is_some());
    }

    #[test]
    fn test_stix_store_add_and_lookup() {
        let store = StixStore::new();

        let indicator_json: Value = serde_json::from_str(r#"{
            "type": "indicator",
            "id": "indicator--store1",
            "name": "Malicious Hash",
            "pattern": "file:hashes.'SHA-256' = 'aabbccdd11223344'",
            "pattern_type": "stix",
            "valid_from": "2025-01-01T00:00:00Z",
            "labels": ["malware"]
        }"#).unwrap();

        let indicator = StixParser::parse_indicator(&indicator_json).unwrap();
        let bundle = StixBundle {
            id: "bundle--test".into(),
            spec_version: "2.1".into(),
            objects: vec![StixObject::Indicator(indicator)],
        };

        store.add_bundle(bundle);
        assert_eq!(store.total_objects(), 1);

        let found = store.lookup_indicator("file:hashes.'SHA-256' = 'aabbccdd11223344'");
        assert!(found.is_some());
        assert_eq!(found.unwrap().name, "Malicious Hash");

        let not_found = store.lookup_indicator("file:hashes.'SHA-256' = 'nothere'");
        assert!(not_found.is_none());
    }

    #[test]
    fn test_stix_store_total_objects() {
        let store = StixStore::new();

        let ind_json: Value = serde_json::from_str(r#"{
            "type": "indicator",
            "id": "indicator--a",
            "name": "A",
            "pattern": "[ipv4-addr:value = '1.1.1.1']",
            "pattern_type": "stix",
            "valid_from": "2025-01-01T00:00:00Z"
        }"#).unwrap();

        let mal_json: Value = serde_json::from_str(r#"{
            "type": "malware",
            "id": "malware--b",
            "name": "B",
            "is_family": false
        }"#).unwrap();

        let ind = StixParser::parse_indicator(&ind_json).unwrap();
        let mal = StixParser::parse_malware(&mal_json).unwrap();

        let bundle = StixBundle {
            id: "bundle--1".into(),
            spec_version: "2.1".into(),
            objects: vec![StixObject::Indicator(ind), StixObject::Malware(mal)],
        };
        store.add_bundle(bundle);
        assert_eq!(store.total_objects(), 2);
        assert_eq!(store.get_indicators().len(), 1);
        assert_eq!(store.get_malware().len(), 1);
    }
}
