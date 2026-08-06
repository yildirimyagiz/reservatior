"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { analyticsOSApi } from "@/lib/api/analytics-os";
import { 
  BarChart3, 
  Activity,
  PieChart,
  Clock,
  TrendingUp
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { PieChart as RechartsPieChart } from "@/components/charts/PieChart";

export default function AnalyticsOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["analytics-os-dashboard", orgId],
    queryFn: () => analyticsOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: dataTrendsData } = useQuery({
    queryKey: ["analytics-os-data-trends", orgId],
    queryFn: () => analyticsOSApi.getDataTrends(orgId),
    enabled: !!orgId,
  });

  const { data: reportDistributionData } = useQuery({
    queryKey: ["analytics-os-report-distribution", orgId],
    queryFn: () => analyticsOSApi.getReportDistribution(orgId),
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
    totalReports: 0,
    dataPoints: 0,
    activeDashboards: 0,
    refreshRate: 0,
  };

  const kpis = [
    {
      title: "Total Reports",
      value: formatNumber(stats.totalReports),
      icon: BarChart3,
      color: "text-brand",
    },
    {
      title: "Data Points",
      value: formatNumber(stats.dataPoints),
      icon: Activity,
      color: "text-brand",
    },
    {
      title: "Active Dashboards",
      value: formatNumber(stats.activeDashboards),
      icon: PieChart,
      color: "text-blue-600",
    },
    {
      title: "Refresh Rate",
      value: `${formatDecimal(stats.refreshRate)}s`,
      icon: Clock,
      color: "text-warning",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Analytics OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor analytics and reporting</p>
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
            <h2 className="text-lg font-semibold text-gray-900">Data Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={dataTrendsData} 
            dataKey="datapoints" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Report Distribution</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <RechartsPieChart 
            data={reportDistributionData} 
            dataKey="value" 
            nameKey="name"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
