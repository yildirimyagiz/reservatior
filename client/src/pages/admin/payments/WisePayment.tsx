import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { CreditCard, DollarSign, Shield, CheckCircle, AlertTriangle, Globe, Clock, Zap, TrendingUp } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
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
  const {
    t
  } = useTranslation();
  const [paymentForm, setPaymentForm] = useState<WisePaymentForm>({
    amount: "",
    currency: "USD",
    recipientEmail: "",
    recipientName: "",
    description: ""
  });
  const [transactions, setTransactions] = useState<WiseTransaction[]>([]);
  const [processing, setProcessing] = useState(false);
  const [balance, setBalance] = useState({
    amount: 0,
    currency: "USD"
  });
  const {
    toast
  } = useToast();

  // Mock balance fetch
  useEffect(() => {
    setBalance({
      amount: 5000.00,
      currency: "USD"
    });

    // Mock transactions
    setTransactions([{
      id: "tx_001",
      amount: 1000.00,
      currency: "USD",
      status: "COMPLETED",
      createdAt: "2026-03-15T10:30:00Z",
      recipientEmail: "agent@example.com",
      recipientName: "John Agent",
      description: t("admin.payments.monthly_commission_payment"),
      fee: 15.00,
      totalAmount: 1015.00
    }, {
      id: "tx_002",
      amount: 2500.00,
      currency: "USD",
      status: "PROCESSING",
      createdAt: "2026-03-20T14:20:00Z",
      recipientEmail: "vendor@example.com",
      recipientName: "Tech Services LLC",
      description: t("admin.payments.platform_maintenance_fee"),
      fee: 37.50,
      totalAmount: 2537.50
    }]);
  }, []);
  const handlePayment = async () => {
    if (!paymentForm.amount || !paymentForm.recipientEmail || !paymentForm.recipientName) {
      toast({
        title: t("admin.payments.missing_information"),
        description: t("admin.payments.please_fill_in_all"),
        variant: "destructive"
      });
      return;
    }
    setProcessing(true);
    try {
      // Wise API call via our backend
      const result = (await apiClient.post('/wise/payment', {
        ...paymentForm,
        amount: parseFloat(paymentForm.amount),
        sourceCurrency: "USD",
        targetCurrency: paymentForm.currency
      })) as any;
      toast({
        title: t("admin.payments.payment_initiated"),
        description: `Payment of ${paymentForm.amount} ${paymentForm.currency} sent successfully.`
      });

      // Reset form
      setPaymentForm({
        amount: "",
        currency: "USD",
        recipientEmail: "",
        recipientName: "",
        description: ""
      });

      // Add to transactions list
      const newTransaction: WiseTransaction = {
        id: result.id || `tx_${Date.now()}`,
        amount: parseFloat(paymentForm.amount),
        currency: paymentForm.currency,
        status: "PENDING",
        createdAt: new Date().toISOString(),
        recipientEmail: paymentForm.recipientEmail,
        recipientName: paymentForm.recipientName,
        description: paymentForm.description,
        fee: parseFloat(paymentForm.amount) * 0.015,
        // 1.5% fee
        totalAmount: parseFloat(paymentForm.amount) * 1.015
      };
      setTransactions(prev => [newTransaction, ...prev]);
    } catch (error) {
      toast({
        title: t("admin.payments.payment_failed"),
        description: error instanceof Error ? error.message : "Payment processing failed.",
        variant: "destructive"
      });
    } finally {
      setProcessing(false);
    }
  };
  const getLocalizedStatus = (status: string) => {
    const map: Record<string, string> = {
      'COMPLETED': t('admin.payments.status_completed', 'Tamamlandı'),
      'PROCESSING': t('admin.payments.status_processing', 'İşleniyor'),
      'FAILED': t('admin.payments.status_failed', 'Başarısız'),
      'CANCELLED': t('admin.payments.status_cancelled', 'İptal Edildi')
    };
    return map[status] || status;
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'COMPLETED':
        return 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20';
      case 'PROCESSING':
        return 'bg-blue-500/10 text-blue-400 border-blue-500/20';
      case 'FAILED':
        return 'bg-red-500/10 text-red-400 border-red-500/20';
      case 'CANCELLED':
        return 'bg-slate-500/10 text-muted-foreground border-slate-500/20';
      default:
        return 'bg-orange-500/10 text-orange-400 border-orange-500/20';
    }
  };
  const getStatusIcon = (status: string) => {
    switch (status) {
      case 'COMPLETED':
        return <CheckCircle className="w-4 h-4" />;
      case 'PROCESSING':
        return <Clock className="w-4 h-4" />;
      case 'FAILED':
        return <AlertTriangle className="w-4 h-4" />;
      case 'CANCELLED':
        return <AlertTriangle className="w-4 h-4" />;
      default:
        return <Clock className="w-4 h-4" />;
    }
  };
  return <PageShell title={t("admin.payments.wise_payment_integration")} description={t("admin.payments.global_payment_processing_with")}>
      <div className="max-w-6xl mx-auto px-4 lg:px-8 py-10 space-y-8">
        
        {/* Header */}
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-3xl font-bold text-foreground">{t("admin.payments.wise_payment_hub")}</h1>
            <p className="text-sm text-muted-foreground mt-1">{t("admin.payments.send_payments_globally_with")}</p>
          </div>
          
          <div className="flex items-center gap-4">
            <div className="text-right">
              <p className="text-xs text-muted-foreground">{t("admin.payments.available_balance")}</p>
              <p className="text-2xl font-bold text-foreground">
                ${balance.amount.toLocaleString()} {balance.currency}
              </p>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          
          {/* Payment Form */}
          <Card className="bg-card border-border rounded-3xl p-8">
            <CardHeader>
              <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                <CreditCard className="w-5 h-5 text-blue-500" />{t("admin.payments.send_payment")}</CardTitle>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="space-y-2">
                <Label htmlFor="amount" className="text-[10px] font-bold text-muted-foreground">{t("admin.payments.amount")}</Label>
                <Input id="amount" type="number" value={paymentForm.amount} onChange={e => setPaymentForm(prev => ({
                ...prev,
                amount: e.target.value
              }))} placeholder="1000.00" className="bg-muted/50 border-border text-foreground" />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="currency" className="text-[10px] font-bold text-muted-foreground">{t("admin.payments.currency")}</Label>
                <Select value={paymentForm.currency} onValueChange={value => setPaymentForm(prev => ({
                ...prev,
                currency: value
              }))}>
                  <SelectTrigger className="bg-muted/50 border-border text-foreground">
                    <SelectValue placeholder={t("admin.payments.select_currency")} />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-border">
                    <SelectItem value="USD">{t("admin.payments.usd_us_dollar")}</SelectItem>
                    <SelectItem value="EUR">{t("admin.payments.eur_euro")}</SelectItem>
                    <SelectItem value="GBP">{t("admin.payments.gbp_british_pound")}</SelectItem>
                    <SelectItem value="TRY">{t("admin.payments.try_turkish_lira")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="recipientName" className="text-[10px] font-bold text-muted-foreground">{t("admin.payments.recipient_name")}</Label>
                <Input id="recipientName" value={paymentForm.recipientName} onChange={e => setPaymentForm(prev => ({
                ...prev,
                recipientName: e.target.value
              }))} placeholder={t("admin.payments.john_doe")} className="bg-muted/50 border-border text-foreground" />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="recipientEmail" className="text-[10px] font-bold text-muted-foreground">{t("admin.payments.recipient_email")}</Label>
                <Input id="recipientEmail" type="email" value={paymentForm.recipientEmail} onChange={e => setPaymentForm(prev => ({
                ...prev,
                recipientEmail: e.target.value
              }))} placeholder={t("admin.payments.johnexamplecom")} className="bg-muted/50 border-border text-foreground" />
              </div>
              
              <div className="space-y-2">
                <Label htmlFor="description" className="text-[10px] font-bold text-muted-foreground">{t("admin.payments.description")}</Label>
                <Input id="description" value={paymentForm.description} onChange={e => setPaymentForm(prev => ({
                ...prev,
                description: e.target.value
              }))} placeholder={t("admin.payments.payment_for_services_rendered")} className="bg-muted/50 border-border text-foreground" />
              </div>
              
              <div className="bg-muted/50 rounded-2xl p-4 border border-border">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">{t("admin.payments.transfer_fee_15")}</span>
                  <span className="text-foreground font-bold">
                    ${paymentForm.amount ? (parseFloat(paymentForm.amount) * 0.015).toFixed(2) : '0.00'}
                  </span>
                </div>
                <div className="flex items-center justify-between text-sm font-bold text-foreground pt-2 border-t border-border">
                  <span>{t("admin.payments.total_amount")}</span>
                  <span>
                    ${paymentForm.amount ? (parseFloat(paymentForm.amount) * 1.015).toFixed(2) : '0.00'} {paymentForm.currency}
                  </span>
                </div>
              </div>
              
              <Button onClick={handlePayment} disabled={processing} className="w-full h-14 rounded-2xl bg-blue-600 hover:bg-blue-500 text-foreground font-bold text-xs shadow-2xl shadow-blue-600/30">
                {processing ? <>
                    <div className="w-4 h-4 mr-2 border-2 border-border border-t-white rounded-full animate-spin" />{t("admin.payments.processing_payment")}</> : <>
                    <DollarSign className="w-4 h-4 mr-2" />{t("admin.payments.send_payment")}</>}
              </Button>
            </CardContent>
          </Card>

          {/* Transactions & Analytics */}
          <div className="space-y-8">
            
            {/* Quick Stats */}
            <div className="grid grid-cols-2 gap-4">
              <Card className="bg-card border-border rounded-3xl p-6">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-xl bg-emerald-500/20 flex items-center justify-center">
                    <TrendingUp className="w-5 h-5 text-emerald-400" />
                  </div>
                  <div>
                    <p className="text-[10px] font-bold text-muted-foreground">{t("admin.payments.monthly_volume")}</p>
                    <p className="text-xl font-bold text-foreground">$12,450</p>
                  </div>
                </div>
              </Card>
              
              <Card className="bg-card border-border rounded-3xl p-6">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-xl bg-orange-500/20 flex items-center justify-center">
                    <Zap className="w-5 h-5 text-orange-400" />
                  </div>
                  <div>
                    <p className="text-[10px] font-bold text-muted-foreground">{t("admin.payments.avg_transaction")}</p>
                    <p className="text-xl font-bold text-foreground">$415.00</p>
                  </div>
                </div>
              </Card>
            </div>

            {/* Recent Transactions */}
            <Card className="bg-card border-border rounded-3xl p-8">
              <CardHeader>
                <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
                  <Globe className="w-5 h-5 text-violet-500" />{t("admin.payments.recent_transactions")}</CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                {transactions.map(transaction => <motion.div key={transaction.id} initial={{
                opacity: 0,
                y: 10
              }} animate={{
                opacity: 1,
                y: 0
              }} className="bg-muted/50 rounded-2xl p-4 border border-border">
                    <div className="flex items-center justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-2">
                          {getStatusIcon(transaction.status)}
                          <Badge className={cn("text-[9px] font-bold   px-2 border-0 shadow-lg", getStatusColor(transaction.status))}>
                            {getLocalizedStatus(transaction.status)}
                          </Badge>
                        </div>
                        
                        <div className="space-y-1">
                          <p className="text-sm font-medium text-foreground">{transaction.recipientName}</p>
                          <p className="text-xs text-muted-foreground">{transaction.recipientEmail}</p>
                          <p className="text-xs text-muted-foreground">{transaction.description}</p>
                        </div>
                      </div>
                      
                      <div className="text-right">
                        <p className="text-lg font-bold text-foreground">
                          ${transaction.amount.toLocaleString()} {transaction.currency}
                        </p>
                        <p className="text-xs text-muted-foreground">{t("admin.payments.fee")}{transaction.fee.toFixed(2)}
                        </p>
                        <p className="text-xs text-muted-foreground">
                          {new Date(transaction.createdAt).toLocaleDateString()}
                        </p>
                      </div>
                    </div>
                  </motion.div>)}
              </CardContent>
            </Card>
          </div>
        </div>

        {/* Security Notice */}
        <Card className="bg-card border-border rounded-3xl p-6">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-blue-500/20 flex items-center justify-center">
              <Shield className="w-5 h-5 text-blue-400" />
            </div>
            <div className="flex-1">
              <p className="text-sm text-muted-foreground">
                <strong className="text-foreground">{t("admin.payments.security_notice")}</strong>{t("admin.payments.all_payments_are_processed")}</p>
            </div>
          </div>
        </Card>
      </div>
    </PageShell>;
}