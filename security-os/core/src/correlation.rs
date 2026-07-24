use crate::event::SecurityEvent;
use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use uuid::Uuid;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CorrelationRule {
    pub id: Uuid,
    pub name: String,
    pub description: String,
    pub source_pattern: EventPattern,
    pub target_pattern: EventPattern,
    pub time_window_secs: u64,
    pub threshold: u32,
    pub risk_multiplier: f64,
    pub output_title: String,
    pub output_severity: crate::Severity,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EventPattern {
    pub category: Option<String>,
    pub action: Option<String>,
    pub source_host: Option<String>,
    pub source_user: Option<String>,
    pub metadata_match: HashMap<String, String>,
}

pub struct CorrelationEngine {
    rules: Vec<CorrelationRule>,
    event_buffer: Vec<SecurityEvent>,
    max_buffer_size: usize,
}

impl CorrelationEngine {
    pub fn new(max_buffer_size: usize) -> Self {
        Self {
            rules: Vec::new(),
            event_buffer: Vec::new(),
            max_buffer_size,
        }
    }

    pub fn add_rule(&mut self, rule: CorrelationRule) {
        self.rules.push(rule);
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        self.event_buffer.push(event.clone());

        if self.event_buffer.len() > self.max_buffer_size {
            let cutoff = Utc::now() - chrono::Duration::seconds(300);
            self.event_buffer.retain(|e| e.timestamp > cutoff);
        }

        let mut correlated = Vec::new();

        for rule in &self.rules {
            if let Some(result) = self.check_correlation(event, rule) {
                correlated.push(result);
            }
        }

        correlated
    }

    fn check_correlation(
        &self,
        trigger: &SecurityEvent,
        rule: &CorrelationRule,
    ) -> Option<SecurityEvent> {
        let window_start = Utc::now() - chrono::Duration::seconds(rule.time_window_secs as i64);

        let matching_events: Vec<&SecurityEvent> = self
            .event_buffer
            .iter()
            .filter(|e| e.timestamp >= window_start)
            .filter(|e| self.matches_pattern(e, &rule.source_pattern))
            .collect();

        if matching_events.len() as u32 >= rule.threshold {
            let mut result = SecurityEvent::new(
                crate::event::EventCategory::Behavior,
                crate::event::EventAction::Correlated,
                trigger.source.clone(),
                &rule.output_title,
                &rule.description,
            )
            .with_severity(rule.output_severity)
            .with_risk_score(trigger.risk_score * rule.risk_multiplier)
            .with_correlation_id(Uuid::new_v4())
            .with_tag("correlation");

            for e in &matching_events {
                result = result.with_parent_event(e.id);
            }

            Some(result)
        } else {
            None
        }
    }

    fn matches_pattern(&self, event: &SecurityEvent, pattern: &EventPattern) -> bool {
        if let Some(ref cat) = pattern.category {
            if format!("{:?}", event.category) != *cat {
                return false;
            }
        }
        if let Some(ref action) = pattern.action {
            if format!("{:?}", event.action) != *action {
                return false;
            }
        }
        if let Some(ref host) = pattern.source_host {
            if event.source.host_id != *host {
                return false;
            }
        }
        if let Some(ref user) = pattern.source_user {
            if event.source.user_id.as_deref() != Some(user.as_str()) {
                return false;
            }
        }
        for (key, value) in &pattern.metadata_match {
            if let Some(actual) = event.metadata.get(key) {
                if actual.as_str() != Some(value.as_str()) {
                    return false;
                }
            } else {
                return false;
            }
        }
        true
    }
}
