"use client";

import { useState, useMemo } from "react";
import { useTranslation } from "react-i18next";
import {
  Globe, Building2, CreditCard, Banknote, Shield,
  ChevronRight, CheckCircle2, AlertTriangle, Info,
  Calculator, FileText, Percent, Calendar
} from "lucide-react";
import { cn } from "@/lib/utils";

// ── Country Registry (23 countries) ─────────────────────────────────────────
const COUNTRIES = [
  { code: "TR", name: "Turkey",        currency: "TRY", flag: "🇹🇷", gateway: "iyzico",   maxInst: 12 },
  { code: "US", name: "USA",           currency: "USD", flag: "🇺🇸", gateway: "Stripe",   maxInst: 12 },
  { code: "UK", name: "United Kingdom",currency: "GBP", flag: "🇬🇧", gateway: "Lemonway", maxInst: 3  },
  { code: "DE", name: "Germany",       currency: "EUR", flag: "🇩🇪", gateway: "Lemonway", maxInst: 3  },
  { code: "FR", name: "France",        currency: "EUR", flag: "🇫🇷", gateway: "Lemonway", maxInst: 3  },
  { code: "ES", name: "Spain",         currency: "EUR", flag: "🇪🇸", gateway: "Lemonway", maxInst: 6  },
  { code: "IT", name: "Italy",         currency: "EUR", flag: "🇮🇹", gateway: "Lemonway", maxInst: 3  },
  { code: "NL", name: "Netherlands",   currency: "EUR", flag: "🇳🇱", gateway: "Lemonway", maxInst: 2  },
  { code: "AE", name: "UAE",           currency: "AED", flag: "🇦🇪", gateway: "Checkout", maxInst: 0  },
  { code: "SA", name: "Saudi Arabia",  currency: "SAR", flag: "🇸🇦", gateway: "Checkout", maxInst: 0  },
  { code: "AU", name: "Australia",     currency: "AUD", flag: "🇦🇺", gateway: "Stripe",   maxInst: 4  },
  { code: "NZ", name: "New Zealand",   currency: "NZD", flag: "🇳🇿", gateway: "Stripe",   maxInst: 0  },
  { code: "JP", name: "Japan",         currency: "JPY", flag: "🇯🇵", gateway: "Stripe",   maxInst: 0  },
  { code: "KR", name: "South Korea",   currency: "KRW", flag: "🇰🇷", gateway: "Checkout", maxInst: 0  },
  { code: "SG", name: "Singapore",     currency: "SGD", flag: "🇸🇬", gateway: "Stripe",   maxInst: 0  },
  { code: "MY", name: "Malaysia",      currency: "MYR", flag: "🇲🇾", gateway: "Checkout", maxInst: 0  },
  { code: "TH", name: "Thailand",      currency: "THB", flag: "🇹🇭", gateway: "Checkout", maxInst: 6  },
  { code: "IN", name: "India",         currency: "INR", flag: "🇮🇳", gateway: "Checkout", maxInst: 6  },
  { code: "CN", name: "China",         currency: "CNY", flag: "🇨🇳", gateway: "Checkout", maxInst: 0  },
  { code: "BR", name: "Brazil",        currency: "BRL", flag: "🇧🇷", gateway: "Checkout", maxInst: 12 },
  { code: "MX", name: "Mexico",        currency: "MXN", flag: "🇲🇽", gateway: "Stripe",   maxInst: 0  },
  { code: "AR", name: "Argentina",     currency: "ARS", flag: "🇦🇷", gateway: "Checkout", maxInst: 0  },
  { code: "CA", name: "Canada",        currency: "CAD", flag: "🇨🇦", gateway: "Stripe",   maxInst: 6  },
];

