"use client";

import { useTranslation } from"react-i18next";
import { useQuery } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { TrendingUp, TrendingDown, DollarSign, FileText, Download, Calendar, Loader2 } from"lucide-react";

interface Report {
 id: string;
 title: string;
 dueDate: string;
 status: string;
 createdAt: string;
}

interface DashboardSummary {
 totalRevenue: number;
 totalExpenses: number;
 totalProfit: number;
 revenueData: { month: string; revenue: number; expenses: number; profit: number }[];
 topAgents: any[];
}

export default function FinancialReports() {
 const { t } = useTranslation();

 const { data: dashData, isLoading: dashLoading } = useQuery({
 queryKey: ['dashboard-summary'],
 queryFn: async () => {
 const res: any = await apiClient.get('/dashboard-analytics/summary');
 return res?.data as DashboardSummary;
 },
 });

 const { data: reportsData, isLoading: reportsLoading } = useQuery({
 queryKey: ['reports-list'],
 queryFn: async () => {
 const res: any = await apiClient.get('/reports?limit=50');
 return (res?.data || []) as Report[];
 },
 });

 const d = dashData;
 const reports: Report[] = reportsData || [];

 const revenueBreakdown = [
 { source:"Rental Income", amount: d ? d.totalRevenue * 0.514 : 234567, percentage: 51.4, growth:"+12.3%" },
 { source:"Property Management Fees", amount: d ? d.totalRevenue * 0.195 : 89234, percentage: 19.5, growth:"+8.7%" },
 { source:"Maintenance Services", amount: d ? d.totalRevenue * 0.149 : 67890, percentage: 14.9, growth:"+15.2%" },
 { source:"Other Services", amount: d ? d.totalRevenue * 0.099 : 45098, percentage: 9.9, growth:"+6.8%" },
 { source:"Late Fees", amount: d ? d.totalRevenue * 0.044 : 20000, percentage: 4.4, growth:"+23.1%" },
 ];

 const expenses = [
 { category:"Property Maintenance", amount: d ? d.totalExpenses * 0.352 : 45678, percentage: 35.2, change:"-5.2%" },
 { category:"Staff Salaries", amount: d ? d.totalExpenses * 0.267 : 34567, percentage: 26.7, change:"+2.1%" },
 { category:"Insurance", amount: d ? d.totalExpenses * 0.095 : 12345, percentage: 9.5, change:"0%" },
 { category:"Property Taxes", amount: d ? d.totalExpenses * 0.181 : 23456, percentage: 18.1, change:"+8.3%" },
 { category:"Utilities", amount: d ? d.totalExpenses * 0.105 : 13688, percentage: 10.5, change:"-3.7%" },
 ];

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
 <div className="flex items-center justify-between bg-card p-6 rounded-2xl border border-border">
 <div>
 <h1 className="text-3xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_financial_financial_reports")}</h1>
 <p className="text-muted-foreground">{t("admin_financial_comprehensive_financial_analysis_and")}</p>
 </div>
 <Button className="bg-card border-border text-foreground hover:bg-muted dark:hover:bg-card/10">
 <Download className="w-4 h-4 mr-2" />{t("admin_financial_export_reports")}
 </Button>
 </div>

 {dashLoading ? (
 <div className="flex justify-center py-16"><Loader2 className="w-8 h-8 animate-spin text-muted-foreground" /></div>
 ) : (
 <>
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_financial_total_revenue")}</CardTitle>
 <TrendingUp className="h-4 w-4 text-success" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{t("currency_symbol", "$")}{(d?.totalRevenue || 0).toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{t("admin_financial_152_from_last_quarter")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_financial_net_profit")}</CardTitle>
 <DollarSign className="h-4 w-4 text-success" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{t("currency_symbol", "$")}{(d?.totalProfit || 0).toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{t("admin_financial_87_from_last_quarter")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_financial_operating_costs")}</CardTitle>
 <TrendingDown className="h-4 w-4 text-red-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{t("currency_symbol", "$")}{(d?.totalExpenses || 0).toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{t("admin_financial_53_from_last_quarter")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_financial_roi")}</CardTitle>
 <FileText className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">18.5%</div>
 <p className="text-xs text-muted-foreground">{t("admin_financial_21_from_last_quarter")}</p>
 </CardContent>
 </Card>
 </div>

 <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_financial_revenue_breakdown")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 {revenueBreakdown.map((item, i) => (
 <div key={i} className="space-y-2">
 <div className="flex items-center justify-between">
 <p className="font-medium text-foreground">{item.source}</p>
 <div className="text-right">
 <p className="font-medium text-foreground">{t("currency_symbol", "$")}{Math.round(item.amount).toLocaleString()}</p>
 <p className="text-sm text-success">{item.growth}</p>
 </div>
 </div>
 <div className="w-full bg-card rounded-full h-2">
 <div className="bg-muted h-2 rounded-full" style={{ width: `${item.percentage}%` }} />
 </div>
 </div>
 ))}
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_financial_expense_analysis")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 {expenses.map((expense, i) => (
 <div key={i} className="space-y-2">
 <div className="flex items-center justify-between">
 <p className="font-medium text-foreground">{expense.category}</p>
 <div className="text-right">
 <p className="font-medium text-foreground">{t("currency_symbol", "$")}{Math.round(expense.amount).toLocaleString()}</p>
 <p className={`text-sm ${expense.change.startsWith("-") ?"text-success" :"text-red-400"}`}>
 {expense.change}
 </p>
 </div>
 </div>
 <div className="w-full bg-card rounded-full h-2">
 <div className="bg-red-600 h-2 rounded-full" style={{ width: `${expense.percentage}%` }} />
 </div>
 </div>
 ))}
 </div>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_financial_monthly_performance_trends")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 {(d?.revenueData || []).length === 0 ? (
 <p className="text-center text-muted-foreground py-4">{t("admin_financial_no_data", "Veri yok")}</p>
 ) : (d?.revenueData || []).map((month, i) => (
 <div key={i} className="flex items-center justify-between border-b border-border pb-4 last:border-0">
 <div className="flex items-center gap-4">
 <Calendar className="h-4 w-4 text-muted-foreground" />
 <div>
 <p className="font-medium text-foreground">{month.month}</p>
 <p className="text-sm text-muted-foreground">{t("admin_auto_q", "Q")}{i < 3 ? 1 : i < 6 ? 2 : 3} 2024</p>
 </div>
 </div>
 <div className="grid grid-cols-3 gap-8 text-right">
 <div>
 <p className="font-medium text-success">{t("currency_symbol", "$")}{Math.round(month.revenue).toLocaleString()}</p>
 <p className="text-xs text-muted-foreground">{t("admin_financial_revenue")}</p>
 </div>
 <div>
 <p className="font-medium text-red-400">{t("currency_symbol", "$")}{Math.round(month.expenses).toLocaleString()}</p>
 <p className="text-xs text-muted-foreground">{t("admin_financial_expenses")}</p>
 </div>
 <div>
 <p className="font-medium text-foreground">{t("currency_symbol", "$")}{Math.round(month.profit).toLocaleString()}</p>
 <p className="text-xs text-success">+{((month.profit / month.revenue) * 100).toFixed(1)}%</p>
 </div>
 </div>
 </div>
 ))}
 </div>
 </CardContent>
 </Card>

 <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_financial_top_performing_properties")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 {(d?.topAgents || []).length === 0 ? (
 <p className="text-center text-muted-foreground py-4">{t("admin_financial_no_data")}</p>
 ) : (d?.topAgents || []).slice(0, 3).map((agent: any, i: number) => (
 <div key={i} className="flex items-center justify-between">
 <div>
 <p className="font-medium text-foreground">{agent.name}</p>
 <p className="text-sm text-muted-foreground">{t("admin_financial_roi")} {(agent.totalRevenue / (d?.totalRevenue || 1) * 100).toFixed(1)}%</p>
 </div>
 <p className="font-medium text-success">{t("currency_symbol", "$")}{agent.totalRevenue?.toLocaleString()}</p>
 </div>
 ))}
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_financial_payment_methods")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 {[{ method:"Bank Transfer", count: 234, amount: d ? d.totalRevenue * 0.514 : 234567, percentage: 51.4 },
 { method:"Credit Card", count: 156, amount: d ? d.totalRevenue * 0.27 : 123456, percentage: 27.0 },
 { method:"Cash", count: 45, amount: d ? d.totalRevenue * 0.1 : 45678, percentage: 10.0 },
 { method:"Check", count: 23, amount: d ? d.totalRevenue * 0.051 : 23456, percentage: 5.1 },
 ].map((method, i) => (
 <div key={i} className="flex items-center justify-between">
 <div>
 <p className="font-medium text-foreground">{method.method}</p>
 <p className="text-sm text-muted-foreground">{method.count} {t("admin_financial_transactions")}</p>
 </div>
 <div className="text-right">
 <p className="font-medium text-foreground">{t("currency_symbol", "$")}{Math.round(method.amount).toLocaleString()}</p>
 <p className="text-sm text-muted-foreground">{method.percentage}%</p>
 </div>
 </div>
 ))}
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_financial_upcoming_reports")}</CardTitle>
 </CardHeader>
 <CardContent>
 {reportsLoading ? (
 <div className="flex justify-center py-8"><Loader2 className="w-6 h-6 animate-spin text-muted-foreground" /></div>
 ) : reports.length === 0 ? (
 <p className="text-center text-muted-foreground py-8">{t("admin_financial_no_reports", "Rapor yok")}</p>
 ) : (
 <div className="space-y-4">
 {reports.map((report) => (
 <div key={report.id} className="flex items-center justify-between">
 <div>
 <p className="font-medium text-foreground">{report.title}</p>
 <p className="text-sm text-muted-foreground">{t("admin_financial_due")}{new Date(report.dueDate).toLocaleDateString()}</p>
 </div>
 <Badge className={report.status ==="in-progress" ?"bg-amber-500/20 text-warning border-0" :"bg-muted0/20 text-muted-foreground border-0"}>
 {report.status}
 </Badge>
 </div>
 ))}
 </div>
 )}
 </CardContent>
 </Card>
 </div>
 </>
 )}
 </div>
 );
}
