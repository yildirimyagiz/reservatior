"use client";

import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger, DropdownMenuLabel, DropdownMenuSeparator } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw, Calendar, Building, DollarSign, Activity, Plus, ArrowLeft, CheckCircle2, XCircle, Clock, Zap, LayoutGrid, Search } from "lucide-react";
import { Switch } from "@/components/ui/switch";
import { availabilityApi, type Availability as AvailabilityType } from "@/lib/api/availability-enhanced";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { useTranslation } from "react-i18next";
import { useNavigate } from "@/lib/react-router-shim";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { Card, CardContent } from "@/components/ui/card";
const EMPTY_FORM = {
  propertyId: "",
  date: "",
  basePrice: "",
  currentPrice: "",
  isBlocked: false,
  availableUnits: 1,
  totalUnits: 1,
  maxGuests: 2
};
export default function Availability({ propertyId }: { propertyId?: string }) {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);
  const [availabilities, setAvailabilities] = useState<AvailabilityType[]>([]);
  const [properties, setProperties] = useState<Property[]>([]);
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>({ ...EMPTY_FORM, propertyId: propertyId || "" });
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const fetchData = async () => {
    try {
      setLoading(true);
      const [availRes, propRes] = await Promise.all([availabilityApi.getAll(), propertiesApi.getAll()]);
      let list = availRes.data || [];
      if (propertyId) {
        list = list.filter((item: any) => item.propertyId === propertyId);
      }
      setAvailabilities(list);
      setProperties(propRes || []);
    } catch (error) {
      toast({
        title: t('error'),
        description: t('client.property.management.syncingError'),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchData();
  }, []);
  const filtered = availabilities.filter(row => (row.property?.name || "").toLowerCase().includes(search.toLowerCase()) || row.date.includes(search));
  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await availabilityApi.create({
        ...form,
        basePrice: parseFloat(form.basePrice),
        currentPrice: parseFloat(form.currentPrice),
        availableUnits: parseInt(form.availableUnits),
        totalUnits: parseInt(form.totalUnits),
        maxGuests: parseInt(form.maxGuests)
      });
      setCreateOpen(false);
      toast({
        title: t('success')
      });
      setForm(EMPTY_FORM);
      fetchData();
    } catch (error) {
      toast({
        title: t('error'),
        variant: "destructive"
      });
    }
  };
  const handleEdit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedId) return;
    try {
      await availabilityApi.update(selectedId, {
        ...form,
        basePrice: parseFloat(form.basePrice),
        currentPrice: parseFloat(form.currentPrice),
        availableUnits: parseInt(form.availableUnits),
        totalUnits: parseInt(form.totalUnits),
        maxGuests: parseInt(form.maxGuests)
      });
      setEditOpen(false);
      toast({
        title: t('success')
      });
      fetchData();
    } catch (error) {
      toast({
        title: t('error'),
        variant: "destructive"
      });
    }
  };
  const handleDelete = async (id: string) => {
    try {
      await availabilityApi.delete(id);
      toast({
        title: t('commonDelete'),
        variant: "destructive"
      });
      fetchData();
    } catch (error) {
      toast({
        title: t('error'),
        variant: "destructive"
      });
    }
  };
  const openEdit = (row: AvailabilityType) => {
    setSelectedId(row.id);
    setForm({
      propertyId: row.propertyId,
      date: row.date.split("T")[0],
      basePrice: row.basePrice.toString(),
      currentPrice: row.currentPrice.toString(),
      isBlocked: row.isBlocked,
      availableUnits: row.availableUnits.toString(),
      totalUnits: row.totalUnits.toString(),
      maxGuests: row.maxGuests.toString()
    });
    setEditOpen(true);
  };
  const EntityForm = ({
    onSubmit,
    label,
    title,
    desc
  }: {
    onSubmit: (e: React.FormEvent) => void;
    label: string;
    title: string;
    desc: string;
  }) => {
    const {
      t
    } = useTranslation();
    return <div className="bg-[#1a1b1e] border-white/10 text-white rounded-[40px] overflow-hidden backdrop-blur-3xl shadow-3xl">
      <div className="p-10 pb-0">
        <h2 className="text-3xl font-black italic tracking-tighter text-blue-400">{title}</h2>
        <p className="text-slate-500 font-black italic tracking-widest text-[10px] pt-4 leading-relaxed">{desc}</p>
      </div>
      <form onSubmit={onSubmit} className="p-10 space-y-8">
        <div className="space-y-2">
          <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.availability.dialog.property')}</Label>
          <Select value={form.propertyId} onValueChange={v => setForm({
            ...form,
            propertyId: v
          })}>
             <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6 shadow-inner"><SelectValue placeholder={t('client.property.availability.dialog.selectProperty')} /></SelectTrigger>
             <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                {properties.map(p => <SelectItem key={p.id} value={p.id} className="focus:bg-white/5">{p.name}</SelectItem>)}
             </SelectContent>
          </Select>
        </div>
        <div className="space-y-2">
          <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.availability.dialog.date')}</Label>
          <Input type="date" className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={form.date} onChange={e => setForm({
            ...form,
            date: e.target.value
          })} required />
        </div>
        <div className="grid grid-cols-2 gap-8">
          <div className="space-y-2">
            <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('basePrice')}</Label>
            <Input type="number" className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={form.basePrice} onChange={e => setForm({
              ...form,
              basePrice: e.target.value
            })} required />
          </div>
          <div className="space-y-2">
            <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('currentPrice')}</Label>
            <Input type="number" className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={form.currentPrice} onChange={e => setForm({
              ...form,
              currentPrice: e.target.value
            })} required />
          </div>
        </div>
        <div className="grid grid-cols-2 gap-8">
          <div className="space-y-2">
            <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('totalUnits')}</Label>
            <Input type="number" className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={form.totalUnits} onChange={e => setForm({
              ...form,
              totalUnits: e.target.value
            })} />
          </div>
          <div className="space-y-2">
            <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.availability.dialog.availableUnits')}</Label>
            <Input type="number" className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={form.availableUnits} onChange={e => setForm({
              ...form,
              availableUnits: e.target.value
            })} />
          </div>
        </div>
        <div className="flex items-center justify-between rounded-[32px] bg-black/40 border border-white/5 p-6 backdrop-blur-xl">
           <div className="space-y-1">
             <Label className="text-[10px] font-black tracking-widest text-white italic">{t('blockDates')}</Label>
             <p className="text-[9px] font-black text-slate-500 italic tracking-widest">{t('blockDesc')}</p>
           </div>
           <Switch checked={form.isBlocked} onCheckedChange={v => setForm({
            ...form,
            isBlocked: v
          })} className="data-[state=checked]:bg-red-600" />
        </div>
        <DialogFooter className="pt-8 flex gap-4">
          <Button type="button" variant="ghost" onClick={() => {
            setCreateOpen(false);
            setEditOpen(false);
          }} className="h-16 px-8 text-[10px] font-black italic text-slate-500 hover:text-white transition-all">{t('client.property.availability.dialog.cancel')}</Button>
          <Button type="submit" className="flex-1 h-16 rounded-[24px] bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20 active:scale-95 transition-all">{label}</Button>
        </DialogFooter>
      </form>
    </div>;
  };
  return <div className="min-h-screen bg-[#14151a] p-8 lg:p-12 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px] z-0" />
      
      <div className="max-w-[1600px] mx-auto space-y-12 relative z-10">
        {/* Header HUD */}
        <motion.div initial={{
        opacity: 0,
        y: -20
      }} animate={{
        opacity: 1,
        y: 0
      }} className="flex flex-col md:flex-row md:items-center justify-between gap-10">
          <div className="flex items-center gap-8">
            <Button variant="ghost" size="sm" onClick={() => navigate(-1)} className="h-14 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 font-black italic text-[10px] tracking-[0.25em] transition-all group">
              <ArrowLeft className="w-4 h-4 mr-3 group-hover:-translate-x-1 transition-transform" />
              {t('back', {
              defaultValue: 'BACK'
            })}
            </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="space-y-1.5">
              <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-400 text-[9px] font-black tracking-[0.2em] italic">
                <Calendar className="w-3.5 h-3.5" />{t("client.src.reztimegrid")}</div>
              <h1 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter leading-none">{t('client.property.availability.title')}</h1>
              <p className="text-slate-500 text-sm font-black tracking-widest italic">{t('client.property.availability.subtitle')}</p>
            </div>
          </div>
          <div className="flex items-center gap-4">
             <Button variant="ghost" onClick={fetchData} disabled={loading} className="h-16 w-16 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl">
               <RefreshCw className={cn("w-5 h-5", loading ? "animate-spin" : "")} />
             </Button>
             <Button onClick={() => {
            setForm(EMPTY_FORM);
            setCreateOpen(true);
          }} className="h-16 px-10 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20 transition-all hover:scale-105 active:scale-95">
               <Plus className="w-5 h-5 mr-3" /> {t('client.property.availability.add')}
             </Button>
          </div>
        </motion.div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t('total'),
          value: availabilities.length,
          icon: Calendar,
          color: "text-blue-400",
          bg: "bg-blue-500/10"
        }, {
          label: t('available'),
          value: availabilities.filter(r => !r.isBlocked && !r.isBooked).length,
          icon: CheckCircle2,
          color: "text-emerald-400",
          bg: "bg-emerald-500/10"
        }, {
          label: t('booked'),
          value: availabilities.filter(r => r.isBooked).length,
          icon: Clock,
          color: "text-amber-400",
          bg: "bg-amber-500/10"
        }, {
          label: t('blocked'),
          value: availabilities.filter(r => r.isBlocked).length,
          icon: XCircle,
          color: "text-rose-400",
          bg: "bg-rose-500/10"
        }].map((s, i) => <motion.div key={i} initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: i * 0.1
        }}>
               <Card className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] overflow-hidden p-8 hover:bg-white/5 transition-all shadow-2xl relative backdrop-blur-3xl group">
                 <div className="absolute top-0 right-0 p-8 opacity-5 group-hover:scale-110 transition-transform"><s.icon className="w-16 h-16" /></div>
                 <div className="flex justify-between items-start relative z-10">
                   <div>
                      <p className="text-[10px] font-black tracking-widest text-slate-500 mb-2 italic">{s.label}</p>
                      <p className="text-4xl font-black text-white italic tracking-tighter leading-none">{s.value}</p>
                   </div>
                   <div className={cn("w-12 h-12 rounded-2xl flex items-center justify-center border border-white/5 shadow-inner backdrop-blur-md", s.bg)}>
                      <s.icon className={cn("w-6 h-6 shadow-[0_0_15px_currentColor]", s.color)} />
                   </div>
                 </div>
               </Card>
             </motion.div>)}
        </div>

        {/* Filter Surface */}
        <motion.div initial={{
        opacity: 0,
        scale: 0.98
      }} animate={{
        opacity: 1,
        scale: 1
      }}>
          <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] p-8 backdrop-blur-3xl shadow-3xl">
            <div className="relative group">
               <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
               <input placeholder={t('client.property.availability.search')} className="w-full pl-16 h-16 bg-black/40 border border-white/5 rounded-[24px] text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" value={search} onChange={e => setSearch(e.target.value)} />
            </div>
          </Card>
        </motion.div>

        {/* Table Surface */}
        <motion.div initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }}>
          <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] overflow-hidden backdrop-blur-3xl shadow-3xl">
            <Table>
              <TableHeader className="bg-white/2 border-b border-white/5">
                <TableRow className="hover:bg-transparent border-none">
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 py-8 italic">{t('client.property.availability.property')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.availability.date')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('price')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.availability.status')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.availability.units')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 text-right italic">{t("client.src.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {loading ? <TableRow><TableCell colSpan={6} className="text-center py-40"><Activity className="w-12 h-12 text-blue-500 animate-spin mx-auto opacity-20" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-40 text-slate-800 font-black italic tracking-widest text-xs">{t('client.property.availability.noFound')}</TableCell></TableRow> : filtered.map(row => <TableRow key={row.id} className="border-b border-white/5 hover:bg-white/2 transition-all group/row">
                      <TableCell className="px-10 py-8">
                        <div className="flex items-center gap-6">
                           <div className="w-14 h-14 rounded-2xl bg-white/5 border border-white/5 flex items-center justify-center group-hover/row:scale-110 transition-transform duration-500">
                              <Building className="w-5 h-5 text-blue-500" />
                           </div>
                           <div className="space-y-1.5">
                              <p className="font-black text-white text-lg italic tracking-tighter leading-none group-hover/row:text-blue-400 transition-colors">{row.property?.name || "???"}</p>
                              <p className="text-[9px] font-mono text-slate-600 tracking-widest">{row.propertyId}</p>
                           </div>
                        </div>
                      </TableCell>
                      <TableCell className="px-10">
                        <div className="flex items-center gap-3">
                           <Calendar className="w-4 h-4 text-slate-500" />
                           <span className="font-black text-slate-300 text-[10px] italic tracking-widest">{new Date(row.date).toLocaleDateString()}</span>
                        </div>
                      </TableCell>
                      <TableCell className="px-10">
                        <div className="space-y-1">
                           <p className="font-black text-white text-xl italic tracking-tighter leading-none group-hover/row:text-blue-400 transition-colors">${row.currentPrice}</p>
                           <p className="text-[10px] text-slate-600 font-black italic line-through tracking-widest leading-none">${row.basePrice}</p>
                        </div>
                      </TableCell>
                      <TableCell className="px-10">
                        {row.isBooked ? <Badge className="bg-blue-600/10 text-blue-400 border-blue-600/20 px-4 h-7 text-[8px] font-black tracking-widest rounded-full italic">{t('booked')}</Badge> : row.isBlocked ? <Badge className="bg-rose-600/10 text-rose-500 border-rose-600/20 px-4 h-7 text-[8px] font-black tracking-widest rounded-full italic">{t('blocked')}</Badge> : <Badge className="bg-emerald-600/10 text-emerald-400 border-emerald-600/20 px-4 h-7 text-[8px] font-black tracking-widest rounded-full italic">{t('available')}</Badge>}
                      </TableCell>
                      <TableCell className="px-10">
                         <div className="flex items-center gap-3">
                            <Zap className="w-4 h-4 text-slate-600 group-hover/row:text-blue-400 transition-colors" />
                            <span className="text-xs font-black text-slate-400 italic tracking-widest leading-none">{row.availableUnits} / {row.totalUnits}</span>
                         </div>
                      </TableCell>
                      <TableCell className="px-10 text-right">
                         <DropdownMenu>
                            <DropdownMenuTrigger asChild><Button variant="ghost" className="h-12 w-12 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl"><MoreHorizontal className="w-5 h-5 text-slate-500" /></Button></DropdownMenuTrigger>
                            <DropdownMenuContent align="end" className="bg-[#1a1b1e] border-white/10 text-white w-64 p-3 rounded-2xl shadow-3xl backdrop-blur-3xl">
                               <DropdownMenuLabel className="text-[10px] font-black text-slate-500 tracking-widest p-4 pb-2 italic">{t("client.src.gridcalibration")}</DropdownMenuLabel>
                               <DropdownMenuSeparator className="bg-white/5 mx-2" />
                               <DropdownMenuItem onClick={() => openEdit(row)} className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-white/5 focus:text-blue-400 cursor-pointer"><Edit className="w-4 h-4" />{t("client.src.trcalibrate")}</DropdownMenuItem>
                               <DropdownMenuSeparator className="bg-white/5 mx-2" />
                               <DropdownMenuItem onClick={() => handleDelete(row.id)} className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-red-500/10 focus:text-red-500 cursor-pointer"><Trash2 className="w-4 h-4" />{t("client.src.trterminate")}</DropdownMenuItem>
                            </DropdownMenuContent>
                         </DropdownMenu>
                      </TableCell>
                    </TableRow>)}
              </TableBody>
            </Table>
          </Card>
        </motion.div>
      </div>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="p-0 border-none bg-transparent max-w-2xl">
          <EntityForm onSubmit={handleCreate} label={t('client.property.availability.dialog.create')} title={t('client.property.availability.dialog.add')} desc="Deploy a new availability node to the scheduling matrix" />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="p-0 border-none bg-transparent max-w-2xl">
          <EntityForm onSubmit={handleEdit} label={t('save')} title={t('edit')} desc="Re-calibrate parameters for existing scheduling node" />
        </DialogContent>
      </Dialog>
    </div>;
}