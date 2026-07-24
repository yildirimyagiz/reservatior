use std::sync::Arc;

use crate::host_memory::HostMemory;
use crate::incident_memory::IncidentMemory;
use crate::org_memory::OrgMemory;
use crate::user_memory::UserMemory;

#[derive(Debug, Clone)]
pub struct RagContext {
    pub query: String,
    pub context_parts: Vec<ContextPart>,
    pub token_estimate: usize,
    pub relevance_score: f64,
}

#[derive(Debug, Clone)]
pub struct ContextPart {
    pub source: String,
    pub content: String,
    pub relevance: f64,
    pub data_type: String,
}

pub struct RagContextBuilder {
    incident_memory: Arc<IncidentMemory>,
    host_memory: Arc<HostMemory>,
    user_memory: Arc<UserMemory>,
    org_memory: Arc<OrgMemory>,
}

impl RagContextBuilder {
    pub fn new(
        incident_memory: Arc<IncidentMemory>,
        host_memory: Arc<HostMemory>,
        user_memory: Arc<UserMemory>,
        org_memory: Arc<OrgMemory>,
    ) -> Self {
        Self {
            incident_memory,
            host_memory,
            user_memory,
            org_memory,
        }
    }

    pub fn build_context(&self, query: &str, max_tokens: usize) -> RagContext {
        let mut context_parts = Vec::new();
        let query_lower = query.to_lowercase();

        let recent_incidents = self.incident_memory.recent(5);
        for incident in &recent_incidents {
            let relevance = Self::rank_relevance(query, &incident.title);
            if relevance > 0.1 {
                let content = format!(
                    "Incident: {} | Severity: {} | Root Cause: {}",
                    incident.title, incident.severity, incident.root_cause
                );
                context_parts.push(ContextPart {
                    source: format!("incident:{}", incident.incident_id),
                    content,
                    relevance,
                    data_type: "incident".to_string(),
                });
            }
        }

        let incident_count = self.incident_memory.total_entries();
        if query_lower.contains("incident") || query_lower.contains("attack") {
            let avg_resolution = self.incident_memory.avg_resolution_time();
            let fp_rate = self.incident_memory.false_positive_rate();
            let content = format!(
                "Total incidents: {} | Avg resolution: {:?} | False positive rate: {:.1}%",
                incident_count,
                avg_resolution.unwrap_or_default(),
                fp_rate * 100.0
            );
            context_parts.push(ContextPart {
                source: "incident:stats".to_string(),
                content,
                relevance: 0.7,
                data_type: "statistics".to_string(),
            });
        }

        let all_threat_patterns = self.org_memory.get_threat_patterns();
        for pattern in all_threat_patterns.iter().take(5) {
            let relevance = Self::rank_relevance(query, &pattern.name);
            if relevance > 0.1 {
                let content = format!(
                    "Threat pattern: {} | Freq: {} | Severity: {}",
                    pattern.name, pattern.frequency, pattern.typical_severity
                );
                context_parts.push(ContextPart {
                    source: format!("org:pattern:{}", pattern.pattern_id),
                    content,
                    relevance,
                    data_type: "threat_pattern".to_string(),
                });
            }
        }

        let effective_responses = self.org_memory.get_effective_responses();
        for response in effective_responses.iter().take(3) {
            if response.success_rate > 0.5 {
                let content = format!(
                    "Response: {} | Success rate: {:.1}% | Used {} times",
                    response.response_type,
                    response.success_rate * 100.0,
                    response.used_count
                );
                context_parts.push(ContextPart {
                    source: format!("org:response:{}", response.response_type),
                    content,
                    relevance: 0.5,
                    data_type: "response".to_string(),
                });
            }
        }

        context_parts.sort_by(|a, b| {
            b.relevance
                .partial_cmp(&a.relevance)
                .unwrap_or(std::cmp::Ordering::Equal)
        });

        let mut total_tokens = 0;
        let mut filtered_parts = Vec::new();
        for part in context_parts {
            let part_tokens = Self::estimate_tokens(&part.content);
            if total_tokens + part_tokens <= max_tokens {
                total_tokens += part_tokens;
                filtered_parts.push(part);
            }
        }

        let relevance_score = if filtered_parts.is_empty() {
            0.0
        } else {
            filtered_parts.iter().map(|p| p.relevance).sum::<f64>()
                / filtered_parts.len() as f64
        };

        RagContext {
            query: query.to_string(),
            context_parts: filtered_parts,
            token_estimate: total_tokens,
            relevance_score,
        }
    }

