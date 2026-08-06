"use client";

import React from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Users, FileSignature, DollarSign, ArrowUpRight, Zap } from "lucide-react";
import { useAuth } from "@/lib/auth";
import {
  XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, AreaChart, Area, ReferenceLine,
} from "recharts";
import { m } from "framer-motion";
import { useQuery } from "@tanstack/react-query";

const fmt = (val: number) =>
  new Intl.NumberFormat("en-US", { style: "currency", currency: "USD", maximumFractionDigits: 0 }).format(val);

export default function PartnerDashboard() {
  const { user } = useAuth();

  const { data: statsData, isLoading } = useQuery({
    queryKey: ["partner-os-dashboard", user?.orgId],
    queryFn: () =>
      fetch(`${process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000"}/api/v1/partner-os/dashboard?orgId=${user?.orgId || ""}`).then((r) => r.json()),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalPartners: 0,
    activeAgreements: 0,
    totalRevenue: 0,
    recentItems: [],
    chartData: [],
  };

  const chartData = stats.chartData ?? [];
  const recentItems = stats.recentItems ?? [];
  const totalPartners = stats.totalPartners ?? 0;
  const activeAgreements = stats.activeAgreements ?? 0;
  const totalRevenue = stats.totalRevenue ?? 0;

  const { t } = useTranslation();

  const kpis = [
    {
      title: t("partner_os.total_partners", { defaultValue: "Total Partners" }),
      value: totalPartners,
      icon: Users,
      color: "text-indigo-400",
      bg: "from-indigo-500/10 to-indigo-500/0",
      sub: t("partner_os.partners_sub", { defaultValue: "Realtors, Brokers, Underwriters & Banks" }),
      trend: "+4 this month",
    },
    {
      title: t("partner_os.active_agreements", { defaultValue: "Active Agreements" }),
      value: activeAgreements,
      icon: FileSignature,
      color: "text-indigo-400",
      bg: "from-indigo-500/10 to-indigo-500/0",
      sub: t("partner_os.agreements_sub", { defaultValue: "Co-Brokerage & Escrow Trust agreements" }),
      trend: "+2 new",
    },
    {
      title: t("partner_os.total_revenue", { defaultValue: "Total Revenue" }),
      value: fmt(totalRevenue),
      icon: DollarSign,
      color: "text-indigo-400",
      bg: "from-indigo-500/10 to-indigo-500/0",
      sub: t("partner_os.revenue_sub", { defaultValue: "Revenue generated via partner commission splits" }),
      trend: "+18.3%",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">{t("partner_os.title", { defaultValue: "Partner OS" })}</h1>
          <p className="text-slate-400 mt-1">{t("partner_os.subtitle", { defaultValue: "Realtors · Brokers · %2 Rent Guarantee Underwriters · Bank Ecosystem" })}</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-indigo-500/10 border border-indigo-500/20">
          <span className="h-2 w-2 rounded-full bg-indigo-400 animate-pulse" />
          <span className="text-xs font-semibold text-indigo-400">{t("partner_os.live", { defaultValue: "ESCROW PROTECTED" })}</span>
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
                  <span className="ml-auto text-xs font-semibold text-indigo-400 flex items-center gap-0.5">
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
              <Zap className="h-4 w-4 text-indigo-400" />
              {t("partner_os.revenue_stream", { defaultValue: "Partner Revenue Stream" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("partner_os.revenue_stream_desc", { defaultValue: "Revenue generated through partner ecosystem." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[220px]">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData} margin={{ top: 5, right: 10, bottom: 0, left: -20 }}>
                  <defs>
                    <linearGradient id="partnerGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#6366f1" stopOpacity={0.25} />
                      <stop offset="95%" stopColor="#6366f1" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                  <XAxis dataKey="name" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} tickFormatter={(v) => `$${v >= 1000 ? (v/1000).toFixed(0)+'k' : v}`} />
                  <Tooltip
                    contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                    itemStyle={{ color: "#6366f1" }}
                    formatter={(v) => [fmt(Number(Array.isArray(v) ? v[0] : (v ?? 0))), t("partner_os.revenue", { defaultValue: "Revenue" })] as [string, string]}
                  />
                  <ReferenceLine y={0} stroke="#334155" />
                  <Area type="monotone" dataKey="amount" stroke="#6366f1" strokeWidth={2} fill="url(#partnerGrad)" dot={false} activeDot={{ r: 4, fill: "#6366f1" }} />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">{t("partner_os.recent_partners", { defaultValue: "Recent Partners" })}</CardTitle>
            <CardDescription className="text-slate-400">{t("partner_os.recent_partners_desc", { defaultValue: "Latest partner agreements and activities." })}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {recentItems.slice(0, 4).map((item: { id?: string; status: string; name: string; date: string | number; revenue: number }, i: number) => (
                <div key={item.id || i} className="flex items-center justify-between p-3 rounded-lg border border-slate-800 bg-slate-800/20">
                  <div className="flex items-center gap-3">
                    <div className={`p-2 rounded-full ${
                      item.status === "ACTIVE" ? "bg-indigo-500/10 text-indigo-400" : "bg-yellow-500/10 text-yellow-400"
                    }`}>
                      <Zap className="h-4 w-4" />
                    </div>
                    <div>
                      <p className="text-sm font-medium text-slate-200">{item.name}</p>
                      <p className="text-xs text-slate-500">{new Date(item.date).toLocaleTimeString()}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-slate-200">{item.revenue > 0 ? fmt(item.revenue) : "—"}</p>
                    <p className={`text-xs font-semibold ${item.status === "ACTIVE" ? "text-indigo-400" : "text-yellow-400"}`}>
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
