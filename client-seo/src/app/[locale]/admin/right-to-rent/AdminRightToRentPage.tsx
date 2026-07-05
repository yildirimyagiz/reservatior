"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  FileSearch,
  Search,
  Plus,
  UserCheck,
  Calendar,
  ArrowUpRight,
  Edit,
  Trash2,
  ShieldCheck,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface RightToRentRecord {
  id: string;
  tenantName: string;
  propertyAddress: string;
  checkDate: string;
  expiryDate: string;
  status: "VERIFIED" | "PENDING" | "EXPIRED" | "FAILED";
  documentType: string;
}

const mockRecords: RightToRentRecord[] = [
  { id: "1", tenantName: "James Wilson", propertyAddress: "123 Main St, London", checkDate: "2024-01-15", expiryDate: "2025-01-15", status: "VERIFIED", documentType: "Passport" },
  { id: "2", tenantName: "Emily Clark", propertyAddress: "456 Oak Ave, Manchester", checkDate: "2024-02-20", expiryDate: "2024-08-20", status: "PENDING", documentType: "Biometric Residency" },
  { id: "3", tenantName: "David Lee", propertyAddress: "789 Pine Rd, Birmingham", checkDate: "2023-03-10", expiryDate: "2024-03-10", status: "EXPIRED", documentType: "Visa" },
  { id: "4", tenantName: "Sarah Johnson", propertyAddress: "321 Elm St, Leeds", checkDate: "2024-04-05", expiryDate: "2025-04-05", status: "VERIFIED", documentType: "Passport" },
  { id: "5", tenantName: "Michael Brown", propertyAddress: "654 Birch Ln, Bristol", checkDate: "2024-03-01", expiryDate: "2024-09-01", status: "FAILED", documentType: "Share Code" },
];

const STATUS_COLORS: Record<string, string> = {
  VERIFIED: "bg-green-500/20 text-green-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
  EXPIRED: "bg-red-500/20 text-red-400",
  FAILED: "bg-gray-500/20 text-gray-400",
};

const STATUS_ICONS: Record<string, any> = {
  VERIFIED: ShieldCheck,
  PENDING: FileSearch,
  EXPIRED: FileSearch,
  FAILED: FileSearch,
};

export default function AdminRightToRentPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");

  const filtered = mockRecords.filter(r =>
    r.tenantName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    r.propertyAddress.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.righttorent.title")}</h1>
              <p className="text-gray-400">{t("admin.righttorent.description")}</p>
            </div>
            <Button className="bg-slate-600 hover:bg-slate-700">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.righttorent.back_to_dashboard")}
            </Button>
          </div>
        </motion.div>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
          {[
            { label: t("admin.righttorent.verified"), value: "124", color: "text-green-400", icon: ShieldCheck },
            { label: t("admin.righttorent.pending"), value: "18", color: "text-yellow-400", icon: FileSearch },
            { label: t("admin.righttorent.expired"), value: "7", color: "text-red-400", icon: FileSearch },
            { label: t("admin.righttorent.failed"), value: "3", color: "text-gray-400", icon: FileSearch },
          ].map((stat, idx) => (
            <motion.div key={stat.label} initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.05 * idx }}>
              <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
                <CardContent className="p-4">
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="text-sm text-gray-400">{stat.label}</div>
                      <div className={`text-2xl font-bold ${stat.color}`}>{stat.value}</div>
                    </div>
                    <stat.icon className={`w-6 h-6 ${stat.color}`} />
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }} className="mb-6">
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder={t("admin.righttorent.search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-slate-600 hover:bg-slate-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin.righttorent.add_record")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }}>
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <UserCheck className="w-5 h-5" />
                {t("admin.righttorent.list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((record) => {
                  const StatusIcon = STATUS_ICONS[record.status];
                  return (
                    <div key={record.id} className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors">
                      <div className="flex items-center gap-4">
                        <div className="w-10 h-10 rounded-full bg-slate-500/20 flex items-center justify-center">
                          <UserCheck className="w-5 h-5 text-slate-400" />
                        </div>
                        <div>
                          <div className="text-white font-medium">{record.tenantName}</div>
                          <div className="text-sm text-gray-400">{record.propertyAddress}</div>
                          <div className="text-xs text-gray-500 flex items-center gap-3 mt-1">
                            <span className="flex items-center gap-1"><Calendar className="w-3 h-3" />{t("admin.righttorent.check")}: {record.checkDate}</span>
                            <span className="flex items-center gap-1"><Calendar className="w-3 h-3" />{t("admin.righttorent.expires")}: {record.expiryDate}</span>
                            <span>{record.documentType}</span>
                          </div>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <Badge className={STATUS_COLORS[record.status]}>
                          <StatusIcon className="w-3 h-3 mr-1 inline" />
                          {record.status}
                        </Badge>
                        <div className="flex gap-2">
                          <Button variant="ghost" size="icon" className="h-8 w-8"><Edit className="w-4 h-4" /></Button>
                          <Button variant="ghost" size="icon" className="h-8 w-8 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
