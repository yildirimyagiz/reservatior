"use client";


import { useLocalization } from "@/contexts/LocalizationContext";
import { useAuth } from "@/lib/auth";
import { useQuery } from "@tanstack/react-query";
import { 
  Network, 
  Activity, 
  Lightbulb, 
  Zap,
  BarChart3,
  GitBranch,
  Target,
  ArrowUpRight
} from "lucide-react";

export default function IntelligenceGraphDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";

  const { data: graphStats, isLoading } = useQuery({
    queryKey: ["intelligence-graph-dashboard", orgId],
    queryFn: () => fetchGraphStats(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = graphStats || {
    totalNodes: 0,
    totalEdges: 0,
    activeInsights: 0,
    pendingActions: 0,
    modelAccuracy: 0,
    predictionsToday: 0,
  };

  const kpis = [
    { title: "Total Nodes", value: formatNumber(stats.totalNodes), icon: Network, color: "text-blue-600", trend: "+15.3%" },
    { title: "Relationships", value: formatNumber(stats.totalEdges), icon: GitBranch, color: "text-purple-600", trend: "+22.7%" },
    { title: "Active Insights", value: formatNumber(stats.activeInsights), icon: Lightbulb, color: "text-orange-600", trend: "+18.5%" },
    { title: "Pending Actions", value: formatNumber(stats.pendingActions), icon: Zap, color: "text-green-600", trend: "+8.2%" },
    { title: "Model Accuracy", value: `${stats.modelAccuracy.toFixed(1)}%`, icon: BarChart3, color: "text-indigo-600", trend: "+3.1%" },
    { title: "Predictions", value: formatNumber(stats.predictionsToday), icon: Activity, color: "text-pink-600", trend: "+35.4%" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Intelligence Graph Dashboard</h1><p className="text-gray-600 mt-1">Monitor graph analytics and ML predictions</p></div>
        <div className="flex gap-3"><button className="px-4 py-2 bg-blue-600 text-white rounded-lg">Run Analysis</button></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return <div key={i} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
            <div className="flex items-center justify-between">
              <div><p className="text-sm font-medium text-gray-600">{kpi.title}</p><p className="text-2xl font-bold text-gray-900 mt-2">{kpi.value}</p></div>
              <div className={`p-3 bg-gray-50 rounded-lg ${kpi.color}`}><Icon className="w-6 h-6" /></div>
            </div>
          </div>;
        })}
      </div>
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><h2 className="text-lg font-semibold mb-4">Graph Layers</h2><div className="space-y-3">
          <div className="flex items-center justify-between p-3 bg-blue-50 rounded-lg"><span className="font-medium">Data Layer</span><span className="text-sm text-blue-600">Active</span></div>
          <div className="flex items-center justify-between p-3 bg-purple-50 rounded-lg"><span className="font-medium">Relationship Layer</span><span className="text-sm text-purple-600">Active</span></div>
          <div className="flex items-center justify-between p-3 bg-orange-50 rounded-lg"><span className="font-medium">Insight Layer</span><span className="text-sm text-orange-600">Active</span></div>
          <div className="flex items-center justify-between p-3 bg-green-50 rounded-lg"><span className="font-medium">Action Layer</span><span className="text-sm text-green-600">Active</span></div>
        </div></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><h2 className="text-lg font-semibold mb-4">ML Models</h2><div className="space-y-3">
          <div className="flex items-center justify-between p-3 bg-indigo-50 rounded-lg"><span className="font-medium">Agent Performance</span><span className="text-sm text-indigo-600">87%</span></div>
          <div className="flex items-center justify-between p-3 bg-pink-50 rounded-lg"><span className="font-medium">Booking Cancellation</span><span className="text-sm text-pink-600">82%</span></div>
          <div className="flex items-center justify-between p-3 bg-red-50 rounded-lg"><span className="font-medium">Anomaly Detection</span><span className="text-sm text-red-600">91%</span></div>
          <div className="flex items-center justify-between p-3 bg-cyan-50 rounded-lg"><span className="font-medium">Lead Clustering</span><span className="text-sm text-cyan-600">78%</span></div>
        </div></div>
      </div>
    </div>
  );
}

async function fetchGraphStats(orgId: string) {
  return { totalNodes: 1250, totalEdges: 3400, activeInsights: 45, pendingActions: 12, modelAccuracy: 0.87, predictionsToday: 234 };
}
