use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq, Hash)]
pub enum KernelEventType {
    ProcessExec,
    ProcessExit,
    FileOpen,
    FileRead,
    FileWrite,
    FileDelete,
    NetworkConnect,
    NetworkAccept,
    NetworkBind,
    NetworkSend,
    NetworkReceive,
    CapabilityCheck,
    MountOperation,
    CgroupAttach,
    LsmBprmCheck,
    SeccompViolation,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct KernelEvent {
    pub event_type: KernelEventType,
    pub timestamp: DateTime<Utc>,
    pub pid: u32,
    pub ppid: u32,
    pub uid: u32,
    pub gid: u32,
    pub comm: String,
    pub exe: String,
    pub hostname: String,
    pub data: KernelEventData,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum KernelEventData {
    Process {
        exit_code: Option<i32>,
        cmdline: String,
    },
    File {
        path: String,
        flags: u32,
        mode: u32,
    },
    Network {
        direction: NetworkDirection,
        src_ip: String,
        dst_ip: String,
        src_port: u16,
        dst_port: u16,
        protocol: u32,
    },
    Capability {
        cap: u32,
        granted: bool,
    },
    Mount {
        source: String,
        target: String,
        fstype: String,
    },
    Cgroup {
        path: String,
        attach_type: String,
    },
    Lsm {
        subject: String,
        object: String,
        decision: String,
    },
    Seccomp {
        syscall: u32,
        args: Vec<u64>,
    },
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub enum NetworkDirection {
    Ingress,
    Egress,
}

impl KernelEvent {
    pub fn new(
        event_type: KernelEventType,
        pid: u32,
        ppid: u32,
        uid: u32,
        gid: u32,
        comm: impl Into<String>,
        exe: impl Into<String>,
        hostname: impl Into<String>,
        data: KernelEventData,
    ) -> Self {
        Self {
            event_type,
            timestamp: Utc::now(),
            pid,
            ppid,
            uid,
            gid,
            comm: comm.into(),
            exe: exe.into(),
            hostname: hostname.into(),
            data,
        }
    }
}

impl KernelEvent {
    pub fn process_exec(
        pid: u32,
        ppid: u32,
        uid: u32,
        gid: u32,
        comm: impl Into<String>,
        exe: impl Into<String>,
        hostname: impl Into<String>,
        cmdline: impl Into<String>,
    ) -> Self {
        Self::new(
            KernelEventType::ProcessExec,
            pid,
            ppid,
            uid,
            gid,
            comm,
            exe,
            hostname,
            KernelEventData::Process {
                exit_code: None,
                cmdline: cmdline.into(),
            },
        )
    }

    pub fn process_exit(
        pid: u32,
        ppid: u32,
        uid: u32,
        gid: u32,
        comm: impl Into<String>,
        exe: impl Into<String>,
        hostname: impl Into<String>,
        exit_code: i32,
        cmdline: impl Into<String>,
    ) -> Self {
        Self::new(
            KernelEventType::ProcessExit,
            pid,
            ppid,
            uid,
            gid,
            comm,
            exe,
            hostname,
            KernelEventData::Process {
                exit_code: Some(exit_code),
                cmdline: cmdline.into(),
            },
        )
    }

    pub fn file_open(
        pid: u32,
        ppid: u32,
        uid: u32,
        gid: u32,
        comm: impl Into<String>,
        exe: impl Into<String>,
        hostname: impl Into<String>,
        path: impl Into<String>,
        flags: u32,
        mode: u32,
    ) -> Self {
        Self::new(
            KernelEventType::FileOpen,
            pid,
            ppid,
            uid,
            gid,
            comm,
            exe,
            hostname,
            KernelEventData::File {
                path: path.into(),
                flags,
                mode,
            },
        )
    }

    pub fn network_connect(
        pid: u32,
        ppid: u32,
        uid: u32,
        gid: u32,
        comm: impl Into<String>,
        exe: impl Into<String>,
        hostname: impl Into<String>,
        direction: NetworkDirection,
        src_ip: impl Into<String>,
        dst_ip: impl Into<String>,
        src_port: u16,
        dst_port: u16,
        protocol: u32,
    ) -> Self {
        Self::new(
            KernelEventType::NetworkConnect,
            pid,
            ppid,
            uid,
            gid,
            comm,
            exe,
            hostname,
            KernelEventData::Network {
                direction,
                src_ip: src_ip.into(),
                dst_ip: dst_ip.into(),
                src_port,
                dst_port,
                protocol,
            },
        )
    }

    pub fn capability_check(
        pid: u32,
        ppid: u32,
        uid: u32,
        gid: u32,
        comm: impl Into<String>,
        exe: impl Into<String>,
        hostname: impl Into<String>,
        cap: u32,
        granted: bool,
    ) -> Self {
        Self::new(
            KernelEventType::CapabilityCheck,
            pid,
            ppid,
            uid,
            gid,
            comm,
            exe,
            hostname,
            KernelEventData::Capability { cap, granted },
        )
    }

    pub fn mount_operation(
        pid: u32,
        ppid: u32,
        uid: u32,
        gid: u32,
        comm: impl Into<String>,
        exe: impl Into<String>,
        hostname: impl Into<String>,
        source: impl Into<String>,
        target: impl Into<String>,
        fstype: impl Into<String>,
    ) -> Self {
        Self::new(
            KernelEventType::MountOperation,
            pid,
            ppid,
            uid,
            gid,
            comm,
            exe,
            hostname,
            KernelEventData::Mount {
                source: source.into(),
                target: target.into(),
                fstype: fstype.into(),
            },
        )
    }

    pub fn cgroup_attach(
        pid: u32,
        ppid: u32,
        uid: u32,
        gid: u32,
        comm: impl Into<String>,
        exe: impl Into<String>,
        hostname: impl Into<String>,
        path: impl Into<String>,
        attach_type: impl Into<String>,
    ) -> Self {
        Self::new(
            KernelEventType::CgroupAttach,
            pid,
            ppid,
            uid,
            gid,
            comm,
            exe,
            hostname,
            KernelEventData::Cgroup {
                path: path.into(),
                attach_type: attach_type.into(),
            },
        )
    }

    pub fn lsm_bprm_check(
        pid: u32,
        ppid: u32,
        uid: u32,
        gid: u32,
        comm: impl Into<String>,
        exe: impl Into<String>,
        hostname: impl Into<String>,
        subject: impl Into<String>,
        object: impl Into<String>,
        decision: impl Into<String>,
    ) -> Self {
        Self::new(
            KernelEventType::LsmBprmCheck,
            pid,
            ppid,
            uid,
            gid,
            comm,
            exe,
            hostname,
            KernelEventData::Lsm {
                subject: subject.into(),
                object: object.into(),
                decision: decision.into(),
            },
        )
    }

    pub fn seccomp_violation(
        pid: u32,
        ppid: u32,
        uid: u32,
        gid: u32,
        comm: impl Into<String>,
        exe: impl Into<String>,
        hostname: impl Into<String>,
        syscall: u32,
        args: Vec<u64>,
    ) -> Self {
        Self::new(
            KernelEventType::SeccompViolation,
            pid,
            ppid,
            uid,
            gid,
            comm,
            exe,
            hostname,
            KernelEventData::Seccomp { syscall, args },
        )
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_kernel_event_construction() {
        let event = KernelEvent::process_exec(
            1234,
            1000,
            0,
            0,
            "bash",
            "/usr/bin/bash",
            "web-server-01",
            "/usr/bin/bash -c ls",
        );
        assert_eq!(event.event_type, KernelEventType::ProcessExec);
        assert_eq!(event.pid, 1234);
        assert_eq!(event.ppid, 1000);
        assert_eq!(event.comm, "bash");
        assert_eq!(event.exe, "/usr/bin/bash");
        assert_eq!(event.hostname, "web-server-01");
        match &event.data {
            KernelEventData::Process { cmdline, exit_code } => {
                assert_eq!(cmdline, "/usr/bin/bash -c ls");
                assert!(exit_code.is_none());
            }
            _ => panic!("Expected Process event data"),
        }
    }

    #[test]
    fn test_network_event_data() {
        let event = KernelEvent::network_connect(
            5678,
            1000,
            0,
            0,
            "curl",
            "/usr/bin/curl",
            "web-server-01",
            NetworkDirection::Egress,
            "10.0.0.1",
            "93.184.216.34",
            45234,
            443,
            6,
        );
        assert_eq!(event.event_type, KernelEventType::NetworkConnect);
        match &event.data {
            KernelEventData::Network {
                direction,
                src_ip,
                dst_ip,
                src_port,
                dst_port,
                protocol,
            } => {
                assert_eq!(*direction, NetworkDirection::Egress);
                assert_eq!(src_ip, "10.0.0.1");
                assert_eq!(dst_ip, "93.184.216.34");
                assert_eq!(*src_port, 45234);
                assert_eq!(*dst_port, 443);
                assert_eq!(*protocol, 6);
            }
            _ => panic!("Expected Network event data"),
        }
    }

    #[test]
    fn test_process_event_data() {
        let event = KernelEvent::process_exit(
            1234,
            1000,
            0,
            0,
            "bash",
            "/usr/bin/bash",
            "web-server-01",
            0,
            "/usr/bin/bash -c ls",
        );
        assert_eq!(event.event_type, KernelEventType::ProcessExit);
        match &event.data {
            KernelEventData::Process { exit_code, cmdline } => {
                assert_eq!(*exit_code, Some(0));
                assert_eq!(cmdline, "/usr/bin/bash -c ls");
            }
            _ => panic!("Expected Process event data"),
        }
    }

    #[test]
    fn test_capability_event_data() {
        let event = KernelEvent::capability_check(
            9999,
            1,
            0,
            0,
            "nscd",
            "/usr/sbin/nscd",
            "web-server-01",
            21,
            false,
        );
        assert_eq!(event.event_type, KernelEventType::CapabilityCheck);
        assert_eq!(event.pid, 9999);
        assert_eq!(event.uid, 0);
        assert_eq!(event.gid, 0);
        match &event.data {
            KernelEventData::Capability { cap, granted } => {
                assert_eq!(*cap, 21);
                assert!(!granted);
            }
            _ => panic!("Expected Capability event data"),
        }
    }
}
