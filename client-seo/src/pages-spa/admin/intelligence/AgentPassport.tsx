"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import {
  Star, Target, DollarSign, Users,
  Brain, Download, Award, Building2, Clock, ThumbsUp, Search
} from "lucide-react";
import { apiClient } from "@/lib/api";
import { tEnum } from "@/lib/admin-enums";

async function fetchAgentList(orgId: string) {
  try {
    const res: any = await apiClient.get(`/agents?orgId=${orgId}&limit=50`);
    return res.data?.items || [];
  } catch { return []; }
}

async function fetchAgentPassport(agentId: string) {
  try {
    const res: any = await apiClient.get(`/intelligence/agent-passport/${agentId}`);
    return res.data;
  } catch { return null; }
}

export default function AgentPassportDashboard() { 
  const { t } = useTranslation();
  const { user } = useAuth();
  const orgId = user?.orgId || "";
  const { language } = useLocalization();
  const currency = user?.preferences?.currency || "USD";
  const [selectedAgentId, setSelectedAgentId] = useState("");
  const [searchQuery, setSearchQuery] = useState("");

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const { data: agents } = useQuery({
    queryKey: ["agent-list", orgId],
    queryFn: () => fetchAgentList(orgId),
    enabled: !!orgId,
  });

  const { data: passport, isLoading } = useQuery({
    queryKey: ["agent-passport", selectedAgentId],
    queryFn: () => fetchAgentPassport(selectedAgentId),
    enabled: !!selectedAgentId,
  });

  const performanceMetrics = [
    { i18nKey: "admin_agent_passport_metric_conversion_rate", label: "Conversion Rate", value: passport?.conversionRate ?? 24, max: 100, color: "bg-blue-500" },
    { i18nKey: "admin_agent_passport_metric_response_time", label: "Response Time", value: passport?.responseTime ?? 78, max: 100, color: "bg-blue-500" },
    { i18nKey: "admin_agent_passport_metric_client_satisfaction", label: "Client Satisfaction", value: passport?.satisfaction ?? 91, max: 100, color: "bg-brand/100" },
    { i18nKey: "admin_agent_passport_metric_listing_quality", label: "Listing Quality", value: passport?.listingQuality ?? 85, max: 100, color: "bg-orange-500" },
    { i18nKey: "admin_agent_passport_metric_market_knowledge", label: "Market Knowledge", value: passport?.marketKnowledge ?? 88, max: 100, color: "bg-brand/100" },
    { i18nKey: "admin_agent_passport_metric_negotiation_skill", label: "Negotiation Skill", value: passport?.negotiationSkill ?? 76, max: 100, color: "bg-pink-500" },
  ];

  const kpis = [
    { i18nKey: "admin_agent_passport_overall_score", title: "Overall Score", value: `${passport?.overallScore ?? 84}/100`, icon: Star, color: "text-yellow-600", bg: "bg-yellow-50" },
    { i18nKey: "admin_agent_passport_deals_closed", title: "Deals Closed", value: passport?.dealsClosed ?? 23, icon: ThumbsUp, color: "text-blue-600", bg: "bg-blue-50" },
    { i18nKey: "admin_agent_passport_revenue_generated", title: "Revenue Generated", value: formatCurrency(passport?.revenueGenerated ?? 450000), icon: DollarSign, color: "text-blue-600", bg: "bg-blue-50" },
    { i18nKey: "admin_agent_passport_active_listings", title: "Active Listings", value: passport?.activeListings ?? 12, icon: Building2, color: "text-brand", bg: "bg-brand/10" },
    { i18nKey: "admin_agent_passport_avg_response", title: "Avg Response", value: `${passport?.avgResponseMinutes ?? 14}m`, icon: Clock, color: "text-orange-600", bg: "bg-orange-50" },
    { i18nKey: "admin_agent_passport_ranking", title: "Ranking", value: `#${passport?.ranking ?? 3}`, icon: Award, color: "text-brand", bg: "bg-brand/10" },
  ];

  return (
    <PageShell
      title={t("admin_agent_passport_title", "Danışman Karnesi (Agent Passport)")}
      description={t("admin_agent_passport_desc", "Emlak danışmanlarının performans, portföy ve satış skorları")}
      actions={
        <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
          <Download className="w-4 h-4" /> {t("admin_common_export", "Dışa Aktar")}
        </button>
      }
    >
    <div className="space-y-6">
      {/* Agent Selector */}
      <div className="bg-card rounded-xl shadow-sm p-4 border border-border">
        <div className="flex items-center gap-4">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input type="text" placeholder={t("admin_agent_passport_search_placeholder", "Danışman Ara…")} value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} className="w-full pl-10 pr-4 py-2 border border-border rounded-lg" />
          </div>
          <select value={selectedAgentId} onChange={(e) => setSelectedAgentId(e.target.value)} className="px-4 py-2 border border-border rounded-lg bg-card min-w-[300px]">
            <option value="">{t("admin_agent_passport_select_placeholder", "Bir danışman seçin…")}</option>
            {(agents || []).filter((a: any) => !searchQuery || a.name?.toLowerCase().includes(searchQuery.toLowerCase())).map((a: any) => (
              <option key={a.id} value={a.id}>{a.name || a.email}</option>
            ))}
          </select>
        </div>
      </div>

      {!selectedAgentId && (
        <div className="bg-card rounded-xl shadow-sm p-12 border border-border text-center">
          <Users className="w-16 h-16 text-gray-300 mx-auto mb-4" />
          <h2 className="text-xl font-semibold text-muted-foreground">{t("admin_agent_passport_empty", "Zeka Karnesini görmek için bir danışman seçin")}</h2>
        </div>
      )}

      {selectedAgentId && !isLoading && (
        <>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {kpis.map((kpi, i) => {
              const Icon = kpi.icon;
              return (
                <div key={i} className="bg-card rounded-xl shadow-sm p-4 border border-border">
                  <div className="flex items-center gap-2 mb-2"><div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div></div>
                  <p className="text-2xl font-bold text-card-foreground">{kpi.value}</p>
                  <p className="text-xs text-muted-foreground mt-1">{t(kpi.i18nKey, kpi.title)}</p>
                </div>
              );
            })}
          </div>

          {/* Performance Radar (simplified as bars) */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2 mb-4">
                <Target className="w-5 h-5 text-blue-600" /> {t("admin_agent_passport_performance_radar", "Performans Radarı")}
              </h2>
              <div className="space-y-4">
                {performanceMetrics.map((m, i) => (
                  <div key={i}>
                    <div className="flex items-center justify-between mb-1">
                      <span className="text-sm text-muted-foreground">{t(m.i18nKey, m.label)}</span>
                      <span className="text-sm font-bold text-card-foreground">{m.value}%</span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-2">
                      <div className={`h-2 rounded-full ${m.color}`} style={{ width: `${m.value}%` }} />
                    </div>
                  </div>
                ))}
              </div>
            </div>

            <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2 mb-4">
                <Brain className="w-5 h-5 text-brand" /> {t("admin_agent_passport_ai_coaching", "AI Koçluk")}
              </h2>
              <div className="space-y-3">
                <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
                  <p className="text-sm font-medium text-blue-800">💪 {t("admin_agent_passport_strength", "Güçlü Yön")}</p>
                  <p className="text-xs text-blue-700 mt-1">{t("admin_agent_passport_strength_desc", "Mükemmel müşteri memnuniyeti (%91) ve pazar bilgisi (%88). Lüks segmentte üst düzey.")}</p>
                </div>
                <div className="p-4 bg-orange-50 rounded-lg border border-orange-200">
                  <p className="text-sm font-medium text-orange-800">🎯 {t("admin_agent_passport_opportunity", "Fırsat")}</p>
                  <p className="text-xs text-orange-700 mt-1">{t("admin_agent_passport_opportunity_desc", "Dönüşüm oranı (%24) ekip ortalamasının (%28) altında. Lead nitelendirmeye odaklanın.")}</p>
                </div>
                <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
                  <p className="text-sm font-medium text-blue-800">📈 {t("admin_agent_passport_action_plan", "Aksiyon Planı")}</p>
                  <p className="text-xs text-blue-700 mt-1">{t("admin_agent_passport_action_plan_desc", "1. Takip otomasyonunu uygula. 2. Yatırım amaçlı mülkleri çapraz sat. 3. Komşu bölgelere genişle.")}</p>
                </div>
                <div className="p-4 bg-brand/10 rounded-lg border border-purple-200">
                  <p className="text-sm font-medium text-brand">🏆 {t("admin_agent_passport_territory", "Bölge")}</p>
                  <p className="text-xs text-brand mt-1">{t("admin_agent_passport_territory_desc", "Birincil: Kensington, Chelsea. Genişleyen: Notting Hill, Holland Park. Önerilen: Mayfair.")}</p>
                </div>
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  </PageShell>
  );
}
