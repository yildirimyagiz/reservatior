"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { identityOSApi } from "@/lib/api/identity-os";
import { 
  Users,
  CheckCircle,
  Clock,
  Shield,
  BarChart3,
  TrendingUp
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { BarChart } from "@/components/charts/BarChart";

export default function IdentityOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["identity-os-dashboard", orgId],
    queryFn: () => identityOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: verificationTrendsData } = useQuery({
    queryKey: ["identity-os-verification-trends", orgId],
    queryFn: () => identityOSApi.getVerificationTrends(orgId),
    enabled: !!orgId,
  });

  const { data: identityTypesData } = useQuery({
    queryKey: ["identity-os-identity-types", orgId],
    queryFn: () => identityOSApi.getIdentityTypes(orgId),
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
    identities: 0,
    verifiedIdentities: 0,
    pendingVerifications: 0,
    verificationRate: 0,
  };

  const kpis = [
    {
      title: "Total Identities",
      value: formatNumber(stats.identities),
      icon: Users,
      color: "text-brand",
    },
    {
      title: "Verified",
      value: formatNumber(stats.verifiedIdentities),
      icon: CheckCircle,
      color: "text-blue-600",
    },
    {
      title: "Pending",
      value: formatNumber(stats.pendingVerifications),
      icon: Clock,
      color: "text-yellow-600",
    },
    {
      title: "Verification Rate",
      value: formatPercent(stats.verificationRate),
      icon: Shield,
      color: "text-brand",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Identity OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage identity verification</p>
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

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Identity Types</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <BarChart 
            data={identityTypesData} 
            dataKey="count" 
            xAxisKey="type" 
            color="#3b82f6"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
