# Cloudflare Security Configuration for AtlasVS

## 1. Domain Setup (Required First)

1. Add your domain to Cloudflare
2. Update nameservers at your registrar
3. Wait for DNS propagation (~10 min)

---

## 2. SSL/TLS Settings

Go to: **SSL/TLS → Overview**

- Set mode to: **Full (strict)**
- Enable: **Always Use HTTPS**
- Enable: **Automatic HTTPS Rewrites**

Go to: **SSL/TLS → Edge Certificates**

- Enable: **TLS 1.3**
- Set Minimum TLS Version: **TLS 1.2**

---

## 3. Security Settings

### Firewall Rules (Security → WAF)

Create these rules:

#### Rule 1: Block Bad Countries (Optional)

```
(ip.geoip.country in {"CN" "RU" "KP"})
```

Action: Block

#### Rule 2: Protect API Endpoints

```
(http.request.uri.path contains "/api/" and not http.request.uri.path contains "/api/health")
```

Then apply rate limiting (see below)

#### Rule 3: Block Known Bad Bots

```
(cf.client.bot and not cf.verified_bot_category in {"Search Engine Crawler" "Monitoring & Analytics"})
```

Action: Block

### Rate Limiting (Security → WAF → Rate Limiting)

#### API Rate Limit

```
URL: /api/*
Requests: 100 per minute per IP
Action: Block for 1 hour
```

#### Login Rate Limit

```
URL: /api/auth/*
Requests: 10 per minute per IP
Action: Block for 1 hour
```

#### AI Generation Rate Limit

```
URL: /api/v1/staging/*
Requests: 20 per minute per IP
Action: Block for 10 minutes
```

---

## 4. Bot Protection

Go to: **Security → Bots**

- Enable: **Bot Fight Mode** (Free)
- Enable: **Block AI Scrapers** (toggle in Security settings)

---

## 5. DDoS Protection

Go to: **Security → DDoS**

- Already enabled by default!
- For extra protection, enable "I'm Under Attack Mode" if needed

---

## 6. Zero Trust Setup (For Admin Access)

### Step 1: Enable Zero Trust

Go to: https://one.dash.cloudflare.com

### Step 2: Create Access Application

1. **Applications → Add Application**
2. Select: **Self-hosted**
3. Configure:
   - Application name: `AtlasVS Admin`
   - Session duration: 24 hours
   - Application domain: `admin.yourapp.com` or `yourapp.com/admin/*`

4. Add Policy:
   - Policy name: `Team Access`
   - Action: Allow
   - Include: `Emails ending in @yourcompany.com`

   OR for specific users:
   - Include: `Email is user1@gmail.com, user2@gmail.com`

### Step 3: Protect Sensitive Routes

Add these paths to require authentication:

- `/dashboard/*` - User dashboard
- `/admin/*` - Admin panel
- `/api/admin/*` - Admin APIs

---

## 7. Page Rules (Performance + Security)

Go to: **Rules → Page Rules**

### Rule 1: Cache Static Assets

```
URL: *yourapp.com/static/*
Settings:
- Cache Level: Cache Everything
- Edge Cache TTL: 1 month
- Browser Cache TTL: 1 week
```

### Rule 2: Bypass Cache for API

```
URL: *yourapp.com/api/*
Settings:
- Cache Level: Bypass
- Security Level: High
```

### Rule 3: Protect Webhooks

```
URL: *yourapp.com/api/webhooks/*
Settings:
- Security Level: High
- Cache Level: Bypass
```

---

## 8. Security Headers

Go to: **Rules → Transform Rules → Modify Response Header**

Add these headers:

```
X-Frame-Options: SAMEORIGIN
X-Content-Type-Options: nosniff
X-XSS-Protection: 1; mode=block
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: camera=(), microphone=(), geolocation=()
Content-Security-Policy: default-src 'self'; img-src 'self' https: data:; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline';
```

---

## 9. Cloudflare Tunnel (Optional - Hide Origin IP)

Instead of exposing your GCP VM IP, use Cloudflare Tunnel:

```bash
# On your GCP VM
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared.deb

# Login
cloudflared tunnel login

# Create tunnel
cloudflared tunnel create atlasvs

# Configure
cloudflared tunnel route dns atlasvs yourapp.com

# Run
cloudflared tunnel run atlasvs
```

Benefits:

- Origin IP completely hidden
- No open ports on your server
- All traffic through Cloudflare

---

## Summary: What You Get FREE

| Feature         | Protection                  |
| --------------- | --------------------------- |
| DDoS mitigation | Unlimited attack protection |
| SSL/TLS         | Free HTTPS certificate      |
| WAF             | 5 free firewall rules       |
| Bot protection  | Block bad bots              |
| Rate limiting   | 1 free rule                 |
| Zero Trust      | 50 users free               |
| Tunnel          | Hide origin IP              |
| CDN             | Global caching              |

**Total cost: $0/month** for a very secure setup! 🎉
