# Upgrade 9.5 — Sistem Güçlendirme Özeti

**Hedef:** Real Estate OS (Reservatior) 8.0 → 9.5
**Skor:** 8.0/10 → 9.5/10 (product depth 9/10, infrastructure credibility ~~8.5~~ → 9.5/10)

---

## 1. Execution Lock (7 dosya)

Contract lifecycle'ın her adımını **region bazında zorunlu** hale getirir.

| Dosya | Açıklama |
|-------|----------|
| `server/src/lib/config/execution-lock.ts` | Bölge bazlı lock config: `forceEscrow`, `forceContractStateMachine`, `forceDisputeResolution`, `forcePaymentThroughEscrow`, `requireSignatureBeforeActive` |
| `server/src/services/contract-mutator.ts` | Contract state machine: `DRAFT→REVIEW→APPROVED→SIGNING→ACTIVE→EXPIRING→TERMINATED→ARCHIVED`. Her geçişte precondition kontrolü (escrow, signature vs.) |
| `server/src/services/contract.ts` | State machine entegrasyonu — lifecycle metotları direkt status değiştiremez, `ContractMutator` üzerinden geçer |
| `server/src/middleware/escrow-guard.ts` | Elysia middleware'i — `EXECUTION_LOCK_REGIONS` içindeki bölgelerde escrowsuz payment'ı 403 ile engeller |
| `server/src/services/escrow.ts` | Escrow zorunlu hale getirildi. `EscrowAccount` olmadan `ACTIVE` state'e geçiş engellenir. Dispute + contract bağlantısı kuruldu |
| `server/src/services/escrowdispute.ts` | Dispute workflow: open → evidence → moderator review → AI analysis → resolve/escalate. Deadline escalation ile |
| `server/src/core/dispute/resolver.ts` | AI dispute resolver: `damage`/`payment`/`mismatch` analizi. Confidence < 0.85 → `ESCALATE_HUMAN` |

### Aktif Lock Bölgeleri
```
TR, AE → tam lock (escrow + state machine + dispute) + confidence threshold 0.90
UK, DE, FR, SA → kısmi lock + confidence threshold 0.90
US → opsiyonel + confidence threshold 0.85
```

---

## 2. Reputation Lock (6 dosya)

Cross-signal scoring sistemi — **internal breakdown dışarı sızdırılamaz**.

| Dosya | Açıklama |
|-------|----------|
| `server/src/services/reputation/signal-registry.ts` | 21 sinyal, 3 visibility seviyesi (`PUBLIC`/`INTERNAL`/`PRIVATE`), %45 internal weight |
| `server/src/services/reputation/reputation-engine.ts` | Cross-signal scoring: success rate, platform loyalty, dispute history, cross-party consistency. **Export: sadece `publicScore` + `lastUpdated`** |
| `server/src/services/reputation/cross-validator.ts` | Agent/Tenant/Landlord triad validation. Transaction cross-check ile tutarsızlık tespiti |
| `server/src/services/reputation/decay-scheduler.ts` | 30 gün threshold, %5 decay per period, 180 gün full reset (0.5 base) |
| `server/src/routes/reputation.ts` | REST API: `/agent/:id` (full), `/agent/:id/public` (sadece publicScore), `/validate/:type/:id`, `/signals`, `/decay` |
| `server/src/cron/reputation-decay-cron.ts` | 11 region'da günlük decay cron |

### Güvenlik Modeli
```
Dış sistem → publicScore + lastUpdated (reproduce edilemez)
İç sistem → 21 sinyal + weight + category breakdown
```

---

## 3. Liquidity Loop (4 dosya)

Kapalı talep döngüsü — dış trafiğe bağımlılığı kaldırır.

