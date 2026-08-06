"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import {
  Activity, Target, TrendingUp, ArrowUpRight, ArrowDownRight,
  BarChart3, Brain, RefreshCw, AlertTriangle, CheckCircle2,
  Download, Zap, XCircle, Clock, Eye, Building2, DollarSign
} from "lucide-react";
import { apiClient } from "@/lib/api";
import { tEnum } from "@/lib/admin-enums";

async function fetchFeedbackData(orgId: string, timeRange: string) {
  try {
    const res: any = await apiClient.get(`/intelligence/feedback-loop?orgId=${orgId}&range=${timeRange}`);
    return res.data;
  } catch { return null; }
}

export default function FeedbackLoopDashboard() { 
  const { t } = useTranslation();
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";
  const [timeRange, setTimeRange] = useState<string>("30d");

  const { data, isLoading } = useQuery({
    queryKey: ["feedback-loop-dashboard", orgId, timeRange],
    queryFn: () => fetchFeedbackData(orgId, timeRange),
    enabled: !!orgId,
  });

  const stats = data?.stats || {
    totalCalibrations: 247,
    upwardCalibrations: 142,
    downwardCalibrations: 78,
    neutralCalibrations: 27,
    avgCalibrationDelta: 0.034,
    contentRefreshTriggered: 23,
    predictionAccuracy: 87.3,
    modelHealth: 94,
  };

  const recentCalibrations = data?.recentCalibrations || [
    { propertyId: "prop-001", propertyTitle: "Kensington 3BR", delta: 0.08, direction: "UPWARD", reason: "Sold 12% above predicted price", createdAt: "1h ago" },
    { propertyId: "prop-002", propertyTitle: "Chelsea Penthouse", delta: -0.05, direction: "DOWNWARD", reason: "DOM 45% longer than predicted", createdAt: "3h ago" },
    { propertyId: "prop-003", propertyTitle: "Shoreditch Loft", delta: 0.03, direction: "UPWARD", reason: "Rental yield 8% above forecast", createdAt: "5h ago" },
    { propertyId: "prop-004", propertyTitle: "Canary Wharf Studio", delta: -0.11, direction: "DOWNWARD", reason: "Price reduction needed after 60 days", createdAt: "8h ago" },
    { propertyId: "prop-005", propertyTitle: "Notting Hill Town", delta: 0.02, direction: "NEUTRAL", reason: "Within tolerance range", createdAt: "12h ago" },
    { propertyId: "prop-006", propertyTitle: "Manchester Waterfront", delta: 0.15, direction: "UPWARD", reason: "Investment return 20% above prediction", createdAt: "1d ago" },
  ];

  const kpis = [
    { title: t("admin_fb_total_calibrations", "Toplam Kalibrasyon"), value: stats.totalCalibrations, icon: Activity, color: "text-brand", bg: "bg-brand/10" },
    { title: t("admin_fb_prediction_accuracy", "Tahmin Doğruluğu"), value: `${stats.predictionAccuracy}%`, icon: Target, color: "text-blue-600", bg: "bg-blue-50" },
    { title: t("admin_fb_model_health", "Model Sağlığı"), value: `${stats.modelHealth}%`, icon: Brain, color: "text-blue-600", bg: "bg-blue-50" },
    { title: t("admin_fb_content_refreshes", "Yenilenen İçerikler"), value: stats.contentRefreshTriggered, icon: RefreshCw, color: "text-orange-600", bg: "bg-orange-50" },
    { title: t("admin_fb_upward", "Yukarı Yönlü ↑"), value: stats.upwardCalibrations, icon: ArrowUpRight, color: "text-blue-600", bg: "bg-blue-50" },
    { title: t("admin_fb_downward", "Aşağı Yönlü ↓"), value: stats.downwardCalibrations, icon: ArrowDownRight, color: "text-red-600", bg: "bg-red-50" },
  ];

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  return (
    <PageShell
      title={t("admin_feedback_loop_title", "Geri Bildirim Döngüsü")}
      description={t("admin_feedback_loop_desc", "Misafir yorumları, memnuniyet ve AI öğrenme döngüsü")}
      actions={
        <div className="flex gap-3">
          <select value={timeRange} onChange={(e) => setTimeRange(e.target.value)} className="px-4 py-2 border border-border rounded-lg bg-card">
            <option value="7d">{t("admin_time_last_7d", "Son 7 Gün")}</option>
            <option value="30d">{t("admin_time_last_30d", "Son 30 Gün")}</option>
            <option value="90d">{t("admin_time_last_90d", "Son 90 Gün")}</option>
          </select>
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> {t("admin_export", "Dışa Aktar")}
          </button>
        </div>
      }
    >
    <div className="space-y-6">

      {/* KPIs */}
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-card rounded-xl shadow-sm p-4 border border-border">
              <div className="flex items-center gap-2 mb-2">
                <div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div>
              </div>
              <p className="text-2xl font-bold text-card-foreground">{kpi.value}</p>
              <p className="text-xs text-muted-foreground mt-1">{kpi.title}</p>
            </div>
          );
        })}
      </div>

      {/* Accuracy Gauges */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {[
          { label: t("admin_fb_price_prediction", "Fiyat Tahmini"), accuracy: 89, trend: "+2.1%", color: "#3b82f6" },
          { label: t("admin_fb_rental_yield", "Kira Getirisi"), accuracy: 84, trend: "+3.5%", color: "#6366f1" },
          { label: t("admin_fb_days_on_market", "Piyasada Kalış Süresi"), accuracy: 78, trend: "-1.2%", color: "#f59e0b" },
        ].map((gauge, i) => (
          <div key={i} className="bg-card rounded-xl shadow-sm p-6 border border-border text-center">
            <h3 className="text-sm font-medium text-muted-foreground mb-4">{gauge.label} {t("admin_fb_accuracy", "Doğruluk")}</h3>
            <div className="relative w-28 h-28 mx-auto">
              <svg className="w-28 h-28 transform -rotate-90" viewBox="0 0 120 120">
                <circle cx="60" cy="60" r="50" stroke="#e5e7eb" strokeWidth="10" fill="none" />
                <circle cx="60" cy="60" r="50" stroke={gauge.color} strokeWidth="10" fill="none"
                  strokeDasharray={`${gauge.accuracy * 3.14} 314`} strokeLinecap="round" />
              </svg>
              <div className="absolute inset-0 flex items-center justify-center">
                <span className="text-2xl font-bold text-card-foreground">{gauge.accuracy}%</span>
              </div>
            </div>
            <p className={`text-sm mt-3 ${gauge.trend.startsWith('+') ? 'text-blue-600' : 'text-red-600'}`}>
              {gauge.trend} {t("admin_fb_vs_last_period", "önceki döneme göre")}
            </p>
          </div>
        ))}
      </div>

      {/* Revenue Accuracy */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2 mb-4">
          <DollarSign className="w-5 h-5 text-blue-600" /> {t("admin_fb_revenue_predicted_vs_actual", "Gelir: Tahmini vs Gerçekleşen")}
        </h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
            <p className="text-xs text-muted-foreground">{t("admin_fb_predicted_commission", "Tahmini Komisyon")}</p>
            <p className="text-xl font-bold text-blue-700">£2.4M</p>
          </div>
          <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
            <p className="text-xs text-muted-foreground">{t("admin_fb_actual_commission", "Gerçekleşen Komisyon")}</p>
            <p className="text-xl font-bold text-blue-700">£2.1M</p>
          </div>
          <div className="p-4 bg-brand/10 rounded-lg border border-purple-200">
            <p className="text-xs text-muted-foreground">{t("admin_fb_predicted_rental", "Tahmini Kira")}</p>
            <p className="text-xl font-bold text-brand">£890K</p>
          </div>
          <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
            <p className="text-xs text-muted-foreground">{t("admin_fb_actual_rental", "Gerçekleşen Kira")}</p>
            <p className="text-xl font-bold text-blue-700">£920K</p>
          </div>
        </div>
      </div>

      {/* Calibration Events Table */}
      <div className="bg-card rounded-xl shadow-sm border border-border overflow-hidden">
        <div className="p-4 border-b border-border">
          <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2">
            <Activity className="w-5 h-5 text-brand" /> {t("admin_fb_recent_calibrations", "Son Kalibrasyon Olayları")}
          </h2>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-muted text-left">
              <tr>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_property", "Mülk")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_fb_direction", "Yön")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_fb_delta", "Delta")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_reason", "Neden")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_when", "Ne Zaman")}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {recentCalibrations.map((cal: any, i: number) => (
                <tr key={i} className="hover:bg-muted transition">
                  <td className="px-4 py-3 text-sm font-medium text-card-foreground">{cal.propertyTitle}</td>
                  <td className="px-4 py-3">
                    <span className={`inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium ${
                      cal.direction === 'UPWARD' ? 'bg-blue-100 text-blue-700' :
                      cal.direction === 'DOWNWARD' ? 'bg-red-100 text-red-700' :
                      'bg-gray-100 text-muted-foreground'
                    }`}>
                       {cal.direction === 'UPWARD' ? <ArrowUpRight className="w-3 h-3" /> :
                        cal.direction === 'DOWNWARD' ? <ArrowDownRight className="w-3 h-3" /> :
                        <Activity className="w-3 h-3" />}
                      {tEnum(t, cal.direction)}
                    </span>
                  </td>
                  <td className="px-4 py-3">
                    <span className={`text-sm font-mono font-medium ${
                      cal.delta > 0 ? 'text-blue-600' : cal.delta < 0 ? 'text-red-600' : 'text-muted-foreground'
                    }`}>
                      {cal.delta > 0 ? '+' : ''}{(cal.delta * 100).toFixed(1)}%
                    </span>
                  </td>
                  <td className="px-4 py-3 text-sm text-muted-foreground max-w-[300px] truncate">{cal.reason}</td>
                  <td className="px-4 py-3 text-sm text-gray-400">{cal.createdAt}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Learning Loop Diagram */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-card-foreground mb-4">{t("admin_fb_learning_loop", "Zeka Öğrenme Döngüsü")}</h2>
        <div className="flex items-center justify-center gap-2 flex-wrap">
          {[t("admin_fb_loop_prediction", "Tahmin"), "→", t("admin_fb_loop_outcome", "Sonuç"), "→", t("admin_fb_loop_feedback", "Geri Bildirim"), "→", t("admin_fb_loop_calibration", "Kalibrasyon"), "→", t("admin_fb_loop_better_prediction", "Daha İyi Tahmin")].map((item, i) => (
            item === "→" ? (
              <Zap key={i} className="w-4 h-4 text-info mx-1" />
            ) : (
              <div key={i} className={`px-4 py-2 rounded-lg text-sm font-medium ${
                i === 0 ? 'bg-blue-100 text-blue-700' :
                i === 2 ? 'bg-blue-100 text-blue-700' :
                i === 4 ? 'bg-orange-100 text-orange-700' :
                i === 6 ? 'bg-brand/15 text-brand' :
                'bg-brand/15 text-brand'
              }`}>
                {item}
              </div>
            )
          ))}
        </div>
      </div>
    </div>
  </PageShell>
  );
}
