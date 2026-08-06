"use client";

import React, { useState, useEffect, useCallback } from "react";
import { useTranslation } from "react-i18next";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import {
  Globe, Brain, Zap, Shield, Activity, RefreshCw, Sparkles,
  CheckCircle2, AlertTriangle, Play, RotateCcw, Cpu, Layers,
  ArrowRight, DollarSign, PieChart, TrendingUp, Building2,
  MapPin, Users, FileText, Network, Target, ChevronDown,
  ChevronUp, Copy, Check, Flag, BarChart3, Landmark, Scale,
  CircleDollarSign, Lock
} from "lucide-react";
import { apiClient } from "@/lib/api";

type TabId = 'countries' | 'evaluate' | 'revenue' | 'partners' | 'swarm';

const DEMAND_COLORS: Record<string, string> = {
  VERY_HIGH: 'bg-emerald-500/20 text-emerald-400 border-emerald-500/30',
  HIGH: 'bg-blue-500/20 text-blue-400 border-blue-500/30',
  MEDIUM: 'bg-amber-500/20 text-amber-400 border-amber-500/30',
  LOW: 'bg-red-500/20 text-red-400 border-red-500/30',
};

const MODEL_COLORS: Record<string, string> = {
  REVENUE_SHARE: 'bg-purple-500/20 text-purple-400',
  MASTER_LEASE: 'bg-blue-500/20 text-blue-400',
  CORPORATE_HOUSING: 'bg-emerald-500/20 text-emerald-400',
  CORPORATE_MASTER_LEASE: 'bg-cyan-500/20 text-cyan-400',
  SERVICED_APARTMENT: 'bg-amber-500/20 text-amber-400',
  REJECT: 'bg-red-500/20 text-red-400',
};

const COUNTRY_REGIONS: Record<string, string[]> = {
  'Americas': ['US', 'CA', 'MX', 'BR'],
  'Europe': ['GB', 'DE', 'NL', 'FR', 'ES', 'PT', 'IT', 'GR', 'CH'],
  'Turkey': ['TR'],
  'Middle East': ['AE', 'SA', 'QA'],
  'Asia-Pacific': ['AU', 'SG', 'JP', 'KR', 'IN', 'PK'],
};

const REGION_COLORS: Record<string, string> = {
  'Americas': 'from-blue-600/20 to-indigo-600/20 border-blue-500/30',
  'Europe': 'from-purple-600/20 to-violet-600/20 border-purple-500/30',
  'Turkey': 'from-red-600/20 to-orange-600/20 border-red-500/30',
  'Middle East': 'from-amber-600/20 to-yellow-600/20 border-amber-500/30',
  'Asia-Pacific': 'from-emerald-600/20 to-teal-600/20 border-emerald-500/30',
};

