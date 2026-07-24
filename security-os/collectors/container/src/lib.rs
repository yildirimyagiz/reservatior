use dashmap::DashMap;
use security_os_core::{
    EventAction, EventCategory, EventBus, EventSource, SecurityEvent, Severity,
};
use std::process::Command;
use std::time::Duration;
use tracing::{error, info, warn};

#[derive(Debug, Clone)]
pub struct ContainerInfo {
    pub id: String,
    pub name: String,
    pub image: String,
    pub status: String,
    pub ports: String,
}

pub struct ContainerCollector {
    baseline: DashMap<String, ContainerInfo>,
}

impl ContainerCollector {
    pub fn new() -> Self {
        Self {
            baseline: DashMap::new(),
        }
    }

    fn parse_docker_ps(&self) -> Result<Vec<ContainerInfo>, DockerError> {
        let output = Command::new("docker")
            .args([
                "ps",
                "--format",
                "{{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}",
            ])
            .output();

        match output {
            Ok(output) => {
                if !output.status.success() {
                    let stderr = String::from_utf8_lossy(&output.stderr);
                    if stderr.contains("command not found") || stderr.contains("Cannot connect") {
                        return Err(DockerError::DockerUnavailable(stderr.to_string()));
                    }
                    return Err(DockerError::CommandFailed(stderr.to_string()));
                }

                let stdout = String::from_utf8_lossy(&output.stdout);
                let containers = stdout
                    .lines()
                    .filter(|line| !line.trim().is_empty())
                    .filter_map(|line| {
                        let parts: Vec<&str> = line.split('\t').collect();
                        if parts.len() >= 5 {
                            Some(ContainerInfo {
                                id: parts[0].to_string(),
                                name: parts[1].to_string(),
                                status: parts[2].to_string(),
                                image: parts[3].to_string(),
                                ports: parts[4].to_string(),
                            })
                        } else {
                            None
                        }
                    })
                    .collect();
                Ok(containers)
            }
            Err(e) => Err(DockerError::DockerUnavailable(e.to_string())),
        }
    }

