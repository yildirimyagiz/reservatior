# EstateAI — App Mimarisi & Eksik Sayfa Analizi
> Prisma Schema · Backend Routes · Flutter Frontend karşılaştırmalı audit

---

## 1. MEVCUT DURUM — Flutter Router Haritası

```
/login                  ✅ LoginScreen
/                       ✅ HomePage
/dashboard              ✅ DashboardScreen
/listings/create        ✅ ListingUploadChoiceScreen
/listings/upload        ✅ CreateListingScreen
/capture/planner        ✅ VideoCapturePlannerScreen
/capture/guided         ✅ GuidedCaptureScreen
/capture/recording      ✅ GuidedRecordingScreen
/listing/:id            ✅ ListingDetailScreen
/ai/:listingId          ✅ AiVideoGenerationScreen
/editor/:listingId      ⚠️  Container (Coming Soon)
/analytics              ✅ AnalyticsScreen
/social-feed            ✅ InstagramFeedPage
/settings               ✅ SettingsScreen
```

**Bottom Nav (şu an sadece 4 tab):** Home · Dashboard · Analytics · Settings

---

## 2. EKSİK SAYFALAR — Öncelik Sıralaması

### 🔴 KRİTİK (Hemen Eklenmeli)

| Sayfa | Route | Backend Endpoint | Prisma Model |
|-------|-------|-----------------|--------------|
| Properties List | `/properties` | `GET /api/v1/properties` | `Property` |
| Property Detail | `/properties/:id` | `GET /api/v1/properties/:id` | `Property` + includes |
| Property Create/Edit | `/properties/new` | `POST /api/v1/properties` | `Property` |
| Reservations List | `/reservations` | `GET /api/v1/reservations` | `Reservation` |
| Reservation Detail | `/reservations/:id` | `GET /api/v1/reservations/:id` | `Reservation` |
| Tasks | `/tasks` | `GET /api/v1/tasks` | `Task` |
| Messages / Chat | `/messages` | `GET /api/v1/messages` | `Message` |
| Notifications | `/notifications` | `GET /api/v1/notifications` | `Notification` |
| Contracts | `/contracts` | `GET /api/v1/contracts` | `Contract` |
| Agents | `/agents` | `GET /api/v1/agents` | `Agent` |

### 🟡 ÖNEMLİ (Sprint 2)

| Sayfa | Route | Backend Endpoint | Prisma Model |
|-------|-------|-----------------|--------------|
| Reports | `/reports` | `GET /api/v1/reports` | `Report` |
| Agency Dashboard | `/agency` | `GET /api/v1/agents/:id` | `Agency` + `AgencyProfile` |
| Facilities | `/facilities` | `GET /api/v1/hoa/facilities` | `Facility` |
| Maintenance | `/maintenance` | `GET /api/v1/property-management/work-orders` | `MaintenanceWorkOrder` |
| Leases | `/leases` | `GET /api/v1/leases` | `Lease` |
| Included Services | `/services` | — (eksik route!) | `IncludedService` |
| Extra Charges | `/extra-charges` | — (eksik route!) | `ExtraCharge` |
| Calendar | `/calendar` | `GET /api/v1/calendar` | `CalendarEvent` |
| Documents | `/documents` | `GET /api/v1/documents` | `Document` |

### 🟢 TAMAMLAYICI (Sprint 3)

| Sayfa | Route | Backend Endpoint |
|-------|-------|-----------------|
| Contacts / CRM | `/contacts` | `GET /api/v1/contacts` |
| Leads | `/leads` | `GET /api/v1/leads` |
| Deals | `/deals` | `GET /api/v1/deals` |
| Financials | `/financials` | `GET /api/v1/financials` |
| Payments | `/payments` | `GET /api/v1/payments` |
| Bookings | `/bookings` | `GET /api/v1/bookings` |
| Investors | `/investors` | `GET /api/v1/investors` |
| MLS | `/mls` | `GET /api/v1/mls` |
| Market Analysis | `/market-analysis` | `GET /api/v1/market-analysis` |
| AI Chat | `/ai-chat` | `GET /api/v1/ai` |
| STR Panel | `/str` | `GET /api/v1/str` |
| Turkey/TAKBİS | `/turkey` | `GET /api/v1/turkey` |

---

## 3. BACKEND ROUTE GAP ANALİZİ

