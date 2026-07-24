use chrono::{DateTime, Duration, Utc};
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::warn;

const API_RATE_LIMIT_THRESHOLD: u64 = 100;
const API_RATE_WINDOW_SECS: i64 = 60;
const SQL_INJECTION_PATTERNS: &[&str] = &[
    "' OR '1'='1",
    "' OR 1=1",
    "1' OR '1'='1",
    "UNION SELECT",
    "UNION ALL SELECT",
    "DROP TABLE",
    "DROP DATABASE",
    "INSERT INTO",
    "DELETE FROM",
    "UPDATE SET",
    "EXEC(",
    "EXECUTE(",
    "xp_cmdshell",
    "WAITFOR DELAY",
    "SLEEP(",
    "BENCHMARK(",
    "LOAD_FILE(",
    "INTO OUTFILE",
    "INTO DUMPFILE",
    "--",
    "/*",
    "*/",
    "CHAR(",
    "CONCAT(",
    "0x",
    " INFORMATION_SCHEMA",
    "TABLE_NAME",
    "COLUMN_NAME",
];

const XSS_PATTERNS: &[&str] = &[
    "<script",
    "javascript:",
    "onerror=",
    "onload=",
    "onclick=",
    "onmouseover=",
    "onfocus=",
    "onblur=",
    "onsubmit=",
    "onchange=",
    "onkeydown=",
    "onkeyup=",
    "onkeypress=",
    "eval(",
    "document.cookie",
    "document.domain",
    "innerHTML",
    "outerHTML",
    "src=",
    "iframe",
    "object",
    "embed",
    "alert(",
    "prompt(",
    "confirm(",
    "fromCharCode",
    "String.fromCharCode",
    "atob(",
    "btoa(",
];

const JWT_SUSPICIOUS_PATTERNS: &[&str] = &[
    "none",
    "None",
    "NONE",
    "alg",
    "\"alg\":",
    "\"typ\":",
    "HS256",
    "RS256",
    "sign",
    "verify",
    "forge",
    "tamper",
    "manipulate",
    "base64",
    "eyJ", // JWT header base64 prefix
];

const PATH_TRAVERSAL_PATTERNS: &[&str] = &[
    "../",
    "..\\",
    "%2e%2e%2f",
    "%2e%2e/",
    "%2e%2e\\",
    "..%2f",
    "..%5c",
    "%2e%2e%5c",
    "....//",
    "....\\\\",
];

#[derive(Debug, Clone)]
pub struct RequestRecord {
    pub timestamp: DateTime<Utc>,
    pub endpoint: String,
    pub method: String,
    pub status_code: u16,
}

#[derive(Debug, Clone)]
pub struct RateTracker {
    pub requests: Vec<RequestRecord>,
    pub total_bytes_in: u64,
    pub total_bytes_out: u64,
}

impl RateTracker {
    fn new() -> Self {
        Self {
            requests: Vec::new(),
            total_bytes_in: 0,
            total_bytes_out: 0,
        }
    }

    fn cleanup_old(&mut self, cutoff: DateTime<Utc>) {
        self.requests.retain(|r| r.timestamp >= cutoff);
    }

    fn add_request(&mut self, record: RequestRecord) {
        self.requests.push(record);
    }
}

pub struct ApiEngine {
    rate_trackers: DashMap<String, RateTracker>,
    injection_alert_cooldown: DashMap<String, DateTime<Utc>>,
    jwt_alert_cooldown: DashMap<String, DateTime<Utc>>,
}

impl ApiEngine {
    pub fn new() -> Self {
        Self {
            rate_trackers: DashMap::new(),
            injection_alert_cooldown: DashMap::new(),
            jwt_alert_cooldown: DashMap::new(),
        }
    }

