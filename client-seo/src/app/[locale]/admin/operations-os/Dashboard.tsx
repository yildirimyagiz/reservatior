"use client";

import { useLocalization } from "@/contexts/LocalizationContext";
import { useAuth } from "@/lib/auth";
import { useQuery } from "@tanstack/react-query";
import { CheckSquare, Clock, CheckCircle, Activity } from "lucide-react";

export default function OperationsOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["operations-os-dashboard", orgId], queryFn: () => fetchOperationsDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalTasks: 0, completedTasks: 0, pendingTasks: 0, averageCompletionTime: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Operations OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Tasks</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalTasks)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Completed</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.completedTasks)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Pending</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.pendingTasks)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Avg Completion Time</p><p className="text-2xl font-bold">{dashboardStats.averageCompletionTime.toFixed(1)}m</p></div>
      </div>
    </div>
  );
}

async function fetchOperationsDashboardStats(orgId: string) {
  return { totalTasks: 850, completedTasks: 720, pendingTasks: 130, averageCompletionTime: 45 };
}
