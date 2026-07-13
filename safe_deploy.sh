#!/bin/bash
set -e
export SSHPASS="KelAlaka@9182"
# Sync server files
sshpass -e rsync -avz -e "ssh -o StrictHostKeyChecking=no" ./server/ root@72.61.71.6:/root/reservatior/server/ --exclude node_modules --exclude dist --exclude .env --exclude data --exclude logs --exclude .wwebjs_auth --exclude .wwebjs_cache --exclude .venv --exclude venv --exclude .git

# Sync client-seo files
echo "Syncing client-seo files..."
sshpass -e rsync -avz -e "ssh -o StrictHostKeyChecking=no" ./client-seo/ root@72.61.71.6:/root/reservatior/client-seo/ --exclude node_modules --exclude .next --exclude .git

# Sync shared files
echo "Syncing shared files..."
sshpass -e rsync -avz -e "ssh -o StrictHostKeyChecking=no" ./shared/ root@72.61.71.6:/root/reservatior/shared/ --exclude node_modules

# Build and restart containers on the server
echo "Building and recreating containers on the server..."
sshpass -e ssh -o StrictHostKeyChecking=no root@72.61.71.6 "cd /root/reservatior && docker compose build server web && docker compose up -d server web"
echo "Deployment successful!"
