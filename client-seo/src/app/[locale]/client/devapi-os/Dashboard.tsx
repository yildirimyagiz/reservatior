"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { devapiOSApi } from "@/lib/api/devapi-os";
import { 
  Activity,
  Key,
  Clock,
  Zap,
  BarChart3,
  TrendingUp
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { BarChart } from "@/components/charts/BarChart";

export default function DevapiOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["devapi-os-dashboard", orgId],
    queryFn: () => devapiOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: apiUsageTrendsData } = useQuery({
    queryKey: ["devapi-os-api-usage-trends", orgId],
    queryFn: () => devapiOSApi.getApiUsageTrends(orgId),
    enabled: !!orgId,
  });

  const { data: endpointDistributionData } = useQuery({
    queryKey: ["devapi-os-endpoint-distribution", orgId],
    queryFn: () => devapiOSApi.getEndpointDistribution(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

  const formatPercent = (val: number) =>
    `${val.toFixed(1)}%`;

  const formatDecimal = (val: number) =>
    val.toFixed(2);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const stats = dashboardStats || {
    apiCalls: 0,
    activeKeys: 0,
    rateLimit: 0,
    avgLatency: 0,
  };

  const kpis = [
    {
      title: "API Calls",
      value: formatNumber(stats.apiCalls),
      icon: Activity,
      color: "text-brand",
    },
    {
      title: "Active API Keys",
      value: formatNumber(stats.activeKeys),
      icon: Key,
      color: "text-blue-600",
    },
    {
      title: "Rate Limit Usage",
      value: formatPercent(stats.rateLimit),
      icon: Clock,
      color: "text-warning",
    },
    {
      title: "Avg Latency",
      value: `${formatDecimal(stats.avgLatency)}ms`,
      icon: Zap,
      color: "text-brand",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Dev API OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage API access and usage</p>
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
            <h2 className="text-lg font-semibold text-gray-900">API Usage Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={apiUsageTrendsData} 
            dataKey="calls" 
            xAxisKey="month" 
            color="#6366f1"
            height={256}
          />
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Endpoint Distribution</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <BarChart 
            data={endpointDistributionData} 
            dataKey="count" 
            xAxisKey="endpoint" 
            color="#8b5cf6"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
