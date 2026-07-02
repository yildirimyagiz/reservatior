#!/bin/bash
# ── API Authentication Audit — Reservatior ─────────────────────────────────
# Scans all route files for auth middleware coverage.
# ───────────────────────────────────────────────────────────────────────────

set -euo pipefail

cd "$(git rev-parse --show-toplevel 2>/dev/null || echo '/opt/reservatior')"
SRC_DIR="server/src/routes"

echo "🔍 Scanning API routes for auth middleware coverage..."
echo ""

TOTAL=0
PROTECTED=0
UNPROTECTED=0

find "$SRC_DIR" -name "*.ts" -type f | while read -r file; do
  rel="${file#./}"
  routes=$(grep -c '\.\(get\|post\|put\|patch\|delete\|onReq\)' "$file" 2>/dev/null || true)
  auth_count=$(grep -c 'authMiddleware\|hasPermission\|hasAnyPermission\|bearer' "$file" 2>/dev/null || true)

  if [ "$routes" -gt 0 ]; then
    TOTAL=$((TOTAL + 1))
    if [ "$auth_count" -gt 0 ]; then
      PROTECTED=$((PROTECTED + 1))
      echo "  ✅ $rel ($routes routes, $auth_count auth refs)"
    else
      UNPROTECTED=$((UNPROTECTED + 1))
      echo "  ⚠️  $rel ($routes routes, NO auth middleware!)"
    fi
  fi
done

echo ""
echo "📊 Summary:"
echo "  Total route files:  $TOTAL"
echo "  Protected:          $PROTECTED"
echo "  Unprotected:        $UNPROTECTED"

if [ "$UNPROTECTED" -gt 0 ]; then
  echo ""
  echo "⚠️  WARNING: $UNPROTECTED route files lack auth middleware!"
  echo "   Review and add hasPermission() guards to these files."
  exit 1
fi

echo "✅ All route files have auth middleware."
