"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { digitalTwinApi } from "@/lib/api/digital-twin";
import { 
  Copy, 
  Play, 
  BarChart3,
  CheckCircle,
  Box,
  Layers,
  Zap,
  Brain,
  Globe,
  TrendingUp,
  Target,
  Settings,
  Eye,
  Download,
  Share2
} from "lucide-react";

export default function DigitalTwinDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const [selectedTwin, setSelectedTwin] = useState<string | null>(null);
  const [viewMode, setViewMode] = useState<"3d" | "layers" | "analytics">("3d");

  const { data: twinStats, isLoading } = useQuery({
    queryKey: ["digital-twin-dashboard", orgId],
    queryFn: () => digitalTwinApi.getStats(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = twinStats || {
    totalTwins: 0,
    activeSimulations: 0,
    completedSimulations: 0,
    avgAccuracy: 0,
    syncStatus: 0,
    aiInsights: 0,
    spatialLayers: 0,
    predictionAccuracy: 0,
  };

  const kpis = [
    { title: "Digital Twins", value: formatNumber(stats.totalTwins), icon: Copy, color: "text-blue-600", trend: "+12.5%" },
    { title: "Active Simulations", value: formatNumber(stats.activeSimulations), icon: Play, color: "text-green-600", trend: "+25.3%" },
    { title: "Completed", value: formatNumber(stats.completedSimulations), icon: CheckCircle, color: "text-purple-600", trend: "+18.7%" },
    { title: "Avg Accuracy", value: `${stats.avgAccuracy.toFixed(1)}%`, icon: BarChart3, color: "text-orange-600", trend: "+5.2%" },
    { title: "AI Insights", value: formatNumber(stats.aiInsights), icon: Brain, color: "text-indigo-600", trend: "+32.1%" },
    { title: "Spatial Layers", value: formatNumber(stats.spatialLayers), icon: Layers, color: "text-pink-600", trend: "+15.7%" },
  ];

  const activeTwins = [
    { id: "twin-1", name: "Property Twin #123", type: "Residential", status: "Synced", accuracy: 94.5, lastSync: "2 min ago" },
    { id: "twin-2", name: "Commercial Twin #45", type: "Commercial", status: "Synced", accuracy: 91.2, lastSync: "5 min ago" },
    { id: "twin-3", name: "Land Twin #78", type: "Land", status: "Syncing", accuracy: 87.8, lastSync: "Processing" },
  ];

  const simulationResults = [
    { name: "Performance Optimization", value: "+15%", icon: TrendingUp, color: "text-green-600" },
    { name: "Cost Reduction", value: "-8%", icon: Target, color: "text-indigo-600" },
    { name: "Lead Conversion", value: "+12%", icon: Zap, color: "text-pink-600" },
    { name: "Revenue Prediction", value: "+22%", icon: Globe, color: "text-orange-600" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Digital Twin Dashboard</h1>
          <p className="text-gray-600 mt-1">AI-powered 3D property modeling and spatial intelligence</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
            <Box className="w-4 h-4" /> Create Twin
          </button>
          <button className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> Export
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

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">3D Twin Viewer</h2>
            <div className="flex gap-2">
              <button onClick={() => setViewMode("3d")} className={`px-3 py-1 rounded-lg text-sm ${viewMode === "3d" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-gray-600"}`}>
                <Eye className="w-4 h-4 inline mr-1" /> 3D View
              </button>
              <button onClick={() => setViewMode("layers")} className={`px-3 py-1 rounded-lg text-sm ${viewMode === "layers" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-gray-600"}`}>
                <Layers className="w-4 h-4 inline mr-1" /> Layers
              </button>
              <button onClick={() => setViewMode("analytics")} className={`px-3 py-1 rounded-lg text-sm ${viewMode === "analytics" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-gray-600"}`}>
                <BarChart3 className="w-4 h-4 inline mr-1" /> Analytics
              </button>
            </div>
          </div>
          <div className="h-96 bg-gradient-to-br from-slate-900 to-slate-800 rounded-lg flex items-center justify-center relative overflow-hidden">
            <div className="text-center text-white">
              <Box className="w-16 h-16 mx-auto mb-4 text-blue-400" />
              <p className="text-lg font-semibold">3D Property Model Viewer</p>
              <p className="text-sm text-slate-400 mt-2">Powered by Vertex AI & Gemini Multimodal</p>
              <div className="mt-4 flex gap-2 justify-center">
                <span className="px-2 py-1 bg-blue-500/20 text-blue-400 rounded text-xs">Spatial Reasoning</span>
                <span className="px-2 py-1 bg-green-500/20 text-green-400 rounded text-xs">AI Analysis</span>
                <span className="px-2 py-1 bg-purple-500/20 text-purple-400 rounded text-xs">Real-time Sync</span>
              </div>
            </div>
            <div className="absolute bottom-4 left-4 flex gap-2">
              <button className="p-2 bg-slate-700 rounded-lg text-white hover:bg-slate-600"><Settings className="w-4 h-4" /></button>
              <button className="p-2 bg-slate-700 rounded-lg text-white hover:bg-slate-600"><Share2 className="w-4 h-4" /></button>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <h2 className="text-lg font-semibold mb-4">Active Twins</h2>
          <div className="space-y-3">
            {activeTwins.map((twin) => (
              <div 
                key={twin.id}
                onClick={() => setSelectedTwin(twin.id)}
                className={`p-4 rounded-lg cursor-pointer transition ${
                  selectedTwin === twin.id ? "bg-blue-50 border-2 border-blue-500" : "bg-gray-50 border-2 border-transparent hover:bg-gray-100"
                }`}
              >
                <div className="flex items-center justify-between mb-2">
                  <span className="font-medium text-gray-900">{twin.name}</span>
                  <span className={`text-xs px-2 py-1 rounded-full ${
                    twin.status === "Synced" ? "bg-green-100 text-green-700" : "bg-yellow-100 text-yellow-700"
                  }`}>{twin.status}</span>
                </div>
                <div className="flex items-center justify-between text-sm">
                  <span className="text-gray-600">{twin.type}</span>
                  <span className="text-gray-500">{twin.accuracy.toFixed(1)}% accuracy</span>
                </div>
                <div className="text-xs text-gray-400 mt-1">{twin.lastSync}</div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
            <Brain className="w-5 h-5 text-purple-600" /> AI-Powered Insights
          </h2>
          <div className="space-y-3">
            <div className="p-4 bg-purple-50 rounded-lg border border-purple-200">
              <div className="flex items-center gap-2 mb-2">
                <Zap className="w-4 h-4 text-purple-600" />
                <span className="font-medium text-purple-900">Spatial Analysis</span>
              </div>
              <p className="text-sm text-purple-700">Property layout optimized for natural light and ventilation. Potential energy savings: 23%</p>
            </div>
            <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
              <div className="flex items-center gap-2 mb-2">
                <Target className="w-4 h-4 text-blue-600" />
                <span className="font-medium text-blue-900">Market Positioning</span>
              </div>
              <p className="text-sm text-blue-700">Comparable properties in area suggest 15% price upside potential.</p>
            </div>
            <div className="p-4 bg-green-50 rounded-lg border border-green-200">
              <div className="flex items-center gap-2 mb-2">
                <TrendingUp className="w-4 h-4 text-green-600" />
                <span className="font-medium text-green-900">Investment Potential</span>
              </div>
              <p className="text-sm text-green-700">Projected ROI of 12.5% over 5 years based on market trends.</p>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <h2 className="text-lg font-semibold mb-4">Simulation Results</h2>
          <div className="space-y-3">
            {simulationResults.map((result, i) => {
              const Icon = result.icon;
              return (
                <div key={i} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className={`p-2 rounded-lg ${result.color.replace("text-", "bg-").replace("600", "100")}`}>
                      <Icon className={`w-5 h-5 ${result.color}`} />
                    </div>
                    <span className="font-medium text-gray-900">{result.name}</span>
                  </div>
                  <span className={`font-bold ${result.color}`}>{result.value}</span>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </div>
  );
}
