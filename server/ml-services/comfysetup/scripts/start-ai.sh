#!/bin/bash

# Configuration
RUNPOD_HOST="ssh.runpod.io"
RUNPOD_PORT="22"
RUNPOD_USER="v3peju2d7q05xy-64411853"
SSH_KEY="~/.ssh/id_runpod_ed25519"
REMOTE_DIR="/workspace"

echo "🚀 Starting AI Services on RunPod..."

ssh -tt -p $RUNPOD_PORT -i $SSH_KEY -o StrictHostKeyChecking=no $RUNPOD_USER@$RUNPOD_HOST << EOF
  # 1. Start ComfyUI (Port 8188)
  cd $REMOTE_DIR/ComfyUI
  if pgrep -f "main.py" > /dev/null; then
    echo "⚠️  ComfyUI is already running."
  else
    echo "🟢 Starting ComfyUI..."
    nohup python main.py --listen 0.0.0.0 --port 8188 > comfy.log 2>&1 &
  fi

  # 2. Start Stable Diffusion WebUI (Port 7860)
  cd $REMOTE_DIR/stable-diffusion-webui
  if pgrep -f "launch.py" > /dev/null; then
    echo "⚠️  SD WebUI is already running."
  else
    echo "🟢 Starting SD WebUI..."
    # --api: Enable API access
    # --nowebui: Save resources (headless)
    # --listen: Allow remote connections
    nohup python launch.py --listen --port 7860 --api --nowebui > sd.log 2>&1 &
  fi

  # Allow a moment for startup
  sleep 2
  echo "📊 Checking active processes:"
  ps aux | grep python
  exit
EOF

echo "✅ Start commands sent."
echo "👉 Use 'scripts/connect-runpod.sh' to establish the tunnel and verify access."
