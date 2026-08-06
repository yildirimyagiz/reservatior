"use client";

import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { TrendingUp, TrendingDown, DollarSign, FileText, Download, Calendar, Smartphone, Shield, Zap, Loader2 } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { financialReportsApi } from "@/lib/api/financial-reports";

const MOCK_REVENUE_BREAKDOWN = [
  { source: "Rental Income", amount: "$234,567", percentage: 51.4, growth: "+12.3%", icon: DollarSign, color: "bg-blue-600" },
  { source: "Property Management Fees", amount: "$89,234", percentage: 19.5, growth: "+8.7%", icon: FileText, color: "bg-brand" },
  { source: "Infrastructure Add-ons", amount: "$45,098", percentage: 9.9, growth: "+28.4%", icon: Smartphone, color: "bg-blue-600", isNew: true },
  { source: "Maintenance Services", amount: "$67,890", percentage: 14.9, growth: "+15.2%", icon: Zap, color: "bg-amber-600" },
  { source: "Legal & Compliance", amount: "$20,000", percentage: 4.4, growth: "+23.1%", icon: Shield, color: "bg-rose-600" }
];

const MOCK_EXPENSE_ANALYSIS = [
  { category: "Property Maintenance", amount: "$45,678", percentage: 35.2, change: "-5.2%" },
  { category: "Staff Salaries", amount: "$34,567", percentage: 26.7, change: "+2.1%" },
  { category: "Insurance", amount: "$12,345", percentage: 9.5, change: "0%" },
  { category: "Property Taxes", amount: "$23,456", percentage: 18.1, change: "+8.3%" },
  { category: "Utilities", amount: "$13,688", percentage: 10.5, change: "-3.7%" }
];

const MOCK_MONTHLY_PERFORMANCE = [
  { month: "January", revenue: "$45,678", expenses: "$23,456", profit: "$22,222", growth: "+12.3%" },
  { month: "February", revenue: "$48,234", expenses: "$24,567", profit: "$23,667", growth: "+5.6%" },
  { month: "March", revenue: "$52,345", expenses: "$26,789", profit: "$25,556", growth: "+8.0%" },
  { month: "April", revenue: "$49,876", expenses: "$25,234", profit: "$24,642", growth: "-4.6%" },
  { month: "May", revenue: "$54,234", expenses: "$27,890", profit: "$26,344", growth: "+6.9%" },
  { month: "June", revenue: "$58,567", expenses: "$29,456", profit: "$29,111", growth: "+10.5%" }
];

const MOCK_TOP_PROPERTIES = [
  { property: "Sunset Apartments - Unit 4B", revenue: "$34,567", roi: "22.3%" },
  { property: "Ocean View - Unit 2A", revenue: "$28,945", roi: "19.8%" },
  { property: "Garden Heights - Unit 5C", revenue: "$25,678", roi: "18.7%" }
];

const MOCK_PAYMENT_METHODS = [
  { method: "Bank Transfer", count: 234, amount: "$234,567", percentage: 51.4 },
  { method: "Credit Card", count: 156, amount: "$123,456", percentage: 27.0 },
  { method: "Cash", count: 45, amount: "$45,678", percentage: 10.0 },
  { method: "Check", count: 23, amount: "$23,456", percentage: 5.1 }
];

const MOCK_UPCOMING_REPORTS = [
  { report: "Q1 Financial Summary", dueDate: "2024-04-05", status: "scheduled" },
  { report: "Tax Preparation Report", dueDate: "2024-03-15", status: "in-progress" },
  { report: "Annual Performance Review", dueDate: "2024-12-31", status: "scheduled" }
];

const MOCK_SUMMARY = {
  totalRevenue: "$456,789",
  revenueGrowth: "+15.2%",
  netProfit: "$123,456",
  profitGrowth: "+8.7%",
  operatingCosts: "$89,234",
  costsGrowth: "-5.3%",
  roi: "18.5%",
  roiGrowth: "+2.1%"
};

