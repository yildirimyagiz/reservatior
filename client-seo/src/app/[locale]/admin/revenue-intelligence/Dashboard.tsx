"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { revenueIntelligenceApi } from "@/lib/api/revenue-intelligence";
import { 
  DollarSign,
  TrendingUp,
  Target,
  BarChart3,
  Activity,
  Zap,
  Brain,
  ArrowUpRight,
  ArrowDownRight,
  Calendar,
  Building2,
  Settings,
  Download,
  Filter,
  LineChart
} from "lucide-react";

export default function RevenueIntelligenceDashboard() {
  const { user } = useAuth();
  const { language, currency } = useLocalization();
  const orgId = user?.organizationId || "";
  const [timeRange, setTimeRange] = useState<"7d" | "30d" | "90d" | "1y">("30d");
  const [selectedMetric, setSelectedMetric] = useState<"noi" | "yield" | "arbitrage">("noi");

  const { data: revenueStats, isLoading } = useQuery({
    queryKey: ["revenue-intelligence-dashboard", orgId, timeRange],
    queryFn: () => revenueIntelligenceApi.getStats(orgId, timeRange),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) => 
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatPercent = (val: number) => `${val.toFixed(1)}%`;

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = revenueStats || {
    totalRevenue: 0,
    netOperatingIncome: 0,
    yieldArbitrage: 0,
    revenueAttribution: 0,
    avgOccupancy: 0,
    revenueGrowth: 0,
    predictedRevenue: 0,
    optimizationPotential: 0,
  };

  const kpis = [
    { title: "Total Revenue", value: formatCurrency(stats.totalRevenue), icon: DollarSign, color: "text-blue-600", trend: "+15.2%" },
    { title: "Net Operating Income", value: formatCurrency(stats.netOperatingIncome), icon: TrendingUp, color: "text-green-600", trend: "+12.8%" },
    { title: "Yield Arbitrage", value: formatPercent(stats.yieldArbitrage), icon: Target, color: "text-purple-600", trend: "+8.5%" },
    { title: "Revenue Attribution", value: formatPercent(stats.revenueAttribution), icon: BarChart3, color: "text-orange-600", trend: "+22.3%" },
    { title: "Avg Occupancy", value: formatPercent(stats.avgOccupancy), icon: Building2, color: "text-indigo-600", trend: "+3.2%" },
    { title: "Revenue Growth", value: formatPercent(stats.revenueGrowth), icon: Activity, color: "text-pink-600", trend: "+18.7%" },
  ];

  const revenueStreams = [
    { name: "Direct Bookings", value: 45, trend: "+12%", color: "bg-blue-500" },
    { name: "Channel Partners", value: 32, trend: "+8%", color: "bg-green-500" },
    { name: "Corporate Contracts", value: 15, trend: "+15%", color: "bg-purple-500" },
    { name: "Long-term Rentals", value: 8, trend: "+5%", color: "bg-orange-500" },
  ];

  const optimizationOpportunities = [
    { name: "Dynamic Pricing", potential: "+18%", impact: "High", effort: "Medium" },
    { name: "Channel Optimization", potential: "+12%", impact: "Medium", effort: "Low" },
    { name: "Yield Arbitrage", potential: "+8%", impact: "High", effort: "High" },
    { name: "Occupancy Boost", potential: "+6%", impact: "Medium", effort: "Medium" },
  ];

  const predictiveInsights = [
    { metric: "Next Month Revenue", predicted: formatCurrency(stats.predictedRevenue), confidence: 92, trend: "up" },
    { metric: "Q3 Forecast", predicted: formatCurrency(stats.predictedRevenue * 3), confidence: 87, trend: "up" },
    { metric: "Annual Projection", predicted: formatCurrency(stats.predictedRevenue * 12), confidence: 81, trend: "up" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Revenue Intelligence Dashboard</h1>
          <p className="text-gray-600 mt-1">AI-powered revenue optimization and predictive analytics</p>
        </div>
        <div className="flex gap-3">
          <select 
            value={timeRange} 
            onChange={(e) => setTimeRange(e.target.value as any)}
            className="px-4 py-2 border border-gray-300 rounded-lg bg-white"
          >
            <option value="7d">Last 7 Days</option>
            <option value="30d">Last 30 Days</option>
            <option value="90d">Last 90 Days</option>
            <option value="1y">Last Year</option>
          </select>
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> Export Report
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
              <Brain className="w-5 h-5 text-purple-600" /> NOI Optimization Analysis
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-gray-500" /></button>
          </div>
          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div className="p-4 bg-green-50 rounded-lg border border-green-200">
                <p className="text-sm text-gray-600">Current NOI</p>
                <p className="text-xl font-bold text-green-700">{formatCurrency(stats.netOperatingIncome)}</p>
              </div>
              <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
                <p className="text-sm text-gray-600">Optimization Potential</p>
                <p className="text-xl font-bold text-blue-700">{formatPercent(stats.optimizationPotential)}</p>
              </div>
            </div>
            <div className="space-y-2">
              <p className="text-sm font-medium text-gray-700">AI Recommendations:</p>
              <div className="p-3 bg-purple-50 rounded-lg border border-purple-200">
                <div className="flex items-center gap-2 mb-1">
                  <Zap className="w-4 h-4 text-purple-600" />
                  <span className="font-medium text-purple-900">Dynamic Pricing Adjustment</span>
                </div>
                <p className="text-sm text-purple-700">Increase weekend rates by 15% based on demand patterns</p>
              </div>
              <div className="p-3 bg-blue-50 rounded-lg border border-blue-200">
                <div className="flex items-center gap-2 mb-1">
                  <Target className="w-4 h-4 text-blue-600" />
                  <span className="font-medium text-blue-900">Expense Optimization</span>
                </div>
                <p className="text-sm text-blue-700">Reduce maintenance costs by 8% through predictive scheduling</p>
              </div>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
              <LineChart className="w-5 h-5 text-blue-600" /> Revenue Streams
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Filter className="w-4 h-4 text-gray-500" /></button>
          </div>
          <div className="space-y-3">
            {revenueStreams.map((stream, i) => (
              <div key={i} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
                <div className="flex items-center gap-3">
                  <div className={`w-3 h-3 rounded-full ${stream.color}`} />
                  <span className="font-medium text-gray-900">{stream.name}</span>
                </div>
                <div className="flex items-center gap-4">
                  <span className="text-sm text-gray-600">{stream.value}%</span>
                  <span className="text-sm text-green-600">{stream.trend}</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
              <Activity className="w-5 h-5 text-orange-600" /> Yield Arbitrage Analysis
            </h2>
            <div className="flex gap-2">
              <button className={`px-3 py-1 rounded-lg text-sm ${selectedMetric === "noi" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-gray-600"}`} onClick={() => setSelectedMetric("noi")}>NOI</button>
              <button className={`px-3 py-1 rounded-lg text-sm ${selectedMetric === "yield" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-gray-600"}`} onClick={() => setSelectedMetric("yield")}>Yield</button>
              <button className={`px-3 py-1 rounded-lg text-sm ${selectedMetric === "arbitrage" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-gray-600"}`} onClick={() => setSelectedMetric("arbitrage")}>Arbitrage</button>
            </div>
          </div>
          <div className="h-64 bg-gradient-to-br from-orange-50 to-orange-100 rounded-lg flex items-center justify-center">
            <div className="text-center">
              <LineChart className="w-12 h-12 mx-auto mb-3 text-orange-600" />
              <p className="text-lg font-semibold text-orange-900">Yield Arbitrage Visualization</p>
              <p className="text-sm text-orange-700 mt-1">Cross-market yield comparison and optimization opportunities</p>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
            <Zap className="w-5 h-5 text-yellow-600" /> Optimization Opportunities
          </h2>
          <div className="space-y-3">
            {optimizationOpportunities.map((opp, i) => (
              <div key={i} className="p-4 bg-gray-50 rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-medium text-gray-900">{opp.name}</span>
                  <span className="text-sm font-bold text-green-600">{opp.potential}</span>
                </div>
                <div className="flex items-center gap-2 text-xs">
                  <span className={`px-2 py-1 rounded-full ${
                    opp.impact === "High" ? "bg-red-100 text-red-700" : "bg-yellow-100 text-yellow-700"
                  }`}>{opp.impact} Impact</span>
                  <span className={`px-2 py-1 rounded-full ${
                    opp.effort === "Low" ? "bg-green-100 text-green-700" : opp.effort === "Medium" ? "bg-blue-100 text-blue-700" : "bg-purple-100 text-purple-700"
                  }`}>{opp.effort} Effort</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <Brain className="w-5 h-5 text-indigo-600" /> Predictive Revenue Insights
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Calendar className="w-4 h-4 text-gray-500" /></button>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {predictiveInsights.map((insight, i) => (
            <div key={i} className="p-4 bg-indigo-50 rounded-lg border border-indigo-200">
              <div className="flex items-center justify-between mb-2">
                <span className="text-sm text-gray-600">{insight.metric}</span>
                {insight.trend === "up" ? <ArrowUpRight className="w-4 h-4 text-green-600" /> : <ArrowDownRight className="w-4 h-4 text-red-600" />}
              </div>
              <p className="text-xl font-bold text-indigo-900">{insight.predicted}</p>
              <div className="flex items-center gap-2 mt-2">
                <div className="flex-1 bg-indigo-200 rounded-full h-2">
                  <div className="bg-indigo-600 h-2 rounded-full" style={{ width: `${insight.confidence}%` }} />
                </div>
                <span className="text-xs text-indigo-700">{insight.confidence}% confidence</span>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
