"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { userOSApi } from "@/lib/api/user-os";
import { 
  Users,
  CheckCircle,
  TrendingUp,
  Activity,
  BarChart3,
  PieChart
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { PieChart as RechartsPieChart } from "@/components/charts/PieChart";

export default function UserOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["user-os-dashboard", orgId],
    queryFn: () => userOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: userTrendsData } = useQuery({
    queryKey: ["user-os-user-trends", orgId],
    queryFn: () => userOSApi.getUserTrends(orgId),
    enabled: !!orgId,
  });

  const { data: userActivityData } = useQuery({
    queryKey: ["user-os-user-activity", orgId],
    queryFn: () => userOSApi.getUserActivity(orgId),
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
    totalUsers: 0,
    activeUsers: 0,
    newUsers: 0,
    engagement: 0,
  };

  const kpis = [
    {
      title: "Total Users",
      value: formatNumber(stats.totalUsers),
      icon: Users,
      color: "text-brand",
    },
    {
      title: "Active",
      value: formatNumber(stats.activeUsers),
      icon: CheckCircle,
      color: "text-blue-600",
    },
    {
      title: "New This Month",
      value: formatNumber(stats.newUsers),
      icon: TrendingUp,
      color: "text-brand",
    },
    {
      title: "Engagement Rate",
      value: formatPercent(stats.engagement),
      icon: Activity,
      color: "text-warning",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">User OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage users and accounts</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
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
        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">User Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={userTrendsData} 
            dataKey="users" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">User Activity</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <RechartsPieChart 
            data={userActivityData} 
            dataKey="value" 
            nameKey="name"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
