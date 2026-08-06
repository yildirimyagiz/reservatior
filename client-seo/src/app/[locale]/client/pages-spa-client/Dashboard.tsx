"use client";

import { useState, useEffect } from "react";
import { Building, Users, DollarSign, ArrowUpRight, ArrowDownRight, ShieldCheck, Brain, Sparkles, CheckCircle2, AlertCircle, Activity, Zap, Globe, Target, CreditCard, Crown, Star, TrendingUp, LayoutDashboard } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { Progress } from "@/components/ui/progress";
import { AreaChart, Area, ResponsiveContainer, XAxis, YAxis, Tooltip, CartesianGrid } from "recharts";
import { useAuth } from "@/lib/auth/hooks";
import { m } from "framer-motion";
import { AIWidget } from "@/components/dashboard/AIWidget";
import { ComplianceWidget } from "@/components/dashboard/ComplianceWidget";
import { SmartAccessWidget } from "@/components/dashboard/SmartAccessWidget";
import { AIOperationsWidget } from "@/components/dashboard/AIOperationsWidget";

import { cn } from "@/lib/utils";
import { useTranslation } from "react-i18next";
import { apiClient } from "@/lib/api/client";
import { subscriptionsApi } from "@/lib/api/subscriptions";
import { propertiesApi } from "@/lib/api/properties";
import { useNavigate } from "@/lib/react-router-shim";
const stats = (t: any) => [{
  label: t("dashboardRevenue"),
  value: "$45,231",
  change: "+12.5%",
  trending: "up",
  icon: DollarSign,
  color: "text-success",
  bg: "bg-success/10"
}, {
  label: t("client.dashboard.stats.nodes"),
  value: "128",
  change: "+4.3%",
  trending: "up",
  icon: Building,
  color: "text-brand",
  bg: "bg-brand/10"
}, {
  label: t("engagement"),
  value: "342",
  change: "-2.1%",
  trending: "down",
  icon: Users,
  color: "text-brand",
  bg: "bg-brand/10"
}, {
  label: t("verification"),
  value: "98.2%",
  change: "+0.5%",
  trending: "up",
  icon: Brain,
  color: "text-amber-400",
  bg: "bg-amber-500/10"
}];
const revenueData = [{
  name: "Mon",
  value: 4000
}, {
  name: "Tue",
  value: 3000
}, {
  name: "Wed",
  value: 5000
}, {
  name: "Thu",
  value: 2780
}, {
  name: "Fri",
  value: 1890
}, {
  name: "Sat",
  value: 2390
}, {
  name: "Sun",
  value: 3490
}];
const PLAN_CONFIG: Record<string, { label: string; icon: any; color: string; maxProperties: number; maxUsers: number; aiFeatures: boolean }> = {
  "starter-10": { label: "Starter", icon: Star, color: "text-muted-foreground", maxProperties: 10, maxUsers: 1, aiFeatures: false },
  "growth-25": { label: "Growth", icon: TrendingUp, color: "text-brand", maxProperties: 25, maxUsers: 3, aiFeatures: false },
  "professional-50": { label: "Professional", icon: Crown, color: "text-brand", maxProperties: 50, maxUsers: 5, aiFeatures: true },
  "agency-100": { label: "Agency", icon: LayoutDashboard, color: "text-amber-400", maxProperties: 100, maxUsers: 10, aiFeatures: true },
  "enterprise": { label: "Enterprise", icon: Crown, color: "text-success", maxProperties: 9999, maxUsers: 999, aiFeatures: true },
};

