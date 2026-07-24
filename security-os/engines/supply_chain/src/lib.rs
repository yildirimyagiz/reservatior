use std::collections::HashMap;
use chrono::{DateTime, Utc};
use dashmap::DashMap;
use security_os_core::{
    Entity, EntityType, EventAction, EventCategory, EventSource, SecurityEvent, Severity,
};
use tracing::{debug, warn};

const SUSPICIOUS_REGISTRY_PATTERNS: &[&str] = &[
    "registry.npmjs.org",
    "pypi.org",
    "rubygems.org",
    "nuget.org",
    "maven",
    "npm",
    "pip install",
    "gem install",
    "cargo install",
];

const BUILD_TOOLS: &[&str] = &[
    "make", "cmake", "gcc", "g++", "clang", "rustc", "cargo",
    "gradle", "maven", "mvn", "npm", "yarn", "pnpm", "pip",
    "bundler", "go build", "dotnet build", "msbuild",
    "docker build", "bazel", "meson", "ninja",
];

const CI_CD_PATHS: &[&str] = &[
    ".github/workflows/",
    ".gitlab-ci.yml",
    ".travis.yml",
    "Jenkinsfile",
    ".circleci/",
    "azure-pipelines.yml",
    ".drone.yml",
    "bitbucket-pipelines.yml",
    "cloudbuild.yaml",
    "buildkite.yml",
];

const PACKAGE_LOCK_FILES: &[&str] = &[
    "package-lock.json",
    "yarn.lock",
    "pnpm-lock.yaml",
    "Cargo.lock",
    "poetry.lock",
    "Pipfile.lock",
    "Gemfile.lock",
    "go.sum",
    "composer.lock",
];

#[derive(Debug, Clone)]
struct PackageVersion {
    name: String,
    version: String,
    registry: String,
    timestamp: DateTime<Utc>,
    known_vulnerable: bool,
}

#[derive(Debug, Clone)]
struct BuildRecord {
    tool: String,
    timestamp: DateTime<Utc>,
    exit_code: i32,
    suspicious_args: bool,
}

pub struct SupplyChainEngine {
    package_versions: DashMap<String, Vec<PackageVersion>>,
    build_records: DashMap<String, Vec<BuildRecord>>,
    known_vulnerable_packages: DashMap<String, Vec<String>>,
    ci_cd_modifications: DashMap<String, u32>,
    registry_access_log: DashMap<String, u32>,
}

impl SupplyChainEngine {
    pub fn new() -> Self {
        let engine = Self {
            package_versions: DashMap::new(),
            build_records: DashMap::new(),
            known_vulnerable_packages: DashMap::new(),
            ci_cd_modifications: DashMap::new(),
            registry_access_log: DashMap::new(),
        };
        engine.register_known_vulnerabilities();
        engine
    }

    fn register_known_vulnerabilities(&self) {
        let npm_vulns = vec![
            "event-stream".to_string(),
            "flatmap-stream".to_string(),
            "ua-parser-js".to_string(),
            "coa".to_string(),
            "rc".to_string(),
            "colors".to_string(),
            "faker".to_string(),
            "cross-env".to_string(),
            "cross-spawn".to_string(),
        ];
        for pkg in npm_vulns {
            self.known_vulnerable_packages
                .entry("npm".to_string())
                .or_default()
                .push(pkg);
        }

        let pypi_vulns = vec![
            "python-dateutil".to_string(),
            "colors-cli".to_string(),
            "notify-py".to_string(),
            "pymongo".to_string(),
        ];
        for pkg in pypi_vulns {
            self.known_vulnerable_packages
                .entry("pypi".to_string())
                .or_default()
                .push(pkg);
        }
    }

