import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, FormEvent } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { financialsApi, type Expense, type FinancialRecord, type Budget, type Payout, type ExpenseCategory } from "@/lib/api/financials";
import { Edit, Trash2, MoreHorizontal, TrendingUp, TrendingDown, Loader2, RefreshCw } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";

// ─── Expenses ─────────────────────────────────────────────────────────────────
export function Expenses() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [createOpen, setCreateOpen] = useState(false);
  const [form, setForm] = useState({
    orgId: "",
    propertyId: "",
    category: "MAINTENANCE" as ExpenseCategory,
    amount: "",
    currency: "USD",
    date: "",
    description: ""
  });

  const { data: expenses = [], isLoading, refetch } = useQuery({
    queryKey: ['financialExpenses'],
    queryFn: async () => {
      const response = await financialsApi.getExpenses();
      return Array.isArray(response) ? response : (response as any)?.data || [];
    }
  });

  const createMutation = useMutation({
    mutationFn: (newExpense: Omit<Expense, 'id'>) => financialsApi.createExpense(newExpense),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['financialExpenses'] });
      setCreateOpen(false);
      toast({ title: t("admin.financial.expense_recorded") });
    },
    onError: () => {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_save_expense"),
        variant: "destructive"
      });
    }
  });

  const handleCreate = (e: FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      ...form,
      amount: parseFloat(form.amount)
    } as any);
  };

  return <>
      <PageShell title={t("admin.financial.expenses")} description={t("admin.financial.track_property_expenses_and")} createLabel={t("admin.financial.add_expense", "Gider Ekle")} onCreateClick={() => setCreateOpen(true)} stats={[{
      label: t("admin.financial.total_expenses"),
      value: expenses.length
    }, {
      label: t("admin.financial.total_amount"),
      value: `$${expenses.reduce((s: number, e: Expense) => s + e.amount, 0).toLocaleString()}`
    }]} actions={<Button variant="outline" size="sm" onClick={() => refetch()} disabled={isLoading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${isLoading ? 'animate-spin' : ''}`} />{t("admin.financial.refresh")}</Button>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader><TableRow><TableHead>{t("admin.financial.category")}</TableHead><TableHead>{t("admin.financial.amount")}</TableHead><TableHead>{t("admin.financial.date")}</TableHead><TableHead>{t("admin.financial.description")}</TableHead><TableHead className="w-10" /></TableRow></TableHeader>
            <TableBody>
              {isLoading ? <TableRow><TableCell colSpan={5} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : expenses.length === 0 ? <TableRow><TableCell colSpan={5} className="text-center py-12 text-muted-foreground">{t("admin.financial.no_expenses_found")}</TableCell></TableRow> : expenses.map((e: Expense) => <TableRow key={e.id} className="hover:bg-muted/40">
                    <TableCell><Badge className="bg-secondary border-0 text-xs text-secondary-foreground">{e.category}</Badge></TableCell>
                    <TableCell className="font-semibold text-sm">${e.amount.toLocaleString()}</TableCell>
                    <TableCell className="text-sm text-muted-foreground">{new Date(e.date).toLocaleDateString()}</TableCell>
                    <TableCell className="text-xs text-muted-foreground">{e.description}</TableCell>
                    <TableCell><DropdownMenu><DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger><DropdownMenuContent align="end"><DropdownMenuItem><Edit className="w-4 h-4 mr-2" />{t("admin.financial.edit")}</DropdownMenuItem><DropdownMenuItem className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("admin.financial.delete")}</DropdownMenuItem></DropdownMenuContent></DropdownMenu></TableCell>
                  </TableRow>)}
            </TableBody>
          </Table>
        </div>
      </PageShell>
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader><DialogTitle>{t("admin.financial.add_expense")}</DialogTitle></DialogHeader>
          <form onSubmit={handleCreate} className="space-y-4 py-2">
            <div className="space-y-1.5"><Label>{t("admin.financial.org_id")}</Label><Input value={form.orgId} onChange={e => setForm({
              ...form,
              orgId: e.target.value
            })} required /></div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1.5"><Label>{t("admin.financial.amount")}</Label><Input type="number" value={form.amount} onChange={e => setForm({
                ...form,
                amount: e.target.value
              })} required /></div>
              <div className="space-y-1.5"><Label>{t("admin.financial.currency")}</Label>
                <Select value={form.currency} onValueChange={v => setForm({
                ...form,
                currency: v
              })}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent><SelectItem value="USD">{t("admin.financial.usd")}</SelectItem><SelectItem value="EUR">{t("admin.financial.eur")}</SelectItem></SelectContent>
                </Select>
              </div>
            </div>
            <div className="space-y-1.5"><Label>{t("admin.financial.category")}</Label>
              <Select value={form.category} onValueChange={v => setForm({
              ...form,
              category: v as ExpenseCategory
            })}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>{["MAINTENANCE", "INSURANCE", "UTILITIES", "TAX", "RENOVATION", "OTHER"].map(t => <SelectItem key={t} value={t}>{t}</SelectItem>)}</SelectContent>
              </Select>
            </div>
            <div className="space-y-1.5"><Label>{t("admin.financial.date")}</Label><Input type="date" value={form.date} onChange={e => setForm({
              ...form,
              date: e.target.value
            })} required /></div>
            <div className="space-y-1.5"><Label>{t("admin.financial.description")}</Label><Input value={form.description} onChange={e => setForm({
              ...form,
              description: e.target.value
            })} /></div>
            <DialogFooter><Button type="submit" disabled={createMutation.isPending}>{createMutation.isPending ? t("commonSaving") : t("admin.financial.record_expense")}</Button></DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </>;
}

// ─── Financial Records ────────────────────────────────────────────────────────
export function FinancialRecords() {
  const { t } = useTranslation();
  
  const { data: records = [], isLoading, refetch } = useQuery({
    queryKey: ['financialRecords'],
    queryFn: async () => {
      const response = await financialsApi.getRecords();
      return Array.isArray(response) ? response : (response as any)?.data || [];
    }
  });

  const totalIncome = records.filter((r: FinancialRecord) => r.type === "INCOME").reduce((s: number, r: FinancialRecord) => s + r.amount, 0);
  const totalExpenses = records.filter((r: FinancialRecord) => r.type === "EXPENSE").reduce((s: number, r: FinancialRecord) => s + Math.abs(r.amount), 0);
  const netProfit = totalIncome - totalExpenses;

  return <PageShell title={t("admin.financial.financial_records")} description={t("admin.financial.income_expenses_and_profit")} stats={[{
    label: t("admin.financial.total_income"),
    value: `$${totalIncome.toLocaleString()}`
  }, {
    label: t("admin.financial.total_expenses"),
    value: `$${totalExpenses.toLocaleString()}`
  }, {
    label: t("admin.financial.net_profit"),
    value: `$${netProfit.toLocaleString()}`
  }, {
    label: t("admin.financial.transactions"),
    value: records.length
  }]} actions={<Button variant="outline" size="sm" onClick={() => refetch()} disabled={isLoading}>
          <RefreshCw className={`w-4 h-4 mr-2 ${isLoading ? 'animate-spin' : ''}`} />{t("admin.financial.refresh")}</Button>}>
      <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
        <Table>
          <TableHeader><TableRow><TableHead>{t("admin.financial.date")}</TableHead><TableHead>{t("admin.financial.description")}</TableHead><TableHead>{t("admin.financial.category")}</TableHead><TableHead>{t("admin.financial.type")}</TableHead><TableHead className="text-right">{t("admin.financial.amount")}</TableHead></TableRow></TableHeader>
          <TableBody>
            {isLoading ? <TableRow><TableCell colSpan={5} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : records.length === 0 ? <TableRow><TableCell colSpan={5} className="text-center py-12 text-muted-foreground">{t("admin.financial.no_records_found")}</TableCell></TableRow> : records.map((r: FinancialRecord) => <TableRow key={r.id} className="hover:bg-muted/40 transition-colors">
                  <TableCell className="text-sm text-muted-foreground">{new Date(r.occurredAt).toLocaleDateString()}</TableCell>
                  <TableCell className="font-medium text-sm">{r.description || "—"}</TableCell>
                  <TableCell><Badge className="bg-secondary border-0 text-xs text-secondary-foreground">{r.category || 'General'}</Badge></TableCell>
                  <TableCell>
                    {r.type === "INCOME" ? <span className="text-xs flex items-center gap-1 text-green-600 font-medium"><TrendingUp className="w-3 h-3" />{t("admin.financial.income")}</span> : <span className="text-xs flex items-center gap-1 text-red-600 font-medium"><TrendingDown className="w-3 h-3" />{t("admin.financial.expense")}</span>}
                  </TableCell>
                  <TableCell className={`text-right font-semibold text-sm ${r.type === "INCOME" ? "text-green-600" : "text-red-600"}`}>
                    {r.type === "INCOME" ? "+" : ""}${Math.abs(r.amount).toLocaleString()}
                  </TableCell>
                </TableRow>)}
          </TableBody>
        </Table>
      </div>
    </PageShell>;
}

// ─── Tax Records ──────────────────────────────────────────────────────────────
export function TaxRecords() {
  const { t } = useTranslation();
  return <PageShell title={t("admin.financial.tax_records")} description={t("admin.financial.property_and_income_tax")} stats={[{
    label: t("admin.financial.total_tax"),
    value: "$8,400"
  }]}>
      <div className="bg-card border border-border rounded-xl p-8 text-center text-muted-foreground">{t("admin.financial.tax_records_are_being")}</div>
    </PageShell>;
}

// ─── Budgets ──────────────────────────────────────────────────────────────────
export function Budgets() {
  const { t } = useTranslation();
  
  const { data: budgets = [], isLoading, refetch } = useQuery({
    queryKey: ['financialBudgets'],
    queryFn: async () => {
      const response = await financialsApi.getBudgets();
      return Array.isArray(response) ? response : (response as any)?.data || [];
    }
  });

  return <PageShell title={t("admin.financial.budgets")} description={t("admin.financial.manage_and_track_budget")} stats={[{
    label: t("admin.financial.total_budgets"),
    value: budgets.length
  }, {
    label: t("admin.financial.total_allocated"),
    value: `$${budgets.reduce((s: number, b: Budget) => s + b.totalAmount, 0).toLocaleString()}`
  }]} actions={<Button variant="outline" size="sm" onClick={() => refetch()} disabled={isLoading}>
          <RefreshCw className={`w-4 h-4 mr-2 ${isLoading ? 'animate-spin' : ''}`} />{t("admin.financial.refresh")}</Button>}>
      {isLoading ? <div className="flex justify-center py-24"><Loader2 className="w-8 h-8 animate-spin" /></div> : budgets.length === 0 ? <div className="bg-card border border-border rounded-xl p-12 text-center text-muted-foreground">{t("admin.financial.no_budgets_found")}</div> : <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {budgets.map((b: Budget) => {
        const pct = Math.min((b.spentAmount || 0) / b.totalAmount * 100, 100);
        const over = (b.spentAmount || 0) > b.totalAmount;
        return <div key={b.id} className="bg-card border border-border rounded-xl p-5 space-y-4 shadow-sm hover:shadow-md transition-shadow">
                <div className="flex justify-between items-start">
                  <div>
                    <p className="font-semibold text-sm">{b.notes || `Budget ${b.year}`}</p>
                    <p className="text-xs text-muted-foreground">{b.year} · {b.currency}</p>
                  </div>
                  {over && <Badge className="bg-red-100 text-red-700 border-0 text-xs">{t("admin.financial.over_budget")}</Badge>}
                </div>
                <div>
                  <div className="flex justify-between text-sm mb-2">
                    <span className="text-muted-foreground text-xs">{t("admin.financial.spent")}</span>
                    <span className="text-xs"><strong>${(b.spentAmount || 0).toLocaleString()}</strong> / ${b.totalAmount.toLocaleString()}</span>
                  </div>
                  <div className="h-2 bg-muted rounded-full overflow-hidden">
                    <div className={`h-full rounded-full transition-all ${over ? "bg-red-500" : pct > 80 ? "bg-orange-500" : "bg-primary"}`} style={{
                width: `${pct}%`
              }} />
                  </div>
                  <p className="text-[10px] text-muted-foreground mt-1">{pct.toFixed(0)}{t("admin.financial.utilized")}</p>
                </div>
              </div>;
      })}
        </div>}
    </PageShell>;
}

// ─── Payouts ──────────────────────────────────────────────────────────────────
export function Payouts() {
  const { t } = useTranslation();
  
  const { data: payouts = [], isLoading, refetch } = useQuery({
    queryKey: ['financialPayouts'],
    queryFn: async () => {
      const response = await financialsApi.getPayouts();
      return Array.isArray(response) ? response : (response as any)?.data || [];
    }
  });

  const statusCls: Record<string, string> = {
    PAID: "bg-green-100 text-green-700",
    PENDING: "bg-yellow-100 text-yellow-700",
    PROCESSING: "bg-blue-100 text-blue-700",
    FAILED: "bg-red-100 text-red-700"
  };

  return <PageShell title={t("admin.financial.payouts")} description={t("admin.financial.commission_payments_vendor_payouts")} stats={[{
    label: t("admin.financial.total_payouts"),
    value: payouts.length
  }]} actions={<Button variant="outline" size="sm" onClick={() => refetch()} disabled={isLoading}>
          <RefreshCw className={`w-4 h-4 mr-2 ${isLoading ? 'animate-spin' : ''}`} />{t("admin.financial.refresh")}</Button>}>
      <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
        <Table>
          <TableHeader><TableRow><TableHead>{t("admin.financial.recipient")}</TableHead><TableHead>{t("admin.financial.method")}</TableHead><TableHead>{t("admin.financial.amount")}</TableHead><TableHead>{t("admin.financial.reference")}</TableHead><TableHead>{t("admin.financial.status")}</TableHead><TableHead className="w-10" /></TableRow></TableHeader>
          <TableBody>
            {isLoading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : payouts.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("admin.financial.no_payouts_found")}</TableCell></TableRow> : payouts.map((p: Payout) => <TableRow key={p.id} className="hover:bg-muted/40">
                  <TableCell className="font-medium text-sm">{p.recipientId}</TableCell>
                  <TableCell><Badge className="bg-secondary border-0 text-xs text-secondary-foreground">{p.method || 'Transfer'}</Badge></TableCell>
                  <TableCell className="font-semibold text-sm">${p.amount.toLocaleString()}</TableCell>
                  <TableCell className="font-mono text-[10px] text-muted-foreground">{p.reference || 'N/A'}</TableCell>
                  <TableCell><Badge className={`${statusCls[p.status] || 'bg-gray-100'} border-0 text-xs font-normal`}>{p.status}</Badge></TableCell>
                  <TableCell><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></TableCell>
                </TableRow>)}
          </TableBody>
        </Table>
      </div>
    </PageShell>;
}