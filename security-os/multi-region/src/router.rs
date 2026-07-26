use std::collections::HashMap;

use chrono::{DateTime, Utc};
use dashmap::DashMap;
use uuid::Uuid;

use security_os_core::{SecurityEvent, Severity};

use crate::MultiRegionError;

#[derive(Debug, Clone)]
pub struct RoutingRule {
    pub rule_id: String,
    pub source_region: Option<String>,
    pub dest_region: String,
    pub entity_filter: Option<String>,
    pub category_filter: Vec<String>,
    pub severity_min: Option<Severity>,
    pub enabled: bool,
    pub priority: u32,
}

#[derive(Debug, Clone)]
pub struct RoutedEvent {
    pub event_id: Uuid,
    pub source_region: String,
    pub dest_region: String,
    pub routed_at: DateTime<Utc>,
    pub routing_rule_id: String,
}

#[derive(Debug)]
pub struct RegionRouter {
    local_region: String,
    routing_rules: DashMap<String, RoutingRule>,
    route_table: DashMap<String, String>,
    events_routed: DashMap<String, u64>,
}

impl RegionRouter {
    pub fn new(local_region: &str) -> Self {
        Self {
            local_region: local_region.to_string(),
            routing_rules: DashMap::new(),
            route_table: DashMap::new(),
            events_routed: DashMap::new(),
        }
    }

    pub fn add_route(&self, rule: RoutingRule) -> Result<(), MultiRegionError> {
        if rule.rule_id.is_empty() {
            return Err(MultiRegionError::RoutingError(
                "rule_id cannot be empty".to_string(),
            ));
        }
        if rule.dest_region.is_empty() {
            return Err(MultiRegionError::RoutingError(
                "dest_region cannot be empty".to_string(),
            ));
        }
        self.routing_rules.insert(rule.rule_id.clone(), rule);
        Ok(())
    }

    pub fn remove_route(&self, rule_id: &str) -> bool {
        self.routing_rules.remove(rule_id).is_some()
    }

    pub fn route_event(&self, event: &SecurityEvent) -> Option<RoutedEvent> {
        let source_region = event
            .region
            .clone()
            .unwrap_or_else(|| self.local_region.clone());

        let mut matched: Option<(String, RoutingRule)> = None;

        for rule_ref in self.routing_rules.iter() {
            let rule = rule_ref.value();
            if !rule.enabled {
                continue;
            }
            if let Some(ref src) = rule.source_region {
                if src != &source_region {
                    continue;
                }
            }
            if !rule.category_filter.is_empty() {
                let cat_str = format!("{:?}", event.category);
                if !rule.category_filter.iter().any(|c| cat_str.contains(c)) {
                    continue;
                }
            }
            if let Some(min_sev) = rule.severity_min {
                if event.severity < min_sev {
                    continue;
                }
            }
            matched = Some((rule_ref.key().clone(), rule.clone()));
            break;
        }

        let (rule_id, rule) = matched?;

        let dest_region = rule.dest_region.clone();

        let routed = RoutedEvent {
            event_id: event.id,
            source_region,
            dest_region: dest_region.clone(),
            routed_at: Utc::now(),
            routing_rule_id: rule_id,
        };

        *self
            .events_routed
            .entry(dest_region)
            .or_insert(0) += 1;

        Some(routed)
    }

    pub fn update_route_table(&self, entity_id: &str, region_id: &str) {
        self.route_table
            .insert(entity_id.to_string(), region_id.to_string());
    }

    pub fn get_destination(&self, entity_id: &str) -> Option<String> {
        self.route_table
            .get(entity_id)
            .map(|r| r.value().clone())
    }

    pub fn routing_stats(&self) -> HashMap<String, u64> {
        self.events_routed
            .iter()
            .map(|entry| (entry.key().clone(), *entry.value()))
            .collect()
    }

    pub fn list_routes(&self) -> Vec<RoutingRule> {
        self.routing_rules
            .iter()
            .map(|r| r.value().clone())
            .collect()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use security_os_core::{EventAction, EventCategory, EventSource, SecurityEvent, Severity};

    fn make_event(category: EventCategory, severity: Severity) -> SecurityEvent {
        SecurityEvent::new(
            category,
            EventAction::Detected,
            EventSource {
                collector: "test".to_string(),
                host_id: "host-1".to_string(),
                host_name: "test-host".to_string(),
                agent_id: "agent-1".to_string(),
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
            },
            "test event",
            "test description",
        )
        .with_severity(severity)
        .with_region("us-east-1")
    }

    fn make_rule(id: &str, dest: &str) -> RoutingRule {
        RoutingRule {
            rule_id: id.to_string(),
            source_region: Some("us-east-1".to_string()),
            dest_region: dest.to_string(),
            entity_filter: None,
            category_filter: vec![],
            severity_min: None,
            enabled: true,
            priority: 0,
        }
    }

    #[test]
    fn test_add_and_remove_route() {
        let router = RegionRouter::new("us-east-1");
        let rule = make_rule("r1", "eu-west-1");
        assert!(router.add_route(rule).is_ok());
        assert_eq!(router.list_routes().len(), 1);

        assert!(router.remove_route("r1"));
        assert_eq!(router.list_routes().len(), 0);
        assert!(!router.remove_route("r1"));
    }

    #[test]
    fn test_route_event() {
        let router = RegionRouter::new("us-east-1");
        router.add_route(make_rule("r1", "eu-west-1")).unwrap();

        let event = make_event(EventCategory::Network, Severity::Medium);
        let routed = router.route_event(&event);
        assert!(routed.is_some());
        let routed = routed.unwrap();
        assert_eq!(routed.dest_region, "eu-west-1");
        assert_eq!(routed.routing_rule_id, "r1");
    }

    #[test]
    fn test_route_event_no_matching_rule() {
        let router = RegionRouter::new("us-east-1");
        let mut rule = make_rule("r1", "eu-west-1");
        rule.severity_min = Some(Severity::Critical);
        router.add_route(rule).unwrap();

        let event = make_event(EventCategory::Network, Severity::Medium);
        assert!(router.route_event(&event).is_none());
    }

    #[test]
    fn test_update_route_table() {
        let router = RegionRouter::new("us-east-1");
        assert!(router.get_destination("entity-1").is_none());

        router.update_route_table("entity-1", "eu-west-1");
        assert_eq!(
            router.get_destination("entity-1"),
            Some("eu-west-1".to_string())
        );
    }

    #[test]
    fn test_routing_stats() {
        let router = RegionRouter::new("us-east-1");

        let mut rule1 = make_rule("r1", "eu-west-1");
        rule1.source_region = Some("us-east-1".to_string());
        router.add_route(rule1).unwrap();

        let mut rule2 = make_rule("r2", "ap-south-1");
        rule2.source_region = Some("us-west-2".to_string());
        router.add_route(rule2).unwrap();

        let e1 = make_event(EventCategory::Network, Severity::High);
        let e2 = SecurityEvent::new(
            EventCategory::Filesystem,
            EventAction::Detected,
            EventSource {
                collector: "test".to_string(),
                host_id: "host-2".to_string(),
                host_name: "test-host-2".to_string(),
                agent_id: "agent-2".to_string(),
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
            },
            "test event 2",
            "test description 2",
        )
        .with_severity(Severity::Low)
        .with_region("us-west-2");

        router.route_event(&e1);
        router.route_event(&e2);

        let stats = router.routing_stats();
        assert_eq!(stats.get("eu-west-1"), Some(&1));
        assert_eq!(stats.get("ap-south-1"), Some(&1));
    }
}
