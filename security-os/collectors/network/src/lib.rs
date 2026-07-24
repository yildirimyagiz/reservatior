use std::collections::HashMap;
use std::time::Duration;
use std::net::{Ipv4Addr, Ipv6Addr, SocketAddr};
use tracing::{info, error};
use security_os_core::{SecurityEvent, EventSource, Severity, EventBus};
use security_os_core::{EventCategory, EventAction, EntityType, Entity};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ConnectionState {
    Established,
    Listen,
    TimeWait,
    CloseWait,
    Other(u8),
}

#[derive(Debug, Clone)]
pub struct TcpConnection {
    pub local_addr: SocketAddr,
    pub remote_addr: SocketAddr,
    pub state: ConnectionState,
}

pub struct NetworkCollector {
    blocked_ports: Vec<u16>,
}

impl NetworkCollector {
    pub fn new(blocked_ports: Vec<u16>) -> Self {
        Self { blocked_ports }
    }

    pub async fn run(self, bus: EventBus, interval: Duration) {
        info!("Network collector started, polling every {:?}", interval);
        loop {
            match self.scan() {
                Ok(events) => {
                    for event in events {
                        bus.publish(event);
                    }
                }
                Err(e) => {
                    error!("Network scan failed: {}", e);
                }
            }
            tokio::time::sleep(interval).await;
        }
    }

    pub fn scan(&self) -> Result<Vec<SecurityEvent>, String> {
        let mut events = Vec::new();
        let connections = self.parse_connections()?;
        for conn in connections {
            let mut severity = Severity::Informational;
            let mut blocked = false;

            if self.blocked_ports.contains(&conn.remote_addr.port()) {
                severity = Severity::High;
                blocked = true;
            }

            let is_loopback = match conn.remote_addr {
                SocketAddr::V4(v4) => v4.ip().is_loopback(),
                SocketAddr::V6(v6) => v6.ip().is_loopback(),
            };

            let remote = conn.remote_addr.to_string();
            let local = conn.local_addr.to_string();

            let description = if blocked {
                format!(
                    "Blocked port {} connection to remote {} from local {}",
                    conn.remote_addr.port(),
                    remote,
                    local
                )
            } else if is_loopback {
                format!(
                    "Loopback connection from {} to {}",
                    local, remote
                )
            } else {
                format!(
                    "External connection from {} to {}",
                    local, remote
                )
            };

            let mut event = SecurityEvent::new(
                EventCategory::Network,
                EventAction::Connected,
                EventSource {
                    collector: "network".into(),
                    host_id: hostname::get()
                        .map(|h| h.to_string_lossy().to_string())
                        .unwrap_or_else(|_| "unknown".into()),
                    host_name: hostname::get()
                        .map(|h| h.to_string_lossy().to_string())
                        .unwrap_or_else(|_| "unknown".into()),
                    agent_id: "network-collector".into(),
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
                },
                "Network Connection",
                description,
            );
            event.severity = severity;
            event = event.with_metadata("source_ip", serde_json::Value::String(local.clone()));
            event = event.with_metadata("destination_ip", serde_json::Value::String(remote.clone()));
            event = event.with_entity(Entity {
                entity_type: EntityType::Ip,
                value: remote,
                risk_contribution: 0.0,
                metadata: HashMap::new(),
            });
            events.push(event);
        }
        Ok(events)
    }

    fn parse_connections(&self) -> Result<Vec<TcpConnection>, String> {
        let mut connections = Vec::new();
        let tcp4 = self.read_proc_net_tcp("/proc/net/tcp")?;
        let tcp6 = self.read_proc_net_tcp("/proc/net/tcp6")?;
        connections.extend(tcp4);
        connections.extend(tcp6);
        Ok(connections)
    }

    fn read_proc_net_tcp(&self, path: &str) -> Result<Vec<TcpConnection>, String> {
        let content = std::fs::read_to_string(path)
            .map_err(|e| format!("Failed to read {}: {}", path, e))?;
        let mut connections = Vec::new();
        for line in content.lines().skip(1) {
            if let Some(conn) = self.parse_line(line) {
                if conn.state == ConnectionState::Established {
                    connections.push(conn);
                }
            }
        }
        Ok(connections)
    }

    fn parse_line(&self, line: &str) -> Option<TcpConnection> {
        let fields: Vec<&str> = line.split_whitespace().collect();
        if fields.len() < 4 {
            return None;
        }
        let local = parse_socket_addr(fields[1])?;
        let remote = parse_socket_addr(fields[2])?;
        let state = parse_state(fields[3])?;
        Some(TcpConnection {
            local_addr: local,
            remote_addr: remote,
            state,
        })
    }
}

fn parse_socket_addr(hex_addr: &str) -> Option<SocketAddr> {
    let parts: Vec<&str> = hex_addr.split(':').collect();
    if parts.len() != 2 {
        return None;
    }
    let ip_hex = parts[0];
    let port_hex = parts[1];
    let port = u16::from_str_radix(port_hex, 16).ok()?;

    if ip_hex.len() == 8 {
        let bytes = (0..8)
            .step_by(2)
            .filter_map(|i| u8::from_str_radix(&ip_hex[i..i + 2], 16).ok())
            .collect::<Vec<u8>>();
        if bytes.len() == 4 {
            let ip = Ipv4Addr::new(bytes[0], bytes[1], bytes[2], bytes[3]);
            return Some(SocketAddr::V4(std::net::SocketAddrV4::new(ip, port)));
        }
    } else if ip_hex.len() == 32 {
        let bytes = (0..32)
            .step_by(2)
            .filter_map(|i| u8::from_str_radix(&ip_hex[i..i + 2], 16).ok())
            .collect::<Vec<u8>>();
        if bytes.len() == 16 {
            let ip = Ipv6Addr::new(
                u16::from_be_bytes([bytes[0], bytes[1]]),
                u16::from_be_bytes([bytes[2], bytes[3]]),
                u16::from_be_bytes([bytes[4], bytes[5]]),
                u16::from_be_bytes([bytes[6], bytes[7]]),
                u16::from_be_bytes([bytes[8], bytes[9]]),
                u16::from_be_bytes([bytes[10], bytes[11]]),
                u16::from_be_bytes([bytes[12], bytes[13]]),
                u16::from_be_bytes([bytes[14], bytes[15]]),
            );
            return Some(SocketAddr::V6(std::net::SocketAddrV6::new(ip, port, 0, 0)));
        }
    }
    None
}

fn parse_state(hex_state: &str) -> Option<ConnectionState> {
    match hex_state {
        "01" => Some(ConnectionState::Established),
        "06" => Some(ConnectionState::TimeWait),
        "08" => Some(ConnectionState::CloseWait),
        "0A" => Some(ConnectionState::Listen),
        _ => {
            let val = u8::from_str_radix(hex_state, 16).ok()?;
            Some(ConnectionState::Other(val))
        }
    }
}
