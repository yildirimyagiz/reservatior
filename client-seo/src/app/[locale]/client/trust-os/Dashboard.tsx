"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { trustOSApi } from "@/lib/api/trust-os";
import { 
  Shield,
  CheckCircle,
  Clock,
  Star,
  BarChart3,
  TrendingUp
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { BarChart } from "@/components/charts/BarChart";

export default function TrustOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["trust-os-dashboard", orgId],
    queryFn: () => trustOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: verificationTrendsData } = useQuery({
    queryKey: ["trust-os-verification-trends", orgId],
    queryFn: () => trustOSApi.getVerificationTrends(orgId),
    enabled: !!orgId,
  });

  const { data: trustScoreDistributionData } = useQuery({
    queryKey: ["trust-os-trust-score-distribution", orgId],
    queryFn: () => trustOSApi.getTrustScoreDistribution(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

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
    totalVerifications: 0,
    completedVerifications: 0,
    pendingVerifications: 0,
    averageTrustScore: 0,
  };

  const kpis = [
    {
      title: "Total Verifications",
      value: formatNumber(stats.totalVerifications),
      icon: Shield,
      color: "text-blue-600",
    },
    {
      title: "Completed",
      value: formatNumber(stats.completedVerifications),
      icon: CheckCircle,
      color: "text-green-600",
    },
    {
      title: "Pending",
      value: formatNumber(stats.pendingVerifications),
      icon: Clock,
      color: "text-yellow-600",
    },
    {
      title: "Avg Trust Score",
      value: formatDecimal(stats.averageTrustScore),
      icon: Star,
      color: "text-purple-600",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Trust OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor verifications and trust scores</p>
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
            <h2 className="text-lg font-semibold text-gray-900">Verification Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={verificationTrendsData} 
            dataKey="verifications" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Trust Score Distribution</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <BarChart 
            data={trustScoreDistributionData} 
            dataKey="count" 
            xAxisKey="range" 
            color="#10b981"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