// Ülke bazlı komisyon kuralları
const COMMISSION_RULES: Record<string, { landlord: number; tenant: number; tenantAllowed: boolean }> = {
  TR: { landlord: 3.5, tenant: 3.5, tenantAllowed: true  },
  US: { landlord: 3.0, tenant: 0.0, tenantAllowed: true  },
  UK: { landlord: 7.0, tenant: 0.0, tenantAllowed: false },
  DE: { landlord: 7.0, tenant: 0.0, tenantAllowed: false },
  FR: { landlord: 3.5, tenant: 3.5, tenantAllowed: true  },
  ES: { landlord: 3.5, tenant: 0.0, tenantAllowed: true  },
  IT: { landlord: 3.5, tenant: 3.5, tenantAllowed: true  },
  NL: { landlord: 7.0, tenant: 0.0, tenantAllowed: false },
  AE: { landlord: 0.0, tenant: 5.0, tenantAllowed: true  },
  SA: { landlord: 2.0, tenant: 0.0, tenantAllowed: true  },
  AU: { landlord: 2.75,tenant: 0.0, tenantAllowed: false },
  NZ: { landlord: 3.0, tenant: 0.0, tenantAllowed: false },
  JP: { landlord: 3.0, tenant: 3.0, tenantAllowed: true  },
  KR: { landlord: 0.4, tenant: 0.4, tenantAllowed: true  },
  SG: { landlord: 1.0, tenant: 1.0, tenantAllowed: true  },
  MY: { landlord: 3.0, tenant: 0.0, tenantAllowed: true  },
  TH: { landlord: 2.5, tenant: 2.5, tenantAllowed: true  },
  IN: { landlord: 1.0, tenant: 1.0, tenantAllowed: true  },
  CN: { landlord: 3.0, tenant: 0.0, tenantAllowed: false },
  BR: { landlord: 6.0, tenant: 0.0, tenantAllowed: true  },
  MX: { landlord: 5.0, tenant: 0.0, tenantAllowed: true  },
  AR: { landlord: 4.0, tenant: 4.0, tenantAllowed: false },
  CA: { landlord: 2.5, tenant: 2.5, tenantAllowed: true  },
};

type CommissionModel = "INSTALLMENT_12" | "HYBRID_50_6" | "TRADITIONAL_1M";

interface ModelResult {
  model: CommissionModel;
  label: string;
  description: string;
  icon: React.ReactNode;
  available: boolean;
  unavailableReason?: string;
  totalCost: number;
  downPayment: number;
  installmentAmount?: number;
  installments?: number;
  platformFee: number;
  landlordTotal: number;
  tenantTotal: number;
  carryFee: number;
  gradient: string;
}

const fmt = (n: number, currency: string) =>
  new Intl.NumberFormat("tr-TR", { style: "currency", currency, minimumFractionDigits: 0, maximumFractionDigits: 0 }).format(n);

