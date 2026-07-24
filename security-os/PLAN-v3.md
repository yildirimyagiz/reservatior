# Reservatior Security OS v3.0 — Implementation Plan

## Current State
- **56 crates**, **249 tests** passing
- Strong: 24 detection engines, 8 IOC feeds, graph-based risk, kill-chain correlation
- Weak: No eBPF, no agent separation, no DSL, no knowledge graph DB, no fleet mgmt, no multi-region

---

## PHASE 1: Foundation (Items #5, #4, #1)
*Normalizer, Distributed Event Bus, Agent Architecture*

### 1.1 `normalizer/` — Normalization Layer
- **Depends on**: core
- **Complexity**: M
- `EventNormalizer` trait for Sigma/OTEL/CEF/ECS/Syslog/JSON
- `NormalizerRegistry` with register/normalize methods
- `RawEvent` → `SecurityEvent` transformation pipeline
- 5 built-in normalizers: Sigma, Otel, Cef, Ecs, Syslog

### 1.2 `eventbus/` — Distributed Event Bus
- **Depends on**: core
- **Complexity**: L
- `EventBusBackend` trait (publish/subscribe/health)
- `DistributedEventBus` with pluggable backends
- `LocalBackend` (tokio::broadcast wrapper), `NatsBackend`, `KafkaBackend`
- Batch publishing, backpressure, dead-letter queue
- Replaces the 35-line `core/src/bus.rs`

### 1.3 `agent/` — Agent Architecture
- **Depends on**: core, eventbus, normalizer
- **Complexity**: XL
- `Agent` struct: config, state, bus, normalizer, collectors, identity
- `AgentIdentity` with certificate-based mTLS enrollment
- `Collector` trait: start/stop/health for all collectors
- Agent lifecycle: Unenrolled → Enrolling → Enrolled → Connected
- Heartbeat loop, policy hot-reload, event forwarding
- New binary: `bin/agent.rs`

---

## PHASE 2: Detection (Items #7, #18, #17, #9, #10)
*Rule DSL, Vulnerability Engine, Malware Analysis, Knowledge Graph, Detection Cache*

### 2.1 `detection-dsl/` — Detection DSL
- **Depends on**: core
- **Complexity**: XL
- Parser → AST → Compiler → executable rules
- DSL syntax: `rule X { condition: sequence { ... } window: 300s by: host }`
- `DslCondition`: Field, And/Or/Not, Near, Aggregate, Sequence, Graph
- Hot-reload with file watcher, rule versioning, inheritance
- `.dson` file format (YAML-like)
- Replaces/enhances code-based `rule/` crate

### 2.2 `vulnerability/` — Vulnerability Engine
- **Depends on**: core
- **Complexity**: L
- NVD/CVE feed ingestion with CVSS scoring
- OSV API integration for open-source vulns
- EPSS scoring (exploit prediction)
- KEV tracking (CISA known exploited)
- CVE→Asset mapping, patch recommendations

### 2.3 `malware/` — Malware Analysis
- **Depends on**: core, ioc
- **Complexity**: L
- YARA rule compilation and scanning (via `yara` crate)
- Static analysis: PE/ELF/Mach-O parsing, entropy, imports, sections
- VirusTotal API integration
- File hashes + reputation scoring
- Packing/obfuscation detection

### 2.4 `knowledge-graph/` — Knowledge Graph
- **Depends on**: core, risk
- **Complexity**: XL
- `GraphBackend` trait: Neo4j/ArangoDB/in-memory
- Domain nodes: Host, User, Container, Secret, Booking, Escrow, Payment
- Relationships: owns, started, called, accessed, modified, created, deleted, authenticated
- Path-finding: attack paths, blast radius analysis
- Event ingestion auto-creates/updates nodes and edges
- Cypher query support

### 2.5 `detection-cache/` — Detection Cache
- **Depends on**: core
- **Complexity**: M
- Bloom filter for fast IOC negative lookups
- HyperLogLog for unique source cardinality
- LFU cache with TTL for hot IOCs
- Redis backend (feature-gated) for distributed caching

---

## PHASE 3: Intelligence (Items #6, #15, #16)
*Threat Intelligence Platform, AI Memory, AI Multi-Agent*

### 3.1 `threat-intel/` — Threat Intelligence Platform
- **Depends on**: core, ioc, detection-cache
- **Complexity**: XL
- STIX 2.1 bundle parsing
- TAXII 2.x server/client for feed distribution
- Sigma rule store + compilation to DSL
- Suricata rule store
- MISP event sync
- Event enrichment pipeline

### 3.2 `ai-memory/` — AI Memory System
- **Depends on**: core, knowledge-graph
- **Complexity**: L
- Incident memory: root cause, resolution, similar incidents
- Host memory: baseline behavior, anomalies, risk trend
- User memory: login patterns, normal IPs, devices
- Organization memory: threat patterns, effective responses
- RAG context builder for LLM queries

