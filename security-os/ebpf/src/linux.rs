use async_trait::async_trait;

use crate::errors::KernelError;
use crate::kernel_collector::{KernelCollector, KernelPlatform, KernelStats, ProbeProgram, ProgramType};

pub struct LinuxEbpfCollector {
    programs: Vec<ProbeProgram>,
    stats: KernelStats,
    running: bool,
}

impl LinuxEbpfCollector {
    pub fn new() -> Self {
        Self {
            programs: Vec::new(),
            stats: KernelStats::new(KernelPlatform::Linux),
            running: false,
        }
    }

    pub fn supported_probes(&self) -> Vec<&'static str> {
        vec![
            "sched_process_exec",
            "sched_process_exit",
            "vfs_open",
            "vfs_read",
            "vfs_write",
            "vfs_unlink",
            "tcp_connect",
            "tcp_accept",
            "inet_bind",
            "cap_capable",
            "sb_mount",
            "cgroup_attach_task",
            "bprm_check",
            "seccomp",
        ]
    }
}

impl Default for LinuxEbpfCollector {
    fn default() -> Self {
        Self::new()
    }
}

#[async_trait]
impl KernelCollector for LinuxEbpfCollector {
    fn platform(&self) -> KernelPlatform {
        KernelPlatform::Linux
    }

    fn name(&self) -> &str {
        "linux-ebpf"
    }

    async fn start(&mut self) -> Result<(), KernelError> {
        self.running = true;
        self.programs = self
            .supported_probes()
            .iter()
            .map(|name| ProbeProgram {
                name: name.to_string(),
                program_type: ProgramType::Tracepoint,
                attached: true,
                events_captured: 0,
            })
            .collect();
        self.stats.attached_probes = self.programs.len() as u32;
        tracing::info!(probes = self.programs.len(), "eBPF collector started");
        Ok(())
    }

    async fn stop(&mut self) -> Result<(), KernelError> {
        self.running = false;
        for program in &mut self.programs {
            program.attached = false;
        }
        tracing::info!("eBPF collector stopped");
        Ok(())
    }

    async fn health_check(&self) -> bool {
        self.running
    }

    fn stats(&self) -> KernelStats {
        self.stats.clone()
    }

    fn programs(&self) -> Vec<ProbeProgram> {
        self.programs.clone()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::kernel_collector::KernelCollector;

    #[test]
    fn test_linux_collector_new() {
        let collector = LinuxEbpfCollector::new();
        assert!(!collector.running);
        assert!(collector.programs.is_empty());
        assert_eq!(collector.stats.attached_probes, 0);
    }

    #[tokio::test]
    async fn test_linux_collector_start_stop() {
        let mut collector = LinuxEbpfCollector::new();
        assert!(!collector.running);

        let result = collector.start().await;
        assert!(result.is_ok());
        assert!(collector.running);
        assert_eq!(collector.programs.len(), 14);
        assert_eq!(collector.stats.attached_probes, 14);

        let result = collector.stop().await;
        assert!(result.is_ok());
        assert!(!collector.running);
        for program in &collector.programs {
            assert!(!program.attached);
        }
    }

    #[tokio::test]
    async fn test_linux_collector_health_check() {
        let mut collector = LinuxEbpfCollector::new();
        assert!(!collector.health_check().await);

        collector.start().await.unwrap();
        assert!(collector.health_check().await);

        collector.stop().await.unwrap();
        assert!(!collector.health_check().await);
    }

    #[tokio::test]
    async fn test_linux_collector_stats() {
        let mut collector = LinuxEbpfCollector::new();
        let stats = collector.stats();
        assert_eq!(stats.platform, KernelPlatform::Linux);
        assert_eq!(stats.events_captured, 0);
        assert_eq!(stats.attached_probes, 0);

        collector.start().await.unwrap();
        let stats = collector.stats();
        assert_eq!(stats.attached_probes, 14);
    }

    #[tokio::test]
    async fn test_linux_collector_programs() {
        let mut collector = LinuxEbpfCollector::new();
        assert!(collector.programs().is_empty());

        collector.start().await.unwrap();
        let programs = collector.programs();
        assert_eq!(programs.len(), 14);
        for program in &programs {
            assert!(program.attached);
            assert_eq!(program.program_type, ProgramType::Tracepoint);
            assert_eq!(program.events_captured, 0);
        }
    }

    #[test]
    fn test_linux_collector_supported_probes() {
        let collector = LinuxEbpfCollector::new();
        let probes = collector.supported_probes();
        assert_eq!(probes.len(), 14);
        assert!(probes.contains(&"sched_process_exec"));
        assert!(probes.contains(&"tcp_connect"));
        assert!(probes.contains(&"cap_capable"));
        assert!(probes.contains(&"seccomp"));
        assert!(probes.contains(&"vfs_open"));
    }
}
