#!/bin/bash
# ── ModSecurity + OWASP CRS Setup — Reservatior ────────────────────────────
# Run on the VPS / production server (requires nginx compiled with ModSecurity).
# ───────────────────────────────────────────────────────────────────────────

set -euo pipefail

echo "📦 Installing ModSecurity for Nginx..."
apt-get update -qq
apt-get install -y -qq libmodsecurity3 modsecurity-crs nginx-module-modsecurity 2>/dev/null || {
  echo "⚠️  Package not found. Building from source..."
  apt-get install -y -qq build-essential libpcre3-dev libxml2-dev libcurl4-openssl-dev git
  git clone --depth 1 https://github.com/SpiderLabs/ModSecurity /tmp/modsecurity
  cd /tmp/modsecurity
  ./build.sh && ./configure && make && make install
}

echo "🔧 Configuring OWASP CRS..."
mkdir -p /etc/nginx/modsec
cat > /etc/nginx/modsec/modsecurity.conf << 'MODSEC'
# ── ModSecurity Core Rules — Reservatior ───────────────────────────────────
SecRuleEngine On
SecRequestBodyAccess On
SecResponseBodyAccess Off
SecRequestBodyLimit 10485760
SecRequestBodyNoFilesLimit 131072
SecResponseBodyLimit 1048576

# ── Rule Engine ────────────────────────────────────────────────────────────
SecDefaultAction "phase:1,deny,log,status:406,auditlog"
SecDefaultAction "phase:2,deny,log,status:406,auditlog"

# ── OWASP CRS Configuration ───────────────────────────────────────────────
Include /usr/share/modsecurity-crs/crs-setup.conf
Include /usr/share/modsecurity-crs/rules/*.conf

# ── Custom rules ───────────────────────────────────────────────────────────
# Block SQL injection patterns
SecRule REQUEST_COOKIES|REQUEST_COOKIES_NAMES|REQUEST_HEADERS|ARGS_NAMES|ARGS|XML:/* \
  "@rx (?i:(union.*select|select.*from|insert.*into|drop\s+table|delete\s+from|update.*set))" \
  "id:1000,phase:2,deny,status:403,msg:'SQL Injection blocked'"

# Block path traversal
SecRule REQUEST_URI|ARGS "@rx \.\./" \
  "id:1001,phase:1,deny,status:403,msg:'Path Traversal blocked'"

# Block common scanners
SecRule REQUEST_HEADERS:User-Agent "@rx (nikto|fimap|wikto|w3af|acunetix|nessus|openvas|burp|zap|sqlmap)" \
  "id:1002,phase:1,deny,status:403,msg:'Scanner detected'"
MODSEC

echo "✅ ModSecurity configured. Reload nginx: sudo nginx -s reload"
echo ""
echo "📝 Logs: /var/log/modsec_audit.log"
echo "📝 Test: curl -s \"http://localhost/?id=1' OR '1'='1\""
