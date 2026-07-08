"use client";

import { useTranslation } from "react-i18next";
import { useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { CreditCard, DollarSign, Shield, CheckCircle, AlertTriangle, Globe, Clock, Zap, TrendingUp, Loader2 } from "lucide-react";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";

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
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  const [paymentForm, setPaymentForm] = useState<WisePaymentForm>({
    amount: "", currency: "USD", recipientEmail: "", recipientName: "", description: "",
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
        sourceCurrency: "USD",
        targetCurrency: data.currency,
      });
    },
    onSuccess: () => {
      toast({ title: t("admin_payments_payment_initiated"), description: t("admin_payments_payment_sent") });
      setPaymentForm({ amount: "", currency: "USD", recipientEmail: "", recipientName: "", description: "" });
      queryClient.invalidateQueries({ queryKey: ['wise-transactions'] });
    },
    onError: (err: any) => {
      toast({ title: t("admin_payments_payment_failed"), description: err.message, variant: "destructive" });
    },
  });

  const handlePayment = () => {
    if (!paymentForm.amount || !paymentForm.recipientEmail || !paymentForm.recipientName) {
      toast({ title: t("admin_payments_missing_information"), description: t("admin_payments_please_fill_in_all"), variant: "destructive" });
      return;
    }
    createMutation.mutate(paymentForm);
  };

  const statusConfig: Record<string, { label: string; class: string }> = {
    COMPLETED: { label: t("admin_payments_completed", "Completed"), class: "bg-emerald-500/20 text-emerald-400 border-emerald-500/20" },
    PROCESSING: { label: t("admin_payments_processing", "Processing"), class: "bg-slate-500/20 text-slate-500 dark:text-slate-400 border-slate-500/20" },
    FAILED: { label: t("admin_payments_failed", "Failed"), class: "bg-red-500/20 text-red-400 border-red-500/20" },
    CANCELLED: { label: t("admin_payments_cancelled", "Cancelled"), class: "bg-slate-500/20 text-slate-500 dark:text-slate-400 border-slate-500/20" },
    PENDING: { label: t("admin_payments_pending", "Pending"), class: "bg-amber-500/20 text-amber-400 border-amber-500/20" },
  };

  const monthlyVolume = transactions.filter(t => t.status === "COMPLETED").reduce((s, t) => s + t.amount, 0);
  const avgTransaction = transactions.length > 0 ? monthlyVolume / transactions.length : 0;

  return (
    <div className="space-y-6 min-h-screen">
      <div className="flex justify-between items-center bg-white/5 p-6 rounded-2xl border border-slate-200 dark:border-white/10">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-slate-600 rounded-xl shadow-lg shadow-slate-600/20">
            <CreditCard className="w-8 h-8 text-slate-900 dark:text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-slate-900 dark:text-white">
              {t("admin_payments_wise_payment_hub", "Wise Payment Hub")}
            </h1>
            <p className="text-slate-500 dark:text-slate-400">
              {t("admin_payments_global_payment_processing_with", "Global payment processing with Wise")}
            </p>
          </div>
        </div>
        <div className="text-right">
          <p className="text-xs text-slate-500 dark:text-slate-400">{t("admin_payments_total_sent", "Total Sent")}</p>
          <p className="text-2xl font-bold text-slate-900 dark:text-white">${monthlyVolume.toLocaleString()}</p>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <Card className="bg-white/5 border-slate-200 dark:border-white/10 p-6">
          <CardHeader className="px-0 pt-0">
            <CardTitle className="text-slate-900 dark:text-white flex items-center gap-2">
              <CreditCard className="w-5 h-5 text-slate-500 dark:text-slate-400" />
              {t("admin_payments_send_payment", "Send Payment")}
            </CardTitle>
          </CardHeader>
          <CardContent className="px-0 pb-0 space-y-4">
            <div className="space-y-2">
              <Label className="text-xs text-slate-500 dark:text-slate-400">{t("admin_payments_amount", "Amount")}</Label>
              <Input type="number" value={paymentForm.amount} onChange={e => setPaymentForm(prev => ({ ...prev, amount: e.target.value }))} placeholder="1000.00" className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white placeholder:text-slate-500" />
            </div>
            <div className="space-y-2">
              <Label className="text-xs text-slate-500 dark:text-slate-400">{t("admin_payments_currency", "Currency")}</Label>
              <Select value={paymentForm.currency} onValueChange={value => setPaymentForm(prev => ({ ...prev, currency: value }))}>
                <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white"><SelectValue /></SelectTrigger>
                <SelectContent className="bg-white dark:bg-slate-900 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                  <SelectItem value="USD">USD - US Dollar</SelectItem>
                  <SelectItem value="EUR">EUR - Euro</SelectItem>
                  <SelectItem value="GBP">GBP - British Pound</SelectItem>
                  <SelectItem value="TRY">TRY - Turkish Lira</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label className="text-xs text-slate-500 dark:text-slate-400">{t("admin_payments_recipient_name", "Recipient Name")}</Label>
              <Input value={paymentForm.recipientName} onChange={e => setPaymentForm(prev => ({ ...prev, recipientName: e.target.value }))} placeholder="John Doe" className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white placeholder:text-slate-500" />
            </div>
            <div className="space-y-2">
              <Label className="text-xs text-slate-500 dark:text-slate-400">{t("admin_payments_recipient_email", "Recipient Email")}</Label>
              <Input type="email" value={paymentForm.recipientEmail} onChange={e => setPaymentForm(prev => ({ ...prev, recipientEmail: e.target.value }))} placeholder="john@example.com" className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white placeholder:text-slate-500" />
            </div>
            <div className="space-y-2">
              <Label className="text-xs text-slate-500 dark:text-slate-400">{t("admin_payments_description", "Description")}</Label>
              <Input value={paymentForm.description} onChange={e => setPaymentForm(prev => ({ ...prev, description: e.target.value }))} placeholder="Payment for services" className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white placeholder:text-slate-500" />
            </div>
            <div className="bg-white/5 rounded-xl p-4 space-y-2">
              <div className="flex justify-between text-sm"><span className="text-slate-500 dark:text-slate-400">{t("admin_payments_transfer_fee", "Transfer Fee")}</span><span className="text-slate-900 dark:text-white font-bold">${paymentForm.amount ? (parseFloat(paymentForm.amount) * 0.015).toFixed(2) : '0.00'}</span></div>
              <div className="flex justify-between text-sm font-bold border-t border-slate-200 dark:border-white/10 pt-2"><span className="text-slate-900 dark:text-white">{t("admin_payments_total", "Total")}</span><span className="text-slate-900 dark:text-white">${paymentForm.amount ? (parseFloat(paymentForm.amount) * 1.015).toFixed(2) : '0.00'}</span></div>
            </div>
            <Button onClick={handlePayment} disabled={createMutation.isPending} className="w-full bg-slate-600 hover:bg-slate-700 text-slate-900 dark:text-white shadow-lg shadow-slate-500/20">
              {createMutation.isPending ? <><Loader2 className="w-4 h-4 mr-2 animate-spin" />{t("admin_payments_processing", "Processing")}</> : <><DollarSign className="w-4 h-4 mr-2" />{t("admin_payments_send_payment", "Send Payment")}</>}
            </Button>
          </CardContent>
        </Card>

        <div className="space-y-6">
          <div className="grid grid-cols-2 gap-4">
            <Card className="bg-white/5 border-slate-200 dark:border-white/10 p-6">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl bg-emerald-500/20 flex items-center justify-center">
                  <TrendingUp className="w-5 h-5 text-emerald-400" />
                </div>
                <div>
                  <p className="text-xs text-slate-500 dark:text-slate-400">{t("admin_payments_monthly_volume", "Monthly Volume")}</p>
                  <p className="text-xl font-bold text-slate-900 dark:text-white">${monthlyVolume.toLocaleString()}</p>
                </div>
              </div>
            </Card>
            <Card className="bg-white/5 border-slate-200 dark:border-white/10 p-6">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl bg-orange-500/20 flex items-center justify-center">
                  <Zap className="w-5 h-5 text-orange-400" />
                </div>
                <div>
                  <p className="text-xs text-slate-500 dark:text-slate-400">{t("admin_payments_avg_transaction", "Avg Transaction")}</p>
                  <p className="text-xl font-bold text-slate-900 dark:text-white">${avgTransaction.toFixed(2)}</p>
                </div>
              </div>
            </Card>
          </div>

          <Card className="bg-white/5 border-slate-200 dark:border-white/10 p-6">
            <CardHeader className="px-0 pt-0">
              <CardTitle className="text-slate-900 dark:text-white flex items-center gap-2">
                <Globe className="w-5 h-5 text-slate-500 dark:text-slate-400" />
                {t("admin_payments_recent_transactions", "Recent Transactions")}
              </CardTitle>
            </CardHeader>
            <CardContent className="px-0 pb-0 space-y-4">
              {isLoading ? (
                <div className="flex justify-center py-8"><Loader2 className="w-6 h-6 animate-spin text-slate-500 dark:text-slate-400" /></div>
              ) : transactions.length === 0 ? (
                <p className="text-center text-slate-500 py-8">{t("admin_payments_no_transactions", "No transactions")}</p>
              ) : transactions.slice(0, 10).map(transaction => {
                const cfg = statusConfig[transaction.status] || statusConfig.PENDING;
                return (
                  <div key={transaction.id} className="bg-white/5 rounded-xl p-4 border border-slate-200 dark:border-white/10">
                    <div className="flex items-center justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-2">
                          {transaction.status === "COMPLETED" ? <CheckCircle className="w-4 h-4 text-emerald-400" /> :
                           transaction.status === "FAILED" ? <AlertTriangle className="w-4 h-4 text-red-400" /> :
                           <Clock className="w-4 h-4 text-slate-500 dark:text-slate-400" />}
                          <Badge className={cn("border-0 text-[10px]", cfg.class)}>{cfg.label}</Badge>
                        </div>
                        <p className="text-sm font-medium text-slate-900 dark:text-white">{transaction.recipientName}</p>
                        <p className="text-xs text-slate-500 dark:text-slate-400">{transaction.recipientEmail}</p>
                        <p className="text-xs text-slate-500">{transaction.description}</p>
                      </div>
                      <div className="text-right">
                        <p className="text-lg font-bold text-slate-900 dark:text-white">${transaction.amount.toLocaleString()}</p>
                        <p className="text-xs text-slate-500 dark:text-slate-400">{t("admin_payments_fee", "Fee")}: ${transaction.fee.toFixed(2)}</p>
                        <p className="text-xs text-slate-500">{new Date(transaction.createdAt).toLocaleDateString()}</p>
                      </div>
                    </div>
                  </div>
                );
              })}
            </CardContent>
          </Card>

          <Card className="bg-white/5 border-slate-200 dark:border-white/10 p-4">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-slate-500/20 flex items-center justify-center">
                <Shield className="w-5 h-5 text-slate-500 dark:text-slate-400" />
              </div>
              <p className="text-sm text-slate-500 dark:text-slate-400">
                <strong className="text-slate-900 dark:text-white">{t("admin_payments_security_notice", "Security Notice")}: </strong>
                {t("admin_payments_all_payments_secured", "All payments are processed securely through Wise")}
              </p>
            </div>
          </Card>
        </div>
      </div>
    </div>
  );
}
