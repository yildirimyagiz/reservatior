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
import { Edit, Trash2, MoreHorizontal, Loader2, AlertCircle, RefreshCw } from "lucide-react";
import { tenantsApi, type Increase, type Tenant } from "@/lib/api/tenants";
import { propertiesApi, type Property } from "@/lib/api/properties";
const STATUS: Record<string, {
  label: string;
  cls: string;
}> = {
  PENDING: {
    label: t("client.src.pending"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  ACCEPTED: {
    label: t("client.src.accepted"),
    cls: "bg-green-100 text-green-700"
  },
  REJECTED: {
    label: t("client.src.rejected"),
    cls: "bg-red-100 text-red-700"
  },
  WITHDRAWN: {
    label: t("client.src.withdrawn"),
    cls: "bg-gray-100 text-gray-700"
  }
};
const EMPTY_FORM = {
  tenantId: "",
  propertyId: "",
  orgId: "",
  oldRent: "",
  newRent: "",
  effectiveDate: "",
  status: "PENDING",
  reason: ""
};
export default function Increases() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [increases, setIncreases] = useState<Increase[]>([]);
  const [properties, setProperties] = useState<Property[]>([]);
  const [tenants, setTenants] = useState<Tenant[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [selectedIncrease, setSelectedIncrease] = useState<Increase | null>(null);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const fetchData = async () => {
    try {
      setLoading(true);
      const [incRes, propRes, tenantRes] = await Promise.all([tenantsApi.getIncreases(), propertiesApi.getAll(), tenantsApi.getAll()]);
      setIncreases(incRes.data || []);
      setProperties(propRes || []);
      setTenants(tenantRes.data || []);
      setError(null);
    } catch (err: any) {
      setError("Failed to fetch data");
      toast({
        variant: "destructive",
        title: t("client.src.error"),
        description: t("client.src.could_not_load_records")
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchData();
  }, []);
  const filtered = increases.filter(row => {
    const tenantName = (row as any).Tenant?.firstName ? `${(row as any).Tenant.firstName} ${(row as any).Tenant.lastName}` : "N/A";
    const propertyName = (row as any).Property?.name || "N/A";
    const match = tenantName.toLowerCase().includes(search.toLowerCase()) || propertyName.toLowerCase().includes(search.toLowerCase());
    return match && (filterStatus === "all" || row.status === filterStatus);
  });
  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    try {
      await tenantsApi.createIncrease({
        ...form,
        oldRent: Number(form.oldRent),
        newRent: Number(form.newRent),
        proposedBy: "ADMIN" // Placeholder
      });
      setCreateOpen(false);
      fetchData();
      toast({
        title: t("client.src.increase_created")
      });
    } catch (err: any) {
      toast({
        variant: "destructive",
        title: t("client.src.error"),
        description: t("client.src.failed_to_create_record")
      });
    }
  };
  const handleEdit = async (e: FormEvent) => {
    e.preventDefault();
    if (!selectedIncrease) return;
    try {
      await tenantsApi.updateIncrease(selectedIncrease.id, {
        ...form,
        oldRent: Number(form.oldRent),
        newRent: Number(form.newRent)
      });
      setEditOpen(false);
      fetchData();
      toast({
        title: t("client.src.increase_updated")
      });
    } catch (err: any) {
      toast({
        variant: "destructive",
        title: t("client.src.error"),
        description: t("client.src.failed_to_update_record")
      });
    }
  };
  const handleDelete = async (id: string) => {
    if (!confirm("Are you sure?")) return;
    try {
      await tenantsApi.deleteIncrease(id);
      fetchData();
      toast({
        title: t("client.src.increase_deleted"),
        variant: "destructive"
      });
    } catch (err: any) {
      toast({
        variant: "destructive",
        title: t("client.src.error"),
        description: t("client.src.failed_to_delete_record")
      });
    }
  };
  const openEdit = (row: Increase) => {
    setSelectedIncrease(row);
    setForm({
      tenantId: row.tenantId,
      propertyId: row.propertyId,
      oldRent: String(row.oldRent),
      newRent: String(row.newRent),
      effectiveDate: row.effectiveDate.split("T")[0],
      status: row.status,
      reason: row.reason || "",
      orgId: (row as any).orgId || ""
    });
    setEditOpen(true);
  };
  const EntityForm = ({
    onSubmit,
    label
  }: {
    onSubmit: (e: FormEvent) => void;
    label: string;
  }) => {
    const {
      t
    } = useTranslation();
    return <form onSubmit={onSubmit} className="space-y-4 py-2">
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5">
          <Label>{t("client.src.tenant")}</Label>
          <Select value={form.tenantId} onValueChange={v => setForm({
            ...form,
            tenantId: v
          })}>
            <SelectTrigger><SelectValue placeholder={t("client.src.select_tenant")} /></SelectTrigger>
            <SelectContent>
              {tenants.map(t => <SelectItem key={t.id} value={t.id}>{t.firstName} {t.lastName}</SelectItem>)}
            </SelectContent>
          </Select>
        </div>
        <div className="space-y-1.5">
          <Label>{t("client.src.property")}</Label>
          <Select value={form.propertyId} onValueChange={v => {
            const p = properties.find(prop => prop.id === v);
            setForm({
              ...form,
              propertyId: v,
              orgId: p?.orgId || ""
            });
          }}>
            <SelectTrigger><SelectValue placeholder={t("client.src.select_property")} /></SelectTrigger>
            <SelectContent>
              {properties.map(p => <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>)}
            </SelectContent>
          </Select>
        </div>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("client.src.current_rent")}</Label><Input type="number" value={form.oldRent} onChange={e => setForm({
            ...form,
            oldRent: e.target.value
          })} placeholder="0.00" /></div>
        <div className="space-y-1.5"><Label>{t("client.src.new_rent")}</Label><Input type="number" value={form.newRent} onChange={e => setForm({
            ...form,
            newRent: e.target.value
          })} placeholder="0.00" /></div>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("client.src.effective_date")}</Label><Input type="date" value={form.effectiveDate} onChange={e => setForm({
            ...form,
            effectiveDate: e.target.value
          })} /></div>
        <div className="space-y-1.5">
          <Label>{t("client.src.status")}</Label>
          <Select value={form.status} onValueChange={v => setForm({
            ...form,
            status: v as any
          })}>
            <SelectTrigger><SelectValue /></SelectTrigger>
            <SelectContent>
              <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
              <SelectItem value="ACCEPTED">{t("client.src.accepted")}</SelectItem>
              <SelectItem value="REJECTED">{t("client.src.rejected")}</SelectItem>
              <SelectItem value="WITHDRAWN">{t("client.src.withdrawn")}</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>
      <div className="space-y-1.5"><Label>{t("client.src.reason")}</Label><Input value={form.reason} onChange={e => setForm({
          ...form,
          reason: e.target.value
        })} /></div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.rent_increases")} description={t("client.src.manage_proposed_and_approved")} createLabel="Add Increases" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search rent increases..." stats={[{
      label: t("client.src.total"),
      value: increases.length
    }, {
      label: t("client.src.pending"),
      value: increases.filter(r => r.status === 'PENDING').length
    }, {
      label: t("client.src.accepted"),
      value: increases.filter(r => r.status === 'ACCEPTED').length
    }]} filters={<div className="flex gap-2">
          <Button variant="outline" size="icon" onClick={fetchData} disabled={loading}>
            <RefreshCw className={`w-4 h-4 ${loading ? 'animate-spin' : ''}`} />
          </Button>
          <Button variant={filterStatus === "all" ? "default" : "outline"} size="sm" onClick={() => setFilterStatus("all")}>{t("client.src.all")}</Button>
          <Button variant={filterStatus === "PENDING" ? "default" : "outline"} size="sm" onClick={() => setFilterStatus("PENDING")}>{t("client.src.pending")}</Button>
          <Button variant={filterStatus === "ACCEPTED" ? "default" : "outline"} size="sm" onClick={() => setFilterStatus("ACCEPTED")}>{t("client.src.accepted")}</Button>
        </div>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          {loading ? <div className="flex flex-col items-center justify-center py-24 text-muted-foreground gap-3">
              <Loader2 className="w-8 h-8 animate-spin" />
              <p>{t("client.src.loading_records")}</p>
            </div> : error ? <div className="flex flex-col items-center justify-center py-24 text-destructive gap-3 text-center px-4">
              <AlertCircle className="w-10 h-10" />
              <p className="font-semibold text-lg">{t("client.src.failed_to_load")}</p>
              <Button variant="outline" onClick={fetchData} className="mt-2">{t("client.src.try_again")}</Button>
            </div> : <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("client.src.tenant")}</TableHead>
                  <TableHead>{t("client.src.property")}</TableHead>
                  <TableHead>{t("client.src.old_rent")}</TableHead>
                  <TableHead>{t("client.src.new_rent")}</TableHead>
                  <TableHead>{t("client.src.increase")}</TableHead>
                  <TableHead>{t("client.src.effective_date")}</TableHead>
                  <TableHead>{t("client.src.status")}</TableHead>
                  <TableHead className="w-10" />
                </TableRow>
              </TableHeader>
              <TableBody>
                {filtered.length === 0 && <TableRow><TableCell colSpan={8} className="text-center py-12 text-muted-foreground">{t("client.src.no_rent_increases_found")}</TableCell></TableRow>}
                {filtered.map(row => {
              const percentage = ((row.newRent - row.oldRent) / row.oldRent * 100).toFixed(1);
              const tenantName = (row as any).Tenant?.firstName ? `${(row as any).Tenant.firstName} ${(row as any).Tenant.lastName}` : "N/A";
              const propertyName = (row as any).Property?.name || "N/A";
              return <TableRow key={row.id} className="hover:bg-muted/40">
                      <TableCell className="text-sm font-medium">{tenantName}</TableCell>
                      <TableCell className="text-sm">{propertyName}</TableCell>
                      <TableCell className="text-sm">${row.oldRent.toLocaleString()}</TableCell>
                      <TableCell className="text-sm font-semibold text-primary">${row.newRent.toLocaleString()}</TableCell>
                      <TableCell className="text-sm text-green-600">+{percentage}%</TableCell>
                      <TableCell className="text-sm">{row.effectiveDate.split("T")[0]}</TableCell>
                      <TableCell>
                        {STATUS[row.status] ? <Badge className={`${STATUS[row.status].cls} border-0 text-xs`}>{STATUS[row.status].label}</Badge> : <span className="text-xs text-muted-foreground">{row.status}</span>}
                      </TableCell>
                      <TableCell>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>;
            })}
              </TableBody>
            </Table>}
        </div>
      </PageShell>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.add_increases")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("client.src.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_increases")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("client.src.save_changes")} />
        </DialogContent>
      </Dialog>
    </>;
}