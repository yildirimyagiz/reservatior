use chrono::{DateTime, Utc};
use dashmap::DashMap;
use std::collections::HashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::{debug, warn};

const SUSPICIOUS_PATHS: &[&str] = &[
    "/tmp/", "/var/tmp/", "/dev/shm/", "/dev/mqueue/",
    "/run/user/", "/run/lock/",
    "/var/run/", "/var/lock/",
    "/proc/self/fd/", "/proc/self/exe",
    "/boot/", "/lib/modules/",
];

const KNOWN_MALICIOUS_HASHES: &[&str] = &[
    "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2",
    "d41d8cd98f00b204e9800998ecf8427e",
    "5d41402abc4b2a76b9719d911017c592",
];

const PACKED_INDICATORS: &[&str] = &[
    "UPX",
    "ASPack",
    "PECompact",
    "Themida",
    "VMProtect",
    ".packed",
    ".encrypted",
    "MEW",
    "FSG",
    "MPRESS",
    "Armadillo",
    "ExeCryptor",
];

const KNOWN_GOOD_SIGNATURES: &[&str] = &[
    "Microsoft Corporation",
    "Google LLC",
    "Apple Inc.",
    "Mozilla Corporation",
    "Canonical Ltd.",
    "Red Hat, Inc.",
    "SUSE LLC",
    "Debian",
    "Amazon.com",
    "Oracle Corporation",
];

#[derive(Debug, Clone)]
struct BinaryRecord {
    hash: String,
    path: String,
    signature: Option<String>,
    first_seen: DateTime<Utc>,
    is_signed: bool,
    is_packed: bool,
    reputation: String,
}

#[derive(Debug, Clone)]
struct ExecutionRecord {
    binary_path: String,
    timestamp: DateTime<Utc>,
    user: String,
}

pub struct BinaryReputationEngine {
    hash_reputation_cache: DashMap<String, String>,
    binary_records: DashMap<String, BinaryRecord>,
    execution_history: DashMap<String, Vec<ExecutionRecord>>,
    suspicious_executions: DashMap<String, u32>,
}

impl BinaryReputationEngine {
    pub fn new() -> Self {
        let engine = Self {
            hash_reputation_cache: DashMap::new(),
            binary_records: DashMap::new(),
            execution_history: DashMap::new(),
            suspicious_executions: DashMap::new(),
        };
        engine.register_known_malicious();
        engine
    }

    fn register_known_malicious(&self) {
        for hash in KNOWN_MALICIOUS_HASHES {
            self.hash_reputation_cache
                .insert(hash.to_string(), "malicious".to_string());
        }
    }

    fn is_suspicious_location(path: &str) -> bool {
        SUSPICIOUS_PATHS.iter().any(|sp| path.starts_with(sp))
    }

    fn is_known_good_signature(signature: &str) -> bool {
        KNOWN_GOOD_SIGNATURES
            .iter()
            .any(|s| signature.contains(s))
    }

    fn detect_unsigned_binary(
        &self,
        path: &str,
        hash: Option<&str>,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        let hash_val = hash.unwrap_or("unknown");

        if let Some(rep) = self.hash_reputation_cache.get(hash_val) {
            if rep.as_str() == "malicious" {
                return self.detect_known_malicious(hash_val, path, source);
            }
        }

        let record = self.binary_records.get(path);
        if let Some(ref r) = record {
            if r.is_signed {
                return None;
            }
        }
        drop(record);

        let mut event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Detected,
            source.clone(),
            format!("Unsigned binary executed: {}", path),
            format!(
                "Binary '{}' (hash: {}) was executed without a valid digital signature. \
                 Unsigned binaries may be tampered with or malicious.",
                path, hash_val
            ),
        )
        .with_severity(Severity::Medium)
        .with_confidence(0.60)
        .with_risk_score(45.0)
        .with_mitre(
            "Execution",
            "User Execution: Malicious File",
            "T1204.002",
        )
        .with_file(path)
        .with_tag("unsigned_binary");

