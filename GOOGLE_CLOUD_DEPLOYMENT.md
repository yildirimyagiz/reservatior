# Google Cloud Free Tier Deployment Guide

## 🎯 Overview

This guide deploys your Node.js + Python real estate application to Google Cloud using **Cloud Run** for maximum Free Tier benefits.

## 📊 Free Tier Limits (2024)

- **Cloud Run**: 2M requests/month, 360K GB-seconds memory, 180K vCPU-seconds
- **Cloud Build**: 120 build minutes/month
- **Artifact Registry**: 1GB storage
- **Network Egress**: 1GB/month

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │      API        │    │   ML Services   │
│   (React)       │    │   (ElysiaJS)    │    │   (FastAPI)     │
│   256Mi RAM     │    │   512Mi RAM     │    │   1Gi RAM       │
│   Port 8080     │    │   Port 3000     │    │   Port 8000     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │   Cloud Run     │
                    │   (Serverless)  │
                    └─────────────────┘
```

## 🚀 Quick Deployment

### 1. Prerequisites

```bash
# Install Google Cloud CLI
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# Login and set project
gcloud auth login
gcloud config set project YOUR_PROJECT_ID

# Enable Docker authentication
gcloud auth configure-docker
```

### 2. Deploy All Services

```bash
# Deploy everything (recommended for first time)
./deploy.sh all

# Or deploy individual services
./deploy.sh api       # Node.js backend
./deploy.sh frontend  # React frontend  
./deploy.sh ml        # Python ML services
```

### 3. Using Cloud Build (CI/CD)

```bash
# Trigger build and deployment
gcloud builds submit --config=cloudbuild.yaml
```

## 🔧 Configuration

### Environment Variables

Create `.env.production`:

```bash
# API Service
NODE_ENV=production
DATABASE_URL=postgresql://user:password@host:5432/dbname
JWT_SECRET=your-jwt-secret

# ML Service
PYTHONPATH=/app
MODEL_CACHE_DIR=/app/models
```

### Service Optimization

| Service | Memory | CPU | Min Instances | Max Instances | Timeout |
|---------|---------|-----|---------------|---------------|---------|
| Frontend | 256Mi | 1 | 0 | 2 | 300s |
| API | 512Mi | 1 | 0 | 2 | 300s |
| ML | 1Gi | 1 | 0 | 1 | 600s |

## 📈 Monitoring & Optimization

### Check Service Status

```bash
# List all services
gcloud run services list

# Get service details
gcloud run services describe reservatiorm-api --region=us-central1

# View logs
gcloud logs read "resource.type=cloud_run_revision" --limit=50
```

### Free Tier Optimization Tips

1. **Scale to Zero**: Services automatically scale to 0 when unused
2. **Memory Limits**: Keep memory low to stay within GB-second limits
3. **Request Optimization**: Cache responses to reduce request count
4. **Build Minutes**: Use Cloud Build efficiently (120 min/month limit)

## 🔒 Security

### IAM Configuration

```bash
# Allow public access (if needed)
gcloud run services add-iam-policy-binding reservatiorm-api \
  --member="allUsers" \
  --role="roles/run.invoker"
```

### Environment Variables

```bash
# Set secrets (better than .env files)
gcloud secrets create DATABASE_SECRET --replication-policy=automatic
echo "your-db-url" | gcloud secrets versions add DATABASE_SECRET --data-file=-

# Link secret to service
gcloud run services update reservatiorm-api \
  --set-secrets="DATABASE_URL=DATABASE_SECRET:latest"
```

## 🌐 Service URLs

After deployment, get your service URLs:

```bash
# API URL
gcloud run services describe reservatiorm-api --region=us-central1 --format='value(status.url)')

# Frontend URL  
gcloud run services describe reservatiorm-frontend --region=us-central1 --format='value(status.url)')

# ML Services URL
gcloud run services describe reservatiorm-ml --region=us-central1 --format='value(status.url)')
```

## 🔄 Updates & Rollbacks

### Update Services

```bash
# Redeploy with changes
git add .
git commit -m "Update services"
./deploy.sh all
```

### Rollback

```bash
# List revisions
gcloud run revisions list --service=reservatiorm-api

# Rollback to previous revision
gcloud run services update reservatiorm-api --revision=REVISION_ID
```

## 💰 Cost Management

### Monitoring Usage

```bash
# Check current month's usage
gcloud billing accounts list
gcloud billing budgets list --billing-account=BILLING_ACCOUNT_ID
```

### Stay Within Free Tier

- **Monitor requests**: Use Cloud Monitoring to track API calls
- **Optimize images**: Compress frontend assets
- **Cache responses**: Implement Redis caching for repeated requests
- **Batch operations**: Combine multiple API calls when possible

## 🐛 Troubleshooting

### Common Issues

1. **Build timeouts**: Increase build timeout in cloudbuild.yaml
2. **Memory errors**: Increase memory allocation for ML services
3. **Cold starts**: Use min-instances=1 for critical services
4. **Database connection**: Use Cloud SQL for production databases

### Debug Commands

```bash
# Check service logs
gcloud logs tail "resource.type=cloud_run_revision"

# Test service locally
docker build -f Dockerfile.api -t test-api .
docker run -p 3000:3000 test-api

# Check resource usage
gcloud run services describe reservatiorm-api --region=us-central1 --format="yaml(spec.template.spec.containers[0].resources)"
```

## 📚 Additional Resources

- [Cloud Run Documentation](https://cloud.google.com/run/docs)
- [Cloud Build Documentation](https://cloud.google.com/build/docs)
- [Free Tier FAQ](https://cloud.google.com/free/docs/free-tier-features)
- [Pricing Calculator](https://cloud.google.com/products/calculator)

## 🎉 Success!

Your application is now deployed on Google Cloud Free Tier! Services will automatically scale to zero when not in use, minimizing costs while maintaining high performance when needed.
