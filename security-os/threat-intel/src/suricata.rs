use dashmap::DashMap;
use regex::Regex;

use crate::errors::{Result, ThreatIntelError};

#[derive(Debug, Clone)]
pub struct SuricataRule {
    pub id: String,
    pub action: String,
    pub protocol: String,
    pub src: String,
    pub src_port: String,
    pub direction: String,
    pub dst: String,
    pub dst_port: String,
    pub msg: String,
    pub sid: u64,
    pub rev: u32,
    pub classtype: Option<String>,
    pub severity: Option<u8>,
    pub metadata: Vec<String>,
    pub raw_rule: String,
}

pub struct SuricataStore {
    rules: DashMap<String, SuricataRule>,
}

impl SuricataStore {
    pub fn new() -> Self {
        Self {
            rules: DashMap::new(),
        }
    }

    pub fn add_rule(&self, rule: SuricataRule) {
        self.rules.insert(rule.id.clone(), rule);
    }

    pub fn get_rule(&self, sid: u64) -> Option<SuricataRule> {
        for entry in self.rules.iter() {
            if entry.value().sid == sid {
                return Some(entry.value().clone());
            }
        }
        None
    }

    pub fn get_rules_by_classtype(&self, classtype: &str) -> Vec<SuricataRule> {
        self.rules
            .iter()
            .filter(|r| {
                r.value()
                    .classtype
                    .as_ref()
                    .map(|ct| ct.eq_ignore_ascii_case(classtype))
                    .unwrap_or(false)
            })
            .map(|r| r.value().clone())
            .collect()
    }

    pub fn total_rules(&self) -> usize {
        self.rules.len()
    }