### ✅ Tam Çalışan Routes (CRUD mevcut)
- `properties` — List, Create, Get, Patch, Delete + valuations + viewings
- `tasks` — List, Create, Get, Patch, Delete
- `reservations` — List, Create, Get, Patch, Delete + conflict check
- `agents` — List, Create, Get, Patch, Delete + performance + assignments
- `contracts` — List, Create, Get, Patch, Delete + versions + signatures
- `notifications` — List, Create, read, read-all, Delete
- `messages` — List, Create, Get, Delete
- `reports` — List, Create, Get, Patch, Delete + execute

### ⚠️ Eksik veya Yetersiz Routes

#### `IncludedService` — **Route YOK**
```typescript
// Eklenecek: /api/v1/included-services
// veya property-management altında:
// GET  /api/v1/property-management/included-services
// POST /api/v1/property-management/included-services
// PATCH /api/v1/property-management/included-services/:id
// DELETE /api/v1/property-management/included-services/:id
```

#### `ExtraCharge` — **Route YOK**
```typescript
// Eklenecek: /api/v1/extra-charges
// veya reservation/:id/extra-charges
// GET  /api/v1/extra-charges?reservationId=&propertyId=
// POST /api/v1/extra-charges
// PATCH /api/v1/extra-charges/:id
// DELETE /api/v1/extra-charges/:id
```

#### `Facility` — HOA route içinde ama yetersiz
```typescript
// Mevcut: hoa.ts içinde kısmi
// Eksik: GET /api/v1/facilities/:id/bookings
// Eksik: POST /api/v1/facilities/:id/blocks  (FacilityBlock)
// Eksik: GET /api/v1/facilities/:id/availability
```

#### `Agency` + `AgencyProfile` — Ayrı route yok
```typescript
// agents.ts include ediyor ama:
// GET  /api/v1/agencies — eksik
// POST /api/v1/agencies — eksik
// GET  /api/v1/agencies/:id/agents — eksik
// GET  /api/v1/agencies/:id/stats — eksik
```

#### `Tenant` — Lease route içinde kısmi
```typescript
// Eksik: GET /api/v1/tenants
// Eksik: GET /api/v1/tenants/:id/leases
// Eksik: GET /api/v1/tenants/:id/payments
```

#### `Discount` + `PricingRule` — **Route YOK**
```typescript
// STR/Booking yönetimi için kritik
// GET  /api/v1/pricing-rules?listingId=
// POST /api/v1/pricing-rules
// GET  /api/v1/discounts?orgId=
// POST /api/v1/discounts
```

#### `PropertyInventory` — property-management içinde eksik
```typescript
// GET  /api/v1/property-management/inventory?propertyId=
// POST /api/v1/property-management/inventory
// PATCH /api/v1/property-management/inventory/:id
```

#### `Offer` + `NegotiationOffer` — sales-process içinde kısmi
```typescript
// Eksik endpoint: GET /api/v1/sales-process/offers/:id/negotiate
// Eksik: POST /api/v1/sales-process/offers/:id/counter
// Eksik: PATCH /api/v1/sales-process/offers/:id/accept
// Eksik: PATCH /api/v1/sales-process/offers/:id/reject
```

---

## 4. FLUTTER HİYERARŞİ — ÖNERİLEN YAPI

