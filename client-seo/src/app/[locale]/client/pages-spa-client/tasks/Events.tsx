"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Card, CardContent } from "@/components/ui/card";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, Calendar, MapPin, Users, Tag, Clock, ArrowUpRight, Plus, Search, Zap, Globe, Shield, Activity } from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
const STATUS_CONFIG: Record<string, {
  label: string;
  cls: string;
  icon: any;
}> = {
  UPCOMING: {
    label: t("client.src.upcoming_event"),
    cls: "bg-blue-500/10 text-blue-400 border-blue-500/20 shadow-[0_0_15px_rgba(59,130,246,0.1)]",
    icon: Calendar
  },
  PLANNED: {
    label: t("client.src.planned_signal"),
    cls: "bg-slate-500/10 text-slate-400 border-white/5",
    icon: Clock
  },
  ONGOING: {
    label: t("client.src.active_now"),
    cls: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20 shadow-[0_0_15px_rgba(16,185,129,0.1)]",
    icon: Activity
  },
  COMPLETED: {
    label: t("client.src.archived"),
    cls: "bg-purple-500/10 text-purple-400 border-purple-500/20",
    icon: Shield
  },
  CANCELLED: {
    label: t("client.src.decommissioned"),
    cls: "bg-red-500/10 text-red-400 border-red-500/20",
    icon: Trash2
  }
};
const MOCK: any[] = [{
  "id": "1",
  "title": "SUNSET VILLA EXPOSURE",
  "type": "OPEN_HOUSE",
  "startDate": "2025-01-18",
  "endDate": "2025-01-18",
  "location": "123 Sunset Blvd",
  "attendeeCount": 24,
  "status": "UPCOMING",
  "priority": "HIGH_PRIORITY"
}, {
  "id": "2",
  "title": "NEURAL HUB Q1 LAUNCH",
  "type": "LAUNCH",
  "startDate": "2025-02-01",
  "endDate": "2025-02-01",
  "location": "Global Plaza Ballroom",
  "attendeeCount": 150,
  "status": "PLANNED",
  "priority": "CRITICAL"
}, {
  "id": "3",
  "title": "OPERATIVE SYNC - SECTOR 4",
  "type": "TRAINING",
  "startDate": "2025-01-25",
  "endDate": "2025-01-25",
  "location": "HQ Strategic Room",
  "attendeeCount": 12,
  "status": "UPCOMING",
  "priority": "MEDIUM_PRIORITY"
}];
const EMPTY_FORM = {
  title: "",
  type: "OPEN_HOUSE",
  startDate: "",
  endDate: "",
  location: "",
  description: "",
  status: "PLANNED"
};
export default function Events() {
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
  const filtered = MOCK.filter(row => String(row.title ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.location ?? "").toLowerCase().includes(search.toLowerCase()));
  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    setCreateOpen(false);
    toast({
      title: t("client.src.event_materialized"),
      description: t("client.src.strategic_signal_successfully_registered")
    });
    setForm(EMPTY_FORM);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    setEditOpen(false);
    toast({
      title: t("client.src.event_recalibrated"),
      description: t("client.src.node_parameters_updated_successfully")
    });
  };
  const handleDelete = () => toast({
    title: t("client.src.event_purged"),
    description: t("client.src.strategic_event_removed_from"),
    variant: "destructive"
  });
  const openEdit = (row: any) => {
    setForm({
      ...row
    });
    setEditOpen(true);
  };
  return <PageShell title={t("client.src.strategic_events")} description={t("client.src.bidirectional_timeline_management_engagement")} createLabel="Initialize Event" onCreateClick={() => {
    setForm(EMPTY_FORM);
    setCreateOpen(true);
  }}>
      <div className="space-y-12">
        {/* Momentum Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t("client.src.total_events"),
          value: MOCK.length,
          icon: Globe
        }, {
          label: t("client.src.upcoming_signals"),
          value: MOCK.filter(r => r.status === 'UPCOMING').length,
          icon: Calendar
        }, {
          label: t("client.src.engagement_index"),
          value: MOCK.reduce((s, r) => s + (r.attendeeCount || 0), 0),
          icon: Users
        }, {
          label: t("client.src.system_load"),
          value: "14%",
          icon: Zap
        }].map((stat, idx) => <Card key={idx} className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-10 shadow-3xl relative group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500 group-hover:scale-110 transition-transform">
                   <stat.icon className="w-16 h-16" />
                </div>
                <p className="text-[10px] font-black text-slate-500 tracking-widest italic mb-2 leading-none">{stat.label}</p>
                <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stat.value}</h3>
             </Card>)}
        </div>

        {/* Global Filter */}
        <div className="relative max-w-2xl mx-auto group">
           <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
           <input type="text" aria-label="Search events" placeholder={t("client.src.search_event_nodes")} className="w-full h-16 pl-16 pr-8 bg-[#1a1b1e]/60 border border-white/5 rounded-2xl text-[10px] font-black tracking-widest italic text-white placeholder:text-slate-700 focus:outline-none focus:border-blue-500/50 transition-all shadow-xl" value={search} onChange={e => setSearch(e.target.value)} />
        </div>

        {/* Tactical Timeline Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          <AnimatePresence mode="popLayout">
            {filtered.map((row, idx) => <m.div key={row.id} initial={{
            opacity: 0,
            scale: 0.95
          }} animate={{
            opacity: 1,
            scale: 1
          }} exit={{
            opacity: 0,
            scale: 0.9
          }} transition={{
            duration: 0.4,
            delay: idx * 0.1
          }} className="bg-[#1a1b1e]/40 border border-white/5 border-l border-t rounded-[40px] p-10 backdrop-blur-3xl shadow-3xl relative overflow-hidden group hover:bg-white/5 transition-all">
                <div className="absolute top-0 right-0 p-12 opacity-0 group-hover:opacity-5 transition-opacity text-blue-500 pointer-events-none">
                   <Zap className="w-48 h-48" />
                </div>

                <div className="flex items-start justify-between mb-10 relative z-10">
                  <div className="flex items-center gap-6">
                    <div className="h-20 w-20 rounded-3xl bg-black/60 border border-white/10 flex items-center justify-center shadow-2xl group-hover:scale-110 transition-transform">
                       <Calendar className="w-10 h-10 text-blue-500" />
                    </div>
                    <div>
                      <h3 className="text-2xl font-black text-white italic tracking-tighter leading-none mb-2">{row.title}</h3>
                      <div className="flex items-center gap-3">
                        <Badge className="bg-blue-600/10 text-blue-500 border-none text-[8px] font-black italic tracking-widest px-3 py-1">
                          {row.type.replace("_", " ")}
                        </Badge>
                        <span className="text-[10px] font-black text-slate-700 italic tracking-widest">{row.priority || "STANDARD_CLEARANCE"}</span>
                      </div>
                    </div>
                  </div>
                  <Badge className={cn("px-4 py-1.5 rounded-full border text-[9px] font-black  tracking-widest italic", STATUS_CONFIG[row.status].cls)}>
                     {STATUS_CONFIG[row.status].label}
                  </Badge>
                </div>

                <div className="grid grid-cols-2 md:grid-cols-4 gap-6 mb-10 pt-8 border-t border-white/5 relative z-10">
                   <div className="space-y-1">
                     <p className="text-[8px] font-black text-slate-600 italic flex items-center gap-1.5"><Clock className="w-2.5 h-2.5" />{t("client.src.startdate")}</p>
                     <p className="text-[11px] font-black text-white italic tracking-tight font-mono">{row.startDate}</p>
                   </div>
                   <div className="space-y-1">
                     <p className="text-[8px] font-black text-slate-600 italic flex items-center gap-1.5"><MapPin className="w-2.5 h-2.5" />{t("client.src.geographicnode")}</p>
                     <p className="text-[11px] font-black text-white italic tracking-tight truncate">{row.location}</p>
                   </div>
                   <div className="space-y-1">
                     <p className="text-[8px] font-black text-slate-600 italic flex items-center gap-1.5"><Users className="w-2.5 h-2.5" />{t("client.src.attendeecap")}</p>
                     <p className="text-[11px] font-black text-emerald-400 italic tracking-tight">{row.attendeeCount}</p>
                   </div>
                   <div className="space-y-1">
                     <p className="text-[8px] font-black text-slate-600 italic flex items-center gap-1.5"><Shield className="w-2.5 h-2.5" />{t("client.src.accesslvl")}</p>
                     <p className="text-[11px] font-black text-blue-400 italic tracking-tight">{t("client.src.lvl3")}</p>
                   </div>
                </div>

                <div className="flex gap-4 relative z-10">
                   <Button className="flex-2 h-14 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-[10px] transition-all" onClick={() => openEdit(row)}>{t("client.src.recalibrate_frequency")}</Button>
                   <Button variant="outline" className="h-14 w-14 rounded-2xl border-white/10 bg-white/5 text-slate-500 hover:text-red-500 hover:bg-red-500/10 transition-all shrink-0" onClick={handleDelete}>
                     <Trash2 className="w-5 h-5" />
                   </Button>
                </div>
              </m.div>)}
          </AnimatePresence>
        </div>
      </div>

      {/* Strategic Interface Dialogs */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border-white/10 text-white rounded-[32px] p-10 font-display">
           <DialogHeader>
             <DialogTitle className="text-3xl font-black italic tracking-tighter">{t("client.src.initialize_strategic_hub")}</DialogTitle>
             <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.registering_bidirectional_event_node")}</DialogDescription>
           </DialogHeader>
           <form onSubmit={handleCreate} className="space-y-8 py-8">
             <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.hubidentifier")}</Label>
                <Input value={form.title} onChange={e => setForm({
              ...form,
              title: e.target.value
            })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800" placeholder={t("client.src.eg_downtownexposure01")} />
             </div>
             <div className="grid grid-cols-2 gap-8">
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.startuplink")}</Label>
                   <Input type="date" value={form.startDate} onChange={e => setForm({
                ...form,
                startDate: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black text-white font-mono" />
                </div>
                <div className="space-y-3">
                   <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.endsyndication")}</Label>
                   <Input type="date" value={form.endDate} onChange={e => setForm({
                ...form,
                endDate: e.target.value
              })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black text-white font-mono" />
                </div>
             </div>
             <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.geographicvector")}</Label>
                <Input value={form.location} onChange={e => setForm({
              ...form,
              location: e.target.value
            })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white placeholder:text-slate-800" />
             </div>
             <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.directivesummary")}</Label>
                <Textarea value={form.description} onChange={e => setForm({
              ...form,
              description: e.target.value
            })} className="bg-black/40 border-white/5 rounded-2xl text-[10px] font-bold italic text-white min-h-[100px]" placeholder={t("client.src.system_directives")} />
             </div>
             <DialogFooter className="gap-6 pt-6 border-t border-white/5">
                <Button type="button" variant="ghost" onClick={() => setCreateOpen(false)} className="text-[10px] font-black italic text-slate-500 hover:text-white">{t("client.src.abort_operation")}</Button>
                <Button type="submit" className="h-16 px-12 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[11px] italic tracking-[0.2em] shadow-2xl shadow-blue-600/30">{t("client.src.materialize_hud")}</Button>
             </DialogFooter>
           </form>
        </DialogContent>
      </Dialog>

      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border-white/10 text-white rounded-[32px] p-10 font-display">
           <DialogHeader>
             <DialogTitle className="text-3xl font-black italic tracking-tighter text-blue-500">{t("client.src.recalibrate_hub_node")}</DialogTitle>
             <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.synchronizing_tactical_parameters_with")}</DialogDescription>
           </DialogHeader>
           {form && <form onSubmit={handleEdit} className="space-y-8 py-8">
               <div className="space-y-3">
                  <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.hubidentifier")}</Label>
                  <Input value={form.title} onChange={e => setForm({
              ...form,
              title: e.target.value
            })} className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-white" />
               </div>
               <div className="grid grid-cols-2 gap-8">
                 <div className="space-y-3">
                    <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.signalstate")}</Label>
                    <Select value={form.status} onValueChange={v => setForm({
                ...form,
                status: v
              })}>
                      <SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-slate-400">
                         <SelectValue />
                      </SelectTrigger>
                      <SelectContent className="bg-[#1a1b1e] border-white/10 font-display">
                         {Object.keys(STATUS_CONFIG).map(s => <SelectItem key={s} value={s} className="text-slate-400 font-bold italic">{STATUS_CONFIG[s].label}</SelectItem>)}
                      </SelectContent>
                    </Select>
                 </div>
                 <div className="space-y-3">
                    <Label className="text-[10px] font-black text-slate-400 italic">{t("client.src.hubtype")}</Label>
                    <Select value={form.type} onValueChange={v => setForm({
                ...form,
                type: v
              })}>
                      <SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-[10px] font-black italic text-slate-400">
                         <SelectValue />
                      </SelectTrigger>
                      <SelectContent className="bg-[#1a1b1e] border-white/10 font-display">
                         {["OPEN_HOUSE", "LAUNCH", "TRAINING", "MEETING", "OTHER"].map(t => <SelectItem key={t} value={t} className="text-slate-400 font-bold italic">{t.replace("_", " ")}</SelectItem>)}
                      </SelectContent>
                    </Select>
                 </div>
               </div>
               <DialogFooter className="pt-6 border-t border-white/5">
                  <Button type="submit" className="w-full h-16 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-[11px]">{t("client.src.synchronize_parameters")}</Button>
               </DialogFooter>
             </form>}
        </DialogContent>
      </Dialog>
    </PageShell>;
}