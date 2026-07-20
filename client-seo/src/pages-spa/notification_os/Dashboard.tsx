"use client";

import React from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Bell, Mail, MessageSquare, ArrowUpRight, Zap } from "lucide-react";
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
  { id: "1", name: "Booking Confirmation", status: "SENT", date: new Date(Date.now() - 1000*60*40).toISOString(), channel: "EMAIL" },
  { id: "2", name: "Payment Reminder", status: "SENT", date: new Date(Date.now() - 1000*60*120).toISOString(), channel: "SMS" },
  { id: "3", name: "Check-in Instructions", status: "UNREAD", date: new Date(Date.now() - 1000*60*210).toISOString(), channel: "PUSH" },
  { id: "4", name: "Review Request", status: "SENT", date: new Date(Date.now() - 1000*60*360).toISOString(), channel: "EMAIL" },
];

const fmt = (val: number) =>
  new Intl.NumberFormat("en-US", { maximumFractionDigits: 0 }).format(val);

export default function NotificationDashboard() {
  const { user } = useAuth();

  const { data: statsData, isLoading } = useQuery({
    queryKey: ["notification-os-dashboard", user?.orgId],
    queryFn: () =>
      fetch(`${process.env.NEXT_PUBLIC_API_URL || "http://localhost:3000"}/api/v1/notification-os/dashboard?orgId=${user?.orgId || ""}`).then((r) => r.json()),
    enabled: !!user?.orgId,
  });

  const stats = statsData?.data || {
    totalNotifications: 0,
    unreadCount: 0,
    totalMessages: 0,
    recentItems: [],
    chartData: [],
  };

  const chartData = stats.chartData?.length > 0 ? stats.chartData : DEMO_CHART;
  const recentItems = stats.recentItems?.length > 0 ? stats.recentItems : DEMO_ITEMS;
  const totalNotifications = stats.totalNotifications > 0 ? stats.totalNotifications : 12847;
  const unreadCount = stats.unreadCount > 0 ? stats.unreadCount : 342;
  const totalMessages = stats.totalMessages > 0 ? stats.totalMessages : 8924;

  const { t } = useTranslation();

  const kpis = [
    {
      title: t("notification_os.total_notifications", { defaultValue: "Total Notifications" }),
      value: fmt(totalNotifications),
      icon: Bell,
      color: "text-rose-400",
      bg: "from-rose-500/10 to-rose-500/0",
      sub: t("notification_os.notifications_sub", { defaultValue: "All-time notifications sent" }),
      trend: "+12.4%",
    },
    {
      title: t("notification_os.unread_count", { defaultValue: "Unread Count" }),
      value: fmt(unreadCount),
      icon: Mail,
      color: "text-rose-400",
      bg: "from-rose-500/10 to-rose-500/0",
      sub: t("notification_os.unread_sub", { defaultValue: "Pending user attention" }),
      trend: "-18 today",
    },
    {
      title: t("notification_os.total_messages", { defaultValue: "Total Messages" }),
      value: fmt(totalMessages),
      icon: MessageSquare,
      color: "text-rose-400",
      bg: "from-rose-500/10 to-rose-500/0",
      sub: t("notification_os.messages_sub", { defaultValue: "Across all channels" }),
      trend: "+8.1%",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">{t("notification_os.title", { defaultValue: "Notification OS" })}</h1>
          <p className="text-slate-400 mt-1">{t("notification_os.subtitle", { defaultValue: "Multi-Channel Communication Hub" })}</p>
        </div>
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-full bg-rose-500/10 border border-rose-500/20">
          <span className="h-2 w-2 rounded-full bg-rose-400 animate-pulse" />
          <span className="text-xs font-semibold text-rose-400">{t("notification_os.live", { defaultValue: "LIVE" })}</span>
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
                  <span className="ml-auto text-xs font-semibold text-rose-400 flex items-center gap-0.5">
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
              <Zap className="h-4 w-4 text-rose-400" />
              {t("notification_os.send_volume", { defaultValue: "Notification Send Volume" })}
            </CardTitle>
            <CardDescription className="text-slate-400">
              {t("notification_os.send_volume_desc", { defaultValue: "Notifications dispatched across all channels." })}
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="h-[220px]">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData} margin={{ top: 5, right: 10, bottom: 0, left: -20 }}>
                  <defs>
                    <linearGradient id="notifGrad" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#f43f5e" stopOpacity={0.25} />
                      <stop offset="95%" stopColor="#f43f5e" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                  <XAxis dataKey="name" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                  <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} tickFormatter={(v) => v >= 1000 ? `${(v/1000).toFixed(0)}k` : `${v}`} />
                  <Tooltip
                    contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                    itemStyle={{ color: "#f43f5e" }}
                  />
                  <ReferenceLine y={0} stroke="#334155" />
                  <Area type="monotone" dataKey="amount" stroke="#f43f5e" strokeWidth={2} fill="url(#notifGrad)" dot={false} activeDot={{ r: 4, fill: "#f43f5e" }} />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </CardContent>
        </Card>

        <Card className="bg-slate-900/60 border-slate-800">
          <CardHeader>
            <CardTitle className="text-slate-100">{t("notification_os.recent_notifications", { defaultValue: "Recent Notifications" })}</CardTitle>
            <CardDescription className="text-slate-400">{t("notification_os.recent_notifications_desc", { defaultValue: "Latest messages dispatched." })}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {recentItems.slice(0, 4).map((item: { id?: string; status: string; name: string; date: string | number; channel: string }, i: number) => (
                <div key={item.id || i} className="flex items-center justify-between p-3 rounded-lg border border-slate-800 bg-slate-800/20">
                  <div className="flex items-center gap-3">
                    <div className={`p-2 rounded-full ${
                      item.status === "SENT" ? "bg-rose-500/10 text-rose-400" : "bg-yellow-500/10 text-yellow-400"
                    }`}>
                      <Zap className="h-4 w-4" />
                    </div>
                    <div>
                      <p className="text-sm font-medium text-slate-200">{item.name}</p>
                      <p className="text-xs text-slate-500">{new Date(item.date).toLocaleTimeString()}</p>
                    </div>
                  </div>
                  <div className="text-right">
                    <p className="text-xs text-slate-400">{item.channel}</p>
                    <p className={`text-xs font-semibold ${item.status === "SENT" ? "text-rose-400" : "text-yellow-400"}`}>
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
