"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { BarChart3, TrendingUp, Brain, Target, Sparkles, Activity, Clock, CheckCircle2, AlertTriangle, ArrowUpRight, Cpu, Database, Zap, RefreshCw } from "lucide-react";
import { AreaChart, Area, BarChart, Bar, ResponsiveContainer, XAxis, YAxis, Tooltip, CartesianGrid } from "recharts";
import { motion } from "framer-motion";
const performanceData = [{
  date: "Mon",
  accuracy: 94.2,
  latency: 1.8,
  requests: 4200
}, {
  date: "Tue",
  accuracy: 95.1,
  latency: 1.6,
  requests: 4800
}, {
  date: "Wed",
  accuracy: 96.8,
  latency: 1.5,
  requests: 5200
}, {
  date: "Thu",
  accuracy: 95.4,
  latency: 1.7,
  requests: 4600
}, {
  date: "Fri",
  accuracy: 97.2,
  latency: 1.4,
  requests: 5800
}, {
  date: "Sat",
  accuracy: 96.5,
  latency: 1.6,
  requests: 3200
}, {
  date: "Sun",
  accuracy: 97.8,
  latency: 1.3,
  requests: 2800
}];
const models = [{
  name: "Property Valuation",
  version: "v3.2",
  accuracy: 97.2,
  status: "active",
  requests: 12400,
  latency: "1.2s",
  lastTrained: "2 days ago"
}, {
  name: "Lead Scoring",
  version: "v2.8",
  accuracy: 94.8,
  status: "active",
  requests: 8900,
  latency: "0.8s",
  lastTrained: "5 days ago"
}, {
  name: "Market Prediction",
  version: "v4.1",
  accuracy: 92.1,
  status: "training",
  requests: 6200,
  latency: "2.4s",
  lastTrained: "Training..."
}, {
  name: "Recommendation Engine",
  version: "v3.5",
  accuracy: 96.5,
  status: "active",
  requests: 15600,
  latency: "0.6s",
  lastTrained: "1 day ago"
}, {
  name: "Sentiment Analysis",
  version: "v2.1",
  accuracy: 91.4,
  status: "active",
  requests: 4300,
  latency: "1.1s",
  lastTrained: "7 days ago"
}, {
  name: "Fraud Detection",
  version: "v1.9",
  accuracy: 98.1,
  status: "active",
  requests: 2100,
  latency: "0.3s",
  lastTrained: "3 days ago"
}];
const insights = [{
  title: t("admin.ai.property_prices_expected_to"),
  confidence: 92,
  category: "Market",
  impact: "high"
}, {
  title: t("admin.ai.lead_conversion_rate_improved"),
  confidence: 88,
  category: "CRM",
  impact: "medium"
}, {
  title: t("admin.ai.market_saturation_detected_in"),
  confidence: 95,
  category: "Risk",
  impact: "high"
}, {
  title: t("admin.ai.new_rental_opportunities_identified"),
  confidence: 87,
  category: "Opportunity",
  impact: "medium"
}, {
  title: t("admin.ai.maintenance_costs_can_be"),
  confidence: 91,
  category: "Operations",
  impact: "high"
}];
const kpis = [{
  label: t("admin.ai.model_accuracy"),
  value: "96.8%",
  change: "+2.3%",
  icon: Target,
  color: "text-emerald-400",
  bg: "bg-emerald-500/10"
}, {
  label: t("admin.ai.daily_predictions"),
  value: "45.2K",
  change: "+18%",
  icon: BarChart3,
  color: "text-slate-400",
  bg: "bg-slate-500/10"
}, {
  label: t("admin.ai.avg_latency"),
  value: "1.4s",
  change: "-15%",
  icon: Zap,
  color: "text-amber-400",
  bg: "bg-amber-500/10"
}, {
  label: t("admin.ai.success_rate"),
  value: "99.2%",
  change: "+0.4%",
  icon: CheckCircle2,
  color: "text-slate-400",
  bg: "bg-slate-500/10"
}];
export default function AIAnalytics() {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState("overview");
  return <div className="p-4 md:p-8 space-y-8 max-w-(--breakpoint-2xl) mx-auto min-h-screen">
      {/* Header */}
      <div className="bg-white/5 p-6 rounded-2xl border border-white/10 flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight flex items-center gap-3 text-white">
            <div className="p-2 rounded-xl bg-primary/10">
              <Brain className="w-7 h-7 text-primary" />
            </div>{t("admin.ai.ai_analytics")}</h1>
          <p className="text-slate-400 mt-1">{t("admin.ai.deep_insights_from_artificial")}</p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="outline" className="border-white/10 text-slate-400">
            <RefreshCw className="w-4 h-4 mr-2" />{t("admin.ai.refresh")}</Button>
          <Button className="bg-primary shadow-lg shadow-primary/20">
            <Sparkles className="w-4 h-4 mr-2" />{t("admin.ai.run_analysis")}</Button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, idx) => <motion.div key={kpi.label} initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }} transition={{
        delay: idx * 0.08
      }}>
            <Card className="bg-white/5 border-white/10 hover:bg-white/10 transition-all group rounded-2xl">
              <CardContent className="p-6">
                <div className="flex justify-between items-start mb-4">
                  <div className={`p-3 rounded-xl ${kpi.bg} ${kpi.color} group-hover:scale-110 transition-transform`}>
                    <kpi.icon className="h-6 w-6" />
                  </div>
                  <Badge className="rounded-full bg-emerald-500/10 text-emerald-400 border-emerald-500/20">
                    <ArrowUpRight className="h-3 w-3 mr-1" />
                    {kpi.change}
                  </Badge>
                </div>
                <p className="text-sm text-slate-400 font-medium">{kpi.label}</p>
                <h3 className="text-2xl font-bold mt-1 text-white">{kpi.value}</h3>
              </CardContent>
            </Card>
          </motion.div>)}
      </div>

      <Tabs value={activeTab} onValueChange={setActiveTab}>
        <TabsList className="bg-white/5 border border-white/10 p-1">
          <TabsTrigger value="overview" className="data-[state=active]:bg-primary data-[state=active]:text-white text-slate-400 rounded-lg">{t("admin.ai.overview")}</TabsTrigger>
          <TabsTrigger value="models" className="data-[state=active]:bg-primary data-[state=active]:text-white text-slate-400 rounded-lg">{t("admin.ai.models")}</TabsTrigger>
          <TabsTrigger value="insights" className="data-[state=active]:bg-primary data-[state=active]:text-white text-slate-400 rounded-lg">{t("admin.ai.insights")}</TabsTrigger>
        </TabsList>

        <TabsContent value="overview" className="space-y-8 mt-6">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            {/* Accuracy Trend */}
            <Card className="lg:col-span-2 bg-white/5 border-white/10 rounded-2xl overflow-hidden">
              <CardHeader>
                <CardTitle className="flex items-center gap-2 text-white">
                  <Activity className="w-5 h-5 text-primary" />{t("admin.ai.model_accuracy_trend")}</CardTitle>
                <CardDescription className="text-slate-400">{t("admin.ai.weekly_accuracy_performance_across")}</CardDescription>
              </CardHeader>
              <CardContent className="h-72 pl-0">
                <ResponsiveContainer width="100%" height={288} minWidth={0}>
                  <AreaChart data={performanceData}>
                    <defs>
                      <linearGradient id="aiAccuracy" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="5%" stopColor="#6366f1" stopOpacity={0.3} />
                        <stop offset="95%" stopColor="#6366f1" stopOpacity={0} />
                      </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" stroke="#ffffff05" vertical={false} />
                    <XAxis dataKey="date" axisLine={false} tickLine={false} tick={{
                    fill: "#94a3b8",
                    fontSize: 12
                  }} />
                    <YAxis domain={[90, 100]} axisLine={false} tickLine={false} tick={{
                    fill: "#94a3b8",
                    fontSize: 12
                  }} />
                    <Tooltip contentStyle={{
                    backgroundColor: "#1e293b",
                    border: "1px solid rgba(255,255,255,0.1)",
                    borderRadius: "12px"
                  }} />
                    <Area type="monotone" dataKey="accuracy" stroke="#6366f1" strokeWidth={3} fillOpacity={1} fill="url(#aiAccuracy)" />
                  </AreaChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>

            {/* Request Volume */}
            <Card className="bg-white/5 border-white/10 rounded-2xl">
              <CardHeader>
                <CardTitle className="flex items-center gap-2 text-white">
                  <Database className="w-5 h-5 text-primary" />{t("admin.ai.request_volume")}</CardTitle>
              </CardHeader>
              <CardContent className="h-64">
                <ResponsiveContainer width="100%" height={256} minWidth={0}>
                  <BarChart data={performanceData}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#ffffff05" horizontal={false} />
                    <XAxis dataKey="date" axisLine={false} tickLine={false} tick={{
                    fill: "#94a3b8",
                    fontSize: 11
                  }} />
                    <YAxis hide />
                    <Tooltip contentStyle={{
                    backgroundColor: "#1e293b",
                    border: "1px solid rgba(255,255,255,0.1)",
                    borderRadius: "12px"
                  }} />
                    <Bar dataKey="requests" fill="#8b5cf6" radius={[6, 6, 0, 0]} barSize={28} />
                  </BarChart>
                </ResponsiveContainer>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="models" className="space-y-6 mt-6">
          <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
            {models.map((model, idx) => <motion.div key={model.name} initial={{
            opacity: 0,
            y: 15
          }} animate={{
            opacity: 1,
            y: 0
          }} transition={{
            delay: idx * 0.06
          }}>
                <Card className="bg-white/5 border-white/10 rounded-2xl hover:border-primary/20 transition-all">
                  <CardContent className="p-6 space-y-4">
                    <div className="flex items-start justify-between">
                      <div className="flex items-center gap-3">
                        <div className={`p-2 rounded-xl ${model.status === "active" ? "bg-emerald-500/10" : "bg-amber-500/10"}`}>
                          <Cpu className={`w-5 h-5 ${model.status === "active" ? "text-emerald-400" : "text-amber-400"}`} />
                        </div>
                        <div>
                          <h3 className="font-semibold text-white">{model.name}</h3>
                          <p className="text-xs text-slate-400">{model.version}</p>
                        </div>
                      </div>
                      <Badge className={`text-[10px] ${model.status === "active" ? "bg-emerald-500/10 text-emerald-400 border-emerald-500/20" : "bg-amber-500/10 text-amber-400 border-amber-500/20"}`}>
                        {model.status === "active" ? <CheckCircle2 className="w-3 h-3 mr-1" /> : <Clock className="w-3 h-3 mr-1" />}
                        {model.status}
                      </Badge>
                    </div>
                    <div className="space-y-2">
                      <div className="flex justify-between text-sm">
                        <span className="text-slate-400">{t("admin.ai.accuracy")}</span>
                        <span className="font-bold text-white">{model.accuracy}%</span>
                      </div>
                      <Progress value={model.accuracy} className="h-2" />
                    </div>
                    <div className="grid grid-cols-3 gap-3 text-center">
                      <div className="p-2 rounded-lg bg-white/5">
                        <p className="text-xs text-slate-400">{t("admin.ai.requests")}</p>
                        <p className="text-sm font-bold text-white">{(model.requests / 1000).toFixed(1)}K</p>
                      </div>
                      <div className="p-2 rounded-lg bg-white/5">
                        <p className="text-xs text-slate-400">{t("admin.ai.latency")}</p>
                        <p className="text-sm font-bold text-white">{model.latency}</p>
                      </div>
                      <div className="p-2 rounded-lg bg-white/5">
                        <p className="text-xs text-slate-400">{t("admin.ai.last_train")}</p>
                        <p className="text-sm font-bold truncate text-white">{model.lastTrained}</p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </motion.div>)}
          </div>
        </TabsContent>

        <TabsContent value="insights" className="space-y-6 mt-6">
          <Card className="bg-white/5 border-white/10 rounded-2xl">
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-white">
                <Sparkles className="w-5 h-5 text-primary" />{t("admin.ai.aigenerated_insights")}</CardTitle>
              <CardDescription className="text-slate-400">{t("admin.ai.automated_analysis_and_recommendations")}</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              {insights.map((insight, idx) => <motion.div key={idx} initial={{
              opacity: 0,
              x: -10
            }} animate={{
              opacity: 1,
              x: 0
            }} transition={{
              delay: idx * 0.06
            }} className={`p-4 rounded-xl border transition-all hover:border-primary/20 ${insight.impact === "high" ? "border-l-4 border-l-amber-500 bg-amber-500/5 border-white/10" : "border-l-4 border-l-slate-500 bg-slate-500/5 border-white/10"}`}>
                  <div className="flex items-start justify-between gap-4">
                    <div className="flex-1">
                      <div className="flex items-center gap-2 mb-1">
                        {insight.impact === "high" ? <AlertTriangle className="w-4 h-4 text-amber-400" /> : <TrendingUp className="w-4 h-4 text-slate-400" />}
                        <Badge variant="outline" className="text-[10px] text-slate-400">{insight.category}</Badge>
                      </div>
                      <p className="font-medium text-white">{insight.title}</p>
                    </div>
                    <div className="text-right shrink-0">
                      <p className="text-sm font-bold text-primary">{insight.confidence}%</p>
                      <p className="text-[10px] text-slate-400">{t("admin.ai.confidence")}</p>
                    </div>
                  </div>
                </motion.div>)}
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>;
}
