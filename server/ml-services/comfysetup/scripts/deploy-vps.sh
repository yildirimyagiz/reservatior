#!/bin/bash

# Configuration
VPS_USER="root"
VPS_HOST="72.62.163.166"
SSH_KEY="~/.ssh/id_runpod_ed25519"
REMOTE_DIR="/var/www/atlasvs"

echo "🚀 Deploying AtlasVS to VPS ($VPS_HOST)..."

# 1. Prepare Remote Directory
echo "📂 Cleaning remote directory..."
ssh -i $SSH_KEY $VPS_USER@$VPS_HOST "mkdir -p $REMOTE_DIR"

# 2. Upload Source Code (excluding heavy folders)
echo "Ep Uploading source code..."
rsync -avz --exclude 'node_modules' --exclude '.next' --exclude '.git' --exclude '.env' -e "ssh -i $SSH_KEY" . $VPS_USER@$VPS_HOST:$REMOTE_DIR

# 3. Create .env file on remote
echo "🔐 Configuring environment..."
# Note: We should populate this with actual secrets later
ssh -i $SSH_KEY $VPS_USER@$VPS_HOST "echo 'NEXT_PUBLIC_API_URL=http://localhost:3000' > $REMOTE_DIR/.env.local"

# 4. Install & Build
echo "📦 Installing dependencies and building (Remote)..."
ssh -i $SSH_KEY $VPS_USER@$VPS_HOST "cd $REMOTE_DIR && npm install && npm run build"

# 5. Start with PM2
echo "🔥 Starting application with PM2..."
ssh -i $SSH_KEY $VPS_USER@$VPS_HOST "cd $REMOTE_DIR && npm install -g pm2 && pm2 delete atlasvs 2>/dev/null || true && pm2 start npm --name 'atlasvs' -- start"

echo "✅ Deployment Complete! Visit http://$VPS_HOST:3000"
