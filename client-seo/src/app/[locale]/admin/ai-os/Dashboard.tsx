"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { Brain, Zap, BarChart3, Activity } from "lucide-react";

export default function AIOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["ai-os-dashboard", orgId], queryFn: () => fetchAIDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalModels: 0, activeModels: 0, predictionsMade: 0, modelAccuracy: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">AI OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Models</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalModels)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Active Models</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.activeModels)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Predictions</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.predictionsMade)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Accuracy</p><p className="text-2xl font-bold">{dashboardStats.modelAccuracy.toFixed(1)}%</p></div>
      </div>
    </div>
  );
}

async function fetchAIDashboardStats(orgId: string) {
  return { totalModels: 45, activeModels: 32, predictionsMade: 12500, modelAccuracy: 0.89 };
}
