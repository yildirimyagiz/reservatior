use chrono::{DateTime, Utc};
use dashmap::DashMap;
use security_os_core::Severity;
use std::sync::Mutex;
use std::time::Duration;

#[derive(Debug, Clone)]
pub struct ThreatPattern {
    pub pattern_id: String,
    pub name: String,
    pub frequency: u32,
    pub first_seen: DateTime<Utc>,
    pub last_seen: DateTime<Utc>,
    pub typical_severity: Severity,
    pub typical_mitre_tactic: Option<String>,
}

#[derive(Debug, Clone)]
pub struct EffectiveResponse {
    pub response_type: String,
    pub used_count: u32,
    pub success_rate: f64,
    pub avg_resolution_time: Duration,
}

#[derive(Debug, Clone, Default)]
pub struct OrgBaselines {
    pub total_assets: u32,
    pub avg_risk_score: f64,
    pub typical_daily_events: u64,
    pub peak_hours: Vec<u8>,
}

pub struct OrgMemory {
    #[allow(dead_code)]
    org_id: String,
    threat_patterns: DashMap<String, ThreatPattern>,
    effective_responses: Mutex<Vec<EffectiveResponse>>,
    global_baselines: Mutex<OrgBaselines>,
}

impl OrgMemory {
    pub fn new(org_id: String) -> Self {
        Self {
            org_id,
            threat_patterns: DashMap::new(),
            effective_responses: Mutex::new(Vec::new()),
            global_baselines: Mutex::new(OrgBaselines::default()),
        }
    }

    pub fn record_threat_pattern(
        &self,
        pattern_id: &str,
        name: &str,
        severity: Severity,
    ) {
        let now = Utc::now();
        let mut entry = self
            .threat_patterns
            .entry(pattern_id.to_string())
            .or_insert_with(|| ThreatPattern {
                pattern_id: pattern_id.to_string(),
                name: name.to_string(),
                frequency: 0,
                first_seen: now,
                last_seen: now,
                typical_severity: severity,
                typical_mitre_tactic: None,
            });

        entry.frequency += 1;
        entry.last_seen = now;
    }

    pub fn record_response(
        &self,
        response_type: &str,
        success: bool,
        duration: Duration,
    ) {
        let mut responses = self.effective_responses.lock().unwrap();
        let mut found = false;
        for resp in responses.iter_mut() {
            if resp.response_type == response_type {
                let total = resp.used_count as f64;
                let new_success_rate =
                    (resp.success_rate * total + if success { 1.0 } else { 0.0 }) / (total + 1.0);
                resp.used_count += 1;
                resp.success_rate = new_success_rate;
                resp.avg_resolution_time =
                    (resp.avg_resolution_time * (resp.used_count - 1) as u32 + duration)
                        / resp.used_count;
                found = true;
                break;
            }
        }

        if !found {
            responses.push(EffectiveResponse {
                response_type: response_type.to_string(),
                used_count: 1,
                success_rate: if success { 1.0 } else { 0.0 },
                avg_resolution_time: duration,
            });
        }
    }

    pub fn get_threat_patterns(&self) -> Vec<ThreatPattern> {
        self.threat_patterns.iter().map(|p| p.clone()).collect()
    }

    pub fn get_effective_responses(&self) -> Vec<EffectiveResponse> {
        self.effective_responses.lock().unwrap().clone()
    }

    pub fn update_baselines(
        &self,
        total_assets: u32,
        avg_risk: f64,
        daily_events: u64,
    ) {
        let mut baselines = self.global_baselines.lock().unwrap();
        baselines.total_assets = total_assets;
        baselines.avg_risk_score = avg_risk;
        baselines.typical_daily_events = daily_events;
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::time::Duration;

    #[test]
    fn test_record_threat_pattern() {
        let org = OrgMemory::new("org-1".into());
        org.record_threat_pattern("pat-001", "SQL Injection Campaign", Severity::High);
        org.record_threat_pattern("pat-001", "SQL Injection Campaign", Severity::High);

        let patterns = org.get_threat_patterns();
        assert_eq!(patterns.len(), 1);
        assert_eq!(patterns[0].frequency, 2);
        assert_eq!(patterns[0].name, "SQL Injection Campaign");
    }

    #[test]
    fn test_record_response() {
        let org = OrgMemory::new("org-1".into());
        org.record_response("block_ip", true, Duration::from_secs(60));
        org.record_response("block_ip", true, Duration::from_secs(120));
        org.record_response("block_ip", false, Duration::from_secs(30));

        let responses = org.get_effective_responses();
        assert_eq!(responses.len(), 1);
        assert_eq!(responses[0].used_count, 3);
        assert!((responses[0].success_rate - 2.0 / 3.0).abs() < 0.01);
    }

    #[test]
    fn test_get_threat_patterns() {
        let org = OrgMemory::new("org-1".into());
        org.record_threat_pattern("p1", "Pattern A", Severity::Low);
        org.record_threat_pattern("p2", "Pattern B", Severity::Critical);

        let patterns = org.get_threat_patterns();
        assert_eq!(patterns.len(), 2);
    }

    #[test]
    fn test_effective_responses() {
        let org = OrgMemory::new("org-1".into());
        org.record_response("isolate_host", true, Duration::from_secs(300));
        org.record_response("notify_soc", true, Duration::from_secs(10));

        let responses = org.get_effective_responses();
        assert_eq!(responses.len(), 2);
        assert_eq!(responses[0].response_type, "isolate_host");
        assert_eq!(responses[1].response_type, "notify_soc");
    }
}
