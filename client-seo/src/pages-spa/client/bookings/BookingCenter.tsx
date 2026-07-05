"use client";

import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { format, startOfMonth, endOfMonth, startOfWeek, endOfWeek, addDays, addMonths, subMonths, isSameMonth, isSameDay, parseISO } from "date-fns";
import { enUS } from "date-fns/locale";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Progress } from "@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Clock, CheckCircle, AlertCircle, MapPin, Users, ChevronLeft, ChevronRight, Plus, CalendarDays, CalendarClock, CalendarCheck, Activity, Zap, Target, FileBarChart, Sparkles, TrendingUp, Building2, ArrowRight, ShieldCheck, LifeBuoy, Key, DollarSign, FileText, CheckSquare, Search, Bell, Home, Star, Tag, Percent, TrendingDown, Globe, Flame, LayoutDashboard, Brain, Link, Share2, ExternalLink, Wifi, Video, GanttChartSquare, BarChart4, Briefcase, MonitorCheck, Radar, Pocket } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog";

// --- Advanced Pricing & Connectivity Types ---
interface TrueComp {
  source: string;
  distance: string;
  matchScore: number;
  price: number;
  features: string[];
}
interface LocalInsight {
  neighborhood: string;
  yieldPremium: number;
  amenityValues: Record<string, string>;
  events: Array<{
    name: string;
    date: string;
    impact: string;
  }>;
  comps: TrueComp[];
}
export default function BookingCenter() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const [activeTab, setActiveTab] = useState<"calendar" | "availability" | "pricing" | "ai_intelligence" | "connectivity">("ai_intelligence");
  const [showEventDialog, setShowEventDialog] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [isSearching, setIsSearching] = useState(false);
  const [currentLocation, setCurrentLocation] = useState("Brooklyn Heights - Promenade");
  const [currentYield, setCurrentYield] = useState(14.2);

  const handleLocationSearch = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter' && searchQuery.trim() !== '') {
      setIsSearching(true);
      setTimeout(() => {
        setCurrentLocation(searchQuery);
        // Generate pseudo-random yield to simulate dynamic API response
        const randomYield = (Math.abs(searchQuery.length * 2.4 + 8.5) % 35).toFixed(1);
        setCurrentYield(Number(randomYield));
        setIsSearching(false);
        setSearchQuery(""); // Clear input after search
      }, 1500); // Simulate Google Maps / Analytics Engine network request
    }
  };

  // MOCK HYPER-LOCAL DATA
  const neighborhoodPulse: LocalInsight = {
    neighborhood: currentLocation,
    yieldPremium: currentYield,
    amenityValues: {
      [t("bookings.pool", "Havuz")]: "+$250/day",
      [t("bookings.metro_proximity", "Metro Yakınlığı")]: "+$180/day",
      [t("bookings.sea_view", "Deniz Manzarası")]: "+$320/day",
      [t("bookings.balcony", "Balkon")]: "+$80/day"
    },
    events: [{
      name: t("bookings.global_tech_summit", "Global Teknoloji Zirvesi"),
      date: t("bookings.july_12_14", "12-14 Temmuz"),
      impact: t("bookings.dynamic_surge", "+%45 Dinamik Artış")
    }, {
      name: t("bookings.jazz_fest", "Caz Festivali 2026"),
      date: t("bookings.aug_02_05", "02-05 Ağustos"),
      impact: t("bookings.yield_gain", "+%18 Getiri Artışı")
    }],
    comps: [{
      source: "Airbnb Luxe",
      distance: "0.2km",
      matchScore: 98,
      price: 1850,
      features: [t("bookings.pool", "Havuz"), t("bookings.view", "Manzara")]
    }, {
      source: "Coldwell Banker",
      distance: "0.4km",
      matchScore: 92,
      price: 1720,
      features: [t("bookings.pool", "Havuz")]
    }, {
      source: "Redfin Comps",
      distance: "0.1km",
      matchScore: 95,
      price: 1780,
      features: [t("bookings.view", "Manzara")]
    }]
  };
  return <div className="min-h-full bg-slate-50 dark:bg-[#0a0b0d] text-slate-600 dark:text-slate-300 p-6 lg:p-10 space-y-10 font-sans">
      
      {/* --- NEURAL HEADER --- */}
      <div className="flex flex-col xl:flex-row xl:items-end justify-between gap-8 max-w-[1700px] mx-auto">
        <div className="space-y-4">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-orange-500/10 border border-orange-500/20 text-[10px] font-black text-orange-400 tracking-widest italic">
            <Radar className="w-3.5 h-3.5" />{t("client.src.neighborhood_pulse_deepscan_active")}</div>
          <div className="space-y-1">
            <h1 className="text-5xl font-black text-slate-900 dark:text-white tracking-tighter italic leading-none">{t("client.src.hyperlocal_intelligence")}</h1>
            <div className="flex flex-col sm:flex-row sm:items-center gap-4 pt-4">
              <span className="text-slate-500 font-medium text-lg whitespace-nowrap">
                {t("bookings.precision_benchmarking_for", "Detaylı Getiri Analizi ve Bölge Kıyaslaması:")}
              </span>
              <div className="relative group">
                <div className="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                  {isSearching ? (
                    <Activity className="h-5 w-5 text-orange-500 animate-pulse" />
                  ) : (
                    <MapPin className="h-5 w-5 text-slate-400 group-focus-within:text-orange-500 transition-colors" />
                  )}
                </div>
                <Input 
                  type="text"
                  placeholder="Konum veya Adres Girin (Google Maps)"
                  className="w-full sm:w-[350px] bg-white dark:bg-[#14151a]/80 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white font-bold h-12 rounded-2xl pl-12 pr-4 focus-visible:ring-orange-500/50 focus-visible:border-orange-500/50 transition-all shadow-xl placeholder:text-slate-400 dark:placeholder:text-slate-600"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  onKeyDown={handleLocationSearch}
                />
                {isSearching && (
                   <span className="absolute -bottom-6 left-4 text-[10px] text-orange-400 italic font-black animate-pulse">
                      Google Maps harita verileri ve fiyatlamalar çekiliyor...
                   </span>
                )}
              </div>
            </div>
          </div>
        </div>

        <div className="flex items-center gap-4 bg-white/80 dark:bg-[#14151a]/60 backdrop-blur-xl p-2 rounded-3xl border border-slate-200 dark:border-white/5 shadow-2xl">
           <Tabs value={activeTab} onValueChange={v => setActiveTab(v as any)} className="bg-slate-100 dark:bg-slate-950/50 p-1 rounded-2xl">
              <TabsList className="bg-transparent gap-1 text-slate-500 dark:text-slate-400">
                <TabsTrigger value="calendar" className="rounded-xl px-4 py-2.5 data-[state=active]:bg-orange-600 data-[state=active]:text-white text-[10px] font-black tracking-widest">{t("client.src.ops")}</TabsTrigger>
                <TabsTrigger value="availability" className="rounded-xl px-4 py-2.5 data-[state=active]:bg-orange-600 data-[state=active]:text-white text-[10px] font-black tracking-widest">{t("client.src.grid")}</TabsTrigger>
                <TabsTrigger value="pricing" className="rounded-xl px-4 py-2.5 data-[state=active]:bg-orange-600 data-[state=active]:text-white text-[10px] font-black tracking-widest">{t("client.src.rules")}</TabsTrigger>
                <TabsTrigger value="ai_intelligence" className="rounded-xl px-4 py-2.5 data-[state=active]:bg-violet-600 data-[state=active]:text-white text-[10px] font-black tracking-widest flex items-center gap-2">
                   <Brain className="w-3.5 h-3.5" />{t("client.src.deep_intel")}</TabsTrigger>
                <TabsTrigger value="connectivity" className="rounded-xl px-4 py-2.5 data-[state=active]:bg-blue-600 data-[state=active]:text-white text-[10px] font-black tracking-widest">{t("client.src.channels")}</TabsTrigger>
              </TabsList>
           </Tabs>
           <Button className="bg-orange-600 hover:bg-orange-500 text-white font-black px-8 h-12 rounded-2xl shadow-xl shadow-orange-600/30 transition-all gap-2" onClick={() => setShowEventDialog(true)}>
              <Target className="w-5 h-5" />{t("client.src.radius_scan")}</Button>
        </div>
      </div>

      <div className="max-w-[1700px] mx-auto grid grid-cols-1 xl:grid-cols-12 gap-10">
        
        {/* --- LEFT SIDEBAR: NEIGHBORHOOD DNA --- */}
        <div className="xl:col-span-3 space-y-6">
           <Card className="bg-white dark:bg-[#14151a]/40 border-slate-200 dark:border-white/5 rounded-4xl overflow-hidden shadow-2xl sticky top-10">
              <CardHeader className="p-8 border-b border-slate-200 dark:border-white/5 bg-gradient-to-b from-orange-600/5 to-transparent">
                 <CardTitle className="text-sm font-black text-slate-900 dark:text-white tracking-widest flex items-center gap-2 italic">
                    <MapPin className="w-4 h-4 text-orange-500" />{t("client.src.neighborhood_dna")}</CardTitle>
              </CardHeader>
              <div className="p-8 space-y-10">
                 <div className="space-y-4">
                    <p className="text-[10px] font-black text-slate-500 tracking-widest">{t("client.src.location_premium")}</p>
                    <div className="flex items-end gap-2">
                       <span className="text-5xl font-black text-slate-900 dark:text-white italic tracking-tighter">+{neighborhoodPulse.yieldPremium}%</span>
                       <TrendingUp className="w-6 h-6 text-emerald-400 mb-1" />
                    </div>
                    <p className="text-[10px] font-bold text-orange-400">{t("client.src.above_district_average")}</p>
                 </div>
                 
                 <div className="space-y-6 pt-10 border-t border-slate-200 dark:border-white/5">
                    <p className="text-[10px] font-black text-slate-500 tracking-widest">{t("client.src.amenity_value_matrix_live")}</p>
                    <div className="space-y-4">
                       {Object.entries(neighborhoodPulse.amenityValues).map(([key, val], i) => <div key={i} className="flex items-center justify-between group">
                            <span className="text-xs font-black text-slate-200 group-hover:text-white transition-colors">{key}</span>
                            <Badge className="bg-emerald-500/10 text-emerald-400 border-none font-black text-[9px] px-3">{val}</Badge>
                         </div>)}
                    </div>
                 </div>
              </div>
           </Card>
        </div>

        {/* --- MAIN CONTENT AREA: HYPER-LOCAL MATRICES --- */}
        <div className="xl:col-span-9 space-y-12">
           <AnimatePresence mode="wait">
             
             {activeTab === "ai_intelligence" && <motion.div initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} exit={{
            opacity: 0,
            y: -20
          }} className="space-y-12">
                   
                   {/* RADIUS PULSE PANEL */}
                   <div className="p-12 bg-gradient-to-br from-white via-slate-50 to-white dark:from-[#14151a] dark:via-[#0a0b0d] dark:to-[#14151a] border border-slate-200 dark:border-orange-500/10 rounded-[3.5rem] relative overflow-hidden group shadow-xl">
                      <Radar className="absolute -right-10 -top-10 w-64 h-64 text-orange-500/5 group-hover:scale-110 transition-all duration-1000" />
                      <div className="relative z-10 flex flex-col lg:flex-row lg:items-center justify-between gap-12">
                         <div className="space-y-8 max-w-xl">
                            <div className="flex items-center gap-4">
                               <div className="p-4 bg-orange-600/10 border border-orange-500/20 rounded-3xl">
                                  <Activity className="w-10 h-10 text-orange-400" />
                               </div>
                               <div className="space-y-1">
                                  <h2 className="text-4xl font-black text-slate-900 dark:text-white italic tracking-tighter">{t("client.src.radius_scan_500m")}</h2>
                                  <p className="text-xs font-black text-slate-500 tracking-widest">{t("client.src.microlocation_yield_optimization")}</p>
                               </div>
                            </div>
                            <p className="text-md text-slate-400 font-medium leading-relaxed italic">{t("client.src.systems_analysis_reveals_that")}<span className="text-orange-400 font-bold">{t("client.src.2_blocks")}</span>{t("client.src.of_this_address_are")}<span className="text-slate-900 dark:text-white font-bold">{t("client.src.12_inventory_squeeze")}</span>{t("client.src.this_is_your_window")}<span className="text-emerald-500 dark:text-emerald-400 font-black">+$240</span>{t("client.src.nightly_premium_before_competitors")}</p>
                            <div className="flex gap-4">
                               <Button className="bg-orange-600 hover:bg-orange-500 text-white font-black h-16 rounded-4xl px-10 text-xs italic tracking-widest transition-all shadow-2xl shadow-orange-600/30">{t("client.src.calibrate_neighborhood")}</Button>
                               <Button variant="ghost" className="h-16 rounded-4xl px-10 text-xs font-black text-slate-500 hover:text-slate-900 dark:hover:text-white border border-slate-200 dark:border-white/5 hover:bg-slate-100 dark:hover:bg-white/5">{t("client.src.full_scan")}</Button>
                            </div>
                         </div>

                         <div className="space-y-6 flex-1 max-w-md">
                            <h4 className="text-[10px] font-black text-slate-500 tracking-widest border-b border-slate-200 dark:border-white/5 pb-3 italic">{t("client.src.local_event_impact_hub")}</h4>
                            <div className="space-y-4">
                               {neighborhoodPulse.events.map((e, i) => <div key={i} className="p-6 bg-slate-50 dark:bg-white/5 border border-slate-200 dark:border-white/5 rounded-3xl group hover:border-violet-500/30 transition-all">
                                    <div className="flex justify-between items-start mb-2">
                                       <span className="text-[10px] font-black text-violet-400">{e.date}</span>
                                       <Zap className="w-4 h-4 text-orange-500" />
                                    </div>
                                    <h4 className="text-lg font-black text-slate-900 dark:text-white tracking-tight italic">{e.name}</h4>
                                    <p className="text-[10px] font-bold text-emerald-400 mt-2">{e.impact}</p>
                                 </div>)}
                            </div>
                         </div>
                      </div>
                   </div>

                   {/* TRUE COMP MATCHING GRID */}
                   <div className="space-y-8">
                      <div className="flex items-end justify-between px-4">
                         <div className="space-y-1">
                            <h3 className="text-3xl font-black text-white italic tracking-tighter">{t("client.src.microscopic_true_comps")}</h3>
                            <p className="text-xs font-black text-slate-500 tracking-widest">{t("client.src.dnamatched_similarity_ranking")}</p>
                         </div>
                         <Button variant="ghost" className="text-[10px] font-black text-slate-500 hover:text-white tracking-widest flex gap-2">
                            <Download className="w-4 h-4" />{t("client.src.export_comp_report")}</Button>
                                     <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-8">
                         {neighborhoodPulse.comps.map((comp, i) => <Card key={i} className="bg-white dark:bg-[#14151a] border-slate-200 dark:border-white/5 p-8 rounded-[2.5rem] hover:border-slate-300 dark:hover:border-white/10 transition-all cursor-pointer group relative overflow-hidden shadow-xl">
                              <div className="absolute top-4 right-4 bg-emerald-500/10 text-emerald-400 text-[10px] font-black px-3 py-1 rounded-full">{comp.matchScore}{t("client.src.match")}</div>
                              <div className="space-y-8 pt-4">
                                 <div className="flex items-center gap-4">
                                    <div className="w-14 h-14 bg-slate-100 dark:bg-slate-900 rounded-2xl flex items-center justify-center">
                                       <Building2 className="w-7 h-7 text-slate-400 dark:text-slate-700" />
                                    </div>
                                    <div className="space-y-1">
                                       <h4 className="text-lg font-black text-slate-900 dark:text-white italic tracking-tight">{comp.source}</h4>
                                       <p className="text-[10px] font-black text-slate-500 tracking-widest flex items-center gap-2"><MapPin className="w-3 h-3 text-orange-500" /> {comp.distance}</p>
                                    </div>
                                 </div>

                                 <div className="p-6 bg-slate-50 dark:bg-slate-950/60 rounded-3xl border border-slate-200 dark:border-white/5 space-y-2">
                                    <p className="text-[10px] font-black text-slate-600 tracking-widest">{t("client.src.comp_nightly_rate")}</p>
                                    <p className="text-3xl font-black text-slate-900 dark:text-white italic tracking-tighter">${comp.price.toLocaleString()}</p>
                                 </div>

                                 <div className="flex flex-wrap gap-2">
                                    {comp.features.map((f, j) => <Badge key={j} className="bg-slate-100 dark:bg-white/5 text-slate-600 dark:text-slate-400 border-slate-200 dark:border-white/10 font-black text-[8px]">{f}</Badge>)}
                                 </div>

                                 <Button variant="ghost" className="w-full h-12 bg-slate-50 dark:bg-white/5 border border-slate-200 dark:border-white/10 rounded-2xl font-black text-[9px] tracking-widest text-slate-700 dark:text-white group-hover:bg-orange-600 group-hover:text-white group-hover:border-orange-600 transition-all">{t("client.src.view_live_listing")}</Button>
                              </div>
                           </Card>)}
                      </div>
                   </div>          </div>
                </motion.div>}

             {/* OTHER TABS... */}
             {activeTab === "calendar" && <motion.div initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} className="space-y-10">
                   <Card className="bg-white dark:bg-[#14151a]/40 border-slate-200 dark:border-white/5 rounded-[3.5rem] p-12 space-y-12">
                      <div className="flex items-center justify-between pb-8">
                         <h3 className="text-3xl font-black text-slate-900 dark:text-white italic tracking-tighter">{t("client.src.neighborhood_activity")}</h3>
                         <Badge className="bg-orange-500/10 text-orange-400 border-none font-black text-[10px] px-6 py-2">{t("client.src.live_microops")}</Badge>
                      </div>
                      <div className="space-y-8">
                         {[1, 2, 3].map(i => <div key={i} className="flex items-center gap-10 p-8 bg-slate-50 dark:bg-white/5 border border-slate-200 dark:border-white/5 rounded-[2.5rem] hover:bg-slate-100 dark:hover:bg-white/10 transition-all cursor-pointer group">
                               <div className="w-20 h-20 bg-white dark:bg-slate-900 border border-slate-200 dark:border-white/10 rounded-3xl flex items-center justify-center group-hover:scale-105 transition-all text-slate-400 dark:text-white">
                                  <Radar className="w-8 h-8 opacity-50" />
                                </div>
                               <div className="flex-1 space-y-2">
                                  <div className="flex items-center gap-3">
                                     <h4 className="text-xl font-black text-slate-900 dark:text-white tracking-tight italic">{t("client.src.microsync_node")}{i}42</h4>
                                     <Badge className="bg-orange-600/10 text-orange-400 border-none text-[8px] font-black tracking-widest">{t("client.src.radius_200m")}</Badge>
                                  </div>
                                  <p className="text-xs font-medium text-slate-500 tracking-widest">{t("client.src.neighborhood_price_movement_detected")}</p>
                               </div>
                               <div className="p-4 bg-orange-500/10 text-orange-400 rounded-2xl group-hover:translate-x-2 transition-all">
                                  <ArrowRight className="w-6 h-6" />
                               </div>
                            </div>)}
                      </div>
                   </Card>
                </motion.div>}
           </AnimatePresence>
        </div>
      </div>

       {/* Analysis Progress Dialog */}
       <Dialog open={showEventDialog} onOpenChange={setShowEventDialog}>
         <DialogContent className="bg-white dark:bg-[#0a0b0d] border-none text-slate-900 dark:text-white rounded-[4rem] max-w-2xl overflow-hidden p-0 shadow-2xl">
            <div className="p-16 space-y-12 bg-gradient-to-br from-orange-50 to-white dark:from-orange-600/10 dark:to-[#0a0b0d]">
               <DialogHeader className="space-y-6 text-center">
                  <div className="mx-auto p-6 bg-orange-600/10 rounded-full w-fit border border-orange-500/20">
                     <Radar className="w-16 h-16 text-orange-500 animate-spin-slow" />
                  </div>
                  <DialogTitle className="text-5xl font-black italic tracking-tighter text-slate-900 dark:text-white">{t("client.src.hyperlocal_scan")}</DialogTitle>
                  <DialogDescription className="text-slate-400 font-medium text-lg leading-relaxed px-6">{t("client.src.deepscanning_immediate_neighbors_amenity")}</DialogDescription>
               </DialogHeader>
               <div className="space-y-8">
                  <div className="grid grid-cols-2 gap-4">
                     {[t("bookings.adna_matching", "A-DNA Eşleştirme"), t("bookings.proximity_check", "Yakınlık Kontrolü"), t("bookings.event_intel", "Etkinlik Verisi"), t("bookings.radius_comps", "Çevre Analizleri")].map(s => <div key={s} className="flex items-center gap-4 bg-slate-50 dark:bg-white/5 p-4 rounded-2xl border border-slate-200 dark:border-white/5">
                          <CheckCircle className="w-4 h-4 text-emerald-400" />
                          <span className="text-[10px] font-black text-slate-700 dark:text-white tracking-widest">{s} {t("client.src.complete")}</span>
                       </div>)}
                  </div>
                  <Button className="w-full bg-orange-600 hover:bg-orange-500 text-white font-black h-20 rounded-[2.5rem] tracking-widest text-sm italic shadow-2xl shadow-orange-600/40 transition-all active:scale-95 group">{t("client.src.initiate_precision_scan")}<ArrowRight className="ml-3 w-5 h-5 group-hover:translate-x-2 transition-all" />
                  </Button>
               </div>
            </div>
         </DialogContent>
      </Dialog>

    </div>;
}

// Missing icons...
const Download = (props: any) => <svg {...props} xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" /><polyline points="7 10 12 15 17 10" /><line x1="12" y1="15" x2="12" y2="3" /></svg>;