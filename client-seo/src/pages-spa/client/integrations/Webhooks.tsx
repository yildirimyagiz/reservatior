import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, Zap, Activity, Terminal, Shield, Database, Fingerprint, Cpu, Clock, ArrowUpRight, Plus, Search, Globe, CheckCircle2, AlertTriangle } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { webhooksApi, Webhooks as WebhookModel } from "@/lib/api/webhooks";
const STATUS_CONFIG: Record<string, {
  label: string;
  cls: string;
  icon: any;
}> = {
  ACTIVE: {
    label: t("client.src.active_signal"),
    cls: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
    icon: Zap
  },
  INACTIVE: {
    label: t("client.src.offline"),
    cls: "bg-slate-500/10 text-slate-400 border-white/5",
    icon: Clock
  },
  ERROR: {
    label: t("client.src.critical"),
    cls: "bg-red-500/10 text-red-400 border-red-500/20 shadow-[0_0_15px_rgba(239,68,68,0.1)]",
    icon: AlertTriangle
  }
};

const EMPTY_FORM = {
  name: "",
  url: "",
  secret: "",
  status: "ACTIVE"
};
export default function Webhooks() {
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

  const { data: rawData = [] } = useQuery({
    queryKey: ['webhooks'],
    queryFn: async () => {
      const response = await webhooksApi.getAll("current");
      return (response as any).data || response || [];
    }
  });

  const webhooks = Array.isArray(rawData) ? rawData : [];
  const filtered = webhooks.filter((row: any) => String(row.name ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.url ?? "").toLowerCase().includes(search.toLowerCase()));

  const createMutation = useMutation({
    mutationFn: (data: any) => webhooksApi.create("current", data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['webhooks'] });
      setCreateOpen(false);
      setForm(EMPTY_FORM);
      toast({ title: t("client.src.signal_initialized"), description: t("client.src.webhook_node_successfully_registered") });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => webhooksApi.update("current", id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['webhooks'] });
      setEditOpen(false);
      toast({ title: t("client.src.signal_calibrated"), description: t("client.src.webhook_endpoint_successfully_updated") });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => webhooksApi.delete("current", id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['webhooks'] });
      toast({ title: t("client.src.signal_purged"), description: t("client.src.webhook_node_removed_from"), variant: "destructive" });
    }
  });

  const testMutation = useMutation({
    mutationFn: (id: string) => webhooksApi.test("current", id),
    onSuccess: (data) => {
      if (data.success) {
        toast({ title: "Signal Test Successful", description: `Test delivered in ${data.responseTime}ms` });
      } else {
        toast({ title: "Signal Test Failed", description: data.error || "Unknown error", variant: "destructive" });
      }
    }
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      name: form.name,
      url: form.url,
      events: [{ type: "system", action: "ping", resource: "all" }],
      status: form.status,
      configuration: {
        secret: form.secret,
        retryPolicy: { enabled: true, maxRetries: 3, retryDelay: 1000, backoffMultiplier: 2, maxDelay: 10000 },
        filtering: { enabled: false, conditions: [] },
        transformation: { enabled: false }
      }
    });
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({ id: form.id, data: { name: form.name, url: form.url } });
    }
  };
  const handleDelete = (id: string) => deleteMutation.mutate(id);
  const openEdit = (row: any) => {
    setForm({
      ...row
    });
    setEditOpen(true);
  };
  return <PageShell title={t("client.src.neural_webhooks")} description={t("client.src.advanced_outbound_signal_processing")} createLabel="Initialize Signal" onCreateClick={() => {
    setForm(EMPTY_FORM);
    setCreateOpen(true);
  }}>
      <div className="space-y-12">
        {/* Intelligence Stats */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t("client.src.total_signals"),
          value: webhooks.length,
          icon: Globe
        }, {
          label: t("client.src.active_streams"),
          value: webhooks.filter(r => (r.status || "").toUpperCase() === 'ACTIVE').length,
          icon: Zap
        }, {
          label: t("client.src.system_uptime"),
          value: "99.9%",
          icon: Shield
        }, {
          label: t("client.src.avg_success"),
          value: "97.4%",
          icon: CheckCircle2
        }].map((stat, idx) => <Card key={idx} className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-10 shadow-3xl relative group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
                   <stat.icon className="w-16 h-16" />
                </div>
                <p className="text-[10px] font-black text-slate-500 tracking-widest italic mb-2 leading-none">{stat.label}</p>
                <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stat.value}</h3>
             </Card>)}
        </div>

        {/* Search Command */}
        <div className="relative max-w-2xl mx-auto group">
           <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
           <input type="text" placeholder={t("client.src.search_signal_nodes")} className="w-full h-16 pl-16 pr-8 bg-[#1a1b1e]/60 border border-white/5 rounded-2xl text-[10px] font-black tracking-widest italic text-white placeholder:text-slate-700 focus:outline-none focus:border-blue-500/50 transition-all shadow-xl" value={search} onChange={e => setSearch(e.target.value)} />
        </div>

        {/* Signal Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          <AnimatePresence mode="popLayout">
            {filtered.map((row, idx) => <motion.div key={row.id} initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} exit={{
            opacity: 0,
            scale: 0.95
          }} transition={{
            duration: 0.4,
            delay: idx * 0.1
          }} className="bg-[#1a1b1e]/40 border border-white/5 border-l border-t rounded-[40px] p-10 backdrop-blur-3xl shadow-3xl relative overflow-hidden group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-12 opacity-0 group-hover:opacity-5 transition-opacity text-blue-500 pointer-events-none">
                   <Terminal className="w-32 h-32" />
                </div>

                <div className="flex items-start justify-between mb-10 relative z-10">
                  <div className="flex items-center gap-6">
                    <div className="h-20 w-20 rounded-3xl bg-black/60 border border-white/10 flex items-center justify-center shadow-2xl group-hover:scale-110 transition-transform">
                       <Fingerprint className="w-10 h-10 text-blue-500" />
                    </div>
                    <div>
                      <h3 className="text-2xl font-black text-white italic tracking-tighter leading-none mb-2">{row.name}</h3>
                      <p className="text-[10px] font-bold text-blue-500/60 tracking-widest italic truncate max-w-[200px] font-mono">
                        {row.url}
                      </p>
                    </div>
                  </div>
                  <Badge className={cn("px-4 py-1.5 rounded-full border text-[9px] font-black  tracking-widest italic", (STATUS_CONFIG[(row.status || "").toUpperCase()] || STATUS_CONFIG.INACTIVE).cls)}>
                     {(STATUS_CONFIG[(row.status || "").toUpperCase()] || STATUS_CONFIG.INACTIVE).label}
                  </Badge>
                </div>

                <div className="space-y-6 mb-10">
                   <div className="flex flex-wrap gap-2">
                     {row.events?.map((event: any, i: number) => <Badge key={i} className="bg-black/60 border-white/5 text-[8px] font-black text-slate-400 italic px-3 py-1">
                         {event.type || event}
                       </Badge>)}
                   </div>

                   <div className="grid grid-cols-2 lg:grid-cols-3 gap-6 pt-8 border-t border-white/5">
                      <div className="space-y-1">
                        <p className="text-[8px] font-black text-slate-600 italic">{t("client.src.success_yield")}</p>
                        <p className="text-xl font-black text-white italic tracking-tighter">{row.statistics?.successRate || 0}%</p>
                      </div>
                      <div className="space-y-1">
                        <p className="text-[8px] font-black text-slate-600 italic">{t("client.src.signal_latency")}</p>
                        <p className="text-xl font-black text-blue-400 italic tracking-tighter">{row.statistics?.averageResponseTime || 0}ms</p>
                      </div>
                      <div className="space-y-1 col-span-2 lg:col-span-1">
                        <p className="text-[8px] font-black text-slate-600 italic">{t("client.src.last_signal")}</p>
                        <p className="text-xl font-black text-white italic tracking-tighter truncate">
                          {row.statistics?.lastDelivery ? new Date(row.statistics.lastDelivery).toLocaleTimeString() : "N/A"}
                        </p>
                      </div>
                   </div>
                </div>

                <div className="flex gap-4 relative z-10">
                   <Button className="flex-1 h-14 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-[10px] transition-all" onClick={() => openEdit(row)}>{t("client.src.recalibrate")}</Button>
                   <Button variant="outline" onClick={() => testMutation.mutate(row.id)} disabled={testMutation.isPending} className="h-14 px-8 rounded-2xl border-white/10 bg-white/5 text-[10px] font-black italic tracking-widest text-slate-400 hover:text-white transition-all backdrop-blur-xl">{t("client.src.test_link")}</Button>
                   <Button variant="outline" className="h-14 w-14 rounded-2xl border-white/10 bg-white/5 text-slate-500 hover:text-red-500 hover:bg-red-500/10 transition-all shrink-0" onClick={() => handleDelete(row.id)}>
                     <Trash2 className="w-5 h-5" />
                   </Button>
                </div>
              </motion.div>)}
          </AnimatePresence>
          {filtered.length === 0 && <div className="col-span-full py-40 flex flex-col items-center gap-6 rounded-[40px] border border-dashed border-white/10 bg-black/20">
                <Database className="w-16 h-16 text-slate-800 opacity-20" />
                <p className="text-[10px] font-black text-slate-600 tracking-widest italic animate-pulse">{t("client.src.no_signal_endpoints_detected")}</p>
             </div>}
        </div>
      </div>

      {/* Modern Dialogs */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border-white/10 text-white rounded-[32px] p-10">
           <DialogHeader>
             <DialogTitle className="text-3xl font-black italic tracking-tighter">{t("client.src.initialize_signal_node")}</DialogTitle>
             <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.provisioning_outbound_data_syndication")}</DialogDescription>
           </DialogHeader>
           <form onSubmit={handleCreate} className="space-y-10 py-10">
             <div className="grid grid-cols-1 md:grid-cols-2 gap-10">
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.signal_identifier")}</Label>
                   <Input value={form.name} onChange={e => setForm({
                ...form,
                name: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800" placeholder={t("client.src.eg_partneruplink")} />
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.target_endpoint")}</Label>
                   <Input type="url" value={form.url} onChange={e => setForm({
                ...form,
                url: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800 font-mono" placeholder={t("client.src.httpsapidomaincomv1")} />
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.encryption_secret")}</Label>
                   <Input type="password" value={form.secret} onChange={e => setForm({
                ...form,
                secret: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-xs font-black text-white font-mono" placeholder="****************" />
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.signal_state")}</Label>
                   <Select value={form.status} onValueChange={v => setForm({
                ...form,
                status: v
              })}>
                     <SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-slate-400">
                        <SelectValue />
                     </SelectTrigger>
                     <SelectContent className="bg-[#1a1b1e] border-white/10 font-display">
                        <SelectItem value="ACTIVE" className="text-slate-400 font-bold italic">{t("client.src.active_signal")}</SelectItem>
                        <SelectItem value="INACTIVE" className="text-slate-400 font-bold italic">{t("client.src.standby_mode")}</SelectItem>
                     </SelectContent>
                   </Select>
                </div>
             </div>
             <DialogFooter className="gap-6 pt-6 border-t border-white/5">
                <Button type="button" variant="ghost" onClick={() => setCreateOpen(false)} className="text-[10px] font-black italic text-slate-500 hover:text-white">{t("client.src.abort_protocol")}</Button>
                <Button type="submit" className="h-16 px-12 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[11px] italic tracking-[0.2em] shadow-2xl shadow-blue-600/30">{t("client.src.materialize_signal")}</Button>
             </DialogFooter>
           </form>
        </DialogContent>
      </Dialog>

      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border-white/10 text-white rounded-[32px] p-10">
           <DialogHeader>
             <DialogTitle className="text-3xl font-black italic tracking-tighter text-blue-500">{t("client.src.recalibrate_signal")}</DialogTitle>
             <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.synchronizing_endpoint_parameters_with")}</DialogDescription>
           </DialogHeader>
           {form && <form onSubmit={handleEdit} className="space-y-10 py-10">
               <div className="space-y-3">
                  <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.signal_identifier")}</Label>
                  <Input value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white" />
               </div>
               <div className="space-y-3">
                  <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.target_uri")}</Label>
                  <Input type="url" value={form.url} onChange={e => setForm({
              ...form,
              url: e.target.value
            })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white font-mono" />
               </div>
               <DialogFooter className="pt-6 border-t border-white/5">
                  <Button type="submit" className="w-full h-16 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-[11px]">{t("client.src.synchronize_node")}</Button>
               </DialogFooter>
             </form>}
        </DialogContent>
      </Dialog>
    </PageShell>;
}