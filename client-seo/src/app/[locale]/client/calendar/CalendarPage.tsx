"use client";

import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { 
  ChevronLeft, 
  ChevronRight, 
  ArrowUpRight,
  Plus,
  Clock
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

const events = [
  { id: 1, title: "Property Viewing", date: "2024-04-15", time: "10:00 AM", type: "VIEWING" },
  { id: 2, title: "Contract Signing", date: "2024-04-16", time: "2:00 PM", type: "CONTRACT" },
  { id: 3, title: "Maintenance Check", date: "2024-04-18", time: "9:00 AM", type: "MAINTENANCE" },
  { id: 4, title: "Client Meeting", date: "2024-04-20", time: "3:30 PM", type: "MEETING" }
];

const EVENT_COLORS: Record<string, string> = {
  VIEWING: "bg-brand/20 text-brand",
  CONTRACT: "bg-blue-500/20 text-blue-400",
  MAINTENANCE: "bg-amber-500/20 text-amber-400",
  MEETING: "bg-brand/20 text-brand"
};

export default function CalendarPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const currentDate = new Date();

  const days = Array.from({ length: 35 }, (_, i) => {
    const date = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
    date.setDate(i - date.getDay() + 1);
    return date;
  });

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
              <h1 className="text-3xl font-bold text-white mb-2">{t("calendar.calendarpage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("calendar.calendarpage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-brand hover:bg-brand"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("calendar.calendarpage.auto_ext_3")}
                                      </Button>
          </div>
        </m.div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Calendar Grid */}
          <m.div
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.1 }}
            className="lg:col-span-2"
          >
            <Card className="bg-white/5 backdrop-blur-xl border-brand/20">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="text-white">
                    {currentDate.toLocaleDateString('en-US', { month: 'long', year: 'numeric' })}
                  </CardTitle>
                  <div className="flex gap-2">
                    <Button variant="outline" size="icon" aria-label={t("common.previous")} className="bg-white/10 border-brand/30 text-white">
                      <ChevronLeft className="w-4 h-4" />
                    </Button>
                    <Button variant="outline" size="icon" aria-label={t("common.next")} className="bg-white/10 border-brand/30 text-white">
                      <ChevronRight className="w-4 h-4" />
                    </Button>
                  </div>
                </div>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-7 gap-2 mb-4">
                  {['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) => (
                    <div key={day} className="text-center text-gray-400 text-sm font-medium">{day}</div>
                  ))}
                </div>
                <div className="grid grid-cols-7 gap-2">
                  {days.map((date, idx) => {
                      const { t } = useTranslation();
                    const isCurrentMonth = date.getMonth() === currentDate.getMonth();
                    const isToday = date.toDateString() === new Date().toDateString();
                    return (
                      <div
                        key={idx}
                        className={`p-2 text-center rounded-lg cursor-pointer transition-colors ${
                          isToday ? 'bg-brand text-white' : 
                          isCurrentMonth ? 'text-white hover:bg-white/10' : 'text-gray-600'
                        }`}
                      >
                        {date.getDate()}
                      </div>
                    );
                  })}
                </div>
              </CardContent>
            </Card>
          </m.div>

          {/* Upcoming Events */}
          <m.div
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.2 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-brand/20">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="text-white">{t("calendar.calendarpage.auto_ext_4")}</CardTitle>
                  <Button size="icon" aria-label={t("common.add")} className="bg-brand hover:bg-brand">
                    <Plus className="w-4 h-4" />
                  </Button>
                </div>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {events.map((event) => (
                    <div
                      key={event.id}
                      className="p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                    >
                      <div className="flex items-center justify-between mb-2">
                        <div className={`text-xs px-2 py-1 rounded ${EVENT_COLORS[event.type]}`}>
                          {event.type}
                        </div>
                        <div className="text-xs text-gray-400 flex items-center gap-1">
                          <Clock className="w-3 h-3" />
                          {event.time}
                        </div>
                      </div>
                      <div className="text-white font-medium mb-1">{event.title}</div>
                      <div className="text-sm text-gray-400">{event.date}</div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </m.div>
        </div>
      </div>
    </div>
  );
}
