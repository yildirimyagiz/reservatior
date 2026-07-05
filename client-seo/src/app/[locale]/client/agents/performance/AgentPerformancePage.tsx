"use client";

import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { 
  TrendingUp, 
  ArrowUpRight,
  DollarSign,
  Users,
  Building2,
  Star,
  Calendar
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";

const performanceMetrics = [
  {
    title: "Total Sales",
    value: "$2.4M",
    change: "+12.5%",
    icon: DollarSign,
    color: "text-green-400"
  },
  {
    title: "Properties Sold",
    value: "24",
    change: "+8.3%",
    icon: Building2,
    color: "text-blue-400"
  },
  {
    title: "Active Clients",
    value: "45",
    change: "+15.2%",
    icon: Users,
    color: "text-purple-400"
  },
  {
    title: "Client Rating",
    value: "4.9",
    change: "+0.2",
    icon: Star,
    color: "text-yellow-400"
  }
];

const recentActivity = [
  { id: 1, type: "SALE", description: "Sold Luxury Villa", amount: "$1.2M", date: "2024-04-15" },
  { id: 2, type: "VIEWING", description: "Property Viewing", amount: "-", date: "2024-04-14" },
  { id: 3, type: "CONTRACT", description: "Contract Signed", amount: "$850K", date: "2024-04-13" },
  { id: 4, type: "MEETING", description: "Client Meeting", amount: "-", date: "2024-04-12" }
];

const ACTIVITY_COLORS: Record<string, string> = {
  SALE: "bg-green-500/20 text-green-400",
  VIEWING: "bg-blue-500/20 text-blue-400",
  CONTRACT: "bg-purple-500/20 text-purple-400",
  MEETING: "bg-amber-500/20 text-amber-400"
};

export default function AgentPerformancePage() {
    const { t } = useTranslation();
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
              <h1 className="text-3xl font-bold text-white mb-2">{t("performance.agentperformancepage.auto_ext_1")}</h1>
              <p className="text-gray-400">{t("performance.agentperformancepage.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/dashboard')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("performance.agentperformancepage.auto_ext_3")}
                                      </Button>
          </div>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8"
        >
          {performanceMetrics.map((metric, idx) => (
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
                <TrendingUp className="w-5 h-5" />
                {t("performance.agentperformancepage.auto_ext_4")}
                                            </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {recentActivity.map((activity) => (
                  <div
                    key={activity.id}
                    className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className={`px-2 py-1 rounded ${ACTIVITY_COLORS[activity.type]}`}>
                        {activity.type}
                      </div>
                      <div>
                        <div className="text-white font-medium">{activity.description}</div>
                        <div className="text-sm text-gray-400 flex items-center gap-1">
                          <Calendar className="w-3 h-3" />
                          {activity.date}
                        </div>
                      </div>
                    </div>
                    <div className="text-white font-bold">{activity.amount}</div>
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
