"use client";

import { useTranslation } from"react-i18next";
import { useState } from"react";
import { useQuery } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { CreditCard, Download, CheckCircle, Loader2 } from"lucide-react";

interface Invoice {
 id: string;
 invoiceNumber: string;
 total: number;
 currency: string;
 status: string;
 customerName: string;
 dueDate: string;
 createdAt: string;
 lineItems: any[];
}

interface Plan {
 id: string;
 name: string;
 price: number;
 interval: string;
 features: any;
 isActive: boolean;
}

export default function Billing() {
 const { t } = useTranslation();
 const [billingCycle, setBillingCycle] = useState("monthly");

 const { data: invoicesData, isLoading: invoicesLoading } = useQuery({
 queryKey: ['billing-invoices'],
 queryFn: async () => {
 const res: any = await apiClient.get('/invoices?limit=50');
 return (res?.data || []) as Invoice[];
 },
 });

 const { data: plansData } = useQuery({
 queryKey: ['billing-plans'],
 queryFn: async () => {
 const res: any = await apiClient.get('/plans');
 return (res?.data || []) as Plan[];
 },
 });

 const invoices = (invoicesData || []) as Invoice[];
 const plans = (plansData || []) as Plan[];

 const currentPlan = plans.find(p => p.isActive);
 const totalPaid = invoices.filter(i => i.status ==="PAID" || i.status ==="paid").reduce((s, i) => s + i.total, 0);

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
 <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center gap-4">
 <div className="p-3 bg-muted rounded-xl shadow-lg shadow-slate-600/20">
 <CreditCard className="w-8 h-8 text-foreground" />
 </div>
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">
 {t("admin_billing_billing", "Fatura Ve Ödeme")}
 </h1>
 <p className="text-muted-foreground">
 {t("admin_billing_subscription_and_payment_management", "Abonelik Ve Ödeme Yönetimi")}
 </p>
 </div>
 </div>
 </div>

 <Tabs defaultValue="overview" className="w-full">
 <TabsList className="bg-card border border-border">
 <TabsTrigger value="overview" className="data-[state=active]:bg-muted data-[state=active]:text-white">{t("admin_billing_overview", "Finansal Bakış")}</TabsTrigger>
 <TabsTrigger value="plans" className="data-[state=active]:bg-muted data-[state=active]:text-white">{t("admin_billing_plans", "Abonelik Planları")}</TabsTrigger>
 <TabsTrigger value="billing" className="data-[state=active]:bg-muted data-[state=active]:text-white">{t("admin_billing_invoices", "Faturalar")}</TabsTrigger>
 <TabsTrigger value="payment" className="data-[state=active]:bg-muted data-[state=active]:text-white">{t("admin_billing_payment_methods", "Ödeme Yöntemleri")}</TabsTrigger>
 </TabsList>

 <TabsContent value="overview" className="space-y-6 mt-6">
 <div className="grid gap-6 md:grid-cols-2">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_billing_current_plan", "Mevcut Plan")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <h3 className="text-2xl font-bold text-foreground">{currentPlan?.name || t("admin_billing_no_plan", "Plan Yok")}</h3>
 <p className="text-3xl font-bold text-foreground">{t("currency_symbol", "$")}{currentPlan?.price || 0}<span className="text-lg font-normal text-muted-foreground">{t("/", "/")}{currentPlan?.interval ||"mo"}</span></p>
 <Badge className="bg-blue-500/20 text-success border-0">{t("admin_billing_active", "Aktif")}</Badge>
 <div className="space-y-2 text-sm text-muted-foreground">
 <p>{t("admin_billing_total_paid", "Toplam Ödenen")}: ${totalPaid.toLocaleString()}</p>
 <p>{invoices.length} {t("admin_billing_invoices", "Faturalar")}</p>
 </div>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_billing_billing_info", "Fatura Bilgileri")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4 text-sm">
 <div>
 <p className="text-muted-foreground">{t("admin_billing_next_billing_date", "Sonraki Fatura Tarihi")}</p>
 <p className="text-lg font-medium text-foreground">{invoices.length > 0 ? new Date(invoices[0].dueDate).toLocaleDateString() :"—"}</p>
 </div>
 <div>
 <p className="text-muted-foreground">{t("admin_billing_total_revenue", "Toplam Gelir")}</p>
 <p className="text-lg font-medium text-foreground">{t("currency_symbol", "$")}{totalPaid.toLocaleString()}</p>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </TabsContent>

 <TabsContent value="plans" className="space-y-6 mt-6">
 <div className="flex justify-center mb-6">
 <div className="flex items-center gap-2 bg-card p-1 rounded-lg">
 <Button variant={billingCycle ==="monthly" ?"default" :"ghost"} size="sm" onClick={() => setBillingCycle("monthly")} className={billingCycle ==="monthly" ?"bg-muted" :"text-muted-foreground"}>{t("admin_billing_monthly", "Aylık Ödeme")}</Button>
 <Button variant={billingCycle ==="yearly" ?"default" :"ghost"} size="sm" onClick={() => setBillingCycle("yearly")} className={billingCycle ==="yearly" ?"bg-muted" :"text-muted-foreground"}>{t("admin_billing_yearly_20_discount", "Yıllık")}</Button>
 </div>
 </div>
 <div className="grid gap-6 md:grid-cols-3">
 {plans.length === 0 ? (
 <p className="text-center text-muted-foreground col-span-3 py-8">{t("admin_billing_no_plans", "Kullanılabilir plan yok")}</p>
 ) : plans.map(plan => (
 <Card key={plan.id} className={`bg-card border-border ${plan.isActive ? 'ring-2 ring-slate-500' : ''}`}>
 <CardHeader>
 <CardTitle className="flex items-center justify-between text-foreground">
 {plan.name}
 {plan.isActive && <Badge className="bg-muted">{t("admin_billing_current", "Mevcut")}</Badge>}
 </CardTitle>
 <div>
 <p className="text-3xl font-bold text-foreground">{t("currency_symbol", "$")}{plan.price}<span className="text-lg font-normal text-muted-foreground">{t("/", "/")}{plan.interval}</span></p>
 </div>
 </CardHeader>
 <CardContent>
 <Button className="w-full" variant={plan.isActive ?"outline" :"default"} disabled={plan.isActive}>
 {plan.isActive ? t("admin_billing_current_plan", "Mevcut Plan") : t("admin_billing_select", "Seçme")}
 </Button>
 </CardContent>
 </Card>
 ))}
 </div>
 </TabsContent>

 <TabsContent value="billing" className="space-y-6 mt-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_billing_invoice_history", "Fatura Geçmişi")}</CardTitle>
 </CardHeader>
 <CardContent>
 {invoicesLoading ? (
 <div className="flex justify-center py-8"><Loader2 className="w-6 h-6 animate-spin text-muted-foreground" /></div>
 ) : invoices.length === 0 ? (
 <p className="text-center text-muted-foreground py-8">{t("admin_billing_no_invoices", "Fatura yok")}</p>
 ) : (
 <div className="space-y-4">
 {invoices.map(invoice => (
 <div key={invoice.id} className="flex items-center justify-between p-4 bg-card rounded-lg border border-border">
 <div>
 <p className="font-medium text-foreground">{invoice.invoiceNumber}</p>
 <p className="text-sm text-muted-foreground">{new Date(invoice.createdAt).toLocaleDateString()}</p>
 </div>
 <div className="text-right">
 <p className="font-medium text-foreground">{t("currency_symbol", "$")}{invoice.total.toLocaleString()}</p>
 <Badge className={invoice.status ==="PAID" || invoice.status ==="paid" ?"bg-blue-500/20 text-success border-0" :"bg-amber-500/20 text-warning border-0"}>
 {invoice.status}
 </Badge>
 </div>
 <Button variant="outline" size="sm" className="bg-card border-border text-muted-foreground hover:bg-muted dark:hover:bg-card/10">
 <Download className="w-4 h-4 mr-2" />{t("admin_billing_download", "Pdf İndir")}
 </Button>
 </div>
 ))}
 </div>
 )}
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="payment" className="space-y-6 mt-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_billing_payment_methods", "Ödeme Yöntemleri")}</CardTitle>
 </CardHeader>
 <CardContent>
 <p className="text-center text-muted-foreground py-8">{t("admin_billing_no_payment_methods", "Hiçbir ödeme yöntemi yapılandırılmadı")}</p>
 <Button className="w-full bg-card border-border text-foreground hover:bg-muted dark:hover:bg-card/10">{t("admin_billing_add_payment_method", "Ödeme Yöntemi Ekle")}</Button>
 </CardContent>
 </Card>
 </TabsContent>
 </Tabs>
 </div>
 );
}
