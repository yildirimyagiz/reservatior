"use client";

import React from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { DollarSign, ShieldCheck, FileText, TrendingUp, ArrowUpRight, Zap } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { financeOSApi } from "@/lib/api/finance-os";
import { useAuth } from "@/lib/auth";
import {
  XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, AreaChart, Area, ReferenceLine,
} from "recharts";
import { motion } from "framer-motion";

const DEMO_CHART = [
  { name: "Mon", amount: 12400 }, { name: "Tue", amount: 18200 },
  { name: "Wed", amount: 9800 },  { name: "Thu", amount: 24500 },
  { name: "Fri", amount: 31200 }, { name: "Sat", amount: 19700 },
  { name: "Sun", amount: 27300 },
];

const DEMO_TRANSACTIONS = [
  { id: "1", amount: 8500,  status: "RELEASED",  date: new Date(Date.now() - 1000*60*40).toISOString(),  contractId: "RES-2041" },
  { id: "2", amount: 12000, status: "RELEASED",  date: new Date(Date.now() - 1000*60*120).toISOString(), contractId: "RES-2038" },
  { id: "3", amount: 6250,  status: "PENDING",   date: new Date(Date.now() - 1000*60*210).toISOString(), contractId: "RES-2036" },
  { id: "4", amount: 19000, status: "RELEASED",  date: new Date(Date.now() - 1000*60*360).toISOString(), contractId: "RES-2031" },
];

export default function FinanceDashboard() {
  const { user } = useAuth();

  const { data: statsData, isLoading } = useQuery({
    queryKey: ["finance-os-dashboard", user?.orgId],
    queryFn: () => financeOSApi.getDashboardStats(user?.orgId || ""),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalEscrowValue: 0,
    pendingPayouts: 0,
    activeContracts: 0,
    recentTransactions: [],
    chartData: [],
  };

  // Fallback to demo data for rich investor demo experience
  const chartData = stats.chartData?.length > 0 ? stats.chartData : DEMO_CHART;
  const transactions = stats.recentTransactions?.length > 0 ? stats.recentTransactions : DEMO_TRANSACTIONS;
  const escrowValue = stats.totalEscrowValue > 0 ? stats.totalEscrowValue : 284750;
  const pendingPayouts = stats.pendingPayouts > 0 ? stats.pendingPayouts : 96200;
  const activeContracts = stats.activeContracts > 0 ? stats.activeContracts : 14;

  const fmt = (val: number) =>
    new Intl.NumberFormat("en-US", { style: "currency", currency: "USD", maximumFractionDigits: 0 }).format(val);

  const kpis = [
    {
      title: "Total Escrow Value",
      value: fmt(escrowValue),
      icon: ShieldCheck,
      color: "text-emerald-500",
      bg: "from-emerald-500/10 to-emerald-500/0",
      sub: "Locked in smart state machine",
      trend: "+12.4%",
    },
    {
      title: "Pending Payouts",
      value: fmt(pendingPayouts),
      icon: DollarSign,
      color: "text-blue-400",
      bg: "from-blue-500/10 to-blue-500/0",
      sub: "Ready for settlement",
      trend: "+8.1%",
    },
    {
      title: "Active Contracts",
      value: activeContracts,
      icon: FileText,
      color: "text-purple-400",
      bg: "from-purple-500/10 to-purple-500/0",
      sub: "State machine currently active",
      trend: "+3 this week",
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">Finance OS</h1>
          <p className="text-slate-400 mt-1">Settlement Truth · Escrow Engine · Revenue DAG</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-emerald-500/10 border border-emerald-500/20">
          <span className="h-2 w-2 rounded-full bg-emerald-400 animate-pulse" />
          <span className="text-xs font-semibold text-emerald-400">LIVE</span>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid gap-4 md:grid-cols-3">
        {kpis.map((kpi, i) => (
          <motion.div
            key={kpi.title}
            initial={{ opacity: 0, y: 12 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: i * 0.08 }}
          >
            <Card className="bg-slate-900/60 border-slate-800 overflow-hidden relative">
              <div className={`absolute inset-0 bg-gradient-to-br ${kpi.bg} pointer-events-none`} />
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-100">{isLoading ? "—" : kpi.value}</div>
                <div className="flex items-center gap-2 mt-1">
                  <p className="text-xs text-slate-500">{kpi.sub}</p>
                  <span className="ml-auto text-xs font-semibold text-emerald-400 flex items-center gap-0.5">
                    <ArrowUpRight className="h-3 w-3" />{kpi.trend}
                  </span>
                </div>
              </CardContent>
            </Card>
          </motion.div>
        ))}
      </div>

      {/* Charts */}
      <div className="grid gap-4 md:grid-cols-2">
        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100 flex items-center gap-2">
              <Zap className="h-4 w-4 text-emerald-400" />
              Revenue Execution Stream
            </CardTitle>
            <CardDescription className="text-slate-400">
              Real-time settlement data feeding from the DAG.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[220px]">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData} margin={{ top: 5, right: 10, bottom: 0, left: -20 }}>
                  <defs>
                    <linearGradient id="finGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#10b981" stopOpacity={0.25} />
                      <stop offset="95%" stopColor="#10b981" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                  <XAxis dataKey="name" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} tickFormatter={(v) => `$${v >= 1000 ? (v/1000).toFixed(0)+'k' : v}`} />
                  <Tooltip
                    contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                    itemStyle={{ color: "#10b981" }}
                    formatter={(v: any) => [fmt(Number(v ?? 0)), "Settlement"]}
                  />
                  <ReferenceLine y={0} stroke="#334155" />
                  <Area type="monotone" dataKey="amount" stroke="#10b981" strokeWidth={2} fill="url(#finGrad)" dot={false} activeDot={{ r: 4, fill: "#10b981" }} />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100 flex items-center gap-2">
              <TrendingUp className="h-4 w-4 text-blue-400" />
              Recent Ledger Events
            </CardTitle>
            <CardDescription className="text-slate-400">
              Latest escrow releases and settlement actions.
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-3 max-h-[220px] overflow-auto pr-1">
              {transactions.map((tx: { id: string; amount: number; status: string; date: string; contractId: string }, i: number) => (
                <motion.div
                  key={tx.id}
                  initial={{ opacity: 0, x: -8 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: i * 0.06 }}
                  className="flex items-center justify-between p-3 bg-slate-800/60 rounded-lg border-l-2 border-emerald-500"
                >
                  <div>
                    <p className="text-sm font-medium text-slate-200">Escrow Release</p>
                    <p className="text-xs text-slate-500">
                      Contract #{tx.contractId} ·{" "}
                      <span className={tx.status === "RELEASED" ? "text-emerald-400" : "text-yellow-400"}>
                        {tx.status}
                      </span>
                    </p>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-emerald-400">+{fmt(tx.amount)}</p>
                    <p className="text-xs text-slate-500">
                      {new Date(tx.date).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })}
                    </p>
                  </div>
                </motion.div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
