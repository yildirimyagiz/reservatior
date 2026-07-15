"use client";

import { useTranslation } from"react-i18next";
import { useState } from"react";
import { useQuery } from"@tanstack/react-query";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Badge } from"@/components/ui/badge";
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, BarChart, Bar, Legend } from"recharts";
import { Brain, TrendingUp, Building2, UserCheck, CalendarCheck, Download, Sparkles, AlertCircle, Camera, Zap, Loader2 } from"lucide-react";
import { adminNeuralApi, AIServiceStats } from"@/lib/api/admin-neural";
const ROI_DATA = [{
 month:"Jan",
 aiStaged: 45,
 standard: 20,
 revenueStaged: 154000,
 revenueStd: 65000
}, {
 month:"Feb",
 aiStaged: 52,
 standard: 18,
 revenueStaged: 182000,
 revenueStd: 58000
}, {
 month:"Mar",
 aiStaged: 65,
 standard: 15,
 revenueStaged: 235000,
 revenueStd: 45000
}, {
 month:"Apr",
 aiStaged: 80,
 standard: 22,
 revenueStaged: 298000,
 revenueStd: 72000
}, {
 month:"May",
 aiStaged: 95,
 standard: 12,
 revenueStaged: 365000,
 revenueStd: 38000
}];
const SERVICE_BREAKDOWN = [{
 service:"Neural Staging",
 properties: 840,
 bookings: 3120,
 conversionLift:"+34%",
 agentAdoption:"78%"
}, {
 service:"AI Valuations",
 properties: 1250,
 bookings: 890,
 conversionLift:"+12%",
 agentAdoption:"92%"
}, {
 service:"Smart Brochures",
 properties: 620,
 bookings: 1450,
 conversionLift:"+18%",
 agentAdoption:"45%"
}, {
 service:"Vacation Neural Reels",
 properties: 310,
 bookings: 2800,
 conversionLift:"+45%",
 agentAdoption:"30%"
}];
export default function AIServiceAnalytics() {
 const {
 t
 } = useTranslation();
 const [dateRange, setDateRange] = useState("90d");
 const [serviceFilter, setServiceFilter] = useState("all");
 const { data: stats, isLoading } = useQuery({
 queryKey: ['aiServiceStats', dateRange],
 queryFn: () => adminNeuralApi.getServiceStats(),
 });
 if (isLoading) {
 return <div className="flex h-[400px] items-center justify-center">
 <Loader2 className="h-12 w-12 animate-spin text-primary" />
 </div>;
 }
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 p-6 space-y-6">
 {/* Filters */}
 <div className="bg-card p-6 rounded-2xl border border-border">
 <div className="flex justify-between items-center">
 <div className="flex items-center gap-4">
 <Select value={dateRange} onValueChange={setDateRange}>
 <SelectTrigger className="w-[180px]">
 <SelectValue placeholder={t("admin_analytics_timeframe")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="30d">{t("admin_analytics_last_30_days")}</SelectItem>
 <SelectItem value="90d">{t("admin_analytics_last_90_days")}</SelectItem>
 <SelectItem value="ytd">{t("admin_analytics_year_to_date")}</SelectItem>
 <SelectItem value="all">{t("admin_analytics_all_time")}</SelectItem>
 </SelectContent>
 </Select>
 <Select value={serviceFilter} onValueChange={setServiceFilter}>
 <SelectTrigger className="w-[180px]">
 <SelectValue placeholder={t("admin_analytics_ai_service")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_analytics_all_services")}</SelectItem>
 <SelectItem value="staging">{t("admin_analytics_neural_staging")}</SelectItem>
 <SelectItem value="valuation">{t("admin_analytics_ai_valuations")}</SelectItem>
 <SelectItem value="brochure">{t("admin_analytics_smart_brochures")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <Button variant="outline" className="gap-2">
 <Download className="w-4 h-4" />{t("admin_analytics_export_report")}</Button>
 </div>
 </div>

 {/* Global Impact Metrics */}
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
 <Card className="bg-gradient-to-br from-slate-500/10 via-slate-900 to-slate-900 border-slate-500/20">
 <CardHeader className="pb-2 flex flex-row items-center justify-between">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_analytics_total_agencies_using_ai")}</CardTitle>
 <Building2 className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-3xl font-bold text-foreground">482</div>
 <p className="text-xs text-emerald-400 font-bold mt-1">{t("admin_analytics_12_from_last")}{dateRange}</p>
 </CardContent>
 </Card>
 
 <Card className="bg-gradient-to-br from-slate-500/10 via-slate-900 to-slate-900 border-slate-500/20">
 <CardHeader className="pb-2 flex flex-row items-center justify-between">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_analytics_agent_adoption_rate")}</CardTitle>
 <UserCheck className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-3xl font-bold text-foreground">{stats?.adoptionRate?.toFixed(1)}%</div>
 <p className="text-xs text-emerald-400 font-bold mt-1">{t("admin_analytics_82_across_platform")}</p>
 </CardContent>
 </Card>

 <Card className="bg-gradient-to-br from-emerald-500/10 via-slate-900 to-slate-900 border-emerald-500/20">
 <CardHeader className="pb-2 flex flex-row items-center justify-between">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_analytics_total_ai_processes")}</CardTitle>
 <CalendarCheck className="w-4 h-4 text-emerald-400" />
 </CardHeader>
 <CardContent>
 <div className="text-3xl font-bold text-foreground">{stats?.totalUsage?.toLocaleString()}</div>
 <p className="text-xs text-emerald-400 font-bold mt-1">{t("admin_analytics_global_usage_track")}</p>
 </CardContent>
 </Card>

 <Card className="bg-gradient-to-br from-amber-500/10 via-slate-900 to-slate-900 border-amber-500/20">
 <CardHeader className="pb-2 flex flex-row items-center justify-between">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_analytics_avg_revenue_lift")}</CardTitle>
 <TrendingUp className="w-4 h-4 text-amber-400" />
 </CardHeader>
 <CardContent>
 <div className="text-3xl font-bold text-foreground">+{stats?.revenueLift}%</div>
 <p className="text-xs text-muted-foreground font-bold mt-1">{t("admin_analytics_compared_to_nonai_listings")}</p>
 </CardContent>
 </Card>
 </div>

 {/* Charts */}
 <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2">
 <Sparkles className="h-5 w-5 text-muted-foreground" />{t("admin_analytics_booking_revenue_ai_vs")}</CardTitle>
 </CardHeader>
 <CardContent>
 <ResponsiveContainer width="100%" height={300} minWidth={0}>
 <AreaChart data={stats?.conversions}>
 <defs>
 <linearGradient id="colorStaged" x1="0" y1="0" x2="0" y2="1">
 <stop offset="5%" stopColor="#8b5cf6" stopOpacity={0.3} />
 <stop offset="95%" stopColor="#8b5cf6" stopOpacity={0} />
 </linearGradient>
 </defs>
 <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#334155" />
 <XAxis dataKey="date" stroke="#94a3b8" />
 <YAxis stroke="#94a3b8" />
 <Tooltip contentStyle={{
 backgroundColor: '#0f172a',
 borderColor: '#334155'
 }} itemStyle={{
 color: '#f8fafc'
 }} />
 <Legend />
 <Area type="monotone" dataKey="aiGroup" name={t("admin_analytics_ai_enhanced","Yapay Zeka Destekli")} stroke="#8b5cf6" fill="url(#colorStaged)" strokeWidth={3} />
 <Area type="monotone" dataKey="controlGroup" name={t("admin_analytics_standard","Standart")} stroke="#64748b" fill="transparent" strokeWidth={2} strokeDasharray="5 5" />
 </AreaChart>
 </ResponsiveContainer>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2">
 <Brain className="h-5 w-5 text-emerald-400" />{t("admin_analytics_ai_service_roi_breakdown")}</CardTitle>
 </CardHeader>
 <CardContent>
 <ResponsiveContainer width="100%" height={300} minWidth={0}>
 <BarChart data={stats?.roiData}>
 <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#334155" />
 <XAxis dataKey="name" stroke="#94a3b8" />
 <YAxis stroke="#94a3b8" />
 <Tooltip contentStyle={{
 backgroundColor: '#0f172a',
 borderColor: '#334155'
 }} />
 <Legend />
 <Bar dataKey="value" name={t("admin_analytics_roi_score","ROI Skoru")} fill="#10b981" radius={[4, 4, 0, 0]} />
 </BarChart>
 </ResponsiveContainer>
 </CardContent>
 </Card>
 </div>

 {/* Actionable Insights & Handlers */}
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2">
 <Zap className="h-5 w-5 text-muted-foreground" />{t("admin_analytics_ai_service_handlers_performance")}</CardTitle>
 <CardDescription>{t("admin_analytics_direct_breakdown_of_client")}</CardDescription>
 </CardHeader>
 <CardContent>
 <div className="overflow-x-auto">
 <table className="w-full text-sm text-left">
 <thead className="bg-card border-b border-border text-muted-foreground">
 <tr>
 <th className="p-4 font-semibold rounded-tl-xl">{t("admin_analytics_service_handler")}</th>
 <th className="p-4 font-semibold">{t("admin_analytics_processed_properties")}</th>
 <th className="p-4 font-semibold">{t("admin_analytics_generated_bookings")}</th>
 <th className="p-4 font-semibold">{t("admin_analytics_conversion_lift")}</th>
 <th className="p-4 font-semibold rounded-tr-xl">{t("admin_analytics_agent_adoption")}</th>
 </tr>
 </thead>
 <tbody className="divide-y divide-white/10">
 {stats?.services?.map((row, i) => <tr key={i} className="hover:bg-card transition-colors group">
 <td className="p-4 font-medium flex items-center gap-3 text-foreground">
 <div className="p-2 bg-card rounded-lg group-hover:bg-white/10 transition-colors">
 {row.name.includes('Stage') ? <Camera className="w-4 h-4 text-muted-foreground" /> : row.name.includes('Valuation') ? <Brain className="w-4 h-4 text-emerald-400" /> : <AlertCircle className="w-4 h-4 text-amber-400" />}
 </div>
 {row.name}
 </td>
 <td className="p-4 text-muted-foreground">{row.usage.toLocaleString()}</td>
 <td className="p-4 font-bold text-foreground">{t("currency_symbol", "$")}{row.revenue.toLocaleString()}</td>
 <td className="p-4">
 <Badge className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20">
 {row.efficiency.toFixed(1)}{t("admin_analytics_acc")}</Badge>
 </td>
 <td className="p-4 text-muted-foreground">
 <div className="flex items-center gap-3">
 <div className="flex-1 h-1.5 bg-white/10 rounded-full overflow-hidden">
 <div className="h-full bg-muted0 rounded-full" style={{
 width: `${row.trend * 5}%`
 }}></div>
 </div>
 <span>+{row.trend}%</span>
 </div>
 </td>
 </tr>)}
 </tbody>
 </table>
 </div>
 </CardContent>
 </Card>
 </div>;
}
