#!/bin/bash
# ── Fail2Ban Setup — Reservatior ───────────────────────────────────────────
# Run on the VPS / production server.
# ───────────────────────────────────────────────────────────────────────────

set -euo pipefail

echo "📦 Installing Fail2Ban..."
apt-get update -qq
apt-get install -y -qq fail2ban iptables

echo "🔧 Configuring Nginx jails..."
cp "$(dirname "$0")/fail2ban-nginx.conf" /etc/fail2ban/jail.d/reservatior.conf
cp "$(dirname "$0")/fail2ban-nginx-filter.conf" /etc/fail2ban/filter.d/nginx-auth.conf

echo "🚀 Starting Fail2Ban..."
systemctl enable fail2ban
systemctl restart fail2ban

echo "📊 Status:"
fail2ban-client status
fail2ban-client status nginx-auth 2>/dev/null || true

echo ""
echo "✅ Fail2Ban active. Banned IPs:"
fail2ban-client banned || true

echo ""
echo "📝 To check logs: sudo fail2ban-client status nginx-auth"
echo "📝 To unban: sudo fail2ban-client set nginx-auth unbanip <IP>"
