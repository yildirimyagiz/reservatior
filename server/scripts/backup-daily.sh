#!/bin/bash
# Daily Backup Script for Multi-Country Databases
# Run via cron: 0 2 * * * /path/to/backup-daily.sh

set -e  # Exit on error

# Configuration
BACKUP_DIR="${BACKUP_STORAGE_PATH:-/var/backups/postgres}"
RETENTION_DAYS="${BACKUP_RETENTION_DAILY:-7}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="${BACKUP_DIR}/backup.log"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Log function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "========== Starting Multi-Country Backup =========="

# List of countries (from environment or default)
COUNTRIES=(
    "US" "UK" "CA" "AU" "DE" "FR" "ES" "IT" "NL" "BR" 
    "MX" "AR" "IN" "CN" "JP" "KR" "SG" "MY" "TH" "AE" 
    "SA" "TR" "NZ"
)

BACKUP_COUNT=0
FAILED_COUNT=0
FAILED_COUNTRIES=()

# Backup each country database
for COUNTRY in "${COUNTRIES[@]}"; do
    log "Backing up $COUNTRY database..."
    
    # Get database URL from environment
    DB_URL_VAR="DATABASE_URL_${COUNTRY}"
    DB_URL="${!DB_URL_VAR}"
    
    if [ -z "$DB_URL" ]; then
        log "WARNING: No database URL found for $COUNTRY (${DB_URL_VAR}), skipping..."
        FAILED_COUNT=$((FAILED_COUNT + 1))
        FAILED_COUNTRIES+=("$COUNTRY")
        continue
    fi
    
    # Parse database URL
    # Format: postgresql://user:password@host:port/database
    DB_USER=$(echo "$DB_URL" | sed -n 's|.*://\([^:]*\):.*|\1|p')
    DB_PASS=$(echo "$DB_URL" | sed -n 's|.*://[^:]*:\([^@]*\)@.*|\1|p')
    DB_HOST=$(echo "$DB_URL" | sed -n 's|.*@\([^:]*\):.*|\1|p')
    DB_PORT=$(echo "$DB_URL" | sed -n 's|.*:\([0-9]*\)/.*|\1|p')
    DB_NAME=$(echo "$DB_URL" | sed -n 's|.*/\([^?]*\).*|\1|p')
    
    # Backup filename
    BACKUP_FILE="${BACKUP_DIR}/backup_${COUNTRY}_${TIMESTAMP}.sql.gz"
    
    # Perform backup
    if PGPASSWORD="$DB_PASS" pg_dump \
        -h "$DB_HOST" \
        -p "$DB_PORT" \
        -U "$DB_USER" \
        -d "$DB_NAME" \
        -F p \
        2>> "$LOG_FILE" | gzip > "$BACKUP_FILE"; then
        
        BACKUP_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
        log "✓ $COUNTRY backup completed: $BACKUP_FILE ($BACKUP_SIZE)"
        BACKUP_COUNT=$((BACKUP_COUNT + 1))
    else
        log "✗ $COUNTRY backup failed!"
        FAILED_COUNT=$((FAILED_COUNT + 1))
        FAILED_COUNTRIES+=("$COUNTRY")
        rm -f "$BACKUP_FILE"  # Remove incomplete backup
    fi
done

log "========== Backup Summary =========="
log "Successful backups: $BACKUP_COUNT"
log "Failed backups: $FAILED_COUNT"

if [ $FAILED_COUNT -gt 0 ]; then
    log "Failed countries: ${FAILED_COUNTRIES[*]}"
fi

# Clean old backups
log "========== Cleaning Old Backups =========="
log "Removing backups older than $RETENTION_DAYS days..."

DELETED_COUNT=$(find "$BACKUP_DIR" -name "backup_*.sql.gz" -type f -mtime +$RETENTION_DAYS -delete -print | wc -l)
log "Deleted $DELETED_COUNT old backup files"

# Calculate total backup size
TOTAL_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
log "Total backup directory size: $TOTAL_SIZE"

log "========== Backup Process Complete =========="

# Exit with error if any backups failed
if [ $FAILED_COUNT -gt 0 ]; then
    exit 1
fi

exit 0
