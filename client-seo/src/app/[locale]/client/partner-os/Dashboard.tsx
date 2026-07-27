"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { partnerOSApi } from "@/lib/api/partner-os";
import { 
  Users,
  CheckCircle,
  DollarSign,
  Star,
  TrendingUp,
  PieChart
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { PieChart as RechartsPieChart } from "@/components/charts/PieChart";

export default function PartnerOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["partner-os-dashboard", orgId],
    queryFn: () => partnerOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: partnerTrendsData } = useQuery({
    queryKey: ["partner-os-partner-trends", orgId],
    queryFn: () => partnerOSApi.getPartnerTrends(orgId),
    enabled: !!orgId,
  });

  const { data: partnerCategoriesData } = useQuery({
    queryKey: ["partner-os-partner-categories", orgId],
    queryFn: () => partnerOSApi.getPartnerCategories(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(val);

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
    totalPartners: 0,
    activePartners: 0,
    revenue: 0,
    satisfaction: 0,
  };

  const kpis = [
    {
      title: "Total Partners",
      value: formatNumber(stats.totalPartners),
      icon: Users,
      color: "text-blue-600",
    },
    {
      title: "Active",
      value: formatNumber(stats.activePartners),
      icon: CheckCircle,
      color: "text-green-600",
    },
    {
      title: "Partner Revenue",
      value: formatCurrency(stats.revenue),
      icon: DollarSign,
      color: "text-purple-600",
    },
    {
      title: "Satisfaction",
      value: formatDecimal(stats.satisfaction),
      icon: Star,
      color: "text-orange-600",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Partner OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage partner relationships</p>
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
            <h2 className="text-lg font-semibold text-gray-900">Partner Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={partnerTrendsData} 
            dataKey="partners" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Partner Categories</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <RechartsPieChart 
            data={partnerCategoriesData} 
            dataKey="value" 
            nameKey="name"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
