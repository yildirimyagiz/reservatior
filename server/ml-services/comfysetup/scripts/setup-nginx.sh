#!/bin/bash
VPS_HOST="72.62.163.166"
VPS_USER="root"
SSH_KEY="~/.ssh/id_runpod_ed25519"
EMAIL="yagizyildirim@icloud.com"

echo "🌐 Setting up Nginx & SSL for atlasvs.cloud..."

# 1. Upload Nginx Config
echo "Ep Uploading Nginx config..."
scp -i $SSH_KEY nginx-atlasvs.conf $VPS_USER@$VPS_HOST:/tmp/atlasvs.conf

# 2. Remote Setup
echo "🔧 Installing Nginx & Certbot..."
ssh -i $SSH_KEY $VPS_USER@$VPS_HOST << EOF
  # Install dependencies
  apt-get update
  apt-get install -y nginx certbot python3-certbot-nginx

  # Configure Nginx
  mv /tmp/atlasvs.conf /etc/nginx/sites-available/atlasvs
  ln -sf /etc/nginx/sites-available/atlasvs /etc/nginx/sites-enabled/
  rm -f /etc/nginx/sites-enabled/default
  
  # Check and Verify
  nginx -t && systemctl reload nginx

  # Request SSL Cert
  echo "🔒 Requesting SSL Certificate..."
  certbot --nginx -d atlasvs.cloud -d www.atlasvs.cloud --non-interactive --agree-tos -m $EMAIL --redirect
EOF

echo "✅ Nginx & SSL Setup Complete! https://atlasvs.cloud"
