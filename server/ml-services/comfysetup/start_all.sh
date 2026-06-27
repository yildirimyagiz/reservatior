#!/bin/bash

# Main Startup Script for AtlasVS Ecosystem
# This script opens a new Terminal window and launches all necessary services in separate tabs.

echo "🚀 Starting AtlasVS Ecosystem..."

# Paths
BASE_DIR="/Users/yldyagz/testtool"
BACKEND_DIR="$BASE_DIR/atlasvs/backend"
A1111_DIR="$BASE_DIR/stable-diffusion-webui"
COMFY_DIR="$BASE_DIR/ComfyUI"

# AppleScript to open tabs
osascript <<EOF
tell application "Terminal"
    activate
    
    -- Tab 1: AtlasVS Backend
    do script "cd $BACKEND_DIR && source venv/bin/activate && uvicorn app.main:app --reload --port 8000"
    
    -- Tab 2: Stable Diffusion WebUI (A1111)
    tell application "System Events" to keystroke "t" using command down
    delay 0.5
    do script "cd $A1111_DIR && ./webui.sh --api" in front window
    
    -- Tab 3: ComfyUI
    tell application "System Events" to keystroke "t" using command down
    delay 0.5
    do script "cd $COMFY_DIR && python main.py" in front window
    
end tell
EOF

echo "✅ All services launched in new Terminal tabs!"
echo "   - Backend: http://localhost:8000"
echo "   - A1111:   http://localhost:7860"
echo "   - ComfyUI: http://localhost:8188"
