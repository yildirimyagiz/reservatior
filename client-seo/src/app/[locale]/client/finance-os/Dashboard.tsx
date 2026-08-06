"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { financeOSApi } from "@/lib/api/finance-os";
import { 
  DollarSign, 
  CreditCard,
  TrendingUp,
  Activity,
  BarChart3,
  PieChart
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { PieChart as RechartsPieChart } from "@/components/charts/PieChart";

export default function FinanceOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["finance-os-dashboard", orgId],
    queryFn: () => financeOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: revenueTrendsData } = useQuery({
    queryKey: ["finance-os-revenue-trends", orgId],
    queryFn: () => financeOSApi.getRevenueTrends(orgId),
    enabled: !!orgId,
  });

  const { data: expenseBreakdownData } = useQuery({
    queryKey: ["finance-os-expense-breakdown", orgId],
    queryFn: () => financeOSApi.getExpenseBreakdown(orgId),
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
    totalRevenue: 0,
    expenses: 0,
    profit: 0,
    profitMargin: 0,
  };

  const kpis = [
    {
      title: "Total Revenue",
      value: formatCurrency(stats.totalRevenue),
      icon: DollarSign,
      color: "text-brand",
    },
    {
      title: "Total Expenses",
      value: formatCurrency(stats.expenses),
      icon: CreditCard,
      color: "text-red-600",
    },
    {
      title: "Net Profit",
      value: formatCurrency(stats.profit),
      icon: TrendingUp,
      color: "text-blue-600",
    },
    {
      title: "Profit Margin",
      value: formatPercent(stats.profitMargin),
      icon: Activity,
      color: "text-brand",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Finance OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor financial performance</p>
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
            <h2 className="text-lg font-semibold text-gray-900">Revenue Trends</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={revenueTrendsData} 
            dataKey="revenue" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Expense Breakdown</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <RechartsPieChart 
            data={expenseBreakdownData} 
            dataKey="value" 
            nameKey="name"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
