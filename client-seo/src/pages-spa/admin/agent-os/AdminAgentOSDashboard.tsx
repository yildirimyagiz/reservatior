"use client";

import { useTranslation } from "react-i18next";
import { Users, Activity, Target, DollarSign, ArrowUpRight, TrendingUp, AlertCircle, CheckCircle, Clock } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";
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
    { title: t("agent_os.total_agents", "Toplam Acente"), value: 156, icon: Users, color: "text-success", trend: "+12 this month" },
    { title: t("agent_os.active_leads", "Aktif Potansiyel Müşteriler"), value: 342, icon: Activity, color: "text-info", trend: "+28 this week" },
    { title: t("agent_os.avg_conversion", "Ort. Dönüşüm"), value: "34.2%", icon: Target, color: "text-brand", trend: "vs 28% industry avg" },
    { title: t("agent_os.total_revenue", "Toplam Gelir"), value: fmt(410450), icon: DollarSign, color: "text-warning", trend: "+14.7% vs last month" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-start justify-between">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-foreground">{t("agent_os.title", "Acente OS")}</h1>
          <p className="text-muted-foreground mt-1">{t("agent_os.subtitle", "Davranışsal Veri Alımı · Komisyon Motoru · AI Karar Grafiği")}</p>
        </div>
        <Button className="bg-primary text-primary-foreground hover:bg-primary/90">
          <Users className="h-4 w-4 mr-2" />
          {t("agent_os.add_agent", "Acente Ekle")}
        </Button>
      </div>

      {/* KPIs */}
      <div className="grid gap-4 md:grid-cols-4">
        {kpis.map((kpi, i) => (
          <m.div key={kpi.title} initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.07 }}>
            <Card className="bg-card border-border">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-muted-foreground">{kpi.title}</CardTitle>
                <kpi.icon className={`h-4 w-4 ${kpi.color}`} />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-foreground">{kpi.value}</div>
                <p className="text-xs text-muted-foreground mt-1 flex items-center gap-1">
                  <ArrowUpRight className="h-3 w-3 text-success" />{kpi.trend}
                </p>
              </CardContent>
            </Card>
          </m.div>
        ))}
      </div>

      <Tabs defaultValue="overview" className="space-y-4">
        <TabsList className="bg-card border-border">
          <TabsTrigger value="overview">{t("agent_os.tabs.overview", "Genel Bakış")}</TabsTrigger>
          <TabsTrigger value="agents">{t("agent_os.tabs.agents", "Acenteler")}</TabsTrigger>
          <TabsTrigger value="commissions">{t("agent_os.tabs.commissions", "Komisyonlar")}</TabsTrigger>
          <TabsTrigger value="performance">{t("agent_os.tabs.performance", "Performans")}</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <TrendingUp className="h-4 w-4 text-success" />
                  {t("agent_os.revenue_stream", "Gelir Akışı (7g)")}
                </CardTitle>
                <CardDescription className="text-muted-foreground">
                  {t("agent_os.revenue_stream_desc", "Acente anlaşmalarından günlük gelir katkısı")}
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
                      <Bar dataKey="revenue" fill="#3b82f6" radius={[4, 4, 0, 0]} opacity={0.85} />
                      <Bar dataKey="commissions" fill="#6366f1" radius={[4, 4, 0, 0]} opacity={0.6} />
                    </BarChart>
                  </ResponsiveContainer>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground">{t("agent_os.status_overview", "Acente Durum Genel Bakış")}</CardTitle>
                <CardDescription className="text-muted-foreground">
                  {t("agent_os.status_overview_desc", "Güncel acente performansı ve durumu")}
                </CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {ACTIVE_AGENTS.map((agent) => (
                    <div key={agent.id} className="flex items-center justify-between p-3 rounded-lg bg-muted/50 border border-border">
                      <div className="flex items-center gap-3">
                        <div className={`w-2 h-2 rounded-full ${agent.status === 'active' ? 'bg-blue-400' : 'bg-yellow-400'}`} />
                        <div>
                          <p className="text-sm font-medium text-foreground">{agent.name}</p>
                          <p className="text-xs text-muted-foreground">{agent.leads} {t("agent_os.leads", "potansiyel müşteri")}</p>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-sm font-bold text-foreground">{fmt(agent.revenue)}</p>
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
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("agent_os.agent_management", "Acente Yönetimi")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("agent_os.agent_management_desc", "Acente hesaplarını, izinleri ve performansı yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <Users className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("agent_os.agent_management_placeholder", "Acente yönetim arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="commissions">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("agent_os.commissions", "Commissions")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("agent_os.commissions_desc", "Acente komisyonlarını ve ödemelerini takip edin ve yönetin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <DollarSign className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("agent_os.commissions_placeholder", "Komisyon yönetim arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="performance">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("agent_os.performance", "Performans Analitiği")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("agent_os.performance_desc", "Detaylı performans metrikleri ve analizler")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <Activity className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("agent_os.performance_placeholder", "Performans analitiği arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