export default function GlobalHybridRentalOS() {
  const { t } = useTranslation();
  const [activeTab, setActiveTab] = useState<TabId>('countries');
  const [loading, setLoading] = useState(false);
  const [copied, setCopied] = useState(false);

  // Countries tab
  const [countries, setCountries] = useState<any[]>([]);
  const [selectedRegion, setSelectedRegion] = useState<string>('All');
  const [countriesLoaded, setCountriesLoaded] = useState(false);

  // Evaluate tab
  const [evalCountry, setEvalCountry] = useState('AE');
  const [evalForm, setEvalForm] = useState({
    sizeSqm: 85, accommodates: 4, buildingAge: 5,
    isFurnished: true, hasElevator: true, hasParking: false, hasPoolOrGym: true,
    proximityToMetroMins: 8, proximityToAirportMins: 30,
    hasBuildingConsent100Pct: true, hasTourismResidenceLicense: true,
    neighbourhood: 'Downtown', city: 'Dubai',
  });
  const [evalResult, setEvalResult] = useState<any>(null);

  // Revenue tab
  const [revCountry, setRevCountry] = useState('AE');
  const [revGross, setRevGross] = useState(15000);
  const [revOwnerPct, setRevOwnerPct] = useState(55);
  const [revPartnerPct, setRevPartnerPct] = useState(10);
  const [dagResult, setDagResult] = useState<any>(null);

  // Saga tab
  const [sagaCountry, setSagaCountry] = useState('TR');
  const [sagaRunning, setSagaRunning] = useState(false);
  const [sagaResult, setSagaResult] = useState<any>(null);

  const fetchCountries = useCallback(async () => {
    if (countriesLoaded) return;
    setLoading(true);
    try {
      const res: any = await apiClient.get('/os/global-hybrid-rental/countries');
      setCountries(res?.countries || []);
      setCountriesLoaded(true);
    } catch {
      // fallback: show empty
    } finally {
      setLoading(false);
    }
  }, [countriesLoaded]);

  useEffect(() => {
    if (activeTab === 'countries') fetchCountries();
  }, [activeTab, fetchCountries]);

  const handleEvaluate = async () => {
    setLoading(true);
    try {
      const res: any = await apiClient.post('/os/global-hybrid-rental/evaluate', {
        countryCode: evalCountry, ...evalForm,
      });
      setEvalResult(res);
    } catch { } finally { setLoading(false); }
  };

  const handleSimulate = async () => {
    setLoading(true);
    try {
      const res: any = await apiClient.post('/os/global-hybrid-rental/revenue-simulation', {
        countryCode: revCountry,
        grossRevenueLocal: revGross,
        ownerSharePct: revOwnerPct,
        partnerCommissionRatePct: revPartnerPct,
      });
      setDagResult(res?.simulation);
    } catch { } finally { setLoading(false); }
  };

  const handleSaga = async () => {
    setSagaRunning(true);
    setSagaResult(null);
    try {
      const res: any = await apiClient.post('/os/global-hybrid-rental/start-saga', {
        countryCode: sagaCountry,
        accommodates: 4, sizeSqm: 85,
        hasBuildingConsent100Pct: true,
        hasTourismResidenceLicense: true,
        grossRevenueLocal: 12000,
      });
      setSagaResult(res?.saga);
    } catch { } finally { setSagaRunning(false); }
  };

  const copyJSON = (obj: any) => {
    navigator.clipboard.writeText(JSON.stringify(obj, null, 2));
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  const filteredCountries = selectedRegion === 'All'
    ? countries
    : countries.filter(c => (COUNTRY_REGIONS[selectedRegion] || []).includes(c.countryCode));

  const tabs: { id: TabId; label: string; icon: React.ReactNode; badge?: string }[] = [
    { id: 'countries', label: t('global_os.tab_countries', 'Ülke İstihbaratı'), icon: <Globe className="w-4 h-4" />, badge: `${countries.length || 23}` },
    { id: 'evaluate', label: t('global_os.tab_evaluate', 'Mülk Değerlendirme'), icon: <Brain className="w-4 h-4" />, badge: 'AI' },
    { id: 'revenue', label: t('global_os.tab_revenue', 'Gelir DAG'), icon: <PieChart className="w-4 h-4" />, badge: 'FX' },
    { id: 'partners', label: t('global_os.tab_partners', 'Partner Ağı'), icon: <Network className="w-4 h-4" /> },
    { id: 'swarm', label: t('global_os.tab_swarm', 'AI Nöral Sürü'), icon: <Cpu className="w-4 h-4" />, badge: '10' },
  ];

  return (
    <PageShell
      title={t('global_os.title', 'Global Hibrit Kiralama & Gelir OS')}
      description={t('global_os.subtitle', 'Çok Ülkeli İstihbarat Platformu — 23 Ülke | PropTech + FinTech + AI')}
    >
      {/* ── Header Stats ─────────────────────────────────────────────── */}
      <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 mb-6">
        {[
          { label: t('global_os.stat_countries', 'Ülke'), value: '23', icon: <Flag className="w-4 h-4 text-emerald-400" />, color: 'border-emerald-500/30 bg-emerald-500/5' },
          { label: t('global_os.stat_models', 'Kiralama Modeli'), value: '6', icon: <Layers className="w-4 h-4 text-blue-400" />, color: 'border-blue-500/30 bg-blue-500/5' },
          { label: t('global_os.stat_currencies', 'Para Birimi'), value: '15+', icon: <CircleDollarSign className="w-4 h-4 text-amber-400" />, color: 'border-amber-500/30 bg-amber-500/5' },
          { label: t('global_os.stat_agents', 'AI Ajan'), value: '10', icon: <Cpu className="w-4 h-4 text-purple-400" />, color: 'border-purple-500/30 bg-purple-500/5' },
        ].map((s) => (
          <div key={s.label} className={`rounded-xl border ${s.color} p-3 flex items-center gap-3`}>
            <div className="p-2 rounded-lg bg-white/5">{s.icon}</div>
            <div>
              <div className="text-xl font-bold text-foreground">{s.value}</div>
              <div className="text-xs text-muted-foreground">{s.label}</div>
            </div>
          </div>
        ))}
      </div>

      {/* ── Tabs ─────────────────────────────────────────────────────── */}
      <div className="flex gap-1 p-1 bg-white/5 rounded-xl mb-6 overflow-x-auto">
        {tabs.map(tab => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id)}
            className={`flex items-center gap-2 px-4 py-2.5 rounded-lg text-sm font-medium whitespace-nowrap transition-all ${
              activeTab === tab.id
                ? 'bg-white/10 text-foreground shadow-sm'
                : 'text-muted-foreground hover:text-foreground hover:bg-white/5'
            }`}
          >
            {tab.icon}
            {tab.label}
            {tab.badge && (
              <span className="text-[10px] px-1.5 py-0.5 rounded-full bg-brand/20 text-brand font-semibold">
                {tab.badge}
              </span>
            )}
          </button>
        ))}
      </div>

      {/* ── Tab: Country Intelligence ─────────────────────────────── */}
      {activeTab === 'countries' && (
        <div>
          {/* Region filter */}
          <div className="flex gap-2 flex-wrap mb-4">
            {['All', ...Object.keys(COUNTRY_REGIONS)].map(r => (
              <button
                key={r}
                onClick={() => setSelectedRegion(r)}
                className={`px-3 py-1.5 rounded-lg text-xs font-medium transition-all border ${
                  selectedRegion === r
                    ? 'bg-brand/20 text-brand border-brand/30'
                    : 'border-white/10 text-muted-foreground hover:text-foreground hover:bg-white/5'
                }`}
              >
                {r} {r !== 'All' && <span className="opacity-60">({(COUNTRY_REGIONS[r] || []).length})</span>}
              </button>
            ))}
          </div>

          {loading && !countriesLoaded ? (
            <div className="flex items-center justify-center py-16 text-muted-foreground">
              <RefreshCw className="w-6 h-6 animate-spin mr-2" />
              <span>{t('global_os.loading_countries', 'Ülke istihbaratı yükleniyor...')}</span>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-3">
              {filteredCountries.map(c => {
                const region = Object.entries(COUNTRY_REGIONS).find(([, codes]) => codes.includes(c.countryCode))?.[0] || '';
                return (
                  <div key={c.countryCode} className={`rounded-xl border bg-gradient-to-br ${REGION_COLORS[region] || 'border-white/10 bg-white/5'} p-4`}>
                    <div className="flex items-start justify-between mb-3">
                      <div className="flex items-center gap-2">
                        <div className="w-8 h-8 rounded-lg bg-white/10 flex items-center justify-center text-sm font-bold text-foreground">
                          {c.countryCode}
                        </div>
                        <div>
                          <div className="font-semibold text-foreground text-sm">{c.countryName}</div>
                          <div className="text-xs text-muted-foreground">{c.currency} · {c.taxSystem?.replace('_', ' ')}</div>
                        </div>
                      </div>
                      <div className="text-right">
                        <div className="text-lg font-bold text-foreground">{c.complianceScore}</div>
                        <div className="text-[10px] text-muted-foreground">Compliance</div>
                      </div>
                    </div>
                    <div className="flex flex-wrap gap-1 mb-3">
                      <span className={`text-[10px] px-2 py-0.5 rounded-full border ${DEMAND_COLORS[c.corporateHousingDemand] || ''}`}>
                        {c.corporateHousingDemand}
                      </span>
                      {c.shortStayAllowed ? (
                        <span className="text-[10px] px-2 py-0.5 rounded-full bg-emerald-500/10 text-emerald-400 border border-emerald-500/20">Short-stay ✓</span>
                      ) : (
                        <span className="text-[10px] px-2 py-0.5 rounded-full bg-red-500/10 text-red-400 border border-red-500/20">Short-stay ✗</span>
                      )}
                      {c.masterLeaseAvailable && (
                        <span className="text-[10px] px-2 py-0.5 rounded-full bg-blue-500/10 text-blue-400 border border-blue-500/20">Master Lease</span>
                      )}
                    </div>
                    <div className="grid grid-cols-3 gap-2 text-center">
                      <div className="bg-white/5 rounded-lg p-1.5">
                        <div className="text-xs font-semibold text-foreground">{c.vatRate}%</div>
                        <div className="text-[9px] text-muted-foreground">VAT</div>
                      </div>
                      <div className="bg-white/5 rounded-lg p-1.5">
                        <div className="text-xs font-semibold text-foreground">{c.tourismTaxRate}%</div>
                        <div className="text-[9px] text-muted-foreground">Tourism Tax</div>
                      </div>
                      <div className="bg-white/5 rounded-lg p-1.5">
                        <div className="text-xs font-semibold text-foreground">{c.withholdingTaxRate}%</div>
                        <div className="text-[9px] text-muted-foreground">WHT</div>
                      </div>
                    </div>
                    {c.notes && (
                      <div className="mt-2 text-[9px] text-muted-foreground italic line-clamp-2">{c.notes}</div>
                    )}
                  </div>
                );
              })}
            </div>
          )}
        </div>
      )}

      {/* ── Tab: Property Evaluation ──────────────────────────────── */}
      {activeTab === 'evaluate' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="space-y-4">
            <div className="rounded-xl border border-white/10 bg-white/5 p-5">
              <h3 className="font-semibold text-foreground mb-4 flex items-center gap-2">
                <Globe className="w-4 h-4 text-emerald-400" />
                {t('global_os.eval_country_config', 'Ülke & Mülk Yapılandırması')}
              </h3>
              <div className="space-y-3">
                <div>
                  <label className="text-xs text-muted-foreground mb-1 block">{t('global_os.eval_country', 'Hedef Ülke')}</label>
                  <select
                    value={evalCountry}
                    onChange={e => setEvalCountry(e.target.value)}
                    className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-sm text-foreground focus:outline-none focus:border-brand"
                  >
                    {Object.values(COUNTRY_REGIONS).flat().map(code => (
                      <option key={code} value={code}>{code}</option>
                    ))}
                  </select>
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className="text-xs text-muted-foreground mb-1 block">{t('global_os.eval_city', 'Şehir')}</label>
                    <input type="text" value={evalForm.city} onChange={e => setEvalForm(p => ({ ...p, city: e.target.value }))}
                      className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-sm text-foreground focus:outline-none focus:border-brand" />
                  </div>
                  <div>
                    <label className="text-xs text-muted-foreground mb-1 block">{t('global_os.eval_size', 'Büyüklük (m²)')}</label>
                    <input type="number" value={evalForm.sizeSqm} onChange={e => setEvalForm(p => ({ ...p, sizeSqm: +e.target.value }))}
                      className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-sm text-foreground focus:outline-none focus:border-brand" />
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div>
                    <label className="text-xs text-muted-foreground mb-1 block">{t('global_os.eval_accommodates', 'Kapasite')}</label>
                    <input type="number" value={evalForm.accommodates} onChange={e => setEvalForm(p => ({ ...p, accommodates: +e.target.value }))}
                      className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-sm text-foreground focus:outline-none focus:border-brand" />
                  </div>
                  <div>
                    <label className="text-xs text-muted-foreground mb-1 block">{t('global_os.eval_building_age', 'Bina Yaşı')}</label>
                    <input type="number" value={evalForm.buildingAge} onChange={e => setEvalForm(p => ({ ...p, buildingAge: +e.target.value }))}
                      className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-sm text-foreground focus:outline-none focus:border-brand" />
                  </div>
                </div>
                <div className="flex flex-wrap gap-3">
                  {[
                    { key: 'isFurnished', label: 'Furnished' },
                    { key: 'hasElevator', label: 'Elevator' },
                    { key: 'hasParking', label: 'Parking' },
                    { key: 'hasPoolOrGym', label: 'Pool/Gym' },
                    { key: 'hasBuildingConsent100Pct', label: 'Consent' },
                    { key: 'hasTourismResidenceLicense', label: 'License' },
                  ].map(({ key, label }) => (
                    <label key={key} className="flex items-center gap-1.5 cursor-pointer">
                      <input type="checkbox" checked={(evalForm as any)[key]}
                        onChange={e => setEvalForm(p => ({ ...p, [key]: e.target.checked }))}
                        className="accent-brand w-3.5 h-3.5" />
                      <span className="text-xs text-muted-foreground">{label}</span>
                    </label>
                  ))}
                </div>
                <button
                  onClick={handleEvaluate}
                  disabled={loading}
                  className="w-full py-2.5 bg-brand/20 hover:bg-brand/30 border border-brand/30 text-brand rounded-lg text-sm font-medium transition-all flex items-center justify-center gap-2"
                >
                  {loading ? <RefreshCw className="w-4 h-4 animate-spin" /> : <Play className="w-4 h-4" />}
                  {t('global_os.eval_run', 'Global Değerlendirme Başlat')}
                </button>
              </div>
            </div>
          </div>

          <div>
            {evalResult?.evaluation ? (
              <div className="space-y-4">
                {/* Score Card */}
                <div className={`rounded-xl border p-5 ${evalResult.evaluation.recommendedModel === 'REJECT' ? 'border-red-500/30 bg-red-500/5' : 'border-emerald-500/30 bg-emerald-500/5'}`}>
                  <div className="flex items-center justify-between mb-3">
                    <div>
                      <div className="text-2xl font-bold text-foreground">{evalResult.evaluation.scoreBreakdown?.totalScore}/100</div>
                      <div className="text-xs text-muted-foreground">{t('global_os.eval_total_score', 'Toplam Skor')}</div>
                    </div>
                    <span className={`px-3 py-1 rounded-full text-sm font-semibold ${MODEL_COLORS[evalResult.evaluation.recommendedModel] || ''}`}>
                      {evalResult.evaluation.recommendedModel}
                    </span>
                  </div>
                  <div className="text-sm text-foreground font-medium mb-1">{evalResult.evaluation.recommendedModelLabel}</div>
                  <div className="text-xs text-muted-foreground">{evalResult.evaluation.modelExplanation}</div>
                </div>

                {/* Country Intelligence */}
                <div className="rounded-xl border border-white/10 bg-white/5 p-4">
                  <div className="text-sm font-semibold text-foreground mb-3 flex items-center gap-2">
                    <Shield className="w-4 h-4 text-blue-400" />
                    {t('global_os.eval_country_intel', 'Ülke İstihbaratı')}
                  </div>
                  <div className="grid grid-cols-3 gap-3">
                    <div className="text-center">
                      <div className="text-xl font-bold text-emerald-400">{evalResult.evaluation.countryComplianceScore}</div>
                      <div className="text-[10px] text-muted-foreground">Compliance</div>
                    </div>
                    <div className="text-center">
                      <div className="text-xl font-bold text-amber-400">{evalResult.evaluation.legalRiskScore}</div>
                      <div className="text-[10px] text-muted-foreground">Legal Risk</div>
                    </div>
                    <div className="text-center">
                      <div className="text-xl font-bold text-blue-400">+{evalResult.evaluation.estimatedRevenueLift}%</div>
                      <div className="text-[10px] text-muted-foreground">Rev Lift</div>
                    </div>
                  </div>
                  <div className="mt-2 text-center">
                    <span className={`text-xs px-2 py-0.5 rounded-full ${DEMAND_COLORS[evalResult.evaluation.marketOpportunity] || ''}`}>
                      {evalResult.evaluation.marketOpportunity} Opportunity
                    </span>
                  </div>
                </div>

                {/* AI Swarm Summary */}
                {evalResult.aiSwarm && (
                  <div className="rounded-xl border border-purple-500/20 bg-purple-500/5 p-4">
                    <div className="text-sm font-semibold text-foreground mb-2 flex items-center gap-2">
                      <Cpu className="w-4 h-4 text-purple-400" />
                      {t('global_os.eval_ai_swarm', 'AI Nöral Sürü')} — {evalResult.aiSwarm.agents?.length} {t('global_os.agents', 'ajan')}
                    </div>
                    <div className="flex items-center justify-between mb-3">
                      <div className="text-xs text-muted-foreground">{t('global_os.consensus', 'Konsensüs')}</div>
                      <div className="text-lg font-bold text-purple-400">{evalResult.aiSwarm.consensusScore}%</div>
                    </div>
                    <div className="space-y-1.5 max-h-48 overflow-y-auto">
                      {evalResult.aiSwarm.agents?.map((agent: any) => (
                        <div key={agent.agentName} className="flex items-start gap-2 p-2 bg-white/5 rounded-lg">
                          <div className="w-6 h-6 rounded-full bg-purple-500/20 flex items-center justify-center flex-shrink-0 mt-0.5">
                            <Brain className="w-3 h-3 text-purple-400" />
                          </div>
                          <div>
                            <div className="text-[10px] font-semibold text-foreground">{agent.agentName} <span className="text-purple-400">{agent.confidenceScore}%</span></div>
                            <div className="text-[9px] text-muted-foreground line-clamp-1">{agent.recommendedAction}</div>
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                )}

                <button onClick={() => copyJSON(evalResult)} className="w-full py-2 text-xs text-muted-foreground hover:text-foreground border border-white/10 rounded-lg flex items-center justify-center gap-1 hover:bg-white/5 transition-all">
                  {copied ? <Check className="w-3 h-3 text-emerald-400" /> : <Copy className="w-3 h-3" />}
                  {copied ? 'Copied!' : 'Copy JSON'}
                </button>
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center h-64 text-muted-foreground border border-dashed border-white/10 rounded-xl">
                <Brain className="w-10 h-10 mb-3 opacity-30" />
                <p className="text-sm">{t('global_os.eval_placeholder', 'Değerlendirme için yapılandırın ve çalıştırın')}</p>
              </div>
            )}
          </div>
        </div>
      )}

      {/* ── Tab: Revenue DAG ──────────────────────────────────────── */}
      {activeTab === 'revenue' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="rounded-xl border border-white/10 bg-white/5 p-5 space-y-4">
            <h3 className="font-semibold text-foreground flex items-center gap-2">
              <PieChart className="w-4 h-4 text-amber-400" />
              {t('global_os.rev_config', 'Gelir DAG Simülasyonu')}
            </h3>
            <div>
              <label className="text-xs text-muted-foreground mb-1 block">{t('global_os.rev_country', 'Ülke')}</label>
              <select value={revCountry} onChange={e => setRevCountry(e.target.value)}
                className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-sm text-foreground focus:outline-none focus:border-brand">
                {Object.values(COUNTRY_REGIONS).flat().map(code => (
                  <option key={code} value={code}>{code}</option>
                ))}
              </select>
            </div>
            <div>
              <label className="text-xs text-muted-foreground mb-1 block">{t('global_os.rev_gross', 'Brüt Gelir (Yerel Para Birimi)')}</label>
              <input type="number" value={revGross} onChange={e => setRevGross(+e.target.value)}
                className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-sm text-foreground focus:outline-none focus:border-brand" />
            </div>
            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="text-xs text-muted-foreground mb-1 block">{t('global_os.rev_owner_pct', 'Ev Sahibi Payı %')}</label>
                <input type="number" value={revOwnerPct} onChange={e => setRevOwnerPct(+e.target.value)} min="0" max="100"
                  className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-sm text-foreground focus:outline-none focus:border-brand" />
              </div>
              <div>
                <label className="text-xs text-muted-foreground mb-1 block">{t('global_os.rev_partner_pct', 'Partner Komisyonu %')}</label>
                <input type="number" value={revPartnerPct} onChange={e => setRevPartnerPct(+e.target.value)} min="0" max="30"
                  className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-sm text-foreground focus:outline-none focus:border-brand" />
              </div>
            </div>
            <button onClick={handleSimulate} disabled={loading}
              className="w-full py-2.5 bg-amber-500/20 hover:bg-amber-500/30 border border-amber-500/30 text-amber-400 rounded-lg text-sm font-medium transition-all flex items-center justify-center gap-2">
              {loading ? <RefreshCw className="w-4 h-4 animate-spin" /> : <Zap className="w-4 h-4" />}
              {t('global_os.rev_simulate', 'Gelir DAG Simüle Et')}
            </button>
          </div>

          <div>
            {dagResult ? (
              <div className="space-y-3">
                <div className="rounded-xl border border-amber-500/20 bg-amber-500/5 p-4">
                  <div className="flex justify-between items-center mb-3">
                    <div>
                      <div className="text-2xl font-bold text-foreground">
                        {dagResult.grossRevenueLocal?.toLocaleString()} <span className="text-base text-muted-foreground">{dagResult.currency}</span>
                      </div>
                      <div className="text-xs text-muted-foreground">{t('global_os.rev_gross_revenue', 'Brüt Gelir')}</div>
                    </div>
                    <div className="text-right">
                      <div className="text-lg font-bold text-red-400">-{dagResult.totalTaxDeductedPct}%</div>
                      <div className="text-xs text-muted-foreground">{t('global_os.rev_total_tax', 'Toplam Vergi')}</div>
                    </div>
                  </div>
                  <div className="text-center py-2 bg-white/5 rounded-lg">
                    <div className="text-xl font-bold text-emerald-400">
                      {dagResult.netRevenueAfterTaxLocal?.toLocaleString()} {dagResult.currency}
                    </div>
                    <div className="text-xs text-muted-foreground">{t('global_os.rev_net_revenue', 'Vergi Sonrası Net Gelir')}</div>
                  </div>
                </div>

                <div className="rounded-xl border border-white/10 bg-white/5 p-4">
                  <div className="text-sm font-semibold text-foreground mb-3">{t('global_os.rev_dag_nodes', 'DAG Pipeline Düğümleri')}</div>
                  <div className="space-y-2">
                    {dagResult.dagNodes?.map((node: any) => (
                      <div key={node.nodeId} className="flex items-center justify-between p-2.5 bg-white/5 rounded-lg">
                        <div className="flex items-center gap-2">
                          <div className="w-2 h-2 rounded-full bg-emerald-400 flex-shrink-0" />
                          <div>
                            <div className="text-xs font-medium text-foreground">{node.nodeName}</div>
                            <div className="text-[9px] text-muted-foreground">{node.nodeId}</div>
                          </div>
                        </div>
                        <div className="text-right">
                          <div className="text-xs font-bold text-foreground">
                            {node.amountLocal?.toLocaleString()} <span className="text-muted-foreground text-[9px]">{node.currency}</span>
                          </div>
                          <div className="text-[9px] text-muted-foreground">{node.percentageOfGross}% of gross</div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center h-64 text-muted-foreground border border-dashed border-white/10 rounded-xl">
                <PieChart className="w-10 h-10 mb-3 opacity-30" />
                <p className="text-sm">{t('global_os.rev_placeholder', 'Gelir DAG için simülasyon çalıştırın')}</p>
              </div>
            )}
          </div>
        </div>
      )}

      {/* ── Tab: Partners ────────────────────────────────────────── */}
      {activeTab === 'partners' && (
        <div className="space-y-4">
          <div className="rounded-xl border border-white/10 bg-white/5 p-5">
            <h3 className="font-semibold text-foreground mb-4 flex items-center gap-2">
              <Network className="w-4 h-4 text-blue-400" />
              {t('global_os.partner_roles', 'Global Partner Rolleri & Komisyon Kademeleri')}
            </h3>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b border-white/10">
                    <th className="text-left text-xs text-muted-foreground pb-2 pr-4">{t('global_os.partner_role', 'Rol')}</th>
                    <th className="text-center text-xs text-muted-foreground pb-2 px-2">REFERRAL</th>
                    <th className="text-center text-xs text-muted-foreground pb-2 px-2">SILVER</th>
                    <th className="text-center text-xs text-muted-foreground pb-2 px-2">GOLD</th>
                    <th className="text-center text-xs text-muted-foreground pb-2 px-2">PLATINUM</th>
                    <th className="text-center text-xs text-muted-foreground pb-2 px-2">STRATEGIC</th>
                  </tr>
                </thead>
                <tbody>
                  {[
                    { role: 'REAL_ESTATE_AGENT', mult: 1.1 },
                    { role: 'RELOCATION_COMPANY', mult: 1.2 },
                    { role: 'CORPORATE_HR_PARTNER', mult: 1.15 },
                    { role: 'PROPERTY_MANAGER', mult: 1.0 },
                    { role: 'INVESTMENT_ADVISOR', mult: 1.1 },
                    { role: 'TRAVEL_AGENCY', mult: 0.85 },
                    { role: 'LOCAL_OPERATOR', mult: 0.9 },
                    { role: 'BUILDING_MANAGER', mult: 1.0 },
                  ].map(({ role, mult }) => (
                    <tr key={role} className="border-b border-white/5 hover:bg-white/5">
                      <td className="py-2 pr-4 text-xs text-foreground font-medium">{role.replace(/_/g, ' ')}</td>
                      {[5, 8, 10, 12, 15].map(base => (
                        <td key={base} className="py-2 px-2 text-center text-xs text-muted-foreground">
                          {Math.min(20, base * mult).toFixed(1)}%
                        </td>
                      ))}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-5 gap-3">
            {[
              { tier: 'REFERRAL', deals: '1-2/yr', color: 'border-slate-500/30 bg-slate-500/5 text-slate-400' },
              { tier: 'SILVER', deals: '3+ /yr', color: 'border-slate-300/30 bg-slate-300/5 text-slate-300' },
              { tier: 'GOLD', deals: '10+ /yr', color: 'border-amber-500/30 bg-amber-500/5 text-amber-400' },
              { tier: 'PLATINUM', deals: '25+ /yr', color: 'border-cyan-500/30 bg-cyan-500/5 text-cyan-400' },
              { tier: 'STRATEGIC', deals: 'JV/Alliance', color: 'border-purple-500/30 bg-purple-500/5 text-purple-400' },
            ].map(t => (
              <div key={t.tier} className={`rounded-xl border ${t.color} p-3 text-center`}>
                <div className="text-xs font-bold mb-0.5">{t.tier}</div>
                <div className="text-[9px] text-muted-foreground">{t.deals}</div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* ── Tab: AI Neural Swarm ─────────────────────────────────── */}
      {activeTab === 'swarm' && (
        <div className="space-y-4">
          <div className="rounded-xl border border-white/10 bg-white/5 p-5">
            <div className="flex items-center justify-between mb-4">
              <h3 className="font-semibold text-foreground flex items-center gap-2">
                <Cpu className="w-4 h-4 text-purple-400" />
                {t('global_os.swarm_title', 'Global Saga Orkestratör')}
              </h3>
              <div className="flex items-center gap-2">
                <select value={sagaCountry} onChange={e => setSagaCountry(e.target.value)}
                  className="bg-white/5 border border-white/10 rounded-lg px-2 py-1 text-xs text-foreground focus:outline-none">
                  {Object.values(COUNTRY_REGIONS).flat().map(code => (
                    <option key={code} value={code}>{code}</option>
                  ))}
                </select>
                <button onClick={handleSaga} disabled={sagaRunning}
                  className="flex items-center gap-1.5 px-4 py-2 bg-purple-500/20 hover:bg-purple-500/30 border border-purple-500/30 text-purple-400 rounded-lg text-sm font-medium transition-all">
                  {sagaRunning ? <RefreshCw className="w-4 h-4 animate-spin" /> : <Play className="w-4 h-4" />}
                  {sagaRunning ? t('global_os.saga_running', 'Çalışıyor...') : t('global_os.saga_start', 'Global Saga Başlat')}
                </button>
              </div>
            </div>

            {sagaResult ? (
              <div className="space-y-3">
                <div className={`flex items-center justify-between p-3 rounded-lg ${sagaResult.status === 'COMPLETED' ? 'bg-emerald-500/10 border border-emerald-500/20' : 'bg-red-500/10 border border-red-500/20'}`}>
                  <div className="flex items-center gap-2">
                    {sagaResult.status === 'COMPLETED' ? <CheckCircle2 className="w-4 h-4 text-emerald-400" /> : <AlertTriangle className="w-4 h-4 text-red-400" />}
                    <span className="text-sm font-semibold text-foreground">{sagaResult.status}</span>
                    <span className="text-xs text-muted-foreground">· {sagaResult.sagaId}</span>
                  </div>
                  <div className="text-xs text-muted-foreground">{sagaResult.countryCode} · {sagaResult.currency}</div>
                </div>
                <div className="space-y-2">
                  {sagaResult.steps?.map((step: any, i: number) => (
                    <div key={step.stepName} className="flex items-start gap-3 p-3 bg-white/5 rounded-lg">
                      <div className={`w-6 h-6 rounded-full flex items-center justify-center flex-shrink-0 text-[10px] font-bold ${
                        step.status === 'COMPLETED' ? 'bg-emerald-500/20 text-emerald-400' :
                        step.status === 'FAILED' ? 'bg-red-500/20 text-red-400' :
                        step.status === 'COMPENSATED' ? 'bg-amber-500/20 text-amber-400' :
                        'bg-white/10 text-muted-foreground'
                      }`}>
                        {step.status === 'COMPLETED' ? '✓' : step.status === 'FAILED' ? '✗' : step.status === 'COMPENSATED' ? '↩' : i + 1}
                      </div>
                      <div className="flex-1 min-w-0">
                        <div className="flex items-center gap-2">
                          <span className="text-xs font-medium text-foreground">{step.stepLabel}</span>
                          <span className="text-[9px] text-muted-foreground bg-white/5 px-1.5 py-0.5 rounded">{step.osModule}</span>
                        </div>
                        {step.error && <div className="text-[9px] text-red-400 mt-0.5">{step.error}</div>}
                        {step.data && Object.keys(step.data).length > 0 && (
                          <div className="flex flex-wrap gap-1 mt-1">
                            {Object.entries(step.data).slice(0, 3).map(([k, v]) => (
                              <span key={k} className="text-[9px] bg-white/5 text-muted-foreground px-1.5 py-0.5 rounded">
                                {k}: <span className="text-foreground">{String(v).slice(0, 20)}</span>
                              </span>
                            ))}
                          </div>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center py-12 text-muted-foreground">
                <Sparkles className="w-10 h-10 mb-3 opacity-30" />
                <p className="text-sm">{t('global_os.swarm_placeholder', 'Ülke seçin ve Global Saga Orkestratörü başlatın')}</p>
              </div>
            )}
          </div>

          {/* Agent registry */}
          <div className="rounded-xl border border-white/10 bg-white/5 p-5">
            <h3 className="font-semibold text-foreground mb-4 flex items-center gap-2">
              <Brain className="w-4 h-4 text-purple-400" />
              {t('global_os.swarm_agents', '10 Ajanlı Nöral Sürü Kayıt Defteri')}
            </h3>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
              {[
                { name: 'PropertyIntelligenceAgent', role: 'Physical & Zone Analysis', original: true },
                { name: 'LegalComplianceAgent', role: 'TR 7464 Law & Regulatory', original: true },
                { name: 'RevenueProjectionAgent', role: 'Revenue & P&L Projection', original: true },
                { name: 'PartnerMatchingAgent', role: 'Partner & Portfolio Matching', original: true },
                { name: 'OwnerNegotiationAgent', role: 'Owner Proposal & Negotiation', original: true },
                { name: 'CountryComplianceAgent', role: 'Global Legal & Permit Control', original: false },
                { name: 'MarketExpansionAgent', role: 'City & Market Opportunity', original: false },
                { name: 'TaxOptimizationAgent', role: 'Tax Structure Advisory', original: false },
                { name: 'CorporateDemandAgent', role: 'Corporate Client Demand', original: false },
                { name: 'GlobalPricingAgent', role: 'FX-Based Price Optimization', original: false },
              ].map(agent => (
                <div key={agent.name} className={`flex items-center gap-3 p-3 rounded-lg border ${agent.original ? 'border-white/10 bg-white/5' : 'border-purple-500/20 bg-purple-500/5'}`}>
                  <div className={`w-8 h-8 rounded-full flex items-center justify-center ${agent.original ? 'bg-white/10' : 'bg-purple-500/20'}`}>
                    <Brain className={`w-4 h-4 ${agent.original ? 'text-muted-foreground' : 'text-purple-400'}`} />
                  </div>
                  <div>
                    <div className="text-xs font-semibold text-foreground">{agent.name}</div>
                    <div className="text-[9px] text-muted-foreground">{agent.role}</div>
                  </div>
                  {!agent.original && (
                    <span className="ml-auto text-[9px] bg-purple-500/20 text-purple-400 px-1.5 py-0.5 rounded">NEW</span>
                  )}
                </div>
              ))}
            </div>
          </div>
        </div>
      )}
    </PageShell>
  );
}
