"use client";

import React, { useState } from 'react';
import { Shield, TrendingUp, Activity, Award, ArrowRight, CheckCircle, XCircle, AlertCircle } from 'lucide-react';
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { useToast } from"@/hooks/use-toast";
import { useTranslation } from"react-i18next";
import { apiClient } from"@/lib/api/client";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Badge } from"@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { MoreHorizontal, Edit, Trash2 } from"lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";

interface PartnerAgreement {
 id: string;
 tenantId: string;
 status: string;
 baseCommission: number;
 loyaltyYield: number;
 portfolioHealthScore: number;
 currentMultiplier: number;
 createdAt?: string;
 updatedAt?: string;
}

const STATUS_OPTIONS = ["CREATED","ACTIVE","SUSPENDED","TERMINATED"];
const STATUS_CONFIG: Record<string, { label: string; cls: string }> = {
 CREATED: { label:"Created", cls:"bg-muted0/10 text-muted-foreground border-slate-500/20" },
 ACTIVE: { label:"Active", cls:"bg-blue-500/10 text-success border-blue-500/20" },
 SUSPENDED: { label:"Suspended", cls:"bg-orange-500/10 text-warning border-orange-500/20" },
 TERMINATED: { label:"Terminated", cls:"bg-red-500/10 text-red-400 border-red-500/20" },
};

