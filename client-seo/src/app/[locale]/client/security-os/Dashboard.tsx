"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { securityOSApi } from "@/lib/api/security-os";
import { 
  Shield,
  AlertCircle,
  CheckCircle,
  CheckSquare,
  BarChart3,
  TrendingUp
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { BarChart } from "@/components/charts/BarChart";

export default function SecurityOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["security-os-dashboard", orgId],
    queryFn: () => securityOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: threatTrendsData } = useQuery({
    queryKey: ["security-os-threat-trends", orgId],
    queryFn: () => securityOSApi.getThreatTrends(orgId),
    enabled: !!orgId,
  });

  const { data: securityEventsData } = useQuery({
    queryKey: ["security-os-security-events", orgId],
    queryFn: () => securityOSApi.getSecurityEvents(orgId),
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
    securityScore: 0,
    activeThreats: 0,
    resolvedIncidents: 0,
    compliance: 0,
  };

  const kpis = [
    {
      title: "Security Score",
      value: formatDecimal(stats.securityScore),
      icon: Shield,
      color: "text-blue-600",
    },
    {
      title: "Active Threats",
      value: formatNumber(stats.activeThreats),
      icon: AlertCircle,
      color: "text-red-600",
    },
    {
      title: "Resolved",
      value: formatNumber(stats.resolvedIncidents),
      icon: CheckCircle,
      color: "text-green-600",
    },
    {
      title: "Compliance",
      value: formatPercent(stats.compliance),
      icon: CheckSquare,
      color: "text-purple-600",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Security OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor security and threats</p>
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
            <h2 className="text-lg font-semibold text-gray-900">Threat Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={threatTrendsData} 
            dataKey="threats" 
            xAxisKey="month" 
            color="#ef4444"
            height={256}
          />
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Security Events</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <BarChart 
            data={securityEventsData} 
            dataKey="count" 
            xAxisKey="type" 
            color="#f59e0b"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
