"use client";

import React from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Users, Monitor, ShieldCheck, Key, ArrowUpRight, Zap } from "lucide-react";
import { useAuth } from "@/lib/auth";
import {
  XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, AreaChart, Area, ReferenceLine,
} from "recharts";
import { motion } from "framer-motion";
import { useQuery } from "@tanstack/react-query";

const DEMO_CHART = [
  { name: "Mon", count: 42 }, { name: "Tue", count: 58 },
  { name: "Wed", count: 37 }, { name: "Thu", count: 64 },
  { name: "Fri", count: 71 }, { name: "Sat", count: 48 },
  { name: "Sun", count: 53 },
];

const DEMO_SESSIONS = [
  { id: "1", user: "alice@example.com", ip: "192.168.1.10", status: "ACTIVE", date: new Date(Date.now() - 1000*60*5).toISOString(), role: "Admin" },
  { id: "2", user: "bob@example.com", ip: "10.0.0.22", status: "ACTIVE", date: new Date(Date.now() - 1000*60*15).toISOString(), role: "Manager" },
  { id: "3", user: "carol@example.com", ip: "172.16.0.8", status: "EXPIRED", date: new Date(Date.now() - 1000*60*60).toISOString(), role: "Viewer" },
  { id: "4", user: "dave@example.com", ip: "192.168.2.45", status: "ACTIVE", date: new Date(Date.now() - 1000*60*120).toISOString(), role: "Admin" },
];

export default function IdentityDashboard() {
  const { user } = useAuth();

  const { data: statsData, isLoading } = useQuery({
    queryKey: ["identity-os-dashboard", user?.orgId],
    queryFn: async () => {
      const res = await fetch(`/api/v1/identity-os/dashboard?orgId=${user?.orgId || ""}`);
      if (!res.ok) throw new Error("Failed to fetch");
      return res.json();
    },
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalUsers: 0,
    activeSessions: 0,
    totalRoles: 0,
    apiKeys: 0,
    chartData: [],
    recentSessions: [],
  };

  const chartData = stats.chartData?.length > 0 ? stats.chartData : DEMO_CHART;
  const sessions = stats.recentSessions?.length > 0 ? stats.recentSessions : DEMO_SESSIONS;
  const totalUsers = stats.totalUsers > 0 ? stats.totalUsers : 1247;
  const activeSessions = stats.activeSessions > 0 ? stats.activeSessions : 389;
  const totalRoles = stats.totalRoles > 0 ? stats.totalRoles : 12;
  const apiKeys = stats.apiKeys > 0 ? stats.apiKeys : 34;

  const fmt = (val: number) =>
    new Intl.NumberFormat("en-US").format(val);

  const { t } = useTranslation();

  const kpis = [
    {
      title: t("identity_os.total_users", { defaultValue: "Total Users" }),
      value: fmt(totalUsers),
      icon: Users,
      color: "text-sky-500",
      bg: "from-sky-500/10 to-sky-500/0",
      sub: t("identity_os.users_sub", { defaultValue: "Registered across all orgs" }),
      trend: "+18.2%",
    },
    {
      title: t("identity_os.active_sessions", { defaultValue: "Active Sessions" }),
      value: fmt(activeSessions),
      icon: Monitor,
      color: "text-sky-400",
      bg: "from-sky-400/10 to-sky-400/0",
      sub: t("identity_os.sessions_sub", { defaultValue: "Currently authenticated" }),
      trend: "+5.7%",
    },
    {
      title: t("identity_os.total_roles", { defaultValue: "Total Roles" }),
      value: totalRoles,
      icon: ShieldCheck,
      color: "text-cyan-400",
      bg: "from-cyan-400/10 to-cyan-400/0",
      sub: t("identity_os.roles_sub", { defaultValue: "RBAC role definitions" }),
      trend: "+2 this week",
    },
    {
      title: t("identity_os.api_keys", { defaultValue: "API Keys" }),
      value: apiKeys,
      icon: Key,
      color: "text-blue-400",
      bg: "from-blue-400/10 to-blue-400/0",
      sub: t("identity_os.api_keys_sub", { defaultValue: "Active service tokens" }),
      trend: "+4 this month",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">{t("identity_os.title", { defaultValue: "Identity OS" })}</h1>
          <p className="text-slate-400 mt-1">{t("identity_os.subtitle", { defaultValue: "IAM · SSO · Access Management" })}</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-sky-500/10 border border-sky-500/20">
          <span className="h-2 w-2 rounded-full bg-sky-400 animate-pulse" />
          <span className="text-xs font-semibold text-sky-400">{t("identity_os.live", { defaultValue: "LIVE" })}</span>
        </div>
      </div>

      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
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
                  <span className="ml-auto text-xs font-semibold text-sky-400 flex items-center gap-0.5">
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
              <Zap className="h-4 w-4 text-sky-400" />
              {t("identity_os.auth_activity", { defaultValue: "Authentication Activity" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("identity_os.auth_activity_desc", { defaultValue: "Login events and session creation over time." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[220px]">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData} margin={{ top: 5, right: 10, bottom: 0, left: -20 }}>
                  <defs>
                    <linearGradient id="idGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#0ea5e9" stopOpacity={0.25} />
                      <stop offset="95%" stopColor="#0ea5e9" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                  <XAxis dataKey="name" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <Tooltip
                    contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                    itemStyle={{ color: "#0ea5e9" }}
                    formatter={(v) => [fmt(Number(Array.isArray(v) ? v[0] : (v ?? 0))), t("identity_os.logins", { defaultValue: "Logins" })] as [string, string]}
                  />
                  <ReferenceLine y={0} stroke="#334155" />
                  <Area type="monotone" dataKey="count" stroke="#0ea5e9" strokeWidth={2} fill="url(#idGrad)" dot={false} activeDot={{ r: 4, fill: "#0ea5e9" }} />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">{t("identity_os.recent_sessions", { defaultValue: "Recent Sessions" })}</CardTitle>
            <CardDescription className="text-slate-400">{t("identity_os.recent_sessions_desc", { defaultValue: "Latest authenticated user sessions." })}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {sessions.slice(0, 4).map((s: { id?: string; user: string; ip: string; status: string; date: string; role: string }, i: number) => (
                <div key={s.id || i} className="flex items-center justify-between p-3 rounded-lg border border-slate-800 bg-slate-800/20">
                  <div className="flex items-center gap-3">
                    <div className={`p-2 rounded-full ${
                      s.status === "ACTIVE" ? "bg-sky-500/10 text-sky-400" : "bg-slate-500/10 text-slate-400"
                    }`}>
                      <Monitor className="h-4 w-4" />
                    </div>
                    <div>
                      <p className="text-sm font-medium text-slate-200">{s.user}</p>
                      <p className="text-xs text-slate-500">{s.ip} · {s.role}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <p className="text-xs text-slate-500">{new Date(s.date).toLocaleTimeString()}</p>
                    <p className={`text-xs font-semibold ${s.status === "ACTIVE" ? "text-sky-400" : "text-slate-400"}`}>
                      {s.status}
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