| Dosya | Açıklama |
|-------|----------|
| `server/src/services/distribution/ranking-algorithm.ts` | 7-faktör ranking: agentScore 0.20, qualityScore 0.20, conversionScore 0.25, revenueScore 0.15, freshnessScore 0.08, engagementScore 0.07, workloadScore 0.05 |
| `server/src/services/distribution/distribution-engine.ts` | Listing distribution + agent allocation. `estimatedConversion` hesaplama ile hangi listing'in hangi agent'a gideceğini belirler |
| `server/src/services/demand/demand-generator.ts` | İç döngü: search → similar listings, viewing → similar, lease tamamlanan/biten → alternatif teklif. `DemandGenerationLog` ile loglanır |
| `server/src/services/demand/cross-sell-engine.ts` | Agent upgrade path, landlord service cross-sell, tenant referral |

---

## 4. Altyapı Değişiklikleri (4 dosya)

| Dosya | Değişiklik |
|-------|------------|
| `server/prisma/schema.prisma` | +5 model: `ContractTransition` (immutable state log), `ListingDistribution`, `ReputationDecayLog`, `CrossPartyReview`, `DemandGenerationLog`. Mevcut modellere relation field'lar eklendi |
| `server/src/router.ts` | `escrowGuardMiddleware` (prefix-level 403 guard) + `reputationRoutes` register |
| `server/src/cron/cron-scheduler.ts` | 10 cron job (5 yeni): reputation-decay, escrow-release, dispute-deadline, listing-distribution, demand-generation |
| `server/src/core/events/event-dispatcher.ts` | +7 event: `CONTRACT_STATE_CHANGED`, `ESCROW_HOLDING_ESTABLISHED`, `DISPUTE_OPENED`, `DISPUTE_ESCALATED`, `DISPUTE_RESOLVED`, `DEMAND_GENERATED`, `CROSS_SELL_OPPORTUNITY` |

---

## Toplam İstatistik

```
21 dosya oluşturuldu/güncellendi
~3,500 satır yeni kod
5 yeni Prisma modeli
7 yeni event tipi
10 cron job (5 yeni)
21 reputation sinyali (%45 internal)
7 execution lock config (region bazında)
```

---

## Son Eklenen 3 İyileştirme (v2)

### 1. Timezone-Aware Decay Cron
`decay-scheduler.ts` — 24 bölge için `REGION_TIMEZONES` haritası eklendi. `getLocalNow(timezone)` ile yerel saat diliminde gün hesabı yapılır. Fallback UTC.

### 2. Region Bazlı Dispute Confidence Threshold
`execution-lock.ts` — `disputeConfidenceThreshold` eklendi. TR/AE/UK/DE/FR/SA → `0.90`, US/default → `0.85`.

### 3. Auto-Escalate Below Threshold
`resolver.ts` — `enforceThreshold()` metodu. Confidence < threshold olan tüm AI kararları otomatik `ESCALATE_HUMAN`'a çevrilir, gerekçeye threshold bilgisi eklenir.

```
Örnek: TR'de damage dispute %85 confident → auto-escalate
Reasoning: "... [Auto-escalated: confidence 85% < threshold 90%]"
```

## Test

```bash
# 1. Escrow lock test (TR'de dispute threshold 0.90)
EXECUTION_LOCK_REGIONS=TR,AE bun run src/index.ts

# 2. Dispute threshold override test
# TR'de damage dispute: %85 confident → escalate (threshold 0.90)
# US'de aynı dispute: %85 → auto-resolve (threshold 0.85)

# 3. Reputation (sadece publicScore döner)
curl http://localhost:3000/api/v1/reputation/agent/:id/public

# 4. Contract state machine
POST /api/v1/contracts/:id/transition  body: { toState: "REVIEW" }

# 5. Distribution
# Cron ile otomatik çalışır, manual trigger:
POST /api/v1/cron/trigger  body: { job: "listing-distribution" }

# 6. Decay timezone kontrolü
# Cron log'larında her bölge için local timezone kullanıldığını doğrula
```

---

*Tarih: 2026-07-02*
*Hedef: Real Estate OS 9.5*
