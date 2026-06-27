#!/bin/bash
# Multi-Country Database Migration Script
# Transfers populated local databases to the remote VPS via SSH tunnel
#
# Usage: bash migrate-to-server.sh
# Prerequisites: PostgreSQL 15 installed locally, SSH access to VPS

set -e

# ── Configuration ─────────────────────────────────────────────
LOCAL_PG="/opt/homebrew/opt/postgresql@15/bin/pg_dump"
LOCAL_USER="postgres"
LOCAL_PASS="1928"
LOCAL_HOST="localhost"

REMOTE_HOST="root@72.62.163.166"
REMOTE_CONTAINER="reservatior-db-1"
REMOTE_USER="postgres"
REMOTE_PASS="postgres"

# Only databases with actual data (property count > 0)
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
)

echo "🚀 Multi-Country Database Migration"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Source: localhost → Target: $REMOTE_HOST"
echo "   Databases: ${#DATABASES[@]}"
echo ""

SUCCESS=0
FAIL=0

for db in "${DATABASES[@]}"; do
  echo "📦 [$((SUCCESS + FAIL + 1))/${#DATABASES[@]}] Migrating: $db"
  
  if PGPASSWORD="$LOCAL_PASS" $LOCAL_PG \
    -U "$LOCAL_USER" \
    -h "$LOCAL_HOST" \
    --no-owner \
    --no-acl \
    "$db" | \
    ssh "$REMOTE_HOST" "docker exec -i $REMOTE_CONTAINER env PGPASSWORD='$REMOTE_PASS' psql -U $REMOTE_USER -d $db" 2>/dev/null; then
    echo "   ✅ $db transferred successfully"
    SUCCESS=$((SUCCESS + 1))
  else
    echo "   ❌ $db transfer FAILED"
    FAIL=$((FAIL + 1))
  fi
  echo ""
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🏁 Migration Complete!"
echo "   ✅ Success: $SUCCESS / ${#DATABASES[@]}"
if [ $FAIL -gt 0 ]; then
  echo "   ❌ Failed:  $FAIL / ${#DATABASES[@]}"
fi
