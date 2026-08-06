"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { localizationOSApi } from "@/lib/api/localization-os";
import { 
  Languages,
  Globe,
  CheckSquare,
  Clock,
  BarChart3,
  TrendingUp
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { BarChart } from "@/components/charts/BarChart";

export default function LocalizationOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["localization-os-dashboard", orgId],
    queryFn: () => localizationOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: translationProgressData } = useQuery({
    queryKey: ["localization-os-translation-progress", orgId],
    queryFn: () => localizationOSApi.getTranslationProgress(orgId),
    enabled: !!orgId,
  });

  const { data: regionalCoverageData } = useQuery({
    queryKey: ["localization-os-regional-coverage", orgId],
    queryFn: () => localizationOSApi.getRegionalCoverage(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

  const formatPercent = (val: number) =>
    `${val.toFixed(1)}%`;

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const stats = dashboardStats || {
    languages: 0,
    translations: 0,
    regions: 0,
    completionRate: 0,
  };


  const kpis = [
    {
      title: "Supported Languages",
      value: formatNumber(stats.languages),
      icon: Languages,
      color: "text-brand",
    },
    {
      title: "Total Translations",
      value: formatNumber(stats.translations),
      icon: Globe,
      color: "text-blue-600",
    },
    {
      title: "Active Regions",
      value: formatNumber(stats.regions),
      icon: Globe,
      color: "text-brand",
    },
    {
      title: "Translation Completion",
      value: formatPercent(stats.completionRate),
      icon: CheckSquare,
      color: "text-warning",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Localization OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage localization and translations</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{kpi.title}</p>
                  <p className="text-2xl font-bold text-gray-900 mt-2">{kpi.value}</p>
                </div>
                <div className={`p-3 bg-gray-50 rounded-lg ${kpi.color}`}>
                  <Icon className="w-6 h-6" />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Translation Progress</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={translationProgressData} 
            dataKey="progress" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Regional Coverage</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <BarChart 
            data={regionalCoverageData} 
            dataKey="coverage" 
            xAxisKey="region" 
            color="#3b82f6"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
