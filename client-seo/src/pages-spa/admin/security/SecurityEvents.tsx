"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import React, { useState, useEffect } from"react";
import { useQueryClient, useMutation } from"@tanstack/react-query";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Input } from"@/components/ui/input";
import { useToast } from"@/hooks/use-toast";
import { adminApi } from"@/lib/api/admin";
import { apiClient } from"@/lib/api/client";
import { Trash2, MoreHorizontal, Search, AlertTriangle, Shield, Eye, Clock, MapPin, Activity, Ban, RefreshCw, CheckCircle2, Info, Zap, Globe, ShieldAlert } from"lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { cn } from"@/lib/utils";
import { Card, CardContent } from"@/components/ui/card";
interface SecurityEvent {
 id: string;
 orgId: string;
 userId?: string;
 type: string;
 severity: string;
 title: string;
 description: string;
 ipAddress: string;
 userAgent?: string;
 location?: {
 country?: string;
 city?: string;
 region?: string;
 };
 isResolved: boolean;
 createdAt: string;
 user?: {
 name: string;
 email: string;
 };
}
export default function SecurityEvents() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const [editingId, setEditingId] = React.useState<string | null>(null);

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/admin/securityevents/${data.id}`, data),
 onSuccess: () => { toast({ title:"Updated", description:"Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/admin/securityevents/${id}`),
 onSuccess: () => { toast({ title:"Deleted", description:"Record deleted successfully" }); queryClient.invalidateQueries(); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 
 const {
 t
 } = useTranslation();
 const [search, setSearch] = useState("");
 const [filterType, setFilterType] = useState("all");
 const [filterSeverity, setFilterSeverity] = useState("all");
 const [filterStatus, setFilterStatus] = useState("all");
 const [detailOpen, setDetailOpen] = useState(false);
 const [events, setEvents] = useState<SecurityEvent[]>([]);
 const [loading, setLoading] = useState(true);
 const [selectedEvent, setSelectedEvent] = useState<SecurityEvent | null>(null);
 useEffect(() => {
 fetchEvents();
 }, []);
 const fetchEvents = async () => {
 try {
 setLoading(true);
 const response = await adminApi.getSecurityEvents({
 page:"1",
 limit:"50"
 });
 setEvents((response as any).data || []);
 } catch (error) {
 toast({
 title: t("admin_security_sync_failed"),
 description: t("admin_security_could_not_retrieve_neural"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 const getSeverityStyle = (severity: string) => {
 switch (severity) {
 case"CRITICAL":
 return"bg-rose-500/10 text-rose-400 border-rose-500/20";
 case"HIGH":
 return"bg-orange-500/10 text-warning border-orange-500/20";
 case"MEDIUM":
 return"bg-yellow-500/10 text-yellow-500 border-yellow-500/20";
 default:
 return"bg-blue-500/10 text-success border-blue-500/20";
 }
 };
 const filteredEvents = events.filter(e => (e.title.toLowerCase().includes(search.toLowerCase()) || e.ipAddress.includes(search)) && (filterType ==="all" || e.type === filterType) && (filterSeverity ==="all" || e.severity === filterSeverity) && (filterStatus ==="all" || (filterStatus ==="resolved" ? e.isResolved : !e.isResolved)));
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 p-6 space-y-6 min-h-screen">
 <div className="space-y-10 pb-20">
 
 {/* KPI NEURAL GRID */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 {[{
 label: t("admin_security_total_incidents"),
 val: events.length,
 icon: Shield,
 color:"text-muted-foreground"
 }, {
 label: t("admin_security_critical_priority"),
 val: events.filter(e => e.severity ==="CRITICAL").length,
 icon: ShieldAlert,
 color:"text-rose-500"
 }, {
 label: t("admin_security_pending_resolve"),
 val: events.filter(e => !e.isResolved).length,
 icon: Clock,
 color:"text-warning"
 }, {
 label: t("admin_security_detection_pulse"),
 val:"Active",
 icon: Activity,
 color:"text-success"
 }].map((stat, i) => <Card key={i} className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
 <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
 <stat.icon className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{stat.label}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">{stat.val}</h3>
 </CardContent>
 </Card>)}
 </div>

 {/* TACTICAL FILTERS */}
 <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 px-4">
 <div className="relative flex-1 max-w-md group">
 <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-muted-foreground transition-colors" />
 <Input placeholder={t("admin_security_search_audit_trail")} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-slate-500/20 transition-all" value={search} onChange={e => setSearch(e.target.value)} />
 </div>
 <div className="flex flex-wrap gap-3">
 <Select value={filterType} onValueChange={setFilterType}>
 <SelectTrigger className="w-40 bg-card border-border rounded-2xl h-14 text-muted-foreground">
 <SelectValue placeholder={t("admin_security_type_index")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border text-muted-foreground">
 <SelectItem value="all">{t("admin_security_global_matrix")}</SelectItem>
 <SelectItem value="FAILED_LOGIN">{t("admin_security_failed_logins")}</SelectItem>
 <SelectItem value="SUSPICIOUS">{t("admin_security_suspicious")}</SelectItem>
 </SelectContent>
 </Select>
 <Select value={filterSeverity} onValueChange={setFilterSeverity}>
 <SelectTrigger className="w-40 bg-card border-border rounded-2xl h-14 text-muted-foreground">
 <SelectValue placeholder={t("admin_security_severity")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border text-muted-foreground">
 <SelectItem value="all">{t("admin_security_all_severities")}</SelectItem>
 <SelectItem value="CRITICAL">{t("admin_security_critical")}</SelectItem>
 <SelectItem value="HIGH">{t("admin_security_high")}</SelectItem>
 </SelectContent>
 </Select>
 <Button variant="outline" className="h-14 px-6 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground" onClick={fetchEvents}>
 <RefreshCw className="w-4 h-4 mr-2" />{t("admin_security_resync")}</Button>
 </div>
 </div>

 {/* DATA TABLE */}
 <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
 <CardContent className="p-0">
 <Table>
 <TableHeader className="bg-card border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("admin_security_audit_entry")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_severity")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_entity_signature")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_security_node_state")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin_security_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {loading ? <TableRow>
 <TableCell colSpan={5} className="py-20 text-center">
 <Activity className="w-8 h-8 text-muted-foreground animate-spin mx-auto mb-4 opacity-50" />
 <p className="text-xs font-bold text-muted-foreground animate-pulse">{t("admin_security_syncing_event_matrix")}</p>
 </TableCell>
 </TableRow> : filteredEvents.map(event => <TableRow key={event.id} className="border-b border-border hover:bg-card transition-all group">
 <TableCell className="py-8 px-8">
 <div className="flex items-center gap-6">
 <div className="p-3 bg-card border border-border rounded-2xl group-hover:scale-105 transition-all">
 <Shield className="w-5 h-5 text-muted-foreground" />
 </div>
 <div>
 <h6 className="text-sm font-bold text-foreground leading-none">{event.type.replace('_', ' ')}</h6>
 <p className="text-[10px] font-bold text-muted-foreground mt-1">{new Date(event.createdAt).toLocaleString()}</p>
 </div>
 </div>
 </TableCell>
 <TableCell className="px-8">
 <Badge className={cn("text-[9px] font-bold px-2", getSeverityStyle(event.severity))}>
 {event.severity}
 </Badge>
 </TableCell>
 <TableCell className="px-8">
 <div className="space-y-1">
 <p className="text-xs font-bold text-foreground leading-none">{event.user?.name ||"IDENTITY_UNKNOWN"}</p>
 <p className="text-[9px] font-bold text-muted-foreground mt-1 flex items-center gap-1"><Globe className="w-3 h-3" /> {event.ipAddress}</p>
 </div>
 </TableCell>
 <TableCell className="px-8">
 <div className="flex items-center gap-2">
 {event.isResolved ? <CheckCircle2 className="w-4 h-4 text-success" /> : <Clock className="w-4 h-4 text-orange-500" />}
 <span className={cn("text-[10px] font-bold", event.isResolved ?"text-success" :"text-orange-500")}>
 {event.isResolved ?"SYNCED" :"PENDING"}
 </span>
 </div>
 </TableCell>
 <TableCell className="px-8 text-right">
 <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-card text-muted-foreground hover:text-foreground" onClick={() => {
 setSelectedEvent(event);
 setDetailOpen(true);
 }} aria-label={t("common.view")}><Eye className="w-5 h-5" /></Button>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </div>

 <Dialog open={detailOpen} onOpenChange={setDetailOpen}>
 <DialogContent className="bg-card border-border text-foreground rounded-3xl max-w-xl">
 <DialogHeader>
 <DialogTitle className="text-xl font-bold">{t("admin_security_event_metadata_audit")}</DialogTitle>
 </DialogHeader>
 {selectedEvent && <div className="space-y-6 pt-6">
 <div className="grid grid-cols-2 gap-6">
 <div className="p-4 bg-card rounded-2xl border border-border">
 <p className="text-[9px] font-bold text-muted-foreground mb-1">{t("admin_security_temporal_stamp")}</p>
 <p className="text-sm font-bold text-foreground">{new Date(selectedEvent.createdAt).toLocaleString()}</p>
 </div>
 <div className="p-4 bg-card rounded-2xl border border-border">
 <p className="text-[9px] font-bold text-muted-foreground mb-1">{t("admin_security_node_signature")}</p>
 <p className="text-sm font-bold text-foreground font-mono">{selectedEvent.ipAddress}</p>
 </div>
 </div>
 <div className="p-6 bg-card rounded-2xl border border-border">
 <p className="text-[9px] font-bold text-muted-foreground mb-2">{t("admin_security_surveillance_descriptor")}</p>
 <p className="text-sm text-muted-foreground leading-relaxed">{selectedEvent.description}</p>
 </div>
 </div>}
 <DialogFooter className="pt-6">
 <Button onClick={() => setDetailOpen(false)} className="bg-card hover:bg-card text-foreground border border-border rounded-xl font-bold text-[10px] transition-all px-8">{t("admin_security_close_audit")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>;
}
