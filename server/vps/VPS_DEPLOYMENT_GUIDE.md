# VPS Edge Worker Deployment Guide

## 📋 Prerequisites

- VPS with Ubuntu 22.04+ or similar
- SSH access to VPS (72.62.163.166)
- PostgreSQL database access
- Google Cloud project credentials

## 🚀 Deployment Steps

### 1. Upload Files to VPS

```bash
# From local machine
scp vps/reservatior-edge.service root@72.62.163.166:/tmp/
scp vps/setup-vps-edge-worker.sh root@72.62.163.166:/tmp/
```

### 2. SSH into VPS

```bash
ssh root@72.62.163.166
```

### 3. Run Setup Script

```bash
cd /tmp
chmod +x setup-vps-edge-worker.sh
./setup-vps-edge-worker.sh
```

### 4. Deploy Application

```bash
# Clone repository or upload application files
cd /home/reservatior/reservatior-server
# Copy your application files here
```

### 5. Configure Environment Variables

Edit `/etc/systemd/system/reservatior-edge.service`:

```ini
Environment="DATABASE_URL=postgresql://user:password@localhost:5432/realestate_us"
Environment="GOOGLE_CLOUD_PROJECT=reservatior-prod"
Environment="GOOGLE_APPLICATION_CREDENTIALS=/home/reservatior/reservatior-server/gcp-key.json"
Environment="PUBSUB_EMULATOR_HOST=localhost:8085"
Environment="COUNTRY_DEFAULT=US"
```

### 6. Install Dependencies

```bash
cd /home/reservatior/reservatior-server
bun install
```

### 7. Start Service

```bash
systemctl start reservatior-edge
systemctl status reservatior-edge
```

### 8. View Logs

```bash
journalctl -u reservatior-edge -f
```

## 🔧 Service Management

### Start Service
```bash
systemctl start reservatior-edge
```

### Stop Service
```bash
systemctl stop reservatior-edge
```

### Restart Service
```bash
systemctl restart reservatior-edge
```

### Check Status
```bash
systemctl status reservatior-edge
```

### View Logs
```bash
journalctl -u reservatior-edge -f
```

### Enable on Boot
```bash
systemctl enable reservatior-edge
```

## 🔍 Troubleshooting

### Service Not Starting
```bash
# Check logs
journalctl -u reservatior-edge -n 50

# Check if port is available
netstat -tlnp | grep 8085

# Check database connection
psql -h localhost -U user -d realestate_us
```

### Permission Issues
```bash
# Fix file permissions
chown -R reservatior:reservatior /home/reservatior/reservatior-server
chmod +x /home/reservatior/reservatior-server/src/edge/event-consumer.ts
```

### Database Connection Issues
```bash
# Test database connection
psql -h localhost -U user -d realestate_us -c "SELECT 1;"
```

## 📊 Monitoring

### Health Check
```bash
# Check if service is running
systemctl is-active reservatior-edge

# Check resource usage
systemctl status reservatior-edge
```

### Log Monitoring
```bash
# Real-time logs
journalctl -u reservatior-edge -f

# Last 100 lines
journalctl -u reservatior-edge -n 100

# Logs since boot
journalctl -u reservatior-edge --since today
```

## 🔐 Security

### Firewall Configuration
```bash
# Allow necessary ports
ufw allow 22/tcp    # SSH
ufw allow 8085/tcp  # Pub/Sub emulator
ufw allow 5432/tcp  # PostgreSQL
ufw enable
```

### User Permissions
```bash
# Create reservatior user with limited permissions
useradd -m -s /bin/bash reservatior
usermod -aG postgres reservatior
```

## 📝 Configuration

### Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| DATABASE_URL | PostgreSQL connection string | `postgresql://user:pass@localhost:5432/db` |
| GOOGLE_CLOUD_PROJECT | GCP project ID | `reservatior-prod` |
| GOOGLE_APPLICATION_CREDENTIALS | Path to GCP key file | `/home/reservatior/reservatior-server/gcp-key.json` |
| PUBSUB_EMULATOR_HOST | Pub/Sub emulator host | `localhost:8085` |
| COUNTRY_DEFAULT | Default country code | `US` |

### Service Configuration

| Setting | Value | Description |
|---------|-------|-------------|
| MemoryMax | 2G | Maximum memory allocation |
| CPUQuota | 200% | CPU usage limit |
| RestartSec | 10 | Seconds before restart |
| LimitNOFILE | 65536 | Maximum open files |

## ✅ Verification

### Check Service Status
```bash
systemctl status reservatior-edge
```

Expected output: `active (running)`

### Check Database Connection
```bash
psql -h localhost -U user -d realestate_us -c "SELECT COUNT(*) FROM \"PredictionOutcome\";"
```

Expected output: Table exists and query succeeds

### Check Pub/Sub Connection
```bash
# Check if Pub/Sub emulator is running
ps aux | grep pubsub
```

Expected output: Pub/Sub emulator process running

## 🎯 Next Steps

After VPS Edge Worker is deployed:

1. **Terraform Apply** - Deploy GCP infrastructure
2. **Configure Pub/Sub** - Set up topics and subscriptions
3. **Test Event Flow** - Send test event and verify processing
4. **Monitor Performance** - Set up monitoring and alerting
