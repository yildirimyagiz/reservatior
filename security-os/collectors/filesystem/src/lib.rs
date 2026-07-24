use security_os_core::{EventAction, EventCategory, EventBus, SecurityEvent, Severity};
use sha2::{Digest, Sha256};
use std::collections::{HashMap, HashSet};
use std::path::Path;
use std::time::Duration;
use tracing::{debug, info, warn};
use walkdir::WalkDir;

pub struct FilesystemCollector {
    watch_paths: Vec<String>,
    critical_paths: Vec<String>,
    baseline: HashMap<String, String>,
    host_id: String,
    host_name: String,
    agent_id: String,
}

impl FilesystemCollector {
    pub fn new(watch_paths: Vec<String>, critical_paths: Vec<String>) -> Self {
        let hostname = hostname::get()
            .map(|h| h.to_string_lossy().into_owned())
            .unwrap_or_else(|_| "unknown".into());

        Self {
            watch_paths,
            critical_paths,
            baseline: HashMap::new(),
            host_id: hostname.clone(),
            host_name: hostname,
            agent_id: "filesystem-collector-0".into(),
        }
    }

    fn compute_hash(path: &Path) -> Option<String> {
        let data = std::fs::read(path).ok()?;
        let mut hasher = Sha256::new();
        hasher.update(&data);
        Some(format!("{:x}", hasher.finalize()))
    }

    fn is_critical_file(&self, path: &Path) -> bool {
        let path_str = path.to_string_lossy().to_lowercase();

        if path_str.ends_with(".env") {
            return true;
        }

        for ext in &[".pem", ".key", ".crt", ".cer", ".p12", ".pfx", ".jks"] {
            if path_str.ends_with(ext) {
                return true;
            }
        }

        let critical_keywords = [
            "id_rsa",
            "id_ed25519",
            "id_dsa",
            "id_ecdsa",
            "known_hosts",
            "authorized_keys",
            "shadow",
            "passwd",
            "sudoers",
        ];

        for keyword in &critical_keywords {
            if path_str.contains(keyword) {
                return true;
            }
        }

        for critical_path in &self.critical_paths {
            if path_str == critical_path.to_lowercase() {
                return true;
            }
        }

        false
    }

    fn severity_for_file(&self, path: &Path) -> Severity {
        if self.is_critical_file(path) {
            Severity::Critical
        } else {
            Severity::Medium
        }
    }

    fn make_source(&self) -> security_os_core::EventSource {
        security_os_core::EventSource {
            collector: "filesystem".into(),
            host_id: self.host_id.clone(),
            host_name: self.host_name.clone(),
            agent_id: self.agent_id.clone(),
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
        }
    }

    fn scan_directory(&self) -> HashMap<String, String> {
        let mut hashes: HashMap<String, String> = HashMap::new();

        for watch_path in &self.watch_paths {
            if !Path::new(watch_path).exists() {
                warn!(path = %watch_path, "Watch path does not exist");
                continue;
            }

            for entry in WalkDir::new(watch_path)
                .max_depth(3)
                .follow_links(false)
                .into_iter()
                .filter_map(|e| e.ok())
            {
                let path = entry.path();
                if !path.is_file() {
                    continue;
                }

                let path_str = path.to_string_lossy().to_string();

                match Self::compute_hash(path) {
                    Some(hash) => {
                        hashes.insert(path_str, hash);
                    }
                    None => {
                        warn!(path = %path_str, "Failed to compute hash for file");
                    }
                }
            }
        }

        hashes
    }

