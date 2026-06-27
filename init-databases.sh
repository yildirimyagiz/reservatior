#!/bin/bash
# Multi-Country Database Initialization Script
# This script runs automatically when PostgreSQL container starts for the first time.
# It creates all regional databases needed by the Reservatior platform.

set -e

echo "🌍 Creating multi-country databases..."

DATABASES=(
  "realestate_us"
  "realestate_tr"
  "realestate_uk"
  "realestate_de"
  "realestate_fr"
  "realestate_es"
  "realestate_it"
  "realestate_nl"
  "realestate_ca"
  "realestate_mx"
  "realestate_br"
  "realestate_ar"
  "realestate_au"
  "realestate_nz"
  "realestate_jp"
  "realestate_kr"
  "realestate_cn"
  "realestate_in"
  "realestate_sg"
  "realestate_my"
  "realestate_th"
  "realestate_ae"
  "realestate_sa"
)

for db in "${DATABASES[@]}"; do
  echo "  📦 Creating database: $db"
  psql -v ON_ERROR_STOP=0 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    SELECT 'CREATE DATABASE $db' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$db')\gexec
EOSQL
done

echo "✅ All $${#DATABASES[@]} country databases created successfully!"