### 3.3 `ai-multiagent/` — AI Multi-Agent System
- **Depends on**: core, ai, ai-memory, knowledge-graph, risk, correlation
- **Complexity**: XL
- 7 specialist agents: Collector, Detection, Threat, Malware, Cloud, Business, SOC
- `AiAgent` trait with role-based analysis
- Multi-agent orchestrator for consensus analysis
- Agent debate for conflicting assessments
- `LlmClient` trait for pluggable LLM backends (OpenAI, Ollama, etc.)

---

## PHASE 4: Operations (Items #11, #14, #13)
*Fleet Management, SOAR/Playbooks, Identity Layer*

### 4.1 `fleet/` — Agent Fleet Management
- **Depends on**: core, storage
- **Complexity**: L
- Agent registry with enrollment, heartbeat, certificate management
- Agent groups and tags
- Policy distribution
- Health monitoring, offline detection
- Upgrade commands

### 4.2 `soar/` — SOAR / Playbook Engine
- **Depends on**: core, fleet, storage
- **Complexity**: XL
- Playbook DSL: triggers → steps → conditions → actions → rollback
- 16+ step actions (BlockIp, IsolateHost, DisableUser, AI analysis, etc.)
- Approval gates with timeout
- Parallel step execution
- Webhook triggers, cron triggers
- Execution history and audit trail

### 4.3 `identity/` — Identity Layer
- **Depends on**: core
- **Complexity**: L
- `AuthProvider` trait: OIDC, LDAP, SAML, OAuth2, Azure AD, Keycloak
- JWT/OIDC token validation
- RBAC permission system
- Multi-provider support
- Token lifecycle management

---

## PHASE 5: Enterprise (Items #12, #20, #2/#3)
*Multi-Region, Data Lake, eBPF Framework*

### 5.1 `multi-region/` — Multi-Region Gateway
- **Depends on**: core, eventbus, fleet
- **Complexity**: L
- Region gateway with peer connections
- Cross-region event routing
- Region-aware policies
- Incident replication

### 5.2 `datalake/` — Data Lake
- **Depends on**: core
- **Complexity**: XL
- ClickHouse client (actual connection, not just DDL)
- Parquet writer (via `arrow`/`parquet` crates)
- Iceberg catalog (feature-gated)
- Partitioning: daily, hourly, by category, by region
- Hot/warm/cold tiering

### 5.3 `ebpf/` — eBPF Framework + Kernel Drivers
- **Depends on**: core
- **Complexity**: XL
- Linux: eBPF via `aya` crate — exec, open, connect, bind, clone, mount, capabilities, LSM hooks
- Windows: ETW + MiniFilter (feature-gated)
- macOS: Endpoint Security Framework (feature-gated)
- `KernelCollector` trait for cross-platform abstraction
- New binary: `bin/ebpf-agent.rs`

---

## New Crates Summary

| Phase | Crate | Depends On | Complexity |
|-------|-------|-----------|------------|
| 1 | normalizer | core | M |
| 1 | eventbus | core | L |
| 1 | agent | core, eventbus, normalizer | XL |
| 2 | detection-dsl | core | XL |
| 2 | vulnerability | core | L |
| 2 | malware | core, ioc | L |
| 2 | knowledge-graph | core, risk | XL |
| 2 | detection-cache | core | M |
| 3 | threat-intel | core, ioc, detection-cache | XL |
| 3 | ai-memory | core, knowledge-graph | L |
| 3 | ai-multiagent | core, ai, ai-memory, knowledge-graph, risk, correlation | XL |
| 4 | fleet | core, storage | L |
| 4 | soar | core, fleet, storage | XL |
| 4 | identity | core | L |
| 5 | multi-region | core, eventbus, fleet | L |
| 5 | datalake | core | XL |
| 5 | ebpf | core | XL |

**Total: 17 new crates + modify ~12 existing crates**
**Estimated: ~21,500 new lines of Rust**

## Target Metrics

| Metric | v2.0 (Current) | v3.0 (Target) |
|--------|----------------|---------------|
| Crates | 56 | 73 |
| Tests | 249 | 400+ |
| Detection Engines | 24 | 24 + DSL |
| IOC Feeds | 8 | 8 + STIX/TAXII/MISP |
| Collectors | 18 | 18 + eBPF |
| AI Agents | 1 | 7 |
| Response Actions | 16 | 16 + Playbooks |
| Storage | PostgreSQL + ClickHouse DDL | PostgreSQL + ClickHouse + Parquet + Iceberg |
| Identity | None | OIDC/LDAP/SAML/OAuth2 |
| Multi-Region | None | EU/US/TR/ME gateways |