    fn detect_compromised_dependency(
        &self,
        package_name: &str,
        registry: &str,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        let is_vulnerable = self
            .known_vulnerable_packages
            .get(registry)
            .map(|pkgs| pkgs.iter().any(|p| p == package_name))
            .unwrap_or(false);

        if !is_vulnerable {
            return None;
        }

        let mut event = SecurityEvent::new(
            EventCategory::SupplyChain,
            EventAction::Detected,
            source.clone(),
            format!(
                "Known vulnerable dependency installed: {} from {}",
                package_name, registry
            ),
            format!(
                "Package '{}' from registry '{}' has known vulnerabilities. \
                 This may indicate a supply chain compromise.",
                package_name, registry
            ),
        )
        .with_severity(Severity::Critical)
        .with_confidence(0.95)
        .with_risk_score(90.0)
        .with_mitre(
            "Initial Access",
            "Supply Chain Compromise: Compromise Software Dependencies",
            "T1195.002",
        )
        .with_tag("compromised_dependency");

        event.affected_entities.push(Entity {
            entity_type: EntityType::Hash,
            value: format!("{}:{}", registry, package_name),
            risk_contribution: 50.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    fn detect_unauthorized_registry_access(
        &self,
        registry: &str,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        let is_known = SUSPICIOUS_REGISTRY_PATTERNS
            .iter()
            .any(|r| registry.contains(r));

        if is_known {
            return None;
        }

        let mut count = self
            .registry_access_log
            .entry(registry.to_string())
            .or_insert(0);
        *count += 1;
        let access_count = *count;
        drop(count);

        if access_count < 5 {
            return None;
        }

        let mut event = SecurityEvent::new(
            EventCategory::SupplyChain,
            EventAction::Detected,
            source.clone(),
            format!(
                "Unauthorized package registry access: {} ({} accesses)",
                registry, access_count
            ),
            format!(
                "Package registry '{}' accessed {} times from an unauthorized source. \
                 This may indicate dependency confusion or typosquatting.",
                registry, access_count
            ),
        )
        .with_severity(Severity::High)
        .with_confidence(0.75)
        .with_risk_score(70.0)
        .with_mitre(
            "Initial Access",
            "Supply Chain Compromise",
            "T1195",
        )
        .with_tag("unauthorized_registry_access");

        event.affected_entities.push(Entity {
            entity_type: EntityType::Domain,
            value: registry.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        Some(event)
    }

    fn detect_build_pipeline_tampering(
        &self,
        file_path: &str,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        let is_ci_cd = CI_CD_PATHS
            .iter()
            .any(|p| file_path.contains(p));

        if !is_ci_cd {
            return None;
        }

        let mut count = self
            .ci_cd_modifications
            .entry(file_path.to_string())
            .or_insert(0);
        *count += 1;
        let mod_count = *count;
        drop(count);

        if mod_count < 2 {
            return None;
        }

        let mut event_det = SecurityEvent::new(
            EventCategory::SupplyChain,
            EventAction::Detected,
            event.source.clone(),
            format!("Build pipeline tampering: {}", file_path),
            format!(
                "CI/CD configuration file '{}' has been modified {} times. \
                 Repeated changes to build pipelines may indicate tampering or credential injection.",
                file_path, mod_count
            ),
        )
        .with_severity(Severity::High)
        .with_confidence(0.80)
        .with_risk_score(78.0)
        .with_mitre(
            "Initial Access",
            "Supply Chain Compromise",
            "T1195",
        )
        .with_file(file_path)
        .with_tag("build_pipeline_tampering");

        event_det.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: file_path.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        Some(event_det)
    }

    fn detect_suspicious_commit_pattern(
        &self,
        user: &str,
        commit_count: u32,
        event: &SecurityEvent,
    ) -> Option<SecurityEvent> {
        if commit_count < 50 {
            return None;
        }

        let mut event_det = SecurityEvent::new(
            EventCategory::SupplyChain,
            EventAction::Detected,
            event.source.clone(),
            format!("Suspicious commit pattern by {}", user),
            format!(
                "User {} made {} commits in rapid succession. \
                 Burst commit patterns may indicate automated code injection or credential stuffing.",
                user, commit_count
            ),
        )
        .with_severity(Severity::Medium)
        .with_confidence(0.70)
        .with_risk_score(60.0)
        .with_mitre(
            "Initial Access",
            "Supply Chain Compromise",
            "T1195",
        )
        .with_tag("suspicious_commit_pattern");

        event_det.affected_entities.push(Entity {
            entity_type: EntityType::User,
            value: user.to_string(),
            risk_contribution: 40.0,
            metadata: HashMap::new(),
        });

        Some(event_det)
    }

    fn detect_lock_file_change(
        &self,
        file_path: &str,
        source: &EventSource,
    ) -> Option<SecurityEvent> {
        let is_lock = PACKAGE_LOCK_FILES
            .iter()
            .any(|f| file_path.ends_with(f));

        if !is_lock {
            return None;
        }

        let mut event_det = SecurityEvent::new(
            EventCategory::SupplyChain,
            EventAction::Detected,
            source.clone(),
            format!("Package lock file modified: {}", file_path),
            format!(
                "Package lock file '{}' has been modified. \
                 Unexpected lock file changes may indicate dependency tampering.",
                file_path
            ),
        )
        .with_severity(Severity::Medium)
        .with_confidence(0.65)
        .with_risk_score(55.0)
        .with_mitre(
            "Initial Access",
            "Supply Chain Compromise: Compromise Software Dependencies",
            "T1195.002",
        )
        .with_file(file_path)
        .with_tag("lock_file_modified");

        event_det.affected_entities.push(Entity {
            entity_type: EntityType::File,
            value: file_path.to_string(),
            risk_contribution: 30.0,
            metadata: HashMap::new(),
        });

        Some(event_det)
    }

    pub fn process_event(&mut self, event: &SecurityEvent) -> Vec<SecurityEvent> {
        let mut detections = Vec::new();

        // Detect compromised dependencies
        if event.category == EventCategory::SupplyChain
            && event.action == EventAction::Created
        {
            if let Some(pkg_name) = event
                .metadata
                .get("package_name")
                .and_then(|v| v.as_str())
            {
                let registry = event
                    .metadata
                    .get("registry")
                    .and_then(|v| v.as_str())
                    .unwrap_or("unknown");

                if let Some(det) =
                    self.detect_compromised_dependency(pkg_name, registry, &event.source)
                {
                    warn!("Compromised dependency: {}", det.title);
                    detections.push(det);
                }

                // Record version
                let version = event
                    .metadata
                    .get("package_version")
                    .and_then(|v| v.as_str())
                    .unwrap_or("0.0.0")
                    .to_string();

                self.package_versions
                    .entry(pkg_name.to_string())
                    .or_default()
                    .push(PackageVersion {
                        name: pkg_name.to_string(),
                        version,
                        registry: registry.to_string(),
                        timestamp: event.timestamp,
                        known_vulnerable: false,
                    });
            }
        }

        // Detect unauthorized registry access
        if event.category == EventCategory::Network
            && event.action == EventAction::Connected
        {
            if let Some(url) = event
                .metadata
                .get("url")
                .and_then(|v| v.as_str())
            {
                if let Some(det) = self.detect_unauthorized_registry_access(url, &event.source) {
                    warn!("Unauthorized registry access: {}", det.title);
                    detections.push(det);
                }
            }
        }

        // Detect build pipeline tampering
        if event.category == EventCategory::Filesystem
            && event.action == EventAction::Modified
        {
            if let Some(ref path) = event.file_path {
                if let Some(det) =
                    self.detect_build_pipeline_tampering(path, event)
                {
                    warn!("Build pipeline tampering: {}", det.title);
                    detections.push(det);
                }
            }
        }

        // Detect lock file changes
        if event.category == EventCategory::Filesystem
            && event.action == EventAction::Modified
        {
            if let Some(ref path) = event.file_path {
                if let Some(det) = self.detect_lock_file_change(path, &event.source) {
                    warn!("Lock file modified: {}", det.title);
                    detections.push(det);
                }
            }
        }

        // Detect suspicious commit patterns
        if event.category == EventCategory::SupplyChain
            && event.action == EventAction::Created
        {
            if let Some(user) = event
                .metadata
                .get("commit_author")
                .and_then(|v| v.as_str())
            {
                let commit_count = event
                    .metadata
                    .get("commit_count")
                    .and_then(|v| v.as_u64())
                    .unwrap_or(0) as u32;

                if let Some(det) =
                    self.detect_suspicious_commit_pattern(user, commit_count, event)
                {
                    warn!("Suspicious commit pattern: {}", det.title);
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

    fn make_package_event(
        package_name: &str,
        registry: &str,
        version: &str,
    ) -> SecurityEvent {
        let source = make_source();
        let mut event = SecurityEvent::new(
            EventCategory::SupplyChain,
            EventAction::Created,
            source,
            format!("Package installed: {}", package_name),
            format!("Package {} v{} from {}", package_name, version, registry),
        );
        event.metadata.insert(
            "package_name".to_string(),
            serde_json::Value::String(package_name.to_string()),
        );
        event.metadata.insert(
            "registry".to_string(),
            serde_json::Value::String(registry.to_string()),
        );
        event.metadata.insert(
            "package_version".to_string(),
            serde_json::Value::String(version.to_string()),
        );
        event
    }

    fn make_file_event(path: &str, action: EventAction) -> SecurityEvent {
        let source = make_source();
        let mut event = SecurityEvent::new(
            EventCategory::Filesystem,
            action,
            source,
            format!("File event: {}", path),
            format!("Event on file {}", path),
        );
        event.file_path = Some(path.to_string());
        event
    }

    #[test]
    fn test_engine_creation() {
        let engine = SupplyChainEngine::new();
        assert!(engine.known_vulnerable_packages.contains_key("npm"));
    }

    #[test]
    fn test_compromised_dependency() {
        let mut engine = SupplyChainEngine::new();
        let event = make_package_event("event-stream", "npm", "1.0.0");
        let detections = engine.process_event(&event);
        assert_eq!(detections.len(), 1);
        assert_eq!(detections[0].severity, Severity::Critical);
        assert!(detections[0].mitre_id.as_deref() == Some("T1195.002"));
    }

    #[test]
    fn test_safe_dependency_ignored() {
        let mut engine = SupplyChainEngine::new();
        let event = make_package_event("lodash", "npm", "4.17.21");
        let detections = engine.process_event(&event);
        assert!(detections.is_empty());
    }

    #[test]
    fn test_build_pipeline_tampering() {
        let mut engine = SupplyChainEngine::new();
        for _ in 0..3 {
            let event = make_file_event(".github/workflows/ci.yml", EventAction::Modified);
            let detections = engine.process_event(&event);
            if detections.len() > 0 {
                assert!(detections[0]
                    .tags
                    .contains(&"build_pipeline_tampering".to_string()));
                return;
            }
        }
        panic!("Expected build pipeline tampering detection");
    }

    #[test]
    fn test_lock_file_change() {
        let mut engine = SupplyChainEngine::new();
        let event = make_file_event("package-lock.json", EventAction::Modified);
        let detections = engine.process_event(&event);
        assert_eq!(detections.len(), 1);
        assert!(detections[0]
            .tags
            .contains(&"lock_file_modified".to_string()));
    }
}
