#!/bin/bash

# Configuration
RUNPOD_HOST="ssh.runpod.io"
RUNPOD_PORT="22"
RUNPOD_USER="v3peju2d7q05xy-64411853"
SSH_KEY="~/.ssh/id_runpod_ed25519"
REMOTE_DIR="/workspace"

echo "📦 Packaging AI Apps (Tar+SCP strategy)..."

# 1. Compress Utils
# Excluding venv and large hidden folders to save time
tar --exclude='venv' --exclude='__pycache__' --exclude='.git' -czf comfy.tar.gz -C /Users/yldyagz/testtool ComfyUI
tar --exclude='venv' --exclude='__pycache__' --exclude='.git' -czf sdwebui.tar.gz -C /Users/yldyagz/testtool stable-diffusion-webui

# 2. Upload
echo "🚀 Uploading Tarballs..."
scp -P $RUNPOD_PORT -i $SSH_KEY -o StrictHostKeyChecking=no comfy.tar.gz sdwebui.tar.gz $RUNPOD_USER@$RUNPOD_HOST:$REMOTE_DIR/

# 3. Extract & Clean
echo "📂 Extracting on Remote..."
ssh -tt -p $RUNPOD_PORT -i $SSH_KEY -o StrictHostKeyChecking=no $RUNPOD_USER@$RUNPOD_HOST << EOF
  cd $REMOTE_DIR
  tar -xzf comfy.tar.gz
  tar -xzf sdwebui.tar.gz
  rm comfy.tar.gz sdwebui.tar.gz
  ls -la
  exit
EOF

# 4. Cleanup Local
rm comfy.tar.gz sdwebui.tar.gz

echo "✅ AI Backend Deployed Successfully!"
