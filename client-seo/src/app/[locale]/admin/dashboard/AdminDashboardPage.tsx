"use client";

import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { 
  Building, 
  Users, 
  DollarSign, 
  Activity, 
  ArrowUpRight,
  ArrowDownRight,
  ShieldCheck,
  TrendingUp,
  Calendar,
  BarChart3,
  Clock,
  CheckCircle2,
  AlertCircle,
  FileText,
  Zap
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";

const metrics = [
  {
    title: "Total Revenue",
    value: "$2.4M",
    change: "+12.5%",
    trend: "up" as const,
    icon: DollarSign,
    gradient: "from-emerald-500/20 to-emerald-600/5",
    iconBg: "bg-emerald-500/15",
    iconColor: "text-emerald-500",
  },
  {
    title: "Properties",
    value: "1,234",
    change: "+8.2%",
    trend: "up" as const,
    icon: Building,
    gradient: "from-slate-500/20 to-slate-600/5",
    iconBg: "bg-slate-500/15",
    iconColor: "text-slate-500",
  },
  {
    title: "Active Users",
    value: "8,567",
    change: "+15.3%",
    trend: "up" as const,
    icon: Users,
    gradient: "from-slate-500/20 to-slate-600/5",
    iconBg: "bg-slate-500/15",
    iconColor: "text-slate-500",
  },
  {
    title: "Tasks Completed",
    value: "2,890",
    change: "-2.1%",
    trend: "down" as const,
    icon: Activity,
    gradient: "from-amber-500/20 to-amber-600/5",
    iconBg: "bg-amber-500/15",
    iconColor: "text-amber-500",
  }
];

const recentActivities = [
  { id: 1, action: "New property listed", time: "2 hours ago", user: "John Doe", initials: "JD", type: "property" },
  { id: 2, action: "Booking confirmed", time: "4 hours ago", user: "Jane Smith", initials: "JS", type: "booking" },
  { id: 3, action: "Payment received", time: "6 hours ago", user: "Bob Wilson", initials: "BW", type: "payment" },
  { id: 4, action: "User registered", time: "8 hours ago", user: "Alice Brown", initials: "AB", type: "user" },
  { id: 5, action: "Maintenance request", time: "12 hours ago", user: "Tom Davis", initials: "TD", type: "alert" },
];

const quickActions = [
  { icon: Building, label: "Properties", href: "/admin/properties", color: "text-slate-500", bg: "bg-slate-500/10 hover:bg-slate-500/20" },
  { icon: Users, label: "Users", href: "/admin/users", color: "text-slate-500", bg: "bg-slate-500/10 hover:bg-slate-500/20" },
  { icon: DollarSign, label: "Financial", href: "/admin/financial", color: "text-emerald-500", bg: "bg-emerald-500/10 hover:bg-emerald-500/20" },
  { icon: ShieldCheck, label: "Security", href: "/admin/security", color: "text-amber-500", bg: "bg-amber-500/10 hover:bg-amber-500/20" },
  { icon: FileText, label: "Reports", href: "/admin/reports", color: "text-cyan-500", bg: "bg-cyan-500/10 hover:bg-cyan-500/20" },
  { icon: Zap, label: "AI Dashboard", href: "/admin/ai", color: "text-pink-500", bg: "bg-pink-500/10 hover:bg-pink-500/20" },
];

const systemStatus = [
  { label: "API Server", status: "online", uptime: "99.98%" },
  { label: "Database", status: "online", uptime: "99.99%" },
  { label: "CDN", status: "online", uptime: "100%" },
  { label: "Email Service", status: "degraded", uptime: "98.5%" },
];

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.06 }
  }
};

const item = {
  hidden: { opacity: 0, y: 16 },
  show: { opacity: 1, y: 0, transition: { duration: 0.4, ease: "easeOut" as const } }
};

