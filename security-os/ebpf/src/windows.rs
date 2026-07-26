use async_trait::async_trait;

use crate::errors::KernelError;
use crate::kernel_collector::{KernelCollector, KernelPlatform, KernelStats, ProbeProgram};

pub struct WindowsEtwCollector {
    stats: KernelStats,
    running: bool,
}

impl WindowsEtwCollector {
    pub fn new() -> Self {
        Self {
            stats: KernelStats::new(KernelPlatform::Windows),
            running: false,
        }
    }

    pub fn supported_providers(&self) -> Vec<&'static str> {
        vec![
            "Microsoft-Windows-Kernel-Process",
            "Microsoft-Windows-Kernel-Network",
            "Microsoft-Windows-Kernel-File",
            "Microsoft-Windows-Kernel-Registry",
            "Microsoft-Windows-Security-Auditing",
        ]
    }
}

impl Default for WindowsEtwCollector {
    fn default() -> Self {
        Self::new()
    }
}

#[async_trait]
impl KernelCollector for WindowsEtwCollector {
    fn platform(&self) -> KernelPlatform {
        KernelPlatform::Windows
    }

    fn name(&self) -> &str {
        "windows-etw"
    }

    async fn start(&mut self) -> Result<(), KernelError> {
        self.running = true;
        tracing::info!("Windows ETW collector started (stub)");
        Ok(())
    }

    async fn stop(&mut self) -> Result<(), KernelError> {
        self.running = false;
        tracing::info!("Windows ETW collector stopped");
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
    fn test_windows_collector_new() {
        let collector = WindowsEtwCollector::new();
        assert!(!collector.running);
        assert_eq!(collector.stats.platform, KernelPlatform::Windows);
        assert_eq!(collector.stats.events_captured, 0);
    }

    #[tokio::test]
    async fn test_windows_collector_start_stop() {
        let mut collector = WindowsEtwCollector::new();
        assert!(!collector.running);

        let result = collector.start().await;
        assert!(result.is_ok());
        assert!(collector.running);

        let result = collector.stop().await;
        assert!(result.is_ok());
        assert!(!collector.running);
    }

    #[test]
    fn test_windows_collector_supported_providers() {
        let collector = WindowsEtwCollector::new();
        let providers = collector.supported_providers();
        assert_eq!(providers.len(), 5);
        assert!(providers.contains(&"Microsoft-Windows-Kernel-Process"));
        assert!(providers.contains(&"Microsoft-Windows-Kernel-Network"));
        assert!(providers.contains(&"Microsoft-Windows-Security-Auditing"));
    }
}