export const PartnerAgreements: React.FC = () => {
 const { t } = useTranslation();
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [isTransitionOpen, setIsTransitionOpen] = useState(false);
 const [selectedAgreement, setSelectedAgreement] = useState<PartnerAgreement | null>(null);
 const [transitionState, setTransitionState] = useState("");

 const [newAgreement, setNewAgreement] = useState({
 baseCommission: '0.10',
 loyaltyYield: '5.0',
 portfolioHealthScore: '0.90'
 });

 const { data: agreementsRes, isLoading } = useQuery({
 queryKey: ['partner-agreements'],
 queryFn: async () => {
 const res: any = await apiClient.get('/partner-agreement/admin/all');
 return res.data as PartnerAgreement[];
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/partner-agreement', {
 terms: {
 baseCommission: parseFloat(data.baseCommission),
 loyaltyYield: parseFloat(data.loyaltyYield),
 portfolioHealthScore: parseFloat(data.portfolioHealthScore),
 currentMultiplier: 1.0
 }
 });
 },
 onSuccess: () => {
 setIsAddOpen(false);
 queryClient.invalidateQueries({ queryKey: ['partner-agreements'] });
 toast({ title: t("common.success", "Başarılı"), description: t("admin_agreements_created", "Sözleşme başarıyla oluşturuldu") });
 setNewAgreement({ baseCommission: '0.10', loyaltyYield: '5.0', portfolioHealthScore: '0.90' });
 },
 onError: (err: any) => {
 toast({ title: t("common.error", "Hata"), description: err.message || t("admin_agreements_create_error", "Sözleşme oluşturulamadı"), variant:"destructive" });
 }
 });

 const transitionMutation = useMutation({
 mutationFn: async ({ id, nextState }: { id: string; nextState: string }) => {
 return apiClient.post(`/partner-agreement/transition/${id}`, { nextState });
 },
 onSuccess: () => {
 setIsTransitionOpen(false);
 setSelectedAgreement(null);
 setTransitionState("");
 queryClient.invalidateQueries({ queryKey: ['partner-agreements'] });
 toast({ title: t("common.success", "Başarılı"), description: t("admin_agreements_transitioned", "Sözleşme durumu güncellendi") });
 },
 onError: (err: any) => {
 toast({ title: t("common.error", "Hata"), description: err.message || t("admin_agreements_transition_error", "Durum güncellenemedi"), variant:"destructive" });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/partner-agreement/${id}`),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['partner-agreements'] });
 toast({ title: t("common.success", "Başarılı"), description: t("admin_agreements_deleted", "Sözleşme silindi") });
 },
 onError: (err: any) => toast({ title: t("common.error", "Hata"), description: err.message, variant:"destructive" })
 });

 const agreements = agreementsRes || [];

 const handleCreate = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate(newAgreement);
 };

 const getValidTransitions = (currentStatus: string): string[] => {
 switch (currentStatus) {
 case"CREATED": return ["ACTIVE","TERMINATED"];
 case"ACTIVE": return ["SUSPENDED","TERMINATED"];
 case"SUSPENDED": return ["ACTIVE","TERMINATED"];
 default: return [];
 }
 };

 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400 flex items-center gap-3">
 <Shield className="w-8 h-8 text-muted-foreground" />
 {t("admin_agreements_title", "İş Ortağı Anlaşmaları")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_agreements_subtitle", "Ajans iş ortağı sözleşmesi sözleşmelerini izleyin ve yönetin")}
 </p>
 </div>
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button className="bg-muted hover:bg-muted text-foreground shadow-lg shadow-slate-500/20">
 <Shield className="w-4 h-4 mr-2" />
 {t("admin_agreements_create", "Sözleşme Oluştur")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[500px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_agreements_create_title", "İş Ortağı Sözleşmesi Oluşturun")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">
 {t("admin_agreements_create_desc", "Yeni iş ortağı sözleşmesinin mali şartlarını belirleyin")}
 </DialogDescription>
 </DialogHeader>
 <form onSubmit={handleCreate} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="baseCommission" className="text-muted-foreground">{t("admin_agreements_base_commission", "Temel Komisyon")}</Label>
 <Input id="baseCommission" type="number" step="0.01" className="bg-card border-border text-foreground" value={newAgreement.baseCommission} onChange={e => setNewAgreement({...newAgreement, baseCommission: e.target.value})} placeholder="0.10" />
 </div>
 <div className="space-y-2">
 <Label htmlFor="loyaltyYield" className="text-muted-foreground">{t("admin_agreements_loyalty_yield", "Sadakat Getirisi")}</Label>
 <Input id="loyaltyYield" type="number" step="0.1" className="bg-card border-border text-foreground" value={newAgreement.loyaltyYield} onChange={e => setNewAgreement({...newAgreement, loyaltyYield: e.target.value})} placeholder="5.0" />
 </div>
 <div className="space-y-2">
 <Label htmlFor="portfolioHealthScore" className="text-muted-foreground">{t("admin_agreements_health_score", "Sağlık Puanı")}</Label>
 <Input id="portfolioHealthScore" type="number" step="0.01" className="bg-card border-border text-foreground" value={newAgreement.portfolioHealthScore} onChange={e => setNewAgreement({...newAgreement, portfolioHealthScore: e.target.value})} placeholder="0.90" />
 </div>
 <DialogFooter className="pt-4">
 <Button type="button" variant="ghost" onClick={() => setIsAddOpen(false)}>{t("common.cancel", "İptal")}</Button>
 <Button type="submit" className="bg-muted hover:bg-muted" disabled={createMutation.isPending}>
 {createMutation.isPending ? t("common.saving", "Kaydediliyor") : t("common.create", "Oluştur")}
 </Button>
 </DialogFooter>
 </form>
 </DialogContent>
 </Dialog>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_agreements_active_contracts", "Aktif Sözleşmeler")}</CardTitle>
 <Activity className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{agreements.filter(a => a.status === 'ACTIVE').length}</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_agreements_total_count","Total: {count}", { count: agreements.length })}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_agreements_avg_commission", "Ortalama Komisyon")}</CardTitle>
 <TrendingUp className="w-4 h-4 text-success" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">
 {agreements.length > 0
 ? `${(agreements.reduce((s, a) => s + a.baseCommission, 0) / agreements.length * 100).toFixed(2)}%`
 : '0%'}
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_agreements_avg_health", "Ortalama Sağlık")}</CardTitle>
 <Award className="w-4 h-4 text-warning" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">
 {agreements.length > 0
 ? `${(agreements.reduce((s, a) => s + a.portfolioHealthScore, 0) / agreements.length * 100).toFixed(0)}`
 : '0'}
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_agreements_avg_multiplier", "Ort Çarpma")}</CardTitle>
 <ArrowRight className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">
 {agreements.length > 0
 ? `${(agreements.reduce((s, a) => s + a.currentMultiplier, 0) / agreements.length).toFixed(2)}x`
 : '0x'}
 </div>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_agreements_agreement_list", "Anlaşma Sözleşmeleri")}</CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("common.loading", "Yükleniyor")}
 </div>
 ) : agreements.length === 0 ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("admin_agreements_no_agreements", "Hiçbir anlaşma bulunamadı.")}
 </div>
 ) : (
 <div className="rounded-xl border border-border">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-muted-foreground">{t("admin_agreements_tenant", "Ajans")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_agreements_status", "Durum")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_agreements_commission", "Komisyon")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_agreements_loyalty", "Bağlılık")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_agreements_health", "Sağlık")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_agreements_multiplier", "Çarpan")}</TableHead>
 <TableHead className="text-muted-foreground text-right">{t("common.actions", "İşlemler")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {agreements.map((agr: PartnerAgreement) => {
     const { t } = useTranslation();
 const statusCfg = STATUS_CONFIG[agr.status] || { label: agr.status, cls:"bg-muted0/10 text-muted-foreground border-slate-500/20" };
 const validTransitions = getValidTransitions(agr.status);
 return (
 <TableRow key={agr.id} className="border-border hover:bg-card transition-colors">
 <TableCell className="font-medium text-foreground">{agr.tenantId}</TableCell>
 <TableCell>
 <Badge variant="outline" className={`${statusCfg.cls} border`}>{statusCfg.label}</Badge>
 </TableCell>
 <TableCell className="text-foreground font-semibold">{(agr.baseCommission * 100).toFixed(2)}%</TableCell>
 <TableCell className="text-muted-foreground">{agr.loyaltyYield.toFixed(1)} {t("admin_ai_pts", "Puan")}</TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className="w-16 h-2 bg-card/10 rounded-full overflow-hidden">
 <div className="h-full bg-blue-500 rounded-full" style={{ width: `${Math.min(100, agr.portfolioHealthScore * 100)}%` }} />
 </div>
 <span className="text-sm text-muted-foreground">{(agr.portfolioHealthScore * 100).toFixed(0)}</span>
 </div>
 </TableCell>
 <TableCell className="text-muted-foreground">{agr.currentMultiplier.toFixed(2)}{t("admin_auto_x", "x")}</TableCell>
 <TableCell className="text-right">
 {validTransitions.length > 0 && (
 <Button
 variant="ghost"
 size="sm"
 className="text-muted-foreground hover:text-muted-foreground hover:bg-muted"
 onClick={() => {
 setSelectedAgreement(agr);
 setTransitionState(validTransitions[0]);
 setIsTransitionOpen(true);
 }}
 >
 <ArrowRight className="w-4 h-4 mr-1" />
 {t("admin_agreements_transition", "Geçiş")}
 </Button>
 )}
 </TableCell>
 
 <TableCell>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0"><span className="sr-only">{t("admin_auto_open_menu", "Menüyü aç")}</span><MoreHorizontal className="h-4 w-4" /></Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-background border-border text-foreground">
 <DropdownMenuItem className="cursor-pointer hover:bg-muted dark:hover:bg-card/10"><Edit className="mr-2 h-4 w-4" /> {t("admin_action_edit", "Düzenle")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => deleteMutation.mutate(agr.id)} className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> {t("admin_action_delete", "Sil")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>
 );
 })}
 </TableBody>
 </Table>
 </div>
 )}
 </CardContent>
 </Card>

 <Dialog open={isTransitionOpen} onOpenChange={setIsTransitionOpen}>
 <DialogContent className="sm:max-w-[400px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_agreements_transition_title", "Geçiş Anlaşması Durumu")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">
 {selectedAgreement && t("admin_agreements_transition_desc","Change state for {id}", { id: selectedAgreement.tenantId })}
 </DialogDescription>
 </DialogHeader>
 <div className="space-y-4 py-4">
 <div className="space-y-2">
 <Label className="text-muted-foreground">{t("admin_agreements_current_state", "Mevcut Durum")}</Label>
 <div className="p-3 bg-card rounded-lg text-foreground font-medium">
 {selectedAgreement && STATUS_CONFIG[selectedAgreement.status]?.label || selectedAgreement?.status}
 </div>
 </div>
 <div className="space-y-2">
 <Label htmlFor="nextState" className="text-muted-foreground">{t("admin_agreements_next_state", "Sonraki Durum")}</Label>
 <Select value={transitionState} onValueChange={setTransitionState}>
 <SelectTrigger className="bg-card border-border text-foreground">
 <SelectValue placeholder={t("admin_agreements_select_state", "Eyalet seçin")} />
 </SelectTrigger>
 <SelectContent className="bg-background border-border text-foreground">
 {selectedAgreement && getValidTransitions(selectedAgreement.status).map(state => (
 <SelectItem key={state} value={state} className="hover:bg-muted dark:hover:bg-card/10">{STATUS_CONFIG[state]?.label || state}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 </div>
 <DialogFooter>
 <Button variant="ghost" onClick={() => { setIsTransitionOpen(false); setSelectedAgreement(null); }}>
 {t("common.cancel", "İptal")}
 </Button>
 <Button
 className="bg-muted hover:bg-muted"
 onClick={() => selectedAgreement && transitionMutation.mutate({ id: selectedAgreement.id, nextState: transitionState })}
 disabled={transitionMutation.isPending || !transitionState}
 >
 {transitionMutation.isPending ? t("common.processing", "İşleniyor") : t("admin_agreements_transition_btn", "Geçiş")}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 );
};
