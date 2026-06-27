#!/bin/bash
# Deploy AtlasVS to GCP e2-micro
# 
# Usage:
#   ./deploy.sh [command]
#
# Commands:
#   setup     - Initial server setup
#   deploy    - Deploy application
#   logs      - View application logs
#   restart   - Restart application
#   status    - Check application status

set -e

# Configuration
PROJECT_NAME="atlasvs"
APP_DIR="/app"
LOG_DIR="/var/log/atlasvs"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "This script must be run as root"
        exit 1
    fi
}

# Initial server setup
cmd_setup() {
    check_root
    log_info "Setting up server..."
    
    # Run startup script
    bash deploy/gcp/startup-script.sh
    
    log_info "Server setup complete!"
}

# Deploy application
cmd_deploy() {
    log_info "Deploying ${PROJECT_NAME}..."
    
    # Install dependencies
    log_info "Installing dependencies..."
    npm ci --production
    
    # Build application
    log_info "Building application..."
    npm run build
    
    # Check if PM2 is running
    if pm2 list | grep -q "$PROJECT_NAME"; then
        log_info "Restarting application..."
        pm2 restart $PROJECT_NAME
    else
        log_info "Starting application..."
        pm2 start deploy/ecosystem.config.js
        pm2 save
    fi
    
    # Setup PM2 startup
    pm2 startup || true
    
    log_info "Deployment complete!"
    pm2 status
}

# View logs
cmd_logs() {
    pm2 logs $PROJECT_NAME --lines 100
}

# Restart application
cmd_restart() {
    log_info "Restarting ${PROJECT_NAME}..."
    pm2 restart $PROJECT_NAME
    pm2 status
}

# Check status
cmd_status() {
    log_info "Application Status:"
    pm2 status
    
    echo ""
    log_info "System Resources:"
    free -h
    df -h /
    
    echo ""
    log_info "Nginx Status:"
    systemctl status nginx --no-pager || true
    
    echo ""
    log_info "Health Check:"
    curl -s http://localhost:3000/api/health | jq . || echo "Health check failed"
}

# Build Docker image
cmd_docker_build() {
    log_info "Building Docker image..."
    docker build -t $PROJECT_NAME:latest -f deploy/Dockerfile .
}

# Run with Docker
cmd_docker_run() {
    log_info "Running with Docker..."
    ENV_FILE=".env"
    if [ -f ".env.docker" ]; then
        log_info "Using .env.docker for local testing..."
        ENV_FILE=".env.docker"
    fi

    docker run -d \
        --name $PROJECT_NAME \
        --restart unless-stopped \
        -p 3000:3000 \
        --env-file $ENV_FILE \
        $PROJECT_NAME:latest
}

# Show help
cmd_help() {
    echo "AtlasVS Deployment Script"
    echo ""
    echo "Usage: ./deploy.sh [command]"
    echo ""
    echo "Commands:"
    echo "  setup         - Initial server setup (run as root)"
    echo "  deploy        - Deploy/update application"
    echo "  logs          - View application logs"
    echo "  restart       - Restart application"
    echo "  status        - Check application status"
    echo "  docker-build  - Build Docker image"
    echo "  docker-run    - Run with Docker"
    echo "  help          - Show this help"
}

# Main
case "${1:-help}" in
    setup)
        cmd_setup
        ;;
    deploy)
        cmd_deploy
        ;;
    logs)
        cmd_logs
        ;;
    restart)
        cmd_restart
        ;;
    status)
        cmd_status
        ;;
    docker-build)
        cmd_docker_build
        ;;
    docker-run)
        cmd_docker_run
        ;;
    help|--help|-h)
        cmd_help
        ;;
    *)
        log_error "Unknown command: $1"
        cmd_help
        exit 1
        ;;
esac
