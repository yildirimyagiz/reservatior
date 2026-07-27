"use client";

import { useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { geospatialApi } from "@/lib/api/geospatial";
import { 
  Map,
  TrendingUp,
  Building2,
  Activity,
  Globe,
  Layers,
  Zap,
  Target,
  Settings,
  Download,
  Filter,
  Thermometer,
  Navigation,
  DollarSign
} from "lucide-react";

export default function GeospatialDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const [selectedHeatmap, setSelectedHeatmap] = useState<"yield" | "demand" | "appreciation">("yield");

  const { data: geospatialStats, isLoading } = useQuery({
    queryKey: ["geospatial-dashboard", orgId, selectedHeatmap],
    queryFn: () => geospatialApi.getStats(orgId, selectedHeatmap, "all"),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatPercent = (val: number) => `${val.toFixed(1)}%`;

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = geospatialStats || {
    totalProperties: 0,
    avgYield: 0,
    demandScore: 0,
    appreciationRate: 0,
    activeRegions: 0,
    dataPoints: 0,
  };

  const kpis = [
    { title: "Total Properties", value: formatNumber(stats.totalProperties), icon: Building2, color: "text-blue-600", trend: "+12.5%" },
    { title: "Avg Yield", value: formatPercent(stats.avgYield), icon: DollarSign, color: "text-green-600", trend: "+8.3%" },
    { title: "Demand Score", value: stats.demandScore.toFixed(1), icon: Activity, color: "text-purple-600", trend: "+15.2%" },
    { title: "Appreciation Rate", value: formatPercent(stats.appreciationRate), icon: TrendingUp, color: "text-orange-600", trend: "+5.7%" },
    { title: "Active Regions", value: formatNumber(stats.activeRegions), icon: Globe, color: "text-indigo-600", trend: "+3.1%" },
    { title: "Data Points", value: formatNumber(stats.dataPoints), icon: Layers, color: "text-pink-600", trend: "+22.4%" },
  ];

  const heatmapTypes = [
    { id: "yield", name: "Rental Yield Heatmap", description: "Annual rental yield by location", color: "from-green-500 to-emerald-600" },
    { id: "demand", name: "Demand Density Heatmap", description: "Market demand and search volume", color: "from-blue-500 to-indigo-600" },
    { id: "appreciation", name: "Capital Appreciation Heatmap", description: "Property value growth trends", color: "from-orange-500 to-red-600" },
  ];

  const regionalData = [
    { region: "Europe", countries: 12, avgYield: 0.065, demand: 8.2, appreciation: 0.045 },
    { region: "Asia", countries: 8, avgYield: 0.072, demand: 9.1, appreciation: 0.058 },
    { region: "Americas", countries: 3, avgYield: 0.058, demand: 7.8, appreciation: 0.052 },
  ];

  const microLocationInsights = [
    { location: "City Center - District A", yield: 0.082, demand: "High", trend: "up", factors: ["Transit access", "Schools", "Amenities"] },
    { location: "Suburban - Zone B", yield: 0.068, demand: "Medium", trend: "stable", factors: ["Family-friendly", "Parking", "Green spaces"] },
    { location: "Industrial - Zone C", yield: 0.091, demand: "Low", trend: "up", factors: ["Commercial growth", "Infrastructure", "Zoning changes"] },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Geospatial Heatmaps Dashboard</h1>
          <p className="text-gray-600 mt-1">Location intelligence powered by Google Maps Platform</p>
        </div>
        <div className="flex gap-3">
          <select 
            value={selectedHeatmap} 
            onChange={(e) => setSelectedHeatmap(e.target.value as "yield" | "demand" | "appreciation")}
            className="px-4 py-2 border border-gray-300 rounded-lg bg-white"
          >
            <option value="yield">Rental Yield</option>
            <option value="demand">Demand Density</option>
            <option value="appreciation">Capital Appreciation</option>
          </select>
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> Export Map
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
            <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
              <Thermometer className="w-5 h-5 text-red-600" /> Interactive Heatmap
            </h2>
            <div className="flex gap-2">
              {heatmapTypes.map((type) => (
                <button 
                  key={type.id}
                  onClick={() => setSelectedHeatmap(type.id as "yield" | "demand" | "appreciation")}
                  className={`px-3 py-1 rounded-lg text-sm ${selectedHeatmap === type.id ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-gray-600"}`}
                >
                  {type.name}
                </button>
              ))}
            </div>
          </div>
          <div className="h-96 bg-gradient-to-br from-slate-900 to-slate-800 rounded-lg flex items-center justify-center relative overflow-hidden">
            <div className="text-center text-white">
              <Map className="w-16 h-16 mx-auto mb-4 text-blue-400" />
              <p className="text-lg font-semibold">Interactive Geospatial Heatmap</p>
              <p className="text-sm text-slate-400 mt-2">Powered by Google Maps Platform & Places API</p>
              <div className="mt-4 flex gap-2 justify-center">
                <span className="px-2 py-1 bg-blue-500/20 text-blue-400 rounded text-xs">Yield Analysis</span>
                <span className="px-2 py-1 bg-green-500/20 text-green-400 rounded text-xs">Demand Density</span>
                <span className="px-2 py-1 bg-orange-500/20 text-orange-400 rounded text-xs">Appreciation</span>
              </div>
            </div>
            <div className="absolute bottom-4 left-4 flex gap-2">
              <button className="p-2 bg-slate-700 rounded-lg text-white hover:bg-slate-600"><Layers className="w-4 h-4" /></button>
              <button className="p-2 bg-slate-700 rounded-lg text-white hover:bg-slate-600"><Navigation className="w-4 h-4" /></button>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
            <Globe className="w-5 h-5 text-blue-600" /> Regional Overview
          </h2>
          <div className="space-y-3">
            {regionalData.map((region, i) => (
              <div key={i} className="p-4 bg-gray-50 rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-medium text-gray-900">{region.region}</span>
                  <span className="text-sm text-gray-600">{region.countries} countries</span>
                </div>
                <div className="grid grid-cols-3 gap-2 text-sm">
                  <div>
                    <p className="text-gray-600">Yield</p>
                    <p className="font-medium">{formatPercent(region.avgYield)}</p>
                  </div>
                  <div>
                    <p className="text-gray-600">Demand</p>
                    <p className="font-medium">{region.demand.toFixed(1)}</p>
                  </div>
                  <div>
                    <p className="text-gray-600">Appreciation</p>
                    <p className="font-medium">{formatPercent(region.appreciation)}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <Target className="w-5 h-5 text-purple-600" /> Micro-Location Insights
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Filter className="w-4 h-4 text-gray-500" /></button>
        </div>
        <div className="space-y-3">
          {microLocationInsights.map((insight, i) => (
            <div key={i} className="p-4 bg-purple-50 rounded-lg border border-purple-200">
              <div className="flex items-center justify-between mb-2">
                <div className="flex items-center gap-2">
                  <Navigation className="w-4 h-4 text-purple-600" />
                  <span className="font-medium text-purple-900">{insight.location}</span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-sm font-bold text-purple-900">{formatPercent(insight.yield)}</span>
                  {insight.trend === "up" ? <TrendingUp className="w-4 h-4 text-green-600" /> : <Activity className="w-4 h-4 text-gray-600" />}
                </div>
              </div>
              <div className="flex items-center justify-between text-sm mb-2">
                <span className={`px-2 py-1 rounded-full ${
                  insight.demand === "High" ? "bg-red-100 text-red-700" : insight.demand === "Medium" ? "bg-yellow-100 text-yellow-700" : "bg-green-100 text-green-700"
                }`}>{insight.demand} Demand</span>
              </div>
              <div className="flex gap-2">
                {insight.factors.map((factor, j) => (
                  <span key={j} className="text-xs px-2 py-1 bg-purple-100 text-purple-700 rounded">{factor}</span>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <Zap className="w-5 h-5 text-yellow-600" /> Google Maps Integration Status
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-gray-500" /></button>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-green-50 rounded-lg border border-green-200">
            <div className="flex items-center gap-2 mb-2">
              <Map className="w-5 h-5 text-green-600" />
              <span className="font-medium text-green-900">Places API</span>
            </div>
            <p className="text-sm text-green-700">Proximity scoring and location analysis</p>
            <div className="mt-2 text-xs text-green-600">✓ Connected</div>
          </div>
          <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
            <div className="flex items-center gap-2 mb-2">
              <Thermometer className="w-5 h-5 text-blue-600" />
              <span className="font-medium text-blue-900">Solar API</span>
            </div>
            <p className="text-sm text-blue-700">Energy efficiency and solar potential</p>
            <div className="mt-2 text-xs text-blue-600">✓ Connected</div>
          </div>
          <div className="p-4 bg-orange-50 rounded-lg border border-orange-200">
            <div className="flex items-center gap-2 mb-2">
              <Layers className="w-5 h-5 text-orange-600" />
              <span className="font-medium text-orange-900">3D Tiles</span>
            </div>
            <p className="text-sm text-orange-700">3D building models and visualization</p>
            <div className="mt-2 text-xs text-orange-600">✓ Connected</div>
          </div>
        </div>
      </div>
    </div>
  );
}
