#!/bin/bash
# GCP e2-micro VM Startup Script
# This runs when the VM starts for the first time

set -e

# === System Updates ===
apt-get update
apt-get upgrade -y

# === Install Docker ===
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# === Install Node.js (for non-Docker deployments) ===
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# === Install PM2 ===
npm install -g pm2

# === Create swap file (important for 1GB RAM) ===
if [ ! -f /swapfile ]; then
    fallocate -l 1G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
fi

# === Set swappiness ===
sysctl vm.swappiness=10
echo 'vm.swappiness=10' >> /etc/sysctl.conf

# === Create app directories ===
mkdir -p /app
mkdir -p /var/log/atlasvs
chown -R 1001:1001 /var/log/atlasvs

# === Install nginx for reverse proxy ===
apt-get install -y nginx

# Configure nginx
cat > /etc/nginx/sites-available/atlasvs << 'EOF'
server {
    listen 80;
    server_name _;
    
    # Gzip compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml text/javascript;
    gzip_min_length 1000;
    
    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    
    # Rate limiting
    limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
        
        # Timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
    
    # API rate limiting
    location /api/ {
        limit_req zone=api burst=20 nodelay;
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    
    # Health check endpoint (no rate limit)
    location /api/health {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
    }
}
EOF

ln -sf /etc/nginx/sites-available/atlasvs /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
nginx -t && systemctl restart nginx

# === Setup firewall ===
apt-get install -y ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow http
ufw allow https
ufw --force enable

# === Setup automatic security updates ===
apt-get install -y unattended-upgrades
dpkg-reconfigure -plow unattended-upgrades

# === Log rotation ===
cat > /etc/logrotate.d/atlasvs << 'EOF'
/var/log/atlasvs/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    copytruncate
}
EOF

echo "=== Startup script completed ==="
echo "Next steps:"
echo "1. Clone your app to /app"
echo "2. Create /app/.env with production values"
echo "3. Run: cd /app && npm install && npm run build"
echo "4. Run: pm2 start ecosystem.config.js"
echo "5. Run: pm2 save && pm2 startup"
