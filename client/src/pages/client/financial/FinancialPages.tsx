import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, FormEvent } from "react";
import { PageShell } from "../layout/PageShell";
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
import { Edit, Trash2, MoreHorizontal, TrendingUp, TrendingDown, Loader2, RefreshCw, Video, Globe, Brain, Sparkles, Wand2 } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";

// ─── Expenses ─────────────────────────────────────────────────────────────────
export function Expenses() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [createOpen, setCreateOpen] = useState(false);
  const queryClient = useQueryClient();

  const { data: expenses = [], isLoading: loading, refetch: fetchExpenses } = useQuery<Expense[]>({
    queryKey: ['expenses'],
    queryFn: async () => {
      const response = await financialsApi.getExpenses();
      return Array.isArray(response) ? response : (response as any)?.data || [];
    }
  });
  const [form, setForm] = useState({
    orgId: "",
    propertyId: "",
    category: "MAINTENANCE" as ExpenseCategory,
    amount: "",
    currency: "USD",
    date: "",
    description: ""
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => await financialsApi.createExpense(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['expenses'] });
      setCreateOpen(false);
      toast({ title: t("client.src.expense_recorded") });
    },
    onError: () => {
      toast({ title: t("client.src.error"), description: t("client.src.failed_to_save_expense"), variant: "destructive" });
    }
  });

  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      ...form,
      amount: parseFloat(form.amount)
    });
  };
  return <>
      <PageShell title={t("client.src.expenses")} description={t("client.src.track_property_expenses_and")} createLabel="Add Expense" onCreateClick={() => setCreateOpen(true)} stats={[{
      label: t("client.src.total_expenses"),
      value: expenses.length
    }, {
      label: t("client.src.total_amount"),
      value: `$${expenses.reduce((s, e) => s + e.amount, 0).toLocaleString()}`
    }]} actions={<Button variant="outline" size="sm" onClick={() => fetchExpenses()} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("client.src.refresh")}</Button>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader><TableRow><TableHead>{t("client.src.category")}</TableHead><TableHead>{t("client.src.amount")}</TableHead><TableHead>{t("client.src.date")}</TableHead><TableHead>{t("client.src.description")}</TableHead><TableHead className="w-10" /></TableRow></TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={5} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : expenses.length === 0 ? <TableRow><TableCell colSpan={5} className="text-center py-12 text-muted-foreground">{t("client.src.no_expenses_found")}</TableCell></TableRow> : expenses.map((e: any) => <TableRow key={e.id} className="hover:bg-muted/40">
                    <TableCell><Badge className="bg-secondary border-0 text-xs text-secondary-foreground">{e.category}</Badge></TableCell>
                    <TableCell className="font-semibold text-sm">${e.amount.toLocaleString()}</TableCell>
                    <TableCell className="text-sm text-muted-foreground">{new Date(e.date).toLocaleDateString()}</TableCell>
                    <TableCell className="text-xs text-muted-foreground">{e.description}</TableCell>
                    <TableCell><DropdownMenu><DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger><DropdownMenuContent align="end"><DropdownMenuItem><Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem><DropdownMenuItem className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem></DropdownMenuContent></DropdownMenu></TableCell>
                  </TableRow>)}
            </TableBody>
          </Table>
        </div>
      </PageShell>
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader><DialogTitle>{t("client.src.add_expense")}</DialogTitle></DialogHeader>
          <form onSubmit={handleCreate} className="space-y-4 py-2">
            <div className="space-y-1.5"><Label>{t("client.src.org_id")}</Label><Input value={form.orgId} onChange={e => setForm({
              ...form,
              orgId: e.target.value
            })} required /></div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1.5"><Label>{t("client.src.amount")}</Label><Input type="number" value={form.amount} onChange={e => setForm({
                ...form,
                amount: e.target.value
              })} required /></div>
              <div className="space-y-1.5"><Label>{t("client.src.currency")}</Label>
                <Select value={form.currency} onValueChange={v => setForm({
                ...form,
                currency: v
              })}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent><SelectItem value="USD">{t("client.src.usd")}</SelectItem><SelectItem value="EUR">{t("client.src.eur")}</SelectItem></SelectContent>
                </Select>
              </div>
            </div>
            <div className="space-y-1.5"><Label>{t("client.src.category")}</Label>
              <Select value={form.category} onValueChange={v => setForm({
              ...form,
              category: v as ExpenseCategory
            })}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>{["MAINTENANCE", "INSURANCE", "UTILITIES", "TAX", "RENOVATION", "OTHER"].map(t => <SelectItem key={t} value={t}>{t}</SelectItem>)}</SelectContent>
              </Select>
            </div>
            <div className="space-y-1.5"><Label>{t("client.src.date")}</Label><Input type="date" value={form.date} onChange={e => setForm({
              ...form,
              date: e.target.value
            })} required /></div>
            <div className="space-y-1.5"><Label>{t("client.src.description")}</Label><Input value={form.description} onChange={e => setForm({
              ...form,
              description: e.target.value
            })} /></div>
            <DialogFooter><Button type="submit">{t("client.src.record_expense")}</Button></DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </>;
}

