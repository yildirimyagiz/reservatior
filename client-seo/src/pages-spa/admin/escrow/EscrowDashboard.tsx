"use client";

import { useState } from"react";
import { useTranslation } from"react-i18next";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Badge } from"@/components/ui/badge";
import { ShieldCheck, Lock, Unlock, Plus, DollarSign, Clock, Search, ArrowRightLeft } from"lucide-react";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Label } from"@/components/ui/label";
import { cn } from"@/lib/utils";

interface EscrowAccount {
 id: string;
 orgId: string;
 reservationId: string;
 totalAmount: number;
 depositAmount: number;
 currency: string;
 status:"HOLDING" |"RELEASED" |"DISPUTED" |"REFUNDED";
 heldAt: string;
 releasedAt?: string;
}

export default function EscrowDashboard() {
 const { t } = useTranslation();
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/escrow-account/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 

 const [searchTerm, setSearchTerm] = useState("");
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [releaseTarget, setReleaseTarget] = useState<EscrowAccount | null>(null);
 const [newAccount, setNewAccount] = useState({
 reservationId:"",
 totalAmount: 0,
 depositAmount: 0,
 currency:"USD",
 });

 const { data: accountsData, isLoading } = useQuery({
 queryKey: ['escrow-accounts'],
 queryFn: async () => {
 const res: any = await apiClient.get('/escrow-account');
 return (res?.data || []) as EscrowAccount[];
 },
 });

 const accounts = (accountsData || []) as EscrowAccount[];

 const stats = {
 locked: accounts.filter(a => a.status ==="HOLDING").reduce((s, a) => s + a.totalAmount, 0),
 released: accounts.filter(a => a.status ==="RELEASED").reduce((s, a) => s + a.totalAmount, 0),
 disputed: accounts.filter(a => a.status ==="DISPUTED").length,
 total: accounts.length,
 };

 const createMutation = useMutation({
 mutationFn: async (data: typeof newAccount) => {
 return apiClient.post('/escrow-account', {
 ...data,
 orgId:"org_1",
 heldAt: new Date().toISOString(),
 });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['escrow-accounts'] });
 setIsAddOpen(false);
 setNewAccount({ reservationId:"", totalAmount: 0, depositAmount: 0, currency:"USD" });
 },
 });

 const releaseMutation = useMutation({
 mutationFn: async ({ id }: { id: string }) => {
 return apiClient.patch(`/escrow-account/${id}`, {
 status:"RELEASED",
 releasedAt: new Date().toISOString(),
 });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['escrow-accounts'] });
 setReleaseTarget(null);
 },
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate(newAccount);
 };

 const filtered = accounts.filter(a =>
 a.id.toLowerCase().includes(searchTerm.toLowerCase()) ||
 a.reservationId.toLowerCase().includes(searchTerm.toLowerCase())
 );

 const statusConfig: Record<string, { label: string; class: string; icon: any }> = {
 HOLDING: { label: t("admin_escrow_holding", "BEKLEME"), class:"bg-muted0/20 text-muted-foreground", icon: Lock },
 RELEASED: { label: t("admin_escrow_released", "PİYASAYA SÜRÜLMÜŞ"), class:"bg-blue-500/20 text-success", icon: Unlock },
 DISPUTED: { label: t("admin_escrow_disputed", "TARTIŞILMIŞ"), class:"bg-amber-500/20 text-warning", icon: ShieldCheck },
 REFUNDED: { label: t("admin_escrow_refunded", "İADE EDİLDİ"), class:"bg-muted0/20 text-muted-foreground", icon: ArrowRightLeft },
 };

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
 <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center gap-4">
 <div className="p-3 bg-muted rounded-xl shadow-lg shadow-slate-600/20">
 <ShieldCheck className="w-8 h-8 text-foreground" />
 </div>
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">
 {t("admin_escrow_title", "Emanet Yönetimi")}
 </h1>
 <p className="text-muted-foreground">
 {t("admin_escrow_subtitle", "SafeStay™ emanet ödemelerini takip edin ve yönetin")}
 </p>
 </div>
 </div>
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button className="bg-muted hover:bg-muted text-foreground shadow-lg shadow-slate-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_escrow_add", "Yeni Emanet")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_escrow_add", "Yeni Emanet")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">
 {t("admin_escrow_add_desc", "Rezervasyon için yeni bir emanet hesabı oluşturun")}
 </DialogDescription>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="reservationId">{t("admin_escrow_reservation_id", "Rezervasyon Kimliği")}</Label>
 <Input id="reservationId" className="bg-card border-border text-foreground" value={newAccount.reservationId} onChange={e => setNewAccount({ ...newAccount, reservationId: e.target.value })} required />
 </div>
 <div className="space-y-2">
 <Label htmlFor="totalAmount">{t("admin_escrow_total_amount", "Toplam Tutar")}</Label>
 <Input id="totalAmount" type="number" className="bg-card border-border text-foreground" value={newAccount.totalAmount} onChange={e => setNewAccount({ ...newAccount, totalAmount: Number(e.target.value) })} required />
 </div>
 <div className="space-y-2">
 <Label htmlFor="depositAmount">{t("admin_escrow_deposit_amount", "Yatırma Tutarı")}</Label>
 <Input id="depositAmount" type="number" className="bg-card border-border text-foreground" value={newAccount.depositAmount} onChange={e => setNewAccount({ ...newAccount, depositAmount: Number(e.target.value) })} required />
 </div>
 <div className="space-y-2">
 <Label htmlFor="currency">{t("admin_escrow_currency", "Para birimi")}</Label>
 <Input id="currency" className="bg-card border-border text-foreground" value={newAccount.currency} onChange={e => setNewAccount({ ...newAccount, currency: e.target.value })} />
 </div>
 <DialogFooter>
 <Button type="button" variant="ghost" onClick={() => setIsAddOpen(false)} className="text-muted-foreground">{t("common.cancel", "İptal")}</Button>
 <Button type="submit" className="bg-muted hover:bg-muted" disabled={createMutation.isPending}>
 {createMutation.isPending ? t("common.saving", "Kaydediliyor") : t("admin_escrow_create", "Yaratmak")}
 </Button>
 </DialogFooter>
 </form>
 </DialogContent>
 </Dialog>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_escrow_locked_amount", "Kilitli Tutar")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{t("currency_symbol", "$")}{stats.locked.toLocaleString()}</h3>
 </div>
 <div className="p-3 bg-muted0/20 rounded-lg"><Lock className="w-5 h-5 text-muted-foreground" /></div>
 </div>
 <p className="text-xs text-muted-foreground mt-2">{stats.locked > 0 ? t("admin_escrow_awaiting_release", "Serbest bırakılmayı bekliyor") : t("admin_escrow_none_locked", "Kilitli fon yok")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_escrow_released_amount", "Serbest Bırakılan Tutar")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{t("currency_symbol", "$")}{stats.released.toLocaleString()}</h3>
 </div>
 <div className="p-3 bg-blue-500/20 rounded-lg"><Unlock className="w-5 h-5 text-success" /></div>
 </div>
 <p className="text-xs text-muted-foreground mt-2">{t("admin_escrow_transferred", "Hesaplara aktarıldı")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_escrow_disputed_count", "İhtilaflı")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{stats.disputed}</h3>
 </div>
 <div className="p-3 bg-amber-500/20 rounded-lg"><ShieldCheck className="w-5 h-5 text-warning" /></div>
 </div>
 <p className="text-xs text-muted-foreground mt-2">{t("admin_escrow_in_dispute", "Anlaşmazlık çözümünde")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_escrow_total", "Toplam Emanet")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{stats.total}</h3>
 </div>
 <div className="p-3 bg-muted0/20 rounded-lg"><DollarSign className="w-5 h-5 text-muted-foreground" /></div>
 </div>
 <p className="text-xs text-muted-foreground mt-2">{t("admin_escrow_all_accounts", "Tüm emanet hesapları")}</p>
 </CardContent>
 </Card>
 </div>

 <div className="space-y-4">
 <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
 <div className="relative flex-1 max-w-md">
 <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
 <Input
 placeholder={t("admin_escrow_search", "Kimliğe veya rezervasyona göre arayın...")}
 className="bg-card border-border pl-10 text-foreground placeholder:text-muted-foreground"
 value={searchTerm}
 onChange={e => setSearchTerm(e.target.value)}
 />
 </div>
 </div>

 <Card className="bg-card border-border overflow-hidden">
 <CardContent className="p-0">
 <div className="overflow-x-auto">
 <Table>
 <TableHeader className="bg-card border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_escrow_id", "İD")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_escrow_reservation", "Rezervasyon")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_escrow_amount", "Miktar")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_escrow_status", "Durum")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_escrow_date", "Tarih")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_escrow_actions", "Eylemler")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {isLoading ? (
 <TableRow><TableCell colSpan={6} className="text-center py-8 text-muted-foreground">{t("common.loading", "Yükleniyor")}</TableCell></TableRow>
 ) : filtered.length === 0 ? (
 <TableRow><TableCell colSpan={6} className="text-center py-8 text-muted-foreground">{t("admin_escrow_no_accounts", "Emanet hesabı bulunamadı")}</TableCell></TableRow>
 ) : filtered.map((acc) => {
 const cfg = statusConfig[acc.status] || statusConfig.REFUNDED;
 const Icon = cfg.icon;
 return (
 <TableRow key={acc.id} className="border-b border-border hover:bg-card transition-colors">
 <TableCell className="py-4 px-6">
 <span className="text-sm font-mono text-foreground">{acc.id.slice(0, 8)}...</span>
 </TableCell>
 <TableCell className="px-6 text-sm text-muted-foreground">{acc.reservationId.slice(0, 12)}...</TableCell>
 <TableCell className="px-6 font-bold text-foreground">{t("currency_symbol", "$")}{acc.totalAmount.toLocaleString()}</TableCell>
 <TableCell className="px-6">
 <Badge className={cn("border-0 gap-1", cfg.class)}>
 <Icon className="w-3 h-3" /> {cfg.label}
 </Badge>
 </TableCell>
 <TableCell className="px-6 text-sm text-muted-foreground">{new Date(acc.heldAt).toLocaleDateString()}</TableCell>
 <TableCell className="px-6">
 <div className="flex gap-2">
 {acc.status ==="HOLDING" && (
 <Dialog open={releaseTarget?.id === acc.id} onOpenChange={(open) => !open && setReleaseTarget(null)}>
 <DialogTrigger asChild>
 <Button size="sm" variant="outline" className="bg-card border-border text-muted-foreground hover:bg-muted dark:hover:bg-card/10" onClick={() => setReleaseTarget(acc)}>
 <Unlock className="w-3 h-3 mr-1" /> {t("admin_escrow_release", "Serbest bırakmak")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[400px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_escrow_confirm_release", "Sürümü Onayla")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">
 {t("admin_escrow_release_desc","Release ${amount} from escrow account {id}", { amount: acc.totalAmount.toLocaleString(), id: acc.id.slice(0, 8) })}
 </DialogDescription>
 </DialogHeader>
 <DialogFooter>
 <Button variant="ghost" onClick={() => setReleaseTarget(null)} className="text-muted-foreground">{t("common.cancel", "İptal")}</Button>
 <Button className="bg-blue-600 hover:bg-blue-700" onClick={() => releaseMutation.mutate({ id: acc.id })} disabled={releaseMutation.isPending}>
 {releaseMutation.isPending ? t("common.processing", "İşleniyor") : t("admin_escrow_confirm", "Sürümü Onayla")}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 )}
 </div>
 </TableCell>
 </TableRow>
 );
 })}
 </TableBody>
 </Table>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 );
}
