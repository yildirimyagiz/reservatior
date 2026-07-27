# Reservatior 8-Layer AI Acquisition OS - Deployment Guide

## Architecture Overview

This implementation transforms Reservatior into an enterprise-grade AI Acquisition OS with 8 layers:

1. **Ingestion Layer** - MLS, CSV, API, Partner Feed
2. **Intelligence Layer** - Property, Spatial, Market, Valuation
3. **Knowledge Layer** - Knowledge Graph + Vector Search + Feature Store
4. **Decision Layer** - Acquisition Brain + Simulation + Opportunity Ranking
5. **Execution Layer** - CRM, Ads, Communication, Booking, Negotiation
6. **Finance Layer** - Escrow, Commission, Revenue Intelligence
7. **Learning Layer** - Feedback Loop, Model Evaluation, A/B Testing
8. **Observability Layer** - Tracing, Metrics, Cost Monitoring, Audit

## Architecture Diagram

```
                Users
                  │
                  ▼
            Reservatior VPS
        (FastAPI + Bun + Elysia)
                  │
                  │
          Publish Event
                  │
                  ▼
          Google Cloud Pub/Sub
                  │
        ┌─────────┼─────────┐
        ▼         ▼         ▼
   Agent A    Agent B   Agent C
        │         │         │
        └─────────┼─────────┘
                  │
             Publish Result
                  │
                  ▼
          Google Cloud Pub/Sub
                  │
                  ▼
          Reservatior Worker
             (VPS Pull)
                  │
                  ▼
             PostgreSQL
```

## Phase 1: Foundation (Completed)

### VPS Edge Components
- **API Gateway** (`src/edge/api-gateway.ts`) - Handles incoming requests and routing
- **Transaction Worker** (`src/edge/transaction-worker.ts`) - Database consistency and transaction state
- **Event Publisher** (`src/edge/services/event-publisher.ts`) - Publishes events to GCP Pub/Sub
- **Event Consumer** (`src/edge/services/event-consumer.ts`) - Subscribes to GCP Pub/Sub topics
- **WebSocket Gateway** (`src/edge/websocket-gateway.ts`) - Real-time UI updates

### Event Naming Convention
Domain-based versioning: `property.listing.ingested.v1`

**Standard Events:**
- `property.listing.ingested.v1` - New property listing ingested
- `property.intelligence.generated.v1` - Property intelligence analysis completed
- `property.valuation.completed.v1` - Property valuation completed
- `property.opportunity.scored.v1` - Property opportunity score calculated
- `property.opportunity.explained.v1` - Property opportunity explained by Strategic Brain
- `property.acquisition.approved.v1` - Property acquisition approved
- `property.owner.invitation.created.v1` - Owner invitation created
- `property.owner.claimed.v1` - Owner claimed property
- `property.portfolio.onboarded.v1` - Property portfolio onboarded
- `transaction.commission.created.v1` - Commission created

### GCP Project Structure
- **Staging**: `reservatior-staging`
- **Production**: `reservatior-prod`

## Phase 2: Intelligence Layer (Completed)

### Opportunity Engine (`src/intelligence/opportunity-engine.ts`)
Pure mathematical scoring engine (no AI hallucination risk):

**Scoring Components:**
- Yield (25%): Cap rate, cash-on-cash return, gross yield, net yield
- Price Gap (20%): Undervaluation percentage
- Demand (20%): Market demand, search volume, days on market
- Vacancy (10%): Area and property vacancy rates
- Risk (15%): Location, market, and overall risk (inverted)
- Liquidity (10%): Market and property liquidity

**Output:**
- Overall score (0-100)
- Opportunity tier (LOW_POTENTIAL, MONITOR, HIGH_POTENTIAL, PREMIUM)
- Acquisition urgency (LOW, MEDIUM, HIGH, IMMEDIATE)

### Strategic Brain (`src/intelligence/strategic-brain.ts`)
Gemini AI explanation layer:

