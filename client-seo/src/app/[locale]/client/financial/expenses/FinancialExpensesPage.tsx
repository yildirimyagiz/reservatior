"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { 
  Receipt, 
  Search, 
  Filter, 
  ArrowUpRight,
  Plus,
  DollarSign,
  Calendar,
  TrendingDown
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface Expense {
  id: string;
  description: string;
  category: string;
  amount: number;
  date: string;
  status: "APPROVED" | "PENDING" | "REJECTED";
}

const mockExpenses: Expense[] = [
  { id: "1", description: "Property Maintenance", category: "Maintenance", amount: 1200, date: "2024-04-15", status: "APPROVED" },
  { id: "2", description: "Utility Bills", category: "Utilities", amount: 450, date: "2024-04-14", status: "PENDING" },
  { id: "3", description: "Cleaning Services", category: "Services", amount: 350, date: "2024-04-13", status: "APPROVED" },
  { id: "4", description: "Office Supplies", category: "Supplies", amount: 180, date: "2024-04-12", status: "REJECTED" },
  { id: "5", description: "Insurance Premium", category: "Insurance", amount: 2500, date: "2024-04-11", status: "APPROVED" }
];

const STATUS_COLORS: Record<string, string> = {
  APPROVED: "bg-green-500/20 text-green-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
  REJECTED: "bg-red-500/20 text-red-400"
};

export default function FinancialExpensesPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");

  const filteredExpenses = mockExpenses.filter(expense => 
    expense.description.toLowerCase().includes(searchTerm.toLowerCase()) ||
    expense.category.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("expenses.financialexpensespage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("expenses.financialexpensespage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("expenses.financialexpensespage.auto_ext_3")}
                                      </Button>
          </div>
        </motion.div>

        <motion.div
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
                      placeholder="Search expenses..."
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-purple-500/30 text-white placeholder:text-gray-400"
                    />
                  </div>
                </div>
                <Button variant="outline" className="bg-white/10 border-purple-500/30 text-white">
                  <Filter className="w-4 h-4 mr-2" />
                  {t("expenses.financialexpensespage.auto_ext_4")}
                                                  </Button>
                <Button className="bg-purple-600 hover:bg-purple-700">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("expenses.financialexpensespage.auto_ext_5")}
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
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <Receipt className="w-5 h-5" />
                {t("expenses.financialexpensespage.auto_ext_6")}{filteredExpenses.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredExpenses.map((expense) => (
                  <div
                    key={expense.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-purple-500/20 flex items-center justify-center">
                        <Receipt className="w-5 h-5 text-purple-400" />
                      </div>
                      <div>
                        <div className="text-white font-medium">{expense.description}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-2">
                          <span>{expense.category}</span>
                          <span>•</span>
                          <Calendar className="w-3 h-3 inline" />
                          {expense.date}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className={`px-2 py-1 rounded ${STATUS_COLORS[expense.status]}`}>
                        {expense.status}
                      </div>
                      <div className="text-white font-bold flex items-center gap-1">
                        <TrendingDown className="w-4 h-4 text-red-400" />
                        <DollarSign className="w-4 h-4 inline" />
                        {expense.amount.toLocaleString()}
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
