"use client";

import { t } from"i18next";
import React, { useState, useEffect } from"react";
import { useTranslation } from"react-i18next";
import { motion } from"framer-motion";
import { PageShell } from"../../client/layout/PageShell";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from"@/components/ui/card";
import { Input } from"@/components/ui/input";
import { useToast } from"@/hooks/use-toast";
import { adminApi } from"@/lib/api/admin";
import { Activity, AlertTriangle, CheckCircle2, TrendingUp, TrendingDown, Cpu, Wifi, Database, Server, Monitor, RefreshCw, Search, Eye, Download, Shield, Zap, Clock, Maximize2 } from"lucide-react";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, AreaChart, Area } from"recharts";
import { cn } from"@/lib/utils";
interface SystemMetric {
 id: string;
 name: string;
 category: MetricCategory;
 value: number;
 unit: string;
 status: MetricStatus;
 threshold?: {
 warning: number;
 critical: number;
 };
 recordedAt: string;
 trend?: {
 direction:"up" |"down" |"stable";
 percentage: number;
 };
 metadata?: Record<string, any>;
}
interface MetricHistory {
 timestamp: string;
 value: number;
 status: MetricStatus;
}
enum MetricCategory {
 SYSTEM ="SYSTEM",
 DATABASE ="DATABASE",
 NETWORK ="NETWORK",
 APPLICATION ="APPLICATION",
 SECURITY ="SECURITY",
 PERFORMANCE ="PERFORMANCE",
}
enum MetricStatus {
 HEALTHY ="HEALTHY",
 WARNING ="WARNING",
 CRITICAL ="CRITICAL",
 UNKNOWN ="UNKNOWN",
}
const CATEGORY_CONFIG = {
 SYSTEM: {
 label: t("admin_system_system"),
 color:"bg-muted0/10 text-muted-foreground border-slate-500/20",
 icon: Cpu
 },
 DATABASE: {
 label: t("admin_system_database"),
 color:"bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
 icon: Database
 },
 NETWORK: {
 label: t("admin_system_network"),
 color:"bg-muted0/10 text-muted-foreground border-slate-500/20",
 icon: Wifi
 },
 APPLICATION: {
 label: t("admin_system_application"),
 color:"bg-orange-500/10 text-orange-400 border-orange-500/20",
 icon: Server
 },
 SECURITY: {
 label: t("admin_system_security"),
 color:"bg-red-500/10 text-red-400 border-red-500/20",
 icon: Shield
 },
 PERFORMANCE: {
 label: t("admin_system_performance"),
 color:"bg-pink-500/10 text-pink-400 border-pink-500/20",
 icon: Activity
 }
};
const STATUS_CONFIG = {
 HEALTHY: {
 label: t("admin_system_healthy"),
 color:"bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
 icon: CheckCircle2
 },
 WARNING: {
 label: t("admin_system_warning"),
 color:"bg-orange-500/10 text-orange-400 border-orange-500/20",
 icon: AlertTriangle
 },
 CRITICAL: {
 label: t("admin_system_critical"),
 color:"bg-red-500/10 text-red-400 border-red-500/20",
 icon: AlertTriangle
 },
 UNKNOWN: {
 label: t("admin_system_unknown"),
 color:"bg-muted0/10 text-muted-foreground border-slate-500/20",
 icon: Activity
 }
};
export default function SystemMetrics() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const [search, setSearch] = useState("");
 const [filterCategory, setFilterCategory] = useState("all");
 const [filterStatus, setFilterStatus] = useState("all");
 const [timeRange, setTimeRange] = useState("1h");
 const [detailOpen, setDetailOpen] = useState(false);
 const [metrics, setMetrics] = useState<SystemMetric[]>([]);
 const [metricHistory, setMetricHistory] = useState<MetricHistory[]>([]);
 const [loading, setLoading] = useState(true);
 const [selectedMetric, setSelectedMetric] = useState<SystemMetric | null>(null);

 // Fetch system metrics from API
 useEffect(() => {
 const fetchMetrics = async () => {
 try {
 setLoading(true);
 const response = await adminApi.getSystemMetrics({
 timeRange,
 include:"history"
 });
 setMetrics((response as any).data?.metrics || []);
 setMetricHistory((response as any).data?.history || []);
 } catch (error) {
 console.error('Error fetching system metrics:', error);
 toast({
 title: t("admin_system_errorsync"),
 description: t('admin_system_metrics_description'),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 fetchMetrics();
 }, [timeRange, t]);
 const filteredMetrics = metrics.filter(metric => {
 const matchesSearch = metric.name.toLowerCase().includes(search.toLowerCase());
 const matchesCategory = filterCategory ==="all" || metric.category === filterCategory;
 const matchesStatus = filterStatus ==="all" || metric.status === filterStatus;
 return matchesSearch && matchesCategory && matchesStatus;
 });
 const totalMetrics = filteredMetrics.length;
 const healthyMetrics = filteredMetrics.filter(m => m.status ==="HEALTHY").length;
 const warningMetrics = filteredMetrics.filter(m => m.status ==="WARNING").length;
 const criticalMetrics = filteredMetrics.filter(m => m.status ==="CRITICAL").length;
 const handleRefreshMetrics = async () => {
 try {
 await adminApi.refreshMetrics();
 toast({
 title: t("admin_system_metricsrefreshed"),
 description: t("admin_system_system_indicators_synchronized_successfully")
 });
 // Reload data
 const data = await adminApi.getSystemMetrics({
 timeRange,
 include:"history"
 });
 setMetrics((data as any).data?.metrics || []);
 setMetricHistory((data as any).data?.history || []);
 } catch (error) {
 console.error('Error refreshing metrics:', error);
 }
 };
 const handleViewDetails = async (metric: SystemMetric) => {
 try {
 const historyRes = await adminApi.getMetricHistory(metric.id, {
 timeRange
 });
 setMetricHistory((historyRes as any).data || []);
 setSelectedMetric(metric);
 setDetailOpen(true);
 } catch (error) {
 console.error('Error fetching metric history:', error);
 }
 };
 const handleExportMetrics = async (format: string) => {
 try {
 const response = await adminApi.exportMetrics({
 format,
 timeRange,
 filters: {
 search,
 category: filterCategory,
 status: filterStatus
 }
 });
 const blob = new Blob([(response as any).data], {
 type: format === 'csv' ? 'text/csv' : 'application/json'
 });
 const url = window.URL.createObjectURL(blob);
 const a = document.createElement('a');
 a.href = url;
 a.download = `system-metrics-${new Date().getTime()}.${format}`;
 document.body.appendChild(a);
 a.click();
 document.body.removeChild(a);
 window.URL.revokeObjectURL(url);
 toast({
 title: t("admin_system_exportready"),
 description: `Neural data prepared in ${format} format.`
 });
 } catch (error) {
 console.error('Error exporting metrics:', error);
 }
 };
 const formatDateTime = (dateString: string) => {
 return new Date(dateString).toLocaleString();
 };
 const getCategoryConfig = (category: MetricCategory) => {
 const config = CATEGORY_CONFIG[category as keyof typeof CATEGORY_CONFIG];
 return config || {
 label: category,
 color:"bg-muted0/10 text-muted-foreground border-slate-500/20",
 icon: Activity
 };
 };
 const getStatusConfig = (status: MetricStatus) => {
 const config = STATUS_CONFIG[status as keyof typeof STATUS_CONFIG];
 return config || {
 label: status,
 color:"bg-muted0/10 text-muted-foreground border-slate-500/20",
 icon: Activity
 };
 };
 const getTrendIcon = (direction?: string) => {
 switch (direction) {
 case"up":
 return <TrendingUp className="h-4 w-4 text-emerald-500" />;
 case"down":
 return <TrendingDown className="h-4 w-4 text-red-500" />;
 default:
 return <Activity className="h-4 w-4 text-muted-foreground opacity-50" />;
 }
 };
 const getChartData = () => {
 return metricHistory.map(item => ({
 time: new Date(item.timestamp).toLocaleTimeString(),
 value: item.value,
 status: item.status
 }));
 };
 const getStatusBadge = (status: MetricStatus) => {
 const config = getStatusConfig(status);
 const Icon = config.icon;
 return <Badge className={cn("text-[9px] font-bold px-3 py-1 rounded-full border transition-all", config.color)}>
 <Icon className="w-3 h-3 mr-1.5" />
 {config.label}
 </Badge>;
 };
 return <PageShell title={t('admin_system_metrics_title')} description={t('admin_system_metrics_description')}>
 <div className="space-y-10 pb-20 selection:bg-primary/30">
 {/* Summary Cards - Neural Grid */}
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
 <motion.div initial={{
 opacity: 0,
 y: 20
 }} animate={{
 opacity: 1,
 y: 0
 }} transition={{
 delay: 0.1
 }}>
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
 <Monitor className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('total')}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">{totalMetrics}</h3>
 <p className="text-[10px] font-bold text-muted-foreground mt-4 flex items-center gap-1">{t("admin_system_activesensors")}</p>
 </CardContent>
 </Card>
 </motion.div>
 
 <motion.div initial={{
 opacity: 0,
 y: 20
 }} animate={{
 opacity: 1,
 y: 0
 }} transition={{
 delay: 0.2
 }}>
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t border-l-emerald-500/30">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
 <CheckCircle2 className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('healthy')}</p>
 <h3 className="text-xl font-bold text-emerald-500 leading-none">{healthyMetrics}</h3>
 <p className="text-[10px] font-bold text-emerald-500/60 mt-4 flex items-center gap-1">{t("admin_system_nominalstatus")}</p>
 </CardContent>
 </Card>
 </motion.div>
 
 <motion.div initial={{
 opacity: 0,
 y: 20
 }} animate={{
 opacity: 1,
 y: 0
 }} transition={{
 delay: 0.3
 }}>
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t border-l-orange-500/30">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
 <AlertTriangle className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('warning')}</p>
 <h3 className="text-xl font-bold text-orange-500 leading-none">{warningMetrics}</h3>
 <p className="text-[10px] font-bold text-orange-500/60 mt-4 flex items-center gap-1">{t("admin_system_attentionreq")}</p>
 </CardContent>
 </Card>
 </motion.div>
 
 <motion.div initial={{
 opacity: 0,
 y: 20
 }} animate={{
 opacity: 1,
 y: 0
 }} transition={{
 delay: 0.4
 }}>
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t border-l-red-500/30">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-red-500">
 <Shield className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('critical')}</p>
 <h3 className="text-xl font-bold text-red-500 leading-none">{criticalMetrics}</h3>
 <p className="text-[10px] font-bold text-red-500/60 mt-4 flex items-center gap-1">{t("admin_system_urgentintervention")}</p>
 </CardContent>
 </Card>
 </motion.div>
 </div>

 {/* Filters and Actions */}
 <div className="bg-card backdrop-blur-xl border border-border rounded-3xl p-6 flex flex-wrap items-center justify-between gap-6 shadow-2xl">
 <div className="flex flex-wrap items-center gap-4">
 <div className="relative group">
 <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-primary transition-colors" />
 <Input placeholder={t('systemMetricsSearch')} value={search} onChange={(e: React.ChangeEvent<HTMLInputElement>) => setSearch(e.target.value)} className="pl-12 w-72 h-12 bg-muted/50 border-border rounded-xl text-foreground placeholder:text-slate-600 font-bold text-[10px] focus:ring-primary/20 transition-all" />
 </div>
 
 <Select value={timeRange} onValueChange={setTimeRange}>
 <SelectTrigger className="w-48 h-12 bg-muted/50 border-border rounded-xl text-foreground font-bold text-[10px] hover:bg-muted/50 transition-all">
 <Clock className="w-4 h-4 mr-2 text-primary" />
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border rounded-xl">
 <SelectItem value="5m" className="text-[10px] font-bold focus:bg-[#1c1d24] focus:text-foreground transition-colors">{t("admin_system_last5min")}</SelectItem>
 <SelectItem value="15m" className="text-[10px] font-bold focus:bg-[#1c1d24] focus:text-foreground transition-colors">{t("admin_system_last15min")}</SelectItem>
 <SelectItem value="1h" className="text-[10px] font-bold focus:bg-[#1c1d24] focus:text-foreground transition-colors">{t("admin_system_lasthour")}</SelectItem>
 <SelectItem value="6h" className="text-[10px] font-bold focus:bg-[#1c1d24] focus:text-foreground transition-colors">{t("admin_system_last6hours")}</SelectItem>
 <SelectItem value="24h" className="text-[10px] font-bold focus:bg-[#1c1d24] focus:text-foreground transition-colors">{t("admin_system_last24hours")}</SelectItem>
 </SelectContent>
 </Select>

 <Select value={filterCategory} onValueChange={setFilterCategory}>
 <SelectTrigger className="w-44 h-12 bg-muted/50 border-border rounded-xl text-foreground font-bold text-[10px] hover:bg-muted/50 transition-all">
 <SelectValue placeholder={t('systemMetricsCategory')} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border rounded-xl">
 <SelectItem value="all" className="text-[10px] font-bold focus:bg-[#1c1d24] focus:text-foreground transition-colors">{t("admin_system_allcategories")}</SelectItem>
 {Object.entries(CATEGORY_CONFIG).map(([key, config]) => <SelectItem key={key} value={key} className="text-[10px] font-bold focus:bg-[#1c1d24] focus:text-foreground transition-colors">
 {config.label}
 </SelectItem>)}
 </SelectContent>
 </Select>
 </div>

 <div className="flex items-center gap-3">
 <Button variant="ghost" onClick={handleRefreshMetrics} className="h-12 px-6 rounded-xl text-[10px] font-bold text-muted-foreground hover:text-foreground hover:bg-muted/50 transition-all">
 <RefreshCw className="h-4 w-4 mr-2" />
 {t('systemMetricsActionsRefresh')}
 </Button>
 <div className="w-px h-8 bg-muted/50 mx-2" />
 <Button variant="ghost" onClick={() => handleExportMetrics('csv')} className="h-12 px-6 rounded-xl text-[10px] font-bold text-muted-foreground hover:text-foreground hover:bg-muted/50 transition-all">
 <Download className="h-4 w-4 mr-2" />{t("admin_system_csv")}</Button>
 <Button variant="ghost" onClick={() => handleExportMetrics('json')} className="h-12 px-6 rounded-xl text-[10px] font-bold text-muted-foreground hover:text-foreground hover:bg-muted/50 transition-all">
 <Download className="h-4 w-4 mr-2" />{t("admin_system_json")}</Button>
 </div>
 </div>

 {/* Metrics Table - Neural Grid */}
 <Card className="bg-card border-border rounded-4xl overflow-hidden border-l border-t relative shadow-2xl">
 <CardHeader className="px-8 py-8 border-b border-border bg-muted/50">
 <div className="flex items-center justify-between">
 <div>
 <CardTitle className="text-xl font-bold text-foreground leading-none">{t('systemMetricsTitle')}</CardTitle>
 <CardDescription className="text-[10px] font-bold text-muted-foreground mt-2">{t("admin_system_realtime_neural_sensor_synchronization")}</CardDescription>
 </div>
 <Activity className="w-8 h-8 text-primary opacity-20" />
 </div>
 </CardHeader>
 <CardContent className="p-0">
 {loading ? <div className="flex flex-col items-center justify-center py-20 space-y-4">
 <RefreshCw className="w-8 h-8 text-primary animate-spin opacity-50" />
 <div className="text-[10px] font-bold text-muted-foreground">{t("admin_system_syncing_neural_nodes")}</div>
 </div> : <Table>
 <TableHeader className="bg-muted/50 border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t('metric')}</TableHead>
 <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t('systemMetricsColumnsCategory')}</TableHead>
 <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t('systemMetricsColumnsValue')}</TableHead>
 <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t('systemMetricsColumnsStatus')}</TableHead>
 <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t('trend')}</TableHead>
 <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground text-right">{t('updated')}</TableHead>
 <TableHead className="w-[80px]"></TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredMetrics.length === 0 ? <TableRow>
 <TableCell colSpan={7} className="text-center py-20">
 <div className="flex flex-col items-center justify-center space-y-3 opacity-30">
 <Search className="w-10 h-10 text-muted-foreground" />
 <div className="text-[10px] font-bold text-muted-foreground">{t("admin_system_no_matching_neural_signatures")}</div>
 </div>
 </TableCell>
 </TableRow> : filteredMetrics.map(metric => {
 const categoryConfig = getCategoryConfig(metric.category);
 return <TableRow key={metric.id} className="border-b border-border hover:bg-muted/50 transition-all group">
 <TableCell className="px-8 py-6">
 <div>
 <div className="text-sm font-bold text-foreground truncate tracking-tight leading-none mb-2">{metric.name}</div>
 {metric.threshold && <div className="text-[9px] font-bold text-muted-foreground opacity-50">{t("admin_system_limits")}{metric.threshold.warning}{t("admin_system_w")}{metric.threshold.critical}C
 </div>}
 </div>
 </TableCell>
 <TableCell className="px-8">
 <div className="flex items-center gap-3">
 <div className={cn("w-8 h-8 rounded-lg flex items-center justify-center border", categoryConfig.color)}>
 <categoryConfig.icon className="w-4 h-4" />
 </div>
 <span className="text-[10px] font-bold text-muted-foreground">{categoryConfig.label}</span>
 </div>
 </TableCell>
 <TableCell className="px-8">
 <div className="flex items-baseline gap-2">
 <span className="text-lg font-bold text-foreground">{metric.value}</span>
 <span className="text-[10px] font-bold text-muted-foreground">{metric.unit}</span>
 </div>
 </TableCell>
 <TableCell className="px-8">
 {getStatusBadge(metric.status)}
 </TableCell>
 <TableCell className="px-8">
 <div className="flex items-center gap-2">
 {getTrendIcon(metric.trend?.direction)}
 {metric.trend && <span className={cn("text-[10px] font-bold", metric.trend.direction ==="up" ?"text-emerald-500" :"text-red-500")}>
 {metric.trend.percentage > 0 ? '+' : ''}{metric.trend.percentage}%
 </span>}
 </div>
 </TableCell>
 <TableCell className="px-8 text-right">
 <div className="flex flex-col items-end">
 <div className="text-[10px] font-bold text-muted-foreground leading-none">{new Date(metric.recordedAt).toLocaleTimeString()}</div>
 <div className="text-[9px] font-bold text-muted-foreground mt-1">{new Date(metric.recordedAt).toLocaleDateString()}</div>
 </div>
 </TableCell>
 <TableCell className="px-8 text-right">
 <Button variant="ghost" size="icon" onClick={() => handleViewDetails(metric)} className="h-10 w-10 text-muted-foreground hover:text-foreground hover:bg-muted/50 rounded-xl transition-all">
 <Maximize2 className="h-4 w-4" />
 </Button>
 </TableCell>
 </TableRow>;
 })}
 </TableBody>
 </Table>}
 </CardContent>
 </Card>

 {/* Metric Details Dialog - Neural HUD */}
 <Dialog open={detailOpen} onOpenChange={setDetailOpen}>
 <DialogContent className="sm:max-w-[900px] bg-card border-border text-foreground rounded-4xl p-0 overflow-hidden shadow-2xl backdrop-blur-2xl">
 <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-primary/50 to-transparent" />
 
 <DialogHeader className="p-10 border-b border-border bg-muted/50 relative">
 <div className="flex items-center gap-4 mb-4">
 <div className={cn("w-14 h-14 rounded-2xl flex items-center justify-center border-l border-t shadow-xl", selectedMetric ? getCategoryConfig(selectedMetric.category).color :"")}>
 {selectedMetric && React.createElement(getCategoryConfig(selectedMetric.category).icon, {
 className:"w-6 h-6"
 })}
 </div>
 <div>
 <DialogTitle className="text-3xl font-bold leading-none">
 {selectedMetric?.name}
 </DialogTitle>
 <DialogDescription className="text-[10px] font-bold text-muted-foreground mt-2 flex items-center gap-2">
 <Zap className="w-3 h-3 text-primary" />{t("admin_system_neuraltelemetrylog")}</DialogDescription>
 </div>
 </div>
 </DialogHeader>

 {selectedMetric && <div className="p-10 space-y-10">
 <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
 <div className="bg-muted/50 p-6 rounded-3xl border border-border border-l border-t">
 <p className="text-[10px] font-bold text-muted-foreground mb-2">{t("admin_system_currentvalue")}</p>
 <div className="flex items-baseline gap-2">
 <span className="text-xl font-bold text-foreground">{selectedMetric.value}</span>
 <span className="text-xs font-bold text-muted-foreground">{selectedMetric.unit}</span>
 </div>
 </div>

 <div className="bg-muted/50 p-6 rounded-3xl border border-border border-l border-t">
 <p className="text-[10px] font-bold text-muted-foreground mb-2">{t("admin_system_nodestatus")}</p>
 <div className="mt-2">
 {getStatusBadge(selectedMetric.status)}
 </div>
 </div>

 <div className="bg-muted/50 p-6 rounded-3xl border border-border border-l border-t">
 <p className="text-[10px] font-bold text-muted-foreground mb-2">{t("admin_system_performancetrend")}</p>
 <div className="flex items-center gap-3">
 <div className={cn("w-10 h-10 rounded-xl flex items-center justify-center bg-muted/50", selectedMetric.trend?.direction ==="up" ?"text-emerald-500" :"text-red-500")}>
 {getTrendIcon(selectedMetric.trend?.direction)}
 </div>
 <div>
 <div className="text-lg font-bold text-foreground leading-none">
 {selectedMetric.trend ? `${selectedMetric.trend.percentage > 0 ? '+' : ''}${selectedMetric.trend.percentage}%` : 'STABLE'}
 </div>
 <div className="text-[9px] font-bold text-muted-foreground mt-1">{t("admin_system_velocitychange")}</div>
 </div>
 </div>
 </div>
 </div>

 {/* Neural Chart */}
 <div className="space-y-6">
 <div className="flex items-center justify-between">
 <h4 className="text-[10px] font-bold text-muted-foreground flex items-center gap-2">
 <Activity className="w-3 h-3 text-primary" />{t("admin_system_historicalpulseanalysis")}</h4>
 <div className="text-[9px] font-bold text-muted-foreground">{t("admin_system_windowing_24hrealtime")}</div>
 </div>
 
 <div className="h-[300px] w-full bg-muted/50 rounded-4xl p-8 border border-border shadow-inner">
 <ResponsiveContainer width="100%" height={300} minWidth={0}>
 <AreaChart data={getChartData()}>
 <defs>
 <linearGradient id="colorValue" x1="0" y1="0" x2="0" y2="1">
 <stop offset="5%" stopColor="hsl(var(--primary))" stopOpacity={0.3} />
 <stop offset="95%" stopColor="hsl(var(--primary))" stopOpacity={0} />
 </linearGradient>
 </defs>
 <CartesianGrid strokeDasharray="3 3" stroke="#ffffff05" vertical={false} />
 <XAxis dataKey="time" stroke="#ffffff15" fontSize={9} fontWeight="900" tickLine={false} axisLine={false} />
 <YAxis stroke="#ffffff15" fontSize={9} fontWeight="900" tickLine={false} axisLine={false} />
 <Tooltip contentStyle={{
 backgroundColor: '#14151a',
 border: '1px solid rgba(255,255,255,0.1)',
 borderRadius: '16px',
 fontSize: '10px',
 fontWeight: '900',
 fontStyle: '',
 color: '#fff'
 }} itemStyle={{
 color: 'hsl(var(--primary))'
 }} />
 <Area type="monotone" dataKey="value" stroke="hsl(var(--primary))" strokeWidth={4} fillOpacity={1} fill="url(#colorValue)" animationDuration={2000} />
 </AreaChart>
 </ResponsiveContainer>
 </div>
 </div>

 <div className="flex items-center justify-between pt-10 border-t border-border">
 <div className="flex items-center gap-4">
 <div className="flex flex-col">
 <span className="text-[9px] font-bold text-slate-600">{t("admin_system_lastsync")}</span>
 <span className="text-[10px] font-bold text-muted-foreground">{formatDateTime(selectedMetric.recordedAt)}</span>
 </div>
 </div>
 <Button onClick={() => setDetailOpen(false)} className="bg-muted/50 border border-border hover:bg-muted/50 text-foreground font-bold text-[10px] h-12 px-10 rounded-2xl transition-all">{t("admin_system_dismissinterface")}</Button>
 </div>
 </div>}
 </DialogContent>
 </Dialog>
 </div>
 </PageShell>;
}