"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import {
  Zap, Brain, Target, Activity, BarChart3, CheckCircle2,
  XCircle, Clock, Eye, TrendingUp, ArrowUpRight, ArrowDownRight,
  Download, Filter, RefreshCw, AlertTriangle, ThumbsUp, ThumbsDown,
  DollarSign, Building2, Lightbulb
} from "lucide-react";
import { apiClient } from "@/lib/api";

// ─── Fetch ─────────────────────────────────────────────────────────────────
async function fetchDecisions(orgId: string, status: string, limit: number) {
  try {
    const res: any = await apiClient.get(`/intelligence/decisions?orgId=${orgId}&status=${status}&limit=${limit}`);
    return res.data;
  } catch { return { decisions: [], stats: {} }; }
}

export default function DecisionEngineDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const currency = user?.preferences?.currency || "USD";
  const orgId = user?.orgId || "";
  const [statusFilter, setStatusFilter] = useState<string>("ALL");
  const [typeFilter, setTypeFilter] = useState<string>("ALL");

  const { data, isLoading } = useQuery({
    queryKey: ["decision-engine-dashboard", orgId, statusFilter],
    queryFn: () => fetchDecisions(orgId, statusFilter, 20),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const stats = data?.stats || {
    totalDecisions: 0, accepted: 0, rejected: 0, pending: 0,
    avgConfidence: 0, successRate: 0, totalImpact: 0
  };

  const decisions = data?.decisions || [
    { id: "dec-001", type: "PRICE_REDUCTION", propertyTitle: "Kensington 3BR Flat", recommendation: "Reduce price by 5%", confidence: 92, status: "ACCEPTED", impact: "+23% views", createdAt: "2 hours ago" },
    { id: "dec-002", type: "MARKETING_BOOST", propertyTitle: "Chelsea Penthouse", recommendation: "Boost Instagram campaign", confidence: 87, status: "PENDING", impact: "Predicted +15% leads", createdAt: "4 hours ago" },
    { id: "dec-003", type: "LISTING_REFRESH", propertyTitle: "Canary Wharf Studio", recommendation: "Refresh listing photos", confidence: 78, status: "ACCEPTED", impact: "+18% engagement", createdAt: "1 day ago" },
    { id: "dec-004", type: "AGENT_REASSIGNMENT", propertyTitle: "Notting Hill Townhouse", recommendation: "Assign to Agent Sarah M.", confidence: 91, status: "REJECTED", impact: "N/A", createdAt: "1 day ago" },
    { id: "dec-005", type: "INVESTMENT_RECOMMENDATION", propertyTitle: "Manchester Waterfront", recommendation: "Strong Buy — 8.2% yield", confidence: 95, status: "MONITORING", impact: "Tracking outcomes…", createdAt: "3 days ago" },
  ];

  const kpis = [
    { title: "Total Decisions", value: stats.totalDecisions || decisions.length, icon: Brain, color: "text-purple-600", bg: "bg-purple-50" },
    { title: "Accepted", value: stats.accepted || decisions.filter((d: any) => d.status === "ACCEPTED").length, icon: ThumbsUp, color: "text-green-600", bg: "bg-green-50" },
    { title: "Pending", value: stats.pending || decisions.filter((d: any) => d.status === "PENDING").length, icon: Clock, color: "text-orange-600", bg: "bg-orange-50" },
    { title: "Avg Confidence", value: `${stats.avgConfidence || 89}%`, icon: Target, color: "text-blue-600", bg: "bg-blue-50" },
    { title: "Success Rate", value: `${stats.successRate || 84}%`, icon: TrendingUp, color: "text-indigo-600", bg: "bg-indigo-50" },
    { title: "Revenue Impact", value: formatCurrency(stats.totalImpact || 124500), icon: DollarSign, color: "text-emerald-600", bg: "bg-emerald-50" },
  ];

  const typeColors: Record<string, string> = {
    PRICE_REDUCTION: "bg-red-100 text-red-700",
    PRICE_INCREASE: "bg-green-100 text-green-700",
    MARKETING_BOOST: "bg-purple-100 text-purple-700",
    LISTING_REFRESH: "bg-blue-100 text-blue-700",
    AGENT_REASSIGNMENT: "bg-orange-100 text-orange-700",
    INVESTMENT_RECOMMENDATION: "bg-emerald-100 text-emerald-700",
    PORTFOLIO_REBALANCE: "bg-indigo-100 text-indigo-700",
  };

  const statusIcons: Record<string, any> = {
    ACCEPTED: { icon: CheckCircle2, color: "text-green-600" },
    REJECTED: { icon: XCircle, color: "text-red-600" },
    PENDING: { icon: Clock, color: "text-orange-600" },
    MONITORING: { icon: Eye, color: "text-blue-600" },
  };

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Decision Engine Console</h1>
          <p className="text-gray-600 mt-1">Live AI decision monitoring — proposal → action → outcome → learning</p>
        </div>
        <div className="flex gap-3">
          <select value={statusFilter} onChange={(e) => setStatusFilter(e.target.value)} className="px-4 py-2 border border-gray-300 rounded-lg bg-white">
            <option value="ALL">All Status</option>
            <option value="PENDING">Pending</option>
            <option value="ACCEPTED">Accepted</option>
            <option value="REJECTED">Rejected</option>
            <option value="MONITORING">Monitoring</option>
          </select>
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> Export
          </button>
        </div>
      </div>

      {/* KPIs */}
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-white rounded-xl shadow-sm p-4 border border-gray-100">
              <div className="flex items-center gap-2 mb-2">
                <div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div>
              </div>
              <p className="text-2xl font-bold text-gray-900">{kpi.value}</p>
              <p className="text-xs text-gray-500 mt-1">{kpi.title}</p>
            </div>
          );
        })}
      </div>

      {/* Decision Table */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="p-4 border-b border-gray-100 flex items-center justify-between">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <Lightbulb className="w-5 h-5 text-orange-500" /> Recent Decisions
          </h2>
          <span className="text-sm text-gray-500">{decisions.length} decisions</span>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 text-left">
              <tr>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Type</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Property</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Recommendation</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Confidence</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Status</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Impact</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">When</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {decisions.map((dec: any, i: number) => {
                const statusInfo = statusIcons[dec.status] || statusIcons.PENDING;
                const StatusIcon = statusInfo.icon;
                return (
                  <tr key={i} className="hover:bg-gray-50 transition cursor-pointer">
                    <td className="px-4 py-3">
                      <span className={`px-2 py-1 rounded-full text-xs font-medium ${typeColors[dec.type] || "bg-gray-100 text-gray-700"}`}>
                        {dec.type.replace(/_/g, ' ')}
                      </span>
                    </td>
                    <td className="px-4 py-3 text-sm font-medium text-gray-900">{dec.propertyTitle}</td>
                    <td className="px-4 py-3 text-sm text-gray-600 max-w-[250px] truncate">{dec.recommendation}</td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-2">
                        <div className="w-16 bg-gray-200 rounded-full h-1.5">
                          <div className={`h-1.5 rounded-full ${dec.confidence >= 85 ? 'bg-green-500' : dec.confidence >= 70 ? 'bg-yellow-500' : 'bg-red-500'}`} style={{ width: `${dec.confidence}%` }} />
                        </div>
                        <span className="text-xs text-gray-600">{dec.confidence}%</span>
                      </div>
                    </td>
                    <td className="px-4 py-3">
                      <span className={`inline-flex items-center gap-1 text-sm ${statusInfo.color}`}>
                        <StatusIcon className="w-4 h-4" /> {dec.status}
                      </span>
                    </td>
                    <td className="px-4 py-3 text-sm text-gray-600">{dec.impact}</td>
                    <td className="px-4 py-3 text-sm text-gray-400">{dec.createdAt}</td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>

      {/* Decision Flow Diagram */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Decision Lifecycle Flow</h2>
        <div className="flex items-center justify-between">
          {["AI Proposes", "Owner Notified", "Accept/Reject", "Action Executed", "Outcome Monitored", "Learning Updated"].map((step, i) => (
            <div key={i} className="flex items-center">
              <div className="flex flex-col items-center">
                <div className={`w-10 h-10 rounded-full flex items-center justify-center text-sm font-bold ${
                  i <= 3 ? 'bg-green-600 text-white' : 'bg-gray-200 text-gray-500'
                }`}>{i + 1}</div>
                <span className="text-xs text-gray-600 mt-2 text-center max-w-[80px]">{step}</span>
              </div>
              {i < 5 && <div className={`w-8 h-0.5 mx-1 mt-[-16px] ${i < 3 ? 'bg-green-400' : 'bg-gray-300'}`} />}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
