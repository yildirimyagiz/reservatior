"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { Building, Users, DollarSign, ArrowUpRight, ArrowDownRight, Brain, Sparkles, TrendingUp, LayoutDashboard, Crown, Star } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { AreaChart, Area, ResponsiveContainer, XAxis, YAxis, Tooltip, CartesianGrid } from "recharts";
import { useAuth } from "@/lib/auth/hooks";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";

const stats = (t: (key: string) => string) => [
  {
    label: t("dashboardRevenue"),
    value: "$45,231",
    change: "+12.5%",
    trending: "up",
    icon: DollarSign,
    color: "text-emerald-400",
    bg: "bg-emerald-500/10"
  },
  {
    label: t("client.dashboard.stats.nodes"),
    value: "128",
    change: "+4.3%",
    trending: "up",
    icon: Building,
    color: "text-blue-400",
    bg: "bg-blue-500/10"
  },
  {
    label: t("engagement"),
    value: "342",
    change: "-2.1%",
    trending: "down",
    icon: Users,
    color: "text-purple-400",
    bg: "bg-purple-500/10"
  },
  {
    label: t("verification"),
    value: "98.2%",
    change: "+0.5%",
    trending: "up",
    icon: Brain,
    color: "text-amber-400",
    bg: "bg-amber-500/10"
  }
];

const revenueData = [
  { name: "Mon", value: 4000 },
  { name: "Tue", value: 3000 },
  { name: "Wed", value: 5000 },
  { name: "Thu", value: 2780 },
  { name: "Fri", value: 1890 },
  { name: "Sat", value: 2390 },
  { name: "Sun", value: 3490 }
];

const PLAN_CONFIG: Record<string, { label: string; icon: React.ComponentType<{ className?: string }>; color: string; maxProperties: number; maxUsers: number; aiFeatures: boolean }> = {
  "starter-10": { label: "Starter", icon: Star, color: "text-slate-400", maxProperties: 10, maxUsers: 1, aiFeatures: false },
  "growth-25": { label: "Growth", icon: TrendingUp, color: "text-blue-400", maxProperties: 25, maxUsers: 3, aiFeatures: false },
  "professional-50": { label: "Professional", icon: Crown, color: "text-purple-400", maxProperties: 50, maxUsers: 5, aiFeatures: true },
  "agency-100": { label: "Agency", icon: LayoutDashboard, color: "text-amber-400", maxProperties: 100, maxUsers: 10, aiFeatures: true },
  "enterprise": { label: "Enterprise", icon: Crown, color: "text-emerald-400", maxProperties: 9999, maxUsers: 999, aiFeatures: true },
};

export default function Dashboard() {
  const { t } = useTranslation();
  const { user } = useAuth();
  const router = useRouter();
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) return null;

  const currentStats = stats(t);
  const IconComponent = PLAN_CONFIG["professional-50"]?.icon;

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
              <h1 className="text-3xl font-bold text-white mb-2">
                {t("dashboard.dashboard.auto_ext_1")} {user?.name || 'User'}
              </h1>
              <p className="text-gray-400">{t("dashboard.dashboard.auto_ext_2")}</p>
            </div>
            <Button
              onClick={() => router.push('/ai-search')}
              className="bg-purple-600 hover:bg-purple-700"
            >
              <Sparkles className="w-4 h-4 mr-2" />
              {t("dashboard.dashboard.auto_ext_3")}
                                      </Button>
          </div>
        </motion.div>

        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          {currentStats.map((stat, index) => (
            <motion.div
              key={index}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
            >
              <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20 hover:bg-white/10 transition-colors">
                <CardContent className="p-6">
                  <div className="flex items-center justify-between mb-4">
                    <div className={cn("p-3 rounded-lg", stat.bg)}>
                      <stat.icon className={cn("w-6 h-6", stat.color)} />
                    </div>
                    <Badge
                      variant="outline"
                      className={cn(
                        "border",
                        stat.trending === "up" ? "border-green-500/30 text-green-400" : "border-red-500/30 text-red-400"
                      )}
                    >
                      {stat.trending === "up" ? <ArrowUpRight className="w-3 h-3 mr-1" /> : <ArrowDownRight className="w-3 h-3 mr-1" />}
                      {stat.change}
                    </Badge>
                  </div>
                  <div className="text-2xl font-bold text-white mb-1">{stat.value}</div>
                  <div className="text-sm text-gray-400">{stat.label}</div>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>

        {/* Revenue Chart */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4 }}
          className="mb-8"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white">{t("dashboard.dashboard.auto_ext_4")}</CardTitle>
              <CardDescription className="text-gray-400">{t("dashboard.dashboard.auto_ext_5")}</CardDescription>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={300}>
                <AreaChart data={revenueData}>
                  <defs>
                    <linearGradient id="colorRevenue" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#8b5cf6" stopOpacity={0.3} />
                      <stop offset="95%" stopColor="#8b5cf6" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#374151" />
                  <XAxis dataKey="name" stroke="#9ca3af" />
                  <YAxis stroke="#9ca3af" />
                  <Tooltip
                    contentStyle={{ backgroundColor: '#1f2937', border: '1px solid #4b5563', borderRadius: '8px' }}
                    itemStyle={{ color: '#f3f4f6' }}
                  />
                  <Area type="monotone" dataKey="value" stroke="#8b5cf6" fillOpacity={1} fill="url(#colorRevenue)" />
                </AreaChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>
        </motion.div>

        {/* Plan Usage */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.5 }}
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white">{t("dashboard.dashboard.auto_ext_6")}</CardTitle>
              <CardDescription className="text-gray-400">{t("dashboard.dashboard.auto_ext_7")}</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="flex items-center gap-4 mb-6">
                <div className="p-3 rounded-lg bg-purple-500/10">
                  {IconComponent && <IconComponent className="w-6 h-6 text-purple-400" />}
                </div>
                <div>
                  <div className="text-lg font-bold text-white">{t("dashboard.dashboard.auto_ext_8")}</div>
                  <div className="text-sm text-gray-400">{t("dashboard.dashboard.auto_ext_9")}</div>
                </div>
              </div>
              <div className="space-y-4">
                <div>
                  <div className="flex justify-between text-sm mb-2">
                    <span className="text-gray-400">{t("dashboard.dashboard.auto_ext_10")}</span>
                    <span className="text-white">12 / 50</span>
                  </div>
                  <Progress value={24} className="bg-purple-500/20" />
                </div>
                <div>
                  <div className="flex justify-between text-sm mb-2">
                    <span className="text-gray-400">{t("dashboard.dashboard.auto_ext_11")}</span>
                    <span className="text-white">2 / 5</span>
                  </div>
                  <Progress value={40} className="bg-purple-500/20" />
                </div>
              </div>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
