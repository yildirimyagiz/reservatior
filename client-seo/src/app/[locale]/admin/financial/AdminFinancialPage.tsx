"use client";

import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { 
  DollarSign, 
  TrendingUp, 
  TrendingDown, 
  ArrowUpRight,
  Wallet,
  CreditCard,
  PiggyBank
} from "lucide-react";
import { motion } from "framer-motion";

const financialMetrics = [
  {
    title: "Total Revenue",
    value: "$2.4M",
    change: "+12.5%",
    trend: "up",
    icon: DollarSign,
    color: "text-green-400"
  },
  {
    title: "Total Expenses",
    value: "$1.8M",
    change: "-5.2%",
    trend: "down",
    icon: Wallet,
    color: "text-red-400"
  },
  {
    title: "Net Profit",
    value: "$600K",
    change: "+25.3%",
    trend: "up",
    icon: PiggyBank,
    color: "text-blue-400"
  },
  {
    title: "Pending Payments",
    value: "$45K",
    change: "+8.1%",
    trend: "up",
    icon: CreditCard,
    color: "text-amber-400"
  }
];

const recentTransactions = [
  { id: 1, type: "RECEIPT", description: "Property Rental Payment", amount: 5000, date: "2024-04-15" },
  { id: 2, type: "EXPENSE", description: "Maintenance Services", amount: 1200, date: "2024-04-14" },
  { id: 3, type: "RECEIPT", description: "Booking Commission", amount: 350, date: "2024-04-13" },
  { id: 4, type: "EXPENSE", description: "Utility Bills", amount: 800, date: "2024-04-12" },
  { id: 5, type: "RECEIPT", description: "Property Sale", amount: 150000, date: "2024-04-11" }
];

export default function AdminFinancialPage() {
  const router = useRouter();

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
              <h1 className="text-3xl font-bold text-white mb-2">Financial Overview</h1>
              <p className="text-gray-400">Track revenue, expenses, and profits</p>
            </div>
            <Button
              onClick={() => router.push('/admin/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              Dashboard
            </Button>
          </div>
        </motion.div>

        {/* Metrics */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8"
        >
          {financialMetrics.map((metric, idx) => (
            <Card key={idx} className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between mb-4">
                  <metric.icon className={`w-6 h-6 ${metric.color}`} />
                  <div className={`flex items-center text-sm ${metric.trend === 'up' ? 'text-green-400' : 'text-red-400'}`}>
                    {metric.trend === 'up' ? <TrendingUp className="w-4 h-4 mr-1" /> : <TrendingDown className="w-4 h-4 mr-1" />}
                    {metric.change}
                  </div>
                </div>
                <div className="text-2xl font-bold text-white mb-1">{metric.value}</div>
                <div className="text-sm text-gray-400">{metric.title}</div>
              </CardContent>
            </Card>
          ))}
        </motion.div>

        {/* Recent Transactions */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white">Recent Transactions</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {recentTransactions.map((transaction) => (
                  <div
                    key={transaction.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg"
                  >
                    <div>
                      <div className="text-white font-medium">{transaction.description}</div>
                      <div className="text-sm text-gray-400">{transaction.date}</div>
                    </div>
                    <div className={`font-bold ${transaction.type === 'RECEIPT' ? 'text-green-400' : 'text-red-400'}`}>
                      {transaction.type === 'RECEIPT' ? '+' : '-'}${transaction.amount.toLocaleString()}
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
