"use client";

import { useLocalization } from "@/contexts/LocalizationContext";
import { useAuth } from "@/lib/auth";
import { useQuery } from "@tanstack/react-query";
import { Users, CheckCircle, Star } from "lucide-react";

export default function PartnerOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";
  const { data: stats } = useQuery({ queryKey: ["partner-os-dashboard", orgId], queryFn: () => fetchPartnerDashboardStats(), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalPartners: 0, activePartners: 0, pendingPartners: 0, averagePartnerScore: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Partner OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Partners</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalPartners)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Active Partners</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.activePartners)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Pending</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.pendingPartners)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Avg Score</p><p className="text-2xl font-bold">{dashboardStats.averagePartnerScore.toFixed(2)}</p></div>
      </div>
    </div>
  );
}

async function fetchPartnerDashboardStats() {
  return { totalPartners: 85, activePartners: 72, pendingPartners: 13, averagePartnerScore: 0.87 };
}
