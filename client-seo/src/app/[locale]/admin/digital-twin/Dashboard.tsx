"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { 
  Copy, 
  Play, 
  Pause, 
  RotateCcw,
  BarChart3,
  Activity,
  CheckCircle,
  Clock,
  AlertTriangle
} from "lucide-react";

export default function DigitalTwinDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";

  const { data: twinStats, isLoading } = useQuery({
    queryKey: ["digital-twin-dashboard", orgId],
    queryFn: () => fetchTwinStats(orgId),
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
  };

  const kpis = [
    { title: "Digital Twins", value: formatNumber(stats.totalTwins), icon: Copy, color: "text-blue-600", trend: "+12.5%" },
    { title: "Active Simulations", value: formatNumber(stats.activeSimulations), icon: Play, color: "text-green-600", trend: "+25.3%" },
    { title: "Completed", value: formatNumber(stats.completedSimulations), icon: CheckCircle, color: "text-purple-600", trend: "+18.7%" },
    { title: "Avg Accuracy", value: `${stats.avgAccuracy.toFixed(1)}%`, icon: BarChart3, color: "text-orange-600", trend: "+5.2%" },
    { title: "Sync Status", value: `${stats.syncStatus.toFixed(1)}%`, icon: Activity, color: "text-indigo-600", trend: "+2.8%" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Digital Twin Dashboard</h1><p className="text-gray-600 mt-1">Manage digital twins and simulations</p></div>
        <div className="flex gap-3"><button className="px-4 py-2 bg-blue-600 text-white rounded-lg">Create Twin</button></div>
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
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><h2 className="text-lg font-semibold mb-4">Active Twins</h2><div className="space-y-3">
          <div className="flex items-center justify-between p-3 bg-blue-50 rounded-lg"><span className="font-medium">Agent Twin #1</span><span className="text-sm text-green-600">Synced</span></div>
          <div className="flex items-center justify-between p-3 bg-purple-50 rounded-lg"><span className="font-medium">Listing Twin #5</span><span className="text-sm text-green-600">Synced</span></div>
          <div className="flex items-center justify-between p-3 bg-orange-50 rounded-lg"><span className="font-medium">Booking Twin #12</span><span className="text-sm text-yellow-600">Syncing</span></div>
        </div></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><h2 className="text-lg font-semibold mb-4">Simulation Results</h2><div className="space-y-3">
          <div className="flex items-center justify-between p-3 bg-green-50 rounded-lg"><span className="font-medium">Performance Optimization</span><span className="text-sm text-green-600">+15%</span></div>
          <div className="flex items-center justify-between p-3 bg-indigo-50 rounded-lg"><span className="font-medium">Cost Reduction</span><span className="text-sm text-indigo-600">-8%</span></div>
          <div className="flex items-center justify-between p-3 bg-pink-50 rounded-lg"><span className="font-medium">Lead Conversion</span><span className="text-sm text-pink-600">+12%</span></div>
        </div></div>
      </div>
    </div>
  );
}

async function fetchTwinStats(orgId: string) {
  return { totalTwins: 45, activeSimulations: 8, completedSimulations: 127, avgAccuracy: 0.89, syncStatus: 0.95 };
}
