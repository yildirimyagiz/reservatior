"use client";
import { apiClient } from '@/lib/api/client';

import { t } from"i18next";
import { useState } from"react";
import { m } from"framer-motion";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from"@/components/ui/dialog";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Switch } from"@/components/ui/switch";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { Progress } from"@/components/ui/progress";
import { useToast } from"@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { systemApi } from"@/lib/api/system";
import { Shield, Bell, Wifi, HardDrive, Cpu, MemoryStick, Activity, CheckCircle, XCircle, AlertTriangle, Clock, RefreshCw, Download, MoreHorizontal, Edit, Plus, Eye, Copy, Zap, Loader2 } from"lucide-react";
import { cn } from"@/lib/utils";
interface SystemSetting {
 id: string;
 category: string;
 key: string;
 value: string | boolean | number;
 description: string;
 type:"string" |"number" |"boolean" |"select";
 options?: string[];
 isEncrypted: boolean;
 lastModified: string;
 modifiedBy: string;
}
interface HealthCheck {
 id: string;
 serviceName: string;
 componentName: string;
 status:"HEALTHY" |"UNHEALTHY" |"DEGRADED" |"UNKNOWN";
 responseTime?: number;
 lastChecked: string;
 details?: any;
 errorMessage?: string;
}
interface SystemMetric {
 id: string;
 name: string;
 value: number;
 unit: string;
 threshold: number;
 status:"NORMAL" |"WARNING" |"CRITICAL";
 lastUpdated: string;
}
interface SystemLog {
 id: string;
 level:"INFO" |"WARNING" |"ERROR" |"DEBUG";
 message: string;
 component: string;
 timestamp: string;
 metadata?: any;
}
const MOCK_SETTINGS: SystemSetting[] = [{
 id:"1",
 category:"General",
 key:"system_name",
 value:"Reservatior Platform",
 description: t("admin_system_system_display_name"),
 type:"string",
 isEncrypted: false,
 lastModified:"2024-03-28",
 modifiedBy:"admin"
}, {
 id:"2",
 category:"General",
 key:"system_timezone",
 value:"America/New_York",
 description: t("admin_system_default_system_timezone"),
 type:"select",
 options: ["America/New_York","Europe/London","Asia/Tokyo","Australia/Sydney"],
 isEncrypted: false,
 lastModified:"2024-03-28",
 modifiedBy:"admin"
}, {
 id:"3",
 category:"Security",
 key:"session_timeout",
 value: 1800,
 description: t("admin_system_session_timeout_in_seconds"),
 type:"number",
 isEncrypted: false,
 lastModified:"2024-03-27",
 modifiedBy:"admin"
}, {
 id:"4",
 category:"Security",
 key:"max_login_attempts",
 value: 5,
 description: t("admin_system_maximum_failed_login_attempts"),
 type:"number",
 isEncrypted: false,
 lastModified:"2024-03-28",
 modifiedBy:"admin"
}, {
 id:"5",
 category:"Notifications",
 key:"email_enabled",
 value: true,
 description: t("admin_system_enable_email_notifications"),
 type:"boolean",
 isEncrypted: false,
 lastModified:"2024-03-28",
 modifiedBy:"admin"
}, {
 id:"6",
 category:"Notifications",
 key:"smtp_host",
 value:"smtp.reservatior.com",
 description: t("admin_system_smtp_server_hostname"),
 type:"string",
 isEncrypted: true,
 lastModified:"2024-03-25",
 modifiedBy:"admin"
}];
const MOCK_HEALTH_CHECKS: HealthCheck[] = [{
 id:"1",
 serviceName:"API Server",
 componentName:"Main API",
 status:"HEALTHY",
 responseTime: 45,
 lastChecked:"2024-03-28T10:30:00Z",
 details: {
 uptime:"15d 3h 45m",
 version:"1.2.3"
 }
}, {
 id:"2",
 serviceName:"Database",
 componentName:"PostgreSQL",
 status:"HEALTHY",
 responseTime: 12,
 lastChecked:"2024-03-28T10:30:00Z",
 details: {
 connections: 45,
 maxConnections: 100,
 size:"2.3GB"
 }
}, {
 id:"3",
 serviceName:"Cache",
 componentName:"Redis",
 status:"HEALTHY",
 responseTime: 2,
 lastChecked:"2024-03-28T10:30:00Z",
 details: {
 memory:"128MB",
 keys: 1234,
 hitRate:"94.5%"
 }
}, {
 id:"4",
 serviceName:"Storage",
 componentName:"S3 Bucket",
 status:"DEGRADED",
 responseTime: 234,
 lastChecked:"2024-03-28T10:29:00Z",
 details: {
 used:"45.2GB",
 available:"54.8GB"
 }
}, {
 id:"5",
 serviceName:"Email Service",
 componentName:"SMTP",
 status:"UNHEALTHY",
 lastChecked:"2024-03-28T10:28:00Z",
 errorMessage:"Connection timeout to SMTP server"
}];
const MOCK_METRICS: SystemMetric[] = [{
 id:"1",
 name:"CPU Usage",
 value: 45.2,
 unit:"%",
 threshold: 80,
 status:"NORMAL",
 lastUpdated:"2024-03-28T10:30:00Z"
}, {
 id:"2",
 name:"Memory Usage",
 value: 67.8,
 unit:"%",
 threshold: 85,
 status:"NORMAL",
 lastUpdated:"2024-03-28T10:30:00Z"
}, {
 id:"3",
 name:"Disk Usage",
 value: 82.3,
 unit:"%",
 threshold: 90,
 status:"WARNING",
 lastUpdated:"2024-03-28T10:30:00Z"
}, {
 id:"4",
 name:"Network I/O",
 value: 125.5,
 unit:"MB/s",
 threshold: 500,
 status:"NORMAL",
 lastUpdated:"2024-03-28T10:30:00Z"
}];
const MOCK_LOGS: SystemLog[] = [{
 id:"1",
 level:"INFO",
 message: t("admin_system_system_startup_completed_successfully"),
 component:"System",
 timestamp:"2024-03-28T09:00:00Z",
 metadata: {
 version:"1.2.3"
 }
}, {
 id:"2",
 level:"WARNING",
 message: t("admin_system_high_memory_usage_detected"),
 component:"Memory Monitor",
 timestamp:"2024-03-28T10:15:00Z",
 metadata: {
 usage:"85%"
 }
}, {
 id:"3",
 level:"ERROR",
 message: t("admin_system_failed_to_connect_to"),
 component:"Email Service",
 timestamp:"2024-03-28T10:28:00Z",
 metadata: {
 port: 587
 }
}, {
 id:"4",
 level:"INFO",
 message: t("admin_system_database_backup_completed"),
 component:"Backup Service",
 timestamp:"2024-03-28T10:30:00Z",
 metadata: {
 size:"2.3GB"
 }
}];
import { useTranslation } from"react-i18next";
export default function SystemSettings() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/unknown/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 

 const [activeTab, setActiveTab] = useState("settings");
 const [settingDialogOpen, setSettingDialogOpen] = useState(false);

 // Queries
 const { data: settingsData, isLoading: loadingSettings } = useQuery<SystemSetting[]>({
 queryKey: ['systemConfig'],
 queryFn: async () => {
 const res = await systemApi.getConfig();
 const apiSettings = Array.isArray(res) ? res : ((res as any).data || []);
 return apiSettings.length > 0 ? apiSettings : MOCK_SETTINGS;
 }
 });

 const { data: healthData, isLoading: loadingHealth } = useQuery<HealthCheck[]>({
 queryKey: ['systemHealth'],
 queryFn: async () => {
 const res = await systemApi.getHealthChecks();
 const apiHealth = Array.isArray(res) ? res : ((res as any).data || []);
 return apiHealth.length > 0 ? apiHealth : MOCK_HEALTH_CHECKS;
 }
 });

 const { data: metricsData, isLoading: loadingMetrics } = useQuery<SystemMetric[]>({
 queryKey: ['systemStats'],
 queryFn: async () => {
 const res = await systemApi.getStats();
 const apiMetrics = Array.isArray(res) ? res : ((res as any).data || []);
 return apiMetrics.length > 0 ? apiMetrics : MOCK_METRICS;
 }
 });

 const { data: logsData, isLoading: loadingLogs } = useQuery<SystemLog[]>({
 queryKey: ['systemLogs'],
 queryFn: async () => {
 const res = await systemApi.getLogs();
 const apiLogs = Array.isArray(res) ? res : ((res as any).data || []);
 return apiLogs.length > 0 ? apiLogs : MOCK_LOGS;
 }
 });

 const settings = settingsData || MOCK_SETTINGS;
 const healthChecks = healthData || MOCK_HEALTH_CHECKS;
 const metrics = metricsData || MOCK_METRICS;
 const logs = logsData || MOCK_LOGS;

 const updateSettingMutation = useMutation({
 mutationFn: async ({ key, value }: { key: string, value: any }) => {
 return await systemApi.updateConfig({ [key]: value });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['systemConfig'] });
 toast({
 title: t('systemSettingsActionsUpdate'),
 description: t("admin_system_global_parameter_synchronized")
 });
 },
 onError: (error: any) => {
 toast({
 title: t("admin_system_error","Error"),
 description: error.message,
 variant:"destructive"
 });
 }
 });
 const getStatusBadge = (status: string) => {
 switch (status) {
 case"HEALTHY":
 case"NORMAL":
 return <Badge className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20 text-[10px] font-bold">{t("admin_system_healthy")}</Badge>;
 case"DEGRADED":
 case"WARNING":
 return <Badge className="bg-orange-500/10 text-orange-400 border-orange-500/20 text-[10px] font-bold">{t("admin_system_degraded")}</Badge>;
 case"UNHEALTHY":
 case"CRITICAL":
 return <Badge className="bg-red-500/10 text-red-400 border-red-500/20 text-[10px] font-bold">{t("admin_system_critical")}</Badge>;
 default:
 return <Badge className="bg-muted0/10 text-muted-foreground border-slate-500/20 text-[10px] font-bold">{status}</Badge>;
 }
 };
 const updateSetting = (settingId: string, key: string, value: any) => {
 updateSettingMutation.mutate({ key, value });
 };
 const runHealthCheck = () => {
 toast({
 title: t("admin_system_diagnostics_initiated"),
 description: t("admin_system_scanning_neural_health")
 });
 setTimeout(() => {
 queryClient.invalidateQueries({ queryKey: ['systemHealth'] });
 toast({
 title: t("admin_system_diagnostics_complete"),
 description: t("admin_system_node_verification_finalized")
 });
 }, 1500);
 };
 const restartService = (service: string) => {
 toast({
 title: t("admin_system_node_reload"),
 description: `Re-initializing ${service}...`
 });
 };
 const stats = {
 healthy: healthChecks.filter(h => h.status ==="HEALTHY").length,
 issues: healthChecks.filter(h => h.status !=="HEALTHY").length,
 alerts: metrics.filter(m => m.status !=="NORMAL").length,
 errors: logs.filter(l => l.level ==="ERROR").length
 };
 return <PageShell title={t('systemHubTitle')} description={t('systemHubDesc')}>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-10 pb-20">
 
 {/* KPI Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border rounded-3xl p-8 relative overflow-hidden group border-l border-t">
 <div className="absolute top-0 right-0 p-6 opacity-5 group-hover:opacity-10 transition-all"><Activity className="w-12 h-12" /></div>
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('systemHubActivenodes')}</p>
 <h3 className="text-xl font-bold text-emerald-500 leading-none">{stats.healthy}</h3>
 <p className="text-[10px] font-bold text-muted-foreground mt-4">{t("admin_system_of")}{healthChecks.length}{t("admin_system_total_services")}</p>
 </Card>
 <Card className="bg-card border-border rounded-3xl p-8 relative overflow-hidden group border-l-orange-500/30 border-l border-t">
 <div className="absolute top-0 right-0 p-6 opacity-5 group-hover:opacity-10 transition-all"><AlertTriangle className="w-12 h-12" /></div>
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('disruptions')}</p>
 <h3 className="text-xl font-bold text-orange-500 leading-none">{stats.issues}</h3>
 <p className="text-[10px] font-bold text-orange-500/60 mt-4">{t("admin_system_attention_required")}</p>
 </Card>
 <Card className="bg-card border-border rounded-3xl p-8 relative overflow-hidden group border-l-red-500/30 border-l border-t">
 <div className="absolute top-0 right-0 p-6 opacity-5 group-hover:opacity-10 transition-all"><XCircle className="w-12 h-12" /></div>
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('systemHubAlerts')}</p>
 <h3 className="text-xl font-bold text-red-500 leading-none">{stats.alerts}</h3>
 <p className="text-[10px] font-bold text-red-500/60 mt-4">{t("admin_system_immediate_action")}</p>
 </Card>
 <Card className="bg-card border-border rounded-3xl p-8 relative overflow-hidden group border-l border-t">
 <div className="absolute top-0 right-0 p-6 opacity-5 group-hover:opacity-10 transition-all"><Bell className="w-12 h-12" /></div>
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('faults')}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">{stats.errors}</h3>
 <p className="text-[10px] font-bold text-muted-foreground mt-4">{t("admin_system_last_24_hours")}</p>
 </Card>
 </div>

 {/* Tabs System */}
 <Tabs value={activeTab} onValueChange={setActiveTab} className="w-full">
 <TabsList className="bg-card border border-border p-1 rounded-2xl h-14 w-full grid grid-cols-5 gap-2 max-w-4xl">
 <TabsTrigger value="settings" className="rounded-xl data-[state=active]:bg-primary data-[state=active]:text-foreground font-bold text-[10px] transition-all">{t('settings')}</TabsTrigger>
 <TabsTrigger value="health" className="rounded-xl data-[state=active]:bg-primary data-[state=active]:text-foreground font-bold text-[10px] transition-all">{t('systemHubHealth')}</TabsTrigger>
 <TabsTrigger value="metrics" className="rounded-xl data-[state=active]:bg-primary data-[state=active]:text-foreground font-bold text-[10px] transition-all">{t('systemHubMetrics')}</TabsTrigger>
 <TabsTrigger value="logs" className="rounded-xl data-[state=active]:bg-primary data-[state=active]:text-foreground font-bold text-[10px] transition-all">{t('logs')}</TabsTrigger>
 <TabsTrigger value="maintenance" className="rounded-xl data-[state=active]:bg-primary data-[state=active]:text-foreground font-bold text-[10px] transition-all">{t('systemHubMaintenance')}</TabsTrigger>
 </TabsList>

 <TabsContent value="settings" className="mt-10 space-y-8">
 {["General","Security","Notifications"].map(cat => <Card key={cat} className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl relative border-l border-t">
 <div className="absolute top-0 left-0 w-full h-px bg-gradient-to-r from-primary/50 via-transparent to-transparent"></div>
 <CardHeader className="px-8 py-6 border-b border-border bg-muted/50">
 <CardTitle className="text-xs font-bold text-muted-foreground">
 {cat ==="General" ? t('general') : cat ==="Security" ? t('security') : t('systemSettingsSectorsNotifications')}
 </CardTitle>
 </CardHeader>
 <CardContent className="p-4 space-y-1">
 {loadingSettings ? (
 <div className="flex justify-center items-center py-6 text-muted-foreground">
 <Loader2 className="w-6 h-6 animate-spin" />
 </div>
 ) : settings.filter(s => s.category === cat).map(s => <div key={s.id} className="flex items-center justify-between p-6 hover:bg-muted/50 rounded-3xl transition-all group">
 <div className="space-y-1">
 <div className="text-sm font-bold text-foreground truncate tracking-tight">{s.key}</div>
 <div className="text-[10px] font-bold text-muted-foreground max-w-sm">{s.description}</div>
 </div>
 <div className="flex items-center gap-6">
 {s.type ==="boolean" ? <Switch checked={!!s.value} onCheckedChange={v => updateSetting(s.id, s.key, v)} className="data-[state=checked]:bg-emerald-600" /> : <Input className="w-48 h-12 bg-card border-border rounded-xl text-xs font-bold text-center text-foreground" defaultValue={String(s.value)} onBlur={e => updateSetting(s.id, s.key, e.target.value)} />}
 {s.isEncrypted && <Shield className="w-4 h-4 text-primary opacity-50 shadow-[0_0_10px_#ea580c]" />}
 </div>
 </div>)}
 </CardContent>
 </Card>)}
 </TabsContent>

 <TabsContent value="health" className="mt-10 grid grid-cols-1 md:grid-cols-2 gap-6">
 {healthChecks.map(h => <Card key={h.id} className="bg-card border-border rounded-4xl p-8 relative group border-l border-t">
 <div className="flex justify-between items-start mb-6">
 <div className="flex gap-4">
 <div className={cn("w-12 h-12 rounded-2xl flex items-center justify-center border", h.status ==="HEALTHY" ?"bg-emerald-500/10 border-emerald-500/20" :"bg-red-500/10 border-red-500/20")}>
 {h.status ==="HEALTHY" ? <CheckCircle className="w-6 h-6 text-emerald-500" /> : <AlertTriangle className="w-6 h-6 text-red-500" />}
 </div>
 <div>
 <h4 className="text-lg font-bold text-foreground leading-none">{h.serviceName}</h4>
 <p className="text-[9px] font-bold text-muted-foreground mt-1">{h.componentName}</p>
 </div>
 </div>
 {getStatusBadge(h.status)}
 </div>
 <div className="space-y-3 bg-card p-4 rounded-2xl border border-border">
 <div className="flex justify-between text-[10px] font-bold"><span className="text-muted-foreground">{t("admin_system_response_index")}</span><span className="text-foreground">{h.responseTime || 0}{t("admin_system_ms")}</span></div>
 <div className="flex justify-between text-[10px] font-bold"><span className="text-muted-foreground">{t("admin_system_last_sync")}</span><span className="text-muted-foreground">{new Date(h.lastChecked).toLocaleTimeString()}</span></div>
 </div>
 <div className="flex justify-end gap-3 mt-8">
 <Button variant="outline" size="sm" onClick={() => restartService(h.serviceName)} className="rounded-xl border-border bg-muted/50 hover:bg-primary font-bold text-[9px] h-10 px-4 transition-all">
 {t('reinitialize')}
 </Button>
 </div>
 </Card>)}
 </TabsContent>
 
 <TabsContent value="metrics" className="mt-10 grid grid-cols-1 md:grid-cols-2 gap-8">
 {metrics.map(m => <Card key={m.id} className="bg-card border-border rounded-4xl p-8 border-l border-t shadow-xl">
 <div className="flex justify-between items-center mb-8">
 <div className="flex gap-4 items-center">
 <div className="w-12 h-12 rounded-2xl bg-card border border-border flex items-center justify-center"><Zap className={cn("w-6 h-6", m.status ==="NORMAL" ?"text-emerald-500" :"text-orange-500")} /></div>
 <h4 className="text-lg font-bold text-foreground leading-none">{m.name}</h4>
 </div>
 {getStatusBadge(m.status)}
 </div>
 <div className="space-y-6">
 <div className="text-2xl font-bold text-foreground leading-none">{m.value}<span className="text-2xl text-slate-600 block text-right mt-1 font-bold">{m.unit}</span></div>
 <div className="space-y-2">
 <div className="flex justify-between text-[9px] font-bold text-muted-foreground"><span>{t("admin_system_load_efficiency")}</span><span>{Math.round(m.value / m.threshold * 100)}%</span></div>
 <Progress value={m.value / m.threshold * 100} className="h-1.5 bg-muted/50" indicatorClassName="bg-primary shadow-[0_0_10px_#ea580c]" />
 </div>
 </div>
 </Card>)}
 </TabsContent>

 <TabsContent value="logs" className="mt-10">
 <Card className="bg-card border-border rounded-4xl overflow-hidden border-l border-t relative shadow-2xl">
 <Table>
 <TableHeader className="bg-muted/50 border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("admin_system_severity")}</TableHead>
 <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("admin_system_payload")}</TableHead>
 <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("admin_system_sync_time")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {loadingLogs ? (
 <TableRow>
 <TableCell colSpan={3} className="text-center py-12">
 <Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" />
 </TableCell>
 </TableRow>
 ) : logs.map(l => <TableRow key={l.id} className="border-b border-border hover:bg-white/3sition-all font-mono">
 <TableCell className="px-8"><Badge className={cn("bg-transparent border text-[9px] font-bold", l.level ==="ERROR" ?"text-red-500 border-red-500/20" :"text-muted-foreground border-slate-400/20")}>{l.level}</Badge></TableCell>
 <TableCell className="px-8 text-[11px] text-muted-foreground font-bold whitespace-pre-wrap">{l.message}</TableCell>
 <TableCell className="px-8 text-[10px] text-muted-foreground">{new Date(l.timestamp).toLocaleString()}</TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </Card>
 </TabsContent>

 <TabsContent value="maintenance" className="mt-10 grid grid-cols-1 md:grid-cols-3 gap-8 pb-10">
 <Card className="bg-card border-border rounded-4xl p-8 hover:bg-muted/50 transition-all text-center border-l border-t border-b-emerald-500/50 border-b-2 shadow-2xl">
 <RefreshCw className="w-10 h-10 text-emerald-500 mx-auto mb-6" />
 <h4 className="text-xl font-bold text-foreground mb-2 leading-none">{t("admin_system_neural_flush")}</h4>
 <p className="text-[10px] font-bold text-muted-foreground mb-8 tracking-tight">{t("admin_system_synchronize_all_cache_nodes")}</p>
 <Button className="w-full bg-muted/50 hover:bg-emerald-600 rounded-2xl h-14 font-bold text-[10px] transition-all">
 {t('flush')}
 </Button>
 </Card>
 <Card className="bg-card border-border rounded-4xl p-8 hover:bg-muted/50 transition-all text-center border-l border-t border-b-slate-500/50 border-b-2 shadow-2xl">
 <Shield className="w-10 h-10 text-slate-500 mx-auto mb-6 shadow-[0_0_20px_#3b82f620]" />
 <h4 className="text-xl font-bold text-foreground mb-2 leading-none">{t("admin_system_full_snapshot")}</h4>
 <p className="text-[10px] font-bold text-muted-foreground mb-8 tracking-tight">{t("admin_system_export_global_system_parameters")}</p>
 <Button className="w-full bg-muted/50 hover:bg-slate-600 rounded-2xl h-14 font-bold text-[10px] transition-all">
 {t('snapshot')}
 </Button>
 </Card>
 <Card className="bg-red-950/10 border-border rounded-4xl p-8 hover:bg-red-900/10 transition-all text-center border-l border-t border-b-red-600/50 border-b-2 shadow-2xl">
 <XCircle className="w-10 h-10 text-red-600 mx-auto mb-6 shadow-[0_0_20px_#dc262620]" />
 <h4 className="text-xl font-bold text-foreground mb-2 leading-none">{t("admin_system_core_reset")}</h4>
 <p className="text-[10px] font-bold text-red-500/50 mb-8 tracking-tight">{t("admin_system_terminate_all_active_threads")}</p>
 <Button variant="destructive" className="w-full rounded-2xl h-14 font-bold text-[10px] shadow-xl shadow-red-600/20 transition-all">
 {t('kill')}
 </Button>
 </Card>
 </TabsContent>
 </Tabs>
 </div>
 </PageShell>;
}