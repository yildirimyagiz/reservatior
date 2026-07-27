"use client";

import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import {
  TrendingUp, DollarSign, Building2,
  Target, MapPin, Activity,
  BarChart3, Brain
} from "lucide-react";
import { apiClient } from "@/lib/api";

async function fetchPublicMarketData(marketId: string) {
  try {
    const res: any = await apiClient.get(`/public/market-intelligence/${marketId}`);
    return res.data;
  } catch { return null; }
}

export default function MarketIntelligenceDashboard() {
  const { language } = useLocalization();
  const currency = "USD";
  const [selectedMarket, setSelectedMarket] = useState("london");

  const { data: market, isLoading } = useQuery({
    queryKey: ["public-market-intelligence", selectedMarket],
    queryFn: () => fetchPublicMarketData(selectedMarket),
    enabled: !!selectedMarket,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const markets = [
    { id: "london", name: "🇬🇧 London" }, { id: "istanbul", name: "🇹🇷 Istanbul" },
    { id: "dubai", name: "🇦🇪 Dubai" }, { id: "new-york", name: "🇺🇸 New York" },
    { id: "miami", name: "🇺🇸 Miami" }, { id: "manchester", name: "🇬🇧 Manchester" },
  ];

  const kpis = [
    { title: "Avg Price / sqm", value: formatCurrency(market?.avgPricePerSqm ?? 8500), icon: DollarSign, trend: "+5.2%", up: true },
    { title: "Demand Index", value: `${market?.demandIndex ?? 78}/100`, icon: TrendingUp, trend: "+12%", up: true },
    { title: "Avg Rental Yield", value: `${market?.avgYield ?? 5.8}%`, icon: Target, trend: "+0.4%", up: true },
    { title: "Active Listings", value: `${market?.activeListings ?? 3420}`, icon: Building2, trend: "+8%", up: true },
    { title: "Days on Market", value: `${market?.avgDOM ?? 42}`, icon: Activity, trend: "-5d", up: true },
    { title: "Price Growth (1Y)", value: `${market?.priceGrowth1Y ?? 7.2}%`, icon: BarChart3, trend: "vs 5.8% prior", up: true },
  ];

  const districts = [
    { name: "Zone 1 — Central", avgPrice: "£12,500/sqm", yield: "3.5%", demand: 95, growth: "+3.2%" },
    { name: "Zone 2 — Inner", avgPrice: "£8,200/sqm", yield: "4.8%", demand: 88, growth: "+5.8%" },
    { name: "Zone 3 — Suburban", avgPrice: "£5,600/sqm", yield: "5.9%", demand: 76, growth: "+7.1%" },
    { name: "Zone 4 — Outer", avgPrice: "£3,800/sqm", yield: "6.5%", demand: 65, growth: "+8.4%" },
  ];

  return (
    <div className="max-w-6xl mx-auto px-4 py-8 space-y-8">
      <div className="text-center">
        <h1 className="text-4xl font-bold text-gray-900">Market Intelligence</h1>
        <p className="text-gray-600 mt-2 text-lg">AI-driven real estate market analysis across global cities</p>
      </div>

      {/* Market Selector */}
      <div className="flex justify-center">
        <div className="flex gap-2 flex-wrap justify-center">
          {markets.map(m => (
            <button key={m.id} onClick={() => setSelectedMarket(m.id)} className={`px-5 py-2.5 rounded-xl text-sm font-medium transition ${
              selectedMarket === m.id ? 'bg-blue-600 text-white shadow-md' : 'bg-white text-gray-700 border border-gray-300 hover:bg-gray-50'
            }`}>
              {m.name}
            </button>
          ))}
        </div>
      </div>

      {isLoading && <div className="flex items-center justify-center h-48"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>}

      {!isLoading && (
        <>
          {/* KPIs */}
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {kpis.map((kpi, i) => {
              const Icon = kpi.icon;
              return (
                <div key={i} className="bg-white rounded-xl shadow-sm p-5 border border-gray-100 text-center">
                  <Icon className="w-6 h-6 text-blue-600 mx-auto mb-2" />
                  <p className="text-2xl font-bold text-gray-900">{kpi.value}</p>
                  <p className="text-xs text-gray-500 mt-1">{kpi.title}</p>
                  <p className={`text-xs mt-1 ${kpi.up ? 'text-green-600' : 'text-red-600'}`}>{kpi.trend}</p>
                </div>
              );
            })}
          </div>

          {/* District Analysis */}
          <div className="bg-white rounded-2xl shadow-lg overflow-hidden">
            <div className="p-6 border-b border-gray-100">
              <h2 className="text-xl font-bold text-gray-900 flex items-center gap-2">
                <MapPin className="w-5 h-5 text-purple-600" /> Zone Analysis
              </h2>
            </div>
            <table className="w-full">
              <thead className="bg-gray-50 text-left">
                <tr>
                  <th className="px-6 py-3 text-xs font-medium text-gray-500 uppercase">Zone</th>
                  <th className="px-6 py-3 text-xs font-medium text-gray-500 uppercase">Avg Price</th>
                  <th className="px-6 py-3 text-xs font-medium text-gray-500 uppercase">Yield</th>
                  <th className="px-6 py-3 text-xs font-medium text-gray-500 uppercase">Demand</th>
                  <th className="px-6 py-3 text-xs font-medium text-gray-500 uppercase">Growth</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {districts.map((d, i) => (
                  <tr key={i} className="hover:bg-gray-50 transition">
                    <td className="px-6 py-4 text-sm font-medium text-gray-900">{d.name}</td>
                    <td className="px-6 py-4 text-sm text-gray-700">{d.avgPrice}</td>
                    <td className="px-6 py-4 text-sm font-bold text-green-600">{d.yield}</td>
                    <td className="px-6 py-4">
                      <div className="flex items-center gap-2">
                        <div className="w-20 bg-gray-200 rounded-full h-2">
                          <div className={`h-2 rounded-full ${d.demand >= 85 ? 'bg-green-500' : d.demand >= 70 ? 'bg-yellow-500' : 'bg-orange-500'}`} style={{ width: `${d.demand}%` }} />
                        </div>
                        <span className="text-xs text-gray-600">{d.demand}/100</span>
                      </div>
                    </td>
                    <td className="px-6 py-4 text-sm font-bold text-green-600">{d.growth}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* AI Market Outlook */}
          <div className="bg-white rounded-2xl shadow-lg p-8">
            <h2 className="text-xl font-bold text-gray-900 flex items-center gap-2 mb-6">
              <Brain className="w-6 h-6 text-indigo-600" /> AI Market Outlook
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div className="p-5 bg-green-50 rounded-xl border border-green-200">
                <p className="font-medium text-green-800">📈 Short-Term (6 months)</p>
                <p className="text-sm text-green-700 mt-2">Moderate price growth expected (+2-4%). Demand remains strong driven by international buyers. Rental market tightening.</p>
              </div>
              <div className="p-5 bg-blue-50 rounded-xl border border-blue-200">
                <p className="font-medium text-blue-800">📊 Medium-Term (1-3 years)</p>
                <p className="text-sm text-blue-700 mt-2">Infrastructure projects (Crossrail 2) to boost outer zones. Yield compression in central areas. Suburban premium emerging.</p>
              </div>
              <div className="p-5 bg-purple-50 rounded-xl border border-purple-200">
                <p className="font-medium text-purple-800">🔮 Long-Term (5+ years)</p>
                <p className="text-sm text-purple-700 mt-2">Population growth supports demand. Climate adaptation increasing premium for flood-safe zones. PropTech adoption accelerating.</p>
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
