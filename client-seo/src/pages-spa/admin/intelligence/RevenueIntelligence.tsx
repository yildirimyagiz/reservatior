"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { tEnum } from "@/lib/admin-enums";
import { revenueIntelligenceApi } from "@/lib/api/revenue-intelligence";
import { 
  DollarSign,
  TrendingUp,
  Target,
  BarChart3,
  Activity,
  Zap,
  Brain,
  ArrowUpRight,
  ArrowDownRight,
  Calendar,
  Building2,
  Settings,
  Download,
  Filter,
  LineChart
} from "lucide-react";

export default function RevenueIntelligenceDashboard() { 
  const { t } = useTranslation();
  const { user } = useAuth();
  const { language, currency } = useLocalization();
  const orgId = user?.organizationId || "default_org";
  const [timeRange, setTimeRange] = useState<"7d" | "30d" | "90d" | "1y">("30d");
  const [selectedMetric, setSelectedMetric] = useState<"noi" | "yield" | "arbitrage">("noi");

  const { data: revenueStats, isLoading } = useQuery({
    queryKey: ["revenue-intelligence-dashboard", orgId, timeRange],
    queryFn: () => revenueIntelligenceApi.getStats(orgId, timeRange),
    enabled: true,
  });

  const formatCurrency = (val: number) => 
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatPercent = (val: number) => `${val.toFixed(1)}%`;

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = revenueStats || {
    totalRevenue: 0,
    netOperatingIncome: 0,
    yieldArbitrage: 0,
    revenueAttribution: 0,
    avgOccupancy: 0,
    revenueGrowth: 0,
    predictedRevenue: 0,
    optimizationPotential: 0,
  };

  const kpis = [
    { i18nKey: "admin_revenue_intelligence_total_revenue", title: "Total Revenue", value: formatCurrency(stats.totalRevenue), icon: DollarSign, color: "text-blue-600", trend: "+15.2%" },
    { i18nKey: "admin_revenue_intelligence_net_operating_income", title: "Net Operating Income", value: formatCurrency(stats.netOperatingIncome), icon: TrendingUp, color: "text-blue-600", trend: "+12.8%" },
    { i18nKey: "admin_revenue_intelligence_yield_arbitrage", title: "Yield Arbitrage", value: formatPercent(stats.yieldArbitrage), icon: Target, color: "text-brand", trend: "+8.5%" },
    { i18nKey: "admin_revenue_intelligence_revenue_attribution", title: "Revenue Attribution", value: formatPercent(stats.revenueAttribution), icon: BarChart3, color: "text-orange-600", trend: "+22.3%" },
    { i18nKey: "admin_revenue_intelligence_avg_occupancy", title: "Avg Occupancy", value: formatPercent(stats.avgOccupancy), icon: Building2, color: "text-brand", trend: "+3.2%" },
    { i18nKey: "admin_revenue_intelligence_revenue_growth", title: "Revenue Growth", value: formatPercent(stats.revenueGrowth), icon: Activity, color: "text-pink-600", trend: "+18.7%" },
  ];

  const revenueStreams = [
    { i18nKey: "admin_revenue_intelligence_direct_bookings", name: "Direct Bookings", value: 45, trend: "+12%", color: "bg-blue-500" },
    { i18nKey: "admin_revenue_intelligence_channel_partners", name: "Channel Partners", value: 32, trend: "+8%", color: "bg-blue-500" },
    { i18nKey: "admin_revenue_intelligence_corporate_contracts", name: "Corporate Contracts", value: 15, trend: "+15%", color: "bg-brand/100" },
    { i18nKey: "admin_revenue_intelligence_long_term_rentals", name: "Long-term Rentals", value: 8, trend: "+5%", color: "bg-orange-500" },
  ];

  const optimizationOpportunities = [
    { i18nKey: "admin_revenue_intelligence_opportunity_dynamic_pricing", name: "Dynamic Pricing", potential: "+18%", impact: "High", effort: "Medium" },
    { i18nKey: "admin_revenue_intelligence_opportunity_channel_optimization", name: "Channel Optimization", potential: "+12%", impact: "Medium", effort: "Low" },
    { i18nKey: "admin_revenue_intelligence_yield_arbitrage", name: "Yield Arbitrage", potential: "+8%", impact: "High", effort: "High" },
    { i18nKey: "admin_revenue_intelligence_opportunity_occupancy_boost", name: "Occupancy Boost", potential: "+6%", impact: "Medium", effort: "Medium" },
  ];

  const predictiveInsights = [
    { i18nKey: "admin_revenue_intelligence_next_month_revenue", metric: "Next Month Revenue", predicted: formatCurrency(stats.predictedRevenue), confidence: 92, trend: "up" },
    { i18nKey: "admin_revenue_intelligence_q3_forecast", metric: "Q3 Forecast", predicted: formatCurrency(stats.predictedRevenue * 3), confidence: 87, trend: "up" },
    { i18nKey: "admin_revenue_intelligence_annual_projection", metric: "Annual Projection", predicted: formatCurrency(stats.predictedRevenue * 12), confidence: 81, trend: "up" },
  ];

  return (
    <PageShell
      title={t("admin_revenue_intelligence_title", "Gelir Zekası (Revenue Intelligence)")}
      description={t("admin_revenue_intelligence_desc", "Gelir optimizasyonu, gelir paylaşımı ve tahminleme")}
      actions={
        <div className="flex gap-3">
          <select 
            value={timeRange} 
            onChange={(e) => setTimeRange(e.target.value as any)}
            className="px-4 py-2 border border-border rounded-lg bg-card"
          >
            <option value="7d">{t("admin_time_last_7d", "Son 7 Gün")}</option>
            <option value="30d">{t("admin_time_last_30d", "Son 30 Gün")}</option>
            <option value="90d">{t("admin_time_last_90d", "Son 90 Gün")}</option>
            <option value="1y">{t("admin_revenue_intelligence_last_year", "Geçen Yıl")}</option>
          </select>
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> {t("admin_revenue_intelligence_export_report", "Raporu Dışa Aktar")}
          </button>
        </div>
      }
    >
    <div className="space-y-6">

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-muted-foreground">{t(kpi.i18nKey, kpi.title)}</p>
                  <p className="text-2xl font-bold text-card-foreground mt-2">{kpi.value}</p>
                  <p className="text-sm text-blue-600 mt-1">{kpi.trend}</p>
                </div>
                <div className={`p-3 bg-muted rounded-lg ${kpi.color}`}>
                  <Icon className="w-6 h-6" />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2">
              <Brain className="w-5 h-5 text-brand" /> {t("admin_revenue_intelligence_noi_analysis", "NOI Optimizasyon Analizi")}
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-muted-foreground" /></button>
          </div>
          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
                <p className="text-sm text-muted-foreground">{t("admin_revenue_intelligence_current_noi", "Güncel NOI")}</p>
                <p className="text-xl font-bold text-blue-700">{formatCurrency(stats.netOperatingIncome)}</p>
              </div>
              <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
                <p className="text-sm text-muted-foreground">{t("admin_revenue_intelligence_optimization_potential", "Optimizasyon Potansiyeli")}</p>
                <p className="text-xl font-bold text-blue-700">{formatPercent(stats.optimizationPotential)}</p>
              </div>
            </div>
            <div className="space-y-2">
              <p className="text-sm font-medium text-muted-foreground">{t("admin_revenue_intelligence_ai_recommendations", "AI Önerileri:")}</p>
              <div className="p-3 bg-brand/10 rounded-lg border border-purple-200">
                <div className="flex items-center gap-2 mb-1">
                  <Zap className="w-4 h-4 text-brand" />
                  <span className="font-medium text-brand">{t("admin_revenue_intelligence_dynamic_pricing_adjustment", "Dinamik Fiyatlandırma Ayarlaması")}</span>
                </div>
                <p className="text-sm text-brand">{t("admin_revenue_intelligence_dynamic_pricing_desc", "Talep modellerine göre hafta sonu oranlarını %15 artırın")}</p>
              </div>
              <div className="p-3 bg-blue-50 rounded-lg border border-blue-200">
                <div className="flex items-center gap-2 mb-1">
                  <Target className="w-4 h-4 text-blue-600" />
                  <span className="font-medium text-blue-900">{t("admin_revenue_intelligence_expense_optimization", "Gider Optimizasyonu")}</span>
                </div>
                <p className="text-sm text-blue-700">{t("admin_revenue_intelligence_expense_optimization_desc", "Öngörülü planlama ile bakım maliyetlerini %8 azaltın")}</p>
              </div>
            </div>
          </div>
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2">
              <LineChart className="w-5 h-5 text-blue-600" /> {t("admin_revenue_intelligence_revenue_streams", "Gelir Akışları")}
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Filter className="w-4 h-4 text-muted-foreground" /></button>
          </div>
          <div className="space-y-3">
            {revenueStreams.map((stream, i) => (
              <div key={i} className="flex items-center justify-between p-4 bg-muted rounded-lg">
                <div className="flex items-center gap-3">
                  <div className={`w-3 h-3 rounded-full ${stream.color}`} />
                  <span className="font-medium text-card-foreground">{t(stream.i18nKey, stream.name)}</span>
                </div>
                <div className="flex items-center gap-4">
                  <span className="text-sm text-muted-foreground">{stream.value}%</span>
                  <span className="text-sm text-blue-600">{stream.trend}</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2">
              <Activity className="w-5 h-5 text-orange-600" /> {t("admin_revenue_intelligence_yield_arbitrage_analysis", "Getiri Arbitrajı Analizi")}
            </h2>
            <div className="flex gap-2">
              <button className={`px-3 py-1 rounded-lg text-sm ${selectedMetric === "noi" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-muted-foreground"}`} onClick={() => setSelectedMetric("noi")}>{t("admin_revenue_intelligence_noi", "NOI")}</button>
              <button className={`px-3 py-1 rounded-lg text-sm ${selectedMetric === "yield" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-muted-foreground"}`} onClick={() => setSelectedMetric("yield")}>{t("admin_revenue_intelligence_yield", "Getiri")}</button>
              <button className={`px-3 py-1 rounded-lg text-sm ${selectedMetric === "arbitrage" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-muted-foreground"}`} onClick={() => setSelectedMetric("arbitrage")}>{t("admin_revenue_intelligence_arbitrage", "Arbitraj")}</button>
            </div>
          </div>
          <div className="h-64 bg-gradient-to-br from-orange-50 to-orange-100 rounded-lg flex items-center justify-center">
            <div className="text-center">
              <LineChart className="w-12 h-12 mx-auto mb-3 text-orange-600" />
              <p className="text-lg font-semibold text-orange-900">{t("admin_revenue_intelligence_yield_arbitrage_viz", "Getiri Arbitrajı Görselleştirmesi")}</p>
              <p className="text-sm text-orange-700 mt-1">{t("admin_revenue_intelligence_yield_arbitrage_viz_desc", "Pazarlar arası getiri karşılaştırması ve optimizasyon fırsatları")}</p>
            </div>
          </div>
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
            <Zap className="w-5 h-5 text-yellow-600" /> {t("admin_revenue_intelligence_optimization_opportunities", "Optimizasyon Fırsatları")}
          </h2>
          <div className="space-y-3">
            {optimizationOpportunities.map((opp, i) => (
              <div key={i} className="p-4 bg-muted rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-medium text-card-foreground">{t(opp.i18nKey, opp.name)}</span>
                  <span className="text-sm font-bold text-blue-600">{opp.potential}</span>
                </div>
                <div className="flex items-center gap-2 text-xs">
                  <span className={`px-2 py-1 rounded-full ${
                    opp.impact === "High" ? "bg-red-100 text-red-700" : "bg-yellow-100 text-yellow-700"
                  }`}>{tEnum(t, opp.impact)} {t("admin_revenue_intelligence_impact", "Etki")}</span>
                  <span className={`px-2 py-1 rounded-full ${
                    opp.effort === "Low" ? "bg-blue-100 text-blue-700" : opp.effort === "Medium" ? "bg-blue-100 text-blue-700" : "bg-brand/15 text-brand"
                  }`}>{tEnum(t, opp.effort)} {t("admin_revenue_intelligence_effort", "Efor")}</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2">
            <Brain className="w-5 h-5 text-brand" /> {t("admin_revenue_intelligence_predictive_insights", "Öngörücü Gelir Analizleri")}
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Calendar className="w-4 h-4 text-muted-foreground" /></button>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {predictiveInsights.map((insight, i) => (
            <div key={i} className="p-4 bg-brand/10 rounded-lg border border-brand/30">
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm text-muted-foreground">{t(insight.i18nKey, insight.metric)}</span>
                {insight.trend === "up" ? <ArrowUpRight className="w-4 h-4 text-blue-600" /> : <ArrowDownRight className="w-4 h-4 text-red-600" />}
              </div>
              <p className="text-xl font-bold text-brand">{insight.predicted}</p>
              <div className="flex items-center gap-2 mt-2">
                <div className="flex-1 bg-brand rounded-full h-2">
                  <div className="bg-primary text-primary-foreground h-2 rounded-full" style={{ width: `${insight.confidence}%` }} />
                </div>
                <span className="text-xs text-brand">{insight.confidence}% {t("admin_revenue_intelligence_confidence", "güven")}</span>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  </PageShell>
  );
}
