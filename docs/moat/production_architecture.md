# Production-Grade Architecture Blueprint: Contract-Driven Revenue Machine

This document outlines the production-ready infrastructure, caching, messaging, and failure recovery specifications required to support our high-throughput, secure, contract-driven revenue engine.

---

## 1. Microservices Deployment Topology

To ensure strict data isolation, high availability, and secure boundary enforcement, the services are separated into distinct runtime environments within a secure virtual private cloud (VPC):

```
                        ┌─────────────────────────────────────────┐
                        │              Internet                   │
                        └────────────────────┬────────────────────┘
                                             │
                                             v
                        ┌────────────────────┴────────────────────┐
                        │      Cloudflare / WAF Edge Gateway      │
                        └────────────────────┬────────────────────┘
                                             │
                                             v
                        ┌────────────────────┴────────────────────┐
                        │       Reverse Proxy / API Gateway        │
                        └──────────┬───────────────────┬──────────┘
                                   │                   │
             ┌─────────────────────┘                   └─────────────────────┐
             v                                                               v
┌─────────────────────────┐                                     ┌─────────────────────────┐
│     Core App Pods       │                                     │     SSE Stream Pods     │
│   (SaaS Operations)     │                                     │ (Real-Time Notification)│
└────────────┬────────────┘                                     └────────────┬────────────┘
             │                                                               │
             │                 Internal Mutual TLS (mTLS)                    │
             └─────────────────────────────┬─────────────────────────────────┘
                                           │
                                           v
                        ┌──────────────────┴──────────────────────┐
                        │     Financial Execution Engine (FEE)    │
                        │   (Isolated from public internet)       │
                        └──────────┬───────────────────┬──────────┘
                                   │                   │
             ┌─────────────────────┘                   └─────────────────────┐
             v                                                               v
┌─────────────────────────┐                                     ┌─────────────────────────┐
│  State Machine Executor │                                     │   Gemini Moat Auditor   │
│  (Isolated DB Access)   │                                     │   (Outbound Proxy Node) │
└─────────────────────────┘                                     └─────────────────────────┘
```

### Pod & VPC Access Rules:
- **Core App Service**: Standard user interactions. Communicates internally with other services via **mTLS**.
- **Financial Execution Engine (FEE)**: Strictly isolated, placed in a private subnet. No public internet ingress.
- **SSE Stream Gateway**: Highly scalable Node.js/Bun instances optimized for persistent HTTP connections, reading directly from the message bus.
- **State Machine Executor**: Dedicated microservice managing transactional state transitions. Has exclusive access to write-ahead logs.

---

## 2. RabbitMQ Exchange & Queue Naming Standard

Our event-driven revenue stream utilizes RabbitMQ for deterministic message routing. We enforce a structured exchange and routing key standard:

- **Exchange**: `prod.realestate.direct` (Direct Exchange for transactional states) & `prod.realestate.topic` (Topic Exchange for lifecycle events)
- **Routing Key Schema**: `<entity>.<event_action>`

### Queue & Routing Key Registry:

| Exchange | Routing Key | Target Queue | Purpose |
| :--- | :--- | :--- | :--- |
| `prod.realestate.topic` | `listing.created` | `q.billing.listing-init` | Emitted when a property listing goes live. |
| `prod.realestate.topic` | `listing.viewed` | `q.analytics.telemetry` | High-frequency interaction/telemetry stream. |
| `prod.realestate.topic` | `lead.inquiry` | `q.billing.lead-scoring` | Tracks prospective tenant requests. |
| `prod.realestate.direct`| `booking.confirmed`| `q.revenue.dag-calculation` | Confirmed bookings feeding the Revenue DAG. |
| `prod.realestate.direct`| `revenue.realized` | `q.revenue.fee-execution` | Revenue events entering the FEE. |
| `prod.realestate.direct`| `contract.state-change`| `q.state.lifecycle-execution`| Contract state machine transitions (CREATED $\rightarrow$ ACTIVE). |

---

## 3. Redis State Cache Strategy

Redis is utilized for low-latency state readouts, rate-limiting, and transactional locking:

### A. Distributed Lock Pattern (Redlock)
To prevent double-spending and out-of-order state machine updates during simultaneous lifecycle events, we acquire a Redis lock before executing any revenue split or payout transition:
- **Key Schema**: `lock:agreement:<agreement_id>`
- **TTL**: 5000ms (Auto-release if execution fails).

### B. High-Frequency Cache Keys
- **Terms Schema**: `cache:agreement:<agreement_id>:terms`
  - *TTL*: 1 hour. Stores the decrypted AES-GCM payload to prevent DB queries during high-frequency transaction loops.
- **Telemetry Buffers**: `buffer:listing:<listing_id>:engagement`
  - *Type*: Sorted Set (ZSET). Collects exposure scores over a rolling 1-hour window before flushing metrics to the DB/RabbitMQ.

---

## 4. Failure Recovery & Replay System

Financial data cannot afford inconsistencies. We implement an **Event Sourcing & Log Replay** strategy:

### A. Write-Ahead Event Log
Every state change inside the Contract Execution State Machine is written to an immutable audit trail (`EventRecord`) before the state is updated in the database.

### B. Replay Engine Flow
If a service crash occurs mid-calculation:
1. **State Reset**: Mark the affected agreement state as `ESCALATED` or `SUSPENDED`.
2. **Replay Hook**: Fetch the chronological sequence of messages from the persistent audit database or RabbitMQ's persistent queue `q.revenue.fee-execution` for the specific tenant ID.
3. **Calculation Re-Execution**: Feed the events through the deterministic Revenue DAG engine.
4. **Consistency Reconciliation**: Compare the re-computed net payout against the ledger. Any discrepancy is flagged for manual settlement review and pushed to the `q.revenue.error.dlq` (Dead Letter Queue) on RabbitMQ.
