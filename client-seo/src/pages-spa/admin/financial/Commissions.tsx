"use client";

import React from 'react';
import { useTranslation } from"react-i18next";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { DollarSign, TrendingUp, ShieldCheck, Plus, Edit, Trash2, Loader2 } from"lucide-react";
import { useState } from"react";
import { cn } from"@/lib/utils";

interface Commission {
 id: string;
 orgId: string;
 agentId?: string;
 agencyId?: string;
 transactionId?: string;
 reservationId?: string;
 commissionAmount: number;
 commissionRate: number;
 amountBase: number;
 currency: string;
 status: string;
 createdAt: string;
}

const statusConfig: Record<string, { label: string; class: string }> = {
 PENDING: { label:"Pending", class:"bg-amber-500/20 text-warning" },
 APPROVED: { label:"Approved", class:"bg-muted0/20 text-muted-foreground" },
 PAID: { label:"Paid", class:"bg-blue-500/20 text-success" },
 CANCELLED: { label:"Cancelled", class:"bg-muted0/20 text-muted-foreground" },
 OVERDUE: { label:"Overdue", class:"bg-red-500/20 text-red-400" },
 DISPUTED: { label:"Disputed", class:"bg-muted0/20 text-muted-foreground" },
};

export default function Commissions() {
 const { t } = useTranslation();
 const queryClient = useQueryClient();
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [editingCommission, setEditingCommission] = useState<Commission | null>(null);
 const [formData, setFormData] = useState({ agentId:"", amountBase: 0, commissionRate: 0, currency:"USD", status:"PENDING" });

 const { data: commissionsData, isLoading } = useQuery({
 queryKey: ['commissions'],
 queryFn: async () => {
 const res: any = await apiClient.get('/commission');
 return (res?.data || []) as Commission[];
 },
 });

 const commissions = (commissionsData || []) as Commission[];

 const createMutation = useMutation({
 mutationFn: async (data: typeof formData) => {
 return apiClient.post('/commission', {
 commissionAmount: data.amountBase * (data.commissionRate / 100),
 commissionRate: data.commissionRate,
 amountBase: data.amountBase,
 currency: data.currency,
 status: data.status,
 orgId:"org_1",
 });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['commissions'] });
 setIsAddOpen(false);
 setFormData({ agentId:"", amountBase: 0, commissionRate: 0, currency:"USD", status:"PENDING" });
 },
 });

 const updateMutation = useMutation({
 mutationFn: async ({ id, data }: { id: string; data: any }) => {
 return apiClient.patch(`/commission/${id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['commissions'] });
 setEditingCommission(null);
 },
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/commission/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['commissions'] });
 },
 });

 const handleSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 if (editingCommission) {
 updateMutation.mutate({ id: editingCommission.id, data: { status: formData.status } });
 } else {
 createMutation.mutate(formData);
 }
 };

 const openEdit = (c: Commission) => {
 setEditingCommission(c);
 setFormData({ agentId: c.agentId ||"", amountBase: c.amountBase, commissionRate: c.commissionRate, currency: c.currency, status: c.status });
 };

 const totalPaid = commissions.filter(c => c.status ==="PAID").reduce((s, c) => s + c.commissionAmount, 0);
 const totalPending = commissions.filter(c => c.status ==="PENDING").reduce((s, c) => s + c.commissionAmount, 0);

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
 <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center gap-4">
 <div className="p-3 bg-muted rounded-xl shadow-lg shadow-slate-600/20">
 <DollarSign className="w-8 h-8 text-foreground" />
 </div>
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">
 {t("admin_financial_commission_management", "Komisyon Yönetimi")}
 </h1>
 <p className="text-muted-foreground">
 {t("admin_financial_define_and_track_commission", "Komisyon kurallarını tanımlayın ve izleyin")}
 </p>
 </div>
 </div>
 <Dialog open={isAddOpen || !!editingCommission} onOpenChange={(open) => { if (!open) { setIsAddOpen(false); setEditingCommission(null); } }}>
 <DialogTrigger asChild>
 <Button className="bg-muted hover:bg-muted text-foreground shadow-lg shadow-slate-500/20" onClick={() => { setIsAddOpen(true); setFormData({ agentId:"", amountBase: 0, commissionRate: 0, currency:"USD", status:"PENDING" }); }}>
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_financial_new_commission", "Yeni Komisyon")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>
 {editingCommission ? t("admin_financial_edit_commission", "Komisyonu Düzenle") : t("admin_financial_new_commission", "Yeni Komisyon")}
 </DialogTitle>
 <DialogDescription className="text-muted-foreground">
 {editingCommission ? t("admin_financial_edit_commission_desc", "Komisyon durumunu güncelle") : t("admin_financial_new_commission_desc", "Komisyon ayrıntılarını girin")}
 </DialogDescription>
 </DialogHeader>
 <form onSubmit={handleSubmit} className="space-y-4 pt-4">
 {!editingCommission && (
 <>
 <div className="space-y-2">
 <Label htmlFor="agentId">{t("admin_financial_agent_id", "Temsilci Kimliği")}</Label>
 <Input id="agentId" className="bg-card border-border text-foreground" value={formData.agentId} onChange={e => setFormData({ ...formData, agentId: e.target.value })} />
 </div>
 <div className="space-y-2">
 <Label htmlFor="amountBase">{t("admin_financial_base_amount", "Baz Tutar")}</Label>
 <Input id="amountBase" type="number" className="bg-card border-border text-foreground" value={formData.amountBase} onChange={e => setFormData({ ...formData, amountBase: Number(e.target.value) })} required />
 </div>
 <div className="space-y-2">
 <Label htmlFor="commissionRate">{t("admin_financial_commission_rate", "Oran (%)")}</Label>
 <Input id="commissionRate" type="number" className="bg-card border-border text-foreground" value={formData.commissionRate} onChange={e => setFormData({ ...formData, commissionRate: Number(e.target.value) })} required />
 </div>
 </>
 )}
 <div className="space-y-2">
 <Label htmlFor="status">{t("admin_financial_status", "Durum")}</Label>
 <Select value={formData.status} onValueChange={(v: string) => setFormData({ ...formData, status: v })}>
 <SelectTrigger className="bg-card border-border text-foreground"><SelectValue /></SelectTrigger>
 <SelectContent className="bg-background border-border text-foreground">
 {Object.keys(statusConfig).map(s => (
 <SelectItem key={s} value={s}>{s}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <DialogFooter>
 <Button type="button" variant="ghost" onClick={() => { setIsAddOpen(false); setEditingCommission(null); }} className="text-muted-foreground">{t("common.cancel", "İptal")}</Button>
 <Button type="submit" className="bg-muted hover:bg-muted" disabled={createMutation.isPending || updateMutation.isPending}>
 {(createMutation.isPending || updateMutation.isPending) ? t("common.saving", "Kaydediliyor") : (editingCommission ? t("common.update", "Güncelle") : t("common.create", "Oluştur"))}
 </Button>
 </DialogFooter>
 </form>
 </DialogContent>
 </Dialog>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_total_commissions", "Toplam Komisyonlar")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{commissions.length}</h3>
 </div>
 <div className="p-3 bg-muted0/20 rounded-lg"><DollarSign className="w-5 h-5 text-muted-foreground" /></div>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_total_paid", "Toplam Ödenen")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{t("currency_symbol", "$")}{totalPaid.toLocaleString()}</h3>
 </div>
 <div className="p-3 bg-blue-500/20 rounded-lg"><TrendingUp className="w-5 h-5 text-success" /></div>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_pending_amount", "Askıda olması")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{t("currency_symbol", "$")}{totalPending.toLocaleString()}</h3>
 </div>
 <div className="p-3 bg-amber-500/20 rounded-lg"><ShieldCheck className="w-5 h-5 text-warning" /></div>
 </div>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border overflow-hidden">
 <CardContent className="p-0">
 <Table>
 <TableHeader className="bg-card border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_financial_id", "İD")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_amount", "Tutar")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_rate", "Oran")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_base", "Temel")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_status", "Durum")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_created", "Oluşturuldu")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_actions", "Aksiyonlar")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {isLoading ? (
 <TableRow><TableCell colSpan={7} className="text-center py-8 text-muted-foreground"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow>
 ) : commissions.length === 0 ? (
 <TableRow><TableCell colSpan={7} className="text-center py-8 text-muted-foreground">{t("admin_financial_no_commissions", "Komisyon bulunamadı")}</TableCell></TableRow>
 ) : commissions.map(c => {
 const cfg = statusConfig[c.status] || statusConfig.PENDING;
 return (
 <TableRow key={c.id} className="border-b border-border hover:bg-card transition-colors">
 <TableCell className="py-4 px-6 font-mono text-xs text-muted-foreground">{c.id.slice(0, 8)}...</TableCell>
 <TableCell className="px-6 font-bold text-foreground">{t("currency_symbol", "$")}{c.commissionAmount.toLocaleString()}</TableCell>
 <TableCell className="px-6 text-sm text-muted-foreground">{c.commissionRate}%</TableCell>
 <TableCell className="px-6 text-sm text-muted-foreground">{t("currency_symbol", "$")}{c.amountBase.toLocaleString()}</TableCell>
 <TableCell className="px-6">
 <Badge className={cn("border-0", cfg.class)}>{cfg.label}</Badge>
 </TableCell>
 <TableCell className="px-6 text-xs text-muted-foreground font-mono">{new Date(c.createdAt).toLocaleDateString()}</TableCell>
 <TableCell className="px-6">
 <div className="flex gap-2">
 <Button size="sm" variant="ghost" className="text-muted-foreground hover:text-foreground" onClick={() => openEdit(c)} aria-label={t("common.edit")}>
 <Edit className="w-3 h-3" />
 </Button>
 <Button size="sm" variant="ghost" className="text-red-400 hover:text-red-300" onClick={() => deleteMutation.mutate(c.id)} aria-label={t("common.delete")}>
 <Trash2 className="w-3 h-3" />
 </Button>
 </div>
 </TableCell>
 </TableRow>
 );
 })}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </div>
 );
}