// ─── Financial Records ────────────────────────────────────────────────────────
export function FinancialRecords() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const { data: records = [], isLoading: loading, refetch: fetchRecords } = useQuery<FinancialRecord[]>({
    queryKey: ['financialRecords'],
    queryFn: async () => {
      const response = await financialsApi.getRecords();
      return Array.isArray(response) ? response : (response as any)?.data || [];
    }
  });
  const totalIncome = records.filter(r => r.type === "INCOME").reduce((s, r) => s + r.amount, 0);
  const totalExpenses = records.filter(r => r.type === "EXPENSE").reduce((s, r) => s + Math.abs(r.amount), 0);
  const netProfit = totalIncome - totalExpenses;
  return <PageShell title={t("client.src.financial_records")} description={t("client.src.income_expenses_and_profit")} stats={[{
    label: t("client.src.total_income"),
    value: `$${totalIncome.toLocaleString()}`
  }, {
    label: t("client.src.net_profit"),
    value: `$${netProfit.toLocaleString()}`
  }, {
    label: t("client.src.ai_video_roi"),
    value: "+24.5%",
    color: "text-purple-600"
  }, {
    label: t("client.src.transl_savings"),
    value: "$1,240",
    color: "text-blue-600"
  }]} actions={<div className="flex gap-2">
          <Button variant="outline" size="sm" className="border-purple-200 text-purple-700 bg-purple-50">
            <Sparkles className="w-4 h-4 mr-2" />{t("client.src.neural_reports")}</Button>
          <Button variant="outline" size="sm" onClick={() => fetchRecords()} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("client.src.refresh")}</Button>
        </div>}>
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 mb-8">
        <div className="lg:col-span-2">
            <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
                <Table>
                    <TableHeader><TableRow><TableHead>{t("client.src.date")}</TableHead><TableHead>{t("client.src.description")}</TableHead><TableHead>{t("client.src.category")}</TableHead><TableHead>{t("client.src.type")}</TableHead><TableHead className="text-right">{t("client.src.amount")}</TableHead></TableRow></TableHeader>
                    <TableBody>
                        {loading ? <TableRow><TableCell colSpan={5} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : records.length === 0 ? <TableRow><TableCell colSpan={5} className="text-center py-12 text-muted-foreground">{t("client.src.no_records_found")}</TableCell></TableRow> : records.map(r => <TableRow key={r.id} className="hover:bg-muted/40 transition-colors">
                            <TableCell className="text-sm text-muted-foreground">{new Date(r.occurredAt).toLocaleDateString()}</TableCell>
                            <TableCell className="font-medium text-sm">{r.description || "—"}</TableCell>
                            <TableCell><Badge className="bg-secondary border-0 text-xs text-secondary-foreground">{r.category || 'General'}</Badge></TableCell>
                            <TableCell>
                                {r.type === "INCOME" ? <span className="text-xs flex items-center gap-1 text-green-600 font-medium"><TrendingUp className="w-3 h-3" />{t("client.src.income")}</span> : <span className="text-xs flex items-center gap-1 text-red-600 font-medium"><TrendingDown className="w-3 h-3" />{t("client.src.expense")}</span>}
                            </TableCell>
                            <TableCell className={`text-right font-semibold text-sm ${r.type === "INCOME" ? "text-green-600" : "text-red-600"}`}>
                                {r.type === "INCOME" ? "+" : ""}${Math.abs(r.amount).toLocaleString()}
                            </TableCell>
                            </TableRow>)}
                    </TableBody>
                </Table>
            </div>
        </div>

        <div className="space-y-6">
            <div className="p-6 bg-linear-to-br from-indigo-600 to-purple-700 rounded-2xl text-white shadow-xl shadow-indigo-200 overflow-hidden relative">
                <Brain className="absolute -bottom-4 -right-4 w-24 h-24 opacity-10" />
                <h3 className="text-lg font-black italic mb-4 flex items-center gap-2">
                    <Wand2 className="w-5 h-5 text-indigo-300" />{t("client.src.neural_roi_hub")}</h3>
                <div className="space-y-4">
                    <div className="p-3 bg-white/10 rounded-lg">
                        <div className="text-[10px] font-black tracking-widest opacity-70">{t("client.src.ai_video_multiplier")}</div>
                        <div className="text-2xl font-bold">{t("client.src.32x")}<span className="text-xs font-normal opacity-60">{t("client.src.listing_views")}</span></div>
                    </div>
                    <div className="p-3 bg-white/10 rounded-lg">
                        <div className="text-[10px] font-black tracking-widest opacity-70">{t("client.src.automated_translation")}</div>
                        <div className="text-2xl font-bold">14 <span className="text-xs font-normal opacity-60">{t("client.src.languages_active")}</span></div>
                    </div>
                    <div className="pt-2">
                         <div className="flex justify-between text-xs mb-1">
                             <span className="opacity-70 italic">{t("client.src.marketing_yield")}</span>
                             <span className="font-bold">+18.4%</span>
                         </div>
                         <div className="h-1 bg-white/20 rounded-full">
                             <div className="h-full bg-indigo-400 w-[78%] rounded-full" />
                         </div>
                    </div>
                </div>
            </div>

            <div className="p-6 bg-card border border-border rounded-2xl shadow-sm">
                <h4 className="text-sm font-bold mb-4 flex items-center gap-2">
                    <Video className="w-4 h-4 text-purple-500" />{t("client.src.recent_marketing_assets")}</h4>
                <div className="space-y-3">
                    <div className="flex items-center justify-between p-2 hover:bg-muted/50 rounded-lg transition-colors cursor-pointer">
                        <div className="flex items-center gap-3">
                            <div className="w-8 h-8 bg-purple-100 rounded flex items-center justify-center">
                                <Video className="w-4 h-4 text-purple-600" />
                            </div>
                            <div className="text-xs">
                                <div className="font-bold">{t("client.src.villa_azure_reel")}</div>
                                <div className="text-[10px] text-muted-foreground italic">{t("client.src.12k_views")}</div>
                            </div>
                        </div>
                        <Badge className="bg-emerald-500/10 text-emerald-600 border-0 text-[9px] font-bold">{t("client.src.420_roi")}</Badge>
                    </div>
                    <div className="flex items-center justify-between p-2 hover:bg-muted/50 rounded-lg transition-colors cursor-pointer">
                        <div className="flex items-center gap-3">
                            <div className="w-8 h-8 bg-blue-100 rounded flex items-center justify-center">
                                <Globe className="w-4 h-4 text-blue-600" />
                            </div>
                            <div className="text-xs">
                                <div className="font-bold">{t("client.src.multilang_subs")}</div>
                                <div className="text-[10px] text-muted-foreground italic">{t("client.src.tr_fr_de_ru")}</div>
                            </div>
                        </div>
                        <Badge className="bg-emerald-500/10 text-emerald-600 border-0 text-[9px] font-bold">{t("client.src.285_roi")}</Badge>
                    </div>
                </div>
                <Button variant="ghost" className="w-full mt-4 text-[10px] font-black tracking-widest text-slate-500">{t("client.src.view_all_assets")}</Button>
            </div>
        </div>
      </div>
    </PageShell>;
}

