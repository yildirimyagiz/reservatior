import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect, FormEvent } from "react";
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
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw } from "lucide-react";
import { leasesApi, type Lease } from "@/lib/api/leases";
import { tenantsApi, type Tenant } from "@/lib/api/tenants";
import { propertiesApi, type Property } from "@/lib/api/properties";
const STATUS: Record<string, {
  label: string;
  cls: string;
}> = {
  paid: {
    label: t("client.src.paid"),
    cls: "bg-green-100 text-green-700"
  },
  pending: {
    label: t("client.src.pending"),
    cls: "bg-blue-100 text-blue-700"
  },
  overdue: {
    label: t("client.src.overdue"),
    cls: "bg-red-100 text-red-700"
  },
  partial: {
    label: t("client.src.partial"),
    cls: "bg-yellow-100 text-yellow-700"
  }
};
const EMPTY_FORM = {
  leaseId: "",
  dueDate: "",
  amount: "",
  status: "pending",
  notes: ""
};
export default function RentSchedule() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [payments, setPayments] = useState<any[]>([]);
  const [leases, setLeases] = useState<Lease[]>([]);
  const [tenants, setTenants] = useState<Tenant[]>([]);
  const [properties, setProperties] = useState<Property[]>([]);
  const [loading, setLoading] = useState(true);
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const fetchData = async () => {
    try {
      setLoading(true);
      const [payRes, leaseRes, tenantRes, propRes] = await Promise.all([leasesApi.getRentPayments(), leasesApi.getLeases(), tenantsApi.getAll(), propertiesApi.getAll()]);
      setPayments(payRes || []);
      setLeases(leaseRes || []);
      setTenants(tenantRes.data || []);
      setProperties(propRes || []);
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_load_data"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchData();
  }, []);
  const getLeaseMeta = (leaseId: string) => {
    const lease = leases.find(l => l.id === leaseId);
    if (!lease) return {
      tenant: "Unknown",
      property: "Unknown"
    };
    const tenant = tenants.find(t => t.id === lease.tenantId);
    const prop = properties.find(p => p.id === lease.propertyId);
    return {
      tenant: tenant ? `${tenant.firstName} ${tenant.lastName}` : "Unknown",
      property: prop?.name || "Unknown"
    };
  };
  const filtered = payments.filter(row => {
    const {
      tenant,
      property
    } = getLeaseMeta(row.leaseId);
    const matchesSearch = row.leaseId?.toLowerCase().includes(search.toLowerCase()) || tenant.toLowerCase().includes(search.toLowerCase()) || property.toLowerCase().includes(search.toLowerCase());
    const matchesStatus = filterStatus === "all" || row.status === filterStatus;
    return matchesSearch && matchesStatus;
  });
  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    try {
      await leasesApi.recordRentPayment(form.leaseId, form.amount, form.dueDate);
      setCreateOpen(false);
      toast({
        title: t("client.src.payment_recorded")
      });
      setForm(EMPTY_FORM);
      fetchData();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_record_payment"),
        variant: "destructive"
      });
    }
  };
  const handleEdit = async (e: FormEvent) => {
    e.preventDefault();
    if (!selectedId) return;
    // Mock update since API might not have single payment PATCH yet
    toast({
      title: t("client.src.update_success_mock")
    });
    setEditOpen(false);
  };
  const handleDelete = async (id: string) => {
    if (!confirm("Are you sure?")) return;
    // Mock delete
    toast({
      title: t("client.src.delete_success_mock"),
      variant: "destructive"
    });
    setPayments(prev => prev.filter(p => p.id !== id));
  };
  const openEdit = (row: any) => {
    setSelectedId(row.id);
    setForm({
      leaseId: row.leaseId,
      dueDate: row.dueDate?.split("T")[0] || "",
      amount: row.amount,
      status: row.status,
      notes: row.notes || ""
    });
    setEditOpen(true);
  };
  return <>
      <PageShell title={t("client.src.rent_schedule")} description={t("client.src.upcoming_and_past_rent")} createLabel="Record Payment" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search by tenant, property or ID..." stats={[{
      label: t("client.src.total_payments"),
      value: payments.length
    }, {
      label: t("client.src.pending"),
      value: payments.filter(r => r.status === 'pending').length
    }, {
      label: t("client.src.overdue"),
      value: payments.filter(r => r.status === 'overdue').length
    }, {
      label: t("client.src.total_received"),
      value: `$${payments.filter(r => r.status === 'paid').reduce((s, r) => s + (Number(r.amount) || 0), 0).toLocaleString()}`
    }]} actions={<Button variant="outline" size="icon" onClick={fetchData} disabled={loading}>
            <RefreshCw className={`w-4 h-4 ${loading ? 'animate-spin' : ''}`} />
          </Button>} filters={<Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-40 h-9"><SelectValue placeholder={t("client.src.status")} /></SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("client.src.all_status")}</SelectItem>
              {Object.keys(STATUS).map(s => <SelectItem key={s} value={s}>{s}</SelectItem>)}
            </SelectContent>
          </Select>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.tenant_property")}</TableHead>
                <TableHead>{t("client.src.lease_id")}</TableHead>
                <TableHead>{t("client.src.amount")}</TableHead>
                <TableHead>{t("client.src.date")}</TableHead>
                <TableHead>{t("client.src.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_payments_found")}</TableCell></TableRow> : filtered.map(row => {
              const meta = getLeaseMeta(row.leaseId);
              return <TableRow key={row.id} className="hover:bg-muted/40 transition-colors">
                      <TableCell>
                        <div className="font-semibold text-sm">{meta.tenant}</div>
                        <div className="text-xs text-muted-foreground">{meta.property}</div>
                      </TableCell>
                      <TableCell className="font-mono text-[10px]">{row.leaseId}</TableCell>
                      <TableCell className="font-bold">${row.amount}</TableCell>
                      <TableCell className="text-sm">{row.paymentDate || row.dueDate || "—"}</TableCell>
                      <TableCell>
                        <Badge className={`${STATUS[row.status as keyof typeof STATUS]?.cls} border-0 text-[10px]`}>{row.status}</Badge>
                      </TableCell>
                      <TableCell>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive font-medium"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>;
            })}
            </TableBody>
          </Table>
        </div>
      </PageShell>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg">
          <DialogHeader><DialogTitle>{t("client.src.record_rent_payment")}</DialogTitle></DialogHeader>
          <form onSubmit={handleCreate} className="space-y-4 py-2">
            <div className="space-y-1.5">
              <Label>{t("client.src.active_lease")}</Label>
              <Select value={form.leaseId} onValueChange={v => setForm({
              ...form,
              leaseId: v
            })}>
                <SelectTrigger><SelectValue placeholder={t("client.src.select_active_lease")} /></SelectTrigger>
                <SelectContent>
                  {leases.filter(l => l.status === 'active').map(l => {
                  const meta = getLeaseMeta(l.id);
                  return <SelectItem key={l.id} value={l.id}>{meta.tenant} - {meta.property}</SelectItem>;
                })}
                </SelectContent>
              </Select>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1.5"><Label>{t("client.src.amount")}</Label><Input type="number" value={form.amount} onChange={e => setForm({
                ...form,
                amount: e.target.value
              })} required placeholder="0.00" /></div>
              <div className="space-y-1.5"><Label>{t("client.src.date")}</Label><Input type="date" value={form.dueDate} onChange={e => setForm({
                ...form,
                dueDate: e.target.value
              })} /></div>
            </div>
            <DialogFooter className="pt-2"><Button type="submit">{t("client.src.record_payment")}</Button></DialogFooter>
          </form>
        </DialogContent>
      </Dialog>

      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg">
          <DialogHeader><DialogTitle>{t("client.src.edit_payment_record")}</DialogTitle></DialogHeader>
          <form onSubmit={handleEdit} className="space-y-4 py-2">
            <div className="space-y-1.5"><Label>{t("client.src.amount")}</Label><Input type="number" value={form.amount} onChange={e => setForm({
              ...form,
              amount: e.target.value
            })} required /></div>
            <div className="space-y-1.5"><Label>{t("client.src.status")}</Label>
              <Select value={form.status} onValueChange={v => setForm({
              ...form,
              status: v
            })}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>
                  {Object.keys(STATUS).map(s => <SelectItem key={s} value={s}>{s}</SelectItem>)}
                </SelectContent>
              </Select>
            </div>
            <DialogFooter className="pt-2"><Button type="submit">{t("client.src.save_changes")}</Button></DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </>;
}