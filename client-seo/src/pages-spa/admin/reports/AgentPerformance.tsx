"use client";

import { useTranslation } from"react-i18next";
import { useState } from"react";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Avatar, AvatarFallback } from"@/components/ui/avatar";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { BarChart, Bar, LineChart, Line, RadarChart, Radar, PolarGrid, PolarAngleAxis, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell } from"recharts";
import { Search, Eye, RefreshCw, Activity, Plus } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { useQuery } from"@tanstack/react-query";

interface AgentPerformanceRecord {
 id: string;
 userId: string;
 period: string;
 startDate: string;
 endDate: string;
 leadsGenerated: number;
 showingsCompleted: number;
 offersSubmitted: number;
 dealsClosed: number;
 commissionEarned: number;
 status?: string;
 user?: {
 id: string;
 name: string;
 email: string;
 agency?: { name: string };
 };
}
interface MonthlyTrendPoint {
 month: string;
 [agentName: string]: number | string;
}
interface ConversionPoint {
 name: string;
 leadsToShowings: number;
 showingsToOffers: number;
 offersToDeals: number;
}
interface RadarPoint {
 metric: string;
 [agentName: string]: number | string;
}
interface AgentAggregate {
 id: string; name: string; agency: string;
 leads: number; showings: number; offers: number; deals: number; commission: number; status: string;
}
const AGENT_COLORS = ["#6366f1","#8b5cf6","#ec4899","#f59e0b","#10b981","#ef4444"];
const $ = (v: number) => new Intl.NumberFormat("en-US", { style:"currency", currency:"USD", maximumFractionDigits: 0 }).format(v);
const CustomTooltip = ({ active, payload, label }: any) => {
  const { t } = useTranslation();
 if (!active || !payload?.length) return null;
 return <div className="bg-[#1a1b1e] border border-border rounded-lg p-3 text-xs shadow-md space-y-1">
 <p className="font-medium text-foreground">{label}</p>
 {payload.map((p: any) => <p key={p.name} style={{ color: p.color }}>
 {p.name}{t("mobile.leftovers.", ":")}{p.value > 1000 ? $(p.value) : `${p.value}%`}
 </p>)}
 </div>;
};
function buildMonthlyTrend(records: AgentPerformanceRecord[], topNames: string[]): MonthlyTrendPoint[] {
 const months: Record<string, MonthlyTrendPoint> = {};
 records.forEach(r => {
 const label = new Date(r.startDate).toLocaleString("en-US", { month:"short" });
 if (!months[label]) months[label] = { month: label };
 const name = r.user?.name ?? r.userId;
 if (topNames.includes(name)) {
 months[label][name] = (months[label][name] as number ?? 0) + Number(r.commissionEarned);
 }
 });
 return Object.values(months);
}
function buildConversion(records: AgentPerformanceRecord[]): ConversionPoint[] {
 const byUser: Record<string, AgentPerformanceRecord[]> = {};
 records.forEach(r => {
 const k = r.user?.name ?? r.userId;
 if (!byUser[k]) byUser[k] = [];
 byUser[k].push(r);
 });
 return Object.entries(byUser).slice(0, 4).map(([name, recs]) => {
 const leads = recs.reduce((s, r) => s + r.leadsGenerated, 0);
 const showings = recs.reduce((s, r) => s + r.showingsCompleted, 0);
 const offers = recs.reduce((s, r) => s + r.offersSubmitted, 0);
 const deals = recs.reduce((s, r) => s + r.dealsClosed, 0);
 return { name, leadsToShowings: leads > 0 ? Math.round(showings / leads * 100) : 0, showingsToOffers: showings > 0 ? Math.round(offers / showings * 100) : 0, offersToDeals: offers > 0 ? Math.round(deals / offers * 100) : 0 };
 });
}
function buildRadar(records: AgentPerformanceRecord[], topNames: string[], t: (key: string, fallback?: string) => string): RadarPoint[] {
 const totals: Record<string, { leads: number; showings: number; offers: number; deals: number; commission: number }> = {};
 records.forEach(r => {
 const name = r.user?.name ?? r.userId;
 if (!totals[name]) totals[name] = { leads: 0, showings: 0, offers: 0, deals: 0, commission: 0 };
 totals[name].leads += r.leadsGenerated;
 totals[name].showings += r.showingsCompleted;
 totals[name].offers += r.offersSubmitted;
 totals[name].deals += r.dealsClosed;
 totals[name].commission += Number(r.commissionEarned);
 });
 const top = topNames.slice(0, 3);
 const baseline = totals[top[0]];
 if (!baseline) return [];
 const metrics = [
 { key: t("admin_reports_metrics_leads","Adaylar"), prop:"leads" as const },
 { key: t("admin_reports_metrics_showings","Gösterimler"), prop:"showings" as const },
 { key: t("admin_reports_metrics_offers","Teklifler"), prop:"offers" as const },
 { key: t("admin_reports_metrics_deals","Anlaşmalar"), prop:"deals" as const },
 { key: t("admin_reports_metrics_revenue","Gelir"), prop:"commission" as const },
 ];
 return metrics.map(({ key: metric, prop }) => {
 const point: RadarPoint = { metric };
 top.forEach(name => {
 const t_stats = totals[name];
 if (!t_stats) return;
 point[name] = baseline[prop] > 0 ? Math.round(t_stats[prop] / baseline[prop] * 100) : 0;
 });
 return point;
 });
}
export default function AgentPerformance() {
 const { t } = useTranslation();
 const { toast } = useToast();
 const [selectedAgent, setSelectedAgent] = useState<string | null>(null);
 const [tab, setTab] = useState("leaderboard");
 const [search, setSearch] = useState("");
 const [period, setPeriod] = useState("current");
 const { data: records = [], isLoading } = useQuery({
 queryKey: ['agent-performance', period],
 queryFn: async () => {
 const res = await apiClient.get("/agent-performance", { period, include:"user,agency", limit:"100" }) as { data: AgentPerformanceRecord[] };
 return res.data || [];
 }
 });
 const agentMap = new Map<string, AgentAggregate>();
 records.forEach(r => {
 const name = r.user?.name ?? r.userId;
 const agency = r.user?.agency?.name ??"—";
 if (!agentMap.has(r.userId)) {
 agentMap.set(r.userId, { id: r.userId, name, agency, leads: 0, showings: 0, offers: 0, deals: 0, commission: 0, status: r.status ??"ACTIVE" });
 }
 const entry = agentMap.get(r.userId)!;
 entry.leads += r.leadsGenerated;
 entry.showings += r.showingsCompleted;
 entry.offers += r.offersSubmitted;
 entry.deals += r.dealsClosed;
 entry.commission += Number(r.commissionEarned);
 });
 const AGENTS = [...agentMap.values()].sort((a, b) => b.commission - a.commission);
 const filtered = AGENTS.filter(a => `${a.name} ${a.agency}`.toLowerCase().includes(search.toLowerCase()));
 const topNames = AGENTS.slice(0, 4).map(a => a.name);
 const MONTHLY_TREND = buildMonthlyTrend(records, topNames);
 const CONVERSION = buildConversion(records);
 const RADAR_DATA = buildRadar(records, topNames.slice(0, 3), t as any);
 const totalDeals = AGENTS.reduce((s, a) => s + a.deals, 0);
 const totalCommission = AGENTS.reduce((s, a) => s + a.commission, 0);
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen bg-background">
 <div className="p-8 lg:p-12 space-y-10 min-h-screen bg-background text-foreground transition-colors duration-300">
 <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-8 relative">
 <div className="space-y-2 relative z-10">
 <h1 className="text-2xl md:text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_reports_agent_performance")}</h1>
 <p className="text-sm text-muted-foreground mt-2 opacity-80">{t("admin_reports_leaderboards_conversion_funnels_and")}</p>
 </div>
 <div className="flex items-center gap-4 relative z-10">
 <div className="flex items-center gap-2">
 <Select value={period} onValueChange={setPeriod}>
 <SelectTrigger className="w-36 bg-card border-border text-foreground"><SelectValue /></SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground">
 <SelectItem value="current">{t("admin_reports_current_period")}</SelectItem>
 <SelectItem value="last_quarter">{t("admin_reports_last_quarter")}</SelectItem>
 <SelectItem value="last_year">{t("admin_reports_last_year")}</SelectItem>
 <SelectItem value="all">{t("admin_reports_all_time")}</SelectItem>
 </SelectContent>
 </Select>
 <Button variant="outline" size="sm" disabled={isLoading} className="border-border text-foreground bg-card">
 <RefreshCw className={`w-4 h-4 ${isLoading ?"animate-spin" :""}`} />
 </Button>
 </div>
 </div>
 </div>

 <div className="grid grid-cols-2 lg:grid-cols-4 gap-6">
 {[{ label: t("admin_reports_active_agents"), value: isLoading ?"—" : AGENTS.filter(a => a.status ==="ACTIVE").length },
 { label: t("admin_reports_total_deals"), value: isLoading ?"—" : totalDeals },
 { label: t("admin_reports_total_commission"), value: isLoading ?"—" : $(totalCommission) }].map((stat, idx) => <div key={stat.label}
 className="bg-[#1a1b1e]/60 border border-white/5 border-l border-t rounded-[32px] p-8 backdrop-blur-3xl shadow-2xl relative overflow-hidden group hover:bg-accent/10 transition-all"
 >
 <div className="absolute top-0 right-0 p-6 opacity-5 text-primary group-hover:scale-110 transition-transform">
 <Activity className="w-12 h-12" />
 </div>
 <p className="text-xs font-semibold text-muted-foreground tracking-wider mb-2">{stat.label}</p>
 <p className="text-2xl font-bold text-foreground">{stat.value}</p>
 <div className="mt-4 h-1 w-full bg-muted rounded-full overflow-hidden">
 <div className="h-full bg-primary shadow-[0_0_10px_var(--color-primary)] w-2/3" />
 </div>
 </div>)}
 </div>

 <div className="flex flex-col lg:flex-row gap-6 items-center">
 <div className="relative flex-1 w-full lg:max-w-md group">
 <Search className="absolute left-5 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-primary transition-colors" />
 <Input
 placeholder={t("admin_reports_search_agents","Temsilcilerde ara...")}
 value={search}
 onChange={(e) => setSearch(e.target.value)}
 className="h-11 pl-10 bg-[#1a1b1e]/60 border border-border rounded-lg text-sm text-foreground placeholder:text-slate-500 focus:border-primary/50 transition-all shadow-sm"
 />
 </div>
 <div className="flex flex-wrap gap-4 w-full lg:w-auto items-center">
 <Select value="all" disabled>
 <SelectTrigger className="w-40 bg-card border-border text-foreground"><SelectValue placeholder={t("admin_reports_agency")} /></SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground">
 <SelectItem value="all">{t("admin_reports_all_agencies")}</SelectItem>
 </SelectContent>
 </Select>
 <Select value="all" disabled>
 <SelectTrigger className="w-32 bg-card border-border text-foreground"><SelectValue placeholder={t("admin_reports_status")} /></SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground">
 <SelectItem value="all">{t("admin_reports_all")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>

 <div className="relative">
 <Tabs value={tab} onValueChange={setTab}>
 <TabsList className="mb-4 bg-card border border-border">
 <TabsTrigger value="leaderboard" className="text-muted-foreground data-[state=active]:bg-white/10 data-[state=active]:text-white">{t("admin_reports_leaderboard")}</TabsTrigger>
 <TabsTrigger value="trends" className="text-muted-foreground data-[state=active]:bg-white/10 data-[state=active]:text-white">{t("admin_reports_commission_trends")}</TabsTrigger>
 <TabsTrigger value="conversion" className="text-muted-foreground data-[state=active]:bg-white/10 data-[state=active]:text-white">{t("admin_reports_conversion_funnel")}</TabsTrigger>
 <TabsTrigger value="radar" className="text-muted-foreground data-[state=active]:bg-white/10 data-[state=active]:text-white">{t("admin_reports_comparison_radar")}</TabsTrigger>
 </TabsList>

 <TabsContent value="leaderboard" className="space-y-4">
 <Card className="bg-card border-border">
 <CardHeader className="pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t("admin_reports_commission_earned")}</CardTitle>
 </CardHeader>
 <CardContent>
 <ResponsiveContainer width="100%" height={220} minWidth={0}>
 <BarChart data={filtered} layout="vertical" margin={{ top: 0, right: 16, left: 80, bottom: 0 }}>
 <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" strokeOpacity={0.4} horizontal={false} />
 <XAxis type="number" tickFormatter={v => `$${(v / 1000).toFixed(0)}k`} tick={{ fontSize: 11, fill: '#94a3b8' }} tickLine={false} axisLine={false} />
 <YAxis type="category" dataKey="name" tick={{ fontSize: 11, fill: '#94a3b8' }} tickLine={false} axisLine={false} width={80} />
 <Tooltip content={<CustomTooltip />} />
 <Bar dataKey="commission" name={t("admin_reports_commission","Komisyon")} radius={[0, 4, 4, 0]} maxBarSize={28}>
 {filtered.map((_, i) => <Cell key={i} fill={AGENT_COLORS[i % AGENT_COLORS.length]} />)}
 </Bar>
 </BarChart>
 </ResponsiveContainer>
 </CardContent>
 </Card>

 <div className="grid gap-3">
 {filtered.map((agent, idx) => <div key={agent.id} className="bg-[#1a1b1e]/60 border border-border rounded-xl p-4 flex items-center gap-4 hover:bg-card cursor-pointer transition-colors" onClick={() => setSelectedAgent(selectedAgent === agent.id ? null : agent.id)}>
 <div className="w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold shrink-0" style={{
 background: idx < 3 ? AGENT_COLORS[idx] +"20" :"var(--color-background-secondary)",
 color: idx < 3 ? AGENT_COLORS[idx] :"var(--color-text-tertiary)"
 }}>
 {idx + 1}
 </div>
 <Avatar className="h-9 w-9 shrink-0">
 <AvatarFallback className="text-xs bg-primary/10 text-primary font-medium">
 {agent.name.split("").map(n => n[0]).join("")}
 </AvatarFallback>
 </Avatar>
 <div className="flex-1 min-w-0">
 <div className="flex items-center gap-2 flex-wrap">
 <p className="text-sm font-semibold text-foreground">{agent.name}</p>
 {idx === 0 && <Badge className="bg-amber-100 text-amber-700 border-0 text-[10px]">{t("admin_reports_top_agent")}</Badge>}
 <Badge className={`border-0 text-[10px] ${agent.status ==="ACTIVE" ?"bg-green-100 text-green-700" :"bg-slate-100 text-slate-500"}`}>
 {agent.status ==="ACTIVE" ? t("admin_reports_status_active","Aktif") : agent.status}
 </Badge>
 </div>
 <p className="text-xs text-muted-foreground">{agent.agency} · {period}</p>
 </div>
 <div className="hidden sm:grid grid-cols-4 gap-6 text-right shrink-0">
 {[{ label: t("admin_reports_leads"), value: agent.leads },
 { label: t("admin_reports_deals"), value: agent.deals },
 { label: t("admin_reports_rating"), value:"—" },
 { label: t("admin_reports_commission"), value: $(agent.commission) }].map(s => <div key={s.label}>
 <p className="text-xs text-muted-foreground">{s.label}</p>
 <p className="text-sm font-semibold text-foreground mt-0.5">{s.value}</p>
 </div>)}
 </div>
 <Button variant="ghost" size="icon" className="h-8 w-8 shrink-0 text-muted-foreground">
 <Eye className="w-4 h-4" />
 </Button>
 </div>)}
 </div>
 </TabsContent>

 <TabsContent value="trends">
 <Card className="bg-card border-border">
 <CardHeader className="pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t("admin_reports_monthly_commission_top_4")}</CardTitle>
 </CardHeader>
 <CardContent>
 <ResponsiveContainer width="100%" height={300} minWidth={0}>
 <LineChart data={MONTHLY_TREND} margin={{ top: 5, right: 16, left: 0, bottom: 0 }}>
 <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" strokeOpacity={0.4} />
 <XAxis dataKey="month" tick={{ fontSize: 11, fill: '#94a3b8' }} tickLine={false} axisLine={false} />
 <YAxis tickFormatter={v => `$${(v / 1000).toFixed(0)}k`} tick={{ fontSize: 11, fill: '#94a3b8' }} tickLine={false} axisLine={false} width={50} />
 <Tooltip content={<CustomTooltip />} />
 {topNames.map((name, i) => <Line key={name} type="monotone" dataKey={name} name={name} stroke={AGENT_COLORS[i]} strokeWidth={2} dot={false} />)}
 </LineChart>
 </ResponsiveContainer>
 <div className="flex flex-wrap gap-4 mt-3">
 {topNames.map((name, i) => <div key={name} className="flex items-center gap-1.5 text-xs text-muted-foreground">
 <span className="w-3 h-0.5 inline-block rounded-lg" style={{ background: AGENT_COLORS[i] }} />
 {name}
 </div>)}
 </div>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="conversion">
 <Card className="bg-card border-border">
 <CardHeader className="pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t("admin_reports_conversion_rates_leads_showings")}</CardTitle>
 </CardHeader>
 <CardContent>
 <ResponsiveContainer width="100%" height={280} minWidth={0}>
 <BarChart data={CONVERSION} margin={{ top: 5, right: 16, left: 80, bottom: 0 }} layout="vertical">
 <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" strokeOpacity={0.4} horizontal={false} />
 <XAxis type="number" domain={[0, 100]} tickFormatter={v => `${v}%`} tick={{ fontSize: 11, fill: '#94a3b8' }} tickLine={false} axisLine={false} />
 <YAxis type="category" dataKey="name" tick={{ fontSize: 11, fill: '#94a3b8' }} tickLine={false} axisLine={false} width={80} />
 <Tooltip formatter={(v: any) => `${v}%`} />
 <Bar dataKey="leadsToShowings" name={t("admin_reports_leads_to_showings","Adaylar→Gösterimler")} fill="#6366f1" radius={[0, 2, 2, 0]} maxBarSize={14} />
 <Bar dataKey="showingsToOffers" name={t("admin_reports_showings_to_offers","Gösterimler→Teklifler")} fill="#8b5cf6" radius={[0, 2, 2, 0]} maxBarSize={14} />
 <Bar dataKey="offersToDeals" name={t("admin_reports_offers_to_deals","Teklifler→Anlaşmalar")} fill="#10b981" radius={[0, 2, 2, 0]} maxBarSize={14} />
 </BarChart>
 </ResponsiveContainer>
 <div className="flex flex-wrap gap-4 mt-2">
 {[["#6366f1", t("admin_reports_leads_to_showings","Adaylar→Gösterimler")],
 ["#8b5cf6", t("admin_reports_showings_to_offers","Gösterimler→Teklifler")],
 ["#10b981", t("admin_reports_offers_to_deals","Teklifler→Anlaşmalar")]].map(([c, l]) => <div key={l} className="flex items-center gap-1.5 text-xs text-muted-foreground">
 <span className="w-2 h-2 rounded-sm inline-block" style={{ background: c }} />{l}
 </div>)}
 </div>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="radar">
 <Card className="bg-card border-border">
 <CardHeader className="pb-2">
 <CardTitle className="text-sm font-medium text-foreground">
 {t("admin_reports_performance_comparison_top_3")}{topNames[0] ??"top agent"} = 100)
 </CardTitle>
 </CardHeader>
 <CardContent>
 <ResponsiveContainer width="100%" height={320} minWidth={0}>
 <RadarChart data={RADAR_DATA}>
 <PolarGrid stroke="rgba(255,255,255,0.1)" />
 <PolarAngleAxis dataKey="metric" tick={{ fontSize: 12, fill: '#94a3b8' }} />
 {topNames.slice(0, 3).map((name, i) => <Radar key={name} name={name} dataKey={name} stroke={AGENT_COLORS[i]} fill={AGENT_COLORS[i]} fillOpacity={0.15} />)}
 <Tooltip />
 </RadarChart>
 </ResponsiveContainer>
 <div className="flex flex-wrap gap-4 mt-1 justify-center">
 {topNames.slice(0, 3).map((name, i) => <div key={name} className="flex items-center gap-1.5 text-xs text-muted-foreground">
 <span className="w-2 h-2 rounded-full inline-block" style={{ background: AGENT_COLORS[i] }} />{name}
 </div>)}
 </div>
 </CardContent>
 </Card>
 </TabsContent>
 </Tabs>
 </div>
 </div>
 </div>;
}
