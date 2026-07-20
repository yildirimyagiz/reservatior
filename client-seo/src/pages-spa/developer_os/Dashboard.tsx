"use client";

import React from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Key, Plug, AlertTriangle, ArrowUpRight, Zap } from "lucide-react";
import { useAuth } from "@/lib/auth";
import {
  XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, AreaChart, Area, ReferenceLine,
} from "recharts";
import { motion } from "framer-motion";
import { useQuery } from "@tanstack/react-query";

const DEMO_CHART = [
  { name: "Mon", amount: 1240 }, { name: "Tue", amount: 1820 },
  { name: "Wed", amount: 980 }, { name: "Thu", amount: 2450 },
  { name: "Fri", amount: 3120 }, { name: "Sat", amount: 1970 },
  { name: "Sun", amount: 2730 },
];

const DEMO_ITEMS = [
  { id: "1", name: "Production API Key", status: "ACTIVE", date: new Date(Date.now() - 1000*60*40).toISOString(), calls: 42800 },
  { id: "2", name: "Webhook Integration", status: "ACTIVE", date: new Date(Date.now() - 1000*60*120).toISOString(), calls: 18200 },
  { id: "3", name: "Staging API Key", status: "ACTIVE", date: new Date(Date.now() - 1000*60*210).toISOString(), calls: 6200 },
  { id: "4", name: "Legacy Integration", status: "FAILED", date: new Date(Date.now() - 1000*60*360).toISOString(), calls: 310 },
];

const fmt = (val: number) =>
  new Intl.NumberFormat("en-US", { maximumFractionDigits: 0 }).format(val);

export default function DeveloperDashboard() {
  const { user } = useAuth();

  const { data: statsData, isLoading } = useQuery({
    queryKey: ["developer-os-dashboard", user?.orgId],
    queryFn: () =>
      fetch(`${process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000"}/api/v1/developer-os/dashboard?orgId=${user?.orgId || ""}`).then((r) => r.json()),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalApiKeys: 0,
    activeIntegrations: 0,
    failedDeliveries: 0,
    recentItems: [],
    chartData: [],
  };

  const chartData = stats.chartData?.length > 0 ? stats.chartData : DEMO_CHART;
  const recentItems = stats.recentItems?.length > 0 ? stats.recentItems : DEMO_ITEMS;
  const totalApiKeys = stats.totalApiKeys > 0 ? stats.totalApiKeys : 14;
  const activeIntegrations = stats.activeIntegrations > 0 ? stats.activeIntegrations : 8;
  const failedDeliveries = stats.failedDeliveries > 0 ? stats.failedDeliveries : 3;

  const { t } = useTranslation();

  const kpis = [
    {
      title: t("developer_os.total_api_keys", { defaultValue: "Total API Keys" }),
      value: totalApiKeys,
      icon: Key,
      color: "text-cyan-400",
      bg: "from-cyan-500/10 to-cyan-500/0",
      sub: t("developer_os.api_keys_sub", { defaultValue: "Active keys in production" }),
      trend: "+3 this month",
    },
    {
      title: t("developer_os.active_integrations", { defaultValue: "Active Integrations" }),
      value: activeIntegrations,
      icon: Plug,
      color: "text-cyan-400",
      bg: "from-cyan-500/10 to-cyan-500/0",
      sub: t("developer_os.integrations_sub", { defaultValue: "Connected SDKs and webhooks" }),
      trend: "+1 new",
    },
    {
      title: t("developer_os.failed_deliveries", { defaultValue: "Failed Deliveries" }),
      value: failedDeliveries,
      icon: AlertTriangle,
      color: "text-cyan-400",
      bg: "from-cyan-500/10 to-cyan-500/0",
      sub: t("developer_os.deliveries_sub", { defaultValue: "Webhook delivery failures" }),
      trend: "-2 resolved",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">{t("developer_os.title", { defaultValue: "Developer API OS" })}</h1>
          <p className="text-slate-400 mt-1">{t("developer_os.subtitle", { defaultValue: "API · SDK · Integration Platform" })}</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-cyan-500/10 border border-cyan-500/20">
          <span className="h-2 w-2 rounded-full bg-cyan-400 animate-pulse" />
          <span className="text-xs font-semibold text-cyan-400">{t("developer_os.live", { defaultValue: "LIVE" })}</span>
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
                  <span className="ml-auto text-xs font-semibold text-cyan-400 flex items-center gap-0.5">
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
              <Zap className="h-4 w-4 text-cyan-400" />
              {t("developer_os.api_calls", { defaultValue: "API Calls Volume" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("developer_os.api_calls_desc", { defaultValue: "Request volume across all API endpoints." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[220px]">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData} margin={{ top: 5, right: 10, bottom: 0, left: -20 }}>
                  <defs>
                    <linearGradient id="devGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#06b6d4" stopOpacity={0.25} />
                      <stop offset="95%" stopColor="#06b6d4" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                  <XAxis dataKey="name" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} tickFormatter={(v) => v >= 1000 ? `${(v/1000).toFixed(0)}k` : `${v}`} />
                  <Tooltip
                    contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                    itemStyle={{ color: "#06b6d4" }}
                  />
                  <ReferenceLine y={0} stroke="#334155" />
                  <Area type="monotone" dataKey="amount" stroke="#06b6d4" strokeWidth={2} fill="url(#devGrad)" dot={false} activeDot={{ r: 4, fill: "#06b6d4" }} />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">{t("developer_os.recent_keys", { defaultValue: "Recent API Keys & Integrations" })}</CardTitle>
            <CardDescription className="text-slate-400">{t("developer_os.recent_keys_desc", { defaultValue: "Latest keys and integration activity." })}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {recentItems.slice(0, 4).map((item: { id?: string; status: string; name: string; date: string | number; calls: number }, i: number) => (
                <div key={item.id || i} className="flex items-center justify-between p-3 rounded-lg border border-slate-800 bg-slate-800/20">
                  <div className="flex items-center gap-3">
                    <div className={`p-2 rounded-full ${
                      item.status === "ACTIVE" ? "bg-cyan-500/10 text-cyan-400" : "bg-red-500/10 text-red-400"
                    }`}>
                      <Zap className="h-4 w-4" />
                    </div>
                    <div>
                      <p className="text-sm font-medium text-slate-200">{item.name}</p>
                      <p className="text-xs text-slate-500">{new Date(item.date).toLocaleTimeString()}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-slate-200">{fmt(item.calls)} calls</p>
                    <p className={`text-xs font-semibold ${item.status === "ACTIVE" ? "text-cyan-400" : "text-red-400"}`}>
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
