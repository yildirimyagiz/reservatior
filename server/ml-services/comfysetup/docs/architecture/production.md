# Production Architecture: GCP Free Tier + RunPod AI + CDN

## Overview

This document describes the production architecture for AtlasVS, optimized for:

- **GCP e2-micro VM** (Always Free tier) - 1 vCPU, 1GB RAM
- **RunPod AI** - GPU workloads for image generation
- **Cloud Storage + CDN** - Zero-bandwidth image delivery
- **Stripe** - Payment processing
- **PostgreSQL** - Lightweight database

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              CLIENTS                                         │
│                  (Web Browser / Mobile App)                                  │
└─────────────────────────┬───────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                         CLOUDFLARE (Free Tier)                               │
│  • DNS + CDN caching                                                         │
│  • DDoS protection                                                           │
│  • SSL/TLS termination                                                       │
│  • Static asset caching (JS, CSS, fonts)                                     │
└─────────────────────────┬───────────────────────────────────────────────────┘
                          │
          ┌───────────────┴───────────────┐
          ▼                               ▼
┌──────────────────────┐     ┌────────────────────────────────────────────────┐
│   GCP e2-micro VM    │     │            CLOUDFLARE R2 / GCS                 │
│   (Always Free)      │     │           (Image Storage + CDN)                │
│                      │     │                                                 │
│  ┌────────────────┐  │     │  • All generated images stored here            │
│  │   Next.js      │  │     │  • WebP/AVIF format for web delivery           │
│  │   (SSG/ISR)    │  │     │  • Multiple sizes (thumbnail, preview, full)   │
│  └───────┬────────┘  │     │  • Zero egress from VM                         │
│          │           │     │  • CDN-cached URLs returned to clients         │
│  ┌───────▼────────┐  │     └────────────────────────────────────────────────┘
│  │   Node.js API  │  │                         ▲
│  │   (Express)    │──┼─────────────────────────┤ (Upload generated images)
│  └───────┬────────┘  │                         │
│          │           │     ┌───────────────────┴────────────────────────────┐
│  ┌───────▼────────┐  │     │              RUNPOD AI                         │
│  │  PostgreSQL    │  │     │         (Serverless GPUs)                      │
│  │  (Lightweight) │  │     │                                                 │
│  └────────────────┘  │     │  • A1111 Stable Diffusion endpoint             │
│                      │     │  • img2img for virtual staging                 │
│  Memory: ~600MB used │     │  • ControlNet for structure preservation       │
│  CPU: <50% avg       │     │  • Returns base64 images to VM                 │
│  Bandwidth: <1GB/mo  │     │  • Pay-per-second (~$0.00069/sec)              │
└──────────────────────┘     └────────────────────────────────────────────────┘
          │
          ▼
┌──────────────────────────────────────────────────────────────────────────────┐
│                            STRIPE                                             │
│  • Payment intents (server-side)                                              │
│  • Webhooks → VM (success/failure/subscription)                               │
│  • Client-side Stripe.js for card collection                                  │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## Component Breakdown

### 1. GCP e2-micro VM (Always Free)

**Specs:**

- 1 vCPU (shared)
- 1 GB RAM
- 30 GB standard persistent disk
- 1 GB egress/month (to internet, free)

**What runs on VM:**

- Next.js app (SSG/ISR mode, not SSR)
- Node.js API (lightweight)
- PostgreSQL (embedded or Cloud SQL free tier)
- PM2 process manager

**Optimization strategies:**

- Use SSG (Static Site Generation) for all marketing pages
- Use ISR (Incremental Static Regeneration) for dynamic content
- Cache API responses aggressively
- Offload ALL images to CDN (never serve from VM)
- Use swap file for memory overflow

### 2. Image Workflow (Zero VM Bandwidth)

```
┌─────────────┐    ┌──────────────┐    ┌──────────────┐    ┌─────────────────┐
│   Client    │───▶│   VM API     │───▶│  RunPod AI   │───▶│  VM (receives   │
│   uploads   │    │   receives   │    │  generates   │    │  base64 image)  │
│   image     │    │   request    │    │  staged img  │    │                 │
└─────────────┘    └──────────────┘    └──────────────┘    └────────┬────────┘
                                                                     │
                                                                     ▼
                                                           ┌─────────────────┐
                                                           │   Convert to    │
                                                           │   WebP/AVIF     │
                                                           │   Resize to     │
                                                           │   multiple sizes│
                                                           └────────┬────────┘
                                                                     │
                                                                     ▼
                                                           ┌─────────────────┐
                                                           │  Upload to R2   │
                                                           │  or GCS bucket  │
                                                           │  (CDN-enabled)  │
                                                           └────────┬────────┘
                                                                     │
                                                                     ▼
                                                           ┌─────────────────┐
                                                           │  Return CDN URL │
                                                           │  to client      │
                                                           │  (not VM URL!)  │
                                                           └─────────────────┘
```

**Image Storage Options (Ranked):**

| Provider                | Free Tier                                | CDN      | Cost After Free |
| ----------------------- | ---------------------------------------- | -------- | --------------- |
| **Cloudflare R2**       | 10GB storage, 10M reads/mo, 1M writes/mo | Built-in | $0.015/GB/mo    |
| **GCS + CDN**           | 5GB storage, 1GB egress in US            | Separate | $0.020/GB/mo    |
| **AWS S3 + CloudFront** | 5GB, 15GB transfer                       | Separate | $0.023/GB/mo    |

**Recommendation:** Cloudflare R2 (most generous free tier, built-in CDN)

### 3. RunPod AI Configuration

**Endpoint Setup:**

- Template: `Automatic1111` (A1111)
- GPU: RTX 4090 (fastest for price)
- Min workers: 0 (scale to zero when idle)
- Max workers: 3 (prevent cost overrun)
- Idle timeout: 5 seconds

