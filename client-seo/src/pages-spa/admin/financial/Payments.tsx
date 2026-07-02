import { t } from "i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { paymentsApi, type Payment, PaymentLedgerStatus } from "@/lib/api/payments";
import { Edit, Trash2, MoreHorizontal, CheckCircle2, Clock, AlertCircle, TrendingUp, Plus, Search, Loader2, CreditCard, Activity, DollarSign, Shield, Zap, Maximize2, Copy } from "lucide-react";
import { useTranslation } from "react-i18next";
import { cn } from "@/lib/utils";
import { motion, AnimatePresence } from "framer-motion";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
const STATUS_CONFIG = (t: any) => {
  return {
    PAID: {
      label: t("paid"),
      cls: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20",
      icon: CheckCircle2
    },
    UNPAID: {
      label: t("financialPayoutsStatusPending"),
      cls: "bg-orange-500/10 text-orange-400 border-orange-500/20",
      icon: Clock
    },
    OVERDUE: {
      label: t("failed"),
      cls: "bg-red-500/10 text-red-400 border-red-500/20",
      icon: AlertCircle
    },
    REFUNDED: {
      label: t("admin.financial.refunded"),
      cls: "bg-blue-500/10 text-blue-400 border-blue-500/20",
      icon: TrendingUp
    },
    PARTIAL: {
      label: t("admin.financial.partial"),
      cls: "bg-purple-500/10 text-purple-400 border-purple-500/20",
      icon: AlertCircle
    }
  };
};
export default function Payments() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/api/v1/unknown/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  
  
    
  const {
    t
  } = useTranslation();
  const statusConfig = STATUS_CONFIG(t);
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterProperty, setFilterProperty] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedPayment, setSelectedPayment] = useState<Payment | null>(null);
  const { data: paymentsData, isLoading: loading } = useQuery({
    queryKey: ['adminPayments'],
    queryFn: async () => {
      try {
        const response = await paymentsApi.getPayments();
        return Array.isArray(response) ? response : (response as any).data?.data || [];
      } catch (error) {
        console.error('Error fetching payments:', error);
        toast({
          title: t("admin.financial.error"),
          description: t("admin.financial.failed_to_load_payments"),
          variant: "destructive"
        });
        return [];
      }
    }
  });

  const payments = (paymentsData as Payment[]) || [];
  const filteredPayments = payments.filter(payment => {
    const matchesSearch = (payment.tenant?.name || "").toLowerCase().includes(search.toLowerCase()) || (payment.property?.name || "").toLowerCase().includes(search.toLowerCase()) || (payment.reference || "").toLowerCase().includes(search.toLowerCase());
    const matchesStatus = filterStatus === "all" || payment.status === filterStatus;
    const matchesProperty = filterProperty === "all" || payment.propertyId === filterProperty;
    return matchesSearch && matchesStatus && matchesProperty;
  });
  const totalPayments = filteredPayments.length;
  const paidCount = filteredPayments.filter(p => p.status === PaymentLedgerStatus.PAID).length;
  const unpaidCount = filteredPayments.filter(p => p.status === PaymentLedgerStatus.UNPAID).length;
  const overdueCount = filteredPayments.filter(p => p.status === PaymentLedgerStatus.OVERDUE).length;
  const createPaymentMutation = useMutation({
    mutationFn: async (data: any) => paymentsApi.createPayment(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['adminPayments'] });
      setCreateOpen(false);
      toast({
        title: t("admin.financial.payment_created"),
        description: t("admin.financial.new_payment_has_been")
      });
    },
    onError: () => {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_create_payment"),
        variant: "destructive"
      });
    }
  });

  const updatePaymentMutation = useMutation({
    mutationFn: async ({ id, data }: { id: string, data: any }) => paymentsApi.updatePayment(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['adminPayments'] });
      setEditOpen(false);
      toast({
        title: t("admin.financial.payment_updated"),
        description: t("admin.financial.payment_has_been_updated")
      });
    },
    onError: () => {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_update_payment"),
        variant: "destructive"
      });
    }
  });

  const deletePaymentMutation = useMutation({
    mutationFn: async (id: string) => paymentsApi.deletePayment(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['adminPayments'] });
      toast({
        title: t("admin.financial.payment_deleted"),
        description: t("admin.financial.payment_has_been_deleted")
      });
    },
    onError: () => {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_delete_payment"),
        variant: "destructive"
      });
    }
  });

  const handleCreatePayment = (data: any) => createPaymentMutation.mutate(data);
  const handleUpdatePayment = (id: string, data: any) => updatePaymentMutation.mutate({ id, data });
  const handleDeletePayment = (id: string) => {
    if (!confirm(t("admin.financial.are_you_sure", "Emin misiniz?"))) return;
    deletePaymentMutation.mutate(id);
  };
  const formatDate = (dateString?: string) => {
    if (!dateString) return "-";
    return new Date(dateString).toLocaleDateString();
  };
  const formatCurrency = (amount: number, currency: string) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency
    }).format(amount);
  };
  return <PageShell title={t("financialPaymentsTitle")} description={t("financialPaymentsDesc")}>
      <div className="space-y-10 pb-20 selection:bg-primary/30">
        {/* KPI Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 px-4">
          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.1
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-muted/50">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-blue-500">
                <Zap className="w-10 h-10" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("total")}</p>
                <h3 className="text-xl font-bold text-foreground leading-none">{totalPayments}</h3>
                <p className="text-[10px] font-bold text-muted-foreground mt-4 flex items-center gap-1">{t("admin.financial.globalflow")}</p>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.2
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t border-l-emerald-500/30 transition-all hover:bg-muted/50">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
                <CheckCircle2 className="w-10 h-10" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("paid")}</p>
                <h3 className="text-xl font-bold text-emerald-400 leading-none">{paidCount}</h3>
                <p className="text-[10px] font-bold text-emerald-500/60 mt-4 flex items-center gap-1">{t("admin.financial.synccomplete")}</p>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.3
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t border-l-orange-500/30 transition-all hover:bg-muted/50">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
                <Clock className="w-10 h-10" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("unpaid")}</p>
                <h3 className="text-xl font-bold text-orange-400 leading-none">{unpaidCount}</h3>
                <p className="text-[10px] font-bold text-orange-500/60 mt-4 flex items-center gap-1">{t("admin.financial.awaitingsync")}</p>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.4
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t border-l-red-500/30 transition-all hover:bg-muted/50">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-red-500">
                <AlertCircle className="w-10 h-10" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("overdue")}</p>
                <h3 className="text-xl font-bold text-red-400 leading-none">{overdueCount}</h3>
                <p className="text-[10px] font-bold text-red-500/60 mt-4 flex items-center gap-1">{t("admin.financial.faultynode")}</p>
              </CardContent>
            </Card>
          </motion.div>
        </div>

        {/* Tactical Search & Actions Interface */}
        <div className="bg-card backdrop-blur-xl border border-border rounded-3xl p-6 flex flex-wrap items-center justify-between gap-6 shadow-2xl mx-4">
          <div className="flex flex-wrap items-center gap-4 flex-1">
            <div className="relative group min-w-[320px]">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-primary transition-colors" />
              <Input placeholder={t("commonSearch")} value={search} onChange={e => setSearch(e.target.value)} className="pl-12 w-full h-12 bg-muted/50 border-border rounded-xl text-foreground placeholder:text-slate-600 font-bold text-[10px] focus:ring-primary/20 transition-all" />
            </div>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-44 h-12 bg-muted/50 border-border rounded-xl text-foreground font-bold text-[10px] hover:bg-muted/50 transition-all">
                <SelectValue placeholder={t("financialPaymentsStatus")} />
              </SelectTrigger>
              <SelectContent className="bg-[#14151a] border-border rounded-xl">
                 <SelectItem value="all" className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground transition-colors">{t("admin.financial.allnodes")}</SelectItem>
                 {Object.values(PaymentLedgerStatus).map(status => <SelectItem key={status} value={status} className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground transition-colors">
                    {(statusConfig as any)[status]?.label.toUpperCase() || status}
                  </SelectItem>)}
              </SelectContent>
            </Select>
          </div>
          <Button onClick={() => setCreateOpen(true)} className="bg-primary hover:bg-primary/90 text-foreground h-12 px-8 rounded-xl font-bold text-[10px] gap-3 shadow-xl shadow-primary/20">
            <Plus className="w-4 h-4" />
            {t("financialInitnode")}
          </Button>
        </div>

        <Card className="bg-card border-border rounded-4xl overflow-hidden border-l border-t relative shadow-2xl mx-4">
          <CardHeader className="px-8 py-8 border-b border-border bg-muted/50">
            <div className="flex items-center justify-between">
              <div>
                <CardTitle className="text-xl font-bold text-foreground leading-none">{t("financialPaymentsTitle")}</CardTitle>
                <CardDescription className="text-[10px] font-bold text-muted-foreground mt-2">{t("admin.financial.realtime_capital_flow_synchronization")}</CardDescription>
              </div>
              <Activity className="w-8 h-8 text-primary opacity-20" />
            </div>
          </CardHeader>
          <CardContent className="p-0">
            <Table>
              <TableHeader className="bg-muted/50 border-b border-border">
                <TableRow className="hover:bg-transparent border-none">
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("tenant")}</TableHead>
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("financialPaymentsProperty")}</TableHead>
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("financialPaymentsAmount")}</TableHead>
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("dueDate")}</TableHead>
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground">{t("financialPaymentsStatus")}</TableHead>
                  <TableHead className="text-[10px] font-bold px-8 h-16 text-muted-foreground text-right">{t("reference")}</TableHead>
                  <TableHead className="w-[80px]"></TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {loading ? <TableRow><TableCell colSpan={7} className="text-center py-20"><Loader2 className="w-6 h-6 animate-spin mx-auto text-primary opacity-50" /></TableCell></TableRow> : filteredPayments.length === 0 ? <TableRow>
                     <TableCell colSpan={7} className="text-center py-20 text-muted-foreground text-[10px] font-bold opacity-30">{t("admin.financial.no_neural_financial_signatures")}</TableCell>
                  </TableRow> : filteredPayments.map(payment => {
                const config = (statusConfig as any)[payment.status];
                return <TableRow key={payment.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                        <TableCell className="px-8 py-6">
                          <div>
                            <div className="text-sm font-bold text-foreground truncate tracking-tight leading-none mb-2">{payment.tenant?.name || "—"}</div>
                            <div className="text-[9px] font-bold text-muted-foreground opacity-50">{payment.tenant?.email || "—"}</div>
                          </div>
                        </TableCell>
                        <TableCell className="px-8">
                          <div>
                            <div className="text-[10px] font-bold text-muted-foreground leading-none">{payment.property?.name || "—"}</div>
                            <div className="text-[9px] font-bold text-muted-foreground mt-1 opacity-50 truncate max-w-[150px]">{payment.property?.addressLine1 || "—"}</div>
                          </div>
                        </TableCell>
                        <TableCell className="px-8">
                           <div className="flex items-baseline gap-1">
                              <span className="text-lg font-bold text-foreground">{formatCurrency(payment.amount, payment.currency)}</span>
                           </div>
                        </TableCell>
                        <TableCell className="px-8">
                           <div className="text-[10px] font-bold text-muted-foreground leading-none">{formatDate(payment.dueDate)}</div>
                           {payment.paymentDate && <div className="text-[9px] font-bold text-emerald-500 mt-1 opacity-50">{t("admin.financial.paid")}{formatDate(payment.paymentDate)}</div>}
                        </TableCell>
                        <TableCell className="px-8">
                           <Badge className={cn("text-[9px] font-bold   px-3 py-1 rounded-full  border transition-all", config?.cls)}>
                              <div className="flex items-center gap-1.5">
                                 {config && <config.icon className="w-3 h-3" />}
                                 <span>{config?.label || payment.status}</span>
                              </div>
                           </Badge>
                        </TableCell>
                        <TableCell className="px-8 text-right font-mono text-[10px] text-muted-foreground">
                          {payment.reference || "-"}
                        </TableCell>
                        <TableCell className="px-8 text-right">
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="icon" className="h-10 w-10 text-muted-foreground hover:text-foreground hover:bg-muted/50 rounded-xl transition-all">
                                <MoreHorizontal className="h-4 w-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent align="end" className="bg-[#14151a] border-border rounded-2xl p-2 w-48 shadow-2xl">
                              <DropdownMenuItem className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground rounded-xl py-3 cursor-pointer" onClick={() => window.location.href = `/checkout?type=TENANT_PAYMENT&amount=${payment.amount}&id=${payment.id}`}>
                                <CreditCard className="w-4 h-4 mr-3 text-blue-400" />{t("admin.financial.completestripe")}</DropdownMenuItem>
                              <DropdownMenuItem className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground rounded-xl py-3 cursor-pointer" onClick={() => {
                          setSelectedPayment(payment);
                          setEditOpen(true);
                        }}>
                                <Edit className="h-4 w-4 mr-3 text-emerald-400" />{t("admin.financial.reconfignode")}</DropdownMenuItem>
                              <DropdownMenuItem className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground rounded-xl py-3 cursor-pointer" onClick={() => {
                          navigator.clipboard.writeText(payment.reference || '');
                          toast({
                            title: t("admin.financial.copied"),
                            description: t("admin.financial.reference_copied_to_clipboard")
                          });
                        }}>
                                <Copy className="w-4 h-4 mr-3 text-violet-400" />{t("admin.financial.syncreference")}</DropdownMenuItem>
                              <DropdownMenuItem className="text-[10px] font-bold focus:bg-red-500/10 focus:text-red-500 rounded-xl py-3 cursor-pointer" onClick={() => handleDeletePayment(payment.id)}>
                                <Trash2 className="h-4 w-4 mr-3" />{t("admin.financial.terminateflow")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </TableCell>
                      </TableRow>;
              })}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        {/* Create Payment Dialog - Neural HUB */}
        <Dialog open={createOpen} onOpenChange={setCreateOpen}>
          <DialogContent className="sm:max-w-lg bg-[#14151a] border-border text-foreground rounded-4xl p-0 overflow-hidden shadow-2xl backdrop-blur-2xl">
            <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-primary/50 to-transparent" />
            <DialogHeader className="p-10 border-b border-border bg-muted/50">
              <DialogTitle className="text-2xl font-bold leading-none">{t("admin.financial.initializetransaction")}</DialogTitle>
              <DialogDescription className="text-[10px] font-bold text-muted-foreground mt-2 flex items-center gap-2">
                <Zap className="w-3 h-3 text-primary" />{t("admin.financial.newfinancialnode")}</DialogDescription>
            </DialogHeader>
            <div className="p-10 space-y-6">
              <div className="grid grid-cols-2 gap-6">
                <div className="space-y-3">
                  <Label className="text-[10px] font-bold text-muted-foreground">{t("admin.financial.orgidentity")}</Label>
                  <Input placeholder={t("admin.financial.organization_id")} className="h-12 bg-muted/50 border-border rounded-xl text-[10px] font-bold focus:ring-primary/20" />
                </div>
                <div className="space-y-3">
                  <Label className="text-[10px] font-bold text-muted-foreground">{t("admin.financial.grossamount")}</Label>
                  <Input type="number" placeholder="0.00" className="h-12 bg-muted/50 border-border rounded-xl text-[10px] font-bold focus:ring-primary/20" />
                </div>
              </div>
              <div className="grid grid-cols-2 gap-6">
                <div className="space-y-3">
                  <Label className="text-[10px] font-bold text-muted-foreground">{t("admin.financial.currencytoken")}</Label>
                  <Input defaultValue="USD" className="h-12 bg-muted/50 border-border rounded-xl text-[10px] font-bold focus:ring-primary/20" />
                </div>
                <div className="space-y-3">
                  <Label className="text-[10px] font-bold text-muted-foreground">{t("admin.financial.expirypulse")}</Label>
                  <Input type="date" className="h-12 bg-muted/50 border-border rounded-xl text-[10px] font-bold focus:ring-primary/20 shadow-none scheme-dark" />
                </div>
              </div>
              <div className="space-y-3">
                <Label className="text-[10px] font-bold text-muted-foreground">{t("admin.financial.matrixstatus")}</Label>
                <Select defaultValue="UNPAID">
                  <SelectTrigger className="h-12 bg-muted/50 border-border rounded-xl text-[10px] font-bold focus:ring-primary/20">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-border rounded-xl">
                    {Object.values(PaymentLedgerStatus).map(s => <SelectItem key={s} value={s} className="text-[10px] font-bold">{s}</SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
            </div>
            <DialogFooter className="p-10 pt-0 bg-transparent flex items-center justify-end gap-4 shadow-none">
              <Button variant="ghost" onClick={() => setCreateOpen(false)} className="h-12 px-8 rounded-xl text-[10px] font-bold text-muted-foreground hover:text-foreground hover:bg-muted/50">{t("admin.financial.abortinit")}</Button>
              <Button onClick={() => handleCreatePayment({
              orgId: "org_1",
              amount: 100,
              currency: "USD",
              status: "UNPAID",
              dueDate: new Date().toISOString()
            })} className="bg-primary hover:bg-primary/90 text-foreground h-12 px-8 rounded-xl font-bold text-[10px] shadow-xl shadow-primary/20">{t("admin.financial.committransaction")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Edit Payment Dialog - Neural HUB */}
        <Dialog open={editOpen} onOpenChange={setEditOpen}>
          <DialogContent className="sm:max-w-lg bg-[#14151a] border-border text-foreground rounded-4xl p-0 overflow-hidden shadow-2xl backdrop-blur-2xl">
            <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-primary/50 to-transparent" />
            <DialogHeader className="p-10 border-b border-border bg-muted/50">
              <DialogTitle className="text-2xl font-bold leading-none">{t("admin.financial.reconfigfinancialnode")}</DialogTitle>
              <DialogDescription className="text-[10px] font-bold text-muted-foreground mt-2">{t("admin.financial.pulseid")}{selectedPayment?.id}
              </DialogDescription>
            </DialogHeader>
            <div className="p-10 space-y-6 text-center">
               <div className="flex flex-col items-center justify-center space-y-4 py-10">
                  <Activity className="w-12 h-12 text-primary opacity-20 animate-pulse" />
                  <p className="text-[10px] font-bold text-muted-foreground">{t("admin.financial.synchronizinginterface")}</p>
               </div>
            </div>
            <DialogFooter className="p-10 pt-0 bg-transparent flex items-center justify-end gap-4 shadow-none">
                <Button variant="ghost" onClick={() => setEditOpen(false)} className="h-12 px-8 rounded-xl text-[10px] font-bold text-muted-foreground hover:text-foreground hover:bg-muted/50">{t("admin.financial.abortreconfig")}</Button>
                <Button onClick={() => selectedPayment && handleUpdatePayment(selectedPayment.id, {})} className="bg-emerald-600 hover:bg-emerald-500 text-foreground h-12 px-8 rounded-xl font-bold text-[10px] shadow-xl shadow-emerald-600/20">{t("admin.financial.executereconfig")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}