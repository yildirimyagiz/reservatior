"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { identityOSApi } from "@/lib/api/identity-os";
import { 
  Users, 
  Building2, 
  Shield, 
  Key, 
  Activity, 
  AlertTriangle,
  BarChart3,
  CheckCircle,
  TrendingUp,
  ArrowUpRight,
  ArrowDownRight
} from "lucide-react";

export default function IdentityOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["identity-os-dashboard", orgId],
    queryFn: () => identityOSApi.getDashboardStats(orgId),
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
    totalUsers: 0,
    activeUsers: 0,
    totalOrganizations: 0,
    activeSessions: 0,
    failedLogins: 0,
    mfaAdoptionRate: 0,
    complianceScore: 0,
    securityIncidents: 0,
  };

  const kpis = [
    {
      title: "Total Users",
      value: formatNumber(stats.totalUsers),
      icon: Users,
      color: "text-blue-600",
      trend: "+15.2% vs last month",
      trendUp: true,
    },
    {
      title: "Active Users",
      value: formatNumber(stats.activeUsers),
      icon: Activity,
      color: "text-green-600",
      trend: "+12.8% vs last month",
      trendUp: true,
    },
    {
      title: "Organizations",
      value: formatNumber(stats.totalOrganizations),
      icon: Building2,
      color: "text-purple-600",
      trend: "+8.5% vs last month",
      trendUp: true,
    },
    {
      title: "Active Sessions",
      value: formatNumber(stats.activeSessions),
      icon: Shield,
      color: "text-orange-600",
      trend: "+18.3% vs last month",
      trendUp: true,
    },
    {
      title: "Failed Logins",
      value: formatNumber(stats.failedLogins),
      icon: AlertTriangle,
      color: "text-red-600",
      trend: "-12.4% vs last month",
      trendUp: false,
    },
    {
      title: "MFA Adoption",
      value: `${stats.mfaAdoptionRate.toFixed(1)}%`,
      icon: Key,
      color: "text-indigo-600",
      trend: "+5.7% vs last month",
      trendUp: true,
    },
    {
      title: "Compliance Score",
      value: `${stats.complianceScore.toFixed(1)}/100`,
      icon: CheckCircle,
      color: "text-emerald-600",
      trend: "+2.3% vs last month",
      trendUp: true,
    },
    {
      title: "Security Incidents",
      value: formatNumber(stats.securityIncidents),
      icon: Shield,
      color: "text-pink-600",
      trend: "-8.1% vs last month",
      trendUp: false,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Identity OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor and manage identity and access</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
            New User
          </button>
          <button className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition">
            Audit Report
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
        {/* User Activity Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">User Activity</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">User activity chart will be rendered here</p>
          </div>
        </div>

        {/* Security Trends Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Security Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Security trends chart will be rendered here</p>
          </div>
        </div>
      </div>

      {/* Recent Organizations */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Recent Organizations</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Building2 className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-gray-900">Organization #{1000 + item}</p>
                  <p className="text-sm text-gray-600">Agency • {item * 15} users</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-gray-900">Active</p>
                <p className="text-sm text-gray-600">{item} day(s) ago</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Security Overview */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Security Overview</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-green-50 border border-green-200 rounded-lg">
            <h3 className="font-semibold text-green-900">Excellent</h3>
            <p className="text-sm text-green-700 mt-1">High MFA adoption</p>
            <p className="text-2xl font-bold text-green-900 mt-2">85%</p>
            <p className="text-xs text-green-600">MFA enabled</p>
          </div>
          <div className="p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <h3 className="font-semibold text-yellow-900">Good</h3>
            <p className="text-sm text-yellow-700 mt-1">Compliance score</p>
            <p className="text-2xl font-bold text-yellow-900 mt-2">92%</p>
            <p className="text-xs text-yellow-600">compliance rate</p>
          </div>
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">Low Risk</h3>
            <p className="text-sm text-blue-700 mt-1">Security incidents</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">3</p>
            <p className="text-xs text-blue-600">incidents this month</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900">Security Alerts</h2>
          <AlertTriangle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertTriangle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">Unusual login activity detected</p>
              <p className="text-sm text-yellow-700">Multiple failed login attempts from new location</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-green-50 border border-green-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-green-600 mt-0.5" />
            <div>
              <p className="font-medium text-green-900">MFA adoption target achieved</p>
              <p className="text-sm text-green-700">MFA enabled for 85% of users</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
