"use client";

import React, { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import {
  Brain, Zap, Shield, Activity, RefreshCw, Sparkles, CheckCircle2,
  AlertTriangle, Play, RotateCcw, Cpu, Layers, GitMerge, ArrowRight,
  Server, ShieldAlert, FileText, Check, Copy, UserCheck, Share2,
  Building2, Target, Send, MessageSquare, Phone, Mail, Network,
  Lock, ArrowDownRight, ArrowUpRight, DollarSign, PieChart, Hash
} from "lucide-react";
import { apiClient } from "@/lib/api";

export default function HybridRentalOSModuleDashboard() {
  const { t } = useTranslation();
  const [activeTab, setActiveTab] = useState<'acquisition' | 'intelligence' | 'revenue_dag'>('intelligence');
  const [loading, setLoading] = useState(false);
  
  // Intelligence State
  const [sagaRunning, setSagaRunning] = useState(false);
  const [currentStep, setCurrentStep] = useState(0);
  const [sagaLog, setSagaLog] = useState<string[]>([]);
  const [activeSagaId, setActiveSagaId] = useState<string | null>(null);
  const [swarmResult, setSwarmResult] = useState<any>(null);

  // Acquisition State
  const [acquisitionData, setAcquisitionData] = useState<any>(null);

  // Revenue DAG State
  const [dagResult, setDagResult] = useState<any>(null);

  const sagaSteps = [
    { title: "PropertySubmitted", label: "Mülk Başvurusu Alındı", os: "ListingOS" },
    { title: "PropertyIntelligenceAnalysis", label: "AI Fiziksel & Bölge Analizi", os: "AI-OS" },
    { title: "AIScoreGenerated", label: "0-100 Skor Matrisi Üretildi", os: "AI-OS" },
    { title: "LegalComplianceCheck", label: "7464 Mevzuat & Kat Malikleri Kontrolü", os: "GovernanceOS" },
    { title: "RentalModelDecision", label: "Revenue Share / Master Lease Kararı", os: "HybridRentalOS" },
    { title: "PartnerAttribution", label: "Partner Ataması & Tier Matrisi", os: "PartnerOS" },
    { title: "RevenueSimulation", label: "Çift Taraflı P&L Projeksiyonu", os: "FinanceOS" },
    { title: "OwnerProposalGenerated", label: "AI Ev Sahibi Teklif Paketi", os: "AI-OS" },
    { title: "OwnerAcceptedOffer", label: "Ev Sahibi Teklif Onayı", os: "UserOS" },
    { title: "HybridContractCreated", label: "E-Devlet Sözleşme & Teminat", os: "ListingOS" },
    { title: "PropertyOperationActivated", label: "Operasyon & Kanal Aktivasyonu", os: "OperationsOS" },
    { title: "PartnerRevenueAccrued", label: "Komisyon Dağıtımı & Hakediş", os: "FinanceOS" }
  ];

  const handleStartSaga = async () => {
    setSagaRunning(true);
    setCurrentStep(0);
    setSagaLog(["[SagaOrchestrator] 🚀 Starting HybridRentalOnboardingSaga..."]);

    try {
      const res: any = await apiClient.post("/os/hybrid-rental/trigger-saga", {
        neighbourhood: "Beyoğlu",
        accommodates: 4,
        sizeSqm: 85,
        hasBuildingConsent100Pct: true,
        hasTourismResidenceLicense: true
      });

      if (res?.data?.sagaId) {
        setActiveSagaId(res.data.sagaId);
        setSagaLog(prev => [...prev, `[SagaRegistry] Saga ID registered: ${res.data.sagaId}`]);
      }
    } catch (e) {
      console.error(e);
    }

    for (let i = 0; i < sagaSteps.length; i++) {
      await new Promise(r => setTimeout(r, 500));
      setCurrentStep(i + 1);
      setSagaLog(prev => [
        ...prev,
        `[${sagaSteps[i].os}] Event emitted: ${sagaSteps[i].title} -> ${sagaSteps[i].label}`
      ]);
    }
    setSagaRunning(false);
  };

  const handleTriggerCompensation = async () => {
    if (!activeSagaId) return;
    setLoading(true);
    setSagaLog(prev => [
      ...prev,
      `[SagaOrchestrator] ⚠️ MANUAL COMPENSATION ROLLBACK INITIATED for ${activeSagaId}`
    ]);

    try {
      await apiClient.post("/os/hybrid-rental/trigger-compensation", {
        sagaId: activeSagaId,
        reason: "7464 Kat Malikleri Rıza Reddi"
      });

      await new Promise(r => setTimeout(r, 600));
      setSagaLog(prev => [
        ...prev,
        `[HybridRentalOS] Compensation step 1: ContractCancelled`,
        `[PartnerOS] Compensation step 2: PartnerAttributionReleased`,
        `[FinanceOS] Compensation step 3: CommissionReservationRemoved`,
        `[SagaOrchestrator] 🔴 Compensation complete. State rolled back to clean baseline.`
      ]);
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  const handleFetchAcquisition = async () => {
    setLoading(true);
    try {
      const res: any = await apiClient.post("/os/hybrid-rental/acquisition-discover", {});
      if (res?.data?.data) {
        setAcquisitionData(res.data.data);
      }
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  const handleRunRevenueDAG = async () => {
    setLoading(true);
    try {
      const res: any = await apiClient.post("/os/hybrid-rental/revenue-dag-process", { grossRevenueTRY: 118000 });
      if (res?.data?.data) {
        setDagResult(res.data.data);
      }
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  const handleRunSwarm = async () => {
    try {
      const res: any = await apiClient.post("/os/hybrid-rental/multi-agent-swarm", {
        neighbourhood: "Beyoğlu",
        sizeSqm: 85
      });
      if (res?.data?.swarm) {
        setSwarmResult(res.data.swarm);
      }
    } catch (e) {
      console.error(e);
    }
  };

  useEffect(() => {
    handleRunSwarm();
    handleFetchAcquisition();
    handleRunRevenueDAG();
  }, []);

  const formatCurrency = (val: number) => {
    return new Intl.NumberFormat("tr-TR", {
      style: "currency",
      currency: "TRY",
      maximumFractionDigits: 0,
    }).format(val || 0);
  };

  return (
    <PageShell title={t("admin_hybrid_rental_os_page_title", "Hibrit Kiralama & Gelir OS Modülü (AI Gayrimenkul İşletim Sistemi)")}>
      <div className="space-y-6 animate-in fade-in duration-500">
        {/* Header Hero Banner */}
        <div className="relative overflow-hidden rounded-2xl bg-gradient-to-r from-slate-900 via-indigo-950 to-slate-900 p-6 border border-border shadow-2xl">
          <div className="flex flex-col md:flex-row items-start md:items-center justify-between gap-4 relative z-10">
            <div>
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-brand/10 border border-brand/20 text-brand text-xs font-semibold uppercase tracking-wider mb-2">
                <Cpu className="w-3.5 h-3.5" /> {t("admin_hybrid_rental_os_badge", "Çekirdek İşletim Sistemi Mimarisi")}
              </div>
              <h1 className="text-2xl md:text-3xl font-extrabold text-white tracking-tight">
                {t("admin_hybrid_rental_os_hero_title", "Hibrit Kiralama & Gelir OS Modülü")}
              </h1>
              <p className="text-muted-foreground text-sm mt-1 max-w-2xl">
                {t("admin_hybrid_rental_os_hero_desc", "Gayrimenkul Gelir OS Mimarisi: Edinim Motoru, Çoklu Ajan Sürü Zekası ve Directed Acyclic Graph (DAG) Gelir Boru Hattı.")}
              </p>
            </div>

            {/* 3 Sub-OS Navigation Tabs */}
            <div className="flex items-center bg-background p-1 rounded-xl border border-border text-xs font-semibold">
              <button
                onClick={() => setActiveTab('acquisition')}
                className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg transition ${
                  activeTab === 'acquisition' ? "bg-primary text-primary-foreground text-white shadow" : "text-muted-foreground hover:text-white"
                }`}
              >
                <Target className="w-3.5 h-3.5" /> {t("admin_hybrid_rental_os_tab_acquisition", "1. Edinim Motoru")}
              </button>
              <button
                onClick={() => setActiveTab('intelligence')}
                className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg transition ${
                  activeTab === 'intelligence' ? "bg-primary text-primary-foreground text-white shadow" : "text-muted-foreground hover:text-white"
                }`}
              >
                <Brain className="w-3.5 h-3.5" /> {t("admin_hybrid_rental_os_tab_intelligence", "2. Zeka Motoru")}
              </button>
              <button
                onClick={() => setActiveTab('revenue_dag')}
                className={`flex items-center gap-1.5 px-3 py-1.5 rounded-lg transition ${
                  activeTab === 'revenue_dag' ? "bg-primary text-primary-foreground text-white shadow" : "text-muted-foreground hover:text-white"
                }`}
              >
                <Network className="w-3.5 h-3.5" /> {t("admin_hybrid_rental_os_tab_revenue_dag", "3. Gelir DAG Motoru")}
              </button>
            </div>
          </div>
        </div>

        {/* SUB-OS TAB 1: ACQUISITION ENGINE */}
        {activeTab === 'acquisition' && (
          <div className="space-y-6">
            <div className="flex items-center justify-between">
              <div>
                <h2 className="text-lg font-bold text-card-foreground flex items-center gap-2">
                  <Target className="w-5 h-5 text-brand" /> {t("admin_hybrid_rental_os_targets_title", "AI Mülk Keşfi & Ev Sahibi Erişim Hedefleri")}
                </h2>
                <p className="text-xs text-muted-foreground">{t("admin_hybrid_rental_os_targets_desc", "Piyasadan otomatik taranan yüksek potansiyelli mülkler ve AI iletişim kanalları")}</p>
              </div>
              <button
                onClick={handleFetchAcquisition}
                disabled={loading}
                className="flex items-center gap-1.5 px-3.5 py-2 bg-brand/10 border border-brand/30 text-brand text-xs font-bold rounded-xl hover:bg-brand/20"
              >
                <RefreshCw className="w-3.5 h-3.5" /> {t("admin_hybrid_rental_os_rescan_market", "Piyasayı Yeniden Tara")}
              </button>
            </div>

            {acquisitionData && (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {acquisitionData.targets.map((target: any, idx: number) => (
                  <div key={idx} className="bg-card border border-border rounded-2xl p-4 space-y-3 shadow-sm hover:border-brand/50 transition">
                    <div className="flex items-start justify-between">
                      <div className="space-y-0.5">
                        <span className="text-[10px] font-mono text-muted-foreground uppercase">{target.targetId} • {target.neighbourhood}</span>
                        <h3 className="text-sm font-bold text-card-foreground">{target.propertyTitle}</h3>
                      </div>
                      <span className="text-xs font-black bg-blue-500/10 text-success px-2 py-0.5 rounded-full border border-blue-500/20">
                        +{target.estimatedRevenueLiftPct}% {t("admin_hybrid_rental_os_lift", "Artış")}
                      </span>
                    </div>

                    <div className="grid grid-cols-2 gap-2 text-xs bg-muted/40 p-2.5 rounded-xl">
                      <div>
                        <span className="text-[10px] text-muted-foreground block">{t("admin_hybrid_rental_os_classic_rent", "Klasik Kira")}</span>
                        <span className="font-bold text-card-foreground">{formatCurrency(target.classicMonthlyRentTRY)}</span>
                      </div>
                      <div>
                        <span className="text-[10px] text-muted-foreground block">{t("admin_hybrid_rental_os_hybrid_revenue", "Hybrid Ciro (Tahmini)")}</span>
                        <span className="font-bold text-success">{formatCurrency(target.projectedMonthlyRevenueTRY)}</span>
                      </div>
                    </div>

                    <div className="flex items-center justify-between text-xs pt-1 border-t border-border">
                      <div className="flex items-center gap-1.5 text-muted-foreground">
                        {target.outreachChannel === 'WHATSAPP' && <MessageSquare className="w-3.5 h-3.5 text-success" />}
                        {target.outreachChannel === 'EMAIL' && <Mail className="w-3.5 h-3.5 text-blue-500" />}
                        {target.outreachChannel === 'CRM_CALL_CENTER' && <Phone className="w-3.5 h-3.5 text-brand" />}
                        <span className="font-medium text-[11px]">{target.outreachChannel}</span>
                      </div>
                      <span className="text-[10px] bg-brand/10 text-brand font-mono px-2 py-0.5 rounded font-bold">
                        {target.outreachStatus}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

        {/* SUB-OS TAB 2: INTELLIGENCE ENGINE & SAGA */}
        {activeTab === 'intelligence' && (
          <div className="space-y-6">
            <div className="flex items-center justify-between">
              <div>
                <h2 className="text-lg font-bold text-card-foreground flex items-center gap-2">
                  <GitMerge className="w-5 h-5 text-brand" /> {t("admin_hybrid_rental_os_saga_title", "`HybridRentalOnboardingSaga` Orkestrasyonu")}
                </h2>
                <p className="text-xs text-muted-foreground">{t("admin_hybrid_rental_os_saga_desc", "12 Adımlı yaşam döngüsü ve geri alma (compensation)")}</p>
              </div>

              <div className="flex items-center gap-2">
                <button
                  onClick={handleStartSaga}
                  disabled={sagaRunning}
                  className="flex items-center gap-1.5 px-3.5 py-2 bg-primary text-primary-foreground hover:bg-primary/90 text-white text-xs font-bold rounded-xl shadow disabled:opacity-50"
                >
                  {sagaRunning ? <RefreshCw className="w-3.5 h-3.5 animate-spin" /> : <Play className="w-3.5 h-3.5" />}
                  {t("admin_hybrid_rental_os_run_saga", "Saga Akışını Çalıştır")}
                </button>
                <button
                  onClick={handleTriggerCompensation}
                  disabled={!activeSagaId || loading}
                  className="flex items-center gap-1.5 px-3.5 py-2 bg-rose-500/10 border border-rose-500/30 text-rose-400 text-xs font-bold rounded-xl hover:bg-rose-500/20 disabled:opacity-40"
                >
                  <RotateCcw className="w-3.5 h-3.5" />
                  {t("admin_hybrid_rental_os_rollback", "Geri Al")}
                </button>
              </div>
            </div>

            <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-2">
              {sagaSteps.map((step, idx) => {
                const isDone = currentStep > idx;
                const isCurrent = currentStep === idx + 1;
                return (
                  <div
                    key={idx}
                    className={`p-3 rounded-xl border text-xs space-y-1 transition-all ${
                      isDone
                        ? "bg-blue-500/10 border-blue-500/30 text-success"
                        : isCurrent
                        ? "bg-brand/20 border-indigo-500 text-brand ring-2 ring-indigo-500/30"
                        : "bg-muted/40 border-border text-muted-foreground"
                    }`}
                  >
                    <div className="flex items-center justify-between text-[10px]">
                      <span className="font-mono">{idx + 1}{t("admin_hybrid_rental_os_step", ". Adım")}</span>
                      <span className="font-semibold">{step.os}</span>
                    </div>
                    <div className="font-bold truncate text-[11px]">{step.title}</div>
                    <div className="text-[10px] opacity-80 truncate">{step.label}</div>
                  </div>
                );
              })}
            </div>

            {/* Console Event Logs */}
            <div className="bg-background p-4 rounded-xl font-mono text-[11px] text-success space-y-1 max-h-40 overflow-y-auto border border-border">
              {sagaLog.length === 0 ? (
                <span className="text-muted-foreground">{t("admin_hybrid_rental_os_log_placeholder", "// EventBus dinleyicisi hazır. 'Saga Akışını Çalıştır' butonuna tıklayın.")}</span>
              ) : (
                sagaLog.map((log, idx) => <div key={idx}>{log}</div>)
              )}
            </div>

            {/* Multi-Agent Neural Swarm Status */}
            {swarmResult && (
              <div className="bg-card border border-border rounded-2xl p-5 space-y-4 shadow-sm">
                <div className="flex items-center justify-between border-b border-border pb-3">
                  <h3 className="text-base font-bold text-card-foreground flex items-center gap-2">
                    <Brain className="w-5 h-5 text-brand" /> {t("admin_hybrid_rental_os_swarm_title", "Çoklu Ajan Nöral AI Sürüsü (5 Ajan Konsensüsü)")}
                  </h3>
                  <span className="text-xs bg-brand/10 text-brand border border-brand/30 px-2.5 py-1 rounded-full font-bold">
                    {t("admin_hybrid_rental_os_consensus_score", "Konsensüs Skoru:")} %{swarmResult.consensusScore}
                  </span>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-5 gap-3">
                  {swarmResult.agents.map((agent: any, idx: number) => (
                    <div key={idx} className="bg-muted/40 border border-border p-3 rounded-xl space-y-2 text-xs">
                      <div className="flex items-center justify-between font-bold text-card-foreground text-[11px]">
                        <span>{agent.agentName}</span>
                        <span className="text-brand">%{agent.confidenceScore}</span>
                      </div>
                      <p className="text-[10px] text-muted-foreground leading-tight">{agent.agentRole}</p>
                      <div className="bg-background p-2 rounded-lg text-[10px] text-card-foreground border border-border">
                        {agent.recommendedAction}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        )}

        {/* SUB-OS TAB 3: REVENUE DAG ENGINE */}
        {activeTab === 'revenue_dag' && (
          <div className="space-y-6">
            <div className="flex items-center justify-between">
              <div>
                <h2 className="text-lg font-bold text-card-foreground flex items-center gap-2">
                  <Network className="w-5 h-5 text-brand" /> {t("admin_hybrid_rental_os_dag_title", "Directed Acyclic Graph (DAG) Gelir Boru Hattı")}
                </h2>
                <p className="text-xs text-muted-foreground">{t("admin_hybrid_rental_os_dag_desc", "Rezervasyon cirosundan vergi, ev sahibi payı, partner komisyonu ve Reservatior marjı dağıtım düğümleri")}</p>
              </div>
              <button
                onClick={handleRunRevenueDAG}
                disabled={loading}
                className="flex items-center gap-1.5 px-3.5 py-2 bg-brand/10 border border-brand/30 text-brand text-xs font-bold rounded-xl hover:bg-brand/20"
              >
                <RefreshCw className="w-3.5 h-3.5" /> {t("admin_hybrid_rental_os_rerun_dag", "DAG İşlemini Yeniden Çalıştır")}
              </button>
            </div>

            {dagResult && (
              <div className="space-y-4">
                <div className="bg-background p-4 rounded-2xl border border-border flex items-center justify-between text-xs font-mono">
                  <div>
                    <span className="text-muted-foreground">{t("admin_hybrid_rental_os_transaction_id", "İşlem ID:")}</span> <span className="text-brand font-bold">{dagResult.transactionId}</span>
                  </div>
                  <div>
                    <span className="text-muted-foreground">{t("admin_hybrid_rental_os_gross_revenue", "Brüt Ciro:")}</span> <span className="text-success font-bold">{formatCurrency(dagResult.grossRevenueTRY)}</span>
                  </div>
                  <div>
                    <span className="text-muted-foreground">{t("admin_hybrid_rental_os_ledger_hash", "Finansal Defter Kaydı Hash:")}</span> <span className="text-muted-foreground">{dagResult.ledgerCommitHash}</span>
                  </div>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                  {dagResult.dagNodes.map((node: any, idx: number) => (
                    <div key={idx} className="bg-card border border-border rounded-2xl p-4 space-y-2 relative overflow-hidden shadow-sm">
                      <div className="flex items-center justify-between">
                        <span className="text-[10px] font-mono text-brand font-bold bg-brand/10 px-2 py-0.5 rounded">
                          {node.nodeId}
                        </span>
                        <span className="text-xs font-extrabold text-card-foreground">%{node.percentageOfGross}</span>
                      </div>
                      <h4 className="text-xs font-bold text-card-foreground">{node.nodeName}</h4>
                      <div className="text-lg font-black text-success">{formatCurrency(node.amountTRY)}</div>
                      <p className="text-[10px] text-muted-foreground pt-1 border-t border-border">
                        {t("admin_hybrid_rental_os_target", "Hedef:")} <span className="font-semibold text-card-foreground">{node.outputDestination}</span>
                      </p>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        )}
      </div>
    </PageShell>
  );
}
