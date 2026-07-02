#!/bin/bash
# ── Container Image Vulnerability Scan — Reservatior ───────────────────────
# Uses Trivy to scan all Docker images.
# Schedule: 0 6 * * 0 /opt/reservatior/scripts/security/trivy-scan.sh
# ───────────────────────────────────────────────────────────────────────────

set -euo pipefail

REPORT_DIR="${REPORT_DIR:-/var/log/trivy}"
mkdir -p "$REPORT_DIR"
DATE="$(date +%Y%m%d)"

echo "📦 Installing Trivy..."
if ! command -v trivy &>/dev/null; then
  apt-get install -y -qq wget apt-transport-https
  wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
  echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | \
    tee /etc/apt/sources.list.d/trivy.list
  apt-get update -qq && apt-get install -y -qq trivy
fi

echo "🔍 Scanning Docker images..."
IMAGES=("reservatior-server" "reservatior-client" "nginx:alpine" "postgres:15-alpine")

for IMAGE in "${IMAGES[@]}"; do
  echo "  Scanning $IMAGE ..."
  trivy image --severity CRITICAL,HIGH --exit-code 0 \
    --format json \
    --output "$REPORT_DIR/${IMAGE//\//_}_${DATE}.json" \
    "$IMAGE"
done

echo "📊 Generating summary..."
python3 -c "
import json, os, sys
report_dir = '$REPORT_DIR'
for f in sorted(os.listdir(report_dir)):
    if not f.endswith('.json'): continue
    with open(os.path.join(report_dir, f)) as fh:
        data = json.load(fh)
    results = data.get('Results', [])
    total = sum(len(r.get('Vulnerabilities', [])) for r in results)
    critical = sum(1 for r in results for v in r.get('Vulnerabilities', []) if v.get('Severity') == 'CRITICAL')
    high = sum(1 for r in results for v in r.get('Vulnerabilities', []) if v.get('Severity') == 'HIGH')
    print(f'  {f}: {total} vulns ({critical} critical, {high} high)')
" 2>/dev/null || echo "  (no reports)"

echo ""
echo "✅ Scan complete. Reports: $REPORT_DIR"
