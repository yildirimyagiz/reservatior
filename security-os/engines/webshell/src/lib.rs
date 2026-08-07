use std::collections::HashMap;
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::{debug, warn};

const WEBSHELL_SIGNATURES: &[&str] = &[
    "eval(",
    "eval(base64_decode(",
    "system($_",
    "passthru($_",
    "shell_exec($_",
    "exec($_",
    "popen($_",
    "proc_open($_",
    "assert($_",
    "preg_replace.*e",
    "create_function(",
    "call_user_func(",
    "call_user_func_array(",
    "base64_decode($_",
    "gzinflate(base64_decode(",
    "gzuncompress(base64_decode(",
    "str_rot13(base64_decode(",
    "<%eval request(",
    "<%Dim ",
    "<%Set ",
    "<%execute ",
    "<script language=",
    "Process.Start(",
    "cmd.exe /c",
    "/bin/bash -c",
    "Runtime.getRuntime().exec(",
];

const WEB_EXTENSIONS: &[&str] = &[
    ".php", ".php3", ".php4", ".php5", ".php7", ".phtml", ".pht",
    ".asp", ".aspx", ".asa", ".asax", ".ascx", ".ashx", ".asmx",
    ".jsp", ".jspx", ".jsw", ".jsv", ".jspf",
    ".cgi", ".pl", ".py",
];

const WEB_DIRECTORIES: &[&str] = &[
    "/var/www/html/",
    "/var/www/",
    "/usr/share/nginx/",
    "/srv/www/",
    "/home/*/public_html/",
    "/opt/lampp/htdocs/",
    "/var/www/wordpress/",
    "/var/www/magento/",
    "/usr/local/apache2/htdocs/",
];

const SHELL_BINARIES: &[&str] = &[
    "sh", "bash", "dash", "zsh", "csh", "ksh",
    "cmd.exe", "powershell.exe", "pwsh.exe",
];

pub struct WebShellEngine {
    #[allow(dead_code)]
    known_web_files: DashMap<String, String>,
    suspicious_modifications: DashMap<String, u32>,
    web_server_pids: DashMap<u32, String>,
}

impl WebShellEngine {
    pub fn new() -> Self {
        Self {
            known_web_files: DashMap::new(),
            suspicious_modifications: DashMap::new(),
            web_server_pids: DashMap::new(),
        }
    }

    fn is_web_path(path: &str) -> bool {
        let path_lower = path.to_lowercase();
        WEB_DIRECTORIES
            .iter()
            .any(|dir| path_lower.starts_with(dir) || path_lower.contains(dir))
            || path_lower.contains("/html/")
            || path_lower.contains("/htdocs/")
            || path_lower.contains("/public_html/")
            || path_lower.contains("/webroot/")
            || path_lower.contains("/www/")
    }

    fn has_web_extension(path: &str) -> bool {
        let path_lower = path.to_lowercase();
        WEB_EXTENSIONS.iter().any(|ext| path_lower.ends_with(ext))
    }

