import { t } from "i18next";
import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { AreaChart, Area, BarChart, Bar, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from "recharts";
import { TrendingUp, Building, Users, DollarSign, CheckSquare, ArrowUpRight, ArrowDownRight, Activity, ShieldCheck, Sparkles, Star } from "lucide-react";
import { apiClient } from "@/lib/api/client";
import { cn } from "@/lib/utils";
import { toast } from "@/components/hooks/use-toast";
interface DashboardMetrics {
  totalRevenue: number;
  totalExpenses: number;
  totalProfit: number;
  totalProperties: number;
  occupiedProperties: number;
  vacantProperties: number;
  totalUsers: number;
  activeUsers: number;
  totalTasks: number;
  completedTasks: number;
  pendingTasks: number;
  revenueGrowth: number;
  occupancyRate: number;
  avgTaskCompletion: number;
}
interface RevenueData {
  month: string;
  revenue: number;
  expenses: number;
  profit: number;
}
interface PropertyTypeData {
  name: string;
  value: number;
  color: string;
  [key: string]: string | number | boolean | undefined;
}
interface TaskBreakdownData {
  name: string;
  value: number;
  color: string;
  [key: string]: string | number | boolean | undefined;
}
interface TopAgent {
  id: string;
  name: string;
  email: string;
  avatar?: string;
  totalDeals: number;
  totalRevenue: number;
  rating: number;
  commission: number;
}
interface RecentActivity {
  id: string;
  type: "DEAL" | "TASK" | "PROPERTY" | "USER" | "PAYMENT" | "AI" | "ESCROW";
  title: string;
  description: string;
  timestamp: string;
  user?: string;
}
const ACTIVITY_ICONS = {
  DEAL: TrendingUp,
  TASK: CheckSquare,
  PROPERTY: Building,
  USER: Users,
  PAYMENT: DollarSign,
  AI: Sparkles,
  ESCROW: ShieldCheck
};
export default function Dashboard() {
  const { t } = useTranslation();
  const [period, setPeriod] = useState("3m");
  const [loading, setLoading] = useState(true);
  const [metrics, setMetrics] = useState<DashboardMetrics | null>(null);
  const [revenueData, setRevenueData] = useState<RevenueData[]>([]);
  const [propertyTypeData, setPropertyTypeData] = useState<PropertyTypeData[]>([]);
  const [taskBreakdownData, setTaskBreakdownData] = useState<TaskBreakdownData[]>([]);
  const [topAgents, setTopAgents] = useState<TopAgent[]>([]);
  const [recentActivities, setRecentActivities] = useState<RecentActivity[]>([]);
  useEffect(() => {
    fetchDashboardData();
  }, [period]);
  const fetchDashboardData = async () => {
    setLoading(true);
    try {
      // Assuming orgId is derived from context/user. We can use a demo string or user?.orgId
      const orgId = "org_1"; 
      const response = await apiClient.get(`/system/dashboard-analytics/summary?orgId=${orgId}`) as any;

      if (response.data?.success) {
        const data = response.data.data;
        
        setMetrics({
          totalRevenue: data.totalRevenue,
          totalExpenses: data.totalExpenses,
          totalProfit: data.totalProfit,
          totalProperties: data.totalProperties,
          occupiedProperties: data.occupiedProperties,
          vacantProperties: data.vacantProperties,
          totalUsers: data.totalUsers,
          activeUsers: data.activeUsers,
          totalTasks: data.totalTasks,
          completedTasks: data.completedTasks,
          pendingTasks: data.pendingTasks,
          revenueGrowth: data.revenueGrowth,
          occupancyRate: data.occupancyRate,
          avgTaskCompletion: data.avgTaskCompletion
        });
        
        setRevenueData(data.revenueData);
        setPropertyTypeData(data.propertyTypeData);
        setTaskBreakdownData(data.taskBreakdownData);
        setTopAgents(data.topAgents);
        setRecentActivities(data.recentActivities);
      }
    } catch (error) {
      toast({
        title: t('error'),
        description: t("admin.core.failed_to_sync_with"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  if (loading || !metrics) {
    return <PageShell title={t('dashboardTitle')} description={t('dashboard.pulseMonitoring')}>
        <div className="flex items-center justify-center h-[60vh]">
          <div className="w-12 h-12 border-4 border-blue-600/20 border-t-blue-600 rounded-full animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t('dashboardTitle')} description={t('dashboard.pulseMonitoring')}>
      <div className="max-w-[1600px] mx-auto p-6 space-y-8 pb-20">
        
        {/* Superior Header Control */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 bg-card backdrop-blur-xl p-6 rounded-[2.5rem] border border-border">
          <div className="flex items-center gap-4">
            <div className="w-12 h-12 rounded-2xl bg-blue-600/20 flex items-center justify-center border border-blue-500/30">
              <Activity className="w-6 h-6 text-blue-400 animate-pulse" />
            </div>
            <div>
              <h2 className="text-lg font-bold text-foreground">{t('dashboard.statsHub')}</h2>
              <p className="text-xs font-medium text-muted-foreground tracking-wider">{t('overview')}</p>
            </div>
          </div>
          
          <div className="flex items-center gap-3">
             <Select value={period} onValueChange={setPeriod}>
                <SelectTrigger className="w-40 bg-card border-border text-foreground font-medium text-sm h-10 rounded-lg">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent className="bg-card border-border text-foreground font-medium text-sm">
                  <SelectItem value="24h">{t('dashboard.periods.24h')}</SelectItem>
                  <SelectItem value="7d">{t('dashboard.periods.7d')}</SelectItem>
                  <SelectItem value="3m">{t('dashboard.periods.3m')}</SelectItem>
                  <SelectItem value="1y">{t('dashboard.periods.1y')}</SelectItem>
                </SelectContent>
             </Select>
             <div className="h-12 w-12 rounded-2xl bg-blue-600 hover:bg-blue-500 transition-colors flex items-center justify-center cursor-pointer shadow-lg shadow-blue-600/20">
                <ArrowUpRight className="w-5 h-5 text-foreground" />
             </div>
          </div>
        </div>

        {/* Global KPI Matrix */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <KPICard title={t('totalRevenue')} value={`$${(metrics.totalRevenue / 1000000).toFixed(2)}M`} trend="+12.5%" trendType="up" icon={DollarSign} color="blue" />
          <KPICard title={t('totalProperties')} value={metrics.totalProperties.toString()} trend="+48" trendType="up" icon={Building} color="purple" />
          <KPICard title={t('totalMembers')} value={metrics.totalUsers.toString()} trend="-2.4%" trendType="down" icon={Users} color="emerald" />
          <KPICard title={t('aiAnalytics')} value={`${metrics.occupancyRate}%`} trend="+4.2%" trendType="up" icon={Sparkles} color="amber" />
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Main Revenue Chart */}
          <Card className="lg:col-span-2 bg-card border-border rounded-4xl p-6 shadow-sm">
            <CardHeader className="p-0 mb-6 flex flex-row items-center justify-between">
              <div>
                <CardTitle className="text-lg font-bold text-foreground">{t('dashboard.portfolioGrowth')}</CardTitle>
                <p className="text-xs font-medium text-muted-foreground tracking-wider">{t('statistics')}</p>
              </div>
              <div className="flex items-center gap-4 text-xs font-medium tracking-wider">
                <div className="flex items-center gap-2 text-blue-500">
                  <div className="w-2 h-2 rounded-full bg-blue-500" /> {t('invoicesAmount')}
                </div>
                <div className="flex items-center gap-2 text-purple-500">
                  <div className="w-2 h-2 rounded-full bg-purple-500" /> {t('avgMemberValue')}
                </div>
              </div>
            </CardHeader>
            <CardContent className="p-0 h-[350px]">
              <ResponsiveContainer width="100%" height={350} minWidth={0}>
                <AreaChart data={revenueData}>
                  <defs>
                    <linearGradient id="colorRev" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.3} />
                      <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#ffffff05" vertical={false} />
                  <XAxis dataKey="month" axisLine={false} tickLine={false} tick={{
                  fill: '#64748b',
                  fontSize: 10,
                  fontWeight: 900
                }} />
                  <YAxis axisLine={false} tickLine={false} tick={{
                  fill: '#64748b',
                  fontSize: 10,
                  fontWeight: 600
                }} tickFormatter={v => `$${v / 1000}k`} />
                  <Tooltip contentStyle={{
                  backgroundColor: 'hsl(var(--card))',
                  border: '1px solid hsl(var(--border))',
                  borderRadius: '0.5rem',
                  color: 'hsl(var(--foreground))'
                }} itemStyle={{
                  fontSize: '12px',
                  fontWeight: 600
                }} />
                  <Area type="monotone" dataKey="revenue" stroke="#3b82f6" strokeWidth={4} fillOpacity={1} fill="url(#colorRev)" />
                  <Area type="monotone" dataKey="profit" stroke="#a855f7" strokeWidth={4} fill="transparent" />
                </AreaChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>

          {/* Type Distribution */}
          <Card className="bg-card border-border rounded-4xl p-6 shadow-sm">
             <CardHeader className="p-0 mb-6">
                <CardTitle className="text-lg font-bold text-foreground">{t('propertiesStatus')}</CardTitle>
                <p className="text-xs font-medium text-muted-foreground tracking-wider">{t('properties')}</p>
             </CardHeader>
             <CardContent className="p-0 h-[350px] flex flex-col items-center justify-center">
                <ResponsiveContainer width="100%" height={220} minWidth={0}>
                  <PieChart>
                    <Pie data={propertyTypeData} cx="50%" cy="50%" innerRadius={60} outerRadius={80} paddingAngle={8} dataKey="value">
                      {propertyTypeData.map((entry, index) => <Cell key={`cell-${index}`} fill={entry.color} strokeWidth={0} />)}
                    </Pie>
                    <Tooltip />
                  </PieChart>
                </ResponsiveContainer>
                <div className="grid grid-cols-2 gap-4 w-full mt-8">
                   {propertyTypeData.map(type => <div key={type.name} className="flex flex-col gap-1">
                        <div className="flex items-center gap-2">
                           <div className="w-2 h-2 rounded-full" style={{
                    backgroundColor: type.color
                  }} />
                           <span className="text-xs font-medium text-muted-foreground">{type.name}</span>
                        </div>
                        <span className="text-base font-bold text-foreground">{type.value}%</span>
                     </div>)}
                </div>
             </CardContent>
          </Card>
        </div>

        {/* Tactical Overview */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
           {/* Task Completion */}
           <Card className="bg-card border-border rounded-4xl p-6 shadow-sm">
              <CardHeader className="p-0 mb-6">
                <CardTitle className="text-lg font-bold text-foreground">{t('dashboard.tasksDynamic')}</CardTitle>
                <p className="text-xs font-medium text-muted-foreground tracking-wider">{t('dashboard.realTimeIndex')}</p>
              </CardHeader>
              <CardContent className="p-0 h-[300px]">
                <ResponsiveContainer width="100%" height={300} minWidth={0}>
                   <BarChart data={taskBreakdownData}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#ffffff05" vertical={false} />
                      <XAxis dataKey="name" axisLine={false} tickLine={false} tick={{
                  fill: '#64748b',
                  fontSize: 10,
                  fontWeight: 900
                }} />
                      <YAxis hide />
                      <Bar dataKey="value" radius={[10, 10, 0, 0]}>
                         {taskBreakdownData.map((entry, index) => <Cell key={`cell-${index}`} fill={entry.color} />)}
                      </Bar>
                   </BarChart>
                </ResponsiveContainer>
              </CardContent>
           </Card>

           {/* Top Agents */}
           <Card className="bg-card border-border rounded-4xl p-6 shadow-sm">
              <CardHeader className="p-0 mb-6 flex flex-row items-center justify-between">
                <div>
                  <CardTitle className="text-lg font-bold text-foreground">{t('dashboard.topAgents')}</CardTitle>
                  <p className="text-xs font-medium text-muted-foreground tracking-wider">{t('dashboard.fieldOperativesMatrix')}</p>
                </div>
                <div className="w-10 h-10 rounded-xl bg-blue-600/10 border border-blue-500/20 flex items-center justify-center">
                   <Users className="w-5 h-5 text-blue-400" />
                </div>
              </CardHeader>
              <CardContent className="p-0 space-y-4">
                  {topAgents.map(agent => <div key={agent.id} className="flex items-center justify-between p-3 bg-accent/30 rounded-xl border border-border/50 hover:bg-accent/50 transition-all cursor-pointer group">
                      <div className="flex items-center gap-3">
                         <Avatar className="h-9 w-9 rounded-lg border border-border/50">
                            <AvatarFallback className="bg-blue-500/10 text-blue-500 text-xs font-semibold">{agent.name.substring(0, 2).toUpperCase()}</AvatarFallback>
                         </Avatar>
                         <div>
                            <h4 className="text-sm font-semibold text-foreground">{agent.name}</h4>
                            <p className="text-xs text-muted-foreground">{agent.totalDeals} {t('dashboard.transactions')}</p>
                         </div>
                      </div>
                      <div className="text-right">
                         <p className="text-sm font-semibold text-emerald-500">${(agent.totalRevenue / 1000).toFixed(1)}k</p>
                         <div className="flex items-center gap-1 justify-end">
                            <Star className="w-3 h-3 fill-yellow-500 text-yellow-500" />
                            <span className="text-xs font-medium text-muted-foreground">{agent.rating}</span>
                         </div>
                      </div>
                   </div>)}
              </CardContent>
           </Card>
        </div>

        {/* Global Signal Trace */}
        <Card className="bg-card border-border rounded-4xl p-6 shadow-sm">
           <CardHeader className="p-0 mb-6">
              <CardTitle className="text-lg font-bold text-foreground">{t('recentActivity')}</CardTitle>
              <p className="text-xs font-medium text-muted-foreground tracking-wider">{t('admin.lastSync')}: {t('dashboard.lastSyncJustNow')}</p>
           </CardHeader>
           <CardContent className="p-0">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                 {recentActivities.map(activity => {
              const Icon = (ACTIVITY_ICONS as any)[activity.type] || Activity;
              return <div key={activity.id} className="p-5 bg-accent/30 rounded-2xl border border-border/50 relative overflow-hidden group">
                        <div className="absolute -top-2 -right-2 opacity-[0.03] scale-150 group-hover:scale-110 transition-transform">
                           <Icon className="w-16 h-16 text-primary" />
                        </div>
                        <div className="flex items-center gap-2 mb-3">
                           <div className="p-1.5 rounded-md bg-primary/10 text-primary">
                             <Icon className="w-4 h-4" />
                           </div>
                           <span className="text-xs font-semibold text-primary tracking-wider">{activity.type}</span>
                        </div>
                        <h4 className="text-sm font-semibold text-foreground mb-1">{activity.title}</h4>
                        <p className="text-xs text-muted-foreground mb-4">{activity.description}</p>
                        <div className="flex items-center justify-between pt-3 border-t border-border/50 text-xs font-medium text-muted-foreground">
                           <span>{activity.user}</span>
                           <span>{activity.timestamp}</span>
                        </div>
                     </div>;
            })}
              </div>
           </CardContent>
        </Card>
      </div>
    </PageShell>;
}
function KPICard({
  title,
  value,
  trend,
  trendType,
  icon: Icon,
  color
}: any) {
  const colorMap: any = {
    blue: "text-blue-400 bg-blue-950/20 border-blue-500/20",
    purple: "text-purple-400 bg-purple-950/20 border-purple-500/20",
    emerald: "text-emerald-400 bg-emerald-950/20 border-emerald-500/20",
    amber: "text-amber-400 bg-amber-950/20 border-amber-500/20"
  };
  return <Card className="bg-card border-border rounded-4xl p-6 shadow-sm relative overflow-hidden group hover:bg-accent/50 transition-all">
      <div className="absolute -top-4 -right-4 opacity-5 group-hover:scale-110 transition-transform">
         <Icon className="w-24 h-24" />
      </div>
      <div className="flex items-start justify-between mb-6">
        <div className={cn("p-3 rounded-2xl border", colorMap[color])}>
           <Icon className="w-6 h-6" />
        </div>
        <div className={cn("flex items-center gap-1 px-2 py-1 rounded-lg text-[10px] font-bold ", trendType === 'up' ? "text-emerald-400 bg-emerald-500/10" : "text-red-400 bg-red-500/10")}>
          {trendType === 'up' ? <ArrowUpRight className="w-3 h-3" /> : <ArrowDownRight className="w-3 h-3" />}
          {trend}
        </div>
      </div>
      <div>
        <p className="text-xs font-medium text-muted-foreground tracking-wider mb-1">{title}</p>
        <h3 className="text-2xl font-bold text-foreground">{value}</h3>
      </div>
    </Card>;
}