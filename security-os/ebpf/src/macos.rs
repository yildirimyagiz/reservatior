use async_trait::async_trait;

use crate::errors::KernelError;
use crate::kernel_collector::{KernelCollector, KernelPlatform, KernelStats, ProbeProgram};

pub struct MacOsEsfCollector {
    stats: KernelStats,
    running: bool,
}

impl MacOsEsfCollector {
    pub fn new() -> Self {
        Self {
            stats: KernelStats::new(KernelPlatform::MacOs),
            running: false,
        }
    }

    pub fn supported_events(&self) -> Vec<&'static str> {
        vec![
            "ES_EVENT_TYPE_AUTH_EXEC",
            "ES_EVENT_TYPE_AUTH_OPEN",
            "ES_EVENT_TYPE_AUTH_CLOSE",
            "ES_EVENT_TYPE_AUTH_CONNECT",
            "ES_EVENT_TYPE_NOTIFY_CREATE",
            "ES_EVENT_TYPE_NOTIFY_DELETE",
            "ES_EVENT_TYPE_NOTIFY_RENAME",
            "ES_EVENT_TYPE_NOTIFY_MOUNT",
        ]
    }
}

impl Default for MacOsEsfCollector {
    fn default() -> Self {
        Self::new()
    }
}

#[async_trait]
impl KernelCollector for MacOsEsfCollector {
    fn platform(&self) -> KernelPlatform {
        KernelPlatform::MacOs
    }

    fn name(&self) -> &str {
        "macos-esf"
    }

    async fn start(&mut self) -> Result<(), KernelError> {
        self.running = true;
        tracing::info!("macOS ESF collector started (stub)");
        Ok(())
    }

    async fn stop(&mut self) -> Result<(), KernelError> {
        self.running = false;
        tracing::info!("macOS ESF collector stopped");
        Ok(())
    }

    async fn health_check(&self) -> bool {
        self.running
    }

    fn stats(&self) -> KernelStats {
        self.stats.clone()
    }

    fn programs(&self) -> Vec<ProbeProgram> {
        vec![]
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::kernel_collector::KernelCollector;

    #[test]
    fn test_macos_collector_new() {
        let collector = MacOsEsfCollector::new();
        assert!(!collector.running);
        assert_eq!(collector.stats.platform, KernelPlatform::MacOs);
        assert_eq!(collector.stats.events_captured, 0);
    }

    #[tokio::test]
    async fn test_macos_collector_start_stop() {
        let mut collector = MacOsEsfCollector::new();
        assert!(!collector.running);

        let result = collector.start().await;
        assert!(result.is_ok());
        assert!(collector.running);

        let result = collector.stop().await;
        assert!(result.is_ok());
        assert!(!collector.running);
    }

    #[test]
    fn test_macos_collector_supported_events() {
        let collector = MacOsEsfCollector::new();
        let events = collector.supported_events();
        assert_eq!(events.len(), 8);
        assert!(events.contains(&"ES_EVENT_TYPE_AUTH_EXEC"));
        assert!(events.contains(&"ES_EVENT_TYPE_AUTH_CONNECT"));
        assert!(events.contains(&"ES_EVENT_TYPE_NOTIFY_CREATE"));
    }
}
