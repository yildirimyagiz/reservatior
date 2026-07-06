# Social Media Entegrasyonları — Durum Raporu

> Son güncelleme: 2026-07-06

---

## 1. GENEL DURUM

| Platform            | Auto-Poster | AI Content | Mentions    | DB Kaydı       | Durum                         |
| ------------------- | ----------- | ---------- | ----------- | --------------- | ----------------------------- |
| **Instagram** | ✅          | ✅         | ✅          | ✅ (SocialPost) | **Aktif**               |
| **Facebook**  | ✅          | ❌         | ❌          | ✅ (SocialPost) | **Aktif** (Meta API)    |
| **LinkedIn**  | ✅          | ❌         | ❌          | ❌              | **Pasif** (token eksik) |
| **Twitter/X** | ✅          | ❌         | ✅ (mevcut) | ❌ (enum yok)   | **Aktif**               |
| **TikTok**    | ❌          | ❌         | ❌          | ❌              | **Geliştirilmedi**     |
| **YouTube**   | ❌          | ❌         | ❌          | ❌              | **Geliştirilmedi**     |

---

## 2. INSTAGRAM

### Durum: ✅ ÇALIŞIYOR

### Dosyalar

| Dosya                                            | Açıklama                                                                   |
| ------------------------------------------------ | ---------------------------------------------------------------------------- |
| `server/src/services/instagram.ts`             | Meta Graph API v21.0 — container oluşturma, publish, carousel, video/Reels |
| `server/src/services/instagram-auto-poster.ts` | Auto-poster: her 60dk yeni listing'leri Instagram'a postlar                  |
| `server/src/services/instagram-content-ai.ts`  | AI caption + hashtag üretici                                                |
| `server/src/services/instagram-mentions.ts`    | Local işletme/influencer mention yönetimi                                  |
| `server/src/routes/instagram.ts`               | REST API: verify, post-now, posts, mentions, stats                           |

### API Endpoints

```
GET  /api/v1/integrations/instagram/verify           — Bağlantı doğrulama
POST /api/v1/integrations/instagram/post-now         — Manuel post tetikle
GET  /api/v1/integrations/instagram/posts            — Son 20 post
GET  /api/v1/integrations/instagram/mentions         — Lokasyon mention önerileri
POST /api/v1/integrations/instagram/mentions         — Mention kuralı ekle
GET  /api/v1/integrations/instagram/stats            — Dashboard istatistikleri
POST /api/v1/integrations/instagram/data-deletion     — Meta veri silme callback'i
GET  /api/v1/integrations/instagram/deletion-status   — Veri silme durum sorgulama
```

### Özellikler

