"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { bookingOSApi } from "@/lib/api/booking-os";
import { 
  Calendar, 
  Users, 
  DollarSign, 
  TrendingUp, 
  Clock, 
  CheckCircle, 
  XCircle,
  AlertCircle,
  BarChart3,
  CreditCard
} from "lucide-react";

export default function BookingOSDashboard() {
  const { user } = useAuth();
  const { currency, language } = useLocalization();
  const { t } = useTranslation();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["booking-os-dashboard", orgId],
    queryFn: () => bookingOSApi.getDashboardStats(orgId),
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
    totalBookings: 0,
    activeBookings: 0,
    pendingBookings: 0,
    completedBookings: 0,
    cancelledBookings: 0,
    totalRevenue: 0,
    averageBookingValue: 0,
    occupancyRate: 0,
    averageStayDuration: 0,
  };

  const kpis = [
    {
      title: t("admin_booking_os_total_bookings", "Toplam Rezervasyon"),
      value: formatNumber(stats.totalBookings),
      icon: Calendar,
      color: "text-blue-600",
      trend: "+12.5% " + t("admin_common_vs_last_month", "geçen aya göre"),
    },
    {
      title: t("admin_booking_os_active_bookings", "Aktif Rezervasyonlar"),
      value: formatNumber(stats.activeBookings),
      icon: Users,
      color: "text-blue-600",
      trend: "+8.3% " + t("admin_common_vs_last_month", "geçen aya göre"),
    },
    {
      title: t("admin_booking_os_total_revenue", "Toplam Gelir"),
      value: formatCurrency(stats.totalRevenue),
      icon: DollarSign,
      color: "text-brand",
      trend: "+15.2% " + t("admin_common_vs_last_month", "geçen aya göre"),
    },
    {
      title: t("admin_booking_os_occupancy_rate", "Doluluk Oranı"),
      value: `${stats.occupancyRate.toFixed(1)}%`,
      icon: TrendingUp,
      color: "text-orange-600",
      trend: "+2.1% " + t("admin_common_vs_last_month", "geçen aya göre"),
    },
    {
      title: t("admin_booking_os_pending_bookings", "Bekleyen Rezervasyonlar"),
      value: formatNumber(stats.pendingBookings),
      icon: Clock,
      color: "text-yellow-600",
      trend: "-3.2% " + t("admin_common_vs_last_month", "geçen aya göre"),
    },
    {
      title: t("admin_booking_os_completed_bookings", "Tamamlanan Rezervasyonlar"),
      value: formatNumber(stats.completedBookings),
      icon: CheckCircle,
      color: "text-blue-600",
      trend: "+10.8% " + t("admin_common_vs_last_month", "geçen aya göre"),
    },
    {
      title: t("admin_booking_os_cancelled_bookings", "İptal Edilen Rezervasyonlar"),
      value: formatNumber(stats.cancelledBookings),
      icon: XCircle,
      color: "text-red-600",
      trend: "-5.4% " + t("admin_common_vs_last_month", "geçen aya göre"),
    },
    {
      title: t("admin_booking_os_average_booking_value", "Ortalama Rezervasyon Değeri"),
      value: formatCurrency(stats.averageBookingValue),
      icon: CreditCard,
      color: "text-brand",
      trend: "+7.6% " + t("admin_common_vs_last_month", "geçen aya göre"),
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_booking_os_title", "Rezervasyon OS Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_booking_os_desc", "Rezervasyon operasyonlarını izleyin ve yönetin")}</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition">
            {t("admin_booking_os_new_booking", "Yeni Rezervasyon")}
          </button>
          <button className="px-4 py-2 border border-border rounded-lg hover:bg-muted transition">
            {t("admin_booking_os_export_report", "Rapor Dışa Aktar")}
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

      {/* Charts Section */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Booking Trends Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_booking_os_booking_trends", "Rezervasyon Trendleri")}</h2>
            <BarChart3 className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_booking_os_booking_trends_placeholder", "Rezervasyon trendleri grafiği burada gösterilecek")}</p>
          </div>
        </div>

        {/* Revenue Distribution Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_booking_os_revenue_distribution", "Gelir Dağılımı")}</h2>
            <DollarSign className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_booking_os_revenue_distribution_placeholder", "Gelir dağılımı grafiği burada gösterilecek")}</p>
          </div>
        </div>
      </div>

      {/* Recent Activity */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_booking_os_recent_activity", "Son Etkinlik")}</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-muted rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Calendar className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-foreground">{t("admin_booking_os_new_booking_created", "Yeni rezervasyon oluşturuldu")}</p>
                  <p className="text-sm text-muted-foreground">{t("admin_booking_os_booking_label", "Rezervasyon #")}{1000 + item}</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-foreground">{formatCurrency(500 + item * 100)}</p>
                <p className="text-sm text-muted-foreground">{item} {t("admin_common_hours_ago", "saat önce")}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground">{t("admin_booking_os_alerts", "Uyarılar ve Bildirimler")}</h2>
          <AlertCircle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertCircle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">{t("admin_booking_os_alert_cancellation", "Yüksek iptal oranı tespit edildi")}</p>
              <p className="text-sm text-yellow-700">{t("admin_booking_os_alert_cancellation_detail", "İptal oranı bu hafta %5 arttı")}</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-blue-600 mt-0.5" />
            <div>
              <p className="font-medium text-blue-900">{t("admin_booking_os_alert_revenue_target", "Gelir hedefine ulaşıldı")}</p>
              <p className="text-sm text-blue-700">{t("admin_booking_os_alert_revenue_target_detail", "Aylık gelir hedefi %12 aşıldı")}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
