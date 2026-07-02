import { useState, useEffect } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuSeparator, DropdownMenuTrigger, DropdownMenuLabel } from "@/components/ui/dropdown-menu";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Home, Search, MapPin, Bed, Bath, DollarSign, Edit, Trash2, MoreHorizontal, Grid3X3, List, CheckCircle, Plus, Building, Building2, HomeIcon, Store, Factory, Trees, Save, Sparkles, Video, ChevronRight, Maximize2, Cpu, ArrowRight, LayoutDashboard, Activity, ArrowLeft } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { motion, AnimatePresence } from "framer-motion";
import { propertiesApi, Property } from "@/lib/api/properties";
import { useToast } from "@/hooks/use-toast";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";
import Image from "next/image";
export default function PropertyManagement() {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  const {
    user
  } = useAuth();
  const [properties, setProperties] = useState<Property[]>([]);
  const [filteredProperties, setFilteredProperties] = useState<Property[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedProperty, setSelectedProperty] = useState<Property | null>(null);
  const [showCreateDialog, setShowCreateDialog] = useState(false);
  const [showEditDialog, setShowEditDialog] = useState(false);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);
  const [viewMode, setViewMode] = useState<"grid" | "table">("grid");
  const [searchTerm, setSearchTerm] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterType, setFilterType] = useState("all");
  const {
    toast
  } = useToast();
  const [formData, setFormData] = useState<any>({
    name: "",
    type: "DETACHED_HOUSE",
    propertyCategory: "RESIDENTIAL",
    listingType: "SALE",
    listingStatus: "AVAILABLE",
    addressLine1: "",
    city: "",
    state: "",
    country: "USA",
    listingPrice: "",
    currency: "USD",
    bedrooms: "",
    bathrooms: "",
    areaSqm: "",
    yearBuilt: "",
    notes: "",
    region: "USA_NORTHEAST"
  });
  useEffect(() => {
    loadProperties();
  }, []);
  const loadProperties = async () => {
    setLoading(true);
    try {
      const data = await propertiesApi.getAll();
      setProperties(data);
      setFilteredProperties(data);
    } catch (error) {
      toast({
        title: t('error'),
        description: t('client.property.management.syncingError', {
          defaultValue: "Failed to load properties"
        }),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    let filtered = [...properties];
    if (searchTerm) {
      filtered = filtered.filter(p => p.name.toLowerCase().includes(searchTerm.toLowerCase()) || p.city.toLowerCase().includes(searchTerm.toLowerCase()));
    }
    if (filterStatus !== "all") filtered = filtered.filter(p => p.listingStatus === filterStatus);
    if (filterType !== "all") filtered = filtered.filter(p => p.type === filterType);
    setFilteredProperties(filtered);
  }, [properties, searchTerm, filterStatus, filterType]);
  const getStatusBadge = (status: string) => {
    switch (status) {
      case "AVAILABLE":
        return <Badge className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20 px-3 text-[8px] font-black tracking-widest h-6 rounded-full">{t('client.property.management.status.forSale')}</Badge>;
      case "RESERVED":
        return <Badge className="bg-amber-500/10 text-amber-400 border-amber-500/20 px-3 text-[8px] font-black tracking-widest h-6 rounded-full">{t('reserved')}</Badge>;
      case "SOLD":
        return <Badge className="bg-rose-500/10 text-rose-500 border-rose-500/20 px-3 text-[8px] font-black tracking-widest h-6 rounded-full">{t('client.property.management.status.sold')}</Badge>;
      default:
        return <Badge className="bg-slate-500/10 text-slate-400 border-slate-500/20 px-3 text-[8px] font-black tracking-widest h-6 rounded-full">{status}</Badge>;
    }
  };
  const handleEditProperty = (property: Property) => {
    setSelectedProperty(property);
    setFormData({
      ...property,
      listingPrice: property.listingPrice?.toString() || "",
      bedrooms: property.bedrooms?.toString() || ""
    });
    setShowEditDialog(true);
  };
  const handleSaveProperty = async () => {
    try {
      const payload = {
        ...formData,
        bedrooms: formData.bedrooms ? parseInt(formData.bedrooms) : undefined,
        listingPrice: formData.listingPrice ? parseFloat(formData.listingPrice) : undefined
      };
      if (showEditDialog && selectedProperty) {
        await propertiesApi.update(selectedProperty.id, payload);
        toast({
          title: t('success'),
          description: t('updateSuccess', {
            defaultValue: "Property updated"
          })
        });
      } else {
        await propertiesApi.create(payload as any);
        toast({
          title: t('success'),
          description: t('createSuccess', {
            defaultValue: "Property created"
          })
        });
      }
      loadProperties();
      setShowCreateDialog(false);
      setShowEditDialog(false);
    } catch (error) {
      toast({
        title: t('error'),
        description: t('error'),
        variant: "destructive"
      });
    }
  };
  return <div className="min-h-screen bg-[#14151a] p-8 lg:p-12 relative overflow-hidden">
      {/* Dynamic Cinematic Background */}
      <div className="fixed inset-0 pointer-events-none overflow-hidden z-0">
        <div className="absolute -top-[20%] -right-[10%] w-[70vw] h-[70vw] bg-blue-600/10 blur-[150px] rounded-full mix-blend-screen animate-[pulse_8s_ease-in-out_infinite]"></div>
        <div className="absolute -bottom-[20%] -left-[10%] w-[60vw] h-[60vw] bg-violet-600/10 blur-[150px] rounded-full mix-blend-screen animate-[pulse_10s_ease-in-out_infinite_2s]"></div>
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[80vw] h-[40vw] bg-blue-600/5 blur-[120px] rounded-full mix-blend-screen"></div>
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.05)_1px,transparent_1px)] bg-size-[32px_32px] opacity-60 mask-[radial-gradient(ellipse_at_center,black_40%,transparent_80%)]"></div>
        <div className="absolute inset-0 bg-gradient-to-b from-transparent via-[#14151a]/50 to-[#14151a] opacity-80"></div>
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
            <div className="space-y-1.5">
              <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-blue-500/10 border border-blue-500/20 text-blue-400 text-[9px] font-black tracking-[0.2em] italic">
                <LayoutDashboard className="w-3.5 h-3.5" /> {t('headerPanel')}
              </div>
              <h1 className="text-5xl md:text-7xl font-black italic tracking-tighter leading-none bg-gradient-to-br from-white via-blue-100 to-slate-500 bg-clip-text text-transparent drop-shadow-lg">{t('client.property.management.title')}</h1>
              <p className="text-slate-500 text-sm font-black tracking-widest italic">{t('client.property.management.subtitle')}</p>
            </div>
          </div>
          <div className="flex items-center gap-4">
             <Button variant="ghost" className="h-16 px-8 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 font-black italic text-xs tracking-widest transition-all">
               <Cpu className="w-5 h-5 mr-3 text-blue-400" /> {t('getAIReport')}
             </Button>
             <Button onClick={() => setShowCreateDialog(true)} className="h-16 px-10 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20 transition-all hover:scale-105 active:scale-95">
               <Plus className="w-5 h-5 mr-3" /> {t('addNew')}
             </Button>
          </div>
        </motion.div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t('total'),
          value: properties.length,
          icon: Home,
          color: "text-blue-400",
          bg: "bg-blue-500/10"
        }, {
          label: t('active'),
          value: properties.filter(p => p.listingStatus === "AVAILABLE").length,
          icon: Sparkles,
          color: "text-emerald-400",
          bg: "bg-emerald-500/10"
        }, {
          label: t('reservedSold'),
          value: properties.filter(p => ["RESERVED", "SOLD"].includes(p.listingStatus)).length,
          icon: CheckCircle,
          color: "text-amber-400",
          bg: "bg-amber-500/10"
        }, {
          label: t('client.property.management.value'),
          value: "$" + (properties.reduce((acc, p) => acc + (p.listingPrice || 0), 0) / 1e6).toFixed(1) + "M",
          icon: DollarSign,
          color: "text-pink-400",
          bg: "bg-pink-500/10"
        }].map((s, i) => <motion.div key={i} initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: i * 0.1
        }}>
               <Card className="bg-[#1a1b1e]/40 border border-white/5 rounded-[32px] overflow-hidden p-8 hover:bg-[#1a1b1e]/80 transition-all duration-500 shadow-2xl relative backdrop-blur-xl group hover:shadow-[0_0_40px_rgba(59,130,246,0.15)] hover:-translate-y-2 hover:border-blue-500/30">
                 <div className="absolute top-0 right-0 p-6 opacity-[0.03] group-hover:opacity-10 group-hover:scale-125 group-hover:rotate-12 transition-all duration-700 group-hover:text-blue-400">
                    <s.icon className="w-32 h-32 -mt-8 -mr-8" />
                 </div>
                 <div className="flex justify-between items-start relative z-10">
                   <div>
                      <p className="text-[10px] font-black tracking-widest text-slate-500 mb-2 italic group-hover:text-slate-400 transition-colors">{s.label}</p>
                      <p className="text-4xl font-black text-white italic tracking-tighter leading-none drop-shadow-md">{s.value}</p>
                   </div>
                   <div className={cn("w-14 h-14 rounded-[20px] flex items-center justify-center border border-white/10 shadow-inner backdrop-blur-md transition-transform duration-500 group-hover:scale-110 group-hover:rotate-3", s.bg)}>
                      <s.icon className={cn("w-7 h-7 shadow-[0_0_20px_currentColor]", s.color)} />
                   </div>
                 </div>
                 
                 {/* Decorative bottom line */}
                 <div className="absolute bottom-0 left-0 right-0 h-1 bg-gradient-to-r from-transparent via-blue-500/20 to-transparent scale-x-0 group-hover:scale-x-100 transition-transform duration-700" />
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
                  <input placeholder={t('client.property.management.search')} className="w-full pl-16 h-16 bg-black/40 border border-white/5 rounded-[24px] text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
               </div>
               <div className="flex items-center gap-4">
                  <Select value={filterStatus} onValueChange={setFilterStatus}>
                     <SelectTrigger className="w-64 h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6"><SelectValue placeholder={t("client.src.status")} /></SelectTrigger>
                     <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                       <SelectItem value="all" className="focus:bg-white/5">{t('client.property.management.all')}</SelectItem>
                       <SelectItem value="AVAILABLE" className="focus:bg-white/5">{t('client.property.management.status.forSale')}</SelectItem>
                       <SelectItem value="RESERVED" className="focus:bg-white/5">{t('reserved')}</SelectItem>
                       <SelectItem value="SOLD" className="focus:bg-white/5">{t('client.property.management.status.sold')}</SelectItem>
                     </SelectContent>
                  </Select>
                  <div className="flex bg-black/40 rounded-[24px] p-1.5 border border-white/5 h-16 shadow-inner">
                    <Button variant="ghost" onClick={() => setViewMode("table")} className={cn("h-full px-6 rounded-xl font-black  italic text-[10px] tracking-widest transition-all", viewMode === "table" ? "bg-white text-black shadow-xl" : "text-slate-500 hover:text-white")}><List className="w-4 h-4 mr-2" />{t("client.src.list")}</Button>
                    <Button variant="ghost" onClick={() => setViewMode("grid")} className={cn("h-full px-6 rounded-xl font-black  italic text-[10px] tracking-widest transition-all", viewMode === "grid" ? "bg-white text-black shadow-xl" : "text-slate-500 hover:text-white")}><Grid3X3 className="w-4 h-4 mr-2" />{t("client.src.grid")}</Button>
                  </div>
               </div>
            </div>
          </Card>
        </motion.div>

        {/* Content Surface */}
        <AnimatePresence mode="wait">
          {loading ? <div className="py-32 flex flex-col items-center justify-center gap-6">
              <Activity className="w-12 h-12 text-blue-500 animate-spin opacity-40" />
              <p className="text-[10px] font-black tracking-[0.3em] italic text-slate-600">{t('client.property.management.syncing')}</p>
            </div> : viewMode === "grid" ? <motion.div initial={{
          opacity: 0
        }} animate={{
          opacity: 1
        }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-10">
               {filteredProperties.map((p, idx) => <motion.div key={p.id} layout initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} transition={{
            delay: idx * 0.05
          }}>
                     <Card className="group relative bg-[#1a1b1e]/40 border border-white/5 rounded-[40px] overflow-hidden backdrop-blur-xl transition-all duration-700 hover:shadow-[0_0_50px_rgba(59,130,246,0.15)] hover:border-blue-500/40 h-full flex flex-col hover:-translate-y-3">
                        <div className="aspect-[4/3] relative overflow-hidden">
                           <div className="absolute inset-0 bg-blue-500/20 opacity-0 group-hover:opacity-100 transition-opacity duration-700 mix-blend-overlay z-10 pointer-events-none" />
                          {p.photos?.[0] ? <Image src={p.photos[0].url} alt="" fill className="object-cover group-hover:scale-110 transition-transform duration-1000 brightness-90 group-hover:brightness-110" sizes="(max-width: 768px) 100vw, 50vw" /> : <div className="w-full h-full flex items-center justify-center bg-black/40">
                              <Home className="w-20 h-20 text-white/5" />
                            </div>}
                          <div className="absolute inset-0 bg-gradient-to-t from-[#14151a] via-[#14151a]/40 to-transparent opacity-90 z-10" />
                          <div className="absolute top-6 left-6 z-20">
                             {getStatusBadge(p.listingStatus)}
                          </div>
                          <div className="absolute bottom-6 left-6 right-6 flex items-end justify-between z-20">
                              <div className="space-y-1 transform group-hover:-translate-y-1 transition-transform duration-500">
                                 <p className="text-white font-black text-3xl italic tracking-tighter leading-none group-hover:text-blue-400 transition-colors drop-shadow-lg">{p.listingPrice ? "$" + parseInt(p.listingPrice.toString()).toLocaleString('en-US') : '--'}</p>
                                 <span className="text-[10px] font-black text-blue-300 tracking-widest italic drop-shadow-md">{p.type.replace('_', ' ')}</span>
                              </div>
                              <Button size="icon" className="h-14 w-14 rounded-[24px] bg-white/10 backdrop-blur-2xl border border-white/20 hover:bg-blue-600 hover:border-blue-500 transition-all duration-500 text-white hover:scale-110 active:scale-90 shadow-2xl group-hover:shadow-blue-500/20">
                                 <Video className="w-6 h-6" />
                              </Button>
                          </div>
                        </div>

                        <CardContent className="p-8 space-y-6 flex-1 flex flex-col">
                          <div className="space-y-1.5">
                            <h3 className="font-black text-xl text-white italic tracking-tighter leading-none group-hover:translate-x-1 transition-transform">{p.name}</h3>
                            <p className="text-slate-500 text-[10px] font-black italic tracking-widest flex items-center gap-2"><MapPin className="w-3.5 h-3.5 text-blue-500" /> {p.city}, {p.country}</p>
                          </div>

                          <div className="grid grid-cols-3 gap-4 py-4 border-y border-white/5">
                             <div className="text-center group/metric">
                                <Bed className="w-4 h-4 mx-auto mb-1.5 text-slate-600 group-hover/metric:text-blue-400 transition-colors" />
                                <span className="text-sm font-black text-slate-400 group-hover/metric:text-white transition-colors italic">{p.bedrooms || 0}</span>
                             </div>
                             <div className="text-center group/metric">
                                <Bath className="w-4 h-4 mx-auto mb-1.5 text-slate-600 group-hover/metric:text-blue-400 transition-colors" />
                                <span className="text-sm font-black text-slate-400 group-hover/metric:text-white transition-colors italic">{p.bathrooms || 0}</span>
                             </div>
                             <div className="text-center group/metric">
                                <Maximize2 className="w-4 h-4 mx-auto mb-1.5 text-slate-600 group-hover/metric:text-blue-400 transition-colors" />
                                <span className="text-[11px] font-black text-slate-400 group-hover/metric:text-white transition-colors italic">{p.areaSqm || 0}{t("client.src.m")}</span>
                             </div>
                          </div>

                          <div className="grid grid-cols-2 gap-4 pt-4 mt-auto relative z-20">
                             <Button onClick={() => handleEditProperty(p)} variant="ghost" className="bg-white/5 border border-white/5 text-[10px] font-black italic tracking-widest rounded-[20px] h-12 hover:bg-white/10 text-slate-400 hover:text-white transition-all duration-300">
                                {t('edit')}
                             </Button>
                             <Button className="bg-blue-600/10 text-blue-400 hover:bg-blue-600 hover:text-white border border-blue-600/20 text-[10px] font-black italic tracking-widest rounded-[20px] h-12 transition-all duration-300 group/btn">
                                {t('aiEnhance')} <Sparkles className="w-3.5 h-3.5 ml-2 group-hover/btn:animate-pulse" />
                             </Button>
                          </div>
                        </CardContent>
                     </Card>
                  </motion.div>)}
            </motion.div> : <motion.div initial={{
          opacity: 0
        }} animate={{
          opacity: 1
        }} className="bg-[#1a1b1e]/40 border border-white/5 border-l border-t rounded-[48px] overflow-hidden backdrop-blur-3xl shadow-3xl">
               <Table>
                  <TableHeader className="bg-white/2 border-b border-white/5">
                    <TableRow className="hover:bg-transparent border-none">
                      <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 py-8 italic">{t('client.property.management.detail')}</TableHead>
                      <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.management.category')}</TableHead>
                      <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.management.status')}</TableHead>
                      <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('price')}</TableHead>
                      <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.management.metrics')}</TableHead>
                      <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 text-right italic"></TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                     {filteredProperties.map(p => <TableRow key={p.id} className="border-b border-white/5 hover:bg-white/2 transition-all group/row">
                          <TableCell className="px-10 py-8">
                             <div className="flex items-center gap-8">
                                <div className="relative w-16 h-16 rounded-[20px] bg-black/40 overflow-hidden border border-white/5 shadow-inner grow-0 shrink-0 group-hover/row:scale-110 transition-transform duration-500">
                                   {p.photos?.[0] ? <Image src={p.photos[0].url} alt="" fill className="object-cover" sizes="64px" /> : <Home className="w-full h-full p-4 opacity-10" />}
                               </div>
                               <div className="space-y-1.5">
                                 <p className="font-black text-white text-xl italic tracking-tighter leading-none group-hover:text-blue-400 transition-colors">{p.name}</p>
                                 <p className="text-slate-500 text-[10px] font-black italic tracking-widest flex items-center gap-2"><MapPin className="w-3.5 h-3.5 text-blue-500" /> {p.city}, {p.country}</p>
                               </div>
                             </div>
                          </TableCell>
                          <TableCell className="px-10">
                            <Badge className="bg-blue-600/10 text-blue-400 border border-blue-600/20 text-[8px] font-black tracking-widest px-4 h-7 rounded-full italic">{p.propertyCategory}</Badge>
                          </TableCell>
                          <TableCell className="px-10">{getStatusBadge(p.listingStatus)}</TableCell>
                          <TableCell className="px-10">
                             <p className="text-[9px] font-black text-slate-500 tracking-widest italic leading-none mb-1">{t("client.src.totalvalue")}</p>
                             <span className="font-black text-white text-2xl italic tracking-tighter leading-none">{p.listingPrice ? "$" + parseInt(p.listingPrice.toString()).toLocaleString('en-US') : '--'}</span>
                          </TableCell>
                          <TableCell className="px-10">
                             <div className="flex items-center gap-6">
                               <div className="space-y-1 text-center group/metric">
                                 <Bed className="w-3.5 h-3.5 text-slate-600 group-hover/row:text-blue-400 transition-colors mx-auto" />
                                 <p className="text-xs font-black text-slate-400 italic leading-none">{p.bedrooms || 0}</p>
                               </div>
                               <div className="space-y-1 text-center group/metric">
                                 <Bath className="w-3.5 h-3.5 text-slate-600 group-hover/row:text-blue-400 transition-colors mx-auto" />
                                 <p className="text-xs font-black text-slate-400 italic leading-none">{p.bathrooms || 0}</p>
                               </div>
                               <div className="space-y-1 text-center group/metric">
                                 <Maximize2 className="w-3.5 h-3.5 text-slate-600 group-hover/row:text-blue-400 transition-colors mx-auto" />
                                 <p className="text-[10px] font-black text-slate-400 italic leading-none">{p.areaSqm || 0}{t("client.src.m")}</p>
                               </div>
                             </div>
                          </TableCell>
                          <TableCell className="px-10 text-right">
                             <DropdownMenu>
                               <DropdownMenuTrigger asChild><Button variant="ghost" className="h-12 w-12 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl"><MoreHorizontal className="w-5 h-5 text-slate-500" /></Button></DropdownMenuTrigger>
                               <DropdownMenuContent align="end" className="bg-[#1a1b1e] border-white/10 text-white w-64 p-3 rounded-2xl shadow-3xl backdrop-blur-3xl">
                                 <DropdownMenuLabel className="text-[10px] font-black text-slate-500 tracking-widest p-4 pb-2 italic">{t("client.src.assetcontrol")}</DropdownMenuLabel>
                                 <DropdownMenuSeparator className="bg-white/5 mx-2" />
                                 <DropdownMenuItem onClick={() => handleEditProperty(p)} className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-white/5 focus:text-blue-400 cursor-pointer"><Edit className="w-4 h-4" /> {t('edit')}</DropdownMenuItem>
                                 <DropdownMenuItem className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-white/5 focus:text-emerald-400 cursor-pointer"><Sparkles className="w-4 h-4" /> {t('aiEnhance')}</DropdownMenuItem>
                                 <DropdownMenuItem className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-white/5 focus:text-purple-400 cursor-pointer"><Video className="w-4 h-4" /> {t('client.property.management.studio')}</DropdownMenuItem>
                                 <DropdownMenuSeparator className="bg-white/5 mx-2" />
                                 <DropdownMenuItem className="rounded-xl h-12 gap-4 font-black italic text-[10px] tracking-widest focus:bg-red-500/10 focus:text-red-500 cursor-pointer" onClick={() => {
                        setSelectedProperty(p);
                        setShowDeleteDialog(true);
                      }}><Trash2 className="w-4 h-4" /> {t('delete')}</DropdownMenuItem>
                               </DropdownMenuContent>
                            </DropdownMenu>
                          </TableCell>
                        </TableRow>)}
                  </TableBody>
               </Table>
            </motion.div>}
        </AnimatePresence>

        {/* Create/Edit Dialog */}
        <Dialog open={showCreateDialog || showEditDialog} onOpenChange={open => {
        if (!open) {
          setShowCreateDialog(false);
          setShowEditDialog(false);
        }
      }}>
          <DialogContent className="max-w-4xl bg-[#1a1b1e] border-white/10 text-white rounded-[48px] p-0 overflow-hidden shadow-3xl backdrop-blur-3xl">
            <div className="bg-gradient-to-r from-blue-600/10 to-purple-600/10 p-12 border-b border-white/5 flex items-center justify-between">
              <div>
                <DialogTitle className="text-4xl font-black italic tracking-tighter text-blue-400">{showEditDialog ? t('client.property.management.dialog.update') : t('client.property.management.dialog.create')}</DialogTitle>
                <DialogDescription className="text-slate-500 font-black italic tracking-widest text-[10px] pt-4 leading-relaxed">{t('client.property.management.dialog.desc')}</DialogDescription>
              </div>
              <div className="w-20 h-20 rounded-[24px] bg-blue-600 flex items-center justify-center shadow-xl shadow-blue-600/30">
                 <HomeIcon className="w-10 h-10 text-white" />
              </div>
            </div>
            
            <div className="p-12 grid grid-cols-1 md:grid-cols-2 gap-12 max-h-[60vh] overflow-y-auto custom-scrollbar">
               <div className="space-y-8">
                  <div className="space-y-2">
                    <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.management.dialog.name')}</Label>
                    <Input value={formData.name} onChange={e => setFormData({
                  ...formData,
                  name: e.target.value
                })} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest focus:ring-blue-600/50 transition-all placeholder:text-slate-800" />
                  </div>
                  <div className="grid grid-cols-2 gap-6">
                    <div className="space-y-2">
                       <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.management.dialog.type')}</Label>
                       <Select value={formData.type} onValueChange={v => setFormData({
                    ...formData,
                    type: v
                  })}>
                         <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6 shadow-inner"><SelectValue /></SelectTrigger>
                         <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                           <SelectItem value="DETACHED_HOUSE" className="focus:bg-white/5">{t('detached')}</SelectItem>
                           <SelectItem value="APARTMENT" className="focus:bg-white/5">{t('client.property.management.dialog.types.apartment')}</SelectItem>
                           <SelectItem value="COMMERCIAL" className="focus:bg-white/5">{t('client.property.management.dialog.types.commercial')}</SelectItem>
                           <SelectItem value="VILLA" className="focus:bg-white/5">{t('client.property.management.dialog.types.villa')}</SelectItem>
                         </SelectContent>
                       </Select>
                    </div>
                    <div className="space-y-2">
                       <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.management.dialog.status')}</Label>
                       <Select value={formData.listingStatus} onValueChange={v => setFormData({
                    ...formData,
                    listingStatus: v
                  })}>
                         <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6 shadow-inner"><SelectValue /></SelectTrigger>
                         <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                           <SelectItem value="AVAILABLE" className="focus:bg-white/5">{t('client.property.management.status.forSale')}</SelectItem>
                           <SelectItem value="RESERVED" className="focus:bg-white/5">{t('reserved')}</SelectItem>
                           <SelectItem value="SOLD" className="focus:bg-white/5">{t('client.property.management.status.sold')}</SelectItem>
                         </SelectContent>
                       </Select>
                    </div>
                  </div>
                  <div className="space-y-2">
                    <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('price')}</Label>
                    <Input type="number" value={formData.listingPrice} onChange={e => setFormData({
                  ...formData,
                  listingPrice: e.target.value
                })} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" />
                  </div>
                  <div className="grid grid-cols-2 gap-6">
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('bedrooms')}</Label>
                        <Input type="number" value={formData.bedrooms} onChange={e => setFormData({
                    ...formData,
                    bedrooms: e.target.value
                  })} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" />
                     </div>
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('bathrooms')}</Label>
                        <Input type="number" value={formData.bathrooms} onChange={e => setFormData({
                    ...formData,
                    bathrooms: e.target.value
                  })} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" />
                     </div>
                  </div>
               </div>
               <div className="space-y-8">
                  <div className="space-y-2">
                    <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('address')}</Label>
                    <Input value={formData.addressLine1} onChange={e => setFormData({
                  ...formData,
                  addressLine1: e.target.value
                })} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" />
                  </div>
                  <div className="grid grid-cols-2 gap-6">
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('city')}</Label>
                        <Input value={formData.city} onChange={e => setFormData({
                    ...formData,
                    city: e.target.value
                  })} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" />
                     </div>
                     <div className="space-y-2">
                        <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('country')}</Label>
                        <Input value={formData.country} onChange={e => setFormData({
                    ...formData,
                    country: e.target.value
                  })} className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest" />
                     </div>
                  </div>
                  <div className="space-y-2">
                    <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('aiNotes')}</Label>
                    <Textarea value={formData.notes} onChange={e => setFormData({
                  ...formData,
                  notes: e.target.value
                })} rows={5} className="bg-black/40 border-white/5 rounded-[32px] text-white placeholder:text-slate-800 font-black italic text-[10px] tracking-widest p-6 min-h-[140px] focus:ring-blue-600/50 resize-none transition-all" placeholder={t('aiNotesPlaceholder')} />
                  </div>
               </div>
            </div>

            <DialogFooter className="p-12 bg-white/2 border-t border-white/5 flex gap-4">
              <Button variant="ghost" onClick={() => {
              setShowCreateDialog(false);
              setShowEditDialog(false);
            }} className="h-16 px-10 text-[10px] font-black italic text-slate-500">{t('client.property.management.dialog.cancel')}</Button>
              <Button onClick={handleSaveProperty} className="flex-1 bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest h-16 px-12 rounded-[24px] shadow-xl shadow-blue-600/20 active:scale-95 transition-all">
                 <Save className="w-5 h-5 mr-3" /> {t('save')}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Delete Dialog */}
        <Dialog open={showDeleteDialog} onOpenChange={setShowDeleteDialog}>
          <DialogContent className="bg-[#1a1b1e] border-white/10 text-white rounded-[40px] p-12 backdrop-blur-3xl shadow-3xl max-w-lg">
            <div className="flex flex-col items-center text-center space-y-6">
              <div className="w-20 h-20 rounded-full bg-red-500/10 flex items-center justify-center border border-red-500/20">
                 <Trash2 className="w-10 h-10 text-red-500" />
              </div>
              <div className="space-y-2">
                 <DialogTitle className="text-3xl font-black italic tracking-tighter text-white">{t('deleteTitle')}</DialogTitle>
                 <DialogDescription className="text-slate-500 font-black italic tracking-widest text-[10px] leading-relaxed">
                    {t('deleteDesc', {
                  name: selectedProperty?.name
                })}
                 </DialogDescription>
              </div>
            </div>
            <DialogFooter className="mt-12 flex flex-col sm:flex-row gap-4">
               <Button variant="ghost" onClick={() => setShowDeleteDialog(false)} className="flex-1 h-16 font-black italic text-[10px] tracking-widest text-slate-500">{t('client.property.management.dialog.cancel')}</Button>
               <Button variant="destructive" onClick={async () => {
              if (selectedProperty) {
                await propertiesApi.delete(selectedProperty.id);
                toast({
                  title: t('commonDelete')
                });
                loadProperties();
                setShowDeleteDialog(false);
              }
            }} className="flex-1 h-16 bg-red-600 hover:bg-red-500 font-black italic text-[10px] tracking-widest rounded-2xl shadow-xl shadow-red-600/20">
                  {t('deleteConfirm')}
               </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </div>;
}