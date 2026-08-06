"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { format, startOfMonth, endOfMonth, startOfWeek, endOfWeek, addDays, addMonths, subMonths, isSameMonth, isSameDay, parseISO } from "date-fns";
import { tr } from "date-fns/locale";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Clock, CheckCircle, XCircle, AlertCircle, MapPin, Users, ChevronLeft, ChevronRight, Plus, CalendarDays, Eye, Edit, Trash2, Search, CalendarClock, Activity, FileBarChart, Sparkles, Target, Zap } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { m } from "framer-motion";
import { cn } from "@/lib/utils";
interface CalendarEvent {
  id: string;
  title: string;
  description?: string;
  date: string;
  startTime: string;
  endTime: string;
  type: "appointment" | "viewing" | "meeting" | "deadline" | "reminder";
  status: "scheduled" | "completed" | "cancelled" | "rescheduled";
  priority: "low" | "medium" | "high" | "urgent";
  location?: string;
  attendees?: string[];
  propertyId?: string;
  clientId?: string;
  notes?: string;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
}
interface Property {
  id: string;
  title: string;
  address: string;
  price: number;
  status: string;
}
interface Client {
  id: string;
  name: string;
  email: string;
  phone: string;
  avatar?: string;
}
export default function Calendar() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const [currentDate, setCurrentDate] = useState(new Date());
  const [selectedDate, setSelectedDate] = useState<Date>(new Date());
  const [events, setEvents] = useState<CalendarEvent[]>([]);
  const [properties, setProperties] = useState<Property[]>([]);
  const [clients, setClients] = useState<Client[]>([]);
  const [showEventDialog, setShowEventDialog] = useState(false);
  const [viewMode, setViewMode] = useState<"month" | "week" | "day">("month");
  const [filterType, setFilterType] = useState<string>("all");
  const [searchTerm, setSearchTerm] = useState("");

  // Mock data - replace with actual API calls
  useEffect(() => {
    const mockEvents: CalendarEvent[] = [{
      id: "1",
      title: t("client.src.property_viewing_luxury_penthouse"),
      description: t("client.src.viewing_with_highnetworth_individual"),
      date: format(new Date(), "yyyy-MM-dd"),
      startTime: "14:00",
      endTime: "15:00",
      type: "viewing",
      status: "scheduled",
      priority: "urgent",
      location: "350 Fifth Ave, Manhattan",
      attendees: ["vip.client@private.com", "info@reservatior.com"],
      propertyId: "prop1",
      clientId: "client1",
      notes: "Client requires highest level of privacy and security.",
      createdBy: user?.id || "",
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    }, {
      id: "2",
      title: t("client.src.strategic_asset_review"),
      description: t("client.src.quarterly_portfolio_optimization_and"),
      date: format(new Date(), "yyyy-MM-dd"),
      startTime: "16:30",
      endTime: "17:30",
      type: "meeting",
      status: "scheduled",
      priority: "high",
      location: "Executive Boardroom",
      attendees: ["board@reservatior.com"],
      notes: "Prepare latest market metrics for review.",
      createdBy: user?.id || "",
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    }, {
      id: "3",
      title: t("client.src.contract_deadline_plaza_suites"),
      description: t("client.src.deadline_for_the_primary"),
      date: format(addDays(new Date(), 2), "yyyy-MM-dd"),
      startTime: "17:00",
      endTime: "18:00",
      type: "deadline",
      status: "scheduled",
      priority: "urgent",
      location: "Legal Chambers",
      attendees: ["counsel@firm.com"],
      propertyId: "prop2",
      clientId: "client2",
      notes: "Ensure all riders are executed.",
      createdBy: user?.id || "",
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    }];
    const mockProperties: Property[] = [{
      id: "prop1",
      title: t("client.src.the_grand_tower_unit"),
      address: "350 Fifth Avenue, NY",
      price: 1500000,
      status: "active"
    }, {
      id: "prop2",
      title: t("client.src.plaza_office_hub"),
      address: "200 Fifth Ave, NY",
      price: 2500000,
      status: "pending"
    }];
    const mockClients: Client[] = [{
      id: "client1",
      name: "David Miller",
      email: "david.miller@example.com",
      phone: "+1-555-0301",
      avatar: ""
    }];
    setEvents(mockEvents);
    setProperties(mockProperties);
    setClients(mockClients);
  }, [user]);
  const getEventTypeColor = (type: string) => {
    switch (type) {
      case "appointment":
        return "bg-brand/10 text-brand border-blue-500/20";
      case "viewing":
        return "bg-success/10 text-success border-success/20";
      case "meeting":
        return "bg-brand/10 text-brand border-brand/20";
      case "deadline":
        return "bg-rose-500/10 text-rose-400 border-rose-500/20";
      case "reminder":
        return "bg-amber-500/10 text-amber-400 border-amber-500/20";
      default:
        return "bg-muted text-muted-foreground border-slate-500/20";
    }
  };
  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case "urgent":
        return "bg-rose-500 shadow-[0_0_10px_rgba(244,63,94,0.5)]";
      case "high":
        return "bg-amber-500";
      case "medium":
        return "bg-brand/100";
      case "low":
        return "bg-success";
      default:
        return "bg-muted0";
    }
  };
  const renderCalendarDays = () => {
    const monthStart = startOfMonth(currentDate);
    const monthEnd = endOfMonth(currentDate);
    const startDate = startOfWeek(monthStart, {
      weekStartsOn: 1
    });
    const endDate = endOfWeek(monthEnd, {
      weekStartsOn: 1
    });
    const days = [];
    let currentDay = startDate;
    while (currentDay <= endDate) {
      const dayEvents = events.filter(event => isSameDay(parseISO(event.date), currentDay));
      const isTodayCurrent = isSameDay(currentDay, new Date());
      const isSelected = selectedDate && isSameDay(currentDay, selectedDate);
      days.push(<div key={currentDay.toString()} className={cn("min-h-[110px] border border-border p-2 cursor-pointer transition-all duration-300 relative group", !isSameMonth(currentDay, currentDate) ? "bg-card/30 opacity-40" : "bg-background/50 hover:bg-muted/50", isSelected && "bg-blue-600/5 border-blue-600/50 scale-[1.02] z-10")} onClick={() => setSelectedDate(currentDay)}>
          {isTodayCurrent && <div className="absolute top-0 right-0 w-1.5 h-1.5 bg-brand/100 rounded-full m-2 shadow-[0_0_8px_rgba(59,130,246,0.8)]" />}
          
          <div className="flex justify-between items-start mb-1.5">
            <span className={cn("text-xs font-bold tracking-tighter", !isSameMonth(currentDay, currentDate) ? "text-muted-foreground" : isTodayCurrent ? "text-brand" : "text-muted-foreground")}>
              {format(currentDay, "d")}
            </span>
          </div>

          <div className="space-y-1">
            {dayEvents.slice(0, 3).map((event, idx) => <div key={idx} className={cn("text-[10px] px-1.5 py-0.5 rounded-md truncate border", getEventTypeColor(event.type))}>
                {event.startTime} {event.title}
              </div>)}
            {dayEvents.length > 3 && <div className="text-[9px] text-muted-foreground font-bold mt-1 ml-1">+{dayEvents.length - 3}{t("client.src.more")}</div>}
          </div>
        </div>);
      currentDay = addDays(currentDay, 1);
    }
    return days;
  };
  const todayEvents = events.filter(e => isSameDay(parseISO(e.date), new Date()));
  const nextEvents = events.filter(e => new Date(e.date) > new Date()).sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime());
  return <div className="p-8 space-y-8 bg-[#0a0b0d] min-h-full text-foreground selection:bg-brand/30">
      {/* Header with Glassmorphism */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 relative">
        <div className="space-y-1">
          <h1 className="text-4xl font-bold tracking-tight text-white flex items-center gap-3">
             <div className="p-2.5 bg-blue-600/10 rounded-2xl border border-blue-600/20 shadow-lg shadow-blue-600/10">
               <CalendarClock className="w-8 h-8 text-brand" />
             </div>{t("client.src.todays_agenda")}</h1>
          <p className="text-muted-foreground font-medium ml-1">{t("client.src.orchestrating_highvalue_property_management")}</p>
        </div>
        
        <div className="flex items-center gap-3 bg-background/80 backdrop-blur-xl p-1.5 rounded-2xl border border-border shadow-2xl">
          <Button variant="ghost" size="icon" aria-label={t("common.previous")} className="h-9 w-9 text-muted-foreground hover:text-white hover:bg-muted rounded-xl transition-all" onClick={() => setCurrentDate(subMonths(currentDate, 1))}>
            <ChevronLeft className="w-4 h-4" />
          </Button>
          <Button variant="ghost" className="h-9 px-4 text-sm font-bold text-muted-foreground hover:text-white hover:bg-muted rounded-xl" onClick={() => {
          setCurrentDate(new Date());
          setSelectedDate(new Date());
        }}>{t("client.src.present_day")}</Button>
          <Button variant="ghost" size="icon" aria-label={t("common.next")} className="h-9 w-9 text-muted-foreground hover:text-white hover:bg-muted rounded-xl transition-all" onClick={() => setCurrentDate(addMonths(currentDate, 1))}>
            <ChevronRight className="w-4 h-4" />
          </Button>
          <div className="w-px h-6 bg-muted/50 mx-1" />
          <Button onClick={() => setShowEventDialog(true)} className="bg-blue-600 hover:bg-brand/100 text-white font-bold h-9 px-5 rounded-xl shadow-lg shadow-blue-600/20 transition-all active:scale-95">
            <Plus className="w-4 h-4 mr-2" />{t("client.src.new_initiative")}</Button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
        {/* Left Surface: Today's Vertical Timeline & Intel */}
        <div className="lg:col-span-4 space-y-8">
          <Card className="bg-background/60 border-border backdrop-blur-xl overflow-hidden rounded-4xl shadow-2xl">
            <CardHeader className="pb-2 border-b border-white/5">
              <div className="flex items-center justify-between">
                <CardTitle className="text-lg font-bold text-white tracking-tight flex items-center gap-2">
                  <Activity className="w-4 h-4 text-success" />{t("client.src.live_agenda")}</CardTitle>
                <div className="flex gap-1">
                   <Badge variant="outline" className="bg-success/10 text-success border-success/20 text-[10px] font-bold">{t("common.active")}</Badge>
                </div>
              </div>
            </CardHeader>
            <CardContent className="pt-6">
              <div className="space-y-6 relative ml-2">
                <div className="absolute left-1.5 top-2 bottom-2 w-px bg-muted/50 group-hover:bg-brand/30 transition-colors" />
                
                {todayEvents.length > 0 ? todayEvents.map((event, idx) => <m.div key={event.id} initial={{
                opacity: 0,
                x: -10
              }} animate={{
                opacity: 1,
                x: 0
              }} transition={{
                delay: idx * 0.1
              }} className="relative pl-8 group">
                      <div className={cn("absolute left-0 top-1.5 w-3 h-3 rounded-full border-2 border-[#14151a] z-10", getPriorityColor(event.priority))} />
                      
                      <div className="bg-card/40 p-4 rounded-2xl border border-white/5 hover:border-border/50 hover:bg-muted/50 transition-all duration-300">
                        <div className="flex justify-between items-start mb-2">
                          <span className="text-[10px] font-bold tracking-widest text-muted-foreground group-hover:text-brand transition-colors">
                            {event.startTime} — {event.endTime}
                          </span>
                          <Badge className={cn("text-[8px] font-black  h-4 px-1.5", getEventTypeColor(event.type))}>
                            {event.type}
                          </Badge>
                        </div>
                        <h4 className="text-sm font-bold text-white mb-1 group-hover:translate-x-1 transition-transform">{event.title}</h4>
                        <div className="flex items-center gap-2 text-xs text-muted-foreground">
                          <MapPin className="w-3 h-3" />
                          {event.location}
                        </div>
                      </div>
                    </m.div>) : <div className="py-12 text-center">
                    <div className="w-12 h-12 bg-muted/50 rounded-2xl flex items-center justify-center mx-auto mb-4 opacity-50">
                      <CalendarDays className="w-6 h-6 text-muted-foreground" />
                    </div>
                    <p className="text-muted-foreground text-sm font-medium italic">{t("client.src.no_initiatives_locked_for")}</p>
                  </div>}
              </div>
            </CardContent>
          </Card>

          {/* Performance Overview Snapshot */}
          <Card className="bg-gradient-to-br from-brand/10 to-info/5 border-border rounded-4xl p-6 shadow-2xl relative overflow-hidden backdrop-blur-xl">
            <div className="absolute top-0 right-0 w-32 h-32 bg-blue-600/10 rounded-full blur-3xl -mr-16 -mt-16" />
            <div className="relative z-10">
              <h3 className="text-lg font-bold text-white mb-4 flex items-center gap-2">
                <Zap className="w-4 h-4 text-amber-500" />{t("client.src.strategic_insight")}</h3>
              <div className="space-y-4">
                <div className="bg-muted/50 p-4 rounded-2xl border border-white/5">
                  <div className="text-[10px] font-bold text-brand tracking-widest mb-1">{t("client.src.weekly_momentum")}</div>
                  <div className="text-2xl font-bold text-white">+14.2%</div>
                  <p className="text-[10px] text-muted-foreground mt-1">{t("client.src.growth_in_property_viewings")}</p>
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div className="bg-muted/50 p-3 rounded-2xl border border-white/5">
                    <div className="text-[10px] text-muted-foreground tracking-widest">{t("client.src.active_deals")}</div>
                    <div className="text-lg font-bold text-white">8</div>
                  </div>
                  <div className="bg-muted/50 p-3 rounded-2xl border border-white/5">
                    <div className="text-[10px] text-muted-foreground tracking-widest">{t("client.src.efficiency")}</div>
                    <div className="text-lg font-bold text-success">92%</div>
                  </div>
                </div>
              </div>
            </div>
          </Card>
        </div>

        {/* Right Surface: Global Calendar Surface */}
        <div className="lg:col-span-8 flex flex-col gap-8">
          <Card className="bg-background/60 border-border backdrop-blur-xl rounded-4xl shadow-2xl overflow-hidden flex-1">
            <CardHeader className="pb-4 border-b border-white/5 flex flex-row items-center justify-between">
              <CardTitle className="text-2xl font-bold text-white tracking-tighter flex items-center gap-3">
                {format(currentDate, "MMMM yyyy", {
                locale: tr
              })}
                <span className="text-muted-foreground font-normal">|</span>
                <span className="text-muted-foreground text-sm font-medium tracking-normal">{t("client.src.global_view")}</span>
              </CardTitle>
              <div className="flex bg-muted/50 p-1 rounded-xl border border-white/5 shadow-inner">
                <Button variant="ghost" className={cn("h-8 px-4 text-xs font-bold rounded-lg transition-all", viewMode === "month" ? "bg-blue-600 text-white shadow-lg" : "text-muted-foreground hover:text-white")} onClick={() => setViewMode("month")}>{t("client.src.month")}</Button>
                <Button variant="ghost" className={cn("h-8 px-4 text-xs font-bold rounded-lg transition-all", viewMode === "week" ? "bg-blue-600 text-white shadow-lg" : "text-muted-foreground hover:text-white")} onClick={() => setViewMode("week")}>{t("client.src.week")}</Button>
                <Button variant="ghost" className={cn("h-8 px-4 text-xs font-bold rounded-lg transition-all", viewMode === "day" ? "bg-blue-600 text-white shadow-lg" : "text-muted-foreground hover:text-white")} onClick={() => setViewMode("day")}>{t("client.src.day")}</Button>
              </div>
            </CardHeader>
            <CardContent className="p-0">
              <div className="grid grid-cols-7 border-b border-border">
                {["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"].map(day => <div key={day} className="py-4 text-center text-[10px] font-black text-muted-foreground tracking-[0.2em] border-r border-border">
                    {day}
                  </div>)}
              </div>
              <div className="grid grid-cols-7 border-l border-border">
                {renderCalendarDays()}
              </div>
            </CardContent>
          </Card>

          {/* Quick Operations Intel */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 pb-8">
            <Card className="bg-background/60 border-border rounded-4xl p-6 backdrop-blur-xl">
              <h4 className="text-sm font-bold text-white mb-4 tracking-widest opacity-70 flex items-center gap-2">
                <Target className="w-4 h-4 text-brand" />{t("client.src.immediate_actions")}</h4>
              <div className="space-y-4">
                 <div className="flex items-center gap-3 p-3 bg-card/40 rounded-2xl border border-white/5 hover:bg-muted/50 transition-colors cursor-pointer group">
                   <div className="w-10 h-10 rounded-xl bg-warning/10 flex items-center justify-center border border-warning/20 group-hover:scale-110 transition-transform">
                      <AlertCircle className="w-5 h-5 text-orange-500" />
                   </div>
                   <div className="flex-1">
                     <p className="text-xs font-bold text-white">{t("client.src.review_lead_acquisition")}</p>
                     <p className="text-[10px] text-muted-foreground">{t("client.src.3_new_leads_requiring")}</p>
                   </div>
                   <ChevronRight className="w-4 h-4 text-muted-foreground" />
                 </div>
                 <div className="flex items-center gap-3 p-3 bg-card/40 rounded-2xl border border-white/5 hover:bg-muted/50 transition-colors cursor-pointer group">
                   <div className="w-10 h-10 rounded-xl bg-brand/10 flex items-center justify-center border border-blue-500/20 group-hover:scale-110 transition-transform">
                      <FileBarChart className="w-5 h-5 text-brand" />
                   </div>
                   <div className="flex-1">
                     <p className="text-xs font-bold text-white">{t("client.src.generate_listing_report")}</p>
                     <p className="text-[10px] text-muted-foreground">{t("client.src.quarterly_performance_for_tower")}</p>
                   </div>
                   <ChevronRight className="w-4 h-4 text-muted-foreground" />
                 </div>
              </div>
            </Card>

            <Card className="bg-background/60 border-border rounded-4xl p-6 backdrop-blur-xl">
              <h4 className="text-sm font-bold text-white mb-4 tracking-widest opacity-70 flex items-center gap-2">
                <Users className="w-4 h-4 text-brand" />{t("client.src.network_pulse")}</h4>
              <div className="flex flex-wrap gap-2">
                 {[1, 2, 3, 4, 5, 6].map(i => <Avatar key={i} className="w-10 h-10 border-2 border-slate-900 shadow-xl group cursor-pointer transition-all hover:scale-110">
                     <AvatarFallback className="bg-muted text-xs font-bold text-muted-foreground group-hover:text-brand">
                       U{i}
                     </AvatarFallback>
                   </Avatar>)}
                 <div className="w-10 h-10 rounded-full bg-blue-600/10 border-2 border-blue-600/30 flex items-center justify-center text-[10px] font-black text-brand cursor-pointer hover:bg-brand/20">
                   +12
                 </div>
              </div>
              <p className="text-[10px] text-muted-foreground mt-4 font-medium italic">{t("client.src.active_agents_and_clients")}</p>
            </Card>
          </div>
        </div>
      </div>

      {/* Shared Dialogs - Reusing and Styling */}
      <Dialog open={showEventDialog} onOpenChange={setShowEventDialog}>
        <DialogContent className="bg-background border-border text-white rounded-4xl max-w-2xl overflow-hidden p-0 shadow-[0_0_50px_rgba(0,0,0,0.5)]">
          <div className="p-8 space-y-6">
            <DialogHeader>
              <DialogTitle className="text-2xl font-bold flex items-center gap-2">
                <Sparkles className="w-6 h-6 text-brand" />{t("client.src.define_new_initiative")}</DialogTitle>
              <DialogDescription className="text-muted-foreground">{t("client.src.register_a_new_strategic")}</DialogDescription>
            </DialogHeader>
            
            <div className="grid gap-6">
              <div className="grid grid-cols-2 gap-6">
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.initiative_title")}</label>
                  <Input placeholder={t("client.src.eg_penthouse_showing")} className="bg-muted border-border focus:ring-blue-500/20 rounded-xl h-11" />
                </div>
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.event_classification")}</label>
                  <Select>
                    <SelectTrigger className="bg-muted border-border rounded-xl h-11">
                      <SelectValue placeholder={t("common.select_type")} />
                    </SelectTrigger>
                    <SelectContent className="bg-card border-border text-white">
                      <SelectItem value="appointment">{t("client.src.strategic_appointment")}</SelectItem>
                      <SelectItem value="viewing">{t("client.src.highvalue_viewing")}</SelectItem>
                      <SelectItem value="meeting">{t("client.src.board_interaction")}</SelectItem>
                      <SelectItem value="deadline">{t("client.src.critical_deadline")}</SelectItem>
                      <SelectItem value="reminder">{t("client.src.operational_reminder")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
              
              <div className="grid grid-cols-2 gap-6">
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.execution_date")}</label>
                  <Input type="date" className="bg-muted border-border rounded-xl h-11" />
                </div>
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.mission_priority")}</label>
                  <Select>
                    <SelectTrigger className="bg-muted border-border rounded-xl h-11 text-white">
                      <SelectValue placeholder={t("client.src.define_impact")} />
                    </SelectTrigger>
                    <SelectContent className="bg-card border-border text-white">
                      <SelectItem value="low">{t("client.src.low_impact")}</SelectItem>
                      <SelectItem value="medium">{t("client.src.standard_operational")}</SelectItem>
                      <SelectItem value="high">{t("client.src.mission_critical")}</SelectItem>
                      <SelectItem value="urgent">{t("client.src.immediate_intercession")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>

              <div className="grid grid-cols-2 gap-6">
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.commencement")}</label>
                  <Input type="time" className="bg-muted border-border rounded-xl h-11" />
                </div>
                <div className="space-y-2">
                  <label className="text-[10px] font-bold text-muted-foreground tracking-widest ml-1">{t("client.src.conclusion")}</label>
                  <Input type="time" className="bg-muted border-border rounded-xl h-11" />
                </div>
              </div>
            </div>
            
            <DialogFooter className="pt-4 mt-4 border-t border-white/5">
              <Button variant="ghost" className="text-muted-foreground hover:text-white" onClick={() => setShowEventDialog(false)}>{t("common.cancel")}</Button>
              <Button onClick={() => setShowEventDialog(false)} className="bg-blue-600 hover:bg-brand/100 px-8 rounded-xl h-11 font-bold">{t("client.src.deploy_initiative")}</Button>
            </DialogFooter>
          </div>
        </DialogContent>
      </Dialog>
    </div>;
}