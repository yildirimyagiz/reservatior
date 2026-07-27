"use client";
import { useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { 
  Megaphone,
  Play,
  Pause,
  TrendingUp,
  DollarSign,
  Target,
  BarChart3,
  Globe,
  Zap,
  Activity,
  ArrowUpRight,
  ArrowDownRight,
  Settings,
  Download,
  Filter,
  Network,
  Layers,
  PieChart
} from "lucide-react";

export default function AdsOSDashboard() {
  const { user } = useAuth();
  const { language, currency } = useLocalization();
  const orgId = user?.organizationId || "";
  const [timeRange, setTimeRange] = useState<"7d" | "30d" | "90d">("30d");
  const [selectedNetwork, setSelectedNetwork] = useState<"all" | "google" | "meta" | "tiktok">("all");

  const { data: adsStats, isLoading } = useQuery({
    queryKey: ["ads-os-dashboard", orgId, timeRange, selectedNetwork],
    queryFn: () => fetchAdsStats(orgId, timeRange, selectedNetwork),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) => 
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatPercent = (val: number) => `${val.toFixed(2)}%`;

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = adsStats || {
    totalCampaigns: 0,
    activeCampaigns: 0,
    pausedCampaigns: 0,
    averageCTR: 0,
    totalSpend: 0,
    totalImpressions: 0,
    totalConversions: 0,
    averageCPET: 0,
    roas: 0,
  };

  const kpis = [
    { title: "Total Campaigns", value: formatNumber(stats.totalCampaigns), icon: Megaphone, color: "text-blue-600", trend: "+12.5%" },
    { title: "Active Campaigns", value: formatNumber(stats.activeCampaigns), icon: Play, color: "text-green-600", trend: "+8.3%" },
    { title: "Total Spend", value: formatCurrency(stats.totalSpend), icon: DollarSign, color: "text-purple-600", trend: "+15.2%" },
    { title: "Avg CTR", value: formatPercent(stats.averageCTR), icon: TrendingUp, color: "text-orange-600", trend: "+2.1%" },
    { title: "Total Conversions", value: formatNumber(stats.totalConversions), icon: Target, color: "text-indigo-600", trend: "+18.7%" },
    { title: "ROAS", value: stats.roas.toFixed(2), icon: BarChart3, color: "text-pink-600", trend: "+5.4%" },
  ];

  const networks = [
    { name: "Google Ads", spend: 45000, conversions: 234, roas: 3.2, cpET: 0.85, status: "active" },
    { name: "Meta Ads", spend: 32000, conversions: 189, roas: 2.8, cpET: 0.92, status: "active" },
    { name: "TikTok Ads", spend: 18000, conversions: 87, roas: 2.1, cpET: 1.15, status: "active" },
    { name: "LinkedIn Ads", spend: 12000, conversions: 45, roas: 1.8, cpET: 1.45, status: "paused" },
  ];

  const arbitrageOpportunities = [
    { from: "Google Ads", to: "Meta Ads", potential: "+12%", reason: "Lower CPET on Meta" },
    { from: "TikTok Ads", to: "Google Ads", potential: "+8%", reason: "Higher conversion rate on Google" },
    { from: "LinkedIn Ads", to: "Meta Ads", potential: "+15%", reason: "Better ROAS on Meta" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Ads OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Multi-network arbitrage and campaign optimization</p>
        </div>
        <div className="flex gap-3">
          <select 
            value={selectedNetwork} 
            onChange={(e) => setSelectedNetwork(e.target.value as any)}
            className="px-4 py-2 border border-gray-300 rounded-lg bg-white"
          >
            <option value="all">All Networks</option>
            <option value="google">Google Ads</option>
            <option value="meta">Meta Ads</option>
            <option value="tiktok">TikTok Ads</option>
          </select>
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
            <Megaphone className="w-4 h-4" /> Create Campaign
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
              <Network className="w-5 h-5 text-blue-600" /> Multi-Network Performance
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Filter className="w-4 h-4 text-gray-500" /></button>
          </div>
          <div className="space-y-3">
            {networks.map((network, i) => (
              <div key={i} className="p-4 bg-gray-50 rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-3">
                    <Globe className="w-5 h-5 text-gray-600" />
                    <span className="font-medium text-gray-900">{network.name}</span>
                    <span className={`text-xs px-2 py-1 rounded-full ${
                      network.status === "active" ? "bg-green-100 text-green-700" : "bg-yellow-100 text-yellow-700"
                    }`}>{network.status}</span>
                  </div>
                  <span className="text-sm font-bold text-gray-900">{formatCurrency(network.spend)}</span>
                </div>
                <div className="grid grid-cols-3 gap-2 text-sm">
                  <div>
                    <p className="text-gray-600">Conversions</p>
                    <p className="font-medium">{network.conversions}</p>
                  </div>
                  <div>
                    <p className="text-gray-600">ROAS</p>
                    <p className="font-medium">{network.roas.toFixed(1)}x</p>
                  </div>
                  <div>
                    <p className="text-gray-600">CPET</p>
                    <p className="font-medium">{network.cpET.toFixed(2)}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
              <Zap className="w-5 h-5 text-yellow-600" /> Arbitrage Opportunities
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-gray-500" /></button>
          </div>
          <div className="space-y-3">
            {arbitrageOpportunities.map((opp, i) => (
              <div key={i} className="p-4 bg-yellow-50 rounded-lg border border-yellow-200">
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-2">
                    <ArrowUpRight className="w-4 h-4 text-yellow-600" />
                    <span className="font-medium text-yellow-900">{opp.from} → {opp.to}</span>
                  </div>
                  <span className="text-sm font-bold text-green-600">{opp.potential}</span>
                </div>
                <p className="text-sm text-yellow-700">{opp.reason}</p>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <Activity className="w-5 h-5 text-purple-600" /> CPET Optimization Analysis
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Download className="w-4 h-4 text-gray-500" /></button>
        </div>
        <div className="h-64 bg-gradient-to-br from-purple-50 to-purple-100 rounded-lg flex items-center justify-center">
          <div className="text-center">
            <BarChart3 className="w-12 h-12 mx-auto mb-3 text-purple-600" />
            <p className="text-lg font-semibold text-purple-900">CPET Optimization Dashboard</p>
            <p className="text-sm text-purple-700 mt-1">Real-time budget allocation across ad networks</p>
          </div>
        </div>
      </div>
    </div>
  );
}

async function fetchAdsStats(orgId: string, timeRange: string, network: string) {
  return {
    totalCampaigns: 24,
    activeCampaigns: 18,
    pausedCampaigns: 6,
    averageCTR: 0.0234,
    totalSpend: 107000,
    totalImpressions: 2450000,
    totalConversions: 555,
    averageCPET: 0.89,
    roas: 2.8,
  };
}
