# 🦊 Elysia Real Estate API

High-performance REST API built with **ElysiaJS** + **Prisma** + **Bun**, designed as a multi-tenant real estate platform with 22 microservices.

---

## 🚀 Quick Start

### 1. Clone & Install
```bash
bun install
```

### 2. Environment
```bash
cp .env.example .env
# Edit .env — set JWT_SECRET and DATABASE_URL
```

### 3. Database
```bash
# Start Postgres via Docker
docker compose up postgres -d

# Push schema & generate Prisma client
bun run db:push

# Seed with demo data
bun run db:seed
```

### 4. Run
```bash
# Monolith (all routes, port 3000)
bun run src/index.ts

# Or run all microservices in parallel (watch mode)
bun run dev
```

### 5. Swagger UI
Open [http://localhost:3000/docs](http://localhost:3000/docs)

---

## 🐳 Docker (Full Stack)

```bash
# Start everything: Postgres + migrate + all 22 services
docker compose up -d

# Tail logs
docker compose logs -f

# Stop
docker compose down
```

---

## 📋 Services & Ports

| Service          | Port | Prefix              |
|------------------|------|---------------------|
| **Gateway**      | 3000 | `/api/v1/*`         |
| Auth             | 3001 | `/auth`             |
| Organizations    | 3002 | `/organizations`    |
| Properties       | 3003 | `/properties`       |
| Listings         | 3004 | `/listings`         |
| Leads            | 3005 | `/leads`            |
| Contacts         | 3006 | `/contacts`         |
| Leases           | 3007 | `/leases`           |
| Appointments     | 3008 | `/appointments`     |
| Tasks            | 3009 | `/tasks`            |
| Maintenance      | 3010 | `/maintenance`      |
| Documents        | 3011 | `/documents`        |
| Financials       | 3012 | `/financials`       |
| Notifications    | 3013 | `/notifications`    |
| Reports          | 3014 | `/reports`          |
| Webhooks         | 3015 | `/webhooks`         |
| Audit            | 3016 | `/audit-logs`       |
| Reservations     | 3017 | `/reservations`     |
| Deals            | 3018 | `/deals`            |
| Commissions      | 3019 | `/commissions`      |
| Bookings         | 3020 | `/bookings`         |
| Escrow           | 3021 | `/escrow`           |
| AI               | 3022 | `/ai`               |

---

## 🔑 Authentication

All endpoints (except `/auth/register` and `/auth/login`) require a Bearer token.

```bash
# Register
curl -X POST http://localhost:3000/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"you@example.com","name":"Your Name"}'

# Login → get token
curl -X POST http://localhost:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"you@example.com"}'

# Use token
curl http://localhost:3000/api/v1/properties \
  -H "Authorization: Bearer <token>"
```

---

## 🧩 Eden Treaty (Type-safe Frontend Client)

Copy `src/lib/eden-client.ts` and `src/lib/eden-hooks.ts` to your frontend:

```bash
# Install in frontend project
bun add elysia @elysiajs/eden
```

```ts
// Usage
import { api } from "@/lib/api"
import { useProperties, useLeads } from "@/hooks/useApi"

// Hook
const { data, loading, error } = useProperties({ city: "New York", limit: 10 })

// Direct call
const { data } = await api.api.v1.properties.get({ query: { page: 1 } })
```

See [EDEN_TREATY.md](./EDEN_TREATY.md) for full documentation.

---

## 🗄️ Database Scripts

```bash
bun run db:generate   # Re-generate Prisma client after schema changes
bun run db:push       # Push schema to DB (no migration history)
bun run db:migrate    # Create a migration (recommended for production)
bun run db:studio     # Open Prisma Studio GUI
bun run db:seed       # Seed demo data
```

---

## 📁 Project Structure

```
src/
├── index.ts              # API Gateway (monolith entry)
├── router.ts             # Central route aggregator
├── routes/               # Route handlers (22 modules)
│   ├── auth.ts
│   ├── properties.ts
│   └── ...
├── pages/                # Microservice entry points (22 services)
│   ├── auth/index.ts     # Runs on PORT_AUTH (3001)
│   ├── properties/index.ts
│   └── ...
├── plugins/
│   ├── auth.ts           # JWT + Bearer auth plugin
│   └── prisma.ts         # Prisma db injection plugin
└── lib/
    ├── prisma.ts          # Prisma client singleton
    ├── eden-client.ts     # Frontend type-safe client
    └── eden-hooks.ts      # React hooks for all APIs
prisma/
├── schema.prisma          # Full data model
└── seed.ts                # Demo data seeder
```

---

## 🤝 Adding a New Route

1. Create `src/routes/myfeature.ts` following the existing pattern
2. Import and register in `src/router.ts`
3. Create `src/pages/myfeature/index.ts` for the standalone microservice
4. Add `dev:myfeature` / `start:myfeature` scripts to `package.json`
5. Add the service to `docker-compose.yml`
