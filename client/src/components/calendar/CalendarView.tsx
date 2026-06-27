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
import { Clock, CheckCircle, XCircle, AlertCircle, MapPin, Users, ChevronLeft, ChevronRight, Plus, CalendarDays, Eye, Edit, Trash2, Search } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { motion } from "framer-motion";
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
export function CalendarView() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const [currentDate, setCurrentDate] = useState(new Date());
  const [selectedDate, setSelectedDate] = useState<Date | null>(null);
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
      title: t("client.src.property_viewing_luxury_apartment"),
      description: t("client.src.show_luxury_apartment_to"),
      date: format(new Date(), "yyyy-MM-dd"),
      startTime: "14:00",
      endTime: "15:00",
      type: "viewing",
      status: "scheduled",
      priority: "high",
      location: "123 Main St, Istanbul",
      attendees: ["client1@example.com", "agent1@example.com"],
      propertyId: "prop1",
      clientId: "client1",
      notes: "Client interested in penthouse view",
      createdBy: user?.id || "",
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    }, {
      id: "2",
      title: t("client.src.team_meeting_weekly_standup"),
      description: t("client.src.weekly_team_sync_and"),
      date: format(addDays(new Date(), 1), "yyyy-MM-dd"),
      startTime: "10:00",
      endTime: "11:00",
      type: "meeting",
      status: "scheduled",
      priority: "medium",
      location: "Office",
      attendees: ["team@company.com"],
      notes: "Discuss weekly goals and challenges",
      createdBy: user?.id || "",
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    }, {
      id: "3",
      title: t("client.src.contract_deadline_commercial_property"),
      description: t("client.src.final_contract_signing_deadline"),
      date: format(addDays(new Date(), 3), "yyyy-MM-dd"),
      startTime: "17:00",
      endTime: "18:00",
      type: "deadline",
      status: "scheduled",
      priority: "urgent",
      location: "Law Office",
      attendees: ["lawyer@firm.com", "client2@example.com"],
      propertyId: "prop2",
      clientId: "client2",
      notes: "All documents must be signed",
      createdBy: user?.id || "",
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    }];
    const mockProperties: Property[] = [{
      id: "prop1",
      title: t("client.src.luxury_downtown_apartment"),
      address: "123 Main St, Istanbul",
      price: 750000,
      status: "active"
    }, {
      id: "prop2",
      title: t("client.src.commercial_office_space"),
      address: "456 Business Ave, Istanbul",
      price: 2500000,
      status: "pending"
    }];
    const mockClients: Client[] = [{
      id: "client1",
      name: "John Doe",
      email: "client1@example.com",
      phone: "+90-555-123-4567",
      avatar: ""
    }, {
      id: "client2",
      name: "Jane Smith",
      email: "client2@example.com",
      phone: "+90-555-987-6543",
      avatar: ""
    }];
    setEvents(mockEvents);
    setProperties(mockProperties);
    setClients(mockClients);
  }, [user]);
  const getEventTypeColor = (type: string) => {
    switch (type) {
      case "appointment":
        return "bg-blue-500/10 text-blue-500 border-blue-200";
      case "viewing":
        return "bg-green-500/10 text-green-500 border-green-200";
      case "meeting":
        return "bg-purple-500/10 text-purple-500 border-purple-200";
      case "deadline":
        return "bg-red-500/10 text-red-500 border-red-200";
      case "reminder":
        return "bg-yellow-500/10 text-yellow-500 border-yellow-200";
      default:
        return "bg-gray-500/10 text-gray-500 border-gray-200";
    }
  };
  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case "urgent":
        return "bg-red-500";
      case "high":
        return "bg-orange-500";
      case "medium":
        return "bg-yellow-500";
      case "low":
        return "bg-green-500";
      default:
        return "bg-gray-500";
    }
  };
  const getStatusIcon = (status: string) => {
    switch (status) {
      case "scheduled":
        return <Clock className="w-4 h-4" />;
      case "completed":
        return <CheckCircle className="w-4 h-4" />;
      case "cancelled":
        return <XCircle className="w-4 h-4" />;
      case "rescheduled":
        return <AlertCircle className="w-4 h-4" />;
      default:
        return <Clock className="w-4 h-4" />;
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
      days.push(<div key={currentDay.toString()} className={`min-h-[100px] border border-gray-200 p-2 cursor-pointer hover:bg-gray-50 transition-colors ${!isSameMonth(currentDay, currentDate) ? "bg-gray-50" : ""} ${selectedDate && isSameDay(currentDay, selectedDate) ? "ring-2 ring-blue-500" : ""}`} onClick={() => setSelectedDate(currentDay)}>
          <div className="flex justify-between items-start mb-1">
            <span className={`text-sm font-medium ${!isSameMonth(currentDay, currentDate) ? "text-gray-400" : "text-gray-900"}`}>
              {format(currentDay, "d")}
            </span>
            {dayEvents.length > 0 && <Badge variant="secondary" className="text-xs">
                {dayEvents.length}
              </Badge>}
          </div>
          <div className="space-y-1">
            {dayEvents.slice(0, 3).map((event, idx) => <div key={idx} className={`text-xs p-1 rounded truncate ${getEventTypeColor(event.type)}`} title={event.title}>
                {event.startTime} {event.title}
              </div>)}
            {dayEvents.length > 3 && <div className="text-xs text-gray-500">+{dayEvents.length - 3}{t("client.src.more")}</div>}
          </div>
        </div>);
      currentDay = addDays(currentDay, 1);
    }
    return days;
  };
  const filteredEvents = events.filter(event => {
    const matchesType = filterType === "all" || event.type === filterType;
    const matchesSearch = event.title.toLowerCase().includes(searchTerm.toLowerCase()) || event.description?.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesType && matchesSearch;
  });
  const selectedDateEvents = selectedDate ? events.filter(event => isSameDay(parseISO(event.date), selectedDate)) : [];
  return <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold flex items-center gap-2">
            <CalendarDays className="w-8 h-8" />{t("client.src.calendar")}</h1>
          <p className="text-muted-foreground">{t("client.src.manage_your_appointments_viewings")}</p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="outline" size="sm" onClick={() => setCurrentDate(subMonths(currentDate, 1))}>
            <ChevronLeft className="w-4 h-4" />
          </Button>
          <Button variant="outline" size="sm" onClick={() => setCurrentDate(new Date())}>{t("client.src.today")}</Button>
          <Button variant="outline" size="sm" onClick={() => setCurrentDate(addMonths(currentDate, 1))}>
            <ChevronRight className="w-4 h-4" />
          </Button>
          <Button onClick={() => setShowEventDialog(true)}>
            <Plus className="w-4 h-4 mr-2" />{t("client.src.new_event")}</Button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
        {/* Calendar View */}
        <div className="lg:col-span-3">
          <Card>
            <CardHeader>
              <CardTitle className="flex items-center justify-between">
                <span>{format(currentDate, "MMMM yyyy", {
                  locale: tr
                })}</span>
                <div className="flex gap-2">
                  <Button variant={viewMode === "month" ? "default" : "outline"} size="sm" onClick={() => setViewMode("month")}>{t("client.src.month")}</Button>
                  <Button variant={viewMode === "week" ? "default" : "outline"} size="sm" onClick={() => setViewMode("week")}>{t("client.src.week")}</Button>
                  <Button variant={viewMode === "day" ? "default" : "outline"} size="sm" onClick={() => setViewMode("day")}>{t("client.src.day")}</Button>
                </div>
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-7 gap-1 mb-2">
                {["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].map(day => <div key={day} className="text-center text-sm font-medium text-gray-500 p-2">
                    {day}
                  </div>)}
              </div>
              <div className="grid grid-cols-7 gap-1">
                {renderCalendarDays()}
              </div>
            </CardContent>
          </Card>

          {/* Selected Date Events */}
          {selectedDate && <Card className="mt-6">
              <CardHeader>
                <CardTitle>{t("client.src.events_for")}{format(selectedDate, "MMMM d, yyyy")}
                </CardTitle>
              </CardHeader>
              <CardContent>
                {selectedDateEvents.length > 0 ? <div className="space-y-3">
                    {selectedDateEvents.map(event => <motion.div key={event.id} initial={{
                opacity: 0,
                y: 10
              }} animate={{
                opacity: 1,
                y: 0
              }} className="border rounded-lg p-4 hover:shadow-md transition-shadow">
                        <div className="flex items-start justify-between">
                          <div className="flex-1">
                            <div className="flex items-center gap-2 mb-2">
                              {getStatusIcon(event.status)}
                              <h3 className="font-medium">{event.title}</h3>
                              <Badge className={getEventTypeColor(event.type)}>
                                {event.type}
                              </Badge>
                              <div className={`w-2 h-2 rounded-full ${getPriorityColor(event.priority)}`} />
                            </div>
                            <div className="flex items-center gap-4 text-sm text-gray-600 mb-2">
                              <div className="flex items-center gap-1">
                                <Clock className="w-4 h-4" />
                                {event.startTime} - {event.endTime}
                              </div>
                              {event.location && <div className="flex items-center gap-1">
                                  <MapPin className="w-4 h-4" />
                                  {event.location}
                                </div>}
                            </div>
                            {event.description && <p className="text-sm text-gray-600 mb-2">{event.description}</p>}
                            {event.attendees && event.attendees.length > 0 && <div className="flex items-center gap-2">
                                <Users className="w-4 h-4 text-gray-500" />
                                <div className="flex -space-x-2">
                                  {event.attendees.slice(0, 3).map((attendee, idx) => <Avatar key={idx} className="w-6 h-6 border-2 border-white">
                                      <AvatarFallback className="text-xs">
                                        {attendee.charAt(0).toUpperCase()}
                                      </AvatarFallback>
                                    </Avatar>)}
                                  {event.attendees.length > 3 && <div className="w-6 h-6 rounded-full bg-gray-200 border-2 border-white flex items-center justify-center">
                                      <span className="text-xs">+{event.attendees.length - 3}</span>
                                    </div>}
                                </div>
                              </div>}
                          </div>
                          <div className="flex gap-2">
                            <Button size="sm" variant="outline">
                              <Eye className="w-4 h-4" />
                            </Button>
                            <Button size="sm" variant="outline">
                              <Edit className="w-4 h-4" />
                            </Button>
                            <Button size="sm" variant="outline">
                              <Trash2 className="w-4 h-4" />
                            </Button>
                          </div>
                        </div>
                      </motion.div>)}
                  </div> : <div className="text-center py-8 text-gray-500">{t("client.src.no_events_scheduled_for")}</div>}
              </CardContent>
            </Card>}
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Filters */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">{t("client.src.filters")}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-4">
              <div>
                <label className="text-sm font-medium mb-2 block">{t("client.src.event_type")}</label>
                <Select value={filterType} onValueChange={setFilterType}>
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("client.src.all_events")}</SelectItem>
                    <SelectItem value="appointment">{t("client.src.appointments")}</SelectItem>
                    <SelectItem value="viewing">{t("client.src.viewings")}</SelectItem>
                    <SelectItem value="meeting">{t("client.src.meetings")}</SelectItem>
                    <SelectItem value="deadline">{t("client.src.deadlines")}</SelectItem>
                    <SelectItem value="reminder">{t("client.src.reminders")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div>
                <label className="text-sm font-medium mb-2 block">{t("client.src.search")}</label>
                <div className="relative">
                  <Search className="absolute left-3 top-3 w-4 h-4 text-gray-400" />
                  <Input placeholder={t("client.src.search_events")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-10" />
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Upcoming Events */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">{t("client.src.upcoming_events")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {filteredEvents.filter(event => new Date(event.date) >= new Date()).sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime()).slice(0, 5).map(event => <div key={event.id} className="border rounded-lg p-3">
                      <div className="flex items-center gap-2 mb-1">
                        <Badge className={getEventTypeColor(event.type)}>
                          {event.type}
                        </Badge>
                        <span className="text-xs text-gray-500">
                          {format(parseISO(event.date), "MMM d")}
                        </span>
                      </div>
                      <h4 className="font-medium text-sm mb-1">{event.title}</h4>
                      <div className="flex items-center gap-2 text-xs text-gray-500">
                        <Clock className="w-3 h-3" />
                        {event.startTime}
                      </div>
                    </div>)}
              </div>
            </CardContent>
          </Card>

          {/* Quick Stats */}
          <Card>
            <CardHeader>
              <CardTitle className="text-lg">{t("client.src.todays_overview")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("client.src.total_events")}</span>
                  <Badge variant="secondary">
                    {events.filter(e => isSameDay(parseISO(e.date), new Date())).length}
                  </Badge>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("client.src.viewings")}</span>
                  <Badge className="bg-green-500/10 text-green-500">
                    {events.filter(e => e.type === "viewing" && isSameDay(parseISO(e.date), new Date())).length}
                  </Badge>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("client.src.meetings")}</span>
                  <Badge className="bg-purple-500/10 text-purple-500">
                    {events.filter(e => e.type === "meeting" && isSameDay(parseISO(e.date), new Date())).length}
                  </Badge>
                </div>
                <div className="flex justify-between items-center">
                  <span className="text-sm">{t("client.src.deadlines")}</span>
                  <Badge className="bg-red-500/10 text-red-500">
                    {events.filter(e => e.type === "deadline" && isSameDay(parseISO(e.date), new Date())).length}
                  </Badge>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>

      {/* New Event Dialog */}
      <Dialog open={showEventDialog} onOpenChange={setShowEventDialog}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>{t("client.src.create_new_event")}</DialogTitle>
            <DialogDescription>{t("client.src.add_a_new_appointment")}</DialogDescription>
          </DialogHeader>
          <div className="grid gap-4 py-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="text-sm font-medium mb-2 block">{t("client.src.event_title")}</label>
                <Input placeholder={t("client.src.enter_event_title")} />
              </div>
              <div>
                <label className="text-sm font-medium mb-2 block">{t("client.src.event_type")}</label>
                <Select>
                  <SelectTrigger>
                    <SelectValue placeholder={t("client.src.select_type")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="appointment">{t("client.src.appointment")}</SelectItem>
                    <SelectItem value="viewing">{t("client.src.property_viewing")}</SelectItem>
                    <SelectItem value="meeting">{t("client.src.meeting")}</SelectItem>
                    <SelectItem value="deadline">{t("client.src.deadline")}</SelectItem>
                    <SelectItem value="reminder">{t("client.src.reminder")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="text-sm font-medium mb-2 block">{t("client.src.date")}</label>
                <Input type="date" />
              </div>
              <div>
                <label className="text-sm font-medium mb-2 block">{t("client.src.priority")}</label>
                <Select>
                  <SelectTrigger>
                    <SelectValue placeholder={t("client.src.select_priority")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="low">{t("client.src.low")}</SelectItem>
                    <SelectItem value="medium">{t("client.src.medium")}</SelectItem>
                    <SelectItem value="high">{t("client.src.high")}</SelectItem>
                    <SelectItem value="urgent">{t("client.src.urgent")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="text-sm font-medium mb-2 block">{t("client.src.start_time")}</label>
                <Input type="time" />
              </div>
              <div>
                <label className="text-sm font-medium mb-2 block">{t("client.src.end_time")}</label>
                <Input type="time" />
              </div>
            </div>
            <div>
              <label className="text-sm font-medium mb-2 block">{t("client.src.location")}</label>
              <Input placeholder={t("client.src.enter_location")} />
            </div>
            <div>
              <label className="text-sm font-medium mb-2 block">{t("client.src.description")}</label>
              <Textarea placeholder={t("client.src.enter_description")} rows={3} />
            </div>
            <div>
              <label className="text-sm font-medium mb-2 block">{t("client.src.property")}</label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("client.src.select_property")} />
                </SelectTrigger>
                <SelectContent>
                  {properties.map(property => <SelectItem key={property.id} value={property.id}>
                      {property.title}
                    </SelectItem>)}
                </SelectContent>
              </Select>
            </div>
            <div>
              <label className="text-sm font-medium mb-2 block">{t("client.src.client")}</label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("client.src.select_client")} />
                </SelectTrigger>
                <SelectContent>
                  {clients.map(client => <SelectItem key={client.id} value={client.id}>
                      {client.name}
                    </SelectItem>)}
                </SelectContent>
              </Select>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setShowEventDialog(false)}>{t("client.src.cancel")}</Button>
            <Button onClick={() => setShowEventDialog(false)}>{t("client.src.create_event")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>;
}