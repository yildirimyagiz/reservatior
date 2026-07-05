"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { TrendingUp, TrendingDown, DollarSign, CreditCard, ArrowUpRight, Wallet, Receipt, PieChart } from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

interface FinancialRecord {
  id: string;
  type: "income" | "expense";
  category: string;
  amount: number;
  date: string;
  status: "completed" | "pending";
  description: string;
}

const mockFinancials: FinancialRecord[] = [
  { id: "1", type: "income", category: "Booking", amount: 2500, date: "2024-07-15", status: "completed", description: "Property rental income" },
  { id: "2", type: "expense", category: "Maintenance", amount: 350, date: "2024-07-14", status: "completed", description: "Plumbing repair" },
  { id: "3", type: "income", category: "Commission", amount: 450, date: "2024-07-13", status: "pending", description: "Agent commission" },
  { id: "4", type: "expense", category: "Utilities", amount: 180, date: "2024-07-12", status: "completed", description: "Electricity bill" },
  { id: "5", type: "income", category: "Booking", amount: 1800, date: "2024-07-10", status: "completed", description: "Property rental income" },
];

export default function FinancialPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [activeTab, setActiveTab] = useState("overview");

  const totalIncome = mockFinancials.filter(f => f.type === "income").reduce((sum, f) => sum + f.amount, 0);
  const totalExpenses = mockFinancials.filter(f => f.type === "expense").reduce((sum, f) => sum + f.amount, 0);
  const netProfit = totalIncome - totalExpenses;
  const pendingAmount = mockFinancials.filter(f => f.status === "pending").reduce((sum, f) => sum + f.amount, 0);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-purple-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("financial.financialpage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("financial.financialpage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("financial.financialpage.auto_ext_3")}
                                      </Button>
          </div>
        </motion.div>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("financial.financialpage.auto_ext_4")}</div>
                    <div className="text-2xl font-bold text-white">${totalIncome.toLocaleString()}</div>
                    <div className="flex items-center text-green-400 text-sm mt-1">
                      <TrendingUp className="w-4 h-4 mr-1" />
                      +12.5%
                    </div>
                  </div>
                  <div className="p-3 rounded-lg bg-green-500/10">
                    <DollarSign className="w-6 h-6 text-green-400" />
                  </div>
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
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("financial.financialpage.auto_ext_5")}</div>
                    <div className="text-2xl font-bold text-white">${totalExpenses.toLocaleString()}</div>
                    <div className="flex items-center text-red-400 text-sm mt-1">
                      <TrendingDown className="w-4 h-4 mr-1" />
                      -3.2%
                    </div>
                  </div>
                  <div className="p-3 rounded-lg bg-red-500/10">
                    <CreditCard className="w-6 h-6 text-red-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("financial.financialpage.auto_ext_6")}</div>
                    <div className="text-2xl font-bold text-white">${netProfit.toLocaleString()}</div>
                    <div className="flex items-center text-green-400 text-sm mt-1">
                      <TrendingUp className="w-4 h-4 mr-1" />
                      +8.7%
                    </div>
                  </div>
                  <div className="p-3 rounded-lg bg-purple-500/10">
                    <Wallet className="w-6 h-6 text-purple-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.4 }}
          >
            <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between">
                  <div>
                    <div className="text-sm text-gray-400 mb-1">{t("financial.financialpage.auto_ext_7")}</div>
                    <div className="text-2xl font-bold text-white">${pendingAmount.toLocaleString()}</div>
                    <div className="text-yellow-400 text-sm mt-1">{t("financial.financialpage.auto_ext_8")}</div>
                  </div>
                  <div className="p-3 rounded-lg bg-yellow-500/10">
                    <Receipt className="w-6 h-6 text-yellow-400" />
                  </div>
                </div>
              </CardContent>
            </Card>
          </motion.div>
        </div>

        {/* Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-6">
          <TabsList className="bg-white/5 border-purple-500/20">
            <TabsTrigger value="overview" className="data-[state=active]:bg-purple-600">{t("financial.financialpage.auto_ext_9")}</TabsTrigger>
            <TabsTrigger value="transactions" className="data-[state=active]:bg-purple-600">{t("financial.financialpage.auto_ext_10")}</TabsTrigger>
            <TabsTrigger value="reports" className="data-[state=active]:bg-purple-600">{t("financial.financialpage.auto_ext_11")}</TabsTrigger>
          </TabsList>

          <TabsContent value="overview">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
                <CardHeader>
                  <CardTitle className="text-white">{t("financial.financialpage.auto_ext_12")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <Table>
                    <TableHeader>
                      <TableRow className="border-purple-500/20">
                        <TableHead className="text-gray-400">{t("financial.financialpage.auto_ext_13")}</TableHead>
                        <TableHead className="text-gray-400">{t("financial.financialpage.auto_ext_14")}</TableHead>
                        <TableHead className="text-gray-400">{t("financial.financialpage.auto_ext_15")}</TableHead>
                        <TableHead className="text-gray-400">{t("financial.financialpage.auto_ext_16")}</TableHead>
                        <TableHead className="text-gray-400 text-right">{t("financial.financialpage.auto_ext_17")}</TableHead>
                      </TableRow>
                    </TableHeader>
                    <TableBody>
                      {mockFinancials.map((record) => (
                        <TableRow key={record.id} className="border-purple-500/10">
                          <TableCell className="text-white">{record.description}</TableCell>
                          <TableCell className="text-gray-300">{record.category}</TableCell>
                          <TableCell className="text-gray-300">{record.date}</TableCell>
                          <TableCell>
                            <Badge
                              variant="outline"
                              className={
                                record.status === "completed"
                                  ? "bg-green-500/20 text-green-400 border-green-500/30"
                                  : "bg-yellow-500/20 text-yellow-400 border-yellow-500/30"
                              }
                            >
                              {record.status}
                            </Badge>
                          </TableCell>
                          <TableCell className={`text-right font-medium ${record.type === "income" ? "text-green-400" : "text-red-400"}`}>
                            {record.type === "income" ? "+" : "-"}${record.amount.toLocaleString()}
                          </TableCell>
                        </TableRow>
                      ))}
                    </TableBody>
                  </Table>
                </CardContent>
              </Card>
            </motion.div>
          </TabsContent>

          <TabsContent value="transactions">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
                <CardHeader>
                  <CardTitle className="text-white">{t("financial.financialpage.auto_ext_18")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-center py-12 text-gray-400">
                    <PieChart className="w-12 h-12 mx-auto mb-4 text-purple-400" />
                    <p>{t("financial.financialpage.auto_ext_19")}</p>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          </TabsContent>

          <TabsContent value="reports">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
                <CardHeader>
                  <CardTitle className="text-white">{t("financial.financialpage.auto_ext_20")}</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="text-center py-12 text-gray-400">
                    <Receipt className="w-12 h-12 mx-auto mb-4 text-purple-400" />
                    <p>{t("financial.financialpage.auto_ext_21")}</p>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
