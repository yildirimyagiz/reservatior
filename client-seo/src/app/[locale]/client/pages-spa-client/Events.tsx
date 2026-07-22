"use client";

import { t } from "i18next";
import { useState, useEffect } from "react";
import { format, addDays, addWeeks, isWithinInterval, startOfDay, endOfDay } from "date-fns";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { CalendarIcon, Clock, MapPin, Users, Video, Bell, Search, Plus, Eye, Edit, Trash2, Share2, MoreHorizontal, ChevronLeft, ChevronRight, CalendarDays, CheckCircle, AlertCircle, RefreshCw, Archive, Pause, Building, Zap, Activity, Cpu, Fingerprint, Layers, ArrowUpRight, Shield, Play, Terminal, Sparkles, XCircle, Database, Settings } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { m, AnimatePresence } from "framer-motion";
import { PageShell } from "./layout/PageShell";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
interface Event {
  id: string;
  title: string;
  description: string;
  type: "meeting" | "appointment" | "viewing" | "inspection" | "deadline" | "reminder" | "webinar" | "workshop" | "conference" | "training";
  category: "business" | "personal" | "property" | "legal" | "financial" | "marketing" | "maintenance" | "other";
  status: "scheduled" | "in_progress" | "completed" | "cancelled" | "postponed" | "no_show";
  priority: "low" | "medium" | "high" | "urgent";
  startDate: string;
  endDate: string;
  isAllDay: boolean;
  timezone: string;
  location?: {
    type: "physical" | "virtual" | "hybrid";
    address?: string;
    coordinates?: {
      lat: number;
      lng: number;
    };
    virtualUrl?: string;
    meetingId?: string;
    dialInInfo?: string;
  };
  organizer: {
    id: string;
    name: string;
    email: string;
    phone?: string;
    avatar?: string;
  };
  attendees: Array<{
    id: string;
    name: string;
    email: string;
    phone?: string;
    avatar?: string;
    role: "organizer" | "required" | "optional" | "resource";
    status: "pending" | "accepted" | "declined" | "tentative" | "no_show";
    responseAt?: string;
  }>;
  recurrence?: {
    type: "daily" | "weekly" | "monthly" | "yearly" | "custom";
    interval: number;
    endDate?: string;
    occurrences?: number;
    daysOfWeek?: number[];
    dayOfMonth?: number;
  };
  reminders: Array<{
    id: string;
    type: "email" | "push" | "sms" | "popup";
    minutesBefore: number;
    sent: boolean;
    sentAt?: string;
  }>;
  attachments: Array<{
    id: string;
    name: string;
    type: string;
    size: number;
    url: string;
  }>;
  notes?: string;
  tags: string[];
  propertyId?: string;
  clientId?: string;
  projectId?: string;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  isPublic: boolean;
  isRecurring: boolean;
  parentEventId?: string;
  metadata: Record<string, any>;
}
interface EventSeries {
  id: string;
  title: string;
  description: string;
  type: Event["type"];
  category: Event["category"];
  recurrence: Event["recurrence"];
  events: Event[];
  isActive: boolean;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
}
export default function Events() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const [events, setEvents] = useState<Event[]>([]);
  const [eventSeries, setEventSeries] = useState<EventSeries[]>([]);
  const [selectedEvent, setSelectedEvent] = useState<Event | null>(null);
  const [currentDate, setCurrentDate] = useState(new Date());
  const [viewMode, setViewMode] = useState<"day" | "week" | "month" | "list">("week");
  const [searchTerm, setSearchTerm] = useState("");
  const [filterType, setFilterType] = useState<string>("all");
  const [filterStatus, setFilterStatus] = useState<string>("all");
  const [filterCategory, setFilterCategory] = useState<string>("all");
  const [activeTab, setActiveTab] = useState("events");

  // Mock data - replace with actual API calls
  useEffect(() => {
    const mockEvents: Event[] = [{
      id: "event1",
      title: t("client.src.property_viewing_luxury_downtown"),
      description: t("client.src.show_luxury_apartment_to"),
      type: "viewing",
      category: "property",
      status: "scheduled",
      priority: "high",
      startDate: format(new Date(), "yyyy-MM-dd'T'14:00:00"),
      endDate: format(new Date(), "yyyy-MM-dd'T'15:00:00"),
      isAllDay: false,
      timezone: "Europe/Istanbul",
      location: {
        type: "physical",
        address: "123 Main St, Istanbul, Turkey",
        coordinates: {
          lat: 41.0082,
          lng: 28.9784
        }
      },
      organizer: {
        id: user?.id || "",
        name: user?.name || "Agent",
        email: user?.email || "agent@example.com",
        phone: "+90-555-123-4567"
      },
      attendees: [{
        id: "client1",
        name: "John Doe",
        email: "john@example.com",
        phone: "+90-555-987-6543",
        role: "required",
        status: "accepted",
        responseAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24), "yyyy-MM-dd'T'10:00:00")
      }, {
        id: user?.id || "",
        name: user?.name || "Agent",
        email: user?.email || "agent@example.com",
        role: "organizer",
        status: "accepted"
      }],
      reminders: [{
        id: "rem1",
        type: "email",
        minutesBefore: 60,
        sent: false
      }, {
        id: "rem2",
        type: "push",
        minutesBefore: 15,
        sent: false
      }],
      attachments: [],
      notes: "Client is very interested in the penthouse view. Prepare keys and property information.",
      tags: ["viewing", "downtown", "luxury", "penthouse"],
      propertyId: "prop123",
      clientId: "client1",
      createdBy: user?.id || "",
      createdAt: format(new Date(Date.now() - 1000 * 60 * 60 * 48), "yyyy-MM-dd'T'10:00:00"),
      updatedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24), "yyyy-MM-dd'T'10:00:00"),
      isPublic: false,
      isRecurring: false,
      metadata: {
        propertyType: "apartment",
        priceRange: "750000-850000",
        specialRequirements: ["penthouse view", "parking included"]
      }
    }, {
      id: "event2",
      title: t("client.src.team_meeting_weekly_standup"),
      description: t("client.src.weekly_team_sync_and"),
      type: "meeting",
      category: "business",
      status: "scheduled",
      priority: "medium",
      startDate: format(addDays(new Date(), 1), "yyyy-MM-dd'T'10:00:00"),
      endDate: format(addDays(new Date(), 1), "yyyy-MM-dd'T'11:00:00"),
      isAllDay: false,
      timezone: "Europe/Istanbul",
      location: {
        type: "virtual",
        virtualUrl: "https://zoom.us/j/123456789",
        meetingId: "123456789",
        dialInInfo: "+1-555-123-4567"
      },
      organizer: {
        id: user?.id || "",
        name: user?.name || "Team Lead",
        email: user?.email || "lead@example.com"
      },
      attendees: [{
        id: "member1",
        name: "Alice Johnson",
        email: "alice@example.com",
        role: "required",
        status: "accepted"
      }, {
        id: "member2",
        name: "Bob Smith",
        email: "bob@example.com",
        role: "required",
        status: "tentative"
      }, {
        id: user?.id || "",
        name: user?.name || "You",
        email: user?.email || "you@example.com",
        role: "required",
        status: "accepted"
      }],
      recurrence: {
        type: "weekly",
        interval: 1,
        daysOfWeek: [1] // Monday
      },
      reminders: [{
        id: "rem1",
        type: "email",
        minutesBefore: 30,
        sent: false
      }],
      attachments: [{
        id: "att1",
        name: "weekly-agenda.pdf",
        type: "application/pdf",
        size: 524288,
        url: "/documents/weekly-agenda.pdf"
      }],
      notes: "Discuss weekly goals, challenges, and upcoming property listings.",
      tags: ["team", "weekly", "standup", "planning"],
      createdBy: user?.id || "",
      createdAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 7), "yyyy-MM-dd'T'09:00:00"),
      updatedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24), "yyyy-MM-dd'T'09:00:00"),
      isPublic: true,
      isRecurring: true,
      metadata: {
        meetingType: "standup",
        expectedDuration: 60,
        recurringPattern: "every-monday"
      }
    }, {
      id: "event3",
      title: t("client.src.property_inspection_commercial_building"),
      description: t("client.src.prepurchase_inspection_for_commercial"),
      type: "inspection",
      category: "property",
      status: "scheduled",
      priority: "high",
      startDate: format(addDays(new Date(), 2), "yyyy-MM-dd'T'09:00:00"),
      endDate: format(addDays(new Date(), 2), "yyyy-MM-dd'T'12:00:00"),
      isAllDay: false,
      timezone: "Europe/Istanbul",
      location: {
        type: "physical",
        address: "456 Business Ave, Istanbul, Turkey",
        coordinates: {
          lat: 41.0151,
          lng: 28.9795
        }
      },
      organizer: {
        id: "inspector1",
        name: "Mike Inspector",
        email: "mike@inspection.com",
        phone: "+90-555-456-7890"
      },
      attendees: [{
        id: "client2",
        name: "Sarah Johnson",
        email: "sarah@example.com",
        role: "required",
        status: "accepted"
      }, {
        id: user?.id || "",
        name: user?.name || "Agent",
        email: user?.email || "agent@example.com",
        role: "optional",
        status: "accepted"
      }, {
        id: "inspector1",
        name: "Mike Inspector",
        email: "mike@inspection.com",
        role: "resource",
        status: "accepted"
      }],
      reminders: [{
        id: "rem1",
        type: "email",
        minutesBefore: 120,
        sent: false
      }, {
        id: "rem2",
        type: "sms",
        minutesBefore: 30,
        sent: false
      }],
      attachments: [{
        id: "att1",
        name: "inspection-checklist.pdf",
        type: "application/pdf",
        size: 1048576,
        url: "/documents/inspection-checklist.pdf"
      }],
      notes: "Client needs detailed structural and systems inspection. Focus on HVAC and electrical systems.",
      tags: ["inspection", "commercial", "structural", "detailed"],
      propertyId: "prop456",
      clientId: "client2",
      createdBy: user?.id || "",
      createdAt: format(new Date(Date.now() - 1000 * 60 * 60 * 48), "yyyy-MM-dd'T'14:00:00"),
      updatedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24), "yyyy-MM-dd'T'14:00:00"),
      isPublic: false,
      isRecurring: false,
      metadata: {
        inspectionType: "pre-purchase",
        propertyType: "commercial",
        buildingSize: "5000 sq ft",
        yearBuilt: 2010
      }
    }];
    const mockEventSeries: EventSeries[] = [{
      id: "series1",
      title: t("client.src.weekly_team_meetings"),
      description: t("client.src.recurring_weekly_team_sync"),
      type: "meeting",
      category: "business",
      recurrence: {
        type: "weekly",
        interval: 1,
        daysOfWeek: [1]
      },
      events: mockEvents.filter(e => e.id === "event2"),
      isActive: true,
      createdBy: user?.id || "",
      createdAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24 * 30), "yyyy-MM-dd'T'09:00:00"),
      updatedAt: format(new Date(Date.now() - 1000 * 60 * 60 * 24), "yyyy-MM-dd'T'09:00:00")
    }];
    setEvents(mockEvents);
    setEventSeries(mockEventSeries);
  }, [user]);
  const getEventIcon = (type: string) => {
    switch (type) {
      case "meeting":
        return <Users className="w-5 h-5" />;
      case "appointment":
        return <CalendarDays className="w-5 h-5" />;
      case "viewing":
        return <Building className="w-5 h-5" />;
      case "inspection":
        return <CheckCircle className="w-5 h-5" />;
      case "deadline":
        return <AlertCircle className="w-5 h-5" />;
      case "reminder":
        return <Bell className="w-5 h-5" />;
      case "webinar":
        return <Video className="w-5 h-5" />;
      case "workshop":
        return <Users className="w-5 h-5" />;
      case "conference":
        return <Users className="w-5 h-5" />;
      case "training":
        return <Users className="w-5 h-5" />;
      default:
        return <CalendarIcon className="w-5 h-5" />;
    }
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case "scheduled":
        return "bg-blue-500/10 text-blue-400 border-blue-500/20 shadow-[0_0_15px_rgba(59,130,246,0.1)]";
      case "in_progress":
        return "bg-orange-500/10 text-orange-400 border-orange-500/20 animate-pulse";
      case "completed":
        return "bg-emerald-500/10 text-emerald-400 border-emerald-500/20";
      case "cancelled":
        return "bg-red-500/10 text-red-500 border-red-500/20";
      case "postponed":
        return "bg-slate-500/10 text-slate-400 border-white/5";
      case "no_show":
        return "bg-slate-800/50 text-slate-600 border-white/5";
      default:
        return "bg-slate-500/10 text-slate-500 border-white/5";
    }
  };
  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case "urgent":
        return "bg-red-500 shadow-[0_0_10px_#ef4444]";
      case "high":
        return "bg-orange-500 shadow-[0_0_10px_#f97316]";
      case "medium":
        return "bg-blue-500 shadow-[0_0_10px_#3b82f6]";
      case "low":
        return "bg-emerald-500 shadow-[0_0_10px_#10b981]";
      default:
        return "bg-slate-700";
    }
  };
  const getCategoryColor = (category: string) => {
    switch (category) {
      case "business":
        return "bg-purple-500/10 text-purple-400 border-purple-500/20";
      case "property":
        return "bg-emerald-500/10 text-emerald-400 border-emerald-500/20";
      case "legal":
        return "bg-red-500/10 text-red-400 border-red-500/20";
      case "financial":
        return "bg-orange-500/10 text-orange-400 border-orange-500/20";
      default:
        return "bg-slate-500/10 text-slate-400 border-white/5";
    }
  };
  const getLocationIcon = (location?: Event["location"]) => {
    if (!location) return null;
    switch (location.type) {
      case "physical":
        return <MapPin className="w-4 h-4" />;
      case "virtual":
        return <Video className="w-4 h-4" />;
      case "hybrid":
        return <Users className="w-4 h-4" />;
      default:
        return <MapPin className="w-4 h-4" />;
    }
  };
  const formatEventTime = (startDate: string, endDate: string, isAllDay: boolean) => {
    if (isAllDay) return "All day";
    const start = new Date(startDate);
    const end = new Date(endDate);
    return `${format(start, "h:mm a")} - ${format(end, "h:mm a")}`;
  };
  const filteredEvents = events.filter(event => {
    const matchesType = filterType === "all" || event.type === filterType;
    const matchesStatus = filterStatus === "all" || event.status === filterStatus;
    const matchesCategory = filterCategory === "all" || event.category === filterCategory;
    const matchesSearch = event.title.toLowerCase().includes(searchTerm.toLowerCase()) || event.description.toLowerCase().includes(searchTerm.toLowerCase()) || event.tags.some(tag => tag.toLowerCase().includes(searchTerm.toLowerCase()));
    return matchesType && matchesStatus && matchesCategory && matchesSearch;
  });
  const getEventsForDate = (date: Date) => {
    return filteredEvents.filter(event => {
      const eventStart = startOfDay(new Date(event.startDate));
      const eventEnd = endOfDay(new Date(event.endDate));
      const current = startOfDay(date);
      return isWithinInterval(current, {
        start: eventStart,
        end: eventEnd
      });
    });
  };
  const getUpcomingEvents = (days: number = 7) => {
    const now = new Date();
    const future = addDays(now, days);
    return filteredEvents.filter(event => new Date(event.startDate) >= now && new Date(event.startDate) <= future).sort((a, b) => new Date(a.startDate).getTime() - new Date(b.startDate).getTime());
  };
  const getTodayEvents = () => {
    return getEventsForDate(new Date());
  };
  const getWeekEvents = () => {
    const startOfWeek = new Date(currentDate);
    startOfWeek.setDate(startOfWeek.getDate() - startOfWeek.getDay());
    const endOfWeek = addDays(startOfWeek, 6);
    return filteredEvents.filter(event => {
      const eventDate = new Date(event.startDate);
      return eventDate >= startOfWeek && eventDate <= endOfWeek;
    });
  };
  const renderWeekView = () => {
    const startOfWeek = new Date(currentDate);
    startOfWeek.setDate(startOfWeek.getDate() - startOfWeek.getDay());
    const days = [];
    for (let i = 0; i < 7; i++) {
      const currentDay = addDays(startOfWeek, i);
      const dayEvents = getEventsForDate(currentDay);
      const isToday = startOfDay(currentDay).getTime() === startOfDay(new Date()).getTime();
      days.push(<div key={i} className={cn("relative rounded-[32px] p-6 min-h-[450px] border border-white/5 transition-all", isToday ? "bg-blue-600/5 shadow-[inset_0_0_40px_rgba(37,99,235,0.1)] border-blue-500/20" : "bg-black/20")}>
          {isToday && <div className="absolute top-0 left-1/2 -translate-x-1/2 -translate-y-1/2 px-4 py-1 bg-blue-600 text-[8px] font-black italic tracking-[0.2em] rounded-full shadow-[0_0_20px_rgba(37,99,235,0.5)]">
               {t("liveNode")}
            </div>}
          
          <div className="flex flex-col items-center mb-8 border-b border-white/5 pb-4">
            <h3 className={cn("text-[10px] font-black  italic tracking-widest leading-none mb-2", isToday ? "text-blue-400" : "text-slate-500")}>{format(currentDay, "EEEE")}</h3>
            <span className="text-3xl font-black text-white italic tracking-tighter tabular-nums leading-none">{format(currentDay, "dd")}</span>
            <span className="text-[9px] font-bold text-slate-700 italic mt-1">{format(currentDay, "MMM")}</span>
          </div>

          <div className="space-y-4">
            {dayEvents.map(event => <m.div key={event.id} initial={{
            opacity: 0,
            scale: 0.95
          }} animate={{
            opacity: 1,
            scale: 1
          }} whileHover={{
            scale: 1.05
          }} className={cn("relative p-4 rounded-2xl bg-[#1a1b1e]/60 border border-white/5 shadow-xl cursor-pointer group hover:border-blue-500/30 transition-all", event.priority === 'urgent' && "border-red-500/20")} onClick={() => setSelectedEvent(event)}>
                <div className="absolute top-2 right-2 flex gap-1">
                   {event.priority === 'urgent' && <div className="h-1.5 w-1.5 bg-red-500 rounded-full animate-pulse" />}
                   <div className={cn("h-1.5 w-1.5 rounded-full", getPriorityColor(event.priority))} />
                </div>
                
                <h4 className="text-[10px] font-black text-white italic tracking-tight line-clamp-1 mb-2 leading-none group-hover:text-blue-400 transition-colors">{event.title}</h4>
                
                <div className="flex items-center justify-between text-[8px] font-black italic tracking-widest text-slate-600">
                   <div className="flex items-center gap-1">
                      <Clock className="w-2.5 h-2.5" />
                      <span>{format(new Date(event.startDate), "HH:mm")}</span>
                   </div>
                   <Badge className="bg-white/5 text-slate-500 border-none p-0 scale-75 origin-right">{event.type}</Badge>
                </div>
              </m.div>)}
            {dayEvents.length === 0 && <div className="flex flex-col items-center justify-center py-10 opacity-10">
                 <Cpu className="w-8 h-8 text-slate-500 mb-2" />
                 <p className="text-[8px] font-black text-slate-500 tracking-widest">{t("client.src.stdby")}</p>
              </div>}
          </div>
        </div>);
    }
    return days;
  };
  const renderListView = () => {
    return <div className="space-y-6">
        {filteredEvents.sort((a, b) => new Date(a.startDate).getTime() - new Date(b.startDate).getTime()).map(event => <m.div key={event.id} initial={{
        opacity: 0,
        x: -20
      }} animate={{
        opacity: 1,
        x: 0
      }} whileHover={{
        scale: 1.01,
        x: 5
      }} onClick={() => setSelectedEvent(event)} className="group relative p-8 rounded-[32px] bg-[#1a1b1e]/40 border border-white/5 border-l border-t hover:bg-white/5 transition-all shadow-2xl cursor-pointer overflow-hidden">
              <div className="absolute top-0 right-0 p-8 opacity-0 group-hover:opacity-10 transition-opacity pointer-events-none text-blue-500">
                 {getEventIcon(event.type)}
              </div>
              
              <div className="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-8">
                 <div className="flex items-center gap-6">
                    <div className={cn("h-16 w-16 rounded-2xl flex items-center justify-center border shadow-inner", event.status === 'scheduled' ? 'bg-blue-500/10 border-blue-500/20 text-blue-400' : event.status === 'completed' ? 'bg-emerald-500/10 border-emerald-500/20 text-emerald-400' : 'bg-slate-500/10 border-white/5 text-slate-500')}>
                       {getEventIcon(event.type)}
                    </div>
                    
                    <div className="space-y-1">
                       <div className="flex items-center gap-3">
                          <h3 className="text-xl font-black text-white italic tracking-tighter leading-none">{event.title}</h3>
                          <Badge className={cn("text-[8px] font-black italic tracking-widest px-2 py-0.5 rounded-full border", event.priority === 'urgent' ? 'bg-red-500/10 border-red-500/20 text-red-500' : event.priority === 'high' ? 'bg-orange-500/10 border-orange-500/20 text-orange-500' : 'bg-slate-500/10 border-white/5 text-slate-500')}>
                            {event.priority}
                          </Badge>
                       </div>
                       <p className="text-[10px] font-bold text-slate-500 italic tracking-tight">{event.description}</p>
                    </div>
                 </div>
                 
                 <div className="flex flex-wrap items-center gap-8">
                    <div className="space-y-1 text-right md:text-left">
                       <p className="text-[8px] font-black text-slate-600 tracking-widest italic group-hover:text-blue-500/50 transition-colors">{t("client.src.temporal_alignment")}</p>
                       <p className="text-sm font-black text-white italic leading-none">{formatEventTime(event.startDate, event.endDate, event.isAllDay)}</p>
                    </div>
                    
                    <div className="space-y-1 text-right md:text-left">
                       <p className="text-[8px] font-black text-slate-600 tracking-widest italic">{t("client.src.geospatial_node")}</p>
                       <div className="flex items-center gap-2 text-sm font-black text-slate-400 italic leading-none">
                          <MapPin className="w-3 h-3" />
                          <span>{event.location?.address || 'VIRTUAL NODE'}</span>
                       </div>
                    </div>
                    
                    <div className="flex items-center gap-2">
                       <div className="flex -space-x-3">
                          {event.attendees.slice(0, 3).map((a, i) => <Avatar key={i} className="h-8 w-8 border-2 border-[#1a1b1e] rounded-xl shadow-lg ring-1 ring-white/5">
                               <AvatarFallback className="bg-slate-800 text-[10px] font-black text-white">{a.name.charAt(0)}</AvatarFallback>
                            </Avatar>)}
                          {event.attendees.length > 3 && <div className="h-8 w-8 rounded-xl bg-black/40 border-2 border-[#1a1b1e] flex items-center justify-center text-[10px] font-black text-slate-500 shadow-lg ring-1 ring-white/5">
                               +{event.attendees.length - 3}
                            </div>}
                       </div>
                    </div>

                    <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition-all scale-95 group-hover:scale-100">
                       <Button variant="ghost" className="h-10 w-10 p-0 rounded-xl bg-white/5 hover:bg-white/10 border border-white/5 text-slate-400 hover:text-white transition-all">
                          <Edit className="w-4 h-4" />
                       </Button>
                       <Button variant="ghost" className="h-10 w-10 p-0 rounded-xl bg-white/5 hover:bg-red-500/10 border border-white/5 text-slate-400 hover:text-red-400 transition-all">
                          <Trash2 className="w-4 h-4" />
                       </Button>
                    </div>
                 </div>
              </div>
            </m.div>)}
        {filteredEvents.length === 0 && <div className="py-20 text-center space-y-4 rounded-[40px] border border-dashed border-white/10 bg-black/20">
             <Layers className="w-12 h-12 text-slate-800 mx-auto opacity-20" />
             <p className="text-[10px] font-black text-slate-600 tracking-widest italic">{t("noEvents")}</p>
          </div>}
      </div>;
  };
  return <PageShell title={t("client.src.temporal_operations")}>
      <>
        <div className="space-y-12">
          {/* Tactical Header HUD */}
          <header className="relative py-12 px-10 rounded-[40px] bg-[#1a1b1e]/40 border border-white/5 border-l border-t overflow-hidden shadow-3xl">
           <div className="absolute top-0 right-0 p-40 opacity-5 pointer-events-none text-blue-600">
              <CalendarDays className="w-96 h-96" />
           </div>
           <div className="absolute -top-24 -left-24 w-96 h-96 bg-blue-600/10 blur-[120px] rounded-full pointer-events-none"></div>
           
           <div className="relative z-10 flex flex-col md:flex-row items-center justify-between gap-10">
              <div className="flex items-center gap-8">
                 <div className="relative group">
                    <div className="absolute inset-0 bg-blue-600/20 blur-2xl group-hover:bg-blue-600/40 transition-all rounded-full animate-pulse-slow"></div>
                    <div className="relative p-6 rounded-3xl bg-gradient-to-br from-blue-500/20 to-purple-500/20 border border-blue-500/30 backdrop-blur-xl shadow-2xl">
                       <CalendarIcon className="w-10 h-10 text-blue-400" />
                    </div>
                 </div>
                 <div className="space-y-2">
                    <div className="flex items-center gap-3">
                       <h1 className="text-5xl font-black text-white italic tracking-tighter leading-none">{t("eventsTitle")}</h1>
                       <Badge className="bg-blue-500/10 text-blue-400 border border-blue-500/20 font-black italic tracking-widest text-[10px] px-3 py-1 rounded-full">
                        {t("eventsSynchronized")}
                       </Badge>
                    </div>
                    <p className="text-lg font-black text-slate-500 italic tracking-widest leading-none mt-2">{t("eventsSubtitle")}</p>
                 </div>
              </div>
              
              <div className="flex gap-4">
                 <Button className="h-16 px-10 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic text-xs tracking-widest shadow-xl transition-all hover:scale-105 active:scale-95">
                    <Plus className="w-4 h-4 mr-3" />
                    {t("initialize")}
                 </Button>
                 <Button variant="outline" className="h-16 w-16 rounded-2xl border-white/5 bg-white/5 text-slate-400 hover:text-white transition-all backdrop-blur-xl">
                    <RefreshCw className="w-6 h-6" />
                 </Button>
              </div>
           </div>
        </header>

        {/* Real-time Temporal Metrics */}
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
           {[{
            label: t("today"),
            value: getTodayEvents().length,
            icon: CalendarDays,
            color: "text-blue-400",
            bg: "bg-blue-500/10"
          }, {
            label: t("eventsWeekly"),
            value: getWeekEvents().length,
            icon: Activity,
            color: "text-emerald-400",
            bg: "bg-emerald-500/10"
          }, {
            label: t("upcoming"),
            value: getUpcomingEvents(7).length,
            icon: Clock,
            color: "text-orange-400",
            bg: "bg-orange-500/10"
          }, {
            label: t("series"),
            value: eventSeries.length,
            icon: Database,
            color: "text-purple-400",
            bg: "bg-purple-500/10"
          }].map((stat, idx) => <Card key={idx} className="border-white/5 bg-[#1a1b1e]/60 backdrop-blur-3xl rounded-[32px] overflow-hidden shadow-2xl relative border-l border-t">
                <CardContent className="p-8">
                   <div className="flex justify-between items-start mb-6">
                      <div className={cn("p-4 rounded-2xl bg-black/40 border border-white/5", stat.color)}>
                         <stat.icon className="h-6 w-6" />
                      </div>
                      <Badge className="bg-white/5 text-slate-500 border-none text-[8px] font-black italic tracking-widest">{t("client.src.realtime")}</Badge>
                   </div>
                   <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{stat.label}</p>
                   <h2 className="text-3xl font-black text-white italic tracking-tighter mt-1">{stat.value}</h2>
                </CardContent>
             </Card>)}
        </div>

        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-12">
            <TabsList className="bg-[#1a1b1e]/60 border border-white/5 p-2 rounded-[32px] h-auto backdrop-blur-3xl inline-flex">
              {[{
              id: 'events',
              label: t("stream")
            }, {
              id: 'calendar',
              label: t("eventsGrid")
            }, {
              id: 'series',
              label: t("loops")
            }, {
              id: 'analytics',
              label: t("insights")
            }].map(tab => <TabsTrigger key={tab.id} value={tab.id} className="px-8 py-4 rounded-2xl data-[state=active]:bg-blue-600 data-[state=active]:text-white text-slate-500 font-black italic tracking-widest text-xs transition-all">
                  {tab.label}
                </TabsTrigger>)}
            </TabsList>

            <TabsContent value="events" className="space-y-12 mt-0">
               {/* Filters Node */}
               <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[32px] p-8 shadow-2xl">
                  <div className="flex flex-wrap items-center gap-8">
                    <div className="flex items-center gap-4 flex-1">
                      <div className="relative group flex-1">
                         <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-600" />
                         <input type="text" aria-label="Filter events" placeholder={t("client.src.filter_temporal_data")} className="bg-black/40 border border-white/5 rounded-2xl py-4 pl-12 pr-6 text-[10px] font-black tracking-widest italic text-white placeholder:text-slate-700 focus:outline-none focus:border-blue-500/50 transition-all w-full" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
                      </div>
                    </div>
                    
                    <div className="flex gap-4">
                       <Select value={filterType} onValueChange={setFilterType}>
                          <SelectTrigger className="h-14 px-6 rounded-2xl bg-black/40 border-white/5 text-[10px] font-black italic tracking-widest text-white w-40">
                             <SelectValue placeholder={t("client.src.type")} />
                          </SelectTrigger>
                          <SelectContent className="bg-[#1a1b1e] border-white/10 rounded-2xl">
                             <SelectItem value="all">{t("client.src.all_types")}</SelectItem>
                             <SelectItem value="meeting">{t("client.src.meetings")}</SelectItem>
                             <SelectItem value="viewing">{t("client.src.viewings")}</SelectItem>
                             <SelectItem value="inspection">{t("client.src.inspections")}</SelectItem>
                          </SelectContent>
                       </Select>

                       <Select value={filterStatus} onValueChange={setFilterStatus}>
                          <SelectTrigger className="h-14 px-6 rounded-2xl bg-black/40 border-white/5 text-[10px] font-black italic tracking-widest text-white w-32">
                             <SelectValue placeholder={t("client.src.status")} />
                          </SelectTrigger>
                          <SelectContent className="bg-[#1a1b1e] border-white/10 rounded-2xl">
                             <SelectItem value="all">{t("client.src.all_status")}</SelectItem>
                             <SelectItem value="scheduled">{t("client.src.scheduled")}</SelectItem>
                             <SelectItem value="completed">{t("client.src.completed")}</SelectItem>
                          </SelectContent>
                       </Select>

                       <div className="flex p-2 bg-black/40 rounded-2xl border border-white/5 gap-2">
                          <Button onClick={() => setViewMode("list")} variant="ghost" className={cn("h-10 px-6 rounded-xl font-black italic text-[10px]  tracking-widest transition-all", viewMode === "list" ? "bg-white text-black" : "text-slate-500 hover:text-white")}>{t("client.src.listview")}</Button>
                          <Button onClick={() => setViewMode("week")} variant="ghost" className={cn("h-10 px-6 rounded-xl font-black italic text-[10px]  tracking-widest transition-all", viewMode === "week" ? "bg-white text-black" : "text-slate-500 hover:text-white")}>{t("client.src.weekview")}</Button>
                       </div>
                    </div>
                  </div>
               </Card>

               <div className="grid grid-cols-1 gap-8">
                  {viewMode === "list" ? renderListView() : <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-7 gap-6">
                      {renderWeekView()}
                    </div>}
               </div>
            </TabsContent>

            <TabsContent value="calendar" className="mt-0">
               <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] overflow-hidden shadow-3xl">
                  <header className="p-10 border-b border-white/5 flex items-center justify-between">
                     <h2 className="text-3xl font-black text-white italic tracking-tighter">{t("client.src.temporal_grid")}</h2>
                     <div className="flex items-center gap-4">
                        <div className="flex p-2 bg-black/40 rounded-2xl border border-white/5">
                           <Button onClick={() => setCurrentDate(addWeeks(currentDate, -1))} variant="ghost" className="h-10 w-10 text-slate-500 hover:text-white"><ChevronLeft className="w-5 h-5" /></Button>
                           <Button onClick={() => setCurrentDate(new Date())} variant="ghost" className="h-10 px-6 font-black italic tracking-widest text-[10px] text-white">{t("client.src.today")}</Button>
                           <Button onClick={() => setCurrentDate(addWeeks(currentDate, 1))} variant="ghost" className="h-10 w-10 text-slate-500 hover:text-white"><ChevronRight className="w-5 h-5" /></Button>
                        </div>
                     </div>
                  </header>
                  <div className="p-10 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-7 gap-6 bg-black/20">
                     {renderWeekView()}
                  </div>
               </Card>
            </TabsContent>

            <TabsContent value="series" className="mt-0 space-y-8">
               <div className="flex items-center justify-between px-4">
                  <h2 className="text-2xl font-black text-white italic tracking-tighter">{t("client.src.recurring_loops")}</h2>
                  <Badge className="bg-purple-500/10 text-purple-400 border border-purple-500/20 font-black italic text-[9px] px-3 py-1">{eventSeries.length}{t("client.src.active")}</Badge>
               </div>
               <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                  {eventSeries.map(series => <m.div key={series.id} initial={{
                opacity: 0,
                y: 20
              }} animate={{
                opacity: 1,
                y: 0
              }} className="p-8 rounded-[32px] bg-[#1a1b1e]/40 border border-white/5 border-l border-t hover:bg-white/5 transition-all shadow-2xl group flex justify-between gap-8">
                       <div className="flex gap-6">
                          <div className="h-16 w-16 rounded-2xl bg-purple-500/10 border border-purple-500/20 flex items-center justify-center text-purple-400">
                             <RefreshCw className="w-8 h-8" />
                          </div>
                          <div className="space-y-2">
                             <h3 className="text-xl font-black text-white italic tracking-tighter leading-none">{series.title}</h3>
                             <p className="text-[11px] font-bold text-slate-500 tracking-tight italic line-clamp-1">{series.description}</p>
                             <div className="flex items-center gap-4 pt-4">
                                <Badge className="bg-black/40 border-white/5 text-slate-400 text-[8px] font-black italic tracking-widest">{series.recurrence?.type}</Badge>
                                <span className="text-[10px] font-black text-slate-600 italic">{series.events.length}{t("client.src.events")}</span>
                             </div>
                          </div>
                       </div>
                       <Button variant="ghost" className="h-12 w-12 rounded-xl bg-white/5 hover:bg-white/10 opacity-0 group-hover:opacity-100 transition-all">
                          <Settings className="w-5 h-5 text-slate-500" />
                       </Button>
                    </m.div>)}
               </div>
            </TabsContent>

            <TabsContent value="analytics" className="mt-0">
               <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
                  <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] p-10 shadow-3xl">
                     <header className="mb-10 flex items-center justify-between">
                        <h2 className="text-xl font-black text-white italic tracking-tighter leading-none">{t("client.src.temporal_distribution")}</h2>
                        <Layers className="w-5 h-5 text-blue-500" />
                     </header>
                     <div className="space-y-8">
                        {["meeting", "viewing", "appointment", "inspection"].map(type => {
                    const count = events.filter(e => e.type === type).length;
                    const percentage = events.length > 0 ? count / events.length * 100 : 0;
                    return <div key={type} className="space-y-4">
                               <div className="flex justify-between items-center text-[10px] font-black italic tracking-widest text-slate-500">
                                  <span>{type}</span>
                                  <span className="text-white">{count}{t("client.src.units")}{percentage.toFixed(1)}%)</span>
                               </div>
                               <div className="h-1.5 w-full bg-black/40 rounded-full overflow-hidden shadow-inner flex">
                                  <m.div initial={{
                          width: 0
                        }} animate={{
                          width: `${percentage}%`
                        }} className="h-full bg-blue-600 shadow-[0_0_15px_#2563eb]" />
                               </div>
                            </div>;
                  })}
                     </div>
                  </Card>

                  <Card className="bg-[#1a1b1e]/40 border-white/5 border-l border-t rounded-[40px] p-10 shadow-3xl">
                     <header className="mb-10 flex items-center justify-between">
                        <h2 className="text-xl font-black text-white italic tracking-tighter leading-none">{t("client.src.upcoming_temporal_cycles")}</h2>
                        <Activity className="w-5 h-5 text-emerald-500" />
                     </header>
                     <div className="space-y-4">
                        {getUpcomingEvents(7).map(event => <div key={event.id} className="p-6 rounded-2xl bg-black/40 border border-white/5 flex items-center justify-between group hover:bg-white/5 transition-all">
                             <div className="flex items-center gap-6">
                                <div className={cn("h-10 w-10 rounded-xl flex items-center justify-center border", event.status === 'scheduled' ? 'bg-blue-500/10 border-blue-500/20 text-blue-400' : 'bg-slate-500/10 border-white/5 text-slate-500')}>
                                   <Zap className="w-4 h-4" />
                                </div>
                                <div>
                                    <h3 className="text-sm font-black text-white italic tracking-widest leading-none mb-1">{event.title}</h3>
                                   <p className="text-[9px] font-bold text-slate-600 italic">{format(new Date(event.startDate), "MMM d, yyyy @ h:mm a")}</p>
                                </div>
                             </div>
                             <ChevronRight className="w-4 h-4 text-slate-800 group-hover:text-slate-400 transition-colors" />
                          </div>)}
                     </div>
                  </Card>
               </div>
            </TabsContent>
        </Tabs>
      </div>

      {/* Detail Overlay */}
      {selectedEvent && <div className="fixed inset-0 bg-black/80 backdrop-blur-md flex items-center justify-center p-8 z-50">
           <m.div initial={{
          opacity: 0,
          scale: 0.95
        }} animate={{
          opacity: 1,
          scale: 1
        }} className="w-full max-w-3xl bg-[#1a1b1e] border border-white/10 rounded-[40px] overflow-hidden shadow-3xl">
              <div className="p-12 space-y-12">
                 <header className="flex items-center justify-between">
                    <div className="space-y-4">
                       <div className="flex gap-2">
                          <Badge className="bg-blue-500/10 text-blue-400 border border-blue-500/10 px-4 py-1.5 text-[9px] font-black italic">{t("client.src.temporal_analysis")}</Badge>
                          <Badge className={cn("border px-4 py-1.5 text-[9px] font-black  italic", selectedEvent.priority === 'urgent' ? 'bg-red-500/10 border-red-500/20 text-red-500' : selectedEvent.priority === 'high' ? 'bg-orange-500/10 border-orange-500/20 text-orange-500' : 'bg-slate-500/10 border-white/5 text-slate-500')}>
                             {selectedEvent.priority}{t("client.src.priority")}</Badge>
                       </div>
                       <h2 className="text-5xl font-black text-white italic tracking-tighter leading-none">{selectedEvent.title}</h2>
                    </div>
                    <Button variant="ghost" onClick={() => setSelectedEvent(null)} className="h-16 w-16 rounded-[24px] bg-white/5 hover:bg-white/10 transition-all">
                       <XCircle className="w-8 h-8 text-white" />
                    </Button>
                 </header>

                 <div className="grid grid-cols-2 gap-10 py-12 border-y border-white/5">
                    <div className="space-y-6">
                       <div className="flex gap-4 items-center">
                          <div className="h-12 w-12 rounded-2xl bg-black/40 border border-white/5 flex items-center justify-center text-blue-400">
                             <Clock className="w-5 h-5" />
                          </div>
                          <div>
                             <p className="text-[9px] font-black text-slate-600 italic tracking-widest mb-1">{t("client.src.time_alignment")}</p>
                             <p className="text-lg font-black text-white italic leading-none">{format(new Date(selectedEvent.startDate), "MMM d, yyyy")} @ {format(new Date(selectedEvent.startDate), "h:mm a")}</p>
                          </div>
                       </div>
                       
                       <div className="flex gap-4 items-center">
                          <div className="h-12 w-12 rounded-2xl bg-black/40 border border-white/5 flex items-center justify-center text-emerald-400">
                             <MapPin className="w-5 h-5" />
                          </div>
                          <div>
                             <p className="text-[9px] font-black text-slate-600 italic tracking-widest mb-1">{t("client.src.geospatial_data")}</p>
                             <p className="text-lg font-black text-white italic leading-none">{selectedEvent.location?.address || 'VIRTUAL NODE'}</p>
                          </div>
                       </div>
                    </div>
                    
                    <div className="space-y-6 text-right">
                       <div className="flex flex-col items-end">
                          <p className="text-[9px] font-black text-slate-600 italic tracking-widest mb-2">{t("client.src.protocol_status")}</p>
                          <Badge className={cn("px-6 py-2 rounded-xl text-xs font-black italic ", selectedEvent.status === 'scheduled' ? 'bg-blue-500 text-white shadow-[0_0_20px_#3b82f6]' : selectedEvent.status === 'completed' ? 'bg-emerald-500 text-white shadow-[0_0_20px_#10b981]' : 'bg-slate-700 text-white')}>
                             {selectedEvent.status}
                          </Badge>
                       </div>
                       
                       <div className="flex flex-col items-end">
                          <p className="text-[9px] font-black text-slate-600 italic tracking-widest mb-2">{t("client.src.node_category")}</p>
                          <p className="text-xl font-black text-white italic tracking-tighter">{selectedEvent.category}</p>
                       </div>
                    </div>
                 </div>

                 <div className="space-y-6">
                    <p className="text-[10px] font-black text-slate-500 italic tracking-widest">{t("client.src.intelligence_summary")}</p>
                    <div className="p-8 rounded-3xl bg-black/40 border border-white/5 relative overflow-hidden">
                       <div className="absolute top-0 right-0 p-8 opacity-5 text-blue-500">
                          <Fingerprint className="w-24 h-24" />
                       </div>
                       <p className="text-sm font-bold text-slate-400 italic leading-loose relative z-10">{selectedEvent.description || 'No detailed intel provided for this temporal anchor.'}</p>
                    </div>
                 </div>

                 <div className="flex gap-4 pt-4">
                    <Button onClick={() => setSelectedEvent(null)} className="flex-1 h-16 rounded-[24px] bg-white text-black hover:bg-slate-200 font-black italic tracking-widest text-xs shadow-xl transition-all">{t("client.src.close_tactical_hud")}</Button>
                    <Button variant="outline" className="h-16 px-10 rounded-[24px] border-white/10 bg-white/5 text-white hover:bg-white/10 font-black italic tracking-widest text-xs transition-all">
                       <Edit className="w-4 h-4 mr-3" />{t("client.src.edit_node")}</Button>
                 </div>
              </div>
           </m.div>
        </div>}
      </>
    </PageShell>;
}