**Cost Estimation:**
| Action | GPU Time | Cost |
|--------|----------|------|
| Staging 1 image | ~8-12 sec | ~$0.006-0.008 |
| Batch 5 images | ~40-60 sec | ~$0.028-0.041 |

### 4. Stripe Payment Flow

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│   Frontend   │     │   Next.js    │     │    Stripe    │     │  PostgreSQL  │
│   (React)    │     │   API Route  │     │    API       │     │              │
└──────┬───────┘     └──────┬───────┘     └──────┬───────┘     └──────┬───────┘
       │                    │                    │                    │
       │ 1. Select plan     │                    │                    │
       ├───────────────────▶│                    │                    │
       │                    │ 2. Create intent   │                    │
       │                    ├───────────────────▶│                    │
       │                    │                    │                    │
       │                    │◀───────────────────┤                    │
       │ 3. client_secret   │  (returns secret)  │                    │
       │◀───────────────────┤                    │                    │
       │                    │                    │                    │
       │ 4. Confirm payment │                    │                    │
       ├────────────────────────────────────────▶│                    │
       │      (using Stripe.js)                  │                    │
       │                    │                    │                    │
       │                    │ 5. Webhook (success)                    │
       │                    │◀───────────────────┤                    │
       │                    │                    │                    │
       │                    │ 6. Update user     │                    │
       │                    ├────────────────────────────────────────▶│
       │                    │                    │                    │
       │ 7. Confirmation    │                    │                    │
       │◀───────────────────┤                    │                    │
```

---

## Folder Structure

```
atlasvs/
├── src/
│   ├── app/                      # Next.js App Router
│   │   ├── api/
│   │   │   ├── v1/
│   │   │   │   ├── staging/      # AI staging endpoints
│   │   │   │   ├── payments/     # Stripe endpoints
│   │   │   │   └── images/       # Image upload/management
│   │   │   └── webhooks/
│   │   │       └── stripe/       # Stripe webhook handler
│   │   ├── [locale]/             # i18n pages (SSG)
│   │   └── ...
│   ├── lib/
│   │   ├── storage/              # Cloud storage clients
│   │   │   ├── r2-client.ts      # Cloudflare R2
│   │   │   ├── gcs-client.ts     # Google Cloud Storage
│   │   │   └── index.ts
│   │   ├── image-processor/      # Image optimization
│   │   │   ├── converter.ts      # WebP/AVIF conversion
│   │   │   ├── resizer.ts        # Multi-size generation
│   │   │   └── index.ts
│   │   ├── stripe/               # Stripe integration
│   │   │   ├── client.ts
│   │   │   └── webhooks.ts
│   │   └── ...
│   └── ...
├── deploy/                       # Deployment configs
│   ├── Dockerfile                # Production Docker image
│   ├── docker-compose.yml        # Local development
│   ├── ecosystem.config.js       # PM2 config
│   ├── nginx.conf                # Reverse proxy
│   └── gcp/
│       ├── startup-script.sh     # VM initialization
│       └── terraform/            # Infrastructure as code
├── docs/
│   └── architecture/
│       └── production.md         # This file
└── ...
```

---

## Environment Variables

```env
# === Application ===
NODE_ENV=production
NEXT_PUBLIC_APP_URL=https://yourapp.com

# === Database ===
DATABASE_URL=postgresql://user:pass@localhost:5432/atlasvs

# === AI Generation ===
RUNPOD_API_KEY=your_runpod_api_key
RUNPOD_A1111_ENDPOINT_ID=your_endpoint_id

# === Image Storage (Cloudflare R2) ===
R2_ACCOUNT_ID=your_account_id
R2_ACCESS_KEY_ID=your_access_key
R2_SECRET_ACCESS_KEY=your_secret_key
R2_BUCKET_NAME=atlasvs-images
R2_PUBLIC_URL=https://images.yourapp.com

# === Stripe ===
STRIPE_SECRET_KEY=sk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_live_...

# === Security ===
AUTH_SECRET=your_auth_secret
RATE_LIMIT_MAX=100
RATE_LIMIT_WINDOW_MS=60000
```

---

## Cost Breakdown (Monthly)

| Service         | Usage                    | Cost                 |
| --------------- | ------------------------ | -------------------- |
| GCP e2-micro    | 730 hours                | **$0** (Always Free) |
| GCP Disk (30GB) | Standard                 | **$0** (Always Free) |
| GCP Egress      | <1GB                     | **$0** (Always Free) |
| Cloudflare R2   | 5GB storage, 1M requests | **$0** (Free tier)   |
| Cloudflare CDN  | Unlimited                | **$0** (Free tier)   |
| RunPod AI       | ~100 images              | **~$0.60-0.80**      |
| PostgreSQL      | Embedded on VM           | **$0**               |
| **Total**       |                          | **~$0.60-0.80/mo**   |

---

## Scaling Plan

### Stage 1: Free Tier (<1000 users)

- Current architecture
- Cost: ~$1/month

### Stage 2: Light Growth (1000-5000 users)

- Upgrade to e2-small ($5/mo)
- Add Cloud SQL ($9/mo)
- Increase RunPod max workers
- Cost: ~$15-20/month

### Stage 3: Growth (5000-20000 users)

- Upgrade to e2-medium ($13/mo)
- Cloud SQL with backup ($20/mo)
- Add Redis for caching ($10/mo)
- CDN caching optimization
- Cost: ~$50-70/month

### Stage 4: Scale (20000+ users)

- Cloud Run / Kubernetes
- Cloud SQL HA ($100+/mo)
- Dedicated RunPod endpoints
- Multi-region CDN
- Cost: $200+/month
