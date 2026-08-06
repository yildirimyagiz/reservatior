"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Search, Filter, Plus, Phone, Mail, Calendar, Star, CheckCircle, Clock, AlertCircle, MessageSquare, FileText, CreditCard, UserX, Users, MoreVertical, Download, Upload, Zap, Activity, Shield, TrendingUp, MapPin, ArrowUpRight, Loader2 } from 'lucide-react';
import { cn } from '@/lib/utils';
import { m, AnimatePresence } from 'framer-motion';
import { useQuery } from '@tanstack/react-query';
import { guestsApi } from '@/lib/api/guests';

export default function Guests() {
  const {
    t
  } = useTranslation();
  const [selectedGuest, setSelectedGuest] = useState(1);
  const [searchQuery, setSearchQuery] = useState('');
  const [statusFilter, setStatusFilter] = useState('all');
  const { data: guests = [], isLoading } = useQuery({
    queryKey: ['guests'],
    queryFn: async () => {
      const response = await guestsApi.getAll() as any;
      return (response.data || []).map((g: any) => ({
        id: g.id,
        name: g.name,
        email: g.email,
        phone: g.phone || '-',
        avatar: g.avatar || g.name?.charAt(0) || 'U',
        status: g.status || 'inactive',
        type: g.type || 'short-term',
        rating: g.rating || 0,
        checkIn: g.checkIn || '-',
        checkOut: g.checkOut || '-',
        property: g.property || '-',
        totalBookings: g.totalBookings || 0,
        totalRevenue: g.totalRevenue || '$0',
        lastPayment: g.lastPayment || '-',
        nextPayment: g.nextPayment || '-',
        documents: g.documents || 0,
        messages: g.messages || 0,
        alerts: g.alerts || 0
      }));
    }
  });
  const filteredGuests = guests.filter((guest: any) => {
    const matchesSearch = guest.name.toLowerCase().includes(searchQuery.toLowerCase()) || guest.email.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesStatus = statusFilter === 'all' || guest.status === statusFilter;
    return matchesSearch && matchesStatus;
  });
  const currentGuest = guests.find((g: any) => g.id === selectedGuest);
  const getStatusConfig = (status: string) => {
    switch (status) {
      case 'active':
        return {
          label: t("client.src.active_signal"),
          color: 'bg-success/10 text-success border-success/20'
        };
      case 'pending':
        return {
          label: t("client.src.pending_sync"),
          color: 'bg-warning/10 text-orange-400 border-warning/20'
        };
      case 'inactive':
        return {
          label: t("client.src.offline"),
          color: 'bg-muted text-muted-foreground border-slate-500/20'
        };
      default:
        return {
          label: t("client.src.unknown"),
          color: 'bg-muted text-muted-foreground border-slate-500/20'
        };
    }
  };
  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'active':
        return <CheckCircle className="w-4 h-4" />;
      case 'pending':
        return <Clock className="w-4 h-4" />;
      case 'inactive':
        return <UserX className="w-4 h-4" />;
      default:
        return <AlertCircle className="w-4 h-4" />;
    }
  };
  return <div className="h-full flex bg-background overflow-hidden">
      {/* Guests Sidebar Matrix */}
      <div className="w-[450px] border-r border-white/5 bg-card/40 flex flex-col">
        <div className="p-8 border-b border-white/5 space-y-6">
          <div className="flex items-center justify-between">
            <div>
              <h2 className="text-2xl font-black text-white italic tracking-tighter">{t("client.src.entity_nexus")}</h2>
              <p className="text-[10px] font-black text-muted-foreground tracking-widest italic mt-1">{t("client.src.guest_synchronization_matrix")}</p>
            </div>
            <Button size="sm" className="rounded-xl bg-blue-600 hover:bg-brand/100 text-white font-black text-[10px] tracking-widest shadow-xl shadow-blue-600/30 gap-2 italic">
              <Plus className="w-4 h-4" />{t("client.src.initialize_entity")}</Button>
          </div>
          
          {/* Tactical Filters */}
          <div className="space-y-4">
            <div className="relative group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-brand transition-colors" />
              <Input placeholder={t("client.src.synchronizing_guest_data")} value={searchQuery} onChange={e => setSearchQuery(e.target.value)} className="bg-black/20 border-white/5 rounded-2xl pl-12 h-14 text-white focus:ring-blue-500/20 focus:border-blue-500/40 transition-all font-medium border-l border-t" />
            </div>
            
            <div className="flex gap-3">
              <div className="flex-1">
                <select aria-label="Filter by guest status" value={statusFilter} onChange={e => setStatusFilter(e.target.value)} className="w-full h-12 bg-black/20 border border-white/5 rounded-xl px-4 text-[10px] font-black text-white tracking-widest italic focus:outline-none focus:ring-2 focus:ring-blue-500/20 border-l border-t">
                  <option value="all">{t("client.src.all_entities")}</option>
                  <option value="active">{t("client.src.active_signals")}</option>
                  <option value="pending">{t("client.src.pending_sync")}</option>
                  <option value="inactive">{t("client.src.offline_nodes")}</option>
                </select>
              </div>
              <Button variant="outline" className="h-12 w-12 rounded-xl border-white/5 bg-white/5 text-muted-foreground hover:text-white transition-all" aria-label={t("common.filter")}>
                <Filter className="w-4 h-4" />
              </Button>
            </div>
          </div>
        </div>
        
        <ScrollArea className="flex-1 scrollbar-hide">
          <div className="p-4 space-y-3">
            {isLoading ? (
              <div className="flex flex-col items-center justify-center py-12 text-muted-foreground">
                <Loader2 className="w-8 h-8 animate-spin mb-4 text-brand" />
                <p className="text-[10px] font-black tracking-widest italic">{t("client.src.synchronizing")}</p>
              </div>
            ) : filteredGuests.length === 0 ? (
              <div className="flex flex-col items-center justify-center py-12 text-muted-foreground">
                <UserX className="w-8 h-8 mb-4 opacity-50" />
                <p className="text-[10px] font-black tracking-widest italic">{t("client.src.no_entities_found")}</p>
              </div>
            ) : (
              filteredGuests.map((guest: any) => <m.div layout key={guest.id} onClick={() => setSelectedGuest(guest.id)} className={cn("p-5 rounded-3xl cursor-pointer transition-all border-l border-t relative group", selectedGuest === guest.id ? "bg-blue-600/10 border-blue-500/30 shadow-[0_0_20px_rgba(37,99,235,0.1)]" : "bg-white/2 hover:bg-white/5 border-white/5 shadow-xl")}>
                <div className="flex items-start gap-4">
                  <div className="relative shrink-0">
                    <Avatar className={cn("w-14 h-14 border-2 rounded-2xl p-0.5", selectedGuest === guest.id ? "border-blue-500/50" : "border-white/5")}>
                      <AvatarImage src={`/api/placeholder/avatar-${guest.id}.jpg`} className="rounded-xl" />
                      <AvatarFallback className="bg-card text-white font-black italic rounded-xl">
                        {guest.avatar}
                      </AvatarFallback>
                    </Avatar>
                    <div className={cn("absolute -bottom-1 -right-1 w-4 h-4 rounded-full border-2 border-[#14151a]", guest.status === 'active' ? "bg-success" : "bg-muted0")} />
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between mb-1">
                      <p className="font-black text-white italic tracking-tighter truncate text-lg">{guest.name}</p>
                      <div className="flex items-center gap-1 px-2 py-0.5 bg-black/40 rounded-full border border-white/5">
                        <Star className="w-3 h-3 fill-orange-500 text-orange-500" />
                        <span className="text-[10px] font-black text-white italic">{guest.rating}</span>
                      </div>
                    </div>
                    <p className="text-[10px] font-bold text-muted-foreground tracking-tighter truncate mb-3">{guest.email}</p>
                    
                    <div className="flex flex-wrap items-center gap-2">
                      <Badge className={cn("text-[8px] font-black  tracking-widest px-2 py-0.5 rounded-md italic border-none", getStatusConfig(guest.status).color)}>
                        {getStatusConfig(guest.status).label}
                      </Badge>
                      <Badge variant="outline" className="text-[8px] font-black tracking-widest px-2 py-0.5 border-white/10 text-muted-foreground italic">
                        {guest.type}
                      </Badge>
                      {guest.alerts > 0 && <div className="h-4 w-4 rounded-full bg-red-600 text-[8px] font-black text-white flex items-center justify-center animate-pulse">
                          {guest.alerts}
                        </div>}
                    </div>
                    <div className="mt-3 flex items-center gap-2 text-muted-foreground">
                       <MapPin className="w-3 h-3" />
                       <p className="text-[9px] font-bold italic truncate">{guest.property}</p>
                    </div>
                  </div>
                </div>
              </m.div>)
            )}
          </div>
        </ScrollArea>
      </div>

      {/* Guest Intelligence Hub */}
      <div className="flex-1 flex flex-col bg-background">
        <AnimatePresence mode="wait">
          {currentGuest ? <m.div key={currentGuest.id} initial={{
          opacity: 0,
          x: 20
        }} animate={{
          opacity: 1,
          x: 0
        }} exit={{
          opacity: 0,
          x: -20
        }} className="h-full flex flex-col">
              {/* Profile Header Tactical Strip */}
              <div className="p-10 border-b border-white/5 bg-card/20 relative overflow-hidden">
                <div className="absolute top-0 right-0 p-20 opacity-5 pointer-events-none text-brand">
                   <Shield className="w-64 h-64" />
                </div>
                
                <div className="relative z-10 flex items-center justify-between">
                  <div className="flex items-center gap-8">
                    <div className="relative">
                      <Avatar className="w-28 h-28 border-4 border-white/5 rounded-4xl p-1">
                        <AvatarImage src={`/api/placeholder/avatar-${currentGuest.id}.jpg`} className="rounded-[30px]" />
                        <AvatarFallback className="text-3xl font-black italic bg-card">{currentGuest.avatar}</AvatarFallback>
                      </Avatar>
                      <div className="absolute -bottom-2 -right-2 h-10 w-10 rounded-2xl bg-background border border-white/5 flex items-center justify-center shadow-2xl">
                         <Zap className="w-5 h-5 text-orange-500" />
                      </div>
                    </div>
                    
                    <div className="space-y-2">
                       <div className="flex items-center gap-4">
                        <h3 className="text-4xl font-black text-white italic tracking-tighter">{currentGuest.name}</h3>
                        <Badge className={cn("text-[10px] font-black  tracking-widest px-4 py-1.5 rounded-full italic border-none shadow-xl", getStatusConfig(currentGuest.status).color)}>
                          {getStatusConfig(currentGuest.status).label}
                        </Badge>
                       </div>
                      
                      <div className="flex items-center gap-6 mt-1">
                        <div className="flex items-center gap-2 px-3 py-1 bg-white/5 rounded-xl border border-white/5">
                           <Star className="w-4 h-4 fill-orange-500 text-orange-500" />
                           <span className="text-sm font-black text-white italic">{currentGuest.rating}{t("client.src.global_score")}</span>
                        </div>
                        <Badge variant="outline" className="border-white/10 text-muted-foreground font-black italic tracking-widest text-[10px] px-4 py-1 rounded-full">{currentGuest.type}</Badge>
                      </div>
                      
                      <div className="flex items-center gap-8 mt-4">
                        <div className="flex items-center gap-3 text-muted-foreground group cursor-pointer hover:text-white transition-colors">
                          <div className="h-8 w-8 rounded-xl bg-white/5 flex items-center justify-center group-hover:bg-brand/20 transition-all">
                             <Mail className="w-4 h-4" />
                          </div>
                          <span className="text-xs font-bold font-mono tracking-tight">{currentGuest.email}</span>
                        </div>
                        <div className="flex items-center gap-3 text-muted-foreground group cursor-pointer hover:text-white transition-colors">
                          <div className="h-8 w-8 rounded-xl bg-white/5 flex items-center justify-center group-hover:bg-blue-600/20 transition-all">
                             <Phone className="w-4 h-4" />
                          </div>
                          <span className="text-xs font-bold font-mono tracking-tight">{currentGuest.phone}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                  
                  <div className="flex flex-col gap-3">
                    <Button className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-brand/100 text-white font-black tracking-widest text-xs gap-3 italic shadow-xl shadow-blue-600/20 transition-all">
                      <MessageSquare className="w-5 h-5" />{t("client.src.execute_channel")}</Button>
                    <div className="flex gap-3">
                      <Button variant="outline" className="h-12 flex-1 rounded-xl border-white/5 bg-white/5 text-muted-foreground hover:text-white hover:bg-white/10 font-black text-[10px] tracking-widest italic">
                        <FileText className="w-4 h-4 mr-2" />{t("client.src.dossier")}</Button>
                      <Button variant="outline" className="h-12 w-12 rounded-xl border-white/5 bg-white/5 text-muted-foreground hover:text-white hover:bg-white/10" aria-label={t("common.more")}>
                        <MoreVertical className="w-4 h-4" />
                      </Button>
                    </div>
                  </div>
                </div>
              </div>

              {/* Data Intelligence Grid */}
              <ScrollArea className="flex-1 p-10 scrollbar-hide">
                <div className="grid grid-cols-1 lg:grid-cols-3 gap-10">
                  {/* Left Sector: Core Operations */}
                  <div className="lg:col-span-2 space-y-10">
                    
                    {/* Active Occupancy Pulse */}
                    <Card className="bg-card/40 border-white/5 rounded-[40px] overflow-hidden shadow-3xl border-l border-t relative">
                      <div className="absolute top-0 right-0 p-8 opacity-5">
                         <Calendar className="w-24 h-24" />
                      </div>
                      <CardHeader className="p-8 pb-4">
                        <CardTitle className="text-xs font-black text-muted-foreground tracking-widest flex items-center gap-3 italic">
                          <Activity className="w-4 h-4 text-brand" />{t("client.src.current_stay_synchronization")}</CardTitle>
                      </CardHeader>
                      <CardContent className="p-8 pt-4">
                          <div className="flex items-center justify-between mb-8">
                             <div className="space-y-1">
                                <p className="text-[10px] font-black text-muted-foreground tracking-widest italic">{t("client.src.target_node")}</p>
                                <p className="text-2xl font-black text-white italic tracking-tighter">{currentGuest.property}</p>
                             </div>
                             <div className="text-right space-y-1">
                                <p className="text-[10px] font-black text-muted-foreground tracking-widest italic">{t("client.src.tempo_cycle")}</p>
                                <p className="text-2xl font-black text-brand italic tracking-tighter">{t("client.src.5_months_active")}</p>
                             </div>
                          </div>
                          
                          <div className="grid grid-cols-2 gap-8">
                            <div className="bg-black/20 p-6 rounded-3xl border border-white/5 border-l-blue-500/50 border-l-2">
                               <p className="text-[10px] font-black text-muted-foreground tracking-widest italic mb-2">{t("client.src.checkin_initialization")}</p>
                               <p className="text-xl font-black text-white italic font-mono tracking-tighter">{currentGuest.checkIn}</p>
                            </div>
                            <div className="bg-black/20 p-6 rounded-3xl border border-white/5 border-l-orange-500/50 border-l-2">
                               <p className="text-[10px] font-black text-muted-foreground tracking-widest italic mb-2">{t("client.src.termination_window")}</p>
                               <p className="text-xl font-black text-white italic font-mono tracking-tighter">{currentGuest.checkOut}</p>
                            </div>
                          </div>
                      </CardContent>
                    </Card>

                    {/* Financial Velocity Matrix */}
                    <Card className="bg-card/40 border-white/5 rounded-[40px] overflow-hidden shadow-3xl border-l border-t">
                      <CardHeader className="p-8 pb-4">
                        <CardTitle className="text-xs font-black text-muted-foreground tracking-widest flex items-center gap-3 italic">
                          <TrendingUp className="w-4 h-4 text-success" />{t("client.src.economic_parameters")}</CardTitle>
                      </CardHeader>
                      <CardContent className="p-8 pt-4">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                           <div className="bg-success/5 p-8 rounded-[32px] border border-blue-500/10 relative group overflow-hidden">
                              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-success">
                                 <CreditCard className="w-12 h-12" />
                              </div>
                              <p className="text-[10px] font-black text-success/60 tracking-widest italic mb-2">{t("client.src.gross_node_revenue")}</p>
                              <p className="text-4xl font-black text-success italic font-mono tracking-tighter">{currentGuest.totalRevenue}</p>
                              <div className="mt-4 flex items-center gap-2">
                                 <div className="h-1 flex-1 bg-success/10 rounded-full overflow-hidden">
                                    <div className="h-full bg-success shadow-[0_0_10px_#3b82f6]" style={{
                              width: '85%'
                            }}></div>
                                 </div>
                                 <span className="text-[8px] font-black text-success italic">{t("client.src.85_loyalty")}</span>
                              </div>
                           </div>
                           
                           <div className="bg-brand/5 p-8 rounded-[32px] border border-blue-500/10 relative group overflow-hidden">
                             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-brand">
                                 <Users className="w-12 h-12" />
                              </div>
                              <p className="text-[10px] font-black text-brand/60 tracking-widest italic mb-2">{t("client.src.cycle_frequency")}</p>
                              <p className="text-4xl font-black text-brand italic font-mono tracking-tighter">{currentGuest.totalBookings}{t("common.bookings")}</p>
                              <p className="mt-4 text-[9px] font-black text-brand/40 tracking-widest italic">{t("client.src.high_value_entity_level")}</p>
                           </div>
                        </div>
                        
                        <div className="grid grid-cols-2 gap-8 mt-8">
                          <div className="flex justify-between items-center p-6 bg-black/20 rounded-2xl border border-white/5">
                             <span className="text-[11px] font-black text-muted-foreground tracking-widest italic text-nowrap">{t("client.src.last_pulse_arrival")}</span>
                             <span className="text-sm font-black text-white italic font-mono">{currentGuest.lastPayment}</span>
                          </div>
                          <div className="flex justify-between items-center p-6 bg-black/20 rounded-2xl border border-white/5">
                             <span className="text-[11px] font-black text-muted-foreground tracking-widest italic text-nowrap">{t("client.src.next_expected_pulse")}</span>
                             <span className="text-sm font-black text-orange-400 italic font-mono tracking-tighter">{currentGuest.nextPayment !== '-' ? currentGuest.nextPayment : 'SYNC ENDED'}</span>
                          </div>
                        </div>
                      </CardContent>
                    </Card>

                    {/* Intellectual Dossier */}
                    <Card className="bg-card/40 border-white/5 rounded-[40px] overflow-hidden shadow-3xl border-l border-t">
                      <CardHeader className="p-8 pb-4">
                        <div className="flex items-center justify-between">
                          <CardTitle className="text-xs font-black text-muted-foreground tracking-widest flex items-center gap-3 italic">
                            <FileText className="w-4 h-4 text-orange-500" />{t("client.src.entity_documentation_matrix")}{currentGuest.documents})
                          </CardTitle>
                          <Button size="sm" variant="ghost" className="rounded-xl bg-white/5 hover:bg-white/10 text-white font-black text-[8px] tracking-widest italic gap-2 h-8 px-4">
                             <Upload className="w-3 h-3" />{t("client.src.push_doc")}</Button>
                        </div>
                      </CardHeader>
                      <CardContent className="p-8 pt-4">
                        <div className="grid grid-cols-2 gap-4">
                          {['Lease Multi-Chain Agreement', 'Biometric ID Verification', 'Neuro-Background Analysis', 'Global Payment Gateway', 'Emergency Signal Node'].map((doc, i) => <div key={i} className="flex items-center justify-between p-5 bg-black/20 border border-white/5 rounded-2xl hover:bg-white/5 transition-all group">
                              <div className="flex items-center gap-4">
                                <div className="h-10 w-10 rounded-xl bg-white/5 flex items-center justify-center group-hover:scale-110 transition-all text-muted-foreground">
                                  <FileText className="w-5 h-5" />
                                </div>
                                <span className="text-xs font-black text-muted-foreground italic tracking-tighter">{doc}</span>
                              </div>
                              <Button size="icon" aria-label={t("common.download")} variant="ghost" className="h-10 w-10 rounded-xl hover:bg-brand/20 text-brand">
                                <Download className="w-4 h-4" />
                              </Button>
                            </div>)}
                        </div>
                      </CardContent>
                    </Card>
                  </div>

                  {/* Sidebar: Real-time Intelligence */}
                  <div className="space-y-10">
                    {/* Anomaly Alerts */}
                    {currentGuest.alerts > 0 && <Card className="bg-red-500/10 border-red-500/20 rounded-3xl overflow-hidden shadow-2xl relative border-l border-t shadow-red-500/10">
                         <div className="absolute top-0 right-0 p-6 opacity-10 animate-pulse text-red-500">
                            <AlertCircle className="w-10 h-10" />
                         </div>
                        <CardHeader className="p-8 pb-2">
                          <CardTitle className="text-xs font-black text-red-500 tracking-widest flex items-center gap-3 italic">{t("client.src.critical_system_alerts")}{currentGuest.alerts})
                          </CardTitle>
                        </CardHeader>
                        <CardContent className="p-8 pt-2 space-y-4">
                          <div className="p-5 bg-red-600/20 border border-red-500/30 rounded-2xl relative overflow-hidden group">
                             <div className="absolute top-0 left-0 w-1 h-full bg-red-600" />
                            <p className="text-[11px] font-black text-white italic mb-1">{t("client.src.fiscal_anomaly")}</p>
                            <p className="text-[9px] font-bold text-red-400 tracking-tight italic">{t("client.src.expected_payment_pulse_is")}</p>
                          </div>
                          <div className="p-5 bg-orange-600/20 border border-orange-500/30 rounded-2xl relative overflow-hidden">
                             <div className="absolute top-0 left-0 w-1 h-full bg-orange-600" />
                            <p className="text-[11px] font-black text-white italic mb-1">{t("client.src.data_entropy")}</p>
                            <p className="text-[9px] font-bold text-orange-400 tracking-tight italic">{t("client.src.deep_background_sync_required")}</p>
                          </div>
                          <Button className="w-full h-12 bg-red-600 hover:bg-red-500 text-white font-black text-[10px] tracking-widest italic rounded-xl gap-2">
                             <Zap className="w-4 h-4" />{t("client.src.resolve_anomalies")}</Button>
                        </CardContent>
                      </Card>}

                    {/* Interaction Log */}
                    <Card className="bg-card/40 border-white/5 rounded-3xl overflow-hidden shadow-2xl border-l border-t">
                      <CardHeader className="p-8 pb-4">
                        <CardTitle className="text-xs font-black text-white tracking-widest flex items-center gap-3 italic">
                          <ArrowUpRight className="w-4 h-4 text-violet-500" />{t("client.src.interaction_feed")}</CardTitle>
                      </CardHeader>
                      <CardContent className="p-8 pt-2 space-y-6">
                        {[{
                      title: t("client.src.payment_pulse_received"),
                      time: '2 DAYS AGO',
                      color: 'bg-success'
                    }, {
                      title: t("client.src.document_matrix_updated"),
                      time: '5 DAYS AGO',
                      color: 'bg-brand/100'
                    }, {
                      title: t("client.src.ai_channel_comm_link"),
                      time: '1 WEEK AGO',
                      color: 'bg-violet-500'
                    }, {
                      title: t("client.src.initial_sync_finalized"),
                      time: '2 WEEKS AGO',
                      color: 'bg-muted0'
                    }].map((event, i) => <div key={i} className="flex items-start gap-4 group cursor-pointer">
                            <div className="mt-1 space-y-1 flex flex-col items-center">
                               <div className={cn("w-2.5 h-2.5 rounded-full ring-4 ring-[#14151a]", event.color)}></div>
                               {i < 3 && <div className="w-px h-10 bg-white/5" />}
                            </div>
                            <div className="flex-1 pb-4">
                              <p className="text-[11px] font-black text-white italic group-hover:text-brand transition-colors">{event.title}</p>
                              <p className="text-[9px] font-bold text-muted-foreground italic mt-1">{event.time}</p>
                            </div>
                          </div>)}
                        <Button variant="ghost" className="w-full text-[9px] font-black text-muted-foreground hover:text-white tracking-widest italic mt-4">{t("client.src.view_temporal_history")}</Button>
                      </CardContent>
                    </Card>
                    
                    {/* Performance Index */}
                     <Card className="bg-gradient-to-br from-brand/10 to-violet-600/5 border-white/5 rounded-3xl overflow-hidden shadow-2xl border-l border-t p-8 text-center relative">
                        <div className="absolute top-0 right-0 p-4 opacity-5">
                           <TrendingUp className="w-12 h-12" />
                        </div>
                        <p className="text-[10px] font-black text-brand tracking-widest italic mb-6">{t("client.src.tenant_reliability_index")}</p>
                        <div className="relative inline-block">
                           <svg className="w-32 h-32 transform -rotate-90">
                              <circle cx="64" cy="64" r="58" stroke="currentColor" strokeWidth="8" fill="transparent" className="text-white/5" />
                              <circle cx="64" cy="64" r="58" stroke="currentColor" strokeWidth="8" fill="transparent" strokeDasharray="364.4" strokeDashoffset={364.4 * 0.12} className="text-brand drop-shadow-[0_0_8px_#6366f1]" />
                           </svg>
                           <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
                              <p className="text-3xl font-black text-white italic tracking-tighter">88%</p>
                           </div>
                        </div>
                        <p className="mt-6 text-[10px] font-black text-muted-foreground italic">{t("client.src.optimal_copilot_sync")}</p>
                     </Card>
                  </div>
                </div>
              </ScrollArea>
            </m.div> : <div className="flex-1 flex flex-col items-center justify-center space-y-6 opacity-40">
              <div className="h-32 w-32 rounded-4xl bg-white/2 border border-white/5 flex items-center justify-center animate-pulse">
                 <Users className="w-12 h-12 text-muted-foreground" />
              </div>
              <p className="text-xs font-black text-muted-foreground tracking-widest italic">{t("client.src.awaiting_entity_selection_from")}</p>
            </div>}
        </AnimatePresence>
      </div>
    </div>;
}