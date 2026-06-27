import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { TrendingUp, TrendingDown, DollarSign, FileText, Download, Calendar } from "lucide-react";
export default function FinancialReports() {
  const {
    t
  } = useTranslation();
  return <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">{t("admin.financial.financial_reports")}</h1>
          <p className="text-muted-foreground">{t("admin.financial.comprehensive_financial_analysis_and")}</p>
        </div>
        <Button>
          <Download className="w-4 h-4 mr-2" />{t("admin.financial.export_reports")}</Button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin.financial.total_revenue")}</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">$456,789</div>
            <p className="text-xs text-muted-foreground">{t("admin.financial.152_from_last_quarter")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin.financial.net_profit")}</CardTitle>
            <DollarSign className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">$123,456</div>
            <p className="text-xs text-muted-foreground">{t("admin.financial.87_from_last_quarter")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin.financial.operating_costs")}</CardTitle>
            <TrendingDown className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">$89,234</div>
            <p className="text-xs text-muted-foreground">{t("admin.financial.53_from_last_quarter")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin.financial.roi")}</CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">18.5%</div>
            <p className="text-xs text-muted-foreground">{t("admin.financial.21_from_last_quarter")}</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>{t("admin.financial.revenue_breakdown")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              source: "Rental Income",
              amount: "$234,567",
              percentage: 51.4,
              growth: "+12.3%"
            }, {
              source: "Property Management Fees",
              amount: "$89,234",
              percentage: 19.5,
              growth: "+8.7%"
            }, {
              source: "Maintenance Services",
              amount: "$67,890",
              percentage: 14.9,
              growth: "+15.2%"
            }, {
              source: "Other Services",
              amount: "$45,098",
              percentage: 9.9,
              growth: "+6.8%"
            }, {
              source: "Late Fees",
              amount: "$20,000",
              percentage: 4.4,
              growth: "+23.1%"
            }].map((item, i) => <div key={i} className="space-y-2">
                  <div className="flex items-center justify-between">
                    <p className="font-medium">{item.source}</p>
                    <div className="text-right">
                      <p className="font-medium">{item.amount}</p>
                      <p className="text-sm text-green-600">{item.growth}</p>
                    </div>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-2">
                    <div className="bg-blue-600 h-2 rounded-full" style={{
                  width: `${item.percentage}%`
                }}></div>
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("admin.financial.expense_analysis")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              category: "Property Maintenance",
              amount: "$45,678",
              percentage: 35.2,
              change: "-5.2%"
            }, {
              category: "Staff Salaries",
              amount: "$34,567",
              percentage: 26.7,
              change: "+2.1%"
            }, {
              category: "Insurance",
              amount: "$12,345",
              percentage: 9.5,
              change: "0%"
            }, {
              category: "Property Taxes",
              amount: "$23,456",
              percentage: 18.1,
              change: "+8.3%"
            }, {
              category: "Utilities",
              amount: "$13,688",
              percentage: 10.5,
              change: "-3.7%"
            }].map((expense, i) => <div key={i} className="space-y-2">
                  <div className="flex items-center justify-between">
                    <p className="font-medium">{expense.category}</p>
                    <div className="text-right">
                      <p className="font-medium">{expense.amount}</p>
                      <p className={`text-sm ${expense.change.startsWith("-") ? "text-green-600" : "text-red-600"}`}>
                        {expense.change}
                      </p>
                    </div>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-2">
                    <div className="bg-red-600 h-2 rounded-full" style={{
                  width: `${expense.percentage}%`
                }}></div>
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{t("admin.financial.monthly_performance_trends")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {[{
            month: "January",
            revenue: "$45,678",
            expenses: "$23,456",
            profit: "$22,222",
            growth: "+12.3%"
          }, {
            month: "February",
            revenue: "$48,234",
            expenses: "$24,567",
            profit: "$23,667",
            growth: "+5.6%"
          }, {
            month: "March",
            revenue: "$52,345",
            expenses: "$26,789",
            profit: "$25,556",
            growth: "+8.0%"
          }, {
            month: "April",
            revenue: "$49,876",
            expenses: "$25,234",
            profit: "$24,642",
            growth: "-4.6%"
          }, {
            month: "May",
            revenue: "$54,234",
            expenses: "$27,890",
            profit: "$26,344",
            growth: "+6.9%"
          }, {
            month: "June",
            revenue: "$58,567",
            expenses: "$29,456",
            profit: "$29,111",
            growth: "+10.5%"
          }].map((month, i) => <div key={i} className="flex items-center justify-between border-b pb-4 last:border-0">
                <div className="flex items-center gap-4">
                  <Calendar className="h-4 w-4 text-muted-foreground" />
                  <div>
                    <p className="font-medium">{month.month}</p>
                    <p className="text-sm text-muted-foreground">Q{i < 3 ? 1 : i < 6 ? 2 : 3} 2024</p>
                  </div>
                </div>
                <div className="grid grid-cols-3 gap-8 text-right">
                  <div>
                    <p className="font-medium text-green-600">{month.revenue}</p>
                    <p className="text-xs text-muted-foreground">{t("admin.financial.revenue")}</p>
                  </div>
                  <div>
                    <p className="font-medium text-red-600">{month.expenses}</p>
                    <p className="text-xs text-muted-foreground">{t("admin.financial.expenses")}</p>
                  </div>
                  <div>
                    <p className="font-medium">{month.profit}</p>
                    <p className="text-xs text-green-600">{month.growth}</p>
                  </div>
                </div>
              </div>)}
          </div>
        </CardContent>
      </Card>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>{t("admin.financial.top_performing_properties")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              property: "Sunset Apartments - Unit 4B",
              revenue: "$34,567",
              roi: "22.3%"
            }, {
              property: "Ocean View - Unit 2A",
              revenue: "$28,945",
              roi: "19.8%"
            }, {
              property: "Garden Heights - Unit 5C",
              revenue: "$25,678",
              roi: "18.7%"
            }].map((prop, i) => <div key={i} className="flex items-center justify-between">
                  <div>
                    <p className="font-medium">{prop.property}</p>
                    <p className="text-sm text-muted-foreground">{t("admin.financial.roi")}{prop.roi}</p>
                  </div>
                  <p className="font-medium text-green-600">{prop.revenue}</p>
                </div>)}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("admin.financial.payment_methods")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              method: "Bank Transfer",
              count: 234,
              amount: "$234,567",
              percentage: 51.4
            }, {
              method: "Credit Card",
              count: 156,
              amount: "$123,456",
              percentage: 27.0
            }, {
              method: "Cash",
              count: 45,
              amount: "$45,678",
              percentage: 10.0
            }, {
              method: "Check",
              count: 23,
              amount: "$23,456",
              percentage: 5.1
            }].map((method, i) => <div key={i} className="flex items-center justify-between">
                  <div>
                    <p className="font-medium">{method.method}</p>
                    <p className="text-sm text-muted-foreground">{method.count}{t("admin.financial.transactions")}</p>
                  </div>
                  <div className="text-right">
                    <p className="font-medium">{method.amount}</p>
                    <p className="text-sm text-muted-foreground">{method.percentage}%</p>
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("admin.financial.upcoming_reports")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              report: "Q1 Financial Summary",
              dueDate: "2024-04-05",
              status: "scheduled"
            }, {
              report: "Tax Preparation Report",
              dueDate: "2024-03-15",
              status: "in-progress"
            }, {
              report: "Annual Performance Review",
              dueDate: "2024-12-31",
              status: "scheduled"
            }].map((report, i) => <div key={i} className="flex items-center justify-between">
                  <div>
                    <p className="font-medium">{report.report}</p>
                    <p className="text-sm text-muted-foreground">{t("admin.financial.due")}{report.dueDate}</p>
                  </div>
                  <Badge variant={report.status === "in-progress" ? "secondary" : "outline"}>
                    {report.status}
                  </Badge>
                </div>)}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>;
}