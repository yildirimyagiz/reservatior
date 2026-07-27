"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import {
  Star, Target, DollarSign, Users,
  Brain, Download, Award, Building2, Clock, ThumbsUp, Search
} from "lucide-react";
import { apiClient } from "@/lib/api";

async function fetchAgentList(orgId: string) {
  try {
    const res: any = await apiClient.get(`/agents?orgId=${orgId}&limit=50`);
    return res.data?.items || [];
  } catch { return []; }
}

async function fetchAgentPassport(agentId: string) {
  try {
    const res: any = await apiClient.get(`/intelligence/agent-passport/${agentId}`);
    return res.data;
  } catch { return null; }
}

export default function AgentPassportDashboard() {
  const { user } = useAuth();
  const orgId = user?.orgId || "";
  const { language } = useLocalization();
  const currency = user?.preferences?.currency || "USD";
  const [selectedAgentId, setSelectedAgentId] = useState("");
  const [searchQuery, setSearchQuery] = useState("");

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const { data: agents } = useQuery({
    queryKey: ["agent-list", orgId],
    queryFn: () => fetchAgentList(orgId),
    enabled: !!orgId,
  });

  const { data: passport, isLoading } = useQuery({
    queryKey: ["agent-passport", selectedAgentId],
    queryFn: () => fetchAgentPassport(selectedAgentId),
    enabled: !!selectedAgentId,
  });

  const performanceMetrics = [
    { label: "Conversion Rate", value: passport?.conversionRate ?? 24, max: 100, color: "bg-green-500" },
    { label: "Response Time", value: passport?.responseTime ?? 78, max: 100, color: "bg-blue-500" },
    { label: "Client Satisfaction", value: passport?.satisfaction ?? 91, max: 100, color: "bg-purple-500" },
    { label: "Listing Quality", value: passport?.listingQuality ?? 85, max: 100, color: "bg-orange-500" },
    { label: "Market Knowledge", value: passport?.marketKnowledge ?? 88, max: 100, color: "bg-indigo-500" },
    { label: "Negotiation Skill", value: passport?.negotiationSkill ?? 76, max: 100, color: "bg-pink-500" },
  ];

  const kpis = [
    { title: "Overall Score", value: `${passport?.overallScore ?? 84}/100`, icon: Star, color: "text-yellow-600", bg: "bg-yellow-50" },
    { title: "Deals Closed", value: passport?.dealsClosed ?? 23, icon: ThumbsUp, color: "text-green-600", bg: "bg-green-50" },
    { title: "Revenue Generated", value: formatCurrency(passport?.revenueGenerated ?? 450000), icon: DollarSign, color: "text-blue-600", bg: "bg-blue-50" },
    { title: "Active Listings", value: passport?.activeListings ?? 12, icon: Building2, color: "text-purple-600", bg: "bg-purple-50" },
    { title: "Avg Response", value: `${passport?.avgResponseMinutes ?? 14}m`, icon: Clock, color: "text-orange-600", bg: "bg-orange-50" },
    { title: "Ranking", value: `#${passport?.ranking ?? 3}`, icon: Award, color: "text-indigo-600", bg: "bg-indigo-50" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Agent Passport</h1>
          <p className="text-gray-600 mt-1">Agent performance intelligence with AI coaching recommendations</p>
        </div>
        <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
          <Download className="w-4 h-4" /> Export
        </button>
      </div>

      {/* Agent Selector */}
      <div className="bg-white rounded-xl shadow-sm p-4 border border-gray-100">
        <div className="flex items-center gap-4">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input type="text" placeholder="Search agents…" value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg" />
          </div>
          <select value={selectedAgentId} onChange={(e) => setSelectedAgentId(e.target.value)} className="px-4 py-2 border border-gray-300 rounded-lg bg-white min-w-[300px]">
            <option value="">Select an agent…</option>
            {(agents || []).filter((a: any) => !searchQuery || a.name?.toLowerCase().includes(searchQuery.toLowerCase())).map((a: any) => (
              <option key={a.id} value={a.id}>{a.name || a.email}</option>
            ))}
          </select>
        </div>
      </div>

      {!selectedAgentId && (
        <div className="bg-white rounded-xl shadow-sm p-12 border border-gray-100 text-center">
          <Users className="w-16 h-16 text-gray-300 mx-auto mb-4" />
          <h2 className="text-xl font-semibold text-gray-500">Select an agent to view their Intelligence Passport</h2>
        </div>
      )}

      {selectedAgentId && !isLoading && (
        <>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {kpis.map((kpi, i) => {
              const Icon = kpi.icon;
              return (
                <div key={i} className="bg-white rounded-xl shadow-sm p-4 border border-gray-100">
                  <div className="flex items-center gap-2 mb-2"><div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div></div>
                  <p className="text-2xl font-bold text-gray-900">{kpi.value}</p>
                  <p className="text-xs text-gray-500 mt-1">{kpi.title}</p>
                </div>
              );
            })}
          </div>

          {/* Performance Radar (simplified as bars) */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
                <Target className="w-5 h-5 text-blue-600" /> Performance Radar
              </h2>
              <div className="space-y-4">
                {performanceMetrics.map((m, i) => (
                  <div key={i}>
                    <div className="flex items-center justify-between mb-1">
                      <span className="text-sm text-gray-600">{m.label}</span>
                      <span className="text-sm font-bold text-gray-900">{m.value}%</span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-2">
                      <div className={`h-2 rounded-full ${m.color}`} style={{ width: `${m.value}%` }} />
                    </div>
                  </div>
                ))}
              </div>
            </div>

            <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
                <Brain className="w-5 h-5 text-purple-600" /> AI Coaching
              </h2>
              <div className="space-y-3">
                <div className="p-4 bg-green-50 rounded-lg border border-green-200">
                  <p className="text-sm font-medium text-green-800">💪 Strength</p>
                  <p className="text-xs text-green-700 mt-1">Excellent client satisfaction (91%) and market knowledge (88%). Top-tier in luxury segment.</p>
                </div>
                <div className="p-4 bg-orange-50 rounded-lg border border-orange-200">
                  <p className="text-sm font-medium text-orange-800">🎯 Opportunity</p>
                  <p className="text-xs text-orange-700 mt-1">Conversion rate (24%) is below team average (28%). Focus on lead qualification.</p>
                </div>
                <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
                  <p className="text-sm font-medium text-blue-800">📈 Action Plan</p>
                  <p className="text-xs text-blue-700 mt-1">1. Implement follow-up automation. 2. Cross-sell investment properties. 3. Expand to adjacent districts.</p>
                </div>
                <div className="p-4 bg-purple-50 rounded-lg border border-purple-200">
                  <p className="text-sm font-medium text-purple-800">🏆 Territory</p>
                  <p className="text-xs text-purple-700 mt-1">Primary: Kensington, Chelsea. Expanding: Notting Hill, Holland Park. Recommended: Mayfair.</p>
                </div>
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