        if let Some(h) = hash {
            event.file_hash_sha256 = Some(h.to_string());
        }

        event.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: path.to_string(),
            risk_contribution: 30.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    fn detect_known_malicious(
        &self,
        hash: &str,
        path: &str,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        let mut event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Detected,
            source.clone(),
            format!("Known malicious binary executed: {}", path),
            format!(
                "Binary '{}' (hash: {}) matches a known malicious hash in threat intelligence. \
                 Immediate investigation recommended.",
                path, hash
            ),
        )
        .with_severity(Severity::Critical)
        .with_confidence(1.0)
        .with_risk_score(95.0)
        .with_mitre(
            "Execution",
            "User Execution: Malicious File",
            "T1204.002",
        )
        .with_file(path)
        .with_tag("known_malicious_binary");

        event.file_hash_sha256 = Some(hash.to_string());
        event.affected_entities.push(Entity {
            entity_type: EntityType::Hash,
            value: hash.to_string(),
            risk_contribution: 50.0,
            metadata: HashMap::new(),
        });
        event.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: path.to_string(),
            risk_contribution: 30.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    fn detect_suspicious_location(
        &self,
        path: &str,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        if !Self::is_suspicious_location(path) {
            return None;
        }

        let mut event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Detected,
            source.clone(),
            format!("Binary executed from suspicious location: {}", path),
            format!(
                "Binary at '{}' was executed from a temporary or shared memory location. \
                 Attackers often stage malware in these directories.",
                path
            ),
        )
        .with_severity(Severity::High)
        .with_confidence(0.75)
        .with_risk_score(70.0)
        .with_mitre(
            "Defense Evasion",
            "Obfuscated Files or Information",
            "T1027",
        )
        .with_file(path)
        .with_tag("suspicious_binary_location");

        event.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: path.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    fn detect_packed_binary(
        &self,
        path: &str,
        content: Option<&str>,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        let data = content?;

        let is_packed = PACKED_INDICATORS
            .iter()
            .any(|indicator| data.contains(indicator));

        if !is_packed {
            return None;
        }

        let matched = PACKED_INDICATORS
            .iter()
            .find(|i| data.contains(*i))
            .unwrap_or(&"");

        let mut event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Detected,
            source.clone(),
            format!("Packed/encrypted binary detected: {}", path),
            format!(
                "Binary '{}' appears to be packed or encrypted (indicator: '{}'). \
                 Packed binaries may be used to evade detection.",
                path, matched
            ),
        )
        .with_severity(Severity::Medium)
        .with_confidence(0.70)
        .with_risk_score(55.0)
        .with_mitre(
            "Defense Evasion",
            "Obfuscated Files or Information",
            "T1027",
        )
        .with_file(path)
        .with_tag("packed_binary");

