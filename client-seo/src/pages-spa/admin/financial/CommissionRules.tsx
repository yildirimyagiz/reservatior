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
import { Percent, DollarSign, TrendingUp, ShieldCheck, Plus, Edit, Trash2, Loader2 } from"lucide-react";
import { useState } from"react";
import { cn } from"@/lib/utils";

interface CommissionRule {
 id: string;
 providerId: string;
 ruleType:"PERCENTAGE" |"FLAT" |"TIERED";
 commission: number;
 minVolume?: number;
 maxVolume?: number;
 conditions?: any;
 createdAt: string;
}

export default function CommissionRules() {
 const { t } = useTranslation();
 const queryClient = useQueryClient();
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [editingRule, setEditingRule] = useState<CommissionRule | null>(null);
 const [formData, setFormData] = useState({ providerId:"", ruleType:"PERCENTAGE" as CommissionRule["ruleType"], commission: 0, minVolume: 0 });

 const { data: rulesData, isLoading } = useQuery({
 queryKey: ['commission-rules'],
 queryFn: async () => {
 const res: any = await apiClient.get('/financials/commission-rules');
 return (res?.data || []) as CommissionRule[];
 },
 });

 const rules = (rulesData || []) as CommissionRule[];

 const createMutation = useMutation({
 mutationFn: async (data: typeof formData) => {
 return apiClient.post('/financials/commission-rules', data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['commission-rules'] });
 setIsAddOpen(false);
 setFormData({ providerId:"", ruleType:"PERCENTAGE", commission: 0, minVolume: 0 });
 },
 });

 const updateMutation = useMutation({
 mutationFn: async ({ id, data }: { id: string; data: Partial<CommissionRule> }) => {
 return apiClient.patch(`/financials/commission-rules/${id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['commission-rules'] });
 setEditingRule(null);
 },
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/financials/commission-rules/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['commission-rules'] });
 },
 });

 const handleSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 if (editingRule) {
 updateMutation.mutate({ id: editingRule.id, data: formData });
 } else {
 createMutation.mutate(formData);
 }
 };

 const openEdit = (rule: CommissionRule) => {
 setEditingRule(rule);
 setFormData({
 providerId: rule.providerId,
 ruleType: rule.ruleType,
 commission: rule.commission,
 minVolume: rule.minVolume || 0,
 });
 };

 const avgCommission = rules.length > 0
 ? (rules.reduce((s, r) => s + r.commission, 0) / rules.length).toFixed(1)
 :"0";

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
 <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center gap-4">
 <div className="p-3 bg-muted rounded-xl shadow-lg shadow-slate-600/20">
 <Percent className="w-8 h-8 text-foreground" />
 </div>
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">
 {t("admin_financial_commission_rules", "Komisyon Kuralları")}
 </h1>
 <p className="text-muted-foreground">
 {t("admin_financial_define_and_track_commission", "Komisyon kurallarını tanımlayın ve izleyin")}
 </p>
 </div>
 </div>
 <Dialog open={isAddOpen || !!editingRule} onOpenChange={(open) => { if (!open) { setIsAddOpen(false); setEditingRule(null); } }}>
 <DialogTrigger asChild>
 <Button className="bg-muted hover:bg-muted text-foreground shadow-lg shadow-slate-500/20" onClick={() => { setIsAddOpen(true); setFormData({ providerId:"", ruleType:"PERCENTAGE", commission: 0, minVolume: 0 }); }}>
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_financial_new_rule", "Yeni Kural")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>
 {editingRule ? t("admin_financial_edit_rule", "Kuralı Düzenle") : t("admin_financial_new_rule", "Yeni Kural")}
 </DialogTitle>
 <DialogDescription className="text-muted-foreground">
 {editingRule ? t("admin_financial_edit_rule_desc", "Komisyon kuralı ayrıntılarını güncelleyin") : t("admin_financial_new_rule_desc", "Yeni kuralın ayrıntılarını girin")}
 </DialogDescription>
 </DialogHeader>
 <form onSubmit={handleSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="providerId">{t("admin_financial_provider", "sağlayıcı")}</Label>
 <Input id="providerId" className="bg-card border-border text-foreground" value={formData.providerId} onChange={e => setFormData({ ...formData, providerId: e.target.value })} required />
 </div>
 <div className="space-y-2">
 <Label htmlFor="ruleType">{t("admin_financial_rule_type", "Kural Tipi")}</Label>
 <Select value={formData.ruleType} onValueChange={(v: CommissionRule["ruleType"]) => setFormData({ ...formData, ruleType: v })}>
 <SelectTrigger className="bg-card border-border text-foreground"><SelectValue /></SelectTrigger>
 <SelectContent className="bg-background border-border text-foreground">
 <SelectItem value="PERCENTAGE">{t("admin_financial_percentage", "Yüzdelik")}</SelectItem>
 <SelectItem value="FLAT">{t("admin_financial_flat", "Düz")}</SelectItem>
 <SelectItem value="TIERED">{t("admin_financial_tiered", "katmanlı")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label htmlFor="commission">{t("admin_financial_commission", "Komisyon")}</Label>
 <Input id="commission" type="number" className="bg-card border-border text-foreground" value={formData.commission} onChange={e => setFormData({ ...formData, commission: Number(e.target.value) })} required />
 </div>
 <div className="space-y-2">
 <Label htmlFor="minVolume">{t("admin_financial_min_volume", "Min. Hacim")}</Label>
 <Input id="minVolume" type="number" className="bg-card border-border text-foreground" value={formData.minVolume} onChange={e => setFormData({ ...formData, minVolume: Number(e.target.value) })} />
 </div>
 <DialogFooter>
 <Button type="button" variant="ghost" onClick={() => { setIsAddOpen(false); setEditingRule(null); }} className="text-muted-foreground">{t("common.cancel", "İptal")}</Button>
 <Button type="submit" className="bg-muted hover:bg-muted" disabled={createMutation.isPending || updateMutation.isPending}>
 {(createMutation.isPending || updateMutation.isPending) ? t("common.saving", "Kaydediliyor") : (editingRule ? t("common.update", "Güncelle") : t("common.create", "Oluştur"))}
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
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_avg_commission", "Ortalama Komisyon")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{avgCommission}%</h3>
 </div>
 <div className="p-3 bg-muted0/20 rounded-lg"><Percent className="w-5 h-5 text-muted-foreground" /></div>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_total_payouts", "Toplam Hak Ediş")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{t("currency_symbol", "$")}{(rules.reduce((s, r) => s + r.commission, 0)).toLocaleString()}</h3>
 </div>
 <div className="p-3 bg-blue-500/20 rounded-lg"><DollarSign className="w-5 h-5 text-success" /></div>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_active_rules", "Aktif Kurallar")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{rules.length}</h3>
 </div>
 <div className="p-3 bg-muted0/20 rounded-lg"><ShieldCheck className="w-5 h-5 text-muted-foreground" /></div>
 </div>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border overflow-hidden">
 <CardContent className="p-0">
 <Table>
 <TableHeader className="bg-card border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_financial_provider_source", "sağlayıcı")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_rule_type", "Kural Tipi")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_commission", "Komisyon")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_min_volume", "Min. Hacim")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_created", "Oluşturuldu")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_actions", "Aksiyonlar")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {isLoading ? (
 <TableRow><TableCell colSpan={6} className="text-center py-8 text-muted-foreground"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow>
 ) : rules.length === 0 ? (
 <TableRow><TableCell colSpan={6} className="text-center py-8 text-muted-foreground">{t("admin_financial_no_rules", "Komisyon kuralı bulunamadı")}</TableCell></TableRow>
 ) : rules.map(rule => (
 <TableRow key={rule.id} className="border-b border-border hover:bg-card transition-colors">
 <TableCell className="py-4 px-6 font-medium text-foreground">{rule.providerId}</TableCell>
 <TableCell className="px-6">
 <Badge className={cn("border-0 text-[10px]",
 rule.ruleType ==="PERCENTAGE" ?"bg-muted0/20 text-muted-foreground" :
 rule.ruleType ==="FLAT" ?"bg-blue-500/20 text-success" :"bg-muted0/20 text-muted-foreground"
 )}>
 {rule.ruleType}
 </Badge>
 </TableCell>
 <TableCell className="px-6 font-bold text-foreground">
 {rule.ruleType ==="PERCENTAGE" ? `${rule.commission}%` : `$${rule.commission.toLocaleString()}`}
 </TableCell>
 <TableCell className="px-6 text-sm text-muted-foreground">
 {rule.minVolume ? `$${rule.minVolume.toLocaleString()}+` :"—"}
 </TableCell>
 <TableCell className="px-6 text-xs text-muted-foreground font-mono">
 {new Date(rule.createdAt).toLocaleDateString()}
 </TableCell>
 <TableCell className="px-6">
 <div className="flex gap-2">
 <Button size="sm" variant="ghost" className="text-muted-foreground hover:text-foreground" onClick={() => openEdit(rule)} aria-label={t("common.edit")}>
 <Edit className="w-3 h-3" />
 </Button>
 <Button size="sm" variant="ghost" className="text-red-400 hover:text-red-300" onClick={() => deleteMutation.mutate(rule.id)} aria-label={t("common.delete")}>
 <Trash2 className="w-3 h-3" />
 </Button>
 </div>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </div>
 );
}