export default function AdminDashboardPage() {
  const { t } = useTranslation();
  const router = useRouter();

  const getActivityIcon = (type: string) => {
    switch (type) {
      case "property": return <Building className="w-4 h-4 text-slate-500" />;
      case "booking": return <Calendar className="w-4 h-4 text-emerald-500" />;
      case "payment": return <DollarSign className="w-4 h-4 text-green-500" />;
      case "user": return <Users className="w-4 h-4 text-slate-500" />;
      case "alert": return <AlertCircle className="w-4 h-4 text-amber-500" />;
      default: return <Activity className="w-4 h-4 text-muted-foreground" />;
    }
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="px-6 py-8 max-w-[1600px] mx-auto">
        {/* Header */}
        <m.div
          initial={{ opacity: 0, y: -12 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.4 }}
          className="mb-8 flex items-center justify-between"
        >
          <div>
            <h1 className="text-2xl font-bold text-foreground tracking-tight">{t("admin_dashboard_title", "Admin Dashboard")}</h1>
            <p className="text-muted-foreground text-sm mt-1">{t("admin_dashboard_desc", "Overview of your platform metrics and activity")}</p>
          </div>
          <div className="flex items-center gap-3">
            <Badge variant="outline" className="border-emerald-500/30 text-emerald-500 bg-emerald-500/10 px-3 py-1">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-500 mr-2 animate-pulse" />
              {t("admin_auto_all_systems_online", "All Systems Online")}</Badge>
            <Button
              onClick={() => router.push('/')}
              variant="outline"
              size="sm"
              className="border-border text-foreground hover:bg-accent"
            >
              <ArrowUpRight className="w-4 h-4 mr-1.5" />
              {t("admin_view_site", "View Site")}
            </Button>
          </div>
        </m.div>

        {/* Metrics Grid */}
        <m.div
          variants={container}
          initial="hidden"
          animate="show"
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6"
        >
          {metrics.map((metric, idx) => (
            <m.div key={idx} variants={item}>
              <Card className="bg-card border-border overflow-hidden group hover:border-primary/30 transition-all duration-300">
                <CardContent className="p-5">
                  <div className="flex items-start justify-between mb-3">
                    <div className={`p-2.5 rounded-xl ${metric.iconBg} transition-transform group-hover:scale-110 duration-300`}>
                      <metric.icon className={`w-5 h-5 ${metric.iconColor}`} />
                    </div>
                    <div className={`flex items-center gap-1 text-xs font-semibold px-2 py-1 rounded-full ${
                      metric.trend === 'up' 
                        ? 'text-emerald-500 bg-emerald-500/10' 
                        : 'text-red-500 bg-red-500/10'
                    }`}>
                      {metric.trend === 'up' ? <ArrowUpRight className="w-3 h-3" /> : <ArrowDownRight className="w-3 h-3" />}
                      {metric.change}
                    </div>
                  </div>
                  <div className="text-2xl font-bold text-foreground tracking-tight">{metric.value}</div>
                  <div className="text-xs text-muted-foreground mt-1 font-medium">{t(`admin_dashboard_metric_${metric.title.toLowerCase().replace(/\s+/g, '_')}`, metric.title)}</div>
                  {/* Subtle gradient accent bar */}
                  <div className={`h-0.5 mt-4 rounded-full bg-gradient-to-r ${metric.gradient} opacity-60`} />
                </CardContent>
              </Card>
            </m.div>
          ))}
        </m.div>

        {/* Main Content Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Recent Activities — wider column */}
          <m.div
            initial={{ opacity: 0, y: 16 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.3, duration: 0.4 }}
            className="lg:col-span-2"
          >
            <Card className="bg-card border-border h-full">
              <CardHeader className="pb-3">
                <div className="flex items-center justify-between">
                  <CardTitle className="text-foreground text-base font-semibold flex items-center gap-2">
                    <Clock className="w-4 h-4 text-muted-foreground" />
                    {t("recent_activities", "Recent Activities")}
                  </CardTitle>
                  <Button variant="ghost" size="sm" className="text-xs text-muted-foreground hover:text-foreground">
                    {t("admin_dashboard_view_all", "View All")}</Button>
                </div>
              </CardHeader>
              <CardContent className="pb-5">
                <div className="space-y-1">
                  {recentActivities.map((activity) => (
                    <div
                      key={activity.id}
                      className="flex items-center gap-3 p-3 rounded-xl hover:bg-accent/50 transition-colors group cursor-pointer"
                    >
                      <Avatar className="h-9 w-9 shrink-0">
                        <AvatarFallback className="bg-primary/10 text-primary text-xs font-semibold border border-primary/20">
                          {activity.initials}
                        </AvatarFallback>
                      </Avatar>
                      <div className="flex-1 min-w-0">
                        <div className="text-sm font-medium text-foreground">{t(`admin_dashboard_activity_${activity.action.toLowerCase().replace(/\s+/g, '_')}`, activity.action)}</div>
                        <div className="text-xs text-muted-foreground">{activity.user}</div>
                      </div>
                      <div className="flex items-center gap-2 shrink-0">
                        <div className="p-1.5 rounded-lg bg-accent/50">
                          {getActivityIcon(activity.type)}
                        </div>
                        <span className="text-xs text-muted-foreground whitespace-nowrap">{t(`admin_dashboard_time_${activity.time.toLowerCase().replace(/\s+/g, '_')}`, activity.time)}</span>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </m.div>

          {/* Right Column */}
          <div className="space-y-6">
            {/* Quick Actions */}
            <m.div
              initial={{ opacity: 0, y: 16 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.4, duration: 0.4 }}
            >
              <Card className="bg-card border-border">
                <CardHeader className="pb-3">
                  <CardTitle className="text-foreground text-base font-semibold flex items-center gap-2">
                    <Zap className="w-4 h-4 text-muted-foreground" />
                    {t("quick_actions", "Quick Actions")}
                  </CardTitle>
                </CardHeader>
                <CardContent className="pb-5">
                  <div className="grid grid-cols-2 gap-2">
                    {quickActions.map((action, idx) => (
                      <Button
                        key={idx}
                        variant="ghost"
                        className={`h-auto py-4 flex-col gap-2 rounded-xl border border-transparent hover:border-border ${action.bg} transition-all duration-200`}
                        onClick={() => router.push(action.href)}
                      >
                        <action.icon className={`w-5 h-5 ${action.color}`} />
                        <span className="text-xs font-medium text-foreground">{t(`admin_dashboard_action_${action.label.toLowerCase().replace(/\s+/g, '_')}`, action.label)}</span>
                      </Button>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </m.div>

            {/* System Status */}
            <m.div
              initial={{ opacity: 0, y: 16 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.5, duration: 0.4 }}
            >
              <Card className="bg-card border-border">
                <CardHeader className="pb-3">
                  <CardTitle className="text-foreground text-base font-semibold flex items-center gap-2">
                    <BarChart3 className="w-4 h-4 text-muted-foreground" />
                    {t("system_status", "System Status")}
                  </CardTitle>
                </CardHeader>
                <CardContent className="pb-5">
                  <div className="space-y-3">
                    {systemStatus.map((service, idx) => (
                      <div key={idx} className="flex items-center justify-between">
                        <div className="flex items-center gap-2.5">
                          {service.status === "online" ? (
                            <CheckCircle2 className="w-4 h-4 text-emerald-500" />
                          ) : (
                            <AlertCircle className="w-4 h-4 text-amber-500" />
                          )}
                          <span className="text-sm text-foreground font-medium">{t(`admin_dashboard_status_${service.label.toLowerCase().replace(/\s+/g, '_')}`, service.label)}</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <span className="text-xs text-muted-foreground">{service.uptime}</span>
                          <Badge 
                            variant="outline" 
                            className={`text-[10px] px-1.5 py-0 ${
                              service.status === "online"
                                ? "border-emerald-500/30 text-emerald-500 bg-emerald-500/10"
                                : "border-amber-500/30 text-amber-500 bg-amber-500/10"
                            }`}
                          >
                            {t(`admin_status_${service.status}`, service.status)}
                          </Badge>
                        </div>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            </m.div>
          </div>
        </div>

        {/* Performance Overview Bar */}
        <m.div
          initial={{ opacity: 0, y: 16 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.6, duration: 0.4 }}
          className="mt-6"
        >
          <Card className="bg-card border-border">
            <CardContent className="p-5">
              <div className="flex items-center justify-between flex-wrap gap-4">
                <div className="flex items-center gap-3">
                  <div className="p-2 rounded-xl bg-primary/10">
                    <TrendingUp className="w-5 h-5 text-primary" />
                  </div>
                  <div>
                    <div className="text-sm font-semibold text-foreground">{t("performance_overview", "Performance Overview")}</div>
                    <div className="text-xs text-muted-foreground">{t("last_30_days", "Last 30 days")}</div>
                  </div>
                </div>
                <div className="flex items-center gap-6">
                  <div className="text-center">
                    <div className="text-lg font-bold text-foreground">94.2%</div>
                    <div className="text-[10px] text-muted-foreground uppercase tracking-wider">{t("admin_property_occupancy", "Occupancy")}</div>
                  </div>
                  <div className="w-px h-8 bg-border" />
                  <div className="text-center">
                    <div className="text-lg font-bold text-foreground">4.8</div>
                    <div className="text-[10px] text-muted-foreground uppercase tracking-wider">{t("admin_property_avg_rating", "Avg Rating")}</div>
                  </div>
                  <div className="w-px h-8 bg-border" />
                  <div className="text-center">
                    <div className="text-lg font-bold text-foreground">$187</div>
                    <div className="text-[10px] text-muted-foreground uppercase tracking-wider">{t("admin_dashboard_perf_avg/night", "Avg/Night")}</div>
                  </div>
                  <div className="w-px h-8 bg-border" />
                  <div className="text-center">
                    <div className="text-lg font-bold text-emerald-500">+23%</div>
                    <div className="text-[10px] text-muted-foreground uppercase tracking-wider">{t("admin_dashboard_perf_growth", "Growth")}</div>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>
        </m.div>
      </div>
    </div>
  );
}
