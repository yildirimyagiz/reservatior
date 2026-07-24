use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SecurityOsConfig {
    pub agent: AgentConfig,
    pub storage: StorageConfig,
    pub event_bus: EventBusConfig,
    pub api: ApiConfig,
    pub collectors: CollectorsConfig,
    pub engines: EnginesConfig,
    pub rule_engine: RuleEngineConfig,
    pub ioc: IocConfig,
    pub risk: RiskConfig,
    pub ai: AiConfig,
    pub response: ResponseConfig,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AgentConfig {
    pub id: String,
    pub name: String,
    pub mode: String,
    pub log_level: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct StorageConfig {
    pub backend: String,
    pub connection_string: String,
    pub max_connections: u32,
    pub retention_days: u32,
    pub compression: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EventBusConfig {
    pub channel_size: usize,
    pub batch_size: usize,
    pub flush_interval_secs: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ApiConfig {
    pub bind: String,
    pub jwt_secret: String,
    pub cors_origins: Vec<String>,
    pub rate_limit: u32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct CollectorsConfig {
    pub process: ProcessCollectorConfig,
    pub network: NetworkCollectorConfig,
    pub filesystem: FilesystemCollectorConfig,
    pub container: ContainerCollectorConfig,
    pub audit: AuditCollectorConfig,
    pub reservatior: ReservatiorCollectorConfig,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ProcessCollectorConfig {
    pub enabled: bool,
    pub use_ebpf: bool,
    pub scan_interval_ms: u64,
    pub allowed_binaries: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct NetworkCollectorConfig {
    pub enabled: bool,
    pub use_netlink: bool,
    pub blocked_ports: Vec<u16>,
    pub monitor_dns: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FilesystemCollectorConfig {
    pub enabled: bool,
    pub use_fanotify: bool,
    pub use_inotify: bool,
    pub watch_paths: Vec<String>,
    pub critical_paths: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ContainerCollectorConfig {
    pub enabled: bool,
    pub docker_socket: String,
    pub watch_namespaces: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AuditCollectorConfig {
    pub enabled: bool,
    pub use_auditd: bool,
    pub log_path: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ReservatiorCollectorConfig {
    pub enabled: bool,
    pub api_url: String,
    pub api_token: String,
    pub watch_events: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EnginesConfig {
    pub process: bool,
    pub network: bool,
    pub filesystem: bool,
    pub container: bool,
    pub auth: bool,
    pub api: bool,
    pub secrets: bool,
    pub cloud: bool,
    pub config_drift: bool,
    pub behavior: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RuleEngineConfig {
    pub rules_path: String,
    pub hot_reload: bool,
    pub max_rules: usize,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IocConfig {
    pub enabled: bool,
    pub feeds: Vec<IocFeedConfig>,
    pub refresh_interval_secs: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct IocFeedConfig {
    pub name: String,
    pub feed_type: String,
    pub url: String,
    pub api_key: Option<String>,
    pub enabled: bool,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RiskConfig {
    pub enabled: bool,
    pub decay_rate: f64,
    pub max_score: f64,
    pub entity_types: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AiConfig {
    pub enabled: bool,
    pub provider: String,
    pub model: String,
    pub api_key: String,
    pub threshold: f64,
    pub max_tokens: u32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ResponseConfig {
    pub enabled: bool,
    pub auto_block_ip: bool,
    pub auto_lock_user: bool,
    pub auto_revoke_token: bool,
    pub notification_webhook: String,
    pub notification_email: String,
}

impl Default for SecurityOsConfig {
    fn default() -> Self {
        Self {
            agent: AgentConfig {
                id: "reservatior-edr-001".into(),
                name: "Reservatior Security OS".into(),
                mode: "production".into(),
                log_level: "info".into(),
            },
            storage: StorageConfig {
                backend: "postgresql".into(),
                connection_string: "postgresql://localhost/security_os".into(),
                max_connections: 10,
                retention_days: 90,
                compression: true,
            },
            event_bus: EventBusConfig {
                channel_size: 100_000,
                batch_size: 1000,
                flush_interval_secs: 5,
            },
            api: ApiConfig {
                bind: "127.0.0.1:9100".into(),
                jwt_secret: String::new(),
                cors_origins: vec!["http://localhost:3000".into()],
                rate_limit: 1000,
            },
            collectors: CollectorsConfig {
                process: ProcessCollectorConfig {
                    enabled: true,
                    use_ebpf: true,
                    scan_interval_ms: 1000,
                    allowed_binaries: vec![
                        "node".into(), "nginx".into(), "postgres".into(),
                        "redis".into(), "bun".into(), "security-os".into(),
                    ],
                },
                network: NetworkCollectorConfig {
                    enabled: true,
                    use_netlink: true,
                    blocked_ports: vec![22, 23, 3389, 4444, 5555],
                    monitor_dns: true,
                },
                filesystem: FilesystemCollectorConfig {
                    enabled: true,
                    use_fanotify: true,
                    use_inotify: true,
                    watch_paths: vec![
                        "/app".into(),
                        "/etc/nginx".into(),
                        "/etc/passwd".into(),
                        "/etc/shadow".into(),
                    ],
                    critical_paths: vec![
                        "/app/.env".into(),
                        "/app/server/prisma".into(),
                        "/etc/shadow".into(),
                        "/etc/ssh/sshd_config".into(),
                    ],
                },
                container: ContainerCollectorConfig {
                    enabled: true,
                    docker_socket: "/var/run/docker.sock".into(),
                    watch_namespaces: vec!["default".into()],
                },
                audit: AuditCollectorConfig {
                    enabled: true,
                    use_auditd: true,
                    log_path: "/var/log/audit/audit.log".into(),
                },
                reservatior: ReservatiorCollectorConfig {
                    enabled: true,
                    api_url: "http://localhost:3000".into(),
                    api_token: String::new(),
                    watch_events: vec![
                        "auth.login".into(),
                        "auth.failed".into(),
                        "booking.created".into(),
                        "payment.received".into(),
                        "admin.created".into(),
                        "role.changed".into(),
                    ],
                },
            },
            engines: EnginesConfig {
                process: true,
                network: true,
                filesystem: true,
                container: true,
                auth: true,
                api: true,
                secrets: true,
                cloud: true,
                config_drift: true,
                behavior: true,
            },
            rule_engine: RuleEngineConfig {
                rules_path: "rules/".into(),
                hot_reload: true,
                max_rules: 10000,
            },
            ioc: IocConfig {
                enabled: true,
                feeds: vec![
                    IocFeedConfig {
                        name: "AbuseIPDB".into(),
                        feed_type: "abuseipdb".into(),
                        url: "https://api.abuseipdb.com/api/v2".into(),
                        api_key: None,
                        enabled: true,
                    },
                    IocFeedConfig {
                        name: "CISA KEV".into(),
                        feed_type: "cisa".into(),
                        url: "https://www.cisa.gov/sites/default/files/feeds/known_exploited_vulnerabilities.json".into(),
                        api_key: None,
                        enabled: true,
                    },
                ],
                refresh_interval_secs: 3600,
            },
            risk: RiskConfig {
                enabled: true,
                decay_rate: 0.1,
                max_score: 100.0,
                entity_types: vec![
                    "host".into(), "user".into(), "process".into(),
                    "container".into(), "ip".into(),
                ],
            },
            ai: AiConfig {
                enabled: false,
                provider: "openai".into(),
                model: "gpt-4".into(),
                api_key: String::new(),
                threshold: 70.0,
                max_tokens: 2000,
            },
            response: ResponseConfig {
                enabled: true,
                auto_block_ip: false,
                auto_lock_user: false,
                auto_revoke_token: false,
                notification_webhook: String::new(),
                notification_email: String::new(),
            },
        }
    }
}

impl SecurityOsConfig {
    pub fn load(path: &str) -> crate::Result<Self> {
        let content = std::fs::read_to_string(path)
            .map_err(|e| crate::SecurityOsError::Config(format!("Failed to read config: {}", e)))?;
        let config: Self = toml::from_str(&content)
            .map_err(|e| crate::SecurityOsError::Config(format!("Failed to parse config: {}", e)))?;
        Ok(config)
    }
}
