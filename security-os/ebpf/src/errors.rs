use thiserror::Error;

#[derive(Error, Debug)]
pub enum KernelError {
    #[error("Failed to attach probe: {0}")]
    AttachFailed(String),

    #[error("Failed to load eBPF program: {0}")]
    ProgramLoadFailed(String),

    #[error("Permission denied: {0}")]
    PermissionDenied(String),

    #[error("Unsupported platform: {0}")]
    UnsupportedPlatform(String),

    #[error("Ring buffer full: {0} events dropped")]
    RingBufferFull(u64),

    #[error("Collector is not running")]
    NotRunning,

    #[error("IO error: {0}")]
    Io(#[from] std::io::Error),
}
