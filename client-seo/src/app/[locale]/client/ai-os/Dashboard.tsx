"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { aiOSApi } from "@/lib/api/ai-os";
import { 
  Brain,
  Zap,
  Sparkles,
  Clock,
  BarChart3,
  TrendingUp
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { BarChart } from "@/components/charts/BarChart";

export default function AiOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["ai-os-dashboard", orgId],
    queryFn: () => aiOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: predictionTrendsData } = useQuery({
    queryKey: ["ai-os-prediction-trends", orgId],
    queryFn: () => aiOSApi.getPredictionTrends(orgId),
    enabled: !!orgId,
  });

  const { data: modelPerformanceData } = useQuery({
    queryKey: ["ai-os-model-performance", orgId],
    queryFn: () => aiOSApi.getModelPerformance(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

  const formatPercent = (val: number) =>
    `${val.toFixed(1)}%`;

  const formatDecimal = (val: number) =>
    val.toFixed(2);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const stats = dashboardStats || {
    aiModels: 0,
    predictions: 0,
    accuracy: 0,
    processingTime: 0,
  };

  const kpis = [
    {
      title: "AI Models",
      value: formatNumber(stats.aiModels),
      icon: Brain,
      color: "text-brand",
    },
    {
      title: "Predictions",
      value: formatNumber(stats.predictions),
      icon: Zap,
      color: "text-brand",
    },
    {
      title: "Accuracy",
      value: formatPercent(stats.accuracy),
      icon: Sparkles,
      color: "text-blue-600",
    },
    {
      title: "Avg Processing Time",
      value: `${formatDecimal(stats.processingTime)}s`,
      icon: Clock,
      color: "text-warning",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">AI OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage AI models and predictions</p>
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
            <h2 className="text-lg font-semibold text-gray-900">Prediction Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={predictionTrendsData} 
            dataKey="predictions" 
            xAxisKey="month" 
            color="#8b5cf6"
            height={256}
          />
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Model Performance</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <BarChart 
            data={modelPerformanceData} 
            dataKey="accuracy" 
            xAxisKey="model" 
            color="#f59e0b"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
