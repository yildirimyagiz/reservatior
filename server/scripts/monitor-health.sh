#!/bin/bash
# Health Monitoring Script
# Checks system health and sends alerts if issues detected

set -e

# Configuration
API_URL="${API_URL:-http://localhost:3000}"
ALERT_WEBHOOK="${SLACK_WEBHOOK_URL:-}"
THRESHOLD_DOWN=1        # Alert if any database is down
THRESHOLD_DEGRADED=5    # Alert if 5+ databases are degraded

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Log function
log() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Send Slack alert
send_alert() {
    local message="$1"
    local severity="${2:-warning}"
    
    if [ -z "$ALERT_WEBHOOK" ]; then
        log "${YELLOW}No Slack webhook configured, skipping alert${NC}"
        return
    fi
    
    local color="#FFA500"  # Orange for warning
    if [ "$severity" == "critical" ]; then
        color="#FF0000"  # Red for critical
    fi
    
    curl -X POST "$ALERT_WEBHOOK" \
        -H 'Content-Type: application/json' \
        -d "{
            \"attachments\": [{
                \"color\": \"$color\",
                \"title\": \"🚨 Multi-Country API Health Alert\",
                \"text\": \"$message\",
                \"footer\": \"Health Monitor\",
                \"ts\": $(date +%s)
            }]
        }" \
        --silent --output /dev/null
}

# Check health endpoint
check_health() {
    local response=$(curl -s "$API_URL/health/databases" || echo "ERROR")
    
    if [ "$response" == "ERROR" ]; then
        log "${RED}✗ Failed to connect to API${NC}"
        send_alert "Failed to connect to API at $API_URL" "critical"
        return 1
    fi
    
    echo "$response"
}

# Main health check
log "========== Health Check Started =========="

HEALTH_DATA=$(check_health)

if [ $? -ne 0 ]; then
    log "${RED}Health check failed - API unreachable${NC}"
    exit 1
fi

# Parse health data
STATUS=$(echo "$HEALTH_DATA" | jq -r '.status' 2>/dev/null || echo "unknown")
TOTAL=$(echo "$HEALTH_DATA" | jq -r '.summary.total' 2>/dev/null || echo "0")
HEALTHY=$(echo "$HEALTH_DATA" | jq -r '.summary.healthy' 2>/dev/null || echo "0")
DEGRADED=$(echo "$HEALTH_DATA" | jq -r '.summary.degraded' 2>/dev/null || echo "0")
DOWN=$(echo "$HEALTH_DATA" | jq -r '.summary.down' 2>/dev/null || echo "0")

log "System Status: $STATUS"
log "Databases: $HEALTHY/$TOTAL healthy"

if [ "$DOWN" -gt 0 ]; then
    log "${RED}✗ WARNING: $DOWN database(s) are DOWN${NC}"
    
    # Get list of down databases
    DOWN_DBS=$(echo "$HEALTH_DATA" | jq -r '.issues[] | select(.severity=="critical") | .country' | tr '\n' ', ' | sed 's/,$//')
    
    log "${RED}Down databases: $DOWN_DBS${NC}"
    
    if [ "$DOWN" -ge "$THRESHOLD_DOWN" ]; then
        send_alert "🔴 CRITICAL: $DOWN database(s) are DOWN: $DOWN_DBS" "critical"
    fi
fi

if [ "$DEGRADED" -gt 0 ]; then
    log "${YELLOW}⚠ WARNING: $DEGRADED database(s) are DEGRADED${NC}"
    
    # Get list of degraded databases
    DEGRADED_DBS=$(echo "$HEALTH_DATA" | jq -r '.issues[] | select(.severity=="warning") | .country' | tr '\n' ', ' | sed 's/,$//')
    
    log "${YELLOW}Degraded databases: $DEGRADED_DBS${NC}"
    
    if [ "$DEGRADED" -ge "$THRESHOLD_DEGRADED" ]; then
        send_alert "⚠️ WARNING: $DEGRADED database(s) are DEGRADED: $DEGRADED_DBS" "warning"
    fi
fi

if [ "$STATUS" == "healthy" ]; then
    log "${GREEN}✓ All systems healthy${NC}"
fi

# Check individual database response times
log "========== Database Response Times =========="

echo "$HEALTH_DATA" | jq -r '.databases[] | "\(.country): \(.responseTime)ms [\(.status)]"' | while read -r line; do
    if [[ $line == *"down"* ]]; then
        log "${RED}$line${NC}"
    elif [[ $line == *"degraded"* ]]; then
        log "${YELLOW}$line${NC}"
    else
        log "${GREEN}$line${NC}"
    fi
done

log "========== Health Check Complete =========="

# Exit with error if system is not healthy
if [ "$STATUS" != "healthy" ]; then
    exit 1
fi

exit 0
