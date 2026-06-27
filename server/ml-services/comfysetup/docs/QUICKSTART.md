# AtlasVS Quick Start Guide

## 🚀 Production Deployment (GCP Free Tier)

### Prerequisites

- GCP Account with e2-micro VM (Always Free)
- RunPod Account (for cloud AI)
- Cloudflare Account (for R2 storage/CDN)
- Stripe Account (for payments)

---

## 1️⃣ Local Development

```bash
# Install dependencies
npm install

# Start local A1111 (for free AI generation)
cd /Users/yldyagz/testtool/stable-diffusion-webui-master
./webui.sh --api

# Start development server
cd /Users/yldyagz/testtool/atlasvs
npm run dev
```

---

## 2️⃣ Configure Environment

Edit `.env` with your credentials:

```env
# AI (choose one or more)
A1111_HOST=127.0.0.1:7860                    # Local (free)
RUNPOD_API_KEY=your_key                      # Cloud
RUNPOD_A1111_ENDPOINT_ID=your_endpoint_id    # Cloud

# CDN Storage
R2_ACCOUNT_ID=your_account_id
R2_ACCESS_KEY_ID=your_access_key
R2_SECRET_ACCESS_KEY=your_secret
R2_BUCKET_NAME=atlasvs-images

# Payments
STRIPE_SECRET_KEY=sk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...
```

---

## 3️⃣ Deploy to GCP

### Create VM

```bash
gcloud compute instances create atlasvs \
  --machine-type=e2-micro \
  --zone=us-central1-a \
  --image-family=debian-12 \
  --image-project=debian-cloud \
  --tags=http-server,https-server \
  --metadata-from-file=startup-script=deploy/gcp/startup-script.sh
```

### Deploy App

```bash
# SSH into VM
gcloud compute ssh atlasvs

# Clone repository
git clone https://github.com/your-repo/atlasvs.git /app
cd /app

# Setup environment
cp .env.example .env
nano .env  # Add your credentials

# Deploy
./deploy/deploy.sh deploy
```

---

## 4️⃣ Set Up RunPod (Cloud AI)

1. Go to [runpod.io/console](https://runpod.io/console)
2. **Serverless** → **Create Endpoint**
3. Select **Automatic1111** template
4. Settings:
   - Min Workers: 0 (scale to zero)
   - Max Workers: 3
   - Idle Timeout: 5 seconds
5. Copy **Endpoint ID** to `.env`
6. Get **API Key** from Settings → API Keys

---

## 5️⃣ Set Up Cloudflare R2

1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com)
2. **R2** → **Create bucket** (`atlasvs-images`)
3. **Settings** → **Public access** → Enable
4. **Manage R2 API Tokens** → Create token
5. Copy credentials to `.env`

---

## 6️⃣ Set Up Stripe

1. Go to [Stripe Dashboard](https://dashboard.stripe.com)
2. **Developers** → **API Keys** → Copy Secret Key
3. **Developers** → **Webhooks** → Add endpoint
   - URL: `https://yourapp.com/api/webhooks/stripe`
   - Events: All payment_intent, subscription, invoice events
4. Copy credentials to `.env`

---

## 📁 Key Files

| File                                           | Description                |
| ---------------------------------------------- | -------------------------- |
| `src/lib/storage/r2-client.ts`                 | Cloudflare R2 CDN client   |
| `src/lib/image-processor/index.ts`             | WebP conversion & resizing |
| `src/lib/stripe/client.ts`                     | Stripe payments            |
| `src/lib/stripe/webhooks.ts`                   | Webhook handlers           |
| `src/lib/a1111/client.ts`                      | Local A1111 client         |
| `backend/app/ai/runpod_a1111_client.py`        | Cloud A1111 client         |
| `src/app/api/v1/staging/generate-cdn/route.ts` | Full staging pipeline      |
| `deploy/`                                      | Deployment configs         |

---

## 💰 Cost Breakdown (Monthly)

| Service         | Free Tier     | Cost                  |
| --------------- | ------------- | --------------------- |
| GCP e2-micro    | 730 hrs/mo    | **$0**                |
| GCP Disk (30GB) | 30 GB         | **$0**                |
| GCP Egress      | 1 GB          | **$0**                |
| Cloudflare R2   | 10 GB storage | **$0**                |
| RunPod AI       | Pay per use   | ~$0.006/image         |
| **Total**       |               | **~$0.60/100 images** |

---

## 🔧 Useful Commands

```bash
# Check status
./deploy/deploy.sh status

# View logs
./deploy/deploy.sh logs

# Restart app
./deploy/deploy.sh restart

# Health check
curl http://localhost:3000/api/health
```

---

## 🌐 API Endpoints

| Endpoint                            | Description                 |
| ----------------------------------- | --------------------------- |
| `GET /api/health`                   | Health check                |
| `POST /api/v1/staging/generate-cdn` | Generate staged image (CDN) |
| `POST /api/v1/payments`             | Create payment              |
| `POST /api/webhooks/stripe`         | Stripe webhooks             |
| `GET /api/v1/staging/a1111-status`  | Check A1111 status          |