- **Fotoğraf + Video** carousel (10 medyaya kadar)
- **AI caption** (listing başlık, açıklama, fiyat, konum bazlı)
- **AI hashtag** (ülke + şehir + kategori bazlı)
- **@mention** (local işletme/influencer etiketleme)
- **Reels** video posting
- **SocialAIContent** kaydı (AI içerik geçmişi)
- **SocialPost** kaydı (tüm post geçmişi + engagement metrikleri)
- **Duplicate prevention** (daha önce postlanmış listing'leri atla)

### Gereken .env

```env
META_APP_ID=1983617865424037
META_APP_SECRET=ea14ad6b6dc09e0ed49b9a19c73330aa
META_PAGE_ID=<Facebook Page ID>
META_ACCESS_TOKEN=<Page Access Token>
META_INSTAGRAM_ACCOUNT_ID=<otomatik çözülür>
```

### Init

```typescript
// server/src/index.ts — aktif
import { startInstagramAutoPoster } from "./services/instagram-auto-poster";
startInstagramAutoPoster();
```

---

## 3. FACEBOOK

### Durum: ✅ ÇALIŞIYOR (Instagram ile aynı Meta API)

### Dosyalar

| Dosya                                           | Açıklama                                        |
| ----------------------------------------------- | ------------------------------------------------- |
| `server/src/services/facebook-auto-poster.ts` | Auto-poster: Facebook Page feed'e listing postlar |
| `server/src/services/instagram.ts`            | Paylaşılan Meta Graph API client                |

### Özellikler

- Facebook Page feed'e otomatik post
- Fotoğraflı post desteği
- **SocialPost** kaydı
- Instagram ile aynı `.env` (META_PAGE_ID + META_ACCESS_TOKEN)

### Eksikler

- AI caption (Instagram'daki `instagram-content-ai.ts` henüz Facebook için adapte edilmedi)
- Mention/etiket desteği yok
- Facebook Reels/Video desteği eklenebilir

### Init

```typescript
// server/src/index.ts — aktif
import { startFacebookAutoPoster } from "./services/facebook-auto-poster";
startFacebookAutoPoster();
```

---

## 4. LINKEDIN

### Durum: ⏸️ PASİF (token girilmedi)

### Dosyalar

| Dosya                                           | Açıklama                                                              |
| ----------------------------------------------- | ----------------------------------------------------------------------- |
| `server/src/services/linkedin.ts`             | LinkedIn API v2 — kişisel/şirket profiline paylaşım, token refresh |
| `server/src/services/linkedin-auto-poster.ts` | Auto-poster: her 30dk yeni property'leri LinkedIn'e postlar             |

### Özellikler

- Kişisel profile + Company page'e paralel paylaşım
- Token refresh mekanizması
- Kategori filtresi (sadece BOOKING tipi listing'ler)

### Neden Pasif?

```env
# .env'de boş:
LINKEDIN_COMPANY_ID=
LINKEDIN_PERSON_URN=
LINKEDIN_ACCESS_TOKEN=   <── BU GEREKLİ
```

Doldurulması gerekenler:

1. `LINKEDIN_ACCESS_TOKEN` — LinkedIn API v2 OAuth token
2. `LINKEDIN_PERSON_URN` — Kişisel profil URN (opsiyonel)
3. `LINKEDIN_COMPANY_ID` — Company ID (opsiyonel)

### Init

```typescript
// server/src/index.ts — başlatılıyor ama token yoksa disable oluyor
import { startLinkedInAutoPoster } from "./services/linkedin-auto-poster";
startLinkedInAutoPoster();
```

---

## 5. TWITTER / X

### Durum: ✅ ÇALIŞIYOR

### Dosyalar

| Dosya                                          | Açıklama                                                         |
| ---------------------------------------------- | ------------------------------------------------------------------ |
| `server/src/services/twitter-bot.ts`         | Twitter API v2 — tweet atma, mention izleme, reply, token refresh |
| `server/src/services/twitter-auto-poster.ts` | Auto-poster: her 60dk yeni listing'leri tweet'ler                  |
| `server/src/services/mention.ts`             | Twitter mention'ları sync + auto-reply                            |
| `server/src/services/hashtag.ts`             | Hashtag yönetimi + tweet atma                                     |
| `server/src/routes/mention.ts`               | `POST /mention/sync-twitter`, `POST /mention/:id/process`      |
| `server/src/routes/hashtag.ts`               | `POST /hashtag/post-twitter`                                     |

### Özellikler

- 280 karakter tweet (caption kısaltma)
- Medya (fotoğraf) ekleme
- Mention monitoring + auto-reply
- Hashtag yönetimi
- Token refresh (OAuth 2.0 PKCE)

### Mevcut .env (dolu)

```env
TWITTER_API_KEY=Tlc3dFdna1JPT3QzVngyX0ZXQjY6MTpjaQ
TWITTER_API_SECRET=h0ZSXydInJN0Aqs6SgPE6fYRcv1FLvArGAOSYXqapICEdP_T7z
TWITTER_BOT_ACCESS_TOKEN=<dolu>
TWITTER_BOT_REFRESH_TOKEN=<dolu>
```

### Kısıtlamalar

- `SocialPost` modelinin `SocialPlatform` enum'unda `TWITTER_X` değeri yok. Şu an `SocialPlatform` sadece `FACEBOOK | INSTAGRAM | WHATSAPP` içeriyor. Twitter post geçmişi DB'ye kaydedilmiyor.
- **Çözüm**: Prisma şemasına `TWITTER_X` ve `LINKEDIN` değerlerini eklemek için migration gerekli.

### Init

```typescript
// server/src/index.ts — aktif
import { startTwitterAutoPoster } from "./services/twitter-auto-poster";
startTwitterAutoPoster();
```

---

## 6. PRISMA SCHEMA İLİŞKİLERİ

```
SocialAccount (DB)
  ├── platform: INSTAGRAM
  ├── igUserId
  ├── pageId (Facebook Page ID)
  ├── accessToken
  └── posts → SocialPost[]

SocialPost (DB)
  ├── platform: FACEBOOK | INSTAGRAM | WHATSAPP  ← TWITTER_X/LINKEDIN eklenmeli
  ├── listingId → Listing
  ├── aiGenerationId → SocialAIContent
  ├── content, mediaUrls[], hashtags[]
  ├── externalPostId (Instagram Media ID / Facebook Post ID)
  └── status: DRAFT → SCHEDULED → PUBLISHED | FAILED

SocialAIContent (DB)
  ├── generatedText, generatedHashtags[]
  ├── contentType: POST | STORY_CAPTION | AD_COPY
  └── posts → SocialPost[]

SocialAutomationRule (DB)
  ├── triggerType: NEW_COMMENT | KEYWORD_MATCH | ...
  ├── action: AI_REPLY | CREATE_LEAD | ...
  └── keywords: ["Bodrum", "restaurant"]  ← Mention kuralları

VideoContent (DB)
  ├── url, thumbnailUrl
  ├── platform: INSTAGRAM_REELS | TIKTOK | YOUTUBE_SHORTS | LINKEDIN | FACEBOOK | TWITTER_X
  └── propertyId → Property, listingId → Listing

PropertyPhoto (DB)
  ├── url, isPrimary, sortOrder
  └── propertyId → Property
```

---

## 7. ÇALIŞMA AKIŞI

```
Yeni Listing eklendi (status: AVAILABLE)
        │
        ▼
  Cron Poll (her 60dk)
        │
        ├── Instagram Auto-Poster
        │     ├── collectMedia() → PropertyPhoto + VideoContent
        │     ├── generateInstagramContent() → AI caption + hashtag
        │     ├── getMentionsForCity() → @mention ekle
        │     ├── Meta Graph API → container oluştur → publish
        │     └── SocialPost + SocialAIContent kaydet
        │
        ├── Facebook Auto-Poster
        │     ├── buildPost() → caption oluştur
        │     ├── Meta Graph API → Page feed'e post
        │     └── SocialPost kaydet
        │
        ├── LinkedIn Auto-Poster ⏸️ (token gerekli)
        │     ├── buildShareText() → caption oluştur
        │     ├── LinkedIn API → profile + company share
        │     └── (SocialPost kaydı yok)
        │
        └── Twitter/X Auto-Poster
              ├── buildTweet() → 280 karakter tweet
              ├── Twitter API v2 → tweet at
              └── (SocialPost kaydı yok — enum eksik)
```

---

## 8. YAPILACAKLAR

### Kısa Vade

1. **LinkedIn token** — `LINKEDIN_ACCESS_TOKEN` alınıp `.env`'ye yazılmalı
2. **META_PAGE_ID + META_ACCESS_TOKEN** — Facebook Developer Console'dan alınıp yazılmalı
3. **Instagram verify** — `curl localhost:3000/api/v1/integrations/instagram/verify` çalıştırılmalı

### Orta Vade

1. **Prisma SocialPlatform enum** — `TWITTER_X` ve `LINKEDIN` değerleri eklenmeli, migration yapılmalı
2. **AI caption** — Facebook ve LinkedIn için de AI içerik üreticisi adapte edilmeli
3. **TikTok** — API entegrasyonu başlatılmalı (TikTok Business API)
4. **YouTube** — AI video (mevcut `AiVideoGeneration`) YouTube'a otomatik yüklenmeli
5. **Instagram Stories** — Hikaye posting desteği (Meta Graph API)

### Uzun Vade

1. **Cross-platform scheduler** — Tek bir arayüzden tüm platformlara post planlama
2. **Engagement analytics dashboard** — SocialAccountMetric + SocialPost engagement verileri
3. **AI mention önerileri** — Listing şehrine göre otomatik local işletme önerme
4. **Multi-account** — 23 ülke için ayrı Instagram/Facebook hesapları yönetimi

---

## 9. DOSYA LİSTESİ (ÖZET)

```
server/src/services/
├── instagram.ts                    # Meta Graph API client
├── instagram-auto-poster.ts        # Instagram auto-poster
├── instagram-content-ai.ts         # AI caption/hashtag
├── instagram-mentions.ts           # Mention yönetimi
├── facebook-auto-poster.ts         # Facebook auto-poster
├── linkedin.ts                     # LinkedIn API client
├── linkedin-auto-poster.ts         # LinkedIn auto-poster
├── twitter-bot.ts                  # Twitter/X API client
├── twitter-auto-poster.ts          # Twitter/X auto-poster
├── mention.ts                      # Twitter mention sync
├── hashtag.ts                      # Hashtag yönetimi
├── socialpost.ts                   # SocialPost CRUD
├── socialaccount.ts                # SocialAccount CRUD
├── socialaccountmetric.ts          # Metrik CRUD
├── socialcommentreply.ts           # Reply CRUD
├── socialinboundmessage.ts         # Mesaj CRUD
├── socialautomationrule.ts         # Otomasyon kuralı CRUD
├── socialaicontent.ts              # AI içerik CRUD
└── ai/ai-social-parser.ts          # AI sosyal medya parser

server/src/routes/
├── instagram.ts                    # Instagram REST API
├── mention.ts                      # Mention route
├── hashtag.ts                      # Hashtag route
├── social-account.ts               # SocialAccount CRUD route
├── social-accountmetric.ts         # Metrik CRUD route
├── social-post.ts                  # SocialPost CRUD route
├── social-aicontent.ts             # AI içerik CRUD route
├── social-automationrule.ts        # Otomasyon CRUD route
├── social-commentreply.ts          # Reply CRUD route
├── social-inboundmessage.ts        # Mesaj CRUD route
├── social-impact-counter.ts        # Impact counter route
└── social-impact-record.ts         # Impact record route
```

---

## 10. HIZLI BAŞLANGIÇ

```bash
# 1. .env'yi doldur
#    META_PAGE_ID, META_ACCESS_TOKEN,
#    LINKEDIN_ACCESS_TOKEN (varsa)

# 2. Instagram bağlantısını doğrula
curl http://localhost:3000/api/v1/integrations/instagram/verify

# 3. Instagram mention ekle (opsiyonel)
curl -X POST http://localhost:3000/api/v1/integrations/instagram/mentions \
  -H "Content-Type: application/json" \
  -d '{"keyword":"Bodrum","username":"bodrumlocal"}

# 4. Tüm platformlara manuel post
curl -X POST http://localhost:3000/api/v1/integrations/instagram/post-now
# Twitter: curl -X POST http://localhost:3000/hashtag/post-twitter
# Mention: curl -X POST http://localhost:3000/mention/sync-twitter

# 5. Post geçmişini görüntüle
curl http://localhost:3000/api/v1/integrations/instagram/posts
```
