import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "@/pages/client/layout/PageShell";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit3, Trash2, MoreHorizontal, Globe, Zap, Activity, Shield, RefreshCw, Link2, Home, Calendar, DollarSign, Maximize2, ChevronRight, Plus, Loader2 } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { channelManagementApi } from "@/lib/api/channel-management";
const STATUS_CONFIG: Record<string, {
  label: string;
  color: string;
  icon: any;
}> = {
  CONNECTED: {
    label: t("client.src.synchronized"),
    color: "text-emerald-400 bg-emerald-500/10 border-emerald-500/20",
    icon: Shield
  },
  ERROR: {
    label: t("client.src.linkfailure"),
    color: "text-red-400 bg-red-500/10 border-red-500/20",
    icon: Activity
  },
  DISCONNECTED: {
    label: t("client.src.offline"),
    color: "text-slate-500 bg-slate-500/10 border-white/5",
    icon: Globe
  },
  SYNCING: {
    label: t("client.src.buffering"),
    color: "text-blue-400 bg-blue-500/10 border-blue-500/20",
    icon: RefreshCw
  }
};

const EMPTY_FORM = {
  platform: "",
  apiKey: "",
  syncCalendar: false,
  syncPricing: false
};
export default function VacationRentalPlatforms() {
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

  const { data: channelsData, isLoading } = useQuery({
    queryKey: ['vacation-channels'],
    queryFn: async () => {
      const response = await channelManagementApi.getChannels();
      return (response as any).data || response || [];
    }
  });

  const channels = Array.isArray(channelsData) ? channelsData : [];
  const filtered = channels.filter((row: any) => String(row.name ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.type ?? "").toLowerCase().includes(search.toLowerCase()));

  const createMutation = useMutation({
    mutationFn: (data: any) => channelManagementApi.createChannel(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['vacation-channels'] });
      setCreateOpen(false);
      setForm(EMPTY_FORM);
      toast({ title: t("client.src.distributionnodematerialized"), description: t("client.src.new_platform_endpoint_successfully") });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => channelManagementApi.updateChannel(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['vacation-channels'] });
      setEditOpen(false);
      toast({ title: t("client.src.nodeparameterssynced"), description: t("client.src.platform_configuration_updated_in") });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => channelManagementApi.deleteChannel(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['vacation-channels'] });
      toast({ title: t("client.src.nodeeradicated"), description: t("client.src.platform_endpoint_purged_from"), variant: "destructive" });
    }
  });

  const syncMutation = useMutation({
    mutationFn: (id: string) => channelManagementApi.syncChannel(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['vacation-channels'] });
      toast({ title: t("client.src.synchronized"), description: t("client.src.sync_started") });
    }
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      name: form.platform,
      type: form.platform?.toLowerCase().replace('.com', '_com') as any,
      apiKey: form.apiKey,
      settings: {
        autoSync: form.syncCalendar,
        syncFrequency: 60,
        pricingStrategy: form.syncPricing ? 'dynamic' : 'fixed',
        instantBooking: false,
        lastMinuteDeals: false
      },
      commission: { percentage: 0, fixed: 0, currency: 'USD' }
    });
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({ id: form.id, data: { apiKey: form.apiKey } });
    }
  };
  const handleDelete = (id: string) => deleteMutation.mutate(id);
  const openEdit = (row: any) => {
    setForm({
      ...row
    });
    setEditOpen(true);
  };
  const PlatformNode = ({
    platform,
    idx
  }: {
    platform: any;
    idx: number;
  }) => {
    const {
      t
    } = useTranslation();
    const config = STATUS_CONFIG[platform.status] || STATUS_CONFIG.DISCONNECTED;
    return <motion.div initial={{
      opacity: 0,
      y: 20
    }} animate={{
      opacity: 1,
      y: 0
    }} transition={{
      delay: idx * 0.05
    }} className="bg-[#1a1b1e]/60 border border-white/5 border-l border-t rounded-[40px] p-10 backdrop-blur-3xl shadow-3xl relative overflow-hidden group hover:bg-white/5 transition-all">
        <div className="absolute top-0 right-0 p-10 opacity-5 pointer-events-none group-hover:scale-110 transition-transform">
           <Home className="w-48 h-48 text-blue-500" />
        </div>

        <div className="flex items-start justify-between mb-10 relative z-10">
           <div className="flex items-center gap-6">
              <div className="h-20 w-20 rounded-3xl bg-black/60 border border-white/10 flex items-center justify-center shadow-2xl group-hover:border-blue-500/30 transition-colors">
                 <Globe className="w-10 h-10 text-blue-400" />
              </div>
               <div>
                 <h3 className="text-2xl font-black text-white italic tracking-tighter mb-2 leading-none">{platform.name || platform.type}</h3>
                 <div className="flex items-center gap-2">
                    <config.icon className={cn("w-3 h-3", config.color.split(' ')[0])} />
                    <span className={cn("text-[9px] font-black  tracking-[0.2em] italic", config.color.split(' ')[0])}>{config.label}</span>
                 </div>
              </div>
           </div>
           
           <DropdownMenu>
              <DropdownMenuTrigger asChild>
                 <Button variant="ghost" size="icon" className="h-12 w-12 rounded-2xl hover:bg-white/5 text-slate-500">
                    <MoreHorizontal className="w-6 h-6" />
                 </Button>
              </DropdownMenuTrigger>
               <DropdownMenuContent align="end" className="bg-[#1a1b1e] border-white/10 text-white font-bold italic text-[10px]">
                 <DropdownMenuItem onClick={() => openEdit(platform)} className="focus:bg-blue-600"><Edit3 className="w-4 h-4 mr-2" />{t("client.src.reconfignode")}</DropdownMenuItem>
                 <DropdownMenuItem onClick={() => handleDelete(platform.id)} className="text-red-500 focus:bg-red-600 focus:text-white"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.eraseendpoint")}</DropdownMenuItem>
              </DropdownMenuContent>
           </DropdownMenu>
        </div>

        <div className="grid grid-cols-2 gap-6 mb-10 relative z-10">
           <div className="bg-black/40 border border-white/5 rounded-2xl p-5 hover:bg-white/5 transition-all">
              <p className="text-[8px] font-black text-slate-600 italic mb-2 tracking-widest">{t("client.src.activeproperties")}</p>
              <h4 className="text-2xl font-black text-white italic tracking-tighter">{platform.listings?.active || "ZERO"}</h4>
           </div>
           <div className="bg-black/40 border border-white/5 rounded-2xl p-5 hover:bg-white/5 transition-all">
              <p className="text-[8px] font-black text-slate-600 italic mb-2 tracking-widest">{t("client.src.lifetimebookings")}</p>
              <h4 className="text-2xl font-black text-white italic tracking-tighter">{platform.performance?.bookings || "ZERO"}</h4>
           </div>
        </div>

        <div className="flex items-center justify-between mb-8 pb-8 border-b border-white/5 relative z-10">
           <div className="flex flex-col">
              <span className="text-[8px] font-black text-slate-600 italic mb-1">{t("client.src.lastsynchronization")}</span>
              <span className="text-[10px] font-bold text-slate-400 italic">{platform.integration?.lastSync ? new Date(platform.integration.lastSync).toLocaleString() : "NEVER_SYNCED"}</span>
           </div>
           <Button variant="outline" onClick={() => syncMutation.mutate(platform.id)} disabled={syncMutation.isPending} className="h-10 rounded-xl border-white/5 bg-white/2 hover:bg-blue-600 hover:text-white text-[9px] font-black italic tracking-widest px-4 transition-all">
              <RefreshCw className={cn("w-3 h-3 mr-2", syncMutation.isPending && "animate-spin")} />{t("client.src.syncbuffer")}</Button>
        </div>

        <div className="flex gap-4 relative z-10">
           <Button className="flex-1 h-14 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-[10px] shadow-xl transition-all">{t("client.src.manageinventory")}</Button>
           <Button variant="outline" className="h-14 w-14 rounded-2xl border-white/10 bg-white/5 text-slate-500 hover:text-blue-500 transition-all shrink-0">
              <Maximize2 className="w-5 h-5" />
           </Button>
        </div>
      </motion.div>;
  };
  return <PageShell title={t("client.src.distribution_core")} description={t("client.src.shortterm_rental_synchronization_yield")} searchValue={search} onSearchChange={setSearch} searchPlaceholder="SEARCH DISTRIBUTION NODES...">
      <div className="space-y-12">
        {/* Intelligence Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t("client.src.availnodes"),
          value: channels.length,
          icon: Globe
        }, {
          label: t("client.src.activelinks"),
          value: channels.filter(r => (r.status || '').toLowerCase() === 'active').length,
          icon: Zap
        }, {
          label: t("client.src.syncedprops"),
          value: channels.reduce((s, r) => s + (r.listings?.active || 0), 0),
          icon: Home
        }, {
          label: t("client.src.totalbookings"),
          value: channels.reduce((s, r) => s + (r.performance?.bookings || 0), 0),
          icon: DollarSign
        }].map((stat, idx) => <Card key={idx} className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-10 shadow-3xl relative group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
                   <stat.icon className="w-16 h-16" />
                </div>
                <p className="text-[10px] font-black text-slate-500 tracking-widest italic mb-2 leading-none">{stat.label}</p>
                <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stat.value}</h3>
             </Card>)}
        </div>

        {/* Global Control Bar */}
        <div className="flex flex-col sm:flex-row items-center justify-between gap-6 bg-[#1a1b1e]/60 border border-white/5 p-6 rounded-[28px] backdrop-blur-xl">
           <div className="flex items-center gap-4">
              <div className="h-12 w-12 rounded-xl bg-blue-600/20 border border-blue-500/30 flex items-center justify-center">
                 <Link2 className="w-5 h-5 text-blue-400" />
              </div>
              <div>
                 <h4 className="text-[10px] font-black text-white tracking-widest italic">{t("client.src.neural_link_gateway")}</h4>
                 <p className="text-[8px] font-bold text-slate-500 italic">{t("client.src.status_encryptedchannelactive")}</p>
              </div>
           </div>
           <Button onClick={() => {
          setForm(EMPTY_FORM);
          setCreateOpen(true);
        }} className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[10px] italic tracking-widest shadow-xl shadow-blue-600/30">
             <Plus className="w-4 h-4 mr-2" />{t("client.src.initializeendpoint")}</Button>
        </div>

        {/* Distribution Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-10">
          {isLoading ? (
             <div className="col-span-1 lg:col-span-2 flex justify-center py-20"><Loader2 className="w-12 h-12 animate-spin text-blue-500" /></div>
          ) : (
            <AnimatePresence mode="popLayout">
              {filtered.map((platform, idx) => <PlatformNode key={platform.id || idx} platform={platform} idx={idx} />)}
            </AnimatePresence>
          )}
        </div>
      </div>

      {/* Configuration Dialogs */}
      <Dialog open={createOpen || editOpen} onOpenChange={v => {
      setCreateOpen(v);
      setEditOpen(v);
    }}>
        <DialogContent className="max-w-2xl bg-[#14151a] border-white/10 text-white rounded-[32px] p-10 font-display shadow-3xl">
           <DialogHeader>
             <DialogTitle className="text-3xl font-black italic tracking-tighter">
                {editOpen ? "Recalibrate Endpoint" : "Provision Distribution Hub"}
             </DialogTitle>
             <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic mt-2">{t("client.src.establishing_handshake_with_shortterm")}</DialogDescription>
           </DialogHeader>
           <form onSubmit={editOpen ? handleEdit : handleCreate} className="space-y-10 py-10">
             <div className="space-y-8">
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.targetplatform")}</Label>
                   <Select value={form.platform} onValueChange={v => setForm({
                ...form,
                platform: v
              })}>
                      <SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white">
                         <SelectValue placeholder={t("client.src.selectuplink")} />
                      </SelectTrigger>
                      <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-bold italic text-[10px]">
                         <SelectItem value="Airbnb">{t("client.src.airbnbgrid")}</SelectItem>
                         <SelectItem value="Vrbo">{t("client.src.vrbocluster")}</SelectItem>
                         <SelectItem value="Booking.com">{t("client.src.bookingpulse")}</SelectItem>
                         <SelectItem value="Expedia">{t("client.src.expediacore")}</SelectItem>
                         <SelectItem value="TripAdvisor">{t("client.src.advisornode")}</SelectItem>
                      </SelectContent>
                   </Select>
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.cryptographicapikey")}</Label>
                   <Input type="password" value={form.apiKey || ""} onChange={e => setForm({
                ...form,
                apiKey: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800" placeholder="••••••••••••••••" />
                </div>
                <div className="grid grid-cols-2 gap-6">
                   <div className="flex items-center justify-between bg-black/40 border border-white/5 rounded-2xl p-6">
                      <div className="space-y-1">
                        <Label className="text-[9px] font-black text-white italic tracking-widest">{t("client.src.synccalendar")}</Label>
                        <p className="text-[7px] font-bold text-slate-600">{t("client.src.realtimescheduler")}</p>
                      </div>
                      <Switch checked={form.syncCalendar} onCheckedChange={v => setForm({
                  ...form,
                  syncCalendar: v
                })} />
                   </div>
                   <div className="flex items-center justify-between bg-black/40 border border-white/5 rounded-2xl p-6">
                      <div className="space-y-1">
                        <Label className="text-[9px] font-black text-white italic tracking-widest">{t("client.src.syncpricing")}</Label>
                        <p className="text-[7px] font-bold text-slate-600">{t("client.src.yieldoptimizer")}</p>
                      </div>
                      <Switch checked={form.syncPricing} onCheckedChange={v => setForm({
                  ...form,
                  syncPricing: v
                })} />
                   </div>
                </div>
             </div>
             <DialogFooter className="gap-6 pt-6 border-t border-white/5">
                <Button type="button" variant="ghost" onClick={() => {
              setCreateOpen(false);
              setEditOpen(false);
            }} className="text-[10px] font-black italic text-slate-500 hover:text-white">{t("client.src.abortprotocol")}</Button>
                <Button type="submit" className="h-16 px-12 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[11px] italic tracking-[0.2em] shadow-2xl shadow-blue-600/30">
                   {editOpen ? "SYNC_NODE" : "MATERIALIZE"}
                </Button>
             </DialogFooter>
           </form>
        </DialogContent>
      </Dialog>
    </PageShell>;
}