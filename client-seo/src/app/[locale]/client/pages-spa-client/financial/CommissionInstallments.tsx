"use client";

import { useTranslation } from "react-i18next";
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { PageShell } from "../layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogTrigger } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { paymentInstallmentsApi, type PaymentInstallment } from "@/lib/api/payment-installments";
import { commissionsApi, type Commission } from "@/lib/api/commissions";
import { Calendar, DollarSign, AlertCircle, CheckCircle2, Clock, Plus, Loader2 } from "lucide-react";

export default function CommissionInstallments() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const orgId = "default-org"; // Fallback

  const [createOpen, setCreateOpen] = useState(false);
  const [selectedCommission, setSelectedCommission] = useState("");
  const [installmentCount, setInstallmentCount] = useState("6");
  const [startDate, setStartDate] = useState("");

  const { data: installmentsData, isLoading } = useQuery<PaymentInstallment[]>({
    queryKey: ['paymentInstallments', orgId],
    queryFn: async () => {
      try {
        const res = await paymentInstallmentsApi.getAll({ orgId });
        return (res as any)?.data || [];
      } catch (e) {
        return [];
      }
    }
  });

  const { data: commissionsData } = useQuery<Commission[]>({
    queryKey: ['commissions', orgId],
    queryFn: async () => {
      try {
        const res = await commissionsApi.getAll(orgId);
        return (res as any)?.data || [];
      } catch (e) {
        return [];
      }
    }
  });

  const createPlanMutation = useMutation({
    mutationFn: async () => {
      return commissionsApi.createInstallmentPlan(orgId, selectedCommission, {
        installmentCount: parseInt(installmentCount),
        startDate: startDate || undefined
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['paymentInstallments'] });
      setCreateOpen(false);
      toast({
        title: t("client.src.success", "Success"),
        description: t("client.src.installment_plan_created", "Installment plan created successfully"),
      });
    },
    onError: () => {
      toast({
        title: t("common.error", "Error"),
        description: t("client.src.installment_plan_failed", "Failed to create installment plan"),
        variant: "destructive"
      });
    }
  });

  const markPaidMutation = useMutation({
    mutationFn: async (id: string) => {
      return paymentInstallmentsApi.markAsPaid(id);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['paymentInstallments'] });
      toast({
        title: t("client.src.success", "Success"),
        description: t("client.src.installment_marked_paid", "Installment marked as paid"),
      });
    }
  });

  const installments = installmentsData || [];
  const commissions = (commissionsData || []).filter(c => c.status !== "CANCELLED");

  const totalAmount = installments.reduce((acc, curr) => acc + Number(curr.amount), 0);
  const paidAmount = installments.filter(i => i.status === "PAID").reduce((acc, curr) => acc + Number(curr.amount), 0);
  const overdueCount = installments.filter(i => i.status === "UNPAID" && new Date(i.dueDate) < new Date()).length;

  return (
    <PageShell 
      title={t("client.src.commission_installments", "Commission Installments")} 
      description={t("client.src.manage_commission_installments", "Manage and track commission installment payments")}
      actions={
        <Dialog open={createOpen} onOpenChange={setCreateOpen}>
          <DialogTrigger asChild>
            <Button size="sm" className="bg-primary hover:bg-primary/90 text-primary-foreground">
              <Plus className="w-4 h-4 mr-2" />
              {t("client.src.create_plan", "Create Plan")}
            </Button>
          </DialogTrigger>
          <DialogContent>
            <DialogHeader>
              <DialogTitle>{t("client.src.create_installment_plan", "Create Installment Plan")}</DialogTitle>
            </DialogHeader>
            <div className="space-y-4 py-4">
              <div className="space-y-2">
                <Label>{t("client.src.select_commission", "Select Commission")}</Label>
                <Select value={selectedCommission} onValueChange={setSelectedCommission}>
                  <SelectTrigger>
                    <SelectValue placeholder={t("client.src.select_commission_placeholder", "Select a commission")} />
                  </SelectTrigger>
                  <SelectContent>
                    {commissions.map(c => (
                      <SelectItem key={c.id} value={c.id}>
                        {c.id} - ${c.amount} ({c.type})
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>{t("client.src.installments_count", "Number of Installments")}</Label>
                <Select value={installmentCount} onValueChange={setInstallmentCount}>
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="3">3 {t("client.src.months", "Months")}</SelectItem>
                    <SelectItem value="6">6 {t("client.src.months", "Months")}</SelectItem>
                    <SelectItem value="9">9 {t("client.src.months", "Months")}</SelectItem>
                    <SelectItem value="12">12 {t("client.src.months", "Months")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label>{t("client.src.start_date", "Start Date")}</Label>
                <Input type="date" value={startDate} onChange={e => setStartDate(e.target.value)} />
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setCreateOpen(false)}>
                {t("common.cancel", "Cancel")}
              </Button>
              <Button onClick={() => createPlanMutation.mutate()} disabled={!selectedCommission || createPlanMutation.isPending}>
                {createPlanMutation.isPending ? <Loader2 className="w-4 h-4 mr-2 animate-spin" /> : null}
                {t("client.src.create", "Create")}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      }
    >
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <Card className="bg-primary/5 border-primary/10 shadow-sm overflow-hidden relative">
          <div className="absolute top-0 right-0 p-3 opacity-10">
            <DollarSign className="w-16 h-16" />
          </div>
          <CardHeader className="pb-2">
            <CardTitle className="text-xs font-bold tracking-wider text-muted-foreground">{t("client.src.total_installment_value", "Total Value")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold">${totalAmount.toLocaleString()}</div>
          </CardContent>
        </Card>
        
        <Card className="bg-green-50/50 border-green-100 shadow-sm overflow-hidden relative">
          <div className="absolute top-0 right-0 p-3 opacity-10 text-green-600">
            <CheckCircle2 className="w-16 h-16" />
          </div>
          <CardHeader className="pb-2">
            <CardTitle className="text-xs font-bold tracking-wider text-muted-foreground">{t("client.src.paid_installments", "Paid Amount")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-green-700">${paidAmount.toLocaleString()}</div>
          </CardContent>
        </Card>

        <Card className="bg-blue-50/50 border-blue-100 shadow-sm overflow-hidden relative">
          <div className="absolute top-0 right-0 p-3 opacity-10 text-blue-600">
            <Clock className="w-16 h-16" />
          </div>
          <CardHeader className="pb-2">
            <CardTitle className="text-xs font-bold tracking-wider text-muted-foreground">{t("client.src.pending_installments", "Pending Amount")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="text-3xl font-bold text-blue-700">${(totalAmount - paidAmount).toLocaleString()}</div>
          </CardContent>
        </Card>

        <Card className={overdueCount > 0 ? "bg-red-50/50 border-red-200 shadow-sm overflow-hidden relative" : "bg-gray-50/50 border-gray-200 shadow-sm overflow-hidden relative"}>
          <div className="absolute top-0 right-0 p-3 opacity-10 text-red-600">
            <AlertCircle className="w-16 h-16" />
          </div>
          <CardHeader className="pb-2">
            <CardTitle className="text-xs font-bold tracking-wider text-muted-foreground">{t("client.src.overdue_installments", "Overdue Installments")}</CardTitle>
          </CardHeader>
          <CardContent>
            <div className={`text-3xl font-bold ${overdueCount > 0 ? 'text-red-600' : 'text-gray-700'}`}>{overdueCount}</div>
          </CardContent>
        </Card>
      </div>

      <Card>
        <CardHeader>
          <CardTitle className="text-lg">{t("client.src.installment_schedule", "Installment Schedule")}</CardTitle>
        </CardHeader>
        <CardContent>
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.commission_id", "Commission")}</TableHead>
                <TableHead>{t("client.src.installment_no", "Inst. #")}</TableHead>
                <TableHead>{t("client.src.due_date", "Due Date")}</TableHead>
                <TableHead>{t("client.src.amount", "Amount")}</TableHead>
                <TableHead>{t("client.src.status", "Status")}</TableHead>
                <TableHead className="text-right">{t("common.actions", "Actions")}</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? (
                <TableRow>
                  <TableCell colSpan={6} className="text-center py-8 text-muted-foreground">
                    <Loader2 className="w-6 h-6 animate-spin mx-auto mb-2" />
                    {t("common.loading", "Loading...")}
                  </TableCell>
                </TableRow>
              ) : installments.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={6} className="text-center py-8 text-muted-foreground">
                    {t("client.src.no_installments_found", "No installments found")}
                  </TableCell>
                </TableRow>
              ) : (
                installments.map((inst) => {
                  const isOverdue = inst.status === "UNPAID" && new Date(inst.dueDate) < new Date();
                  
                  return (
                    <TableRow key={inst.id} className={isOverdue ? "bg-red-50/30" : ""}>
                      <TableCell className="font-medium text-xs">{(inst as any).commissionId || 'N/A'}</TableCell>
                      <TableCell>{(inst as any).installmentNo}</TableCell>
                      <TableCell className={isOverdue ? "text-red-600 font-medium" : ""}>
                        <div className="flex items-center">
                          <Calendar className="w-3 h-3 mr-1 opacity-50" />
                          {new Date(inst.dueDate).toLocaleDateString()}
                        </div>
                      </TableCell>
                      <TableCell className="font-medium">${Number(inst.amount).toLocaleString()}</TableCell>
                      <TableCell>
                        <Badge variant="outline" className={
                          inst.status === "PAID" ? "bg-green-100 text-green-700 border-green-200" :
                          isOverdue ? "bg-red-100 text-red-700 border-red-200" :
                          "bg-blue-100 text-blue-700 border-blue-200"
                        }>
                          {isOverdue ? t("client.src.overdue", "OVERDUE") : inst.status}
                        </Badge>
                      </TableCell>
                      <TableCell className="text-right">
                        {inst.status === "UNPAID" && (
                          <Button 
                            variant="outline" 
                            size="sm" 
                            className="h-8"
                            onClick={() => markPaidMutation.mutate(inst.id)}
                            disabled={markPaidMutation.isPending}
                          >
                            <CheckCircle2 className="w-3 h-3 mr-1" />
                            {t("client.src.mark_paid", "Mark Paid")}
                          </Button>
                        )}
                      </TableCell>
                    </TableRow>
                  );
                })
              )}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </PageShell>
  );
}