```
lib/
├── core/
│   ├── theme/              ✅ app_theme.dart
│   ├── network/            ✅ dio_client.dart, api_endpoints.dart
│   ├── localization/       ✅ app_localizations.dart
│   └── services/           ✅ mevcut servisler
│
├── features/
│   ├── auth/               ✅ Tam
│   ├── home/               ✅ Tam
│   ├── dashboard/          ✅ Tam
│   ├── analytics/          ✅ Tam
│   ├── settings/           ✅ Tam
│   ├── social_feed/        ✅ Tam
│   ├── listings/           ✅ Kısmi (create var, list yok)
│   ├── ai_chat/            ✅ Tam
│   ├── ai_listing/         ✅ Tam
│   ├── video_editor/       ✅ Tam
│   │
│   │   ─── EKSİK FEATURE KLASÖRLER ───
│   │
│   ├── properties/         ❌ Sadece repository var, screen yok
│   │   ├── data/
│   │   │   ├── models/property_model.dart
│   │   │   └── repositories/property_repository.dart  ✅ mevcut
│   │   ├── domain/
│   │   │   ├── entities/property_entity.dart
│   │   │   └── usecases/property_usecases.dart
│   │   └── presentation/
│   │       ├── providers/property_providers.dart
│   │       └── screens/
│   │           ├── property_list_screen.dart           ❌ YOK
│   │           ├── property_detail_screen.dart         ❌ YOK
│   │           └── property_form_screen.dart           ❌ YOK
│   │
│   ├── reservations/       ⚠️ Entity+usecase var, screen eksik
│   │   └── presentation/screens/
│   │       ├── reservation_list_screen.dart            ❌ YOK
│   │       └── reservation_detail_screen.dart          ❌ YOK
│   │
│   ├── tasks/              ❌ Hiçbir şey yok
│   │   └── presentation/screens/
│   │       ├── task_list_screen.dart                   ❌ YOK
│   │       └── task_detail_screen.dart                 ❌ YOK
│   │
│   ├── messaging/          ⚠️ Repository+entity var, screen eksik
│   │   └── presentation/screens/
│   │       ├── inbox_screen.dart                       ❌ YOK
│   │       └── conversation_screen.dart                ❌ YOK
│   │
│   ├── notifications/      ❌ Sadece widget (notification_center) var
│   │   └── presentation/screens/
│   │       └── notifications_screen.dart               ❌ YOK
│   │
│   ├── contracts/          ❌ Hiçbir şey yok
│   │   └── presentation/screens/
│   │       ├── contract_list_screen.dart               ❌ YOK
│   │       └── contract_detail_screen.dart             ❌ YOK
│   │
│   ├── agents/             ❌ Sadece agency_dashboard var
│   │   └── presentation/screens/
│   │       ├── agent_list_screen.dart                  ❌ YOK
│   │       └── agent_detail_screen.dart                ❌ YOK
│   │
│   ├── reports/            ❌ Hiçbir şey yok
│   │   └── presentation/screens/
│   │       └── reports_screen.dart                     ❌ YOK
│   │
│   ├── facilities/         ⚠️ Sadece entity var
│   │   └── presentation/screens/
│   │       └── facility_screen.dart                    ❌ YOK
│   │
│   ├── maintenance/        ❌ Hiçbir şey yok
│   ├── leases/             ❌ Hiçbir şey yok
│   ├── calendar/           ❌ Hiçbir şey yok
│   ├── documents/          ❌ Hiçbir şey yok
│   ├── included_services/  ❌ Hiçbir şey yok
│   └── extra_charges/      ❌ Hiçbir şey yok
│
└── shared/
    └── widgets/            ✅ app_widgets.dart
```

---

## 5. YENİ BOTTOM NAV ÖNERİSİ

Mevcut 4 tab yetersiz. Önerilen **5 tab** yapısı:

```
┌─────────────────────────────────────────────────────┐
│  🏠 Home  │  🏢 Props  │  📋 Tasks  │  💬 Msgs  │  👤 More  │
└─────────────────────────────────────────────────────┘
```

| Tab | Path | İçerik |
|-----|------|--------|
| Home | `/` | HomePage (mevcut) |
| Properties | `/properties` | PropertyListScreen |
| Tasks | `/tasks` | TaskListScreen |
| Messages | `/messages` | InboxScreen |
| More | `/more` | Drawer (Reports, Contracts, Agents, Settings, Analytics, ...) |

---

## 6. GEREKLİ ROUTE EKLEMELERİ (main.dart)

