"use client";

import { useState } from "react";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { useValuations, useCreateValuation, useProcessValuation, useValuationStats } from "@/hooks/use-valuations";
import { ValuationType, ValuationStatus } from "@/lib/api/valuations";
import { PropertyValuation } from "@/lib/api/valuations";
import { format } from "date-fns";
import { Search, Filter, Plus, Play, Download, TrendingUp, Activity, Zap, BarChart3, Clock, CheckCircle2, AlertCircle, Building, ArrowLeft, ChevronRight, MapPin } from "lucide-react";
import { useTranslation } from "react-i18next";
import { useNavigate } from "@/lib/react-router-shim";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
export default function Valuations({ propertyId }: { propertyId?: string }) {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  const [filters, setFilters] = useState({
    status: undefined as ValuationStatus | undefined,
    valuationType: undefined as ValuationType | undefined,
    search: ""
  });
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [createData, setCreateData] = useState({
    propertyId: propertyId || "",
    valuationType: "BASIC" as ValuationType,
    priority: "normal",
    contactInfo: {},
    propertyData: {},
    videoUrl: "",
    images: [] as string[],
    requirements: [] as string[]
  });
  const {
    data: valuations,
    isLoading,
    refetch
  } = useValuations({ ...filters, propertyId });
  const {
    data: stats
  } = useValuationStats();
  const createMutation = useCreateValuation();
  const processMutation = useProcessValuation();
  const handleCreateValuation = () => {
    createMutation.mutate(createData, {
      onSuccess: () => {
        setIsCreateDialogOpen(false);
        setCreateData({
          propertyId: "",
          valuationType: "BASIC",
          priority: "normal",
          contactInfo: {},
          propertyData: {},
          videoUrl: "",
          images: [],
          requirements: []
        });
        refetch();
      }
    });
  };
  const handleProcessValuation = (valuationId: string) => {
    processMutation.mutate(valuationId, {
      onSuccess: () => {
        refetch();
      }
    });
  };
  const getStatusInfo = (status: ValuationStatus) => {
    switch (status) {
      case "COMPLETED":
        return {
          label: t('client.property.valuations.statuses.completed'),
          cls: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20"
        };
      case "PROCESSING":
        return {
          label: t('client.property.valuations.statuses.processing'),
          cls: "bg-blue-500/10 text-blue-400 border-blue-500/20"
        };
      case "FAILED":
        return {
          label: t('client.property.valuations.statuses.failed'),
          cls: "bg-red-500/10 text-red-400 border-red-500/20"
        };
      case "EXPIRED":
        return {
          label: t('client.property.valuations.statuses.expired'),
          cls: "bg-slate-500/10 text-slate-400 border-slate-500/20"
        };
      default:
        return {
          label: t('client.property.valuations.statuses.pending'),
          cls: "bg-amber-500/10 text-amber-400 border-amber-500/20"
        };
    }
  };
  const getTypeInfo = (type: ValuationType) => {
    switch (type) {
      case "BASIC":
        return {
          label: t('client.property.valuations.types.basic'),
          color: "text-slate-400"
        };
      case "PROFESSIONAL":
        return {
          label: t('client.property.valuations.types.professional'),
          color: "text-blue-400"
        };
      case "ENTERPRISE":
        return {
          label: t('client.property.valuations.types.enterprise'),
          color: "text-purple-400"
        };
      case "INSTANT":
        return {
          label: t('client.property.valuations.types.instant'),
          color: "text-emerald-400"
        };
      case "DETAILED":
        return {
          label: t('client.property.valuations.types.detailed'),
          color: "text-orange-400"
        };
      default:
        return {
          label: type,
          color: "text-slate-400"
        };
    }
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
              {t('common.back', {
              defaultValue: 'BACK'
            })}
            </Button>
            <div className="h-14 w-px bg-white/10 hidden md:block" />
            <div className="space-y-1">
              <h1 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter leading-none">
                {t('client.property.valuations.title')}
              </h1>
              <p className="text-slate-500 text-sm font-black tracking-widest italic">{t('client.property.valuations.subtitle')}</p>
            </div>
          </div>

          <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <DialogTrigger asChild>
              <Button className="h-16 px-10 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20 transition-all hover:scale-105 active:scale-95">
                <Plus className="w-5 h-5 mr-3" />
                {t('client.property.valuations.new')}
              </Button>
            </DialogTrigger>
            <DialogContent className="max-w-2xl bg-[#1a1b1e] border-white/10 text-white rounded-[40px] p-0 overflow-hidden backdrop-blur-3xl shadow-3xl">
              <DialogHeader className="p-10 pb-0">
                <DialogTitle className="text-3xl font-black italic tracking-tighter text-blue-400">{t('client.property.valuations.dialog.title')}</DialogTitle>
                <DialogDescription className="text-slate-500 font-black italic tracking-widest text-[10px] pt-4 leading-relaxed">
                  {t('client.property.valuations.dialog.desc')}
                </DialogDescription>
              </DialogHeader>
              <div className="p-10 space-y-8">
                <div className="grid grid-cols-2 gap-8">
                  <div className="space-y-2">
                    <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.valuations.dialog.propertyId')}</Label>
                    <Input className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" value={createData.propertyId} onChange={e => setCreateData(prev => ({
                    ...prev,
                    propertyId: e.target.value
                  }))} placeholder={t('client.property.valuations.dialog.propertyIdPlaceholder')} />
                  </div>
                  <div className="space-y-2">
                    <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.valuations.dialog.valType')}</Label>
                    <Select value={createData.valuationType} onValueChange={(value: ValuationType) => setCreateData(prev => ({
                    ...prev,
                    valuationType: value
                  }))}>
                      <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6 shadow-inner">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                        <SelectItem value="BASIC" className="focus:bg-white/5">{t('client.property.valuations.types.basic')}</SelectItem>
                        <SelectItem value="PROFESSIONAL" className="focus:bg-white/5">{t('client.property.valuations.types.professional')}</SelectItem>
                        <SelectItem value="ENTERPRISE" className="focus:bg-white/5">{t('client.property.valuations.types.enterprise')}</SelectItem>
                        <SelectItem value="INSTANT" className="focus:bg-white/5">{t('client.property.valuations.types.instant')}</SelectItem>
                        <SelectItem value="DETAILED" className="focus:bg-white/5">{t('client.property.valuations.types.detailed')}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
                <div className="space-y-2">
                  <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.valuations.dialog.priority')}</Label>
                  <Select value={createData.priority} onValueChange={value => setCreateData(prev => ({
                  ...prev,
                  priority: value
                }))}>
                    <SelectTrigger className="h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6 shadow-inner">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                      <SelectItem value="low" className="focus:bg-white/5">{t('client.property.valuations.dialog.priorities.low')}</SelectItem>
                      <SelectItem value="normal" className="focus:bg-white/5">{t('client.property.valuations.dialog.priorities.normal')}</SelectItem>
                      <SelectItem value="high" className="focus:bg-white/5">{t('client.property.valuations.dialog.priorities.high')}</SelectItem>
                      <SelectItem value="urgent" className="focus:bg-white/5">{t('client.property.valuations.dialog.priorities.urgent')}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.valuations.dialog.video')}</Label>
                  <Input className="h-16 bg-black/40 border-white/5 rounded-[24px] px-6 text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" value={createData.videoUrl} onChange={e => setCreateData(prev => ({
                  ...prev,
                  videoUrl: e.target.value
                }))} placeholder={t('client.property.valuations.dialog.videoPlaceholder')} />
                </div>
                <div className="space-y-2">
                  <Label className="text-[10px] font-black tracking-widest text-slate-500 italic ml-2">{t('client.property.valuations.dialog.reqs')}</Label>
                  <Textarea className="bg-black/40 border-white/5 rounded-[32px] text-white placeholder:text-slate-800 font-black italic text-[10px] tracking-widest p-6 min-h-[120px] focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all" value={createData.requirements.join("\n")} onChange={e => setCreateData(prev => ({
                  ...prev,
                  requirements: e.target.value.split("\n").filter(r => r.trim())
                }))} placeholder={t('client.property.valuations.dialog.reqsPlaceholder')} />
                </div>
                <DialogFooter className="pt-8 flex gap-4">
                  <Button variant="ghost" onClick={() => setIsCreateDialogOpen(false)} className="h-16 px-8 text-[10px] font-black italic text-slate-500">
                    {t('client.property.valuations.dialog.cancel')}
                  </Button>
                  <Button className="flex-1 h-16 rounded-[24px] bg-blue-600 hover:bg-blue-500 text-white font-black italic text-xs tracking-widest shadow-xl shadow-blue-600/20" onClick={handleCreateValuation} disabled={createMutation.isPending}>
                    {createMutation.isPending ? t('common.loading') : t('client.property.valuations.dialog.create')}
                  </Button>
                </DialogFooter>
              </div>
            </DialogContent>
          </Dialog>
        </motion.div>

        {/* Stats HUD */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
          label: t('client.property.valuations.stats.total'),
          value: stats?.totalValuations || 0,
          desc: t('client.property.valuations.stats.totalDesc'),
          icon: Activity,
          color: "text-blue-400",
          bg: "bg-blue-500/10"
        }, {
          label: t('client.property.valuations.stats.totalValue'),
          value: `$${stats?.totalValue?.toLocaleString() || 0}`,
          desc: t('client.property.valuations.stats.valueDesc'),
          icon: TrendingUp,
          color: "text-emerald-400",
          bg: "bg-emerald-500/10"
        }, {
          label: t('client.property.valuations.stats.completion'),
          value: `${((stats?.completionRate || 0) * 100).toFixed(1)}%`,
          desc: t('client.property.valuations.stats.completionDesc'),
          icon: CheckCircle2,
          color: "text-purple-400",
          bg: "bg-purple-500/10"
        }, {
          label: t('client.property.valuations.stats.avgTime'),
          value: `${(stats?.averageProcessingTime || 0).toFixed(1)}h`,
          desc: t('client.property.valuations.stats.timeDesc'),
          icon: Clock,
          color: "text-orange-400",
          bg: "bg-orange-500/10"
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
                 <div className="absolute top-0 right-0 p-8 opacity-5 group-hover:scale-110 transition-transform">
                    <s.icon className="w-16 h-16" />
                 </div>
                 <div className="flex justify-between items-start relative z-10">
                   <div className="space-y-1">
                      <p className="text-[10px] font-black tracking-widest text-slate-500 italic">{s.label}</p>
                      <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{s.value}</h3>
                      <p className="text-[10px] font-black text-slate-600 tracking-widest italic">{s.desc}</p>
                   </div>
                   <div className={cn("w-12 h-12 rounded-2xl flex items-center justify-center border border-white/5 shadow-inner backdrop-blur-md", s.bg)}>
                      <s.icon className={cn("w-6 h-6 shadow-[0_0_15px_currentColor]", s.color)} />
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
            <div className="flex flex-col lg:flex-row items-center gap-8">
               <div className="flex-1 w-full relative group">
                  <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
                  <input placeholder={t('client.property.valuations.filters.search')} className="w-full pl-16 h-16 bg-black/40 border border-white/5 rounded-[24px] text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" value={filters.search} onChange={e => setFilters(prev => ({
                ...prev,
                search: e.target.value
              }))} />
               </div>
               <div className="flex flex-col sm:flex-row w-full lg:w-fit gap-4">
                  <Select value={filters.status || ""} onValueChange={value => setFilters(prev => ({
                ...prev,
                status: value as ValuationStatus || undefined
              }))}>
                    <SelectTrigger className="w-full sm:w-56 h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6 shadow-inner">
                      <SelectValue placeholder={t('client.property.valuations.filters.status')} />
                    </SelectTrigger>
                    <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                      <SelectItem value="" className="focus:bg-white/5">{t('client.property.valuations.filters.allStatuses')}</SelectItem>
                      <SelectItem value="PENDING" className="focus:bg-white/5">{t('client.property.valuations.statuses.pending')}</SelectItem>
                      <SelectItem value="PROCESSING" className="focus:bg-white/5">{t('client.property.valuations.statuses.processing')}</SelectItem>
                      <SelectItem value="COMPLETED" className="focus:bg-white/5">{t('client.property.valuations.statuses.completed')}</SelectItem>
                      <SelectItem value="FAILED" className="focus:bg-white/5">{t('client.property.valuations.statuses.failed')}</SelectItem>
                      <SelectItem value="EXPIRED" className="focus:bg-white/5">{t('client.property.valuations.statuses.expired')}</SelectItem>
                    </SelectContent>
                  </Select>

                  <Select value={filters.valuationType || ""} onValueChange={value => setFilters(prev => ({
                ...prev,
                valuationType: value as ValuationType || undefined
              }))}>
                    <SelectTrigger className="w-full sm:w-56 h-16 bg-black/40 border-white/5 rounded-[24px] text-white font-black italic text-[10px] tracking-widest px-6 shadow-inner">
                      <SelectValue placeholder={t('client.property.valuations.filters.type')} />
                    </SelectTrigger>
                    <SelectContent className="bg-[#1a1b1e] border-white/10 text-white font-black italic">
                      <SelectItem value="" className="focus:bg-white/5">{t('client.property.valuations.filters.allTypes')}</SelectItem>
                      <SelectItem value="BASIC" className="focus:bg-white/5">{t('client.property.valuations.types.basic')}</SelectItem>
                      <SelectItem value="PROFESSIONAL" className="focus:bg-white/5">{t('client.property.valuations.types.professional')}</SelectItem>
                      <SelectItem value="ENTERPRISE" className="focus:bg-white/5">{t('client.property.valuations.types.enterprise')}</SelectItem>
                      <SelectItem value="INSTANT" className="focus:bg-white/5">{t('client.property.valuations.types.instant')}</SelectItem>
                      <SelectItem value="DETAILED" className="focus:bg-white/5">{t('client.property.valuations.types.detailed')}</SelectItem>
                    </SelectContent>
                  </Select>

                  <Button variant="ghost" className="h-16 w-16 rounded-[24px] bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl">
                    <Filter className="w-6 h-6" />
                  </Button>
               </div>
            </div>
          </Card>
        </motion.div>

        {/* Valuations Table */}
        <motion.div initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }}>
          <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] overflow-hidden backdrop-blur-3xl shadow-3xl">
            <CardHeader className="bg-white/5 border-b border-white/5 p-10 flex flex-row items-center justify-between">
              <div className="space-y-1">
                <CardTitle className="text-2xl font-black text-white italic tracking-tighter leading-none">{t('client.property.valuations.table.title')}</CardTitle>
                <CardDescription className="text-[10px] font-black text-slate-500 tracking-widest italic">{t('client.property.valuations.table.found', {
                  count: (valuations as any)?.total || (Array.isArray(valuations) ? valuations.length : (valuations as any)?.data?.length) || 0
                })}</CardDescription>
              </div>
              <div className="flex gap-4">
                 <Button variant="ghost" className="h-12 px-6 rounded-xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 font-black italic text-[10px] tracking-widest">
                   <Download className="w-4 h-4 mr-3" /> {t('client.property.valuations.table.export')}
                 </Button>
              </div>
            </CardHeader>
            <CardContent className="p-0">
              {isLoading ? <div className="py-32 flex flex-col items-center justify-center gap-6">
                  <Activity className="w-12 h-12 text-blue-500 animate-spin opacity-40" />
                  <p className="text-[10px] font-black tracking-[0.3em] italic text-slate-600">{t('common.loading')}</p>
                </div> : <div className="overflow-x-auto">
                  <Table>
                    <TableHeader className="bg-white/2 border-b border-white/5">
                      <TableRow className="hover:bg-transparent border-none">
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 py-8 italic">{t('client.property.valuations.table.property')}</TableHead>
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.valuations.table.type')}</TableHead>
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.valuations.table.status')}</TableHead>
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.valuations.table.value')}</TableHead>
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.valuations.table.confidence')}</TableHead>
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 italic">{t('client.property.valuations.table.created')}</TableHead>
                        <TableHead className="text-slate-500 text-[10px] font-black tracking-[0.2em] px-10 text-right italic">{t('client.property.valuations.table.actions')}</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {(Array.isArray(valuations) ? valuations : (valuations as any)?.data || [])?.map((valuation: PropertyValuation, idx: number) => {
                    const statusInfo = getStatusInfo(valuation.status);
                    const typeInfo = getTypeInfo(valuation.valuationType);
                    return <TableRow key={valuation.id} className="border-b border-white/5 hover:bg-white/2 transition-all group/row">
                            <TableCell className="px-10 py-10">
                              <div className="flex items-center gap-8">
                                <div className="w-16 h-16 rounded-[20px] bg-black/40 border border-white/5 flex items-center justify-center shadow-inner group-hover/row:scale-110 transition-transform duration-500">
                                   <Building className="w-8 h-8 text-slate-800" />
                                </div>
                                <div className="space-y-1">
                                  <div className="font-black text-white text-lg italic tracking-tighter leading-none group-hover/row:text-blue-400 transition-colors">
                                    {valuation.property?.name || t('common.unnamed')}
                                  </div>
                                  <div className="text-[10px] font-black text-slate-500 tracking-widest italic flex items-center gap-2">
                                    <MapPin className="w-3 h-3 text-blue-500" /> {valuation.property?.address || "SURFACE_GRID_7"}
                                  </div>
                                </div>
                              </div>
                            </TableCell>
                            <TableCell className="px-10">
                              <span className={cn("text-[10px] font-black  tracking-widest italic rounded-full px-4 py-1.5 bg-white/2 border border-white/5", typeInfo.color)}>
                                {typeInfo.label}
                              </span>
                            </TableCell>
                            <TableCell className="px-10">
                              <Badge className={cn("px-4 h-8  text-[8px] font-black tracking-widest rounded-full border shadow-lg backdrop-blur-xl", statusInfo.cls)}>
                                {statusInfo.label}
                              </Badge>
                            </TableCell>
                            <TableCell className="px-10">
                              <div className="space-y-1">
                                <p className="text-[9px] font-black text-slate-500 tracking-widest italic leading-none">{t('client.property.valuations.table.value')}</p>
                                <span className="font-black text-white text-2xl italic tracking-tighter leading-none">
                                  {valuation.value ? `$${valuation.value.toLocaleString()}` : "N/A"}
                                </span>
                              </div>
                            </TableCell>
                            <TableCell className="px-10">
                              {valuation.confidence ? <div className="flex items-center gap-3">
                                  <div className="w-10 h-1.5 bg-black/40 rounded-full border border-white/5 overflow-hidden">
                                     <div className="h-full bg-blue-500 shadow-[0_0_8px_#3b82f6]" style={{
                              width: `${valuation.confidence * 100}%`
                            }} />
                                  </div>
                                  <span className="text-[10px] font-black text-white italic tracking-tighter">{(valuation.confidence * 100).toFixed(1)}%</span>
                                </div> : <span className="text-[10px] font-black text-slate-800 italic">{t("client.src.nullscore")}</span>}
                            </TableCell>
                            <TableCell className="px-10">
                              <div className="space-y-1">
                                <p className="text-[9px] font-black text-slate-500 tracking-widest italic leading-none">{t('client.property.valuations.table.created')}</p>
                                <span className="text-[10px] font-black text-slate-400 italic tracking-widest">
                                  {format(new Date(valuation.createdAt), "MMM dd, yyyy")}
                                </span>
                              </div>
                            </TableCell>
                            <TableCell className="px-10 text-right">
                              <div className="flex justify-end gap-3">
                                {valuation.status === "PENDING" && <Button size="sm" onClick={() => handleProcessValuation(valuation.id)} disabled={processMutation.isPending} className="h-12 px-6 rounded-xl bg-blue-600 hover:bg-blue-500 text-white font-black italic text-[10px] tracking-widest gap-3 shadow-xl shadow-blue-600/20 transition-all hover:scale-105 active:scale-95">
                                    <Play className="w-4 h-4 fill-white" />
                                    {t('client.property.valuations.table.process')}
                                  </Button>}
                                <Button size="sm" variant="ghost" className="h-12 w-12 rounded-xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all">
                                  <ChevronRight className="w-5 h-5" />
                                </Button>
                              </div>
                            </TableCell>
                          </TableRow>;
                  })}
                    </TableBody>
                  </Table>
                </div>}
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>;
}