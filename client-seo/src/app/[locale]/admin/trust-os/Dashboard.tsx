"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { Shield, CheckCircle, Clock, AlertTriangle } from "lucide-react";

export default function TrustOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["trust-os-dashboard", orgId], queryFn: () => fetchTrustDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalVerifications: 0, completedVerifications: 0, pendingVerifications: 0, averageTrustScore: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Trust OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Verifications</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalVerifications)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Completed</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.completedVerifications)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Pending</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.pendingVerifications)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Avg Trust Score</p><p className="text-2xl font-bold">{dashboardStats.averageTrustScore.toFixed(2)}</p></div>
      </div>
    </div>
  );
}

async function fetchTrustDashboardStats(orgId: string) {
  return { totalVerifications: 1250, completedVerifications: 1100, pendingVerifications: 150, averageTrustScore: 0.82 };
}