    fn make_source() -> EventSource {
        EventSource {
            collector: "container".to_string(),
            host_id: hostname().unwrap_or_else(|| "unknown".to_string()),
            host_name: hostname().unwrap_or_else(|| "unknown".to_string()),
            agent_id: "container-collector".to_string(),
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

    fn scan_once(&self) -> Vec<SecurityEvent> {
        let mut events = Vec::new();

        let containers = match self.parse_docker_ps() {
            Ok(c) => c,
            Err(DockerError::DockerUnavailable(msg)) => {
                warn!("Docker is not available: {}", msg);
                return events;
            }
            Err(DockerError::CommandFailed(msg)) => {
                error!("Docker ps command failed: {}", msg);
                return events;
            }
        };

        let current_ids: Vec<String> = containers.iter().map(|c| c.id.clone()).collect();

        let mut new_containers = Vec::new();
        for container in &containers {
            if !self.baseline.contains_key(&container.id) {
                new_containers.push(container.clone());
            }
        }

        let mut stopped_containers = Vec::new();
        {
            let mut to_remove = Vec::new();
            for entry in self.baseline.iter() {
                if !current_ids.contains(entry.key()) {
                    to_remove.push(entry.key().clone());
                }
            }
            for id in to_remove {
                if let Some((_, info)) = self.baseline.remove(&id) {
                    stopped_containers.push(info);
                }
            }
        }

        let mut restarted_containers = Vec::new();
        for container in &containers {
            if let Some(existing) = self.baseline.get(&container.id) {
                let old_status = existing.status.clone();
                drop(existing);

                if is_restart(&old_status, &container.status) {
                    restarted_containers.push(container.clone());
                }

                self.baseline
                    .insert(container.id.clone(), container.clone());
            }
        }

        for container in &new_containers {
            self.baseline.insert(container.id.clone(), container.clone());

            let source = Self::make_source();
            let event = SecurityEvent::new(
                EventCategory::Container,
                EventAction::Created,
                source,
                format!("New container started: {}", container.name),
                format!(
                    "Container '{}' ({}) with image '{}' has started. Status: {}. Ports: {}.",
                    container.name, container.id, container.image, container.status, container.ports,
                ),
            )
            .with_severity(Severity::Low)
            .with_metadata("container_id", serde_json::json!(container.id))
            .with_metadata("container_name", serde_json::json!(container.name))
            .with_metadata("image", serde_json::json!(container.image))
            .with_metadata("ports", serde_json::json!(container.ports));

            info!("New container detected: {} ({})", container.name, container.id);
            events.push(event);
        }

        for container in &stopped_containers {
            let source = Self::make_source();
            let event = SecurityEvent::new(
                EventCategory::Container,
                EventAction::Stopped,
                source,
                format!("Container stopped: {}", container.name),
                format!(
                    "Container '{}' ({}) with image '{}' has stopped. \
                     Previously reported status: '{}'.",
                    container.name, container.id, container.image, container.status,
                ),
            )
            .with_severity(Severity::Medium)
            .with_metadata("container_id", serde_json::json!(container.id))
            .with_metadata("container_name", serde_json::json!(container.name))
            .with_metadata("image", serde_json::json!(container.image))
            .with_metadata("ports", serde_json::json!(container.ports));

            warn!(
                "Container stopped: {} ({})",
                container.name, container.id
            );
            events.push(event);
        }

        for container in &restarted_containers {
            let source = Self::make_source();
            let event = SecurityEvent::new(
                EventCategory::Container,
                EventAction::Started,
                source,
                format!("Container restarted: {}", container.name),
                format!(
                    "Container '{}' ({}) with image '{}' has been restarted. \
                     Ports: {}.",
                    container.name, container.id, container.image, container.ports,
                ),
            )
            .with_severity(Severity::Medium)
            .with_metadata("container_id", serde_json::json!(container.id))
            .with_metadata("container_name", serde_json::json!(container.name))
            .with_metadata("image", serde_json::json!(container.image))
            .with_metadata("ports", serde_json::json!(container.ports));

            warn!(
                "Container restarted: {} ({})",
                container.name, container.id
            );
            events.push(event);
        }

        events
    }

    pub async fn run(self, bus: EventBus, interval: Duration) {
        info!("Container collector starting with interval {:?}", interval);
        let mut ticker = tokio::time::interval(interval);

        loop {
            ticker.tick().await;
            let events = self.scan_once();
            for event in events {
                bus.publish(event);
            }
        }
    }
}

fn hostname() -> Option<String> {
    std::fs::read_to_string("/etc/hostname")
        .ok()
        .map(|s| s.trim().to_string())
        .or_else(|| {
            Command::new("hostname")
                .output()
                .ok()
                .and_then(|o| String::from_utf8(o.stdout).ok().map(|s| s.trim().to_string()))
        })
}

fn is_restart(old_status: &str, new_status: &str) -> bool {
    let old_started = parse_started_seconds(old_status);
    let new_started = parse_started_seconds(new_status);

    match (old_started, new_started) {
        (Some(old), Some(new)) => new < old,
        _ => false,
    }
}

fn parse_started_seconds(status: &str) -> Option<u64> {
    if status.contains("Up") {
        let up_part = status.strip_prefix("Up ").unwrap_or(status);

        let mut total_seconds: u64 = 0;

        if let Some(days) = extract_number(up_part, "day") {
            total_seconds += days * 86400;
        }
        if let Some(hours) = extract_number(up_part, "hour") {
            total_seconds += hours * 3600;
        }
        if let Some(minutes) = extract_number(up_part, "minute") {
            total_seconds += minutes * 60;
        }
        if let Some(seconds) = extract_number(up_part, "second") {
            total_seconds += seconds;
        }

        if total_seconds > 0 {
            return Some(total_seconds);
        }
    }
    None
}

fn extract_number(s: &str, unit: &str) -> Option<u64> {
    for word in s.split_whitespace() {
        if word.strip_suffix(',').unwrap_or(word).contains(unit) {
            if let Some(pos) = s.find(word) {
                let prefix = &s[..pos].trim_end();
                if let Some(num_str) = prefix.split_whitespace().last() {
                    if let Ok(n) = num_str.parse::<u64>() {
                        return Some(n);
                    }
                }
            }
        }
    }
    None
}

#[derive(Debug)]
enum DockerError {
    DockerUnavailable(String),
    CommandFailed(String),
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_parse_started_seconds_hours() {
        let s = "Up 2 hours, 30 minutes";
        let secs = parse_started_seconds(s);
        assert_eq!(secs, Some(2 * 3600 + 30 * 60));
    }

    #[test]
    fn test_parse_started_seconds_minutes_only() {
        let s = "Up 5 minutes";
        assert_eq!(parse_started_seconds(s), Some(300));
    }

    #[test]
    fn test_parse_started_seconds_days() {
        let s = "Up 1 day, 3 hours";
        assert_eq!(parse_started_seconds(s), Some(86400 + 3 * 3600));
    }

    #[test]
    fn test_is_restart() {
        assert!(is_restart("Up 2 hours", "Up 5 minutes"));
        assert!(!is_restart("Up 5 minutes", "Up 2 hours"));
    }

    #[test]
    fn test_new_collector_empty_baseline() {
        let collector = ContainerCollector::new();
        assert!(collector.baseline.is_empty());
    }
}
