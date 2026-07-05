"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import {
  Globe,
  Search,
  Plus,
  Edit,
  Trash2,
  ArrowUpRight,
  Wifi,
  WifiOff,
  RefreshCw,
  Building2,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Channel {
  id: string;
  name: string;
  type: "OTA" | "GDS" | "DIRECT";
  status: "CONNECTED" | "DISCONNECTED" | "ERROR";
  properties: number;
  lastSync: string;
  commission: string;
}

const mockChannels: Channel[] = [
  { id: "1", name: "Booking.com", type: "OTA", status: "CONNECTED", properties: 45, lastSync: "2 min ago", commission: "15%" },
  { id: "2", name: "Airbnb", type: "OTA", status: "CONNECTED", properties: 38, lastSync: "5 min ago", commission: "3%" },
  { id: "3", name: "Expedia", type: "OTA", status: "CONNECTED", properties: 42, lastSync: "10 min ago", commission: "18%" },
  { id: "4", name: "VRBO", type: "OTA", status: "ERROR", properties: 12, lastSync: "1 hour ago", commission: "8%" },
  { id: "5", name: "Google Travel", type: "GDS", status: "CONNECTED", properties: 30, lastSync: "15 min ago", commission: "0%" },
  { id: "6", name: "TripAdvisor", type: "GDS", status: "DISCONNECTED", properties: 0, lastSync: "Never", commission: "12%" },
  { id: "7", name: "Direct Website", type: "DIRECT", status: "CONNECTED", properties: 50, lastSync: "1 min ago", commission: "0%" },
];

const TYPE_COLORS: Record<string, string> = {
  OTA: "bg-slate-500/20 text-slate-400",
  GDS: "bg-slate-500/20 text-slate-400",
  DIRECT: "bg-emerald-500/20 text-emerald-400",
};

const STATUS_COLORS: Record<string, string> = {
  CONNECTED: "bg-green-500/20 text-green-400",
  DISCONNECTED: "bg-gray-500/20 text-gray-400",
  ERROR: "bg-red-500/20 text-red-400",
};

export default function AdminChannelsPage() {
  const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredChannels = mockChannels.filter(ch =>
    ch.name.toLowerCase().includes(searchTerm.toLowerCase())
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
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.channels.title")}</h1>
              <p className="text-gray-400">{t("admin.channels.description")}</p>
            </div>
            <Button
              onClick={() => router.push('/admin/dashboard')}
              className="bg-slate-600 hover:bg-slate-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.channels.back_to_dashboard")}
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
                      placeholder={t("admin.channels.search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-slate-600 hover:bg-slate-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin.channels.add_channel")}
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
                <Globe className="w-5 h-5" />
                {t("admin.channels.list_title")}({filteredChannels.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredChannels.map((channel) => (
                  <div
                    key={channel.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-slate-500/20 flex items-center justify-center">
                        {channel.status === "CONNECTED" ? (
                          <Wifi className="w-5 h-5 text-green-400" />
                        ) : channel.status === "ERROR" ? (
                          <RefreshCw className="w-5 h-5 text-red-400" />
                        ) : (
                          <WifiOff className="w-5 h-5 text-gray-400" />
                        )}
                      </div>
                      <div>
                        <div className="text-white font-medium">{channel.name}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <Building2 className="w-3 h-3" />
                          {t("admin.channels.properties_count", { count: channel.properties })} &middot; {t("admin.channels.commission_rate", { rate: channel.commission })}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <Badge className={TYPE_COLORS[channel.type]}>{channel.type}</Badge>
                      <Badge className={STATUS_COLORS[channel.status]}>{channel.status}</Badge>
                      <div className="text-xs text-gray-500">{channel.lastSync}</div>
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
