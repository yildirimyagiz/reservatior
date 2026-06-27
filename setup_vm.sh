#!/bin/bash
set -e

echo "Updating packages..."
sudo apt-get update -y
sudo apt-get install -y curl git build-essential unzip

echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing PM2..."
sudo npm install -g pm2

echo "Installing Bun..."
curl -fsSL https://bun.sh/install | bash

# Ensure bun is in PATH for non-interactive shells
echo 'export PATH="$HOME/.bun/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.bun/bin:$PATH"

echo "Installation complete. Checking versions:"
node -v
npm -v
pm2 -v
bun -v
