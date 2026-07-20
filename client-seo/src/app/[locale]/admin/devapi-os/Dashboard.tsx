"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { Key, Activity, Clock, AlertTriangle } from "lucide-react";

export default function DevAPIOSSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["devapi-os-dashboard", orgId], queryFn: () => fetchDevAPIDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalAPIKeys: 0, activeAPIKeys: 0, revokedAPIKeys: 0, totalAPICalls: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Developer API OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total API Keys</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalAPIKeys)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Active Keys</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.activeAPIKeys)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Revoked</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.revokedAPIKeys)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Calls</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalAPICalls)}</p></div>
      </div>
    </div>
  );
}

async function fetchDevAPIDashboardStats(orgId: string) {
  return { totalAPIKeys: 1250, activeAPIKeys: 1180, revokedAPIKeys: 70, totalAPICalls: 8500000 };
}
