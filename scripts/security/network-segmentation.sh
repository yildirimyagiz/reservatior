#!/bin/bash
# ── Docker Network Segmentation — Reservatior ──────────────────────────────
# Creates isolated networks: frontend → API → DB (no direct DB access from frontend)
# ───────────────────────────────────────────────────────────────────────────

set -euo pipefail

echo "🔧 Creating isolated Docker networks..."

# Network for database (only server can reach it)
docker network create \
  --driver overlay \
  --attachable \
  --internal \
  reservatior-db-net 2>/dev/null || true

# Network for API (server + client can reach it)
docker network create \
  --driver overlay \
  --attachable \
  reservatior-api-net 2>/dev/null || true

# Network for frontend (reverse proxy + client)
docker network create \
  --driver overlay \
  --attachable \
  reservatior-frontend-net 2>/dev/null || true

echo ""
echo "✅ Networks created:"
docker network ls | grep reservatior

echo ""
echo "📝 After starting services, verify isolation:"
echo "  docker run --rm --network reservatior-db-net alpine ping postgres"
echo "    (should FAIL from frontend container)"
echo ""
echo "  docker run --rm --network reservatior-frontend-net alpine wget -qO- http://client:8080"
echo "    (should SUCCEED from reverse proxy)"
echo ""
echo "⚠️  Update docker-compose.yml to assign each service to its network."
echo "   Example:"
echo "     services:"
echo "       db:      networks: - reservatior-db-net"
echo "       server:  networks: - reservatior-db-net - reservatior-api-net"
echo "       client:  networks: - reservatior-api-net - reservatior-frontend-net"
echo "       nginx:   networks: - reservatior-frontend-net"
