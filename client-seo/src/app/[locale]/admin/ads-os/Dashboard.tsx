"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { Megaphone, Play, Pause, DollarSign } from "lucide-react";

export default function AdsOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["ads-os-dashboard", orgId], queryFn: () => fetchAdsDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalCampaigns: 0, activeCampaigns: 0, pausedCampaigns: 0, averageCTR: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Ads OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Campaigns</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalCampaigns)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Active</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.activeCampaigns)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Paused</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.pausedCampaigns)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Avg CTR</p><p className="text-2xl font-bold">{dashboardStats.averageCTR.toFixed(2)}%</p></div>
      </div>
    </div>
  );
}

async function fetchAdsDashboardStats(orgId: string) {
  return { totalCampaigns: 85, activeCampaigns: 62, pausedCampaigns: 23, averageCTR: 3.8 };
}
