"use client";

import { useTranslation } from "react-i18next";
import { Users, Activity, Target, DollarSign, ArrowUpRight, TrendingUp, AlertCircle, CheckCircle, Clock } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { motion } from "framer-motion";
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer,
} from "recharts";

const DEMO_CHART = [
  { day: "Mon", revenue: 8400, commissions: 3 },
  { day: "Tue", revenue: 14200, commissions: 5 },
  { day: "Wed", revenue: 9100, commissions: 2 },
  { day: "Thu", revenue: 18600, commissions: 7 },
  { day: "Fri", revenue: 22400, commissions: 8 },
  { day: "Sat", revenue: 11300, commissions: 4 },
  { day: "Sun", revenue: 16900, commissions: 6 },
];

const ACTIVE_AGENTS = [
  { id: 1, name: "John Smith", status: "active", leads: 45, revenue: 125000 },
  { id: 2, name: "Sarah Johnson", status: "active", leads: 38, revenue: 98000 },
  { id: 3, name: "Mike Davis", status: "warning", leads: 22, revenue: 45000 },
  { id: 4, name: "Emily Brown", status: "active", leads: 51, revenue: 142000 },
];

export default function AdminAgentOSDashboard() {
  const { t } = useTranslation();

  const fmt = (v: number) =>
    new Intl.NumberFormat("en-US", { style: "currency", currency: "USD", maximumFractionDigits: 0 }).format(v);

  const kpis = [
    { title: "Total Agents", value: 156, icon: Users, color: "text-emerald-500", trend: "+12 this month" },
    { title: "Active Leads", value: 342, icon: Activity, color: "text-blue-400", trend: "+28 this week" },
    { title: "Avg Conversion", value: "34.2%", icon: Target, color: "text-purple-400", trend: "vs 28% industry avg" },
    { title: "Total Revenue", value: fmt(410450), icon: DollarSign, color: "text-orange-400", trend: "+14.7% vs last month" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-slate-100">Agent OS Management</h1>
          <p className="text-slate-400 mt-1">Agent performance monitoring and commission management</p>
        </div>
        <Button className="bg-indigo-600 hover:bg-indigo-700">
          <Users className="h-4 w-4 mr-2" />
          Add Agent
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
          <TabsTrigger value="agents">Agents</TabsTrigger>
          <TabsTrigger value="commissions">Commissions</TabsTrigger>
          <TabsTrigger value="performance">Performance</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            <Card className="bg-slate-900/60 border-slate-800">
              <CardHeader>
                <CardTitle className="text-slate-100 flex items-center gap-2">
                  <TrendingUp className="h-4 w-4 text-emerald-400" />
                  Revenue Stream (7d)
                </CardTitle>
                <CardDescription className="text-slate-400">
                  Daily revenue contribution from agent deals
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
                          name === "revenue" ? "Revenue" : "Commissions",
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
                <CardTitle className="text-slate-100">Agent Status Overview</CardTitle>
                <CardDescription className="text-slate-400">
                  Current agent performance and status
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {ACTIVE_AGENTS.map((agent) => (
                    <div key={agent.id} className="flex items-center justify-between p-3 rounded-lg bg-slate-800/50 border border-slate-700">
                      <div className="flex items-center gap-3">
                        <div className={`w-2 h-2 rounded-full ${agent.status === 'active' ? 'bg-emerald-400' : 'bg-yellow-400'}`} />
                        <div>
                          <p className="text-sm font-medium text-slate-200">{agent.name}</p>
                          <p className="text-xs text-slate-500">{agent.leads} leads</p>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-sm font-bold text-slate-100">{fmt(agent.revenue)}</p>
                        <Badge variant={agent.status === 'active' ? 'default' : 'secondary'} className="text-xs">
                          {agent.status}
                        </Badge>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="agents">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Agent Management</CardTitle>
              <CardDescription className="text-slate-400">
                Manage agent accounts, permissions, and performance
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <Users className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Agent management interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="commissions">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Commission Management</CardTitle>
              <CardDescription className="text-slate-400">
                Track and manage agent commissions and payouts
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <DollarSign className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Commission management interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="performance">
          <Card className="bg-slate-900/60 border-slate-800">
            <CardHeader>
              <CardTitle className="text-slate-100">Performance Analytics</CardTitle>
              <CardDescription className="text-slate-400">
                Detailed performance metrics and analytics
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-slate-400">
                <Activity className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>Performance analytics interface</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
