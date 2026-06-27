#!/bin/bash
# Reservatior Bidirectional Sync & Database Migration Script
# Automates the transfer of local PostgreSQL databases and code to the remote server.
#
# Usage: bash sync.sh

set -e

# ─── Configuration ─────────────────────────────────────────────
LOCAL_PG_DUMP="/opt/homebrew/opt/postgresql@15/bin/pg_dump"
LOCAL_USER="postgres"
LOCAL_PASS="1928"
LOCAL_HOST="localhost"

REMOTE_HOST="root@72.61.71.6"
REMOTE_PASS="KelAlaka@9182"
REMOTE_CONTAINER="server-postgres-1"
REMOTE_USER="elysia"

# Databases to migrate (matching all supported regions)
DATABASES=(
  "realestate_us"
  "realestate_tr"
  "realestate_ae"
  "realestate_sg"
  "realestate_ca"
  "realestate_mx"
  "realestate_br"
  "realestate_ar"
  "realestate_nz"
  "realestate_jp"
  "realestate_kr"
  "realestate_cn"
  "realestate_in"
  "realestate_my"
  "realestate_sa"
  "realestate_de"
  "realestate_es"
  "realestate_fr"
  "realestate_it"
  "realestate_nl"
  "realestate_au"
  "realestate_uk"
)

export SSHPASS="$REMOTE_PASS"

echo "🚀 Starting Reservatior Sync & Database Migration..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Target Remote: $REMOTE_HOST"
echo "  Docker Database Container: $REMOTE_CONTAINER"
echo ""

# 1. Create databases remotely if they do not exist
echo "📦 [1/5] Creating regional databases on remote server..."
for db in "${DATABASES[@]}"; do
  echo "  Checking/Creating database: $db"
  # Attempt database creation, ignore error if already exists
  sshpass -e ssh -o StrictHostKeyChecking=no "$REMOTE_HOST" \
    "docker exec -i $REMOTE_CONTAINER psql -U $REMOTE_USER -d postgres -c \"CREATE DATABASE $db;\"" 2>/dev/null || true
done
echo "✅ Remote databases prepared."
echo ""

# 2. Dump and restore each local database to remote
echo "📦 [2/5] Migrating database contents (local → remote)..."
for db in "${DATABASES[@]}"; do
  echo "  Transferring: $db..."
  if PGPASSWORD="$LOCAL_PASS" "$LOCAL_PG_DUMP" -U "$LOCAL_USER" -h "$LOCAL_HOST" --clean --no-owner --no-acl "$db" 2>/dev/null | \
     sshpass -e ssh -o StrictHostKeyChecking=no "$REMOTE_HOST" "docker exec -i $REMOTE_CONTAINER psql -U $REMOTE_USER -d $db" >/dev/null 2>&1; then
    echo "    ✅ $db transferred successfully"
  else
    echo "    ⚠️ $db skip or transfer failed (check if database exists locally)"
  fi
done
echo "✅ Database migration complete."
echo ""

# 3. Synchronize codebase (rsync)
echo "🔄 [3/5] Syncing server & client codebase..."
echo "  Syncing server files..."
sshpass -e rsync -avz -e "ssh -o StrictHostKeyChecking=no" \
  ./server/ "$REMOTE_HOST":/root/reservatior/server/ \
  --exclude node_modules --exclude dist --exclude .env --exclude data --exclude logs

echo "  Syncing client files..."
sshpass -e rsync -avz -e "ssh -o StrictHostKeyChecking=no" \
  ./client/ "$REMOTE_HOST":/root/reservatior/client/ \
  --exclude node_modules --exclude dist --exclude .env

# Sync root packages and configurations
sshpass -e rsync -avz -e "ssh -o StrictHostKeyChecking=no" \
  ./package.json ./tsconfig.json "$REMOTE_HOST":/root/reservatior/
echo "✅ Code sync complete."
echo ""

# 4. Write updated docker-compose.yml configuration
echo "⚙️ [4/5] Deploying updated remote docker-compose.yml..."
sshpass -e ssh -o StrictHostKeyChecking=no "$REMOTE_HOST" "cat << 'EOF' > /root/reservatior/docker-compose.yml
version: '3.8'

