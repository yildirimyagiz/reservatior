"use client";

import { useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { attributionApi } from "@/lib/api/attribution";
import { 
  Target,
  DollarSign,
  BarChart3,
  Activity,
  Link,
  CheckCircle,
  Clock,
  Globe,
  Zap,
  Settings,
  Download,
  Filter,
  LineChart
} from "lucide-react";

export default function AttributionDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const [selectedChannel, setSelectedChannel] = useState<"all" | "google" | "meta" | "organic">("all");

  const { data: attributionStats, isLoading } = useQuery({
    queryKey: ["attribution-dashboard", orgId, selectedChannel],
    queryFn: () => attributionApi.getStats(orgId, "30d", selectedChannel),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) => 
    new Intl.NumberFormat(language, { style: 'currency', currency: 'USD', maximumFractionDigits: 0 } as any).format(val);
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatPercent = (val: number) => `${val.toFixed(1)}%`;

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = attributionStats || {
    attributedRevenue: 0,
    attributionAccuracy: 0,
    totalConversions: 0,
    avgAttributionTime: 0,
    capiMatchRate: 0,
    offlineAttribution: 0,
  };

  const kpis = [
    { title: "Attributed Revenue", value: formatCurrency(stats.attributedRevenue), icon: DollarSign, color: "text-blue-600", trend: "+22.5%" },
    { title: "Attribution Accuracy", value: formatPercent(stats.attributionAccuracy), icon: Target, color: "text-green-600", trend: "+5.3%" },
    { title: "Total Conversions", value: formatNumber(stats.totalConversions), icon: CheckCircle, color: "text-purple-600", trend: "+18.7%" },
    { title: "Avg Attribution Time", value: `${stats.avgAttributionTime}h`, icon: Clock, color: "text-orange-600", trend: "-12.2%" },
    { title: "CAPI Match Rate", value: formatPercent(stats.capiMatchRate), icon: Link, color: "text-indigo-600", trend: "+8.4%" },
    { title: "Offline Attribution", value: formatPercent(stats.offlineAttribution), icon: Activity, color: "text-pink-600", trend: "+15.1%" },
  ];

  const attributionChannels = [
    { name: "Google Ads CAPI", revenue: 145000, conversions: 234, matchRate: 0.92, status: "connected" },
    { name: "Meta Ads CAPI", revenue: 98000, conversions: 189, matchRate: 0.88, status: "connected" },
    { name: "Organic Traffic", revenue: 67000, conversions: 145, matchRate: 0.95, status: "active" },
    { name: "Direct Traffic", revenue: 45000, conversions: 87, matchRate: 0.82, status: "active" },
  ];

  const attributionJourney = [
    { step: "Ad Click", time: "0s", channel: "Google Ads", status: "completed" },
    { step: "Landing Page", time: "2s", channel: "Website", status: "completed" },
    { step: "Property View", time: "45s", channel: "Website", status: "completed" },
    { step: "Lead Form", time: "3m", channel: "Website", status: "completed" },
    { step: "Contract Signed", time: "5d", channel: "Offline", status: "completed" },
    { step: "Revenue Attributed", time: "5d", channel: "CAPI", status: "completed" },
  ];

  const offlineConversions = [
    { id: "conv-1", property: "Property #123", value: 45000, source: "Google Ads", date: "2024-01-15", status: "attributed" },
    { id: "conv-2", property: "Property #456", value: 78000, source: "Meta Ads", date: "2024-01-18", status: "attributed" },
    { id: "conv-3", property: "Property #789", value: 32000, source: "Organic", date: "2024-01-20", status: "pending" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Closed-Loop Attribution Dashboard</h1>
          <p className="text-gray-600 mt-1">Revenue attribution tracking with CAPI integration</p>
        </div>
        <div className="flex gap-3">
          <select 
            value={selectedChannel} 
            onChange={(e) => setSelectedChannel(e.target.value as "all" | "google" | "meta" | "organic")}
            className="px-4 py-2 border border-gray-300 rounded-lg bg-white"
          >
            <option value="all">All Channels</option>
            <option value="google">Google Ads</option>
            <option value="meta">Meta Ads</option>
            <option value="organic">Organic</option>
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
              <Link className="w-5 h-5 text-blue-600" /> CAPI Integration Status
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-gray-500" /></button>
          </div>
          <div className="space-y-3">
            {attributionChannels.map((channel, i) => (
              <div key={i} className="p-4 bg-gray-50 rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-3">
                    <Globe className="w-5 h-5 text-gray-600" />
                    <span className="font-medium text-gray-900">{channel.name}</span>
                    <span className={`text-xs px-2 py-1 rounded-full ${
                      channel.status === "connected" ? "bg-green-100 text-green-700" : "bg-blue-100 text-blue-700"
                    }`}>{channel.status}</span>
                  </div>
                  <span className="text-sm font-bold text-gray-900">{formatCurrency(channel.revenue)}</span>
                </div>
                <div className="grid grid-cols-2 gap-2 text-sm">
                  <div>
                    <p className="text-gray-600">Conversions</p>
                    <p className="font-medium">{channel.conversions}</p>
                  </div>
                  <div>
                    <p className="text-gray-600">Match Rate</p>
                    <p className="font-medium">{formatPercent(channel.matchRate)}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
              <Zap className="w-5 h-5 text-yellow-600" /> Attribution Journey
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Filter className="w-4 h-4 text-gray-500" /></button>
          </div>
          <div className="space-y-2">
            {attributionJourney.map((step, i) => (
              <div key={i} className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
                <div className={`w-8 h-8 rounded-full flex items-center justify-center ${
                  step.status === "completed" ? "bg-green-100 text-green-700" : "bg-yellow-100 text-yellow-700"
                }`}>
                  {step.status === "completed" ? <CheckCircle className="w-4 h-4" /> : <Clock className="w-4 h-4" />}
                </div>
                <div className="flex-1">
                  <div className="flex items-center justify-between">
                    <span className="font-medium text-gray-900">{step.step}</span>
                    <span className="text-sm text-gray-600">{step.time}</span>
                  </div>
                  <p className="text-xs text-gray-500">{step.channel}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <Activity className="w-5 h-5 text-purple-600" /> Offline Conversions Attribution
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Download className="w-4 h-4 text-gray-500" /></button>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="border-b border-gray-200">
                <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Property</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Value</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Source</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Date</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Status</th>
              </tr>
            </thead>
            <tbody>
              {offlineConversions.map((conv) => (
                <tr key={conv.id} className="border-b border-gray-100">
                  <td className="py-3 px-4 text-sm font-medium text-gray-900">{conv.property}</td>
                  <td className="py-3 px-4 text-sm text-gray-900">{formatCurrency(conv.value)}</td>
                  <td className="py-3 px-4 text-sm text-gray-600">{conv.source}</td>
                  <td className="py-3 px-4 text-sm text-gray-600">{conv.date}</td>
                  <td className="py-3 px-4">
                    <span className={`text-xs px-2 py-1 rounded-full ${
                      conv.status === "attributed" ? "bg-green-100 text-green-700" : "bg-yellow-100 text-yellow-700"
                    }`}>{conv.status}</span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <LineChart className="w-5 h-5 text-indigo-600" /> Revenue Attribution Trend
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-gray-500" /></button>
        </div>
        <div className="h-64 bg-gradient-to-br from-indigo-50 to-indigo-100 rounded-lg flex items-center justify-center">
          <div className="text-center">
            <BarChart3 className="w-12 h-12 mx-auto mb-3 text-indigo-600" />
            <p className="text-lg font-semibold text-indigo-900">Revenue Attribution Visualization</p>
            <p className="text-sm text-indigo-700 mt-1">Cross-channel revenue attribution over time</p>
          </div>
        </div>
      </div>
    </div>
  );
}
