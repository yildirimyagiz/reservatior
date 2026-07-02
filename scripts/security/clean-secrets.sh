#!/bin/bash
# ── Secrets removal from git history ───────────────────────────────────────
# WARNING: Rewrites git history. Coordinate with all team members first.
# ───────────────────────────────────────────────────────────────────────────

set -euo pipefail
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo '/opt/reservatior')"
cd "$REPO_ROOT"

echo "🔍 Checking for sensitive files in current tree..."
git ls-files --error-unmatch .env server/.env client/.env client-seo/.env mobile/.env 2>/dev/null && {
  echo "⚠️  .env files are tracked! Removing from index..."
  for f in .env server/.env client/.env client-seo/.env mobile/.env server/.env.example; do
    [ -f "$f" ] && git rm --cached "$f" 2>/dev/null || true
  done
  git commit -m "chore: stop tracking .env files (secrets rotation)" || true
}

echo ""
echo "🧹 To rewrite history and purge secrets entirely, run:"
echo ""
echo "  # Option A — git filter-branch:"
echo "  git filter-branch --force --index-filter \\"
echo "    'git rm --cached --ignore-unmatch .env server/.env client/.env \\"
echo "     client-seo/.env mobile/.env' \\"
echo "    --prune-empty --tag-name-filter cat -- --all"
echo ""
echo "  # Option B — git-filter-repo (recommended):"
echo "  pip install git-filter-repo"
echo "  git filter-repo --path .env --path server/.env --path client/.env \\"
echo "    --path client-seo/.env --path mobile/.env --invert-paths"
echo ""
echo "📦 Creating .env.template for new devs..."
cat > .env.template << 'TEMPLATE'
# ── Reservatior Environment Template ──────────────────────────────────────
# Copy to .env and fill secrets from your password manager.
# NEVER commit .env files.

# Server
PORT=3000
NODE_ENV=development
DATABASE_URL="postgresql://..."
JWT_SECRET="change-me"
TEMPLATE
echo "   Created .env.template"
echo ""
echo "✅ Done. Next: fill .env from secrets manager, then force-push."