    pub fn build_incident_context(&self, incident_id: &str) -> RagContext {
        let mut context_parts = Vec::new();

        if let Some(entry) = self.incident_memory.get(incident_id) {
            let content = format!(
                "Incident: {} | Title: {} | Severity: {} | Root Cause: {} | Resolution: {}",
                entry.incident_id,
                entry.title,
                entry.severity,
                entry.root_cause,
                entry.resolution.as_deref().unwrap_or("Unresolved")
            );
            context_parts.push(ContextPart {
                source: format!("incident:{}", entry.incident_id),
                content,
                relevance: 1.0,
                data_type: "incident".to_string(),
            });

            if !entry.resolution_steps.is_empty() {
                let steps = entry.resolution_steps.join(", ");
                context_parts.push(ContextPart {
                    source: format!("incident:{}:steps", entry.incident_id),
                    content: format!("Resolution steps: {}", steps),
                    relevance: 0.9,
                    data_type: "resolution".to_string(),
                });
            }

            let similar = self.incident_memory.find_similar(
                &entry.title,
                entry.mitre_tactic.as_deref(),
                &entry.tags,
            );
            for sim in similar.iter().take(3) {
                context_parts.push(ContextPart {
                    source: format!("incident:{}:similar", sim.entry.incident_id),
                    content: format!(
                        "Similar: {} | Score: {:.2}",
                        sim.entry.title, sim.similarity_score
                    ),
                    relevance: sim.similarity_score,
                    data_type: "similar_incident".to_string(),
                });
            }
        }

        let token_estimate: usize = context_parts.iter().map(|p| Self::estimate_tokens(&p.content)).sum();
        let relevance_score = if context_parts.is_empty() {
            0.0
        } else {
            context_parts.iter().map(|p| p.relevance).sum::<f64>()
                / context_parts.len() as f64
        };

        RagContext {
            query: format!("incident:{}", incident_id),
            context_parts,
            token_estimate,
            relevance_score,
        }
    }

    pub fn build_host_context(&self, host_id: &str) -> RagContext {
        let mut context_parts = Vec::new();

        if let Some(profile) = self.host_memory.get_profile(host_id) {
            let content = format!(
                "Host: {} ({}) | Events: {} | Baseline processes: {}",
                profile.host_id,
                profile.hostname,
                profile.total_events,
                profile.baseline.normal_processes.len()
            );
            context_parts.push(ContextPart {
                source: format!("host:{}", profile.host_id),
                content,
                relevance: 1.0,
                data_type: "host_profile".to_string(),
            });

            if !profile.anomalies.is_empty() {
                let anomaly_summary = profile
                    .anomalies
                    .iter()
                    .take(5)
                    .map(|a| format!("{} ({})", a.anomaly_type, a.severity))
                    .collect::<Vec<_>>()
                    .join(", ");
                context_parts.push(ContextPart {
                    source: format!("host:{}:anomalies", profile.host_id),
                    content: format!("Anomalies: {}", anomaly_summary),
                    relevance: 0.9,
                    data_type: "anomalies".to_string(),
                });
            }

            if let Some(latest_risk) = profile.risk_trend.last() {
                context_parts.push(ContextPart {
                    source: format!("host:{}:risk", profile.host_id),
                    content: format!("Current risk score: {}", latest_risk.risk_score),
                    relevance: 0.8,
                    data_type: "risk".to_string(),
                });
            }
        }

        let token_estimate: usize = context_parts.iter().map(|p| Self::estimate_tokens(&p.content)).sum();
        let relevance_score = if context_parts.is_empty() {
            0.0
        } else {
            context_parts.iter().map(|p| p.relevance).sum::<f64>()
                / context_parts.len() as f64
        };

        RagContext {
            query: format!("host:{}", host_id),
            context_parts,
            token_estimate,
            relevance_score,
        }
    }

    pub fn build_user_context(&self, user_id: &str) -> RagContext {
        let mut context_parts = Vec::new();

        if let Some(profile) = self.user_memory.get_profile(user_id) {
            let content = format!(
                "User: {} ({}) | Known IPs: {} | Risk: {:.1} | Anomalies: {}",
                profile.user_id,
                profile.username,
                profile.known_ips.len(),
                profile.risk_score,
                profile.anomaly_count
            );
            context_parts.push(ContextPart {
                source: format!("user:{}", profile.user_id),
                content,
                relevance: 1.0,
                data_type: "user_profile".to_string(),
            });

            if profile.risk_score > 50.0 {
                context_parts.push(ContextPart {
                    source: format!("user:{}:risk", profile.user_id),
                    content: format!(
                        "High risk user: {} score={:.1} failed_logins={}",
                        profile.username,
                        profile.risk_score,
                        profile.login_patterns.failed_attempts
                    ),
                    relevance: 0.9,
                    data_type: "risk".to_string(),
                });
            }
        }

        let token_estimate: usize = context_parts.iter().map(|p| Self::estimate_tokens(&p.content)).sum();
        let relevance_score = if context_parts.is_empty() {
            0.0
        } else {
            context_parts.iter().map(|p| p.relevance).sum::<f64>()
                / context_parts.len() as f64
        };

        RagContext {
            query: format!("user:{}", user_id),
            context_parts,
            token_estimate,
            relevance_score,
        }
    }

