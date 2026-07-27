"use client";

import { useLocalization } from "@/contexts/LocalizationContext";
import { useAuth } from "@/lib/auth";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import {
  Network, Activity, Lightbulb, Zap, BarChart3, GitBranch,
  Target, ArrowUpRight, Brain, Clock, CheckCircle2, XCircle,
  AlertTriangle, RefreshCw, Download, Eye, Layers, DollarSign,
  Building2, Users
} from "lucide-react";
import { apiClient } from "@/lib/api";

async function fetchGraphStats(orgId: string) {
  try {
    const res: any = await apiClient.get(`/intelligence/graph-stats?orgId=${orgId}`);
    return res.data;
  } catch { return null; }
}

export default function IntelligenceGraphDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";
  const [activeTab, setActiveTab] = useState<"overview" | "sagas" | "dlq" | "timeline">("overview");

  const { data: graphStats, isLoading } = useQuery({
    queryKey: ["intelligence-graph-dashboard", orgId],
    queryFn: () => fetchGraphStats(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);

  const stats = graphStats || {
    totalSagas: 48, activeSagas: 12, completedToday: 34, failedToday: 2,
    dlqPending: 5, avgDurationMs: 12400, totalCalibrations: 247,
    totalDecisions: 89, pipelineHealth: 96,
  };

  const kpis = [
    { title: "Total Sagas", value: stats.totalSagas, icon: Layers, color: "text-purple-600", bg: "bg-purple-50" },
    { title: "Active Now", value: stats.activeSagas, icon: RefreshCw, color: "text-blue-600", bg: "bg-blue-50" },
    { title: "Completed Today", value: stats.completedToday, icon: CheckCircle2, color: "text-green-600", bg: "bg-green-50" },
    { title: "Failed Today", value: stats.failedToday, icon: XCircle, color: "text-red-600", bg: "bg-red-50" },
    { title: "DLQ Pending", value: stats.dlqPending, icon: AlertTriangle, color: "text-orange-600", bg: "bg-orange-50" },
    { title: "Pipeline Health", value: `${stats.pipelineHealth}%`, icon: Activity, color: "text-emerald-600", bg: "bg-emerald-50" },
  ];

  const sagaTypes = [
    { name: "IntelligencePipeline", active: 4, completed: 156, failed: 3, avgMs: 18500, icon: Brain },
    { name: "DecisionExecution", active: 2, completed: 89, failed: 1, avgMs: 45000, icon: Zap },
    { name: "RevenueLifecycle", active: 3, completed: 67, failed: 2, avgMs: 72000, icon: DollarSign },
    { name: "PropertyLifecycle", active: 1, completed: 234, failed: 5, avgMs: 8200, icon: Building2 },
    { name: "UserAcquisition", active: 2, completed: 189, failed: 0, avgMs: 3400, icon: Users },
    { name: "FeedbackLoop", active: 0, completed: 247, failed: 1, avgMs: 5600, icon: Target },
  ];

  const dlqEntries = [
    { id: "dlq-001", sagaType: "IntelligencePipeline", step: "CONTENT_GENERATING", error: "OpenAI timeout after 30s", retries: 3, createdAt: "2h ago" },
    { id: "dlq-002", sagaType: "DecisionExecution", step: "NOTIFYING_OWNER", error: "WhatsApp API rate limit", retries: 3, createdAt: "4h ago" },
    { id: "dlq-003", sagaType: "RevenueLifecycle", step: "ESCROW_FUNDED", error: "Payment gateway 503", retries: 5, createdAt: "6h ago" },
    { id: "dlq-004", sagaType: "IntelligencePipeline", step: "SCORING", error: "Scoring service unavailable", retries: 3, createdAt: "12h ago" },
    { id: "dlq-005", sagaType: "PropertyLifecycle", step: "ACTIVATION", error: "Validation failed: missing images", retries: 2, createdAt: "1d ago" },
  ];

  const timelineEntries = [
    { sagaId: "saga-001", type: "IntelligencePipeline", entity: "Kensington 3BR", steps: 10, completed: 10, duration: "18.5s", status: "COMPLETED" },
    { sagaId: "saga-002", type: "DecisionExecution", entity: "Chelsea Penthouse", steps: 7, completed: 4, duration: "45.2s", status: "RUNNING" },
    { sagaId: "saga-003", type: "RevenueLifecycle", entity: "Lead #1892", steps: 10, completed: 6, duration: "72.1s", status: "RUNNING" },
    { sagaId: "saga-004", type: "IntelligencePipeline", entity: "Canary Wharf Studio", steps: 10, completed: 10, duration: "12.3s", status: "COMPLETED" },
    { sagaId: "saga-005", type: "FeedbackLoop", entity: "Shoreditch Loft", steps: 5, completed: 5, duration: "5.6s", status: "COMPLETED" },
  ];

  const tabs = [
    { id: "overview" as const, label: "Overview", icon: BarChart3 },
    { id: "sagas" as const, label: "Saga Registry", icon: Layers },
    { id: "dlq" as const, label: "Dead Letter Queue", icon: AlertTriangle },
    { id: "timeline" as const, label: "Timeline", icon: Clock },
  ];

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Intelligence Graph</h1>
          <p className="text-gray-600 mt-1">Saga orchestration observability — pipelines, DLQ, timelines</p>
        </div>
        <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
          <Download className="w-4 h-4" /> Export
        </button>
      </div>

      {/* KPIs */}
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

      {/* Tabs */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-100">
        <div className="flex border-b border-gray-100">
          {tabs.map(tab => {
            const Icon = tab.icon;
            return (
              <button key={tab.id} onClick={() => setActiveTab(tab.id)} className={`flex items-center gap-2 px-6 py-3 text-sm font-medium border-b-2 transition ${
                activeTab === tab.id ? 'border-blue-600 text-blue-600' : 'border-transparent text-gray-500 hover:text-gray-700'
              }`}>
                <Icon className="w-4 h-4" /> {tab.label}
              </button>
            );
          })}
        </div>

        <div className="p-6">
          {/* Overview Tab */}
          {activeTab === "overview" && (
            <div className="space-y-6">
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div>
                  <h3 className="text-sm font-semibold text-gray-700 mb-3">Platform Architecture</h3>
                  <div className="p-4 bg-gray-50 rounded-lg border border-gray-200 font-mono text-xs space-y-1 text-gray-600">
                    <p>┌─ BaseSaga (Enterprise v2) ──────────────┐</p>
                    <p>│  ✅ Versioning   ✅ Distributed Lock    │</p>
                    <p>│  ✅ Timeline     ✅ Retry + DLQ         │</p>
                    <p>├──────────────────────────────────────────┤</p>
                    <p>│  48 Active Sagas                        │</p>
                    <p>│  ├─ IntelligencePipeline (6 entities)   │</p>
                    <p>│  ├─ DecisionExecution (7 steps)         │</p>
                    <p>│  ├─ RevenueLifecycle (10 steps)         │</p>
                    <p>│  ├─ FeedbackLoop (5 steps)              │</p>
                    <p>│  └─ 44 more domain sagas                │</p>
                    <p>├──────────────────────────────────────────┤</p>
                    <p>│  Dead Letter Queue: {stats.dlqPending} pending           │</p>
                    <p>│  Pipeline Health: {stats.pipelineHealth}%                │</p>
                    <p>└──────────────────────────────────────────┘</p>
                  </div>
                </div>
                <div>
                  <h3 className="text-sm font-semibold text-gray-700 mb-3">Intelligence Flow</h3>
                  <div className="space-y-2">
                    {[
                      { label: "Entity Created → Data Collected", pct: 100 },
                      { label: "Data Collected → Analyzed", pct: 98 },
                      { label: "Analyzed → Scored", pct: 97 },
                      { label: "Scored → Content Generated", pct: 94 },
                      { label: "Content → Published", pct: 92 },
                      { label: "Published → Feedback Loop", pct: 85 },
                      { label: "Feedback → Learning Updated", pct: 82 },
                    ].map((f, i) => (
                      <div key={i} className="flex items-center gap-3">
                        <span className="text-xs text-gray-600 w-52 truncate">{f.label}</span>
                        <div className="flex-1 bg-gray-200 rounded-full h-2">
                          <div className={`h-2 rounded-full ${f.pct >= 95 ? 'bg-green-500' : f.pct >= 85 ? 'bg-blue-500' : 'bg-orange-500'}`} style={{ width: `${f.pct}%` }} />
                        </div>
                        <span className="text-xs font-bold w-10 text-right">{f.pct}%</span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          )}

          {/* Saga Registry Tab */}
          {activeTab === "sagas" && (
            <table className="w-full">
              <thead className="bg-gray-50 text-left">
                <tr>
                  <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Saga Type</th>
                  <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Active</th>
                  <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Completed</th>
                  <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Failed</th>
                  <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Avg Duration</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {sagaTypes.map((s, i) => {
                  const Icon = s.icon;
                  return (
                    <tr key={i} className="hover:bg-gray-50 transition">
                      <td className="px-4 py-3 flex items-center gap-2">
                        <Icon className="w-4 h-4 text-gray-500" />
                        <span className="text-sm font-medium text-gray-900">{s.name}</span>
                      </td>
                      <td className="px-4 py-3">
                        {s.active > 0 ? <span className="px-2 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-medium">{s.active} running</span> : <span className="text-xs text-gray-400">—</span>}
                      </td>
                      <td className="px-4 py-3 text-sm text-green-600 font-medium">{s.completed}</td>
                      <td className="px-4 py-3 text-sm text-red-600 font-medium">{s.failed || '—'}</td>
                      <td className="px-4 py-3 text-sm text-gray-600">{(s.avgMs / 1000).toFixed(1)}s</td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          )}

          {/* DLQ Tab */}
          {activeTab === "dlq" && (
            <div className="space-y-4">
              <div className="flex items-center justify-between">
                <h3 className="text-sm font-semibold text-gray-700">{dlqEntries.length} Pending Dead Letters</h3>
                <button className="px-3 py-1.5 bg-green-600 text-white rounded-lg text-sm hover:bg-green-700 transition">Replay All</button>
              </div>
              <table className="w-full">
                <thead className="bg-gray-50 text-left">
                  <tr>
                    <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Saga</th>
                    <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Step</th>
                    <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Error</th>
                    <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Retries</th>
                    <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">When</th>
                    <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {dlqEntries.map((e, i) => (
                    <tr key={i} className="hover:bg-gray-50 transition">
                      <td className="px-4 py-3 text-sm font-medium text-gray-900">{e.sagaType}</td>
                      <td className="px-4 py-3"><span className="px-2 py-1 bg-orange-100 text-orange-700 rounded-full text-xs">{e.step}</span></td>
                      <td className="px-4 py-3 text-sm text-red-600 max-w-[200px] truncate">{e.error}</td>
                      <td className="px-4 py-3 text-sm text-gray-600">{e.retries}</td>
                      <td className="px-4 py-3 text-sm text-gray-400">{e.createdAt}</td>
                      <td className="px-4 py-3 flex gap-2">
                        <button className="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs hover:bg-blue-200 transition">Replay</button>
                        <button className="px-2 py-1 bg-red-100 text-red-700 rounded text-xs hover:bg-red-200 transition">Discard</button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}

          {/* Timeline Tab */}
          {activeTab === "timeline" && (
            <table className="w-full">
              <thead className="bg-gray-50 text-left">
                <tr>
                  <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Saga</th>
                  <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Entity</th>
                  <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Progress</th>
                  <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Duration</th>
                  <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Status</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {timelineEntries.map((t, i) => (
                  <tr key={i} className="hover:bg-gray-50 transition">
                    <td className="px-4 py-3 text-sm font-medium text-gray-900">{t.type}</td>
                    <td className="px-4 py-3 text-sm text-gray-600">{t.entity}</td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-2">
                        <div className="w-24 bg-gray-200 rounded-full h-2">
                          <div className={`h-2 rounded-full ${t.completed === t.steps ? 'bg-green-500' : 'bg-blue-500'}`} style={{ width: `${(t.completed / t.steps) * 100}%` }} />
                        </div>
                        <span className="text-xs text-gray-600">{t.completed}/{t.steps}</span>
                      </div>
                    </td>
                    <td className="px-4 py-3 text-sm text-gray-600">{t.duration}</td>
                    <td className="px-4 py-3">
                      <span className={`px-2 py-1 rounded-full text-xs font-medium ${
                        t.status === 'COMPLETED' ? 'bg-green-100 text-green-700' : 'bg-blue-100 text-blue-700'
                      }`}>{t.status}</span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>
    </div>
  );
}
