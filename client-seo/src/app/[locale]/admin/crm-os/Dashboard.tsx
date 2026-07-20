"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { Users, CheckCircle, Target, TrendingUp } from "lucide-react";

export default function CRMOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["crm-os-dashboard", orgId], queryFn: () => fetchCRMDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalLeads: 0, qualifiedLeads: 0, convertedLeads: 0, conversionRate: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">CRM OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Leads</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalLeads)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Qualified</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.qualifiedLeads)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Converted</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.convertedLeads)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Conversion Rate</p><p className="text-2xl font-bold">{dashboardStats.conversionRate.toFixed(1)}%</p></div>
      </div>
    </div>
  );
}

async function fetchCRMDashboardStats(orgId: string) {
  return { totalLeads: 2450, qualifiedLeads: 1850, convertedLeads: 980, conversionRate: 40.0 };
}
