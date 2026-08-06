"use client";


import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { listingOSApi } from "@/lib/api/listing-os";
import { 
  Home, 
  Eye, 
  MessageSquare, 
  TrendingUp, 
  DollarSign, 
  Star,
  BarChart3,
  Calendar,
  CheckCircle,
  AlertCircle,
  ArrowUpRight,
  ArrowDownRight
} from "lucide-react";
import { useAuth } from "@/lib/auth";

export default function ListingOSDashboard() {
  const { user } = useAuth();
  const { currency, language } = useLocalization();
  const { t } = useTranslation();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["listing-os-dashboard", orgId],
    queryFn: () => listingOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

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
    totalListings: 0,
    activeListings: 0,
    totalViews: 0,
    totalInquiries: 0,
    averagePrice: 0,
    averageTimeToLease: 0,
    publishedListings: 0,
    pendingListings: 0,
  };

  const kpis = [
    {
      title: t("admin_listing_os_total_listings", "Toplam İlan"),
      value: formatNumber(stats.totalListings),
      icon: Home,
      color: "text-blue-600",
      trend: "+12.5% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_listing_os_active_listings", "Aktif İlanlar"),
      value: formatNumber(stats.activeListings),
      icon: CheckCircle,
      color: "text-blue-600",
      trend: "+8.3% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_listing_os_total_views", "Toplam Görüntülenme"),
      value: formatNumber(stats.totalViews),
      icon: Eye,
      color: "text-brand",
      trend: "+22.1% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_listing_os_total_inquiries", "Toplam Talep"),
      value: formatNumber(stats.totalInquiries),
      icon: MessageSquare,
      color: "text-orange-600",
      trend: "+15.7% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_listing_os_average_price", "Ortalama Fiyat"),
      value: formatCurrency(stats.averagePrice),
      icon: DollarSign,
      color: "text-blue-600",
      trend: "+5.4% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_listing_os_avg_time_to_lease", "Ort. Kiralama Süresi"),
      value: `${stats.averageTimeToLease} ${t("admin_listing_os_days", "gün")}`,
      icon: Calendar,
      color: "text-brand",
      trend: "-3.2% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: false,
    },
    {
      title: t("admin_listing_os_published_listings", "Yayınlanan İlanlar"),
      value: formatNumber(stats.publishedListings),
      icon: Star,
      color: "text-yellow-600",
      trend: "+10.8% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_listing_os_pending_listings", "Bekleyen İlanlar"),
      value: formatNumber(stats.pendingListings),
      icon: AlertCircle,
      color: "text-red-600",
      trend: "-7.5% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: false,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_listing_os_title", "İlan OS Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_listing_os_desc", "İlan operasyonlarını izleyin ve yönetin")}</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition">
            {t("admin_listing_os_new_listing", "Yeni İlan")}
          </button>
          <button className="px-4 py-2 border border-border rounded-lg hover:bg-muted transition">
            {t("admin_listing_os_import_from_mls", "MLS'den İçe Aktar")}
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
        {/* Listing Views Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_listing_os_listing_views", "İlan Görüntülenmeleri")}</h2>
            <BarChart3 className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_listing_os_listing_views_placeholder", "İlan görüntülenme grafiği burada gösterilecek")}</p>
          </div>
        </div>

        {/* Inquiry Trends Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_listing_os_inquiry_trends", "Talep Trendleri")}</h2>
            <TrendingUp className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_listing_os_inquiry_trends_placeholder", "Talep trendleri grafiği burada gösterilecek")}</p>
          </div>
        </div>
      </div>

      {/* Recent Listings */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_listing_os_recent_listings", "Son İlanlar")}</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-muted rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Home className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-foreground">{t("admin_listing_os_property_label", "Mülk #")}{1000 + item}</p>
                  <p className="text-sm text-muted-foreground">{t("admin_listing_os_property_spec", "3BR • 2BA • 1,500 sqft")}</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-foreground">{formatCurrency(2500000 + item * 100000)}</p>
                <p className="text-sm text-muted-foreground">{item} {t("admin_common_days_ago", "gün önce")}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Listing Performance */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_listing_os_listing_performance", "İlan Performansı")}</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">{t("admin_listing_os_high_performance", "Yüksek Performans")}</h3>
            <p className="text-sm text-blue-700 mt-1">{t("admin_listing_os_high_performance_desc", "Ortalamanın üzerinde görüntülenme ve talep")}</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">35%</p>
            <p className="text-xs text-blue-600">{t("admin_listing_os_of_listings", "ilanın")}</p>
          </div>
          <div className="p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <h3 className="font-semibold text-yellow-900">{t("admin_listing_os_average_performance", "Ortalama Performans")}</h3>
            <p className="text-sm text-yellow-700 mt-1">{t("admin_listing_os_average_performance_desc", "Beklenen metrikleri karşılıyor")}</p>
            <p className="text-2xl font-bold text-yellow-900 mt-2">50%</p>
            <p className="text-xs text-yellow-600">{t("admin_listing_os_of_listings", "ilanın")}</p>
          </div>
          <div className="p-4 bg-red-50 border border-red-200 rounded-lg">
            <h3 className="font-semibold text-red-900">{t("admin_listing_os_low_performance", "Düşük Performans")}</h3>
            <p className="text-sm text-red-700 mt-1">{t("admin_listing_os_low_performance_desc", "Ortalamanın altında görüntülenme ve talep")}</p>
            <p className="text-2xl font-bold text-red-900 mt-2">15%</p>
            <p className="text-xs text-red-600">{t("admin_listing_os_of_listings", "ilanın")}</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground">{t("admin_listing_os_alerts", "Uyarılar ve Bildirimler")}</h2>
          <AlertCircle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertCircle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">{t("admin_listing_os_alert_low_inquiry", "Düşük talep oranı tespit edildi")}</p>
              <p className="text-sm text-yellow-700">{t("admin_listing_os_alert_low_inquiry_detail", "Talep oranı bu hafta %8 azaldı")}</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-blue-600 mt-0.5" />
            <div>
              <p className="font-medium text-blue-900">{t("admin_listing_os_alert_views_target", "Görüntülenme hedefine ulaşıldı")}</p>
              <p className="text-sm text-blue-700">{t("admin_listing_os_alert_views_target_detail", "Aylık görüntülenme hedefi %22 aşıldı")}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
