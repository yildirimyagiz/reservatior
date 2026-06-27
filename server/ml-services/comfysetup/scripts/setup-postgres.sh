#!/bin/bash
VPS_HOST="72.62.163.166"
VPS_USER="root"
SSH_KEY="~/.ssh/id_runpod_ed25519"

echo "🐘 Configuring PostgreSQL 16 for Docker access..."

ssh -i $SSH_KEY $VPS_USER@$VPS_HOST << EOF
  # 1. Update postgresql.conf to listen on all interfaces
  # Change '#listen_addresses = ...' or 'listen_addresses = ...' to '*'
  sed -i "s/^#\?listen_addresses.*/listen_addresses = '*'/" /etc/postgresql/16/main/postgresql.conf

  # 2. Update pg_hba.conf to allow Docker subnet
  # Check if rule exists before adding to avoid duplicates
  if ! grep -q "172.17.0.0/16" /etc/postgresql/16/main/pg_hba.conf; then
      echo "host    all             all             172.17.0.0/16           scram-sha-256" >> /etc/postgresql/16/main/pg_hba.conf
      echo "✅ Added Docker subnet to pg_hba.conf"
  else
      echo "ℹ️  Docker subnet rule already exists in pg_hba.conf"
  fi

  # 3. Restart PostgreSQL
  systemctl restart postgresql

  echo "✅ PostgreSQL configured and restarted."
EOF
