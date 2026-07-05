"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Scale,
  Search,
  Plus,
  Phone,
  Mail,
  Building2,
  ArrowUpRight,
  Edit,
  Trash2,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Solicitor {
  id: string;
  firmName: string;
  contactName: string;
  email: string;
  phone: string;
  specialisation: string;
  status: "ACTIVE" | "INACTIVE";
}

const mockSolicitors: Solicitor[] = [
  { id: "1", firmName: "Smith & Co Legal", contactName: "John Smith", email: "john@smithlegal.com", phone: "+44 20 7123 4567", specialisation: "Property Law", status: "ACTIVE" },
  { id: "2", firmName: "Brown & Partners", contactName: "Sarah Brown", email: "sarah@brownpartners.com", phone: "+44 20 7234 5678", specialisation: "Immigration", status: "ACTIVE" },
  { id: "3", firmName: "Wilson Legal Services", contactName: "Mike Wilson", email: "mike@wilsonlegal.com", phone: "+44 20 7345 6789", specialisation: "Corporate Law", status: "INACTIVE" },
  { id: "4", firmName: "Davis Solicitors", contactName: "Emma Davis", email: "emma@davissolicitors.com", phone: "+44 20 7456 7890", specialisation: "Tenancy Law", status: "ACTIVE" },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
};

export default function AdminSolicitorsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");

  const filtered = mockSolicitors.filter(s =>
    s.firmName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.contactName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.solicitors.title")}</h1>
              <p className="text-gray-400">{t("admin.solicitors.description")}</p>
            </div>
            <Button className="bg-slate-600 hover:bg-slate-700">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.solicitors.back_to_dashboard")}
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
                      placeholder={t("admin.solicitors.search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-slate-600 hover:bg-slate-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin.solicitors.add_solicitor")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <Scale className="w-5 h-5" />
                {t("admin.solicitors.list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((solicitor) => (
                  <div key={solicitor.id} className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-slate-500/20 flex items-center justify-center">
                        <Scale className="w-5 h-5 text-slate-400" />
                      </div>
                      <div>
                        <div className="text-white font-medium">{solicitor.firmName}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <Building2 className="w-3 h-3" />
                          {solicitor.contactName}
                        </div>
                        <div className="text-xs text-gray-500 flex items-center gap-3 mt-1">
                          <span className="flex items-center gap-1"><Mail className="w-3 h-3" />{solicitor.email}</span>
                          <span className="flex items-center gap-1"><Phone className="w-3 h-3" />{solicitor.phone}</span>
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <span className="text-xs text-gray-400">{solicitor.specialisation}</span>
                      <Badge className={STATUS_COLORS[solicitor.status]}>{solicitor.status}</Badge>
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
