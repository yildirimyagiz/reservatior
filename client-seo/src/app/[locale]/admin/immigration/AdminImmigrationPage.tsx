"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Search,
  Plus,
  Globe,
  Calendar,
  ArrowUpRight,
  Edit,
  Trash2,
  FileText,
  CreditCard as Passport,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface ImmigrationCase {
  id: string;
  applicantName: string;
  nationality: string;
  visaType: string;
  status: "IN_REVIEW" | "APPROVED" | "REJECTED" | "PENDING_DOCS";
  submittedDate: string;
}

const mockCases: ImmigrationCase[] = [
  { id: "1", applicantName: "Maria Garcia", nationality: "Spain", visaType: "Work Visa", status: "IN_REVIEW", submittedDate: "2024-03-15" },
  { id: "2", applicantName: "Chen Wei", nationality: "China", visaType: "Student Visa", status: "APPROVED", submittedDate: "2024-02-20" },
  { id: "3", applicantName: "Ahmed Hassan", nationality: "Egypt", visaType: "Family Visa", status: "PENDING_DOCS", submittedDate: "2024-04-01" },
  { id: "4", applicantName: "Olga Petrova", nationality: "Russia", visaType: "Business Visa", status: "REJECTED", submittedDate: "2024-01-10" },
  { id: "5", applicantName: "Yuki Tanaka", nationality: "Japan", visaType: "Work Visa", status: "IN_REVIEW", submittedDate: "2024-04-10" },
];

const STATUS_COLORS: Record<string, string> = {
  IN_REVIEW: "bg-slate-500/20 text-slate-400",
  APPROVED: "bg-green-500/20 text-green-400",
  REJECTED: "bg-red-500/20 text-red-400",
  PENDING_DOCS: "bg-yellow-500/20 text-yellow-400",
};

export default function AdminImmigrationPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");

  const filtered = mockCases.filter(c =>
    c.applicantName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    c.nationality.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.immigration.title")}</h1>
              <p className="text-gray-400">{t("admin.immigration.description")}</p>
            </div>
            <Button className="bg-slate-600 hover:bg-slate-700">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.immigration.back_to_dashboard")}
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
                      placeholder={t("admin.immigration.search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-slate-600 hover:bg-slate-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin.immigration.add_case")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <Passport className="w-5 h-5" />
                {t("admin.immigration.list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((c) => (
                  <div key={c.id} className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-slate-500/20 flex items-center justify-center">
                        <Globe className="w-5 h-5 text-slate-400" />
                      </div>
                      <div>
                        <div className="text-white font-medium">{c.applicantName}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <Globe className="w-3 h-3" />
                          {c.nationality} &middot; {c.visaType}
                        </div>
                        <div className="text-xs text-gray-500 flex items-center gap-1 mt-1">
                          <Calendar className="w-3 h-3" />
                          {c.submittedDate}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <Badge className={STATUS_COLORS[c.status]}>{c.status.replace("_", " ")}</Badge>
                      <div className="flex gap-2">
                        <Button variant="ghost" size="icon" className="h-8 w-8"><FileText className="w-4 h-4" /></Button>
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