**Capabilities:**
- Explains why a property received its score
- Identifies regional strengths
- Recommends target customer segments
- Suggests sales strategies
- Lists risk factors
- Provides timing recommendations

**Model:** `gemini-2.5-flash` (configurable)

### Feature Store (`src/knowledge/feature-store.ts`)
Vertex AI Feature Store integration for O(1) feature access:

**Features:**
- Property features (yield, vacancy, crime, walkability, school, demand, trust, risk)
- Market features (price trends, demand patterns, liquidity)
- Temporal features (seasonal patterns, time-based trends)
- In-memory caching with configurable expiry

## Phase 3: Knowledge Layer (Completed)

### Knowledge Graph (`src/knowledge/knowledge-graph.ts`)
Neo4j relationship structure for complex property relationships:

**Node Types:**
- Property, Owner, Previous Owner, Broker, Developer
- Building, Neighborhood, Tenant, Buyer, Seller
- Contractor, Lender, Investor, InvestorInterest
- Transaction, Maintenance, Mortgage

**Relationships:**
- OWNED_BY, PREVIOUSLY_OWNED_BY, LISTED_BY, DEVELOPED_BY
- PART_OF, LOCATED_IN, RENTED_TO, HAD_TRANSACTION
- HAD_MAINTENANCE, HAS_MORTGAGE, HAS_INVESTOR_INTEREST

**Advanced Features:**
- Investment pattern detection
- Property ownership chain tracking
- Similar property discovery

### Vector Search (`src/knowledge/vector-search.ts`)
Semantic search integration:

**Capabilities:**
- Text embedding generation (Vertex AI)
- Semantic property search
- Similar property discovery
- Hybrid search (semantic + keyword)
- Property clustering

**Model:** `textembedding-gecko@003` (768-dimensional)

## Phase 4: Decision Layer (Completed)

### Simulation Agent (`src/decision/simulation-agent.ts`)
Commercial scenario simulation:

**Scenarios:**
1. **Normal Sale** - Traditional property sale
2. **Luxury Rental Management** - High-end rental with management
3. **Corporate Tenant** - Long-term corporate lease
4. **Furnished Short-term Rental** - Airbnb-style rental
5. **Wait 90 Days** - Hold for appreciation
6. **Wait 180 Days** - Longer hold period

**Output per Scenario:**
- Estimated timeframe (days)
- Estimated revenue and costs
- Net profit and profit margin
- Confidence score
- Risk factors
- Requirements

### Ranking Engine (`src/decision/ranking-engine.ts`)
Multi-factor opportunity ranking:

**Ranking Weights:**
- Opportunity Score (30%)
- Strategic Analysis (25%)
- Simulation Results (25%)
- Market Conditions (10%)
- User Preferences (10%)

**Output:**
- Ranked property list
- Overall scores (0-100)
- Recommended strategies
- Confidence levels
- Key factors and risks

## Phase 5: Governance & Learning (Completed)

### Agent Governance Layer (`src/governance/agent-governance.ts`)
Enterprise security and permission control:

**Agent Types:**
- ValuationAgent, CommunicationAgent, StrategicBrain
- AcquisitionBrain, SimulationAgent, RankingEngine
- CampaignAgent, CRMAgent, FinanceAgent

**Action Types:**
- READ, WRITE, EXECUTE_EXTERNAL, UPDATE_FINANCE
- SEND_EMAIL, SEND_SMS, UPDATE_CRM, DIRECT_DATABASE_WRITE
- API_ACCESS, SEND_DIRECT_OFFER, UPDATE_OWNER_CONTACT, EXECUTE_TRANSACTION

**Security Features:**
- Permission-based access control
- Resource-level security
- Human approval requirements
- Comprehensive audit logging

### Outcome Store (`src/learning/outcome-store.ts`)
BigQuery learning loop for continuous improvement:

**Data Collected:**
- Predicted vs actual outcomes
- Model error delta calculation
- Prediction accuracy tracking
- Strategy match analysis
- Revenue realization rates

