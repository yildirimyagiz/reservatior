#!/bin/bash
# ── OWASP ZAP Penetration Test — Reservatior ──────────────────────────────
# Runs automated DAST scanning against the target URL.
# Schedule: 0 5 * * 0 /opt/reservatior/scripts/security/zap-scan.sh
# ───────────────────────────────────────────────────────────────────────────

set -euo pipefail

TARGET="${TARGET_URL:-https://reservatior.com}"
REPORT_DIR="${REPORT_DIR:-/var/log/zap}"
DATE="$(date +%Y%m%d)"
mkdir -p "$REPORT_DIR"

echo "📦 Pulling OWASP ZAP Docker image..."
docker pull ghcr.io/zaproxy/zaproxy:stable 2>/dev/null || true

echo "🔍 Running ZAP baseline scan against $TARGET ..."
docker run --rm \
  -v "$REPORT_DIR:/zap/wrk" \
  ghcr.io/zaproxy/zaproxy:stable \
  zap-baseline.py \
  -t "$TARGET" \
  -g /zap/wrap/gen.conf \
  -r "zap-report_${DATE}.html" \
  -w "zap-alerts_${DATE}.md" \
  -x "zap-report_${DATE}.xml" \
  -I \
  -a | tee "$REPORT_DIR/zap-output_${DATE}.log"

echo ""
echo "📊 Summary of findings:"
python3 -c "
import json, os, re
report_dir = '$REPORT_DIR'
date = '$DATE'
logfile = os.path.join(report_dir, f'zap-output_{date}.log')
if os.path.exists(logfile):
    with open(logfile) as f:
        content = f.read()
    # Extract alert counts
    for line in content.split('\n'):
        if 'PASS' in line or 'FAIL' in line or 'WARN' in line:
            print(f'  {line.strip()}')
else:
    print('  (no scan log)')
" 2>/dev/null || true

echo ""
echo "✅ ZAP scan complete. Reports: $REPORT_DIR"
echo "  HTML:  zap-report_${DATE}.html"
echo "  Alerts: zap-alerts_${DATE}.md"
