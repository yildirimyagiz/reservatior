# Reservatior Security OS - CHANGELOG v2.0

## 56 Crates | 249 Tests Passing | Build: OK

---

## Architecture (Enterprise-Grade AI-Native Security OS)

```
security-os/
├── core/                          # Event model (70+ fields), Severity (5 levels), MITRE (50+ techniques), EventBus, Config, Correlation, Incident, Kill Chain, Response Policy, Knowledge Graph, Agent Heartbeat
├── storage/
│   ├── postgres/                  # PostgreSQL EventStore
│   └── clickhouse/                # ClickHouse telemetry + MemoryStore fallback
│
├── collectors/                    # 18 Telemetry Collectors
│   ├── process/                   # Process lifecycle (sysinfo)
│   ├── network/                   # TCP connections (/proc/net/tcp)
│   ├── filesystem/                # File integrity (SHA-256 baselines)
│   ├── container/                 # Docker lifecycle (docker ps)
│   ├── audit/                     # Linux auditd log parsing
│   ├── systemd/                   # Systemd journal monitoring
│   ├── ssh/                       # SSH login/auth from /var/log/auth.log
│   ├── kernel/                    # Kernel events (module load, seccomp, OOM)
│   ├── dns/                       # DNS query monitoring
│   ├── tls/                       # TLS certificate/cipher monitoring
│   ├── jwt/                       # JWT issuance/verification
│   ├── cron/                      # Cron job monitoring
│   ├── sudo/                      # Sudo command monitoring
│   ├── selinux/                   # SELinux AVC denials
│   ├── memory/                    # Memory pressure monitoring
│   ├── gpu/                       # GPU usage (crypto mining detection)
│   ├── kubernetes/                # K8s API (Pod, RBAC, Secret, ConfigMap)
│   └── reservatior/               # Business events (auth, booking, payment, escrow)
│
├── engines/                       # 24 Detection Engines
│   ├── process/                   # Suspicious process chains, spoofing
│   ├── network/                   # Port scan, exfiltration, C2 beaconing
│   ├── filesystem/                # Ransomware, sensitive file access
│   ├── container/                 # Container escape, crypto mining
│   ├── auth/                      # Brute force, credential stuffing
│   ├── api/                       # Rate abuse, JWT manipulation, SQL/XSS
│   ├── secrets/                   # Secret leak detection (AWS, JWT, API keys)
│   ├── cloud/                     # IAM changes, public S3, root usage
│   ├── config_drift/              # SHA-256 config drift detection
│   ├── behavior/                  # User behavior profiling, impossible travel
│   ├── identity/                  # Identity-based threat detection
│   ├── ssh/                       # SSH brute force, tunnel, anomalies
│   ├── kubernetes/                # Pod escape, RBAC escalation, secret enum
│   ├── ransomware/                # Mass file mods, encryption patterns
│   ├── lateral_movement/          # Horizontal movement, pass-the-hash
│   ├── persistence/               # Scheduled tasks, SSH keys, systemd
│   ├── privilege_escalation/      # Sudo abuse, capability escalation
│   ├── data_exfiltration/         # Large transfers, DNS exfil
│   ├── webshell/                  # Web shell detection
│   ├── insider_threat/            # After-hours, mass downloads, USB
│   ├── supply_chain/              # Compromised dependencies, build tampering
│   ├── binary_reputation/         # Unsigned binaries, malicious hashes
│   ├── injection/                 # SQL/XSS/SSRF/Command injection
│   └── llm_abuse/                 # Prompt injection, AI abuse patterns
│
├── correlation/                   # Kill-chain correlation engine
├── rule/                          # Boolean rule engine (AND/OR/NOT/regex/threshold)
├── ioc/                           # IOC feeds (AbuseIPDB, CISA, GreyNoise, ThreatFox, URLHaus, PhishTank, AbuseCH, TOR)
├── risk/                          # Graph-based risk engine (entity risk graph with propagation)
├── ai/                            # AI SOC Analyst pipeline (kill chain, root cause, business impact)
├── api/                           # Axum REST/SSE server
├── dashboard/response/            # Policy-based autonomous response engine
├── cli/                           # CLI binary
├── sdk/                           # Client SDK
├── proto/                         # Protocol types
└── plugins/                       # Plugin system
```

---

## New in v2.0

### Core Event Schema Expansion (70+ fields)
- Multi-tenancy: tenant_id, environment
- Infrastructure: region, cluster, node_name
- Process context: pid, ppid, uid, gid, exe, cmdline, username, session, process_hash_sha256, process_signature, process_reputation
- File context: file_path, file_hash_sha256, file_size, file_permissions
- Network context: src_ip, dst_ip, src_port, dst_port, protocol, country, asn
- Risk/Business: risk_delta, business_context, revenue_impact
- Rule: rule_id, rule_name
- Chain: chain_id, incident_id
- Incident, KillChainPhase, ResponsePolicy, ResponseAction, KnowledgeGraph structures

