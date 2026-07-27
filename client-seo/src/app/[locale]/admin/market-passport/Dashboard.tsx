"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import {
  Globe, TrendingUp, TrendingDown, DollarSign, Building2, BarChart3,
  ArrowUpRight, ArrowDownRight, Activity, Target, MapPin, Users,
  Download, Zap, Eye, Star
} from "lucide-react";
import { apiClient } from "@/lib/api";

async function fetchMarketPassport(orgId: string, marketId: string) {
  try {
    const res: any = await apiClient.get(`/intelligence/market-passport/${marketId}`);
    return res.data;
  } catch { return null; }
}

export default function MarketPassportDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const currency = user?.preferences?.currency || "USD";
  const orgId = user?.orgId || "";
  const [selectedMarket, setSelectedMarket] = useState("london");

  const { data: passport, isLoading } = useQuery({
    queryKey: ["market-passport", selectedMarket],
    queryFn: () => fetchMarketPassport(orgId, selectedMarket),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const markets = [
    { id: "london", name: "London" }, { id: "manchester", name: "Manchester" },
    { id: "istanbul", name: "Istanbul" }, { id: "dubai", name: "Dubai" },
    { id: "new-york", name: "New York" }, { id: "miami", name: "Miami" },
  ];

  const kpis = [
    { title: "Avg Price/sqm", value: formatCurrency(passport?.avgPricePerSqm ?? 8500), icon: DollarSign, color: "text-blue-600", bg: "bg-blue-50", trend: "+5.2%" },
    { title: "Demand Index", value: `${passport?.demandIndex ?? 78}/100`, icon: TrendingUp, color: "text-green-600", bg: "bg-green-50", trend: "+12.3%" },
    { title: "Supply Ratio", value: `${passport?.supplyRatio ?? 0.65}`, icon: Building2, color: "text-purple-600", bg: "bg-purple-50", trend: "-3.1%" },
    { title: "Avg Yield", value: `${passport?.avgYield ?? 5.8}%`, icon: Target, color: "text-orange-600", bg: "bg-orange-50", trend: "+0.4%" },
    { title: "Active Listings", value: passport?.activeListings ?? 3420, icon: Eye, color: "text-indigo-600", bg: "bg-indigo-50", trend: "+8%" },
    { title: "Avg DOM", value: `${passport?.avgDaysOnMarket ?? 42}d`, icon: Activity, color: "text-pink-600", bg: "bg-pink-50", trend: "-5d" },
  ];

  const districtData = [
    { name: "Kensington", avgPrice: "£1.2M", yield: "3.8%", demand: 92, trend: "up" },
    { name: "Shoreditch", avgPrice: "£650K", yield: "5.2%", demand: 88, trend: "up" },
    { name: "Canary Wharf", avgPrice: "£580K", yield: "5.8%", demand: 75, trend: "stable" },
    { name: "Brixton", avgPrice: "£420K", yield: "6.1%", demand: 82, trend: "up" },
    { name: "Chelsea", avgPrice: "£1.8M", yield: "3.2%", demand: 70, trend: "down" },
    { name: "Greenwich", avgPrice: "£380K", yield: "6.5%", demand: 78, trend: "up" },
  ];

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Market Passport</h1>
          <p className="text-gray-600 mt-1">Market-level intelligence with demand, supply, and yield analysis</p>
        </div>
        <div className="flex gap-3">
          <select value={selectedMarket} onChange={(e) => setSelectedMarket(e.target.value)} className="px-4 py-2 border border-gray-300 rounded-lg bg-white">
            {markets.map(m => <option key={m.id} value={m.id}>{m.name}</option>)}
          </select>
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> Export
          </button>
        </div>
      </div>

      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-white rounded-xl shadow-sm p-4 border border-gray-100">
              <div className="flex items-center gap-2 mb-2"><div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div></div>
              <p className="text-2xl font-bold text-gray-900">{kpi.value}</p>
              <div className="flex items-center gap-1 mt-1">
                <span className={`text-xs ${kpi.trend.startsWith('+') || kpi.trend.startsWith('-') && !kpi.trend.includes('d') ? 'text-green-600' : 'text-gray-500'}`}>{kpi.trend}</span>
              </div>
              <p className="text-xs text-gray-500">{kpi.title}</p>
            </div>
          );
        })}
      </div>

      {/* District Comparison */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="p-4 border-b border-gray-100">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <MapPin className="w-5 h-5 text-purple-600" /> District Intelligence
          </h2>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 text-left">
              <tr>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">District</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Avg Price</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Yield</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Demand</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Trend</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {districtData.map((d, i) => (
                <tr key={i} className="hover:bg-gray-50 transition">
                  <td className="px-4 py-3 text-sm font-medium text-gray-900">{d.name}</td>
                  <td className="px-4 py-3 text-sm text-gray-700">{d.avgPrice}</td>
                  <td className="px-4 py-3 text-sm text-gray-700">{d.yield}</td>
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-2">
                      <div className="w-16 bg-gray-200 rounded-full h-1.5">
                        <div className={`h-1.5 rounded-full ${d.demand >= 85 ? 'bg-green-500' : d.demand >= 70 ? 'bg-yellow-500' : 'bg-red-500'}`} style={{ width: `${d.demand}%` }} />
                      </div>
                      <span className="text-xs">{d.demand}</span>
                    </div>
                  </td>
                  <td className="px-4 py-3">
                    {d.trend === "up" ? <ArrowUpRight className="w-4 h-4 text-green-600" /> :
                     d.trend === "down" ? <ArrowDownRight className="w-4 h-4 text-red-600" /> :
                     <Activity className="w-4 h-4 text-gray-400" />}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Market Health + Strategy */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
            <Zap className="w-5 h-5 text-orange-600" /> Market Health Score
          </h2>
          <div className="grid grid-cols-2 gap-4">
            {[
              { label: "Liquidity", score: 82, color: "bg-green-500" },
              { label: "Stability", score: 74, color: "bg-blue-500" },
              { label: "Growth Potential", score: 88, color: "bg-purple-500" },
              { label: "Risk", score: 35, color: "bg-red-500" },
            ].map((h, i) => (
              <div key={i} className="p-3 bg-gray-50 rounded-lg">
                <p className="text-sm text-gray-600">{h.label}</p>
                <div className="flex items-center gap-2 mt-1">
                  <div className="flex-1 bg-gray-200 rounded-full h-2">
                    <div className={`h-2 rounded-full ${h.color}`} style={{ width: `${h.score}%` }} />
                  </div>
                  <span className="text-sm font-bold">{h.score}</span>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
            <Star className="w-5 h-5 text-yellow-500" /> AI Marketing Strategy
          </h2>
          <div className="space-y-3">
            <div className="p-3 bg-blue-50 rounded-lg border border-blue-200">
              <p className="text-sm font-medium text-blue-800">Target Audience</p>
              <p className="text-xs text-blue-600 mt-1">Young professionals (25-35), remote workers, international investors</p>
            </div>
            <div className="p-3 bg-green-50 rounded-lg border border-green-200">
              <p className="text-sm font-medium text-green-800">Recommended Channels</p>
              <p className="text-xs text-green-600 mt-1">Google Ads, Instagram, LinkedIn, Property portals</p>
            </div>
            <div className="p-3 bg-purple-50 rounded-lg border border-purple-200">
              <p className="text-sm font-medium text-purple-800">Content Focus</p>
              <p className="text-xs text-purple-600 mt-1">Investment returns, lifestyle benefits, transport connectivity</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
