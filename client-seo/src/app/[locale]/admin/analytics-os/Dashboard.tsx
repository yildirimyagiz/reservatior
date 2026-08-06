"use client";


import { useLocalization } from "@/contexts/LocalizationContext";
import { useTranslation } from "react-i18next";
import { tEnum } from "@/lib/admin-enums";
import { useQuery } from "@tanstack/react-query";
import { analyticsOSApi } from "@/lib/api/analytics-os";
import { 
  BarChart3, 
  TrendingUp, 
  Database, 
  Clock, 
  Zap,
  FileText,
  Activity,
  CheckCircle,
  AlertTriangle,
  ArrowUpRight,
  ArrowDownRight
} from "lucide-react";
import { useAuth } from "@/lib/auth";

export default function AnalyticsOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const { t } = useTranslation();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["analytics-os-dashboard", orgId],
    queryFn: () => analyticsOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const stats = dashboardStats || {
    totalQueries: 0,
    successfulQueries: 0,
    totalDashboards: 0,
    dashboardViews: 0,
    totalReports: 0,
    insightsGenerated: 0,
    dataPointsProcessed: 0,
    cacheHitRate: 0,
  };

  const kpis = [
    {
      title: t("admin_analytics_os_total_queries", "Toplam Sorgu"),
      value: formatNumber(stats.totalQueries),
      icon: Database,
      color: "text-blue-600",
      trend: `+32.5% ${t("admin_analytics_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_analytics_os_successful_queries", "Başarılı Sorgular"),
      value: formatNumber(stats.successfulQueries),
      icon: CheckCircle,
      color: "text-blue-600",
      trend: `+28.7% ${t("admin_analytics_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_analytics_os_dashboards", "Panolar"),
      value: formatNumber(stats.totalDashboards),
      icon: BarChart3,
      color: "text-brand",
      trend: `+15.3% ${t("admin_analytics_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_analytics_os_dashboard_views", "Pano Görüntülemeleri"),
      value: formatNumber(stats.dashboardViews),
      icon: Activity,
      color: "text-orange-600",
      trend: `+42.1% ${t("admin_analytics_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_analytics_os_reports_generated", "Oluşturulan Raporlar"),
      value: formatNumber(stats.totalReports),
      icon: FileText,
      color: "text-blue-600",
      trend: `+22.8% ${t("admin_analytics_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_analytics_os_insights_generated", "Oluşturulan İçgörüler"),
      value: formatNumber(stats.insightsGenerated),
      icon: TrendingUp,
      color: "text-brand",
      trend: `+35.4% ${t("admin_analytics_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_analytics_os_data_points", "Veri Noktaları"),
      value: formatNumber(stats.dataPointsProcessed),
      icon: Database,
      color: "text-pink-600",
      trend: `+55.2% ${t("admin_analytics_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_analytics_os_cache_hit_rate", "Önbellek İsabet Oranı"),
      value: `${stats.cacheHitRate.toFixed(1)}%`,
      icon: Zap,
      color: "text-cyan-600",
      trend: `+8.6% ${t("admin_analytics_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_analytics_os_dashboard_title", "Analytics OS Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_analytics_os_dashboard_desc", "Analitik işlemlerini izleyin ve yönetin")}</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition">
            {t("admin_analytics_os_new_query", "Yeni Sorgu")}
          </button>
          <button className="px-4 py-2 border border-border rounded-lg hover:bg-muted transition">
            {t("admin_analytics_os_create_dashboard", "Pano Oluştur")}
          </button>
        </div>
      </div>

      {/* KPI Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-muted-foreground">{kpi.title}</p>
                  <p className="text-2xl font-bold text-foreground mt-2">{kpi.value}</p>
                  <div className="flex items-center gap-1 mt-1">
                    {kpi.trendUp ? (
                      <ArrowUpRight className="w-4 h-4 text-blue-600" />
                    ) : (
                      <ArrowDownRight className="w-4 h-4 text-red-600" />
                    )}
                    <p className={`text-sm ${kpi.trendUp ? 'text-blue-600' : 'text-red-600'}`}>
                      {kpi.trend}
                    </p>
                  </div>
                </div>
                <div className={`p-3 bg-muted rounded-lg ${kpi.color}`}>
                  <Icon className="w-6 h-6" />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Charts Section */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Query Performance Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_analytics_os_query_performance", "Sorgu Performansı")}</h2>
            <Clock className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_analytics_os_query_performance_placeholder", "Sorgu performansı grafiği burada gösterilecek")}</p>
          </div>
        </div>

        {/* Data Processing Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_analytics_os_data_processing", "Veri İşleme")}</h2>
            <Database className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_analytics_os_data_processing_placeholder", "Veri işleme grafiği burada gösterilecek")}</p>
          </div>
        </div>
      </div>

      {/* Recent Queries */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_analytics_os_recent_queries", "Son Sorgular")}</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-muted rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Database className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-foreground">{t("admin_analytics_os_query_number", "Sorgu #")}{1000 + item}</p>
                  <p className="text-sm text-muted-foreground">{t("admin_analytics_os_revenue_analysis", "Gelir Analizi")} • {item * 150}ms</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-foreground">{tEnum(t, "Completed")}</p>
                <p className="text-sm text-muted-foreground">{item} {t("admin_common_minutes_ago", "dakika önce")}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* System Performance */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_analytics_os_system_performance", "Sistem Performansı")}</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">{t("admin_common_excellent", "Mükemmel")}</h3>
            <p className="text-sm text-blue-700 mt-1">{t("admin_analytics_os_cache_performance", "Önbellek performansı")}</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">92%</p>
            <p className="text-xs text-blue-600">{t("admin_analytics_os_cache_hit_rate_sub", "önbellek isabet oranı")}</p>
          </div>
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">{t("admin_common_good", "İyi")}</h3>
            <p className="text-sm text-blue-700 mt-1">{t("admin_analytics_os_query_latency", "Sorgu gecikmesi")}</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">45ms</p>
            <p className="text-xs text-blue-600">{t("admin_analytics_os_average_response", "ortalama yanıt")}</p>
          </div>
          <div className="p-4 bg-brand/10 border border-purple-200 rounded-lg">
            <h3 className="font-semibold text-brand">{t("admin_common_optimal", "Optimal")}</h3>
            <p className="text-sm text-brand mt-1">{t("admin_analytics_os_data_freshness", "Veri tazeliği")}</p>
            <p className="text-2xl font-bold text-brand mt-2">5min</p>
            <p className="text-xs text-brand">{t("admin_analytics_os_average_data_age", "ortalama veri yaşı")}</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground">{t("admin_analytics_os_system_alerts", "Sistem Uyarıları")}</h2>
          <AlertTriangle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertTriangle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">{t("admin_analytics_os_high_query_latency_detected", "Yüksek sorgu gecikmesi tespit edildi")}</p>
              <p className="text-sm text-yellow-700">{t("admin_analytics_os_query_latency_increased", "Sorgu gecikmesi son bir saatte %15 arttı")}</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-blue-600 mt-0.5" />
            <div>
              <p className="font-medium text-blue-900">{t("admin_analytics_os_insight_milestone_achieved", "İçgörü üretim hedefine ulaşıldı")}</p>
              <p className="text-sm text-blue-700">{t("admin_analytics_os_generated_insights", "Bu hafta 1.000+ içgörü üretildi")}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
