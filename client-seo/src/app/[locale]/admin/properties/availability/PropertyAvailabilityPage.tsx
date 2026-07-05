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
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

const availabilitySlots = [
  { id: 1, date: "2024-04-15", status: "AVAILABLE", price: 500 },
  { id: 2, date: "2024-04-16", status: "BOOKED", price: 500 },
  { id: 3, date: "2024-04-17", status: "AVAILABLE", price: 500 },
  { id: 4, date: "2024-04-18", status: "AVAILABLE", price: 500 },
  { id: 5, date: "2024-04-19", status: "BLOCKED", price: 0 },
  { id: 6, date: "2024-04-20", status: "AVAILABLE", price: 500 },
  { id: 7, date: "2024-04-21", status: "BOOKED", price: 500 }
];

const STATUS_COLORS: Record<string, string> = {
  AVAILABLE: "bg-green-500/20 text-green-400 border-green-500/30",
  BOOKED: "bg-red-500/20 text-red-400 border-red-500/30",
  BLOCKED: "bg-gray-500/20 text-gray-400 border-gray-500/30"
};

export default function PropertyAvailabilityPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const currentDate = new Date();

  const days = Array.from({ length: 35 }, (_, i) => {
    const date = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
    date.setDate(i - date.getDay() + 1);
    return date;
  });

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.properties.availability.title")}</h1>
              <p className="text-gray-400">{t("admin.properties.availability.description")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-slate-600 hover:bg-slate-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.properties.availability.back_to_dashboard")}
                                      </Button>
          </div>
        </motion.div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <motion.div
            initial={{ opacity: 0, x: -20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.1 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="text-white">
                    {currentDate.toLocaleDateString('en-US', { month: 'long', year: 'numeric' })}
                  </CardTitle>
                  <div className="flex gap-2">
                    <Button variant="outline" size="icon" className="bg-white/10 border-slate-500/30 text-white">
                      <ChevronLeft className="w-4 h-4" />
                    </Button>
                    <Button variant="outline" size="icon" className="bg-white/10 border-slate-500/30 text-white">
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
                          isToday ? 'bg-slate-600 text-white' : 
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
          </motion.div>

          <motion.div
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            transition={{ delay: 0.2 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <CardTitle className="text-white">{t("admin.properties.availability.calendar_title")}</CardTitle>
                  <Button size="icon" className="bg-slate-600 hover:bg-slate-700">
                    <Plus className="w-4 h-4" />
                  </Button>
                </div>
              </CardHeader>
              <CardContent>
                <div className="space-y-3">
                  {availabilitySlots.map((slot) => (
                    <div
                      key={slot.id}
                      className={`p-3 rounded-lg border ${STATUS_COLORS[slot.status]}`}
                    >
                      <div className="flex items-center justify-between">
                        <div className="flex items-center gap-3">
                          <Clock className="w-4 h-4" />
                          <div>
                            <div className="text-white font-medium">{slot.date}</div>
                            <div className="text-sm">{slot.status}</div>
                          </div>
                        </div>
                        {slot.price > 0 && (
                          <div className="text-white font-bold">${slot.price}</div>
                        )}
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </motion.div>
        </div>
      </div>
    </div>
  );
}
