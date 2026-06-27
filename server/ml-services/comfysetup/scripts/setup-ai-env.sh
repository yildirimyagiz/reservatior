#!/bin/bash

# Configuration
RUNPOD_HOST="ssh.runpod.io"
RUNPOD_PORT="22"
RUNPOD_USER="v3peju2d7q05xy-64411853"
SSH_KEY="~/.ssh/id_runpod_ed25519"
REMOTE_DIR="/workspace"

echo "🛠️  Installing AI Dependencies on RunPod..."

ssh -tt -p $RUNPOD_PORT -i $SSH_KEY -o StrictHostKeyChecking=no $RUNPOD_USER@$RUNPOD_HOST << EOF
  cd $REMOTE_DIR
  
  # 1. ComfyUI Dependencies
  echo "📦 Installing ComfyUI requirements..."
  cd ComfyUI
  pip install -r requirements.txt
  cd ..

  # 2. Stable Diffusion WebUI Dependencies
  # We'll run a 'dry run' of launch.py to trigger install commands without starting the server
  echo "📦 Installing SD WebUI requirements..."
  cd stable-diffusion-webui
  
  # Install basics manually to save time/errors
  pip install -r requirements_versions.txt
  
  # This triggers the automatic installer logic (venv, repositories, etc.)
  # We use --exit to stop after install (if supported) or we just timeout
  # Actually, let's just install the core requirements. The launch script handles the rest on start.
  
  echo "✅ Dependencies Installed."
  exit
EOF

echo "🎉 AI Environment Setup Complete."
