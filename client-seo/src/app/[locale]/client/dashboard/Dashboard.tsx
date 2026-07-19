"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { Building, DollarSign, ArrowUpRight, ArrowDownRight, Sparkles, Plus, Calendar, MessageSquare, Home, CheckCircle, AlertCircle, Star, TrendingUp, LayoutDashboard, Crown } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import dynamic from "next/dynamic";
const AreaChart = dynamic(() => import("recharts").then(m => m.AreaChart), { ssr: false });
const Area = dynamic(() => import("recharts").then(m => m.Area), { ssr: false });
const ResponsiveContainer = dynamic(() => import("recharts").then(m => m.ResponsiveContainer), { ssr: false });
const XAxis = dynamic(() => import("recharts").then(m => m.XAxis), { ssr: false });
const YAxis = dynamic(() => import("recharts").then(m => m.YAxis), { ssr: false });
const RechartsTooltip = dynamic(() => import("recharts").then(m => m.Tooltip), { ssr: false });
const CartesianGrid = dynamic(() => import("recharts").then(m => m.CartesianGrid), { ssr: false });
import { useAuth } from "@/lib/auth/hooks";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";

const quickActions = [
  { icon: Plus, label: "New Property", href: "/property/new", color: "bg-blue-500/10 text-blue-400" },
  { icon: Calendar, label: "New Booking", href: "/client/bookings", color: "bg-purple-500/10 text-purple-400" },
  { icon: MessageSquare, label: "Messages", href: "/client/messages", color: "bg-emerald-500/10 text-emerald-400" },
  { icon: Home, label: "My Properties", href: "/client/properties", color: "bg-amber-500/10 text-amber-400" },
];

const recentActivities = [
  { type: "booking", title: "New booking received", property: "Villa Sunset", time: "2 hours ago", status: "pending" },
  { type: "message", title: "New inquiry", property: "Beach House", time: "4 hours ago", status: "unread" },
  { type: "booking", title: "Booking confirmed", property: "Mountain Retreat", time: "1 day ago", status: "confirmed" },
  { type: "property", title: "Property updated", property: "City Apartment", time: "2 days ago", status: "completed" },
];

const stats = (t: (key: string) => string) => [
  {
    label: t("Total Properties"),
    value: "12",
    change: "+2",
    trending: "up",
    icon: Building,
    color: "text-blue-400",
    bg: "bg-blue-500/10"
  },
  {
    label: t("Active Bookings"),
    value: "8",
    change: "+3",
    trending: "up",
    icon: Calendar,
    color: "text-purple-400",
    bg: "bg-purple-500/10"
  },
  {
    label: t("This Month Revenue"),
    value: "$12,450",
    change: "+18.5%",
    trending: "up",
    icon: DollarSign,
    color: "text-emerald-400",
    bg: "bg-emerald-500/10"
  },
  {
    label: t("Pending Messages"),
    value: "5",
    change: "-1",
    trending: "down",
    icon: MessageSquare,
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

        {/* Quick Actions */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
          className="mb-8"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white">Quick Actions</CardTitle>
              <CardDescription className="text-gray-400">Frequently used actions</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                {quickActions.map((action, index) => (
                  <motion.button
                    key={index}
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                    onClick={() => router.push(action.href)}
                    className="flex flex-col items-center gap-3 p-4 rounded-xl bg-white/5 hover:bg-white/10 transition-colors border border-white/10"
                  >
                    <div className={cn("p-3 rounded-lg", action.color)}>
                      <action.icon className="w-6 h-6" />
                    </div>
                    <span className="text-sm font-medium text-white">{action.label}</span>
                  </motion.button>
                ))}
              </div>
            </CardContent>
          </Card>
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

        {/* Recent Activities */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6 }}
          className="mb-8"
        >
          <Card className="bg-white/5 backdrop-blur-xl border-purple-500/20">
            <CardHeader>
              <CardTitle className="text-white">Recent Activities</CardTitle>
              <CardDescription className="text-gray-400">Latest updates on your properties and bookings</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {recentActivities.map((activity, index) => (
                  <div key={index} className="flex items-center gap-4 p-3 rounded-lg bg-white/5 hover:bg-white/10 transition-colors">
                    <div className={cn(
                      "p-2 rounded-lg",
                      activity.status === "pending" ? "bg-amber-500/10 text-amber-400" :
                      activity.status === "unread" ? "bg-blue-500/10 text-blue-400" :
                      activity.status === "confirmed" ? "bg-emerald-500/10 text-emerald-400" :
                      "bg-purple-500/10 text-purple-400"
                    )}>
                      {activity.status === "pending" ? <AlertCircle className="w-4 h-4" /> :
                       activity.status === "unread" ? <MessageSquare className="w-4 h-4" /> :
                       activity.status === "confirmed" ? <CheckCircle className="w-4 h-4" /> :
                       <Calendar className="w-4 h-4" />}
                    </div>
                    <div className="flex-1">
                      <div className="text-sm font-medium text-white">{activity.title}</div>
                      <div className="text-xs text-gray-400">{activity.property}</div>
                    </div>
                    <div className="text-xs text-gray-500">{activity.time}</div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>

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
                   <RechartsTooltip
                    contentStyle={{ backgroundColor: '#1f2937', border: '1px solid #4b5563', borderRadius: '8px' }}
                    itemStyle={{ color: '#f3f4f6' }}
                  />
                  <Area type="monotone" dataKey="value" stroke="#8b5cf6" fillOpacity={1} fill="url(#colorRevenue)" />
                </AreaChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
