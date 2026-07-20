"use client";

import { useLocalization } from "@/contexts/LocalizationContext";
import { useAuth } from "@/lib/auth";
import { useQuery } from "@tanstack/react-query";
import { Users, Activity, CheckCircle, AlertTriangle } from "lucide-react";

export default function UserOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["user-os-dashboard", orgId], queryFn: () => fetchUserDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalUsers: 0, activeUsers: 0, suspendedUsers: 0, userGrowthRate: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">User OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Users</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalUsers)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Active Users</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.activeUsers)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Suspended</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.suspendedUsers)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Growth Rate</p><p className="text-2xl font-bold">{dashboardStats.userGrowthRate.toFixed(1)}%</p></div>
      </div>
    </div>
  );
}

async function fetchUserDashboardStats(orgId: string) {
  return { totalUsers: 2847, activeUsers: 2650, suspendedUsers: 45, userGrowthRate: 12.5 };
}
