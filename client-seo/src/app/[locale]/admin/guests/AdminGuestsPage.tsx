"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import {
  Users,
  Search,
  Plus,
  Edit,
  Trash2,
  ArrowUpRight,
  Mail,
  Phone,
  Calendar,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Guest {
  id: string;
  name: string;
  email: string;
  phone: string;
  totalBookings: number;
  totalSpent: string;
  status: "ACTIVE" | "INACTIVE" | "BLACKLISTED";
  lastStay: string;
}

const mockGuests: Guest[] = [
  { id: "1", name: "Emily Johnson", email: "emily@example.com", phone: "+1 (555) 123-4567", totalBookings: 12, totalSpent: "$8,450", status: "ACTIVE", lastStay: "2024-06-15" },
  { id: "2", name: "Michael Chen", email: "michael@example.com", phone: "+1 (555) 234-5678", totalBookings: 8, totalSpent: "$5,200", status: "ACTIVE", lastStay: "2024-06-10" },
  { id: "3", name: "Sarah Williams", email: "sarah@example.com", phone: "+1 (555) 345-6789", totalBookings: 5, totalSpent: "$3,100", status: "ACTIVE", lastStay: "2024-05-28" },
  { id: "4", name: "David Martinez", email: "david@example.com", phone: "+1 (555) 456-7890", totalBookings: 3, totalSpent: "$1,950", status: "INACTIVE", lastStay: "2024-03-15" },
  { id: "5", name: "Lisa Thompson", email: "lisa@example.com", phone: "+1 (555) 567-8901", totalBookings: 15, totalSpent: "$11,200", status: "ACTIVE", lastStay: "2024-06-18" },
  { id: "6", name: "James Wilson", email: "james@example.com", phone: "+1 (555) 678-9012", totalBookings: 1, totalSpent: "$850", status: "BLACKLISTED", lastStay: "2024-01-05" },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
  BLACKLISTED: "bg-red-500/20 text-red-400",
};

export default function AdminGuestsPage() {
  const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredGuests = mockGuests.filter(guest =>
    guest.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    guest.email.toLowerCase().includes(searchTerm.toLowerCase())
  );

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
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.guests.title")}</h1>
              <p className="text-gray-400">{t("admin.guests.description")}</p>
            </div>
            <Button
              onClick={() => router.push('/admin/dashboard')}
              className="bg-slate-600 hover:bg-slate-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.guests.back_to_dashboard")}
            </Button>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder={t("admin.guests.search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-slate-600 hover:bg-slate-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin.guests.add_guest")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <Users className="w-5 h-5" />
                {t("admin.guests.list_title")}({filteredGuests.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredGuests.map((guest) => (
                  <div
                    key={guest.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-slate-500/20 flex items-center justify-center text-slate-400 font-bold">
                        {guest.name.split(' ').map(n => n[0]).join('')}
                      </div>
                      <div>
                        <div className="text-white font-medium">{guest.name}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <Mail className="w-3 h-3" />
                          {guest.email}
                          <span className="mx-1">&middot;</span>
                          <Phone className="w-3 h-3" />
                          {guest.phone}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className="text-right">
                        <div className="text-white text-sm">{t("admin.guests.stays_count", { count: guest.totalBookings })}</div>
                        <div className="text-gray-400 text-xs">{guest.totalSpent}</div>
                      </div>
                      <Badge className={STATUS_COLORS[guest.status]}>{guest.status}</Badge>
                      <div className="flex items-center gap-1 text-xs text-gray-500">
                        <Calendar className="w-3 h-3" />
                        {guest.lastStay}
                      </div>
                      <div className="flex gap-2">
                        <Button variant="ghost" size="icon" className="h-8 w-8">
                          <Edit className="w-4 h-4" />
                        </Button>
                        <Button variant="ghost" size="icon" className="h-8 w-8 text-red-400">
                          <Trash2 className="w-4 h-4" />
                        </Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
