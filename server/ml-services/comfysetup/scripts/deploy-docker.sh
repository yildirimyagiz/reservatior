#!/bin/bash

# Configuration
VPS_USER="root"
VPS_HOST="72.62.163.166"
PROJECT_DIR="/var/www/atlasvs-docker"
APP_NAME="atlasvs"
SSH_KEY="~/.ssh/id_runpod_ed25519"

echo "🐳 Deploying $APP_NAME to VPS ($VPS_HOST) with Docker..."

# 1. Prepare Remote Directory
echo "📂 Preparing remote directory..."
ssh -i $SSH_KEY $VPS_USER@$VPS_HOST "mkdir -p $PROJECT_DIR"

# 2. Upload Source Code
echo "Ep Uploading source code..."
rsync -avz --exclude 'node_modules' --exclude '.next' --exclude '.git' --exclude '.env' -e "ssh -i $SSH_KEY" . $VPS_USER@$VPS_HOST:$PROJECT_DIR

# 3. Create .env file on remote (if not exists or update it)
echo "🔐 Configuring environment..."
ssh -i $SSH_KEY $VPS_USER@$VPS_HOST "echo 'NEXT_PUBLIC_API_URL=http://$VPS_HOST:3001' > $PROJECT_DIR/.env.local && echo 'DATABASE_URL=postgresql://postgres:1928@172.17.0.1:5432/dbone85?schema=public' >> $PROJECT_DIR/.env.local"

# 4. Remote Docker Build & Run
echo "🏗️  Building and Starting Container..."
ssh -i $SSH_KEY $VPS_USER@$VPS_HOST "cd $PROJECT_DIR && \
  docker build -t $APP_NAME . && \
  docker stop $APP_NAME || true && \
  docker rm $APP_NAME || true && \
  docker run -d -p 3001:3000 --name $APP_NAME --restart unless-stopped $APP_NAME"

echo "✅ Deployment Complete! App running at http://$VPS_HOST:3001"
