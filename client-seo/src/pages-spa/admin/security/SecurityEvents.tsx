"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import React, { useState, useEffect } from "react";
import { useQueryClient, useMutation } from "@tanstack/react-query";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import { useToast } from "@/hooks/use-toast";
import { adminApi } from "@/lib/api/admin";
import { apiClient } from "@/lib/api/client";
import { Trash2, MoreHorizontal, Search, AlertTriangle, Shield, Eye, Clock, MapPin, Activity, Ban, RefreshCw, CheckCircle2, Info, Zap, Globe, ShieldAlert } from "lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { cn } from "@/lib/utils";
import { Card, CardContent } from "@/components/ui/card";
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
    onSuccess: () => { toast({ title: "Updated", description: "Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/admin/securityevents/${id}`),
    onSuccess: () => { toast({ title: "Deleted", description: "Record deleted successfully" }); queryClient.invalidateQueries(); },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
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
        page: "1",
        limit: "50"
      });
      setEvents((response as any).data || []);
    } catch (error) {
      toast({
        title: t("admin.security.sync_failed"),
        description: t("admin.security.could_not_retrieve_neural"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const getSeverityStyle = (severity: string) => {
    switch (severity) {
      case "CRITICAL":
        return "bg-rose-500/10 text-rose-400 border-rose-500/20";
      case "HIGH":
        return "bg-orange-500/10 text-orange-400 border-orange-500/20";
      case "MEDIUM":
        return "bg-yellow-500/10 text-yellow-500 border-yellow-500/20";
      default:
        return "bg-emerald-500/10 text-emerald-400 border-emerald-500/20";
    }
  };
  const filteredEvents = events.filter(e => (e.title.toLowerCase().includes(search.toLowerCase()) || e.ipAddress.includes(search)) && (filterType === "all" || e.type === filterType) && (filterSeverity === "all" || e.severity === filterSeverity) && (filterStatus === "all" || (filterStatus === "resolved" ? e.isResolved : !e.isResolved)));
  return <div className="p-6 space-y-6 min-h-screen">
      <div className="space-y-10 pb-20">
        
        {/* KPI NEURAL GRID */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
           {[{
          label: t("admin.security.total_incidents"),
          val: events.length,
          icon: Shield,
          color: "text-slate-400"
        }, {
          label: t("admin.security.critical_priority"),
          val: events.filter(e => e.severity === "CRITICAL").length,
          icon: ShieldAlert,
          color: "text-rose-500"
        }, {
          label: t("admin.security.pending_resolve"),
          val: events.filter(e => !e.isResolved).length,
          icon: Clock,
          color: "text-orange-400"
        }, {
          label: t("admin.security.detection_pulse"),
          val: "Active",
          icon: Activity,
          color: "text-emerald-400"
        }].map((stat, i) => <Card key={i} className="bg-white/5 border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group">
                <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
                   <stat.icon className="w-12 h-12" />
                </div>
                <CardContent className="p-8">
                  <p className="text-[10px] font-bold text-slate-400 mb-1">{stat.label}</p>
                  <h3 className="text-xl font-bold text-white leading-none">{stat.val}</h3>
                </CardContent>
             </Card>)}
        </div>

        {/* TACTICAL FILTERS */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 px-4">
           <div className="relative flex-1 max-w-md group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 group-focus-within:text-slate-500 transition-colors" />
              <Input placeholder={t("admin.security.search_audit_trail")} className="bg-white/5 border-white/10 rounded-2xl pl-12 h-14 text-white focus:ring-slate-500/20 transition-all" value={search} onChange={e => setSearch(e.target.value)} />
           </div>
           <div className="flex flex-wrap gap-3">
              <Select value={filterType} onValueChange={setFilterType}>
                <SelectTrigger className="w-40 bg-white/5 border-white/10 rounded-2xl h-14 text-slate-400">
                  <SelectValue placeholder={t("admin.security.type_index")} />
                </SelectTrigger>
                <SelectContent className="bg-[#1a1b1e] border-white/10 text-slate-400">
                  <SelectItem value="all">{t("admin.security.global_matrix")}</SelectItem>
                  <SelectItem value="FAILED_LOGIN">{t("admin.security.failed_logins")}</SelectItem>
                  <SelectItem value="SUSPICIOUS">{t("admin.security.suspicious")}</SelectItem>
                </SelectContent>
              </Select>
              <Select value={filterSeverity} onValueChange={setFilterSeverity}>
                <SelectTrigger className="w-40 bg-white/5 border-white/10 rounded-2xl h-14 text-slate-400">
                  <SelectValue placeholder={t("admin.security.severity")} />
                </SelectTrigger>
                <SelectContent className="bg-[#1a1b1e] border-white/10 text-slate-400">
                  <SelectItem value="all">{t("admin.security.all_severities")}</SelectItem>
                  <SelectItem value="CRITICAL">{t("admin.security.critical")}</SelectItem>
                  <SelectItem value="HIGH">{t("admin.security.high")}</SelectItem>
                </SelectContent>
              </Select>
              <Button variant="outline" className="h-14 px-6 rounded-2xl border-white/10 bg-white/5 text-slate-400 hover:text-white" onClick={fetchEvents}>
                 <RefreshCw className="w-4 h-4 mr-2" />{t("admin.security.resync")}</Button>
           </div>
        </div>

        {/* DATA TABLE */}
        <Card className="bg-white/5 border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
           <CardContent className="p-0">
              <Table>
                 <TableHeader className="bg-white/5 border-b border-white/10">
                    <TableRow className="hover:bg-transparent border-none">
                       <TableHead className="text-[10px] font-bold text-slate-400 py-6 px-8">{t("admin.security.audit_entry")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.security.severity")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.security.entity_signature")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.security.node_state")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-slate-400 px-8 text-right">{t("admin.security.actions")}</TableHead>
                    </TableRow>
                 </TableHeader>
                 <TableBody>
                    {loading ? <TableRow>
                          <TableCell colSpan={5} className="py-20 text-center">
                             <Activity className="w-8 h-8 text-slate-500 animate-spin mx-auto mb-4 opacity-50" />
                             <p className="text-xs font-bold text-slate-400 animate-pulse">{t("admin.security.syncing_event_matrix")}</p>
                          </TableCell>
                        </TableRow> : filteredEvents.map(event => <TableRow key={event.id} className="border-b border-white/10 hover:bg-white/5 transition-all group">
                           <TableCell className="py-8 px-8">
                              <div className="flex items-center gap-6">
                                 <div className="p-3 bg-white/5 border border-white/10 rounded-2xl group-hover:scale-105 transition-all">
                                    <Shield className="w-5 h-5 text-slate-400" />
                                 </div>
                                 <div>
                                    <h6 className="text-sm font-bold text-white leading-none">{event.type.replace('_', ' ')}</h6>
                                    <p className="text-[10px] font-bold text-slate-400 mt-1">{new Date(event.createdAt).toLocaleString()}</p>
                                 </div>
                              </div>
                           </TableCell>
                           <TableCell className="px-8">
                              <Badge className={cn("text-[9px] font-bold   px-2", getSeverityStyle(event.severity))}>
                                 {event.severity}
                              </Badge>
                           </TableCell>
                           <TableCell className="px-8">
                              <div className="space-y-1">
                                 <p className="text-xs font-bold text-white leading-none">{event.user?.name || "IDENTITY_UNKNOWN"}</p>
                                 <p className="text-[9px] font-bold text-slate-400 mt-1 flex items-center gap-1"><Globe className="w-3 h-3" /> {event.ipAddress}</p>
                              </div>
                           </TableCell>
                           <TableCell className="px-8">
                              <div className="flex items-center gap-2">
                                 {event.isResolved ? <CheckCircle2 className="w-4 h-4 text-emerald-500" /> : <Clock className="w-4 h-4 text-orange-500" />}
                                 <span className={cn("text-[10px] font-bold  ", event.isResolved ? "text-emerald-500" : "text-orange-500")}>
                                    {event.isResolved ? "SYNCED" : "PENDING"}
                                 </span>
                              </div>
                           </TableCell>
                           <TableCell className="px-8 text-right">
                              <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-white/5 text-slate-400 hover:text-white" onClick={() => {
                    setSelectedEvent(event);
                    setDetailOpen(true);
                  }}><Eye className="w-5 h-5" /></Button>
                           </TableCell>
                        </TableRow>)}
                 </TableBody>
              </Table>
           </CardContent>
        </Card>
      </div>

      <Dialog open={detailOpen} onOpenChange={setDetailOpen}>
         <DialogContent className="bg-[#14151a] border-white/10 text-white rounded-3xl max-w-xl">
            <DialogHeader>
               <DialogTitle className="text-xl font-bold">{t("admin.security.event_metadata_audit")}</DialogTitle>
            </DialogHeader>
            {selectedEvent && <div className="space-y-6 pt-6">
                  <div className="grid grid-cols-2 gap-6">
                     <div className="p-4 bg-white/5 rounded-2xl border border-white/10">
                        <p className="text-[9px] font-bold text-slate-400 mb-1">{t("admin.security.temporal_stamp")}</p>
                        <p className="text-sm font-bold text-white">{new Date(selectedEvent.createdAt).toLocaleString()}</p>
                     </div>
                     <div className="p-4 bg-white/5 rounded-2xl border border-white/10">
                        <p className="text-[9px] font-bold text-slate-400 mb-1">{t("admin.security.node_signature")}</p>
                        <p className="text-sm font-bold text-white font-mono">{selectedEvent.ipAddress}</p>
                     </div>
                  </div>
                  <div className="p-6 bg-white/5 rounded-2xl border border-white/10">
                     <p className="text-[9px] font-bold text-slate-400 mb-2">{t("admin.security.surveillance_descriptor")}</p>
                     <p className="text-sm text-slate-400 leading-relaxed">{selectedEvent.description}</p>
                  </div>
               </div>}
            <DialogFooter className="pt-6">
               <Button onClick={() => setDetailOpen(false)} className="bg-white/5 hover:bg-white/5 text-white border border-white/10 rounded-xl font-bold text-[10px] transition-all px-8">{t("admin.security.close_audit")}</Button>
            </DialogFooter>
         </DialogContent>
      </Dialog>
    </div>;
}
