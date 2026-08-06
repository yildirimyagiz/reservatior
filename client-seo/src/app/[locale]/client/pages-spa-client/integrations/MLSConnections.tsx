"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Card, CardContent } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, Database, RefreshCw, Globe, Shield, Zap, Search, Activity, History, CloudLightning, Fingerprint, Loader2 } from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { mlsApi } from "@/lib/api/mls";
const STATUS_CONFIG: Record<string, {
  label: string;
  cls: string;
  icon: any;
}> = {
  ACTIVE: {
    label: t("client.src.synchronized"),
    cls: "bg-success/10 text-success border-success/20 shadow-[0_0_15px_rgba(16,185,129,0.1)]",
    icon: Zap
  },
  ERROR: {
    label: t("client.src.link_disrupted"),
    cls: "bg-red-500/10 text-red-400 border-red-500/20 shadow-[0_0_15px_rgba(239,68,68,0.1)]",
    icon: Activity
  },
  INACTIVE: {
    label: t("client.src.offline"),
    cls: "bg-muted text-muted-foreground border-white/5",
    icon: History
  },
  SYNCING: {
    label: t("client.src.uplinking"),
    cls: "bg-brand/10 text-brand border-blue-500/20 animate-pulse",
    icon: RefreshCw
  }
};

const EMPTY_FORM = {
  name: "",
  provider: "RETS",
  apiKey: "",
  region: "",
  syncInterval: "60"
};
export default function MLSConnections() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const queryClient = useQueryClient();

  const { data: rawData, isLoading } = useQuery({
    queryKey: ['mls-connections'],
    queryFn: async () => {
      const response = await mlsApi.getConnections();
      return (response as any).data || response || [];
    }
  });

  const connections = Array.isArray(rawData) ? rawData : [];
  const filtered = connections.filter((row: any) => String(row.name ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.provider ?? "").toLowerCase().includes(search.toLowerCase()));

  const createMutation = useMutation({
    mutationFn: (data: any) => mlsApi.createConnection(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['mls-connections'] });
      setCreateOpen(false);
      toast({ title: t("client.src.link_established"), description: t("client.src.mls_connection_data_feed") });
      setForm(EMPTY_FORM);
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => mlsApi.updateConnection(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['mls-connections'] });
      setEditOpen(false);
      toast({ title: t("client.src.link_recalibrated"), description: t("client.src.connection_parameters_synchronized_with") });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => mlsApi.deleteConnection(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['mls-connections'] });
      toast({ title: t("client.src.link_severed"), description: t("client.src.mls_connection_purged_from"), variant: "destructive" });
    }
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(form);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({ id: form.id, data: form });
    }
  };
  const handleDelete = (id: string) => deleteMutation.mutate(id);
  const openEdit = (row: any) => {
    setForm({
      ...row
    });
    setEditOpen(true);
  };
  return <PageShell title={t("client.src.mls_connections")} description={t("client.src.bidirectional_property_data_syndication")} createLabel="Initialize Link" onCreateClick={() => {
    setForm(EMPTY_FORM);
    setCreateOpen(true);
  }}>
      <div className="space-y-12">
        {/* Intelligence Stats */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t("client.src.total_links"),
          value: connections.length,
          icon: Globe
        }, {
          label: t("client.src.active_feeds"),
          value: connections.filter(r => (r.status || "").toUpperCase() === 'ACTIVE').length,
          icon: Zap
        }, {
          label: t("client.src.synced_nodes"),
          value: connections.reduce((s, r) => s + (r.listingCount || 0), 0).toLocaleString(),
          icon: Database
        }, {
          label: t("client.src.bandwidth"),
          value: "85%",
          icon: CloudLightning
        }].map((stat, idx) => <Card key={idx} className="bg-card/60 border-white/5 border-l border-t rounded-[32px] p-10 shadow-3xl relative group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-8 opacity-5 text-brand group-hover:scale-110 transition-transform">
                   <stat.icon className="w-16 h-16" />
                </div>
                <p className="text-[10px] font-black text-muted-foreground tracking-widest italic mb-2 leading-none">{stat.label}</p>
                <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stat.value}</h3>
             </Card>)}
        </div>

        {/* Global Search */}
        <div className="relative max-w-2xl mx-auto group">
           <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-muted-foreground group-focus-within:text-brand transition-colors" />
           <input type="text" aria-label="Search link clusters" placeholder={t("client.src.search_link_clusters")} className="w-full h-16 pl-16 pr-8 bg-card/60 border border-white/5 rounded-2xl text-[10px] font-black tracking-widest italic text-white placeholder:text-muted-foreground focus:outline-none focus:border-blue-500/50 transition-all shadow-xl" value={search} onChange={e => setSearch(e.target.value)} />
        </div>

        {/* Tactical Feed Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          {isLoading ? (
             <div className="col-span-1 lg:col-span-2 flex justify-center py-20"><Loader2 className="w-12 h-12 animate-spin text-brand" /></div>
          ) : (
            <AnimatePresence mode="popLayout">
              {filtered.map((row, idx) => <m.div key={row.id || idx} initial={{
            opacity: 0,
            y: 30
          }} animate={{
            opacity: 1,
            y: 0
          }} exit={{
            opacity: 0,
            scale: 0.95
          }} transition={{
            duration: 0.4,
            delay: idx * 0.1
          }} className="bg-card/40 border border-white/5 border-l border-t rounded-[40px] p-10 backdrop-blur-3xl shadow-3xl relative overflow-hidden group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-12 opacity-0 group-hover:opacity-5 transition-opacity text-brand pointer-events-none">
                   <Database className="w-48 h-48" />
                </div>

                <div className="flex items-start justify-between mb-10 relative z-10">
                  <div className="flex items-center gap-6">
                    <div className="h-20 w-20 rounded-3xl bg-black/60 border border-white/10 flex items-center justify-center shadow-2xl group-hover:scale-110 transition-transform">
                       <Fingerprint className="w-10 h-10 text-brand" />
                    </div>
                    <div>
                      <h3 className="text-2xl font-black text-white italic tracking-tighter leading-none mb-2">{row.name}</h3>
                      <div className="flex items-center gap-3">
                         <span className="text-[10px] font-black text-brand tracking-widest italic">{row.provider}</span>
                         <span className="w-1 h-1 rounded-full bg-muted" />
                         <span className="text-[10px] font-black text-muted-foreground tracking-widest italic">{row.region}</span>
                      </div>
                    </div>
                  </div>
                  <Badge className={cn("px-4 py-1.5 rounded-full border text-[9px] font-black  tracking-widest italic", (STATUS_CONFIG[(row.status || "").toUpperCase()] || STATUS_CONFIG.INACTIVE).cls)}>
                     {(STATUS_CONFIG[(row.status || "").toUpperCase()] || STATUS_CONFIG.INACTIVE).label}
                  </Badge>
                </div>

                <div className="grid grid-cols-2 md:grid-cols-3 gap-6 mb-10 pt-8 border-t border-white/5 relative z-10">
                   <div className="space-y-1">
                     <p className="text-[8px] font-black text-muted-foreground italic">{t("client.src.lastsyncepoch")}</p>
                     <p className="text-[11px] font-black text-white italic tracking-tight font-mono">{row.lastSync ? new Date(row.lastSync).toLocaleString() : "NEVER_SYNCED"}</p>
                   </div>
                   <div className="space-y-1">
                     <p className="text-[8px] font-black text-muted-foreground italic">{t("client.src.assetload")}</p>
                     <p className="text-[11px] font-black text-brand italic tracking-tight">{(row.listingCount || 0).toLocaleString()}{t("client.src.nodes")}</p>
                   </div>
                   <div className="space-y-1">
                     <p className="text-[8px] font-black text-muted-foreground italic">{t("client.src.encryptionlvl")}</p>
                     <p className="text-[11px] font-black text-success italic tracking-tight">{t("client.src.aes256v3")}</p>
                   </div>
                </div>

                <div className="flex gap-4 relative z-10">
                   <Button className="flex-2 h-14 rounded-2xl bg-card text-black hover:bg-muted font-black italic tracking-widest text-[10px] transition-all" onClick={() => openEdit(row)}>{t("client.src.recalibrate_bandwidth")}</Button>
                   <Button variant="outline" className="h-14 w-14 rounded-2xl border-white/10 bg-white/5 text-muted-foreground hover:text-red-500 hover:bg-red-500/10 transition-all shrink-0" onClick={() => handleDelete(row.id)} aria-label={t("common.delete")}>
                     <Trash2 className="w-5 h-5" />
                   </Button>
                </div>
              </m.div>)}
            </AnimatePresence>
          )}
        </div>
      </div>

      {/* Modern Interface Dialogs */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="max-w-2xl bg-background border-white/10 text-white rounded-[32px] p-10 font-display">
           <DialogHeader>
             <DialogTitle className="text-3xl font-black italic tracking-tighter">{t("client.src.initialize_link_cluster")}</DialogTitle>
             <DialogDescription className="text-[10px] font-black text-muted-foreground tracking-widest italic">{t("client.src.provisioning_bidirectional_property_data")}</DialogDescription>
           </DialogHeader>
           <form onSubmit={handleCreate} className="space-y-10 py-10">
             <div className="grid grid-cols-1 md:grid-cols-2 gap-10">
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-muted-foreground italic">{t("client.src.connectionalias")}</Label>
                   <Input value={form.name} onChange={e => setForm({
                ...form,
                name: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-foreground" placeholder={t("client.src.eg_nationalgridsync")} />
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-muted-foreground italic">{t("client.src.protocoltype")}</Label>
                   <Select value={form.provider} onValueChange={v => setForm({
                ...form,
                provider: v
              })}>
                     <SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-muted-foreground">
                        <SelectValue />
                     </SelectTrigger>
                     <SelectContent className="bg-card border-white/10 font-display">
                        <SelectItem value="RETS" className="text-muted-foreground font-bold italic">{t("client.src.rets_legacy_uplink")}</SelectItem>
                        <SelectItem value="RESO" className="text-muted-foreground font-bold italic">{t("client.src.reso_webapi_neural")}</SelectItem>
                        <SelectItem value="IDX" className="text-muted-foreground font-bold italic">{t("client.src.idx_stream")}</SelectItem>
                     </SelectContent>
                   </Select>
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-muted-foreground italic">{t("client.src.encryptionsecret")}</Label>
                   <Input type="password" value={form.apiKey} onChange={e => setForm({
                ...form,
                apiKey: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-xs font-black text-white font-mono" placeholder="****************" />
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-muted-foreground italic">{t("client.src.geographicregion")}</Label>
                   <Input value={form.region} onChange={e => setForm({
                ...form,
                region: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-foreground" />
                </div>
             </div>
             <DialogFooter className="gap-6 pt-6 border-t border-white/5">
                <Button type="button" variant="ghost" onClick={() => setCreateOpen(false)} className="text-[10px] font-black italic text-muted-foreground hover:text-white">{t("client.src.abort_protocol")}</Button>
                <Button type="submit" className="h-16 px-12 rounded-2xl bg-blue-600 hover:bg-brand/100 text-white font-black text-[11px] italic tracking-[0.2em] shadow-2xl shadow-blue-600/30">{t("client.src.materialize_hub")}</Button>
             </DialogFooter>
           </form>
        </DialogContent>
      </Dialog>

      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="max-w-2xl bg-background border-white/10 text-white rounded-[32px] p-10 font-display">
           <DialogHeader>
             <DialogTitle className="text-3xl font-black italic tracking-tighter text-brand">{t("client.src.recalibrate_hub_node")}</DialogTitle>
             <DialogDescription className="text-[10px] font-black text-muted-foreground tracking-widest italic">{t("client.src.synchronizing_tactical_parameters_with")}</DialogDescription>
           </DialogHeader>
           {form && <form onSubmit={handleEdit} className="space-y-10 py-10">
               <div className="space-y-3">
                  <Label className="text-[10px] font-black text-muted-foreground italic">{t("client.src.connectionalias")}</Label>
                  <Input value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white" />
               </div>
               <div className="space-y-3">
                  <Label className="text-[10px] font-black text-muted-foreground italic">{t("client.src.protocoltype")}</Label>
                  <Input readOnly value={form.provider} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-muted-foreground" />
               </div>
               <DialogFooter className="pt-6 border-t border-white/5">
                  <Button type="submit" className="w-full h-16 rounded-2xl bg-card text-black hover:bg-muted font-black italic tracking-widest text-[11px]">{t("client.src.synchronize_parameters")}</Button>
               </DialogFooter>
             </form>}
        </DialogContent>
      </Dialog>
    </PageShell>;
}