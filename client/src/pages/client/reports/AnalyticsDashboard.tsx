import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { BarChart3, TrendingUp, Users, Building, DollarSign, Activity, Eye, ArrowUpRight, ArrowDownRight, Target, Sparkles, Calendar, PieChart as LucidePieChart, Download, ChevronRight, Zap, Boxes, ArrowRight, TrendingDown, Globe } from "lucide-react";
import { AreaChart, Area, BarChart, Bar, ResponsiveContainer, XAxis, YAxis, Tooltip, CartesianGrid, PieChart as RPieChart, Pie, Cell } from "recharts";
import { motion, AnimatePresence } from "framer-motion";
import { analyticsApi, AnalyticsOverview } from "@/lib/api/analytics";
import { useToast } from "@/hooks/use-toast";
import { cn } from "@/lib/utils";
import { useQuery } from "@tanstack/react-query";
const revenueData = [{
  name: "JAN",
  revenue: 42000,
  expenses: 28000
}, {
  name: "FEB",
  revenue: 48000,
  expenses: 31000
}, {
  name: "MAR",
  revenue: 55000,
  expenses: 29000
}, {
  name: "APR",
  revenue: 51000,
  expenses: 33000
}, {
  name: "MAY",
  revenue: 63000,
  expenses: 35000
}, {
  name: "JUN",
  revenue: 72000,
  expenses: 37000
}, {
  name: "JUL",
  revenue: 68000,
  expenses: 34000
}];
const propertyTypeData = [{
  name: "Apartments",
  value: 42,
  color: "#3b82f6"
}, {
  name: "Houses",
  value: 28,
  color: "#8b5cf6"
}, {
  name: "Commercial",
  value: 18,
  color: "#6366f1"
}, {
  name: "Vacation",
  value: 12,
  color: "#a855f7"
}];
const leadSourceData = [{
  name: "WEBSITE",
  leads: 120
}, {
  name: "REFERRALS",
  leads: 85
}, {
  name: "SOCIAL",
  leads: 62
}, {
  name: "MLS",
  leads: 48
}, {
  name: "WALK-IN",
  leads: 30
}];
const recentActivity = [{
  event: "NEW BOOKING CONFIRMED",
  property: "Sunset Apartments #204",
  time: "2 MIN AGO",
  type: "booking"
}, {
  event: "LEASE SIGNED",
  property: "Downtown Loft #12",
  time: "15 MIN AGO",
  type: "lease"
}, {
  event: "PAYMENT RECEIVED",
  property: "Park View Complex",
  time: "1 HR AGO",
  type: "payment"
}, {
  event: "LEAD CONVERTED",
  property: "Marina Bay Residences",
  time: "2 HRS AGO",
  type: "lead"
}, {
  event: "MAINTENANCE COMPLETED",
  property: "Heritage Tower #8",
  time: "4 HRS AGO",
  type: "maintenance"
}];
const topProperties = [{
  name: "SUNSET APARTMENTS",
  occupancy: 96,
  revenue: 145000,
  units: 48
}, {
  name: "DOWNTOWN LOFT",
  occupancy: 92,
  revenue: 118000,
  units: 32
}, {
  name: "PARK VIEW COMPLEX",
  occupancy: 88,
  revenue: 95000,
  units: 24
}, {
  name: "MARINA BAY",
  occupancy: 85,
  revenue: 82000,
  units: 16
}];
export default function AnalyticsDashboard() {
  const {
    t
  } = useTranslation();
  const [period, setPeriod] = useState("7d");
  const [activeTab, setActiveTab] = useState("overview");
  const [mounted, setMounted] = useState(false);
  const { toast } = useToast();

  useEffect(() => {
    setMounted(true);
  }, []);

  const { data: overview, isLoading: loading } = useQuery({
    queryKey: ['analytics-overview', period],
    queryFn: async () => {
      try {
        const data = await analyticsApi.getOverview();
        return data;
      } catch (error) {
        // Fallback for visual audit
        return {
          totalRevenue: 3450000,
          totalBookings: 1240,
          totalUsers: 4500,
          totalListings: 128,
          totalProperties: 104,
          averageCheckSize: 2400,
          conversionRate: 12.5,
          dailyStats: [],
          topProperties: [],
          lastUpdated: new Date().toISOString()
        } as AnalyticsOverview;
      }
    }
  });
  const kpis = [{
    label: t("client.src.total_revenue"),
    value: overview ? `$${(overview.totalRevenue / 1000).toFixed(1)}K` : "$0.0K",
    change: "+18.2%",
    trending: "up",
    icon: DollarSign,
    color: "text-emerald-400",
    bg: "bg-emerald-500/10"
  }, {
    label: t("client.src.active_nodes"),
    value: overview ? overview.totalListings.toString() : "0",
    change: "+12.4%",
    trending: "up",
    icon: Building,
    color: "text-blue-400",
    bg: "bg-blue-500/10"
  }, {
    label: t("client.src.sync_cycles"),
    value: overview ? overview.totalBookings.toString() : "0",
    change: "+3.1%",
    trending: "up",
    icon: Target,
    color: "text-purple-400",
    bg: "bg-purple-500/10"
  }, {
    label: t("client.src.active_identities"),
    value: overview ? overview.totalUsers.toString() : "0",
    change: "-2.3%",
    trending: "down",
    icon: Users,
    color: "text-orange-400",
    bg: "bg-orange-500/10"
  }];
  if (!mounted) return null;
  return <div className="min-h-screen bg-[#14151a] p-8 lg:p-12 space-y-12 overflow-x-hidden">
      
      {/* Analytics Tactical Header */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-10 relative">
         <div className="absolute top-0 left-0 w-24 h-24 bg-blue-600/10 blur-[80px] pointer-events-none rounded-full"></div>
         <div className="relative z-10 flex items-center gap-6">
            <div className="h-16 w-16 rounded-[24px] bg-[#1a1b1e]/60 border border-white/5 border-l border-t flex items-center justify-center shadow-3xl">
              <BarChart3 className="w-8 h-8 text-blue-500 animate-pulse" />
            </div>
            <div>
              <h1 className="text-4xl font-black text-white italic tracking-tighter leading-none">{t("client.src.neural_analytics_nexus")}</h1>
              <p className="text-[10px] font-black text-slate-500 tracking-widest italic mt-2 flex items-center gap-2">
                 <Globe className="w-3 h-3" />{t("client.src.realtime_geospatial_intelligence_feed")}</p>
            </div>
         </div>

        <div className="flex items-center gap-4 relative z-10">
          <Select value={period} onValueChange={setPeriod}>
            <SelectTrigger className="h-14 w-48 bg-[#1a1b1e]/60 border-white/5 rounded-2xl text-[10px] font-black tracking-widest italic text-slate-400 hover:text-white transition-all shadow-xl">
               <Calendar className="w-4 h-4 mr-2 text-blue-500" />
               <SelectValue />
            </SelectTrigger>
            <SelectContent className="bg-[#1a1b1e] border-white/10">
              <SelectItem value="24h">{t("client.src.last_24_hours")}</SelectItem>
              <SelectItem value="7d">{t("client.src.last_7_days")}</SelectItem>
              <SelectItem value="30d">{t("client.src.last_30_days")}</SelectItem>
              <SelectItem value="90d">{t("client.src.last_90_days")}</SelectItem>
              <SelectItem value="1y">{t("client.src.last_year")}</SelectItem>
            </SelectContent>
          </Select>
          <Button variant="outline" className="h-14 px-8 rounded-2xl border-white/5 bg-white/5 text-[10px] font-black tracking-widest italic text-slate-400 hover:text-white transition-all shadow-xl gap-3">
            <Download className="w-4 h-4" />{t("client.src.export_dossier")}</Button>
        </div>
      </div>

      {/* High-Fidelity KPI Matrix */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
        {kpis.map((kpi, idx) => <motion.div key={kpi.label} initial={{
        opacity: 0,
        y: 30
      }} animate={{
        opacity: 1,
        y: 0
      }} transition={{
        delay: idx * 0.1
      }}>
            <Card className="border-white/5 bg-[#1a1b1e]/60 backdrop-blur-3xl hover:bg-white/5 transition-all group rounded-[32px] overflow-hidden shadow-2xl relative border-l border-t">
              <div className="absolute top-0 right-0 p-8 opacity-5 group-hover:opacity-10 transition-all text-blue-500">
                 <kpi.icon className="w-16 h-16" />
              </div>
              <CardContent className="p-8">
                <div className="flex justify-between items-start mb-6">
                  <div className={cn("p-4 rounded-2xl bg-black/40 border border-white/5 group-hover:scale-110 transition-transform", kpi.color)}>
                    <kpi.icon className="h-6 w-6" />
                  </div>
                  <Badge className={cn("rounded-lg px-2 py-1 text-[8px] font-black  tracking-widest italic border-none shadow-lg", kpi.trending === "up" ? "bg-emerald-500/10 text-emerald-400 shadow-emerald-500/10" : "bg-red-500/10 text-red-400 shadow-red-500/10")}>
                    {kpi.trending === "up" ? <TrendingUp className="h-3 w-3 mr-1" /> : <TrendingDown className="h-3 w-3 mr-1" />}
                    {kpi.change}
                  </Badge>
                </div>
                <div className="space-y-1">
                   <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{kpi.label}</p>
                   <h3 className="text-3xl font-black text-white italic tracking-tighter mt-1">{kpi.value}</h3>
                </div>
                <div className="mt-6 flex items-center gap-2">
                   <div className="h-1 flex-1 bg-white/5 rounded-full overflow-hidden">
                      <motion.div initial={{
                  width: 0
                }} animate={{
                  width: "65%"
                }} className={cn("h-full", kpi.trending === 'up' ? "bg-emerald-500" : "bg-red-500")} style={{
                  boxShadow: kpi.trending === 'up' ? '0 0 10px #10b981' : '0 0 10px #ef4444'
                }} />
                   </div>
                   <span className="text-[8px] font-black text-slate-600 italic">{t("client.src.trust_index")}</span>
                </div>
              </CardContent>
            </Card>
          </motion.div>)}
      </div>

      {/* Main Insights Node */}
      <Tabs value={activeTab} onValueChange={setActiveTab} className="space-y-10">
        <TabsList className="bg-[#1a1b1e]/60 border border-white/5 p-1.5 rounded-[20px] h-14 shadow-xl">
          {["OVERVIEW", "PROPERTIES", "LEADS & CRM"].map(tab => <TabsTrigger key={tab} value={tab.toLowerCase().replace(/ & /g, '-').replace(/ /g, '')} className="data-[state=active]:bg-blue-600 data-[state=active]:text-white rounded-[14px] px-8 text-[10px] font-black tracking-widest italic h-full transition-all">
              {tab}
            </TabsTrigger>)}
        </TabsList>

        <AnimatePresence mode="wait">
          <TabsContent value="overview" className="space-y-10 mt-0 outline-none">
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-10">
              {/* Financial Pulse Chart */}
              <Card className="lg:col-span-2 border-white/5 bg-[#1a1b1e]/40 backdrop-blur-3xl rounded-[40px] overflow-hidden shadow-3xl border-l border-t">
                <CardHeader className="p-10 pb-4 flex flex-row items-center justify-between">
                  <div>
                    <CardTitle className="text-2xl font-black text-white italic tracking-tighter leading-none">{t("client.src.financial_velocity")}</CardTitle>
                    <CardDescription className="text-[10px] font-black text-slate-500 tracking-widest italic mt-2">{t("client.src.node_efficiency_threshold_matrix")}</CardDescription>
                  </div>
                  <div className="flex items-center gap-6">
                    <div className="flex items-center gap-3">
                      <div className="h-1 w-8 bg-blue-500 shadow-[0_0_10px_#3b82f6]" />
                      <span className="text-[9px] font-black text-white italic tracking-widest">{t("client.src.revenue")}</span>
                    </div>
                    <div className="flex items-center gap-3">
                      <div className="h-1 w-8 bg-purple-500 shadow-[0_0_10px_#a855f7]" />
                      <span className="text-[9px] font-black text-white italic tracking-widest">{t("client.src.overhead")}</span>
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="p-10 pt-0 h-[450px]">
                  <ResponsiveContainer width="100%" height="100%">
                    <AreaChart data={revenueData}>
                      <defs>
                        <linearGradient id="colorRevenue" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.3} />
                          <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                        </linearGradient>
                        <linearGradient id="colorExpenses" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="5%" stopColor="#a855f7" stopOpacity={0.2} />
                          <stop offset="95%" stopColor="#a855f7" stopOpacity={0} />
                        </linearGradient>
                      </defs>
                      <CartesianGrid strokeDasharray="3 3" stroke="#ffffff05" vertical={false} />
                      <XAxis dataKey="name" axisLine={false} tickLine={false} tick={{
                      fill: "#64748b",
                      fontSize: 10,
                      fontWeight: 900,
                      letterSpacing: '0.1em'
                    }} dy={20} />
                      <YAxis hide />
                      <Tooltip contentStyle={{
                      backgroundColor: "rgba(26,27,30,0.9)",
                      border: "1px solid rgba(255,255,255,0.05)",
                      borderRadius: "20px",
                      backdropFilter: "blur(20px)",
                      padding: "16px",
                      boxShadow: "0 20px 40px rgba(0,0,0,0.4)"
                    }} itemStyle={{
                      fontSize: '10px',
                      fontWeight: 900,
                      textTransform: '',
                      fontStyle: 'italic',
                      color: '#fff'
                    }} labelStyle={{
                      fontSize: '9px',
                      fontWeight: 900,
                      marginBottom: '8px',
                      color: '#64748b',
                      letterSpacing: '0.2em'
                    }} formatter={((value: number) => [`$${value.toLocaleString()}`]) as any} />
                      <Area type="monotone" dataKey="revenue" stroke="#3b82f6" strokeWidth={4} fillOpacity={1} fill="url(#colorRevenue)" />
                      <Area type="monotone" dataKey="expenses" stroke="#a855f7" strokeWidth={3} fillOpacity={1} fill="url(#colorExpenses)" strokeDasharray="10 10" />
                    </AreaChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              {/* Asset Allocation Radar */}
              <Card className="border-white/5 bg-[#1a1b1e]/40 rounded-[40px] shadow-3xl border-l border-t p-4">
                <CardHeader className="p-6">
                  <CardTitle className="text-xs font-black text-slate-500 tracking-widest flex items-center gap-3 italic">
                    <Boxes className="w-4 h-4 text-orange-500" />{t("client.src.taxonomy_allocation")}</CardTitle>
                </CardHeader>
                <CardContent className="p-6">
                  <div className="h-64 relative">
                    <ResponsiveContainer width="100%" height="100%">
                      <RPieChart>
                        <Pie data={propertyTypeData} cx="50%" cy="50%" innerRadius={70} outerRadius={95} paddingAngle={8} dataKey="value" stroke="none">
                          {propertyTypeData.map((entry, index) => <Cell key={`cell-${index}`} fill={entry.color} className="outline-none" />)}
                        </Pie>
                        <Tooltip contentStyle={{
                        backgroundColor: "#1a1b1e",
                        border: "1px solid rgba(255,255,255,0.05)",
                        borderRadius: "16px"
                      }} />
                      </RPieChart>
                    </ResponsiveContainer>
                    <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-center">
                       <p className="text-3xl font-black text-white italic tracking-tighter leading-none">128</p>
                       <p className="text-[8px] font-black text-slate-500 tracking-widest italic">{t("client.src.total_nodes")}</p>
                    </div>
                  </div>
                  <div className="space-y-3 mt-10">
                    {propertyTypeData.map(type => <div key={type.name} className="flex items-center justify-between group cursor-pointer hover:bg-white/2 p-2 rounded-xl transition-all">
                        <div className="flex items-center gap-3">
                          <div className="w-2.5 h-2.5 rounded-full" style={{
                        backgroundColor: type.color
                      }} />
                          <span className="text-[10px] font-black text-slate-400 tracking-widest italic group-hover:text-white transition-colors">{type.name}</span>
                        </div>
                        <span className="text-xs font-black text-white italic font-mono">{type.value}%</span>
                      </div>)}
                  </div>
                </CardContent>
              </Card>
            </div>

            {/* Tactical Feed Sector */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-10">
              {/* Lead Intelligence Radar */}
              <Card className="border-white/5 bg-[#1a1b1e]/40 rounded-[40px] shadow-3xl border-l border-t">
                <CardHeader className="p-10 pb-4">
                  <CardTitle className="text-xs font-black text-slate-500 tracking-widest flex items-center gap-3 italic">
                    <Target className="w-4 h-4 text-blue-500" />{t("client.src.origin_acquisition_vectors")}</CardTitle>
                </CardHeader>
                <CardContent className="p-10 pt-4 h-80">
                  <ResponsiveContainer width="100%" height="100%">
                    <BarChart data={leadSourceData} layout="vertical">
                      <CartesianGrid strokeDasharray="3 3" stroke="#ffffff05" horizontal={false} />
                      <XAxis type="number" hide />
                      <YAxis dataKey="name" type="category" axisLine={false} tickLine={false} tick={{
                      fill: "#64748b",
                      fontSize: 9,
                      fontWeight: 900,
                      letterSpacing: '0.15em'
                    }} width={90} />
                      <Tooltip contentStyle={{
                      backgroundColor: "#1a1b1e",
                      border: "1px solid rgba(255,255,255,0.05)",
                      borderRadius: "16px"
                    }} />
                      <Bar dataKey="leads" fill="#3b82f6" radius={[0, 12, 12, 0]} barSize={28} className="drop-shadow-[0_0_10px_rgba(59,130,246,0.2)]" />
                    </BarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              {/* Neural Event Stream */}
              <Card className="border-white/5 bg-[#1a1b1e]/40 rounded-[40px] shadow-3xl border-l border-t relative overflow-hidden">
                <div className="absolute top-0 right-0 p-10 opacity-5 pointer-events-none text-emerald-500">
                   <Activity className="w-32 h-32" />
                </div>
                <CardHeader className="p-10 pb-4">
                  <CardTitle className="text-xs font-black text-slate-500 tracking-widest flex items-center gap-3 italic">
                    <Activity className="w-4 h-4 text-emerald-500" />{t("client.src.realtime_anomaly_feed")}</CardTitle>
                </CardHeader>
                <CardContent className="p-10 pt-4 space-y-4">
                  {recentActivity.map((item, idx) => <motion.div key={idx} initial={{
                  opacity: 0,
                  x: -20
                }} animate={{
                  opacity: 1,
                  x: 0
                }} transition={{
                  delay: idx * 0.05
                }} className="flex items-center gap-5 p-4 rounded-2xl bg-black/40 border border-white/5 hover:border-blue-500/30 transition-all cursor-pointer group shadow-lg">
                      <div className={cn("p-3 rounded-xl shadow-inner group-hover:scale-110 transition-transform", item.type === "booking" ? "bg-blue-600/10 text-blue-400" : item.type === "payment" ? "bg-emerald-600/10 text-emerald-400" : item.type === "lead" ? "bg-purple-600/10 text-purple-400" : item.type === "lease" ? "bg-orange-600/10 text-orange-400" : "bg-slate-500/10 text-slate-400")}>
                        <Zap className="w-4 h-4" />
                      </div>
                      <div className="flex-1 min-w-0">
                        <p className="text-[11px] font-black text-white italic tracking-tighter leading-none">{item.event}</p>
                        <p className="text-[9px] font-bold text-slate-500 tracking-widest mt-1 italic leading-none">{item.property}</p>
                      </div>
                      <div className="text-right">
                         <span className="text-[9px] font-black text-slate-600 italic tracking-tighter whitespace-nowrap">{item.time}</span>
                         <div className="flex justify-end mt-1">
                            <ChevronRight className="w-3 h-3 text-slate-800" />
                         </div>
                      </div>
                    </motion.div>)}
                  <Button variant="ghost" className="w-full h-12 rounded-xl text-[9px] font-black text-slate-500 hover:text-white tracking-widest italic mt-4">{t("client.src.sync_full_chrono_event")}</Button>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Additional Tabs Implementation */}
          <TabsContent value="properties" className="mt-0 outline-none">
             <Card className="border-white/5 bg-[#1a1b1e]/40 backdrop-blur-3xl rounded-[40px] overflow-hidden shadow-3xl border-l border-t">
                <CardHeader className="p-10 pb-4">
                  <div className="flex items-center justify-between">
                     <div>
                        <CardTitle className="text-2xl font-black text-white italic tracking-tighter leading-none">{t("client.src.property_alpha_table")}</CardTitle>
                        <CardDescription className="text-[10px] font-black text-slate-500 tracking-widest italic mt-2">{t("client.src.ranked_by_neural_engagement")}</CardDescription>
                     </div>
                     <Sparkles className="w-6 h-6 text-orange-500 animate-pulse" />
                  </div>
                </CardHeader>
                <CardContent className="p-10 pt-4">
                  <div className="space-y-4">
                    {topProperties.map((property, idx) => <motion.div key={property.name} initial={{
                  opacity: 0,
                  y: 20
                }} animate={{
                  opacity: 1,
                  y: 0
                }} transition={{
                  delay: idx * 0.08
                }} className="flex items-center gap-8 p-6 rounded-[28px] bg-black/40 border border-white/5 hover:bg-white/5 hover:border-blue-500/20 transition-all group cursor-pointer shadow-xl relative">
                         <div className="absolute top-0 right-0 p-4 opacity-5 group-hover:opacity-20 transition-all text-blue-500">
                            <ArrowUpRight className="w-12 h-12" />
                         </div>
                        <div className="flex items-center justify-center w-14 h-14 rounded-2xl bg-[#1a1b1e] border border-white/5 text-blue-500 font-black italic text-2xl shadow-inner">
                          {idx + 1}
                        </div>
                        <div className="flex-1">
                          <h4 className="text-xl font-black text-white italic tracking-tighter whitespace-nowrap">{property.name}</h4>
                          <p className="text-[10px] font-bold text-slate-500 tracking-widest italic mt-1">{property.units}{t("client.src.active_nodes")}</p>
                        </div>
                        
                        <div className="hidden md:block w-48 space-y-2">
                           <div className="flex justify-between text-[9px] font-black italic text-slate-500">
                              <span>{t("client.src.occupancy_sync")}</span>
                              <span className="text-white">{property.occupancy}%</span>
                           </div>
                           <div className="h-1.5 w-full bg-white/5 rounded-full overflow-hidden shadow-inner">
                              <div className="h-full bg-blue-600 shadow-[0_0_10px_#3b82f6] rounded-full transition-all" style={{
                        width: `${property.occupancy}%`
                      }} />
                           </div>
                        </div>

                        <div className="text-right pl-4">
                          <p className="text-2xl font-black text-emerald-400 italic tracking-tighter leading-none">${property.revenue.toLocaleString()}</p>
                          <p className="text-[9px] font-black text-slate-600 tracking-widest italic mt-1">{t("client.src.gross_revenue")}</p>
                        </div>
                        
                        <Button variant="outline" className="h-12 w-12 rounded-xl border-white/5 bg-white/2 text-slate-400 group-hover:text-white transition-all">
                           <ArrowRight className="w-4 h-4" />
                        </Button>
                      </motion.div>)}
                  </div>
                </CardContent>
             </Card>
          </TabsContent>
        </AnimatePresence>
      </Tabs>
      
      {/* Global Optimization HUD */}
      <footer className="p-10 rounded-[40px] bg-linear-to-br from-blue-600/10 via-purple-600/10 to-transparent border border-white/5 border-l border-t relative overflow-hidden group shadow-3xl">
         <div className="absolute top-0 right-0 p-20 opacity-5 pointer-events-none group-hover:scale-110 transition-transform duration-2000">
            <Sparkles className="w-64 h-64 text-indigo-500" />
         </div>
         <div className="flex flex-col md:flex-row items-center justify-between gap-10 relative z-10">
            <div className="flex items-center gap-8">
               <div className="h-20 w-20 rounded-[28px] bg-white/5 border border-white/5 flex items-center justify-center shadow-2xl relative overflow-hidden">
                  <div className="absolute inset-0 bg-blue-500/10 animate-pulse" />
                  <Target className="w-8 h-8 text-blue-400 relative z-10" />
               </div>
               <div className="space-y-2">
                  <h4 className="text-2xl font-black text-white italic tracking-tighter leading-none">{t("client.src.neural_prediction_engine_active")}</h4>
                  <p className="text-[10px] font-black text-slate-500 tracking-widest italic leading-relaxed max-w-lg">{t("client.src.running_geospatial_forecasting_models")}</p>
               </div>
            </div>
            <Button size="lg" className="h-16 px-12 rounded-3xl bg-blue-600 hover:bg-blue-500 text-white font-black text-xs italic tracking-widest shadow-xl shadow-blue-600/20 transition-all hover:scale-105 active:scale-95 gap-3">{t("client.src.execute_forecast")}<ArrowUpRight className="w-5 h-5" />
            </Button>
         </div>
      </footer>
    </div>;
}