    fn detect_rate_abuse(
        &self,
        source_ip: &str,
        tracker: &RateTracker,
        now: DateTime<Utc>,
    ) -> Option<SecurityEvent> {
        let window_start = now - Duration::seconds(API_RATE_WINDOW_SECS);
        let recent_requests: Vec<&RequestRecord> = tracker
            .requests
            .iter()
            .filter(|r| r.timestamp >= window_start)
            .collect();

        if recent_requests.len() as u64 >= API_RATE_LIMIT_THRESHOLD {
            let unique_endpoints: Vec<&str> = recent_requests
                .iter()
                .map(|r| r.endpoint.as_str())
                .collect::<std::collections::HashSet<_>>()
                .into_iter()
                .collect();

            let error_count = recent_requests
                .iter()
                .filter(|r| r.status_code >= 400)
                .count();

            let source = EventSource {
                collector: "api-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "api-engine-agent".to_string(),
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

            let mut rate_event = SecurityEvent::new(
                EventCategory::Api,
                EventAction::Detected,
                source,
                format!("API rate limit abuse from {}", source_ip),
                format!(
                    "Source IP '{}' made {} requests within {} seconds, exceeding the {} \
                     request threshold. Unique endpoints targeted: {}. Error responses: {}. \
                     This may indicate automated scraping, brute force, or denial of service.",
                    source_ip,
                    recent_requests.len(),
                    API_RATE_WINDOW_SECS,
                    API_RATE_LIMIT_THRESHOLD,
                    unique_endpoints.len(),
                    error_count,
                ),
            )
            .with_severity(Severity::High)
            .with_confidence(0.85)
            .with_risk_score(75.0)
            .with_mitre(
                "Impact",
                "Endpoint Denial of Service",
                "T1499",
            )
            .with_tag("api-abuse")
            .with_tag("rate-limit-exceeded");

            rate_event.metadata.insert(
                "request_count".to_string(),
                serde_json::Value::Number(recent_requests.len().into()),
            );
            rate_event.metadata.insert(
                "unique_endpoints".to_string(),
                serde_json::Value::Number(unique_endpoints.len().into()),
            );
            rate_event.metadata.insert(
                "error_count".to_string(),
                serde_json::Value::Number(error_count.into()),
            );
            rate_event.metadata.insert(
                "window_seconds".to_string(),
                serde_json::Value::Number(API_RATE_WINDOW_SECS.into()),
            );

            rate_event.affected_entities.push(Entity {
                entity_type: EntityType::Ip,
                value: source_ip.to_string(),
                risk_contribution: 40.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(rate_event);
        }

        None
    }

    fn detect_jwt_manipulation(
        &self,
        source_ip: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if let Some(cooldown) = self.jwt_alert_cooldown.get(source_ip) {
            if event.timestamp - *cooldown < Duration::seconds(300) {
                return None;
            }
        }

        let mut suspicious_jwt_indicators = Vec::new();

        let auth_header = event
            .metadata
            .get("auth_header")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let jwt_token = event
            .metadata
            .get("jwt_token")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let token_parts: Vec<&str> = jwt_token.split('.').collect();
        if token_parts.len() == 3 {
            let header_b64 = token_parts[0];
            let decoded_header = base64_decode(header_b64);

            let header_lower = decoded_header.to_lowercase();

            if header_lower.contains("\"alg\"") {
                if header_lower.contains("\"none\"") || header_lower.contains(":none") || header_lower.contains(":none,") || header_lower.contains(",none") {
                    suspicious_jwt_indicators.push("none-algorithm".to_string());
                }
                if header_lower.contains("hs256") && event
                    .metadata
                    .get("expected_algorithm")
                    .and_then(|v| v.as_str())
                    == Some("RS256")
                {
                    suspicious_jwt_indicators.push("algorithm-downgrade".to_string());
                }
            }

            let payload_b64 = token_parts[1];
            let decoded_payload = base64_decode(payload_b64);

            let payload_lower = decoded_payload.to_lowercase();
            if payload_lower.contains("\"exp\"") {
                if let Some(exp_start) = payload_lower.find("\"exp\":") {
                    let exp_str = &payload_lower[exp_start + 6..];
                    if let Some(exp_val) = exp_str.split(|c: char| !c.is_ascii_digit()).next() {
                        if let Ok(exp) = exp_val.parse::<i64>() {
                            let now = event.timestamp.timestamp();
                            if exp < now - 3600 {
                                suspicious_jwt_indicators.push("expired-token".to_string());
                            }
                            if exp > now + 365 * 24 * 3600 {
                                suspicious_jwt_indicators.push("excessive-expiry".to_string());
                            }
                        }
                    }
                }
            }
        }

        for pattern in JWT_SUSPICIOUS_PATTERNS {
            if auth_header.to_lowercase().contains(&pattern.to_lowercase()) {
                let indicator = format!("auth-header:{}", pattern);
                if !suspicious_jwt_indicators.contains(&indicator) {
                    suspicious_jwt_indicators.push(indicator);
                }
            }
        }

        if suspicious_jwt_indicators.len() >= 2 {
            self.jwt_alert_cooldown
                .insert(source_ip.to_string(), event.timestamp);

            let source = EventSource {
                collector: "api-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "api-engine-agent".to_string(),
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
            };

            let mut jwt_event = SecurityEvent::new(
                EventCategory::Api,
                EventAction::Detected,
                source,
                format!("JWT manipulation attempt detected from {}", source_ip),
                format!(
                    "Source IP '{}' sent a request with suspicious JWT indicators: [{}]. \
                     This may indicate an attempt to forge, tamper with, or bypass JWT \
                     authentication tokens.",
                    source_ip,
                    suspicious_jwt_indicators.join(", "),
                ),
            )
            .with_severity(Severity::High)
            .with_confidence(0.85)
            .with_risk_score(85.0)
            .with_mitre(
                "Defense Evasion",
                "Impair Defenses: Modify Authentication Process",
                "T1562.008",
            )
            .with_tag("jwt-manipulation")
            .with_tag("authentication-bypass");

            jwt_event.metadata.insert(
                "indicators".to_string(),
                serde_json::Value::Array(
                    suspicious_jwt_indicators
                        .iter()
                        .map(|i| serde_json::Value::String(i.clone()))
                        .collect(),
                ),
            );

            jwt_event.affected_entities.push(Entity {
                entity_type: EntityType::Ip,
                value: source_ip.to_string(),
                risk_contribution: 40.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(jwt_event);
        }

        None
    }

    fn detect_injection(
        &self,
        source_ip: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if let Some(cooldown) = self.injection_alert_cooldown.get(source_ip) {
            if event.timestamp - *cooldown < Duration::seconds(60) {
                return None;
            }
        }

        let mut sql_indicators = Vec::new();
        let mut xss_indicators = Vec::new();
        let mut path_traversal_indicators = Vec::new();

        let params = event
            .metadata
            .get("request_params")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let body = event
            .metadata
            .get("request_body")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let url = event
            .metadata
            .get("request_url")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let query_string = event
            .metadata
            .get("query_string")
            .and_then(|v| v.as_str())
            .unwrap_or("");

        let combined_input = format!("{} {} {} {}", params, body, url, query_string).to_lowercase();

        for pattern in SQL_INJECTION_PATTERNS {
            if combined_input.contains(&pattern.to_lowercase()) {
                sql_indicators.push(pattern.to_string());
            }
        }

        for pattern in XSS_PATTERNS {
            if combined_input.contains(&pattern.to_lowercase()) {
                xss_indicators.push(pattern.to_string());
            }
        }

        for pattern in PATH_TRAVERSAL_PATTERNS {
            if combined_input.contains(&pattern.to_lowercase()) {
                path_traversal_indicators.push(pattern.to_string());
            }
        }

        let mut all_indicators = Vec::new();
        let mut injection_type = String::new();

        if !sql_indicators.is_empty() {
            all_indicators.extend(sql_indicators.iter().map(|i| format!("SQL:{}", i)));
            injection_type = "SQL Injection".to_string();
        }
        if !xss_indicators.is_empty() {
            all_indicators.extend(xss_indicators.iter().map(|i| format!("XSS:{}", i)));
            if injection_type.is_empty() {
                injection_type = "Cross-Site Scripting".to_string();
            } else {
                injection_type.push_str(" + XSS");
            }
        }
        if !path_traversal_indicators.is_empty() {
            all_indicators.extend(
                path_traversal_indicators
                    .iter()
                    .map(|i| format!("PathTraversal:{}", i)),
            );
            if injection_type.is_empty() {
                injection_type = "Path Traversal".to_string();
            } else {
                injection_type.push_str(" + Path Traversal");
            }
        }

        if !all_indicators.is_empty() {
            self.injection_alert_cooldown
                .insert(source_ip.to_string(), event.timestamp);

            let source = EventSource {
                collector: "api-engine".to_string(),
                host_id: "unknown".to_string(),
                host_name: "unknown".to_string(),
                agent_id: "api-engine-agent".to_string(),
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
            };

            let endpoint = event
                .metadata
                .get("request_url")
                .and_then(|v| v.as_str())
                .unwrap_or("unknown");

            let mut injection_event = SecurityEvent::new(
                EventCategory::Api,
                EventAction::Detected,
                source,
                format!(
                    "{} attempt detected from {} on {}",
                    injection_type, source_ip, endpoint
                ),
                format!(
                    "Source IP '{}' submitted a request to '{}' containing {} indicators: [{}]. \
                     This may indicate an attempt to exploit the application through injection.",
                    source_ip,
                    endpoint,
                    injection_type,
                    all_indicators.iter().take(10).cloned().collect::<Vec<_>>().join(", "),
                ),
            )
            .with_severity(Severity::Critical)
            .with_confidence(0.9)
            .with_risk_score(90.0)
            .with_mitre(
                "Initial Access",
                "Exploit Public-Facing Application",
                "T1190",
            )
            .with_tag("injection-attempt")
            .with_tag(&injection_type.to_lowercase().replace(' ', "-"));

            injection_event.metadata.insert(
                "injection_type".to_string(),
                serde_json::Value::String(injection_type),
            );
            injection_event.metadata.insert(
                "indicators".to_string(),
                serde_json::Value::Array(
                    all_indicators
                        .iter()
                        .map(|i| serde_json::Value::String(i.clone()))
                        .collect(),
                ),
            );
            injection_event.metadata.insert(
                "endpoint".to_string(),
                serde_json::Value::String(endpoint.to_string()),
            );

            injection_event.affected_entities.push(Entity {
                entity_type: EntityType::Ip,
                value: source_ip.to_string(),
                risk_contribution: 40.0,
            
                metadata: std::collections::HashMap::new(),
            });
            injection_event.affected_entities.push(Entity {
                entity_type: EntityType::Url,
                value: endpoint.to_string(),
                risk_contribution: 30.0,
            
                metadata: std::collections::HashMap::new(),
            });

            return Some(injection_event);
        }

        None
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        if event.category == EventCategory::Api {
            let source_ip = event
                .metadata
                .get("source_ip")
                .and_then(|v| v.as_str())
                .or_else(|| event.metadata.get("src_ip").and_then(|v| v.as_str()))
                .unwrap_or("unknown")
                .to_string();

            {
                let mut tracker = self
                    .rate_trackers
                    .entry(source_ip.clone())
                    .or_insert_with(RateTracker::new);

                let window_start = event.timestamp - Duration::seconds(API_RATE_WINDOW_SECS * 2);
                tracker.cleanup_old(window_start);

                let endpoint = event
                    .metadata
                    .get("request_url")
                    .and_then(|v| v.as_str())
                    .unwrap_or("unknown")
                    .to_string();

                let method = event
                    .metadata
                    .get("request_method")
                    .and_then(|v| v.as_str())
                    .unwrap_or("GET")
                    .to_string();

                let status_code = event
                    .metadata
                    .get("status_code")
                    .and_then(|v| v.as_u64())
                    .unwrap_or(200) as u16;

                tracker.add_request(RequestRecord {
                    timestamp: event.timestamp,
                    endpoint,
                    method,
                    status_code,
                });

                if let Some(rate_event) =
                    self.detect_rate_abuse(&source_ip, &tracker, event.timestamp)
                {
                    warn!("API rate abuse detected from {}: {}", source_ip, rate_event.title);
                    detections.push(rate_event);
                }
            }

            if let Some(jwt_event) = self.detect_jwt_manipulation(&source_ip, event) {
                warn!(
                    "JWT manipulation detected from {}: {}",
                    source_ip, jwt_event.title
                );
                detections.push(jwt_event);
            }

            if let Some(injection_event) = self.detect_injection(&source_ip, event) {
                warn!(
                    "Injection attempt detected from {}: {}",
                    source_ip, injection_event.title
                );
                detections.push(injection_event);
            }
        }

        detections
    }
}

fn base64_decode(input: &str) -> String {
    use std::io::Write;

    let alphabet = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    let mut result = Vec::new();
    let mut buffer: u32 = 0;
    let mut bits_read = 0;

    for &byte in input.as_bytes() {
        if byte == b'=' {
            break;
        }
        let val = alphabet
            .iter()
            .position(|&b| b == byte)
            .unwrap_or(0) as u32;
        buffer = (buffer << 6) | val;
        bits_read += 6;

        if bits_read >= 8 {
            bits_read -= 8;
            result.push((buffer >> bits_read) as u8);
            buffer &= (1 << bits_read) - 1;
        }
    }

    String::from_utf8_lossy(&result).to_string()
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;
    use std::collections::HashMap;
    use uuid::Uuid;

    fn make_api_event(
        source_ip: &str,
        url: &str,
        method: &str,
        params: &str,
    ) -> SecurityEvent {
        let mut metadata = HashMap::new();
        metadata.insert(
            "source_ip".to_string(),
            serde_json::Value::String(source_ip.to_string()),
        );
        metadata.insert(
            "request_url".to_string(),
            serde_json::Value::String(url.to_string()),
        );
        metadata.insert(
            "request_method".to_string(),
            serde_json::Value::String(method.to_string()),
        );
        metadata.insert(
            "request_params".to_string(),
            serde_json::Value::String(params.to_string()),
        );
        metadata.insert(
            "status_code".to_string(),
            serde_json::Value::Number(200.into()),
        );

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

        let mut event = SecurityEvent::new(
            EventCategory::Api,
            EventAction::Created,
            source,
            format!("API request: {} {}", method, url),
            format!("API request to {}", url),
        );
        event.metadata = metadata;
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = ApiEngine::new();
        assert!(engine.rate_trackers.is_empty());
    }

    #[test]
    fn test_sql_injection_detection() {
        let mut engine = ApiEngine::new();
        let event = make_api_event(
            "10.0.0.1",
            "/api/users",
            "GET",
            "id=1' OR '1'='1",
        );
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
        assert!(detections.iter().any(|d| {
            d.tags
                .iter()
                .any(|t| t.contains("injection"))
        }));
    }

    #[test]
    fn test_xss_detection() {
        let mut engine = ApiEngine::new();
        let event = make_api_event(
            "10.0.0.2",
            "/api/search",
            "GET",
            "q=<script>alert('xss')</script>",
        );
        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
    }

    #[test]
    fn test_jwt_none_algorithm() {
        let mut engine = ApiEngine::new();
        let mut event = make_api_event("10.0.0.3", "/api/protected", "GET", "");
        event.metadata.insert(
            "jwt_token".to_string(),
            serde_json::Value::String(
                "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJzdWIiOiIxMjM0NTY3ODkwIn0.".to_string(),
            ),
        );
        event.metadata.insert(
            "auth_header".to_string(),
            serde_json::Value::String("Bearer eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.".to_string()),
        );

        let detections = engine.process_event(&event);
        assert!(!detections.is_empty());
    }

    #[test]
    fn test_base64_decode() {
        assert_eq!(base64_decode("SGVsbG8="), "Hello");
        assert_eq!(base64_decode("VGVzdA=="), "Test");
    }
}
