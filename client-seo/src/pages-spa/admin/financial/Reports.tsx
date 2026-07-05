"use client";

import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { TrendingUp, TrendingDown, DollarSign, FileText, Download, Calendar, Loader2 } from "lucide-react";

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
    { source: "Rental Income", amount: d ? d.totalRevenue * 0.514 : 234567, percentage: 51.4, growth: "+12.3%" },
    { source: "Property Management Fees", amount: d ? d.totalRevenue * 0.195 : 89234, percentage: 19.5, growth: "+8.7%" },
    { source: "Maintenance Services", amount: d ? d.totalRevenue * 0.149 : 67890, percentage: 14.9, growth: "+15.2%" },
    { source: "Other Services", amount: d ? d.totalRevenue * 0.099 : 45098, percentage: 9.9, growth: "+6.8%" },
    { source: "Late Fees", amount: d ? d.totalRevenue * 0.044 : 20000, percentage: 4.4, growth: "+23.1%" },
  ];

  const expenses = [
    { category: "Property Maintenance", amount: d ? d.totalExpenses * 0.352 : 45678, percentage: 35.2, change: "-5.2%" },
    { category: "Staff Salaries", amount: d ? d.totalExpenses * 0.267 : 34567, percentage: 26.7, change: "+2.1%" },
    { category: "Insurance", amount: d ? d.totalExpenses * 0.095 : 12345, percentage: 9.5, change: "0%" },
    { category: "Property Taxes", amount: d ? d.totalExpenses * 0.181 : 23456, percentage: 18.1, change: "+8.3%" },
    { category: "Utilities", amount: d ? d.totalExpenses * 0.105 : 13688, percentage: 10.5, change: "-3.7%" },
  ];

  return (
    <div className="space-y-6 min-h-screen">
      <div className="flex items-center justify-between bg-white/5 p-6 rounded-2xl border border-white/10">
        <div>
          <h1 className="text-3xl font-bold text-white">{t("admin.financial.financial_reports")}</h1>
          <p className="text-slate-400">{t("admin.financial.comprehensive_financial_analysis_and")}</p>
        </div>
        <Button className="bg-white/5 border-white/10 text-white hover:bg-white/10">
          <Download className="w-4 h-4 mr-2" />{t("admin.financial.export_reports")}
        </Button>
      </div>

      {dashLoading ? (
        <div className="flex justify-center py-16"><Loader2 className="w-8 h-8 animate-spin text-slate-400" /></div>
      ) : (
        <>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <Card className="bg-white/5 border-white/10">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{t("admin.financial.total_revenue")}</CardTitle>
                <TrendingUp className="h-4 w-4 text-emerald-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-white">${(d?.totalRevenue || 0).toLocaleString()}</div>
                <p className="text-xs text-slate-500">{t("admin.financial.152_from_last_quarter")}</p>
              </CardContent>
            </Card>
            <Card className="bg-white/5 border-white/10">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{t("admin.financial.net_profit")}</CardTitle>
                <DollarSign className="h-4 w-4 text-emerald-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-white">${(d?.totalProfit || 0).toLocaleString()}</div>
                <p className="text-xs text-slate-500">{t("admin.financial.87_from_last_quarter")}</p>
              </CardContent>
            </Card>
            <Card className="bg-white/5 border-white/10">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{t("admin.financial.operating_costs")}</CardTitle>
                <TrendingDown className="h-4 w-4 text-red-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-white">${(d?.totalExpenses || 0).toLocaleString()}</div>
                <p className="text-xs text-slate-500">{t("admin.financial.53_from_last_quarter")}</p>
              </CardContent>
            </Card>
            <Card className="bg-white/5 border-white/10">
              <CardHeader className="flex flex-row items-center justify-between pb-2">
                <CardTitle className="text-sm font-medium text-slate-400">{t("admin.financial.roi")}</CardTitle>
                <FileText className="h-4 w-4 text-slate-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-white">18.5%</div>
                <p className="text-xs text-slate-500">{t("admin.financial.21_from_last_quarter")}</p>
              </CardContent>
            </Card>
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <Card className="bg-white/5 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">{t("admin.financial.revenue_breakdown")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {revenueBreakdown.map((item, i) => (
                    <div key={i} className="space-y-2">
                      <div className="flex items-center justify-between">
                        <p className="font-medium text-white">{item.source}</p>
                        <div className="text-right">
                          <p className="font-medium text-white">${Math.round(item.amount).toLocaleString()}</p>
                          <p className="text-sm text-emerald-400">{item.growth}</p>
                        </div>
                      </div>
                      <div className="w-full bg-white/5 rounded-full h-2">
                        <div className="bg-slate-600 h-2 rounded-full" style={{ width: `${item.percentage}%` }} />
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card className="bg-white/5 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">{t("admin.financial.expense_analysis")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {expenses.map((expense, i) => (
                    <div key={i} className="space-y-2">
                      <div className="flex items-center justify-between">
                        <p className="font-medium text-white">{expense.category}</p>
                        <div className="text-right">
                          <p className="font-medium text-white">${Math.round(expense.amount).toLocaleString()}</p>
                          <p className={`text-sm ${expense.change.startsWith("-") ? "text-emerald-400" : "text-red-400"}`}>
                            {expense.change}
                          </p>
                        </div>
                      </div>
                      <div className="w-full bg-white/5 rounded-full h-2">
                        <div className="bg-red-600 h-2 rounded-full" style={{ width: `${expense.percentage}%` }} />
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>

          <Card className="bg-white/5 border-white/10">
            <CardHeader>
              <CardTitle className="text-white">{t("admin.financial.monthly_performance_trends")}</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {(d?.revenueData || []).length === 0 ? (
                  <p className="text-center text-slate-500 py-4">{t("admin.financial.no_data", "No data available")}</p>
                ) : (d?.revenueData || []).map((month, i) => (
                  <div key={i} className="flex items-center justify-between border-b border-white/10 pb-4 last:border-0">
                    <div className="flex items-center gap-4">
                      <Calendar className="h-4 w-4 text-slate-400" />
                      <div>
                        <p className="font-medium text-white">{month.month}</p>
                        <p className="text-sm text-slate-500">Q{i < 3 ? 1 : i < 6 ? 2 : 3} 2024</p>
                      </div>
                    </div>
                    <div className="grid grid-cols-3 gap-8 text-right">
                      <div>
                        <p className="font-medium text-emerald-400">${Math.round(month.revenue).toLocaleString()}</p>
                        <p className="text-xs text-slate-500">{t("admin.financial.revenue")}</p>
                      </div>
                      <div>
                        <p className="font-medium text-red-400">${Math.round(month.expenses).toLocaleString()}</p>
                        <p className="text-xs text-slate-500">{t("admin.financial.expenses")}</p>
                      </div>
                      <div>
                        <p className="font-medium text-white">${Math.round(month.profit).toLocaleString()}</p>
                        <p className="text-xs text-emerald-400">+{((month.profit / month.revenue) * 100).toFixed(1)}%</p>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>

          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <Card className="bg-white/5 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">{t("admin.financial.top_performing_properties")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {(d?.topAgents || []).length === 0 ? (
                    <p className="text-center text-slate-500 py-4">{t("admin.financial.no_data")}</p>
                  ) : (d?.topAgents || []).slice(0, 3).map((agent: any, i: number) => (
                    <div key={i} className="flex items-center justify-between">
                      <div>
                        <p className="font-medium text-white">{agent.name}</p>
                        <p className="text-sm text-slate-500">{t("admin.financial.roi")} {(agent.totalRevenue / (d?.totalRevenue || 1) * 100).toFixed(1)}%</p>
                      </div>
                      <p className="font-medium text-emerald-400">${agent.totalRevenue?.toLocaleString()}</p>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card className="bg-white/5 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">{t("admin.financial.payment_methods")}</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {[{ method: "Bank Transfer", count: 234, amount: d ? d.totalRevenue * 0.514 : 234567, percentage: 51.4 },
                    { method: "Credit Card", count: 156, amount: d ? d.totalRevenue * 0.27 : 123456, percentage: 27.0 },
                    { method: "Cash", count: 45, amount: d ? d.totalRevenue * 0.1 : 45678, percentage: 10.0 },
                    { method: "Check", count: 23, amount: d ? d.totalRevenue * 0.051 : 23456, percentage: 5.1 },
                  ].map((method, i) => (
                    <div key={i} className="flex items-center justify-between">
                      <div>
                        <p className="font-medium text-white">{method.method}</p>
                        <p className="text-sm text-slate-500">{method.count} {t("admin.financial.transactions")}</p>
                      </div>
                      <div className="text-right">
                        <p className="font-medium text-white">${Math.round(method.amount).toLocaleString()}</p>
                        <p className="text-sm text-slate-500">{method.percentage}%</p>
                      </div>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            <Card className="bg-white/5 border-white/10">
              <CardHeader>
                <CardTitle className="text-white">{t("admin.financial.upcoming_reports")}</CardTitle>
              </CardHeader>
              <CardContent>
                {reportsLoading ? (
                  <div className="flex justify-center py-8"><Loader2 className="w-6 h-6 animate-spin text-slate-400" /></div>
                ) : reports.length === 0 ? (
                  <p className="text-center text-slate-500 py-8">{t("admin.financial.no_reports", "No reports")}</p>
                ) : (
                  <div className="space-y-4">
                    {reports.map((report) => (
                      <div key={report.id} className="flex items-center justify-between">
                        <div>
                          <p className="font-medium text-white">{report.title}</p>
                          <p className="text-sm text-slate-500">{t("admin.financial.due")}{new Date(report.dueDate).toLocaleDateString()}</p>
                        </div>
                        <Badge className={report.status === "in-progress" ? "bg-amber-500/20 text-amber-400 border-0" : "bg-slate-500/20 text-slate-400 border-0"}>
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
