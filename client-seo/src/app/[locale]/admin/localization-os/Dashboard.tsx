"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { localizationOSApi } from "@/lib/api/localization-os";
import { Globe, Languages, CheckCircle } from "lucide-react";

export default function LocalizationOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["localization-os-dashboard", orgId], queryFn: () => localizationOSApi.getDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalCountries: 0, activeCountries: 0, totalTranslations: 0, translationAccuracy: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Localization OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Countries</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalCountries)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Active</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.activeCountries)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Translations</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalTranslations)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Accuracy</p><p className="text-2xl font-bold">{dashboardStats.translationAccuracy.toFixed(1)}%</p></div>
      </div>
    </div>
  );
}
