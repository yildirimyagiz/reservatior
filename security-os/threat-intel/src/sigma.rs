use dashmap::DashMap;
use serde_json::Value;

use crate::errors::{Result, ThreatIntelError};

#[derive(Debug, Clone)]
pub struct SigmaRule {
    pub id: String,
    pub title: String,
    pub status: String,
    pub description: String,
    pub author: String,
    pub date: String,
    pub logsource: SigmaLogsource,
    pub detection: String,
    pub falsepositives: Vec<String>,
    pub level: String,
    pub tags: Vec<String>,
    pub references: Vec<String>,
}

#[derive(Debug, Clone)]
pub struct SigmaLogsource {
    pub category: Option<String>,
    pub product: Option<String>,
    pub service: Option<String>,
}

pub struct SigmaStore {
    pub(crate) rules: DashMap<String, SigmaRule>,
}

impl SigmaStore {
    pub fn new() -> Self {
        Self {
            rules: DashMap::new(),
        }
    }

    pub fn add_rule(&self, rule: SigmaRule) {
        self.rules.insert(rule.id.clone(), rule);
    }

    pub fn remove_rule(&self, rule_id: &str) -> bool {
        self.rules.remove(rule_id).is_some()
    }

    pub fn get_rule(&self, rule_id: &str) -> Option<SigmaRule> {
        self.rules.get(rule_id).map(|r| r.value().clone())
    }

    pub fn get_rules_by_tag(&self, tag: &str) -> Vec<SigmaRule> {
        self.rules
            .iter()
            .filter(|r| r.value().tags.contains(&tag.to_string()))
            .map(|r| r.value().clone())
            .collect()
    }

    pub fn get_rules_by_level(&self, level: &str) -> Vec<SigmaRule> {
        self.rules
            .iter()
            .filter(|r| r.value().level.eq_ignore_ascii_case(level))
            .map(|r| r.value().clone())
            .collect()
    }

    pub fn total_rules(&self) -> usize {
        self.rules.len()
    }

    pub fn parse_rule_from_yaml(yaml: &Value) -> Result<SigmaRule> {
        let id = yaml
            .get("id")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();

        if id.is_empty() {
            return Err(ThreatIntelError::Parse(
                "Sigma rule must have an 'id' field".into(),
            ));
        }

        let title = yaml
            .get("title")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();
        let status = yaml
            .get("status")
            .and_then(|v| v.as_str())
            .unwrap_or("experimental")
            .to_string();
        let description = yaml
            .get("description")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();
        let author = yaml
            .get("author")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();
        let date = yaml
            .get("date")
            .and_then(|v| v.as_str())
            .unwrap_or("")
            .to_string();
        let level = yaml
            .get("level")
            .and_then(|v| v.as_str())
            .unwrap_or("informational")
            .to_string();

        let logsource = if let Some(ls) = yaml.get("logsource") {
            SigmaLogsource {
                category: ls
                    .get("category")
                    .and_then(|v| v.as_str())
                    .map(String::from),
                product: ls
                    .get("product")
                    .and_then(|v| v.as_str())
                    .map(String::from),
                service: ls
                    .get("service")
                    .and_then(|v| v.as_str())
                    .map(String::from),
            }
        } else {
            SigmaLogsource {
                category: None,
                product: None,
                service: None,
            }
        };

        let detection = yaml
            .get("detection")
            .map(|v| serde_json::to_string(v).unwrap_or_default())
            .unwrap_or_default();

        let falsepositives = extract_string_array(yaml, "falsepositives");
        let tags = extract_string_array(yaml, "tags");
        let references = extract_string_array(yaml, "references");

        Ok(SigmaRule {
            id,
            title,
            status,
            description,
            author,
            date,
            logsource,
            detection,
            falsepositives,
            level,
            tags,
            references,
        })
    }
}

impl Default for SigmaStore {
    fn default() -> Self {
        Self::new()
    }
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

#[cfg(test)]
mod tests {
    use super::*;

