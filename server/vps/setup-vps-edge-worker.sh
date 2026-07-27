#!/bin/bash

# VPS Edge Worker Setup Script
# This script sets up the Reservatior Edge Worker on VPS

set -e

echo "🚀 Reservatior VPS Edge Worker Setup"
echo "===================================="

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root or with sudo"
    exit 1
fi

# Create reservatior user
echo "Creating reservatior user..."
if id "reservatior" &>/dev/null; then
    echo "User reservatior already exists"
else
    useradd -m -s /bin/bash reservatior
    echo "User reservatior created"
fi

# Install dependencies
echo "Installing dependencies..."
apt-get update
apt-get install -y postgresql-client curl git

# Install Bun
echo "Installing Bun..."
if ! command -v bun &> /dev/null; then
    curl -fsSL https://bun.sh/install | bash
    export PATH="$HOME/.bun/bin:$PATH"
    echo "Bun installed"
else
    echo "Bun already installed"
fi

# Create application directory
echo "Creating application directory..."
mkdir -p /home/reservatior/reservatior-server
chown -R reservatior:reservatior /home/reservatior/reservatior-server

# Copy systemd service file
echo "Installing systemd service..."
cp reservatior-edge.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable reservatior-edge.service

# Create logs directory
echo "Creating logs directory..."
mkdir -p /home/reservatior/reservatior-server/logs
mkdir -p /home/reservatior/reservatior-server/tmp
chown -R reservatior:reservatior /home/reservatior/reservatior-server/logs
chown -R reservatior:reservatior /home/reservatior/reservatior-server/tmp

echo ""
echo "✅ VPS Edge Worker setup completed!"
echo ""
echo "Next steps:"
echo "1. Deploy application to /home/reservatior/reservatior-server"
echo "2. Update environment variables in /etc/systemd/system/reservatior-edge.service"
echo "3. Run: systemctl start reservatior-edge"
echo "4. Run: systemctl status reservatior-edge"
echo "5. Run: journalctl -u reservatior-edge -f (to view logs)"
