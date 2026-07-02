"use client";

import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { 
  BarChart3, 
  ArrowUpRight,
  TrendingUp,
  DollarSign,
  PieChart,
  Download
} from "lucide-react";
import { motion } from "framer-motion";

const reportMetrics = [
  {
    title: "Total Revenue",
    value: "$2.4M",
    change: "+12.5%",
    icon: DollarSign,
    color: "text-green-400"
  },
  {
    title: "Total Expenses",
    value: "$1.8M",
    change: "-5.2%",
    icon: TrendingUp,
    color: "text-red-400"
  },
  {
    title: "Net Profit",
    value: "$600K",
    change: "+25.3%",
    icon: PieChart,
    color: "text-blue-400"
  },
  {
    title: "Growth Rate",
    value: "18.7%",
    change: "+3.2%",
    icon: BarChart3,
    color: "text-purple-400"
  }
];

const recentReports = [
  { id: 1, name: "Monthly Revenue Report", date: "2024-04-15", type: "REVENUE" },
  { id: 2, name: "Expense Analysis", date: "2024-04-14", type: "EXPENSE" },
  { id: 3, name: "Profit & Loss Statement", date: "2024-04-13", type: "P&L" },
  { id: 4, name: "Cash Flow Report", date: "2024-04-12", type: "CASH_FLOW" }
];

export default function FinancialReportsPage() {
  const router = useRouter();

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
              <h1 className="text-3xl font-bold text-white mb-2">Financial Reports</h1>
              <p className="text-gray-400">View and generate financial reports</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              Dashboard
            </Button>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8"
        >
          {reportMetrics.map((metric, idx) => (
            <Card key={idx} className="bg-white/5 backdrop-blur-xl border-purple-500/20">
              <CardContent className="p-6">
                <div className="flex items-center justify-between mb-4">
                  <metric.icon className={`w-6 h-6 ${metric.color}`} />
                  <div className={`text-sm ${metric.change.startsWith('+') ? 'text-green-400' : 'text-red-400'}`}>
                    {metric.change}
                  </div>
                </div>
                <div className="text-2xl font-bold text-white mb-1">{metric.value}</div>
                <div className="text-sm text-gray-400">{metric.title}</div>
              </CardContent>
            </Card>
          ))}
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <BarChart3 className="w-5 h-5" />
                Recent Reports
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {recentReports.map((report) => (
                  <div
                    key={report.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div>
                      <div className="text-white font-medium">{report.name}</div>
                      <div className="text-sm text-gray-400">{report.date}</div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className="text-sm text-gray-400">{report.type}</div>
                      <Button variant="ghost" size="icon" className="h-8 w-8">
                        <Download className="w-4 h-4" />
                      </Button>
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