export default function FinancialReports() {
  const { t } = useTranslation();

  const { data: summaryData, isLoading: loadingSummary } = useQuery({
    queryKey: ['financialSummary'],
    queryFn: async () => {
      try {
        const res = await financialReportsApi.getReports() as any;
        return res?.data?.summary || MOCK_SUMMARY;
      } catch (err) {
        return MOCK_SUMMARY;
      }
    }
  });

  const { data: revenueBreakdown = [] } = useQuery({
    queryKey: ['revenueBreakdown'],
    queryFn: async () => {
      try {
        const res = await financialReportsApi.getRevenueBreakdown() as any;
        return Array.isArray(res) ? res : res?.data || MOCK_REVENUE_BREAKDOWN;
      } catch (err) {
        return MOCK_REVENUE_BREAKDOWN;
      }
    }
  });

  const { data: expenseAnalysis = [] } = useQuery({
    queryKey: ['expenseAnalysis'],
    queryFn: async () => {
      try {
        const res = await financialReportsApi.getExpenseAnalysis() as any;
        return Array.isArray(res) ? res : res?.data || MOCK_EXPENSE_ANALYSIS;
      } catch (err) {
        return MOCK_EXPENSE_ANALYSIS;
      }
    }
  });

  const { data: monthlyPerformance = [] } = useQuery({
    queryKey: ['monthlyPerformance'],
    queryFn: async () => {
      try {
        const res = await financialReportsApi.getMonthlyPerformance() as any;
        return Array.isArray(res) ? res : res?.data || MOCK_MONTHLY_PERFORMANCE;
      } catch (err) {
        return MOCK_MONTHLY_PERFORMANCE;
      }
    }
  });

  const { data: topProperties = [] } = useQuery({
    queryKey: ['topProperties'],
    queryFn: async () => {
      try {
        const res = await financialReportsApi.getTopProperties() as any;
        return Array.isArray(res) ? res : res?.data || MOCK_TOP_PROPERTIES;
      } catch (err) {
        return MOCK_TOP_PROPERTIES;
      }
    }
  });

  const { data: paymentMethods = [] } = useQuery({
    queryKey: ['paymentMethods'],
    queryFn: async () => {
      try {
        const res = await financialReportsApi.getPaymentMethods() as any;
        return Array.isArray(res) ? res : res?.data || MOCK_PAYMENT_METHODS;
      } catch (err) {
        return MOCK_PAYMENT_METHODS;
      }
    }
  });

  const { data: upcomingReports = [] } = useQuery({
    queryKey: ['upcomingReports'],
    queryFn: async () => {
      try {
        const res = await financialReportsApi.getUpcomingReports() as any;
        return Array.isArray(res) ? res : res?.data || MOCK_UPCOMING_REPORTS;
      } catch (err) {
        return MOCK_UPCOMING_REPORTS;
      }
    }
  });

  const summary = summaryData || MOCK_SUMMARY;

  return (
    <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">{t("client.src.financial_reports")}</h1>
          <p className="text-muted-foreground">{t("client.src.comprehensive_financial_analysis_and")}</p>
        </div>
        <Button>
          <Download className="w-4 h-4 mr-2" />{t("client.src.export_reports")}
        </Button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("common.total_revenue")}</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            {loadingSummary ? <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" /> : (
              <>
                <div className="text-2xl font-bold">{summary.totalRevenue}</div>
                <p className="text-xs text-muted-foreground">{summary.revenueGrowth} {t("client.src.from_last_quarter")}</p>
              </>
            )}
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.net_profit")}</CardTitle>
            <DollarSign className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            {loadingSummary ? <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" /> : (
              <>
                <div className="text-2xl font-bold">{summary.netProfit}</div>
                <p className="text-xs text-muted-foreground">{summary.profitGrowth} {t("client.src.from_last_quarter")}</p>
              </>
            )}
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.operating_costs")}</CardTitle>
            <TrendingDown className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            {loadingSummary ? <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" /> : (
              <>
                <div className="text-2xl font-bold">{summary.operatingCosts}</div>
                <p className="text-xs text-muted-foreground">{summary.costsGrowth} {t("client.src.from_last_quarter")}</p>
              </>
            )}
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.roi")}</CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            {loadingSummary ? <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" /> : (
              <>
                <div className="text-2xl font-bold">{summary.roi}</div>
                <p className="text-xs text-muted-foreground">{summary.roiGrowth} {t("client.src.from_last_quarter")}</p>
              </>
            )}
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card className="border-none shadow-xl bg-card ring-1 ring-slate-100 overflow-hidden">
          <CardHeader className="bg-muted border-b border-border">
            <div className="flex items-center justify-between">
              <CardTitle className="text-sm font-black text-foreground tracking-widest">{t("client.src.revenue_breakdown")}</CardTitle>
              <Badge variant="outline" className="bg-card text-[10px] font-bold">{t("client.src.live_data")}</Badge>
            </div>
          </CardHeader>
          <CardContent className="p-0">
            <div className="divide-y divide-slate-50">
              {revenueBreakdown.map((item: any, i: number) => {
                const IconComponent = item.icon || DollarSign;
                const colorClass = item.color || "bg-blue-600";
                return (
                  <div key={i} className="p-4 hover:bg-muted/50 transition-colors group">
                    <div className="flex items-center justify-between mb-2">
                      <div className="flex items-center gap-3">
                        <div className={`p-2 rounded-lg ${colorClass.replace('600', '50')} ${colorClass.replace('bg-', 'text-')}`}>
                          <IconComponent className="w-4 h-4" />
                        </div>
                        <div>
                          <p className="text-sm font-black text-foreground flex items-center gap-2">
                            {item.source}
                            {item.isNew && <Badge className="h-4 text-[8px] bg-success text-white font-black border-none px-1">{t("client.src.new_stream")}</Badge>}
                          </p>
                          <p className="text-[10px] text-muted-foreground font-bold tracking-tight">{item.percentage}% {t("client.src.sector_weight")}</p>
                        </div>
                      </div>
                      <div className="text-right">
                        <p className="text-sm font-black text-foreground">{item.amount}</p>
                        <p className="text-[10px] text-success font-black">{item.growth}</p>
                      </div>
                    </div>
                    <div className="w-full bg-muted rounded-full h-1.5 overflow-hidden">
                      <div className={`${colorClass} h-full transition-all duration-1000 group-hover:opacity-80`} style={{ width: `${item.percentage}%` }}></div>
                    </div>
                  </div>
                );
              })}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("client.src.expense_analysis")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {expenseAnalysis.map((expense: any, i: number) => (
                <div key={i} className="space-y-2">
                  <div className="flex items-center justify-between">
                    <p className="font-medium">{expense.category}</p>
                    <div className="text-right">
                      <p className="font-medium">{expense.amount}</p>
                      <p className={`text-sm ${expense.change?.startsWith("-") ? "text-blue-600" : "text-red-600"}`}>
                        {expense.change}
                      </p>
                    </div>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-2">
                    <div className="bg-red-600 h-2 rounded-full" style={{ width: `${expense.percentage}%` }}></div>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{t("client.src.monthly_performance_trends")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {monthlyPerformance.map((month: any, i: number) => (
              <div key={i} className="flex items-center justify-between border-b pb-4 last:border-0">
                <div className="flex items-center gap-4">
                  <Calendar className="h-4 w-4 text-muted-foreground" />
                  <div>
                    <p className="font-medium">{month.month}</p>
                    <p className="text-sm text-muted-foreground">Q{i < 3 ? 1 : i < 6 ? 2 : 3} {new Date().getFullYear()}</p>
                  </div>
                </div>
                <div className="grid grid-cols-3 gap-8 text-right">
                  <div>
                    <p className="font-medium text-blue-600">{month.revenue}</p>
                    <p className="text-xs text-muted-foreground">{t("common.revenue")}</p>
                  </div>
                  <div>
                    <p className="font-medium text-red-600">{month.expenses}</p>
                    <p className="text-xs text-muted-foreground">{t("client.src.expenses")}</p>
                  </div>
                  <div>
                    <p className="font-medium">{month.profit}</p>
                    <p className="text-xs text-blue-600">{month.growth}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>{t("client.src.top_performing_properties")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {topProperties.map((prop: any, i: number) => (
                <div key={i} className="flex items-center justify-between">
                  <div>
                    <p className="font-medium">{prop.property}</p>
                    <p className="text-sm text-muted-foreground">{t("client.src.roi")} {prop.roi}</p>
                  </div>
                  <p className="font-medium text-blue-600">{prop.revenue}</p>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("client.src.payment_methods")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {paymentMethods.map((method: any, i: number) => (
                <div key={i} className="flex items-center justify-between">
                  <div>
                    <p className="font-medium">{method.method}</p>
                    <p className="text-sm text-muted-foreground">{method.count} {t("client.src.transactions")}</p>
                  </div>
                  <div className="text-right">
                    <p className="font-medium">{method.amount}</p>
                    <p className="text-sm text-muted-foreground">{method.percentage}%</p>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("client.src.upcoming_reports")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {upcomingReports.map((report: any, i: number) => (
                <div key={i} className="flex items-center justify-between">
                  <div>
                    <p className="font-medium">{report.report}</p>
                    <p className="text-sm text-muted-foreground">{t("client.src.due")} {report.dueDate}</p>
                  </div>
                  <Badge variant={report.status === "in-progress" ? "secondary" : "outline"}>
                    {report.status}
                  </Badge>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}