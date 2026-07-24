use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::{debug, warn};

#[derive(Debug, Clone)]
pub struct CloudBaseline {
    pub account_id: String,
    pub known_ips: Vec<String>,
    pub known_regions: Vec<String>,
    pub known_services: Vec<String>,
    pub known_actions: Vec<String>,
    pub is_root_used: bool,
}

pub struct CloudEngine {
    baselines: DashMap<String, CloudBaseline>,
}

impl CloudEngine {
    pub fn new() -> Self {
        Self {
            baselines: DashMap::new(),
        }
    }

    fn ensure_baseline(&self, account_id: &str) {
        self.baselines
            .entry(account_id.to_string())
            .or_insert_with(|| CloudBaseline {
                account_id: account_id.to_string(),
                known_ips: Vec::new(),
                known_regions: Vec::new(),
                known_services: Vec::new(),
                known_actions: Vec::new(),
                is_root_used: false,
            });
    }

    fn get_string_meta(event: &SecurityEvent, key: &str) -> Option<String> {
        event
            .metadata
            .get(key)
            .and_then(|v| v.as_str())
            .map(|s| s.to_string())
    }

    fn detect_iam_policy_change(
        &self,
        event: &SecurityEvent,
        account_id: &str,
    ) -> Option<SecurityEvent> {
        let action = Self::get_string_meta(event, "cloud_action")?;
        let is_iam = action.to_lowercase().contains("policy")
            || action.to_lowercase().contains("iam")
            || action.to_lowercase().contains("attach")
            || action.to_lowercase().contains("detach")
            || action.to_lowercase().contains("create_role")
            || action.to_lowercase().contains("put_role_policy");

        if !is_iam {
            return None;
        }

        debug!("IAM policy change detected for account {}", account_id);

        let source = Self::make_source(event, "cloud-engine-iam");
        let mut det = SecurityEvent::new(
            EventCategory::Cloud,
            EventAction::Detected,
            source,
            format!("IAM policy change on account {}", account_id),
            format!(
                "Cloud IAM policy modification detected on account {}. Action: {}.",
                account_id, action
            ),
        )
        .with_severity(Severity::Critical)
        .with_confidence(0.9)
        .with_risk_score(95.0)
        .with_mitre("Privilege Escalation", "Account Manipulation", "T1098")
        .with_tag("cloud")
        .with_tag("iam");

        det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: account_id.to_string(),
            risk_contribution: 50.0,
        
            metadata: std::collections::HashMap::new(),
        });

        Some(det)
    }

    fn detect_public_s3_access(
        &self,
        event: &SecurityEvent,
        account_id: &str,
    ) -> Option<SecurityEvent> {
        let service = Self::get_string_meta(event, "cloud_service")?;
        let action = Self::get_string_meta(event, "cloud_action")?;

        let is_s3 = service.to_lowercase().contains("s3")
            || service.to_lowercase().contains("storage");
        let is_public_access = action.to_lowercase().contains("public")
            || action.to_lowercase().contains("acl")
            || action.to_lowercase().contains("getobject")
            || action.to_lowercase().contains("putbucketpolicy");

        if !is_s3 || !is_public_access {
            return None;
        }

        debug!("Public S3 access detected for account {}", account_id);

        let source = Self::make_source(event, "cloud-engine-s3");
        let mut det = SecurityEvent::new(
            EventCategory::Cloud,
            EventAction::Detected,
            source,
            format!("Public S3 bucket access on account {}", account_id),
            format!(
                "S3 bucket public access detected on account {}. Service: {}, Action: {}.",
                account_id, service, action
            ),
        )
        .with_severity(Severity::High)
        .with_confidence(0.85)
        .with_risk_score(80.0)
        .with_mitre(
            "Discovery",
            "Cloud Infrastructure Discovery",
            "T1580",
        )
        .with_tag("cloud")
        .with_tag("s3")
        .with_tag("public-access");

        det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: account_id.to_string(),
            risk_contribution: 40.0,
        
            metadata: std::collections::HashMap::new(),
        });

        Some(det)
    }

    fn detect_root_account_usage(
        &self,
        event: &SecurityEvent,
        account_id: &str,
    ) -> Option<SecurityEvent> {
        let user = Self::get_string_meta(event, "cloud_user")?;
        let is_root = user == "root"
            || user == "aws-root"
            || user.ends_with(":root")
            || user == "OrganizationAccountAccessRole";

        if !is_root {
            return None;
        }

        debug!("Root account usage detected for account {}", account_id);

        let source = Self::make_source(event, "cloud-engine-root");
        let mut det = SecurityEvent::new(
            EventCategory::Cloud,
            EventAction::Detected,
            source,
            format!("Root account usage on account {}", account_id),
            format!(
                "Root account {} used for cloud operations on account {}. \
                 Root account usage should be avoided for day-to-day operations.",
                user, account_id
            ),
        )
        .with_severity(Severity::Critical)
        .with_confidence(0.95)
        .with_risk_score(90.0)
        .with_mitre(
            "Privilege Escalation",
            "Valid Accounts: Cloud Accounts",
            "T1078.004",
        )
        .with_tag("cloud")
        .with_tag("root-account");

        det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: user,
            risk_contribution: 50.0,
        
            metadata: std::collections::HashMap::new(),
        });

        Some(det)
    }

    fn detect_unauthorized_api_from_new_ip(
        &self,
        event: &SecurityEvent,
        account_id: &str,
    ) -> Option<SecurityEvent> {
        let source_ip = Self::get_string_meta(event, "source_ip")?;
        let api_call = Self::get_string_meta(event, "api_call")
            .or_else(|| Self::get_string_meta(event, "cloud_action"))?;

        let baseline = self.baselines.get(account_id)?;
        let is_known_ip = baseline.known_ips.contains(&source_ip);

        if is_known_ip {
            return None;
        }

        debug!(
            "Unauthorized API call from new IP {} on account {}",
            source_ip, account_id
        );

        let source = Self::make_source(event, "cloud-engine-api");
        let mut det = SecurityEvent::new(
            EventCategory::Cloud,
            EventAction::Detected,
            source,
            format!("API call from new IP on account {}", account_id),
            format!(
                "Cloud API call '{}' from previously unseen IP {} on account {}. \
                 This may indicate compromised credentials.",
                api_call, source_ip, account_id
            ),
        )
        .with_severity(Severity::High)
        .with_confidence(0.8)
        .with_risk_score(75.0)
        .with_mitre(
            "Initial Access",
            "Valid Accounts: Cloud Accounts",
            "T1078.004",
        )
        .with_tag("cloud")
        .with_tag("new-ip")
        .with_tag("credential-compromise");

        det.affected_entities.push(Entity {
            entity_type: EntityType::Ip,
            value: source_ip.clone(),
            risk_contribution: 40.0,
        
            metadata: std::collections::HashMap::new(),
        });
        det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: account_id.to_string(),
            risk_contribution: 30.0,
        
            metadata: std::collections::HashMap::new(),
        });

        Some(det)
    }

    fn detect_unusual_location_credential(
        &self,
        event: &SecurityEvent,
        account_id: &str,
    ) -> Option<SecurityEvent> {
        let source_region = Self::get_string_meta(event, "source_region")?;
        let credential_type = Self::get_string_meta(event, "credential_type")
            .unwrap_or_else(|| "unknown".to_string());

        let baseline = self.baselines.get(account_id)?;
        let is_known_region = baseline.known_regions.contains(&source_region);

        if is_known_region {
            return None;
        }

        debug!(
            "Credential usage from unusual location {} on account {}",
            source_region, account_id
        );

        let source = Self::make_source(event, "cloud-engine-location");
        let mut det = SecurityEvent::new(
            EventCategory::Cloud,
            EventAction::Detected,
            source,
            format!(
                "Credential usage from unusual location on account {}",
                account_id
            ),
            format!(
                "Cloud credential ({}) used from unusual region {} on account {}. \
                 Known regions: {:?}.",
                credential_type, source_region, account_id, baseline.known_regions
            ),
        )
        .with_severity(Severity::Medium)
        .with_confidence(0.7)
        .with_risk_score(60.0)
        .with_mitre(
            "Initial Access",
            "Valid Accounts: Cloud Accounts",
            "T1078.004",
        )
        .with_tag("cloud")
        .with_tag("unusual-location");

        det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: account_id.to_string(),
            risk_contribution: 30.0,
        
            metadata: std::collections::HashMap::new(),
        });

        Some(det)
    }

    fn update_baseline(&self, account_id: &str, event: &SecurityEvent) {
        self.ensure_baseline(account_id);

        if let Some(ip) = Self::get_string_meta(event, "source_ip") {
            if let Some(mut baseline) = self.baselines.get_mut(account_id) {
                if !baseline.known_ips.contains(&ip) {
                    baseline.known_ips.push(ip);
                }
            }
        }

        if let Some(region) = Self::get_string_meta(event, "source_region") {
            if let Some(mut baseline) = self.baselines.get_mut(account_id) {
                if !baseline.known_regions.contains(&region) {
                    baseline.known_regions.push(region);
                }
            }
        }

        if let Some(service) = Self::get_string_meta(event, "cloud_service") {
            if let Some(mut baseline) = self.baselines.get_mut(account_id) {
                if !baseline.known_services.contains(&service) {
                    baseline.known_services.push(service);
                }
            }
        }

        if let Some(action) = Self::get_string_meta(event, "cloud_action") {
            if let Some(mut baseline) = self.baselines.get_mut(account_id) {
                if !baseline.known_actions.contains(&action) {
                    baseline.known_actions.push(action);
                }
            }
        }
    }

    fn make_source(event: &SecurityEvent, agent_id: &str) -> EventSource {
        EventSource {
            collector: event.source.collector.clone(),
            host_id: event.source.host_id.clone(),
            host_name: event.source.host_name.clone(),
            agent_id: agent_id.to_string(),
            process_name: event.source.process_name.clone(),
            process_id: event.source.process_id,
            user_id: event.source.user_id.clone(),
            user_name: event.source.user_name.clone(),
            container_id: event.source.container_id.clone(),
            container_name: event.source.container_name.clone(),
            pod_name: event.source.pod_name.clone(),
            namespace: event.source.namespace.clone(),
        
            agent_version: None,
            service_name: None,
        }
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        if event.category != EventCategory::Cloud && event.category != EventCategory::Api {
            return detections;
        }

        let account_id = Self::get_string_meta(event, "cloud_account")
            .unwrap_or_else(|| "unknown".to_string());

        self.ensure_baseline(&account_id);

        if let Some(det) = self.detect_iam_policy_change(event, &account_id) {
            warn!("Cloud detection: {}", det.title);
            detections.push(det);
        }

        if let Some(det) = self.detect_public_s3_access(event, &account_id) {
            warn!("Cloud detection: {}", det.title);
            detections.push(det);
        }

        if let Some(det) = self.detect_root_account_usage(event, &account_id) {
            warn!("Cloud detection: {}", det.title);
            detections.push(det);
        }

        if let Some(det) = self.detect_unauthorized_api_from_new_ip(event, &account_id) {
            warn!("Cloud detection: {}", det.title);
            detections.push(det);
        }

        if let Some(det) = self.detect_unusual_location_credential(event, &account_id) {
            warn!("Cloud detection: {}", det.title);
            detections.push(det);
        }

        self.update_baseline(&account_id, event);

        detections
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::HashMap;

    fn make_test_event(
        category: EventCategory,
        action: EventAction,
        metadata: HashMap<String, serde_json::Value>,
    ) -> SecurityEvent {
        let source = EventSource {
            collector: "test".to_string(),
            host_id: "test-host".to_string(),
            host_name: "test".to_string(),
            agent_id: "test-agent".to_string(),
            process_name: None,
            process_id: None,
            user_id: None,
            user_name: None,
            container_id: None,
            container_name: None,
            pod_name: None,
            namespace: None,
        
            agent_version: None,
            service_name: None,
        };

        let mut event = SecurityEvent::new(category, action, source, "test event", "test desc");
        event.metadata = metadata;
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = CloudEngine::new();
        assert!(engine.baselines.is_empty());
    }

    #[test]
    fn test_iam_policy_change_detection() {
        let mut engine = CloudEngine::new();
        let mut metadata = HashMap::new();
        metadata.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-123".to_string()),
        );
        metadata.insert(
            "cloud_service".to_string(),
            serde_json::Value::String("iam".to_string()),
        );
        metadata.insert(
            "cloud_action".to_string(),
            serde_json::Value::String("PutRolePolicy".to_string()),
        );
        metadata.insert(
            "cloud_user".to_string(),
            serde_json::Value::String("admin".to_string()),
        );

        let event = make_test_event(EventCategory::Cloud, EventAction::Created, metadata);
        let detections = engine.process_event(&event);

        assert_eq!(detections.len(), 1);
        assert_eq!(detections[0].severity, Severity::Critical);
        assert_eq!(detections[0].mitre_id.as_deref(), Some("T1098"));
        assert!(detections[0].title.contains("IAM policy change"));
    }

    #[test]
    fn test_public_s3_detection() {
        let mut engine = CloudEngine::new();
        let mut metadata = HashMap::new();
        metadata.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-456".to_string()),
        );
        metadata.insert(
            "cloud_service".to_string(),
            serde_json::Value::String("s3".to_string()),
        );
        metadata.insert(
            "cloud_action".to_string(),
            serde_json::Value::String("PutBucketPolicy".to_string()),
        );
        metadata.insert(
            "cloud_user".to_string(),
            serde_json::Value::String("deployer".to_string()),
        );

        let event = make_test_event(EventCategory::Cloud, EventAction::Modified, metadata);
        let detections = engine.process_event(&event);

        assert!(detections.iter().any(|d| d.title.contains("S3 bucket")));
        let s3_det = detections.iter().find(|d| d.title.contains("S3")).unwrap();
        assert_eq!(s3_det.severity, Severity::High);
        assert_eq!(s3_det.mitre_id.as_deref(), Some("T1580"));
    }

    #[test]
    fn test_root_account_detection() {
        let mut engine = CloudEngine::new();
        let mut metadata = HashMap::new();
        metadata.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-789".to_string()),
        );
        metadata.insert(
            "cloud_user".to_string(),
            serde_json::Value::String("root".to_string()),
        );
        metadata.insert(
            "cloud_service".to_string(),
            serde_json::Value::String("ec2".to_string()),
        );
        metadata.insert(
            "cloud_action".to_string(),
            serde_json::Value::String("RunInstances".to_string()),
        );

        let event = make_test_event(EventCategory::Cloud, EventAction::Started, metadata);
        let detections = engine.process_event(&event);

        assert!(detections.iter().any(|d| d.title.contains("Root account")));
        let root_det = detections.iter().find(|d| d.title.contains("Root")).unwrap();
        assert_eq!(root_det.severity, Severity::Critical);
        assert_eq!(root_det.mitre_id.as_deref(), Some("T1078.004"));
    }

    #[test]
    fn test_new_ip_api_call_detection() {
        let mut engine = CloudEngine::new();

        let mut baseline_metadata = HashMap::new();
        baseline_metadata.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-101".to_string()),
        );
        baseline_metadata.insert(
            "source_ip".to_string(),
            serde_json::Value::String("10.0.0.1".to_string()),
        );
        baseline_metadata.insert(
            "cloud_service".to_string(),
            serde_json::Value::String("ec2".to_string()),
        );
        baseline_metadata.insert(
            "cloud_action".to_string(),
            serde_json::Value::String("DescribeInstances".to_string()),
        );
        baseline_metadata.insert(
            "cloud_user".to_string(),
            serde_json::Value::String("ops".to_string()),
        );
        let baseline_event =
            make_test_event(EventCategory::Cloud, EventAction::Started, baseline_metadata);
        engine.process_event(&baseline_event);

        let mut new_ip_metadata = HashMap::new();
        new_ip_metadata.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-101".to_string()),
        );
        new_ip_metadata.insert(
            "source_ip".to_string(),
            serde_json::Value::String("203.0.113.99".to_string()),
        );
        new_ip_metadata.insert(
            "api_call".to_string(),
            serde_json::Value::String("TerminateInstances".to_string()),
        );
        new_ip_metadata.insert(
            "cloud_service".to_string(),
            serde_json::Value::String("ec2".to_string()),
        );
        new_ip_metadata.insert(
            "cloud_user".to_string(),
            serde_json::Value::String("ops".to_string()),
        );
        let new_event =
            make_test_event(EventCategory::Cloud, EventAction::Started, new_ip_metadata);
        let detections = engine.process_event(&new_event);

        let api_dets: Vec<_> = detections
            .iter()
            .filter(|d| d.title.contains("new IP"))
            .collect();
        assert_eq!(api_dets.len(), 1);
        assert_eq!(api_dets[0].severity, Severity::High);
        assert_eq!(api_dets[0].mitre_id.as_deref(), Some("T1078.004"));
    }

    #[test]
    fn test_unusual_location_detection() {
        let mut engine = CloudEngine::new();

        let mut baseline_metadata = HashMap::new();
        baseline_metadata.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-202".to_string()),
        );
        baseline_metadata.insert(
            "source_region".to_string(),
            serde_json::Value::String("us-east-1".to_string()),
        );
        baseline_metadata.insert(
            "cloud_service".to_string(),
            serde_json::Value::String("sts".to_string()),
        );
        baseline_metadata.insert(
            "cloud_action".to_string(),
            serde_json::Value::String("AssumeRole".to_string()),
        );
        baseline_metadata.insert(
            "cloud_user".to_string(),
            serde_json::Value::String("dev".to_string()),
        );
        let baseline_event =
            make_test_event(EventCategory::Cloud, EventAction::Started, baseline_metadata);
        engine.process_event(&baseline_event);

        let mut unusual_metadata = HashMap::new();
        unusual_metadata.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-202".to_string()),
        );
        unusual_metadata.insert(
            "source_region".to_string(),
            serde_json::Value::String("ap-northeast-1".to_string()),
        );
        unusual_metadata.insert(
            "credential_type".to_string(),
            serde_json::Value::String("access_key".to_string()),
        );
        unusual_metadata.insert(
            "cloud_service".to_string(),
            serde_json::Value::String("sts".to_string()),
        );
        unusual_metadata.insert(
            "cloud_action".to_string(),
            serde_json::Value::String("AssumeRole".to_string()),
        );
        unusual_metadata.insert(
            "cloud_user".to_string(),
            serde_json::Value::String("dev".to_string()),
        );
        let unusual_event =
            make_test_event(EventCategory::Cloud, EventAction::Started, unusual_metadata);
        let detections = engine.process_event(&unusual_event);

        let loc_dets: Vec<_> = detections
            .iter()
            .filter(|d| d.title.contains("unusual location"))
            .collect();
        assert_eq!(loc_dets.len(), 1);
        assert_eq!(loc_dets[0].severity, Severity::Medium);
    }

    #[test]
    fn test_non_cloud_event_ignored() {
        let mut engine = CloudEngine::new();
        let mut metadata = HashMap::new();
        metadata.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-999".to_string()),
        );
        metadata.insert(
            "cloud_action".to_string(),
            serde_json::Value::String("PutRolePolicy".to_string()),
        );

        let event = make_test_event(EventCategory::Process, EventAction::Created, metadata);
        let detections = engine.process_event(&event);
        assert!(detections.is_empty());
    }

    #[test]
    fn test_baseline_update() {
        let mut engine = CloudEngine::new();
        let mut metadata = HashMap::new();
        metadata.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-303".to_string()),
        );
        metadata.insert(
            "source_ip".to_string(),
            serde_json::Value::String("10.0.0.5".to_string()),
        );
        metadata.insert(
            "source_region".to_string(),
            serde_json::Value::String("us-west-2".to_string()),
        );
        metadata.insert(
            "cloud_service".to_string(),
            serde_json::Value::String("lambda".to_string()),
        );
        metadata.insert(
            "cloud_action".to_string(),
            serde_json::Value::String("Invoke".to_string()),
        );
        metadata.insert(
            "cloud_user".to_string(),
            serde_json::Value::String("lambda-role".to_string()),
        );

        let event = make_test_event(EventCategory::Cloud, EventAction::Created, metadata);
        engine.process_event(&event);

        let baseline = engine.baselines.get("acct-303").unwrap();
        assert!(baseline.known_ips.contains(&"10.0.0.5".to_string()));
        assert!(baseline.known_regions.contains(&"us-west-2".to_string()));
        assert!(baseline.known_services.contains(&"lambda".to_string()));
        assert!(baseline.known_actions.contains(&"Invoke".to_string()));
    }

    #[test]
    fn test_known_ip_no_detection() {
        let mut engine = CloudEngine::new();

        let mut metadata1 = HashMap::new();
        metadata1.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-404".to_string()),
        );
        metadata1.insert(
            "source_ip".to_string(),
            serde_json::Value::String("10.0.0.1".to_string()),
        );
        metadata1.insert(
            "cloud_service".to_string(),
            serde_json::Value::String("ec2".to_string()),
        );
        metadata1.insert(
            "cloud_action".to_string(),
            serde_json::Value::String("DescribeInstances".to_string()),
        );
        metadata1.insert(
            "cloud_user".to_string(),
            serde_json::Value::String("admin".to_string()),
        );
        let event1 = make_test_event(EventCategory::Cloud, EventAction::Started, metadata1);
        engine.process_event(&event1);

        let mut metadata2 = HashMap::new();
        metadata2.insert(
            "cloud_account".to_string(),
            serde_json::Value::String("acct-404".to_string()),
        );
        metadata2.insert(
            "source_ip".to_string(),
            serde_json::Value::String("10.0.0.1".to_string()),
        );
        metadata2.insert(
            "api_call".to_string(),
            serde_json::Value::String("TerminateInstances".to_string()),
        );
        metadata2.insert(
            "cloud_service".to_string(),
            serde_json::Value::String("ec2".to_string()),
        );
        metadata2.insert(
            "cloud_user".to_string(),
            serde_json::Value::String("admin".to_string()),
        );
        let event2 = make_test_event(EventCategory::Cloud, EventAction::Started, metadata2);
        let detections = engine.process_event(&event2);

        let api_dets: Vec<_> = detections
            .iter()
            .filter(|d| d.title.contains("new IP"))
            .collect();
        assert!(api_dets.is_empty());
    }
}
