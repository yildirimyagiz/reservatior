import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { format, startOfMonth, endOfMonth, startOfWeek, endOfWeek, addDays, addMonths, subMonths, isSameMonth, isSameDay, parseISO } from "date-fns";
import { tr } from "date-fns/locale";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Progress } from "@/components/ui/progress";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Clock, CheckCircle, AlertCircle, MapPin, Users, ChevronLeft, ChevronRight, Plus, CalendarDays, CalendarClock, CalendarCheck, Activity, Zap, Target, FileBarChart, Sparkles, TrendingUp, Building2, ArrowRight, ShieldCheck, LifeBuoy, Briefcase, Key, DollarSign, FileText, CheckSquare, Search, Bell } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";

// --- Sector Types Based on User Request ---
type SectorType = "rentals" | "sales" | "bookings" | "tasks" | "documents" | "helpdesk";
interface AgendaItem {
  id: string;
  title: string;
  description?: string;
  time: string;
  endTime?: string;
  sector: SectorType;
  priority: "low" | "medium" | "high" | "urgent";
  status: "pending" | "ongoing" | "completed" | "flagged";
  entityName: string;
  entityRole: string; // Agency, Agent, Tenant, Guest, Buyer, Seller
  location?: string;
  progress?: number;
}
export default function Today() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const [currentDate, setCurrentDate] = useState(new Date());
  const [selectedDate, setSelectedDate] = useState<Date>(new Date());
  const [showEventDialog, setShowEventDialog] = useState(false);
  const [activeSector, setActiveSector] = useState<SectorType | "all">("all");
  const [agenda, setAgenda] = useState<AgendaItem[]>([]);

  // --- Role Visibility Logic ---
  const isTeamApp = user?.role === "SUPER_ADMIN" || user?.role === "ORG_ADMIN";
  const isAgency = user?.role === "AGENCY_ADMIN";
  const isAgent = user?.role === "AGENT";
  const isTenantGuest = user?.role === "TENANT_GUEST";

  // Define sectors visibility by role
  const getVisibleSectors = (): (SectorType | "all")[] => {
    if (isTeamApp || isAgency) return ["all", "sales", "rentals", "bookings", "documents", "helpdesk", "tasks"];
    if (isAgent) return ["all", "sales", "rentals", "tasks", "helpdesk"];
    if (isTenantGuest) return ["all", "rentals", "bookings", "helpdesk"];
    return ["all", "helpdesk"];
  };
  const visibleSectors = getVisibleSectors();
  useEffect(() => {
    // Ensure active sector is valid for the role
    if (!visibleSectors.includes(activeSector)) {
      setActiveSector("all");
    }
  }, [user, activeSector]);
  useEffect(() => {
    // Mock data reflecting the specific user requirement
    const mockAgenda: AgendaItem[] = [{
      id: "a1",
      title: t("client.src.vip_sale_closing_ocean"),
      description: t("client.src.final_signature_session_with"),
      time: "10:30",
      endTime: "12:00",
      sector: "sales",
      priority: "urgent",
      status: "ongoing",
      entityName: "Alexander Rivera",
      entityRole: "Seller",
      location: "Central Notary Office"
    }, {
      id: "a2",
      title: t("client.src.tenant_onboarding_apt_402"),
      description: t("client.src.key_handover_and_digital"),
      time: "13:00",
      endTime: "14:00",
      sector: "rentals",
      priority: "high",
      status: "pending",
      entityName: "Sarah Jenkins",
      entityRole: "Tenant",
      location: "Skyline Residency"
    }, {
      id: "a3",
      title: t("client.src.guest_checkin_seaside_loft"),
      description: t("client.src.late_arrival_automated_lock"),
      time: "15:30",
      sector: "bookings",
      priority: "medium",
      status: "pending",
      entityName: "Mark Thompson",
      entityRole: "Guest",
      location: "Marina District"
    }, {
      id: "a4",
      title: t("client.src.aml_document_verification"),
      description: t("client.src.agent_alpha_uploaded_new"),
      time: "11:00",
      sector: "documents",
      priority: "urgent",
      status: "flagged",
      entityName: "Agency X",
      entityRole: "Agency",
      progress: 65
    }, {
      id: "a5",
      title: t("client.src.helpdesk_payout_discrepancy"),
      description: t("client.src.agent_reporting_missing_commission"),
      time: "09:00",
      sector: "helpdesk",
      priority: "high",
      status: "completed",
      entityName: "Elias Vance",
      entityRole: "Agent"
    }, {
      id: "a6",
      title: t("client.src.system_maintenance_db_sync"),
      description: t("client.src.global_synchronization_of_booking"),
      time: "02:00",
      sector: "tasks",
      priority: "low",
      status: "completed",
      entityName: "Platform Team",
      entityRole: "Team App"
    }];
    setAgenda(mockAgenda);
  }, []);
  const getSectorIcon = (sector: SectorType) => {
    switch (sector) {
      case "rentals":
        return <Key className="w-4 h-4" />;
      case "sales":
        return <DollarSign className="w-4 h-4" />;
      case "bookings":
        return <CalendarCheck className="w-4 h-4" />;
      case "tasks":
        return <CheckSquare className="w-4 h-4" />;
      case "documents":
        return <FileText className="w-4 h-4" />;
      case "helpdesk":
        return <LifeBuoy className="w-4 h-4" />;
    }
  };
  const getSectorColor = (sector: SectorType) => {
    switch (sector) {
      case "rentals":
        return "text-blue-400 bg-blue-500/10 border-blue-500/20";
      case "sales":
        return "text-emerald-400 bg-emerald-500/10 border-emerald-500/20";
      case "bookings":
        return "text-purple-400 bg-purple-500/10 border-purple-500/20";
      case "tasks":
        return "text-amber-400 bg-amber-500/10 border-amber-500/20";
      case "documents":
        return "text-indigo-400 bg-indigo-500/10 border-indigo-500/20";
      case "helpdesk":
        return "text-rose-400 bg-rose-500/10 border-rose-500/20";
    }
  };
  const roleLabels: Record<string, string> = {
    "SUPER_ADMIN": "Nexus Overlord",
    "ORG_ADMIN": "Systems Architect",
    "AGENCY_ADMIN": "Agency Director",
    "AGENT": "Field Operative",
    "TENANT_GUEST": "Residency Guest"
  };
  const filteredAgenda = agenda.filter(item => {
    if (activeSector !== "all" && item.sector !== activeSector) return false;
    // Further role filtering of the actual items
    if (isTenantGuest && !["rentals", "bookings", "helpdesk"].includes(item.sector)) return false;
    if (isAgent && !["rentals", "sales", "tasks", "helpdesk"].includes(item.sector)) return false;
    return true;
  });
  return <div className="min-h-full bg-[#0a0b0d] text-slate-300 p-6 lg:p-10 space-y-10 selection:bg-blue-500/30 font-sans">
      
      {/* --- ADMINISTRATIVE HUD --- */}
      <div className="flex flex-col xl:flex-row xl:items-end justify-between gap-8">
        <div className="space-y-4">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-500/5 border border-blue-500/10 text-[10px] font-black text-blue-400 tracking-widest">
            <span className="relative flex h-2 w-2">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-blue-400 opacity-75"></span>
              <span className="relative inline-flex rounded-full h-2 w-2 bg-blue-500"></span>
            </span>
            {roleLabels[user?.role || "USER"] || "User"}{t("client.src.session_active")}</div>
          <div className="space-y-1">
            <h1 className="text-5xl font-black text-white tracking-tighter">{t("client.src.operational_today")}</h1>
            <p className="text-slate-500 font-medium text-lg italic">{t("client.src.hello")}<span className="text-white font-bold">{user?.name}</span>{t("client.src.you_have")}<span className="text-blue-400 font-bold">{filteredAgenda.length}</span>{t("client.src.actionable_items")}</p>
          </div>
        </div>

        <div className="flex items-center gap-6 p-4 rounded-[2.5rem] bg-[#14151a] border border-white/5 shadow-2xl">
          <div className="flex items-center gap-4 px-2">
             <div className="text-right">
                <div className="text-xs font-black text-slate-500 tracking-widest">{t("client.src.local_insight")}</div>
                <div className="text-xl font-bold text-white tracking-tight">{format(new Date(), "HH:mm")}</div>
             </div>
             <div className="h-10 w-px bg-white/5" />
             <Button variant="ghost" size="icon" className="bg-white/5 hover:bg-blue-500/20 hover:text-blue-400 rounded-2xl h-12 w-12 transition-all">
                <Bell className="w-6 h-6" />
             </Button>
          </div>
          <Button className="bg-blue-600 hover:bg-blue-500 text-white font-black px-8 h-14 rounded-2xl shadow-xl shadow-blue-600/30 active:scale-95 transition-all gap-3" onClick={() => setShowEventDialog(true)}>
            <Plus className="w-6 h-6" />{t("client.src.new_deployment")}</Button>
        </div>
      </div>

      {/* --- QUICK SECTOR INSIGHTS --- */}
      <div className="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-6 gap-6">
         {[{
        label: t("client.src.sales"),
        val: 4,
        sub: "Pipeline",
        icon: <DollarSign />,
        color: "emerald",
        roles: ["SUPER_ADMIN", "ORG_ADMIN", "AGENCY_ADMIN", "AGENT"]
      }, {
        label: t("client.src.rentals"),
        val: 12,
        sub: "Occupancy",
        icon: <Key />,
        color: "blue",
        roles: ["SUPER_ADMIN", "ORG_ADMIN", "AGENCY_ADMIN", "AGENT", "TENANT_GUEST"]
      }, {
        label: t("client.src.bookings"),
        val: 8,
        sub: "Activity",
        icon: <CalendarDays />,
        color: "purple",
        roles: ["SUPER_ADMIN", "ORG_ADMIN", "AGENCY_ADMIN", "TENANT_GUEST"]
      }, {
        label: t("client.src.document"),
        val: 5,
        sub: "Flags",
        icon: <ShieldCheck />,
        color: "indigo",
        roles: ["SUPER_ADMIN", "ORG_ADMIN", "AGENCY_ADMIN"]
      }, {
        label: t("client.src.helpdesk"),
        val: 3,
        sub: "Tickets",
        icon: <LifeBuoy />,
        color: "rose",
        roles: ["SUPER_ADMIN", "ORG_ADMIN", "AGENCY_ADMIN", "AGENT", "TENANT_GUEST"]
      }, {
        label: t("client.src.tasks"),
        val: 14,
        sub: "Remaining",
        icon: <CheckSquare />,
        color: "amber",
        roles: ["SUPER_ADMIN", "ORG_ADMIN", "AGENCY_ADMIN", "AGENT"]
      }].filter(s => s.roles.includes(user?.role || "USER")).map((s, i) => <Card key={i} className="bg-[#14151a]/50 border-white/5 hover:border-blue-500/20 transition-all cursor-pointer group rounded-4xl overflow-hidden">
             <CardContent className="p-6">
                <div className={cn("p-3 rounded-2xl w-fit mb-4 group-hover:scale-110 transition-transform", s.color === 'emerald' ? 'bg-emerald-500/10 text-emerald-400' : s.color === 'blue' ? 'bg-blue-500/10 text-blue-400' : s.color === 'purple' ? 'bg-purple-500/10 text-purple-400' : s.color === 'indigo' ? 'bg-indigo-500/10 text-indigo-400' : s.color === 'rose' ? 'bg-rose-500/10 text-rose-400' : 'bg-amber-500/10 text-amber-400')}>
                  {s.icon}
                </div>
                <div className="text-2xl font-black text-white tracking-tighter mb-0.5">{s.val}</div>
                <div className="text-[10px] font-bold text-slate-500 tracking-widest">{s.label}</div>
             </CardContent>
           </Card>)}
      </div>

      <div className="grid grid-cols-1 xl:grid-cols-12 gap-10">
        
        {/* --- LIVE ECOSYSTEM AGENDA --- */}
        <div className="xl:col-span-8 space-y-8">
           <Tabs defaultValue="all" onValueChange={v => setActiveSector(v as any)} className="space-y-8">
              <div className="flex items-center justify-between flex-wrap gap-6">
                <TabsList className="bg-slate-950/50 p-1.5 rounded-2xl border border-white/5 h-auto flex flex-wrap gap-1">
                   {visibleSectors.map(s => <TabsTrigger key={s} value={s} className="rounded-xl px-6 py-2.5 data-[state=active]:bg-blue-600 data-[state=active]:text-white text-[10px] font-black tracking-widest">
                       {s === 'all' ? 'Universe' : s}
                     </TabsTrigger>)}
                </TabsList>
                
                <div className="relative group">
                   <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600 group-focus-within:text-blue-500 transition-colors" />
                   <Input placeholder={t("client.src.search_entities_agents_or")} className="bg-[#14151a] border-white/10 pl-11 pr-6 rounded-2xl h-12 w-full md:w-[300px] text-sm focus:ring-blue-500/20 focus:border-blue-500/30 transition-all font-medium" />
                </div>
              </div>

              <TabsContent value={activeSector} className="mt-0 outline-none">
                 <div className="grid gap-6">
                    <AnimatePresence mode="popLayout">
                      {filteredAgenda.map((item, idx) => <motion.div key={item.id} layout initial={{
                  opacity: 0,
                  y: 20
                }} animate={{
                  opacity: 1,
                  y: 0
                }} exit={{
                  opacity: 0,
                  scale: 0.95
                }} transition={{
                  delay: idx * 0.05
                }}>
                          <Card className="bg-[#14151a]/40 border-white/5 rounded-[2.5rem] hover:bg-[#1a1b21] hover:border-white/10 transition-all overflow-hidden group">
                             <CardContent className="p-8">
                                 <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
                                    <div className="flex items-start gap-6">
                                       <div className="flex flex-col items-center">
                                          <div className="text-[10px] font-black text-slate-500 mb-1">{item.time}</div>
                                          <div className="w-1 h-12 bg-linear-to-b from-blue-500/50 to-transparent rounded-full" />
                                       </div>
                                       <div className="space-y-2">
                                          <div className="flex items-center gap-3">
                                             <Badge className={cn("rounded-lg px-2.5 py-1 font-black text-[9px]  tracking-wider", getSectorColor(item.sector))}>
                                               {getSectorIcon(item.sector)}
                                               <span className="ml-1.5">{item.sector}</span>
                                             </Badge>
                                             <div className={cn("w-1.5 h-1.5 rounded-full", item.priority === "urgent" ? "bg-rose-500 animate-pulse shadow-[0_0_8px_#f43f5e]" : item.priority === "high" ? "bg-amber-500" : "bg-blue-500")} />
                                          </div>
                                          <h3 className="text-xl font-bold text-white group-hover:text-blue-400 transition-colors tracking-tight">{item.title}</h3>
                                          <p className="text-sm text-slate-500 font-medium max-w-lg leading-relaxed">{item.description}</p>
                                       </div>
                                    </div>

                                    <div className="flex items-center justify-between md:justify-end gap-10 border-t md:border-t-0 border-white/5 pt-6 md:pt-0">
                                       <div className="flex items-center gap-4">
                                          <Avatar className="h-12 w-12 border-2 border-white/5 rounded-2xl">
                                             <AvatarFallback className="bg-slate-800 text-xs font-black text-blue-400 tracking-tighter">
                                               {item.entityName.substring(0, 2)}
                                             </AvatarFallback>
                                          </Avatar>
                                          <div>
                                             <div className="text-xs font-black text-white tracking-tight">{item.entityName}</div>
                                             <div className="text-[10px] font-bold text-slate-500 tracking-[0.15em]">{item.entityRole}</div>
                                          </div>
                                       </div>
                                       <div className="flex flex-col items-end gap-2">
                                          <Button variant="ghost" size="icon" className="rounded-xl hover:bg-white/5 text-slate-500 hover:text-white">
                                             <ArrowRight className="w-5 h-5" />
                                          </Button>
                                       </div>
                                    </div>
                                 </div>
                                 {item.progress !== undefined && <div className="mt-6 space-y-2">
                                     <div className="flex justify-between text-[10px] font-black tracking-widest text-slate-500">
                                       <span>{t("client.src.verification_integrity")}</span>
                                       <span className="text-indigo-400">{item.progress}%</span>
                                     </div>
                                     <Progress value={item.progress} className="h-1 bg-white/5" />
                                   </div>}
                             </CardContent>
                          </Card>
                        </motion.div>)}
                    </AnimatePresence>
                 </div>
              </TabsContent>
           </Tabs>
        </div>

        {/* --- STRATEGIC SIDEBAR --- */}
        <div className="xl:col-span-4 space-y-10">
           <Card className="bg-[#14151a]/40 border-white/5 rounded-[2.5rem] backdrop-blur-3xl overflow-hidden shadow-2xl">
              <CardHeader className="p-8 border-b border-white/5 bg-white/5">
               <CardTitle className="text-lg font-black text-white flex items-center gap-3">
                 <Target className="w-5 h-5 text-blue-500" />{t("client.src.ecosystem_horizon")}</CardTitle>
               <CardDescription className="text-slate-500 font-bold text-[10px] tracking-widest">{t("client.src.global_ops_calendar")}</CardDescription>
             </CardHeader>
             <CardContent className="p-0">
                <div className="p-6">
                   <div className="flex items-center justify-between mb-6">
                      <h4 className="text-sm font-bold text-white">{format(currentDate, "MMMM yyyy", {
                    locale: tr
                  })}</h4>
                      <div className="flex gap-1">
                         <Button onClick={() => setCurrentDate(subMonths(currentDate, 1))} variant="ghost" size="icon" className="h-8 w-8 hover:bg-white/5 rounded-lg"><ChevronLeft className="w-4 h-4" /></Button>
                         <Button onClick={() => setCurrentDate(addMonths(currentDate, 1))} variant="ghost" size="icon" className="h-8 w-8 hover:bg-white/5 rounded-lg"><ChevronRight className="w-4 h-4" /></Button>
                      </div>
                   </div>
                   <div className="grid grid-cols-7 gap-1 mb-2">
                      {["M", "T", "W", "T", "F", "S", "S"].map(d => <div key={d} className="text-center text-[9px] font-black text-slate-600 py-2">{d}</div>)}
                   </div>
                   <div className="grid grid-cols-7 gap-px rounded-xl overflow-hidden grayscale opacity-80 hover:grayscale-0 hover:opacity-100 transition-all">
                      {/* Simple Calendar Grid */}
                      {Array.from({
                  length: 35
                }).map((_, i) => <div key={i} className={cn("aspect-square flex items-center justify-center text-[9px] font-bold border border-white/5", i === 15 ? "bg-blue-600 text-white rounded-lg scale-110 shadow-lg z-10" : "bg-white/5 text-slate-500")}>
                           {i + 1 > 31 ? i + 1 - 31 : i + 1}
                        </div>)}
                   </div>
                </div>
             </CardContent>
           </Card>

           <Card className="bg-linear-to-br from-indigo-600/10 via-[#14151a] to-[#14151a] border-white/5 rounded-[2.5rem] p-10 relative overflow-hidden group">
               <Sparkles className="absolute -right-6 -bottom-6 w-32 h-32 text-indigo-500/10 group-hover:scale-110 transition-transform duration-700" />
               <div className="relative z-10 space-y-6">
                  <div className="p-4 bg-indigo-500/10 rounded-3xl w-fit border border-indigo-500/20">
                    <ShieldCheck className="w-8 h-8 text-indigo-400" />
                  </div>
                  <div className="space-y-2">
                     <h3 className="text-2xl font-black text-white tracking-tight leading-tight">{t("client.src.document_compliance_matrix")}</h3>
                     <p className="text-slate-500 font-medium text-sm leading-relaxed">
                        <span className="text-indigo-400 font-bold">{t("client.src.5_critical_flags")}</span>{t("client.src.detected_in_agent_contracts")}</p>
                  </div>
                  <Button className="w-full bg-[#1c1d25] border border-white/5 hover:bg-indigo-600 hover:text-white transition-all h-14 rounded-2xl text-[10px] font-black tracking-widest gap-2">{t("client.src.audit_submissions")}<ArrowRight className="w-4 h-4" />
                  </Button>
               </div>
           </Card>

           <Card className="bg-[#14151a]/40 border-white/5 rounded-[2.5rem] p-10 backdrop-blur-3xl">
               <div className="flex items-center gap-2 mb-8">
                 <Activity className="w-4 h-4 text-emerald-500" />
                 <h4 className="text-[10px] font-black text-slate-500 tracking-[0.2em]">{t("client.src.ecosystem_vitality")}</h4>
               </div>
               <div className="space-y-8">
                  {[{
              label: t("client.src.booking_yield"),
              val: 82,
              color: "purple"
            }, {
              label: t("client.src.lead_conversion"),
              val: 64,
              color: "emerald"
            }, {
              label: t("client.src.ticket_resolution"),
              val: 94,
              color: "blue"
            }].map((metric, i) => <div key={i} className="space-y-3">
                       <div className="flex justify-between items-end">
                          <span className="text-sm font-bold text-white">{metric.label}</span>
                          <span className={cn("text-xs font-black", metric.color === 'purple' ? 'text-purple-400' : metric.color === 'emerald' ? 'text-emerald-400' : 'text-blue-400')}>{metric.val}%</span>
                       </div>
                       <div className="h-1.5 bg-white/5 rounded-full overflow-hidden">
                         <motion.div initial={{
                  width: 0
                }} animate={{
                  width: `${metric.val}%`
                }} transition={{
                  duration: 1.5,
                  delay: i * 0.2
                }} className={cn("h-full", metric.color === 'purple' ? 'bg-purple-500' : metric.color === 'emerald' ? 'bg-emerald-500' : 'bg-blue-500')} />
                       </div>
                    </div>)}
               </div>
           </Card>
        </div>
      </div>

      <Dialog open={showEventDialog} onOpenChange={setShowEventDialog}>
        <DialogContent className="bg-[#0a0b0d] border-white/5 text-white rounded-[3rem] max-w-2xl overflow-hidden p-0 shadow-[0_0_80px_rgba(0,0,0,0.8)]">
          {/* Reuse the previous dialog structure but tailored to new roles */}
          <div className="p-10 space-y-8">
            <DialogHeader className="space-y-2">
              <DialogTitle className="text-3xl font-black flex items-center gap-3">
                <Zap className="w-8 h-8 text-blue-500" />{t("client.src.strategic_intervention")}</DialogTitle>
              <DialogDescription className="text-slate-400 font-medium">{t("client.src.add_a_critical_checkpoint")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-8">
               <div className="grid grid-cols-2 gap-8">
                  <div className="space-y-2.5">
                    <label className="text-[10px] font-black text-slate-500 tracking-[0.2em] ml-1">{t("client.src.mission_title")}</label>
                    <Input placeholder={t("client.src.eg_notary_session")} className="bg-white/5 border-white/10 rounded-2xl h-14 font-bold text-white" />
                  </div>
                  <div className="space-y-2.5">
                    <label className="text-[10px] font-black text-slate-500 tracking-[0.2em] ml-1">{t("client.src.target_sector")}</label>
                    <Select>
                      <SelectTrigger className="bg-white/5 border-white/10 rounded-2xl h-14 font-bold text-white">
                        <SelectValue placeholder={t("client.src.select_type")} />
                      </SelectTrigger>
                      <SelectContent className="bg-slate-900 border-white/10 text-white rounded-2xl">
                        <SelectItem value="sales">{t("client.src.sales_payouts")}</SelectItem>
                        <SelectItem value="rentals">{t("client.src.rentals_leases")}</SelectItem>
                        <SelectItem value="bookings">{t("client.src.hospitality_bookings")}</SelectItem>
                        <SelectItem value="helpdesk">{t("client.src.helpdesk_support")}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
               </div>
            </div>
            <DialogFooter className="pt-6">
              <Button className="bg-blue-600 hover:bg-blue-500 text-white font-black px-10 h-14 rounded-2xl w-full">{t("client.src.initiate_checkpoint")}</Button>
            </DialogFooter>
          </div>
        </DialogContent>
      </Dialog>
    </div>;
}