```dart
// Eklenecek GoRoute'lar:

// ── Properties ───────────────────────────────────
GoRoute(path: '/properties',           builder: (ctx, s) => const PropertyListScreen()),
GoRoute(path: '/properties/new',       builder: (ctx, s) => const PropertyFormScreen()),
GoRoute(path: '/properties/:id',       builder: (ctx, s) => PropertyDetailScreen(id: s.pathParameters['id']!)),
GoRoute(path: '/properties/:id/edit',  builder: (ctx, s) => PropertyFormScreen(id: s.pathParameters['id'])),

// ── Reservations ─────────────────────────────────
GoRoute(path: '/reservations',         builder: (ctx, s) => const ReservationListScreen()),
GoRoute(path: '/reservations/new',     builder: (ctx, s) => const ReservationFormScreen()),
GoRoute(path: '/reservations/:id',     builder: (ctx, s) => ReservationDetailScreen(id: s.pathParameters['id']!)),

// ── Tasks ────────────────────────────────────────
GoRoute(path: '/tasks',                builder: (ctx, s) => const TaskListScreen()),
GoRoute(path: '/tasks/new',            builder: (ctx, s) => const TaskFormScreen()),
GoRoute(path: '/tasks/:id',            builder: (ctx, s) => TaskDetailScreen(id: s.pathParameters['id']!)),

// ── Messages ─────────────────────────────────────
GoRoute(path: '/messages',             builder: (ctx, s) => const InboxScreen()),
GoRoute(path: '/messages/:threadId',   builder: (ctx, s) => ConversationScreen(threadId: s.pathParameters['threadId']!)),

// ── Notifications ────────────────────────────────
GoRoute(path: '/notifications',        builder: (ctx, s) => const NotificationsScreen()),

// ── Contracts ────────────────────────────────────
GoRoute(path: '/contracts',            builder: (ctx, s) => const ContractListScreen()),
GoRoute(path: '/contracts/new',        builder: (ctx, s) => const ContractFormScreen()),
GoRoute(path: '/contracts/:id',        builder: (ctx, s) => ContractDetailScreen(id: s.pathParameters['id']!)),

// ── Agents & Agency ──────────────────────────────
GoRoute(path: '/agents',               builder: (ctx, s) => const AgentListScreen()),
GoRoute(path: '/agents/:id',           builder: (ctx, s) => AgentDetailScreen(id: s.pathParameters['id']!)),
GoRoute(path: '/agency',               builder: (ctx, s) => const AgencyDashboardScreen()),

// ── Reports ──────────────────────────────────────
GoRoute(path: '/reports',              builder: (ctx, s) => const ReportsScreen()),
GoRoute(path: '/reports/:id',          builder: (ctx, s) => ReportDetailScreen(id: s.pathParameters['id']!)),

// ── Facilities ───────────────────────────────────
GoRoute(path: '/facilities',           builder: (ctx, s) => const FacilityListScreen()),
GoRoute(path: '/facilities/:id',       builder: (ctx, s) => FacilityDetailScreen(id: s.pathParameters['id']!)),

// ── Maintenance ──────────────────────────────────
GoRoute(path: '/maintenance',          builder: (ctx, s) => const WorkOrderListScreen()),
GoRoute(path: '/maintenance/:id',      builder: (ctx, s) => WorkOrderDetailScreen(id: s.pathParameters['id']!)),

// ── Leases ───────────────────────────────────────
GoRoute(path: '/leases',               builder: (ctx, s) => const LeaseListScreen()),
GoRoute(path: '/leases/:id',           builder: (ctx, s) => LeaseDetailScreen(id: s.pathParameters['id']!)),

// ── Calendar ─────────────────────────────────────
GoRoute(path: '/calendar',             builder: (ctx, s) => const CalendarScreen()),

// ── Documents ────────────────────────────────────
GoRoute(path: '/documents',            builder: (ctx, s) => const DocumentListScreen()),
GoRoute(path: '/documents/:id',        builder: (ctx, s) => DocumentDetailScreen(id: s.pathParameters['id']!)),

// ── Services (Included/Extra) ────────────────────
GoRoute(path: '/services',             builder: (ctx, s) => const ServicesScreen()),

// ── More / Drawer ────────────────────────────────
GoRoute(path: '/more',                 builder: (ctx, s) => const MoreScreen()),
```

---

## 7. EKSİK BACKEND ROUTES — Eklenecek Dosyalar

### `routes/agencies.ts` — YENİ DOSYA
```typescript
export const agencyRoutes = new Elysia({ prefix: "/agencies" })
  .use(authMiddleware)
  .get("/", ...)          // List agencies
  .post("/", ...)         // Create agency
  .get("/:id", ...)       // Agency detail + members
  .patch("/:id", ...)     // Update agency
  .get("/:id/agents", ...)     // Agency agents
  .get("/:id/stats", ...)      // Performance stats
  .get("/:id/listings", ...)   // Agency listings
```

### `routes/included-services.ts` — YENİ DOSYA
```typescript
export const includedServiceRoutes = new Elysia({ prefix: "/included-services" })
  .use(authMiddleware)
  .get("/", ...)          // ?propertyId= ?orgId=
  .post("/", ...)         // Create service
  .get("/:id", ...)
  .patch("/:id", ...)
  .delete("/:id", ...)
```

