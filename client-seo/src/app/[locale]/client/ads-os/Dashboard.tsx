"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { adsOSApi } from "@/lib/api/ads-os";
import { 
  Megaphone,
  TrendingUp,
  DollarSign,
  Target,
  BarChart3,
  PieChart
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { PieChart as RechartsPieChart } from "@/components/charts/PieChart";

export default function AdsOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["ads-os-dashboard", orgId],
    queryFn: () => adsOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: campaignPerformanceData } = useQuery({
    queryKey: ["ads-os-campaign-performance", orgId],
    queryFn: () => adsOSApi.getCampaignPerformance(orgId),
    enabled: !!orgId,
  });

  const { data: adSpendDistributionData } = useQuery({
    queryKey: ["ads-os-ad-spend-distribution", orgId],
    queryFn: () => adsOSApi.getAdSpendDistribution(orgId),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(val);

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
    activeCampaigns: 0,
    totalSpend: 0,
    impressions: 0,
    clickThroughRate: 0,
  };

  const kpis = [
    {
      title: "Active Campaigns",
      value: formatNumber(stats.activeCampaigns),
      icon: Megaphone,
      color: "text-brand",
    },
    {
      title: "Total Spend",
      value: formatCurrency(stats.totalSpend),
      icon: DollarSign,
      color: "text-blue-600",
    },
    {
      title: "Impressions",
      value: formatNumber(stats.impressions),
      icon: Target,
      color: "text-brand",
    },
    {
      title: "CTR",
      value: formatPercent(stats.clickThroughRate),
      icon: TrendingUp,
      color: "text-warning",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Ads OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage advertising campaigns and performance</p>
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
            <h2 className="text-lg font-semibold text-gray-900">Campaign Performance</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={campaignPerformanceData} 
            dataKey="performance" 
            xAxisKey="month" 
            color="#ec4899"
            height={256}
          />
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Ad Spend Distribution</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <RechartsPieChart 
            data={adSpendDistributionData} 
            dataKey="value" 
            nameKey="name"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
