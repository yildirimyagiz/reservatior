import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { BarChart, Bar, LineChart, Line, RadarChart, Radar, PolarGrid, PolarAngleAxis, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell } from "recharts";
import { Eye, RefreshCw } from "lucide-react";
import { PageShell } from "../../client/layout/PageShell";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";

// ─── Types ─────────────────────────────────────────────────────────────────────
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
  user?: {
    id: string;
    name: string;
    email: string;
    agency?: {
      name: string;
    };
  };
  // Computed locally
  rating?: number;
  status?: string;
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
const AGENT_COLORS = ["#6366f1", "#8b5cf6", "#ec4899", "#f59e0b", "#10b981", "#ef4444"];
const $ = (v: number) => new Intl.NumberFormat("en-US", {
  style: "currency",
  currency: "USD",
  maximumFractionDigits: 0
}).format(v);
const CustomTooltip = ({
  active,
  payload,
  label
}: any) => {
  if (!active || !payload?.length) return null;
  return <div className="bg-card border border-border rounded-lg p-3 text-xs shadow-md space-y-1">
      <p className="font-medium">{label}</p>
      {payload.map((p: any) => <p key={p.name} style={{
      color: p.color
    }}>
          {p.name}: {p.value > 1000 ? $(p.value) : `${p.value}%`}
        </p>)}
    </div>;
};

// ─── Helpers ───────────────────────────────────────────────────────────────────
function buildMonthlyTrend(records: AgentPerformanceRecord[], topNames: string[]): MonthlyTrendPoint[] {
  const months: Record<string, MonthlyTrendPoint> = {};
  records.forEach(r => {
    const label = new Date(r.startDate).toLocaleString("en-US", {
      month: "short"
    });
    if (!months[label]) months[label] = {
      month: label
    };
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
    return {
      name,
      leadsToShowings: leads > 0 ? Math.round(showings / leads * 100) : 0,
      showingsToOffers: showings > 0 ? Math.round(offers / showings * 100) : 0,
      offersToDeals: offers > 0 ? Math.round(deals / offers * 100) : 0
    };
  });
}
function buildRadar(records: AgentPerformanceRecord[], topNames: string[]): RadarPoint[] {
  const {
    t
  } = useTranslation();
  const totals: Record<string, {
    leads: number;
    showings: number;
    offers: number;
    deals: number;
    commission: number;
  }> = {};
  records.forEach(r => {
    const name = r.user?.name ?? r.userId;
    if (!totals[name]) totals[name] = {
      leads: 0,
      showings: 0,
      offers: 0,
      deals: 0,
      commission: 0
    };
    totals[name].leads += r.leadsGenerated;
    totals[name].showings += r.showingsCompleted;
    totals[name].offers += r.offersSubmitted;
    totals[name].deals += r.dealsClosed;
    totals[name].commission += Number(r.commissionEarned);
  });
  const top = topNames.slice(0, 3);
  const baseline = totals[top[0]];
  if (!baseline) return [];
  return [
    t("admin.reports.metrics.leads", "Adaylar"), 
    t("admin.reports.metrics.showings", "Gösterimler"), 
    t("admin.reports.metrics.offers", "Teklifler"), 
    t("admin.reports.metrics.deals", "Anlaşmalar"), 
    t("admin.reports.metrics.revenue", "Gelir")
  ].map(metric => {
    const point: RadarPoint = {
      metric
    };
    top.forEach(name => {
      const t_stats = totals[name];
      if (!t_stats) return;
      const rawMap: Record<string, number> = {
        [t("admin.reports.metrics.leads", "Adaylar")]: t_stats.leads,
        [t("admin.reports.metrics.showings", "Gösterimler")]: t_stats.showings,
        [t("admin.reports.metrics.offers", "Teklifler")]: t_stats.offers,
        [t("admin.reports.metrics.deals", "Anlaşmalar")]: t_stats.deals,
        [t("admin.reports.metrics.revenue", "Gelir")]: t_stats.commission
      };
      const baseMap: Record<string, number> = {
        [t("admin.reports.metrics.leads", "Adaylar")]: baseline.leads,
        [t("admin.reports.metrics.showings", "Gösterimler")]: baseline.showings,
        [t("admin.reports.metrics.offers", "Teklifler")]: baseline.offers,
        [t("admin.reports.metrics.deals", "Anlaşmalar")]: baseline.deals,
        [t("admin.reports.metrics.revenue", "Gelir")]: baseline.commission
      };
      point[name] = baseMap[metric] > 0 ? Math.round(rawMap[metric] / baseMap[metric] * 100) : 0;
    });
    return point;
  });
}