        event.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: path.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    fn record_binary(
        &mut self,
        path: &str,
        hash: Option<&str>,
        signature: Option<&str>,
        is_signed: bool,
    ) {
        let hash_val = hash.unwrap_or("unknown").to_string();
        let sig = signature.map(|s| s.to_string());

        let is_packed = false; // Would need actual PE analysis

        let reputation = if self.hash_reputation_cache.contains_key(&hash_val) {
            self.hash_reputation_cache.get(&hash_val).unwrap().clone()
        } else if is_signed && sig.as_ref().map(|s| Self::is_known_good_signature(s)).unwrap_or(false) {
            "trusted".to_string()
        } else {
            "unknown".to_string()
        };

        self.binary_records.insert(
            path.to_string(),
            BinaryRecord {
                hash: hash_val,
                path: path.to_string(),
                signature: sig,
                first_seen: Utc::now(),
                is_signed,
                is_packed,
                reputation,
            },
        );
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        if event.category == EventCategory::Process
            && (event.action == EventAction::Executed || event.action == EventAction::Started)
        {
            let path = event.exe.clone().unwrap_or_default();
            let hash = event.process_hash_sha256.as_deref();
            let sig = event.process_signature.as_deref();

            if !path.is_empty() {
                let is_signed = sig.is_some() && sig.unwrap() != "unsigned";
                self.record_binary(&path, hash, sig, is_signed);

                // Check for known malicious
                if let Some(h) = hash {
                    if let Some(rep) = self.hash_reputation_cache.get(h) {
                        if rep.as_str() == "malicious" {
                            if let Some(det) =
                                self.detect_known_malicious(h, &path, &event.source)
                            {
                                warn!("Known malicious binary: {}", det.title);
                                detections.push(det);
                            }
                        }
                    }
                }

                // Check unsigned
                if let Some(det) = self.detect_unsigned_binary(&path, hash, &event.source) {
                    warn!("Unsigned binary: {}", det.title);
                    detections.push(det);
                }

                // Check suspicious location
                if let Some(det) =
                    self.detect_suspicious_location(&path, &event.source)
                {
                    warn!("Suspicious binary location: {}", det.title);
                    detections.push(det);
                }

                // Check packed
                if let Some(content) = event
                    .metadata
                    .get("binary_content")
                    .and_then(|v| v.as_str())
                {
                    if let Some(det) =
                        self.detect_packed_binary(&path, Some(content), &event.source)
                    {
                        warn!("Packed binary: {}", det.title);
                        detections.push(det);
                    }
                }

                // Record execution
                let user = event
                    .username
                    .clone()
                    .unwrap_or_else(|| "unknown".to_string());
                self.execution_history
                    .entry(user.clone())
                    .or_default()
                    .push(ExecutionRecord {
                        binary_path: path,
                        timestamp: event.timestamp,
                        user,
                    });
            }
        }

        detections
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::HashMap;

    fn make_source() -> EventSource {
        EventSource {
            collector: "test".to_string(),
            host_id: "test-host".to_string(),
            host_name: "test".to_string(),
            agent_id: "test-agent".to_string(),
            agent_version: None,
            process_name: None,
            process_id: None,
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
            service_name: None,
        }
    }

    fn make_exec_event(
        exe: &str,
        hash: Option<&str>,
        signature: Option<&str>,
    ) -> SecurityEvent {
        let source = make_source();
        let mut event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Executed,
            source,
            format!("Binary executed: {}", exe),
            format!("Binary {} executed", exe),
        );
        event.exe = Some(exe.to_string());
        if let Some(h) = hash {
            event.process_hash_sha256 = Some(h.to_string());
        }
        if let Some(s) = signature {
            event.process_signature = Some(s.to_string());
        }
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = BinaryReputationEngine::new();
        assert!(!engine.hash_reputation_cache.is_empty());
    }

    #[test]
    fn test_known_malicious_detected() {
        let mut engine = BinaryReputationEngine::new();
        let event = make_exec_event(
            "/tmp/malware",
            Some("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"),
            None,
        );
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert_eq!(detections[0].severity, Severity::Critical);
    }

    #[test]
    fn test_suspicious_location_detected() {
        let mut engine = BinaryReputationEngine::new();
        let event = make_exec_event("/tmp/evil_script", Some("aabbccdd"), None);
        let detections = engine.process_event(&event);
        assert!(detections.iter().any(|d| d.tags.contains(&"suspicious_binary_location".to_string())));
    }

    #[test]
    fn test_packed_binary_detected() {
        let mut engine = BinaryReputationEngine::new();
        let mut event = make_exec_event("/usr/bin/packed_app", None, None);
        event.metadata.insert(
            "binary_content".to_string(),
            serde_json::Value::String("This binary is UPX packed".to_string()),
        );
        let detections = engine.process_event(&event);
        assert!(detections.iter().any(|d| d.tags.contains(&"packed_binary".to_string())));
    }
}
