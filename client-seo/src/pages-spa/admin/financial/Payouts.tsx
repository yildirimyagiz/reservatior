"use client";

import { t } from"i18next";
import { useState, useEffect, FormEvent } from"react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { useToast } from"@/hooks/use-toast";
import { financialsApi, type Payout } from"@/lib/api/financials";
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw, CreditCard, Activity, DollarSign, Wallet, Zap, Clock, Shield, Search, Plus } from"lucide-react";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { useTranslation } from"react-i18next";
import { tEnum } from"@/lib/admin-enums";
import { cn } from"@/lib/utils";
import { m, AnimatePresence } from"framer-motion";
import { Card, CardContent } from"@/components/ui/card";
const STATUS_CONFIG = (t: any) => {
 return {
 PAID: {
 label: t("paid"),
 cls:"bg-blue-500/10 text-success border-blue-500/20"
 },
 PENDING: {
 label: t("financialPayoutsStatusPending"),
 cls:"bg-yellow-500/10 text-yellow-400 border-yellow-500/20"
 },
 SCHEDULED: {
 label: t("financialPayoutsStatusScheduled"),
 cls:"bg-muted0/10 text-muted-foreground border-slate-500/20"
 },
 FAILED: {
 label: t("failed"),
 cls:"bg-red-500/10 text-red-400 border-red-500/20"
 }
 };
};
const EMPTY_FORM = {
 orgId:"",
 amount:"",
 currency:"USD",
 scheduledAt:"",
 status:"PENDING"
};
export default function Payouts() {
 const {
 t
 } = useTranslation();
 const {
 toast
 } = useToast();
 const statusConfig = STATUS_CONFIG(t);
 const [search, setSearch] = useState("");
 const [createOpen, setCreateOpen] = useState(false);
 const [editOpen, setEditOpen] = useState(false);
 const [form, setForm] = useState<any>(EMPTY_FORM);
 const queryClient = useQueryClient();

 const { data: payoutsData, isLoading: loading, refetch: fetchPayouts } = useQuery({
 queryKey: ['financialPayouts'],
 queryFn: async () => {
 const response = (await financialsApi.getPayouts()) as any;
 return Array.isArray(response) ? response : response?.data || [];
 }
 });

 const payouts: Payout[] = payoutsData || [];
 const filtered = payouts.filter(row => (row.status || '').toLowerCase().includes(search.toLowerCase()) || (row.id || '').toLowerCase().includes(search.toLowerCase()));
 const createMutation = useMutation({
 mutationFn: (data: any) => financialsApi.createPayout(data),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['financialPayouts'] });
 setCreateOpen(false);
 toast({ title: t("admin_financial_payout_created") });
 },
 onError: () => {
 toast({
 title: t("admin_financial_error"),
 description: t("admin_financial_failed_to_create_payout"),
 variant:"destructive"
 });
 }
 });

 const updateMutation = useMutation({
 mutationFn: ({ id, data }: { id: string, data: any }) => financialsApi.updatePayout(id, data),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['financialPayouts'] });
 setEditOpen(false);
 toast({ title: t("admin_financial_payout_updated") });
 },
 onError: () => {
 toast({
 title: t("admin_financial_error"),
 description: t("admin_financial_failed_to_update_payout"),
 variant:"destructive"
 });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: (id: string) => financialsApi.deletePayout(id),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['financialPayouts'] });
 toast({ title: t("admin_financial_payout_deleted") });
 },
 onError: () => {
 toast({
 title: t("admin_financial_error"),
 description: t("admin_financial_failed_to_delete_payout"),
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
 if (!form.id) return;
 updateMutation.mutate({
 id: form.id,
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
 const openEdit = (row: Payout) => {
 setForm({
 id: row.id,
 orgId: row.orgId,
 amount: row.amount.toString(),
 currency: row.currency,
 scheduledAt: row.scheduledAt ? new Date(row.scheduledAt).toISOString().split('T')[0] :"",
 status: row.status
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
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-1.5"><Label>{t("admin_financial_amount")}</Label><Input type="number" value={form.amount} onChange={e => setForm({
 ...form,
 amount: e.target.value
 })} required /></div>
 <div className="space-y-1.5">
 <Label>{t("admin_financial_currency")}</Label>
 <Input type="text" value={form.currency} onChange={e => setForm({
 ...form,
 currency: e.target.value
 })} />
 </div>
 </div>
 <div className="space-y-1.5"><Label>{t("admin_financial_scheduled_date")}</Label><Input type="date" value={form.scheduledAt} onChange={e => setForm({
 ...form,
 scheduledAt: e.target.value
 })} /></div>
 <div className="space-y-1.5">
 <Label>{t("admin_financial_status")}</Label>
 <Select value={form.status} onValueChange={v => setForm({
 ...form,
 status: v as any
 })}>
 <SelectTrigger><SelectValue /></SelectTrigger>
 <SelectContent>
 <SelectItem value="SCHEDULED">{t("admin_financial_scheduled")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_financial_pending")}</SelectItem>
 <SelectItem value="PAID">{t("admin_financial_paid")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_financial_failed")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
 </form>;
 };
 return <>
 <PageShell title={t("financialPayoutsTitle")} description={t("financialPayoutsDesc")}>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-10 pb-20">
 {/* KPI Neural Grid */}
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 px-4">
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-muted-foreground">
 <Zap className="w-10 h-10" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("total")}</p>
 <h3 className="text-3xl font-bold text-foreground leading-none">{payouts.length}</h3>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-success">
 <Wallet className="w-10 h-10" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("financialPayoutsCompleted")}</p>
 <h3 className="text-3xl font-bold text-success leading-none">{payouts.filter(r => r.status === 'PAID').length}</h3>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
 <Clock className="w-10 h-10" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("financialPayoutsPending")}</p>
 <h3 className="text-3xl font-bold text-warning leading-none">{payouts.filter(r => r.status === 'PENDING').length}</h3>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-muted-foreground">
 <DollarSign className="w-10 h-10" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("financialPayoutsTotalpaid")}</p>
 <h3 className="text-3xl font-bold text-muted-foreground leading-none">{t("currency_symbol", "$")}{payouts.filter(r => r.status === 'PAID').reduce((s, r) => s + (r.amount || 0), 0).toLocaleString()}</h3>
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
 <Button variant="outline" onClick={() => fetchPayouts()} disabled={loading} className="h-14 px-8 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground hover:bg-muted/50 gap-2 font-bold text-[10px]">
 <RefreshCw className={cn("h-4 w-4", loading &&"animate-spin")} /> {t("commonLoading")}
 </Button>
 <Button onClick={() => {
 setForm(EMPTY_FORM);
 setCreateOpen(true);
 }} className="bg-muted hover:bg-muted0 text-foreground h-14 px-8 rounded-2xl font-bold text-[10px] gap-3 shadow-xl shadow-slate-600/20">
 <Plus className="w-4 h-4" />
 {t("financialInitnode")}
 </Button>
 </div>
 </div>

 <div className="bg-card border border-border rounded-4xl overflow-hidden shadow-2xl backdrop-blur-xl border-l border-t mx-4">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("id")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("financialPayoutsAmount")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("currency")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("financialPayoutsScheduled")}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin_financial_payouts_table_status")}</TableHead>
 <TableHead className="w-10" />
 </TableRow>
 </TableHeader>
 <TableBody>
 {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground font-bold text-[10px]">{t("admin_financial_no_active_signals_found")}</TableCell></TableRow> : filtered.map(row => <TableRow key={row.id} className="border-border hover:bg-muted/50 transition-all group">
 <TableCell className="px-8 text-xs font-mono text-muted-foreground group-hover:text-foreground transition-colors">{row.id.slice(0, 12)}</TableCell>
 <TableCell className="px-8 text-sm font-bold text-foreground">{t("currency_symbol", "$")}{row.amount.toLocaleString()}</TableCell>
 <TableCell className="px-8 text-sm font-bold text-muted-foreground">{row.currency}</TableCell>
 <TableCell className="px-8 text-sm text-muted-foreground font-bold">{row.scheduledAt ? new Date(row.scheduledAt).toLocaleDateString() :"—"}</TableCell>
 <TableCell className="px-8">
 <Badge className={cn("text-[9px] font-bold px-4 py-1.5 rounded-full border-none shadow-lg", (statusConfig as any)[row.status]?.cls ||"bg-muted text-muted-foreground")}>
  {(statusConfig as any)[row.status]?.label || tEnum(t, row.status)}
 </Badge>
 </TableCell>
 <TableCell className="px-8">
 <DropdownMenu>
 <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8 text-muted-foreground hover:text-foreground"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-card border-border rounded-2xl">
 <DropdownMenuItem onClick={() => window.location.href = `/checkout?type=PAYOUT&amount=${row.amount}&id=${row.id}`} className="font-bold text-[10px]">
 <CreditCard className="w-4 h-4 mr-2 text-muted-foreground" />{t("admin_financial_pay_with_stripe")}</DropdownMenuItem>
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
 <DialogHeader><DialogTitle>{t("admin_financial_add_payout")}</DialogTitle></DialogHeader>
 <EntityForm onSubmit={handleCreate} label={t("admin_financial_create")} />
 </DialogContent>
 </Dialog>
 <Dialog open={editOpen} onOpenChange={setEditOpen}>
 <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
 <DialogHeader><DialogTitle>{t("admin_financial_edit_payout")}</DialogTitle></DialogHeader>
 <EntityForm onSubmit={handleEdit} label={t("admin_financial_save_changes")} isEdit={true} />
 </DialogContent>
 </Dialog>
 </>;
}