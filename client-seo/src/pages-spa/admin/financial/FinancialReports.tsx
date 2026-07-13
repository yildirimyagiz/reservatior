"use client";

import { useState } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { AreaChart, Area, BarChart, Bar, PieChart, Pie, Cell, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from"recharts";
import { TrendingUp, TrendingDown, DollarSign, Download, Calendar, ArrowUpRight, ArrowDownRight, Activity } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { Button } from"@/components/ui/button";
import { useQuery } from"@tanstack/react-query";
import { useTranslation } from"react-i18next";

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

const PIE_COLORS = ["#6366f1","#8b5cf6","#a78bfa","#c4b5fd","#ddd6fe"];

export default function FinancialReports() {
 const { t } = useTranslation();
 const { toast } = useToast();
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

 const handleExportCSV = async (reportType: string) => {
 try {
 const response = await apiClient.get(`/financial/export/${reportType}`, { period });
 const blob = new Blob([(response as any).data], { type: 'text/csv' });
 const url = window.URL.createObjectURL(blob);
 const a = document.createElement('a');
 a.href = url;
 a.download = `financial-${reportType}-${period}.csv`;
 document.body.appendChild(a);
 a.click();
 document.body.removeChild(a);
 window.URL.revokeObjectURL(url);
 toast({ title: t("admin_financial_export_successful"), description: `${reportType} report downloaded.` });
 } catch (error) {
 toast({ title: t("admin_financial_export_failed"), description: t("admin_financial_failed_to_export_financial"), variant:"destructive" });
 }
 };

 const formatCurrency = (amount: number) =>
 new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(amount);

 const formatPercent = (value: number) => `${(value * 100).toFixed(1)}%`;

 const formatChange = (change: number) => {
 const isPositive = change >= 0;
 return (
 <span className={`flex items-center ${isPositive ? 'text-emerald-400' : 'text-red-400'}`}>
 {isPositive ? <ArrowUpRight className="h-3 w-3 mr-1" /> : <ArrowDownRight className="h-3 w-3 mr-1" />}
 {Math.abs(change)}%
 </span>
 );
 };

 if (loading) {
 return (
 <div className="min-h-screen flex items-center justify-center space-y-6">
 <div className="text-muted-foreground">{t("common.loading","Loading...")}</div>
 </div>
 );
 }

 return (
 <div className="p-6 space-y-6 min-h-screen">
 <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center gap-4">
 <div className="p-3 bg-slate-600 rounded-xl shadow-lg shadow-slate-600/20">
 <DollarSign className="w-8 h-8 text-foreground" />
 </div>
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground">
 {t("financialReportsTitle","Financial Reports")}
 </h1>
 <p className="text-muted-foreground">
 {t("financialReportsSubtitle","Comprehensive financial analysis and reporting")}
 </p>
 </div>
 </div>
 <div className="flex items-center gap-4">
 <Select value={period} onValueChange={setPeriod}>
 <SelectTrigger className="w-36 bg-card border-border text-foreground">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-background border-border text-foreground">
 <SelectItem value="1m">{t("financialReportsPeriodsMonthly","1 Month")}</SelectItem>
 <SelectItem value="3m">{t("quarterly","3 Months")}</SelectItem>
 <SelectItem value="6m">{t("biannual","6 Months")}</SelectItem>
 <SelectItem value="12m">{t("annual","12 Months")}</SelectItem>
 </SelectContent>
 </Select>
 <Button variant="outline" onClick={() => handleExportCSV('overview')} className="bg-card border-border text-slate-300 hover:bg-white/10">
 <Download className="h-4 w-4 mr-2" /> {t("common.export","Export")}
 </Button>
 </div>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("inbound","Revenue")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{formatCurrency(metrics?.totalRevenue || 0)}</h3>
 </div>
 <div className="p-3 bg-emerald-500/20 rounded-lg"><DollarSign className="w-5 h-5 text-emerald-400" /></div>
 </div>
 <div className="mt-3 flex items-center gap-2">
 {formatChange(metrics?.revenueGrowth || 0)}
 <span className="text-xs text-slate-500">{t("admin_financial_vs_prev_period","vs prev period")}</span>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("outflow","Expenses")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{formatCurrency(metrics?.totalExpenses || 0)}</h3>
 </div>
 <div className="p-3 bg-red-500/20 rounded-lg"><TrendingDown className="w-5 h-5 text-red-400" /></div>
 </div>
 <div className="mt-3 flex items-center gap-2">
 {formatChange(metrics?.expenseGrowth || 0)}
 <span className="text-xs text-slate-500">{t("admin_financial_burn_optimization","burn rate")}</span>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("profit","Profit")}</p>
 <h3 className="text-2xl font-bold text-muted-foreground mt-1">{formatCurrency(metrics?.totalProfit || 0)}</h3>
 </div>
 <div className="p-3 bg-muted0/20 rounded-lg"><TrendingUp className="w-5 h-5 text-muted-foreground" /></div>
 </div>
 <div className="mt-3 flex items-center gap-2">
 {formatChange(metrics?.profitGrowth || 0)}
 <span className="text-xs text-slate-500">{t("admin_financial_efficiency_gain","efficiency gain")}</span>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("financialReportsSync","Collection Rate")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{formatPercent(metrics?.collectionRate || 0)}</h3>
 </div>
 <div className="p-3 bg-orange-500/20 rounded-lg"><Activity className="w-5 h-5 text-orange-400" /></div>
 </div>
 </CardContent>
 </Card>
 </div>

 <Tabs defaultValue="overview" className="space-y-6">
 <TabsList className="bg-card border border-border">
 <TabsTrigger value="overview" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">
 {t("admin_financial_performance_core","Overview")}
 </TabsTrigger>
 <TabsTrigger value="revenue" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">
 {t("admin_financial_yield_dynamics","Revenue")}
 </TabsTrigger>
 <TabsTrigger value="expenses" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">
 {t("admin_financial_drain_analysis","Expenses")}
 </TabsTrigger>
 <TabsTrigger value="payments" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">
 {t("admin_financial_gateway_logic","Payments")}
 </TabsTrigger>
 </TabsList>

 <TabsContent value="overview" className="space-y-6">
 <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <div className="flex items-center justify-between">
 <CardTitle className="text-sm text-foreground flex items-center gap-2">
 <Activity className="w-4 h-4 text-muted-foreground" /> {t("flow","Cash Flow")}
 </CardTitle>
 </div>
 </CardHeader>
 <CardContent>
 <ResponsiveContainer width="100%" height={300}>
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
 <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="rgba(255,255,255,0.05)" />
 <XAxis dataKey="month" axisLine={false} tickLine={false} tick={{ fill: '#64748b', fontSize: 10 }} />
 <YAxis hide />
 <Tooltip contentStyle={{ backgroundColor: '#1e293b', border: '1px solid rgba(255,255,255,0.1)', borderRadius: '12px', color: '#fff', fontSize: '12px' }} />
 <Area type="monotone" dataKey="revenue" stroke="#3b82f6" strokeWidth={2} fillOpacity={1} fill="url(#colorRev)" />
 <Area type="monotone" dataKey="expenses" stroke="#ef4444" strokeWidth={2} fillOpacity={1} fill="url(#colorExp)" />
 </AreaChart>
 </ResponsiveContainer>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-sm text-foreground flex items-center gap-2">
 <TrendingUp className="w-4 h-4 text-emerald-400" /> {t("integrity","Collections")}
 </CardTitle>
 </CardHeader>
 <CardContent>
 <ResponsiveContainer width="100%" height={300}>
 <BarChart data={monthlyData}>
 <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="rgba(255,255,255,0.05)" />
 <XAxis dataKey="month" axisLine={false} tickLine={false} tick={{ fill: '#64748b', fontSize: 10 }} />
 <YAxis hide />
 <Tooltip contentStyle={{ backgroundColor: '#1e293b', border: '1px solid rgba(255,255,255,0.1)', borderRadius: '12px', color: '#fff' }} />
 <Bar dataKey="revenue" fill="#3b82f6" radius={[4, 4, 0, 0]} barSize={20} />
 <Bar dataKey="collections" fill="#10b981" radius={[4, 4, 0, 0]} barSize={20} />
 </BarChart>
 </ResponsiveContainer>
 </CardContent>
 </Card>
 </div>
 </TabsContent>

 <TabsContent value="revenue" className="space-y-6">
 <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
 <div className="space-y-4">
 <p className="text-sm text-muted-foreground">{t("financialReportsChartsDistribution","Revenue Distribution")}</p>
 {revenueSources.map((source: RevenueSource, index: number) => (
 <div key={String(source.name)} className="bg-card border border-border p-4 rounded-xl flex items-center justify-between">
 <div className="flex items-center gap-3">
 <div className="w-1.5 h-8 rounded-full" style={{ backgroundColor: PIE_COLORS[index % PIE_COLORS.length] }} />
 <div>
 <p className="font-medium text-foreground">{String(source.name)}</p>
 <p className="text-xs text-muted-foreground">{Number(source.pct)}% share</p>
 </div>
 </div>
 <div className="text-right">
 <p className="font-bold text-emerald-400">{formatCurrency(Number(source.value))}</p>
 <div className="mt-1">{formatChange(Number(source.change))}</div>
 </div>
 </div>
 ))}
 </div>
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-sm text-foreground">{t("polarization","Distribution")}</CardTitle>
 </CardHeader>
 <CardContent>
 <ResponsiveContainer width="100%" height={300}>
 <PieChart>
 <Pie data={revenueSources} cx="50%" cy="50%" innerRadius={80} outerRadius={120} paddingAngle={5} dataKey="value" stroke="none">
 {revenueSources.map((_: any, index: number) => <Cell key={`cell-${index}`} fill={PIE_COLORS[index % PIE_COLORS.length]} />)}
 </Pie>
 <Tooltip contentStyle={{ backgroundColor: '#1e293b', border: '1px solid rgba(255,255,255,0.1)', borderRadius: '12px' }} />
 </PieChart>
 </ResponsiveContainer>
 </CardContent>
 </Card>
 </div>
 </TabsContent>
 </Tabs>
 </div>
 );
}
