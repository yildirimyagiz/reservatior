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

 return (
 <div className="space-y-6 min-h-screen">
 <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center gap-4">
 <div className="p-3 bg-slate-600 rounded-xl shadow-lg shadow-slate-600/20">
 <CreditCard className="w-8 h-8 text-foreground" />
 </div>
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground">
 {t("admin_billing_billing","Billing")}
 </h1>
 <p className="text-muted-foreground">
 {t("admin_billing_subscription_and_payment_management","Subscription and payment management")}
 </p>
 </div>
 </div>
 </div>

 <Tabs defaultValue="overview" className="w-full">
 <TabsList className="bg-card border border-border">
 <TabsTrigger value="overview" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">{t("admin_billing_overview","Overview")}</TabsTrigger>
 <TabsTrigger value="plans" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">{t("admin_billing_plans","Plans")}</TabsTrigger>
 <TabsTrigger value="billing" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">{t("admin_billing_invoices","Invoices")}</TabsTrigger>
 <TabsTrigger value="payment" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">{t("admin_billing_payment_methods","Payment Methods")}</TabsTrigger>
 </TabsList>

 <TabsContent value="overview" className="space-y-6 mt-6">
 <div className="grid gap-6 md:grid-cols-2">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_billing_current_plan","Current Plan")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 <h3 className="text-2xl font-bold text-foreground">{currentPlan?.name || t("admin_billing_no_plan","No Plan")}</h3>
 <p className="text-3xl font-bold text-foreground">${currentPlan?.price || 0}<span className="text-lg font-normal text-muted-foreground">/{currentPlan?.interval ||"mo"}</span></p>
 <Badge className="bg-emerald-500/20 text-emerald-400 border-0">{t("admin_billing_active","Active")}</Badge>
 <div className="space-y-2 text-sm text-muted-foreground">
 <p>{t("admin_billing_total_paid","Total Paid")}: ${totalPaid.toLocaleString()}</p>
 <p>{invoices.length} {t("admin_billing_invoices","invoices")}</p>
 </div>
 </div>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_billing_billing_info","Billing Info")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4 text-sm">
 <div>
 <p className="text-muted-foreground">{t("admin_billing_next_billing_date","Next Billing Date")}</p>
 <p className="text-lg font-medium text-foreground">{invoices.length > 0 ? new Date(invoices[0].dueDate).toLocaleDateString() :"—"}</p>
 </div>
 <div>
 <p className="text-muted-foreground">{t("admin_billing_total_revenue","Total Revenue")}</p>
 <p className="text-lg font-medium text-foreground">${totalPaid.toLocaleString()}</p>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </TabsContent>

 <TabsContent value="plans" className="space-y-6 mt-6">
 <div className="flex justify-center mb-6">
 <div className="flex items-center gap-2 bg-card p-1 rounded-lg">
 <Button variant={billingCycle ==="monthly" ?"default" :"ghost"} size="sm" onClick={() => setBillingCycle("monthly")} className={billingCycle ==="monthly" ?"bg-slate-600" :"text-slate-300"}>{t("admin_billing_monthly","Monthly")}</Button>
 <Button variant={billingCycle ==="yearly" ?"default" :"ghost"} size="sm" onClick={() => setBillingCycle("yearly")} className={billingCycle ==="yearly" ?"bg-slate-600" :"text-slate-300"}>{t("admin_billing_yearly_20_discount","Yearly")}</Button>
 </div>
 </div>
 <div className="grid gap-6 md:grid-cols-3">
 {plans.length === 0 ? (
 <p className="text-center text-slate-500 col-span-3 py-8">{t("admin_billing_no_plans","No plans available")}</p>
 ) : plans.map(plan => (
 <Card key={plan.id} className={`bg-card border-border ${plan.isActive ? 'ring-2 ring-slate-500' : ''}`}>
 <CardHeader>
 <CardTitle className="flex items-center justify-between text-foreground">
 {plan.name}
 {plan.isActive && <Badge className="bg-slate-600">{t("admin_billing_current","Current")}</Badge>}
 </CardTitle>
 <div>
 <p className="text-3xl font-bold text-foreground">${plan.price}<span className="text-lg font-normal text-muted-foreground">/{plan.interval}</span></p>
 </div>
 </CardHeader>
 <CardContent>
 <Button className="w-full" variant={plan.isActive ?"outline" :"default"} disabled={plan.isActive}>
 {plan.isActive ? t("admin_billing_current_plan","Current Plan") : t("admin_billing_select","Select")}
 </Button>
 </CardContent>
 </Card>
 ))}
 </div>
 </TabsContent>

 <TabsContent value="billing" className="space-y-6 mt-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_billing_invoice_history","Invoice History")}</CardTitle>
 </CardHeader>
 <CardContent>
 {invoicesLoading ? (
 <div className="flex justify-center py-8"><Loader2 className="w-6 h-6 animate-spin text-muted-foreground" /></div>
 ) : invoices.length === 0 ? (
 <p className="text-center text-slate-500 py-8">{t("admin_billing_no_invoices","No invoices")}</p>
 ) : (
 <div className="space-y-4">
 {invoices.map(invoice => (
 <div key={invoice.id} className="flex items-center justify-between p-4 bg-card rounded-lg border border-border">
 <div>
 <p className="font-medium text-foreground">{invoice.invoiceNumber}</p>
 <p className="text-sm text-muted-foreground">{new Date(invoice.createdAt).toLocaleDateString()}</p>
 </div>
 <div className="text-right">
 <p className="font-medium text-foreground">${invoice.total.toLocaleString()}</p>
 <Badge className={invoice.status ==="PAID" || invoice.status ==="paid" ?"bg-emerald-500/20 text-emerald-400 border-0" :"bg-amber-500/20 text-amber-400 border-0"}>
 {invoice.status}
 </Badge>
 </div>
 <Button variant="outline" size="sm" className="bg-card border-border text-slate-300 hover:bg-white/10">
 <Download className="w-4 h-4 mr-2" />{t("admin_billing_download","Download")}
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
 <CardTitle className="text-foreground">{t("admin_billing_payment_methods","Payment Methods")}</CardTitle>
 </CardHeader>
 <CardContent>
 <p className="text-center text-slate-500 py-8">{t("admin_billing_no_payment_methods","No payment methods configured")}</p>
 <Button className="w-full bg-card border-border text-foreground hover:bg-white/10">{t("admin_billing_add_payment_method","Add Payment Method")}</Button>
 </CardContent>
 </Card>
 </TabsContent>
 </Tabs>
 </div>
 );
}
