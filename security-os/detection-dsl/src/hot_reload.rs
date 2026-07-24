use std::collections::hash_map::DefaultHasher;
use std::hash::{Hash, Hasher};
use std::path::{Path, PathBuf};
use std::time::Duration;

use dashmap::DashMap;
use tracing::{error, info};

use crate::ast::DslRule;
use crate::errors::DslError;
use crate::parser::DslParser;

pub struct HotReloadManager {
    rules_dir: PathBuf,
    rules: DashMap<String, DslRule>,
    rule_hashes: DashMap<String, String>,
    interval: Duration,
}

impl HotReloadManager {
    pub fn new(rules_dir: PathBuf) -> Self {
        Self {
            rules_dir,
            rules: DashMap::new(),
            rule_hashes: DashMap::new(),
            interval: Duration::from_secs(30),
        }
    }

    pub async fn start_watching(&self) -> Result<(), DslError> {
        loop {
            match self.load_rules_from_dir() {
                Ok(new_rules) => {
                    info!("hot-reload: loaded {} rules from disk", new_rules.len());
                }
                Err(e) => {
                    error!("hot-reload error: {}", e);
                }
            }
            tokio::time::sleep(self.interval).await;
        }
    }

    pub fn load_rules_from_dir(&self) -> Result<Vec<DslRule>, DslError> {
        let mut rules = Vec::new();

        let entries = std::fs::read_dir(&self.rules_dir).map_err(|e| DslError::HotReload {
            path: self.rules_dir.clone(),
            message: e.to_string(),
        })?;

        for entry in entries {
            let entry = entry.map_err(|e| DslError::HotReload {
                path: self.rules_dir.clone(),
                message: e.to_string(),
            })?;

            let path = entry.path();
            if path.extension().and_then(|e| e.to_str()) == Some("dl") {
                match self.load_rule_from_file(&path) {
                    Ok(rule) => {
                        let file_hash = file_hash(&path);
                        let name = rule.name.clone();

                        let changed = match self.rule_hashes.get(&name) {
                            Some(existing) => *existing.value() != file_hash,
                            None => true,
                        };

                        if changed {
                            self.rule_hashes.insert(name.clone(), file_hash);
                            self.rules.insert(name, rule.clone());
                            rules.push(rule);
                        }
                    }
                    Err(e) => {
                        error!("failed to load rule from {}: {}", path.display(), e);
                    }
                }
            }
        }

        Ok(rules)
    }

    pub fn load_rule_from_file(&self, path: &Path) -> Result<DslRule, DslError> {
        let content = std::fs::read_to_string(path).map_err(DslError::IoError)?;
        DslParser::parse(&content).map_err(|e| DslError::HotReload {
            path: path.to_path_buf(),
            message: e.to_string(),
        })
    }

    pub fn active_rules(&self) -> Vec<DslRule> {
        self.rules
            .iter()
            .map(|entry| entry.value().clone())
            .collect()
    }
}

fn file_hash(path: &Path) -> String {
    match std::fs::read(path) {
        Ok(data) => {
            let mut hasher = DefaultHasher::new();
            data.hash(&mut hasher);
            format!("{:x}", hasher.finish())
        }
        Err(_) => String::new(),
    }
}

// ── Tests ─────────────────────────────────────────────────────────────────────
#[cfg(test)]
mod tests {
    use super::*;
    use std::fs;

    #[test]
    fn load_rules_from_dir() {
        let dir = std::env::temp_dir().join("detection-dsl-test-dir");
        let _ = fs::remove_dir_all(&dir);
        fs::create_dir_all(&dir).unwrap();

        let rule_content = r#"
rule "Dir Rule" {
    description: "loaded from directory"
    severity: medium
    condition: event.category == "Authentication"
    tags: ["dir-test"]
}
"#;
        fs::write(dir.join("test_rule.dl"), rule_content).unwrap();

        let mgr = HotReloadManager::new(dir.clone());
        let rules = mgr.load_rules_from_dir().unwrap();
        assert_eq!(rules.len(), 1);
        assert_eq!(rules[0].name, "Dir Rule");
        assert_eq!(rules[0].severity, security_os_core::Severity::Medium);

        let _ = fs::remove_dir_all(&dir);
    }

    #[test]
    fn load_rule_from_file() {
        let dir = std::env::temp_dir().join("detection-dsl-test-file");
        let _ = fs::remove_dir_all(&dir);
        fs::create_dir_all(&dir).unwrap();

        let rule_content = r#"
rule "File Rule" {
    description: "loaded from file"
    severity: critical
    condition: event.category == "Network" && event.action == "Blocked"
    tags: ["file-test"]
}
"#;
        let path = dir.join("file_rule.dl");
        fs::write(&path, rule_content).unwrap();

        let mgr = HotReloadManager::new(dir.clone());
        let rule = mgr.load_rule_from_file(&path).unwrap();
        assert_eq!(rule.name, "File Rule");
        assert_eq!(rule.severity, security_os_core::Severity::Critical);
        assert_eq!(rule.tags, vec!["file-test"]);

        let _ = fs::remove_dir_all(&dir);
    }
}
