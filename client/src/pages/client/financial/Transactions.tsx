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
  const { data: rawData, isLoading } = useQuery({
    queryKey: ['financial-transactions'],
    queryFn: async () => {
      const response = await financialsApi.getRecords({ limit: 100 });
      return response.data || [];
    }
  });

  const transactions = rawData || [];
  
  const incomeRecords = transactions.filter(t => t.type === "INCOME");
  const expenseRecords = transactions.filter(t => t.type === "EXPENSE");
  
  const totalIncome = incomeRecords.reduce((sum, t) => sum + t.amount, 0);
  const totalExpense = expenseRecords.reduce((sum, t) => sum + t.amount, 0);
  const netProfit = totalIncome - totalExpense;

  const getStatusColor = (status?: string) => {
    switch ((status || "").toLowerCase()) {
      case "paid": case "completed": return "default";
      case "pending": return "secondary";
      case "failed": case "cancelled": return "destructive";
      default: return "secondary";
    }
  };

  return <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">{t("client.src.financial_transactions")}</h1>
          <p className="text-muted-foreground">{t("client.src.track_and_manage_all")}</p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline">
            <Filter className="w-4 h-4 mr-2" />{t("client.src.filter")}</Button>
          <Button>
            <DollarSign className="w-4 h-4 mr-2" />{t("client.src.new_transaction")}</Button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.total_revenue")}</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">${totalIncome.toLocaleString()}</div>
            <p className="text-xs text-muted-foreground">{t("client.src.125_from_last_month")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.total_expenses")}</CardTitle>
            <TrendingDown className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">${totalExpense.toLocaleString()}</div>
            <p className="text-xs text-muted-foreground">{t("client.src.82_from_last_month")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.net_profit")}</CardTitle>
            <DollarSign className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">${netProfit.toLocaleString()}</div>
            <p className="text-xs text-muted-foreground">{t("client.src.187_from_last_month")}</p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("client.src.transactions")}</CardTitle>
            <Calendar className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{transactions.length}</div>
            <p className="text-xs text-muted-foreground">{t("client.src.this_month")}</p>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle>{t("client.src.recent_transactions")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {isLoading ? (
              <div className="flex justify-center p-8"><Loader2 className="w-8 h-8 animate-spin text-primary" /></div>
            ) : transactions.length === 0 ? (
              <div className="text-center p-8 text-muted-foreground">{t("client.src.no_transactions_found")}</div>
            ) : transactions.slice(0, 10).map((transaction, i) => <div key={transaction.id || i} className="flex items-center justify-between border-b pb-4 last:border-0">
                <div className="flex items-center gap-4">
                  <div className={`w-2 h-2 rounded-full ${transaction.type === "INCOME" ? "bg-green-500" : "bg-red-500"}`}></div>
                  <div>
                    <p className="font-medium">{transaction.description || (transaction.type === "INCOME" ? t("client.src.income") : t("client.src.expense"))}</p>
                    <p className="text-sm text-muted-foreground">{transaction.id.split("-").pop()?.toUpperCase()} • {new Date(transaction.createdAt).toLocaleDateString()}</p>
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <div className="text-right">
                    <p className={`font-medium ${transaction.type === "INCOME" ? "text-green-600" : "text-red-600"}`}>
                      {transaction.type === "INCOME" ? "+" : "-"}${transaction.amount.toLocaleString()}
                    </p>
                    <Badge variant={getStatusColor(transaction.paymentStatus)}>
                      {transaction.paymentStatus || "completed"}
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
            <CardTitle>{t("client.src.transaction_categories")}</CardTitle>
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
            <CardTitle>{t("client.src.upcoming_transactions")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[{
              description: t("client.src.monthly_property_tax"),
              amount: "$4,500",
              dueDate: "2024-01-20",
              type: "expense"
            }, {
              description: t("client.src.rental_payment_unit_3c"),
              amount: "$2,100",
              dueDate: "2024-01-25",
              type: "income"
            }, {
              description: t("client.src.property_insurance_renewal"),
              amount: "$1,200",
              dueDate: "2024-01-30",
              type: "expense"
            }, {
              description: t("client.src.vendor_payment_landscaping"),
              amount: "$800",
              dueDate: "2024-02-01",
              type: "expense"
            }].map((upcoming, i) => <div key={i} className="flex items-center justify-between">
                  <div>
                    <p className="font-medium">{upcoming.description}</p>
                    <p className="text-sm text-muted-foreground">{t("client.src.due")}{upcoming.dueDate}</p>
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