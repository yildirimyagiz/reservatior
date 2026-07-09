"use client";

import { useState } from "react";
import { useTranslation } from "react-i18next";
import {
  PieChart,
  Pie,
  Cell,
  Tooltip,
  ResponsiveContainer,
  Legend,
} from "recharts";
import {
  Calendar,
  CreditCard,
  Banknote,
  Shield,
  TrendingUp,
  CheckCircle2,
  Clock,
  AlertTriangle,
  ChevronRight,
  Zap,
} from "lucide-react";

// ── Types ─────────────────────────────────────────────────────────────────

type DepositStrategy = "FLEXIBLE_INSTALLMENT" | "INSURANCE_BACKED" | "TRADITIONAL_CASH";
type PaymentRail = "A2A_FAST" | "A2A_ACH" | "CARD_INSTALLMENT" | "CARD_DIRECT" | "WIRE";
type CycleStatus = "PENDING_CAPTURE" | "CAPTURED" | "IN_FLOAT" | "DISBURSED" | "FAILED";

interface CaptureCycle {
  cycle: number;
  captureDate: string;
  dueDate: string;
  statementDate: string;
  bufferDays: number;
}

interface SplitPreview {
  officeAmount: number;
  agentAmount: number;
  platformAmount: number;
  totalCommission: number;
}

// ── Constants ──────────────────────────────────────────────────────────────

const SPLIT_COLORS = {
  office: "#6366f1",
  agent: "#22d3ee",
  platform: "#f59e0b",
};

const RAIL_LABELS: Record<PaymentRail, string> = {
  A2A_FAST: "FAST / ÖHVPS (TR)",
  A2A_ACH: "ACH / FedNow (US)",
  CARD_INSTALLMENT: "Kredi Kartı Taksit",
  CARD_DIRECT: "Kredi Kartı",
  WIRE: "Havale / EFT",
};

const STRATEGY_LABELS: Record<DepositStrategy, string> = {
  FLEXIBLE_INSTALLMENT: "Taksitli Depozito (v2)",
  INSURANCE_BACKED: "Sigortalı Güvence",
  TRADITIONAL_CASH: "Nakit Depozito",
};

const STATUS_STYLES: Record<CycleStatus, { color: string; icon: typeof CheckCircle2; label: string }> = {
  PENDING_CAPTURE: { color: "text-zinc-400", icon: Clock, label: "Bekliyor" },
  CAPTURED:        { color: "text-blue-400", icon: CheckCircle2, label: "Yakalandı" },
  IN_FLOAT:        { color: "text-cyan-400", icon: TrendingUp, label: "Float'ta" },
  DISBURSED:       { color: "text-emerald-400", icon: CheckCircle2, label: "Ödendi" },
  FAILED:          { color: "text-red-400", icon: AlertTriangle, label: "Başarısız" },
};

// ── Utility ────────────────────────────────────────────────────────────────

function calcInstallment(total: number, count: number) {
  return Math.ceil((total / count) * 100) / 100;
}

function calcCaptureDates(moveIn: Date, cycles: number, captureDay: number): CaptureCycle[] {
  const result: CaptureCycle[] = [];
  for (let i = 0; i < cycles; i++) {
    const base = new Date(moveIn);
    base.setMonth(base.getMonth() + i);

    const captureDate = new Date(base);
    captureDate.setDate(captureDay);

    const dueDate = new Date(base);
    dueDate.setMonth(dueDate.getMonth() + 1);
    dueDate.setDate(moveIn.getDate());

    const statDate = new Date(captureDate);
    statDate.setMonth(statDate.getMonth() + 1);
    statDate.setDate(0);

    result.push({
      cycle: i + 1,
      captureDate: captureDate.toISOString().split("T")[0],
      dueDate: dueDate.toISOString().split("T")[0],
      statementDate: statDate.toISOString().split("T")[0],
      bufferDays: Math.ceil((dueDate.getTime() - captureDate.getTime()) / 86400000),
    });
  }
  return result;
}

// ── Main Component ─────────────────────────────────────────────────────────

