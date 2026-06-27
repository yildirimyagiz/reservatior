# Production Architecture Summary

This document summarizes the production-ready architecture built for AtlasVS.

## 1. Core Architecture

- **Frontend**: Next.js 14 (App Router)
- **Backend**: Next.js API Routes (Serverless/Edge) + Python AI Workers (RunPod/A1111)
- **Database**: PostgreSQL (Prisma)
- **Storage**: Cloudflare R2 (S3-compatible, zero egress fees)
- **Security**: Cloudflare (WAF, DDoS, Zero Trust)
- **Payments**: Stripe (Intents, Subscriptions, Webhooks)

## 2. Key Components Created

### 🌐 API Routes

- `/api/v1/staging/generate-cdn`: Main pipeline. Generates image → Optimizes (WebP) → Uploads to R2 → Returns CDN URL.
- `/api/v1/payments`: Stripe payment intent creation.
- `/api/webhooks/stripe`: Robust webhook handling for subscriptions.
- `/api/health`: System health monitoring.

### 🛠️ Libraries & Utilities

- `src/lib/storage/r2-client.ts`: Cloudflare R2 client.
- `src/lib/image-processor/index.ts`: High-performance image optimization (Sharp).
- `src/lib/stripe/client.ts`: Unified Stripe client.
- `src/hooks/use-staging-generation.ts`: Updated frontend hook for the new pipeline.

### 🚀 Deployment

- `deploy/Dockerfile`: Optimized production container (Alpine, Multi-stage).
- `deploy/deploy.sh`: Automated deployment script for GCP.
- `deploy/ecosystem.config.js`: PM2 process management.
- `docs/architecture/cloudflare-security.md`: Security configuration guide.

## 3. Configuration Checklist

Ensure these variables are set in your production `.env` (or GCP Secret Manager):

### Storage (Cloudflare R2)

```env
R2_ACCOUNT_ID=...
R2_ACCESS_KEY_ID=...
R2_SECRET_ACCESS_KEY=...
R2_BUCKET_NAME=atlasvs-images
R2_PUBLIC_URL=https://pub-xxx.r2.dev
```

### AI Compute (RunPod)

```env
RUNPOD_API_KEY=...
RUNPOD_A1111_ENDPOINT_ID=...
```

### Payments (Stripe Live)

```env
STRIPE_SECRET_KEY=sk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_live_...
```

## 4. Next Steps

1. **Configure Cloudflare**: Follow `docs/architecture/cloudflare-security.md` to set up R2 and WAF.
2. **Deploy**: Run `./deploy/deploy.sh` to push to your GCP VM.
3. **Verify**: Check `/api/health` to ensure all systems are green.
