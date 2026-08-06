"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { notificationOSApi } from "@/lib/api/notification-os";
import { Bell, Mail, CheckCircle, BarChart3, Activity, AlertTriangle, ArrowUpRight, ArrowDownRight } from "lucide-react";
import { useTranslation } from "react-i18next";

export default function NotificationOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const { t } = useTranslation();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["notification-os-dashboard", orgId],
    queryFn: () => notificationOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = dashboardStats || { totalNotifications: 0, sentNotifications: 0, deliveredNotifications: 0, failedNotifications: 0, openRate: 0, clickRate: 0 };

  const kpis = [
    { title: t("admin_notification_os_kpi_sent", "Toplam Gönderilen"), value: formatNumber(stats.sentNotifications), icon: Bell, color: "text-blue-600", trend: "+28.5%", trendUp: true },
    { title: t("admin_notification_os_kpi_delivered", "Teslim Edilen"), value: formatNumber(stats.deliveredNotifications), icon: CheckCircle, color: "text-blue-600", trend: "+25.3%", trendUp: true },
    { title: t("admin_notification_os_kpi_failed", "Başarısız"), value: formatNumber(stats.failedNotifications), icon: AlertTriangle, color: "text-red-600", trend: "-15.2%", trendUp: false },
    { title: t("admin_notification_os_kpi_open_rate", "Açılma Oranı"), value: `${stats.openRate.toFixed(1)}%`, icon: Mail, color: "text-brand", trend: "+8.7%", trendUp: true },
    { title: t("admin_notification_os_kpi_click_rate", "Tıklanma Oranı"), value: `${stats.clickRate.toFixed(1)}%`, icon: Activity, color: "text-orange-600", trend: "+5.4%", trendUp: true },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-foreground">{t("admin_notification_os_dashboard_title", "Notification OS Panosu")}</h1><p className="text-muted-foreground mt-1">{t("admin_notification_os_dashboard_desc", "Bildirimleri izle ve yönet")}</p></div>
        <div className="flex gap-3"><button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg">{t("admin_notification_os_new", "Yeni Bildirim")}</button></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return <div key={i} className="bg-card rounded-xl shadow-sm p-6 border border-border">
            <div className="flex items-center justify-between">
              <div><p className="text-sm font-medium text-muted-foreground">{kpi.title}</p><p className="text-2xl font-bold text-foreground mt-2">{kpi.value}</p></div>
              <div className={`p-3 bg-muted rounded-lg ${kpi.color}`}><Icon className="w-6 h-6" /></div>
            </div>
          </div>;
        })}
      </div>
    </div>
  );
}