    fn sample_rule(id: &str, tag: &str, level: &str) -> SigmaRule {
        SigmaRule {
            id: id.to_string(),
            title: format!("Rule {}", id),
            status: "stable".into(),
            description: "Test rule".into(),
            author: "tester".into(),
            date: "2025-01-01".into(),
            logsource: SigmaLogsource {
                category: Some("process_creation".into()),
                product: Some("windows".into()),
                service: None,
            },
            detection: "{}".into(),
            falsepositives: vec![],
            level: level.to_string(),
            tags: vec![tag.to_string()],
            references: vec![],
        }
    }

    #[test]
    fn test_sigma_add_remove_get() {
        let store = SigmaStore::new();
        assert_eq!(store.total_rules(), 0);

        let rule = sample_rule("001", "attack.t1059", "high");
        store.add_rule(rule);
        assert_eq!(store.total_rules(), 1);

        let found = store.get_rule("001");
        assert!(found.is_some());
        assert_eq!(found.unwrap().title, "Rule 001");

        assert!(store.get_rule("999").is_none());

        assert!(store.remove_rule("001"));
        assert_eq!(store.total_rules(), 0);
        assert!(!store.remove_rule("001"));
    }

    #[test]
    fn test_sigma_get_by_tag() {
        let store = SigmaStore::new();
        store.add_rule(sample_rule("r1", "attack.t1059", "high"));
        store.add_rule(sample_rule("r2", "attack.t1059", "medium"));
        store.add_rule(sample_rule("r3", "attack.t1027", "high"));

        let t1059 = store.get_rules_by_tag("attack.t1059");
        assert_eq!(t1059.len(), 2);

        let t1027 = store.get_rules_by_tag("attack.t1027");
        assert_eq!(t1027.len(), 1);

        let none = store.get_rules_by_tag("attack.t9999");
        assert!(none.is_empty());
    }

    #[test]
    fn test_sigma_parse_from_yaml() {
        let yaml: Value = serde_json::from_str(r#"{
            "id": "sigma-0001",
            "title": "Suspicious PowerShell Execution",
            "status": "stable",
            "description": "Detects suspicious PowerShell commands",
            "author": "SOC Team",
            "date": "2025-06-15",
            "logsource": {
                "category": "process_creation",
                "product": "windows"
            },
            "detection": {
                "selection": {"CommandLine|contains": "Invoke-Expression"},
                "condition": "selection"
            },
            "falsepositives": ["Legitimate admin scripts"],
            "level": "high",
            "tags": ["attack.execution", "attack.t1059.001"],
            "references": ["https://example.com/doc"]
        }"#).unwrap();

        let rule = SigmaStore::parse_rule_from_yaml(&yaml).unwrap();
        assert_eq!(rule.id, "sigma-0001");
        assert_eq!(rule.title, "Suspicious PowerShell Execution");
        assert_eq!(rule.status, "stable");
        assert_eq!(rule.author, "SOC Team");
        assert_eq!(rule.level, "high");
        assert!(rule.logsource.category.is_some());
        assert_eq!(rule.logsource.category.unwrap(), "process_creation");
        assert!(rule.logsource.service.is_none());
        assert_eq!(rule.falsepositives.len(), 1);
        assert!(rule.tags.contains(&"attack.execution".to_string()));
        assert!(rule.references.len() == 1);
        assert!(!rule.detection.is_empty());
    }

    #[test]
    fn test_sigma_get_by_level() {
        let store = SigmaStore::new();
        store.add_rule(sample_rule("r1", "tag1", "high"));
        store.add_rule(sample_rule("r2", "tag2", "critical"));
        store.add_rule(sample_rule("r3", "tag3", "high"));

        let high = store.get_rules_by_level("high");
        assert_eq!(high.len(), 2);

        let critical = store.get_rules_by_level("critical");
        assert_eq!(critical.len(), 1);
    }
}
