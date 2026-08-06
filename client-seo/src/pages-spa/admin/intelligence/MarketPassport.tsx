"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import {
  Globe, TrendingUp, TrendingDown, DollarSign, Building2, BarChart3,
  ArrowUpRight, ArrowDownRight, Activity, Target, MapPin, Users,
  Download, Zap, Eye, Star
} from "lucide-react";
import { apiClient } from "@/lib/api";
import { tEnum } from "@/lib/admin-enums";

async function fetchMarketPassport(orgId: string, marketId: string) {
  try {
    const res: any = await apiClient.get(`/intelligence/market-passport/${marketId}`);
    return res.data;
  } catch { return null; }
}

export default function MarketPassportDashboard() { 
  const { t } = useTranslation();
  const { user } = useAuth();
  const { language } = useLocalization();
  const currency = user?.preferences?.currency || "USD";
  const orgId = user?.orgId || "";
  const [selectedMarket, setSelectedMarket] = useState("london");

  const { data: passport, isLoading } = useQuery({
    queryKey: ["market-passport", selectedMarket],
    queryFn: () => fetchMarketPassport(orgId, selectedMarket),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const markets = [
    { id: "london", name: "London" }, { id: "manchester", name: "Manchester" },
    { id: "istanbul", name: "Istanbul" }, { id: "dubai", name: "Dubai" },
    { id: "new-york", name: "New York" }, { id: "miami", name: "Miami" },
  ];

  const kpis = [
    { i18nKey: "admin_market_passport_avg_price_sqm", title: "Avg Price/sqm", value: formatCurrency(passport?.avgPricePerSqm ?? 8500), icon: DollarSign, color: "text-blue-600", bg: "bg-blue-50", trend: "+5.2%" },
    { i18nKey: "admin_market_passport_demand_index", title: "Demand Index", value: `${passport?.demandIndex ?? 78}/100`, icon: TrendingUp, color: "text-blue-600", bg: "bg-blue-50", trend: "+12.3%" },
    { i18nKey: "admin_market_passport_supply_ratio", title: "Supply Ratio", value: `${passport?.supplyRatio ?? 0.65}`, icon: Building2, color: "text-brand", bg: "bg-brand/10", trend: "-3.1%" },
    { i18nKey: "admin_market_passport_avg_yield", title: "Avg Yield", value: `${passport?.avgYield ?? 5.8}%`, icon: Target, color: "text-orange-600", bg: "bg-orange-50", trend: "+0.4%" },
    { i18nKey: "admin_market_passport_active_listings", title: "Active Listings", value: passport?.activeListings ?? 3420, icon: Eye, color: "text-brand", bg: "bg-brand/10", trend: "+8%" },
    { i18nKey: "admin_market_passport_avg_dom", title: "Avg DOM", value: `${passport?.avgDaysOnMarket ?? 42}d`, icon: Activity, color: "text-pink-600", bg: "bg-pink-50", trend: "-5d" },
  ];

  const districtData = [
    { name: "Kensington", avgPrice: "£1.2M", yield: "3.8%", demand: 92, trend: "up" },
    { name: "Shoreditch", avgPrice: "£650K", yield: "5.2%", demand: 88, trend: "up" },
    { name: "Canary Wharf", avgPrice: "£580K", yield: "5.8%", demand: 75, trend: "stable" },
    { name: "Brixton", avgPrice: "£420K", yield: "6.1%", demand: 82, trend: "up" },
    { name: "Chelsea", avgPrice: "£1.8M", yield: "3.2%", demand: 70, trend: "down" },
    { name: "Greenwich", avgPrice: "£380K", yield: "6.5%", demand: 78, trend: "up" },
  ];

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  return (
    <PageShell
      title={t("admin_market_passport_title", "Bölge Zekası (Market Passport)")}
      description={t("admin_market_passport_desc", "Bölgesel talep, rekabet ve fiyatlandırma zekası")}
      actions={
        <div className="flex gap-3">
          <select value={selectedMarket} onChange={(e) => setSelectedMarket(e.target.value)} className="px-4 py-2 border border-border rounded-lg bg-card">
            {markets.map(m => <option key={m.id} value={m.id}>{m.name}</option>)}
          </select>
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> {t("admin_common_export", "Dışa Aktar")}
          </button>
        </div>
      }
    >
    <div className="space-y-6">

      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-card rounded-xl shadow-sm p-4 border border-border">
              <div className="flex items-center gap-2 mb-2"><div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div></div>
              <p className="text-2xl font-bold text-card-foreground">{kpi.value}</p>
              <div className="flex items-center gap-1 mt-1">
                <span className={`text-xs ${kpi.trend.startsWith('+') || kpi.trend.startsWith('-') && !kpi.trend.includes('d') ? 'text-blue-600' : 'text-muted-foreground'}`}>{kpi.trend}</span>
              </div>
              <p className="text-xs text-muted-foreground">{t(kpi.i18nKey, kpi.title)}</p>
            </div>
          );
        })}
      </div>

      {/* District Comparison */}
      <div className="bg-card rounded-xl shadow-sm border border-border overflow-hidden">
        <div className="p-4 border-b border-border">
          <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2">
            <MapPin className="w-5 h-5 text-brand" /> {t("admin_market_passport_district_intelligence", "Bölge Zekası")}
          </h2>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-muted text-left">
              <tr>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_market_passport_district", "Bölge")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_market_passport_avg_price", "Ort. Fiyat")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_market_passport_yield", "Getiri")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_market_passport_demand", "Talep")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_market_passport_trend", "Eğilim")}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {districtData.map((d, i) => (
                <tr key={i} className="hover:bg-muted transition">
                  <td className="px-4 py-3 text-sm font-medium text-card-foreground">{d.name}</td>
                  <td className="px-4 py-3 text-sm text-muted-foreground">{d.avgPrice}</td>
                  <td className="px-4 py-3 text-sm text-muted-foreground">{d.yield}</td>
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-2">
                      <div className="w-16 bg-gray-200 rounded-full h-1.5">
                        <div className={`h-1.5 rounded-full ${d.demand >= 85 ? 'bg-blue-500' : d.demand >= 70 ? 'bg-yellow-500' : 'bg-red-500'}`} style={{ width: `${d.demand}%` }} />
                      </div>
                      <span className="text-xs">{d.demand}</span>
                    </div>
                  </td>
                  <td className="px-4 py-3">
                    {d.trend === "up" ? <ArrowUpRight className="w-4 h-4 text-blue-600" /> :
                     d.trend === "down" ? <ArrowDownRight className="w-4 h-4 text-red-600" /> :
                     <Activity className="w-4 h-4 text-gray-400" />}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Market Health + Strategy */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2 mb-4">
            <Zap className="w-5 h-5 text-orange-600" /> {t("admin_market_passport_health_score", "Pazar Sağlık Skoru")}
          </h2>
          <div className="grid grid-cols-2 gap-4">
            {[
              { i18nKey: "admin_market_passport_health_liquidity", label: "Liquidity", score: 82, color: "bg-blue-500" },
              { i18nKey: "admin_market_passport_health_stability", label: "Stability", score: 74, color: "bg-blue-500" },
              { i18nKey: "admin_market_passport_health_growth", label: "Growth Potential", score: 88, color: "bg-brand/100" },
              { i18nKey: "admin_market_passport_health_risk", label: "Risk", score: 35, color: "bg-red-500" },
            ].map((h, i) => (
              <div key={i} className="p-3 bg-muted rounded-lg">
                <p className="text-sm text-muted-foreground">{t(h.i18nKey, h.label)}</p>
                <div className="flex items-center gap-2 mt-1">
                  <div className="flex-1 bg-gray-200 rounded-full h-2">
                    <div className={`h-2 rounded-full ${h.color}`} style={{ width: `${h.score}%` }} />
                  </div>
                  <span className="text-sm font-bold">{h.score}</span>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2 mb-4">
            <Star className="w-5 h-5 text-yellow-500" /> {t("admin_market_passport_marketing_strategy", "AI Pazarlama Stratejisi")}
          </h2>
          <div className="space-y-3">
            <div className="p-3 bg-blue-50 rounded-lg border border-blue-200">
              <p className="text-sm font-medium text-blue-800">{t("admin_market_passport_target_audience", "Hedef Kitle")}</p>
              <p className="text-xs text-blue-600 mt-1">{t("admin_market_passport_target_audience_desc", "Genç profesyoneller (25-35), uzaktan çalışanlar, uluslararası yatırımcılar")}</p>
            </div>
            <div className="p-3 bg-blue-50 rounded-lg border border-blue-200">
              <p className="text-sm font-medium text-blue-800">{t("admin_market_passport_recommended_channels", "Önerilen Kanallar")}</p>
              <p className="text-xs text-blue-600 mt-1">{t("admin_market_passport_recommended_channels_desc", "Google Ads, Instagram, LinkedIn, Emlak portalları")}</p>
            </div>
            <div className="p-3 bg-brand/10 rounded-lg border border-purple-200">
              <p className="text-sm font-medium text-brand">{t("admin_market_passport_content_focus", "İçerik Odağı")}</p>
              <p className="text-xs text-brand mt-1">{t("admin_market_passport_content_focus_desc", "Yatırım getirileri, yaşam tarzı avantajları, ulaşım bağlantıları")}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </PageShell>
  );
}