**Learning Metrics:**
- Average model error
- Prediction accuracy
- Strategy match rate
- Conversion rate
- Revenue realization rate

### Agent Registry (`src/governance/agent-registry.ts`)
Agent versioning and management:

**Features:**
- Agent version tracking (v1.0, v1.1, v1.2, etc.)
- Model version management
- Configuration versioning
- A/B testing support
- Rollback capabilities
- Performance metrics tracking

### Prompt Versioning (`src/governance/prompt-versioning.ts`)
Prompt management system:

**Prompt Types:**
- SYSTEM, USER, EXAMPLES, TOOL, SCHEMA

**Features:**
- Version control for prompts
- Template management
- Variable substitution
- Performance tracking
- A/B testing
- Rollback capabilities

## Phase 6: Deployment (Completed)

### GCP Deployment Plan

#### Terraform Configuration
- **Projects** (`gcp/terraform/projects.tf`) - reservatior-staging, reservatior-prod
- **Pub/Sub** (`gcp/terraform/pubsub.tf`) - Topics and subscriptions
- **Cloud Run** (`gcp/terraform/cloudrun.tf`) - Agent services and IAM

#### Cloud Run Services
- **Strategic Brain Service** - Gemini AI analysis
- **Opportunity Engine Service** - Mathematical scoring
- **Simulation Agent Service** - Scenario simulation
- **Ranking Engine Service** - Opportunity ranking

#### IAM Roles
- Service accounts for each agent
- Vertex AI access for Strategic Brain
- Pub/Sub publisher/subscriber roles
- Feature Store viewer roles

### VPS Worker Systemd

#### Worker Daemon
- **Location**: `src/edge/workers/gcp-event-worker.ts`
- **Function**: Subscribes to GCP Pub/Sub, updates PostgreSQL, triggers WebSocket updates

#### Systemd Service
- **Location**: `gcp/systemd/reservatior-gcp-worker.service`
- **Auto-restart**: Enabled
- **Logging**: Journal-based

## Environment Variables

### Required Variables
```bash
# GCP Configuration
GCP_PROJECT_ID="reservatior-prod"
GCP_PUBSUB_TOPIC_PREFIX="reservatior-prod"
GCP_PUBSUB_SUBSCRIPTION_PREFIX="reservatior-prod"
GCP_BIGQUERY_DATASET="analytics"
GCP_VERTEXAI_ENDPOINT="us-central1-aiplatform.googleapis.com"
GOOGLE_APPLICATION_CREDENTIALS="/etc/reservatior/gcp-prod-key.json"

# AI/ML Services
GEMINI_API_KEY="your-gemini-api-key"
EMBEDDING_MODEL="textembedding-gecko@003"
FEATURE_STORE_ID="reservatior-feature-store"

# Neo4j Configuration
NEO4J_URI="neo4j://localhost:7687"
NEO4J_USERNAME="neo4j"
NEO4J_PASSWORD="your-neo4j-password"
```

## Deployment Steps

### 1. GCP Infrastructure Setup
```bash
cd /Users/os2026/Downloads/Reservatior/server/gcp/terraform

# Initialize Terraform
terraform init

# Plan deployment
terraform plan

# Apply changes
terraform apply
```

### 2. Build and Deploy Cloud Run Services
```bash
# Build Docker images
docker build -t gcr.io/reservatior-prod/strategic-brain:v1.0.0 -f docker/strategic-brain.Dockerfile .
docker build -t gcr.io/reservatior-prod/opportunity-engine:v1.0.0 -f docker/opportunity-engine.Dockerfile .
docker build -t gcr.io/reservatior-prod/simulation-agent:v1.0.0 -f docker/simulation-agent.Dockerfile .
docker build -t gcr.io/reservatior-prod/ranking-engine:v1.0.0 -f docker/ranking-engine.Dockerfile .

# Push to GCR
docker push gcr.io/reservatior-prod/strategic-brain:v1.0.0
docker push gcr.io/reservatior-prod/opportunity-engine:v1.0.0
docker push gcr.io/reservatior-prod/simulation-agent:v1.0.0
docker push gcr.io/reservatior-prod/ranking-engine:v1.0.0
```

