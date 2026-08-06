"use client";

import { useTranslation } from"react-i18next";
import { useState } from"react";
import { useMutation, useQuery, useQueryClient } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Badge } from"@/components/ui/badge";
import { CreditCard, DollarSign, Shield, CheckCircle, AlertTriangle, Globe, Clock, Zap, TrendingUp, Loader2 } from"lucide-react";
import { cn } from"@/lib/utils";
import { useToast } from"@/hooks/use-toast";

interface WisePaymentForm {
 amount: string;
 currency: string;
 recipientEmail: string;
 recipientName: string;
 description: string;
}

interface WiseTransaction {
 id: string;
 amount: number;
 currency: string;
 status: 'PENDING' | 'PROCESSING' | 'COMPLETED' | 'FAILED' | 'CANCELLED';
 createdAt: string;
 recipientEmail: string;
 recipientName: string;
 description: string;
 fee: number;
 totalAmount: number;
}

export default function WisePaymentIntegration() {
 const { t } = useTranslation();
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/payments/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 

 const [paymentForm, setPaymentForm] = useState<WisePaymentForm>({
 amount:"", currency:"USD", recipientEmail:"", recipientName:"", description:"",
 });

 const { data: transactionsData, isLoading } = useQuery({
 queryKey: ['wise-transactions'],
 queryFn: async () => {
 const res: any = await apiClient.get('/payments', { limit: 50 });
 return (res?.data || []) as WiseTransaction[];
 },
 });

 const transactions = (transactionsData || []) as WiseTransaction[];

 const createMutation = useMutation({
 mutationFn: async (data: WisePaymentForm) => {
 return apiClient.post('/wise/payment', {
 ...data,
 amount: parseFloat(data.amount),
 sourceCurrency:"USD",
 targetCurrency: data.currency,
 });
 },
 onSuccess: () => {
 toast({ title: t("admin_payments_payment_initiated"), description: t("admin_payments_payment_sent") });
 setPaymentForm({ amount:"", currency:"USD", recipientEmail:"", recipientName:"", description:"" });
 queryClient.invalidateQueries({ queryKey: ['wise-transactions'] });
 },
 onError: (err: any) => {
 toast({ title: t("admin_payments_payment_failed"), description: err.message, variant:"destructive" });
 },
 });

 const handlePayment = () => {
 if (!paymentForm.amount || !paymentForm.recipientEmail || !paymentForm.recipientName) {
 toast({ title: t("admin_payments_missing_information"), description: t("admin_payments_please_fill_in_all"), variant:"destructive" });
 return;
 }
 createMutation.mutate(paymentForm);
 };

 const statusConfig: Record<string, { label: string; class: string }> = {
 COMPLETED: { label: t("admin_payments_completed", "Tamamlanmış"), class:"bg-blue-500/20 text-success border-blue-500/20" },
 PROCESSING: { label: t("admin_payments_processing", "İşleme"), class:"bg-muted0/20 text-muted-foreground border-slate-500/20" },
 FAILED: { label: t("admin_payments_failed", "Arızalı"), class:"bg-red-500/20 text-red-400 border-red-500/20" },
 CANCELLED: { label: t("admin_payments_cancelled", "İptal edildi"), class:"bg-muted0/20 text-muted-foreground border-slate-500/20" },
 PENDING: { label: t("admin_payments_pending", "Askıda olması"), class:"bg-amber-500/20 text-warning border-amber-500/20" },
 };

 const monthlyVolume = transactions.filter(t => t.status ==="COMPLETED").reduce((s, t) => s + t.amount, 0);
 const avgTransaction = transactions.length > 0 ? monthlyVolume / transactions.length : 0;

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
 <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center gap-4">
 <div className="p-3 bg-muted rounded-xl shadow-lg shadow-slate-600/20">
 <CreditCard className="w-8 h-8 text-foreground" />
 </div>
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">
 {t("admin_payments_wise_payment_hub", "Wise Ödeme Merkezi")}
 </h1>
 <p className="text-muted-foreground">
 {t("admin_payments_global_payment_processing_with", "Global Ödeme İşleme Wise İle")}
 </p>
 </div>
 </div>
 <div className="text-right">
 <p className="text-xs text-muted-foreground">{t("admin_payments_total_sent", "Toplam Gönderilen")}</p>
 <p className="text-2xl font-bold text-foreground">{t("currency_symbol", "$")}{monthlyVolume.toLocaleString()}</p>
 </div>
 </div>

 <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
 <Card className="bg-card border-border p-6">
 <CardHeader className="px-0 pt-0">
 <CardTitle className="text-foreground flex items-center gap-2">
 <CreditCard className="w-5 h-5 text-muted-foreground" />
 {t("admin_payments_send_payment", "Ödeme Yap")}
 </CardTitle>
 </CardHeader>
 <CardContent className="px-0 pb-0 space-y-4">
 <div className="space-y-2">
 <Label className="text-xs text-muted-foreground">{t("admin_payments_amount", "Tutar")}</Label>
 <Input type="number" value={paymentForm.amount} onChange={e => setPaymentForm(prev => ({ ...prev, amount: e.target.value }))} placeholder="1000.00" className="bg-card border-border text-foreground placeholder:text-muted-foreground" />
 </div>
 <div className="space-y-2">
 <Label className="text-xs text-muted-foreground">{t("admin_payments_currency", "Para Birimi")}</Label>
 <Select value={paymentForm.currency} onValueChange={value => setPaymentForm(prev => ({ ...prev, currency: value }))}>
 <SelectTrigger className="bg-card border-border text-foreground"><SelectValue /></SelectTrigger>
 <SelectContent className="bg-background border-border text-foreground">
 <SelectItem value="USD">{t("admin_payments_usd_us_dollar", "Usd - Abd Doları")}</SelectItem>
 <SelectItem value="EUR">{t("admin_payments_eur_euro", "Eur - Euro Cinsi")}</SelectItem>
 <SelectItem value="GBP">{t("admin_payments_gbp_british_pound", "Gbp - İngiliz Sterlini")}</SelectItem>
 <SelectItem value="TRY">{t("admin_payments_try_turkish_lira", "Try - Türk Lirası")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label className="text-xs text-muted-foreground">{t("admin_payments_recipient_name", "Alıcı İsim")}</Label>
 <Input value={paymentForm.recipientName} onChange={e => setPaymentForm(prev => ({ ...prev, recipientName: e.target.value }))} placeholder={t("admin_payments_john_doe", "Ahmet Yılmaz")} className="bg-card border-border text-foreground placeholder:text-muted-foreground" />
 </div>
 <div className="space-y-2">
 <Label className="text-xs text-muted-foreground">{t("admin_payments_recipient_email", "Alıcı E-posta")}</Label>
 <Input type="email" value={paymentForm.recipientEmail} onChange={e => setPaymentForm(prev => ({ ...prev, recipientEmail: e.target.value }))} placeholder={t("admin_payments_johnexamplecom", "Ahmet@ornek.com")} className="bg-card border-border text-foreground placeholder:text-muted-foreground" />
 </div>
 <div className="space-y-2">
 <Label className="text-xs text-muted-foreground">{t("admin_payments_description", "Ödeme Ağ Geçidi Ve İşlem Geçmişi")}</Label>
 <Input value={paymentForm.description} onChange={e => setPaymentForm(prev => ({ ...prev, description: e.target.value }))} placeholder={t("admin_auto_payment_for_services", "Hizmetler için ödeme")} className="bg-card border-border text-foreground placeholder:text-muted-foreground" />
 </div>
 <div className="bg-card rounded-xl p-4 space-y-2">
 <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_payments_transfer_fee", "Transfer Ücreti")}</span><span className="text-foreground font-bold">{t("currency_symbol", "$")}{paymentForm.amount ? (parseFloat(paymentForm.amount) * 0.015).toFixed(2) : '0.00'}</span></div>
 <div className="flex justify-between text-sm font-bold border-t border-border pt-2"><span className="text-foreground">{t("admin_payments_total", "Toplam")}</span><span className="text-foreground">{t("currency_symbol", "$")}{paymentForm.amount ? (parseFloat(paymentForm.amount) * 1.015).toFixed(2) : '0.00'}</span></div>
 </div>
 <Button onClick={handlePayment} disabled={createMutation.isPending} className="w-full bg-muted hover:bg-muted text-foreground shadow-lg shadow-slate-500/20">
 {createMutation.isPending ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />{t("admin_payments_processing", "İşleme")}</> : <><DollarSign className="w-4 h-4 mr-2" />{t("admin_payments_send_payment", "Ödeme Yap")}</>}
 </Button>
 </CardContent>
 </Card>

 <div className="space-y-6">
 <div className="grid grid-cols-2 gap-4">
 <Card className="bg-card border-border p-6">
 <div className="flex items-center gap-3">
 <div className="w-10 h-10 rounded-xl bg-blue-500/20 flex items-center justify-center">
 <TrendingUp className="w-5 h-5 text-success" />
 </div>
 <div>
 <p className="text-xs text-muted-foreground">{t("admin_payments_monthly_volume", "Aylık Hacim")}</p>
 <p className="text-xl font-bold text-foreground">{t("currency_symbol", "$")}{monthlyVolume.toLocaleString()}</p>
 </div>
 </div>
 </Card>
 <Card className="bg-card border-border p-6">
 <div className="flex items-center gap-3">
 <div className="w-10 h-10 rounded-xl bg-orange-500/20 flex items-center justify-center">
 <Zap className="w-5 h-5 text-warning" />
 </div>
 <div>
 <p className="text-xs text-muted-foreground">{t("admin_payments_avg_transaction", "Ortalama İşlem")}</p>
 <p className="text-xl font-bold text-foreground">{t("currency_symbol", "$")}{avgTransaction.toFixed(2)}</p>
 </div>
 </div>
 </Card>
 </div>

 <Card className="bg-card border-border p-6">
 <CardHeader className="px-0 pt-0">
 <CardTitle className="text-foreground flex items-center gap-2">
 <Globe className="w-5 h-5 text-muted-foreground" />
 {t("admin_payments_recent_transactions", "Geçmiş Ödemeler")}
 </CardTitle>
 </CardHeader>
 <CardContent className="px-0 pb-0 space-y-4">
 {isLoading ? (
 <div className="flex justify-center py-8"><Loader2 className="w-6 h-6 animate-spin text-muted-foreground" /></div>
 ) : transactions.length === 0 ? (
 <p className="text-center text-muted-foreground py-8">{t("admin_payments_no_transactions", "İşlem yok")}</p>
 ) : transactions.slice(0, 10).map(transaction => {
 const cfg = statusConfig[transaction.status] || statusConfig.PENDING;
 return (
 <div key={transaction.id} className="bg-card rounded-xl p-4 border border-border">
 <div className="flex items-center justify-between">
 <div className="flex-1">
 <div className="flex items-center gap-2 mb-2">
 {transaction.status ==="COMPLETED" ? <CheckCircle className="w-4 h-4 text-success" /> :
 transaction.status ==="FAILED" ? <AlertTriangle className="w-4 h-4 text-red-400" /> :
 <Clock className="w-4 h-4 text-muted-foreground" />}
 <Badge className={cn("border-0 text-[10px]", cfg.class)}>{cfg.label}</Badge>
 </div>
 <p className="text-sm font-medium text-foreground">{transaction.recipientName}</p>
 <p className="text-xs text-muted-foreground">{transaction.recipientEmail}</p>
 <p className="text-xs text-muted-foreground">{transaction.description}</p>
 </div>
 <div className="text-right">
 <p className="text-lg font-bold text-foreground">{t("currency_symbol", "$")}{transaction.amount.toLocaleString()}</p>
 <p className="text-xs text-muted-foreground">{t("admin_payments_fee", "Ücret")}: ${transaction.fee.toFixed(2)}</p>
 <p className="text-xs text-muted-foreground">{new Date(transaction.createdAt).toLocaleDateString()}</p>
 </div>
 </div>
 </div>
 );
 })}
 </CardContent>
 </Card>

 <Card className="bg-card border-border p-4">
 <div className="flex items-center gap-3">
 <div className="w-10 h-10 rounded-xl bg-muted0/20 flex items-center justify-center">
 <Shield className="w-5 h-5 text-muted-foreground" />
 </div>
 <p className="text-sm text-muted-foreground">
 <strong className="text-foreground">{t("admin_payments_security_notice", "Güvenlik Bildirimi")}{t("mobile.leftovers.", ":")}</strong>
 {t("admin_payments_all_payments_secured", "Tüm ödemeler Wise aracılığıyla güvenli bir şekilde işlenir")}
 </p>
 </div>
 </Card>
 </div>
 </div>
 </div>
 );
}
