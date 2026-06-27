import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DollarSign, TrendingUp, TrendingDown, Calendar, Filter, Loader2 } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { financialsApi, type FinancialRecord } from "@/lib/api/financials";
export default function FinancialTransactions() {
  const {
    t
  } = useTranslation();

  const { data: recordsData, isLoading } = useQuery({
    queryKey: ['financialRecords', 'ALL'],
    queryFn: async () => {
      const res = await financialsApi.getRecords({ limit: 100 });
      return res.data || [];
    }
  });

  const records = recordsData || [];
  const totalIncome = records.filter(r => r.type === "INCOME").reduce((s, r) => s + r.amount, 0);
  const totalExpense = records.filter(r => r.type === "EXPENSE").reduce((s, r) => s + r.amount, 0);
  const netProfit = totalIncome - totalExpense;
  return <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">{t("admin.financial.financial_transactions")}</h1>
          <p className="text-muted-foreground">{t("admin.financial.track_and_manage_all")}</p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline">
            <Filter className="w-4 h-4 mr-2" />{t("admin.financial.filter")}</Button>
          <Button>
            <DollarSign className="w-4 h-4 mr-2" />{t("admin.financial.new_transaction")}</Button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin.financial.total_revenue")}</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">${totalIncome.toLocaleString()}</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin.financial.total_expenses")}</CardTitle>
            <TrendingDown className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">${totalExpense.toLocaleString()}</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin.financial.net_profit")}</CardTitle>
            <DollarSign className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">${netProfit.toLocaleString()}</div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin.financial.transactions")}</CardTitle>
            <Calendar className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{records.length}</div>
            <p className="text-xs text-muted-foreground">{t("admin.financial.this_month")}</p>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{t("admin.financial.recent_transactions")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {isLoading ? (
              <div className="flex justify-center p-8"><Loader2 className="w-8 h-8 animate-spin text-primary" /></div>
            ) : records.length === 0 ? (
              <div className="text-center text-muted-foreground p-8">{t("admin.financial.no_records_found")}</div>
            ) : records.slice(0, 10).map((transaction) => <div key={transaction.id} className="flex items-center justify-between border-b pb-4 last:border-0">
                <div className="flex items-center gap-4">
                  <div className={`w-2 h-2 rounded-full ${transaction.type === "INCOME" ? "bg-green-500" : "bg-red-500"}`}></div>
                  <div>
                    <p className="font-medium">{transaction.description || (transaction.type === "INCOME" ? "Income" : "Expense")}</p>
                    <p className="text-sm text-muted-foreground">{transaction.id.slice(0, 8)} • {new Date(transaction.occurredAt).toLocaleDateString()}</p>
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <div className="text-right">
                    <p className={`font-medium ${transaction.type === "INCOME" ? "text-green-600" : "text-red-600"}`}>
                      {transaction.type === "INCOME" ? "+" : "-"}${transaction.amount.toLocaleString()}
                    </p>
                    <Badge variant={transaction.paymentStatus === "PAID" ? "default" : "secondary"}>
                      {transaction.paymentStatus || "PENDING"}
                    </Badge>
                  </div>
                </div>
              </div>)}
          </div>
        </CardContent>
      </Card>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>{t("admin.financial.transaction_categories")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              category: "Rental Income",
              amount: "$89,234",
              percentage: 71.6,
              type: "income"
            }, {
              category: "Maintenance",
              amount: "$12,450",
              percentage: 27.5,
              type: "expense"
            }, {
              category: "Property Management",
              amount: "$8,900",
              percentage: 19.7,
              type: "expense"
            }, {
              category: "Insurance",
              amount: "$3,600",
              percentage: 8.0,
              type: "expense"
            }, {
              category: "Utilities",
              amount: "$2,834",
              percentage: 6.3,
              type: "expense"
            }].map((cat, i) => <div key={i} className="space-y-2">
                  <div className="flex items-center justify-between">
                    <p className="font-medium">{cat.category}</p>
                    <p className={`font-medium ${cat.type === "income" ? "text-green-600" : "text-red-600"}`}>
                      {cat.type === "income" ? "+" : "-"}{cat.amount}
                    </p>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-2">
                    <div className={`h-2 rounded-full ${cat.type === "income" ? "bg-green-500" : "bg-red-500"}`} style={{
                  width: `${cat.percentage}%`
                }}></div>
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("admin.financial.upcoming_transactions")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              description: t("admin.financial.monthly_property_tax"),
              amount: "$4,500",
              dueDate: "2024-01-20",
              type: "expense"
            }, {
              description: t("admin.financial.rental_payment_unit_3c"),
              amount: "$2,100",
              dueDate: "2024-01-25",
              type: "income"
            }, {
              description: t("admin.financial.property_insurance_renewal"),
              amount: "$1,200",
              dueDate: "2024-01-30",
              type: "expense"
            }, {
              description: t("admin.financial.vendor_payment_landscaping"),
              amount: "$800",
              dueDate: "2024-02-01",
              type: "expense"
            }].map((upcoming, i) => <div key={i} className="flex items-center justify-between">
                  <div>
                    <p className="font-medium">{upcoming.description}</p>
                    <p className="text-sm text-muted-foreground">{t("admin.financial.due")}{upcoming.dueDate}</p>
                  </div>
                  <div className="text-right">
                    <p className={`font-medium ${upcoming.type === "income" ? "text-green-600" : "text-red-600"}`}>
                      {upcoming.type === "income" ? "+" : "-"}{upcoming.amount}
                    </p>
                  </div>
                </div>)}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>;
}