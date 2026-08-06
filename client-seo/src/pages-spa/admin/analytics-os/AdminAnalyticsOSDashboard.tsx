"use client";

import { useTranslation } from "react-i18next";
import { BarChart3, TrendingUp, Target, Activity, ArrowUpRight, AlertCircle, CheckCircle, Clock, FileText, Users, DollarSign } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { m } from "framer-motion";
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
    { title: t("analytics_os.total_revenue", "Toplam Gelir"), value: fmt(100950), icon: DollarSign, color: "text-success", trend: "+14.7% this week" },
    { title: t("analytics_os.total_bookings", "Toplam Rezervasyon"), value: 133, icon: Activity, color: "text-info", trend: "+18 this week" },
    { title: t("analytics_os.active_users", "Aktif Kullanıcılar"), value: 448, icon: Users, color: "text-brand", trend: "+12% vs last week" },
    { title: t("analytics_os.avg_conversion", "Ort. Dönüşüm"), value: "34.2%", icon: Target, color: "text-warning", trend: "vs 28% industry avg" },
  ];

  return (
    <div className="ui-page">
      <div className="ui-page-header">
        <div>
          <h1 className="ui-title">{t("analytics_os.title", "Analitik OS")}</h1>
          <p className="ui-subtitle">{t("analytics_os.subtitle", "İş zekası ve performans analitikleri")}</p>
        </div>
        <Button className="ui-btn-primary">
          <BarChart3 className="h-4 w-4 mr-2" />
          {t("analytics_os.generate_report", "Rapor Oluştur")}
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
          <TabsTrigger value="overview">{t("analytics_os.tabs.overview", "Genel Bakış")}</TabsTrigger>
          <TabsTrigger value="kpis">{t("analytics_os.tabs.kpis", "KPI'lar")}</TabsTrigger>
          <TabsTrigger value="insights">{t("analytics_os.tabs.insights", "AI İçgörüler")}</TabsTrigger>
          <TabsTrigger value="widgets">{t("analytics_os.tabs.widgets", "Widget'lar")}</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <TrendingUp className="h-4 w-4 text-success" />
                  {t("analytics_os.revenue_bookings", "Gelir ve Rezervasyonlar (7g)")}
                </CardTitle>
                <CardDescription className="text-muted-foreground">
                  {t("analytics_os.weekly_metrics", "Haftalık performans metrikleri")}
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
                      <Bar dataKey="revenue" fill="#3b82f6" radius={[4, 4, 0, 0]} opacity={0.85} />
                      <Bar dataKey="bookings" fill="#6366f1" radius={[4, 4, 0, 0]} opacity={0.6} />
                    </BarChart>
                  </ResponsiveContainer>
                </div>
              </CardContent>
            </Card>

            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground">{t("analytics_os.user_activity_trend", "Kullanıcı Aktivite Eğilimi")}</CardTitle>
                <CardDescription className="text-muted-foreground">
                  {t("analytics_os.user_activity_desc", "Hafta boyunca günlük aktif kullanıcılar")}
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
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("analytics_os.kpis", "KPI Takibi")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("analytics_os.kpis_desc", "Hedeflere karşı temel performans göstergelerini izleyin")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {KPIS.map((kpi) => (
                  <div key={kpi.id} className="flex items-center justify-between p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-center gap-3">
                      <div className={`w-2 h-2 rounded-full ${kpi.status === 'positive' ? 'bg-blue-400' : 'bg-yellow-400'}`} />
                      <div>
                        <p className="text-sm font-medium text-foreground">{kpi.name}</p>
                        <p className="text-xs text-muted-foreground">{t("analytics_os.target_label", "Hedef:")} {kpi.target}</p>
                      </div>
                    </div>
                    <div className="text-right">
                      <p className="text-sm font-bold text-foreground">{kpi.value}</p>
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
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("analytics_os.insights", "AI Destekli İçgörüler")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("analytics_os.insights_desc", "Otomatik analiz ve öneriler")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {INSIGHTS.map((insight) => (
                  <div key={insight.id} className="p-4 rounded-lg bg-muted/50 border border-border">
                    <div className="flex items-start justify-between mb-2">
                      <div className="flex items-center gap-2">
                        <Badge variant={insight.impact === 'high' ? 'default' : 'secondary'} className="text-xs">
                          {insight.impact} {t("analytics_os.impact", "etki")}
                        </Badge>
                        <Badge variant="outline" className="text-xs">
                          {insight.type}
                        </Badge>
                      </div>
                      <AlertCircle className="h-4 w-4 text-muted-foreground" />
                    </div>
                    <p className="text-sm font-medium text-foreground">{insight.title}</p>
                    <p className="text-xs text-muted-foreground mt-1">{insight.description}</p>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="widgets">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("analytics_os.widgets", "Panel Bileşenleri")}</CardTitle>
              <CardDescription className="text-muted-foreground">
                {t("analytics_os.widgets_desc", "Özel panel bileşenlerini yapılandırın")}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="text-center py-8 text-muted-foreground">
                <FileText className="h-12 w-12 mx-auto mb-4 opacity-50" />
                <p>{t("analytics_os.widgets_placeholder", "Bileşen yapılandırma arayüzü")}</p>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