export default function Dashboard() {
  const {
    t
  } = useTranslation();
  const {
    user
  } = useAuth();
  const navigate = useNavigate();
  const [mounted, setMounted] = useState(false);
  const [globalActivity, setGlobalActivity] = useState<any[]>([]);
  const [currentPlan, setCurrentPlan] = useState<{ plan: string; status: string } | null>(null);
  const [propertyCount, setPropertyCount] = useState(0);
  useEffect(() => {
    setMounted(true);
    const fetchGlobalActivity = async () => {
      try {
        const response: any = await apiClient.get('/user/global-activity').catch(() => null);
        if (response && response.data) {
          setGlobalActivity(response.data);
        } else {
          // Mock data fallback
          setGlobalActivity([
            { id: 1, type: "BOOKING", region: "US", title: "Reservation for Luxury Villa", description: "Miami, USA", date: new Date().toISOString() },
            { id: 2, type: "FAVORITE", region: "UK", title: "Added to Favorites", description: "London Apartment", date: new Date(Date.now() - 86400000).toISOString() }
          ]);
        }
      } catch (e) {
        console.error(e);
      }
    };
    const fetchSubscription = async () => {
      if (!user?.orgId) return;
      try {
        const res = await subscriptionsApi.getOrgSubscriptions(user.orgId) as any;
        const subs = res?.data || [];
        if (subs.length > 0) {
          setCurrentPlan({ plan: subs[0].plan, status: subs[0].status });
        }
      } catch (e) {
        console.error("Failed to fetch subscription", e);
      }
    };
    const fetchPropertyCount = async () => {
      if (!user?.orgId) return;
      try {
        const props = await propertiesApi.getOrgProperties(user.orgId);
        setPropertyCount(props?.length || 0);
      } catch (e) {
        console.error("Failed to fetch property count", e);
      }
    };
    fetchGlobalActivity();
    fetchSubscription();
    fetchPropertyCount();
  }, [user?.orgId]);

  const planConfig = currentPlan ? PLAN_CONFIG[currentPlan.plan] || PLAN_CONFIG["starter-10"] : null;
  const usagePercent = planConfig ? Math.min(100, Math.round((propertyCount / planConfig.maxProperties) * 100)) : 0;
  if (!mounted) return null;
  return <div className="p-8 lg:p-12 space-y-12 max-w-[1600px] mx-auto bg-background min-h-screen">
      {/* Tactical Welcomer */}
      <section className="relative overflow-hidden rounded-[40px] p-12 bg-card/40 border border-border/50 border-l border-t shadow-3xl">
        <div className="absolute -top-24 -right-24 h-[500px] w-[500px] bg-blue-600/10 rounded-full blur-[120px] pointer-events-none opacity-50" />
        <div className="absolute -bottom-24 -left-24 h-[400px] w-[400px] bg-blue-600/10 rounded-full blur-[100px] pointer-events-none opacity-30" />
        
        <div className="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-6">
          <div className="space-y-2">
            <div className="flex items-center gap-3 flex-wrap">
              <Badge className="bg-brand/10 text-brand border border-blue-500/20 px-3 py-0.5 text-[9px] font-bold tracking-wider">
                {t("nodeStatus", { node: "Alpha-7" })}
              </Badge>
              {planConfig && (
                <Badge className={cn("px-3 py-0.5 text-[9px] font-bold tracking-wider flex items-center gap-1.5", `bg-${planConfig.color.replace('text-', '')}/10 border-${planConfig.color.replace('text-', '')}/20 ${planConfig.color}`)}>
                  <planConfig.icon className="w-3 h-3" />
                  {planConfig.label} {currentPlan?.status === "ACTIVE" ? "• Active" : "• Inactive"}
                </Badge>
              )}
            </div>
            <h1 className="text-3xl md:text-4xl font-extrabold text-white tracking-tight">
              {t("welcome", { name: "" })}<span className="text-transparent bg-clip-text bg-gradient-to-r from-brand via-indigo-400 to-brand ml-1">{user?.name || "Neural Comm"}</span>
            </h1>
            <p className="text-muted-foreground text-sm font-medium max-w-2xl">
              {t("syncComplete", { count: 4 })}
            </p>
          </div>
          <div className="flex gap-3">
            <Button size="default" className="h-12 px-6 rounded-xl bg-card text-black hover:bg-muted font-bold text-xs tracking-wide transition-all shadow-lg hover:scale-[1.02] active:scale-[0.98]">
              <Sparkles className="mr-2 h-4 w-4 text-brand" />
              {t("analyzePulse")}
            </Button>
            <Button size="default" variant="outline" className="h-12 px-6 rounded-xl border-white/10 bg-white/5 text-white font-bold text-xs tracking-wide backdrop-blur-xl hover:bg-white/10 transition-all">
              {t("chronoReports")}
            </Button>
          </div>
        </div>

        {/* Subscription Usage Meter */}
        {planConfig && (
          <div className="mt-8 pt-8 border-t border-white/5 grid grid-cols-1 md:grid-cols-3 gap-6">
            <div className="space-y-2">
              <div className="flex justify-between text-[10px] font-bold text-muted-foreground tracking-wider">
                <span>{t("common.properties")}</span>
                <span>{propertyCount} / {planConfig.maxProperties === 9999 ? '∞' : planConfig.maxProperties}</span>
              </div>
              <Progress value={usagePercent} className="h-2 bg-black/40 rounded-full" />
            </div>
            <div className="space-y-2">
              <div className="flex justify-between text-[10px] font-bold text-muted-foreground tracking-wider">
                <span>{t('client.src.users')}</span>
                <span>1 / {planConfig.maxUsers === 999 ? '∞' : planConfig.maxUsers}</span>
              </div>
              <Progress value={Math.min(100, Math.round((1 / planConfig.maxUsers) * 100))} className="h-2 bg-black/40 rounded-full" />
            </div>
            <div className="flex items-center justify-between p-4 rounded-2xl bg-white/5 border border-white/5">
              <div className="flex items-center gap-3">
                <CreditCard className="w-5 h-5 text-brand" />
                <span className="text-[10px] font-bold text-muted-foreground tracking-wider">{t('client.src.subscriptions')}</span>
              </div>
              <Button onClick={() => navigate("/pricing")} size="sm" className="h-8 px-4 rounded-xl bg-blue-600 hover:bg-brand/100 text-white font-bold text-[9px]">
                {t('client.src.upgrade')}
              </Button>
            </div>
          </div>
        )}
      </section>

      {/* Neural KPIs Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
        {stats(t).map((stat: any, idx: number) => <m.div initial={{
        opacity: 0,
        y: 20
      }} animate={{
        opacity: 1,
        y: 0
      }} transition={{
        delay: idx * 0.1
      }} key={stat.label}>
            <Card className="border-border/50 bg-card/60 backdrop-blur-3xl hover:bg-card/80 transition-all group rounded-[32px] overflow-hidden shadow-2xl relative border-l border-t">
              <CardContent className="p-10">
                <div className="flex justify-between items-start mb-8">
                  <div className={`p-4 rounded-2xl bg-black/40 border border-white/5 ${stat.color} group-hover:scale-110 transition-transform shadow-inner`}>
                    <stat.icon className="h-6 w-6" />
                  </div>
                  <Badge className={cn("px-3 py-1 rounded-full text-[10px] font-black italic tracking-widest border", stat.trending === 'up' ? 'bg-success/10 text-success border-success/20' : 'bg-red-500/10 text-red-400 border-red-500/20')}>
                    {stat.trending === "up" ? <ArrowUpRight className="h-3 w-3 mr-1" /> : <ArrowDownRight className="h-3 w-3 mr-1" />}
                    {stat.change}
                  </Badge>
                </div>
                <div className="space-y-1">
                  <p className="text-xs font-semibold text-muted-foreground tracking-wider">{stat.label}</p>
                  <h3 className="text-2xl font-bold text-white tracking-tight">{stat.value}</h3>
                </div>
              </CardContent>
            </Card>
          </m.div>)}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-12">
        {/* Performance Area HUD */}
        <Card className="lg:col-span-2 border-border/50 bg-card/60 backdrop-blur-3xl rounded-[40px] overflow-hidden shadow-3xl border-l border-t">
          <CardHeader className="p-10 flex flex-row items-center justify-between">
            <div className="space-y-1">
              <CardTitle className="text-lg font-bold text-white tracking-tight">{t("client.dashboard.trajectory.title")}</CardTitle>
              <CardDescription className="text-xs text-muted-foreground font-medium">{t("client.dashboard.trajectory.desc")}</CardDescription>
            </div>
            <div className="flex items-center gap-3">
              <div className="flex items-center gap-2 px-3 py-1 bg-success/10 rounded-full border border-success/20">
                <div className="h-1.5 w-1.5 rounded-full bg-success animate-pulse shadow-[0_0_8px_#3b82f6]" />
                <span className="text-[10px] font-bold text-success tracking-wider">{t("nodeLive")}</span>
              </div>
            </div>
          </CardHeader>
          <CardContent className="h-96 w-full pl-0 pb-10">
            <ResponsiveContainer width="100%" height="100%">
              <AreaChart data={revenueData}>
                <defs>
                  <linearGradient id="colorValue" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#2563eb" stopOpacity={0.3} />
                    <stop offset="95%" stopColor="#2563eb" stopOpacity={0} />
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" stroke="#ffffff05" vertical={false} />
                <XAxis dataKey="name" axisLine={false} tickLine={false} tick={{
                fill: "#64748b",
                fontSize: 10,
                fontWeight: 900
              }} dy={15} />
                <YAxis hide />
                <Tooltip contentStyle={{
                backgroundColor: "rgba(26, 27, 30, 0.95)",
                border: "1px solid rgba(255,255,255,0.05)",
                borderRadius: "20px",
                boxShadow: "0 25px 50px -12px rgba(0,0,0,0.5)",
                backdropFilter: "blur(12px)",
                padding: "15px"
              }} itemStyle={{
                color: "#fff",
                fontWeight: 900,
                textTransform: "",
                fontSize: "10px"
              }} labelStyle={{
                color: "#64748b",
                fontWeight: 900,
                textTransform: "",
                fontSize: "10px",
                marginBottom: "5px"
              }} />
                <Area type="monotone" dataKey="value" stroke="#3b82f6" strokeWidth={4} fillOpacity={1} fill="url(#colorValue)" />
              </AreaChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>

        {/* AI Hub Widgets */}
        <div className="space-y-10 lg:col-span-3">
          <AIOperationsWidget />
        </div>

        <div className="space-y-10">
          <AIWidget />
          <ComplianceWidget />
          <SmartAccessWidget />
        </div>
      </div>

      {/* Chrono-Feed Section */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-12">
        <Card className="border-border/50 bg-card/40 backdrop-blur-3xl rounded-[40px] shadow-3xl border-l border-t relative overflow-hidden group">
          <CardHeader className="p-10 pb-6">
            <CardTitle className="text-lg font-bold text-white tracking-tight flex items-center gap-3">
               <Activity className="w-5 h-5 text-brand" /> {t("eventStream")}
            </CardTitle>
          </CardHeader>
          <CardContent className="p-10 pt-0 space-y-6">
            {globalActivity.map((activity, i) => (
              <div key={activity.id || i} className="flex items-center gap-6 py-6 border-b border-white/5 last:border-0 hover:bg-white/5 transition-colors -mx-4 px-4 rounded-2xl">
                <div className="relative">
                   <div className="absolute inset-0 bg-brand/20 blur-xl opacity-0 group-hover:opacity-100 transition-opacity"></div>
                   <Avatar className="h-14 w-14 border-2 border-white/5 shadow-2xl relative">
                     <AvatarImage src={`https://flagcdn.com/w160/${activity.region?.toLowerCase() || 'us'}.png`} className="object-cover" />
                     <AvatarFallback className="bg-black/40 font-bold text-xs">{activity.region}</AvatarFallback>
                   </Avatar>
                </div>
                <div className="flex-1 space-y-1">
                  <p className="text-xs font-semibold text-white">{activity.title}</p>
                  <p className="text-[10px] text-muted-foreground font-medium">{activity.description}</p>
                </div>
                <div className="text-right space-y-2">
                  <p className="text-xs text-muted-foreground">{new Date(activity.date).toLocaleDateString()}</p>
                  <Badge className="bg-brand/10 text-brand border-none text-[9px] font-bold tracking-wider">{activity.type}</Badge>
                </div>
              </div>
            ))}
          </CardContent>
        </Card>

        <Card className="border-border/50 bg-card/40 backdrop-blur-3xl rounded-[40px] shadow-3xl border-l border-t relative overflow-hidden">
          <CardHeader className="p-10 pb-6">
            <CardTitle className="text-lg font-bold text-white tracking-tight flex items-center gap-3">
               <Target className="w-5 h-5 text-success" /> {t("client.dashboard.integrity.title")}
            </CardTitle>
          </CardHeader>
          <CardContent className="p-10 pt-0 space-y-10">
            <div className="space-y-4">
              <div className="flex justify-between items-center text-xs font-semibold tracking-wider text-muted-foreground">
                <span className="flex items-center gap-3">
                  <ShieldCheck className="h-4 w-4 text-success" />
                  {t("client.dashboard.integrity.encryption")}
                </span>
                <span className="text-white">{t("secure")}</span>
              </div>
              <div className="h-1.5 w-full bg-black/40 rounded-full overflow-hidden shadow-inner border border-white/5">
                <m.div initial={{
                width: 0
              }} animate={{
                width: '100%'
              }} className="h-full bg-success shadow-[0_0_15px_#3b82f6]" />
              </div>
            </div>
            <div className="space-y-4">
              <div className="flex justify-between items-center text-xs font-semibold tracking-wider text-muted-foreground">
                <span className="flex items-center gap-3">
                  <CheckCircle2 className="h-4 w-4 text-brand" />
                  {t("validation")}
                </span>
                <span className="text-white">{t("complete", {
                  percent: 85
                })}</span>
              </div>
              <div className="h-1.5 w-full bg-black/40 rounded-full overflow-hidden shadow-inner border border-white/5">
                <m.div initial={{
                width: 0
              }} animate={{
                width: '85%'
              }} className="h-full bg-brand/100 shadow-[0_0_15px_#3b82f6]" />
              </div>
            </div>
            <div className="p-8 rounded-[32px] bg-success/5 border border-blue-500/10 flex items-start gap-6 relative overflow-hidden group/alert">
              <div className="absolute top-0 right-0 p-8 opacity-5 text-success group-hover:scale-110 transition-transform">
                 <Sparkles className="w-20 h-20" />
              </div>
              <div className="p-4 rounded-2xl bg-success/20 shadow-inner">
                 <AlertCircle className="h-6 w-6 text-success shrink-0 animate-pulse" />
              </div>
              <div className="space-y-1 relative z-10">
                <p className="text-xs font-bold text-success tracking-wide leading-none">{t("client.dashboard.integrity.alert.title")}</p>
                <p className="text-xs font-medium text-muted-foreground leading-relaxed">
                  {t("client.dashboard.integrity.alert.desc", {
                  count: 3
                })}
                </p>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>;
}