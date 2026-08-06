"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Plus, Search, Filter, Calendar, Clock, Users, MapPin, Video, Eye, Edit, Trash2, RefreshCw, ExternalLink } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";

// Type definitions
interface CalendarEvent {
  id: string;
  orgId: string;
  externalCalendarId?: string;
  externalEventId?: string;
  title: string;
  description?: string;
  startDate: string;
  endDate: string;
  isAllDay: boolean;
  location?: string;
  attendees?: string[];
  status: CalendarEventStatus;
  visibility: CalendarVisibility;
  recurrence?: {
    rule: string;
    frequency: string;
    interval: number;
    endDate?: string;
    occurrences?: number;
  };
  metadata?: {
    calendarType: string;
    source: string;
    syncStatus?: string;
    lastSyncAt?: string;
    externalUrl?: string;
  };
  createdAt: string;
  updatedAt: string;
}
interface CalendarIntegration {
  id: string;
  orgId: string;
  platform: CalendarPlatform;
  name: string;
  calendarId: string;
  accessToken: string;
  refreshToken?: string;
  isActive: boolean;
  syncDirection: SyncDirection;
  syncFrequency: number;
  lastSyncAt?: string;
  syncStatus?: SyncStatus;
  errorMessage?: string;
  createdAt: string;
  updatedAt: string;
}
enum CalendarEventStatus {
  CONFIRMED = "CONFIRMED",
  TENTATIVE = "TENTATIVE",
  CANCELLED = "CANCELLED",
}
enum CalendarVisibility {
  DEFAULT = "DEFAULT",
  PUBLIC = "PUBLIC",
  PRIVATE = "PRIVATE",
}
enum CalendarPlatform {
  GOOGLE_CALENDAR = "GOOGLE_CALENDAR",
  OUTLOOK_CALENDAR = "OUTLOOK_CALENDAR",
  APPLE_CALENDAR = "APPLE_CALENDAR",
  CALDAV = "CALDAV",
  OFFICE_365 = "OFFICE_365",
}
enum SyncDirection {
  IMPORT = "IMPORT",
  EXPORT = "EXPORT",
  BIDIRECTIONAL = "BIDIRECTIONAL",
}
enum SyncStatus {
  SUCCESS = "SUCCESS",
  FAILED = "FAILED",
  IN_PROGRESS = "IN_PROGRESS",
  PENDING = "PENDING",
}
export default function CalendarIntegration() {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState<"events" | "integrations">("events");
  const [searchTerm, setSearchTerm] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterPlatform, setFilterPlatform] = useState("all");
  const [isEventDialogOpen, setIsEventDialogOpen] = useState(false);
  const [isIntegrationDialogOpen, setIsIntegrationDialogOpen] = useState(false);
  const [events, setEvents] = useState<CalendarEvent[]>([]);
  const [integrations, setIntegrations] = useState<CalendarIntegration[]>([]);
  const [loading, setLoading] = useState(true);
  const {
    toast
  } = useToast();

  // Fetch data from API
  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const [eventsRes, integrationsRes] = await Promise.all([apiClient.get('/calendar-events'), apiClient.get('/calendar-integrations')]);
        setEvents((eventsRes as any).data || []);
        setIntegrations((integrationsRes as any).data || []);
      } catch (error) {
        console.error('Error fetching calendar data:', error);
        toast({
          title: t("common.error"),
          description: t("client.src.failed_to_load_calendar"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);
  const filteredEvents = events.filter(event => {
    const matchesSearch = event.title.toLowerCase().includes(searchTerm.toLowerCase()) || event.description?.toLowerCase().includes(searchTerm.toLowerCase()) || event.location?.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = filterStatus === "all" || event.status === filterStatus;
    return matchesSearch && matchesStatus;
  });
  const filteredIntegrations = integrations.filter(integration => {
    const matchesSearch = integration.name.toLowerCase().includes(searchTerm.toLowerCase()) || integration.platform.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesPlatform = filterPlatform === "all" || integration.platform === filterPlatform;
    return matchesSearch && matchesPlatform;
  });
  const totalEvents = filteredEvents.length;
  const upcomingEvents = filteredEvents.filter(e => new Date(e.startDate) > new Date()).length;
  const allDayEvents = filteredEvents.filter(e => e.isAllDay).length;
  const totalIntegrations = filteredIntegrations.length;
  const activeIntegrations = filteredIntegrations.filter(i => i.isActive).length;
  const handleCreateEvent = async (data: any) => {
    try {
      await apiClient.post('/calendar-events', data);
      setIsEventDialogOpen(false);
      toast({
        title: t("client.src.event_created"),
        description: t("client.src.calendar_event_has_been")
      });
      // Refresh data
      const response = await apiClient.get('/calendar-events');
      setEvents((response as any).data || []);
    } catch (error) {
      console.error('Error creating event:', error);
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_create_calendar"),
        variant: "destructive"
      });
    }
  };
  const handleCreateIntegration = async (data: any) => {
    try {
      await apiClient.post('/calendar-integrations', data);
      setIsIntegrationDialogOpen(false);
      toast({
        title: t("client.src.integration_created"),
        description: t("client.src.calendar_integration_has_been")
      });
      // Refresh data
      const response = await apiClient.get('/calendar-integrations');
      setIntegrations((response as any).data || []);
    } catch (error) {
      console.error('Error creating integration:', error);
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_create_calendar"),
        variant: "destructive"
      });
    }
  };
  const handleSyncIntegration = async (id: string) => {
    try {
      await apiClient.post(`/calendar-integrations/${id}/sync`);
      toast({
        title: t("client.src.sync_started"),
        description: t("client.src.calendar_synchronization_has_been")
      });
    } catch (error) {
      console.error('Error syncing integration:', error);
    }
  };
  const handleDeleteEvent = async (id: string) => {
    try {
      await apiClient.delete(`/calendar-events/${id}`);
      setEvents(events.filter(e => e.id !== id));
      toast({
        title: t("client.src.event_deleted"),
        description: t("client.src.calendar_event_has_been")
      });
    } catch (error) {
      console.error('Error deleting event:', error);
    }
  };
  const handleDeleteIntegration = async (id: string) => {
    try {
      await apiClient.delete(`/calendar-integrations/${id}`);
      setIntegrations(integrations.filter(i => i.id !== id));
      toast({
        title: t("client.src.integration_removed"),
        description: t("client.src.calendar_integration_has_been")
      });
    } catch (error) {
      console.error('Error deleting integration:', error);
    }
  };
  const getPlatformColor = (platform: CalendarPlatform) => {
    switch (platform) {
      case "GOOGLE_CALENDAR":
        return "default";
      case "OUTLOOK_CALENDAR":
        return "outline";
      case "APPLE_CALENDAR":
        return "secondary";
      case "CALDAV":
        return "outline";
      case "OFFICE_365":
        return "default";
      default:
        return "secondary";
    }
  };
  const getSyncStatusColor = (status?: SyncStatus) => {
    switch (status) {
      case "SUCCESS":
        return "default";
      case "FAILED":
        return "destructive";
      case "IN_PROGRESS":
        return "outline";
      case "PENDING":
        return "secondary";
      default:
        return "secondary";
    }
  };
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString();
  };
  const formatDateTime = (dateString: string) => {
    return new Date(dateString).toLocaleString();
  };
  const formatTime = (dateString: string) => {
    return new Date(dateString).toLocaleTimeString([], {
      hour: '2-digit',
      minute: '2-digit'
    });
  };
  const formatRelativeTime = (dateString: string) => {
    const date = new Date(dateString);
    const now = new Date();
    const diffMs = date.getTime() - now.getTime();
    const diffDays = Math.ceil(diffMs / (1000 * 60 * 60 * 24));
    if (diffDays < 0) return "Past";
    if (diffDays === 0) return "Today";
    if (diffDays === 1) return "Tomorrow";
    return `In ${diffDays} days`;
  };
  return <PageShell title={t("client.src.calendar_integration")} description={t("client.src.manage_calendar_events_and")}>
      <div className="space-y-6">
        {/* Tab Navigation */}
        <div className="flex space-x-1 bg-muted p-1 rounded-lg w-fit">
          <Button variant={activeTab === "events" ? "default" : "ghost"} size="sm" onClick={() => setActiveTab("events")}>
            <Calendar className="h-4 w-4 mr-2" />{t("client.src.events")}</Button>
          <Button variant={activeTab === "integrations" ? "default" : "ghost"} size="sm" onClick={() => setActiveTab("integrations")}>
            <RefreshCw className="h-4 w-4 mr-2" />{t("client.src.integrations")}</Button>
        </div>

        {/* Summary Cards */}
        <div className="grid gap-4 md:grid-cols-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.total_events")}</CardTitle>
              <Calendar className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalEvents}</div>
              <p className="text-xs text-muted-foreground">{t("client.src.all_calendar_events")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.upcoming")}</CardTitle>
              <Clock className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-brand">
                {upcomingEvents}
              </div>
              <p className="text-xs text-muted-foreground">{t("client.src.future_events")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.allday")}</CardTitle>
              <Users className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-blue-600">
                {allDayEvents}
              </div>
              <p className="text-xs text-muted-foreground">{t("client.src.full_day_events")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("client.src.integrations")}</CardTitle>
              <RefreshCw className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-brand">
                {activeIntegrations}
              </div>
              <p className="text-xs text-muted-foreground">
                {totalIntegrations}{t("common.total")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex items-center justify-between space-x-2">
          <div className="flex items-center space-x-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
              <Input placeholder={t("common.search")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-[250px]" />
            </div>
            {activeTab === "events" ? <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="outline" size="sm">
                    <Filter className="h-4 w-4 mr-2" />{t("common.status")}{filterStatus === "all" ? "All" : filterStatus}
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent>
                  <DropdownMenuItem onClick={() => setFilterStatus("all")}>{t("common.all_status")}</DropdownMenuItem>
                  {Object.values(CalendarEventStatus).map(status => <DropdownMenuItem key={status} onClick={() => setFilterStatus(status)}>
                      {status}
                    </DropdownMenuItem>)}
                </DropdownMenuContent>
              </DropdownMenu> : <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="outline" size="sm">
                    <Filter className="h-4 w-4 mr-2" />{t("common.platform")}{filterPlatform === "all" ? "All" : filterPlatform}
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent>
                  <DropdownMenuItem onClick={() => setFilterPlatform("all")}>{t("client.src.all_platforms")}</DropdownMenuItem>
                  {Object.values(CalendarPlatform).map(platform => <DropdownMenuItem key={platform} onClick={() => setFilterPlatform(platform)}>
                      {platform.replace("_", " ")}
                    </DropdownMenuItem>)}
                </DropdownMenuContent>
              </DropdownMenu>}
          </div>
          {activeTab === "events" ? <Dialog open={isEventDialogOpen} onOpenChange={setIsEventDialogOpen}>
              <DialogTrigger asChild>
                <Button>
                  <Plus className="h-4 w-4 mr-2" />{t("client.src.create_event")}</Button>
              </DialogTrigger>
              <DialogContent className="sm:max-w-[500px]">
                <DialogHeader>
                  <DialogTitle>{t("client.src.create_calendar_event")}</DialogTitle>
                  <DialogDescription>{t("client.src.add_a_new_event")}</DialogDescription>
                </DialogHeader>
                <div className="grid gap-4 py-4">
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="title" className="text-right">{t("common.title")}</Label>
                    <Input id="title" placeholder={t("client.src.enter_event_title")} className="col-span-3" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="startDate" className="text-right">{t("client.src.start_date")}</Label>
                    <Input id="startDate" type="datetime-local" className="col-span-3" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="endDate" className="text-right">{t("client.src.end_date")}</Label>
                    <Input id="endDate" type="datetime-local" className="col-span-3" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="location" className="text-right">{t("common.location")}</Label>
                    <Input id="location" placeholder={t("client.src.enter_location")} className="col-span-3" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="description" className="text-right">{t("common.description")}</Label>
                    <Textarea id="description" placeholder={t("client.src.event_description")} className="col-span-3" rows={3} />
                  </div>
                </div>
                <div className="flex justify-end space-x-2">
                  <Button variant="outline" onClick={() => setIsEventDialogOpen(false)}>{t("common.cancel")}</Button>
                  <Button onClick={() => handleCreateEvent({})}>{t("client.src.create_event")}</Button>
                </div>
              </DialogContent>
            </Dialog> : <Dialog open={isIntegrationDialogOpen} onOpenChange={setIsIntegrationDialogOpen}>
              <DialogTrigger asChild>
                <Button>
                  <Plus className="h-4 w-4 mr-2" />{t("client.src.add_integration")}</Button>
              </DialogTrigger>
              <DialogContent className="sm:max-w-[425px]">
                <DialogHeader>
                  <DialogTitle>{t("client.src.add_calendar_integration")}</DialogTitle>
                  <DialogDescription>{t("client.src.connect_an_external_calendar")}</DialogDescription>
                </DialogHeader>
                <div className="grid gap-4 py-4">
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="platform" className="text-right">{t("common.platform")}</Label>
                    <Select>
                      <SelectTrigger className="col-span-3">
                        <SelectValue placeholder={t("client.src.select_platform")} />
                      </SelectTrigger>
                      <SelectContent>
                        {Object.values(CalendarPlatform).map(platform => <SelectItem key={platform} value={platform}>
                            {platform.replace("_", " ")}
                          </SelectItem>)}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="name" className="text-right">{t("common.name")}</Label>
                    <Input id="name" placeholder={t("client.src.integration_name")} className="col-span-3" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="direction" className="text-right">{t("client.src.sync_direction")}</Label>
                    <Select>
                      <SelectTrigger className="col-span-3">
                        <SelectValue placeholder={t("client.src.select_direction")} />
                      </SelectTrigger>
                      <SelectContent>
                        {Object.values(SyncDirection).map(direction => <SelectItem key={direction} value={direction}>
                            {direction.replace("_", " ")}
                          </SelectItem>)}
                      </SelectContent>
                    </Select>
                  </div>
                </div>
                <div className="flex justify-end space-x-2">
                  <Button variant="outline" onClick={() => setIsIntegrationDialogOpen(false)}>{t("common.cancel")}</Button>
                  <Button onClick={() => handleCreateIntegration({})}>{t("client.src.connect")}</Button>
                </div>
              </DialogContent>
            </Dialog>}
        </div>

        {/* Content based on active tab */}
        {activeTab === "events" && <Card>
            <CardHeader>
              <CardTitle>{t("client.src.calendar_events")}</CardTitle>
              <CardDescription>{t("client.src.manage_calendar_events_and")}</CardDescription>
            </CardHeader>
            <CardContent>
              {loading ? <div className="flex items-center justify-center py-8">
                  <div className="text-sm text-muted-foreground">{t("common.loading")}</div>
                </div> : <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("common.title")}</TableHead>
                      <TableHead>{t("client.src.date_time")}</TableHead>
                      <TableHead>{t("common.location")}</TableHead>
                      <TableHead>{t("common.status")}</TableHead>
                      <TableHead>{t("client.src.visibility")}</TableHead>
                      <TableHead>{t("client.src.source")}</TableHead>
                      <TableHead className="w-[50px]"></TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredEvents.map(event => <TableRow key={event.id}>
                        <TableCell className="font-medium">
                          <div>
                            <div className="font-medium">{event.title}</div>
                            {event.description && <div className="text-sm text-muted-foreground truncate max-w-[200px]">
                                {event.description}
                              </div>}
                          </div>
                        </TableCell>
                        <TableCell>
                          <div>
                            <div className="text-sm">
                              {event.isAllDay ? <>
                                  <div>{formatDate(event.startDate)}</div>
                                  <div className="text-muted-foreground">{t("client.src.all_day")}</div>
                                </> : <>
                                  <div>{formatDate(event.startDate)}</div>
                                  <div className="text-muted-foreground">
                                    {formatTime(event.startDate)} - {formatTime(event.endDate)}
                                  </div>
                                </>}
                            </div>
                            <div className="text-xs text-muted-foreground">
                              {formatRelativeTime(event.startDate)}
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center space-x-2">
                            {event.location && <MapPin className="h-4 w-4 text-muted-foreground" />}
                            <span className="text-sm truncate max-w-[150px]">
                              {event.location || "No location"}
                            </span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant={event.status === "CONFIRMED" ? "default" : "outline"}>
                            {event.status}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <Badge variant={event.visibility === "PRIVATE" ? "secondary" : "outline"}>
                            {event.visibility}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center space-x-2">
                            <span className="text-sm">{event.metadata?.source || "Local"}</span>
                            {event.metadata?.externalUrl && <Button variant="ghost" size="sm" aria-label={t("common.open")}>
                                <ExternalLink className="h-4 w-4" />
                              </Button>}
                          </div>
                        </TableCell>
                        <TableCell>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="sm" aria-label={t("common.more")}>
                                <MoreHorizontal className="h-4 w-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent>
                              <DropdownMenuItem>
                                <Eye className="h-4 w-4 mr-2" />{t("common.view_details")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Edit className="h-4 w-4 mr-2" />{t("client.src.edit_event")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Users className="h-4 w-4 mr-2" />{t("client.src.manage_attendees")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Video className="h-4 w-4 mr-2" />{t("client.src.start_meeting")}</DropdownMenuItem>
                              <DropdownMenuItem className="text-red-600" onClick={() => handleDeleteEvent(event.id)}>
                                <Trash2 className="h-4 w-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>}
            </CardContent>
          </Card>}

        {activeTab === "integrations" && <Card>
            <CardHeader>
              <CardTitle>{t("client.src.calendar_integrations")}</CardTitle>
              <CardDescription>{t("client.src.manage_external_calendar_service")}</CardDescription>
            </CardHeader>
            <CardContent>
              {loading ? <div className="flex items-center justify-center py-8">
                  <div className="text-sm text-muted-foreground">{t("common.loading")}</div>
                </div> : <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("common.name")}</TableHead>
                      <TableHead>{t("common.platform")}</TableHead>
                      <TableHead>{t("client.src.direction")}</TableHead>
                      <TableHead>{t("common.status")}</TableHead>
                      <TableHead>{t("common.last_sync")}</TableHead>
                      <TableHead>{t("client.src.sync_status")}</TableHead>
                      <TableHead className="w-[50px]"></TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredIntegrations.map(integration => <TableRow key={integration.id}>
                        <TableCell className="font-medium">{integration.name}</TableCell>
                        <TableCell>
                          <Badge variant={getPlatformColor(integration.platform)}>
                            {integration.platform.replace("_", " ")}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <Badge variant="outline">
                            {integration.syncDirection.replace("_", " ")}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <Badge variant={integration.isActive ? "default" : "secondary"}>
                            {integration.isActive ? "Active" : "Inactive"}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            {integration.lastSyncAt ? formatDateTime(integration.lastSyncAt) : "Never"}
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant={getSyncStatusColor(integration.syncStatus)}>
                            {integration.syncStatus || "PENDING"}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="sm" aria-label={t("common.more")}>
                                <MoreHorizontal className="h-4 w-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent>
                              <DropdownMenuItem onClick={() => handleSyncIntegration(integration.id)}>
                                <RefreshCw className="h-4 w-4 mr-2" />{t("client.src.sync_now")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Eye className="h-4 w-4 mr-2" />{t("common.view_details")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Edit className="h-4 w-4 mr-2" />{t("client.src.configure")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Users className="h-4 w-4 mr-2" />{t("client.src.test_connection")}</DropdownMenuItem>
                              <DropdownMenuItem className="text-red-600" onClick={() => handleDeleteIntegration(integration.id)}>
                                <Trash2 className="h-4 w-4 mr-2" />{t("client.src.remove")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>}
            </CardContent>
          </Card>}
      </div>
    </PageShell>;
}