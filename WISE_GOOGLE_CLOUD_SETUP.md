# Wise Payment Integration + Google Cloud Free Tier Setup

## 🎯 Hedef
Wise payment sistemi ile Google Cloud Free Tier sunucu kurarak ücretsiz hosting ve ödeme altyapısı oluşturmak.

## 💳 Wise Payment Integration

### 1. Wise API Kurulumu
```bash
# Wise API credentials
WISE_API_KEY=your_wise_api_key_here
WISE_PROFILE_ID=your_profile_id_here
```

### 2. Payment Flow Components
- **Frontend:** React payment form
- **Backend:** Wise webhook handler
- **Database:** Transaction tracking

### 3. Required Components
- [ ] PaymentForm component
- [ ] Wise webhook handler
- [ ] Transaction model
- [ ] Payment status tracking

## ☁️ Google Cloud Free Tier

### 1. Google Cloud Console Setup
```bash
# Google Cloud project setup
gcloud projects create reservatiormain-free
gcloud config set project reservatiormain-free
```

### 2. Free Tier Limits
- **Compute Engine:** 1 f1-micro instance (ayda 744 saat)
- **Cloud Storage:** 5 GB standard storage
- **Cloud Functions:** 2 milyon invocation/ay
- **App Engine:** 28 instance-saat/gün
- **Cloud Run:** 180.000 vCPU-saniye/ay

### 3. Deployment Strategy
- **Frontend:** Cloud Run (React app)
- **Backend:** Cloud Run (Elysia server)
- **Database:** Cloud SQL (PostgreSQL)
- **Storage:** Cloud Storage (media files)

## 🔧 Implementation Plan

### Phase 1: Wise Integration (1-2 gün)
1. **Backend Setup**
   - Wise API client
   - Webhook endpoint
   - Transaction model

2. **Frontend Integration**
   - Payment form component
   - Status tracking
   - Success/error handling

### Phase 2: Google Cloud Migration (3-5 gün)
1. **Database Migration**
   - PostgreSQL export/import
   - Connection strings update

2. **Application Deployment**
   - Docker containerization
   - Cloud Run deployment
   - Environment configuration

3. **DNS Configuration**
   - Custom domain setup
   - SSL certificates
   - Load balancing

## 💰 Maliyet Analizi

### Google Cloud Free Tier (Aylık)
- **Compute:** $0 (744 saat içinde)
- **Storage:** $0 (5 GB'a kadar)
- **Database:** $0 (Cloud SQL free tier)
- **Network:** $0 (1 GB'a kadar)
- **Toplam:** **$0/ay**

### Wise Payment Fees
- **International transfers:** 0.5% - 2%
- **Currency conversion:** 0.4% - 1.5%
- **Payment processing:** $0.50 - $2.00

## 🚀 Deployment Commands

### Google Cloud Deployment
```bash
# 1. Google Cloud CLI kurulumu
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# 2. Authentication
gcloud auth login
gcloud config set project reservatiormain-free

# 3. Docker build
docker build -t gcr.io/reservatiormain-free/client:latest .
docker build -t gcr.io/reservatiormain-free/server:latest .

# 4. Container push
gcloud auth configure-docker
docker push gcr.io/reservatiormain-free/client:latest
docker push gcr.io/reservatiormain-free/server:latest

# 5. Cloud Run deployment
gcloud run deploy client \
  --image gcr.io/reservatiormain-free/client:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 3001

gcloud run deploy server \
  --image gcr.io/reservatiormain-free/server:latest \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --port 3000 \
  --set-env-vars="DATABASE_URL=postgresql://user:pass@cloud-sql-proxy:5432/dbname"
```

## 📋 Checklist

### Wise Integration
- [ ] Wise API key alındı
- [ ] Webhook endpoint oluşturuldu
- [ ] Payment form component'i hazır
- [ ] Transaction tracking sistemi
- [ ] Test ödemeleri yapıldı

### Google Cloud Setup
- [ ] Google Cloud project oluşturuldu
- [ ] Free tier aktifleştirildi
- [ ] Cloud SQL PostgreSQL oluşturuldu
- [ ] Container registry hazır
- [ ] DNS ayarları yapıldı
- [ ] SSL sertifikaları yüklendi

### Migration Tasks
- [ ] Database export/import
- [ ] Environment variables güncelleme
- [ ] Docker container'ları hazırlama
- [ ] Cloud Run deployment
- [ ] Domain pointing
- [ ] Monitoring setup

## 🔗 Important Links

### Wise Developer Resources
- API Documentation: https://wise.com/api-docs/
- Dashboard: https://wise.com/dashboard/
- Webhook Guide: https://wise.com/help/api/webhooks/

### Google Cloud Resources
- Console: https://console.cloud.google.com/
- Free Tier: https://cloud.google.com/free
- Pricing: https://cloud.google.com/pricing
- Cloud Run: https://cloud.google.com/run

## ⚠️ Important Notes

1. **Free Tier Limits:** Aylık kullanım sınırlarına dikkat
2. **Wise Compliance:** KYC ve AML gereksinimleri
3. **Data Migration:** Sıfır kesinti planı
4. **DNS Propagation:** 24-48 saat sürebilir
5. **Backup Strategy:** Otomatik yedekleme sistemi

## 🎯 Success Metrics

### Technical Metrics
- **Uptime:** 99.9%+
- **Load Time:** <2 seconds
- **API Response:** <200ms
- **Error Rate:** <0.1%

### Business Metrics
- **Payment Success:** >95%
- **Transaction Time:** <30 seconds
- **User Satisfaction:** >4.5/5
- **Cost Savings:** $100+/ay (hosting)

## 🚨 Risk Mitigation

### Technical Risks
- **Free Tier Exhaustion:** Monitoring ve alerting
- **Downtime:** Multi-region deployment
- **Data Loss:** Automated backups
- **Security:** HTTPS ve authentication

### Financial Risks
- **Wise Fees:** Transparent fee structure
- **Currency Risk:** Multi-currency support
- **Fraud:** Payment verification systems
- **Compliance:** Regulatory requirements

---

**Bu setup ile aylık $100+ hosting maliyetinden tasarruf sağlanabilir!** 💰
