"use client";

import { useLocalization } from "@/contexts/LocalizationContext";
import { useAuth } from "@/lib/auth";
import { useQuery } from "@tanstack/react-query";

export default function SecurityOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";
  const { data: stats } = useQuery({ queryKey: ["security-os-dashboard", orgId], queryFn: () => fetchSecurityDashboardStats(), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalAlerts: 0, resolvedAlerts: 0, activeIncidents: 0, totalSecurityScans: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Security OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Alerts</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalAlerts)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Resolved</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.resolvedAlerts)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Active Incidents</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.activeIncidents)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Security Scans</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalSecurityScans)}</p></div>
      </div>
    </div>
  );
}

async function fetchSecurityDashboardStats() {
  return { totalAlerts: 1250, resolvedAlerts: 1180, activeIncidents: 5, totalSecurityScans: 450 };
}
