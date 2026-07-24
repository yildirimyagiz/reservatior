use std::collections::HashMap;
use dashmap::DashMap;
use regex::Regex;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::{debug, warn};

pub struct InjectionEngine {
    sql_injection_patterns: Vec<Regex>,
    command_injection_patterns: Vec<Regex>,
    xss_patterns: Vec<Regex>,
    ssrf_patterns: Vec<Regex>,
    nosql_injection_patterns: Vec<Regex>,
    ldap_injection_patterns: Vec<Regex>,
    detections_cache: DashMap<String, u32>,
}

impl InjectionEngine {
    pub fn new() -> Self {
        let sql_patterns: Vec<Regex> = vec![
            Regex::new(r"(?i)(\bunion\b\s+\bselect\b)").unwrap(),
            Regex::new(r"(?i)(\bselect\b\s+.*\bfrom\b\s+.*\bwhere\b)").unwrap(),
            Regex::new(r"(?i)(\binsert\b\s+\binto\b\s+)").unwrap(),
            Regex::new(r"(?i)(\bdelete\b\s+\bfrom\b\s+)").unwrap(),
            Regex::new(r"(?i)(\bdrop\b\s+\b(table|database|column)\b)").unwrap(),
            Regex::new(r"(?i)(\bupdate\b\s+\w+\s+\bset\b)").unwrap(),
            Regex::new(r"(?i)(--\s*$|/\*.*\*/)").unwrap(),
            Regex::new(r"(?i)(\bor\b\s+\d+\s*=\s*\d+)").unwrap(),
            Regex::new(r"(?i)(\band\b\s+\d+\s*=\s*\d+)").unwrap(),
            Regex::new(r"(?i)(\bexec\b\s*\()").unwrap(),
            Regex::new(r"(?i)(;\s*\bdrop\b)").unwrap(),
            Regex::new(r"(?i)('\s*or\s*')").unwrap(),
            Regex::new(r"(?i)(\bxp_cmdshell\b)").unwrap(),
            Regex::new(r"(?i)(\bsql_query\b\s*=)").unwrap(),
        ];

        let cmd_patterns: Vec<Regex> = vec![
            Regex::new(r"(;\s*(ls|cat|echo|wget|curl|bash|sh|python|perl|ruby)\b)").unwrap(),
            Regex::new(r"(\|\s*(ls|cat|echo|wget|curl|bash|sh|python|perl|ruby)\b)").unwrap(),
            Regex::new(r"(\$\([^)]*\))").unwrap(),
            Regex::new(r"(`[^`]*`)").unwrap(),
            Regex::new(r"(;\s*\bnc\b\s+)").unwrap(),
            Regex::new(r"(;\s*\bbash\b\s+-c)").unwrap(),
            Regex::new(r"(\b(os|system|popen|subprocess)\b\s*\()").unwrap(),
            Regex::new(r"(;\s*\bchmod\b\s+)").unwrap(),
            Regex::new(r"(\|\s*python\s+-c)").unwrap(),
            Regex::new(r"(\|\s*perl\s+-e)").unwrap(),
        ];

        let xss_patterns: Vec<Regex> = vec![
            Regex::new(r"(<script[^>]*>)").unwrap(),
            Regex::new(r"(javascript\s*:)").unwrap(),
            Regex::new(r#"(on\w+\s*=\s*["'])"#).unwrap(),
            Regex::new(r"(<img[^>]*\bonerror\s*=)").unwrap(),
            Regex::new(r"(<svg[^>]*\bonload\s*=)").unwrap(),
            Regex::new(r"(document\s*\.\s*(cookie|write|location))").unwrap(),
            Regex::new(r"(eval\s*\(\s*document)").unwrap(),
            Regex::new(r"(window\s*\.\s*(location|open)\s*=)").unwrap(),
            Regex::new(r"(alert\s*\()").unwrap(),
            Regex::new(r#"(<iframe[^>]*src\s*=\s*["']?javascript)"#).unwrap(),
        ];

        let ssrf_patterns: Vec<Regex> = vec![
            Regex::new(r"(https?://(localhost|127\.0\.0\.1|0\.0\.0\.0|169\.254\.\d+\.\d+))").unwrap(),
            Regex::new(r"(https?://(10\.\d+\.\d+\.\d+|172\.(1[6-9]|2\d|3[01])\.\d+\.\d+|192\.168\.\d+\.\d+))").unwrap(),
            Regex::new(r"(https?://\[::1\])").unwrap(),
            Regex::new(r"(metadata\.google\.internal)").unwrap(),
            Regex::new(r"(169\.254\.169\.254)").unwrap(),
            Regex::new(r"(http://[a-z0-9]+\.internal)").unwrap(),
            Regex::new(r"(file:///etc/passwd)").unwrap(),
            Regex::new(r"(gopher://)").unwrap(),
            Regex::new(r"(dict://)").unwrap(),
        ];

        let nosql_patterns: Vec<Regex> = vec![
            Regex::new(r"(\{\s*\$where\s*:)").unwrap(),
            Regex::new(r"(\{\s*\$regex\s*:)").unwrap(),
            Regex::new(r"(\{\s*\$gt\s*:|\{\s*\$gte\s*:|\{\s*\$lt\s*:|\{\s*\$lte\s*:)").unwrap(),
            Regex::new(r"(\{\s*\$ne\s*:)").unwrap(),
            Regex::new(r"(\{\s*\$in\s*:)").unwrap(),
            Regex::new(r"(\{\s*\$nin\s*:)").unwrap(),
            Regex::new(r"(;\s*\$exec\b)").unwrap(),
            Regex::new(r"(\{\s*\$atomic\s*:)").unwrap(),
        ];

        let ldap_patterns: Vec<Regex> = vec![
            Regex::new(r"(\*\)\(\|(\*|\w))").unwrap(),
            Regex::new(r"(\)(\||\&)\()").unwrap(),
            Regex::new(r"(\(\|[a-zA-Z]+=)").unwrap(),
            Regex::new(r"(cn\s*=\s*\*\s*\)\s*\(\s*objectclass)").unwrap(),
            Regex::new(r"(&(objectClass=)(.*)(\*\))?)").unwrap(),
            Regex::new(r"(!\(objectClass=)").unwrap(),
        ];

        Self {
            sql_injection_patterns: sql_patterns,
            command_injection_patterns: cmd_patterns,
            xss_patterns,
            ssrf_patterns,
            nosql_injection_patterns: nosql_patterns,
            ldap_injection_patterns: ldap_patterns,
            detections_cache: DashMap::new(),
        }
    }

    fn get_injection_fields(event: &SecurityEvent) -> Vec<String> {
        let mut fields = Vec::new();

        if let Some(ref body) = event.metadata.get("request_body").and_then(|v| v.as_str()) {
            fields.push(body.to_string());
        }
        if let Some(ref query) = event.metadata.get("query_string").and_then(|v| v.as_str()) {
            fields.push(query.to_string());
        }
        if let Some(ref uri) = event.metadata.get("request_uri").and_then(|v| v.as_str()) {
            fields.push(uri.to_string());
        }
        if let Some(ref cmdline) = event.cmdline.as_deref() {
            fields.push(cmdline.to_string());
        }
        if let Some(ref params) = event.metadata.get("parameters").and_then(|v| v.as_str()) {
            fields.push(params.to_string());
        }

        fields
    }

    fn check_patterns(
        patterns: &[Regex],
        fields: &[String],
        injection_type: &str,
    ) -> Option<String> {
        for field in fields {
            for pattern in patterns {
                if let Some(m) = pattern.find(field) {
                    return Some(format!(
                        "{} injection pattern '{}' found in input: {}",
                        injection_type,
                        m.as_str(),
                        &field[..field.len().min(200)]
                    ));
                }
            }
        }
        None
    }

    fn create_detection(
        injection_type: &str,
        description: String,
        matched_field: &str,
        source: &EventSource,
        severity: Severity,
        confidence: f64,
        risk_score: f64,
        mitre_id: &str,
    ) -> SecurityEvent {
        let mut event = SecurityEvent::new(
            EventCategory::Api,
            EventAction::Detected,
            source.clone(),
            format!("{} injection detected", injection_type),
            description,
        )
        .with_severity(severity)
        .with_confidence(confidence)
        .with_risk_score(risk_score)
        .with_mitre(
            "Initial Access",
            "Exploit Public-Facing Application",
            mitre_id,
        )
        .with_tag(format!("{}_injection", injection_type.to_lowercase()));

        event.affected_entities.push(Entity {
            entity_type: EntityType::Url,
            value: matched_field.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        event
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        if event.category != EventCategory::Api
            && event.category != EventCategory::Network
            && event.category != EventCategory::Database
        {
            return detections;
        }

        let fields = Self::get_injection_fields(event);
        if fields.is_empty() {
            return detections;
        }

        let source_key = format!(
            "{}:{}",
            event.source.host_id,
            event.source.agent_id
        );

        // SQL injection
        if let Some(desc) = Self::check_patterns(
            &self.sql_injection_patterns,
            &fields,
            "SQL",
        ) {
            let mut count = self.detections_cache.entry(source_key.clone()).or_insert(0);
            *count += 1;
            let total = *count;
            drop(count);

            let severity = if total > 10 {
                Severity::Critical
            } else if total > 5 {
                Severity::High
            } else {
                Severity::Medium
            };

            let detection = Self::create_detection(
                "SQL",
                desc,
                &fields.first().unwrap_or(&String::new()),
                &event.source,
                severity,
                0.85,
                75.0,
                "T1190",
            );
            warn!("SQL injection: {}", detection.title);
            detections.push(detection);
        }

        // Command injection
        if let Some(desc) = Self::check_patterns(
            &self.command_injection_patterns,
            &fields,
            "Command",
        ) {
            let detection = Self::create_detection(
                "Command",
                desc,
                &fields.first().unwrap_or(&String::new()),
                &event.source,
                Severity::Critical,
                0.90,
                85.0,
                "T1059",
            );
            warn!("Command injection: {}", detection.title);
            detections.push(detection);
        }

        // XSS
        if let Some(desc) = Self::check_patterns(
            &self.xss_patterns,
            &fields,
            "XSS",
        ) {
            let detection = Self::create_detection(
                "XSS",
                desc,
                &fields.first().unwrap_or(&String::new()),
                &event.source,
                Severity::Medium,
                0.80,
                60.0,
                "T1190",
            );
            warn!("XSS: {}", detection.title);
            detections.push(detection);
        }

        // SSRF
        if let Some(desc) = Self::check_patterns(
            &self.ssrf_patterns,
            &fields,
            "SSRF",
        ) {
            let detection = Self::create_detection(
                "SSRF",
                desc,
                &fields.first().unwrap_or(&String::new()),
                &event.source,
                Severity::High,
                0.85,
                78.0,
                "T1190",
            );
            warn!("SSRF: {}", detection.title);
            detections.push(detection);
        }

        // NoSQL injection
        if let Some(desc) = Self::check_patterns(
            &self.nosql_injection_patterns,
            &fields,
            "NoSQL",
        ) {
            let detection = Self::create_detection(
                "NoSQL",
                desc,
                &fields.first().unwrap_or(&String::new()),
                &event.source,
                Severity::Medium,
                0.80,
                65.0,
                "T1190",
            );
            warn!("NoSQL injection: {}", detection.title);
            detections.push(detection);
        }

        // LDAP injection
        if let Some(desc) = Self::check_patterns(
            &self.ldap_injection_patterns,
            &fields,
            "LDAP",
        ) {
            let detection = Self::create_detection(
                "LDAP",
                desc,
                &fields.first().unwrap_or(&String::new()),
                &event.source,
                Severity::Medium,
                0.75,
                60.0,
                "T1190",
            );
            warn!("LDAP injection: {}", detection.title);
            detections.push(detection);
        }

        detections
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::HashMap;

    fn make_source() -> EventSource {
        EventSource {
            collector: "test".to_string(),
            host_id: "test-host".to_string(),
            host_name: "test".to_string(),
            agent_id: "test-agent".to_string(),
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
        }
    }

    fn make_api_event(body: &str) -> SecurityEvent {
        let source = make_source();
        let mut event = SecurityEvent::new(
            EventCategory::Api,
            EventAction::Received,
            source,
            "API request".to_string(),
            "Incoming API request".to_string(),
        );
        event
            .metadata
            .insert("request_body".to_string(), serde_json::Value::String(body.to_string()));
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = InjectionEngine::new();
        assert!(!engine.sql_injection_patterns.is_empty());
        assert!(!engine.command_injection_patterns.is_empty());
    }

    #[test]
    fn test_sql_injection() {
        let mut engine = InjectionEngine::new();
        let event = make_api_event("id=1' UNION SELECT username, password FROM users--");
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(detections[0].tags.contains(&"sql_injection".to_string()));
    }

    #[test]
    fn test_command_injection() {
        let mut engine = InjectionEngine::new();
        let event = make_api_event("file=test.txt; cat /etc/passwd");
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(detections[0].tags.contains(&"command_injection".to_string()));
    }

    #[test]
    fn test_xss_detection() {
        let mut engine = InjectionEngine::new();
        let event = make_api_event("<script>alert('xss')</script>");
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(detections[0].tags.contains(&"xss_injection".to_string()));
    }

    #[test]
    fn test_ssrf_detection() {
        let mut engine = InjectionEngine::new();
        let event = make_api_event("url=http://169.254.169.254/latest/meta-data/");
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(detections[0].tags.contains(&"ssrf_injection".to_string()));
    }

    #[test]
    fn test_clean_input() {
        let mut engine = InjectionEngine::new();
        let event = make_api_event("name=John&email=john@example.com");
        let detections = engine.process_event(&event);
        assert!(detections.is_empty());
    }

    #[test]
    fn test_nosql_injection() {
        let mut engine = InjectionEngine::new();
        let event = make_api_event(r#"{"username": {$gt: ""}, "password": {$gt: ""}}"#);
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(detections[0].tags.contains(&"nosql_injection".to_string()));
    }
}
