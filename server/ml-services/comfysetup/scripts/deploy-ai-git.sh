#!/bin/bash

# Configuration
RUNPOD_HOST="ssh.runpod.io"
RUNPOD_PORT="22"
RUNPOD_USER="v3peju2d7q05xy-64411853"
SSH_KEY="~/.ssh/id_runpod_ed25519"
REMOTE_DIR="/workspace"

echo "🚀 Deploying AI Apps (Git Clone + Config Sync)..."

# 1. Remote Git Clones
echo "📥 Cloning repositories on RunPod..."
ssh -tt -p $RUNPOD_PORT -i $SSH_KEY -o StrictHostKeyChecking=no $RUNPOD_USER@$RUNPOD_HOST << EOF
  cd $REMOTE_DIR
  
  # Stable Diffusion WebUI (leeseomin fork as requested)
  if [ ! -d "stable-diffusion-webui" ]; then
    echo "Cloning SD WebUI..."
    git clone https://github.com/leeseomin/stable-diffusion-webui-1.5 stable-diffusion-webui
  else
    echo "SD WebUI already exists."
  fi

  # ComfyUI (Standard)
  if [ ! -d "ComfyUI" ]; then
    echo "Cloning ComfyUI..."
    git clone https://github.com/comfyanonymous/ComfyUI
  else
    echo "ComfyUI already exists."
  fi
  exit
EOF

# 2. Sync Local Configs (Overlay)
echo "⚙️  Syncing Local Configurations..."

# SD WebUI Configs
scp -P $RUNPOD_PORT -i $SSH_KEY -o StrictHostKeyChecking=no \
  /Users/yldyagz/testtool/stable-diffusion-webui/config.json \
  /Users/yldyagz/testtool/stable-diffusion-webui/ui-config.json \
  /Users/yldyagz/testtool/stable-diffusion-webui/webui-user.sh \
  $RUNPOD_USER@$RUNPOD_HOST:$REMOTE_DIR/stable-diffusion-webui/ 2>/dev/null || echo "Some SD configs not found, skipping."

# ComfyUI Configs (if any custom ones exist, e.g. extra_model_paths.yaml)
# Add specific ComfyUI config syncs here if needed

echo "✅ AI Backend Deployed (Hybrid Mode)."