// ─── Tax Records ──────────────────────────────────────────────────────────────
export function TaxRecords() {
  const {
    t
  } = useTranslation();
  return <PageShell title={t("client.src.tax_records")} description={t("client.src.property_and_income_tax")} stats={[{
    label: t("client.src.total_tax"),
    value: "$8,400"
  }]}>
      <div className="bg-card border border-border rounded-xl p-8 text-center text-muted-foreground">{t("client.src.tax_records_are_being")}</div>
    </PageShell>;
}

// ─── Budgets ──────────────────────────────────────────────────────────────────
export function Budgets() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const { data: budgets = [], isLoading: loading, refetch: fetchBudgets } = useQuery<Budget[]>({
    queryKey: ['budgets'],
    queryFn: async () => {
      const response = await financialsApi.getBudgets();
      return Array.isArray(response) ? response : (response as any)?.data || [];
    }
  });
  return <PageShell title={t("client.src.budgets")} description={t("client.src.manage_and_track_budget")} stats={[{
    label: t("client.src.total_budgets"),
    value: budgets.length
  }, {
    label: t("client.src.total_allocated"),
    value: `$${budgets.reduce((s, b) => s + b.totalAmount, 0).toLocaleString()}`
  }]} actions={<Button variant="outline" size="sm" onClick={() => fetchBudgets()} disabled={loading}>
          <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("client.src.refresh")}</Button>}>
      {loading ? <div className="flex justify-center py-24"><Loader2 className="w-8 h-8 animate-spin" /></div> : budgets.length === 0 ? <div className="bg-card border border-border rounded-xl p-12 text-center text-muted-foreground">{t("client.src.no_budgets_found")}</div> : <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {budgets.map(b => {
        const pct = Math.min((b.spentAmount || 0) / b.totalAmount * 100, 100);
        const over = (b.spentAmount || 0) > b.totalAmount;
        return <div key={b.id} className="bg-card border border-border rounded-xl p-5 space-y-4 shadow-sm hover:shadow-md transition-shadow">
                <div className="flex justify-between items-start">
                  <div>
                    <p className="font-semibold text-sm">{b.notes || `Budget ${b.year}`}</p>
                    <p className="text-xs text-muted-foreground">{b.year} · {b.currency}</p>
                  </div>
                  {over && <Badge className="bg-red-100 text-red-700 border-0 text-xs">{t("client.src.over_budget")}</Badge>}
                </div>
                <div>
                  <div className="flex justify-between text-sm mb-2">
                    <span className="text-muted-foreground text-xs">{t("client.src.spent")}</span>
                    <span className="text-xs"><strong>${(b.spentAmount || 0).toLocaleString()}</strong> / ${b.totalAmount.toLocaleString()}</span>
                  </div>
                  <div className="h-2 bg-muted rounded-full overflow-hidden">
                    <div className={`h-full rounded-full transition-all ${over ? "bg-red-500" : pct > 80 ? "bg-orange-500" : "bg-primary"}`} style={{
                width: `${pct}%`
              }} />
                  </div>
                  <p className="text-[10px] text-muted-foreground mt-1">{pct.toFixed(0)}{t("client.src.utilized")}</p>
                </div>
              </div>;
      })}
        </div>}
    </PageShell>;
}