// ─── Component ─────────────────────────────────────────────────────────────────
export default function AgentPerformance() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [selectedAgent, setSelectedAgent] = useState<string | null>(null);
  const [tab, setTab] = useState("leaderboard");
  const [search, setSearch] = useState("");
  const [period, setPeriod] = useState("current");
  const [records, setRecords] = useState<AgentPerformanceRecord[]>([]);
  const [loading, setLoading] = useState(true);
  useEffect(() => {
    fetchPerformance();
  }, [period]);
  const fetchPerformance = async () => {
    try {
      setLoading(true);
      const res = (await apiClient.get("/agent-performance", {
        period,
        include: "user,agency",
        limit: "100"
      })) as {
        data: AgentPerformanceRecord[];
      };
      setRecords(res.data || []);
    } catch (error) {
      console.error("Error fetching agent performance:", error);
      toast({
        title: t("admin.reports.error"),
        description: t("admin.reports.failed_to_load_agent"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };

  // Aggregate to one row per agent (sum across periods in view)
  const agentMap = new Map<string, {
    id: string;
    name: string;
    agency: string;
    leads: number;
    showings: number;
    offers: number;
    deals: number;
    commission: number;
    status: string;
  }>();
  records.forEach(r => {
    const name = r.user?.name ?? r.userId;
    const agency = r.user?.agency?.name ?? "—";
    if (!agentMap.has(r.userId)) {
      agentMap.set(r.userId, {
        id: r.userId,
        name,
        agency,
        leads: 0,
        showings: 0,
        offers: 0,
        deals: 0,
        commission: 0,
        status: r.status ?? "ACTIVE"
      });
    }
    const entry = agentMap.get(r.userId)!;
    entry.leads += r.leadsGenerated;
    entry.showings += r.showingsCompleted;
    entry.offers += r.offersSubmitted;
    entry.deals += r.dealsClosed;
    entry.commission += Number(r.commissionEarned);
  });
  const AGENTS = [...agentMap.values()].sort((a, b) => b.commission - a.commission);
  const filtered = AGENTS.filter(a => {
    return `${a.name} ${a.agency}`.toLowerCase().includes(search.toLowerCase());
  });
  const topNames = AGENTS.slice(0, 4).map(a => a.name);
  const MONTHLY_TREND = buildMonthlyTrend(records, topNames);
  const CONVERSION = buildConversion(records);
  const RADAR_DATA = buildRadar(records, topNames.slice(0, 3));
  const totalDeals = AGENTS.reduce((s, a) => s + a.deals, 0);
  const totalCommission = AGENTS.reduce((s, a) => s + a.commission, 0);
  return <PageShell title={t("admin.reports.agent_performance")} description={t("admin.reports.leaderboards_conversion_funnels_and")} searchValue={search} onSearchChange={setSearch} searchPlaceholder={t("admin.reports.search_agents", "Temsilcilerde ara...")} stats={[{
    label: t("admin.reports.active_agents"),
    value: loading ? "—" : AGENTS.filter(a => a.status === "ACTIVE").length
  }, {
    label: t("admin.reports.total_deals"),
    value: loading ? "—" : totalDeals
  }, {
    label: t("admin.reports.total_commission"),
    value: loading ? "—" : $(totalCommission)
  }]} actions={<div className="flex items-center gap-2">
          <Select value={period} onValueChange={setPeriod}>
            <SelectTrigger className="w-36"><SelectValue /></SelectTrigger>
            <SelectContent>
              <SelectItem value="current">{t("admin.reports.current_period")}</SelectItem>
              <SelectItem value="last_quarter">{t("admin.reports.last_quarter")}</SelectItem>
              <SelectItem value="last_year">{t("admin.reports.last_year")}</SelectItem>
              <SelectItem value="all">{t("admin.reports.all_time")}</SelectItem>
            </SelectContent>
          </Select>
          <Button variant="outline" size="sm" onClick={fetchPerformance} disabled={loading}>
            <RefreshCw className={`w-4 h-4 ${loading ? "animate-spin" : ""}`} />
          </Button>
        </div>} filters={<div className="flex gap-2">
          <Select value="all" disabled>
            <SelectTrigger className="w-40"><SelectValue placeholder={t("admin.reports.agency")} /></SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("admin.reports.all_agencies")}</SelectItem>
            </SelectContent>
          </Select>
          <Select value="all" disabled>
            <SelectTrigger className="w-32"><SelectValue placeholder={t("admin.reports.status")} /></SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("admin.reports.all")}</SelectItem>
            </SelectContent>
          </Select>
        </div>}>
      <Tabs value={tab} onValueChange={setTab}>
        <TabsList className="mb-4">
          <TabsTrigger value="leaderboard">{t("admin.reports.leaderboard")}</TabsTrigger>
          <TabsTrigger value="trends">{t("admin.reports.commission_trends")}</TabsTrigger>
          <TabsTrigger value="conversion">{t("admin.reports.conversion_funnel")}</TabsTrigger>
          <TabsTrigger value="radar">{t("admin.reports.comparison_radar")}</TabsTrigger>
        </TabsList>

        {/* LEADERBOARD */}
        <TabsContent value="leaderboard" className="space-y-4">
          {/* Bar chart */}
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.reports.commission_earned")}</CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={220} minWidth={0}>
                <BarChart data={filtered} layout="vertical" margin={{
                top: 0,
                right: 16,
                left: 80,
                bottom: 0
              }}>
                  <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" strokeOpacity={0.4} horizontal={false} />
                  <XAxis type="number" tickFormatter={v => `$${(v / 1000).toFixed(0)}k`} tick={{
                  fontSize: 11
                }} tickLine={false} axisLine={false} />
                  <YAxis type="category" dataKey="name" tick={{
                  fontSize: 11
                }} tickLine={false} axisLine={false} width={80} />
                  <Tooltip content={<CustomTooltip />} />
                  <Bar dataKey="commission" name={t("admin.reports.commission", "Komisyon")} radius={[0, 4, 4, 0]} maxBarSize={28}>
                    {filtered.map((_, i) => <Cell key={i} fill={AGENT_COLORS[i % AGENT_COLORS.length]} />)}
                  </Bar>
                </BarChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>

          {/* Agent cards */}
          <div className="grid gap-3">
            {filtered.map((agent, idx) => <div key={agent.id} className="bg-card border border-border rounded-xl p-4 flex items-center gap-4 hover:bg-muted/30 cursor-pointer transition-colors" onClick={() => setSelectedAgent(selectedAgent === agent.id ? null : agent.id)}>
                {/* Rank */}
                <div className="w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold shrink-0" style={{
              background: idx < 3 ? AGENT_COLORS[idx] + "20" : "var(--color-background-secondary)",
              color: idx < 3 ? AGENT_COLORS[idx] : "var(--color-text-tertiary)"
            }}>
                  {idx + 1}
                </div>

                {/* Avatar + name */}
                <Avatar className="h-9 w-9 shrink-0">
                  <AvatarFallback className="text-xs bg-primary/10 text-primary font-medium">
                    {agent.name.split(" ").map(n => n[0]).join("")}
                  </AvatarFallback>
                </Avatar>
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2 flex-wrap">
                    <p className="text-sm font-semibold">{agent.name}</p>
                    {idx === 0 && <Badge className="bg-amber-100 text-amber-700 border-0 text-[10px]">{t("admin.reports.top_agent")}</Badge>}
                    <Badge className={`border-0 text-[10px] ${agent.status === "ACTIVE" ? "bg-green-100 text-green-700" : "bg-slate-100 text-muted-foreground"}`}>
                      {agent.status === "ACTIVE" ? t("admin.reports.status_active", "Aktif") : agent.status}
                    </Badge>
                  </div>
                  <p className="text-xs text-muted-foreground">{agent.agency} · {period}</p>
                </div>

                {/* Stats */}
                <div className="hidden sm:grid grid-cols-4 gap-6 text-right shrink-0">
                  {[{
                label: t("admin.reports.leads"),
                value: agent.leads
              }, {
                label: t("admin.reports.deals"),
                value: agent.deals
              }, {
                label: t("admin.reports.rating"),
                value: "—"
              }, {
                label: t("admin.reports.commission"),
                value: $(agent.commission)
              }].map(s => <div key={s.label}>
                      <p className="text-xs text-muted-foreground">{s.label}</p>
                      <p className="text-sm font-semibold mt-0.5">{s.value}</p>
                    </div>)}
                </div>

                <Button variant="ghost" size="icon" className="h-8 w-8 shrink-0">
                  <Eye className="w-4 h-4" />
                </Button>
              </div>)}
          </div>
        </TabsContent>

        {/* TRENDS */}
        <TabsContent value="trends">
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.reports.monthly_commission_top_4")}</CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={300} minWidth={0}>
                <LineChart data={MONTHLY_TREND} margin={{
                top: 5,
                right: 16,
                left: 0,
                bottom: 0
              }}>
                  <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" strokeOpacity={0.4} />
                  <XAxis dataKey="month" tick={{
                  fontSize: 11
                }} tickLine={false} axisLine={false} />
                  <YAxis tickFormatter={v => `$${(v / 1000).toFixed(0)}k`} tick={{
                  fontSize: 11
                }} tickLine={false} axisLine={false} width={50} />
                  <Tooltip content={<CustomTooltip />} />
                  {topNames.map((name, i) => <Line key={name} type="monotone" dataKey={name} name={name} stroke={AGENT_COLORS[i]} strokeWidth={2} dot={false} />)}
                </LineChart>
              </ResponsiveContainer>
              <div className="flex flex-wrap gap-4 mt-3">
                {topNames.map((name, i) => <div key={name} className="flex items-center gap-1.5 text-xs text-muted-foreground">
                    <span className="w-3 h-0.5 inline-block rounded" style={{
                  background: AGENT_COLORS[i]
                }} />
                    {name}
                  </div>)}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* CONVERSION FUNNEL */}
        <TabsContent value="conversion">
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.reports.conversion_rates_leads_showings")}</CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={280} minWidth={0}>
                <BarChart data={CONVERSION} margin={{
                top: 5,
                right: 16,
                left: 80,
                bottom: 0
              }} layout="vertical">
                  <CartesianGrid strokeDasharray="3 3" stroke="hsl(var(--border))" strokeOpacity={0.4} horizontal={false} />
                  <XAxis type="number" domain={[0, 100]} tickFormatter={v => `${v}%`} tick={{
                  fontSize: 11
                }} tickLine={false} axisLine={false} />
                  <YAxis type="category" dataKey="name" tick={{
                  fontSize: 11
                }} tickLine={false} axisLine={false} width={80} />
                  <Tooltip formatter={(v: any) => `${v}%`} />
                  <Bar dataKey="leadsToShowings" name={t("admin.reports.leads_to_showings", "Adaylar→Gösterimler")} fill="#6366f1" radius={[0, 2, 2, 0]} maxBarSize={14} />
                  <Bar dataKey="showingsToOffers" name={t("admin.reports.showings_to_offers", "Gösterimler→Teklifler")} fill="#8b5cf6" radius={[0, 2, 2, 0]} maxBarSize={14} />
                  <Bar dataKey="offersToDeals" name={t("admin.reports.offers_to_deals", "Teklifler→Anlaşmalar")} fill="#10b981" radius={[0, 2, 2, 0]} maxBarSize={14} />
                </BarChart>
              </ResponsiveContainer>
              <div className="flex flex-wrap gap-4 mt-2">
                {[
                  ["#6366f1", t("admin.reports.leads_to_showings", "Adaylar→Gösterimler")], 
                  ["#8b5cf6", t("admin.reports.showings_to_offers", "Gösterimler→Teklifler")], 
                  ["#10b981", t("admin.reports.offers_to_deals", "Teklifler→Anlaşmalar")]
                ].map(([c, l]) => <div key={l} className="flex items-center gap-1.5 text-xs text-muted-foreground">
                    <span className="w-2 h-2 rounded-sm inline-block" style={{
                  background: c
                }} />{l}
                  </div>)}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* RADAR */}
        <TabsContent value="radar">
          <Card>
            <CardHeader className="pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.reports.performance_comparison_top_3")}{topNames[0] ?? "top agent"} = 100)
              </CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={320} minWidth={0}>
                <RadarChart data={RADAR_DATA}>
                  <PolarGrid />
                  <PolarAngleAxis dataKey="metric" tick={{
                  fontSize: 12
                }} />
                  {topNames.slice(0, 3).map((name, i) => <Radar key={name} name={name} dataKey={name} stroke={AGENT_COLORS[i]} fill={AGENT_COLORS[i]} fillOpacity={0.15} />)}
                  <Tooltip />
                </RadarChart>
              </ResponsiveContainer>
              <div className="flex flex-wrap gap-4 mt-1 justify-center">
                {topNames.slice(0, 3).map((name, i) => <div key={name} className="flex items-center gap-1.5 text-xs text-muted-foreground">
                    <span className="w-2 h-2 rounded-full inline-block" style={{
                  background: AGENT_COLORS[i]
                }} />{name}
                  </div>)}
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </PageShell>;
}