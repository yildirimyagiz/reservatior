"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { 
  DollarSign, 
  Search, 
  Filter, 
  ArrowUpRight,
  TrendingUp,
  Calendar
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Commission {
  id: string;
  dealName: string;
  amount: number;
  rate: number;
  status: "PAID" | "PENDING" | "PROCESSING";
  date: string;
}

const mockCommissions: Commission[] = [
  { id: "1", dealName: "Luxury Villa Sale", amount: 60000, rate: 5, status: "PAID", date: "2024-04-15" },
  { id: "2", dealName: "Downtown Apartment", amount: 22500, rate: 5, status: "PENDING", date: "2024-04-14" },
  { id: "3", dealName: "Beachfront Condo", amount: 44500, rate: 5, status: "PROCESSING", date: "2024-04-13" },
  { id: "4", dealName: "Studio Loft", amount: 21000, rate: 5, status: "PAID", date: "2024-04-12" },
  { id: "5", dealName: "Penthouse Suite", amount: 175000, rate: 5, status: "PENDING", date: "2024-04-11" }
];

const STATUS_COLORS: Record<string, string> = {
  PAID: "bg-green-500/20 text-green-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
  PROCESSING: "bg-blue-500/20 text-blue-400"
};

export default function AgentCommissionsPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredCommissions = mockCommissions.filter(commission => 
    commission.dealName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("commissions.agentcommissionspage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("commissions.agentcommissionspage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("commissions.agentcommissionspage.auto_ext_3")}
                                      </Button>
          </div>
        </m.div>

        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input
                      placeholder="Search commissions..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white">
                  <Filter className="w-4 h-4 mr-2" />
                  {t("commissions.agentcommissionspage.auto_ext_4")}
                                                  </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <TrendingUp className="w-5 h-5" />
                {t("commissions.agentcommissionspage.auto_ext_5")}{filteredCommissions.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredCommissions.map((commission) => (
                  <div
                    key={commission.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center">
                        <DollarSign className="w-5 h-5 text-purple-400" />
                      </div>
                      <div>
                        <div className="text-white font-medium">{commission.dealName}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <Calendar className="w-3 h-3" />
                          {commission.date}
                          <span>•</span>
                          {commission.rate}{t("commissions.agentcommissionspage.auto_ext_6")}
                                                            </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className={`px-2 py-1 rounded ${STATUS_COLORS[commission.status]}`}>
                        {commission.status}
                      </div>
                      <div className="text-white font-bold">
                        <DollarSign className="w-4 h-4 inline" />
                        {commission.amount.toLocaleString()}
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </m.div>
      </div>
    </div>
  );
}
