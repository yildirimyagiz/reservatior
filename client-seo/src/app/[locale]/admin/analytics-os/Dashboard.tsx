"use client";


import { useLocalization } from "@/contexts/LocalizationContext";
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
      title: "Total Queries",
      value: formatNumber(stats.totalQueries),
      icon: Database,
      color: "text-blue-600",
      trend: "+32.5% vs last month",
      trendUp: true,
    },
    {
      title: "Successful Queries",
      value: formatNumber(stats.successfulQueries),
      icon: CheckCircle,
      color: "text-green-600",
      trend: "+28.7% vs last month",
      trendUp: true,
    },
    {
      title: "Dashboards",
      value: formatNumber(stats.totalDashboards),
      icon: BarChart3,
      color: "text-purple-600",
      trend: "+15.3% vs last month",
      trendUp: true,
    },
    {
      title: "Dashboard Views",
      value: formatNumber(stats.dashboardViews),
      icon: Activity,
      color: "text-orange-600",
      trend: "+42.1% vs last month",
      trendUp: true,
    },
    {
      title: "Reports Generated",
      value: formatNumber(stats.totalReports),
      icon: FileText,
      color: "text-emerald-600",
      trend: "+22.8% vs last month",
      trendUp: true,
    },
    {
      title: "Insights Generated",
      value: formatNumber(stats.insightsGenerated),
      icon: TrendingUp,
      color: "text-indigo-600",
      trend: "+35.4% vs last month",
      trendUp: true,
    },
    {
      title: "Data Points",
      value: formatNumber(stats.dataPointsProcessed),
      icon: Database,
      color: "text-pink-600",
      trend: "+55.2% vs last month",
      trendUp: true,
    },
    {
      title: "Cache Hit Rate",
      value: `${stats.cacheHitRate.toFixed(1)}%`,
      icon: Zap,
      color: "text-cyan-600",
      trend: "+8.6% vs last month",
      trendUp: true,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Analytics OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor and manage analytics operations</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
            New Query
          </button>
          <button className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition">
            Create Dashboard
          </button>
        </div>
      </div>

      {/* KPI Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{kpi.title}</p>
                  <p className="text-2xl font-bold text-gray-900 mt-2">{kpi.value}</p>
                  <div className="flex items-center gap-1 mt-1">
                    {kpi.trendUp ? (
                      <ArrowUpRight className="w-4 h-4 text-green-600" />
                    ) : (
                      <ArrowDownRight className="w-4 h-4 text-red-600" />
                    )}
                    <p className={`text-sm ${kpi.trendUp ? 'text-green-600' : 'text-red-600'}`}>
                      {kpi.trend}
                    </p>
                  </div>
                </div>
                <div className={`p-3 bg-gray-50 rounded-lg ${kpi.color}`}>
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
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Query Performance</h2>
            <Clock className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Query performance chart will be rendered here</p>
          </div>
        </div>

        {/* Data Processing Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Data Processing</h2>
            <Database className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Data processing chart will be rendered here</p>
          </div>
        </div>
      </div>

      {/* Recent Queries */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Recent Queries</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Database className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-gray-900">Query #{1000 + item}</p>
                  <p className="text-sm text-gray-600">Revenue Analysis • {item * 150}ms</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-gray-900">Completed</p>
                <p className="text-sm text-gray-600">{item} minute(s) ago</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* System Performance */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">System Performance</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-green-50 border border-green-200 rounded-lg">
            <h3 className="font-semibold text-green-900">Excellent</h3>
            <p className="text-sm text-green-700 mt-1">Cache performance</p>
            <p className="text-2xl font-bold text-green-900 mt-2">92%</p>
            <p className="text-xs text-green-600">cache hit rate</p>
          </div>
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">Good</h3>
            <p className="text-sm text-blue-700 mt-1">Query latency</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">45ms</p>
            <p className="text-xs text-blue-600">average response</p>
          </div>
          <div className="p-4 bg-purple-50 border border-purple-200 rounded-lg">
            <h3 className="font-semibold text-purple-900">Optimal</h3>
            <p className="text-sm text-purple-700 mt-1">Data freshness</p>
            <p className="text-2xl font-bold text-purple-900 mt-2">5min</p>
            <p className="text-xs text-purple-600">average data age</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900">System Alerts</h2>
          <AlertTriangle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertTriangle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">High query latency detected</p>
              <p className="text-sm text-yellow-700">Query latency increased by 15% in the last hour</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-green-50 border border-green-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-green-600 mt-0.5" />
            <div>
              <p className="font-medium text-green-900">Insight generation milestone achieved</p>
              <p className="text-sm text-green-700">Generated 1,000+ insights this week</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
