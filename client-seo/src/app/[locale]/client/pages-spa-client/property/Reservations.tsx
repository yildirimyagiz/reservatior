"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger, DropdownMenuSeparator, DropdownMenuLabel } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, Calendar, User, Building, Search, Plus, Activity, Zap, LayoutGrid, List, ArrowLeft, ChevronRight, Filter, DollarSign, Mail, Clock, CheckCircle2, XCircle, FileText } from "lucide-react";
import { useTranslation } from "react-i18next";
import { useNavigate } from "@/lib/react-router-shim";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { Card, CardContent } from "@/components/ui/card";
const MOCK: any[] = [{
  "id": "1",
  "guestName": "Tom Baker",
  "guestEmail": "tom@email.com",
  "propertyName": "Sunset Villa",
  "checkIn": "2025-01-15",
  "checkOut": "2025-01-22",
  "nights": 7,
  "totalAmount": 2450,
  "currency": "$",
  "status": "CONFIRMED",
  "createdAt": "2025-01-01"
}, {
  "id": "2",
  "guestName": "Nina Ross",
  "guestEmail": "nina@email.com",
  "propertyName": "Ocean Bungalow",
  "checkIn": "2025-02-01",
  "checkOut": "2025-02-08",
  "nights": 7,
  "totalAmount": 3100,
  "currency": "$",
  "status": "PENDING",
  "createdAt": "2025-01-10"
}, {
  "id": "3",
  "guestName": "Leo Park",
  "guestEmail": "leo@email.com",
  "propertyName": "Mountain Cabin",
  "checkIn": "2024-12-20",
  "checkOut": "2024-12-27",
  "nights": 7,
  "totalAmount": 1890,
  "currency": "$",
  "status": "COMPLETED",
  "createdAt": "2024-12-01"
}];
const EMPTY_FORM = {
  guestName: "",
  guestEmail: "",
  propertyName: "",
  checkIn: "",
  checkOut: "",
  totalAmount: "",
  currency: "$",
  status: "PENDING"
};
export default function Reservations({ propertyId }: { propertyId?: string }) {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>({ ...EMPTY_FORM, propertyId: propertyId || "" });
  const STATUS_MAP: Record<string, {
    label: string;
    cls: string;
    icon: any;
  }> = {
    CONFIRMED: {
      label: t('confirmed'),
      cls: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
      icon: CheckCircle2
    },
    PENDING: {
      label: t('client.property.reservations.status.pending'),
      cls: "bg-amber-500/10 text-amber-400 border-amber-500/20",
      icon: Clock
    },
    COMPLETED: {
      label: t('client.property.reservations.status.completed'),
      cls: "bg-blue-500/10 text-blue-400 border-blue-500/20",
      icon: Activity
    },
    CANCELLED: {
      label: t('client.property.reservations.status.cancelled'),
      cls: "bg-red-500/10 text-red-500 border-red-500/20",
      icon: XCircle
    }
  };
  const filtered = MOCK.filter(row => 
    (String(row.guestName ?? "").toLowerCase().includes(search.toLowerCase()) || 
     String(row.propertyName ?? "").toLowerCase().includes(search.toLowerCase())) && 
    (filterStatus === "all" || row.status === filterStatus) &&
    (!propertyId || row.propertyId === propertyId)
  );
  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    setCreateOpen(false);
    toast({
      title: t('success')
    });
    setForm(EMPTY_FORM);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    setEditOpen(false);
    toast({
      title: t('success')
    });
  };
  const handleDelete = () => toast({
    title: t('commonDelete'),
    variant: "destructive"
  });
  const openEdit = (row: any) => {
    const f: any = {};
    Object.keys(EMPTY_FORM).forEach(k => {
      f[k] = String(row[k] ?? "");
    });
    setForm(f);
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
        <div className="grid grid-cols-2 gap-8">
          <div className="space-y-2">
            <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('guestName')}</Label>
            <Input className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" value={form.guestName} onChange={e => setForm({
              ...form,
              guestName: e.target.value
            })} />
          </div>
          <div className="space-y-2">
            <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('guestEmail')}</Label>
            <Input className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" type="email" value={form.guestEmail} onChange={e => setForm({
              ...form,
              guestEmail: e.target.value
            })} />
          </div>
        </div>
        <div className="space-y-2">
          <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.reservations.dialog.property')}</Label>
          <Input className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" value={form.propertyName} onChange={e => setForm({
            ...form,
            propertyName: e.target.value
          })} />
        </div>
        <div className="grid grid-cols-2 gap-8">
          <div className="space-y-2">
            <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('checkIn')}</Label>
            <Input className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" type="date" value={form.checkIn} onChange={e => setForm({
              ...form,
              checkIn: e.target.value
            })} />
          </div>
          <div className="space-y-2">
            <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('checkOut')}</Label>
            <Input className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" type="date" value={form.checkOut} onChange={e => setForm({
              ...form,
              checkOut: e.target.value
            })} />
          </div>
        </div>
        <div className="grid grid-cols-2 gap-8">
          <div className="space-y-2">
            <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.reservations.dialog.amount')}</Label>
            <Input className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" type="number" value={form.totalAmount} onChange={e => setForm({
              ...form,
              totalAmount: e.target.value
            })} />
          </div>
          <div className="space-y-2">
            <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.reservations.dialog.status')}</Label>
            <Select value={form.status} onValueChange={v => setForm({
              ...form,
              status: v as any
            })}>
              <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6 shadow-inner"><SelectValue /></SelectTrigger>
              <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                <SelectItem value="PENDING" className="focus:bg-white/5">{t('client.property.reservations.status.pending')}</SelectItem>
                <SelectItem value="CONFIRMED" className="focus:bg-white/5">{t('confirmed')}</SelectItem>
                <SelectItem value="COMPLETED" className="focus:bg-white/5">{t('client.property.reservations.status.completed')}</SelectItem>
                <SelectItem value="CANCELLED" className="focus:bg-white/5">{t('client.property.reservations.status.cancelled')}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-8 flex gap-4">
          <Button type="button" variant="ghost" onClick={() => {
            setCreateOpen(false);
            setEditOpen(false);
          }} className="h-16 px-8 text-[10px] font-black italic text-slate-500">{t('client.property.reservations.dialog.cancel')}</Button>
          <Button type="submit" className="flex-1 h-16 rounded-[24px] bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20">{label}</Button>
        </DialogFooter>
      </form>
    </div>;
  };
  return <div className="min-h-screen bg-[#14151a] p-8 lg:p-12 relative overflow-hidden">
      {/* Background Cybernetic Elements */}
      <div className="absolute inset-0 pointer-events-none">
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-blue-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-purple-600/5 blur-[120px] rounded-full"></div>
        <div className="absolute top-0 left-0 w-full h-full opacity-[0.03] bg-[radial-gradient(#fff_1px,transparent_1px)] bg-size-[40px_40px]"></div>
      </div>

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
            <div className="space-y-1">
              <h1 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter leading-none">{t('client.property.reservations.title')}</h1>
              <p className="text-slate-500 text-sm font-black tracking-widest italic">{t('client.property.reservations.subtitle')}</p>
            </div>
          </div>
          <Button onClick={() => {
          setForm(EMPTY_FORM);
          setCreateOpen(true);
        }} className="h-16 px-10 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20 transition-all hover:scale-105 active:scale-95">
            <Plus className="w-5 h-5 mr-3" /> {t('client.property.reservations.add')}
          </Button>
        </motion.div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t('total'),
          value: MOCK.length,
          icon: LayoutGrid,
          color: "text-blue-400",
          bg: "bg-blue-500/10"
        }, {
          label: t('confirmed'),
          value: MOCK.filter(r => r.status === 'CONFIRMED').length,
          icon: CheckCircle2,
          color: "text-emerald-400",
          bg: "bg-emerald-500/10"
        }, {
          label: t('client.property.reservations.pending'),
          value: MOCK.filter(r => r.status === 'PENDING').length,
          icon: Clock,
          color: "text-amber-400",
          bg: "bg-amber-500/10"
        }, {
          label: t('client.property.reservations.revenue'),
          value: `$${MOCK.filter(r => r.status !== 'CANCELLED').reduce((s, r) => s + (r.totalAmount || 0), 0).toLocaleString()}`,
          icon: Zap,
          color: "text-purple-400",
          bg: "bg-purple-500/10"
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
                   <div className="space-y-1">
                      <p className="text-[10px] font-black tracking-widest text-slate-500 italic">{s.label}</p>
                      <h3 className="text-3xl font-black text-white italic tracking-tighter leading-none">{s.value}</h3>
                   </div>
                   <div className={cn("w-12 h-12 rounded-2xl flex items-center justify-center border border-white/5 shadow-inner backdrop-blur-md", s.bg)}>
                      <s.icon className={cn("w-6 h-6", s.color)} />
                   </div>
                 </div>
               </Card>
             </motion.div>)}
        </div>

        {/* Filters Card */}
        <motion.div initial={{
        opacity: 0,
        scale: 0.98
      }} animate={{
        opacity: 1,
        scale: 1
      }}>
          <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] p-8 backdrop-blur-3xl shadow-3xl">
            <div className="flex flex-col md:flex-row items-center gap-8">
               <div className="flex-1 w-full relative group">
                  <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
                  <input placeholder={t('client.property.reservations.search')} className="w-full pl-16 h-16 bg-black/40 border border-white/5 rounded-[24px] text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" value={search} onChange={e => setSearch(e.target.value)} />
               </div>
               <Select value={filterStatus} onValueChange={setFilterStatus}>
                  <SelectTrigger className="w-full md:w-64 h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6"><SelectValue placeholder={t("client.src.status")} /></SelectTrigger>
                  <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                    <SelectItem value="all" className="focus:bg-white/5">{t("client.src.all_channels")}</SelectItem>
                    <SelectItem value="CONFIRMED" className="focus:bg-white/5">{t('confirmed')}</SelectItem>
                    <SelectItem value="PENDING" className="focus:bg-white/5">{t('client.property.reservations.status.pending')}</SelectItem>
                    <SelectItem value="COMPLETED" className="focus:bg-white/5">{t('client.property.reservations.status.completed')}</SelectItem>
                    <SelectItem value="CANCELLED" className="focus:bg-white/5">{t('client.property.reservations.status.cancelled')}</SelectItem>
                  </SelectContent>
               </Select>
            </div>
          </Card>
        </motion.div>

        {/* Reservations Table */}
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
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 py-8 italic">{t('guest')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.reservations.property')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('checkIn')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('checkOut')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.reservations.status')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.reservations.amount')}</TableHead>
                  <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 text-right italic">{t('client.property.reservations.actions')}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-32 text-slate-800 font-black italic tracking-widest text-xs">{t('client.property.reservations.noFound')}</TableCell></TableRow>}
                {filtered.map(row => <TableRow key={row.id} className="border-b border-white/5 hover:bg-white/2 transition-all group/row">
                    <TableCell className="px-10 py-8">
                       <div className="flex items-center gap-4">
                          <div className="w-12 h-12 rounded-2xl bg-white/5 border border-white/5 flex items-center justify-center group-hover/row:scale-110 transition-transform duration-500">
                             <User className="w-5 h-5 text-blue-500" />
                          </div>
                          <div className="space-y-1">
                             <p className="font-black text-white text-base italic tracking-tighter leading-none group-hover/row:text-blue-400 transition-colors">{row.guestName}</p>
                             <p className="text-[10px] font-black text-slate-600 tracking-widest italic">{row.guestEmail}</p>
                          </div>
                       </div>
                    </TableCell>
                    <TableCell className="px-10">
                       <div className="flex items-center gap-3">
                          <Building className="w-4 h-4 text-slate-500" />
                          <span className="font-black text-slate-300 text-[11px] italic tracking-widest">{row.propertyName}</span>
                       </div>
                    </TableCell>
                    <TableCell className="px-10">
                       <div className="flex items-center gap-3">
                          <Calendar className="w-4 h-4 text-slate-500" />
                          <span className="font-black text-slate-400 text-[10px] italic tracking-widest">{row.checkIn}</span>
                       </div>
                    </TableCell>
                    <TableCell className="px-10">
                       <div className="flex items-center gap-3">
                          <Calendar className="w-4 h-4 text-slate-500" />
                          <span className="font-black text-slate-400 text-[10px] italic tracking-widest">{row.checkOut}</span>
                       </div>
                    </TableCell>
                    <TableCell className="px-10">
                      {STATUS_MAP[row.status] && <Badge className={cn("px-4 h-8  text-[8px] font-black tracking-widest rounded-full border shadow-lg backdrop-blur-xl", STATUS_MAP[row.status].cls)}>
                           {STATUS_MAP[row.status].label}
                        </Badge>}
                    </TableCell>
                    <TableCell className="px-10 font-black text-white italic tracking-tighter text-xl group-hover/row:text-blue-400 transition-colors">{row.currency}{row.totalAmount?.toLocaleString()}</TableCell>
                    <TableCell className="px-10 text-right">
                       <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" className="h-12 w-12 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl"><MoreHorizontal className="w-5 h-5 text-slate-500" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="bg-[#1a1b1e] border-white/10 text-white w-64 p-3 rounded-2xl shadow-3xl backdrop-blur-3xl">
                             <DropdownMenuLabel className="text-[10px] font-black text-slate-500 tracking-widest p-4 pb-2 italic">{t("client.src.calibrationmodes")}</DropdownMenuLabel>
                             <DropdownMenuSeparator className="bg-white/5 mx-2" />
                             <DropdownMenuItem onClick={() => openEdit(row)} className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-white/5 focus:text-blue-400 cursor-pointer"><Edit className="w-4 h-4" />{t("client.src.trcalibrate")}</DropdownMenuItem>
                             <DropdownMenuItem className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-white/5 focus:text-emerald-400 cursor-pointer"><FileText className="w-4 h-4" />{t("client.src.trreport")}</DropdownMenuItem>
                             <DropdownMenuSeparator className="bg-white/5 mx-2" />
                             <DropdownMenuItem onClick={() => handleDelete()} className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-red-500/10 focus:text-red-500 cursor-pointer"><Trash2 className="w-4 h-4" />{t("client.src.trterminate")}</DropdownMenuItem>
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
          <EntityForm onSubmit={handleCreate} label={t('client.property.reservations.dialog.create')} title={t('client.property.reservations.dialog.add')} desc="Deploy a new occupancy node to the neural grid" />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="p-0 border-none bg-transparent max-w-2xl">
          <EntityForm onSubmit={handleEdit} label={t('save')} title={t('edit')} desc="Adjust the parameters of an existing occupancy node" />
        </DialogContent>
      </Dialog>
    </div>;
}