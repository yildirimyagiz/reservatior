"use client";

import React from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { BarChart3, FileText, LayoutDashboard, ArrowUpRight, Zap } from "lucide-react";
import { useAuth } from "@/lib/auth";
import {
  XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, AreaChart, Area, ReferenceLine,
} from "recharts";
import { motion } from "framer-motion";
import { useQuery } from "@tanstack/react-query";

const DEMO_CHART = [
  { name: "Mon", amount: 320 }, { name: "Tue", amount: 480 },
  { name: "Wed", amount: 290 }, { name: "Thu", amount: 560 },
  { name: "Fri", amount: 710 }, { name: "Sat", amount: 430 },
  { name: "Sun", amount: 620 },
];

const DEMO_ITEMS = [
  { id: "1", name: "Revenue Dashboard", status: "ACTIVE", date: new Date(Date.now() - 1000*60*40).toISOString(), type: "DASHBOARD" },
  { id: "2", name: "Monthly KPI Report", status: "ACTIVE", date: new Date(Date.now() - 1000*60*120).toISOString(), type: "REPORT" },
  { id: "3", name: "User Activity Widget", status: "ACTIVE", date: new Date(Date.now() - 1000*60*210).toISOString(), type: "WIDGET" },
  { id: "4", name: "Conversion Funnel", status: "DRAFT", date: new Date(Date.now() - 1000*60*360).toISOString(), type: "ANALYSIS" },
];

export default function AnalyticsDashboard() {
  const { user } = useAuth();

  const { data: statsData, isLoading } = useQuery({
    queryKey: ["analytics-os-dashboard", user?.orgId],
    queryFn: () =>
      fetch(`${process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000"}/api/v1/analytics-os/dashboard?orgId=${user?.orgId || ""}`).then((r) => r.json()),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalAnalytics: 0,
    reportCount: 0,
    activeWidgets: 0,
    recentItems: [],
    chartData: [],
  };

  const chartData = stats.chartData?.length > 0 ? stats.chartData : DEMO_CHART;
  const recentItems = stats.recentItems?.length > 0 ? stats.recentItems : DEMO_ITEMS;
  const totalAnalytics = stats.totalAnalytics > 0 ? stats.totalAnalytics : 47;
  const reportCount = stats.reportCount > 0 ? stats.reportCount : 23;
  const activeWidgets = stats.activeWidgets > 0 ? stats.activeWidgets : 16;

  const { t } = useTranslation();

  const kpis = [
    {
      title: t("analytics_os.total_analytics", { defaultValue: "Total Analytics" }),
      value: totalAnalytics,
      icon: BarChart3,
      color: "text-violet-400",
      bg: "from-violet-500/10 to-violet-500/0",
      sub: t("analytics_os.analytics_sub", { defaultValue: "Active analytics configurations" }),
      trend: "+8 this week",
    },
    {
      title: t("analytics_os.report_count", { defaultValue: "Report Count" }),
      value: reportCount,
      icon: FileText,
      color: "text-violet-400",
      bg: "from-violet-500/10 to-violet-500/0",
      sub: t("analytics_os.report_sub", { defaultValue: "Generated reports this month" }),
      trend: "+5 new",
    },
    {
      title: t("analytics_os.active_widgets", { defaultValue: "Active Widgets" }),
      value: activeWidgets,
      icon: LayoutDashboard,
      color: "text-violet-400",
      bg: "from-violet-500/10 to-violet-500/0",
      sub: t("analytics_os.widget_sub", { defaultValue: "Dashboard widgets live" }),
      trend: "+3 deployed",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">{t("analytics_os.title", { defaultValue: "Analytics OS" })}</h1>
          <p className="text-slate-400 mt-1">{t("analytics_os.subtitle", { defaultValue: "BI · KPI · Reporting · Analysis" })}</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-violet-500/10 border border-violet-500/20">
          <span className="h-2 w-2 rounded-full bg-violet-400 animate-pulse" />
          <span className="text-xs font-semibold text-violet-400">{t("analytics_os.live", { defaultValue: "LIVE" })}</span>
        </div>
      </div>

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
                  <span className="ml-auto text-xs font-semibold text-violet-400 flex items-center gap-0.5">
                    <ArrowUpRight className="h-3 w-3" />{kpi.trend}
                  </span>
                </div>
              </CardContent>
            </Card>
          </motion.div>
        ))}
      </div>

      <div className="grid gap-4 md:grid-cols-2">
        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100 flex items-center gap-2">
              <Zap className="h-4 w-4 text-violet-400" />
              {t("analytics_os.data_volume", { defaultValue: "Data Processing Volume" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("analytics_os.data_volume_desc", { defaultValue: "Events processed for analytics pipelines." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[220px]">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData} margin={{ top: 5, right: 10, bottom: 0, left: -20 }}>
                  <defs>
                    <linearGradient id="analyticsGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#8b5cf6" stopOpacity={0.25} />
                      <stop offset="95%" stopColor="#8b5cf6" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                  <XAxis dataKey="name" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <Tooltip
                    contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                    itemStyle={{ color: "#8b5cf6" }}
                  />
                  <ReferenceLine y={0} stroke="#334155" />
                  <Area type="monotone" dataKey="amount" stroke="#8b5cf6" strokeWidth={2} fill="url(#analyticsGrad)" dot={false} activeDot={{ r: 4, fill: "#8b5cf6" }} />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">{t("analytics_os.recent_items", { defaultValue: "Recent Analytics Assets" })}</CardTitle>
            <CardDescription className="text-slate-400">{t("analytics_os.recent_items_desc", { defaultValue: "Latest reports, dashboards and widgets." })}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {recentItems.slice(0, 4).map((item: { id?: string; status: string; name: string; date: string | number; type: string }, i: number) => (
                <div key={item.id || i} className="flex items-center justify-between p-3 rounded-lg border border-slate-800 bg-slate-800/20">
                  <div className="flex items-center gap-3">
                    <div className={`p-2 rounded-full ${
                      item.status === "ACTIVE" ? "bg-violet-500/10 text-violet-400" : "bg-slate-500/10 text-slate-400"
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
                    <p className={`text-xs font-semibold ${item.status === "ACTIVE" ? "text-violet-400" : "text-slate-400"}`}>
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
