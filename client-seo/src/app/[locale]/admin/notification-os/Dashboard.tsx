"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { notificationOSApi } from "@/lib/api/notification-os";
import { Bell, Mail, CheckCircle, BarChart3, Activity, AlertTriangle, ArrowUpRight, ArrowDownRight } from "lucide-react";

export default function NotificationOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
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
    { title: "Total Sent", value: formatNumber(stats.sentNotifications), icon: Bell, color: "text-blue-600", trend: "+28.5%", trendUp: true },
    { title: "Delivered", value: formatNumber(stats.deliveredNotifications), icon: CheckCircle, color: "text-green-600", trend: "+25.3%", trendUp: true },
    { title: "Failed", value: formatNumber(stats.failedNotifications), icon: AlertTriangle, color: "text-red-600", trend: "-15.2%", trendUp: false },
    { title: "Open Rate", value: `${stats.openRate.toFixed(1)}%`, icon: Mail, color: "text-purple-600", trend: "+8.7%", trendUp: true },
    { title: "Click Rate", value: `${stats.clickRate.toFixed(1)}%`, icon: Activity, color: "text-orange-600", trend: "+5.4%", trendUp: true },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Notification OS Dashboard</h1><p className="text-gray-600 mt-1">Monitor and manage notifications</p></div>
        <div className="flex gap-3"><button className="px-4 py-2 bg-blue-600 text-white rounded-lg">New Notification</button></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return <div key={i} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
            <div className="flex items-center justify-between">
              <div><p className="text-sm font-medium text-gray-600">{kpi.title}</p><p className="text-2xl font-bold text-gray-900 mt-2">{kpi.value}</p></div>
              <div className={`p-3 bg-gray-50 rounded-lg ${kpi.color}`}><Icon className="w-6 h-6" /></div>
            </div>
          </div>;
        })}
      </div>
    </div>
  );
}
