#!/bin/bash

# Load configuration
if [ -f "runpod.config" ]; then
    source runpod.config
else
    echo "Error: runpod.config not found. Please create it with RUNPOD_HOST, RUNPOD_PORT, etc."
    exit 1
fi

echo "🔌 Establishing secure tunnel to RunPod GPU..."
echo "   Target: $RUNPOD_USER@$RUNPOD_HOST:$RUNPOD_PORT"
echo "   Tunnel: localhost:8188 -> remote:8188 (ComfyUI)"

# Start SSH tunnel
# -N: Do not execute a remote command (just forward ports)
# -L: Local port forwarding (8188:127.0.0.1:8188) for ComfyUI
# -L: Local port forwarding (7860:127.0.0.1:7860) for SD WebUI
# -i: Identity file
ssh -f -N -L 8188:127.0.0.1:8188 -L 7860:127.0.0.1:7860 $RUNPOD_USER@$RUNPOD_HOST -p $RUNPOD_PORT -i $SSH_KEY_PATH


if [ $? -eq 0 ]; then
    echo "✅ Tunnel established! You can now access the remote interfaces."
    echo "   App URL: http://localhost:3000"
    echo "   ComfyUI: http://localhost:8188"
    echo "   SD WebUI: http://localhost:7860"
else
    echo "❌ Failed to establish tunnel. Please check your SSH keys and connection details."
fi
