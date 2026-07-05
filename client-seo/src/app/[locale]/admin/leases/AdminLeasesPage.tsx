"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  FileText,
  Search,
  Plus,
  Home,
  User,
  Calendar,
  DollarSign,
  ArrowUpRight,
  Edit,
  Trash2,
  Clock,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Lease {
  id: string;
  tenantName: string;
  propertyName: string;
  startDate: string;
  endDate: string;
  monthlyRent: number;
  status: "ACTIVE" | "EXPIRING" | "EXPIRED" | "DRAFT";
}

const mockLeases: Lease[] = [
  { id: "1", tenantName: "Alice Johnson", propertyName: "Luxury Villa", startDate: "2024-01-01", endDate: "2025-01-01", monthlyRent: 2500, status: "ACTIVE" },
  { id: "2", tenantName: "Bob Williams", propertyName: "Downtown Apartment", startDate: "2023-06-01", endDate: "2024-06-01", monthlyRent: 1200, status: "EXPIRING" },
  { id: "3", tenantName: "Carol Martinez", propertyName: "Beachfront Condo", startDate: "2022-03-01", endDate: "2023-03-01", monthlyRent: 1800, status: "EXPIRED" },
  { id: "4", tenantName: "David Lee", propertyName: "Studio Loft", startDate: "2024-04-01", endDate: "2025-04-01", monthlyRent: 900, status: "DRAFT" },
  { id: "5", tenantName: "Eve Anderson", propertyName: "Penthouse Suite", startDate: "2024-02-01", endDate: "2025-02-01", monthlyRent: 3500, status: "ACTIVE" },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  EXPIRING: "bg-yellow-500/20 text-yellow-400",
  EXPIRED: "bg-red-500/20 text-red-400",
  DRAFT: "bg-slate-500/20 text-slate-400",
};

export default function AdminLeasesPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");

  const filtered = mockLeases.filter(lease =>
    lease.tenantName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    lease.propertyName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.leases.title")}</h1>
              <p className="text-gray-400">{t("admin.leases.description")}</p>
            </div>
            <Button className="bg-slate-600 hover:bg-slate-700">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.leases.back_to_dashboard")}
            </Button>
          </div>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="mb-6">
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder={t("admin.leases.search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-slate-600 hover:bg-slate-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin.leases.add_lease")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <FileText className="w-5 h-5" />
                {t("admin.leases.list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((lease) => (
                  <div key={lease.id} className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-slate-500/20 flex items-center justify-center">
                        <FileText className="w-5 h-5 text-slate-400" />
                      </div>
                      <div>
                        <div className="text-white font-medium">{lease.propertyName}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <User className="w-3 h-3" />
                          {lease.tenantName}
                        </div>
                        <div className="text-xs text-gray-500 flex items-center gap-3 mt-1">
                          <span className="flex items-center gap-1"><Calendar className="w-3 h-3" />{lease.startDate} - {lease.endDate}</span>
                          <span className="flex items-center gap-1"><Clock className="w-3 h-3" />{
                            t("admin.leases.days_remaining", { days: Math.ceil((new Date(lease.endDate).getTime() - new Date().getTime()) / (1000 * 60 * 60 * 24)) })
                          }</span>
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className="text-right">
                        <div className="text-white font-medium">${lease.monthlyRent.toLocaleString()}/mo</div>
                      </div>
                      <Badge className={STATUS_COLORS[lease.status]}>{lease.status}</Badge>
                      <div className="flex gap-2">
                        <Button variant="ghost" size="icon" className="h-8 w-8"><Edit className="w-4 h-4" /></Button>
                        <Button variant="ghost" size="icon" className="h-8 w-8 text-red-400"><Trash2 className="w-4 h-4" /></Button>
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