export default function SalesDealCreator() {
  const { t } = useTranslation();

  const [step, setStep] = useState<1 | 2 | 3>(1);
  const [countryCode, setCountryCode]   = useState("TR");
  const [salePrice, setSalePrice]       = useState(500000);
  const [monthlyRent, setMonthlyRent]   = useState(15000);
  const [selectedModel, setSelectedModel] = useState<CommissionModel | null>(null);

  const country = COUNTRIES.find(c => c.code === countryCode)!;
  const rules   = COMMISSION_RULES[countryCode] ?? { landlord: 3.5, tenant: 3.5, tenantAllowed: true };

  // ── Commission calculations ─────────────────────────────────────────────────
  const models = useMemo<ModelResult[]>(() => {
    const landlordBase = Math.round(salePrice * rules.landlord / 100);
    const tenantBase   = Math.round(salePrice * rules.tenant   / 100);
    const gross        = landlordBase + tenantBase;
    const platform     = Math.round(salePrice * 0.02);

    // Model A — 12 Taksit, %4 carry her taraf
    const landlordCarryA = Math.round(landlordBase * 0.04 * 12);
    const tenantCarryA   = Math.round(tenantBase   * 0.04 * 12);
    const totalA         = landlordBase + landlordCarryA + tenantBase + tenantCarryA + platform;
    const instA          = Math.round(totalA / 12);

    // Model B — %50 peşin + kalan %60 / 6 taksit
    const downLandlordB  = Math.round(landlordBase * 0.5);
    const downTenantB    = Math.round(tenantBase   * 0.5);
    const deferLandlordB = Math.round((landlordBase - downLandlordB) * 1.1);
    const deferTenantB   = Math.round((tenantBase   - downTenantB)   * 1.1);
    const downB          = downLandlordB + downTenantB + platform;
    const instB          = Math.round((deferLandlordB + deferTenantB) / 6);
    const totalB         = downB + deferLandlordB + deferTenantB;

    // Model C — Geleneksel
    const totalC = monthlyRent + platform;

    return [
      {
        model:      "INSTALLMENT_12",
        label:      country.maxInst >= 12 ? "12 Ay Taksit" : "12 Ay Taksit ⚠",
        description: `%4 carry ev sahibi + %4 carry kiracı. Toplam: ${fmt(totalA, country.currency)}`,
        icon:       <Calendar className="w-5 h-5" />,
        available:  country.maxInst >= 12,
        unavailableReason: country.maxInst < 12
          ? `${country.name} maksimum ${country.maxInst} taksit destekler → Geleneksel modele yönlendir`
          : undefined,
        totalCost:        totalA,
        downPayment:      0,
        installmentAmount: instA,
        installments:     12,
        platformFee:      platform,
        landlordTotal:    landlordBase + landlordCarryA,
        tenantTotal:      tenantBase   + tenantCarryA,
        carryFee:         landlordCarryA + tenantCarryA,
        gradient:         "from-violet-500/20 to-indigo-500/20",
      },
      {
        model:      "HYBRID_50_6",
        label:      country.maxInst >= 6 ? "Hibrit %50+%60 / 6 Taksit" : "Hibrit ⚠",
        description: `%50 peşin + kalan %60'ı 6 taksit. Geçiş eşiği ≈ ${fmt(monthlyRent, country.currency)}`,
        icon:       <CreditCard className="w-5 h-5" />,
        available:  country.maxInst >= 6,
        unavailableReason: country.maxInst < 6
          ? `${country.name} 6 taksiti desteklemiyor → Geleneksel modele yönlendir`
          : undefined,
        totalCost:        totalB,
        downPayment:      downB,
        installmentAmount: instB,
        installments:     6,
        platformFee:      platform,
        landlordTotal:    downLandlordB + deferLandlordB,
        tenantTotal:      downTenantB   + deferTenantB,
        carryFee:         (deferLandlordB - (landlordBase - downLandlordB)) + (deferTenantB - (tenantBase - downTenantB)),
        gradient:         "from-cyan-500/20 to-teal-500/20",
      },
      {
        model:      "TRADITIONAL_1M",
        label:      "Geleneksel (1 Ay Kira)",
        description: `1 aylık kira peşin ${fmt(monthlyRent, country.currency)} + %2 platform güvencesi`,
        icon:       <Banknote className="w-5 h-5" />,
        available:  true,
        totalCost:  totalC,
        downPayment: totalC,
        platformFee: platform,
        landlordTotal: landlordBase,
        tenantTotal:   tenantBase,
        carryFee:      0,
        gradient:      "from-emerald-500/20 to-green-500/20",
      },
    ];
  }, [countryCode, salePrice, monthlyRent, country, rules]);

  const sel = models.find(m => m.model === selectedModel);

  return (
    <div className="max-w-4xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3 mb-2">
        <div className="p-2 rounded-xl bg-primary/10 border border-primary/20">
          <Building2 className="w-5 h-5 text-primary" />
        </div>
        <div>
          <h1 className="text-2xl font-bold text-foreground">Sales Deal Creator</h1>
          <p className="text-sm text-muted-foreground">Global komisyon motoru — 23 ülke, 3 model</p>
        </div>
      </div>

      {/* Step Indicator */}
      <div className="flex items-center gap-2 text-xs">
        {[
          { n: 1, label: "Ülke & Mülk" },
          { n: 2, label: "Komisyon Modeli" },
          { n: 3, label: "Sözleşme Önizleme" },
        ].map((s, i) => (
          <div key={s.n} className="flex items-center gap-2">
            <button
              onClick={() => s.n < step && setStep(s.n as 1 | 2 | 3)}
              className={cn(
                "flex items-center gap-1.5 px-3 py-1.5 rounded-full font-medium transition-all",
                step === s.n
                  ? "bg-primary text-primary-foreground"
                  : step > s.n
                  ? "bg-primary/20 text-primary cursor-pointer"
                  : "bg-muted text-muted-foreground"
              )}
            >
              {step > s.n ? <CheckCircle2 className="w-3.5 h-3.5" /> : <span>{s.n}</span>}
              {s.label}
            </button>
            {i < 2 && <ChevronRight className="w-3.5 h-3.5 text-muted-foreground" />}
          </div>
        ))}
      </div>

      {/* ── STEP 1: Country & Property ──────────────────────────────────────── */}
      {step === 1 && (
        <div className="space-y-5">
          {/* Country Selector */}
          <div className="rounded-2xl border border-border bg-card p-5 space-y-3">
            <div className="flex items-center gap-2 mb-1">
              <Globe className="w-4 h-4 text-primary" />
              <span className="font-semibold text-sm">Ülke Seçimi</span>
            </div>
            <div className="grid grid-cols-4 sm:grid-cols-6 gap-2">
              {COUNTRIES.map(c => (
                <button
                  key={c.code}
                  onClick={() => setCountryCode(c.code)}
                  className={cn(
                    "flex flex-col items-center gap-1 p-2 rounded-xl border text-center transition-all",
                    countryCode === c.code
                      ? "border-primary bg-primary/10 text-primary"
                      : "border-border hover:border-primary/50 hover:bg-accent/30 text-muted-foreground"
                  )}
                >
                  <span className="text-xl">{c.flag}</span>
                  <span className="text-[10px] font-medium leading-tight">{c.code}</span>
                </button>
              ))}
            </div>
          </div>

          {/* Compliance Info */}
          <div className={cn(
            "rounded-xl border p-4 text-sm space-y-2",
            country.maxInst === 0
              ? "border-amber-500/30 bg-amber-500/5"
              : "border-emerald-500/30 bg-emerald-500/5"
          )}>
            <div className="flex items-center gap-2 font-medium">
              {country.maxInst > 0
                ? <CheckCircle2 className="w-4 h-4 text-emerald-500" />
                : <AlertTriangle className="w-4 h-4 text-amber-500" />}
              {country.name} — Regülasyon Özeti
            </div>
            <div className="grid grid-cols-2 gap-2 text-muted-foreground text-xs">
              <div>Ev Sahibi Komisyon: <span className="text-foreground font-medium">%{rules.landlord}</span></div>
              <div>Kiracı Komisyon: <span className="text-foreground font-medium">%{rules.tenant}{!rules.tenantAllowed && " (Yasak)"}</span></div>
              <div>Maks Taksit: <span className="text-foreground font-medium">{country.maxInst === 0 ? "Taksit Yok" : `${country.maxInst} Ay`}</span></div>
              <div>Gateway: <span className="text-foreground font-medium">{country.gateway}</span></div>
            </div>
            {!rules.tenantAllowed && (
              <p className="text-xs text-amber-600 dark:text-amber-400 flex items-center gap-1">
                <AlertTriangle className="w-3 h-3" />
                Bu ülkede kiracıdan komisyon alınamaz — Bestellerprinzip / Tenant Fees Act uygulanır
              </p>
            )}
          </div>

          {/* Property Details */}
          <div className="rounded-2xl border border-border bg-card p-5 space-y-4">
            <span className="font-semibold text-sm flex items-center gap-2">
              <Calculator className="w-4 h-4 text-primary" />
              Finansal Detaylar
            </span>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1.5">
                <label className="text-xs font-medium text-muted-foreground">Satış Fiyatı</label>
                <div className="flex items-center gap-2 border border-border rounded-xl px-3 py-2 bg-background">
                  <span className="text-xs text-muted-foreground">{country.currency}</span>
            <input
              type="number"
              aria-label="Sale price"
              value={salePrice}
              onChange={(e) => setSalePrice(Number(e.target.value))}
              className="bg-black/40 border-white/10 text-white rounded-xl p-3 w-full"
              placeholder="0.00"
            />
                </div>
              </div>
              <div className="space-y-1.5">
                <label className="text-xs font-medium text-muted-foreground">Aylık Kira (Hibrit Eşiği)</label>
                <div className="flex items-center gap-2 border border-border rounded-xl px-3 py-2 bg-background">
                  <span className="text-xs text-muted-foreground">{country.currency}</span>
            <input
              type="number"
              aria-label="Monthly rent for hybrid threshold"
              value={monthlyRent}
              onChange={(e) => setMonthlyRent(Number(e.target.value))}
              className="bg-black/40 border-white/10 text-white rounded-xl p-3 w-full"
              placeholder="0.00"
            />
                </div>
              </div>
            </div>
            {/* Quick calc preview */}
            <div className="grid grid-cols-3 gap-3 pt-1">
              {[
                { label: "Brüt Komisyon", val: Math.round(salePrice * (rules.landlord + rules.tenant) / 100) },
                { label: "Platform %2", val: Math.round(salePrice * 0.02) },
                { label: "Carry (12 ay %4+4)", val: Math.round(salePrice * (rules.landlord + rules.tenant) / 100 * 0.04 * 12) },
              ].map(item => (
                <div key={item.label} className="rounded-xl bg-muted/40 p-3 text-center">
                  <p className="text-lg font-bold text-foreground">{fmt(item.val, country.currency)}</p>
                  <p className="text-[10px] text-muted-foreground mt-0.5">{item.label}</p>
                </div>
              ))}
            </div>
          </div>

          <button
            onClick={() => setStep(2)}
            className="w-full py-3 rounded-xl bg-primary text-primary-foreground font-semibold text-sm hover:bg-primary/90 transition-colors flex items-center justify-center gap-2"
          >
            Komisyon Modeli Seç <ChevronRight className="w-4 h-4" />
          </button>
        </div>
      )}

      {/* ── STEP 2: Commission Model ────────────────────────────────────────── */}
      {step === 2 && (
        <div className="space-y-4">
          <p className="text-sm text-muted-foreground">
            <span className="font-semibold text-foreground">{country.flag} {country.name}</span> için uygulanabilir modeller:
          </p>

          <div className="space-y-3">
            {models.map(m => (
              <button
                key={m.model}
                onClick={() => m.available && setSelectedModel(m.model)}
                disabled={!m.available}
                className={cn(
                  "w-full text-left rounded-2xl border p-4 transition-all",
                  !m.available
                    ? "opacity-50 cursor-not-allowed border-border bg-muted/20"
                    : selectedModel === m.model
                    ? "border-primary bg-primary/10 shadow-md"
                    : "border-border hover:border-primary/50 bg-card hover:bg-accent/20 cursor-pointer"
                )}
              >
                <div className={cn("absolute inset-0 rounded-2xl bg-gradient-to-br opacity-30 pointer-events-none", m.gradient)} />
                <div className="relative flex items-start gap-3">
                  <div className={cn(
                    "p-2 rounded-lg",
                    selectedModel === m.model ? "bg-primary/20" : "bg-muted/60"
                  )}>
                    {m.icon}
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 mb-1">
                      <span className="font-semibold text-sm">{m.label}</span>
                      {m.available
                        ? <span className="text-[10px] px-2 py-0.5 rounded-full bg-emerald-500/15 text-emerald-600 border border-emerald-500/20">Uygun</span>
                        : <span className="text-[10px] px-2 py-0.5 rounded-full bg-amber-500/15 text-amber-600 border border-amber-500/20">Fallback</span>}
                    </div>
                    <p className="text-xs text-muted-foreground">{m.description}</p>
                    {m.unavailableReason && (
                      <p className="text-xs text-amber-600 dark:text-amber-400 mt-1 flex items-center gap-1">
                        <AlertTriangle className="w-3 h-3" />
                        {m.unavailableReason}
                      </p>
                    )}
                    {m.available && (
                      <div className="mt-3 grid grid-cols-3 gap-2">
                        {[
                          { label: "Toplam Maliyet", val: fmt(m.totalCost, country.currency) },
                          m.installmentAmount
                            ? { label: `${m.installments} Taksit`, val: fmt(m.installmentAmount, country.currency) + "/ay" }
                            : { label: "Peşin", val: fmt(m.downPayment, country.currency) },
                          { label: "Platform %2", val: fmt(m.platformFee, country.currency) },
                        ].map(item => (
                          <div key={item.label} className="text-center">
                            <p className="text-sm font-bold text-foreground">{item.val}</p>
                            <p className="text-[10px] text-muted-foreground">{item.label}</p>
                          </div>
                        ))}
                      </div>
                    )}
                    {/* Split detail */}
                    {m.available && (
                      <div className="mt-2 flex gap-3 text-xs text-muted-foreground border-t border-border pt-2">
                        <span>🏠 Ev Sahibi: <strong className="text-foreground">{fmt(m.landlordTotal, country.currency)}</strong></span>
                        <span>👤 Kiracı: <strong className="text-foreground">{fmt(m.tenantTotal, country.currency)}</strong></span>
                        {m.carryFee > 0 && <span>💱 Carry: <strong className="text-amber-500">{fmt(m.carryFee, country.currency)}</strong></span>}
                      </div>
                    )}
                  </div>
                  {selectedModel === m.model && (
                    <CheckCircle2 className="w-5 h-5 text-primary shrink-0 mt-0.5" />
                  )}
                </div>
              </button>
            ))}
          </div>

          <div className="flex gap-3">
            <button
              onClick={() => setStep(1)}
              className="flex-1 py-3 rounded-xl border border-border text-sm font-medium hover:bg-accent/30 transition-colors"
            >
              Geri
            </button>
            <button
              onClick={() => selectedModel && setStep(3)}
              disabled={!selectedModel}
              className="flex-1 py-3 rounded-xl bg-primary text-primary-foreground font-semibold text-sm hover:bg-primary/90 transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
            >
              Sözleşme Önizle <FileText className="w-4 h-4" />
            </button>
          </div>
        </div>
      )}

      {/* ── STEP 3: Contract Preview ────────────────────────────────────────── */}
      {step === 3 && sel && (
        <div className="space-y-5">
          <div className="rounded-2xl border border-primary/30 bg-primary/5 p-5">
            <div className="flex items-center gap-2 mb-4">
              <FileText className="w-4 h-4 text-primary" />
              <span className="font-semibold text-sm">Sözleşme Özeti — {country.flag} {country.name}</span>
            </div>

            {/* Commission Model Summary */}
            <div className={cn("rounded-xl p-4 mb-4 bg-gradient-to-br", sel.gradient, "border border-border")}>
              <div className="flex items-center gap-2 mb-3">
                {sel.icon}
                <span className="font-bold">{sel.label}</span>
              </div>
              <div className="grid grid-cols-2 gap-3 text-sm">
                <div className="space-y-1">
                  <p className="text-xs text-muted-foreground">Toplam Maliyet</p>
                  <p className="text-xl font-bold text-foreground">{fmt(sel.totalCost, country.currency)}</p>
                </div>
                {sel.installmentAmount && (
                  <div className="space-y-1">
                    <p className="text-xs text-muted-foreground">Aylık Taksit</p>
                    <p className="text-xl font-bold text-foreground">{fmt(sel.installmentAmount, country.currency)}</p>
                  </div>
                )}
                <div className="space-y-1">
                  <p className="text-xs text-muted-foreground">🏠 Ev Sahibi</p>
                  <p className="font-semibold">{fmt(sel.landlordTotal, country.currency)}</p>
                </div>
                <div className="space-y-1">
                  <p className="text-xs text-muted-foreground">👤 Kiracı/Alıcı</p>
                  <p className="font-semibold">{rules.tenantAllowed ? fmt(sel.tenantTotal, country.currency) : "Yasal İstisna"}</p>
                </div>
              </div>
              {sel.carryFee > 0 && (
                <div className="mt-3 flex items-center gap-2 text-xs text-amber-600 bg-amber-500/10 rounded-lg p-2">
                  <Percent className="w-3 h-3" />
                  Carry Bedeli: {fmt(sel.carryFee, country.currency)} — Her taraf kendi %4'ünü öder
                </div>
              )}
            </div>

            {/* Platform Fee */}
            <div className="flex items-center gap-3 p-3 rounded-xl bg-muted/40 text-sm">
              <Shield className="w-4 h-4 text-primary shrink-0" />
              <div>
                <p className="font-medium">%2 Platform Güvencesi + Sigorta</p>
                <p className="text-xs text-muted-foreground">{fmt(sel.platformFee, country.currency)} — Tüm işlemlerde Reservatior'a kalır</p>
              </div>
            </div>

            {/* Warning for non-tenant countries */}
            {!rules.tenantAllowed && (
              <div className="flex items-start gap-2 p-3 rounded-xl bg-amber-500/10 border border-amber-500/20 text-xs text-amber-700 dark:text-amber-400 mt-3">
                <AlertTriangle className="w-4 h-4 shrink-0 mt-0.5" />
                <div>
                  <p className="font-medium">{country.name}: Kiracı Komisyonu Yasak</p>
                  <p>Tüm komisyon ev sahibinden tahsil edilmektedir. Kiracıya herhangi bir ücret yansıtılmaz.</p>
                </div>
              </div>
            )}

            {/* Value Proposition / Upsell Pitch */}
            <div className="flex items-start gap-3 p-4 rounded-xl bg-blue-500/10 border border-blue-500/20 text-sm mt-3">
              <Info className="w-5 h-5 text-blue-600 dark:text-blue-400 shrink-0 mt-0.5" />
              <div>
                <p className="font-semibold text-blue-700 dark:text-blue-400">💡 Düzenli Gelir (ARR) Kapatma Argümanı</p>
                <p className="text-muted-foreground mt-1 leading-relaxed text-xs">
                  {country.name} pazarında geleneksel emlak yönetim şirketleri sadece basit bir kira takibi için yıllık <strong>%8 - %10</strong> komisyon alırken, hiçbir operasyonel garanti sunmazlar. <br/><br/>
                  Satış esnasında ev sahibine şu <strong>Reservatior 360° Ekosistem</strong> paketini sunun: <br/>
                  ✅ <strong>Kira & Depozito Sigortası:</strong> (Sıfır depozito, garantili ödeme) <br/>
                  ✅ <strong>Masrafsız Tahliye:</strong> (Hukuki güvence ve anında müdahale) <br/>
                  ✅ <strong>Esnek Yönetim:</strong> (Kısa & Uzun dönem kiralama geçişleri) <br/><br/>
                  Bu model ile komisyonu bir kesinti olmaktan çıkarıp, <strong>düzenli ve risksiz bir emlak yatırım ortaklığına</strong> dönüştürürsünüz. Komisyonu; <strong>Ofis (%1.35), Emlak Danışmanı (%1.35) ve Reservatior Platformu (%1.30)</strong> olarak adil şekilde bölüştüren bu %4'lük dilim, müşteri sistemde kaldığı sürece tüm taraflara pasif ve düzenli bir gelir (ARR) yaratır.
                </p>
              </div>
            </div>
          </div>

          {/* Payment Schedule */}
          {sel.installments && sel.installmentAmount && (
            <div className="rounded-2xl border border-border bg-card p-5">
              <h3 className="font-semibold text-sm mb-3 flex items-center gap-2">
                <Calendar className="w-4 h-4 text-primary" />
                Ödeme Takvimi ({sel.installments} taksit)
              </h3>
              <div className="space-y-2">
                {sel.downPayment > 0 && (
                  <div className="flex items-center justify-between py-2 border-b border-border text-sm">
                    <span className="text-muted-foreground font-medium">0. Peşinat</span>
                    <span className="font-bold text-foreground">{fmt(sel.downPayment, country.currency)}</span>
                  </div>
                )}
                {Array.from({ length: Math.min(sel.installments, 4) }, (_, i) => {
                  const d = new Date(); d.setMonth(d.getMonth() + i + (sel.downPayment > 0 ? 1 : 0));
                  return (
                    <div key={i} className="flex items-center justify-between py-2 border-b border-border/50 text-sm last:border-0">
                      <span className="text-muted-foreground">{i + 1}. Taksit — {d.toLocaleDateString("tr-TR", { month: "short", year: "numeric" })}</span>
                      <span className="font-medium">{fmt(sel.installmentAmount!, country.currency)}</span>
                    </div>
                  );
                })}
                {sel.installments > 4 && (
                  <p className="text-xs text-muted-foreground pt-1 text-center">+ {sel.installments - 4} taksit daha...</p>
                )}
              </div>
            </div>
          )}

          <div className="flex gap-3">
            <button
              onClick={() => setStep(2)}
              className="flex-1 py-3 rounded-xl border border-border text-sm font-medium hover:bg-accent/30 transition-colors"
            >
              Geri
            </button>
            <button className="flex-1 py-3 rounded-xl bg-primary text-primary-foreground font-semibold text-sm hover:bg-primary/90 transition-colors flex items-center justify-center gap-2">
              <FileText className="w-4 h-4" />
              Sözleşme Oluştur & İmzaya Gönder
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
