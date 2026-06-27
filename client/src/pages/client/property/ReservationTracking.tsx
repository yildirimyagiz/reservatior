import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Progress } from "@/components/ui/progress";
import { Calendar, Clock, Users, CheckCircle, XCircle, AlertTriangle, TrendingUp, TrendingDown, DollarSign, Bed, Bath, Square, Star, MessageSquare, FileText, Filter, Search, Download, RefreshCw, Edit, Activity, BarChart3, PieChart, LineChart, Target, Award, Heart, Building, MapPin, ArrowLeft, ChevronRight, MoreHorizontal, LayoutGrid, Zap } from "lucide-react";
import { reservationsApi } from "@/lib/api/reservations";
import { useQuery } from "@tanstack/react-query";
import { Dialog, DialogContent, DialogTitle, DialogHeader } from "@/components/ui/dialog";
import { useTranslation } from "react-i18next";
import { useNavigate } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
export default function ReservationTracking() {
  const {
    t
  } = useTranslation();
  const navigate = useNavigate();
  const [filter, setFilter] = useState<any>({});
  const [selectedReservation, setSelectedReservation] = useState<any | null>(null);
  const [viewMode, setViewMode] = useState<'list' | 'grid' | 'kanban'>('list');
  const [isLive, setIsLive] = useState(true);
  const {
    data: reservationsData,
    isLoading: isLoadingReservations,
    refetch: refetchReservations
  } = useQuery<{
    data: any[];
    total: number;
  }>({
    queryKey: ["reservations", filter],
    queryFn: async () => {
      const response = await reservationsApi.getAll(filter);
      return response as any;
    }
  });
  const {
    data: analyticsData,
    isLoading: isLoadingAnalytics
  } = useQuery<any>({
    queryKey: ["reservations-analytics"],
    queryFn: async () => {
      const response = await reservationsApi.getAnalytics();
      return response as any;
    }
  });
  const reservations = reservationsData?.data || [];
  const filteredReservations = reservations;
  const analytics = analyticsData;
  useEffect(() => {
    if (!isLive) return;
    const interval = setInterval(() => {
      refetchReservations();
    }, 10000);
    return () => clearInterval(interval);
  }, [isLive, refetchReservations]);
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'pending':
        return 'bg-amber-600/10 text-amber-500 border-amber-600/20';
      case 'confirmed':
        return 'bg-blue-600/10 text-blue-400 border-blue-600/20';
      case 'cancelled':
        return 'bg-rose-600/10 text-rose-500 border-rose-600/20';
      case 'completed':
        return 'bg-emerald-600/10 text-emerald-400 border-emerald-600/20';
      case 'no_show':
        return 'bg-slate-600/10 text-slate-500 border-slate-600/20';
      default:
        return 'bg-slate-600/10 text-slate-500 border-slate-600/20';
    }
  };
  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'pending':
        return <Clock className="w-4 h-4" />;
      case 'confirmed':
        return <CheckCircle className="w-4 h-4" />;
      case 'cancelled':
        return <XCircle className="w-4 h-4" />;
      case 'completed':
        return <CheckCircle className="w-4 h-4" />;
      case 'no_show':
        return <AlertTriangle className="w-4 h-4" />;
      default:
        return <Clock className="w-4 h-4" />;
    }
  };
  const formatCurrency = (amount: number, currency: string) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: currency
    }).format(amount);
  };
  const exportReservations = () => {
    const csv = ['Booking Code,Status,Property,Guest,Check In,Check Out,Nights,Total Amount,Agent', ...filteredReservations.map(res => `${res.bookingCode},${res.status},"${res.property.name}","${res.guest.name}",${res.dates.checkIn.toISOString().split('T')[0]},${res.dates.checkOut.toISOString().split('T')[0]},${res.dates.nights},${res.pricing.totalAmount},${res.assignedAgent || ''}`)].join('\n');
    const blob = new Blob([csv], {
      type: 'text/csv'
    });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `reservations-${new Date().toISOString().split('T')[0]}.csv`;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    window.URL.revokeObjectURL(url);
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
                <Activity className="w-3.5 h-3.5 shadow-[0_0_10px_currentColor]" /> {isLive ? t('live') : t('client.property.reservationTracking.controls.paused')}
              </div>
              <h1 className="text-4xl md:text-6xl font-black text-white italic tracking-tighter leading-none">{t('client.property.reservationTracking.title')}</h1>
              <p className="text-slate-500 text-sm font-black tracking-widest italic">{t('client.property.reservationTracking.subtitle')}</p>
            </div>
          </div>
          <div className="flex items-center gap-4">
             <Button variant="ghost" onClick={() => refetchReservations()} disabled={isLoadingReservations} className="h-16 w-16 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-slate-400 hover:text-white transition-all shadow-xl">
               <RefreshCw className={cn("w-5 h-5", isLoadingReservations ? "animate-spin" : "")} />
             </Button>
             <Button onClick={exportReservations} className="h-16 px-10 rounded-2xl bg-white/5 border border-white/5 hover:bg-white/10 text-white font-black italic text-[10px] tracking-widest shadow-xl transition-all">
               <Download className="w-5 h-5 mr-3" /> {t('client.property.reservationTracking.controls.download')}
             </Button>
          </div>
        </motion.div>

        {/* Analytics Grid */}
        {analytics && <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
            <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.1
        }}>
              <Card className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-8 backdrop-blur-3xl shadow-3xl group relative overflow-hidden">
                <div className="absolute top-0 right-0 p-8 opacity-5 group-hover:scale-110 transition-transform"><Calendar className="w-16 h-16" /></div>
                <div className="relative z-10 space-y-4">
                   <p className="text-[10px] font-black tracking-widest text-slate-500 italic">{t('total')}</p>
                   <p className="text-4xl font-black text-white italic tracking-tighter leading-none">{analytics.total}</p>
                   <p className="text-[10px] font-black text-emerald-400 italic tracking-widest">{t('thisMonth', {
                  pct: Math.floor((analytics.revenue.thisMonth / (analytics.revenue.lastMonth || 1) - 1) * 100)
                })}</p>
                </div>
              </Card>
            </motion.div>

            <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.2
        }}>
              <Card className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-8 backdrop-blur-3xl shadow-3xl group relative overflow-hidden">
                <div className="absolute top-0 right-0 p-8 opacity-5 group-hover:scale-110 transition-transform"><DollarSign className="w-16 h-16" /></div>
                <div className="relative z-10 space-y-4">
                   <p className="text-[10px] font-black tracking-widest text-slate-500 italic">{t('client.property.reservationTracking.revenue')}</p>
                   <p className="text-4xl font-black text-white italic tracking-tighter leading-none">{formatCurrency(analytics.revenue.thisMonth, 'USD')}</p>
                   <p className="text-[10px] font-black text-blue-400 italic tracking-widest">{t('client.property.reservationTracking.target', {
                  amount: formatCurrency(analytics.revenue.projected, 'USD')
                })}</p>
                </div>
              </Card>
            </motion.div>

            <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.3
        }}>
              <Card className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-8 backdrop-blur-3xl shadow-3xl group relative overflow-hidden">
                <div className="absolute top-0 right-0 p-8 opacity-5 group-hover:scale-110 transition-transform"><BarChart3 className="w-16 h-16" /></div>
                <div className="relative z-10 space-y-4">
                   <p className="text-[10px] font-black tracking-widest text-slate-500 italic">{t('client.property.reservationTracking.occupancy')}</p>
                   <div className="flex items-baseline gap-4">
                      <p className="text-4xl font-black text-white italic tracking-tighter leading-none">{analytics.occupancy.current.toFixed(1)}%</p>
                      {analytics.occupancy.trend === 'up' ? <TrendingUp className="w-4 h-4 text-emerald-400" /> : <TrendingDown className="w-4 h-4 text-rose-500" />}
                   </div>
                   <p className="text-[10px] font-black text-slate-600 italic tracking-widest">{t('occupancyTarget', {
                  rate: analytics.occupancy.target
                })}</p>
                </div>
              </Card>
            </motion.div>

            <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.4
        }}>
              <Card className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[32px] p-8 backdrop-blur-3xl shadow-3xl group relative overflow-hidden">
                <div className="absolute top-0 right-0 p-8 opacity-5 group-hover:scale-110 transition-transform"><Heart className="w-16 h-16" /></div>
                <div className="relative z-10 space-y-4">
                   <p className="text-[10px] font-black tracking-widest text-slate-500 italic">{t('satisfaction')}</p>
                   <p className="text-4xl font-black text-white italic tracking-tighter leading-none">{analytics.guestSatisfaction.toFixed(1)}%</p>
                   <div className="flex items-center gap-2">
                      <Star className="w-3.5 h-3.5 text-amber-500 fill-amber-500 shadow-[0_0_10px_currentColor]" />
                      <p className="text-[10px] font-black text-slate-600 italic tracking-widest">{t('avgRating', {
                    rating: analytics.averageRating.toFixed(1)
                  })}</p>
                   </div>
                </div>
              </Card>
            </motion.div>
          </div>}

        {/* Status Hub */}
        <div className="grid grid-cols-2 md:grid-cols-5 gap-6">
          {[{
          status: 'pending',
          count: analytics?.pending || 0,
          label: t('client.property.reservationTracking.statuses.pending'),
          icon: Clock,
          color: 'text-amber-500'
        }, {
          status: 'confirmed',
          count: analytics?.confirmed || 0,
          label: t('confirmed'),
          icon: CheckCircle,
          color: 'text-blue-400'
        }, {
          status: 'completed',
          count: analytics?.completed || 0,
          label: t('client.property.reservationTracking.statuses.completed'),
          icon: CheckCircle,
          color: 'text-emerald-400'
        }, {
          status: 'cancelled',
          count: analytics?.cancelled || 0,
          label: t('client.property.reservationTracking.statuses.cancelled'),
          icon: XCircle,
          color: 'text-rose-500'
        }, {
          status: 'no_show',
          count: 0,
          label: t('noShow'),
          icon: AlertTriangle,
          color: 'text-slate-500'
        }].map(s => <Card key={s.status} className="cursor-pointer bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-3xl p-6 hover:bg-white/5 transition-all shadow-xl group border-none" onClick={() => setFilter({
          ...filter,
          status: s.status
        })}>
               <div className="flex justify-between items-start">
                  <div className="space-y-2">
                     <p className="text-3xl font-black text-white italic tracking-tighter leading-none">{s.count}</p>
                     <p className="text-[9px] font-black text-slate-500 tracking-widest italic group-hover:text-white/40 transition-colors">{s.label}</p>
                  </div>
                  <s.icon className={cn("w-5 h-5 shadow-inner", s.color)} />
               </div>
            </Card>)}
        </div>

        {/* Dynamic Controls Surface */}
        <motion.div initial={{
        opacity: 0,
        scale: 0.98
      }} animate={{
        opacity: 1,
        scale: 1
      }}>
          <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] p-8 backdrop-blur-3xl shadow-3xl flex flex-col lg:flex-row lg:items-center justify-between gap-8">
            <div className="flex-1 max-w-2xl relative group">
               <Search className="absolute left-6 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
               <input placeholder={t('client.property.reservationTracking.controls.search')} className="w-full pl-16 h-16 bg-black/40 border border-white/5 rounded-[24px] text-white font-black italic text-xs tracking-widest focus:outline-none focus:ring-2 focus:ring-blue-600/50 transition-all placeholder:text-slate-800" value={filter.search || ''} onChange={e => setFilter({
              ...filter,
              search: e.target.value || undefined
            })} />
            </div>

            <div className="flex flex-wrap items-center gap-6">
                <select className="h-16 px-8 rounded-2xl bg-black/40 border-white/5 text-slate-400 font-black italic text-[10px] tracking-widest focus:ring-2 focus:ring-blue-600/50 outline-none" value={filter.status || ''} onChange={e => setFilter({
              ...filter,
              status: e.target.value || undefined
            })}>
                  <option value="">{t('client.property.reservationTracking.controls.allStatuses')}</option>
                  <option value="pending">{t('client.property.reservationTracking.statuses.pending')}</option>
                  <option value="confirmed">{t('confirmed')}</option>
                  <option value="completed">{t('client.property.reservationTracking.statuses.completed')}</option>
                  <option value="cancelled">{t('client.property.reservationTracking.statuses.cancelled')}</option>
                  <option value="no_show">{t('noShow')}</option>
                </select>

                <div className="h-16 bg-black/40 p-1.5 rounded-[20px] border border-white/5 flex gap-1 shadow-inner group">
                   <Button variant="ghost" className={cn("h-full px-6 rounded-xl font-black  italic text-[9px] tracking-widest transition-all", viewMode === 'list' ? "bg-white text-black shadow-xl" : "text-slate-600 hover:text-white")} onClick={() => setViewMode('list')}><LayoutGrid className="w-4 h-4 mr-2" /> {t('client.property.reservationTracking.controls.list')}</Button>
                   <Button variant="ghost" className={cn("h-full px-6 rounded-xl font-black  italic text-[9px] tracking-widest transition-all", viewMode === 'grid' ? "bg-white text-black shadow-xl" : "text-slate-600 hover:text-white")} onClick={() => setViewMode('grid')}><Activity className="w-4 h-4 mr-2" /> {t('client.property.reservationTracking.controls.grid')}</Button>
                   <Button variant="ghost" className={cn("h-full px-6 rounded-xl font-black  italic text-[9px] tracking-widest transition-all", viewMode === 'kanban' ? "bg-white text-black shadow-xl" : "text-slate-600 hover:text-white")} onClick={() => setViewMode('kanban')}><Target className="w-4 h-4 mr-2" /> {t('kanban')}</Button>
                </div>
            </div>
          </Card>
        </motion.div>

        {/* Component Manifest */}
        <AnimatePresence mode="wait">
           {viewMode === 'list' && <motion.div key="list" initial={{
          opacity: 0,
          x: -20
        }} animate={{
          opacity: 1,
          x: 0
        }} exit={{
          opacity: 0,
          x: 20
        }}>
                <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] overflow-hidden backdrop-blur-3xl shadow-3xl">
                   <div className="p-10 border-b border-white/5 bg-white/2"><h2 className="text-xl font-black italic text-white tracking-tighter">{t('count', {
                  count: filteredReservations.length
                })}</h2></div>
                   <div className="divide-y divide-white/5">
                      {filteredReservations.map((res: any) => <div key={res.id} onClick={() => setSelectedReservation(res)} className="p-8 flex items-center justify-between hover:bg-white/2 transition-all group cursor-pointer relative">
                            <div className="flex items-center gap-8">
                               <div className="w-16 h-16 rounded-[24px] bg-white/5 border border-white/5 flex items-center justify-center group-hover:scale-110 transition-transform duration-500"><Building className="w-6 h-6 text-blue-500" /></div>
                               <div className="space-y-1.5">
                                  <p className="text-xl font-black text-white italic tracking-tighter leading-none group-hover:text-blue-400 transition-colors">{res.property.name}</p>
                                  <div className="flex items-center gap-3 text-[10px] font-black text-slate-500 tracking-widest italic">
                                     <span>{res.guest.name}</span>
                                     <span className="w-1.5 h-1.5 rounded-full bg-slate-800" />
                                     <span>{t('nights', {
                          count: res.dates.nights
                        })}</span>
                                  </div>
                               </div>
                            </div>
                            <div className="flex items-center gap-12">
                               <div className="text-right hidden md:block">
                                  <p className="text-sm font-black text-white italic tracking-tighter leading-none">{res.dates.checkIn.toISOString().split('T')[0]}</p>
                                  <p className="text-[9px] font-black text-slate-600 tracking-widest italic mt-1.5">{t('checkIn')}</p>
                               </div>
                               <div className="text-right space-y-2">
                                  <p className="text-2xl font-black text-white italic tracking-tighter leading-none">{formatCurrency(res.pricing.totalAmount, res.pricing.currency)}</p>
                                  <Badge className={cn("px-4 h-7  text-[8px] font-black tracking-widest rounded-full italic border-none", getStatusColor(res.status))}>{res.status.replace('_', ' ')}</Badge>
                               </div>
                               <Button variant="ghost" className="h-14 w-14 rounded-2xl bg-white/5 border border-white/5 hover:bg-blue-600 hover:text-white transition-all"><ChevronRight className="w-5 h-5" /></Button>
                            </div>
                         </div>)}
                   </div>
                </Card>
             </motion.div>}

           {viewMode === 'grid' && <motion.div key="grid" initial={{
          opacity: 0,
          scale: 0.95
        }} animate={{
          opacity: 1,
          scale: 1
        }} exit={{
          opacity: 0,
          scale: 1.05
        }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                {filteredReservations.map((res: any) => <Card key={res.id} onClick={() => setSelectedReservation(res)} className="bg-[#1a1b1e]/60 border-white/5 border-l border-t rounded-[40px] overflow-hidden hover:bg-white/5 transition-all shadow-3xl cursor-pointer group">
                     <div className="aspect-video relative overflow-hidden">
                        <img src={res.property.image} className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700 opacity-60 group-hover:opacity-100" />
                        <div className="absolute inset-0 bg-linear-to-t from-[#1a1b1e] to-transparent" />
                        <Badge className={cn("absolute top-6 right-6 px-4 h-8  text-[9px] font-black tracking-widest rounded-full italic border-none", getStatusColor(res.status))}>{res.status}</Badge>
                     </div>
                     <div className="p-10 space-y-6">
                        <div>
                           <h3 className="text-2xl font-black text-white italic tracking-tighter leading-none group-hover:text-blue-400 transition-colors truncate">{res.property.name}</h3>
                           <p className="text-[10px] font-black text-slate-500 tracking-widest italic mt-3 flex items-center gap-2"><MapPin className="w-3.5 h-3.5" />{t("client.src.hudoperationalunit")}</p>
                        </div>
                        <div className="h-px bg-white/5 w-full" />
                        <div className="grid grid-cols-2 gap-6">
                           <div>
                              <p className="text-[8px] font-black text-slate-600 tracking-widest mb-1 italic">{t("client.src.checkin")}</p>
                              <p className="text-sm font-black text-white italic tracking-tighter leading-none">{res.dates.checkIn.toISOString().split('T')[0]}</p>
                           </div>
                           <div className="text-right">
                              <p className="text-[8px] font-black text-slate-600 tracking-widest mb-1 italic">{t("client.src.totalunit")}</p>
                              <p className="text-sm font-black text-emerald-400 italic tracking-tighter leading-none">{formatCurrency(res.pricing.totalAmount, res.pricing.currency)}</p>
                           </div>
                        </div>
                        <Button variant="ghost" className="w-full h-16 rounded-[24px] bg-white/5 border border-white/5 hover:bg-blue-600 text-white font-black italic text-[10px] tracking-widest transition-all shadow-xl group/btn">
                          {t('viewDetails')}
                          <ChevronRight className="w-4 h-4 ml-3 group-hover/btn:translate-x-1 transition-transform" />
                        </Button>
                     </div>
                  </Card>)}
             </motion.div>}

           {viewMode === 'kanban' && <motion.div key="kanban" initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} exit={{
          opacity: 0,
          y: -20
        }} className="grid grid-cols-1 md:grid-cols-3 gap-10 min-h-[600px]">
                {['pending', 'confirmed', 'completed'].map(status => <div key={status} className="bg-black/20 rounded-[40px] p-8 border border-white/5 backdrop-blur-md flex flex-col gap-8">
                     <div className="flex items-center justify-between">
                        <div className="flex items-center gap-3">
                           <div className={cn("w-2 h-2 rounded-full shadow-[0_0_10px_currentColor]", getStatusColor(status).split(' ')[1])} />
                           <h3 className="text-xs font-black text-white italic tracking-widest">{status}</h3>
                        </div>
                        <Badge className="bg-white/5 text-white/40 border-none font-black px-4">{filteredReservations.filter((r: any) => r.status === status).length}</Badge>
                     </div>
                     <div className="flex-1 space-y-6 overflow-y-auto pr-2 custom-scrollbar">
                        {filteredReservations.filter((res: any) => res.status === status).map((res: any) => <motion.div key={res.id} whileHover={{
                scale: 1.02
              }} className="bg-[#1a1b1e] border-white/5 border-l border-t rounded-[24px] p-6 shadow-xl cursor-grab active:cursor-grabbing group">
                             <p className="text-sm font-black text-white italic tracking-tighter group-hover:text-blue-400 transition-colors truncate mb-3">{res.property.name}</p>
                             <div className="flex justify-between items-center text-[9px] font-black text-slate-500 tracking-widest italic">
                                <span>{res.guest.name}</span>
                                <span className="text-emerald-400">{formatCurrency(res.pricing.totalAmount, res.pricing.currency)}</span>
                             </div>
                          </motion.div>)}
                     </div>
                  </div>)}
             </motion.div>}
        </AnimatePresence>

        {/* Analytics Deep HUD */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-10">
           <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] p-10 backdrop-blur-3xl shadow-3xl">
              <div className="flex items-center justify-between mb-10">
                 <h3 className="text-xl font-black text-white italic tracking-tighter flex items-center gap-4"><LineChart className="w-6 h-6 text-blue-500" /> {t('trends')}</h3>
                 <Zap className="w-5 h-5 text-slate-700" />
              </div>
              <div className="h-[250px] flex items-end gap-3 pb-8">
                {[45, 62, 58, 75, 90, 85, 95, 60, 40, 80].map((val, i) => <div key={i} className="flex-1 bg-white/2 rounded-full relative group cursor-pointer h-full">
                    <motion.div initial={{
                height: 0
              }} animate={{
                height: `${val}%`
              }} transition={{
                duration: 1.5,
                delay: i * 0.05
              }} className="absolute bottom-0 left-0 right-0 bg-linear-to-t from-blue-600 to-blue-400 rounded-full group-hover:shadow-[0_0_20px_rgba(37,99,235,0.4)] transition-all" />
                    <div className="absolute -bottom-8 left-0 right-0 text-[8px] font-black text-slate-700 text-center tracking-widest group-hover:text-blue-400 transition-colors">{t("client.src.e")}{i + 1}</div>
                  </div>)}
              </div>
           </Card>

           <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] p-10 backdrop-blur-3xl shadow-3xl">
              <div className="flex items-center justify-between mb-10">
                 <h3 className="text-xl font-black text-white italic tracking-tighter flex items-center gap-4"><PieChart className="w-6 h-6 text-emerald-400" /> {t('client.property.reservationTracking.charts.distribution')}</h3>
                 <div className="flex gap-2">
                    <div className="w-3 h-3 rounded-full bg-blue-500 shadow-[0_0_10px_rgba(59,130,246,0.5)]" />
                    <div className="w-3 h-3 rounded-full bg-emerald-500" />
                    <div className="w-3 h-3 rounded-full bg-amber-500" />
                 </div>
              </div>
              <div className="space-y-8">
                 {[{
              label: t('client.property.reservationTracking.controls.apartment'),
              value: 45,
              color: "bg-blue-600"
            }, {
              label: t('client.property.reservationTracking.controls.villa'),
              value: 30,
              color: "bg-emerald-500"
            }, {
              label: t('detachedHouse'),
              value: 15,
              color: "bg-amber-500"
            }, {
              label: t('client.property.reservationTracking.controls.studio'),
              value: 10,
              color: "bg-slate-700"
            }].map((item, i) => <div key={i} className="space-y-3">
                       <div className="flex justify-between text-[10px] font-black tracking-widest italic">
                          <span className="text-slate-400">{item.label}</span>
                          <span className="text-white">{item.value}%</span>
                       </div>
                       <div className="h-2 w-full bg-white/5 rounded-full overflow-hidden shadow-inner">
                          <motion.div initial={{
                  width: 0
                }} animate={{
                  width: `${item.value}%`
                }} transition={{
                  duration: 1,
                  delay: i * 0.1
                }} className={cn("h-full rounded-full shadow-[0_0_10px_rgba(0,0,0,0.5)]", item.color)} />
                       </div>
                    </div>)}
              </div>
           </Card>
        </div>
      </div>

      {/* Reservation Manifest Dialog */}
      <Dialog open={!!selectedReservation} onOpenChange={() => setSelectedReservation(null)}>
        <DialogContent className="max-w-[1000px] p-0 border-none bg-transparent overflow-hidden shadow-none">
           {selectedReservation && <motion.div initial={{
          opacity: 0,
          scale: 0.95
        }} animate={{
          opacity: 1,
          scale: 1
        }} className="bg-[#1a1b1e] border border-white/10 rounded-[40px] overflow-hidden backdrop-blur-3xl shadow-4xl flex flex-col md:flex-row min-h-[700px]">
                {/* Left Side: Master Parameter */}
                <div className="w-full md:w-[400px] bg-black/40 border-r border-white/10 p-10 flex flex-col justify-between relative overflow-hidden">
                   <div className="absolute top-0 right-0 p-10 opacity-[0.05]"><Zap className="w-40 h-40" /></div>
                   <div className="relative z-10 space-y-10">
                      <Badge className={cn("px-6 h-10  text-[10px] font-black tracking-[0.2em] rounded-full italic border-none shadow-2xl", getStatusColor(selectedReservation.status))}>{selectedReservation.status}</Badge>
                      <div className="space-y-2">
                         <p className="text-[10px] font-black text-slate-500 tracking-[0.2em] italic">{t("client.src.nodecoreidentifier")}</p>
                         <h2 className="text-4xl font-black text-white italic tracking-tighter leading-none">{t('reservation', {
                    code: selectedReservation.bookingCode
                  })}</h2>
                         <p className="text-slate-400 font-black italic text-[11px] tracking-widest pt-4 opacity-60">{t("client.src.hudmanifestoperational")}</p>
                      </div>
                      <div className="space-y-6">
                         <div className="flex items-center gap-4 text-emerald-400">
                            <Clock className="w-5 h-5" />
                            <p className="text-[10px] font-black tracking-widest italic">{t('createdOn', {
                      date: selectedReservation.dates.checkIn.toISOString().split('T')[0]
                    })}</p>
                         </div>
                      </div>
                   </div>
                   <div className="relative z-10 grid grid-cols-1 gap-4">
                      <Button variant="ghost" className="h-16 rounded-2xl bg-white/5 border border-white/5 hover:bg-rose-600 hover:text-white text-rose-500 font-black italic text-[10px] tracking-widest transition-all shadow-xl">{t('client.property.reservationTracking.dialog.cancel')}</Button>
                      <Button className="h-16 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-black italic text-[10px] tracking-widest transition-all shadow-2xl shadow-blue-600/30">{t('manage')}</Button>
                   </div>
                </div>

                {/* Right Side: Data Array */}
                <div className="flex-1 p-10 space-y-10 overflow-y-auto max-h-[80vh] custom-scrollbar">
                   {/* Property HUD */}
                   <div className="space-y-6">
                      <div className="flex items-center justify-between">
                         <h3 className="text-xs font-black text-white italic tracking-[0.2em] flex items-center gap-3"><Building className="w-4 h-4 text-blue-400" /> {t('propertyDetails')}</h3>
                         <span className="text-[9px] font-black text-slate-700">{t("client.src.0xcf42")}</span>
                      </div>
                      <Card className="bg-black/20 border-white/5 rounded-3xl p-6 hover:bg-white/5 transition-all group">
                         <div className="flex gap-8">
                            <div className="w-32 h-32 rounded-2xl overflow-hidden shadow-2xl relative">
                               <img src={selectedReservation.property.image} className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
                               <div className="absolute inset-0 bg-blue-600/10 mix-blend-overlay" />
                            </div>
                            <div className="flex-1 space-y-4 pt-2">
                               <h4 className="text-2xl font-black text-white italic tracking-tighter leading-none group-hover:text-blue-400 transition-colors">{selectedReservation.property.name}</h4>
                               <p className="text-[10px] font-black text-slate-500 tracking-widest italic flex items-center gap-2"><MapPin className="w-3.5 h-3.5" /> {selectedReservation.property.address}</p>
                               <div className="flex gap-6 pt-4 border-t border-white/5">
                                  <div className="flex items-center gap-2 text-[10px] font-black text-white italic tracking-widest"><Bed className="w-3.5 h-3.5 text-blue-400" /> {selectedReservation.property.bedrooms}</div>
                                  <div className="flex items-center gap-2 text-[10px] font-black text-white italic tracking-widest"><Bath className="w-3.5 h-3.5 text-emerald-400" /> {selectedReservation.property.bathrooms}</div>
                                  <div className="flex items-center gap-2 text-[10px] font-black text-white italic tracking-widest"><Square className="w-3.5 h-3.5 text-amber-500" /> {selectedReservation.property.area}{t("client.src.sqm")}</div>
                               </div>
                            </div>
                         </div>
                      </Card>
                   </div>

                   {/* Pricing HUD */}
                   <div className="space-y-6">
                      <h3 className="text-xs font-black text-white italic tracking-[0.2em] flex items-center gap-3"><DollarSign className="w-4 h-4 text-emerald-400" /> {t('pricingAnalysis')}</h3>
                      <Card className="bg-black/20 border-white/5 rounded-3xl p-8 space-y-4 shadow-inner relative overflow-hidden group">
                         <div className="absolute top-0 right-0 p-8 opacity-[0.03] group-hover:scale-110 transition-transform"><BarChart3 className="w-20 h-20" /></div>
                         <div className="flex justify-between items-center text-[11px] font-black text-slate-500 tracking-widest italic">
                            <span>{t('nightlyRate', {
                      count: selectedReservation.dates.nights
                    })}</span>
                            <span className="text-white">{formatCurrency(selectedReservation.pricing.nightlyRate, selectedReservation.pricing.currency)} / NIGHT</span>
                         </div>
                         <div className="flex justify-between items-center text-[11px] font-black text-slate-500 tracking-widest italic pt-2">
                            <span>{t('extraFees')}</span>
                            <span className="text-white">{formatCurrency(selectedReservation.pricing.extraFees, selectedReservation.pricing.currency)}</span>
                         </div>
                         <div className="flex justify-between items-center text-[11px] font-black text-slate-500 tracking-widest italic pt-2 pb-6">
                            <span>{t('taxes')}</span>
                            <span className="text-white">{formatCurrency(selectedReservation.pricing.taxes, selectedReservation.pricing.currency)}</span>
                         </div>
                         <div className="h-px bg-white/10 w-full" />
                         <div className="flex justify-between items-center pt-4 relative z-10">
                            <span className="text-[10px] font-black text-emerald-400 tracking-[0.2em] italic">{t('client.property.reservationTracking.dialog.totalPaid')}</span>
                            <span className="text-4xl font-black text-emerald-400 italic tracking-tighter leading-none shadow-[0_0_20px_rgba(52,211,153,0.2)]">{formatCurrency(selectedReservation.pricing.totalAmount, selectedReservation.pricing.currency)}</span>
                         </div>
                      </Card>
                   </div>
                </div>
             </motion.div>}
        </DialogContent>
      </Dialog>
    </div>;
}