"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { 
  CreditCard, 
  Search, 
  Filter, 
  ArrowUpRight,
  DollarSign,
  Calendar,
  CheckCircle,
  XCircle,
  Clock
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Payment {
  id: string;
  description: string;
  amount: number;
  date: string;
  status: "COMPLETED" | "PENDING" | "FAILED" | "REFUNDED";
  method: string;
}

const mockPayments: Payment[] = [
  { id: "1", description: "Property Rental Payment", amount: 5000, date: "2024-04-15", status: "COMPLETED", method: "Credit Card" },
  { id: "2", description: "Booking Deposit", amount: 1500, date: "2024-04-14", status: "PENDING", method: "Bank Transfer" },
  { id: "3", description: "Service Fee", amount: 350, date: "2024-04-13", status: "COMPLETED", method: "PayPal" },
  { id: "4", description: "Refund Processing", amount: 800, date: "2024-04-12", status: "REFUNDED", method: "Credit Card" },
  { id: "5", description: "Maintenance Payment", amount: 450, date: "2024-04-11", status: "FAILED", method: "Bank Transfer" }
];

const STATUS_COLORS: Record<string, string> = {
  COMPLETED: "bg-green-500/20 text-green-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
  FAILED: "bg-red-500/20 text-red-400",
  REFUNDED: "bg-blue-500/20 text-blue-400"
};

const STATUS_ICONS: Record<string, React.ComponentType<{ className?: string }>> = {
  COMPLETED: CheckCircle,
  PENDING: Clock,
  FAILED: XCircle,
  REFUNDED: CheckCircle
};

export default function FinancialPaymentsPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredPayments = mockPayments.filter(payment => 
    payment.description.toLowerCase().includes(searchTerm.toLowerCase())
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
              <h1 className="text-3xl font-bold text-white mb-2">{t("payments.financialpaymentspage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("payments.financialpaymentspage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("payments.financialpaymentspage.auto_ext_3")}
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
                      placeholder="Search payments..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white">
                  <Filter className="w-4 h-4 mr-2" />
                  {t("payments.financialpaymentspage.auto_ext_4")}
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
                <CreditCard className="w-5 h-5" />
                {t("payments.financialpaymentspage.auto_ext_5")}{filteredPayments.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredPayments.map((payment) => {
                    const { t } = useTranslation();
                  const StatusIcon = STATUS_ICONS[payment.status];
                  return (
                    <div
                      key={payment.id}
                      className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                    >
                      <div className="flex items-center gap-4">
                        <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center">
                          <CreditCard className="w-5 h-5 text-purple-400" />
                        </div>
                        <div>
                          <div className="text-white font-medium">{payment.description}</div>
                          <div className="text-sm text-gray-400 flex items-center gap-2">
                            <Calendar className="w-3 h-3" />
                            {payment.date}
                          </div>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <div className="text-sm text-gray-400">{payment.method}</div>
                        <div className={`flex items-center gap-1 ${STATUS_COLORS[payment.status]} px-2 py-1 rounded`}>
                          <StatusIcon className="w-3 h-3" />
                          <span className="text-xs font-medium">{payment.status}</span>
                        </div>
                        <div className="text-white font-bold">
                          <DollarSign className="w-4 h-4 inline" />
                          {payment.amount.toLocaleString()}
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </CardContent>
          </Card>
        </m.div>
      </div>
    </div>
  );
}