    pub fn scan(&mut self) -> Vec<SecurityEvent> {
        let mut events = Vec::new();
        let current = self.scan_directory();

        let current_paths: HashSet<&String> = current.keys().collect();
        let baseline_paths: HashSet<&String> = self.baseline.keys().collect();

        for (path, hash) in &current {
            match self.baseline.get(path) {
                Some(baseline_hash) => {
                    if hash != baseline_hash {
                        let path_obj = Path::new(path);
                        let severity = self.severity_for_file(path_obj);
                        let is_critical = self.is_critical_file(path_obj);
                        let file_type = if is_critical { "critical" } else { "standard" };

                        info!(
                            path = %path,
                            old_hash = %baseline_hash,
                            new_hash = %hash,
                            severity = %severity,
                            "File modification detected"
                        );

                        let mut event = SecurityEvent::new(
                            EventCategory::Filesystem,
                            EventAction::Modified,
                            self.make_source(),
                            format!("File modified: {}", path),
                            format!(
                                "The {} file '{}' has been modified. Hash changed from {} to {}.",
                                file_type, path, &baseline_hash[..16], &hash[..16]
                            ),
                        )
                        .with_severity(severity)
                        .with_mitre(
                            "Persistence",
                            "Data Manipulation: Stored Data Manipulation",
                            "T1565.001",
                        )
                        .with_tag("filesystem")
                        .with_tag("file-modification")
                        .with_risk_score(severity.risk_weight() * 80.0);

                        if is_critical {
                            event = event.with_tag("critical-file");
                        }

                        events.push(event);
                    }
                }
                None => {
                    let path_obj = Path::new(path);
                    let severity = self.severity_for_file(path_obj);
                    let is_critical = self.is_critical_file(path_obj);

                    info!(
                        path = %path,
                        severity = %severity,
                        "New file detected"
                    );

                    let mut event = SecurityEvent::new(
                        EventCategory::Filesystem,
                        EventAction::Created,
                        self.make_source(),
                        format!("New file created: {}", path),
                        format!(
                            "A new {} file '{}' was detected with hash {}.",
                            if is_critical { "critical" } else { "standard" },
                            path,
                            &hash[..16]
                        ),
                    )
                    .with_severity(severity)
                    .with_mitre(
                        "Persistence",
                        "Data Manipulation: Stored Data Manipulation",
                        "T1565.001",
                    )
                    .with_tag("filesystem")
                    .with_tag("file-created")
                    .with_risk_score(severity.risk_weight() * 60.0);

                    if is_critical {
                        event = event.with_tag("critical-file");
                    }

                    events.push(event);
                }
            }
        }

        for path in baseline_paths.difference(&current_paths) {
            let path_obj = Path::new(path.as_str());
            let severity = self.severity_for_file(path_obj);

            warn!(
                path = %path,
                severity = %severity,
                "File deletion detected"
            );

            let event = SecurityEvent::new(
                EventCategory::Filesystem,
                EventAction::Deleted,
                self.make_source(),
                format!("File deleted: {}", path),
                format!(
                    "The file '{}' has been removed from the monitored filesystem.",
                    path
                ),
            )
            .with_severity(severity)
            .with_mitre(
                "Persistence",
                "Data Manipulation: Stored Data Manipulation",
                "T1565.001",
            )
            .with_tag("filesystem")
            .with_tag("file-deleted")
            .with_risk_score(severity.risk_weight() * 70.0);

            events.push(event);
        }

        self.baseline = current;
        events
    }

    pub async fn run(mut self, bus: EventBus, interval: Duration) {
        info!(
            watch_paths = ?self.watch_paths,
            critical_paths = ?self.critical_paths,
            interval = ?interval,
            "Filesystem collector starting"
        );

        info!("Building initial baseline...");
        self.baseline = self.scan_directory();
        info!(
            baseline_count = self.baseline.len(),
            "Initial baseline established"
        );

        let mut ticker = tokio::time::interval(interval);
        ticker.tick().await;

        loop {
            ticker.tick().await;

            debug!("Starting filesystem scan cycle");

            let events = self.scan();

            if events.is_empty() {
                debug!("No filesystem events detected in this scan cycle");
            } else {
                info!(
                    event_count = events.len(),
                    "Filesystem events detected, publishing to bus"
                );

                for event in events {
                    bus.publish(event);
                }
            }
        }
    }
}
