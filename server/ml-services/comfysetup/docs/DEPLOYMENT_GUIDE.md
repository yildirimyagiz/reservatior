# AtlasVS Deployment Guide

## AI Backend Architecture

AtlasVS uses a multi-tiered AI backend strategy for maximum flexibility and cost optimization.

### Current Setup (March 2026)

```
┌─────────────────────────────────────────────────────────┐
│                     AtlasVS App                         │
│              (Next.js + FastAPI Backend)                │
└──────────────┬──────────────────────────────────────────┘
               │
               ▼
    ┌──────────────────────────┐
    │  AI Engine Priority      │
    │  1. Local A1111          │ ← Free, Fastest (Dev)
    │  2. RunPod A1111         │ ← Cloud, Pay-per-use (Prod)
    │  3. VPS ComfyUI          │ ← Dedicated, Remote
    │  4. Local ComfyUI        │ ← Alternative
    │  5. RunPod ComfyUI       │ ← Cloud Fallback
    └──────────────────────────┘
```

## Infrastructure Overview

### 1. Stable Diffusion WebUI (RunPod)
- **Location**: RunPod GPU instances
- **Purpose**: Primary production image generation
- **Status**: Configured, awaiting RunPod credits
- **Cost**: Pay-per-use (~$0.0004/second)

### 2. ComfyUI (VPS)
- **Location**: Hostinger VPS (72.62.163.166:8188)
- **Purpose**: Dedicated remote generation
- **Status**: ✅ Active (systemd service)
- **Cost**: FREE (included in VPS cost)
- **Performance**: CPU-based (~30-60s per image)

### 3. Local Development
- **A1111**: localhost:7860
- **ComfyUI**: localhost:8188
- **Purpose**: Free development and testing

## Deployment Workflows

### Initial VPS Setup

```bash
# 1. Setup VPS ComfyUI
cd atlasvs
./scripts/setup-vps-comfyui.sh

# 2. Verify service
ssh root@72.62.163.166
systemctl status comfyui.service
curl http://localhost:8188

# 3. Update AtlasVS .env files
# Add: VPS_COMFY_HOST=72.62.163.166:8188
```

### RunPod Setup (When Credits Available)

```bash
# 1. Connect to RunPod via SSH
source atlasvs/runpod.config
ssh -i ~/.ssh/id_runpod_ed25519 root@$RUNPOD_HOST -p $RUNPOD_PORT

# 2. Deploy Stable Diffusion WebUI
cd stable-diffusion-webui
./webui.sh --listen --api --port 7860

# 3. Update .env with RunPod credentials
# RUNPOD_API_KEY=your_api_key
# RUNPOD_A1111_ENDPOINT_ID=your_endpoint_id
```

### AtlasVS Backend Deployment

```bash
# 1. Install dependencies
cd atlasvs/backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 2. Configure environment
cp .env.example .env
# Edit .env with your settings

# 3. Start backend
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### AtlasVS Frontend Deployment

```bash
# 1. Install dependencies
cd atlasvs
npm install

# 2. Configure environment
cp .env.example .env
# Edit .env with your settings

# 3. Development
npm run dev

# 4. Production build
npm run build
npm start
```

## Environment Variables Reference

### Backend (.env)

```bash
# A1111 (Local)
A1111_HOST=127.0.0.1:7860

# RunPod A1111 (Cloud)
RUNPOD_API_KEY=your_key_here
RUNPOD_A1111_ENDPOINT_ID=your_endpoint_id

# VPS ComfyUI (Remote)
VPS_COMFY_HOST=72.62.163.166:8188

# Local ComfyUI
COMFY_HOST=127.0.0.1:8188

# RunPod ComfyUI (Cloud)
RUNPOD_ENDPOINT_ID=your_comfy_endpoint_id
```

### Frontend (.env)

```bash
# App
NODE_ENV=production
NEXT_PUBLIC_APP_URL=https://your-domain.com

# Database
DATABASE_URL=postgresql://user:pass@host:5432/db

# Auth
AUTH_SECRET=your_secret_here

# AI Backends (same as backend)
VPS_COMFY_HOST=72.62.163.166:8188
RUNPOD_API_KEY=your_key_here
```

## Service Management

### VPS ComfyUI

```bash
# SSH into VPS
ssh root@72.62.163.166

# Service commands
systemctl status comfyui.service
systemctl restart comfyui.service
systemctl stop comfyui.service
systemctl start comfyui.service

