"use client";

import React from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { FileStack, FileSignature, PenTool, ArrowUpRight, Zap } from "lucide-react";
import { useAuth } from "@/lib/auth";
import {
  XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, AreaChart, Area, ReferenceLine,
} from "recharts";
import { m } from "framer-motion";
import { useQuery } from "@tanstack/react-query";

export default function DocumentDashboard() {
  const { user } = useAuth();

  const { data: statsData, isLoading } = useQuery({
    queryKey: ["document-os-dashboard", user?.orgId],
    queryFn: () =>
      fetch(`${process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000"}/api/v1/document-os/dashboard?orgId=${user?.orgId || ""}`).then((r) => r.json()),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalDocuments: 0,
    activeContracts: 0,
    pendingSignatures: 0,
    recentItems: [],
    chartData: [],
  };

  const chartData = stats.chartData ?? [];
  const recentItems = stats.recentItems ?? [];
  const totalDocuments = stats.totalDocuments ?? 0;
  const activeContracts = stats.activeContracts ?? 0;
  const pendingSignatures = stats.pendingSignatures ?? 0;

  const { t } = useTranslation();

  const kpis = [
    {
      title: t("document_os.total_documents", { defaultValue: "Total Documents" }),
      value: totalDocuments,
      icon: FileStack,
      color: "text-blue-400",
      bg: "from-blue-500/10 to-blue-500/0",
      sub: t("document_os.documents_sub", { defaultValue: "Documents in the system" }),
      trend: "+18 this week",
    },
    {
      title: t("document_os.active_contracts", { defaultValue: "Active Contracts" }),
      value: activeContracts,
      icon: FileSignature,
      color: "text-blue-400",
      bg: "from-blue-500/10 to-blue-500/0",
      sub: t("document_os.contracts_sub", { defaultValue: "Currently enforceable contracts" }),
      trend: "+4 new",
    },
    {
      title: t("document_os.pending_signatures", { defaultValue: "Pending Signatures" }),
      value: pendingSignatures,
      icon: PenTool,
      color: "text-blue-400",
      bg: "from-blue-500/10 to-blue-500/0",
      sub: t("document_os.signatures_sub", { defaultValue: "Awaiting e-signature" }),
      trend: "-3 today",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">{t("document_os.title", { defaultValue: "Document OS" })}</h1>
          <p className="text-slate-400 mt-1">{t("document_os.subtitle", { defaultValue: "Contracts · Documents · OCR · Archive" })}</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-blue-500/10 border border-blue-500/20">
          <span className="h-2 w-2 rounded-full bg-blue-400 animate-pulse" />
          <span className="text-xs font-semibold text-blue-400">{t("document_os.live", { defaultValue: "LIVE" })}</span>
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
                  <span className="ml-auto text-xs font-semibold text-blue-400 flex items-center gap-0.5">
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
              <Zap className="h-4 w-4 text-blue-400" />
              {t("document_os.processing_volume", { defaultValue: "Document Processing Volume" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("document_os.processing_volume_desc", { defaultValue: "Documents processed and archived over time." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[220px]">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData} margin={{ top: 5, right: 10, bottom: 0, left: -20 }}>
                  <defs>
                    <linearGradient id="docGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.25} />
                      <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                  <XAxis dataKey="name" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <Tooltip
                    contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                    itemStyle={{ color: "#3b82f6" }}
                  />
                  <ReferenceLine y={0} stroke="#334155" />
                  <Area type="monotone" dataKey="amount" stroke="#3b82f6" strokeWidth={2} fill="url(#docGrad)" dot={false} activeDot={{ r: 4, fill: "#3b82f6" }} />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">{t("document_os.recent_documents", { defaultValue: "Recent Documents" })}</CardTitle>
            <CardDescription className="text-slate-400">{t("document_os.recent_documents_desc", { defaultValue: "Latest document and contract activity." })}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {recentItems.slice(0, 4).map((item: { id?: string; status: string; name: string; date: string | number; type: string }, i: number) => (
                <div key={item.id || i} className="flex items-center justify-between p-3 rounded-lg border border-slate-800 bg-slate-800/20">
                  <div className="flex items-center gap-3">
                    <div className={`p-2 rounded-full ${
                      item.status === "ACTIVE" ? "bg-blue-500/10 text-blue-400" : item.status === "PENDING_SIGNATURE" ? "bg-yellow-500/10 text-yellow-400" : "bg-slate-500/10 text-slate-400"
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
                    <p className={`text-xs font-semibold ${item.status === "ACTIVE" ? "text-blue-400" : item.status === "PENDING_SIGNATURE" ? "text-yellow-400" : "text-slate-400"}`}>
                      {item.status.replace("_", " ")}
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