### 3. VPS Setup
```bash
# Copy systemd service file
sudo cp gcp/systemd/reservatior-gcp-worker.service /etc/systemd/system/

# Copy GCP credentials
sudo mkdir -p /etc/reservatior
sudo cp gcp-prod-key.json /etc/reservatior/
sudo chmod 600 /etc/reservatior/gcp-prod-key.json

# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable reservatior-gcp-worker
sudo systemctl start reservatior-gcp-worker

# Check status
sudo systemctl status reservatior-gcp-worker
```

### 4. Environment Configuration
```bash
# Copy .env.example to .env
cp .env.example .env

# Edit with actual values
nano .env
```

### 5. Install Dependencies
```bash
# Add GCP dependencies (if needed)
bun add @google-cloud/pubsub @google-cloud/bigquery @google-cloud/aiplatform
```

## Testing

### Test Edge Components
```bash
# Test API Gateway
bun run edge:status

# Test Event Publisher
bun run src/edge/services/event-publisher.ts

# Test Event Consumer
bun run gcp:worker:dev
```

### Test Intelligence Layer
```bash
# Test Opportunity Engine
bun run src/intelligence/opportunity-engine.ts

# Test Strategic Brain
bun run src/intelligence/strategic-brain.ts

# Test Feature Store
bun run src/knowledge/feature-store.ts
```

### Test Knowledge Layer
```bash
# Test Knowledge Graph
bun run src/knowledge/knowledge-graph.ts

# Test Vector Search
bun run src/knowledge/vector-search.ts
```

### Test Decision Layer
```bash
# Test Simulation Agent
bun run src/decision/simulation-agent.ts

# Test Ranking Engine
bun run src/decision/ranking-engine.ts
```

### Test Governance Layer
```bash
# Test Agent Governance
bun run src/governance/agent-governance.ts

# Test Outcome Store
bun run src/learning/outcome-store.ts

# Test Agent Registry
bun run src/governance/agent-registry.ts

# Test Prompt Versioning
bun run src/governance/prompt-versioning.ts
```

## Monitoring

### VPS Worker Logs
```bash
# View real-time logs
sudo journalctl -u reservatior-gcp-worker -f

# View recent logs
sudo journalctl -u reservatior-gcp-worker -n 100
```

### GCP Cloud Run Logs
```bash
# View Cloud Run logs
gcloud logging read "resource.type=cloud_run_revision" --limit 50
```

### Pub/Sub Monitoring
```bash
# View Pub/Sub metrics
gcloud pubsub topics list
gcloud pubsub subscriptions list
```

## Architecture Benefits

1. **VPS as Edge Components** - No direct GCP agent connections, port-free, static IP-free
2. **Google Cloud as AI Center** - All AI processing in GCP, scalable microservices
3. **Event-Driven Architecture** - Domain-based naming, versioned events
4. **Enterprise Security** - Agent governance, permission controls, audit logging
5. **Continuous Learning** - Outcome tracking, model evaluation, A/B testing
6. **Scalability** - Cloud Run auto-scaling, independent microservices
7. **Resilience** - Event-driven decoupling, retry mechanisms, dead letter queues

## Next Steps

1. **Implement actual GCP client libraries** - Replace TODO comments with real implementations
2. **Create Docker files** - Build containers for each Cloud Run service
3. **Set up monitoring** - Cloud Monitoring, Cloud Logging, Cloud Trace
4. **Implement dead letter queues** - Handle failed Pub/Sub messages
5. **Add integration tests** - Test end-to-end event flows
6. **Performance optimization** - Tune caching, batch processing, parallel execution
7. **Cost optimization** - Monitor GCP costs, optimize resource allocation

## Support

For issues or questions:
- Check logs: `sudo journalctl -u reservatior-gcp-worker -f`
- Review GCP console: https://console.cloud.google.com
- Check Terraform state: `cd gcp/terraform && terraform show`