// ─── Payouts ──────────────────────────────────────────────────────────────────
export function Payouts() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const { data: payouts = [], isLoading: loading, refetch: fetchPayouts } = useQuery<Payout[]>({
    queryKey: ['payouts'],
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
  return <PageShell title={t("client.src.payouts")} description={t("client.src.commission_payments_vendor_payouts")} stats={[{
    label: t("client.src.total_payouts"),
    value: payouts.length
  }]} actions={<Button variant="outline" size="sm" onClick={() => fetchPayouts()} disabled={loading}>
          <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("client.src.refresh")}</Button>}>
      <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
        <Table>
          <TableHeader><TableRow><TableHead>{t("client.src.recipient")}</TableHead><TableHead>{t("client.src.method")}</TableHead><TableHead>{t("client.src.amount")}</TableHead><TableHead>{t("client.src.reference")}</TableHead><TableHead>{t("client.src.status")}</TableHead><TableHead className="w-10" /></TableRow></TableHeader>
          <TableBody>
            {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : payouts.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_payouts_found")}</TableCell></TableRow> : payouts.map((p: any) => <TableRow key={p.id} className="hover:bg-muted/40">
                  <TableCell className="font-medium text-sm">{p.recipientId}</TableCell>
                  <TableCell><Badge className="bg-secondary border-0 text-xs text-secondary-foreground">{p.method || 'Transfer'}</Badge></TableCell>
                  <TableCell className="font-semibold text-sm">${p.amount.toLocaleString()}</TableCell>
                  <TableCell className="font-mono text-[10px] text-muted-foreground">{p.reference || 'N/A'}</TableCell>
                  <TableCell><Badge className={`${statusCls[p.status as string] || 'bg-gray-100'} border-0 text-xs font-normal`}>{p.status}</Badge></TableCell>
                  <TableCell><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></TableCell>
                </TableRow>)}
          </TableBody>
        </Table>
      </div>
    </PageShell>;
}