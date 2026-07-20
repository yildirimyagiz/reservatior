# Reservatior Platform — Durum Raporu
**Tarih:** 20 Temmuz 2026  
**Rapor:** GitHub ↔ Production Container Karşılaştırması

---

## Özet

GitHub (`origin/master`) ile production container arasında **ciddi yapısal farklılıklar** var. İki codebase farklı yönlere evrilmiş durumda.

| Metrik | GitHub | Container | Fark |
|--------|--------|-----------|------|
| Toplam server dosyası | 945 | 915 | -30 |
| Route dosyası | 335 | 359 | +24 (container'da fazla) |
| Prisma schema satır | 13,320 | 14,467 | +1,147 (container'da fazla) |
| domain-events.ts satır | 200 | 140 | -60 (container'da az) |
| Router satır | 708 | 767 | +59 |
| index.ts satır | 736 | 784 | +48 |
| Saga workflow | 27 | 22 | Farklı dosyalar |
| OS route prefix | `/analytics` | `/analytics-os` | Farklı konvansiyon |
| Service naming | `analytics-os` | `analytics-engine-service` | Farklı isimlendirme |

---

## 1. Farklı Domain Event Mimarisi

### GitHub (200 satır) — İnce Granülaritede Event'ler
```
LISTING_UNPUBLISHED, LISTING_EXPIRED, LISTING_PRICE_CHANGED, LISTING_VIEWED, 
LISTING_INQUIRY, LISTING_FAVORITED, LISTING_SHARED
BOOKING_CONFIRMED, BOOKING_CANCELLED, BOOKING_CHECKED_IN, BOOKING_CHECKED_OUT
PAYMENT_RECEIVED, PAYMENT_FAILED, PAYMENT_REFUNDED
INVOICE_CREATED, INVOICE_PAID, INVOICE_OVERDUE
AI_MODEL_TRAINED, AI_PREDICTION_MADE
USER_CREATED, USER_UPDATED, USER_DELETED, USER_SUSPENDED
TRUST_* (7 event)
AD_* (campaign events)
```

### Container (140 satır) — Daha Geniş Event'ler
```
AGENT_REGISTERED, AGENT_STATUS_CHANGED
LISTING_CREATED (tek event)
ESCROW_CREATED, ESCROW_RELEASED, ESCROW_REFUNDED
BOOKING_STATUS_CHANGED (tek event)
+ Tüm OS-specific event'ler (360+ toplam)
```

**Sonuç:** GitHub event'leri daha detaylı, container daha konsolide.

---

## 2. Route Farkları

### Container'da olan ama GitHub'da OLMAYAN 24 route:
```
ads-os.ts, asset-marketplace.ts, bank-account.ts, commerce-agent.ts,
commerce-campaign.ts, commerce-order.ts, commission-engine.ts, developer-os.ts,
financial-audit-log.ts, governance-os.ts, income-certificate.ts, investment-os.ts,
kumbara-deposit.ts, operations-os.ts, partner-os.ts, product-bundle.ts,
product.ts, purchase-intent.ts, reo-portfolio.ts, security-os.ts,
seo-data.ts, supplier.ts, universal-trust-score.ts, user-os.ts
```

### GitHub'da olan ama Container'da OLMAYAN route:
**Yok** — Container, GitHub'ın süper kümesi.

---

## 3. Saga Workflow Farkları

### GitHub (27 saga):
```
ads-campaign, agent-management, agent-onboarding, ai-pipeline,
analytics-pipeline, api-key-lifecycle, booking-pipeline, commerce-order,
commission-payment, crm-lead, document-management, finance-pipeline,
governance-audit, identity-management, investment-lifecycle,
invite-agent-workflow, listing-management, listing-pipeline,
localization-pipeline, notification-pipeline, operations-workflow,
partner-onboarding, saga-orchestrator, security-incident,
trust-verification, user-lifecycle
```

### Container (22 saga):
```
agent-onboarding, analytics-insight, commission-payment,
developer-api-lifecycle, document-compliance, governance-compliance,
identity-security, investment-analysis, invite-agent-workflow,
lead-conversion, listing-pipeline, localization-sync,
maintenance-orchestration, notification-orchestration,
partner-onboarding, property-activation, property-lifecycle,
saga-orchestrator, security-screening, transaction, user-acquisition
```

**Sadece 5 ortak saga:** commission-payment, invite-agent-workflow, listing-pipeline, partner-onboarding, saga-orchestrator

---

## 4. Client-SEO Farkları

### Container'da OLMAYAN 18 Admin OS Route (GitHub'da var):
```
admin/agent-os, admin/ai-os, admin/analytics-os, admin/booking-os,
admin/commerce-os, admin/devapi-os, admin/document-os, admin/finance-os,
admin/governance-os, admin/identity-os, admin/listing-os,
admin/localization-os, admin/notification-os, admin/operations-os,
admin/partner-os, admin/security-os, admin/trust-os, admin/user-os
```

### Container'da olan ama GitHub'da farklı olan:
```
admin/agent-mobile, admin/audit-log, admin/bank-accounts, admin/bundles,
admin/campaigns, admin/certificates, admin/commerce-agents,
admin/commerce-orders, admin/commissions, admin/kumbara,
admin/marketplace, admin/products, admin/purchase-intents, admin/reo,
admin/seo-generator, admin/suppliers, admin/trust-score
```

### Locale Dosyaları: Eşit (20 dil)
Her iki tarafta da: ar, da, de, en, es, fi, fr, gr, hi, it, ja, ko, nl, no, pl, pt, ru, se, tr, zh

---

## 5. Production Endpoint Durumu

Tüm 17 OS endpoint'i canlı ve çalışıyor:

| OS Modülü | Endpoint | Durum |
|-----------|----------|-------|
| Finance OS | `/api/v1/finance-os/dashboard` | ✅ 200 |
| Booking OS | `/api/v1/booking-os/dashboard` | ✅ 200 |
| Listing OS | `/api/v1/listing-os/dashboard` | ✅ 200 |
| Agent OS | `/api/v1/agent-os/dashboard` | ✅ 200 |
| Investment OS | `/api/v1/investment-os/dashboard` | ✅ 200 |
| Operations OS | `/api/v1/operations-os/dashboard` | ✅ 200 |
| Security OS | `/api/v1/security-os/dashboard` | ✅ 200 |
| Governance OS | `/api/v1/governance-os/dashboard` | ✅ 200 |
| Partner OS | `/api/v1/partner-os/dashboard` | ✅ 200 |
| Developer OS | `/api/v1/developer-os/dashboard` | ✅ 200 |
| Analytics OS | `/api/v1/analytics-os/dashboard` | ✅ 200 |
| Document OS | `/api/v1/document-os/dashboard` | ✅ 200 |
| Notification OS | `/api/v1/notification-os/dashboard` | ✅ 200 |
| User OS | `/api/v1/user-os/dashboard` | ✅ 200 |
| Ads OS | `/api/v1/ads-os/dashboard` | ✅ 200 |
| Identity OS | `/api/v1/identity-os/dashboard` | ✅ 200 |
| Localization OS | `/api/v1/localization-os/dashboard` | ✅ 200 |

Swagger UI: `https://reservatior.com/docs` ✅

---

## 6. Yapılan Son İşler (Bu Oturumda)

| İş | Commit | Durum |
|----|--------|-------|
| Event emission 28+ servise eklendi | `f94bc2eb` | ✅ Deploy edildi |
| 8 yeni cross-OS saga oluşturuldu | `f94bc2eb` | ✅ Deploy edildi |
| Intelligence Graph derinleştirildi | `cf3ccca7` | ✅ Deploy edildi |
| OpenAPI 3.0.3 spec + Swagger | `0e6418a3` | ✅ Deploy edildi |
| OS-level RBAC Permission Model | `c1753fd7` | ✅ Deploy edildi |

---

## 7. Eksik OS'lar (İnşa Edilecek)

| # | OS Modülü | Açıklama |
|---|-----------|----------|
| 18 | **Commerce OS** | Products, orders, bundles, campaigns |
| 19 | **CRM OS** | Contacts, leads, client relationships |
| 20 | **Portfolio OS** | Investor portfolio, REO, valuations |
| 21 | **Platform OS** | Config, tenants, feature flags, system health |

---

## 8. Öneriler

1. **GitHub ile senkronizasyon:** İki codebase ciddi şekilde farklılaşmış. Hangisini "source of truth" olarak kullanacağınıza karar verilmeli.
2. **Container rebuild:** Client-seo container'ı 19 Temmuz'da build edilmiş, 18+ OS modülü eksik.
3. **Event modeli standardizasyonu:** GitHub ince granülarite, container geniş event kullanıyor. Biri seçilmeli.
4. **Saga standardizasyonu:** 27 vs 22 farklı saga. Ortak bir set oluşturulmalı.
5. **Eksik OS'lar:** CRM, Portfolio, Platform OS'ları inşa edilmeli.

---

**Rapor:** Yagiz Yildirim — yagizyildirim@icloud.com  
**Platform:** reservatior.com  
**Server:** 72.62.163.166 (srv1233901.hstgr.cloud)
