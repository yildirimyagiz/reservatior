"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { notificationOSApi } from "@/lib/api/notification-os";
import { 
  Activity,
  CheckCircle,
  Clock,
  TrendingUp,
  BarChart3,
  PieChart
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { PieChart as RechartsPieChart } from "@/components/charts/PieChart";

export default function NotificationOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["notification-os-dashboard", orgId],
    queryFn: () => notificationOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: notificationTrendsData } = useQuery({
    queryKey: ["notification-os-notification-trends", orgId],
    queryFn: () => notificationOSApi.getNotificationTrends(orgId),
    enabled: !!orgId,
  });

  const { data: channelDistributionData } = useQuery({
    queryKey: ["notification-os-channel-distribution", orgId],
    queryFn: () => notificationOSApi.getChannelDistribution(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

  const formatPercent = (val: number) =>
    `${val.toFixed(1)}%`;

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const stats = dashboardStats || {
    totalNotifications: 0,
    sentNotifications: 0,
    pendingNotifications: 0,
    deliveryRate: 0,
  };

  const kpis = [
    {
      title: "Total Notifications",
      value: formatNumber(stats.totalNotifications),
      icon: Activity,
      color: "text-blue-600",
    },
    {
      title: "Sent",
      value: formatNumber(stats.sentNotifications),
      icon: CheckCircle,
      color: "text-green-600",
    },
    {
      title: "Pending",
      value: formatNumber(stats.pendingNotifications),
      icon: Clock,
      color: "text-yellow-600",
    },
    {
      title: "Delivery Rate",
      value: formatPercent(stats.deliveryRate),
      icon: TrendingUp,
      color: "text-purple-600",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Notification OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage notifications and alerts</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{kpi.title}</p>
                  <p className="text-2xl font-bold text-gray-900 mt-2">{kpi.value}</p>
                </div>
                <div className={`p-3 bg-gray-50 rounded-lg ${kpi.color}`}>
                  <Icon className="w-6 h-6" />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Notification Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={notificationTrendsData} 
            dataKey="notifications" 
            xAxisKey="month" 
            color="#06b6d4"
            height={256}
          />
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Channel Distribution</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <RechartsPieChart 
            data={channelDistributionData} 
            dataKey="value" 
            nameKey="name"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
