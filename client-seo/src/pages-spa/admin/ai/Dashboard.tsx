"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState } from"react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Progress } from"@/components/ui/progress";
import { Brain, TrendingUp, Zap, BarChart3, Sparkles, Activity, AlertTriangle, CheckCircle2, Clock, ArrowUpRight, Cpu, LineChart, Target, RefreshCw, Play, Pause } from"lucide-react";
import { AreaChart, Area, ResponsiveContainer, XAxis, YAxis, Tooltip, CartesianGrid } from"recharts";
import { motion } from"framer-motion";
const processingData = [{
 time:"00:00",
 requests: 2400,
 latency: 1.8
}, {
 time:"04:00",
 requests: 1200,
 latency: 1.2
}, {
 time:"08:00",
 requests: 4800,
 latency: 2.1
}, {
 time:"12:00",
 requests: 6200,
 latency: 2.4
}, {
 time:"16:00",
 requests: 5800,
 latency: 2.0
}, {
 time:"20:00",
 requests: 3600,
 latency: 1.6
}, {
 time:"Now",
 requests: 4100,
 latency: 1.5
}];
const activeModels = [{
 name:"Property Valuation",
 status:"running",
 accuracy: 97.2,
 uptime:"99.8%",
 load: 72,
 icon:"🏠"
}, {
 name:"Neural Staging",
 status:"running",
 accuracy: 98.5,
 uptime:"99.9%",
 load: 64,
 icon:"✨"
}, {
 name:"ROI Forecasting",
 status:"running",
 accuracy: 95.1,
 uptime:"99.4%",
 load: 31,
 icon:"📈"
}, {
 name:"Lead Scoring",
 status:"running",
 accuracy: 94.8,
 uptime:"99.5%",
 load: 45,
 icon:"🎯"
}, {
 name:"Market Prediction",
 status:"training",
 accuracy: 92.1,
 uptime:"—",
 load: 95,
 icon:"📊"
}, {
 name:"Smart Recommendations",
 status:"running",
 accuracy: 96.5,
 uptime:"99.9%",
 load: 38,
 icon:"💡"
}, {
 name:"Fraud Detection",
 status:"running",
 accuracy: 98.1,
 uptime:"100%",
 load: 15,
 icon:"🛡️"
}, {
 name:"Sentiment Analysis",
 status:"paused",
 accuracy: 91.4,
 uptime:"—",
 load: 0,
 icon:"💬"
}];
const recentActivities = [{
 action:"Neural Staging completed",
 property:"Villa Azura (SunReal Agency)",
 accuracy:"99.2%",
 time:"1 min ago",
 status:"success"
}, {
 action:"ROI Forecast updated",
 property:"Marina Villa Project",
 accuracy:"95.4%",
 time:"3 min ago",
 status:"success"
}, {
 action:"Property Valuation completed",
 property:"Sunset Apartments #204",
 accuracy:"97.8%",
 time:"12 min ago",
 status:"success"
}, {
 action:"Lead scoring batch processed",
 property:"1,247 leads analyzed",
 accuracy:"94.2%",
 time:"15 min ago",
 status:"success"
}, {
 action:"Anomaly detected in pricing",
 property:"Downtown Loft #7",
 accuracy:"99.1%",
 time:"28 min ago",
 status:"warning"
}, {
 action:"Recommendation engine updated",
 property:"All properties",
 accuracy:"96.5%",
 time:"1 hr ago",
 status:"success"
}];
const systemMetrics = [{
 label: t("admin_ai_gpu_utilization"),
 value: 68,
 max: 100,
 unit:"%"
}, {
 label: t("admin_ai_memory_usage"),
 value: 12.4,
 max: 32,
 unit:"GB"
}, {
 label: t("admin_ai_queue_length"),
 value: 23,
 max: 100,
 unit:"tasks"
}, {
 label: t("admin_ai_api_throughput"),
 value: 1234,
 max: 2000,
 unit:"req/s"
}];
export default function AIDashboard() {
 const {
 t
 } = useTranslation();
 const [refreshing, setRefreshing] = useState(false);
 const handleRefresh = () => {
 setRefreshing(true);
 setTimeout(() => setRefreshing(false), 1500);
 };
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 p-4 md:p-8 space-y-8 max-w-(--breakpoint-2xl) mx-auto min-h-screen">
 {/* Header */}
 <section className="relative overflow-hidden rounded-3xl p-8 bg-gradient-to-br from-slate-600/20 via-slate-600/20 to-pink-600/10 border border-border">
 <div className="absolute -top-24 -right-24 h-96 w-96 bg-primary/20 rounded-full blur-3xl opacity-20 pointer-events-none" />
 <div className="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-6">
 <div className="space-y-2">
 <h1 className="text-3xl md:text-xl font-bold tracking-tight flex items-center gap-3 text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">
 <Brain className="w-9 h-9 text-primary" />{t("admin_ai_ai_command_center")}</h1>
 <p className="text-muted-foreground text-lg max-w-xl">{t("admin_ai_realtime_monitoring_of_all")}</p>
 </div>
 <div className="flex gap-3">
 <Button onClick={handleRefresh} variant="outline" className="border-border text-muted-foreground backdrop-blur-sm">
 <RefreshCw className={`w-4 h-4 mr-2 ${refreshing ?"animate-spin" :""}`} />{t("admin_ai_refresh")}</Button>
 <Button className="bg-primary hover:bg-primary/90 shadow-lg shadow-primary/20">
 <Sparkles className="w-4 h-4 mr-2" />{t("admin_ai_run_analysis")}</Button>
 </div>
 </div>
 </section>

 {/* Quick Stats */}
 <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
 {[{
 label: t("admin_ai_active_models"),
 value:"12",
 change:"+2",
 icon: Brain,
 color:"text-muted-foreground",
 bg:"bg-muted0/10"
 }, {
 label: t("admin_ai_predictions_today"),
 value:"8,543",
 change:"+23%",
 icon: TrendingUp,
 color:"text-emerald-400",
 bg:"bg-emerald-500/10"
 }, {
 label: t("admin_ai_avg_accuracy"),
 value:"94.2%",
 change:"+1.8%",
 icon: BarChart3,
 color:"text-muted-foreground",
 bg:"bg-muted0/10"
 }, {
 label: t("admin_ai_avg_latency"),
 value:"1.5s",
 change:"-0.3s",
 icon: Zap,
 color:"text-amber-400",
 bg:"bg-amber-500/10"
 }].map((stat, idx) => <motion.div key={stat.label} initial={{
 opacity: 0,
 y: 20
 }} animate={{
 opacity: 1,
 y: 0
 }} transition={{
 delay: idx * 0.08
 }}>
 <Card className="bg-card border-border hover:bg-slate-100 dark:hover:bg-white/10 transition-all group rounded-2xl">
 <CardContent className="p-6">
 <div className="flex justify-between items-start mb-4">
 <div className={`p-3 rounded-xl ${stat.bg} ${stat.color} group-hover:scale-110 transition-transform`}>
 <stat.icon className="h-6 w-6" />
 </div>
 <Badge className="rounded-full bg-emerald-500/10 text-emerald-400 border-emerald-500/20">
 <ArrowUpRight className="h-3 w-3 mr-1" /> {stat.change}
 </Badge>
 </div>
 <p className="text-sm text-muted-foreground font-medium">{stat.label}</p>
 <h3 className="text-2xl font-bold mt-1 text-foreground">{stat.value}</h3>
 </CardContent>
 </Card>
 </motion.div>)}
 </div>

 <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
 {/* Processing Chart */}
 <Card className="lg:col-span-2 bg-card border-border rounded-2xl overflow-hidden">
 <CardHeader className="flex flex-row items-center justify-between">
 <div>
 <CardTitle className="text-xl font-bold flex items-center gap-2 text-foreground">
 <LineChart className="w-5 h-5 text-primary" />{t("admin_ai_request_processing")}</CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_ai_24hour_request_volume_and")}</CardDescription>
 </div>
 <div className="flex items-center gap-1.5 px-3 py-1 bg-emerald-500/10 rounded-full border border-emerald-500/20">
 <div className="h-2 w-2 rounded-full bg-emerald-500 animate-pulse" />
 <span className="text-xs font-medium text-emerald-400">{t("admin_ai_live")}</span>
 </div>
 </CardHeader>
 <CardContent className="h-72 pl-0">
 <ResponsiveContainer width="100%" height={288} minWidth={0}>
 <AreaChart data={processingData}>
 <defs>
 <linearGradient id="aiReqs" x1="0" y1="0" x2="0" y2="1">
 <stop offset="5%" stopColor="#6366f1" stopOpacity={0.3} />
 <stop offset="95%" stopColor="#6366f1" stopOpacity={0} />
 </linearGradient>
 </defs>
 <CartesianGrid strokeDasharray="3 3" stroke="#ffffff05" vertical={false} />
 <XAxis dataKey="time" axisLine={false} tickLine={false} tick={{
 fill:"#94a3b8",
 fontSize: 12
 }} />
 <YAxis hide />
 <Tooltip contentStyle={{
 backgroundColor:"#1e293b",
 border:"1px solid rgba(255,255,255,0.1)",
 borderRadius:"12px"
 }} formatter={((value: number, name: string) => [name ==="requests" ? value.toLocaleString() : `${value}s`, name ==="requests" ?"Requests" :"Latency"]) as any} />
 <Area type="monotone" dataKey="requests" stroke="#6366f1" strokeWidth={3} fillOpacity={1} fill="url(#aiReqs)" />
 </AreaChart>
 </ResponsiveContainer>
 </CardContent>
 </Card>

 {/* System Metrics */}
 <Card className="bg-card border-border rounded-2xl">
 <CardHeader>
 <CardTitle className="flex items-center gap-2 text-foreground">
 <Cpu className="w-5 h-5 text-primary" />{t("admin_ai_system_health")}</CardTitle>
 </CardHeader>
 <CardContent className="space-y-6">
 {systemMetrics.map(metric => <div key={metric.label} className="space-y-2">
 <div className="flex justify-between text-sm">
 <span className="text-muted-foreground">{metric.label}</span>
 <span className="font-bold text-foreground">
 {typeof metric.value ==="number" && metric.value > 100 ? metric.value.toLocaleString() : metric.value}{metric.unit ==="%" ?"%" : ` ${metric.unit}`}
 </span>
 </div>
 <Progress value={metric.value / metric.max * 100} className="h-2" />
 </div>)}
 </CardContent>
 </Card>
 </div>

 {/* Active Models */}
 <Card className="bg-card border-border rounded-2xl">
 <CardHeader>
 <CardTitle className="flex items-center gap-2 text-foreground">
 <Activity className="w-5 h-5 text-primary" />{t("admin_ai_active_ai_models")}</CardTitle>
 <CardDescription className="text-muted-foreground">{t("admin_ai_status_and_performance_of")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
 {activeModels.map((model, idx) => <motion.div key={model.name} initial={{
 opacity: 0,
 scale: 0.95
 }} animate={{
 opacity: 1,
 scale: 1
 }} transition={{
 delay: idx * 0.06
 }} className={`p-4 rounded-xl border transition-all hover:shadow-lg ${model.status ==="running" ?"border-emerald-500/20 bg-emerald-500/5" : model.status ==="training" ?"border-amber-500/20 bg-amber-500/5" :"border-border bg-card"}`}>
 <div className="flex items-center justify-between mb-3">
 <div className="flex items-center gap-2">
 <span className="text-xl">{model.icon}</span>
 <div>
 <h4 className="font-semibold text-sm text-foreground">{model.name}</h4>
 <p className="text-[10px] text-muted-foreground">{model.uptime}{t("admin_ai_uptime")}</p>
 </div>
 </div>
 <Button size="sm" variant="ghost" className="h-7 w-7 p-0 text-muted-foreground">
 {model.status ==="running" ? <Pause className="w-3 h-3" /> : <Play className="w-3 h-3" />}
 </Button>
 </div>
 <div className="flex items-center justify-between text-xs mb-2">
 <span className="text-muted-foreground">{t("admin_ai_accuracy")}</span>
 <span className="font-bold text-foreground">{model.accuracy}%</span>
 </div>
 <Progress value={model.accuracy} className="h-1.5 mb-2" />
 <div className="flex items-center justify-between text-xs">
 <span className="text-muted-foreground">{t("admin_ai_load")}</span>
 <Badge className={`text-[9px] h-4 ${model.load > 80 ?"bg-red-500/10 text-red-400" : model.load > 50 ?"bg-amber-500/10 text-amber-400" :"bg-emerald-500/10 text-emerald-400"}`}>
 {model.load}%
 </Badge>
 </div>
 </motion.div>)}
 </div>
 </CardContent>
 </Card>

 {/* Recent Activity */}
 <Card className="bg-card border-border rounded-2xl">
 <CardHeader>
 <CardTitle className="flex items-center gap-2 text-foreground">
 <Target className="w-5 h-5 text-primary" />{t("admin_ai_recent_ai_activities")}</CardTitle>
 </CardHeader>
 <CardContent className="space-y-3">
 {recentActivities.map((activity, idx) => <motion.div key={idx} initial={{
 opacity: 0,
 x: -10
 }} animate={{
 opacity: 1,
 x: 0
 }} transition={{
 delay: idx * 0.05
 }} className="flex items-center gap-4 p-3 rounded-xl bg-card border border-border hover:border-primary/20 transition-colors">
 <div className={`p-2 rounded-lg ${activity.status ==="success" ?"bg-emerald-500/10" : activity.status ==="warning" ?"bg-amber-500/10" :"bg-muted0/10"}`}>
 {activity.status ==="success" ? <CheckCircle2 className="w-4 h-4 text-emerald-400" /> : activity.status ==="warning" ? <AlertTriangle className="w-4 h-4 text-amber-400" /> : <Clock className="w-4 h-4 text-muted-foreground" />}
 </div>
 <div className="flex-1 min-w-0">
 <p className="text-sm font-medium text-foreground truncate">{activity.action}</p>
 <p className="text-xs text-muted-foreground truncate">{activity.property}</p>
 </div>
 {activity.accuracy !=="—" && <Badge variant="outline" className="text-xs shrink-0 text-muted-foreground">{activity.accuracy}</Badge>}
 <span className="text-xs text-muted-foreground whitespace-nowrap">{activity.time}</span>
 </motion.div>)}
 </CardContent>
 </Card>
 </div>;
}
