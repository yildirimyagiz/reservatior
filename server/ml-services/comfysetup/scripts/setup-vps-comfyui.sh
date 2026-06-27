#!/bin/bash

# VPS ComfyUI Setup Script
# This script sets up ComfyUI on Hostinger VPS (72.62.163.166)

VPS_HOST="72.62.163.166"
VPS_USER="root"
VPS_PASSWORD="KelAlaka@9182"

echo "🚀 VPS ComfyUI Setup"
echo "===================="
echo "Target: $VPS_USER@$VPS_HOST"
echo ""

# Check if sshpass is installed
if ! command -v sshpass &> /dev/null; then
    echo "❌ sshpass not found. Installing..."
    brew install sshpass || sudo apt-get install sshpass
fi

echo "✅ Setting up ComfyUI on VPS..."

# Execute remote setup
sshpass -p "$VPS_PASSWORD" ssh -o StrictHostKeyChecking=no $VPS_USER@$VPS_HOST << 'ENDSSH'
    echo "=== Installing ComfyUI on VPS ==="
    
    # Check if already installed
    if [ -d "/opt/ComfyUI" ]; then
        echo "✅ ComfyUI already installed at /opt/ComfyUI"
    else
        echo "📦 Cloning ComfyUI..."
        cd /opt
        git clone https://github.com/comfyanonymous/ComfyUI.git
        cd ComfyUI
        
        echo "🐍 Setting up Python virtual environment..."
        python3 -m venv venv
        source venv/bin/activate
        
        echo "📦 Installing dependencies..."
        pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
        pip install -r requirements.txt
        
        echo "🔌 Installing ComfyUI Manager..."
        git clone https://github.com/ltdrdata/ComfyUI-Manager custom_nodes/ComfyUI-Manager
    fi
    
    # Create systemd service
    echo "⚙️  Creating systemd service..."
    cat > /etc/systemd/system/comfyui.service << 'EOF'
[Unit]
Description=ComfyUI Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/ComfyUI
Environment="PATH=/opt/ComfyUI/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ExecStart=/opt/ComfyUI/venv/bin/python main.py --listen 0.0.0.0 --port 8188 --cpu
Restart=always
RestartSec=10
StandardOutput=append:/var/log/comfyui.log
StandardError=append:/var/log/comfyui.log

[Install]
WantedBy=multi-user.target
EOF
    
    # Enable and start service
    systemctl daemon-reload
    systemctl enable comfyui.service
    systemctl restart comfyui.service
    
    echo "✅ ComfyUI service started!"
    sleep 3
    systemctl status comfyui.service --no-pager
    
ENDSSH

echo ""
echo "✅ VPS ComfyUI Setup Complete!"
echo ""
echo "🌐 Access ComfyUI at: http://$VPS_HOST:8188"
echo "📊 Check status: systemctl status comfyui.service"
echo "📝 View logs: tail -f /var/log/comfyui.log"
echo ""
echo "🔗 AtlasVS Integration:"
echo "   Add to .env: VPS_COMFY_HOST=$VPS_HOST:8188"
