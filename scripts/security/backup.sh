#!/bin/bash
# ── Automated Encrypted Backup — Reservatior ───────────────────────────────
# Schedule: 0 3 * * * /opt/reservatior/scripts/security/backup.sh
# ───────────────────────────────────────────────────────────────────────────

set -euo pipefail

# ── Config ─────────────────────────────────────────────────────────────────
BACKUP_DIR="${BACKUP_DIR:-/var/backups/reservatior}"
RETENTION_DAYS="${RETENTION_DAYS:-30}"
GPG_RECIPIENT="${GPG_RECIPIENT:-yagizyildirim@icloud.com}"
S3_BUCKET="${S3_BUCKET:-s3://reservatior-backups}"
DATE="$(date +%Y%m%d_%H%M%S)"
DB_NAME="${DB_NAME:-realestate_us}"
LOG_FILE="/var/log/reservatior-backup.log"

mkdir -p "$BACKUP_DIR"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

log "🚀 Starting backup..."

# ── 1. PostgreSQL dump ────────────────────────────────────────────────────
log "📦 Dumping PostgreSQL databases..."
for DB in realestate_us realestate_uk realestate_tr realestate_de realestate_fr \
           realestate_es realestate_it realestate_nl realestate_ca realestate_mx \
           realestate_br realestate_ar realestate_au realestate_nz realestate_jp \
           realestate_kr realestate_cn realestate_in realestate_sg realestate_my \
           realestate_th realestate_ae realestate_sa; do
  pg_dump "$DB" | gzip > "$BACKUP_DIR/${DB}_${DATE}.sql.gz"
  log "  ✅ $DB"
done

# ── 2. Encrypt with GPG ───────────────────────────────────────────────────
log "🔐 Encrypting backups..."
for f in "$BACKUP_DIR"/*_"${DATE}".sql.gz; do
  gpg --encrypt --recipient "$GPG_RECIPIENT" --trust-model always \
    --output "${f}.gpg" "$f"
  rm "$f"  # remove unencrypted
done

# ── 3. Upload to S3 ───────────────────────────────────────────────────────
log "☁️  Uploading to S3..."
if command -v aws &>/dev/null; then
  aws s3 sync "$BACKUP_DIR" "$S3_BUCKET/$(date +%Y/%m)" --exclude "*" --include "*.gpg" --quiet
  log "  ✅ Uploaded to $S3_BUCKET"
else
  log "  ⚠️  AWS CLI not found, skipping S3 upload"
fi

# ── 4. Rotate old backups ─────────────────────────────────────────────────
log "🧹 Cleaning backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -name "*.gpg" -mtime "+$RETENTION_DAYS" -delete

# ── 5. Verify latest backup ───────────────────────────────────────────────
LATEST=$(ls -t "$BACKUP_DIR"/*.gpg 2>/dev/null | head -1)
if [ -n "$LATEST" ]; then
  SIZE=$(stat -f%z "$LATEST" 2>/dev/null || stat -c%s "$LATEST" 2>/dev/null)
  log "  📊 Latest backup: $(basename "$LATEST") ($((SIZE/1024/1024))MB)"
fi

log "🎉 Backup complete!"
