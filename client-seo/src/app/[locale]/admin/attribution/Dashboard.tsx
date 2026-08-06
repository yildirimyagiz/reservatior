"use client";

import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { attributionApi } from "@/lib/api/attribution";
import { 
  Target,
  DollarSign,
  BarChart3,
  Activity,
  Link,
  CheckCircle,
  Clock,
  Globe,
  Zap,
  Settings,
  Download,
  Filter,
  LineChart
} from "lucide-react";
import { tEnum } from "@/lib/admin-enums";

export default function AttributionDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const [selectedChannel, setSelectedChannel] = useState<"all" | "google" | "meta" | "organic">("all");
  const { t } = useTranslation();

  const { data: attributionStats, isLoading } = useQuery({
    queryKey: ["attribution-dashboard", orgId, selectedChannel],
    queryFn: () => attributionApi.getStats(orgId, "30d", selectedChannel),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) => 
    new Intl.NumberFormat(language, { style: 'currency', currency: 'USD', maximumFractionDigits: 0 } as any).format(val);
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatPercent = (val: number) => `${val.toFixed(1)}%`;

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = attributionStats || {
    attributedRevenue: 0,
    attributionAccuracy: 0,
    totalConversions: 0,
    avgAttributionTime: 0,
    capiMatchRate: 0,
    offlineAttribution: 0,
  };

  const kpis = [
    { title: t("admin_attribution_kpi_revenue", "İlişkilendirilmiş Gelir"), value: formatCurrency(stats.attributedRevenue), icon: DollarSign, color: "text-blue-600", trend: "+22.5%" },
    { title: t("admin_attribution_kpi_accuracy", "İlişkilendirme Doğruluğu"), value: formatPercent(stats.attributionAccuracy), icon: Target, color: "text-blue-600", trend: "+5.3%" },
    { title: t("admin_attribution_kpi_conversions", "Toplam Dönüşümler"), value: formatNumber(stats.totalConversions), icon: CheckCircle, color: "text-brand", trend: "+18.7%" },
    { title: t("admin_attribution_kpi_avg_time", "Ort. İlişkilendirme Süresi"), value: `${stats.avgAttributionTime}h`, icon: Clock, color: "text-orange-600", trend: "-12.2%" },
    { title: t("admin_attribution_kpi_capi", "CAPI Eşleşme Oranı"), value: formatPercent(stats.capiMatchRate), icon: Link, color: "text-brand", trend: "+8.4%" },
    { title: t("admin_attribution_kpi_offline", "Çevrimdışı İlişkilendirme"), value: formatPercent(stats.offlineAttribution), icon: Activity, color: "text-pink-600", trend: "+15.1%" },
  ];

  const attributionChannels = [
    { name: t("admin_attribution_channel_google", "Google Ads CAPI"), revenue: 145000, conversions: 234, matchRate: 0.92, status: "connected" },
    { name: t("admin_attribution_channel_meta", "Meta Ads CAPI"), revenue: 98000, conversions: 189, matchRate: 0.88, status: "connected" },
    { name: t("admin_attribution_channel_organic", "Organik Trafik"), revenue: 67000, conversions: 145, matchRate: 0.95, status: "active" },
    { name: t("admin_attribution_channel_direct", "Doğrudan Trafik"), revenue: 45000, conversions: 87, matchRate: 0.82, status: "active" },
  ];

  const attributionJourney = [
    { step: t("admin_attribution_step_ad_click", "Reklam Tıklaması"), time: "0s", channel: "Google Ads", channelKey: "", status: "completed" },
    { step: t("admin_attribution_step_landing", "Açılış Sayfası"), time: "2s", channel: "Website", channelKey: "admin_attribution_channel_website", status: "completed" },
    { step: t("admin_attribution_step_property_view", "Mülk Görüntüleme"), time: "45s", channel: "Website", channelKey: "admin_attribution_channel_website", status: "completed" },
    { step: t("admin_attribution_step_lead_form", "Potansiyel Müşteri Formu"), time: "3m", channel: "Website", channelKey: "admin_attribution_channel_website", status: "completed" },
    { step: t("admin_attribution_step_contract", "Sözleşme İmzalandı"), time: "5d", channel: "Offline", channelKey: "", status: "completed" },
    { step: t("admin_attribution_step_revenue", "İlişkilendirilmiş Gelir"), time: "5d", channel: "CAPI", channelKey: "", status: "completed" },
  ];

  const offlineConversions = [
    { id: "conv-1", property: "Property #123", value: 45000, source: "Google Ads", date: "2024-01-15", status: "attributed" },
    { id: "conv-2", property: "Property #456", value: 78000, source: "Meta Ads", date: "2024-01-18", status: "attributed" },
    { id: "conv-3", property: "Property #789", value: 32000, source: "Organic", date: "2024-01-20", status: "pending" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_attribution_title", "Kapalı Döngü İlişkilendirme Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_attribution_description", "CAPI entegrasyonu ile gelir ilişkilendirme takibi")}</p>
        </div>
        <div className="flex gap-3">
          <select 
            value={selectedChannel} 
            onChange={(e) => setSelectedChannel(e.target.value as "all" | "google" | "meta" | "organic")}
            className="px-4 py-2 border border-border rounded-lg bg-card"
          >
            <option value="all">{t("admin_attribution_all_channels", "Tüm Kanallar")}</option>
            <option value="google">{t("admin_attribution_google_ads", "Google Ads")}</option>
            <option value="meta">{t("admin_attribution_meta_ads", "Meta Ads")}</option>
            <option value="organic">{t("admin_attribution_organic", "Organik")}</option>
          </select>
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> {t("admin_attribution_export_report", "Raporu Dışa Aktar")}
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-muted-foreground">{kpi.title}</p>
                  <p className="text-2xl font-bold text-foreground mt-2">{kpi.value}</p>
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
            <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
              <Link className="w-5 h-5 text-blue-600" /> {t("admin_attribution_capi_status", "CAPI Entegrasyon Durumu")}
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-muted-foreground" /></button>
          </div>
          <div className="space-y-3">
            {attributionChannels.map((channel, i) => (
              <div key={i} className="p-4 bg-muted rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-3">
                    <Globe className="w-5 h-5 text-muted-foreground" />
                    <span className="font-medium text-foreground">{channel.name}</span>
                    <span className={`text-xs px-2 py-1 rounded-full ${
                      channel.status === "connected" ? "bg-blue-100 text-blue-700" : "bg-blue-100 text-blue-700"
                    }`}>{tEnum(t, channel.status)}</span>
                  </div>
                  <span className="text-sm font-bold text-foreground">{formatCurrency(channel.revenue)}</span>
                </div>
                <div className="grid grid-cols-2 gap-2 text-sm">
                  <div>
                    <p className="text-muted-foreground">{t("admin_attribution_conversions", "Dönüşümler")}</p>
                    <p className="font-medium">{channel.conversions}</p>
                  </div>
                  <div>
                    <p className="text-muted-foreground">{t("admin_attribution_match_rate", "Eşleşme Oranı")}</p>
                    <p className="font-medium">{formatPercent(channel.matchRate)}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
              <Zap className="w-5 h-5 text-yellow-600" /> {t("admin_attribution_journey", "İlişkilendirme Yolculuğu")}
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Filter className="w-4 h-4 text-muted-foreground" /></button>
          </div>
          <div className="space-y-2">
            {attributionJourney.map((step, i) => (
              <div key={i} className="flex items-center gap-3 p-3 bg-muted rounded-lg">
                <div className={`w-8 h-8 rounded-full flex items-center justify-center ${
                  step.status === "completed" ? "bg-blue-100 text-blue-700" : "bg-yellow-100 text-yellow-700"
                }`}>
                  {step.status === "completed" ? <CheckCircle className="w-4 h-4" /> : <Clock className="w-4 h-4" />}
                </div>
                <div className="flex-1">
                  <div className="flex items-center justify-between">
                    <span className="font-medium text-foreground">{step.step}</span>
                    <span className="text-sm text-muted-foreground">{step.time}</span>
                  </div>
                  <p className="text-xs text-muted-foreground">{step.channelKey ? t(step.channelKey, step.channel) : step.channel}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
            <Activity className="w-5 h-5 text-brand" /> {t("admin_attribution_offline_title", "Çevrimdışı Dönüşüm İlişkilendirme")}
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Download className="w-4 h-4 text-muted-foreground" /></button>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="border-b border-border">
                <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_attribution_property", "Mülk")}</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_attribution_value", "Değer")}</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_attribution_source", "Kaynak")}</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_attribution_date", "Tarih")}</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_common_status", "Durum")}</th>
              </tr>
            </thead>
            <tbody>
              {offlineConversions.map((conv) => (
                <tr key={conv.id} className="border-b border-border">
                  <td className="py-3 px-4 text-sm font-medium text-foreground">{conv.property}</td>
                  <td className="py-3 px-4 text-sm text-foreground">{formatCurrency(conv.value)}</td>
                  <td className="py-3 px-4 text-sm text-muted-foreground">{conv.source}</td>
                  <td className="py-3 px-4 text-sm text-muted-foreground">{conv.date}</td>
                  <td className="py-3 px-4">
                    <span className={`text-xs px-2 py-1 rounded-full ${
                      conv.status === "attributed" ? "bg-blue-100 text-blue-700" : "bg-yellow-100 text-yellow-700"
                    }`}>{tEnum(t, conv.status)}</span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
            <LineChart className="w-5 h-5 text-brand" /> {t("admin_attribution_trend_title", "Gelir İlişkilendirme Trendi")}
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-muted-foreground" /></button>
        </div>
        <div className="h-64 bg-gradient-to-br from-brand/10 to-indigo-100 rounded-lg flex items-center justify-center">
          <div className="text-center">
            <BarChart3 className="w-12 h-12 mx-auto mb-3 text-brand" />
            <p className="text-lg font-semibold text-brand">{t("admin_attribution_trend_visualization", "Gelir İlişkilendirme Görselleştirmesi")}</p>
            <p className="text-sm text-brand mt-1">{t("admin_attribution_trend_desc", "Zaman içinde çapraz kanal gelir ilişkilendirmesi")}</p>
          </div>
        </div>
      </div>
    </div>
  );
}
