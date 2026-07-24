use chrono::{DateTime, Utc};
use dashmap::DashMap;
use security_os_core::Severity;
use std::time::Duration;

#[derive(Debug, Clone)]
pub struct IncidentMemoryEntry {
    pub incident_id: String,
    pub title: String,
    pub root_cause: String,
    pub resolution: Option<String>,
    pub severity: Severity,
    pub mitre_tactic: Option<String>,
    pub mitre_technique: Option<String>,
    pub affected_assets: Vec<String>,
    pub resolution_steps: Vec<String>,
    pub time_to_resolve: Option<Duration>,
    pub false_positive: bool,
    pub tags: Vec<String>,
    pub created_at: DateTime<Utc>,
    pub resolved_at: Option<DateTime<Utc>>,
}

#[derive(Debug, Clone)]
pub struct SimilarIncident {
    pub entry: IncidentMemoryEntry,
    pub similarity_score: f64,
    pub matching_factors: Vec<String>,
}

pub struct IncidentMemory {
    entries: DashMap<String, IncidentMemoryEntry>,
}

impl IncidentMemory {
    pub fn new() -> Self {
        Self {
            entries: DashMap::new(),
        }
    }

    pub fn store(&self, entry: IncidentMemoryEntry) {
        self.entries
            .insert(entry.incident_id.clone(), entry);
    }

    pub fn get(&self, incident_id: &str) -> Option<IncidentMemoryEntry> {
        self.entries.get(incident_id).map(|e| e.clone())
    }

    pub fn find_similar(
        &self,
        title: &str,
        tactic: Option<&str>,
        tags: &[String],
    ) -> Vec<SimilarIncident> {
        let title_lower = title.to_lowercase();
        let mut results: Vec<SimilarIncident> = Vec::new();

        for entry in self.entries.iter() {
            let mut score = 0.0;
            let mut matching_factors = Vec::new();

            let entry_title_lower = entry.title.to_lowercase();
            if entry_title_lower == title_lower {
                score += 0.5;
                matching_factors.push("exact_title".to_string());
            } else if title_lower.contains(&entry_title_lower)
                || entry_title_lower.contains(&title_lower)
            {
                score += 0.3;
                matching_factors.push("partial_title".to_string());
            }

            if let Some(query_tactic) = tactic {
                if entry
                    .mitre_tactic
                    .as_deref()
                    .map(|t| t.to_lowercase()) == Some(query_tactic.to_lowercase())
                {
                    score += 0.2;
                    matching_factors.push("mitre_tactic".to_string());
                }
            }

            for tag in tags {
                if entry.tags.iter().any(|t| t.to_lowercase() == tag.to_lowercase()) {
                    score += 0.05;
                    if !matching_factors.iter().any(|f| f.starts_with("tag:")) {
                        matching_factors.push(format!("tag:{}", tag));
                    }
                }
            }

            if score > 0.0 {
                results.push(SimilarIncident {
                    entry: entry.clone(),
                    similarity_score: score,
                    matching_factors,
                });
            }
        }

        results.sort_by(|a, b| b.similarity_score.partial_cmp(&a.similarity_score).unwrap());
        results
    }

    pub fn recent(&self, limit: usize) -> Vec<IncidentMemoryEntry> {
        let mut entries: Vec<IncidentMemoryEntry> = self.entries.iter().map(|e| e.clone()).collect();
        entries.sort_by(|a, b| b.created_at.cmp(&a.created_at));
        entries.truncate(limit);
        entries
    }

    pub fn false_positive_rate(&self) -> f64 {
        if self.entries.is_empty() {
            return 0.0;
        }
        let total = self.entries.len() as f64;
        let fps = self
            .entries
            .iter()
            .filter(|e| e.false_positive)
            .count() as f64;
        fps / total
    }

    pub fn avg_resolution_time(&self) -> Option<Duration> {
        let resolved: Vec<Duration> = self
            .entries
            .iter()
            .filter_map(|e| e.time_to_resolve)
            .collect();

        if resolved.is_empty() {
            return None;
        }

        let total: Duration = resolved.iter().sum();
        Some(total / resolved.len() as u32)
    }

    pub fn total_entries(&self) -> usize {
        self.entries.len()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;
    use security_os_core::Severity;

    fn make_entry(id: &str, title: &str, tags: Vec<String>) -> IncidentMemoryEntry {
        IncidentMemoryEntry {
            incident_id: id.to_string(),
            title: title.to_string(),
            root_cause: "SQL injection via login form".to_string(),
            resolution: Some("Patched input validation".to_string()),
            severity: Severity::High,
            mitre_tactic: Some("Initial Access".to_string()),
            mitre_technique: Some("Exploit Public-Facing Application".to_string()),
            affected_assets: vec!["web-server-01".to_string()],
            resolution_steps: vec![
                "Block IP".to_string(),
                "Patch vulnerability".to_string(),
            ],
            time_to_resolve: Some(Duration::from_secs(3600)),
            false_positive: false,
            tags,
            created_at: Utc::now(),
            resolved_at: Some(Utc::now()),
        }
    }

    #[test]
    fn test_store_and_get() {
        let memory = IncidentMemory::new();
        let entry = make_entry("inc-001", "SQL Injection on login", vec!["web".into(), "injection".into()]);
        memory.store(entry.clone());
        let retrieved = memory.get("inc-001").expect("should find entry");
        assert_eq!(retrieved.incident_id, "inc-001");
        assert_eq!(retrieved.title, "SQL Injection on login");
    }

    #[test]
    fn test_get_nonexistent() {
        let memory = IncidentMemory::new();
        assert!(memory.get("nonexistent").is_none());
    }

    #[test]
    fn test_find_similar() {
        let memory = IncidentMemory::new();
        memory.store(make_entry("inc-001", "SQL Injection on login", vec!["web".into()]));
        memory.store(make_entry("inc-002", "XSS on search page", vec!["web".into()]));
        memory.store(make_entry("inc-003", "Brute force login", vec!["auth".into()]));

        let results = memory.find_similar("SQL Injection", None, &["web".to_string()]);
        assert!(!results.is_empty());
        assert_eq!(results[0].entry.incident_id, "inc-001");
        assert!(results[0].similarity_score > 0.0);
    }

    #[test]
    fn test_recent() {
        let memory = IncidentMemory::new();
        memory.store(make_entry("inc-001", "Event 1", vec![]));
        memory.store(make_entry("inc-002", "Event 2", vec![]));

        let recent = memory.recent(1);
        assert_eq!(recent.len(), 1);
        assert_eq!(recent[0].incident_id, "inc-002");
    }

    #[test]
    fn test_false_positive_rate() {
        let memory = IncidentMemory::new();
        memory.store(make_entry("inc-001", "Real incident", vec![]));

        let mut fp = make_entry("inc-002", "False alarm", vec![]);
        fp.false_positive = true;
        memory.store(fp);

        let rate = memory.false_positive_rate();
        assert!((rate - 0.5).abs() < f64::EPSILON);
    }

    #[test]
    fn test_avg_resolution_time() {
        let memory = IncidentMemory::new();
        memory.store(make_entry("inc-001", "Fast incident", vec![]));
        memory.store(make_entry("inc-002", "Slow incident", vec![]));

        let avg = memory.avg_resolution_time();
        assert!(avg.is_some());
        assert_eq!(avg.unwrap(), Duration::from_secs(3600));
    }
}
