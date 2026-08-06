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
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

const financialMetrics = [
  {
    title: "Total Revenue",
    value: "$2.4M",
    change: "+12.5%",
    trend: "up",
    icon: DollarSign,
    color: "text-blue-400"
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
    color: "text-muted-foreground"
  },
  {
    title: "Pending Payments",
    value: "$45K",
    change: "+8.1%",
    trend: "up",
    icon: CreditCard,
    color: "text-warning"
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
    const { t } = useTranslation();
  const router = useRouter();

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        {/* Header */}
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_financial_title")}</h1>
              <p className="text-muted-foreground">{t("admin_financial_description")}</p>
            </div>
            <Button
              onClick={() => router.push('/admin/dashboard')}
              className="bg-primary hover:bg-primary/90"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_financial_back_to_dashboard")}
                                      </Button>
          </div>
        </m.div>

        {/* Metrics */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8"
        >
          {financialMetrics.map((metric, idx) => (
            <Card key={idx} className="bg-card border-border">
              <CardContent className="p-6">
                <div className="flex items-center justify-between mb-4">
                  <metric.icon className={`w-6 h-6 ${metric.color}`} />
                  <div className={`flex items-center text-sm ${metric.trend === 'up' ? 'text-blue-400' : 'text-red-400'}`}>
                    {metric.trend === 'up' ? <TrendingUp className="w-4 h-4 mr-1" /> : <TrendingDown className="w-4 h-4 mr-1" />}
                    {metric.change}
                  </div>
                </div>
                <div className="text-2xl font-bold text-foreground mb-1">{metric.value}</div>
                <div className="text-sm text-muted-foreground">{metric.title}</div>
              </CardContent>
            </Card>
          ))}
        </m.div>

        {/* Recent Transactions */}
        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground">{t("admin_financial_recent_transactions")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {recentTransactions.map((transaction) => (
                  <div
                    key={transaction.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg"
                  >
                    <div>
                      <div className="text-foreground font-medium">{transaction.description}</div>
                      <div className="text-sm text-muted-foreground">{transaction.date}</div>
                    </div>
                    <div className={`font-bold ${transaction.type === 'RECEIPT' ? 'text-blue-400' : 'text-red-400'}`}>
                      {transaction.type === 'RECEIPT' ? '+' : '-'}${transaction.amount.toLocaleString()}
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
