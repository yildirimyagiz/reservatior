# VPS ComfyUI Setup Documentation

## Overview

ComfyUI is now deployed on Hostinger VPS (72.62.163.166) as a systemd service, providing a dedicated remote AI generation backend for AtlasVS.

## Server Details

- **VPS IP**: 72.62.163.166
- **Port**: 8188
- **User**: root
- **ComfyUI Path**: `/opt/ComfyUI`
- **Service**: `comfyui.service` (systemd)
- **Logs**: `/var/log/comfyui.log`

## Architecture

```
AtlasVS (Local/Production)
    ↓
VPS ComfyUI (72.62.163.166:8188)
    ↓
CPU-based Image Generation
```

### Priority Order for AI Engines:

1. **Local A1111** (FREE, fastest) - Primary for development
2. **RunPod A1111** (Pay-per-use) - Cloud scaling
3. **VPS ComfyUI** (Dedicated, FREE after VPS cost) - Remote dedicated
4. **Local ComfyUI** (FREE) - Alternative local
5. **RunPod ComfyUI** (Pay-per-use) - Cloud fallback

## Service Management

### Check Status
```bash
ssh root@72.62.163.166
systemctl status comfyui.service
```

### Start/Stop/Restart
```bash
systemctl start comfyui.service
systemctl stop comfyui.service
systemctl restart comfyui.service
```

### View Logs
```bash
tail -f /var/log/comfyui.log
journalctl -u comfyui.service -f
```

### Enable/Disable Auto-start
```bash
systemctl enable comfyui.service   # Start on boot
systemctl disable comfyui.service  # Don't start on boot
```

## Access

### Web Interface
```
http://72.62.163.166:8188
```

### API Endpoint
```
http://72.62.163.166:8188/api
```

## AtlasVS Integration

### Environment Variables

Add to `atlasvs/.env` and `atlasvs/backend/.env`:

```bash
# VPS ComfyUI (Hostinger VPS)
VPS_COMFY_HOST=72.62.163.166:8188
```

### Configuration

File: `atlasvs/backend/app/core/config.py`
```python
class Settings(BaseSettings):
    # ...
    VPS_COMFY_HOST: str = "72.62.163.166:8188"
```

### Usage in Code

```python
from app.ai.staging_pipeline import staging_pipeline

# Will automatically use VPS ComfyUI if available
result = await staging_pipeline.stage_image(
    image_path="path/to/image.jpg",
    room_type="living_room",
    style="modern"
)
```

## Performance Notes

- **CPU Mode**: ComfyUI runs in CPU-only mode (no GPU on VPS)
- **Speed**: Slower than GPU-based generation (~30-60s per image)
- **Cost**: FREE after VPS hosting cost (~$5-10/month)
- **Reliability**: Dedicated instance, always available

## Troubleshooting

### Service won't start
```bash
journalctl -u comfyui.service -n 50
# Check for Python errors or missing dependencies
```

### Port 8188 not accessible
```bash
netstat -tlnp | grep 8188
# Check firewall settings
ufw allow 8188
```

### Out of Memory
```bash
# Check system resources
free -h
htop
# Consider upgrading VPS or adding swap
```

### Update ComfyUI
```bash
cd /opt/ComfyUI
git pull
source venv/bin/activate
pip install -r requirements.txt --upgrade
systemctl restart comfyui.service
```

## Future Enhancements

- [ ] Add NGINX reverse proxy with SSL
- [ ] Implement request queuing
- [ ] Add monitoring (Prometheus/Grafana)
- [ ] Setup automatic backups
- [ ] Consider GPU VPS upgrade for faster generation
- [ ] Add custom models for real estate staging

## Cleanup (Old Pinokio Installation)

To free up ~90MB of disk space:

```bash
ssh root@72.62.163.166
rm -rf /opt/pinokio
rm -rf /opt/pinokio-workspace
rm -rf /opt/miniconda  # If not needed
```

## Quick Reference

| Action | Command |
|--------|---------|
| Status | `systemctl status comfyui.service` |
| Restart | `systemctl restart comfyui.service` |
| Logs | `tail -f /var/log/comfyui.log` |
| Web UI | `http://72.62.163.166:8188` |
| Setup Script | `./scripts/setup-vps-comfyui.sh` |

---

**Last Updated**: 2026-03-02  
**Maintained by**: AtlasVS Team