services:
  server:
    build:
      context: ./server
      dockerfile: Dockerfile
    ports:
      - \"8082:3000\"
    env_file:
      - .env
    environment:
      - DATABASE_URL=postgresql://elysia:elysia_pass@postgres:5432/realestate_us
      - DATABASE_URL_AE=postgresql://elysia:elysia_pass@postgres:5432/realestate_ae
      - DATABASE_URL_AR=postgresql://elysia:elysia_pass@postgres:5432/realestate_ar
      - DATABASE_URL_AU=postgresql://elysia:elysia_pass@postgres:5432/realestate_au
      - DATABASE_URL_BR=postgresql://elysia:elysia_pass@postgres:5432/realestate_br
      - DATABASE_URL_CA=postgresql://elysia:elysia_pass@postgres:5432/realestate_ca
      - DATABASE_URL_CN=postgresql://elysia:elysia_pass@postgres:5432/realestate_cn
      - DATABASE_URL_DE=postgresql://elysia:elysia_pass@postgres:5432/realestate_de
      - DATABASE_URL_ES=postgresql://elysia:elysia_pass@postgres:5432/realestate_es
      - DATABASE_URL_FR=postgresql://elysia:elysia_pass@postgres:5432/realestate_fr
      - DATABASE_URL_IN=postgresql://elysia:elysia_pass@postgres:5432/realestate_in
      - DATABASE_URL_IT=postgresql://elysia:elysia_pass@postgres:5432/realestate_it
      - DATABASE_URL_JP=postgresql://elysia:elysia_pass@postgres:5432/realestate_jp
      - DATABASE_URL_KR=postgresql://elysia:elysia_pass@postgres:5432/realestate_kr
      - DATABASE_URL_MX=postgresql://elysia:elysia_pass@postgres:5432/realestate_mx
      - DATABASE_URL_MY=postgresql://elysia:elysia_pass@postgres:5432/realestate_my
      - DATABASE_URL_NL=postgresql://elysia:elysia_pass@postgres:5432/realestate_nl
      - DATABASE_URL_NZ=postgresql://elysia:elysia_pass@postgres:5432/realestate_nz
      - DATABASE_URL_SA=postgresql://elysia:elysia_pass@postgres:5432/realestate_sa
      - DATABASE_URL_SG=postgresql://elysia:elysia_pass@postgres:5432/realestate_sg
      - DATABASE_URL_TH=postgresql://elysia:elysia_pass@postgres:5432/realestate_th
      - DATABASE_URL_TR=postgresql://elysia:elysia_pass@postgres:5432/realestate_tr
      - DATABASE_URL_UK=postgresql://elysia:elysia_pass@postgres:5432/realestate_uk
      - DATABASE_URL_US=postgresql://elysia:elysia_pass@postgres:5432/realestate_us
      - APP_URL=https://reservatior.com
      - CLIENT_URL=https://reservatior.com
    volumes:
      - ./server/data:/app/data
    networks:
      - server_elysia-net
    restart: unless-stopped

  client:
    build:
      context: .
      dockerfile: Dockerfile.frontend
    ports:
      - \"8080:8080\"
    restart: unless-stopped
    networks:
      - server_elysia-net
    depends_on:
      - server
    healthcheck:
      test: [\"CMD-SHELL\", \"wget --no-verbose --tries=1 --spider http://127.0.0.1:8080/ || exit 1\"]
      interval: 30s
      timeout: 3s
      start_period: 5s
      retries: 3

networks:
  server_elysia-net:
    external: true
EOF"
echo "✅ Remote docker-compose.yml configuration updated."
echo ""

# 5. Restart containers to apply changes
echo "🔄 [5/5] Restarting docker containers on remote server..."
sshpass -e ssh -o StrictHostKeyChecking=no "$REMOTE_HOST" \
  "cd /root/reservatior && docker compose down && docker compose up -d --build"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🏁 Sync, Migration & Deployment Completed successfully!"
