"use client";

import React, { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { tEnum } from "@/lib/admin-enums";
import {
  Building2, Shield, TrendingUp, DollarSign, Brain, Zap, Target,
  Activity, ArrowUpRight, CheckCircle2, AlertTriangle, XCircle,
  FileCheck, Calculator, PieChart, Sparkles, Scale, RefreshCw,
  Info, ShieldCheck, ChevronRight, Users, Share2, Award, Copy,
  Check, FileText, Briefcase, UserCheck, CreditCard, Lock, Clock,
  ArrowRightLeft, Wallet
} from "lucide-react";
import { apiClient } from "@/lib/api";

export default function HybridRentalEngineDashboard() {
  const { t } = useTranslation();
  const [loading, setLoading] = useState(false);
  const [copiedOwner, setCopiedOwner] = useState(false);
  const [copiedPartner, setCopiedPartner] = useState(false);

  const [formData, setFormData] = useState({
    neighbourhood: "Beyoğlu",
    roomType: "Entire home/apt",
    accommodates: 4,
    bedrooms: 2,
    bathrooms: 1,
    sizeSqm: 85,
    buildingAge: 5,
    isFurnished: true,
    hasElevator: true,
    hasParking: false,
    hasPoolOrGym: false,
    proximityToMetroMins: 5,
    proximityToAirportMins: 35,
    hasBuildingConsent100Pct: true,
    hasTourismResidenceLicense: true,
    hasKabisRegistration: true,
    customLongTermRentMonthlyTRY: 35000,
    primaryPartnerRole: "PROPERTY_ACQUISITION",
    primaryPartnerId: "PARTNER-001",
  });

  const [evaluation, setEvaluation] = useState<any>(null);

  const handleEvaluate = async () => {
    setLoading(true);
    try {
      const res: any = await apiClient.post("/intelligence/hybrid-rental/evaluate", formData);
      if (res?.data?.data) {
        setEvaluation(res.data.data);
      }
    } catch (err) {
      console.error("Evaluation failed", err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    handleEvaluate();
  }, []);

  const formatCurrency = (val: number) => {
    return new Intl.NumberFormat("tr-TR", {
      style: "currency",
      currency: "TRY",
      maximumFractionDigits: 0,
    }).format(val || 0);
  };

  const copyToClipboard = (text: string, type: 'owner' | 'partner') => {
    navigator.clipboard.writeText(text);
    if (type === 'owner') {
      setCopiedOwner(true);
      setTimeout(() => setCopiedOwner(false), 2000);
    } else {
      setCopiedPartner(true);
      setTimeout(() => setCopiedPartner(false), 2000);
    }
  };

  const getModelBadge = (model: string) => {
    switch (model) {
      case "REVENUE_SHARE":
        return {
          label: t("admin_hybrid_rental_engine_model_revenue_share", "REVENUE SHARE MODEL (80-100 SKOR)"),
          sub: "Garanti Minimum Kira + %25 Performans Payı",
          color: "bg-blue-500/10 text-success border-blue-500/30",
          icon: Zap,
        };
      case "CORPORATE_MASTER_LEASE":
        return {
          label: t("admin_hybrid_rental_engine_model_master_lease", "CORPORATE MASTER LEASE MODEL (50-79 SKOR)"),
          sub: "Reservatior Kurumsal Kontrat + Sabit Marjlı Alt Kiralama",
          color: "bg-amber-500/10 text-warning border-amber-500/30",
          icon: Building2,
        };
      default:
        return {
          label: t("admin_hybrid_rental_engine_model_reject", "REJECT / DO NOT OPERATE (0-49 SKOR)"),
          sub: "Yetersiz Talep veya Mevzuat Engeli (7464 Kanun)",
          color: "bg-rose-500/10 text-rose-400 border-rose-500/30",
          icon: XCircle,
        };
    }
  };

  return (
    <PageShell title={t("admin_hybrid_rental_engine_page_title", "Hybrid Rental & Commission Architecture OS")}>
      <div className="space-y-6 animate-in fade-in duration-500">
        {/* Header Hero Banner */}
        <div className="relative overflow-hidden rounded-2xl bg-gradient-to-r from-slate-900 via-indigo-950 to-slate-900 p-6 border border-border shadow-2xl">
          <div className="absolute -right-10 -top-10 w-64 h-64 bg-brand/10 rounded-full blur-3xl pointer-events-none" />
          <div className="flex flex-col md:flex-row items-start md:items-center justify-between gap-4 relative z-10">
            <div>
              <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-brand/10 border border-brand/20 text-brand text-xs font-semibold uppercase tracking-wider mb-2">
                <Brain className="w-3.5 h-3.5" /> {t("admin_hybrid_rental_engine_badge", "PropTech + FinTech + AI Real Estate OS")}
              </div>
              <h1 className="text-2xl md:text-3xl font-extrabold text-white tracking-tight">
                {t("admin_hybrid_rental_engine_hero_title", "Reservatior Hybrid Rental & Partner Revenue Engine")}
              </h1>
              <p className="text-muted-foreground text-sm mt-1 max-w-2xl">
                Mülk değerlemesi, 7464 Mevzuat Kontrolü, Prisma `Commission` & `EscrowSplitConfig` Veritabanı Entegrasyonu ve Anında Avans (Commission Advance) Altyapısı.
              </p>
            </div>
            <button
              onClick={handleEvaluate}
              disabled={loading}
              className="flex items-center gap-2 px-5 py-2.5 bg-gradient-to-r from-brand/100 to-purple-600 hover:from-indigo-600 hover:to-purple-700 text-white text-sm font-semibold rounded-xl transition-all shadow-lg shadow-indigo-500/25 disabled:opacity-50"
            >
              {loading ? <RefreshCw className="w-4 h-4 animate-spin" /> : <Sparkles className="w-4 h-4" />}
              {t("admin_hybrid_rental_engine_reanalyze", "Yeniden Analiz Et & Teklif Üret")}
            </button>
          </div>
        </div>

        {/* Input Parameters Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Controls Form */}
          <div className="lg:col-span-1 bg-card rounded-2xl p-5 border border-border space-y-4 shadow-sm">
            <h2 className="text-base font-bold text-card-foreground flex items-center gap-2 border-b border-border pb-3">
              <Building2 className="w-4 h-4 text-brand" /> Mülk & Partner Parametreleri
            </h2>

            <div className="space-y-3 text-xs">
              {/* Partner Attribution Selection */}
              <div className="bg-brand/5 p-3 rounded-xl border border-brand/20 space-y-2">
                <label className="block text-brand font-bold flex items-center gap-1.5">
                  <Users className="w-3.5 h-3.5" /> Partner Attribution Katmanı
                </label>
                <select
                  value={formData.primaryPartnerRole}
                  onChange={(e) => setFormData({ ...formData, primaryPartnerRole: e.target.value })}
                  className="w-full bg-background border border-border rounded-lg px-2.5 py-1.5 text-card-foreground font-medium"
                >
                  <option value="PROPERTY_ACQUISITION">Emlak Danışmanı / Ofisi (Property Acquisition)</option>
                  <option value="COMMUNITY_REFERRAL">Site Görevlisi / Residence Partner (Community)</option>
                  <option value="CORPORATE_REFERRAL">{t("admin_hybrid_rental_engine_corporate_ref", "Expat HR / Relocation Acentesi (Corporate)")}</option>
                  <option value="PORTFOLIO_MANAGER">Stratejik Bölge Portföy Ortağı (Strategic)</option>
                  <option value="DIRECT_RESERVATIOR">Doğrudan Başvuru (Reservatior Direct - Aracısız)</option>
                </select>
              </div>

              <div>
                <label className="block text-muted-foreground mb-1 font-medium">İlçe / Bölge</label>
                <select
                  value={formData.neighbourhood}
                  onChange={(e) => setFormData({ ...formData, neighbourhood: e.target.value })}
                  className="w-full bg-background border border-border rounded-lg px-3 py-2 text-card-foreground font-medium"
                >
                  <option value="Beyoğlu">Beyoğlu (Taksim/Cihangir)</option>
                  <option value="Beşiktaş">Beşiktaş (Levent/Bebek)</option>
                  <option value="Kadıköy">Kadıköy (Moda/Caddebostan)</option>
                  <option value="Şişli">Şişli (Nişantaşı/Bomonti)</option>
                  <option value="Fatih">{t("admin_hybrid_rental_engine_fatih", "Fatih (Sultanahmet/Balat)")}</option>
                  <option value="Sarıyer">Sarıyer (Maslak/Zekeriyaköy)</option>
                  <option value="Ataşehir">Ataşehir (Finans Merkezi)</option>
                </select>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-muted-foreground mb-1 font-medium">Büyüklük (m²)</label>
                  <input
                    type="number"
                    value={formData.sizeSqm}
                    onChange={(e) => setFormData({ ...formData, sizeSqm: Number(e.target.value) })}
                    className="w-full bg-background border border-border rounded-lg px-3 py-2 text-card-foreground font-medium"
                  />
                </div>
                <div>
                  <label className="block text-muted-foreground mb-1 font-medium">Kişi Kapasitesi</label>
                  <input
                    type="number"
                    value={formData.accommodates}
                    onChange={(e) => setFormData({ ...formData, accommodates: Number(e.target.value) })}
                    className="w-full bg-background border border-border rounded-lg px-3 py-2 text-card-foreground font-medium"
                  />
                </div>
              </div>

              <div>
                <label className="block text-muted-foreground mb-1 font-medium">Tahmini Klasik Aylık Kira (TL)</label>
                <input
                  type="number"
                  value={formData.customLongTermRentMonthlyTRY}
                  onChange={(e) => setFormData({ ...formData, customLongTermRentMonthlyTRY: Number(e.target.value) })}
                  className="w-full bg-background border border-border rounded-lg px-3 py-2 text-card-foreground font-medium"
                />
              </div>

              {/* 7464 Compliance Checkboxes */}
              <div className="space-y-2 pt-3 border-t border-border bg-amber-500/5 p-3 rounded-xl border border-amber-500/20">
                <span className="text-xs font-bold text-amber-500 flex items-center gap-1">
                  <ShieldCheck className="w-3.5 h-3.5" /> 7464 Sayılı Kanun Mevzuat Kontrolü
                </span>
                <label className="flex items-center gap-2 cursor-pointer">
                  <input
                    type="checkbox"
                    checked={formData.hasBuildingConsent100Pct}
                    onChange={(e) => setFormData({ ...formData, hasBuildingConsent100Pct: e.target.checked })}
                    className="rounded text-amber-600 focus:ring-amber-500"
                  />
                  <span className="text-card-foreground text-[11px]">Kat Malikleri %100 Oybirliği Rızası</span>
                </label>
                <label className="flex items-center gap-2 cursor-pointer">
                  <input
                    type="checkbox"
                    checked={formData.hasTourismResidenceLicense}
                    onChange={(e) => setFormData({ ...formData, hasTourismResidenceLicense: e.target.checked })}
                    className="rounded text-amber-600 focus:ring-amber-500"
                  />
                  <span className="text-card-foreground text-[11px]">Turizm Konut Kiralama İzin Belgesi</span>
                </label>
              </div>
            </div>
          </div>

          {/* Model Decision & Output Section */}
          {evaluation && (
            <div className="lg:col-span-2 space-y-6">
              {/* Decision Badge Card */}
              {(() => {
                const badge = getModelBadge(evaluation.recommendedModel);
                const Icon = badge.icon;
                return (
                  <div className={`rounded-2xl p-5 border ${badge.color} shadow-lg relative overflow-hidden`}>
                    <div className="flex items-start justify-between">
                      <div>
                        <div className="flex items-center gap-2">
                          <Icon className="w-6 h-6" />
                          <span className="text-xs font-black uppercase tracking-wider">AI Karar Motoru Sonucu</span>
                        </div>
                        <h2 className="text-xl font-bold mt-1">{badge.label}</h2>
                        <p className="text-xs opacity-90 mt-1 max-w-xl">{evaluation.modelExplanation}</p>
                      </div>
                      <div className="text-right">
                        <span className="text-xs uppercase font-semibold text-muted-foreground">Genel Mülk Skoru</span>
                        <div className="text-3xl font-extrabold">{evaluation.scoreBreakdown.totalScore} / 100</div>
                      </div>
                    </div>
                  </div>
                );
              })()}

              {/* Prisma Model Integration Grid (Commission, Escrow, CommissionAdvance) */}
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                {/* Prisma Commission Record */}
                <div className="bg-card border border-border p-4 rounded-2xl space-y-2">
                  <div className="flex items-center justify-between border-b border-border pb-2">
                    <span className="text-xs font-bold text-card-foreground flex items-center gap-1">
                      <Calculator className="w-3.5 h-3.5 text-brand" /> {t("admin_hybrid_rental_engine_prisma_commission", "Prisma `Commission`")}
                    </span>
                    <span className="text-[10px] bg-brand/10 text-brand font-mono px-1.5 py-0.5 rounded">
                      {evaluation.commissionEngine.prismaCommissionRecord.collectionType}
                    </span>
                  </div>
                  <div className="space-y-1 text-xs">
                    <div className="flex justify-between text-muted-foreground">
                      <span>{t("admin_hybrid_rental_engine_base_amount", "Base Amount:")}</span>
                      <span className="font-bold text-card-foreground">{formatCurrency(evaluation.commissionEngine.prismaCommissionRecord.amountBase)}</span>
                    </div>
                    <div className="flex justify-between text-muted-foreground">
                      <span>{t("admin_hybrid_rental_engine_platform_rate", "Platform Rate / Fee:")}</span>
                      <span className="font-medium text-brand">%{evaluation.commissionEngine.prismaCommissionRecord.platformRate} ({formatCurrency(evaluation.commissionEngine.prismaCommissionRecord.platformFee)})</span>
                    </div>
                    <div className="flex justify-between text-muted-foreground">
                      <span>{t("admin_hybrid_rental_engine_partner_rate", "Partner Rate / Fee:")}</span>
                      <span className="font-medium text-success">%{evaluation.commissionEngine.prismaCommissionRecord.partnerRate} ({formatCurrency(evaluation.commissionEngine.prismaCommissionRecord.partnerFee)})</span>
                    </div>
                    <div className="flex justify-between text-muted-foreground">
                      <span>{t("admin_hybrid_rental_engine_accommodation_tax", "Accommodation Tax (%2):")}</span>
                      <span className="font-medium text-rose-400">{formatCurrency(evaluation.commissionEngine.prismaCommissionRecord.taxAmount)}</span>
                    </div>
                  </div>
                </div>

                {/* Prisma EscrowSplitConfig */}
                <div className="bg-card border border-border p-4 rounded-2xl space-y-2">
                  <div className="flex items-center justify-between border-b border-border pb-2">
                    <span className="text-xs font-bold text-card-foreground flex items-center gap-1">
                      <Lock className="w-3.5 h-3.5 text-amber-500" /> {t("admin_hybrid_rental_engine_escrow_split", "`EscrowSplitConfig`")}
                    </span>
                    <span className="text-[10px] bg-amber-500/10 text-warning font-mono px-1.5 py-0.5 rounded">
                      {evaluation.commissionEngine.prismaEscrowSplitConfig.blockageDays} {t("admin_hybrid_rental_engine_days_block", "Days Block")}
                    </span>
                  </div>
                  <div className="space-y-1 text-xs">
                    <div className="flex justify-between text-muted-foreground">
                      <span>{t("admin_hybrid_rental_engine_agent_payout_rate", "Agent Payout Rate:")}</span>
                      <span className="font-bold text-card-foreground">%{evaluation.commissionEngine.prismaEscrowSplitConfig.agentPayoutRate.toFixed(1)}</span>
                    </div>
                    <div className="flex justify-between text-muted-foreground">
                      <span>{t("admin_hybrid_rental_engine_reservatior_take_rate", "Reservatior Take Rate:")}</span>
                      <span className="font-bold text-brand">%{evaluation.commissionEngine.prismaEscrowSplitConfig.reservatiorFeeRate.toFixed(1)}</span>
                    </div>
                    <div className="flex justify-between text-muted-foreground">
                      <span>{t("admin_hybrid_rental_engine_upfront_installments", "Upfront / Installments:")}</span>
                      <span className="font-medium">%{evaluation.commissionEngine.prismaEscrowSplitConfig.upfrontPercent} / {evaluation.commissionEngine.prismaEscrowSplitConfig.installmentCount} {t("admin_hybrid_rental_engine_installments", "Taksit")}</span>
                    </div>
                  </div>
                </div>

                {/* Prisma CommissionAdvance */}
                <div className="bg-card border border-border p-4 rounded-2xl space-y-2">
                  <div className="flex items-center justify-between border-b border-border pb-2">
                    <span className="text-xs font-bold text-card-foreground flex items-center gap-1">
                      <Wallet className="w-3.5 h-3.5 text-success" /> {t("admin_hybrid_rental_engine_commission_advance", "`CommissionAdvance`")}
                    </span>
                    <span className={`text-[10px] px-1.5 py-0.5 rounded font-mono font-bold ${
                      evaluation.commissionEngine.prismaCommissionAdvance.isEligible ? "bg-blue-500/10 text-success" : "bg-rose-500/10 text-rose-400"
                    }`}>
                      {evaluation.commissionEngine.prismaCommissionAdvance.isEligible ? t("admin_hybrid_rental_engine_instant_eligible", "INSTANT ELIGIBLE") : t("admin_hybrid_rental_engine_not_eligible", "NOT ELIGIBLE")}
                    </span>
                  </div>
                  <div className="space-y-1 text-xs">
                    <div className="flex justify-between text-muted-foreground">
                      <span>{t("admin_hybrid_rental_engine_advance_amount", "Avans Tutar:")}</span>
                      <span className="font-bold text-card-foreground">{formatCurrency(evaluation.commissionEngine.prismaCommissionAdvance.originalAmount)}</span>
                    </div>
                    <div className="flex justify-between text-muted-foreground">
                      <span>{t("admin_hybrid_rental_engine_advance_service_fee", "Avans Hizmet Bedeli (%5):")}</span>
                      <span className="font-medium text-rose-400">- {formatCurrency(evaluation.commissionEngine.prismaCommissionAdvance.feeAmount)}</span>
                    </div>
                    <div className="flex justify-between text-muted-foreground pt-1 border-t border-border">
                      <span className="font-bold text-success">{t("admin_hybrid_rental_engine_instant_payout", "Anında Ödenen (Payout):")}</span>
                      <span className="font-extrabold text-success">{formatCurrency(evaluation.commissionEngine.prismaCommissionAdvance.payoutAmount)}</span>
                    </div>
                  </div>
                </div>
              </div>

              {/* Partner Commission Split Card */}
              <div className="bg-card border border-border rounded-2xl p-5 space-y-4 shadow-sm">
                <div className="flex items-center justify-between border-b border-border pb-3">
                  <h3 className="text-base font-bold text-card-foreground flex items-center gap-2">
                    <Share2 className="w-5 h-5 text-brand" /> {t("admin_hybrid_rental_engine_split_attribution", "Partner Commission Split & Attribution Motoru")}
                  </h3>
                  <span className="text-xs bg-brand/10 text-brand border border-brand/30 px-2.5 py-1 rounded-full font-bold">
                    {t("admin_hybrid_rental_engine_tier", "Tier:")} {evaluation.partnerAttribution.primaryPartnerTier}
                  </span>
                </div>

                {/* Splits Table */}
                <div className="space-y-2 text-xs">
                  <span className="font-bold text-card-foreground block">{t("admin_hybrid_rental_engine_split_ledger", "İşlem Dağıtım Matrisi (Split Ledger):")}</span>
                  <div className="space-y-2">
                    {evaluation.commissionEngine.splits.map((split: any, idx: number) => (
                      <div key={idx} className="flex items-center justify-between p-2.5 rounded-xl bg-background border border-border">
                        <div className="space-y-0.5">
                          <span className="font-bold text-card-foreground block">{split.roleLabel}</span>
                          <span className="text-[11px] text-muted-foreground">{split.explanation}</span>
                        </div>
                        <div className="text-right">
                          <span className="font-extrabold text-brand block">%{split.percentage} ({formatCurrency(split.amountTRY)})</span>
                          <span className="text-[10px] text-muted-foreground">{split.partnerName}</span>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              {/* AI Proposal Generator */}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {/* Owner Pitch Box */}
                <div className="bg-card border border-border rounded-2xl p-4 space-y-3">
                  <div className="flex items-center justify-between border-b border-border pb-2">
                    <span className="text-xs font-bold text-card-foreground flex items-center gap-1.5">
                      <FileText className="w-4 h-4 text-success" /> {t("admin_hybrid_rental_engine_owner_pitch", "AI Ev Sahibi Teklif Metni (Owner Pitch)")}
                    </span>
                    <button
                      onClick={() => copyToClipboard(evaluation.aiProposalGenerator.ownerPitch.pitchSummaryText, 'owner')}
                      className="text-[11px] flex items-center gap-1 text-success hover:underline font-medium"
                    >
                      {copiedOwner ? <Check className="w-3 h-3" /> : <Copy className="w-3 h-3" />}
                      {copiedOwner ? "Kopyalandı!" : "Metni Kopyala"}
                    </button>
                  </div>
                  <h4 className="text-xs font-bold text-success">{evaluation.aiProposalGenerator.ownerPitch.headline}</h4>
                  <p className="text-[11px] text-muted-foreground bg-muted/40 p-2.5 rounded-xl leading-relaxed">
                    {evaluation.aiProposalGenerator.ownerPitch.pitchSummaryText}
                  </p>
                </div>

                {/* Partner Pitch Box */}
                <div className="bg-card border border-border rounded-2xl p-4 space-y-3">
                  <div className="flex items-center justify-between border-b border-border pb-2">
                    <span className="text-xs font-bold text-card-foreground flex items-center gap-1.5">
                      <Briefcase className="w-4 h-4 text-brand" /> {t("admin_hybrid_rental_engine_partner_proposal", "AI Partner Teklif Metni (Partner Proposal)")}
                    </span>
                    <button
                      onClick={() => copyToClipboard(evaluation.aiProposalGenerator.partnerProposal.valueProposition, 'partner')}
                      className="text-[11px] flex items-center gap-1 text-brand hover:underline font-medium"
                    >
                      {copiedPartner ? <Check className="w-3 h-3" /> : <Copy className="w-3 h-3" />}
                      {copiedPartner ? "Kopyalandı!" : "Metni Kopyala"}
                    </button>
                  </div>
                  <h4 className="text-xs font-bold text-brand">{evaluation.aiProposalGenerator.partnerProposal.headline}</h4>
                  <p className="text-[11px] text-muted-foreground bg-muted/40 p-2.5 rounded-xl leading-relaxed">
                    {evaluation.aiProposalGenerator.partnerProposal.valueProposition}
                  </p>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    </PageShell>
  );
}
