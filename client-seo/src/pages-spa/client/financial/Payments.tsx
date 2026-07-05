"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { paymentsApi, type Payment, PaymentLedgerStatus } from "@/lib/api/payments";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { Edit, Trash2, MoreHorizontal, CheckCircle2, Clock, AlertCircle, TrendingUp, Plus, Search, Loader2 } from "lucide-react";
const STATUS_CONFIG: Record<string, {
  label: string;
  cls: string;
  icon: any;
}> = {
  PAID: {
    label: t("client.src.paid"),
    cls: "bg-green-100 text-green-700",
    icon: CheckCircle2
  },
  UNPAID: {
    label: t("client.src.unpaid"),
    cls: "bg-yellow-100 text-yellow-700",
    icon: Clock
  },
  OVERDUE: {
    label: t("client.src.overdue"),
    cls: "bg-red-100 text-red-700",
    icon: AlertCircle
  },
  REFUNDED: {
    label: t("client.src.refunded"),
    cls: "bg-blue-100 text-blue-700",
    icon: TrendingUp
  },
  PARTIAL: {
    label: t("client.src.partial"),
    cls: "bg-orange-100 text-orange-700",
    icon: AlertCircle
  }
};
export default function Payments() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterProperty, setFilterProperty] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedPayment, setSelectedPayment] = useState<Payment | null>(null);
  const queryClient = useQueryClient();

  const { data: rawPayments, isLoading: loading } = useQuery({
    queryKey: ['payments'],
    queryFn: async () => {
      const response = await paymentsApi.getPayments();
      return Array.isArray(response) ? response : (response as any).data?.data || [];
    }
  });

  const payments = (rawPayments as Payment[]) || [];
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
  const createMutation = useMutation({
    mutationFn: (data: any) => paymentsApi.createPayment(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['payments'] });
      setCreateOpen(false);
      toast({ title: t("client.src.payment_created"), description: t("client.src.new_payment_has_been") });
    },
    onError: () => toast({ title: t("client.src.error"), description: t("client.src.failed_to_create_payment"), variant: "destructive" })
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => paymentsApi.updatePayment(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['payments'] });
      setEditOpen(false);
      toast({ title: t("client.src.payment_updated"), description: t("client.src.payment_has_been_updated") });
    },
    onError: () => toast({ title: t("client.src.error"), description: t("client.src.failed_to_update_payment"), variant: "destructive" })
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => paymentsApi.deletePayment(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['payments'] });
      toast({ title: t("client.src.payment_deleted"), description: t("client.src.payment_has_been_deleted") });
    },
    onError: () => toast({ title: t("client.src.error"), description: t("client.src.failed_to_delete_payment"), variant: "destructive" })
  });

  const handleCreatePayment = (data: any) => createMutation.mutate(data);
  const handleUpdatePayment = (id: string, data: any) => updateMutation.mutate({ id, data });
  const handleDeletePayment = (id: string) => {
    if (!confirm("Are you sure?")) return;
    deleteMutation.mutate(id);
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
  const getStatusIcon = (status: PaymentLedgerStatus) => {
    const config = STATUS_CONFIG[status];
    return config ? <config.icon className="h-4 w-4" /> : null;
  };
  const getStatusColor = (status: PaymentLedgerStatus) => {
    const config = STATUS_CONFIG[status];
    return config ? config.cls : "bg-gray-100 text-gray-700";
  };
  return <PageShell title={t("client.src.payments")} description={t("client.src.manage_property_payments_and")}>
      <div className="space-y-6">
        <div className="grid gap-4 md:grid-cols-4">
          <div className="bg-card border border-border p-6 rounded-xl shadow-sm">
            <h3 className="text-sm font-medium text-muted-foreground">{t("client.src.total_payments")}</h3>
            <p className="text-2xl font-bold text-card-foreground">{totalPayments}</p>
          </div>
          <div className="bg-card border border-border p-6 rounded-xl shadow-sm">
            <h3 className="text-sm font-medium text-muted-foreground">{t("client.src.paid")}</h3>
            <p className="text-2xl font-bold text-green-600">{paidCount}</p>
          </div>
          <div className="bg-card border border-border p-6 rounded-xl shadow-sm">
            <h3 className="text-sm font-medium text-muted-foreground">{t("client.src.unpaid")}</h3>
            <p className="text-2xl font-bold text-yellow-600">{unpaidCount}</p>
          </div>
          <div className="bg-card border border-border p-6 rounded-xl shadow-sm">
            <h3 className="text-sm font-medium text-muted-foreground">{t("client.src.overdue")}</h3>
            <p className="text-2xl font-bold text-red-600">{overdueCount}</p>
          </div>
        </div>

        <div className="flex items-center justify-between space-x-4">
          <div className="flex items-center space-x-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
              <Input placeholder={t("client.src.search_payments")} value={search} onChange={e => setSearch(e.target.value)} className="pl-8 w-64 h-9" />
            </div>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-32 h-9">
                <SelectValue placeholder={t("client.src.status")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_status")}</SelectItem>
                {Object.values(PaymentLedgerStatus).map(status => <SelectItem key={status} value={status}>{STATUS_CONFIG[status]?.label || status}</SelectItem>)}
              </SelectContent>
            </Select>
            <Select value={filterProperty} onValueChange={setFilterProperty}>
              <SelectTrigger className="w-32 h-9">
                <SelectValue placeholder={t("client.src.property")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_properties")}</SelectItem>
                {Array.from(new Set(payments.map(p => p.property?.name).filter(Boolean))).map(propertyName => <SelectItem key={propertyName as string} value={propertyName as string}>{propertyName}</SelectItem>)}
              </SelectContent>
            </Select>
          </div>
          <Button onClick={() => setCreateOpen(true)} className="h-9">
            <Plus className="h-4 w-4 mr-2" />{t("client.src.add_payment")}</Button>
        </div>

        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.tenant")}</TableHead>
                <TableHead>{t("client.src.property")}</TableHead>
                <TableHead>{t("client.src.amount")}</TableHead>
                <TableHead>{t("client.src.due_date")}</TableHead>
                <TableHead>{t("client.src.payment_date")}</TableHead>
                <TableHead>{t("client.src.status")}</TableHead>
                <TableHead>{t("client.src.reference")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={8} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : filteredPayments.length === 0 ? <TableRow><TableCell colSpan={8} className="text-center py-12 text-muted-foreground">{t("client.src.no_payments_found")}</TableCell></TableRow> : filteredPayments.map(payment => <TableRow key={payment.id} className="hover:bg-muted/40">
                    <TableCell>
                      <div>
                        <div className="font-medium text-sm">{payment.tenant?.name || "—"}</div>
                        <div className="text-[11px] text-muted-foreground">{payment.tenant?.email || "—"}</div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div>
                        <div className="font-medium text-sm">{payment.property?.name || "—"}</div>
                        <div className="text-[11px] text-muted-foreground italic truncate max-w-[150px]">{payment.property?.addressLine1 || "—"}</div>
                      </div>
                    </TableCell>
                    <TableCell className="font-semibold text-sm">
                      {formatCurrency(payment.amount, payment.currency)}
                    </TableCell>
                    <TableCell className="text-sm">{formatDate(payment.dueDate)}</TableCell>
                    <TableCell className="text-sm">
                      {payment.paymentDate ? formatDate(payment.paymentDate) : "-"}
                    </TableCell>
                    <TableCell>
                      <Badge className={`${getStatusColor(payment.status)} border-0 shadow-sm`}>
                        <div className="flex items-center space-x-1">
                          {getStatusIcon(payment.status)}
                          <span className="text-[11px]">{STATUS_CONFIG[payment.status]?.label || payment.status}</span>
                        </div>
                      </Badge>
                    </TableCell>
                    <TableCell className="text-xs font-mono">{payment.reference || "-"}</TableCell>
                    <TableCell>
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="h-4 w-4" /></Button></DropdownMenuTrigger>
                        <DropdownMenuContent align="end" className="w-40">
                          <DropdownMenuItem onClick={() => {
                      setSelectedPayment(payment);
                      setEditOpen(true);
                    }}><Edit className="h-4 w-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                          <DropdownMenuItem onClick={() => {
                      navigator.clipboard.writeText(payment.reference || '');
                      toast({
                        title: t("client.src.copied"),
                        description: t("client.src.reference_copied_to_clipboard")
                      });
                    }}>{t("client.src.copy_reference")}</DropdownMenuItem>
                          <DropdownMenuItem className="text-destructive font-medium" onClick={() => handleDeletePayment(payment.id)}><Trash2 className="h-4 w-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
            </TableBody>
          </Table>
        </div>

        {/* Create Payment Dialog */}
        <Dialog open={createOpen} onOpenChange={setCreateOpen}>
          <DialogContent className="sm:max-w-lg">
            <DialogHeader><DialogTitle>{t("client.src.create_payment")}</DialogTitle></DialogHeader>
            <div className="space-y-4 py-2">
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5"><Label>{t("client.src.org_id")}</Label><Input placeholder={t("client.src.organization_id")} /></div>
                <div className="space-y-1.5"><Label>{t("client.src.amount")}</Label><Input type="number" placeholder="0.00" /></div>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1.5"><Label>{t("client.src.currency")}</Label><Input defaultValue="USD" /></div>
                <div className="space-y-1.5"><Label>{t("client.src.due_date")}</Label><Input type="date" /></div>
              </div>
              <div className="space-y-1.5">
                <Label>{t("client.src.status")}</Label>
                <Select defaultValue="UNPAID">
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent>
                    {Object.values(PaymentLedgerStatus).map(s => <SelectItem key={s} value={s}>{s}</SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-1.5"><Label>{t("client.src.reference")}</Label><Input placeholder={t("client.src.payment_reference")} /></div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setCreateOpen(false)}>{t("client.src.cancel")}</Button>
              <Button onClick={() => handleCreatePayment({
              orgId: "org_1",
              amount: 100,
              currency: "USD",
              status: "UNPAID",
              dueDate: new Date().toISOString()
            })}>{t("client.src.create_payment")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* Edit Payment Dialog */}
        <Dialog open={editOpen} onOpenChange={setEditOpen}>
          <DialogContent className="sm:max-w-lg">
            <DialogHeader><DialogTitle>{t("client.src.edit_payment")}</DialogTitle></DialogHeader>
            <div className="space-y-4 py-2">
              <p className="text-sm text-muted-foreground">{t("client.src.editing_payment_for")}{selectedPayment?.id}</p>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setEditOpen(false)}>{t("client.src.cancel")}</Button>
              <Button onClick={() => selectedPayment && handleUpdatePayment(selectedPayment.id, {})}>{t("client.src.update_payment")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}