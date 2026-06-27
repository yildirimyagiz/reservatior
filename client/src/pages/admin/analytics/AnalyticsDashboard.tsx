import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { useToast } from "@/hooks/use-toast";
import { useQuery } from "@tanstack/react-query";
import { analyticsApi } from "@/lib/api/analytics";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, PieChart, Pie, Cell, BarChart, Bar, AreaChart, Area } from "recharts";
import { Users, Activity, Eye, Download, Monitor, Tablet, Smartphone, Target, Zap, TrendingUp, Cpu, Globe, MoreVertical, ZapOff, Loader2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { motion } from "framer-motion";
interface AnalyticsMetrics {
  totalEvents: number;
  uniqueUsers: number;
  totalSessions: number;
  avgSessionDuration: number;
  bounceRate: number;
  pageViews: number;
  conversionRate: number;
  topPages: Array<{
    page: string;
    views: number;
    uniqueViews: number;
  }>;
  deviceBreakdown: Array<{
    device: string;
    count: number;
    percentage: number;
  }>;
  userActivity: Array<{
    date: string;
    activeUsers: number;
    newUsers: number;
    sessions: number;
  }>;
  conversionFunnel: Array<{
    stage: string;
    users: number;
    conversionRate: number;
  }>;
  topActions: Array<{
    action: string;
    count: number;
    users: number;
  }>;
}
const COLORS = ['#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899'];
const MOCK_ANALYTICS: AnalyticsMetrics = {
  totalEvents: 15420,
  uniqueUsers: 1234,
  totalSessions: 3456,
  avgSessionDuration: 420,
  bounceRate: 32.5,
  pageViews: 8765,
  conversionRate: 12.3,
  topPages: [{
    page: '/properties',
    views: 2341,
    uniqueViews: 1234
  }, {
    page: '/properties/123',
    views: 1876,
    uniqueViews: 987
  }, {
    page: '/agents',
    views: 1234,
    uniqueViews: 654
  }, {
    page: '/bookings',
    views: 987,
    uniqueViews: 543
  }, {
    page: '/deals',
    views: 765,
    uniqueViews: 432
  }],
  deviceBreakdown: [{
    device: 'Desktop',
    count: 2345,
    percentage: 45.2
  }, {
    device: 'Mobile',
    count: 2101,
    percentage: 40.5
  }, {
    device: 'Tablet',
    count: 734,
    percentage: 14.3
  }],
  userActivity: [{
    date: '2024-03-22',
    activeUsers: 234,
    newUsers: 12,
    sessions: 456
  }, {
    date: '2024-03-23',
    activeUsers: 267,
    newUsers: 18,
    sessions: 523
  }, {
    date: '2024-03-24',
    activeUsers: 289,
    newUsers: 15,
    sessions: 567
  }, {
    date: '2024-03-25',
    activeUsers: 312,
    newUsers: 22,
    sessions: 612
  }, {
    date: '2024-03-26',
    activeUsers: 298,
    newUsers: 19,
    sessions: 589
  }, {
    date: '2024-03-27',
    activeUsers: 345,
    newUsers: 25,
    sessions: 678
  }, {
    date: '2024-03-28',
    activeUsers: 387,
    newUsers: 28,
    sessions: 723
  }],
  conversionFunnel: [{
    stage: 'Visit',
    users: 1234,
    conversionRate: 100
  }, {
    stage: 'View',
    users: 876,
    conversionRate: 71.0
  }, {
    stage: 'Lead',
    users: 234,
    conversionRate: 26.7
  }, {
    stage: 'Booking',
    users: 123,
    conversionRate: 52.6
  }, {
    stage: 'Closed',
    users: 45,
    conversionRate: 36.6
  }],
  topActions: [{
    action: 'property_view',
    count: 3456,
    users: 1234
  }, {
    action: 'search',
    count: 2341,
    users: 987
  }, {
    action: 'contact_agent',
    count: 987,
    users: 456
  }, {
    action: 'create_booking',
    count: 456,
    users: 234
  }, {
    action: 'submit_offer',
    count: 234,
    users: 123
  }]
};
const CustomTooltip = ({
  active,
  payload,
  label
}: any) => {
  if (active && payload && payload.length) {
    return <div className="bg-[#14151a] border border-border p-4 rounded-2xl shadow-2xl backdrop-blur-xl">
        <p className="text-[10px] font-bold text-muted-foreground mb-2">{label}</p>
        <div className="space-y-1">
          {payload.map((entry: any, index: number) => <div key={index} className="flex items-center gap-2">
              <div className="w-2 h-2 rounded-full" style={{
            backgroundColor: entry.color || entry.fill
          }}></div>
              <p className="text-xs font-bold text-foreground">
                {entry.name}: <span className="text-blue-400">{entry.value.toLocaleString()}</span>
              </p>
            </div>)}
        </div>
      </div>;
  }
  return null;
};
export default function AnalyticsDashboard() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [dateRange, setDateRange] = useState("7d");
  const [selectedMetric, setSelectedMetric] = useState("overview");

  const { data: analyticsData, isLoading } = useQuery({
    queryKey: ['analyticsDashboard', dateRange],
    queryFn: async () => {
      const res = await analyticsApi.getDashboard("current");
      if (!res) return MOCK_ANALYTICS;
      
      return {
        totalEvents: res.totalEvents || MOCK_ANALYTICS.totalEvents,
        uniqueUsers: res.uniqueUsers || MOCK_ANALYTICS.uniqueUsers,
        totalSessions: res.totalSessions || MOCK_ANALYTICS.totalSessions,
        avgSessionDuration: res.avgSessionDuration || MOCK_ANALYTICS.avgSessionDuration,
        bounceRate: res.bounceRate || MOCK_ANALYTICS.bounceRate,
        pageViews: res.pageViews || MOCK_ANALYTICS.pageViews,
        conversionRate: res.conversionRate || MOCK_ANALYTICS.conversionRate,
        topPages: res.topPages || MOCK_ANALYTICS.topPages,
        deviceBreakdown: res.deviceBreakdown || MOCK_ANALYTICS.deviceBreakdown,
        userActivity: res.userActivity || MOCK_ANALYTICS.userActivity,
        conversionFunnel: res.conversionFunnel || MOCK_ANALYTICS.conversionFunnel,
        topActions: res.topActions || MOCK_ANALYTICS.topActions
      } as AnalyticsMetrics;
    }
  });

  const analytics = analyticsData || MOCK_ANALYTICS;
  const formatDuration = (seconds: number) => {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
  };
  const getDeviceIcon = (device: string) => {
    switch (device) {
      case 'Desktop':
        return <Monitor className="w-4 h-4" />;
      case 'Mobile':
        return <Smartphone className="w-4 h-4" />;
      case 'Tablet':
        return <Tablet className="w-4 h-4" />;
      default:
        return <Monitor className="w-4 h-4" />;
    }
  };
  return <PageShell title={t("admin.analytics.neural_analytics_terminal")} description={t("admin.analytics.realtime_behavioral_telemetry_system")}>
      <div className="space-y-10 pb-24">
        
        {/* Tactical UI Toolbar */}
        <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
           <div className="flex items-center gap-4 flex-1">
              <div className="bg-card/60 border-border dark:border-border rounded-2xl p-1.5 flex gap-1 border-l border-t shadow-2xl transition-colors">
                 {["1d", "7d", "30d", "90d"].map(range => <Button key={range} variant="ghost" size="sm" onClick={() => setDateRange(range)} className={cn("px-4 rounded-xl text-[10px] font-bold    transition-all", dateRange === range ? "bg-blue-600 text-foreground shadow-lg" : "text-muted-foreground hover:text-foreground")}>
                       {range}
                    </Button>)}
              </div>
              <Select defaultValue="all">
                <SelectTrigger className="w-48 bg-card/60 border-border dark:border-border rounded-2xl h-14 text-foreground font-bold text-[10px] border-l border-t shadow-2xl">
                  <SelectValue placeholder={t("admin.analytics.entity_isolation")} />
                </SelectTrigger>
                <SelectContent className="bg-[#14151a] border-border text-foreground rounded-2xl">
                  <SelectItem value="all">{t("admin.analytics.allentities")}</SelectItem>
                  <SelectItem value="property">{t("admin.analytics.properties")}</SelectItem>
                  <SelectItem value="user">{t("admin.analytics.users")}</SelectItem>
                  <SelectItem value="booking">{t("admin.analytics.bookings")}</SelectItem>
                </SelectContent>
              </Select>
           </div>
           <Button onClick={() => toast({
          title: t("admin.analytics.telemetry_extraction_initialized"),
          description: t("admin.analytics.generating_secure_encrypted_data")
        })} className="h-14 px-8 rounded-2xl bg-muted/50 hover:bg-muted/50 text-foreground border border-border font-bold text-xs shadow-xl gap-3">
              <Download className="w-5 h-5" />{t("admin.analytics.exfiltrate_telemetry")}</Button>
        </div>

        {/* Global KPI Matrix */}
        {isLoading ? (
          <div className="flex justify-center items-center py-12 text-muted-foreground">
            <Loader2 className="w-8 h-8 animate-spin" />
          </div>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
           {[{
          label: t("admin.analytics.telemetryevents"),
          value: analytics.totalEvents.toLocaleString(),
          icon: Activity,
          color: "text-blue-500",
          trend: "+12.4%",
          trendColor: "text-blue-400"
        }, {
          label: t("admin.analytics.uniquenodeusers"),
          value: analytics.uniqueUsers.toLocaleString(),
          icon: Users,
          color: "text-emerald-500",
          trend: "+8.7%",
          trendColor: "text-emerald-400"
        }, {
          label: t("admin.analytics.totalpageviewfragment"),
          value: analytics.pageViews.toLocaleString(),
          icon: Eye,
          color: "text-purple-500",
          trend: "+45.2%",
          trendColor: "text-purple-400"
        }, {
          label: t("admin.analytics.conversionratio"),
          value: `${analytics.conversionRate}%`,
          icon: Target,
          color: "text-orange-500",
          trend: "+2.1%",
          trendColor: "text-orange-400"
        }].map((stat, i) => <motion.div key={i} initial={{
          opacity: 0,
          y: 15
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: i * 0.1
        }}>
               <div className="bg-card/40 border-border dark:border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card/60 p-8">
                  <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-blue-500", stat.color)}>
                    <stat.icon className="w-10 h-10" />
                  </div>
                  <div className="flex items-center gap-2 mb-1">
                    <p className="text-[10px] font-bold text-muted-foreground">{stat.label}</p>
                    <span className={cn("text-[9px] font-bold ", stat.trendColor)}>{stat.trend} <TrendingUp className="w-2.5 h-2.5 inline" /></span>
                  </div>
                  <h3 className="text-xl font-bold text-foreground leading-none">{stat.value}</h3>
                  <div className={cn("absolute bottom-0 left-0 w-full h-1", stat.color.replace('text-', 'bg-'))}></div>
               </div>
             </motion.div>)}
          </div>
        )}

        {/* Behavioral Nexus (Charts Section) */}
        <div className="space-y-8">
          <Tabs value={selectedMetric} onValueChange={setSelectedMetric} className="w-full">
            <div className="px-4">
              <TabsList className="bg-card border border-border rounded-2xl h-14 p-1 shadow-2xl items-stretch w-full lg:w-fit">
                <TabsTrigger value="overview" className="flex-1 lg:flex-none rounded-xl text-[10px] font-bold data-[state=active]:bg-blue-600 data-[state=active]:text-foreground">{t("admin.analytics.globaloverview")}</TabsTrigger>
                <TabsTrigger value="users" className="flex-1 lg:flex-none rounded-xl text-[10px] font-bold data-[state=active]:bg-blue-600 data-[state=active]:text-foreground">{t("admin.analytics.useractivity")}</TabsTrigger>
                <TabsTrigger value="conversion" className="flex-1 lg:flex-none rounded-xl text-[10px] font-bold data-[state=active]:bg-blue-600 data-[state=active]:text-foreground">{t("admin.analytics.conversionfunnel")}</TabsTrigger>
                <TabsTrigger value="devices" className="flex-1 lg:flex-none rounded-xl text-[10px] font-bold data-[state=active]:bg-blue-600 data-[state=active]:text-foreground">{t("admin.analytics.devicetelemetry")}</TabsTrigger>
              </TabsList>
            </div>

            <div className="mt-8">
              <TabsContent value="overview" className="space-y-8">
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                  <div className="bg-card/40 border-border dark:border-border rounded-4xl p-8 shadow-2xl border-l border-t">
                    <div className="flex items-center justify-between mb-8">
                       <div>
                          <h4 className="text-xl font-bold text-foreground leading-none">{t("admin.analytics.activity_velocity")}</h4>
                          <p className="text-[10px] font-bold text-muted-foreground mt-1">{t("admin.analytics.daily_interaction_clusters")}</p>
                       </div>
                       <Cpu className="w-6 h-6 text-blue-500" />
                    </div>
                    <ResponsiveContainer width="100%" height={320} minWidth={0}>
                      <AreaChart data={analytics.userActivity}>
                        <defs>
                          <linearGradient id="colorUsers" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.3} />
                            <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                          </linearGradient>
                        </defs>
                        <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="rgba(255,255,255,0.05)" />
                        <XAxis dataKey="date" axisLine={false} tickLine={false} tick={{
                        fontSize: 10,
                        fill: '#64748b',
                        fontWeight: 900
                      }} />
                        <YAxis axisLine={false} tickLine={false} tick={{
                        fontSize: 10,
                        fill: '#64748b',
                        fontWeight: 900
                      }} />
                        <Tooltip content={<CustomTooltip />} cursor={{
                        stroke: '#3b82f6',
                        strokeWidth: 2
                      }} />
                        <Area type="monotone" dataKey="activeUsers" stroke="#3b82f6" strokeWidth={4} fillOpacity={1} fill="url(#colorUsers)" name={t("admin.analytics.active_users", "Aktif Kullanıcılar")} />
                        <Area type="monotone" dataKey="sessions" stroke="#10b981" strokeWidth={4} fillOpacity={0} name={t("admin.analytics.total_sessions", "Toplam Oturumlar")} />
                      </AreaChart>
                    </ResponsiveContainer>
                  </div>

                  <div className="bg-card/40 border-border dark:border-border rounded-4xl p-8 shadow-2xl border-l border-t">
                    <div className="flex items-center justify-between mb-8">
                       <div>
                          <h4 className="text-xl font-bold text-foreground leading-none">{t("admin.analytics.highfrequency_routes")}</h4>
                          <p className="text-[10px] font-bold text-muted-foreground mt-1">{t("admin.analytics.most_saturated_page_fragments")}</p>
                       </div>
                       <Globe className="w-6 h-6 text-emerald-500" />
                    </div>
                    <ResponsiveContainer width="100%" height={320} minWidth={0}>
                      <BarChart data={analytics.topPages}>
                         <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="rgba(255,255,255,0.05)" />
                         <XAxis dataKey="page" axisLine={false} tickLine={false} tick={{
                        fontSize: 10,
                        fill: '#64748b',
                        fontWeight: 900
                      }} />
                         <YAxis axisLine={false} tickLine={false} tick={{
                        fontSize: 10,
                        fill: '#64748b',
                        fontWeight: 900
                      }} />
                         <Tooltip content={<CustomTooltip />} cursor={{
                        fill: 'rgba(255,255,255,0.05)'
                      }} />
                         <Bar dataKey="views" fill="#3b82f6" radius={[6, 6, 0, 0]} barSize={40} name={t("admin.analytics.page_views", "Sayfa Görüntülemeleri")} />
                      </BarChart>
                    </ResponsiveContainer>
                  </div>
                </div>

                <div className="bg-card border-border rounded-4xl p-8 shadow-2xl border-l border-t relative overflow-hidden">
                   <div className="absolute top-0 left-0 w-1 h-full bg-blue-600"></div>
                   <div className="flex items-center justify-between mb-8">
                      <h4 className="text-xl font-bold text-foreground leading-none">{t("admin.analytics.critical_user_actions")}</h4>
                      <Zap className="w-6 h-6 text-blue-500" />
                   </div>
                   <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-4">
                      {analytics.topActions.map((action, i) => <div key={i} className="bg-card border border-border rounded-2xl p-6 transition-all hover:bg-muted/50 group">
                           <p className="text-[10px] font-bold text-muted-foreground mb-2 group-hover:text-blue-400 transition-colors">{action.action}</p>
                           <h5 className="text-3xl font-bold text-foreground leading-none">{action.count.toLocaleString()}</h5>
                           <p className="text-[9px] font-bold text-slate-600 mt-2">{action.users}{t("admin.analytics.uniquenodes")}</p>
                        </div>)}
                   </div>
                </div>
              </TabsContent>

              <TabsContent value="users" className="space-y-8">
                 <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                    {[{
                  label: t("admin.analytics.avgsessiontelemetry"),
                  value: formatDuration(analytics.avgSessionDuration),
                  icon: Activity
                }, {
                  label: t("admin.analytics.globalclustersessions"),
                  value: analytics.totalSessions.toLocaleString(),
                  icon: Globe
                }, {
                  label: t("admin.analytics.bounceratioreaction"),
                  value: `${analytics.bounceRate}%`,
                  icon: ZapOff
                }].map((m, i) => <div key={i} className="bg-card border-border rounded-3xl p-8 shadow-2xl border-l border-t">
                         <p className="text-[10px] font-bold text-muted-foreground mb-1">{m.label}</p>
                         <h3 className="text-xl font-bold text-foreground leading-none">{m.value}</h3>
                      </div>)}
                 </div>
                 <div className="bg-card border-border rounded-4xl p-10 shadow-2xl border-l border-t">
                    <h4 className="text-xl font-bold text-foreground mb-8 leading-none">{t("admin.analytics.node_saturation_matrix")}</h4>
                    <ResponsiveContainer width="100%" height={400} minWidth={0}>
                      <AreaChart data={analytics.userActivity}>
                        <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="rgba(255,255,255,0.05)" />
                        <XAxis dataKey="date" axisLine={false} tickLine={false} tick={{
                      fontSize: 10,
                      fill: '#64748b',
                      fontWeight: 900
                    }} />
                        <YAxis axisLine={false} tickLine={false} tick={{
                      fontSize: 10,
                      fill: '#64748b',
                      fontWeight: 900
                    }} />
                        <Tooltip content={<CustomTooltip />} />
                        <Area type="monotone" dataKey="activeUsers" stackId="1" stroke="#3b82f6" fill="#3b82f6" fillOpacity={0.6} name={t("admin.analytics.active_nodes", "Aktif Düğümler")} />
                        <Area type="monotone" dataKey="newUsers" stackId="1" stroke="#10b981" fill="#10b981" fillOpacity={0.4} name={t("admin.analytics.new_nodes", "Yeni Düğümler")} />
                      </AreaChart>
                    </ResponsiveContainer>
                 </div>
              </TabsContent>

              <TabsContent value="conversion" className="space-y-8">
                 <div className="bg-card/40 border-border dark:border-border rounded-4xl p-10 shadow-2xl border-l border-t overflow-hidden relative">
                    <div className="absolute top-0 right-0 w-48 h-48 bg-blue-600/10 blur-[100px] rounded-full"></div>
                    <h4 className="text-xl font-bold text-foreground mb-10 leading-none">{t("admin.analytics.synergy_conversion_funnel")}</h4>
                    <div className="grid grid-cols-1 lg:grid-cols-5 gap-8">
                       {analytics.conversionFunnel.map((stage, i) => <div key={i} className="relative group">
                            <div className="bg-card border-border rounded-3xl p-8 z-10 relative border-l border-t group-hover:bg-blue-600/10 transition-all">
                               <p className="text-[10px] font-bold text-muted-foreground mb-2">{stage.stage}</p>
                               <div className="text-xl font-bold text-foreground leading-none mb-1">{stage.users}</div>
                               <div className="text-sm font-bold text-blue-500">{stage.conversionRate}%</div>
                            </div>
                            {i < 4 && <div className="hidden lg:flex absolute top-1/2 -right-4 -translate-y-1/2 z-20 w-8 h-8 rounded-full bg-blue-600 items-center justify-center border-4 border-[#14151a] shadow-xl">
                                 <MoreVertical className="w-4 h-4 text-foreground rotate-90" />
                              </div>}
                         </div>)}
                    </div>
                    <div className="mt-12 h-24 w-full bg-linear-to-r from-blue-600/20 via-transparent to-transparent rounded-full blur-3xl opacity-30"></div>
                 </div>
              </TabsContent>

              <TabsContent value="devices" className="space-y-8">
                 <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                    <div className="bg-card border-border rounded-4xl p-10 shadow-2xl border-l border-t relative overflow-hidden">
                       <div className="absolute -top-10 -left-10 w-40 h-40 bg-purple-600/10 blur-[100px]"></div>
                       <h4 className="text-xl font-bold text-foreground mb-10 leading-none mr-12">{t("admin.analytics.hardware_origin_distribution")}</h4>
                       <ResponsiveContainer width="100%" height={320} minWidth={0}>
                         <PieChart>
                            <Pie data={analytics.deviceBreakdown} innerRadius={80} outerRadius={110} paddingAngle={8} dataKey="count" stroke="none">
                               {analytics.deviceBreakdown.map((_, index) => <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />)}
                            </Pie>
                            <Tooltip content={<CustomTooltip />} />
                            <Legend verticalAlign="bottom" height={36} iconType="circle" wrapperStyle={{
                        fontSize: '10px',
                        fontWeight: 'bold',
                        textTransform: '',
                        fontStyle: '',
                        letterSpacing: '0.1em',
                        paddingTop: '20px'
                      }} />
                         </PieChart>
                       </ResponsiveContainer>
                    </div>

                    <div className="bg-card border-border rounded-4xl p-10 shadow-2xl border-l border-t">
                       <h4 className="text-xl font-bold text-foreground mb-10 leading-none">{t("admin.analytics.telemetry_precision_detailed")}</h4>
                       <div className="space-y-4">
                          {analytics.deviceBreakdown.map((device, i) => <div key={i} className="flex items-center justify-between p-6 bg-card border border-border rounded-3xl hover:bg-muted/50 transition-all">
                               <div className="flex items-center gap-4">
                                  <div className="w-12 h-12 rounded-xl bg-blue-600/10 flex items-center justify-center text-blue-500">
                                     {getDeviceIcon(device.device)}
                                  </div>
                                  <div>
                                     <div className="text-lg font-bold text-foreground leading-none">{device.device}</div>
                                     <div className="text-[10px] font-bold text-muted-foreground mt-1">{device.count.toLocaleString()}{t("admin.analytics.activenodes")}</div>
                                  </div>
                               </div>
                               <div className="text-right">
                                  <div className="text-3xl font-bold text-foreground leading-none">{device.percentage}%</div>
                                  <div className="text-[9px] font-bold text-slate-600 mt-1">{t("admin.analytics.segmentshare")}</div>
                               </div>
                            </div>)}
                       </div>
                    </div>
                 </div>
              </TabsContent>
            </div>
          </Tabs>
        </div>
      </div>
    </PageShell>;
}