#!/bin/bash

# Function to check if a port is in use
check_port() {
    lsof -i :$1 >/dev/null 2>&1
}

echo "🚀 Starting AI Services..."

# 1. Start Stable Diffusion WebUI (Port 7860)
if check_port 7860; then
    echo "✅ SD WebUI already running on port 7860"
else
    echo "⏳ Starting SD WebUI..."
    cd /Users/yldyagz/apps/stagingapps/atlasvsmain/stable-diffusion-webui
    # Using nohup to keep it running in background
    nohup ./webui.sh --api --nowebui --listen > ../atlasvs/sd-webui.log 2>&1 &
    echo "   (Logs: sd-webui.log)"
fi

# 2. Start ComfyUI (Port 8188)
if check_port 8188; then
    echo "✅ ComfyUI already running on port 8188"
else
    echo "⏳ Starting ComfyUI..."
    cd /Users/yldyagz/apps/stagingapps/atlasvsmain/ComfyUI
    source venv/bin/activate
    nohup python main.py --listen --port 8188 > ../atlasvs/comfyui.log 2>&1 &
    echo "   (Logs: comfyui.log)"
fi

echo "✨ Services launching in background. Please wait ~30s for them to be ready."