    fn estimate_tokens(text: &str) -> usize {
        (text.len() / 4) + 1
    }

    fn rank_relevance(query: &str, text: &str) -> f64 {
        let query_lower = query.to_lowercase();
        let text_lower = text.to_lowercase();

        if query_lower == text_lower {
            return 1.0;
        }

        let query_words: Vec<&str> = query_lower.split_whitespace().collect();
        let text_words: Vec<&str> = text_lower.split_whitespace().collect();

        if query_words.is_empty() || text_words.is_empty() {
            return 0.0;
        }

        let mut matches = 0;
        for qw in &query_words {
            for tw in &text_words {
                if tw.contains(qw) || qw.contains(tw) {
                    matches += 1;
                    break;
                }
            }
        }

        matches as f64 / query_words.len() as f64
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::incident_memory::{IncidentMemory, IncidentMemoryEntry};
    use crate::host_memory::HostMemory;
    use crate::user_memory::UserMemory;
    use crate::org_memory::OrgMemory;
    use chrono::Utc;
    use security_os_core::{EventAction, EventCategory, EventSource, SecurityEvent, Severity};
    use std::sync::Arc;

    fn make_source() -> EventSource {
        EventSource {
            collector: "test".into(),
            host_id: "host-1".into(),
            host_name: "web-01".into(),
            agent_id: "agent-1".into(),
            agent_version: Some("1.0".into()),
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

    fn setup() -> RagContextBuilder {
        let incident_memory = Arc::new(IncidentMemory::new());
        let host_memory = Arc::new(HostMemory::new());
        let user_memory = Arc::new(UserMemory::new());
        let org_memory = Arc::new(OrgMemory::new("org-1".into()));

        let entry = IncidentMemoryEntry {
            incident_id: "inc-001".to_string(),
            title: "SQL Injection attack".to_string(),
            root_cause: "Unsanitized input".to_string(),
            resolution: Some("Patched".to_string()),
            severity: Severity::High,
            mitre_tactic: Some("Initial Access".to_string()),
            mitre_technique: None,
            affected_assets: vec!["web-01".to_string()],
            resolution_steps: vec!["Block IP".to_string(), "Patch".to_string()],
            time_to_resolve: None,
            false_positive: false,
            tags: vec!["web".to_string(), "injection".to_string()],
            created_at: Utc::now(),
            resolved_at: Some(Utc::now()),
        };
        incident_memory.store(entry);

        let event = SecurityEvent::new(
            EventCategory::Network,
            EventAction::Connected,
            make_source(),
            "Network activity",
            "Normal connection",
        );
        host_memory.update_baseline("host-1", "web-01", &event);

        org_memory.record_threat_pattern("p1", "SQL Injection", Severity::High);
        org_memory.record_response("block_ip", true, std::time::Duration::from_secs(60));

        RagContextBuilder::new(incident_memory, host_memory, user_memory, org_memory)
    }

    #[test]
    fn test_build_context() {
        let builder = setup();
        let ctx = builder.build_context("SQL injection attack", 1000);
        assert_eq!(ctx.query, "SQL injection attack");
        assert!(!ctx.context_parts.is_empty());
        assert!(ctx.token_estimate > 0);
        assert!(ctx.relevance_score > 0.0);
    }

    #[test]
    fn test_build_incident_context() {
        let builder = setup();
        let ctx = builder.build_incident_context("inc-001");
        assert_eq!(ctx.query, "incident:inc-001");
        assert!(!ctx.context_parts.is_empty());
        assert!(ctx.token_estimate > 0);
    }

    #[test]
    fn test_build_host_context() {
        let builder = setup();
        let ctx = builder.build_host_context("host-1");
        assert_eq!(ctx.query, "host:host-1");
        assert!(ctx.token_estimate > 0);
    }

    #[test]
    fn test_estimate_tokens() {
        let tokens = RagContextBuilder::estimate_tokens("Hello world");
        assert!(tokens > 0);
        assert!(tokens <= 4);
    }
}
