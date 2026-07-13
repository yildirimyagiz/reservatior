"use client";

import { t } from"i18next";
import { useState, useEffect, FormEvent } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Textarea } from"@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { useToast } from"@/hooks/use-toast";
import { financialsApi, type Expense, type ExpenseCategory } from"@/lib/api/financials";
import { propertiesApi, type Property } from"@/lib/api/properties";
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw, Search, Plus, Activity, DollarSign, Wallet, Zap, Shield, Receipt } from"lucide-react";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { useTranslation } from"react-i18next";
import { cn } from"@/lib/utils";
import { Card, CardContent } from"@/components/ui/card";
const CATEGORIES: ExpenseCategory[] = ["MAINTENANCE","INSURANCE","UTILITIES","TAX","RENOVATION","OTHER","COMMISSION","MANAGEMENT_FEE","CLEANING","REPAIR","MARKETING"];
const EMPTY_FORM = {
 orgId:"default",
 propertyId:"",
 category:"MAINTENANCE" as ExpenseCategory,
 amount:"",
 currency:"USD",
 date: new Date().toISOString().split('T')[0],
 description:""
};
export default function Expenses() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const [search, setSearch] = useState("");
 const [createOpen, setCreateOpen] = useState(false);
 const [editOpen, setEditOpen] = useState(false);
 const [currentId, setCurrentId] = useState<string | null>(null);
 const [form, setForm] = useState<any>(EMPTY_FORM);
 const queryClient = useQueryClient();

 const { data: expensesData, isLoading: loadingExpenses, refetch: refetchExpenses } = useQuery({
 queryKey: ['financialExpenses'],
 queryFn: async () => {
 const res = await financialsApi.getExpenses();
 return res.data || [];
 }
 });

 const { data: propertiesData, isLoading: loadingProperties, refetch: refetchProperties } = useQuery({
 queryKey: ['properties'],
 queryFn: async () => {
 const res = await propertiesApi.getAll();
 return res || [];
 }
 });

 const expenses = expensesData || [];
 const properties = propertiesData || [];
 const loading = loadingExpenses || loadingProperties;

 const fetchData = () => {
 refetchExpenses();
 refetchProperties();
 };
 const filtered = expenses.filter(row => {
 const propName = properties.find(p => p.id === row.propertyId)?.name ||"";
 return row.category.toLowerCase().includes(search.toLowerCase()) || (row.description ||"").toLowerCase().includes(search.toLowerCase()) || propName.toLowerCase().includes(search.toLowerCase());
 });
 const createMutation = useMutation({
 mutationFn: (data: any) => financialsApi.createExpense(data),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['financialExpenses'] });
 setCreateOpen(false);
 toast({ title: t("admin_financial_expense_recorded") });
 },
 onError: () => {
 toast({
 title: t("admin_financial_error"),
 description: t("admin_financial_failed_to_save_expense"),
 variant:"destructive"
 });
 }
 });

 const updateMutation = useMutation({
 mutationFn: ({ id, data }: { id: string, data: any }) => financialsApi.updateExpense(id, data),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['financialExpenses'] });
 setEditOpen(false);
 toast({ title: t("admin_financial_expense_updated") });
 },
 onError: () => {
 toast({
 title: t("admin_financial_error"),
 description: t("admin_financial_failed_to_update_expense"),
 variant:"destructive"
 });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: (id: string) => financialsApi.deleteExpense(id),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['financialExpenses'] });
 toast({ title: t("admin_financial_expense_deleted") });
 },
 onError: () => {
 toast({
 title: t("admin_financial_error"),
 description: t("admin_financial_failed_to_delete_expense"),
 variant:"destructive"
 });
 }
 });

 const handleCreate = (e: FormEvent) => {
 e.preventDefault();
 createMutation.mutate({
 ...form,
 amount: parseFloat(form.amount)
 });
 };
 const handleEdit = (e: FormEvent) => {
 e.preventDefault();
 if (!currentId) return;
 updateMutation.mutate({
 id: currentId,
 data: {
 ...form,
 amount: parseFloat(form.amount)
 }
 });
 };
 const handleDelete = (id: string) => {
 if (!confirm(t("admin_financial_are_you_sure","Emin misiniz?"))) return;
 deleteMutation.mutate(id);
 };
 const openEdit = (row: Expense) => {
 setCurrentId(row.id);
 setForm({
 orgId: row.orgId,
 propertyId: row.propertyId ||"",
 category: row.category,
 amount: row.amount.toString(),
 currency: row.currency,
 date: new Date(row.date).toISOString().split('T')[0],
 description: row.description ||""
 });
 setEditOpen(true);
 };
 const EntityForm = ({
 onSubmit,
 label,
 isEdit = false
 }: {
 onSubmit: (e: FormEvent) => void;
 label: string;
 isEdit?: boolean;
 }) => {
 const {
 t
 } = useTranslation();
 return <form onSubmit={onSubmit} className="space-y-4 py-2">
 {!isEdit && <div className="space-y-1.5"><Label>{t("admin_financial_org_id")}</Label><Input value={form.orgId} onChange={e => setForm({
 ...form,
 orgId: e.target.value
 })} required /></div>}
 <div className="space-y-1.5">
 <Label>{t("admin_financial_property")}</Label>
 <Select value={form.propertyId} onValueChange={v => setForm({
 ...form,
 propertyId: v
 })}>
 <SelectTrigger><SelectValue placeholder={t("admin_financial_select_property")} /></SelectTrigger>
 <SelectContent>
 {properties.map(p => <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-1.5">
 <Label>{t("admin_financial_category")}</Label>
 <Select value={form.category} onValueChange={v => setForm({
 ...form,
 category: v as ExpenseCategory
 })}>
 <SelectTrigger><SelectValue /></SelectTrigger>
 <SelectContent>
 {CATEGORIES.map(c => <SelectItem key={c} value={c}>{c}</SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-1.5"><Label>{t("admin_financial_amount")}</Label><Input type="number" step="0.01" value={form.amount} onChange={e => setForm({
 ...form,
 amount: e.target.value
 })} required /></div>
 <div className="space-y-1.5">
 <Label>{t("admin_financial_currency")}</Label>
 <Select value={form.currency} onValueChange={v => setForm({
 ...form,
 currency: v
 })}>
 <SelectTrigger><SelectValue /></SelectTrigger>
 <SelectContent><SelectItem value="USD">{t("admin_financial_usd")}</SelectItem><SelectItem value="EUR">{t("admin_financial_eur")}</SelectItem></SelectContent>
 </Select>
 </div>
 </div>
 <div className="space-y-1.5"><Label>{t("admin_financial_date")}</Label><Input type="date" value={form.date} onChange={e => setForm({
 ...form,
 date: e.target.value
 })} required /></div>
 <div className="space-y-1.5"><Label>{t("admin_financial_description")}</Label><Textarea value={form.description} onChange={e => setForm({
 ...form,
 description: e.target.value
 })} rows={3} /></div>
 <DialogFooter><Button type="submit" disabled={loading}>{label}</Button></DialogFooter>
 </form>;
 };
 return <>
 <PageShell title={t("financialExpensesTitle")} description={t("financialExpensesDesc")}>
 <div className="space-y-10 pb-20">
 {/* KPI Neural Grid */}
 <div className="grid grid-cols-1 md:grid-cols-2 gap-6 px-4">
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-muted-foreground">
 <Zap className="w-10 h-10" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("total")}</p>
 <h3 className="text-3xl font-bold text-foreground leading-none">{expenses.length}</h3>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-red-500">
 <Receipt className="w-10 h-10" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("totalSpent")}</p>
 <h3 className="text-3xl font-bold text-red-400 leading-none">${expenses.reduce((s, r) => s + r.amount, 0).toLocaleString()}</h3>
 </CardContent>
 </Card>
 </div>

 {/* Tactical Search & Actions Interface */}
 <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
 <div className="flex flex-wrap items-center gap-3 flex-1">
 <div className="relative group min-w-[320px]">
 <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-orange-500 transition-colors" />
 <Input placeholder={t("commonSearch")} value={search} onChange={e => setSearch(e.target.value)} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-orange-500/20 focus:border-orange-500/40 transition-all font-medium border-l border-t shadow-2xl" />
 </div>
 </div>
 <div className="flex items-center gap-4">
 <Button variant="outline" onClick={fetchData} disabled={loading} className="h-14 px-8 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground hover:bg-muted/50 gap-2 font-bold text-[10px]">
 <RefreshCw className={cn("h-4 w-4", loading &&"animate-spin")} /> {t("commonLoading")}
 </Button>
 <Button onClick={() => {
 setForm(EMPTY_FORM);
 setCreateOpen(true);
 }} className="bg-slate-600 hover:bg-muted0 text-foreground h-14 px-8 rounded-2xl font-bold text-[10px] gap-3 shadow-xl shadow-slate-600/20">
 <Plus className="w-4 h-4" />
 {t("financialInitnode")}
 </Button>
 </div>
 </div>

 <div className="bg-card border border-border rounded-4xl overflow-hidden shadow-2xl backdrop-blur-xl border-l border-t mx-4">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("financialExpensesCategory")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("financialExpensesProperty")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("financialExpensesAmount")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("financialExpensesDate")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("financialExpensesDesc")}</TableHead>
 <TableHead className="w-10" />
 </TableRow>
 </TableHeader>
 <TableBody>
 {loading && expenses.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground font-bold text-[10px]">{t("admin_financial_no_active_drain_signals")}</TableCell></TableRow> : filtered.map(row => <TableRow key={row.id} className="border-border hover:bg-muted/50 transition-all group">
 <TableCell className="px-8">
 <Badge className="bg-muted text-muted-foreground text-[9px] font-bold px-4 py-1.5 rounded-full border-none shadow-lg">
 {t(`admin.financial.expenses.categories.${row.category}`)}
 </Badge>
 </TableCell>
 <TableCell className="px-8 text-sm font-bold text-muted-foreground">
 {properties.find(p => p.id === row.propertyId)?.name || '—'}
 </TableCell>
 <TableCell className="px-8 text-sm font-bold text-red-400">
 -${row.amount.toLocaleString()}
 </TableCell>
 <TableCell className="px-8 text-sm text-muted-foreground font-bold">
 {new Date(row.date).toLocaleDateString()}
 </TableCell>
 <TableCell className="px-8 text-xs text-muted-foreground font-medium max-w-xs truncate group-hover:text-foreground transition-colors">
 {row.description ||"—"}
 </TableCell>
 <TableCell className="px-8">
 <DropdownMenu>
 <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8 text-muted-foreground hover:text-foreground"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-card border-border rounded-2xl">
 <DropdownMenuItem onClick={() => openEdit(row)} className="font-bold text-[10px]"><Edit className="w-4 h-4 mr-2" />{t("admin_financial_edit")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-red-400 font-bold text-[10px]"><Trash2 className="w-4 h-4 mr-2" />{t("admin_financial_delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </div>
 </div>
 </PageShell>

 <Dialog open={createOpen} onOpenChange={setCreateOpen}>
 <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
 <DialogHeader><DialogTitle>{t("admin_financial_add_expense")}</DialogTitle></DialogHeader>
 <EntityForm onSubmit={handleCreate} label={t("admin_financial_create")} />
 </DialogContent>
 </Dialog>
 <Dialog open={editOpen} onOpenChange={setEditOpen}>
 <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
 <DialogHeader><DialogTitle>{t("admin_financial_edit_expense")}</DialogTitle></DialogHeader>
 <EntityForm onSubmit={handleEdit} label={t("admin_financial_save_changes")} isEdit={true} />
 </DialogContent>
 </Dialog>
 </>;
}