    pub fn parse_rule(line: &str) -> Result<SuricataRule> {
        let line = line.trim();

        if line.is_empty() || line.starts_with('#') {
            return Err(ThreatIntelError::Parse(
                "empty or commented rule".into(),
            ));
        }

        let header_re = Regex::new(
            r"^(alert|drop|reject|pass)\s+(\S+)\s+(\S+)\s+(\S+)\s+(->|<>)\s+(\S+)\s+(\S+)\s*\((.+)\)$"
        ).map_err(|e| ThreatIntelError::Parse(format!("regex error: {}", e)))?;

        let caps = header_re
            .captures(line)
            .ok_or_else(|| ThreatIntelError::Parse(format!("failed to parse Suricata rule header: {}", line)))?;

        let action = caps.get(1).unwrap().as_str().to_string();
        let protocol = caps.get(2).unwrap().as_str().to_string();
        let src = caps.get(3).unwrap().as_str().to_string();
        let src_port = caps.get(4).unwrap().as_str().to_string();
        let direction = caps.get(5).unwrap().as_str().to_string();
        let dst = caps.get(6).unwrap().as_str().to_string();
        let dst_port = caps.get(7).unwrap().as_str().to_string();
        let options_str = caps.get(8).unwrap().as_str();

        let mut msg = String::new();
        let mut sid: u64 = 0;
        let mut rev: u32 = 0;
        let mut classtype: Option<String> = None;
        let mut severity: Option<u8> = None;
        let mut metadata: Vec<String> = Vec::new();

        let msg_re = Regex::new(r#"msg:\s*"([^"]+)""#).unwrap();
        if let Some(m) = msg_re.captures(options_str) {
            msg = m.get(1).unwrap().as_str().to_string();
        }

        let sid_re = Regex::new(r"sid:\s*(\d+)").unwrap();
        if let Some(m) = sid_re.captures(options_str) {
            sid = m.get(1)
                .unwrap()
                .as_str()
                .parse::<u64>()
                .map_err(|e| ThreatIntelError::Parse(format!("invalid sid: {}", e)))?;
        }

        let rev_re = Regex::new(r"rev:\s*(\d+)").unwrap();
        if let Some(m) = rev_re.captures(options_str) {
            rev = m.get(1)
                .unwrap()
                .as_str()
                .parse::<u32>()
                .map_err(|e| ThreatIntelError::Parse(format!("invalid rev: {}", e)))?;
        }

        let ct_re = Regex::new(r"classtype:\s*(\S+?)(?:\s*;|$)").unwrap();
        if let Some(m) = ct_re.captures(options_str) {
            classtype = Some(m.get(1).unwrap().as_str().to_string());
        }

        let prio_re = Regex::new(r"priority:\s*(\d+)").unwrap();
        if let Some(m) = prio_re.captures(options_str) {
            severity = m.get(1)
                .unwrap()
                .as_str()
                .parse::<u8>()
                .ok();
        }

        let meta_re = Regex::new(r#"metadata:\s*([^;]+)"#).unwrap();
        if let Some(m) = meta_re.captures(options_str) {
            let meta_str = m.get(1).unwrap().as_str();
            for entry in meta_str.split(',') {
                let trimmed = entry.trim().to_string();
                if !trimmed.is_empty() {
                    metadata.push(trimmed);
                }
            }
        }

        if sid == 0 {
            return Err(ThreatIntelError::Parse(
                "Suricata rule must have a valid sid".into(),
            ));
        }

        let id = format!("suricata-{}", sid);

        Ok(SuricataRule {
            id,
            action,
            protocol,
            src,
            src_port,
            direction,
            dst,
            dst_port,
            msg,
            sid,
            rev,
            classtype,
            severity,
            metadata,
            raw_rule: line.to_string(),
        })
    }
}

impl Default for SuricataStore {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_suricata_rule() {
        let rule_str = r#"alert http any any -> $HOME_NET any (msg:"ET MALWARE Possible malware download"; flow:established,to_server; content:"GET"; http_method; content:"/download/"; http_uri; classtype:trojan-activity; sid:2024001; rev:3; metadata:severity critical,category malware;)"#;

        let rule = SuricataStore::parse_rule(rule_str).unwrap();
        assert_eq!(rule.action, "alert");
        assert_eq!(rule.protocol, "http");
        assert_eq!(rule.src, "any");
        assert_eq!(rule.src_port, "any");
        assert_eq!(rule.direction, "->");
        assert_eq!(rule.dst, "$HOME_NET");
        assert_eq!(rule.dst_port, "any");
        assert_eq!(rule.msg, "ET MALWARE Possible malware download");
        assert_eq!(rule.sid, 2024001);
        assert_eq!(rule.rev, 3);
        assert_eq!(rule.classtype.as_deref(), Some("trojan-activity"));
        assert!(rule.metadata.contains(&"severity critical".to_string()));
        assert!(rule.metadata.contains(&"category malware".to_string()));
    }

    #[test]
    fn test_suricata_store_add_and_get() {
        let store = SuricataStore::new();
        assert_eq!(store.total_rules(), 0);

        let rule = SuricataRule {
            id: "suricata-100".into(),
            action: "alert".into(),
            protocol: "tcp".into(),
            src: "any".into(),
            src_port: "any".into(),
            direction: "->".into(),
            dst: "$HOME_NET".into(),
            dst_port: "443".into(),
            msg: "Test rule".into(),
            sid: 100,
            rev: 1,
            classtype: Some("attempted-admin".into()),
            severity: Some(1),
            metadata: vec![],
            raw_rule: "alert tcp any any -> $HOME_NET 443 (msg:\"Test rule\"; sid:100; rev:1;)".into(),
        };

        store.add_rule(rule);
        assert_eq!(store.total_rules(), 1);

        let found = store.get_rule(100);
        assert!(found.is_some());
        assert_eq!(found.unwrap().msg, "Test rule");

        assert!(store.get_rule(999).is_none());
    }

    #[test]
    fn test_suricata_store_get_by_classtype() {
        let store = SuricataStore::new();

        store.add_rule(SuricataRule {
            id: "s1".into(),
            action: "alert".into(),
            protocol: "tcp".into(),
            src: "any".into(),
            src_port: "any".into(),
            direction: "->".into(),
            dst: "any".into(),
            dst_port: "80".into(),
            msg: "Rule 1".into(),
            sid: 1,
            rev: 1,
            classtype: Some("trojan-activity".into()),
            severity: None,
            metadata: vec![],
            raw_rule: String::new(),
        });

        store.add_rule(SuricataRule {
            id: "s2".into(),
            action: "alert".into(),
            protocol: "tcp".into(),
            src: "any".into(),
            src_port: "any".into(),
            direction: "->".into(),
            dst: "any".into(),
            dst_port: "443".into(),
            msg: "Rule 2".into(),
            sid: 2,
            rev: 1,
            classtype: Some("attempted-admin".into()),
            severity: None,
            metadata: vec![],
            raw_rule: String::new(),
        });

        store.add_rule(SuricataRule {
            id: "s3".into(),
            action: "alert".into(),
            protocol: "tcp".into(),
            src: "any".into(),
            src_port: "any".into(),
            direction: "->".into(),
            dst: "any".into(),
            dst_port: "445".into(),
            msg: "Rule 3".into(),
            sid: 3,
            rev: 1,
            classtype: Some("trojan-activity".into()),
            severity: None,
            metadata: vec![],
            raw_rule: String::new(),
        });

        let trojan = store.get_rules_by_classtype("trojan-activity");
        assert_eq!(trojan.len(), 2);

        let admin = store.get_rules_by_classtype("attempted-admin");
        assert_eq!(admin.len(), 1);

        let none = store.get_rules_by_classtype("nonexistent");
        assert!(none.is_empty());
    }
}
