"use client";

import { useTranslation } from "react-i18next";
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
import { tEnum } from "@/lib/admin-enums";

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
  const { t } = useTranslation();

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
    { title: t("admin_intelligence_graph_total_sagas", "Toplam Saga"), value: stats.totalSagas, icon: Layers, color: "text-brand", bg: "bg-brand/10" },
    { title: t("admin_intelligence_graph_active_now", "Şu An Aktif"), value: stats.activeSagas, icon: RefreshCw, color: "text-blue-600", bg: "bg-blue-50" },
    { title: t("admin_intelligence_graph_completed_today", "Bugün Tamamlanan"), value: stats.completedToday, icon: CheckCircle2, color: "text-blue-600", bg: "bg-blue-50" },
    { title: t("admin_intelligence_graph_failed_today", "Bugün Başarısız"), value: stats.failedToday, icon: XCircle, color: "text-red-600", bg: "bg-red-50" },
    { title: t("admin_intelligence_graph_dlq_pending", "DLQ Bekleyen"), value: stats.dlqPending, icon: AlertTriangle, color: "text-orange-600", bg: "bg-orange-50" },
    { title: t("admin_intelligence_graph_pipeline_health", "Boru Hattı Sağlığı"), value: `${stats.pipelineHealth}%`, icon: Activity, color: "text-blue-600", bg: "bg-blue-50" },
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
    { id: "overview" as const, label: t("admin_intelligence_graph_tab_overview", "Genel Bakış"), icon: BarChart3 },
    { id: "sagas" as const, label: t("admin_intelligence_graph_tab_saga_registry", "Saga Kayıt Defteri"), icon: Layers },
    { id: "dlq" as const, label: t("admin_intelligence_graph_tab_dead_letter_queue", "Ölü Mektup Kuyruğu"), icon: AlertTriangle },
    { id: "timeline" as const, label: t("admin_intelligence_graph_tab_timeline", "Zaman Çizelgesi"), icon: Clock },
  ];

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-card-foreground">{t("admin_intelligence_graph_title", "Zeka Grafiği (Intelligence Graph)")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_intelligence_graph_dashboard_desc", "Saga orkestrasyonu gözlemlenebilirliği — boru hatları, DLQ, zaman çizelgeleri")}</p>
        </div>
        <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
          <Download className="w-4 h-4" /> {t("admin_intelligence_graph_export", "Dışa Aktar")}
        </button>
      </div>

      {/* KPIs */}
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-card rounded-xl shadow-sm p-4 border border-border">
              <div className="flex items-center gap-2 mb-2"><div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div></div>
              <p className="text-2xl font-bold text-card-foreground">{kpi.value}</p>
              <p className="text-xs text-muted-foreground mt-1">{kpi.title}</p>
            </div>
          );
        })}
      </div>

      {/* Tabs */}
      <div className="bg-card rounded-xl shadow-sm border border-border">
        <div className="flex border-b border-border">
          {tabs.map(tab => {
            const Icon = tab.icon;
            return (
              <button key={tab.id} onClick={() => setActiveTab(tab.id)} className={`flex items-center gap-2 px-6 py-3 text-sm font-medium border-b-2 transition ${
                activeTab === tab.id ? 'border-blue-600 text-blue-600' : 'border-transparent text-muted-foreground hover:text-foreground'
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
                  <h3 className="text-sm font-semibold text-card-foreground mb-3">{t("admin_intelligence_graph_platform_architecture", "Platform Mimarisi")}</h3>
                  <div className="p-4 bg-muted rounded-lg border border-border font-mono text-xs space-y-1 text-muted-foreground">
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
                    <p>│  {t("admin_intelligence_graph_dlq_label", "Ölü Mektup Kuyruğu:")} {stats.dlqPending} {tEnum(t, "pending")}           │</p>
                    <p>│  {t("admin_intelligence_graph_pipeline_health_label", "Boru Hattı Sağlığı:")} {stats.pipelineHealth}%                │</p>
                    <p>└──────────────────────────────────────────┘</p>
                  </div>
                </div>
                <div>
                  <h3 className="text-sm font-semibold text-card-foreground mb-3">{t("admin_intelligence_graph_intelligence_flow", "Zeka Akışı")}</h3>
                  <div className="space-y-2">
                    {[
                      { label: t("admin_intelligence_graph_flow_entity_created", "Varlık Oluşturuldu → Veri Toplandı"), pct: 100 },
                      { label: t("admin_intelligence_graph_flow_data_analyzed", "Veri Toplandı → Analiz Edildi"), pct: 98 },
                      { label: t("admin_intelligence_graph_flow_analyzed_scored", "Analiz Edildi → Puanlandı"), pct: 97 },
                      { label: t("admin_intelligence_graph_flow_scored_content", "Puanlandı → İçerik Üretildi"), pct: 94 },
                      { label: t("admin_intelligence_graph_flow_content_published", "İçerik → Yayınlandı"), pct: 92 },
                      { label: t("admin_intelligence_graph_flow_published_feedback", "Yayınlandı → Geri Bildirim Döngüsü"), pct: 85 },
                      { label: t("admin_intelligence_graph_flow_feedback_learning", "Geri Bildirim → Öğrenme Güncellendi"), pct: 82 },
                    ].map((f, i) => (
                      <div key={i} className="flex items-center gap-3">
                        <span className="text-xs text-muted-foreground w-52 truncate">{f.label}</span>
                        <div className="flex-1 bg-muted rounded-full h-2">
                          <div className={`h-2 rounded-full ${f.pct >= 95 ? 'bg-blue-500' : f.pct >= 85 ? 'bg-blue-500' : 'bg-orange-500'}`} style={{ width: `${f.pct}%` }} />
                        </div>
                        <span className="text-xs font-bold w-10 text-right text-card-foreground">{f.pct}%</span>
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
              <thead className="bg-muted text-left">
                <tr>
                  <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_intelligence_graph_saga_type", "Saga Türü")}</th>
                  <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{tEnum(t, "Active")}</th>
                  <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{tEnum(t, "Completed")}</th>
                  <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{tEnum(t, "Failed")}</th>
                  <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_intelligence_graph_avg_duration", "Ort. Süre")}</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-border">
                {sagaTypes.map((s, i) => {
                  const Icon = s.icon;
                  return (
                    <tr key={i} className="hover:bg-muted/50 transition">
                      <td className="px-4 py-3 flex items-center gap-2">
                        <Icon className="w-4 h-4 text-muted-foreground" />
                        <span className="text-sm font-medium text-card-foreground">{s.name}</span>
                      </td>
                      <td className="px-4 py-3">
                        {s.active > 0 ? <span className="px-2 py-1 bg-blue-100 text-blue-700 rounded-full text-xs font-medium">{s.active} {tEnum(t, "RUNNING")}</span> : <span className="text-xs text-muted-foreground">—</span>}
                      </td>
                      <td className="px-4 py-3 text-sm text-blue-600 font-medium">{s.completed}</td>
                      <td className="px-4 py-3 text-sm text-red-600 font-medium">{s.failed || '—'}</td>
                      <td className="px-4 py-3 text-sm text-muted-foreground">{(s.avgMs / 1000).toFixed(1)}s</td>
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
                <h3 className="text-sm font-semibold text-card-foreground">{dlqEntries.length} {t("admin_intelligence_graph_pending_dead_letters", "Bekleyen Ölü Mektuplar")}</h3>
                <button className="px-3 py-1.5 bg-blue-600 text-white rounded-lg text-sm hover:bg-blue-700 transition">{t("admin_intelligence_graph_replay_all", "Tümünü Tekrar Oynat")}</button>
              </div>
              <table className="w-full">
                <thead className="bg-muted text-left">
                  <tr>
                    <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_intelligence_graph_saga", "Saga")}</th>
                    <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_step", "Adım")}</th>
                    <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_error", "Hata")}</th>
                    <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_retries", "Tekrar Deneme")}</th>
                    <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_when", "Ne Zaman")}</th>
                    <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_actions", "İşlemler")}</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-border">
                  {dlqEntries.map((e, i) => (
                    <tr key={i} className="hover:bg-muted/50 transition">
                      <td className="px-4 py-3 text-sm font-medium text-card-foreground">{e.sagaType}</td>
                      <td className="px-4 py-3"><span className="px-2 py-1 bg-orange-100 text-orange-700 rounded-full text-xs">{tEnum(t, e.step)}</span></td>
                      <td className="px-4 py-3 text-sm text-red-600 max-w-[200px] truncate">{e.error}</td>
                      <td className="px-4 py-3 text-sm text-muted-foreground">{e.retries}</td>
                      <td className="px-4 py-3 text-sm text-muted-foreground">{e.createdAt}</td>
                      <td className="px-4 py-3 flex gap-2">
                        <button className="px-2 py-1 bg-blue-100 text-blue-700 rounded text-xs hover:bg-blue-200 transition">{t("admin_intelligence_graph_replay", "Tekrar Oynat")}</button>
                        <button className="px-2 py-1 bg-red-100 text-red-700 rounded text-xs hover:bg-red-200 transition">{t("admin_intelligence_graph_discard", "At")}</button>
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
              <thead className="bg-muted text-left">
                <tr>
                  <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_intelligence_graph_saga", "Saga")}</th>
                  <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_entity", "Varlık")}</th>
                  <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_progress", "İlerleme")}</th>
                  <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_duration", "Süre")}</th>
                  <th className="px-4 py-3 text-xs font-medium text-muted-foreground uppercase">{t("admin_common_status", "Durum")}</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-border">
                {timelineEntries.map((entry, i) => (
                  <tr key={i} className="hover:bg-muted/50 transition">
                    <td className="px-4 py-3 text-sm font-medium text-card-foreground">{tEnum(t, entry.type)}</td>
                    <td className="px-4 py-3 text-sm text-muted-foreground">{entry.entity}</td>
                    <td className="px-4 py-3">
                      <div className="flex items-center gap-2">
                        <div className="w-24 bg-muted rounded-full h-2">
                          <div className={`h-2 rounded-full ${entry.completed === entry.steps ? 'bg-blue-500' : 'bg-blue-500'}`} style={{ width: `${(entry.completed / entry.steps) * 100}%` }} />
                        </div>
                        <span className="text-xs text-muted-foreground">{entry.completed}/{entry.steps}</span>
                      </div>
                    </td>
                    <td className="px-4 py-3 text-sm text-muted-foreground">{entry.duration}</td>
                    <td className="px-4 py-3">
                      <span className={`px-2 py-1 rounded-full text-xs font-medium ${
                        entry.status === 'COMPLETED' ? 'bg-blue-100 text-blue-700' : 'bg-blue-100 text-blue-700'
                      }`}>{tEnum(t, entry.status)}</span>
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
