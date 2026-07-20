"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { DollarSign, TrendingUp, CheckCircle, PieChart } from "lucide-react";

export default function InvestmentOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["investment-os-dashboard", orgId], queryFn: () => fetchInvestmentDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalInvestments: 0, fundedInvestments: 0, pendingInvestments: 0, averageROI: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Investment OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Investments</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalInvestments)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Funded</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.fundedInvestments)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Pending</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.pendingInvestments)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Avg ROI</p><p className="text-2xl font-bold">{dashboardStats.averageROI.toFixed(1)}%</p></div>
      </div>
    </div>
  );
}

async function fetchInvestmentDashboardStats(orgId: string) {
  return { totalInvestments: 125, fundedInvestments: 95, pendingInvestments: 30, averageROI: 15.5 };
}
