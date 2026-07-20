"use client";

import { useTranslation } from "react-i18next";
import { BarChart3, TrendingUp, Target, Activity, ArrowUpRight, AlertCircle, CheckCircle, Clock, FileText, Users, DollarSign } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { motion } from "framer-motion";
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, LineChart, Line,
} from "recharts";

const DEMO_CHART = [
  { day: "Mon", revenue: 8400, bookings: 12, users: 45 },
  { day: "Tue", revenue: 14200, bookings: 18, users: 62 },
  { day: "Wed", revenue: 9100, bookings: 14, users: 38 },
  { day: "Thu", revenue: 18600, bookings: 24, users: 85 },
  { day: "Fri", revenue: 22400, bookings: 28, users: 92 },
  { day: "Sat", revenue: 11300, bookings: 16, users: 55 },
  { day: "Sun", revenue: 16900, bookings: 21, users: 71 },
];

const KPIS = [
  { id: 1, name: "Revenue Growth", value: "+14.7%", status: "positive", target: "+10%" },
  { id: 2, name: "Booking Rate", value: "78.5%", status: "positive", target: "75%" },
  { id: 3, name: "User Retention", value: "62.3%", status: "warning", target: "70%" },
  { id: 4, name: "Avg Response Time", value: "2.4h", status: "positive", target: "3h" },
];

const INSIGHTS = [
  { id: 1, type: "trend", title: "Revenue increase", description: "14.7% increase in weekly revenue", impact: "high" },
  { id: 2, type: "anomaly", title: "Booking spike", description: "Unusual booking activity on Thursday", impact: "medium" },
  { id: 3, type: "recommendation", title: "Increase inventory", description: "Consider adding more listings", impact: "high" },
];

export default function AdminAnalyticsOSDashboard() {
  const { t } = useTranslation();

  const fmt = (v: number) =>
    new Intl.NumberFormat("en-US", { style: "currency", currency: "USD", maximumFractionDigits: 0 }).format(v);

  const kpis = [
    { title: "Total Revenue", value: fmt(100950), icon: DollarSign, color: "text-emerald-500", trend: "+14.7% this week" },
    { title: "Total Bookings", value: 133, icon: Activity, color: "text-blue-400", trend: "+18 this week" },
    { title: "Active Users", value: 448, icon: Users, color: "text-purple-400", trend: "+12% vs last week" },
    { title: "Avg Conversion", value: "34.2%", icon: Target, color: "text-orange-400", trend: "vs 28% industry avg" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">Analytics OS Management</h1>
          <p className="text-slate-400 mt-1">Business intelligence and performance analytics</p>
        </div>
        <Button className="bg-indigo-600 hover:bg-indigo-700">
          <BarChart3 className="h-4 w-4 mr-2" />
          Generate Report
        </Button>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <motion.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-100">{kpi.value}</div>
                <p className="text-xs text-slate-500 mt-1 flex items-center gap-1">
                  <ArrowUpRight className="h-3 w-3 text-emerald-400" />{kpi.trend}
                </p>
              </CardContent>
            </Card>
          </motion.div>
        ))}
      </div>

      <Tabs defaultValue="overview" className="space-y-4">
        <TabsList className="bg-slate-900/60 border-slate-800">
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="kpis">KPIs</TabsTrigger>
          <TabsTrigger value="insights">AI Insights</TabsTrigger>
          <TabsTrigger value="widgets">Widgets</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader>
                <CardTitle className="text-slate-100 flex items-center gap-2">
                  <TrendingUp className="h-4 w-4 text-emerald-400" />
                  Revenue & Bookings (7d)
                </CardTitle>
                <CardDescription className="text-slate-400">
                  Weekly performance metrics
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="h-[260px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <BarChart data={DEMO_CHART} margin={{ top: 5, right: 10, left: -20, bottom: 0 }}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                      <XAxis dataKey="day" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                      <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} tickFormatter={(v) => `$${v >= 1000 ? (v/1000).toFixed(0)+"k" : v}`} />
                      <Tooltip
                        contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                        formatter={(v: any, name: any) => [
                          name === "revenue" ? fmt(Number(v ?? 0)) : v,
                          name === "revenue" ? "Revenue" : name === "bookings" ? "Bookings" : "Users",
                        ]}
                      />
                      <Bar dataKey="revenue" fill="#10b981" radius={[4, 4, 0, 0]} opacity={0.85} />
                      <Bar dataKey="bookings" fill="#6366f1" radius={[4, 4, 0, 0]} opacity={0.6} />
                    </BarChart>
                  </ResponsiveContainer>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader>
                <CardTitle className="text-slate-100">User Activity Trend</CardTitle>
                <CardDescription className="text-slate-400">
                  Daily active users over the week
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="h-[260px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <LineChart data={DEMO_CHART} margin={{ top: 5, right: 10, left: -20, bottom: 0 }}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#1e293b" vertical={false} />
                      <XAxis dataKey="day" stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                      <YAxis stroke="#475569" fontSize={11} tickLine={false} axisLine={false} />
                      <Tooltip
                        contentStyle={{ backgroundColor: "#0f172a", border: "1px solid #1e293b", borderRadius: "8px" }}
                      />
                      <Line type="monotone" dataKey="users" stroke="#f59e0b" strokeWidth={2} dot={{ fill: "#f59e0b" }} />
                    </LineChart>
                  </ResponsiveContainer>
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="kpis">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">KPI Tracking</CardTitle>
              <CardDescription className="text-slate-400">
                Monitor key performance indicators against targets
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {KPIS.map((kpi) => (
                  <div key={kpi.id} className="flex items-center justify-between p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-center gap-3">
                      <div className={`w-2 h-2 rounded-full ${kpi.status === 'positive' ? 'bg-emerald-400' : 'bg-yellow-400'}`} />
                      <div>
                        <p className="text-sm font-medium text-slate-200">{kpi.name}</p>
                        <p className="text-xs text-slate-500">Target: {kpi.target}</p>
                      </div>
                    </div>
                    <div className="text-right">
                      <p className="text-sm font-bold text-slate-100">{kpi.value}</p>
                      <Badge variant={kpi.status === 'positive' ? 'default' : 'secondary'} className="text-xs">
                        {kpi.status}
                      </Badge>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="insights">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">AI-Powered Insights</CardTitle>
              <CardDescription className="text-slate-400">
                Automated analysis and recommendations
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {INSIGHTS.map((insight) => (
                  <div key={insight.id} className="p-4 rounded-lg bg-slate-800/50 border border-slate-700">
                    <div className="flex items-start justify-between mb-2">
                      <div className="flex items-center gap-2">
                        <Badge variant={insight.impact === 'high' ? 'default' : 'secondary'} className="text-xs">
                          {insight.impact} impact
                        </Badge>
                        <Badge variant="outline" className="text-xs">
                          {insight.type}
                        </Badge>
                      </div>
                      <AlertCircle className="h-4 w-4 text-slate-400" />
                    </div>
                    <p className="text-sm font-medium text-slate-200">{insight.title}</p>
                    <p className="text-xs text-slate-500 mt-1">{insight.description}</p>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="widgets">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Dashboard Widgets</CardTitle>
              <CardDescription className="text-slate-400">
                Configure custom dashboard widgets
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <FileText className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Widget configuration interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
