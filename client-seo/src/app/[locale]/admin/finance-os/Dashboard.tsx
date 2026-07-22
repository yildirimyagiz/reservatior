"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { financeOSApi } from "@/lib/api/finance-os";
import CommissionRuleEngineDashboard from "@/components/financial/CommissionRuleEngineDashboard";
import { 
  DollarSign, 
  TrendingUp, 
  Briefcase, 
  CreditCard, 
  PieChart, 
  BarChart3,
  Calendar,
  Users,
  AlertCircle,
  CheckCircle,
  ArrowUpRight,
  ArrowDownRight
} from "lucide-react";

export default function FinanceOSDashboard() {
  const { user } = useAuth();
  const { currency, language } = useLocalization();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["finance-os-dashboard", orgId],
    queryFn: () => financeOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

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
    totalRevenue: 0,
    totalCommissions: 0,
    activeDeals: 0,
    closedDeals: 0,
    pendingCommissions: 0,
    paidCommissions: 0,
    averageDealValue: 0,
    commissionRate: 0,
  };

  const kpis = [
    {
      title: "Total Revenue",
      value: formatCurrency(stats.totalRevenue),
      icon: DollarSign,
      color: "text-green-600",
      trend: "+18.5% vs last month",
      trendUp: true,
    },
    {
      title: "Total Commissions",
      value: formatCurrency(stats.totalCommissions),
      icon: Briefcase,
      color: "text-blue-600",
      trend: "+12.3% vs last month",
      trendUp: true,
    },
    {
      title: "Active Deals",
      value: formatNumber(stats.activeDeals),
      icon: Calendar,
      color: "text-purple-600",
      trend: "+8.7% vs last month",
      trendUp: true,
    },
    {
      title: "Closed Deals",
      value: formatNumber(stats.closedDeals),
      icon: CheckCircle,
      color: "text-emerald-600",
      trend: "+15.2% vs last month",
      trendUp: true,
    },
    {
      title: "Pending Commissions",
      value: formatCurrency(stats.pendingCommissions),
      icon: Clock,
      color: "text-yellow-600",
      trend: "-5.4% vs last month",
      trendUp: false,
    },
    {
      title: "Paid Commissions",
      value: formatCurrency(stats.paidCommissions),
      icon: CreditCard,
      color: "text-indigo-600",
      trend: "+22.1% vs last month",
      trendUp: true,
    },
    {
      title: "Average Deal Value",
      value: formatCurrency(stats.averageDealValue),
      icon: TrendingUp,
      color: "text-orange-600",
      trend: "+7.8% vs last month",
      trendUp: true,
    },
    {
      title: "Commission Rate",
      value: `${stats.commissionRate.toFixed(2)}%`,
      icon: PieChart,
      color: "text-pink-600",
      trend: "+0.5% vs last month",
      trendUp: true,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Finance OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor and manage financial operations</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
            New Deal
          </button>
          <button className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition">
            Generate Report
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
        {/* Revenue Trends Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Revenue Trends</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Revenue trends chart will be rendered here</p>
          </div>
        </div>

        {/* Commission Distribution Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Commission Distribution</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Commission distribution chart will be rendered here</p>
          </div>
        </div>
      </div>

      {/* Recent Deals */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Recent Deals</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-green-100 rounded-lg">
                  <Briefcase className="w-5 h-5 text-green-600" />
                </div>
                <div>
                  <p className="font-medium text-gray-900">Deal #{1000 + item}</p>
                  <p className="text-sm text-gray-600">Property #{500 + item}</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-gray-900">{formatCurrency(250000 + item * 50000)}</p>
                <p className="text-sm text-gray-600">{item} day(s) ago</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Commission Models */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Commission Models</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">Traditional 1M</h3>
            <p className="text-sm text-blue-700 mt-1">Lump sum payment</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">45%</p>
            <p className="text-xs text-blue-600">of total deals</p>
          </div>
          <div className="p-4 bg-purple-50 border border-purple-200 rounded-lg">
            <h3 className="font-semibold text-purple-900">Installment 12</h3>
            <p className="text-sm text-purple-700 mt-1">12 monthly payments</p>
            <p className="text-2xl font-bold text-purple-900 mt-2">35%</p>
            <p className="text-xs text-purple-600">of total deals</p>
          </div>
          <div className="p-4 bg-green-50 border border-green-200 rounded-lg">
            <h3 className="font-semibold text-green-900">Hybrid 50/6</h3>
            <p className="text-sm text-green-700 mt-1">50% upfront + 6 payments</p>
            <p className="text-2xl font-bold text-green-900 mt-2">20%</p>
            <p className="text-xs text-green-600">of total deals</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Commission Rule Engine</h2>
        <CommissionRuleEngineDashboard />
      </div>

      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900">Alerts & Notifications</h2>
          <AlertCircle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertCircle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">High pending commissions</p>
              <p className="text-sm text-yellow-700">Pending commissions increased by 15% this week</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-green-50 border border-green-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-green-600 mt-0.5" />
            <div>
              <p className="font-medium text-green-900">Revenue target achieved</p>
              <p className="text-sm text-green-700">Monthly revenue target exceeded by 18%</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
