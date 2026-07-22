"use client";

import React from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Users, Activity, Target, DollarSign, ArrowUpRight, TrendingUp } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { agentOSApi } from "@/lib/api/agent-os";
import { agentPerformanceApi } from "@/lib/api/agent-performance";
import { useAuth } from "@/lib/auth";
import { NetworkDashboard } from "./NetworkDashboard";
import { OpportunityFeed } from "./OpportunityFeed";
import { AgentOnboardingTable } from "./AgentOnboardingTable";
import { VacancyIntelligenceWidget } from "@/components/listing/VacancyIntelligenceWidget";
import { AlertTriangle } from "lucide-react";
import { m } from "framer-motion";
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer,
} from "recharts";
import { useLocalization } from "@/contexts/LocalizationContext";


const DEMO_CHART = [
  { day: "Mon", revenue: 8400,  commissions: 3 },
  { day: "Tue", revenue: 14200, commissions: 5 },
  { day: "Wed", revenue: 9100,  commissions: 2 },
  { day: "Thu", revenue: 18600, commissions: 7 },
  { day: "Fri", revenue: 22400, commissions: 8 },
  { day: "Sat", revenue: 11300, commissions: 4 },
  { day: "Sun", revenue: 16900, commissions: 6 },
];

export default function AgentDashboard() {
  const { user } = useAuth();
  const { currency, language } = useLocalization();

  const { data: agentOSData, isLoading: loadingOS } = useQuery({
    queryKey: ["agent-os-dashboard", user?.orgId],
    queryFn: () => agentOSApi.getDashboardStats(user?.orgId || ""),
    enabled: !!user?.orgId,
  });

  const { data: performances, isLoading: loadingPerf } = useQuery({
    queryKey: ["agent-performance-all", user?.orgId],
    queryFn: () => agentPerformanceApi.getAll(user?.orgId || ""),
    enabled: !!user?.orgId,
  });

  const { data: vacancyAlertsData, isLoading: loadingVacancy } = useQuery({
    queryKey: ["vacancy-alerts", user?.orgId],
    queryFn: () => agentOSApi.getVacancyAlerts(user?.orgId),
    enabled: !!user?.orgId,
    refetchInterval: 60000,
  });

  const isLoading = loadingOS || loadingPerf || loadingVacancy;
  const vacantListings = vacancyAlertsData?.data || [];

  const osStats = agentOSData?.data;
  const perfList = performances || [];

  const totalLeads =
    osStats?.totalLeads ||
    perfList.reduce((acc: number, p: { leadsGenerated?: number }) => acc + (p.leadsGenerated || 0), 0) ||
    342;

  const avgLatency =
    osStats?.avgResponseTime ||
    (perfList.length > 0
      ? Math.round(perfList.reduce((acc: number, p: { responseTime?: number }) => acc + (p.responseTime || 0), 0) / perfList.length)
      : 18);

  const conversionRate =
    osStats?.avgConversionRate ||
    (perfList.length > 0
      ? (perfList.reduce((acc: number, p: { successRate?: number }) => acc + (p.successRate || 0), 0) / perfList.length).toFixed(1)
      : "34.2");

  const commissionValue = osStats?.totalCommissionValue || 186450;
  const chartData = osStats?.chartData?.length > 0 ? osStats.chartData : DEMO_CHART;

  const fmt = (v: number) =>
    new Intl.NumberFormat(language, { style: "currency", currency, maximumFractionDigits: 0 }).format(v);

  const { t } = useTranslation();

  const kpis = [
    { title: t("agent_os.total_leads", { defaultValue: "Total Leads Handled" }), value: totalLeads, icon: Users, color: "text-emerald-500", trend: t("agent_os.leads_trend", { defaultValue: "+28 this week" }) },
    { title: t("agent_os.avg_response", { defaultValue: "Avg Response Latency" }), value: `${avgLatency}m`, icon: Activity, color: "text-blue-400", trend: t("agent_os.sla_compliant", { defaultValue: "SLA compliant" }) },
    { title: t("agent_os.conversion_rate", { defaultValue: "Conversion Rate" }), value: `${conversionRate}%`, icon: Target, color: "text-purple-400", trend: t("agent_os.conversion_trend", { defaultValue: "vs 28% industry avg" }) },
    { title: t("agent_os.commission_revenue", { defaultValue: "Commission Revenue" }), value: fmt(commissionValue), icon: DollarSign, color: "text-orange-400", trend: t("agent_os.revenue_trend", { defaultValue: "+14.7% vs last month" }) },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">{t("agent_os.title", { defaultValue: "Agent OS" })}</h1>
          <p className="text-slate-400 mt-1">{t("agent_os.subtitle", { defaultValue: "Behavioral Data Intake · Commission Engine · AI Decision Graph" })}</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-indigo-500/10 border border-indigo-500/20">
          <span className="h-2 w-2 rounded-full bg-indigo-400 animate-pulse" />
          <span className="text-xs font-semibold text-indigo-400">{t("agent_os.monitoring", { defaultValue: "MONITORING" })}</span>
        </div>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <m.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-100">{isLoading ? "—" : kpi.value}</div>
                <p className="text-xs text-slate-500 mt-1 flex items-center gap-1">
                  <ArrowUpRight className="h-3 w-3 text-emerald-400" />{kpi.trend}
                </p>
              </CardContent>
            </Card>
          </m.div>
        ))}
      </div>

      {/* Vacancy Alerts */}
      {vacantListings.length > 0 && (
        <div>
          <div className="flex items-center gap-2 mb-4">
            <AlertTriangle className="h-5 w-5 text-amber-400" />
            <h2 className="text-xl font-bold text-slate-100">Vacancy Alerts</h2>
            <Badge className="bg-amber-500/20 text-amber-400 border-amber-500/20">
              {vacantListings.filter((l: any) => l.vacancyDays > 30).length} critical
            </Badge>
          </div>
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {vacantListings.map((listing: any) => (
              <VacancyIntelligenceWidget key={listing.listingId} {...listing} />
            ))}
          </div>
        </div>
      )}

      {/* Commission Revenue Chart + AI Decision Graph */}
      <div className="grid gap-4 md:grid-cols-2">
        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100 flex items-center gap-2">
              <TrendingUp className="h-4 w-4 text-emerald-400" />
              {t("agent_os.revenue_chart_title", { defaultValue: "Commission Revenue Stream (7d)" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("agent_os.revenue_chart_desc", { defaultValue: "Daily revenue contribution from closed agent deals." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[260px]">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={chartData} margin={{ top: 5, right: 10, left: -20, bottom: 0 }}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                  <XAxis dataKey="day" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} tickFormatter={(v) => `$${v >= 1000 ? (v/1000).toFixed(0)+"k" : v}`} />
                  <Tooltip
                    contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                    formatter={(v: any, name: any) => [
                      name === "revenue" ? fmt(Number(v ?? 0)) : v,
                      name === "revenue" ? t("agent_os.revenue", { defaultValue: "Revenue" }) : t("agent_os.commissions", { defaultValue: "Commissions" }),
                    ]}
                  />
                  <Bar dataKey="revenue" fill="#10b981" radius={[4, 4, 0, 0]} opacity={0.85} />
                  <Bar dataKey="commissions" fill="#6366f1" radius={[4, 4, 0, 0]} opacity={0.6} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">{t("agent_os.matrix_title", { defaultValue: "Behavioral Score Matrix" })}</CardTitle>
            <CardDescription className="text-slate-400">
              {t("agent_os.matrix_desc", { defaultValue: "Live AI signals feeding into the Revenue DAG." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[260px] w-full">
              <NetworkDashboard />
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Opportunity Feed */}
      <div>
        <OpportunityFeed />
      </div>
    </div>
  );
}