export default function ContractFinancials() {
  const { t } = useTranslation();

  // Form state
  const [rentAmount, setRentAmount] = useState(5000);
  const [depositTotal, setDepositTotal] = useState(10000);
  const [commissionRateBps, setCommissionRateBps] = useState(700);
  const [depositInstallments, setDepositInstallments] = useState(6);
  const [depositStrategy, setDepositStrategy] = useState<DepositStrategy>("FLEXIBLE_INSTALLMENT");
  const [rentRail, setRentRail] = useState<PaymentRail>("A2A_FAST");
  const [depositRail, setDepositRail] = useState<PaymentRail>("CARD_INSTALLMENT");
  const [moveInDate, setMoveInDate] = useState("2025-05-04");
  const [captureDay, setCaptureDay] = useState(20);

  // Calculated values
  const commissionTotal = (rentAmount * commissionRateBps) / 10000;
  const depositPerCycle = calcInstallment(depositTotal, depositInstallments);
  const cardUtilizationPct = ((depositPerCycle / depositTotal) * 100).toFixed(1);

  const split: SplitPreview = {
    officeAmount: Math.round(commissionTotal * 0.35 * 100) / 100,
    agentAmount: Math.round(commissionTotal * 0.35 * 100) / 100,
    platformAmount: Math.round(commissionTotal * 0.30 * 100) / 100,
    totalCommission: commissionTotal,
  };

  const captureCycles = calcCaptureDates(
    new Date(moveInDate),
    depositInstallments,
    captureDay
  );

  const pieData = [
    { name: "Ofis (35%)", value: split.officeAmount },
    { name: "Acente (35%)", value: split.agentAmount },
    { name: "Platform (30%)", value: split.platformAmount },
  ];

  return (
    <div className="min-h-screen bg-[#0a0a0f] text-white p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center gap-3 mb-8">
        <div className="p-2 rounded-xl bg-indigo-500/20 border border-indigo-500/30">
          <Zap className="w-6 h-6 text-indigo-400" />
        </div>
        <div>
          <h1 className="text-2xl font-bold text-white">FinTech v2 — Hybrid Settlement</h1>
          <p className="text-zinc-400 text-sm">Depozito Taksitlendirme & 3'lü Komisyon Bölüşümü</p>
        </div>
      </div>

      <div className="grid grid-cols-1 xl:grid-cols-3 gap-6">
        {/* ── Left: Configuration ─────────────────────────────── */}
        <div className="xl:col-span-1 space-y-4">
          <div className="rounded-2xl border border-white/10 bg-white/5 backdrop-blur p-5 space-y-4">
            <h2 className="font-semibold text-white flex items-center gap-2">
              <CreditCard className="w-4 h-4 text-indigo-400" />
              Kira & Depozito
            </h2>

            <div className="space-y-3">
              <div>
                <label className="text-xs text-zinc-400 mb-1 block">Aylık Kira (₺)</label>
                <input
                  type="number"
                  value={rentAmount}
                  onChange={(e) => setRentAmount(Number(e.target.value))}
                  className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-white text-sm focus:border-indigo-500 outline-none"
                />
              </div>

              <div>
                <label className="text-xs text-zinc-400 mb-1 block">Toplam Depozito (₺)</label>
                <input
                  type="number"
                  value={depositTotal}
                  onChange={(e) => setDepositTotal(Number(e.target.value))}
                  className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-white text-sm focus:border-indigo-500 outline-none"
                />
              </div>

              <div>
                <label className="text-xs text-zinc-400 mb-1 block">Depozito Stratejisi</label>
                <select
                  value={depositStrategy}
                  onChange={(e) => setDepositStrategy(e.target.value as DepositStrategy)}
                  className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-white text-sm focus:border-indigo-500 outline-none"
                >
                  {Object.entries(STRATEGY_LABELS).map(([k, v]) => (
                    <option key={k} value={k} className="bg-zinc-900">{v}</option>
                  ))}
                </select>
              </div>

              <div>
                <label className="text-xs text-zinc-400 mb-1 block">Taksit Sayısı</label>
                <input
                  type="number"
                  min={1} max={24}
                  value={depositInstallments}
                  onChange={(e) => setDepositInstallments(Number(e.target.value))}
                  className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-white text-sm focus:border-indigo-500 outline-none"
                />
              </div>

              <div>
                <label className="text-xs text-zinc-400 mb-1 block">Kira Ödeme Kanalı</label>
                <select
                  value={rentRail}
                  onChange={(e) => setRentRail(e.target.value as PaymentRail)}
                  className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-white text-sm focus:border-indigo-500 outline-none"
                >
                  {Object.entries(RAIL_LABELS).map(([k, v]) => (
                    <option key={k} value={k} className="bg-zinc-900">{v}</option>
                  ))}
                </select>
              </div>

              <div>
                <label className="text-xs text-zinc-400 mb-1 block">Komisyon Oranı (bps)</label>
                <input
                  type="number"
                  value={commissionRateBps}
                  onChange={(e) => setCommissionRateBps(Number(e.target.value))}
                  className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-white text-sm focus:border-indigo-500 outline-none"
                />
                <p className="text-xs text-zinc-500 mt-1">{(commissionRateBps / 100).toFixed(1)}% = ₺{commissionTotal.toLocaleString("tr-TR", { maximumFractionDigits: 2 })}</p>
              </div>
            </div>
          </div>

          {/* Early Capture Config */}
          <div className="rounded-2xl border border-white/10 bg-white/5 backdrop-blur p-5 space-y-4">
            <h2 className="font-semibold text-white flex items-center gap-2">
              <Calendar className="w-4 h-4 text-cyan-400" />
              Early Capture Engine
            </h2>
            <div className="space-y-3">
              <div>
                <label className="text-xs text-zinc-400 mb-1 block">Taşınma Tarihi</label>
                <input
                  type="date"
                  value={moveInDate}
                  onChange={(e) => setMoveInDate(e.target.value)}
                  className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-white text-sm focus:border-indigo-500 outline-none"
                />
              </div>
              <div>
                <label className="text-xs text-zinc-400 mb-1 block">Capture Günü (Ayın)</label>
                <input
                  type="number"
                  min={1} max={28}
                  value={captureDay}
                  onChange={(e) => setCaptureDay(Number(e.target.value))}
                  className="w-full bg-white/5 border border-white/10 rounded-lg px-3 py-2 text-white text-sm focus:border-indigo-500 outline-none"
                />
              </div>
            </div>
          </div>
        </div>

        {/* ── Middle: Metrics & Split ─────────────────────────── */}
        <div className="xl:col-span-1 space-y-4">
          {/* Key Metrics */}
          <div className="grid grid-cols-2 gap-3">
            <div className="rounded-2xl border border-indigo-500/30 bg-indigo-500/10 p-4">
              <p className="text-xs text-indigo-300 mb-1">Kart Kullanım Yükü</p>
              <p className="text-2xl font-bold text-white">{cardUtilizationPct}%</p>
              <p className="text-xs text-zinc-400 mt-1">Taksit başına limit etkisi</p>
            </div>
            <div className="rounded-2xl border border-cyan-500/30 bg-cyan-500/10 p-4">
              <p className="text-xs text-cyan-300 mb-1">Taksit/Dönem</p>
              <p className="text-2xl font-bold text-white">₺{depositPerCycle.toLocaleString("tr-TR")}</p>
              <p className="text-xs text-zinc-400 mt-1">{depositInstallments} taksit</p>
            </div>
            <div className="rounded-2xl border border-amber-500/30 bg-amber-500/10 p-4">
              <p className="text-xs text-amber-300 mb-1">Float Süresi</p>
              <p className="text-2xl font-bold text-white">~15 gün</p>
              <p className="text-xs text-zinc-400 mt-1">0% interchange</p>
            </div>
            <div className="rounded-2xl border border-emerald-500/30 bg-emerald-500/10 p-4">
              <p className="text-xs text-emerald-300 mb-1">Platform Geliri</p>
              <p className="text-2xl font-bold text-white">₺{split.platformAmount.toLocaleString("tr-TR", { maximumFractionDigits: 0 })}</p>
              <p className="text-xs text-zinc-400 mt-1">Net, komisyonsuz</p>
            </div>
          </div>

          {/* Tri-Party Split Chart */}
          <div className="rounded-2xl border border-white/10 bg-white/5 backdrop-blur p-5">
            <h2 className="font-semibold text-white mb-4 flex items-center gap-2">
              <TrendingUp className="w-4 h-4 text-amber-400" />
              3'lü Komisyon Bölüşümü
            </h2>
            <ResponsiveContainer width="100%" height={200}>
              <PieChart>
                <Pie
                  data={pieData}
                  cx="50%"
                  cy="50%"
                  innerRadius={55}
                  outerRadius={85}
                  paddingAngle={3}
                  dataKey="value"
                >
                  <Cell fill={SPLIT_COLORS.office} />
                  <Cell fill={SPLIT_COLORS.agent} />
                  <Cell fill={SPLIT_COLORS.platform} />
                </Pie>
                <Tooltip
                  formatter={(val: number) => `₺${val.toLocaleString("tr-TR", { maximumFractionDigits: 2 })}`}
                  contentStyle={{ background: "#18181b", border: "1px solid #27272a", borderRadius: 8, color: "#fff" }}
                />
                <Legend formatter={(v) => <span className="text-xs text-zinc-300">{v}</span>} />
              </PieChart>
            </ResponsiveContainer>

            <div className="space-y-2 mt-2">
              {[
                { label: "Ofis", amount: split.officeAmount, color: SPLIT_COLORS.office, pct: "35%" },
                { label: "Acente", amount: split.agentAmount, color: SPLIT_COLORS.agent, pct: "35%" },
                { label: "Platform", amount: split.platformAmount, color: SPLIT_COLORS.platform, pct: "30%" },
              ].map((item) => (
                <div key={item.label} className="flex items-center justify-between text-sm">
                  <div className="flex items-center gap-2">
                    <div className="w-2.5 h-2.5 rounded-full" style={{ background: item.color }} />
                    <span className="text-zinc-300">{item.label} <span className="text-zinc-500">({item.pct})</span></span>
                  </div>
                  <span className="font-medium text-white">
                    ₺{item.amount.toLocaleString("tr-TR", { maximumFractionDigits: 2 })}
                  </span>
                </div>
              ))}
              <div className="border-t border-white/10 pt-2 flex justify-between text-sm font-semibold">
                <span className="text-zinc-300">Toplam Komisyon</span>
                <span className="text-white">₺{split.totalCommission.toLocaleString("tr-TR", { maximumFractionDigits: 2 })}</span>
              </div>
            </div>
          </div>
        </div>

        {/* ── Right: Capture Calendar ─────────────────────────── */}
        <div className="xl:col-span-1">
          <div className="rounded-2xl border border-white/10 bg-white/5 backdrop-blur p-5 h-full">
            <h2 className="font-semibold text-white mb-4 flex items-center gap-2">
              <Calendar className="w-4 h-4 text-indigo-400" />
              Early Capture Takvimi
            </h2>
            <div className="space-y-2 overflow-y-auto max-h-[480px] pr-1 scrollbar-thin scrollbar-track-transparent scrollbar-thumb-white/10">
              {captureCycles.map((cycle) => (
                <div
                  key={cycle.cycle}
                  className="rounded-xl border border-white/5 bg-white/5 p-3 hover:border-indigo-500/30 transition-colors"
                >
                  <div className="flex items-center justify-between mb-1">
                    <span className="text-xs font-semibold text-indigo-400">Taksit #{cycle.cycle}</span>
                    <span className="text-xs px-2 py-0.5 rounded-full bg-white/10 text-zinc-300">
                      {cycle.bufferDays}g buffer
                    </span>
                  </div>
                  <div className="grid grid-cols-2 gap-x-2 gap-y-1 text-xs">
                    <div>
                      <p className="text-zinc-500">Capture</p>
                      <p className="text-cyan-400 font-medium">{cycle.captureDate}</p>
                    </div>
                    <div>
                      <p className="text-zinc-500">Vade</p>
                      <p className="text-white font-medium">{cycle.dueDate}</p>
                    </div>
                    <div>
                      <p className="text-zinc-500">Ekstre</p>
                      <p className="text-zinc-300">{cycle.statementDate}</p>
                    </div>
                    <div>
                      <p className="text-zinc-500">Tutar</p>
                      <p className="text-amber-400 font-medium">₺{(rentAmount + depositPerCycle).toLocaleString("tr-TR", { maximumFractionDigits: 0 })}</p>
                    </div>
                  </div>
                </div>
              ))}
            </div>

            {/* Float Architecture Summary */}
            <div className="mt-4 rounded-xl border border-cyan-500/20 bg-cyan-500/5 p-3">
              <div className="flex items-center gap-2 mb-2">
                <Banknote className="w-4 h-4 text-cyan-400" />
                <span className="text-xs font-semibold text-cyan-400">Float Architecture</span>
              </div>
              <p className="text-xs text-zinc-400 leading-relaxed">
                Capture ({captureDay}. gün) → 14-15 gün gateway'de → Disbursement.
                Bu sürede gateway overnight repo geliri ile <strong className="text-cyan-300">interchange = %0</strong>.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