### `routes/extra-charges.ts` — YENİ DOSYA
```typescript
export const extraChargeRoutes = new Elysia({ prefix: "/extra-charges" })
  .use(authMiddleware)
  .get("/", ...)          // ?reservationId= ?orgId=
  .post("/", ...)
  .patch("/:id", ...)
  .delete("/:id", ...)
```

### `routes/tenants.ts` — YENİ DOSYA
```typescript
export const tenantRoutes = new Elysia({ prefix: "/tenants" })
  .use(authMiddleware)
  .get("/", ...)
  .get("/:id", ...)
  .get("/:id/leases", ...)
  .get("/:id/payments", ...)
  .get("/:id/maintenance", ...)
```

### `routes/pricing-rules.ts` — YENİ DOSYA
```typescript
export const pricingRuleRoutes = new Elysia({ prefix: "/pricing-rules" })
  .use(authMiddleware)
  .get("/", ...)          // ?listingId=
  .post("/", ...)
  .patch("/:id", ...)
  .delete("/:id", ...)
```

---

## 8. ROUTER.TS GÜNCELLEMESİ

```typescript
// Eklenecek importlar:
import { agencyRoutes }           from "./routes/agencies";
import { includedServiceRoutes }  from "./routes/included-services";
import { extraChargeRoutes }      from "./routes/extra-charges";
import { tenantRoutes }           from "./routes/tenants";
import { pricingRuleRoutes }      from "./routes/pricing-rules";

// .use() eklemeleri — CRM bölümüne:
.use(agencyRoutes)

// Transactions bölümüne:
.use(tenantRoutes)
.use(includedServiceRoutes)
.use(extraChargeRoutes)
.use(pricingRuleRoutes)
```

---

## 9. WIDGET EKSİKLERİ

### Şu an var:
- `PropertyCard` + `PropertyCardSimple` ✅
- `MetricsOverview` ✅
- `QuickActionsGrid` ✅
- `NotificationCenter` ✅ (modal widget)

### Eklenmesi Gereken Widgetlar:

| Widget | Kullanım Yeri |
|--------|--------------|
| `TaskCard` | TaskListScreen |
| `ReservationCard` | ReservationListScreen |
| `ContractStatusBadge` | ContractListScreen + PropertyDetail |
| `AgentCard` | AgentListScreen |
| `MessageBubble` | ConversationScreen |
| `ConversationTile` | InboxScreen |
| `NotificationTile` | NotificationsScreen |
| `FacilityCard` | FacilityListScreen |
| `WorkOrderCard` | MaintenanceScreen |
| `LeaseCard` | LeaseListScreen |
| `ReportChart` | ReportsScreen |
| `IncludedServiceChip` | PropertyDetail + ReservationDetail |
| `ExtraChargeRow` | ReservationDetail |
| `PriceBreakdown` | ReservationDetail + BookingDetail |
| `CalendarEventTile` | CalendarScreen |
| `DocumentTile` | DocumentListScreen |
| `StatusTimeline` | Contract + Reservation detail |
| `CommissionSummary` | AgentDetail + DealDetail |

---

## 10. ÖZET — SPRINT PLANI

### Sprint 1 (Kritik) — ~2 hafta
1. `main.dart` route güncellemesi (tüm routes ekle)
2. `PropertyListScreen` + `PropertyDetailScreen`
3. `TaskListScreen` + `TaskDetailScreen`
4. `ReservationListScreen` + `ReservationDetailScreen`
5. Bottom Nav 5 tab'a güncelle
6. Backend: `agencies.ts` + `tenants.ts` route dosyaları

### Sprint 2 (Önemli) — ~2 hafta
1. `InboxScreen` + `ConversationScreen`
2. `NotificationsScreen` (tam sayfa)
3. `ContractListScreen` + `ContractDetailScreen`
4. `AgentListScreen` + `AgentDetailScreen`
5. `ReportsScreen`
6. Backend: `included-services.ts` + `extra-charges.ts`

### Sprint 3 (Tamamlayıcı) — ~2 hafta
1. `FacilityListScreen` + `FacilityDetailScreen`
2. `WorkOrderListScreen` (Maintenance)
3. `LeaseListScreen` + `LeaseDetailScreen`
4. `CalendarScreen`
5. `DocumentListScreen`
6. `ServicesScreen` (Included + Extra)
7. Backend: `pricing-rules.ts`

---

*Rapor tarihi: 2026-03-19 | EstateAI v1.x Flutter + Elysia/Prisma Stack*
