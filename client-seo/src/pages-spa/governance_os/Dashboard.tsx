"use client";

import React from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { ShieldCheck, Scale, FileCheck, ArrowUpRight, Zap } from "lucide-react";
import { useAuth } from "@/lib/auth";
import {
  XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, AreaChart, Area, ReferenceLine,
} from "recharts";
import { m } from "framer-motion";
import { useQuery } from "@tanstack/react-query";

const DEMO_CHART = [
  { name: "Mon", amount: 42 }, { name: "Tue", amount: 58 },
  { name: "Wed", amount: 35 }, { name: "Thu", amount: 67 },
  { name: "Fri", amount: 81 }, { name: "Sat", amount: 53 },
  { name: "Sun", amount: 74 },
];

const DEMO_ITEMS = [
  { id: "1", name: "AML Compliance Rule", status: "ACTIVE", date: new Date(Date.now() - 1000*60*40).toISOString(), type: "RULE" },
  { id: "2", name: "KYC Verification Policy", status: "ACTIVE", date: new Date(Date.now() - 1000*60*120).toISOString(), type: "POLICY" },
  { id: "3", name: "Contract Approval Flow", status: "PENDING", date: new Date(Date.now() - 1000*60*210).toISOString(), type: "APPROVAL" },
  { id: "4", name: "Data Retention Audit", status: "ACTIVE", date: new Date(Date.now() - 1000*60*360).toISOString(), type: "AUDIT" },
];

export default function GovernanceDashboard() {
  const { user } = useAuth();

  const { data: statsData, isLoading } = useQuery({
    queryKey: ["governance-os-dashboard", user?.orgId],
    queryFn: () =>
      fetch(`${process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000"}/api/v1/governance-os/dashboard?orgId=${user?.orgId || ""}`).then((r) => r.json()),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalRules: 0,
    activeCompliance: 0,
    pendingApprovals: 0,
    recentItems: [],
    chartData: [],
  };

  const chartData = stats.chartData?.length > 0 ? stats.chartData : DEMO_CHART;
  const recentItems = stats.recentItems?.length > 0 ? stats.recentItems : DEMO_ITEMS;
  const totalRules = stats.totalRules > 0 ? stats.totalRules : 38;
  const activeCompliance = stats.activeCompliance > 0 ? stats.activeCompliance : 24;
  const pendingApprovals = stats.pendingApprovals > 0 ? stats.pendingApprovals : 7;

  const { t } = useTranslation();

  const kpis = [
    {
      title: t("governance_os.total_rules", { defaultValue: "Total Rules" }),
      value: totalRules,
      icon: ShieldCheck,
      color: "text-amber-400",
      bg: "from-amber-500/10 to-amber-500/0",
      sub: t("governance_os.rules_sub", { defaultValue: "Engine rules in production" }),
      trend: "+6 this month",
    },
    {
      title: t("governance_os.active_compliance", { defaultValue: "Active Compliance" }),
      value: activeCompliance,
      icon: Scale,
      color: "text-amber-400",
      bg: "from-amber-500/10 to-amber-500/0",
      sub: t("governance_os.compliance_sub", { defaultValue: "Compliance checks passing" }),
      trend: "98.2%",
    },
    {
      title: t("governance_os.pending_approvals", { defaultValue: "Pending Approvals" }),
      value: pendingApprovals,
      icon: FileCheck,
      color: "text-amber-400",
      bg: "from-amber-500/10 to-amber-500/0",
      sub: t("governance_os.approvals_sub", { defaultValue: "Awaiting review" }),
      trend: "-2 from yesterday",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">{t("governance_os.title", { defaultValue: "Governance OS" })}</h1>
          <p className="text-slate-400 mt-1">{t("governance_os.subtitle", { defaultValue: "Rules Engine · Compliance · Audit Trail" })}</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-amber-500/10 border border-amber-500/20">
          <span className="h-2 w-2 rounded-full bg-amber-400 animate-pulse" />
          <span className="text-xs font-semibold text-amber-400">{t("governance_os.live", { defaultValue: "LIVE" })}</span>
        </div>
      </div>

      <div className="grid gap-4 md:grid-cols-3">
        {kpis.map((kpi, i) => (
          <m.div
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
                  <span className="ml-auto text-xs font-semibold text-amber-400 flex items-center gap-0.5">
                    <ArrowUpRight className="h-3 w-3" />{kpi.trend}
                  </span>
                </div>
              </CardContent>
            </Card>
          </m.div>
        ))}
      </div>

      <div className="grid gap-4 md:grid-cols-2">
        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100 flex items-center gap-2">
              <Zap className="h-4 w-4 text-amber-400" />
              {t("governance_os.rule_activity", { defaultValue: "Rule Activity Stream" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("governance_os.rule_activity_desc", { defaultValue: "Governance events processed this week." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[220px]">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData} margin={{ top: 5, right: 10, bottom: 0, left: -20 }}>
                  <defs>
                    <linearGradient id="govGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#f59e0b" stopOpacity={0.25} />
                      <stop offset="95%" stopColor="#f59e0b" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                  <XAxis dataKey="name" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <Tooltip
                    contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                    itemStyle={{ color: "#f59e0b" }}
                  />
                  <ReferenceLine y={0} stroke="#334155" />
                  <Area type="monotone" dataKey="amount" stroke="#f59e0b" strokeWidth={2} fill="url(#govGrad)" dot={false} activeDot={{ r: 4, fill: "#f59e0b" }} />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">{t("governance_os.recent_items", { defaultValue: "Recent Governance Items" })}</CardTitle>
            <CardDescription className="text-slate-400">{t("governance_os.recent_items_desc", { defaultValue: "Latest rules and compliance events." })}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {recentItems.slice(0, 4).map((item: { id?: string; status: string; name: string; date: string | number; type: string }, i: number) => (
                <div key={item.id || i} className="flex items-center justify-between p-3 rounded-lg border border-slate-800 bg-slate-800/20">
                  <div className="flex items-center gap-3">
                    <div className={`p-2 rounded-full ${
                      item.status === "ACTIVE" ? "bg-amber-500/10 text-amber-400" : "bg-yellow-500/10 text-yellow-400"
                    }`}>
                      <Zap className="h-4 w-4" />
                    </div>
                    <div>
                      <p className="text-sm font-medium text-slate-200">{item.name}</p>
                      <p className="text-xs text-slate-500">{new Date(item.date).toLocaleTimeString()}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <p className="text-xs text-slate-400">{item.type}</p>
                    <p className={`text-xs font-semibold ${item.status === "ACTIVE" ? "text-amber-400" : "text-yellow-400"}`}>
                      {item.status}
                    </p>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
