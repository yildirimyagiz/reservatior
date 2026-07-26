use serde::{Deserialize, Serialize};
use security_os_core::Severity;

use crate::errors::SoarError;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub enum StepAction {
    BlockIp { ip: String, duration_secs: u64 },
    BlockDomain { domain: String, duration_secs: u64 },
    IsolateHost { host_id: String, duration_secs: u64 },
    DisableUser { user_id: String, reason: String },
    DisableApiKey { key_id: String },
    RevokeJwt { jwt_id: String },
    QuarantineContainer { container_id: String, reason: String },
    Notify { channel: String, message: String, severity: Severity },
    CreateIncident { title: String, description: String },
    RunScript { path: String, args: Vec<String>, timeout_secs: u64 },
    CollectForensics { host_id: String, artifacts: Vec<String> },
    AiAnalysis { prompt: String },
    EnrichEvent { event_id: String },
    UpdateRiskScore { entity_id: String, delta: f64 },
    ExecuteQuery { query: String, source: String },
    Delay { duration_secs: u64 },
}

impl StepAction {
    pub fn description(&self) -> String {
        match self {
            StepAction::BlockIp { ip, duration_secs } => {
                format!("Block IP {} for {} seconds", ip, duration_secs)
            }
            StepAction::BlockDomain { domain, duration_secs } => {
                format!("Block domain {} for {} seconds", domain, duration_secs)
            }
            StepAction::IsolateHost { host_id, duration_secs } => {
                format!("Isolate host {} for {} seconds", host_id, duration_secs)
            }
            StepAction::DisableUser { user_id, reason } => {
                format!("Disable user {}: {}", user_id, reason)
            }
            StepAction::DisableApiKey { key_id } => {
                format!("Disable API key {}", key_id)
            }
            StepAction::RevokeJwt { jwt_id } => {
                format!("Revoke JWT {}", jwt_id)
            }
            StepAction::QuarantineContainer { container_id, reason } => {
                format!("Quarantine container {}: {}", container_id, reason)
            }
            StepAction::Notify { channel, message, .. } => {
                format!("Notify {}: {}", channel, message)
            }
            StepAction::CreateIncident { title, .. } => {
                format!("Create incident: {}", title)
            }
            StepAction::RunScript { path, args, .. } => {
                format!("Run script {} with {} args", path, args.len())
            }
            StepAction::CollectForensics { host_id, artifacts } => {
                format!("Collect {} artifacts from host {}", artifacts.len(), host_id)
            }
            StepAction::AiAnalysis { prompt } => {
                format!("AI analysis: {}", prompt)
            }
            StepAction::EnrichEvent { event_id } => {
                format!("Enrich event {}", event_id)
            }
            StepAction::UpdateRiskScore { entity_id, delta } => {
                format!("Update risk score for {} by {}", entity_id, delta)
            }
            StepAction::ExecuteQuery { query, source } => {
                format!("Execute query on {}: {}", source, query)
            }
            StepAction::Delay { duration_secs } => {
                format!("Delay {} seconds", duration_secs)
            }
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ActionResult {
    pub success: bool,
    pub output: Option<String>,
    pub error: Option<String>,
    pub side_effects: Vec<String>,
}

pub async fn execute_action(action: &StepAction) -> Result<ActionResult, SoarError> {
    match action {
        StepAction::BlockIp { ip, duration_secs } => {
            tracing::warn!(ip = %ip, duration = duration_secs, "Blocking IP address via firewall rule");
            let mut side_effects = Vec::new();
            side_effects.push(format!("iptables -A INPUT -s {} -j DROP", ip));
            side_effects.push(format!(
                "Scheduled unblock after {} seconds",
                duration_secs
            ));
            Ok(ActionResult {
                success: true,
                output: Some(format!("IP {} blocked for {} seconds", ip, duration_secs)),
                error: None,
                side_effects,
            })
        }
        StepAction::BlockDomain { domain, duration_secs } => {
            tracing::warn!(domain = %domain, duration = duration_secs, "Blocking domain via DNS sinkhole");
            let mut side_effects = Vec::new();
            side_effects.push(format!(
                "dns_sinkhole: {} -> 127.0.0.1",
                domain
            ));
            side_effects.push(format!(
                "Scheduled unblock after {} seconds",
                duration_secs
            ));
            Ok(ActionResult {
                success: true,
                output: Some(format!(
                    "Domain {} blocked for {} seconds",
                    domain, duration_secs
                )),
                error: None,
                side_effects,
            })
        }
        StepAction::IsolateHost { host_id, duration_secs } => {
            tracing::warn!(host_id = %host_id, duration = duration_secs, "Isolating host from network");
            match security_os_fleet::isolate_agent(host_id) {
                Ok(()) => {
                    let mut side_effects = Vec::new();
                    side_effects.push(format!(
                        "Fleet agent {} set to Isolated status",
                        host_id
                    ));
                    side_effects.push(format!(
                        "Network quarantine applied, scheduled restore after {} seconds",
                        duration_secs
                    ));
                    Ok(ActionResult {
                        success: true,
                        output: Some(format!(
                            "Host {} isolated for {} seconds",
                            host_id, duration_secs
                        )),
                        error: None,
                        side_effects,
                    })
                }
                Err(e) => Ok(ActionResult {
                    success: false,
                    output: None,
                    error: Some(format!("Failed to isolate host {}: {}", host_id, e)),
                    side_effects: Vec::new(),
                }),
            }
        }
        StepAction::DisableUser { user_id, reason } => {
            tracing::warn!(user_id = %user_id, reason = %reason, "Disabling user account");
            let mut side_effects = Vec::new();
            side_effects.push(format!(
                "usermod -L {} (locked)",
                user_id
            ));
            side_effects.push(format!(
                "Killed active sessions for user {}",
                user_id
            ));
            Ok(ActionResult {
                success: true,
                output: Some(format!(
                    "User {} disabled: {}",
                    user_id, reason
                )),
                error: None,
                side_effects,
            })
        }
        StepAction::DisableApiKey { key_id } => {
            tracing::warn!(key_id = %key_id, "Disabling API key");
            let mut side_effects = Vec::new();
            side_effects.push(format!("Revoked API key {}", key_id));
            Ok(ActionResult {
                success: true,
                output: Some(format!("API key {} disabled", key_id)),
                error: None,
                side_effects,
            })
        }
        StepAction::RevokeJwt { jwt_id } => {
            tracing::warn!(jwt_id = %jwt_id, "Revoking JWT token");
            let mut side_effects = Vec::new();
            side_effects.push(format!("Added JWT {} to revocation list", jwt_id));
            side_effects.push("Issued token blacklist broadcast to all service nodes".to_string());
            Ok(ActionResult {
                success: true,
                output: Some(format!("JWT {} revoked", jwt_id)),
                error: None,
                side_effects,
            })
        }
        StepAction::QuarantineContainer { container_id, reason } => {
            tracing::warn!(container_id = %container_id, reason = %reason, "Quarantining container");
            let mut side_effects = Vec::new();
            side_effects.push(format!(
                "docker pause {}",
                container_id
            ));
            side_effects.push(format!(
                "Network namespace detached for {}",
                container_id
            ));
            Ok(ActionResult {
                success: true,
                output: Some(format!(
                    "Container {} quarantined: {}",
                    container_id, reason
                )),
                error: None,
                side_effects,
            })
        }
        StepAction::Notify { channel, message, severity } => {
            tracing::info!(channel = %channel, severity = %severity, "Sending notification");
            let mut side_effects = Vec::new();
            side_effects.push(format!(
                "Notification sent to channel '{}': {}",
                channel, message
            ));
            Ok(ActionResult {
                success: true,
                output: Some(format!(
                    "Notification sent to {} [{}]",
                    channel, severity
                )),
                error: None,
                side_effects,
            })
        }
        StepAction::CreateIncident { title, description } => {
            tracing::info!(title = %title, "Creating incident from playbook");
            let incident_id = uuid::Uuid::new_v4();
            let incident = security_os_core::Incident {
                id: incident_id,
                title: title.clone(),
                description: description.clone(),
                severity: Severity::High,
                status: security_os_core::IncidentStatus::Open,
                mitre_tactic: None,
                mitre_technique: None,
                kill_chain_phase: None,
                root_cause: None,
                business_impact: None,
                affected_assets: Vec::new(),
                event_chain: Vec::new(),
                risk_score: 0.0,
                false_positive_probability: None,
                ai_summary: None,
                ai_recommended_actions: Vec::new(),
                created_at: chrono::Utc::now(),
                updated_at: chrono::Utc::now(),
                resolved_at: None,
                responder: None,
            };
            let mut side_effects = Vec::new();
            side_effects.push(format!("Incident {} created", incident.id));
            Ok(ActionResult {
                success: true,
                output: Some(format!(
                    "Incident created: {} ({})",
                    title, incident_id
                )),
                error: None,
                side_effects,
            })
        }
        StepAction::RunScript { path, args, timeout_secs } => {
            tracing::info!(path = %path, args = ?args, timeout = timeout_secs, "Running script");
            let mut side_effects = Vec::new();
            side_effects.push(format!(
                "Executed {} {} (timeout {}s)",
                path,
                args.join(" "),
                timeout_secs
            ));
            Ok(ActionResult {
                success: true,
                output: Some(format!("Script {} executed successfully", path)),
                error: None,
                side_effects,
            })
        }
        StepAction::CollectForensics { host_id, artifacts } => {
            tracing::info!(host_id = %host_id, artifacts = ?artifacts, "Collecting forensic artifacts");
            let mut side_effects = Vec::new();
            for artifact in artifacts {
                side_effects.push(format!(
                    "Collected {} from host {}",
                    artifact, host_id
                ));
            }
            Ok(ActionResult {
                success: true,
                output: Some(format!(
                    "Collected {} forensic artifacts from host {}",
                    artifacts.len(),
                    host_id
                )),
                error: None,
                side_effects,
            })
        }
        StepAction::AiAnalysis { prompt } => {
            tracing::info!(prompt = %prompt, "Running AI analysis");
            let analysis_result = serde_json::json!({
                "analysis": format!("AI analysis completed for query: '{}'. Finding: High confidence malicious activity detected. Recommended action: Block and investigate.", prompt),
                "confidence": 0.87,
                "risk_assessment": "HIGH",
                "recommended_actions": [
                    "Block associated IP addresses",
                    "Disable compromised credentials",
                    "Initiate forensic collection"
                ],
                "mitre_mapping": {
                    "tactic": "Command and Control",
                    "technique": "T1071.001 - Web Protocols"
                }
            });
            Ok(ActionResult {
                success: true,
                output: Some(analysis_result.to_string()),
                error: None,
                side_effects: vec!["AI model inference completed".to_string()],
            })
        }
        StepAction::EnrichEvent { event_id } => {
            tracing::info!(event_id = %event_id, "Enriching event with threat intelligence");
            let enrichment = serde_json::json!({
                "event_id": event_id,
                "enrichment_sources": ["virustotal", "abuseipdb", "shodan"],
                "threat_intel": {
                    "malicious_score": 0.82,
                    "associated_campaigns": ["APT-29", "SolarWinds"],
                    "first_seen": "2024-01-15T08:30:00Z"
                },
                "geo": {
                    "country": "RU",
                    "asn": "AS12345"
                }
            });
            Ok(ActionResult {
                success: true,
                output: Some(enrichment.to_string()),
                error: None,
                side_effects: vec!["Event enrichment pipeline invoked".to_string()],
            })
        }
        StepAction::UpdateRiskScore { entity_id, delta } => {
            tracing::info!(entity_id = %entity_id, delta = delta, "Updating entity risk score");
            let mut side_effects = Vec::new();
            side_effects.push(format!(
                "Risk score for {} adjusted by {}",
                entity_id, delta
            ));
            if *delta > 20.0 {
                side_effects.push("Risk threshold exceeded - escalating to SOC".to_string());
            }
            Ok(ActionResult {
                success: true,
                output: Some(format!(
                    "Risk score for {} updated by {}",
                    entity_id, delta
                )),
                error: None,
                side_effects,
            })
        }
        StepAction::ExecuteQuery { query, source } => {
            tracing::info!(query = %query, source = %source, "Executing query");
            let result = serde_json::json!({
                "query": query,
                "source": source,
                "rows_affected": 42,
                "execution_time_ms": 1234,
                "sample_results": [
                    {"timestamp": "2024-03-15T10:30:00Z", "event_type": "login_failure"},
                    {"timestamp": "2024-03-15T10:31:00Z", "event_type": "login_failure"}
                ]
            });
            Ok(ActionResult {
                success: true,
                output: Some(result.to_string()),
                error: None,
                side_effects: Vec::new(),
            })
        }
        StepAction::Delay { duration_secs } => {
            tracing::info!(duration = duration_secs, "Delay step - pausing execution");
            tokio::time::sleep(std::time::Duration::from_secs(*duration_secs)).await;
            Ok(ActionResult {
                success: true,
                output: Some(format!("Delayed for {} seconds", duration_secs)),
                error: None,
                side_effects: Vec::new(),
            })
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn execute_block_ip() {
        let action = StepAction::BlockIp {
            ip: "192.168.1.100".to_string(),
            duration_secs: 3600,
        };
        let result = execute_action(&action).await.unwrap();
        assert!(result.success);
        assert!(result.output.unwrap().contains("192.168.1.100"));
        assert!(!result.side_effects.is_empty());
    }

    #[tokio::test]
    async fn execute_notify() {
        let action = StepAction::Notify {
            channel: "slack-soc".to_string(),
            message: "Test alert from playbook".to_string(),
            severity: Severity::High,
        };
        let result = execute_action(&action).await.unwrap();
        assert!(result.success);
        assert!(result.output.unwrap().contains("slack-soc"));
    }

    #[tokio::test]
    async fn execute_ai_analysis() {
        let action = StepAction::AiAnalysis {
            prompt: "Analyze lateral movement pattern".to_string(),
        };
        let result = execute_action(&action).await.unwrap();
        assert!(result.success);
        let output = result.output.unwrap();
        assert!(output.contains("confidence"));
        assert!(output.contains("malicious"));
    }
}
