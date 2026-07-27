# Deployment Order v1 - Revize Edilmiş Strateji

## 🎯 Stratejik Yaklaşım

Reservatior'un çekirdeği GCP üzerinde değil, VPS + Prisma + Event Architecture üzerinde kalmalı.

**GCP Rolü:**
- AI compute
- Pub/Sub
- Analytics
- Scaling

**Reservatior Mülkiyeti:**
- Scoring algoritması
- Country intelligence
- Revenue logic
- Property lifecycle
- Transaction graph

Bu yaklaşım "Gemini kullanan emlak uygulaması" olmaktan çıkarıp, AI provider bağımsız gayrimenkul işletim sistemi konumuna getiriyor.

---

## 📋 Revize Edilmiş Deployment Sırası

### Step 1: Database Migration 🔥 Çok Yüksek Öncelik

**Neden Önce?**
Bütün event zincirinin sonunda yazılacak yer hazır olmalı.

**Sıra:**
1. `schema_tr.prisma` - Turkey
2. `schema_usa.prisma` - USA
3. `schema_ae.prisma` - UAE (oluşturulmalı)
4. `schema_uk.prisma` - UK (oluşturulmalı)

**Komutlar:**
```bash
npx prisma migrate deploy
npx prisma generate
```

**Kontrol:**
```sql
SELECT * FROM PredictionOutcome LIMIT 1;
SELECT * FROM AgentTask LIMIT 1;
```

**Beklenen Sonuç:**
- PredictionOutcome tablosu oluşturulmuş
- AgentTask tablosu oluşturulmuş
- Property modelinde AI alanları eklenmiş

---

### Step 2: VPS Edge Worker 🔥 Çok Yüksek Öncelik

**Neden İkinci?**
VPS senin gerçek "control plane".

**Mimari:**
```
VPS
 |
 |
Pub/Sub
 |
 |
GCP
```

**Worker:**
```
systemd
 |
reservatior-edge-worker
 |
event-consumer.ts
```

**Kurulum:**
```bash
# VPS üzerinde
/etc/systemd/system/reservatior-edge.service
```

**Akış:**
```
Incoming Event
    ↓
Google Pub/Sub
    ↓
VPS Worker
    ↓
Database Router
    ↓
Country DB
```

**Beklenen Sonuç:**
- Systemd service çalışıyor
- Pub/Sub subscription aktif
- Database router routing doğru
- Country DB'ye yazma başarılı

---

### Step 3: Terraform Apply 🔥 Çok Yüksek Öncelik

**Neden Üçüncü?**
Artık gerçek consumer hazır.

**Deploy:**
```bash
terraform init
terraform plan -var="project_id=reservatior-prod"
terraform apply -auto-approve
```

**Beklenen:**
- Pub/Sub Topics ✅
- Subscriptions ✅
- IAM ✅
- Service Accounts ✅
- DLQ ✅

---

### Step 4: İlk Production Event 🔥 Çok Yüksek Öncelik

**Gerçek Test:**
```json
{
  "country":"TR",
  "property_id":"test_001",
  "event_type":"listing.ingested.v1"
}
```

**Akış:**
```
TR Property
    ↓
listing.ingested.v1
    ↓
Valuation Engine
    ↓
Opportunity Engine
    ↓
Strategic Brain
    ↓
Ranking
    ↓
opportunity.scored.v1
    ↓
VPS
    ↓
Prisma
```

**Kontrol:**
```sql
-- Database kontrol
SELECT * FROM Property WHERE id = 'test_001';
SELECT * FROM PredictionOutcome WHERE propertyId = 'test_001';
SELECT * FROM AgentTask WHERE propertyId = 'test_001';
```

**Beklenen Sonuç:**
- Property tablosunda kayıt var
- PredictionOutcome tablosunda kayıt var
- AgentTask tablosunda kayıt var
- Event log'da tam akış görünüyor

---

### Step 5: Vertex AI En Son Orta Öncelik

**Neden Sonra?**
Sistem Gemini olmadan bile çalışabilmeli.

**Mantık:**
```
Opportunity Engine
        |
        |
        ↓
91.4 score (üretebilmeli)
```

**Gemini Rolü:**
Sadece "neden 91.4?" açıklamalı.

**Beklenen Sonuç:**
- Opportunity Engine Gemini olmadan çalışıyor
- Strategic Brain Gemini ile açıklama ekliyor
- Fallback mekanizması çalışıyor

---

### Step 6: Cloud Run Agents Orta Öncelik

**Deploy:**
- Opportunity Engine Cloud Run service
- Strategic Brain Cloud Run service
- Simulation Agent Cloud Run service
- Ranking Engine Cloud Run service

**Beklenen Sonuç:**
- Tüm agent'lar Cloud Run'da çalışıyor
- Health checks geçiyor
- Load balancing çalışıyor

---

### Step 7: Neo4j Sonra Orta Öncelik

**Neden Sonra?**
Boş graph deploy etmek yerine önce veri lazım.

**Strateji:**
```
Önce: 1000 property
Sonra: Neo4j Import
```

**Beklenen Sonuç:**
- Neo4j instances deployed
- Graph data imported
- Relationship queries çalışıyor

---

### Step 8: BigQuery Learning Loop Orta Öncelik

**İlk aşamada basit başla:**
```json
{
  "property_id",
  "predicted_score",
  "actual_result",
  "prediction_date",
  "outcome_date"
}
```

**Sonra büyüt:**
- Model performance tracking
- Country-specific insights
- Retraining pipeline

---

### Step 9: Governance Dashboard Düşük Öncelik

**Monitoring:**
- Agent performance metrics
- Security event monitoring
- Audit log dashboard

---

## 📊 Revize Edilmiş Kritik Sıra

| Sıra | İş | Öncelik |
|------|-----|----------|
| 1 | Database migration | 🔥 Çok yüksek |
| 2 | VPS Edge Worker | 🔥 Çok yüksek |
| 3 | Terraform Apply | 🔥 Çok yüksek |
| 4 | E2E Event Test | 🔥 Çok yüksek |
| 5 | Vertex AI | Orta |
| 6 | Cloud Run Agents | Orta |
| 7 | Neo4j | Orta |
| 8 | BigQuery Learning | Orta |
| 9 | Governance Dashboard | Düşük |

---

## 🎯 Stratejik Karar

**En büyük stratejik karar:**
Reservatior'un çekirdeği GCP üzerinde değil, VPS + Prisma + Event Architecture üzerinde kalmalı.

**GCP:**
- AI compute
- Pub/Sub
- Analytics
- Scaling

**Reservatior Mülkiyeti:**
- Scoring algoritması
- Country intelligence
- Revenue logic
- Property lifecycle
- Transaction graph

Bu yaklaşım seni "Gemini kullanan emlak uygulaması" olmaktan çıkarıp, AI provider bağımsız gayrimenkul işletim sistemi konumuna getiriyor.
