#!/bin/bash

# Google Cloud Free Tier Deployment Script
# Usage: ./deploy.sh [api|frontend|ml|all]

set -e

# Configuration
PROJECT_ID="${GOOGLE_CLOUD_PROJECT:-$(gcloud config get-value project)}"
REGION="us-central1"
COMMIT_SHA="${COMMIT_SHA:-$(git rev-parse --short HEAD)}"
SERVICE_NAME="${1:-all}"

echo "🚀 Deploying to Google Cloud Free Tier"
echo "Project: $PROJECT_ID"
echo "Region: $REGION"
echo "Commit: $COMMIT_SHA"
echo "Service: $SERVICE_NAME"

# Enable required APIs
echo "📋 Enabling required APIs..."
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable artifactregistry.googleapis.com

# Function to deploy individual service
deploy_service() {
    local service=$1
    local dockerfile=$2
    local context=$3
    local memory=$4
    local cpu=$5
    local max_instances=$6
    local timeout=${7:-300}
    
    echo "🐳 Building $service..."
    docker build -f "$dockerfile" -t "gcr.io/$PROJECT_ID/reservatior-$service:$COMMIT_SHA" "$context"
    
    echo "📤 Pushing $service..."
    docker push "gcr.io/$PROJECT_ID/reservatior-$service:$COMMIT_SHA"
    
    echo "☁️ Deploying $service to Cloud Run..."
    gcloud run deploy "reservatior-$service" \
        --image="gcr.io/$PROJECT_ID/reservatior-$service:$COMMIT_SHA" \
        --region="$REGION" \
        --platform=managed \
        --allow-unauthenticated \
        --memory="$memory" \
        --cpu="$cpu" \
        --min-instances=0 \
        --max-instances="$max_instances" \
        --timeout="$timeout" \
        --quiet
    
    echo "✅ $service deployed successfully!"
}

# Deploy based on service type
case $SERVICE_NAME in
    "api")
        deploy_service "api" "Dockerfile.api" "." "512Mi" "1" "2"
        ;;
    "frontend")
        deploy_service "frontend" "Dockerfile.frontend" "./client" "256Mi" "1" "2"
        ;;
    "ml")
        deploy_service "ml" "Dockerfile.ml" "./server/ml-services/backend" "1Gi" "1" "1" "600"
        ;;
    "all")
        echo "🔄 Deploying all services..."
        deploy_service "api" "Dockerfile.api" "." "512Mi" "1" "2"
        deploy_service "frontend" "Dockerfile.frontend" "./client" "256Mi" "1" "2"
        deploy_service "ml" "Dockerfile.ml" "./server/ml-services/backend" "1Gi" "1" "1" "600"
        ;;
    *)
        echo "❌ Invalid service. Use: api, frontend, ml, or all"
        exit 1
        ;;
esac

# Get service URLs
echo ""
echo "🌐 Service URLs:"
if [[ "$SERVICE_NAME" == "api" || "$SERVICE_NAME" == "all" ]]; then
    API_URL=$(gcloud run services describe reservatior-api --region="$REGION" --format='value(status.url)')
    echo "📡 API: $API_URL"
fi

if [[ "$SERVICE_NAME" == "frontend" || "$SERVICE_NAME" == "all" ]]; then
    FRONTEND_URL=$(gcloud run services describe reservatior-frontend --region="$REGION" --format='value(status.url)')  
    echo "🖥️  Frontend: $FRONTEND_URL"
fi

if [[ "$SERVICE_NAME" == "ml" || "$SERVICE_NAME" == "all" ]]; then
    ML_URL=$(gcloud run services describe reservatior-ml --region="$REGION" --format='value(status.url)')
    echo "🤖 ML Services: $ML_URL"
fi

echo ""
echo "💡 Free Tier Usage Tips:"
echo "- Services scale to 0 when not in use (no cost)"
echo "- API: 512Mi memory, 1 CPU, max 2 instances"
echo "- Frontend: 256Mi memory, 1 CPU, max 2 instances"  
echo "- ML: 1Gi memory, 1 CPU, max 1 instance"
echo "- Monitor usage: gcloud run services list"
