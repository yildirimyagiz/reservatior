"use client";
import { useToast } from '@/hooks/use-toast';

import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DollarSign, TrendingUp, TrendingDown, Calendar, Filter, Loader2, Plus } from "lucide-react";
import { useQuery } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";
import { useState } from "react";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { cn } from "@/lib/utils";

interface Transaction {
  id: string;
  type: "INCOME" | "EXPENSE";
  amount: number;
  currency: string;
  description?: string;
  category?: string;
  occurredAt: string;
  paymentStatus?: string;
  orgId: string;
  propertyId: string;
}

export default function FinancialTransactions() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/finance/records/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  
  
    
  const { t } = useTranslation();
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [formData, setFormData] = useState({ type: "INCOME" as Transaction["type"], amount: 0, description: "", category: "RENTAL_INCOME" });

  const { data: recordsData, isLoading } = useQuery({
    queryKey: ['financialRecords'],
    queryFn: async () => {
      const res: any = await apiClient.get('/finance/records', { limit: 100 });
      return (res?.data || []) as Transaction[];
    },
  });

  const records = (recordsData || []) as Transaction[];
  const totalIncome = records.filter(r => r.type === "INCOME").reduce((s, r) => s + r.amount, 0);
  const totalExpense = records.filter(r => r.type === "EXPENSE").reduce((s, r) => s + r.amount, 0);
  const netProfit = totalIncome - totalExpense;

  const createMutation = useMutation({
    mutationFn: async (data: typeof formData) => {
      return apiClient.post('/finance/records', { ...data, orgId: "org_1", propertyId: "prop_1", currency: "USD", occurredAt: new Date().toISOString() });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['financialRecords'] });
      setIsAddOpen(false);
      setFormData({ type: "INCOME", amount: 0, description: "", category: "RENTAL_INCOME" });
    },
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(formData);
  };

  const categories = [...new Set(records.filter(r => r.category).map(r => r.category as string))];
  const categoryTotals = categories.map(cat => {
    const items = records.filter(r => r.category === cat);
    const total = items.reduce((s, r) => s + r.amount, 0);
    return { category: cat, amount: total, count: items.length };
  });

  return (
    <div className="space-y-6 min-h-screen">
      <div className="flex justify-between items-center bg-white/5 p-6 rounded-2xl border border-slate-200 dark:border-white/10">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-slate-600 rounded-xl shadow-lg shadow-slate-600/20">
            <DollarSign className="w-8 h-8 text-slate-900 dark:text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-slate-900 dark:text-white">
              {t("admin_financial_financial_transactions", "Financial Transactions")}
            </h1>
            <p className="text-slate-500 dark:text-slate-400">
              {t("admin_financial_track_and_manage_all", "Track and manage all financial transactions")}
            </p>
          </div>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-300 hover:bg-white/10">
            <Filter className="w-4 h-4 mr-2" />
            {t("admin_financial_filter", "Filter")}
          </Button>
          <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
            <DialogTrigger asChild>
              <Button className="bg-slate-600 hover:bg-slate-700 text-slate-900 dark:text-white shadow-lg shadow-slate-500/20">
                <Plus className="w-4 h-4 mr-2" />
                {t("admin_financial_new_transaction", "New Transaction")}
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[425px] bg-white dark:bg-slate-900 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
              <DialogHeader>
                <DialogTitle>{t("admin_financial_new_transaction", "New Transaction")}</DialogTitle>
              </DialogHeader>
              <form onSubmit={handleSubmit} className="space-y-4 pt-4">
                <div className="space-y-2">
                  <Label>{t("admin_financial_type", "Type")}</Label>
                  <Select value={formData.type} onValueChange={(v: "INCOME" | "EXPENSE") => setFormData({ ...formData, type: v })}>
                    <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white"><SelectValue /></SelectTrigger>
                    <SelectContent className="bg-white dark:bg-slate-900 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                      <SelectItem value="INCOME">{t("admin_financial_income", "Income")}</SelectItem>
                      <SelectItem value="EXPENSE">{t("admin_financial_expense", "Expense")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label htmlFor="amount">{t("admin_financial_amount", "Amount")}</Label>
                  <Input id="amount" type="number" className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white" value={formData.amount} onChange={e => setFormData({ ...formData, amount: Number(e.target.value) })} required />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="description">{t("admin_financial_description", "Description")}</Label>
                  <Input id="description" className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white" value={formData.description} onChange={e => setFormData({ ...formData, description: e.target.value })} />
                </div>
                <DialogFooter>
                  <Button type="button" variant="ghost" onClick={() => setIsAddOpen(false)} className="text-slate-300">{t("common.cancel", "Cancel")}</Button>
                  <Button type="submit" className="bg-slate-600 hover:bg-slate-700" disabled={createMutation.isPending}>
                    {createMutation.isPending ? t("common.saving", "Saving...") : t("common.create", "Create")}
                  </Button>
                </DialogFooter>
              </form>
            </DialogContent>
          </Dialog>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card className="bg-white/5 border-slate-200 dark:border-white/10">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">{t("admin_financial_total_revenue", "Total Revenue")}</CardTitle>
            <TrendingUp className="h-4 w-4 text-emerald-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-emerald-400">${totalIncome.toLocaleString()}</div>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-slate-200 dark:border-white/10">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">{t("admin_financial_total_expenses", "Total Expenses")}</CardTitle>
            <TrendingDown className="h-4 w-4 text-red-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-red-400">${totalExpense.toLocaleString()}</div>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-slate-200 dark:border-white/10">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">{t("admin_financial_net_profit", "Net Profit")}</CardTitle>
            <DollarSign className="h-4 w-4 text-slate-500 dark:text-slate-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-white">${netProfit.toLocaleString()}</div>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-slate-200 dark:border-white/10">
          <CardHeader className="flex flex-row items-center justify-between pb-2">
            <CardTitle className="text-sm font-medium text-slate-300">{t("admin_financial_transactions", "Transactions")}</CardTitle>
            <Calendar className="h-4 w-4 text-slate-500 dark:text-slate-400" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold text-slate-900 dark:text-white">{records.length}</div>
            <p className="text-xs text-slate-500">{t("admin_financial_total", "Total")}</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card className="bg-white/5 border-slate-200 dark:border-white/10">
          <CardHeader>
            <CardTitle className="text-slate-900 dark:text-white">{t("admin_financial_recent_transactions", "Recent Transactions")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {isLoading ? (
                <div className="flex justify-center p-8"><Loader2 className="w-6 h-6 animate-spin text-slate-500 dark:text-slate-400" /></div>
              ) : records.length === 0 ? (
                <div className="text-center text-slate-500 p-8">{t("admin_financial_no_records_found", "No records found")}</div>
              ) : records.slice(0, 10).map((transaction) => (
                <div key={transaction.id} className="flex items-center justify-between border-b border-slate-200 dark:border-white/10 pb-4 last:border-0">
                  <div className="flex items-center gap-4">
                    <div className={cn("w-2 h-2 rounded-full", transaction.type === "INCOME" ? "bg-emerald-500" : "bg-red-500")} />
                    <div>
                      <p className="font-medium text-slate-900 dark:text-white">{transaction.description || (transaction.type === "INCOME" ? "Income" : "Expense")}</p>
                      <p className="text-sm text-slate-500 dark:text-slate-400 font-mono">{transaction.id.slice(0, 8)} &bull; {new Date(transaction.occurredAt).toLocaleDateString()}</p>
                    </div>
                  </div>
                  <div className="flex items-center gap-3">
                    <div className="text-right">
                      <p className={cn("font-medium", transaction.type === "INCOME" ? "text-emerald-400" : "text-red-400")}>
                        {transaction.type === "INCOME" ? "+" : "-"}${transaction.amount.toLocaleString()}
                      </p>
                      <Badge className={cn("border-0", transaction.paymentStatus === "PAID" ? "bg-emerald-500/20 text-emerald-400" : "bg-amber-500/20 text-amber-400")}>
                        {transaction.paymentStatus || "PENDING"}
                      </Badge>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        <Card className="bg-white/5 border-slate-200 dark:border-white/10">
          <CardHeader>
            <CardTitle className="text-slate-900 dark:text-white">{t("admin_financial_transaction_categories", "Categories")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {categoryTotals.length === 0 ? (
                <p className="text-center text-slate-500 p-8">{t("admin_financial_no_categories", "No categories")}</p>
              ) : categoryTotals.slice(0, 8).map((cat, i) => (
                <div key={cat.category} className="space-y-2">
                  <div className="flex items-center justify-between">
                    <p className="font-medium text-slate-900 dark:text-white text-sm capitalize">{cat.category.replace(/_/g, " ").toLowerCase()}</p>
                    <p className="font-medium text-emerald-400">${cat.amount.toLocaleString()}</p>
                  </div>
                  <div className="w-full bg-white/5 rounded-full h-2">
                    <div
                      className="h-2 rounded-full bg-slate-500"
                      style={{ width: `${Math.min((cat.amount / Math.max(...categoryTotals.map(c => c.amount))) * 100, 100)}%` }}
                    />
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
