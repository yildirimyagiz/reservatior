"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { 
  FileText, 
  Search, 
  Filter, 
  ArrowUpRight,
  Download,
  DollarSign,
  Calendar,
  CheckCircle,
  Clock,
  XCircle
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Invoice {
  id: string;
  invoiceNumber: string;
  clientName: string;
  amount: number;
  dueDate: string;
  status: "PAID" | "PENDING" | "OVERDUE" | "CANCELLED";
}

const mockInvoices: Invoice[] = [
  { id: "1", invoiceNumber: "INV-001", clientName: "John Doe", amount: 5000, dueDate: "2024-04-15", status: "PAID" },
  { id: "2", invoiceNumber: "INV-002", clientName: "Jane Smith", amount: 3500, dueDate: "2024-04-20", status: "PENDING" },
  { id: "3", invoiceNumber: "INV-003", clientName: "Bob Wilson", amount: 2800, dueDate: "2024-04-10", status: "OVERDUE" },
  { id: "4", invoiceNumber: "INV-004", clientName: "Alice Brown", amount: 4200, dueDate: "2024-04-25", status: "PENDING" },
  { id: "5", invoiceNumber: "INV-005", clientName: "Charlie Davis", amount: 1500, dueDate: "2024-04-30", status: "CANCELLED" }
];

const STATUS_COLORS: Record<string, string> = {
  PAID: "bg-green-500/20 text-green-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
  OVERDUE: "bg-red-500/20 text-red-400",
  CANCELLED: "bg-gray-500/20 text-gray-400"
};

const STATUS_ICONS: Record<string, React.ComponentType<{ className?: string }>> = {
  PAID: CheckCircle,
  PENDING: Clock,
  OVERDUE: XCircle,
  CANCELLED: XCircle
};

export default function FinancialInvoicesPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredInvoices = mockInvoices.filter(invoice => 
    invoice.invoiceNumber.toLowerCase().includes(searchTerm.toLowerCase()) ||
    invoice.clientName.toLowerCase().includes(searchTerm.toLowerCase())
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
              <h1 className="text-3xl font-bold text-white mb-2">{t("invoices.financialinvoicespage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("invoices.financialinvoicespage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("invoices.financialinvoicespage.auto_ext_3")}
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
                      placeholder="Search invoices..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white">
                  <Filter className="w-4 h-4 mr-2" />
                  {t("invoices.financialinvoicespage.auto_ext_4")}
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
                <FileText className="w-5 h-5" />
                {t("invoices.financialinvoicespage.auto_ext_5")}{filteredInvoices.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredInvoices.map((invoice) => {
                    const { t } = useTranslation();
                  const StatusIcon = STATUS_ICONS[invoice.status];
                  return (
                    <div
                      key={invoice.id}
                      className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                    >
                      <div className="flex items-center gap-4">
                        <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center">
                          <FileText className="w-5 h-5 text-purple-400" />
                        </div>
                        <div>
                          <div className="text-white font-medium">{invoice.invoiceNumber}</div>
                          <div className="text-sm text-gray-400">{invoice.clientName}</div>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <div className="text-sm text-gray-400 flex items-center gap-1">
                          <Calendar className="w-3 h-3" />
                          {invoice.dueDate}
                        </div>
                        <div className={`flex items-center gap-1 ${STATUS_COLORS[invoice.status]} px-2 py-1 rounded`}>
                          <StatusIcon className="w-3 h-3" />
                          <span className="text-xs font-medium">{invoice.status}</span>
                        </div>
                        <div className="text-white font-bold">
                          <DollarSign className="w-4 h-4 inline" />
                          {invoice.amount.toLocaleString()}
                        </div>
                        <Button variant="ghost" size="icon" className="h-8 w-8">
                          <Download className="w-4 h-4" />
                        </Button>
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
