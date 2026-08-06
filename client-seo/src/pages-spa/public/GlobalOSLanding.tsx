"use client";

import { m } from "framer-motion";
import { useTranslation } from "react-i18next";
import {
  Brain, Sparkles, ShieldCheck, Banknote, ArrowRight,
  Building2, Cpu, CheckCircle2, MapPin, Users,
  PieChart, Network, Scale, Lock,
  Flag, CircleDollarSign, Layers, ChevronRight,
} from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Link } from "@/lib/react-router-shim";
import { useState } from "react";

/* ─── Country data for the interactive map section ─── */
const REGIONS = [
  {
    name: "Americas",
    color: "from-blue-500/20 to-indigo-500/20",
    borderColor: "border-blue-500/30",
    textColor: "text-blue-400",
    countries: [
      { code: "US", name: "United States", currency: "USD", demand: "VERY_HIGH", cities: "NYC, LA, Miami, SF" },
      { code: "CA", name: "Canada", currency: "CAD", demand: "HIGH", cities: "Toronto, Vancouver" },
      { code: "MX", name: "Mexico", currency: "MXN", demand: "MEDIUM", cities: "CDMX, Cancún" },
      { code: "BR", name: "Brazil", currency: "BRL", demand: "MEDIUM", cities: "São Paulo, Rio" },
    ],
  },
  {
    name: "Europe",
    color: "from-purple-500/20 to-violet-500/20",
    borderColor: "border-purple-500/30",
    textColor: "text-purple-400",
    countries: [
      { code: "GB", name: "United Kingdom", currency: "GBP", demand: "VERY_HIGH", cities: "London, Manchester" },
      { code: "DE", name: "Germany", currency: "EUR", demand: "VERY_HIGH", cities: "Berlin, Munich" },
      { code: "FR", name: "France", currency: "EUR", demand: "HIGH", cities: "Paris, Nice" },
      { code: "NL", name: "Netherlands", currency: "EUR", demand: "HIGH", cities: "Amsterdam" },
      { code: "ES", name: "Spain", currency: "EUR", demand: "HIGH", cities: "Madrid, Barcelona" },
      { code: "PT", name: "Portugal", currency: "EUR", demand: "HIGH", cities: "Lisbon, Porto" },
      { code: "IT", name: "Italy", currency: "EUR", demand: "HIGH", cities: "Milan, Rome" },
      { code: "GR", name: "Greece", currency: "EUR", demand: "MEDIUM", cities: "Athens" },
      { code: "CH", name: "Switzerland", currency: "CHF", demand: "VERY_HIGH", cities: "Zürich, Geneva" },
    ],
  },
  {
    name: "Turkey",
    color: "from-red-500/20 to-orange-500/20",
    borderColor: "border-red-500/30",
    textColor: "text-red-400",
    countries: [
      { code: "TR", name: "Turkey", currency: "TRY", demand: "HIGH", cities: "Istanbul, Ankara, Antalya" },
    ],
  },
  {
    name: "Middle East",
    color: "from-amber-500/20 to-yellow-500/20",
    borderColor: "border-amber-500/30",
    textColor: "text-amber-400",
    countries: [
      { code: "AE", name: "UAE", currency: "AED", demand: "VERY_HIGH", cities: "Dubai, Abu Dhabi" },
      { code: "SA", name: "Saudi Arabia", currency: "SAR", demand: "VERY_HIGH", cities: "Riyadh, Jeddah" },
      { code: "QA", name: "Qatar", currency: "QAR", demand: "VERY_HIGH", cities: "Doha" },
    ],
  },
  {
    name: "Asia-Pacific",
    color: "from-emerald-500/20 to-teal-500/20",
    borderColor: "border-emerald-500/30",
    textColor: "text-emerald-400",
    countries: [
      { code: "AU", name: "Australia", currency: "AUD", demand: "HIGH", cities: "Sydney, Melbourne" },
      { code: "SG", name: "Singapore", currency: "SGD", demand: "VERY_HIGH", cities: "Singapore" },
      { code: "JP", name: "Japan", currency: "JPY", demand: "HIGH", cities: "Tokyo, Osaka" },
      { code: "KR", name: "South Korea", currency: "KRW", demand: "HIGH", cities: "Seoul" },
      { code: "IN", name: "India", currency: "INR", demand: "HIGH", cities: "Mumbai, Bangalore" },
      { code: "PK", name: "Pakistan", currency: "PKR", demand: "MEDIUM", cities: "Islamabad, Lahore" },
    ],
  },
];

