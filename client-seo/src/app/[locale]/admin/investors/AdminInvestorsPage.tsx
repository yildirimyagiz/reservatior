"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  TrendingUp,
  Search,
  Plus,
  DollarSign,
  PieChart,
  ArrowUpRight,
  ArrowDownRight,
  Edit,
  Trash2,
  Briefcase,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Investor {
  id: string;
  name: string;
  email: string;
  totalInvested: number;
  portfolioValue: number;
  returnRate: number;
  status: "ACTIVE" | "INACTIVE" | "PENDING";
  joinDate: string;
}

const mockInvestors: Investor[] = [
  { id: "1", name: "Thomas Reed", email: "thomas@example.com", totalInvested: 500000, portfolioValue: 625000, returnRate: 25, status: "ACTIVE", joinDate: "2023-01-15" },
  { id: "2", name: "Patricia Lane", email: "patricia@example.com", totalInvested: 250000, portfolioValue: 287500, returnRate: 15, status: "ACTIVE", joinDate: "2023-03-20" },
  { id: "3", name: "George Knight", email: "george@example.com", totalInvested: 100000, portfolioValue: 115000, returnRate: 15, status: "INACTIVE", joinDate: "2023-06-10" },
  { id: "4", name: "Rachel Green", email: "rachel@example.com", totalInvested: 750000, portfolioValue: 975000, returnRate: 30, status: "ACTIVE", joinDate: "2022-11-01" },
  { id: "5", name: "Samuel Wright", email: "samuel@example.com", totalInvested: 300000, portfolioValue: 330000, returnRate: 10, status: "PENDING", joinDate: "2024-04-05" },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
};

export default function AdminInvestorsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");

  const filtered = mockInvestors.filter(i =>
    i.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    i.email.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const totalPortfolio = mockInvestors.reduce((sum, i) => sum + i.portfolioValue, 0);
  const totalInvested = mockInvestors.reduce((sum, i) => sum + i.totalInvested, 0);
  const avgReturn = mockInvestors.reduce((sum, i) => sum + i.returnRate, 0) / mockInvestors.length;

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin.investors.title")}</h1>
              <p className="text-gray-400">{t("admin.investors.description")}</p>
            </div>
            <Button className="bg-slate-600 hover:bg-slate-700">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin.investors.back_to_dashboard")}
            </Button>
          </div>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-6">
              <div className="flex items-center justify-between mb-2">
                <span className="text-gray-400 text-sm">{t("admin.investors.total_portfolio_value")}</span>
                <Briefcase className="w-5 h-5 text-slate-400" />
              </div>
              <div className="text-2xl font-bold text-white">${(totalPortfolio / 1000000).toFixed(1)}M</div>
              <div className="text-green-400 text-sm flex items-center gap-1 mt-1">
                <ArrowUpRight className="w-4 h-4" />+{(totalPortfolio / totalInvested - 1) * 100}%
              </div>
            </CardContent>
          </Card>
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-6">
              <div className="flex items-center justify-between mb-2">
                <span className="text-gray-400 text-sm">{t("admin.investors.total_invested")}</span>
                <DollarSign className="w-5 h-5 text-green-400" />
              </div>
              <div className="text-2xl font-bold text-white">${(totalInvested / 1000000).toFixed(1)}M</div>
            </CardContent>
          </Card>
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-6">
              <div className="flex items-center justify-between mb-2">
                <span className="text-gray-400 text-sm">{t("admin.investors.average_return_rate")}</span>
                <PieChart className="w-5 h-5 text-slate-400" />
              </div>
              <div className="text-2xl font-bold text-white">{avgReturn.toFixed(0)}%</div>
              <div className="text-green-400 text-sm flex items-center gap-1 mt-1">
                <ArrowUpRight className="w-4 h-4" />+5.2% {t("admin.investors.vs_last_quarter")}
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }} className="mb-6">
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder={t("admin.investors.search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button className="bg-slate-600 hover:bg-slate-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin.investors.add_investor")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }}>
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <TrendingUp className="w-5 h-5" />
                {t("admin.investors.list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((investor) => (
                  <div key={investor.id} className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-slate-500/20 flex items-center justify-center text-slate-400 font-bold">
                        {investor.name.split(" ").map(n => n[0]).join("")}
                      </div>
                      <div>
                        <div className="text-white font-medium">{investor.name}</div>
                        <div className="text-sm text-gray-400">{investor.email}</div>
                        <div className="text-xs text-gray-500">{t("admin.investors.joined")} {investor.joinDate}</div>
                      </div>
                    </div>
                    <div className="flex items-center gap-6">
                      <div className="text-right">
                        <div className="text-white font-medium">${(investor.portfolioValue / 1000).toFixed(0)}K</div>
                        <div className="text-xs text-gray-400">{t("admin.investors.portfolio")}</div>
                      </div>
                      <div className="text-right">
                        <div className={`font-medium flex items-center gap-1 ${investor.returnRate >= 0 ? "text-green-400" : "text-red-400"}`}>
                          {investor.returnRate >= 0 ? <ArrowUpRight className="w-3 h-3" /> : <ArrowDownRight className="w-3 h-3" />}
                          {investor.returnRate}%
                        </div>
                        <div className="text-xs text-gray-400">{t("admin.investors.return")}</div>
                      </div>
                      <Badge className={STATUS_COLORS[investor.status]}>{investor.status}</Badge>
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
