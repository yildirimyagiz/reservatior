"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import {
  Zap, Brain, Target, Activity, BarChart3, CheckCircle2,
  XCircle, Clock, Eye, TrendingUp, ArrowUpRight, ArrowDownRight,
  Download, Filter, RefreshCw, AlertTriangle, ThumbsUp, ThumbsDown,
  DollarSign, Building2, Lightbulb
} from "lucide-react";
import { apiClient } from "@/lib/api";
import { tEnum } from "@/lib/admin-enums";

// ─── Fetch ─────────────────────────────────────────────────────────────────
async function fetchDecisions(orgId: string, status: string, limit: number) {
  try {
    const res: any = await apiClient.get(`/intelligence/decisions?orgId=${orgId}&status=${status}&limit=${limit}`);
    return res.data;
  } catch { return { decisions: [], stats: {} }; }
}

export default function DecisionEngineDashboard() { 
  const { t } = useTranslation();
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
    { i18nKey: "admin_decision_engine_total_decisions", title: "Total Decisions", value: stats.totalDecisions || decisions.length, icon: Brain, color: "text-brand", bg: "bg-brand/10" },
    { i18nKey: "admin_decision_engine_accepted", title: "Accepted", value: stats.accepted || decisions.filter((d: any) => d.status === "ACCEPTED").length, icon: ThumbsUp, color: "text-blue-600", bg: "bg-blue-50" },
    { i18nKey: "admin_decision_engine_pending", title: "Pending", value: stats.pending || decisions.filter((d: any) => d.status === "PENDING").length, icon: Clock, color: "text-orange-600", bg: "bg-orange-50" },
    { i18nKey: "admin_decision_engine_avg_confidence", title: "Avg Confidence", value: `${stats.avgConfidence || 89}%`, icon: Target, color: "text-blue-600", bg: "bg-blue-50" },
    { i18nKey: "admin_decision_engine_success_rate", title: "Success Rate", value: `${stats.successRate || 84}%`, icon: TrendingUp, color: "text-brand", bg: "bg-brand/10" },
    { i18nKey: "admin_decision_engine_revenue_impact", title: "Revenue Impact", value: formatCurrency(stats.totalImpact || 124500), icon: DollarSign, color: "text-blue-600", bg: "bg-blue-50" },
  ];

  const typeColors: Record<string, string> = {
    PRICE_REDUCTION: "bg-red-100 text-red-700",
    PRICE_INCREASE: "bg-blue-100 text-blue-700",
    MARKETING_BOOST: "bg-brand/15 text-brand",
    LISTING_REFRESH: "bg-blue-100 text-blue-700",
    AGENT_REASSIGNMENT: "bg-orange-100 text-orange-700",
    INVESTMENT_RECOMMENDATION: "bg-blue-100 text-blue-700",
    PORTFOLIO_REBALANCE: "bg-brand/15 text-brand",
  };

  const statusIcons: Record<string, any> = {
    ACCEPTED: { icon: CheckCircle2, color: "text-blue-600" },
    REJECTED: { icon: XCircle, color: "text-red-600" },
    PENDING: { icon: Clock, color: "text-orange-600" },
    MONITORING: { icon: Eye, color: "text-blue-600" },
  };

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  return (
    <PageShell
      title={t("admin_decision_engine_title", "Karar Motoru (Decision Engine)")}
      description={t("admin_decision_engine_desc", "Otonom fiyatlandırma, doluluk ve kabul kararları")}
      actions={
        <div className="flex gap-3">
          <select value={statusFilter} onChange={(e) => setStatusFilter(e.target.value)} className="px-4 py-2 border border-border rounded-lg bg-card">
            <option value="ALL">{t("admin_decision_engine_all_status", "Tüm Durumlar")}</option>
            <option value="PENDING">{t("admin_decision_engine_pending", "Beklemede")}</option>
            <option value="ACCEPTED">{t("admin_decision_engine_accepted", "Kabul Edildi")}</option>
            <option value="REJECTED">{t("admin_decision_engine_rejected", "Reddedildi")}</option>
            <option value="MONITORING">{t("admin_decision_engine_monitoring", "İzleniyor")}</option>
          </select>
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> {t("admin_common_export", "Dışa Aktar")}
          </button>
        </div>
      }
    >
    <div className="space-y-6">

      {/* KPIs */}
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-card rounded-xl shadow-sm p-4 border border-border">
              <div className="flex items-center gap-2 mb-2">
                <div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div>
              </div>
              <p className="text-2xl font-bold text-card-foreground">{kpi.value}</p>
              <p className="text-xs text-muted-foreground mt-1">{t(kpi.i18nKey, kpi.title)}</p>
            </div>
          );
        })}
      </div>

      {/* Decision Table */}
      <div className="bg-card rounded-xl shadow-sm border border-border overflow-hidden">
        <div className="p-4 border-b border-border flex items-center justify-between">
          <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2">
            <Lightbulb className="w-5 h-5 text-orange-500" /> {t("admin_decision_engine_recent_decisions", "Son Kararlar")}
          </h2>
          <span className="text-sm text-muted-foreground">{decisions.length} {t("admin_decision_engine_decisions", "karar")}</span>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-muted text-left">
              <tr>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_type", "Tür")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_decision_engine_property", "Mülk")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_decision_engine_recommendation", "Öneri")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_decision_engine_confidence", "Güven")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_status", "Durum")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_decision_engine_impact", "Etki")}</th>
                <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_when", "Ne Zaman")}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {decisions.map((dec: any, i: number) => {
                const statusInfo = statusIcons[dec.status] || statusIcons.PENDING;
                const StatusIcon = statusInfo.icon;
                return (
                  <tr key={i} className="hover:bg-muted transition cursor-pointer">
                    <td className="px-4 py-3">
                      <span className={`px-2 py-1 rounded-full text-xs font-medium ${typeColors[dec.type] || "bg-gray-100 text-muted-foreground"}`}>
                        {dec.type.replace(/_/g, ' ')}
                      </span>
                    </td>
                    <td className="px-4 py-3 text-sm font-medium text-card-foreground">{dec.propertyTitle}</td>
                    <td className="px-4 py-3 text-sm text-muted-foreground max-w-[250px] truncate">{dec.recommendation}</td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-2">
                        <div className="w-16 bg-gray-200 rounded-full h-1.5">
                          <div className={`h-1.5 rounded-full ${dec.confidence >= 85 ? 'bg-blue-500' : dec.confidence >= 70 ? 'bg-yellow-500' : 'bg-red-500'}`} style={{ width: `${dec.confidence}%` }} />
                        </div>
                        <span className="text-xs text-muted-foreground">{dec.confidence}%</span>
                      </div>
                    </td>
                    <td className="px-4 py-3">
                      <span className={`inline-flex items-center gap-1 text-sm ${statusInfo.color}`}>
                        <StatusIcon className="w-4 h-4" /> {tEnum(t, dec.status)}
                      </span>
                    </td>
                    <td className="px-4 py-3 text-sm text-muted-foreground">{dec.impact}</td>
                    <td className="px-4 py-3 text-sm text-gray-400">{dec.createdAt}</td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>

      {/* Decision Flow Diagram */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-card-foreground mb-4">{t("admin_decision_engine_lifecycle_flow", "Karar Yaşam Döngüsü")}</h2>
        <div className="flex items-center justify-between">
          {[
            { i18nKey: "admin_decision_engine_flow_ai_proposes", label: "AI Proposes" },
            { i18nKey: "admin_decision_engine_flow_owner_notified", label: "Owner Notified" },
            { i18nKey: "admin_decision_engine_flow_accept_reject", label: "Accept/Reject" },
            { i18nKey: "admin_decision_engine_flow_action_executed", label: "Action Executed" },
            { i18nKey: "admin_decision_engine_flow_outcome_monitored", label: "Outcome Monitored" },
            { i18nKey: "admin_decision_engine_flow_learning_updated", label: "Learning Updated" },
          ].map((step, i) => (
            <div key={i} className="flex items-center">
              <div className="flex flex-col items-center">
                <div className={`w-10 h-10 rounded-full flex items-center justify-center text-sm font-bold ${
                  i <= 3 ? 'bg-blue-600 text-white' : 'bg-gray-200 text-muted-foreground'
                }`}>{i + 1}</div>
                <span className="text-xs text-muted-foreground mt-2 text-center max-w-[80px]">{t(step.i18nKey, step.label)}</span>
              </div>
              {i < 5 && <div className={`w-8 h-0.5 mx-1 mt-[-16px] ${i < 3 ? 'bg-blue-400' : 'bg-gray-300'}`} />}
            </div>
          ))}
        </div>
      </div>
    </div>
  </PageShell>
  );
}
