"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { commerceOSApi } from "@/lib/api/commerce-os";
import { 
  ShoppingCart,
  DollarSign,
  Package,
  TrendingUp,
  BarChart3,
  PieChart
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { PieChart as RechartsPieChart } from "@/components/charts/PieChart";

export default function CommerceOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["commerce-os-dashboard", orgId],
    queryFn: () => commerceOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: salesTrendsData } = useQuery({
    queryKey: ["commerce-os-sales-trends", orgId],
    queryFn: () => commerceOSApi.getSalesTrends(orgId),
    enabled: !!orgId,
  });

  const { data: productCategoriesData } = useQuery({
    queryKey: ["commerce-os-product-categories", orgId],
    queryFn: () => commerceOSApi.getProductCategories(orgId),
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
    totalOrders: 0,
    totalRevenue: 0,
    products: 0,
    conversionRate: 0,
  };

  const kpis = [
    {
      title: "Total Orders",
      value: formatNumber(stats.totalOrders),
      icon: ShoppingCart,
      color: "text-blue-600",
    },
    {
      title: "Total Revenue",
      value: formatCurrency(stats.totalRevenue),
      icon: DollarSign,
      color: "text-green-600",
    },
    {
      title: "Products",
      value: formatNumber(stats.products),
      icon: Package,
      color: "text-purple-600",
    },
    {
      title: "Conversion Rate",
      value: formatPercent(stats.conversionRate),
      icon: TrendingUp,
      color: "text-orange-600",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Commerce OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage e-commerce operations</p>
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
            <h2 className="text-lg font-semibold text-gray-900">Sales Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={salesTrendsData} 
            dataKey="sales" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Product Categories</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <RechartsPieChart 
            data={productCategoriesData} 
            dataKey="value" 
            nameKey="name"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
