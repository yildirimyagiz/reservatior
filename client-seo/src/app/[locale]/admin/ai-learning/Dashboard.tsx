"use client";

import { useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { aiLearningApi } from "@/lib/api/ai-learning";
import { 
  Brain,
  TrendingUp,
  Target,
  BarChart3,
  Activity,
  Zap,
  ArrowUpRight,
  ArrowDownRight,
  Settings,
  Download,
  RefreshCw,
  CheckCircle,
  Clock,
  LineChart,
  Layers
} from "lucide-react";

export default function AILearningDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const [selectedLoop, setSelectedLoop] = useState<"campaign" | "price" | "negotiation" | "portfolio">("campaign");

  const { data: learningStats, isLoading } = useQuery({
    queryKey: ["ai-learning-dashboard", orgId, selectedLoop],
    queryFn: () => aiLearningApi.getStats(orgId, selectedLoop),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatPercent = (val: number) => `${val.toFixed(1)}%`;

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = learningStats || {
    totalIterations: 0,
    accuracyImprovement: 0,
    modelVersion: 0,
    lastRetrained: "",
    predictionAccuracy: 0,
    learningRate: 0,
  };

  const kpis = [
    { title: "Total Iterations", value: formatNumber(stats.totalIterations), icon: RefreshCw, color: "text-blue-600", trend: "+45.2%" },
    { title: "Accuracy Improvement", value: formatPercent(stats.accuracyImprovement), icon: TrendingUp, color: "text-green-600", trend: "+12.8%" },
    { title: "Model Version", value: `v${stats.modelVersion.toFixed(1)}`, icon: Layers, color: "text-purple-600", trend: "Latest" },
    { title: "Prediction Accuracy", value: formatPercent(stats.predictionAccuracy), icon: Target, color: "text-orange-600", trend: "+5.3%" },
    { title: "Learning Rate", value: formatPercent(stats.learningRate), icon: Zap, color: "text-indigo-600", trend: "+8.7%" },
    { title: "Last Retrained", value: stats.lastRetrained, icon: Clock, color: "text-pink-600", trend: "2h ago" },
  ];

  const learningLoops = [
    { id: "campaign", name: "Campaign Learning", status: "active", accuracy: 0.92, iterations: 234, lastUpdate: "1h ago" },
    { id: "price", name: "Price Learning", status: "active", accuracy: 0.89, iterations: 189, lastUpdate: "3h ago" },
    { id: "negotiation", name: "Negotiation Learning", status: "training", accuracy: 0.85, iterations: 145, lastUpdate: "5h ago" },
    { id: "portfolio", name: "Portfolio Learning", status: "active", accuracy: 0.91, iterations: 267, lastUpdate: "2h ago" },
  ];

  const learningMetrics = [
    { metric: "ROAS Optimization", current: 2.8, target: 3.5, progress: 80, trend: "up" },
    { metric: "Price Accuracy", current: 0.89, target: 0.95, progress: 94, trend: "up" },
    { metric: "Conversion Rate", current: 0.12, target: 0.15, progress: 80, trend: "up" },
    { metric: "Cost Reduction", current: 0.08, target: 0.12, progress: 67, trend: "up" },
  ];

  const recentImprovements = [
    { loop: "Campaign Learning", improvement: "+15%", metric: "ROAS", date: "2h ago" },
    { loop: "Price Learning", improvement: "+8%", metric: "Accuracy", date: "4h ago" },
    { loop: "Negotiation Learning", improvement: "+12%", metric: "Success Rate", date: "6h ago" },
    { loop: "Portfolio Learning", improvement: "+10%", metric: "ROI", date: "8h ago" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">AI Learning Loops Dashboard</h1>
          <p className="text-gray-600 mt-1">Continuous AI improvement and model retraining</p>
        </div>
        <div className="flex gap-3">
          <select 
            value={selectedLoop} 
            onChange={(e) => setSelectedLoop(e.target.value as "campaign" | "price" | "negotiation" | "portfolio")}
            className="px-4 py-2 border border-gray-300 rounded-lg bg-white"
          >
            <option value="campaign">Campaign Learning</option>
            <option value="price">Price Learning</option>
            <option value="negotiation">Negotiation Learning</option>
            <option value="portfolio">Portfolio Learning</option>
          </select>
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
            <RefreshCw className="w-4 h-4" /> Retrain Models
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{kpi.title}</p>
                  <p className="text-2xl font-bold text-gray-900 mt-2">{kpi.value}</p>
                  <p className="text-sm text-green-600 mt-1">{kpi.trend}</p>
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
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
              <Brain className="w-5 h-5 text-purple-600" /> Active Learning Loops
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-gray-500" /></button>
          </div>
          <div className="space-y-3">
            {learningLoops.map((loop) => (
              <div 
                key={loop.id}
                onClick={() => setSelectedLoop(loop.id as "campaign" | "price" | "negotiation" | "portfolio")}
                className={`p-4 rounded-lg cursor-pointer transition ${
                  selectedLoop === loop.id ? "bg-blue-50 border-2 border-blue-500" : "bg-gray-50 border-2 border-transparent hover:bg-gray-100"
                }`}
              >
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-3">
                    <span className="font-medium text-gray-900">{loop.name}</span>
                    <span className={`text-xs px-2 py-1 rounded-full ${
                      loop.status === "active" ? "bg-green-100 text-green-700" : "bg-yellow-100 text-yellow-700"
                    }`}>{loop.status}</span>
                  </div>
                  <span className="text-sm font-bold text-gray-900">{loop.accuracy.toFixed(0)}%</span>
                </div>
                <div className="flex items-center justify-between text-sm">
                  <span className="text-gray-600">{loop.iterations} iterations</span>
                  <span className="text-gray-500">{loop.lastUpdate}</span>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
              <Activity className="w-5 h-5 text-orange-600" /> Learning Metrics
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Download className="w-4 h-4 text-gray-500" /></button>
          </div>
          <div className="space-y-3">
            {learningMetrics.map((metric, i) => (
              <div key={i} className="p-4 bg-gray-50 rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-medium text-gray-900">{metric.metric}</span>
                  <div className="flex items-center gap-2">
                    <span className="text-sm text-gray-600">{metric.current.toFixed(2)}</span>
                    {metric.trend === "up" ? <ArrowUpRight className="w-4 h-4 text-green-600" /> : <ArrowDownRight className="w-4 h-4 text-red-600" />}
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <div className="flex-1 bg-gray-200 rounded-full h-2">
                    <div className="bg-orange-500 h-2 rounded-full" style={{ width: `${metric.progress}%` }} />
                  </div>
                  <span className="text-xs text-gray-600">{metric.progress}%</span>
                </div>
                <p className="text-xs text-gray-500 mt-1">Target: {metric.target.toFixed(2)}</p>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <Zap className="w-5 h-5 text-yellow-600" /> Recent Improvements
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><RefreshCw className="w-4 h-4 text-gray-500" /></button>
        </div>
        <div className="space-y-3">
          {recentImprovements.map((improvement, i) => (
            <div key={i} className="flex items-center justify-between p-4 bg-green-50 rounded-lg border border-green-200">
              <div className="flex items-center gap-3">
                <CheckCircle className="w-5 h-5 text-green-600" />
                <div>
                  <p className="font-medium text-green-900">{improvement.loop}</p>
                  <p className="text-sm text-green-700">{improvement.metric} improvement</p>
                </div>
              </div>
              <div className="text-right">
                <span className="text-lg font-bold text-green-600">{improvement.improvement}</span>
                <p className="text-xs text-green-600">{improvement.date}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <LineChart className="w-5 h-5 text-indigo-600" /> Learning Progress Visualization
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-gray-500" /></button>
        </div>
        <div className="h-64 bg-gradient-to-br from-indigo-50 to-indigo-100 rounded-lg flex items-center justify-center">
          <div className="text-center">
            <BarChart3 className="w-12 h-12 mx-auto mb-3 text-indigo-600" />
            <p className="text-lg font-semibold text-indigo-900">AI Learning Progress Chart</p>
            <p className="text-sm text-indigo-700 mt-1">Model accuracy and performance over time</p>
          </div>
        </div>
      </div>
    </div>
  );
}