    fn contains_webshell_signature(content: &str) -> Option<&'static str> {
        let content_lower = content.to_lowercase();
        for &sig in WEBSHELL_SIGNATURES {
            if content_lower.contains(&sig.to_lowercase()) {
                return Some(sig);
            }
        }
        None
    }

    fn is_web_server(process_name: &str) -> bool {
        let name = process_name.to_lowercase();
        matches!(
            name.as_str(),
            "nginx" | "apache2" | "httpd" | "caddy" | "lighttpd"
                | "iis" | "w3wp" | "tomcat" | "php-fpm" | "node"
                | "python" | "gunicorn" | "uvicorn" | "puma"
                | "java" | "dotnet" | "kestrel"
        )
    }

    fn detect_web_server_spawning_shell(
        &self,
        parent_pid: u32,
        parent_name: &str,
        child_name: &str,
        child_pid: u32,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        let child_lower = child_name.to_lowercase();
        let is_shell = SHELL_BINARIES
            .iter()
            .any(|s| child_lower == *s || child_lower.ends_with(&format!("/{}", s)));

        if !is_shell {
            return None;
        }

        let mut event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Detected,
            source.clone(),
            format!(
                "Web server spawned shell: {} -> {}",
                parent_name, child_name
            ),
            format!(
                "Web server process {} (PID {}) spawned shell {} (PID {}). \
                 This may indicate a webshell or remote code execution vulnerability.",
                parent_name, parent_pid, child_name, child_pid
            ),
        )
        .with_severity(Severity::Critical)
        .with_confidence(0.90)
        .with_risk_score(90.0)
        .with_mitre(
            "Persistence",
            "Server Software Component: Web Shell",
            "T1505.003",
        )
        .with_tag("webshell_process_spawn");

        event.affected_entities.push(Entity {
            entity_type: EntityType::Process,
            value: format!("{}:{}", parent_pid, parent_name),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });
        event.affected_entities.push(Entity {
            entity_type: EntityType::Process,
            value: format!("{}:{}", child_pid, child_name),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    fn detect_webshell_content(
        &self,
        file_path: &str,
        content: &str,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        let signature = Self::contains_webshell_signature(content)?;

        let mut event = SecurityEvent::new(
            EventCategory::Filesystem,
            EventAction::Detected,
            source.clone(),
            format!("Webshell signature detected in {}", file_path),
            format!(
                "File {} contains webshell signature '{}'. \
                 This file may be a webshell used for unauthorized access.",
                file_path, signature
            ),
        )
        .with_severity(Severity::Critical)
        .with_confidence(0.88)
        .with_risk_score(92.0)
        .with_mitre(
            "Persistence",
            "Server Software Component: Web Shell",
            "T1505.003",
        )
        .with_file(file_path)
        .with_tag("webshell_content");

        event.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: file_path.to_string(),
            risk_contribution: 50.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    fn detect_suspicious_file_modification(
        &self,
        file_path: &str,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        if !Self::is_web_path(file_path) || !Self::has_web_extension(file_path) {
            return None;
        }

        let mut count = self
            .suspicious_modifications
            .entry(file_path.to_string())
            .or_insert(0);
        *count += 1;
        let mod_count = *count;
        drop(count);

        if mod_count < 3 {
            return None;
        }

        let severity = if mod_count >= 10 {
            Severity::Critical
        } else if mod_count >= 5 {
            Severity::High
        } else {
            Severity::Medium
        };

        let mut event = SecurityEvent::new(
            EventCategory::Filesystem,
            EventAction::Detected,
            source.clone(),
            format!("Frequent web file modification: {}", file_path),
            format!(
                "Web-accessible file {} has been modified {} times. \
                 Repeated modifications to web files may indicate webshell deployment.",
                file_path, mod_count
            ),
        )
        .with_severity(severity)
        .with_confidence(0.75)
        .with_risk_score(70.0)
        .with_mitre(
            "Persistence",
            "Server Software Component: Web Shell",
            "T1505.003",
        )
        .with_file(file_path)
        .with_tag("web_file_modification");

        event.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: file_path.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        // Track web server processes
        if event.category == EventCategory::Process
            && (event.action == EventAction::Created || event.action == EventAction::Started)
        {
            if let Some(ref proc_name) = event.source.process_name {
                if Self::is_web_server(proc_name) {
                    if let Some(pid) = event.source.process_id {
                        self.web_server_pids
                            .insert(pid, proc_name.clone());
                        debug!("Tracking web server PID {}: {}", pid, proc_name);
                    }
                }
            }
        }

        // Detect web server spawning shell
        if event.category == EventCategory::Process
            && (event.action == EventAction::Created || event.action == EventAction::Started)
        {
            if let Some(parent_pid) = event.ppid {
                if let Some(parent_name) = self.web_server_pids.get(&parent_pid) {
                    let parent_name = parent_name.clone();
                    let child_name = event
                        .source
                        .process_name
                        .clone()
                        .unwrap_or_default();
                    let child_pid = event.source.process_id.unwrap_or(0);

                    if let Some(det) = self.detect_web_server_spawning_shell(
                        parent_pid,
                        &parent_name,
                        &child_name,
                        child_pid,
                        &event.source,
                    ) {
                        warn!("Web server shell spawn detected: {}", det.title);
                        detections.push(det);
                    }
                }
            }
        }

        // Detect webshell content in files
        if event.category == EventCategory::Filesystem
            && (event.action == EventAction::Created || event.action == EventAction::Modified)
        {
            if let Some(ref path) = event.file_path {
                if Self::has_web_extension(path) {
                    if let Some(content) = event
                        .metadata
                        .get("file_content")
                        .and_then(|v| v.as_str())
                    {
                        if let Some(det) =
                            self.detect_webshell_content(path, content, &event.source)
                        {
                            warn!("Webshell content detected: {}", det.title);
                            detections.push(det);
                        }
                    }
                }
            }
        }

        // Detect suspicious web file modifications
        if event.category == EventCategory::Filesystem
            && event.action == EventAction::Modified
        {
            if let Some(ref path) = event.file_path {
                if let Some(det) =
                    self.detect_suspicious_file_modification(path, &event.source)
                {
                    warn!("Suspicious web file modification: {}", det.title);
                    detections.push(det);
                }
            }
        }

        detections
    }
}

#[cfg(test)]
mod tests {
    use super::*;

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

    fn make_process_event(pid: u32, name: &str, ppid: Option<u32>) -> SecurityEvent {
        let mut source = make_source();
        source.process_name = Some(name.to_string());
        source.process_id = Some(pid);
        let mut event = SecurityEvent::new(
            EventCategory::Process,
            EventAction::Created,
            source,
            format!("Process created: {}", name),
            format!("Process {} with PID {} created", name, pid),
        );
        event.ppid = ppid;
        event
    }

    fn make_file_event(path: &str, action: EventAction, content: Option<&str>) -> SecurityEvent {
        let source = make_source();
        let mut event = SecurityEvent::new(
            EventCategory::Filesystem,
            action,
            source,
            format!("File event: {}", path),
            format!("Event on file {}", path),
        );
        event.file_path = Some(path.to_string());
        if let Some(c) = content {
            event
                .metadata
                .insert("file_content".to_string(), serde_json::Value::String(c.to_string()));
        }
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = WebShellEngine::new();
        assert!(engine.known_web_files.is_empty());
        assert!(engine.web_server_pids.is_empty());
    }

    #[test]
    fn test_web_server_spawning_shell() {
        let mut engine = WebShellEngine::new();
        let web_event = make_process_event(100, "nginx", Some(1));
        engine.process_event(&web_event);

        let shell_event = make_process_event(101, "bash", Some(100));
        let detections = engine.process_event(&shell_event);
        assert_eq!(detections.len(), 1);
        assert_eq!(detections[0].severity, Severity::Critical);
        assert!(detections[0].mitre_id.as_deref() == Some("T1505.003"));
    }

    #[test]
    fn test_webshell_content_detection() {
        let mut engine = WebShellEngine::new();
        let event = make_file_event(
            "/var/www/html/shell.php",
            EventAction::Created,
            Some("<?php eval(base64_decode($_POST['cmd'])); ?>"),
        );
        let detections = engine.process_event(&event);
        assert_eq!(detections.len(), 1);
        assert!(detections[0]
            .tags
            .contains(&"webshell_content".to_string()));
    }

    #[test]
    fn test_suspicious_web_file_modification() {
        let mut engine = WebShellEngine::new();
        for _ in 0..5 {
            let event = make_file_event(
                "/var/www/html/index.php",
                EventAction::Modified,
                None,
            );
            engine.process_event(&event);
        }
        let final_event = make_file_event(
            "/var/www/html/index.php",
            EventAction::Modified,
            None,
        );
        let detections = engine.process_event(&final_event);
        assert!(!detections.is_empty());
    }
}
