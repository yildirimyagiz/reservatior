"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import React, { useState, useEffect } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Card, CardContent } from"@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Input } from"@/components/ui/input";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { useQuery } from"@tanstack/react-query";
import { Eye, Download, Shield, Settings, Trash2, Edit, Plus, LogIn, Search, AlertTriangle, Info, Activity, Users } from"lucide-react";
import { cn } from"@/lib/utils";
import { useMutation, useQueryClient } from"@tanstack/react-query";
import { MoreHorizontal } from"lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
interface AuditLog {
 id: string;
 orgId: string;
 userId: string;
 action: string;
 entityType: string;
 entityId: string;
 entityName?: string;
 changes?: Record<string, {
 from: any;
 to: any;
 }>;
 oldValue?: any;
 newValue?: any;
 ipAddress: string;
 userAgent?: string;
 location?: {
 country?: string;
 city?: string;
 };
 createdAt: string;
 severity:"INFO" |"WARNING" |"CRITICAL";
 category: string;
 description?: string;
 user?: {
 id: string;
 name: string;
 email: string;
 role: string;
 };
}
interface AuditStats {
 totalLogs: number;
 infoLogs: number;
 warningLogs: number;
 criticalLogs: number;
 todayLogs: number;
 uniqueUsers: number;
 topActions: Array<{
 action: string;
 count: number;
 }>;
}
const ACTION_ICONS: Record<string, React.ComponentType<any>> = {
 CREATE: Plus,
 UPDATE: Edit,
 DELETE: Trash2,
 LOGIN: LogIn,
 LOGOUT: LogIn,
 SETTINGS: Settings,
 VIEW: Eye,
 EXPORT: Download,
 IMPORT: Download
};
const SEVERITY_CONFIG = {
 INFO: {
 label: t("admin_security_info"),
 color:"bg-slate-100 text-slate-700",
 icon: Info
 },
 WARNING: {
 label: t("admin_security_warning"),
 color:"bg-yellow-100 text-yellow-700",
 icon: AlertTriangle
 },
 CRITICAL: {
 label: t("admin_security_critical"),
 color:"bg-red-100 text-red-700",
 icon: Shield
 }
};
const CATEGORIES = {
 AUTHENTICATION:"Authentication",
 USER_MANAGEMENT:"User Management",
 DATA_MANAGEMENT:"Data Management",
 SECURITY:"Security",
 SYSTEM:"System",
 COMPLIANCE:"Compliance",
 INTEGRATION:"Integration"
};
export default function AuditLogs() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const [editingId, setEditingId] = React.useState<string | null>(null);

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/admin/auditlogs/${data.id}`, data),
 onSuccess: () => { toast({ title:"Updated", description:"Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/admin/auditlogs/${id}`),
 onSuccess: () => { toast({ title:"Deleted", description:"Record deleted successfully" }); queryClient.invalidateQueries(); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 
 const {
 t
 } = useTranslation();
 const [search, setSearch] = useState("");
 const [filterAction, setFilterAction] = useState("all");
 const [filterSeverity, setFilterSeverity] = useState("all");
 const [filterCategory, setFilterCategory] = useState("all");
 const [filterUser, setFilterUser] = useState("all");
 const [detailOpen, setDetailOpen] = useState(false);
 const [selected, setSelected] = useState<AuditLog | null>(null);
 const { data, isLoading: loading } = useQuery({
 queryKey: ['auditLogsData'],
 queryFn: async () => {
 const [logsRes, statsRes, usersRes] = await Promise.all([
 apiClient.get('/audit-logs', { page:"1", limit:"50", include:"user,location" }),
 apiClient.get('/audit-logs/stats'),
 apiClient.get('/users', { page:"1", limit:"100", fields:"id,name,email,role" })
 ]);
 return {
 logs: (logsRes as any).data || [],
 stats: (statsRes as any).data || null,
 users: (usersRes as any).data || []
 };
 }
 });

 const logs = data?.logs || [];
 const stats = data?.stats || null;
 const users = data?.users || [];
 const filteredLogs = logs.filter((log: AuditLog) => {
 const matchesSearch = log.user?.name?.toLowerCase().includes(search.toLowerCase()) || log.user?.email?.toLowerCase().includes(search.toLowerCase()) || log.action.toLowerCase().includes(search.toLowerCase()) || log.entityType.toLowerCase().includes(search.toLowerCase()) || log.entityName?.toLowerCase().includes(search.toLowerCase());
 const matchesAction = filterAction ==="all" || log.action === filterAction;
 const matchesSeverity = filterSeverity ==="all" || log.severity === filterSeverity;
 const matchesCategory = filterCategory ==="all" || log.category === filterCategory;
 const matchesUser = filterUser ==="all" || log.userId === filterUser;
 return matchesSearch && matchesAction && matchesSeverity && matchesCategory && matchesUser;
 });
 const handleExportLogs = async (format: string) => {
 try {
 const response = await apiClient.get('/audit-logs/export', {
 format,
 filters: {
 search,
 action: filterAction,
 severity: filterSeverity,
 category: filterCategory,
 userId: filterUser
 }
 });

 // Create download link
 const blob = new Blob([(response as any).data], {
 type: format === 'csv' ? 'text/csv' : 'application/json'
 });
 const url = window.URL.createObjectURL(blob);
 const a = document.createElement('a');
 a.href = url;
 a.download = `audit-logs.${format}`;
 document.body.appendChild(a);
 a.click();
 document.body.removeChild(a);
 window.URL.revokeObjectURL(url);
 toast({
 title: t("admin_security_export_successful"),
 description: `Audit logs exported as ${format}`
 });
 } catch (error) {
 console.error('Error exporting logs:', error);
 toast({
 title: t("admin_security_export_failed"),
 description: t("admin_security_failed_to_export_audit"),
 variant:"destructive"
 });
 }
 };
 const formatDateTime = (dateString: string) => {
 return new Date(dateString).toLocaleString();
 };
 const getActionIcon = (action: string) => {
 const Icon = ACTION_ICONS[action] || Settings;
 return <Icon className="h-4 w-4" />;
 };
 const getSeverityColor = (severity: string) => {
 const config = SEVERITY_CONFIG[severity as keyof typeof SEVERITY_CONFIG];
 return config ? config.color :"bg-card text-slate-300";
 };
 const getSeverityLabel = (severity: string) => {
 const config = SEVERITY_CONFIG[severity as keyof typeof SEVERITY_CONFIG];
 return config ? config.label : severity;
 };
 const getSeverityIcon = (severity: string) => {
 const config = SEVERITY_CONFIG[severity as keyof typeof SEVERITY_CONFIG];
 return config ? <config.icon className="h-4 w-4" /> : null;
 };
 const formatChanges = (changes: Record<string, {
 from: any;
 to: any;
 }>) => {
 return Object.entries(changes).map(([key, value]) => <div key={key} className="flex items-center justify-between py-1">
 <span className="font-medium">{key}:</span>
 <div className="flex items-center space-x-2">
 <span className="text-red-600 line-through">{String(value.from)}</span>
 <span>→</span>
 <span className="text-green-600">{String(value.to)}</span>
 </div>
 </div>);
 };
 return <PageShell title={t("admin_security_neuroaudit_trail")} description={t("admin_security_realtime_system_synchronization_and")}>
 <div className="space-y-10 pb-20">
 {/* KPI Neural Grid */}
 {stats && <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-muted-foreground">
 <Info className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin_security_total_audit_capacity")}</p>
 <h3 className="text-xl font-bold text-foreground">{stats.totalLogs.toLocaleString()}</h3>
 <p className="text-[10px] font-bold text-muted-foreground mt-4">{t("admin_security_synced_nodes")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
 <Activity className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin_security_diurnal_cycle_events")}</p>
 <h3 className="text-xl font-bold text-muted-foreground">{stats.todayLogs}</h3>
 <p className="text-[10px] font-bold text-slate-500 mt-4">{t("admin_security_active_today")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-red-500/20 rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
 <div className="absolute top-0 right-0 p-6 opacity-20 group-hover:opacity-40 transition-all text-red-500">
 <AlertTriangle className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-red-500/70 mb-1">{t("admin_security_critical_neural_alerts")}</p>
 <h3 className="text-xl font-bold text-red-500">{stats.criticalLogs}</h3>
 <p className="text-[10px] font-bold text-red-400 mt-4 animate-pulse">{t("admin_security_action_required")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
 <Users className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("admin_security_unique_entity_access")}</p>
 <h3 className="text-xl font-bold text-emerald-400">{stats.uniqueUsers}</h3>
 <p className="text-[10px] font-bold text-emerald-500 mt-4">{t("admin_security_verified_syncs")}</p>
 </CardContent>
 </Card>
 </div>}

 {/* Filters and Actions Tactical Interface */}
 <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
 <div className="flex flex-wrap items-center gap-3 flex-1">
 <div className="relative group min-w-[280px]">
 <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-orange-500 transition-colors" />
 <Input placeholder={t("admin_security_search_neurologs")} value={search} onChange={(e: React.ChangeEvent<HTMLInputElement>) => setSearch(e.target.value)} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-orange-500/20 focus:border-orange-500/40 transition-all" />
 </div>
 <Select value={filterAction} onValueChange={setFilterAction}>
 <SelectTrigger className="w-40 bg-card border-border rounded-2xl h-14 text-foreground">
 <SelectValue placeholder={t("admin_security_action")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border rounded-2xl text-muted-foreground">
 <SelectItem value="all">{t("admin_security_all_actions")}</SelectItem>
 {Object.keys(ACTION_ICONS).map(action => <SelectItem key={action} value={action} className="rounded-lg">{action}</SelectItem>)}
 </SelectContent>
 </Select>
 <Select value={filterSeverity} onValueChange={setFilterSeverity}>
 <SelectTrigger className="w-32 bg-card border-border rounded-2xl h-14 text-foreground">
 <SelectValue placeholder={t("admin_security_severity")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border rounded-2xl text-muted-foreground">
 <SelectItem value="all">{t("admin_security_all_levels")}</SelectItem>
 {Object.keys(SEVERITY_CONFIG).map(severity => <SelectItem key={severity} value={severity} className="rounded-lg">{getSeverityLabel(severity)}</SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 <div className="flex items-center gap-3">
 <Button variant="outline" onClick={() => handleExportLogs('csv')} className="h-14 px-6 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground hover:bg-muted/50 gap-2 font-bold text-[10px]">
 <Download className="h-4 w-4" />{t("admin_security_csv")}</Button>
 <Button variant="outline" onClick={() => handleExportLogs('json')} className="h-14 px-6 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground hover:bg-muted/50 gap-2 font-bold text-[10px]">
 <Download className="h-4 w-4" />{t("admin_security_json")}</Button>
 </div>
 </div>

 {/* Audit Logs Neural Table Panel */}
 <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
 <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-orange-600 via-transparent to-transparent opacity-50"></div>
 <CardContent className="p-0">
 <Table>
 <TableHeader className="bg-muted/50 border-b border-border">
 <TableRow className="border-none">
 <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("admin_security_neurotimestamp")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_origin_entity")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_action_pulse")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_severity_index")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin_security_interrogate")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {loading ? <TableRow>
 <TableCell colSpan={5} className="text-center py-20">
 <Activity className="w-8 h-8 text-orange-500 animate-spin mx-auto mb-4 opacity-50" />
 <p className="text-[10px] font-bold text-muted-foreground animate-pulse">{t("admin_security_synchronizing_neural_trail")}</p>
 </TableCell>
 </TableRow> : filteredLogs.length === 0 ? <TableRow>
 <TableCell colSpan={5} className="text-center py-20 px-8">
 <p className="text-[10px] font-bold text-muted-foreground">{t("admin_security_no_neural_events_detected")}</p>
 </TableCell>
 </TableRow> : filteredLogs.map((log: AuditLog) => <tr key={log.id} className="border-b border-border hover:bg-muted/50 transition-all group">
 <td className="py-8 px-8">
 <div className="text-sm font-bold text-muted-foreground">{formatDateTime(log.createdAt)}</div>
 <p className="text-[10px] font-bold text-slate-600 mt-1">{log.ipAddress}</p>
 </td>
 <td className="px-8">
 <div>
 <div className="text-lg font-bold text-foreground leading-tight">{log.user?.name}</div>
 <div className="text-[10px] font-bold text-muted-foreground">{log.user?.email}</div>
 </div>
 </td>
 <td className="px-8">
 <div className="flex items-center gap-3">
 <div className="w-10 h-10 rounded-xl bg-card border border-border flex items-center justify-center group-hover:scale-110 transition-all">
 {getActionIcon(log.action)}
 </div>
 <div>
 <p className="text-[10px] font-bold text-foreground">{log.action}</p>
 <p className="text-[10px] font-bold text-muted-foreground">{log.entityType}</p>
 </div>
 </div>
 </td>
 <td className="px-8">
 <Badge className={cn("text-[9px] font-bold px-3 py-1 rounded-full border-none shadow-lg", log.severity === 'CRITICAL' ? 'bg-red-500/20 text-red-400' : log.severity === 'WARNING' ? 'bg-orange-500/20 text-orange-400' : 'bg-muted0/20 text-muted-foreground')}>
 {getSeverityLabel(log.severity)}
 </Badge>
 </td>
 <td className="px-8 text-right">
 <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-muted/50 text-muted-foreground hover:text-foreground transition-all shadow-xl" onClick={() => {
 setSelected(log);
 setDetailOpen(true);
 }}>
 <Eye className="w-5 h-5" />
 </Button>
 </td>
 </tr>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </div>

 {/* Audit Log Details Dialog */}
 <Dialog open={detailOpen} onOpenChange={setDetailOpen}>
 <DialogContent className="sm:max-w-[600px]">
 <DialogHeader>
 <DialogTitle>{t("admin_security_audit_log_details")}</DialogTitle>
 </DialogHeader>
 {selected && <div className="space-y-4">
 <div className="grid grid-cols-2 gap-4">
 <div>
 <label className="text-sm font-medium">{t("admin_security_timestamp")}</label>
 <div className="text-sm">{formatDateTime(selected.createdAt)}</div>
 </div>
 <div>
 <label className="text-sm font-medium">{t("admin_security_severity")}</label>
 <div className="flex items-center space-x-2">
 {getSeverityIcon(selected.severity)}
 <Badge className={getSeverityColor(selected.severity)}>
 {getSeverityLabel(selected.severity)}
 </Badge>
 </div>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div>
 <label className="text-sm font-medium">{t("admin_security_user")}</label>
 <div>
 <div className="font-medium">{selected.user?.name}</div>
 <div className="text-sm text-muted-foreground">{selected.user?.email}</div>
 <Badge variant="outline" className="text-xs">
 {selected.user?.role}
 </Badge>
 </div>
 </div>
 <div>
 <label className="text-sm font-medium">{t("admin_security_action")}</label>
 <div className="flex items-center space-x-2">
 {getActionIcon(selected.action)}
 <span className="font-medium">{selected.action}</span>
 </div>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div>
 <label className="text-sm font-medium">{t("admin_security_entity")}</label>
 <div>
 <div className="font-medium">{selected.entityType}</div>
 {selected.entityName && <div className="text-sm text-muted-foreground">{selected.entityName}</div>}
 <div className="text-xs text-muted-foreground font-mono">{t("admin_security_id")}{selected.entityId}</div>
 </div>
 </div>
 <div>
 <label className="text-sm font-medium">{t("admin_security_category")}</label>
 <div className="text-sm">
 {CATEGORIES[selected.category as keyof typeof CATEGORIES] || selected.category}
 </div>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div>
 <label className="text-sm font-medium">{t("admin_security_ip_address")}</label>
 <div className="font-mono text-sm">{selected.ipAddress}</div>
 </div>
 <div>
 <label className="text-sm font-medium">{t("admin_security_location")}</label>
 <div className="text-sm">
 {selected.location?.city && selected.location?.country ? `${selected.location.city}, ${selected.location.country}` : t("admin_security_unknown","Bilinmiyor")}
 </div>
 </div>
 </div>
 {selected.userAgent && <div>
 <label className="text-sm font-medium">{t("admin_security_user_agent")}</label>
 <div className="text-sm text-muted-foreground break-all">{selected.userAgent}</div>
 </div>}
 {selected.description && <div>
 <label className="text-sm font-medium">{t("admin_security_description")}</label>
 <div className="text-sm">{selected.description}</div>
 </div>}
 {selected.changes && Object.keys(selected.changes).length > 0 && <div>
 <label className="text-sm font-medium">{t("admin_security_changes")}</label>
 <div className="border rounded-lg p-3 bg-card">
 {formatChanges(selected.changes)}
 </div>
 </div>}
 {(selected.oldValue !== undefined || selected.newValue !== undefined) && <div>
 <label className="text-sm font-medium">{t("admin_security_value_change")}</label>
 <div className="flex items-center space-x-4">
 <div>
 <label className="text-xs text-muted-foreground">{t("admin_security_before")}</label>
 <div className="text-red-600 line-through">{String(selected.oldValue)}</div>
 </div>
 <div>→</div>
 <div>
 <label className="text-xs text-muted-foreground">{t("admin_security_after")}</label>
 <div className="text-green-600">{String(selected.newValue)}</div>
 </div>
 </div>
 </div>}
 </div>}
 <DialogFooter>
 <Button variant="outline" onClick={() => setDetailOpen(false)}>{t("admin_security_close")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </PageShell>;
}