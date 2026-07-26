use async_trait::async_trait;
use serde::{Deserialize, Serialize};

use crate::errors::KernelError;

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub enum KernelPlatform {
    Linux,
    Windows,
    MacOs,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KernelStats {
    pub events_captured: u64,
    pub events_dropped: u64,
    pub ring_buffer_full: u64,
    pub attached_probes: u32,
    pub uptime_secs: u64,
    pub platform: KernelPlatform,
}

impl KernelStats {
    pub fn new(platform: KernelPlatform) -> Self {
        Self {
            events_captured: 0,
            events_dropped: 0,
            ring_buffer_full: 0,
            attached_probes: 0,
            uptime_secs: 0,
            platform,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ProbeProgram {
    pub name: String,
    pub program_type: ProgramType,
    pub attached: bool,
    pub events_captured: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub enum ProgramType {
    Tracepoint,
    Kprobe,
    Kretprobe,
    Xdp,
    Tc,
    Lsm,
    PerfEvent,
}

#[async_trait]
pub trait KernelCollector: Send + Sync {
    fn platform(&self) -> KernelPlatform;
    fn name(&self) -> &str;
    async fn start(&mut self) -> Result<(), KernelError>;
    async fn stop(&mut self) -> Result<(), KernelError>;
    async fn health_check(&self) -> bool;
    fn stats(&self) -> KernelStats;
    fn programs(&self) -> Vec<ProbeProgram>;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_kernel_stats_construction() {
        let stats = KernelStats::new(KernelPlatform::Linux);
        assert_eq!(stats.events_captured, 0);
        assert_eq!(stats.events_dropped, 0);
        assert_eq!(stats.ring_buffer_full, 0);
        assert_eq!(stats.attached_probes, 0);
        assert_eq!(stats.uptime_secs, 0);
        assert_eq!(stats.platform, KernelPlatform::Linux);
    }

    #[test]
    fn test_kernel_stats_clone() {
        let mut stats = KernelStats::new(KernelPlatform::Windows);
        stats.events_captured = 1000;
        stats.attached_probes = 5;
        let cloned = stats.clone();
        assert_eq!(cloned.events_captured, 1000);
        assert_eq!(cloned.attached_probes, 5);
        assert_eq!(cloned.platform, KernelPlatform::Windows);
    }
}
