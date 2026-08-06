"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { 
  CalendarIcon, 
  Clock, 
  MapPin, 
  Users, 
  Plus, 
  Edit, 
  Trash2, 
  ArrowUpRight
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Event {
  id: string;
  title: string;
  type: "meeting" | "appointment" | "viewing" | "inspection" | "webinar";
  status: "scheduled" | "in_progress" | "completed" | "cancelled";
  priority: "low" | "medium" | "high" | "urgent";
  startDate: string;
  endDate: string;
  location: string;
  attendees: number;
}

const mockEvents: Event[] = [
  {
    id: "1",
    title: "Property Viewing - Luxury Villa",
    type: "viewing",
    status: "scheduled",
    priority: "high",
    startDate: "2024-01-15T10:00:00",
    endDate: "2024-01-15T11:30:00",
    location: "123 Palm Beach Dr, Miami",
    attendees: 3
  },
  {
    id: "2",
    title: "Client Meeting - Investment Portfolio",
    type: "meeting",
    status: "in_progress",
    priority: "urgent",
    startDate: "2024-01-15T09:00:00",
    endDate: "2024-01-15T10:00:00",
    location: "Virtual - Zoom",
    attendees: 5
  },
  {
    id: "3",
    title: "Property Inspection - Commercial Building",
    type: "inspection",
    status: "completed",
    priority: "medium",
    startDate: "2024-01-14T14:00:00",
    endDate: "2024-01-14T16:00:00",
    location: "456 Business Ave, New York",
    attendees: 2
  },
  {
    id: "4",
    title: "AI Valuation Webinar",
    type: "webinar",
    status: "scheduled",
    priority: "low",
    startDate: "2024-01-16T15:00:00",
    endDate: "2024-01-16T16:30:00",
    location: "Virtual - Teams",
    attendees: 25
  }
];

const STATUS_COLORS: Record<string, string> = {
  scheduled: "bg-brand/100/20 text-brand border-blue-500/30",
  in_progress: "bg-yellow-500/20 text-yellow-400 border-yellow-500/30",
  completed: "bg-blue-500/20 text-blue-400 border-blue-500/30",
  cancelled: "bg-red-500/20 text-red-400 border-red-500/30"
};

const PRIORITY_COLORS: Record<string, string> = {
  low: "bg-gray-500/20 text-gray-400",
  medium: "bg-brand/100/20 text-brand",
  high: "bg-orange-500/20 text-orange-400",
  urgent: "bg-red-500/20 text-red-400"
};

export default function EventsPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [activeTab, setActiveTab] = useState("upcoming");

  const upcomingEvents = mockEvents.filter(e => e.status === "scheduled" || e.status === "in_progress");
  const pastEvents = mockEvents.filter(e => e.status === "completed" || e.status === "cancelled");

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("events.eventspage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("events.eventspage.auto_ext_2")}</p>
            </div>
            <div className="flex gap-3">
              <Button
                onClick={() => router.push('/dashboard')}
                className="bg-brand hover:bg-brand"
              >
                <ArrowUpRight className="w-4 h-4 mr-2" />
                {t("events.eventspage.auto_ext_3")}
                                            </Button>
              <Button className="bg-blue-600 hover:bg-brand">
                <Plus className="w-4 h-4 mr-2" />
                {t("events.eventspage.auto_ext_4")}
                                            </Button>
            </div>
          </div>
        </m.div>

        {/* Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
          <TabsList className="bg-white/5 border-brand/20">
            <TabsTrigger value="upcoming" className="data-[state=active]:bg-brand">{t("events.eventspage.auto_ext_5")}</TabsTrigger>
            <TabsTrigger value="past" className="data-[state=active]:bg-brand">{t("events.eventspage.auto_ext_6")}</TabsTrigger>
            <TabsTrigger value="calendar" className="data-[state=active]:bg-brand">{t("events.eventspage.auto_ext_7")}</TabsTrigger>
          </TabsList>

          <TabsContent value="upcoming">
            <div className="grid gap-4">
              {upcomingEvents.map((event, index) => (
                <m.div
                  key={event.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: index * 0.1 }}
                >
                  <Card className="bg-white/5 backdrop-blur-xl border-brand/20 hover:bg-white/10 transition-colors">
                    <CardContent className="p-6">
                      <div className="flex items-start justify-between">
                        <div className="flex-1">
                          <div className="flex items-center gap-3 mb-3">
                            <h3 className="text-lg font-bold text-white">{event.title}</h3>
                            <Badge className={STATUS_COLORS[event.status]}>{event.status}</Badge>
                            <Badge className={PRIORITY_COLORS[event.priority]}>{event.priority}</Badge>
                          </div>
                          <div className="flex items-center gap-6 text-sm text-gray-400">
                            <div className="flex items-center gap-2">
                              <CalendarIcon className="w-4 h-4" />
                              <span>{new Date(event.startDate).toLocaleDateString()}</span>
                            </div>
                            <div className="flex items-center gap-2">
                              <Clock className="w-4 h-4" />
                              <span>{new Date(event.startDate).toLocaleTimeString()} - {new Date(event.endDate).toLocaleTimeString()}</span>
                            </div>
                            <div className="flex items-center gap-2">
                              <MapPin className="w-4 h-4" />
                              <span>{event.location}</span>
                            </div>
                            <div className="flex items-center gap-2">
                              <Users className="w-4 h-4" />
                              <span>{event.attendees} {t("events.eventspage.auto_ext_8")}</span>
                            </div>
                          </div>
                        </div>
                        <div className="flex gap-2">
                          <Button variant="ghost" size="icon" aria-label={t("common.edit")} className="h-8 w-8">
                            <Edit className="w-4 h-4" />
                          </Button>
                          <Button variant="ghost" size="icon" aria-label={t("common.delete")} className="h-8 w-8 text-red-400 hover:text-red-300">
                            <Trash2 className="w-4 h-4" />
                          </Button>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                </m.div>
              ))}
            </div>
          </TabsContent>

          <TabsContent value="past">
            <div className="grid gap-4">
              {pastEvents.map((event, index) => (
                <m.div
                  key={event.id}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: index * 0.1 }}
                >
                  <Card className="bg-white/5 backdrop-blur-xl border-brand/20 opacity-60">
                    <CardContent className="p-6">
                      <div className="flex items-start justify-between">
                        <div className="flex-1">
                          <div className="flex items-center gap-3 mb-3">
                            <h3 className="text-lg font-bold text-white">{event.title}</h3>
                            <Badge className={STATUS_COLORS[event.status]}>{event.status}</Badge>
                          </div>
                          <div className="flex items-center gap-6 text-sm text-gray-400">
                            <div className="flex items-center gap-2">
                              <CalendarIcon className="w-4 h-4" />
                              <span>{new Date(event.startDate).toLocaleDateString()}</span>
                            </div>
                            <div className="flex items-center gap-2">
                              <MapPin className="w-4 h-4" />
                              <span>{event.location}</span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                </m.div>
              ))}
            </div>
          </TabsContent>

          <TabsContent value="calendar">
            <Card className="bg-white/5 backdrop-blur-xl border-brand/20">
              <CardHeader>
                <CardTitle className="text-white">{t("events.eventspage.auto_ext_9")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="text-center py-12 text-gray-400">
                  <CalendarIcon className="w-12 h-12 mx-auto mb-4 text-brand" />
                  <p>{t("events.eventspage.auto_ext_10")}</p>
                </div>
              </CardContent>
            </Card>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
