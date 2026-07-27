# Mevcut AI Modelleri Analizi

## 🤖 Mevcut AI Modelleri

### 1. Opportunity Engine v2 (Matematiksel)
- **Dosya:** `src/intelligence/opportunity-engine-v2.ts`
- **Tür:** Deterministik matematiksel scoring (AI değil)
- **Özellikler:** Country-aware, 6 faktör (yield, price gap, demand, vacancy, risk, liquidity)
- **Prisma:** ⚠️ Kısmi (aiNeighborhoodScore, aiROIHint var ama kapsamlı değil)

### 2. Strategic Brain v2 (AI)
- **Dosya:** `src/intelligence/strategic-brain-v2.ts`
- **Tür:** Gemini AI ile explanation
- **Özellikler:** Country-specific context, structured JSON responses
- **Prisma:** ❌ Sonuçları saklanmıyor

### 3. Simulation Agent v2
- **Dosya:** `src/decision/simulation-agent-v2.ts`
- **Tür:** Country-aware commercial scenario simulation
- **Özellikler:** 6 scenario, country-specific tax rates
- **Prisma:** ❌ Sonuçları saklanmıyor

### 4. Ranking Engine v2
- **Dosya:** `src/decision/ranking-engine-v2.ts`
- **Tür:** Multi-factor opportunity ranking
- **Özellikler:** 5 faktör, country-specific weights
- **Prisma:** ❌ Sonuçları saklanmıyor

### 5. Knowledge Graph v2
- **Dosya:** `src/knowledge/knowledge-graph-v2.ts`
- **Tür:** Country-specific Neo4j relationships
- **Prisma:** ❌ Sonuçları saklanmıyor

### 6. Vector Search v2
- **Dosya:** `src/knowledge/vector-search-v2.ts`
- **Tür:** Country-aware semantic search
- **Prisma:** ❌ Sonuçları saklanmıyor

### 7. Outcome Store v2
- **Dosya:** `src/learning/outcome-store-v2.ts`
- **Tür:** Country-aware learning loop
- **Prisma:** ❌ In-memory, Prisma modeli yok

### 8. Agent Governance v2
- **Dosya:** `src/governance/agent-governance-v2.ts`
- **Tür:** Country-aware security
- **Prisma:** ❌ Audit log saklanmıyor

### 9. Agent Gateway
- **Dosya:** `src/agents/agent-interface.ts`
- **Tür:** Model-agnostic interface (Gemini, OpenAI, Claude)
- **Prisma:** ❌ Usage tracking yok

## 📊 Prisma Entegrasyon Durumu

| AI Model | Prisma Entegrasyon | Öncelik |
|----------|-------------------|---------|
| Opportunity Engine | ⚠️ Kısmi | Yüksek |
| Strategic Brain | ❌ Yok | Yüksek |
| Simulation Agent | ❌ Yok | Yüksek |
| Ranking Engine | ❌ Yok | Yüksek |
| Outcome Store | ❌ Yok | Yüksek |
| Diğerleri | ❌ Yok | Orta |

## 🎯 Kritik Eksiklik

1. **AI sonuçları Prisma'da saklanmıyor** - Tüm AI modelleri in-memory çalışıyor
2. **Learning loop modeli yok** - Prediction tracking için Prisma modeli gerekli
3. **Agent task tracking yok** - Agent orchestration için model gerekli

## 💡 Öneri

Property modeline AI sonuç alanları ekleyerek başla, ardından AIPrediction ve AgentTask modelleri oluştur.
