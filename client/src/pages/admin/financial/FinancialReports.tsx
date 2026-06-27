import { t } from "i18next";
import { useState, useEffect, JSXElementConstructor, Key, ReactElement, ReactNode, ReactPortal } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { AreaChart, Area, BarChart, Bar, LineChart, Line, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from "recharts";
import { TrendingUp, TrendingDown, DollarSign, Download, Calendar, ArrowUpRight, ArrowDownRight, Activity } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
import { Button } from "@/components/ui/button";
import { useQuery } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
interface FinancialMetrics {
  totalRevenue: number;
  totalExpenses: number;
  totalProfit: number;
  totalCollections: number;
  revenueGrowth: number;
  expenseGrowth: number;
  profitGrowth: number;
  collectionRate: number;
  avgMonthlyRevenue: number;
  avgMonthlyExpenses: number;
}
interface MonthlyData {
  month: string;
  revenue: number;
  expenses: number;
  profit: number;
  collections: number;
}
interface RevenueSource {
  name: string;
  value: number;
  pct: number;
  change: number;
  [key: string]: string | number | boolean | undefined;
}
interface ExpenseCategory {
  name: string;
  value: number;
  pct: number;
  change: number;
}
interface PaymentMethod {
  method: string;
  count: number;
  amount: number;
  percentage: number;
  [key: string]: string | number | boolean | undefined;
}
export default function FinancialReports() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [period, setPeriod] = useState("3m");

  const { data, isLoading: loading } = useQuery({
    queryKey: ['financialReports', period],
    queryFn: async () => {
      const [metricsRes, monthlyRes, revenueRes, expenseRes, paymentRes] = await Promise.all([
        apiClient.get('/financial/metrics', { period }),
        apiClient.get('/financial/monthly-data', { period }),
        apiClient.get('/financial/revenue-sources', { period }),
        apiClient.get('/financial/expense-categories', { period }),
        apiClient.get('/financial/payment-methods', { period })
      ]);
      return {
        metrics: (metricsRes as any).data,
        monthlyData: (monthlyRes as any).data || [],
        revenueSources: (revenueRes as any).data || [],
        expenseCategories: (expenseRes as any).data || [],
        paymentMethods: (paymentRes as any).data || []
      };
    }
  });

  const metrics = data?.metrics || null;
  const monthlyData = data?.monthlyData || [];
  const revenueSources = data?.revenueSources || [];
  const expenseCategories = data?.expenseCategories || [];
  const paymentMethods = data?.paymentMethods || [];
  const handleExportCSV = async (reportType: string) => {
    try {
      const response = await apiClient.get(`/financial/export/${reportType}`, {
        period
      });

      // Create download link
      const blob = new Blob([(response as any).data], {
        type: 'text/csv'
      });
      const url = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = `financial-${reportType}-${period}.csv`;
      document.body.appendChild(a);
      a.click();
      document.body.removeChild(a);
      window.URL.revokeObjectURL(url);
      toast({
        title: t("admin.financial.export_successful"),
        description: `${reportType} report has been downloaded.`
      });
    } catch (error) {
      console.error('Error exporting data:', error);
      toast({
        title: t("admin.financial.export_failed"),
        description: t("admin.financial.failed_to_export_financial"),
        variant: "destructive"
      });
    }
  };
  const formatCurrency = (amount: number) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD'
    }).format(amount);
  };
  const formatPercent = (value: number) => {
    return `${(value * 100).toFixed(1)}%`;
  };
  const formatChange = (change: number) => {
    const isPositive = change >= 0;
    return <span className={`flex items-center ${isPositive ? 'text-green-600' : 'text-red-600'}`}>
        {isPositive ? <ArrowUpRight className="h-3 w-3 mr-1" /> : <ArrowDownRight className="h-3 w-3 mr-1" />}
        {Math.abs(change)}%
      </span>;
  };
  const PIE_COLORS = ["#6366f1", "#8b5cf6", "#a78bfa", "#c4b5fd", "#ddd6fe"];
  const EXP_COLORS = ["#ef4444", "#f97316", "#f59e0b", "#eab308", "#84cc16"];
  if (loading) {
    return <PageShell title={t("financialReportsTitle")} description={t("financialReportsDesc")}>
        <div className="flex items-center justify-center h-64">
          <div className="text-sm text-muted-foreground">{t("commonLoading")}...</div>
        </div>
      </PageShell>;
  }
  return <PageShell title={t("financialReportsTitle")} description={t("financialReportsDesc")}>
      <div className="space-y-10 pb-20">
        {/* Header Tactical Section */}
        <div className="flex flex-col lg:flex-row justify-between items-start lg:items-center gap-6 px-4">
          <div className="space-y-1">
            <h2 className="text-3xl font-bold text-foreground flex items-center gap-3">
              <DollarSign className="w-8 h-8 text-emerald-500" /> {t("financialReportsTitle")}
            </h2>
            <p className="text-[10px] font-bold text-muted-foreground">{t("financialReportsSubtitle")}</p>
          </div>
          <div className="flex items-center gap-4">
            <Select value={period} onValueChange={setPeriod}>
              <SelectTrigger className="w-44 bg-card border-border rounded-2xl h-14 text-foreground font-bold text-[10px]">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-[#14151a] border-border rounded-2xl text-muted-foreground">
                <SelectItem value="1m">{t("financialReportsPeriodsMonthly")}</SelectItem>
                <SelectItem value="3m">{t("quarterly")}</SelectItem>
                <SelectItem value="6m">{t("biannual")}</SelectItem>
                <SelectItem value="12m">{t("annual")}</SelectItem>
              </SelectContent>
            </Select>
            <Button variant="outline" onClick={() => handleExportCSV('overview')} className="h-14 px-8 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground hover:bg-muted/50 gap-2 font-bold text-[10px]">
              <Download className="h-4 w-4" /> {t("commonExport")}
            </Button>
          </div>
        </div>

        {/* KPI Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
              <DollarSign className="w-12 h-12" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("inbound")}</p>
              <h3 className="text-3xl font-bold text-foreground leading-none">{formatCurrency(metrics?.totalRevenue || 0)}</h3>
              <div className="mt-4 flex items-center gap-2">
                <div className="flex items-center text-[10px] font-bold text-emerald-400 border border-emerald-500/20 px-2 py-0.5 rounded-full bg-emerald-500/5">
                   <ArrowUpRight className="w-3 h-3 mr-0.5" /> {metrics?.revenueGrowth}%
                </div>
                <p className="text-[9px] font-bold text-slate-600">{t("admin.financial.vs_prev_period")}</p>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-red-500">
              <TrendingDown className="w-12 h-12" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("outflow")}</p>
              <h3 className="text-3xl font-bold text-foreground leading-none">{formatCurrency(metrics?.totalExpenses || 0)}</h3>
              <div className="mt-4 flex items-center gap-2">
                <div className="flex items-center text-[10px] font-bold text-red-400 border border-red-500/20 px-2 py-0.5 rounded-full bg-red-500/5">
                   <ArrowUpRight className="w-3 h-3 mr-0.5" /> {metrics?.expenseGrowth}%
                </div>
                <p className="text-[9px] font-bold text-slate-600">{t("admin.financial.burn_optimization")}</p>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
            <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-blue-500">
              <TrendingUp className="w-12 h-12" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("profit")}</p>
              <h3 className="text-3xl font-bold text-blue-400 leading-none">{formatCurrency(metrics?.totalProfit || 0)}</h3>
              <div className="mt-4 flex items-center gap-2">
                <div className="flex items-center text-[10px] font-bold text-blue-400 border border-blue-500/20 px-2 py-0.5 rounded-full bg-blue-500/5">
                   <ArrowUpRight className="w-3 h-3 mr-0.5" /> {metrics?.profitGrowth}%
                </div>
                <p className="text-[9px] font-bold text-slate-600">{t("admin.financial.efficiency_gain")}</p>
              </div>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
                <TrendingUp className="w-12 h-12" />
              </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("financialReportsSync")}</p>
              <h3 className="text-3xl font-bold text-foreground leading-none">{formatPercent(metrics?.collectionRate || 0)}</h3>
              <p className="text-[9px] font-bold text-slate-600 mt-4 leading-tight">{t("admin.financial.actual_vs_projected_collections")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Charts & Analytical Hub */}
        <Tabs defaultValue="overview" className="space-y-10">
          <TabsList className="bg-card border border-border p-1.5 rounded-2xl h-16 w-full max-w-2xl mx-auto flex">
            <TabsTrigger value="overview" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all">{t("admin.financial.performance_core")}</TabsTrigger>
            <TabsTrigger value="revenue" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all">{t("admin.financial.yield_dynamics")}</TabsTrigger>
            <TabsTrigger value="expenses" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all">{t("admin.financial.drain_analysis")}</TabsTrigger>
            <TabsTrigger value="payments" className="flex-1 rounded-xl font-bold text-[10px] data-[state=active]:bg-muted/50 data-[state=active]:text-foreground text-muted-foreground transition-all">{t("admin.financial.gateway_logic")}</TabsTrigger>
          </TabsList>

          <TabsContent value="overview" className="space-y-10 focus-visible:ring-0">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-10">
              <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative h-[450px]">
                <CardHeader className="pt-8 px-8 border-b border-border">
                   <div className="flex items-center justify-between">
                      <div className="space-y-1">
                        <CardTitle className="text-xs font-bold text-foreground flex items-center gap-2">
                           <Activity className="w-4 h-4 text-blue-500" /> {t("flow")}
                        </CardTitle>
                        <p className="text-[9px] font-bold text-muted-foreground">{t("admin.financial.revenue_vs_outflow_projections")}</p>
                      </div>
                   </div>
                </CardHeader>
                <CardContent className="p-8 h-full">
                  <ResponsiveContainer width="100%" height={300} minWidth={0}>
                    <AreaChart data={monthlyData}>
                      <defs>
                        <linearGradient id="colorRev" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.3} />
                          <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                        </linearGradient>
                        <linearGradient id="colorExp" x1="0" y1="0" x2="0" y2="1">
                          <stop offset="5%" stopColor="#ef4444" stopOpacity={0.3} />
                          <stop offset="95%" stopColor="#ef4444" stopOpacity={0} />
                        </linearGradient>
                      </defs>
                      <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="rgba(255,255,255,0.02)" />
                      <XAxis dataKey="month" axisLine={false} tickLine={false} tick={{
                      fill: '#475569',
                      fontSize: 10,
                      fontWeight: 900
                    }} />
                      <YAxis hide />
                      <Tooltip contentStyle={{
                      backgroundColor: '#14151a',
                      border: '1px solid rgba(255,255,255,0.05)',
                      borderRadius: '12px',
                      color: '#fff'
                    }} itemStyle={{
                      fontSize: '10px',
                      fontWeight: '900',
                      textTransform: ''
                    }} />
                      <Area type="monotone" dataKey="revenue" stroke="#3b82f6" strokeWidth={3} fillOpacity={1} fill="url(#colorRev)" />
                      <Area type="monotone" dataKey="expenses" stroke="#ef4444" strokeWidth={3} fillOpacity={1} fill="url(#colorExp)" />
                    </AreaChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>

              <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative h-[450px]">
                <CardHeader className="pt-8 px-8 border-b border-border">
                   <div className="flex items-center justify-between">
                      <div className="space-y-1">
                        <CardTitle className="text-xs font-bold text-foreground flex items-center gap-2">
                           <TrendingUp className="w-4 h-4 text-emerald-500" /> {t("integrity")}
                        </CardTitle>
                        <p className="text-[9px] font-bold text-muted-foreground">{t("admin.financial.collection_success_quadrant")}</p>
                      </div>
                   </div>
                </CardHeader>
                <CardContent className="p-8 h-full">
                  <ResponsiveContainer width="100%" height={300} minWidth={0}>
                    <BarChart data={monthlyData}>
                      <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="rgba(255,255,255,0.02)" />
                      <XAxis dataKey="month" axisLine={false} tickLine={false} tick={{
                      fill: '#475569',
                      fontSize: 10,
                      fontWeight: 900
                    }} />
                      <YAxis hide />
                      <Tooltip contentStyle={{
                      backgroundColor: '#14151a',
                      border: '1px solid rgba(255,255,255,0.05)',
                      borderRadius: '12px'
                    }} />
                      <Bar dataKey="revenue" fill="#3b82f6" radius={[4, 4, 0, 0]} barSize={20} />
                      <Bar dataKey="collections" fill="#10b981" radius={[4, 4, 0, 0]} barSize={20} />
                    </BarChart>
                  </ResponsiveContainer>
                </CardContent>
              </Card>
            </div>
          </TabsContent>

          {/* Revenue Breakdown Section */}
          <TabsContent value="revenue" className="space-y-10 focus-visible:ring-0">
             <div className="grid grid-cols-1 lg:grid-cols-2 gap-10 px-4">
                <div className="space-y-6">
                   <p className="text-[10px] font-bold text-muted-foreground">{t("financialReportsChartsDistribution")}</p>
                   <div className="grid gap-4">
                      {revenueSources.map((source: RevenueSource, index: number) => <div key={String(source.name)} className="bg-card border border-border p-6 rounded-3xl flex items-center justify-between group hover:bg-muted/50 transition-all">
                           <div className="flex items-center gap-4">
                              <div className="w-1.5 h-8 rounded-full" style={{
                      backgroundColor: PIE_COLORS[index % PIE_COLORS.length]
                    }} />
                              <div>
                                 <p className="text-lg font-bold text-foreground leading-tight">{String(source.name)}</p>
                                 <p className="text-[10px] font-bold text-muted-foreground">{Number(source.pct)}% {t("admin.financial.efficiency_contribution")}</p>
                              </div>
                           </div>
                           <div className="text-right">
                              <p className="text-xl font-bold text-emerald-400 leading-none">{formatCurrency(Number(source.value))}</p>
                              <div className="mt-1 flex items-center justify-end">
                                 {formatChange(Number(source.change))}
                              </div>
                           </div>
                        </div>)}
                   </div>
                </div>
                <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative h-[500px]">
                   <CardHeader className="pt-8 px-8">
                       <CardTitle className="text-xs font-bold text-foreground">{t("polarization")}</CardTitle>
                   </CardHeader>
                   <CardContent className="p-8 h-full">
                      <ResponsiveContainer width="100%" height={300} minWidth={0}>
                        <PieChart>
                          <Pie data={revenueSources} cx="50%" cy="50%" innerRadius={80} outerRadius={120} paddingAngle={5} dataKey="value" stroke="none">
                            {revenueSources.map((_: any, index: number) => <Cell key={`cell-${index}`} fill={PIE_COLORS[index % PIE_COLORS.length]} />)}
                          </Pie>
                          <Tooltip contentStyle={{
                      backgroundColor: '#14151a',
                      border: '1px solid rgba(255,255,255,0.05)',
                      borderRadius: '12px'
                    }} />
                        </PieChart>
                      </ResponsiveContainer>
                   </CardContent>
                </Card>
             </div>
          </TabsContent>
        </Tabs>
      </div>
    </PageShell>;
}