# Logs
tail -f /var/log/comfyui.log
journalctl -u comfyui.service -f

# Update ComfyUI
cd /opt/ComfyUI
git pull
source venv/bin/activate
pip install -r requirements.txt --upgrade
systemctl restart comfyui.service
```

### RunPod Connection

```bash
# Connect to RunPod
cd atlasvs
./scripts/connect-runpod.sh

# This creates SSH tunnels:
# localhost:8188 → RunPod ComfyUI
# localhost:7860 → RunPod SD WebUI
```

## Cost Optimization Strategy

### Development
- Use **Local A1111** (FREE)
- Use **Local ComfyUI** (FREE)

### Testing/Staging
- Use **VPS ComfyUI** (FREE after VPS cost)
- ~30-60s per image, CPU-based
- Good for testing workflows

### Production (Low Volume)
- Use **VPS ComfyUI** for basic generations
- Fall back to **RunPod** for quality/speed

### Production (High Volume)
- Use **RunPod A1111** for fast GPU generation
- ~3-5s per image
- Cost: ~$0.05-0.10 per 100 images

## Monitoring & Health Checks

### VPS ComfyUI Health
```bash
curl http://72.62.163.166:8188/system_stats
```

### Backend Health
```bash
curl http://localhost:8000/api/v1/health
```

### Check Available Engines
```python
from app.ai.staging_pipeline import staging_pipeline
engine = await staging_pipeline.get_available_engine()
print(f"Active engine: {engine}")
```

## Troubleshooting

### VPS ComfyUI Not Responding
```bash
ssh root@72.62.163.166
systemctl restart comfyui.service
tail -f /var/log/comfyui.log
```

### RunPod Connection Failed
```bash
# Check SSH tunnel
ps aux | grep ssh | grep 8188

# Restart tunnel
./scripts/connect-runpod.sh
```

### Backend Can't Connect to AI Engines
```bash
# Check environment variables
cd atlasvs/backend
source venv/bin/activate
python -c "from app.core.config import settings; print(settings.VPS_COMFY_HOST)"

# Test direct connection
curl http://72.62.163.166:8188
```

## Security Considerations

### VPS Security
- [ ] Change default SSH password
- [ ] Setup SSH key authentication
- [ ] Configure firewall (ufw)
- [ ] Add fail2ban
- [ ] Setup NGINX reverse proxy with SSL

### RunPod Security
- [ ] Keep API keys in environment variables only
- [ ] Never commit credentials to git
- [ ] Rotate API keys regularly
- [ ] Monitor usage/costs

### Application Security
- [ ] Use secrets management (e.g., Vault)
- [ ] Implement rate limiting
- [ ] Add authentication to AI endpoints
- [ ] Monitor for abuse

## Performance Benchmarks

| Engine | Speed | Cost | Quality | Use Case |
|--------|-------|------|---------|----------|
| Local A1111 (GPU) | 3-5s | FREE | High | Development |
| RunPod A1111 | 3-5s | $0.0004/s | High | Production |
| VPS ComfyUI (CPU) | 30-60s | FREE* | Medium | Testing/Staging |
| Local ComfyUI (GPU) | 5-10s | FREE | High | Development |
| RunPod ComfyUI | 3-5s | $0.0004/s | High | Fallback |

*FREE after VPS hosting cost (~$5-10/month)

## Backup & Disaster Recovery

### VPS Backup
```bash
# Backup ComfyUI installation
ssh root@72.62.163.166
tar -czf /root/comfyui-backup-$(date +%Y%m%d).tar.gz /opt/ComfyUI

# Download backup
scp root@72.62.163.166:/root/comfyui-backup-*.tar.gz ./backups/
```

### Database Backup
```bash
# PostgreSQL backup
pg_dump -U postgres atlasvs > backup.sql

# Restore
psql -U postgres atlasvs < backup.sql
```

## Next Steps

1. ✅ VPS ComfyUI setup complete
2. ⏳ Add RunPod credits and test
3. ⏳ Implement NGINX reverse proxy
4. ⏳ Add SSL certificates
5. ⏳ Setup monitoring (Prometheus/Grafana)
6. ⏳ Implement automatic backups
7. ⏳ Load testing and optimization

---

**Last Updated**: 2026-03-02  
**Version**: 1.0  
**Maintained by**: AtlasVS Team
