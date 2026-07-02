import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger, DropdownMenuLabel, DropdownMenuSeparator } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw, Check, X, Building2, LayoutGrid, ListChecks, ArrowLeft, Plus, Search, Activity, Zap, Info, Clock, Terminal } from "lucide-react";
import { Textarea } from "@/components/ui/textarea";
import { includedServiceApi, type IncludedService } from "@/lib/api/included-services";
import { facilityApi, type Facility } from "@/lib/api/facilities";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { Switch } from "@/components/ui/switch";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { Card, CardContent } from "@/components/ui/card";
const EMPTY_FACILITY = {
  propertyId: "",
  name: "",
  feeAmount: "",
  feeCurrency: "USD",
  notes: ""
};
const EMPTY_SERVICE = {
  propertyId: "",
  facilityId: "",
  name: "",
  description: "",
  value: "",
  isRecurring: false,
  frequency: "monthly"
};
export default function Facilities() {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  const {
    toast
  } = useToast();
  const [activeTab, setActiveTab] = useState("facilities");
  const [search, setSearch] = useState("");

  // Data states
  const [facilities, setFacilities] = useState<Facility[]>([]);
  const [services, setServices] = useState<IncludedService[]>([]);
  const [properties, setProperties] = useState<Property[]>([]);
  const [loading, setLoading] = useState(true);

  // Dialog states
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);

  // Form states
  const [facilityForm, setFacilityForm] = useState<any>(EMPTY_FACILITY);
  const [serviceForm, setServiceForm] = useState<any>(EMPTY_SERVICE);
  const [selectedItem, setSelectedItem] = useState<any>(null);
  const fetchData = async () => {
    try {
      setLoading(true);
      const [facRes, srvRes, propRes] = await Promise.all([facilityApi.getFacilities(), includedServiceApi.getServices(), propertiesApi.getAll()]);
      setFacilities(facRes.data || []);
      setServices(srvRes.data || []);
      setProperties(propRes || []);
    } catch (error) {
      toast({
        title: t('error'),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchData();
  }, []);
  const filteredFacilities = facilities.filter(row => row.name.toLowerCase().includes(search.toLowerCase()) || (row.property?.name || "").toLowerCase().includes(search.toLowerCase()));
  const filteredServices = services.filter(row => row.name.toLowerCase().includes(search.toLowerCase()) || (row.property?.name || "").toLowerCase().includes(search.toLowerCase()));
  const handleCreateFacility = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await facilityApi.createFacility({
        ...facilityForm,
        feeAmount: facilityForm.feeAmount ? parseFloat(facilityForm.feeAmount) : undefined
      });
      setCreateOpen(false);
      toast({
        title: t('success')
      });
      setFacilityForm(EMPTY_FACILITY);
      fetchData();
    } catch (error) {
      toast({
        title: t('error'),
        variant: "destructive"
      });
    }
  };
  const handleCreateService = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await includedServiceApi.createService({
        ...serviceForm,
        value: serviceForm.value ? parseFloat(serviceForm.value) : undefined,
        facilityId: serviceForm.facilityId === "none" ? undefined : serviceForm.facilityId
      });
      setCreateOpen(false);
      toast({
        title: t('success')
      });
      setServiceForm(EMPTY_SERVICE);
      fetchData();
    } catch (error) {
      toast({
        title: t('error'),
        variant: "destructive"
      });
    }
  };
  const handleEditFacility = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedItem) return;
    try {
      await facilityApi.updateFacility(selectedItem.id, {
        ...facilityForm,
        feeAmount: facilityForm.feeAmount ? parseFloat(facilityForm.feeAmount) : undefined
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
  const handleEditService = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedItem) return;
    try {
      await includedServiceApi.updateService(selectedItem.id, {
        ...serviceForm,
        value: serviceForm.value ? parseFloat(serviceForm.value) : undefined,
        facilityId: serviceForm.facilityId === "none" ? undefined : serviceForm.facilityId
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
  const handleDelete = async (id: string, type: "facility" | "service") => {
    if (!confirm(t('confirmDelete', {
      defaultValue: 'Are you sure?'
    }))) return;
    try {
      if (type === "facility") await facilityApi.deleteFacility(id);else await includedServiceApi.deleteService(id);
      toast({
        title: t('commonDelete')
      });
      fetchData();
    } catch (error) {
      toast({
        title: t('error'),
        variant: "destructive"
      });
    }
  };
  const openEdit = (item: any, type: "facility" | "service") => {
    setSelectedItem(item);
    if (type === "facility") {
      setFacilityForm({
        propertyId: item.propertyId,
        name: item.name,
        feeAmount: item.feeAmount?.toString() || "",
        feeCurrency: item.feeCurrency || "USD",
        notes: item.notes || ""
      });
    } else {
      setServiceForm({
        propertyId: item.propertyId,
        facilityId: item.facilityId || "none",
        name: item.name,
        description: item.description || "",
        value: item.value?.toString() || "",
        isRecurring: item.isRecurring,
        frequency: item.frequency
      });
    }
    setEditOpen(true);
  };
  const FormSurface = ({
    onSubmit,
    children,
    label,
    title,
    desc
  }: any) => {
    const {
      t
    } = useTranslation();
    return <div className="bg-[#1a1b1e] border-white/10 text-white rounded-[40px] overflow-hidden backdrop-blur-3xl shadow-3xl">
      <div className="p-10 pb-0">
        <h2 className="text-3xl font-black italic tracking-tighter text-blue-400">{title}</h2>
        <p className="text-slate-500 font-black italic tracking-widest text-[10px] pt-4 leading-relaxed">{desc}</p>
      </div>
      <form onSubmit={onSubmit} className="p-10 space-y-8">
         {children}
         <DialogFooter className="pt-8 flex gap-4">
            <Button type="button" variant="ghost" onClick={() => {
            setCreateOpen(false);
            setEditOpen(false);
          }} className="h-16 px-8 text-[10px] font-black italic text-slate-500 hover:text-white transition-all">{t('client.property.facilities.dialog.cancel')}</Button>
            <Button type="submit" className="flex-1 h-16 rounded-[24px] bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20 active:scale-95 transition-all">{label}</Button>
         </DialogFooter>
      </form>
    </div>;
  };
  return <div className="min-h-screen bg-[#14151a] p-8 lg:p-12 relative overflow-hidden">
      {/* Background HUD Layer */}
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
                <Terminal className="w-3.5 h-3.5" />{t("client.src.facilitysystemv5")}</div>
              <h1 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter leading-none">{t('client.property.facilities.title')}</h1>
              <p className="text-slate-500 text-sm font-black tracking-widest italic">{t('client.property.facilities.subtitle')}</p>
            </div>
          </div>
          <div className="flex items-center gap-4">
             <Button variant="ghost" onClick={fetchData} disabled={loading} className="h-16 w-16 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl">
               <RefreshCw className={cn("w-5 h-5", loading ? "animate-spin" : "")} />
             </Button>
             <Button onClick={() => {
            if (activeTab === "facilities") setFacilityForm(EMPTY_FACILITY);else setServiceForm(EMPTY_SERVICE);
            setCreateOpen(true);
          }} className="h-16 px-10 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20 transition-all hover:scale-105 active:scale-95">
               <Plus className="w-5 h-5 mr-3" /> {activeTab === "facilities" ? t('client.property.facilities.addFacility') : t('client.property.facilities.addService')}
             </Button>
          </div>
        </motion.div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t('facilities'),
          value: facilities.length,
          icon: Building2,
          color: "text-blue-400",
          bg: "bg-blue-500/10"
        }, {
          label: t('services'),
          value: services.length,
          icon: ListChecks,
          color: "text-emerald-400",
          bg: "bg-emerald-500/10"
        }, {
          label: t('recurring'),
          value: services.filter(r => r.isRecurring).length,
          icon: RefreshCw,
          color: "text-amber-400",
          bg: "bg-amber-500/10"
        }, {
          label: t('direct'),
          value: services.filter(r => !r.facilityId).length,
          icon: Zap,
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

        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-10">
          <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-8">
             <TabsList className="bg-black/40 p-2 rounded-[24px] border border-white/5 h-16 w-fit shadow-inner">
               <TabsTrigger value="facilities" className="h-full px-10 rounded-xl font-black italic text-[10px] tracking-widest transition-all data-[state=active]:bg-white data-[state=active]:text-black">
                 <Building2 className="w-4 h-4 mr-3" /> {t('facilities')}
               </TabsTrigger>
               <TabsTrigger value="services" className="h-full px-10 rounded-xl font-black italic text-[10px] tracking-widest transition-all data-[state=active]:bg-white data-[state=active]:text-black">
                 <ListChecks className="w-4 h-4 mr-3" /> {t('services')}
               </TabsTrigger>
             </TabsList>

             <div className="flex-1 max-w-2xl relative group">
                <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
                <input placeholder={activeTab === "facilities" ? t('searchFacilities') : t('searchServices')} className="w-full pl-16 h-16 bg-black/40 border border-white/5 rounded-[24px] text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" value={search} onChange={e => setSearch(e.target.value)} />
             </div>
          </div>

          <TabsContent value="facilities" className="mt-0">
            <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] overflow-hidden backdrop-blur-3xl shadow-3xl">
              <Table>
                <TableHeader className="bg-white/2 border-b border-white/5">
                  <TableRow className="hover:bg-transparent border-none">
                    <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 py-8 italic">{t('client.property.facilities.name')}</TableHead>
                    <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.facilities.property')}</TableHead>
                    <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('fee')}</TableHead>
                    <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('included')}</TableHead>
                    <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 text-right italic">{t("client.src.actions")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {loading ? <TableRow><TableCell colSpan={5} className="text-center py-40"><Activity className="w-12 h-12 text-blue-500 animate-spin mx-auto opacity-20" /></TableCell></TableRow> : filteredFacilities.length === 0 ? <TableRow><TableCell colSpan={5} className="text-center py-40 text-slate-800 font-black italic tracking-widest text-xs">{t('noFacilities')}</TableCell></TableRow> : filteredFacilities.map(row => <TableRow key={row.id} className="border-b border-white/5 hover:bg-white/2 transition-all group/row">
                        <TableCell className="px-10 py-8">
                          <div className="flex items-center gap-6">
                             <div className="w-14 h-14 rounded-2xl bg-white/5 border border-white/5 flex items-center justify-center group-hover/row:scale-110 transition-transform duration-500">
                                <LayoutGrid className="w-5 h-5 text-blue-500" />
                             </div>
                             <div className="space-y-1.5">
                                <p className="font-black text-white text-lg italic tracking-tighter leading-none group-hover/row:text-blue-400 transition-colors">{row.name}</p>
                                {row.notes && <p className="text-[9px] font-black text-slate-600 tracking-widest italic truncate max-w-[200px]">{row.notes}</p>}
                             </div>
                          </div>
                        </TableCell>
                        <TableCell className="px-10">
                          <div className="flex items-center gap-3">
                             <Building2 className="w-4 h-4 text-slate-500 shadow-xl" />
                             <span className="font-black text-slate-300 text-[10px] italic tracking-widest">{row.property?.name || "???"}</span>
                          </div>
                        </TableCell>
                        <TableCell className="px-10 font-black text-blue-400 italic tracking-tighter text-xl">
                          {row.feeAmount ? `${row.feeAmount.toLocaleString()} ${row.feeCurrency || "USD"}` : <span className="opacity-50 text-slate-600">{t('free')}</span>}
                        </TableCell>
                        <TableCell className="px-10">
                           {services.filter(s => s.facilityId === row.id).length > 0 ? <Badge className="bg-blue-600/10 text-blue-400 border-blue-600/20 px-4 h-7 text-[8px] font-black tracking-widest rounded-full italic">{t('servicesCount', {
                        count: services.filter(s => s.facilityId === row.id).length
                      })}</Badge> : <span className="text-[10px] text-slate-800 font-black italic tracking-widest">{t('none')}</span>}
                        </TableCell>
                        <TableCell className="px-10 text-right">
                           <DropdownMenu>
                              <DropdownMenuTrigger asChild><Button variant="ghost" className="h-12 w-12 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl"><MoreHorizontal className="w-5 h-5 text-slate-500" /></Button></DropdownMenuTrigger>
                              <DropdownMenuContent align="end" className="bg-[#1a1b1e] border-white/10 text-white w-64 p-3 rounded-2xl shadow-3xl backdrop-blur-3xl">
                                 <DropdownMenuLabel className="text-[10px] font-black text-slate-500 tracking-widest p-4 pb-2 italic">{t("client.src.componentcore")}</DropdownMenuLabel>
                                 <DropdownMenuSeparator className="bg-white/5 mx-2" />
                                 <DropdownMenuItem onClick={() => openEdit(row, "facility")} className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-white/5 focus:text-blue-400 cursor-pointer"><Edit className="w-4 h-4" />{t("client.src.trmodparameters")}</DropdownMenuItem>
                                 <DropdownMenuSeparator className="bg-white/5 mx-2" />
                                 <DropdownMenuItem onClick={() => handleDelete(row.id, "facility")} className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-red-500/10 focus:text-red-500 cursor-pointer"><Trash2 className="w-4 h-4" />{t("client.src.trscrapunit")}</DropdownMenuItem>
                              </DropdownMenuContent>
                           </DropdownMenu>
                        </TableCell>
                      </TableRow>)}
                </TableBody>
              </Table>
            </Card>
          </TabsContent>

          <TabsContent value="services" className="mt-0">
             <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] overflow-hidden backdrop-blur-3xl shadow-3xl">
              <Table>
                <TableHeader className="bg-white/2 border-b border-white/5">
                  <TableRow className="hover:bg-transparent border-none">
                    <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 py-8 italic">{t('client.property.facilities.service')}</TableHead>
                    <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.facilities.target')}</TableHead>
                    <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.facilities.value')}</TableHead>
                    <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('recurrence')}</TableHead>
                    <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 text-right italic">{t("client.src.actions")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {loading ? <TableRow><TableCell colSpan={5} className="text-center py-40"><Activity className="w-12 h-12 text-blue-500 animate-spin mx-auto opacity-20" /></TableCell></TableRow> : filteredServices.length === 0 ? <TableRow><TableCell colSpan={5} className="text-center py-40 text-slate-800 font-black italic tracking-widest text-xs">{t('noServices')}</TableCell></TableRow> : filteredServices.map(row => <TableRow key={row.id} className="border-b border-white/5 hover:bg-white/2 transition-all group/row">
                        <TableCell className="px-10 py-8">
                           <div className="flex items-center gap-6">
                             <div className="w-14 h-14 rounded-2xl bg-white/5 border border-white/5 flex items-center justify-center group-hover/row:scale-110 transition-transform duration-500">
                                <ListChecks className="w-5 h-5 text-emerald-500" />
                             </div>
                             <div className="space-y-1.5">
                                <p className="font-black text-white text-lg italic tracking-tighter leading-none group-hover/row:text-blue-400 transition-colors">{row.name}</p>
                                <p className="text-[9px] font-black text-slate-600 tracking-widest italic truncate max-w-[200px]">{row.description || "NO_DESCRIPTION"}</p>
                             </div>
                          </div>
                        </TableCell>
                        <TableCell className="px-10">
                           {row.facilityId ? <div className="space-y-1">
                                 <div className="flex items-center gap-2">
                                    <LayoutGrid className="w-3.5 h-3.5 text-blue-500" />
                                    <span className="text-[10px] font-black text-slate-300 italic tracking-widest truncate max-w-[150px]">{facilities.find(f => f.id === row.facilityId)?.name || "NODE"}</span>
                                 </div>
                                 <p className="text-[8px] font-black text-slate-700 tracking-widest ml-5">{row.property?.name || "PROPERTIES"}</p>
                              </div> : <div className="space-y-1">
                                 <div className="flex items-center gap-2">
                                    <Building2 className="w-3.5 h-3.5 text-slate-500 opacity-50" />
                                    <span className="text-[10px] font-black text-slate-500 italic tracking-widest">{t('directProperty')}</span>
                                 </div>
                                 <p className="text-[8px] font-black text-slate-700 tracking-widest ml-5">{row.property?.name || "PROPERTIES"}</p>
                              </div>}
                        </TableCell>
                        <TableCell className="px-10 font-black text-white italic tracking-tighter text-xl">
                          {row.value ? <span className="text-emerald-400">${row.value.toLocaleString()}</span> : <span className="opacity-50 text-slate-600 text-xs">{t('includedService')}</span>}
                        </TableCell>
                        <TableCell className="px-10">
                           <div className="space-y-2">
                              {row.isRecurring ? <Badge className="bg-amber-600/10 text-amber-500 border-amber-600/20 px-4 h-7 text-[8px] font-black tracking-widest rounded-full italic gap-2"><RefreshCw className="w-3 h-3" /> {t('recurring')}</Badge> : <Badge className="bg-slate-600/10 text-slate-500 border-slate-600/20 px-4 h-7 text-[8px] font-black tracking-widest rounded-full italic gap-2"><Clock className="w-3 h-3" /> {t('onceOff')}</Badge>}
                              <p className="text-[9px] font-black text-slate-600 tracking-[0.2em] italic pl-1">{row.frequency}</p>
                           </div>
                        </TableCell>
                        <TableCell className="px-10 text-right">
                           <DropdownMenu>
                              <DropdownMenuTrigger asChild><Button variant="ghost" className="h-12 w-12 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl"><MoreHorizontal className="w-5 h-5 text-slate-500" /></Button></DropdownMenuTrigger>
                              <DropdownMenuContent align="end" className="bg-[#1a1b1e] border-white/10 text-white w-64 p-3 rounded-2xl shadow-3xl backdrop-blur-3xl">
                                 <DropdownMenuLabel className="text-[10px] font-black text-slate-500 tracking-widest p-4 pb-2 italic">{t("client.src.serviceroutine")}</DropdownMenuLabel>
                                 <DropdownMenuSeparator className="bg-white/5 mx-2" />
                                 <DropdownMenuItem onClick={() => openEdit(row, "service")} className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-white/5 focus:text-blue-400 cursor-pointer"><Edit className="w-4 h-4" />{t("client.src.tradjustrecurrence")}</DropdownMenuItem>
                                 <DropdownMenuSeparator className="bg-white/5 mx-2" />
                                 <DropdownMenuItem onClick={() => handleDelete(row.id, "service")} className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-red-500/10 focus:text-red-500 cursor-pointer"><Trash2 className="w-4 h-4" />{t("client.src.trvoidservice")}</DropdownMenuItem>
                              </DropdownMenuContent>
                           </DropdownMenu>
                        </TableCell>
                      </TableRow>)}
                </TableBody>
              </Table>
            </Card>
          </TabsContent>
        </Tabs>
      </div>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="p-0 border-none bg-transparent max-w-2xl">
          {activeTab === "facilities" ? <FormSurface onSubmit={handleCreateFacility} label={t('client.property.facilities.addFacility')} title={t('client.property.facilities.dialog.addFacility')} desc="Initialize new facility node in the structural matrix">
               <div className="space-y-8">
                  <div className="space-y-2">
                     <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.facilities.dialog.property')}</Label>
                     <Select value={facilityForm.propertyId} onValueChange={v => setFacilityForm({
                ...facilityForm,
                propertyId: v
              })}>
                        <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] shadow-inner text-white font-black italic text-[10px] tracking-widest px-6"><SelectValue placeholder={t('client.property.facilities.dialog.selectProperty')} /></SelectTrigger>
                        <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                           {properties.map(p => <SelectItem key={p.id} value={p.id} className="focus:bg-white/5">{p.name}</SelectItem>)}
                        </SelectContent>
                     </Select>
                  </div>
                  <div className="space-y-2">
                     <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('facilityName')}</Label>
                     <Input placeholder={t('facilityPlaceholder')} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={facilityForm.name} onChange={e => setFacilityForm({
                ...facilityForm,
                name: e.target.value
              })} required />
                  </div>
                  <div className="grid grid-cols-2 gap-8">
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('feeAmount')}</Label>
                        <Input type="number" className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={facilityForm.feeAmount} onChange={e => setFacilityForm({
                  ...facilityForm,
                  feeAmount: e.target.value
                })} />
                     </div>
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('currency')}</Label>
                        <Input className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={facilityForm.feeCurrency} onChange={e => setFacilityForm({
                  ...facilityForm,
                  feeCurrency: e.target.value
                })} />
                     </div>
                  </div>
                  <div className="space-y-2">
                     <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('notes')}</Label>
                     <Textarea placeholder={t('notesPlaceholder')} className="min-h-[120px] bg-black/40 border-white/5 rounded-[24px] p-6 text-white font-black italic text-xs tracking-widest leading-relaxed" value={facilityForm.notes} onChange={e => setFacilityForm({
                ...facilityForm,
                notes: e.target.value
              })} />
                  </div>
               </div>
            </FormSurface> : <FormSurface onSubmit={handleCreateService} label={t('client.property.facilities.addService')} title={t('client.property.facilities.dialog.addService')} desc="Inject new background service thread to the operational pipeline">
               <div className="space-y-8">
                  <div className="grid grid-cols-2 gap-8">
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.facilities.dialog.property')}</Label>
                        <Select value={serviceForm.propertyId} onValueChange={v => setServiceForm({
                  ...serviceForm,
                  propertyId: v
                })}>
                           <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] shadow-inner text-white font-black italic text-[10px] tracking-widest px-6"><SelectValue placeholder={t('client.property.facilities.dialog.selectProperty')} /></SelectTrigger>
                           <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                              {properties.map(p => <SelectItem key={p.id} value={p.id} className="focus:bg-white/5">{p.name}</SelectItem>)}
                           </SelectContent>
                        </Select>
                     </div>
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('facilityOptional')}</Label>
                        <Select value={serviceForm.facilityId} onValueChange={v => setServiceForm({
                  ...serviceForm,
                  facilityId: v
                })}>
                           <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] shadow-inner text-white font-black italic text-[10px] tracking-widest px-6"><SelectValue placeholder={t('selectFacility')} /></SelectTrigger>
                           <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                              <SelectItem value="none" className="focus:bg-white/5">{t('noneDirect')}</SelectItem>
                              {facilities.map(f => <SelectItem key={f.id} value={f.id} className="focus:bg-white/5">{f.name}</SelectItem>)}
                           </SelectContent>
                        </Select>
                     </div>
                  </div>
                  <div className="space-y-2">
                     <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('serviceName')}</Label>
                     <Input placeholder={t('servicePlaceholder')} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={serviceForm.name} onChange={e => setServiceForm({
                ...serviceForm,
                name: e.target.value
              })} required />
                  </div>
                  <div className="grid grid-cols-2 gap-8">
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('valueFee')}</Label>
                        <Input type="number" className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={serviceForm.value} onChange={e => setServiceForm({
                  ...serviceForm,
                  value: e.target.value
                })} />
                     </div>
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('frequency')}</Label>
                        <Select value={serviceForm.frequency} onValueChange={v => setServiceForm({
                  ...serviceForm,
                  frequency: v
                })}>
                           <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] shadow-inner text-white font-black italic text-[10px] tracking-widest px-6"><SelectValue /></SelectTrigger>
                           <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                              <SelectItem value="once" className="focus:bg-white/5">{t('once')}</SelectItem>
                              <SelectItem value="daily" className="focus:bg-white/5">{t('daily')}</SelectItem>
                              <SelectItem value="weekly" className="focus:bg-white/5">{t('client.property.facilities.frequencies.weekly')}</SelectItem>
                              <SelectItem value="monthly" className="focus:bg-white/5">{t('client.property.facilities.frequencies.monthly')}</SelectItem>
                              <SelectItem value="yearly" className="focus:bg-white/5">{t('yearly')}</SelectItem>
                           </SelectContent>
                        </Select>
                     </div>
                  </div>
                  <div className="flex items-center justify-between rounded-[32px] bg-black/40 border border-white/5 p-6 backdrop-blur-xl">
                    <div className="space-y-1">
                      <Label className="text-[10px] font-black tracking-widest text-white italic">{t('recurringService')}</Label>
                      <p className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.enable_routine_execution_thread")}</p>
                    </div>
                    <Switch checked={serviceForm.isRecurring} onCheckedChange={v => setServiceForm({
                ...serviceForm,
                isRecurring: v
              })} className="data-[state=checked]:bg-blue-600" />
                  </div>
                  <div className="space-y-2">
                     <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.facilities.dialog.description')}</Label>
                     <Textarea placeholder={t('descPlaceholder')} className="min-h-[120px] bg-black/40 border-white/5 rounded-[24px] p-6 text-white font-black italic text-xs tracking-widest leading-relaxed" value={serviceForm.description} onChange={e => setServiceForm({
                ...serviceForm,
                description: e.target.value
              })} />
                  </div>
               </div>
            </FormSurface>}
        </DialogContent>
      </Dialog>

      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="p-0 border-none bg-transparent max-w-2xl">
          {activeTab === "facilities" ? <FormSurface onSubmit={handleEditFacility} label={t('save')} title={t('editFacility')} desc="Update operational parameters for established facility node">
               <div className="space-y-8">
                  <div className="space-y-2">
                     <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.facilities.dialog.property')}</Label>
                     <Select value={facilityForm.propertyId} onValueChange={v => setFacilityForm({
                ...facilityForm,
                propertyId: v
              })}>
                        <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] shadow-inner text-white font-black italic text-[10px] tracking-widest px-6"><SelectValue placeholder={t('client.property.facilities.dialog.selectProperty')} /></SelectTrigger>
                        <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                           {properties.map(p => <SelectItem key={p.id} value={p.id} className="focus:bg-white/5">{p.name}</SelectItem>)}
                        </SelectContent>
                     </Select>
                  </div>
                  <div className="space-y-2">
                     <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('facilityName')}</Label>
                     <Input placeholder={t('facilityPlaceholder')} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={facilityForm.name} onChange={e => setFacilityForm({
                ...facilityForm,
                name: e.target.value
              })} required />
                  </div>
                  <div className="grid grid-cols-2 gap-8">
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('feeAmount')}</Label>
                        <Input type="number" className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={facilityForm.feeAmount} onChange={e => setFacilityForm({
                  ...facilityForm,
                  feeAmount: e.target.value
                })} />
                     </div>
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('currency')}</Label>
                        <Input className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={facilityForm.feeCurrency} onChange={e => setFacilityForm({
                  ...facilityForm,
                  feeCurrency: e.target.value
                })} />
                     </div>
                  </div>
                  <div className="space-y-2">
                     <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('notes')}</Label>
                     <Textarea placeholder={t('notesPlaceholder')} className="min-h-[120px] bg-black/40 border-white/5 rounded-[24px] p-6 text-white font-black italic text-xs tracking-widest leading-relaxed" value={facilityForm.notes} onChange={e => setFacilityForm({
                ...facilityForm,
                notes: e.target.value
              })} />
                  </div>
               </div>
            </FormSurface> : <FormSurface onSubmit={handleEditService} label={t('save')} title={t('editService')} desc="Modify execution parameters for active service thread">
               <div className="space-y-8">
                  <div className="grid grid-cols-2 gap-8">
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.facilities.dialog.property')}</Label>
                        <Select value={serviceForm.propertyId} onValueChange={v => setServiceForm({
                  ...serviceForm,
                  propertyId: v
                })}>
                           <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] shadow-inner text-white font-black italic text-[10px] tracking-widest px-6"><SelectValue placeholder={t('client.property.facilities.dialog.selectProperty')} /></SelectTrigger>
                           <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                              {properties.map(p => <SelectItem key={p.id} value={p.id} className="focus:bg-white/5">{p.name}</SelectItem>)}
                           </SelectContent>
                        </Select>
                     </div>
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('facilityOptional')}</Label>
                        <Select value={serviceForm.facilityId} onValueChange={v => setServiceForm({
                  ...serviceForm,
                  facilityId: v
                })}>
                           <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] shadow-inner text-white font-black italic text-[10px] tracking-widest px-6"><SelectValue placeholder={t('selectFacility')} /></SelectTrigger>
                           <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                              <SelectItem value="none" className="focus:bg-white/5">{t('noneDirect')}</SelectItem>
                              {facilities.map(f => <SelectItem key={f.id} value={f.id} className="focus:bg-white/5">{f.name}</SelectItem>)}
                           </SelectContent>
                        </Select>
                     </div>
                  </div>
                  <div className="space-y-2">
                     <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('serviceName')}</Label>
                     <Input placeholder={t('servicePlaceholder')} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={serviceForm.name} onChange={e => setServiceForm({
                ...serviceForm,
                name: e.target.value
              })} required />
                  </div>
                  <div className="grid grid-cols-2 gap-8">
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('valueFee')}</Label>
                        <Input type="number" className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" value={serviceForm.value} onChange={e => setServiceForm({
                  ...serviceForm,
                  value: e.target.value
                })} />
                     </div>
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('frequency')}</Label>
                        <Select value={serviceForm.frequency} onValueChange={v => setServiceForm({
                  ...serviceForm,
                  frequency: v
                })}>
                           <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] shadow-inner text-white font-black italic text-[10px] tracking-widest px-6"><SelectValue /></SelectTrigger>
                           <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                              <SelectItem value="once" className="focus:bg-white/5">{t('once')}</SelectItem>
                              <SelectItem value="daily" className="focus:bg-white/5">{t('daily')}</SelectItem>
                              <SelectItem value="weekly" className="focus:bg-white/5">{t('client.property.facilities.frequencies.weekly')}</SelectItem>
                              <SelectItem value="monthly" className="focus:bg-white/5">{t('client.property.facilities.frequencies.monthly')}</SelectItem>
                              <SelectItem value="yearly" className="focus:bg-white/5">{t('yearly')}</SelectItem>
                           </SelectContent>
                        </Select>
                     </div>
                  </div>
                  <div className="flex items-center justify-between rounded-[32px] bg-black/40 border border-white/5 p-6 backdrop-blur-xl">
                    <div className="space-y-1">
                      <Label className="text-[10px] font-black tracking-widest text-white italic">{t('recurringService')}</Label>
                      <p className="text-[9px] font-black text-slate-500 italic tracking-widest">{t("client.src.enable_routine_execution_thread")}</p>
                    </div>
                    <Switch checked={serviceForm.isRecurring} onCheckedChange={v => setServiceForm({
                ...serviceForm,
                isRecurring: v
              })} className="data-[state=checked]:bg-blue-600" />
                  </div>
                  <div className="space-y-2">
                     <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.facilities.dialog.description')}</Label>
                     <Textarea placeholder={t('descPlaceholder')} className="min-h-[120px] bg-black/40 border-white/5 rounded-[24px] p-6 text-white font-black italic text-xs tracking-widest leading-relaxed" value={serviceForm.description} onChange={e => setServiceForm({
                ...serviceForm,
                description: e.target.value
              })} />
                  </div>
               </div>
            </FormSurface>}
        </DialogContent>
      </Dialog>
    </div>;
}