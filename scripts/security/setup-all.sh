#!/bin/bash
# ── Complete Security Hardening — Reservatior ──────────────────────────────
# Run this on the production VPS after initial deployment.
# ───────────────────────────────────────────────────────────────────────────

set -euo pipefail

echo "========================================"
echo "  🔐 Reservatior Security Hardening"
echo "========================================"
echo ""

SCRIPTS_DIR="$(dirname "$0")"

# Step 1: Fail2Ban
echo "📌 [1/6] Installing Fail2Ban..."
bash "$SCRIPTS_DIR/setup-fail2ban.sh"

# Step 2: SSL
echo ""
echo "📌 [2/6] Setting up Let's Encrypt SSL..."
if [ ! -f "/etc/letsencrypt/live/reservatior.com/fullchain.pem" ]; then
  echo "  Run: sudo bash ssl/setup.sh --host reservatior.com atlasvs.cloud"
  echo "  (skipping for now)"
else
  echo "  ✅ SSL certs found"
fi

# Step 3: Firewall
echo ""
echo "📌 [3/6] Configuring UFW firewall..."
ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 22/tcp
ufw --force enable
echo "  ✅ UFW active"

# Step 4: Automatic security updates
echo ""
echo "📌 [4/6] Enabling automatic security updates..."
apt-get install -y -qq unattended-upgrades
cat > /etc/apt/apt.conf.d/20auto-upgrades << 'UFW'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
UFW
echo "  ✅ Auto-updates enabled"

# Step 5: Harden SSH
echo ""
echo "📌 [5/6] Hardening SSH..."
if [ -f /etc/ssh/sshd_config ]; then
  sed -i 's/^#*PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
  sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
  sed -i 's/^#*MaxAuthTries.*/MaxAuthTries 3/' /etc/ssh/sshd_config
  sed -i 's/^#*ClientAliveInterval.*/ClientAliveInterval 300/' /etc/ssh/sshd_config
  sed -i 's/^#*ClientAliveCountMax.*/ClientAliveCountMax 2/' /etc/ssh/sshd_config
  systemctl reload sshd
  echo "  ✅ SSH hardened"
fi

# Step 6: Kernel hardening (sysctl)
echo ""
echo "📌 [6/6] Applying kernel hardening..."
cat > /etc/sysctl.d/99-security.conf << 'SYSCTL'
# IP Spoofing protection
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1

# Ignore ICMP redirects
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0

# Ignore source-routed packets
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_source_route = 0

# SYN flood protection
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_syn_retries = 5
net.ipv4.tcp_synack_retries = 2

# Disable ICMP protocol
net.ipv4.icmp_echo_ignore_all = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1

# Ignore bogus ICMP errors
net.ipv4.icmp_ignore_bogus_error_responses = 1

# Increase backlog
net.core.somaxconn = 65535
net.ipv4.tcp_max_syn_backlog = 65535

# Reduce time-wait
net.ipv4.tcp_fin_timeout = 15
SYSCTL
sysctl -p /etc/sysctl.d/99-security.conf
echo "  ✅ Kernel hardened"

echo ""
echo "========================================"
echo "  ✅ Security hardening complete!"
echo "========================================"
echo ""
echo "📋 Post-setup checklist:"
echo "  □ Run: ssl/setup.sh --host"
echo "  □ Run: scripts/security/clean-secrets.sh"
echo "  □ Add REDIS_URL to .env for persistent rate limiting"
echo "  □ Configure Cloudflare DNS (proxy mode)"
echo "  □ Run: scripts/security/trivy-scan.sh"
echo "  □ Run: scripts/security/zap-scan.sh"
echo "  □ Set up monitoring: htop, journalctl"
