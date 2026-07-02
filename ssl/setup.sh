#!/bin/bash
# ── Let's Encrypt SSL Setup — Reservatior ──────────────────────────────────
# Run this on the VPS / production server.
# Supports both Docker and bare-metal nginx deployments.
#
# Usage:
#   chmod +x ssl/setup.sh
#   sudo ./ssl/setup.sh [--docker|--host] [domains...]
#
# Examples:
#   sudo ./ssl/setup.sh --host reservatior.com atlasvs.cloud
#   sudo ./ssl/setup.sh --docker reservatior.com
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

# ── Config ─────────────────────────────────────────────────────────────────
EMAIL="${SSL_EMAIL:-yagizyildirim@icloud.com}"
MODE="${1:---host}"
shift || true
DOMAINS=("$@")
if [ ${#DOMAINS[@]} -eq 0 ]; then
  DOMAINS=("reservatior.com" "atlasvs.cloud")
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}🔐 Let's Encrypt SSL Setup${NC}"
echo "  Email: $EMAIL"
echo "  Mode:  $MODE"
echo "  Domains: ${DOMAINS[*]}"
echo ""

install_deps() {
  echo -e "${YELLOW}📦 Installing nginx + certbot...${NC}"
  apt-get update -qq
  apt-get install -y -qq nginx certbot python3-certbot-nginx
}

host_setup() {
  install_deps

  # Build domain flags for certbot
  DOMAIN_FLAGS=()
  for d in "${DOMAINS[@]}"; do
    DOMAIN_FLAGS+=(-d "$d")
    DOMAIN_FLAGS+=(-d "www.$d")
  done

  echo -e "${YELLOW}🔒 Requesting SSL certificates...${NC}"
  certbot --nginx \
    "${DOMAIN_FLAGS[@]}" \
    --non-interactive \
    --agree-tos \
    -m "$EMAIL" \
    --redirect \
    --hsts \
    --staple-ocsp

  echo -e "${GREEN}✅ SSL certificates installed!${NC}"
  echo "  Certs: /etc/letsencrypt/live/${DOMAINS[0]}/"

  # Auto-renewal (certbot installs systemd timer by default)
  echo -e "${YELLOW}⏰ Checking auto-renewal timer...${NC}"
  systemctl list-timers | grep certbot || true
  certbot renew --dry-run 2>&1 | tail -3
}

docker_setup() {
  install_deps

  # Stop the Docker app containers so nginx can bind ports 80/443
  echo -e "${YELLOW}🛑 Stopping Docker app containers...${NC}"
  cd "$(dirname "$0")/.."
  docker compose down 2>/dev/null || true
  docker compose -f server/docker-compose.yml down 2>/dev/null || true

  DOMAIN_FLAGS=()
  for d in "${DOMAINS[@]}"; do
    DOMAIN_FLAGS+=(-d "$d")
    DOMAIN_FLAGS+=(-d "www.$d")
  done

  echo -e "${YELLOW}🔒 Requesting SSL certificates...${NC}"
  certbot certonly --standalone \
    "${DOMAIN_FLAGS[@]}" \
    --non-interactive \
    --agree-tos \
    -m "$EMAIL"

  echo -e "${GREEN}✅ SSL certificates obtained!${NC}"
  echo "  Certs: /etc/letsencrypt/live/${DOMAINS[0]}/"

  # Deploy hook: restart docker containers after renewal
  mkdir -p /etc/letsencrypt/renewal-hooks/deploy
  cat > /etc/letsencrypt/renewal-hooks/deploy/restart-docker.sh << 'RENEW'
#!/bin/bash
cd /opt/reservatior
docker compose restart nginx-ssl
RENEW
  chmod +x /etc/letsencrypt/renewal-hooks/deploy/restart-docker.sh

  # Start Docker with SSL
  echo -e "${YELLOW}🚀 Starting Docker with SSL...${NC}"
  docker compose -f docker-compose.yml -f ssl/docker-compose.ssl.yml up -d

  echo -e "${GREEN}✅ Docker SSL setup complete!${NC}"
}

case "$MODE" in
  --host)
    host_setup
    ;;
  --docker)
    docker_setup
    ;;
  *)
    echo -e "${RED}Usage: $0 [--host|--docker] [domains...]${NC}"
    exit 1
    ;;
esac

# ── Firewall ───────────────────────────────────────────────────────────────
echo -e "${YELLOW}🔧 Updating firewall rules...${NC}"
if command -v ufw &>/dev/null; then
  ufw allow 80/tcp 2>/dev/null || true
  ufw allow 443/tcp 2>/dev/null || true
  ufw reload 2>/dev/null || true
fi

echo -e "${GREEN}🎉 SSL setup complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Verify: curl -I https://${DOMAINS[0]}"
echo "  2. Test renewal: certbot renew --dry-run"
echo "  3. Schedule monthly: systemctl list-timers | grep certbot"