### 12 New Collectors
| Collector | Source | Events |
|-----------|--------|--------|
| systemd | journalctl | Service start/fail/modified |
| ssh | auth.log | Login, failed, brute force |
| kernel | /dev/kmsg, audit | Module load, capability, seccomp, OOM |
| dns | dnsmasq, resolve | DNS query, tunnel, DoH |
| tls | nginx/access.log | Weak cipher, deprecated protocol, cert expiry |
| jwt | API logs | JWT issued, expired, algorithm tamper |
| cron | /etc/crontab | Cron modified, scheduled |
| sudo | auth.log | Sudo command, denied, suspicious |
| selinux | audit.log | AVC denied, policy change |
| memory | /proc/meminfo | Memory pressure, swap pressure |
| gpu | nvidia-smi | GPU high usage, crypto mining |
| kubernetes | K8s API | Pod lifecycle, RBAC, Secret access |

### 14 New Detection Engines
| Engine | Detections | MITRE |
|--------|-----------|-------|
| identity | Impossible travel, dormant accounts, service account abuse | T1078, T1098 |
| ssh | Brute force, tunnel, timing anomalies | T1021.004, T1110 |
| kubernetes | Pod escape, RBAC escalation, secret enum | T1610, T1611, T1613 |
| ransomware | Mass file mods, encryption patterns, shadow copy deletion | T1486, T1490 |
| lateral_movement | Horizontal movement, pass-the-hash | T1021, T1550 |
| persistence | Scheduled tasks, SSH keys, systemd, cron | T1053, T1547, T1543 |
| privilege_escalation | Sudo abuse, capability escalation, suid | T1548, T1068 |
| data_exfiltration | Large transfers, DNS exfil, upload anomalies | T1041, T1048, T1567 |
| webshell | Web server spawning shells, suspicious content | T1505.003 |
| insider_threat | After-hours, mass downloads, USB, sensitive access | T1078 |
| supply_chain | Compromised deps, build tampering | T1195, T1195.002 |
| binary_reputation | Unsigned, malicious hashes, unusual locations | T1204, T1027 |
| injection | SQL/XSS/SSRF/Command/NoSQL/LDAP | T1190, T1059 |
| llm_abuse | Prompt injection, data exfil via AI, jailbreak | T1565 |

### Kill-Chain Correlation Engine
- Temporal correlation (configurable time windows)
- Cross-entity correlation (host, user, container, IP)
- Business correlation (security events + business events)
- 5 kill chain patterns:
  - Container + Process + Network + Modified = Container Escape (Critical)
  - Business + Modified + escrow/payment = Business Logic Attack (Critical)
  - SSH + Sudo + Network + Modified = Lateral Movement (High)
  - Process + Modified + Network = C2/Exfiltration (Critical)
  - Auth failures + success + admin action = Account Compromise (Critical)

### Graph-Based Risk Engine
- Entity risk graph with weighted edges
- Risk propagation through relationships
- Auto edge discovery from events
- Entity types: Host, User, Container, Pod, ApiKey, JWT, Booking, Escrow, Payment
- Time-decay scoring

### IOC Feeds (10 sources)
- AbuseIPDB, CISA KEV, Generic (existing)
- GreyNoise (IP context: noise/riot/classification)
- ThreatFox (botnet CC, malware, C2)
- URLHaus (malicious URLs)
- PhishTank (phishing URLs)
- AbuseCH (malware hashes)
- TOR Exit Nodes

### AI SOC Analyst Pipeline
- Kill chain analysis prompt
- Business impact analysis (Reservatior-specific)
- Confidence scoring based on evidence quality
- Correlation chain context for LLM

### Policy-Based Response Engine
- Configurable response policies with conditions
- Auto-response with cooldown tracking
- 15 action types: BlockIp, DisableUser, QuarantineContainer, IsolateHost, BlockProcess, Notify, CreateIncident, etc.

### MITRE Registry Expansion
- 50+ technique mappings across all 14 MITRE tactics
- Initial Access, Execution, Persistence, Privilege Escalation, Defense Evasion, Credential Access, Lateral Movement, Collection, C2, Exfiltration, Impact, Discovery, Resource Development

---

## Test Summary

| Category | Tests |
|----------|-------|
| Core | 0 (types only) |
| Storage | 14 (ClickHouse + MemoryStore) |
| Collectors | 17 |
| Engines | 156 |
| Correlation | 9 |
| Rule | 13 |
| IOC | 20 |
| Risk | 12 |
| AI | 19 |
| Response | 39 |
| SDK/Proto/Plugins | 18 |
| API/CLI | 0 |
| **TOTAL** | **249** |

---

## Workspace Statistics

| Metric | Value |
|--------|-------|
| Total crates | 56 |
| Total tests | 249 |
| Test failures | 0 |
| Build status | OK |
| Collectors | 18 |
| Detection engines | 24 |
| IOC feeds | 10 |
| MITRE techniques | 50+ |
| Event schema fields | 70+ |