const DEMAND_STYLES: Record<string, string> = {
  VERY_HIGH: "bg-emerald-500/15 text-emerald-400 border-emerald-500/20",
  HIGH: "bg-blue-500/15 text-blue-400 border-blue-500/20",
  MEDIUM: "bg-amber-500/15 text-amber-400 border-amber-500/20",
};

/* ─── Animation variants ─── */
const fadeUp = {
  hidden: { opacity: 0, y: 30 },
  visible: (delay: number) => ({
    opacity: 1, y: 0,
    transition: { delay: delay * 0.1, duration: 0.6, ease: [0.25, 0.1, 0.25, 1] as const },
  }),
};

const stagger = {
  hidden: {},
  visible: { transition: { staggerChildren: 0.08 } },
};

export default function GlobalOSLanding() {
  const { t } = useTranslation();
  const [activeRegion, setActiveRegion] = useState("All");

  const allCountries = REGIONS.flatMap((r) => r.countries);
  const filteredCountries =
    activeRegion === "All"
      ? allCountries
      : REGIONS.find((r) => r.name === activeRegion)?.countries || [];

  return (
    <div className="min-h-screen bg-background text-foreground selection:bg-primary/30 overflow-hidden">
      {/* ── Background Orbs ──────────────────────────────────────────── */}
      <div className="fixed inset-0 overflow-hidden pointer-events-none">
        <div className="absolute -top-[15%] -left-[10%] w-[45%] h-[45%] bg-emerald-600/8 blur-[140px] rounded-full" />
        <div className="absolute top-[30%] -right-[10%] w-[35%] h-[35%] bg-blue-600/8 blur-[120px] rounded-full" />
        <div className="absolute -bottom-[15%] left-[30%] w-[40%] h-[40%] bg-purple-600/6 blur-[160px] rounded-full" />
      </div>

      <div className="relative z-10">
        {/* ═══════════════════════════════════════════════════════════════
            SECTION 1 — Hero
        ═══════════════════════════════════════════════════════════════ */}
        <section className="container mx-auto px-6 pt-24 pb-20 lg:pt-32 lg:pb-28">
          <div className="max-w-4xl">
            <m.div
              initial={{ opacity: 0, x: -30 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.7 }}
            >
              <Badge className="mb-6 rounded-full bg-emerald-500/10 text-emerald-400 border-emerald-500/20 px-5 py-1.5 text-sm font-bold tracking-widest italic">
                GLOBAL HYBRID RENTAL & REVENUE OS
              </Badge>
              <h1 className="text-5xl sm:text-6xl lg:text-8xl font-black italic tracking-tighter mb-8 leading-[0.9]">
                {t("global_os_landing.hero_title_1", "One Platform.")}
                <br />
                <span className="bg-gradient-to-r from-emerald-400 via-blue-400 to-purple-400 bg-clip-text text-transparent">
                  {t("global_os_landing.hero_title_2", "23 Countries.")}
                </span>
                <br />
                {t("global_os_landing.hero_title_3", "Infinite Revenue.")}
              </h1>
              <p className="text-lg sm:text-xl text-slate-400 max-w-2xl leading-relaxed italic border-l-2 border-emerald-500/30 pl-6 mb-10">
                {t(
                  "global_os_landing.hero_subtitle",
                  "Operate short-term rentals, corporate housing, and serviced apartments across the globe. AI-powered compliance, multi-currency tax optimization, and neural revenue intelligence — all unified in one OS."
                )}
              </p>
              <div className="flex flex-wrap gap-4">
                <Link href="/signup">
                  <Button
                    size="lg"
                    className="bg-emerald-500 hover:bg-emerald-600 text-white font-bold px-8 py-6 text-base rounded-2xl gap-2 italic"
                  >
                    {t("global_os_landing.cta_start", "Start Global Operations")}
                    <ArrowRight className="w-5 h-5" />
                  </Button>
                </Link>
                <Link href="/features">
                  <Button
                    size="lg"
                    variant="outline"
                    className="border-white/10 hover:bg-white/5 text-white font-bold px-8 py-6 text-base rounded-2xl gap-2 italic"
                  >
                    {t("global_os_landing.cta_features", "Explore All Features")}
                  </Button>
                </Link>
              </div>
            </m.div>
          </div>

          {/* Hero stats strip */}
          <m.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.4, duration: 0.6 }}
            className="grid grid-cols-2 sm:grid-cols-4 gap-4 mt-16"
          >
            {[
              { icon: <Flag className="w-5 h-5 text-emerald-400" />, value: "23", label: t("global_os_landing.stat_countries", "Countries Supported") },
              { icon: <CircleDollarSign className="w-5 h-5 text-amber-400" />, value: "15+", label: t("global_os_landing.stat_currencies", "Currencies") },
              { icon: <Cpu className="w-5 h-5 text-purple-400" />, value: "10", label: t("global_os_landing.stat_agents", "AI Neural Agents") },
              { icon: <Layers className="w-5 h-5 text-blue-400" />, value: "6", label: t("global_os_landing.stat_models", "Rental Models") },
            ].map((s) => (
              <div
                key={s.label}
                className="rounded-2xl bg-card border border-border backdrop-blur-sm p-5 flex items-center gap-4"
              >
                <div className="p-3 rounded-xl bg-muted">{s.icon}</div>
                <div>
                  <div className="text-3xl font-black text-foreground italic">{s.value}</div>
                  <div className="text-xs text-muted-foreground">{s.label}</div>
                </div>
              </div>
            ))}
          </m.div>
        </section>

        {/* ═══════════════════════════════════════════════════════════════
            SECTION 2 — Core Capabilities (4 pillars)
        ═══════════════════════════════════════════════════════════════ */}
        <section className="container mx-auto px-6 py-20">
          <m.div
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true }}
            variants={stagger}
          >
            <m.div variants={fadeUp} custom={0} className="text-center mb-16">
              <Badge className="mb-4 rounded-full bg-blue-500/10 text-blue-400 border-blue-500/20 px-4 py-1 text-sm font-bold tracking-widest italic">
                CORE CAPABILITIES
              </Badge>
              <h2 className="text-4xl lg:text-6xl font-black italic tracking-tighter">
                {t("global_os_landing.capabilities_title", "Built for Global Scale")}
              </h2>
            </m.div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {[
                {
                  icon: ShieldCheck,
                  title: t("global_os_landing.cap_compliance_title", "Country-Aware Compliance"),
                  description: t(
                    "global_os_landing.cap_compliance_desc",
                    "Automatic legal compliance checks for each jurisdiction. Licensing, registration, zoning, and rental cap rules are evaluated in real-time before any property is onboarded."
                  ),
                  color: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
                  features: [
                    t("global_os_landing.cap_compliance_f1", "Short-stay day limits (90-day London, 120-day Paris, 180-day Tokyo)"),
                    t("global_os_landing.cap_compliance_f2", "License & registration requirement detection"),
                    t("global_os_landing.cap_compliance_f3", "Building consent & zoning verification"),
                  ],
                },
                {
                  icon: Banknote,
                  title: t("global_os_landing.cap_tax_title", "Multi-Currency Tax Engine"),
                  description: t(
                    "global_os_landing.cap_tax_desc",
                    "Calculates VAT, GST, withholding tax, tourism/accommodation tax, and income tax across 15+ currencies. Revenue DAG pipeline with 8 intelligent nodes splits every dollar correctly."
                  ),
                  color: "bg-amber-500/10 text-amber-400 border-amber-500/20",
                  features: [
                    t("global_os_landing.cap_tax_f1", "VAT/GST: 0% (Qatar) → 24% (Greece) auto-applied"),
                    t("global_os_landing.cap_tax_f2", "Withholding tax from 0% (UAE) to 35% (Switzerland)"),
                    t("global_os_landing.cap_tax_f3", "Tourism tax auto-collection at booking time"),
                  ],
                },
                {
                  icon: Brain,
                  title: t("global_os_landing.cap_ai_title", "10-Agent Neural Swarm"),
                  description: t(
                    "global_os_landing.cap_ai_desc",
                    "Every property evaluation is analysed by 10 specialised AI agents working in consensus. From physical inspection to legal compliance, tax structure, corporate demand, and pricing — decisions are data-driven."
                  ),
                  color: "bg-purple-500/10 text-purple-400 border-purple-500/20",
                  features: [
                    t("global_os_landing.cap_ai_f1", "CountryComplianceAgent + MarketExpansionAgent"),
                    t("global_os_landing.cap_ai_f2", "TaxOptimizationAgent + CorporateDemandAgent"),
                    t("global_os_landing.cap_ai_f3", "GlobalPricingAgent with FX hedging recommendations"),
                  ],
                },
                {
                  icon: Network,
                  title: t("global_os_landing.cap_partner_title", "Global Partner Network"),
                  description: t(
                    "global_os_landing.cap_partner_desc",
                    "15 partner roles across 5 commission tiers. From local real estate agents to corporate relocation companies, every referral channel is tracked and rewarded with country-specific commission rules."
                  ),
                  color: "bg-blue-500/10 text-blue-400 border-blue-500/20",
                  features: [
                    t("global_os_landing.cap_partner_f1", "REFERRAL → SILVER → GOLD → PLATINUM → STRATEGIC tiers"),
                    t("global_os_landing.cap_partner_f2", "Relocation companies, HR partners, travel agencies"),
                    t("global_os_landing.cap_partner_f3", "Country-adjusted commission caps based on tax burden"),
                  ],
                },
              ].map((cap, i) => (
                <m.div key={cap.title} variants={fadeUp} custom={i + 1}>
                  <Card className="bg-[#14151a]/60 backdrop-blur-xl border-white/5 hover:border-white/10 transition-all rounded-3xl overflow-hidden h-full group">
                    <CardContent className="p-8">
                      <div className="flex items-center gap-4 mb-6">
                        <div className={`p-4 rounded-2xl border ${cap.color}`}>
                          <cap.icon className="w-7 h-7" />
                        </div>
                        <h3 className="text-2xl font-black italic tracking-tight text-white">
                          {cap.title}
                        </h3>
                      </div>
                      <p className="text-sm text-slate-400 leading-relaxed italic mb-6">
                        {cap.description}
                      </p>
                      <div className="space-y-2">
                        {cap.features.map((f) => (
                          <div key={f} className="flex items-start gap-2">
                            <CheckCircle2 className="w-4 h-4 text-emerald-400 mt-0.5 flex-shrink-0" />
                            <span className="text-xs text-slate-500 italic">{f}</span>
                          </div>
                        ))}
                      </div>
                    </CardContent>
                  </Card>
                </m.div>
              ))}
            </div>
          </m.div>
        </section>

        {/* ═══════════════════════════════════════════════════════════════
            SECTION 3 — Rental Models
        ═══════════════════════════════════════════════════════════════ */}
        <section className="container mx-auto px-6 py-20">
          <m.div
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true }}
            variants={stagger}
          >
            <m.div variants={fadeUp} custom={0} className="text-center mb-16">
              <Badge className="mb-4 rounded-full bg-purple-500/10 text-purple-400 border-purple-500/20 px-4 py-1 text-sm font-bold tracking-widest italic">
                HYBRID MODELS
              </Badge>
              <h2 className="text-4xl lg:text-6xl font-black italic tracking-tighter">
                {t("global_os_landing.models_title", "6 Revenue Models. 1 Engine.")}
              </h2>
              <p className="text-lg text-slate-500 italic mt-4 max-w-2xl mx-auto">
                {t(
                  "global_os_landing.models_subtitle",
                  "Our AI automatically selects the optimal rental model for each property based on location, regulations, market demand, and owner preferences."
                )}
              </p>
            </m.div>

            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {[
                {
                  model: "Revenue Share",
                  icon: PieChart,
                  desc: t("global_os_landing.model_revshare", "Dynamic revenue split between owner and platform. Ideal for premium short-stay properties."),
                  color: "from-purple-500/20 to-purple-500/5 border-purple-500/20",
                  tag: t("global_os_landing.model_popular", "MOST POPULAR"),
                },
                {
                  model: "Master Lease",
                  icon: Building2,
                  desc: t("global_os_landing.model_masterlease", "Guaranteed monthly income for owners. Platform handles all operations and bears occupancy risk."),
                  color: "from-blue-500/20 to-blue-500/5 border-blue-500/20",
                  tag: t("global_os_landing.model_guaranteed", "GUARANTEED INCOME"),
                },
                {
                  model: "Corporate Housing",
                  icon: Users,
                  desc: t("global_os_landing.model_corporate", "Furnished apartments for corporate relocations, expats, and business travellers. 3-12 month stays."),
                  color: "from-emerald-500/20 to-emerald-500/5 border-emerald-500/20",
                  tag: t("global_os_landing.model_premium", "PREMIUM ADR"),
                },
                {
                  model: "Serviced Apartment",
                  icon: Sparkles,
                  desc: t("global_os_landing.model_serviced", "Hotel-grade amenities with apartment flexibility. Concierge, cleaning, and F&B services included."),
                  color: "from-amber-500/20 to-amber-500/5 border-amber-500/20",
                  tag: t("global_os_landing.model_luxury", "LUXURY"),
                },
                {
                  model: "Corporate Master Lease",
                  icon: Scale,
                  desc: t("global_os_landing.model_cmasterlease", "Bulk agreements with corporations for entire floors or buildings. Long-term guaranteed occupancy."),
                  color: "from-cyan-500/20 to-cyan-500/5 border-cyan-500/20",
                  tag: t("global_os_landing.model_enterprise", "ENTERPRISE"),
                },
                {
                  model: "Long-Term Rental",
                  icon: Lock,
                  desc: t("global_os_landing.model_longterm", "Traditional 12+ month leases with automated rent collection, maintenance, and tenant management."),
                  color: "from-rose-500/20 to-rose-500/5 border-rose-500/20",
                  tag: t("global_os_landing.model_stable", "STABLE"),
                },
              ].map((m_item, i) => (
                <m.div
                  key={m_item.model}
                  variants={fadeUp}
                  custom={i}
                  className={`rounded-3xl bg-gradient-to-b ${m_item.color} border backdrop-blur-sm p-6 hover:scale-[1.02] transition-transform cursor-default`}
                >
                  <div className="flex items-center justify-between mb-4">
                    <div className="p-3 rounded-xl bg-white/5">
                      <m_item.icon className="w-6 h-6 text-white" />
                    </div>
                    <span className="text-[10px] px-2 py-0.5 rounded-full bg-white/10 text-white/70 font-bold tracking-wider">
                      {m_item.tag}
                    </span>
                  </div>
                  <h3 className="text-lg font-black italic text-white mb-2">
                    {m_item.model}
                  </h3>
                  <p className="text-xs text-slate-400 leading-relaxed italic">
                    {m_item.desc}
                  </p>
                </m.div>
              ))}
            </div>
          </m.div>
        </section>

        {/* ═══════════════════════════════════════════════════════════════
            SECTION 4 — Global Coverage Map
        ═══════════════════════════════════════════════════════════════ */}
        <section className="container mx-auto px-6 py-20">
          <m.div
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true }}
            variants={stagger}
          >
            <m.div variants={fadeUp} custom={0} className="text-center mb-12">
              <Badge className="mb-4 rounded-full bg-emerald-500/10 text-emerald-400 border-emerald-500/20 px-4 py-1 text-sm font-bold tracking-widest italic">
                GLOBAL COVERAGE
              </Badge>
              <h2 className="text-4xl lg:text-6xl font-black italic tracking-tighter">
                {t("global_os_landing.coverage_title", "23 Countries. Ready to Operate.")}
              </h2>
            </m.div>

            {/* Region filters */}
            <m.div variants={fadeUp} custom={1} className="flex gap-2 flex-wrap justify-center mb-8">
              {["All", ...REGIONS.map((r) => r.name)].map((r) => (
                <button
                  key={r}
                  onClick={() => setActiveRegion(r)}
                  className={`px-4 py-2 rounded-xl text-sm font-bold italic tracking-wide transition-all border ${
                    activeRegion === r
                      ? "bg-emerald-500/20 text-emerald-400 border-emerald-500/30"
                      : "border-white/10 text-slate-500 hover:text-white hover:bg-white/5"
                  }`}
                >
                  {r}
                  {r !== "All" && (
                    <span className="ml-1 opacity-50">
                      ({REGIONS.find((rr) => rr.name === r)?.countries.length})
                    </span>
                  )}
                </button>
              ))}
            </m.div>

            {/* Country Grid */}
            <m.div
              variants={fadeUp}
              custom={2}
              className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-3"
            >
              {filteredCountries.map((c) => {
                const region = REGIONS.find((r) =>
                  r.countries.some((cc) => cc.code === c.code)
                );
                return (
                  <div
                    key={c.code}
                    className={`rounded-2xl bg-gradient-to-br ${region?.color || ""} border ${
                      region?.borderColor || "border-white/10"
                    } p-4 hover:scale-[1.03] transition-transform`}
                  >
                    <div className="flex items-center justify-between mb-3">
                      <div className="flex items-center gap-2">
                        <div className="w-9 h-9 rounded-xl bg-white/10 flex items-center justify-center font-black text-sm text-white">
                          {c.code}
                        </div>
                        <div>
                          <div className="text-sm font-bold text-white">{c.name}</div>
                          <div className="text-[10px] text-slate-500">{c.currency}</div>
                        </div>
                      </div>
                      <span
                        className={`text-[10px] px-2 py-0.5 rounded-full border font-bold ${
                          DEMAND_STYLES[c.demand] || ""
                        }`}
                      >
                        {c.demand.replace("_", " ")}
                      </span>
                    </div>
                    <div className="flex items-center gap-1.5 text-[10px] text-slate-500 italic">
                      <MapPin className="w-3 h-3" />
                      {c.cities}
                    </div>
                  </div>
                );
              })}
            </m.div>
          </m.div>
        </section>

        {/* ═══════════════════════════════════════════════════════════════
            SECTION 5 — How It Works (Saga Pipeline)
        ═══════════════════════════════════════════════════════════════ */}
        <section className="container mx-auto px-6 py-20">
          <m.div
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true }}
            variants={stagger}
          >
            <m.div variants={fadeUp} custom={0} className="text-center mb-16">
              <Badge className="mb-4 rounded-full bg-amber-500/10 text-amber-400 border-amber-500/20 px-4 py-1 text-sm font-bold tracking-widest italic">
                ONBOARDING SAGA
              </Badge>
              <h2 className="text-4xl lg:text-6xl font-black italic tracking-tighter">
                {t("global_os_landing.saga_title", "From Detection to Revenue in 10 Steps")}
              </h2>
            </m.div>

            <div className="max-w-3xl mx-auto space-y-4">
              {[
                { step: "01", name: t("global_os_landing.saga_s1", "Property Detected & Registered"), module: "ListingOS", color: "text-emerald-400" },
                { step: "02", name: t("global_os_landing.saga_s2", "Country Compliance Checked"), module: "GovernanceOS", color: "text-blue-400" },
                { step: "03", name: t("global_os_landing.saga_s3", "Market Opportunity Scored"), module: "IntelligenceOS", color: "text-purple-400" },
                { step: "04", name: t("global_os_landing.saga_s4", "AI Selects Optimal Rental Model"), module: "HybridRentalOS", color: "text-pink-400" },
                { step: "05", name: t("global_os_landing.saga_s5", "Partner Matched & Commission Set"), module: "PartnerOS", color: "text-amber-400" },
                { step: "06", name: t("global_os_landing.saga_s6", "10-Agent Neural Swarm Validates"), module: "AI-OS", color: "text-cyan-400" },
                { step: "07", name: t("global_os_landing.saga_s7", "Contract Auto-Generated"), module: "LegalOS", color: "text-rose-400" },
                { step: "08", name: t("global_os_landing.saga_s8", "Channels & Operations Activated"), module: "OperationsOS", color: "text-emerald-400" },
                { step: "09", name: t("global_os_landing.saga_s9", "Revenue DAG Pipeline Runs"), module: "FinanceOS", color: "text-amber-400" },
                { step: "10", name: t("global_os_landing.saga_s10", "Global Finance Ledger Committed"), module: "FinanceOS", color: "text-emerald-400" },
              ].map((s, i) => (
                <m.div
                  key={s.step}
                  variants={fadeUp}
                  custom={i}
                  className="flex items-center gap-4 p-4 rounded-2xl bg-white/5 border border-white/5 hover:border-white/10 transition-all group"
                >
                  <div
                    className={`w-12 h-12 rounded-xl bg-white/5 flex items-center justify-center text-lg font-black italic ${s.color}`}
                  >
                    {s.step}
                  </div>
                  <div className="flex-1">
                    <div className="text-sm font-bold text-white italic group-hover:translate-x-1 transition-transform">
                      {s.name}
                    </div>
                  </div>
                  <span className="text-[10px] bg-white/5 text-slate-500 px-2 py-1 rounded-lg font-bold tracking-wider">
                    {s.module}
                  </span>
                  <ChevronRight className="w-4 h-4 text-slate-600 group-hover:text-white transition-colors" />
                </m.div>
              ))}
            </div>
          </m.div>
        </section>

        {/* ═══════════════════════════════════════════════════════════════
            SECTION 6 — Revenue DAG Visual
        ═══════════════════════════════════════════════════════════════ */}
        <section className="container mx-auto px-6 py-20">
          <m.div
            initial="hidden"
            whileInView="visible"
            viewport={{ once: true }}
            variants={stagger}
            className="p-8 sm:p-12 rounded-[3rem] bg-white/5 border border-white/10 backdrop-blur-xl relative overflow-hidden"
          >
            <div className="absolute top-0 right-0 p-8 opacity-10">
              <PieChart className="w-48 h-48 text-amber-400 animate-[spin_30s_linear_infinite]" />
            </div>
            <m.div variants={fadeUp} custom={0} className="relative z-10">
              <Badge className="mb-4 rounded-full bg-amber-500/10 text-amber-400 border-amber-500/20 px-4 py-1 text-sm font-bold tracking-widest italic">
                REVENUE DAG
              </Badge>
              <h2 className="text-3xl lg:text-5xl font-black italic tracking-tighter mb-4">
                {t("global_os_landing.dag_title", "Every Dollar, Tracked & Split Automatically")}
              </h2>
              <p className="text-sm text-slate-400 italic max-w-xl mb-10">
                {t(
                  "global_os_landing.dag_subtitle",
                  "Our 8-node Revenue DAG pipeline ensures accurate tax deduction, owner payouts, partner commissions, and platform margins — all in local currency with TRY conversion."
                )}
              </p>
            </m.div>

            <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 relative z-10">
              {[
                { node: "Gross Revenue", pct: "100%", color: "bg-emerald-500/20 text-emerald-400 border-emerald-500/30" },
                { node: "Tourism Tax", pct: "−2-14%", color: "bg-red-500/20 text-red-400 border-red-500/30" },
                { node: "VAT/GST", pct: "−0-24%", color: "bg-orange-500/20 text-orange-400 border-orange-500/30" },
                { node: "Withholding Tax", pct: "−0-35%", color: "bg-rose-500/20 text-rose-400 border-rose-500/30" },
                { node: "Owner Payout", pct: "50-60%", color: "bg-blue-500/20 text-blue-400 border-blue-500/30" },
                { node: "Partner Commission", pct: "5-15%", color: "bg-purple-500/20 text-purple-400 border-purple-500/30" },
                { node: "Reservatior Margin", pct: "20-30%", color: "bg-amber-500/20 text-amber-400 border-amber-500/30" },
                { node: "Ledger Commit", pct: "✓", color: "bg-emerald-500/20 text-emerald-400 border-emerald-500/30" },
              ].map((n, i) => (
                <m.div
                  key={n.node}
                  variants={fadeUp}
                  custom={i}
                  className={`rounded-2xl border p-4 text-center ${n.color}`}
                >
                  <div className="text-2xl font-black italic">{n.pct}</div>
                  <div className="text-[10px] font-bold tracking-wider mt-1">{n.node}</div>
                </m.div>
              ))}
            </div>
          </m.div>
        </section>

        {/* ═══════════════════════════════════════════════════════════════
            SECTION 7 — CTA
        ═══════════════════════════════════════════════════════════════ */}
        <section className="container mx-auto px-6 py-24">
          <m.div
            initial={{ opacity: 0, y: 40 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            className="text-center"
          >
            <h2 className="text-4xl lg:text-6xl font-black italic tracking-tighter mb-6">
              {t("global_os_landing.cta_title_1", "Ready to Go")}
              <span className="bg-gradient-to-r from-emerald-400 to-blue-400 bg-clip-text text-transparent">
                {" "}
                {t("global_os_landing.cta_title_2", "Global")}
              </span>
              ?
            </h2>
            <p className="text-lg text-slate-500 italic max-w-xl mx-auto mb-10">
              {t(
                "global_os_landing.cta_subtitle",
                "Join property owners and operators in 23 countries who trust Reservatior to maximize their rental revenue."
              )}
            </p>
            <div className="flex flex-wrap gap-4 justify-center">
              <Link href="/signup">
                <Button
                  size="lg"
                  className="bg-emerald-500 hover:bg-emerald-600 text-white font-bold px-10 py-7 text-lg rounded-2xl gap-2 italic"
                >
                  {t("global_os_landing.cta_signup", "Get Started Free")}
                  <ArrowRight className="w-5 h-5" />
                </Button>
              </Link>
              <Link href="/about">
                <Button
                  size="lg"
                  variant="outline"
                  className="border-white/10 hover:bg-white/5 text-white font-bold px-10 py-7 text-lg rounded-2xl gap-2 italic"
                >
                  {t("global_os_landing.cta_contact", "Contact Sales")}
                </Button>
              </Link>
            </div>
          </m.div>
        </section>
      </div>
    </div>
  );
}
