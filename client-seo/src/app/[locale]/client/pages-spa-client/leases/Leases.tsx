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
import { leasesApi, type Lease } from "@/lib/api/leases";
import { tenantsApi, type Tenant } from "@/lib/api/tenants";
import { propertiesApi, type Property } from "@/lib/api/properties";
import { Edit, Trash2, MoreHorizontal, Loader2 } from "lucide-react";

// LeaseStatus removed

const STATUS_CONFIG = {
  active: {
    label: t("common.active"),
    cls: "bg-blue-100 text-blue-700"
  },
  draft: {
    label: t("common.draft"),
    cls: "bg-gray-100 text-gray-500"
  },
  expired: {
    label: t("common.expired"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  terminated: {
    label: t("client.src.terminated"),
    cls: "bg-red-100 text-red-700"
  }
};
const EMPTY_FORM = {
  propertyId: "",
  tenantId: "",
  startDate: "",
  endDate: "",
  monthlyRent: "",
  securityDeposit: "",
  status: "active",
  autoRenew: false,
  renewalNoticeDays: 30
};
export default function Leases() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [leases, setLeases] = useState<Lease[]>([]);
  const [properties, setProperties] = useState<Property[]>([]);
  const [tenants, setTenants] = useState<Tenant[]>([]);
  const [loading, setLoading] = useState(true);
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const fetchData = async () => {
    try {
      setLoading(true);
      const [leaseRes, propRes, tenantRes] = await Promise.all([leasesApi.getLeases(), propertiesApi.getAll(), tenantsApi.getAll()]);
      setLeases(leaseRes || []);
      setProperties(propRes || []);
      setTenants(tenantRes.data || []);
    } catch (error) {
      toast({
        title: t("common.error"),
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
  const filteredLeases = leases.filter(lease => {
    const pName = properties.find(p => p.id === lease.propertyId)?.name || "";
    const tName = tenants.find(t => t.id === lease.tenantId)?.firstName || "";
    const matchesSearch = pName.toLowerCase().includes(search.toLowerCase()) || tName.toLowerCase().includes(search.toLowerCase()) || lease.id.toLowerCase().includes(search.toLowerCase());
    const matchesStatus = filterStatus === "all" || lease.status === filterStatus;
    return matchesSearch && matchesStatus;
  });
  const handleCreateLease = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await leasesApi.createLease(form);
      setCreateOpen(false);
      toast({
        title: t("client.src.lease_created")
      });
      setForm(EMPTY_FORM);
      fetchData();
    } catch (error) {
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_create_lease"),
        variant: "destructive"
      });
    }
  };
  const handleUpdateLease = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedId) return;
    try {
      await leasesApi.updateLease(selectedId, form);
      setEditOpen(false);
      toast({
        title: t("client.src.lease_updated")
      });
      fetchData();
    } catch (error) {
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_update_lease"),
        variant: "destructive"
      });
    }
  };
  const handleDeleteLease = async (id: string) => {
    if (!confirm("Are you sure?")) return;
    try {
      await leasesApi.deleteLease(id);
      toast({
        title: t("client.src.lease_deleted")
      });
      fetchData();
    } catch (error) {
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_delete_lease"),
        variant: "destructive"
      });
    }
  };
  const openEdit = (lease: Lease) => {
    setSelectedId(lease.id);
    setForm({
      propertyId: lease.propertyId,
      tenantId: lease.tenantId,
      startDate: lease.startDate.split("T")[0],
      endDate: lease.endDate.split("T")[0],
      monthlyRent: lease.monthlyRent,
      securityDeposit: lease.securityDeposit,
      status: lease.status,
      autoRenew: lease.autoRenew,
      renewalNoticeDays: lease.renewalNoticeDays
    });
    setEditOpen(true);
  };
  const LeaseForm = ({
    onSubmit,
    label
  }: {
    onSubmit: (e: React.FormEvent) => void;
    label: string;
  }) => {
    const {
      t
    } = useTranslation();
    return <form onSubmit={onSubmit} className="space-y-4 py-2">
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5">
          <Label>{t("common.property")}</Label>
          <Select value={form.propertyId} onValueChange={v => setForm({
            ...form,
            propertyId: v
          })}>
            <SelectTrigger><SelectValue placeholder={t("common.select_property")} /></SelectTrigger>
            <SelectContent>
              {properties.map(p => <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>)}
            </SelectContent>
          </Select>
        </div>
        <div className="space-y-1.5">
          <Label>{t("common.tenant")}</Label>
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
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5">
          <Label>{t("client.src.start_date")}</Label>
          <Input type="date" value={form.startDate} onChange={e => setForm({
            ...form,
            startDate: e.target.value
          })} required />
        </div>
        <div className="space-y-1.5">
          <Label>{t("client.src.end_date")}</Label>
          <Input type="date" value={form.endDate} onChange={e => setForm({
            ...form,
            endDate: e.target.value
          })} required />
        </div>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5">
          <Label>{t("client.src.monthly_rent")}</Label>
          <Input type="number" value={form.monthlyRent} onChange={e => setForm({
            ...form,
            monthlyRent: e.target.value
          })} required placeholder="0.00" />
        </div>
        <div className="space-y-1.5">
          <Label>{t("client.src.security_deposit")}</Label>
          <Input type="number" value={form.securityDeposit} onChange={e => setForm({
            ...form,
            securityDeposit: e.target.value
          })} placeholder="0.00" />
        </div>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5">
          <Label>{t("common.status")}</Label>
          <Select value={form.status} onValueChange={v => setForm({
            ...form,
            status: v
          })}>
            <SelectTrigger><SelectValue /></SelectTrigger>
            <SelectContent>
              {Object.keys(STATUS_CONFIG).map(s => <SelectItem key={s} value={s}>{STATUS_CONFIG[s as keyof typeof STATUS_CONFIG].label}</SelectItem>)}
            </SelectContent>
          </Select>
        </div>
        <div className="space-y-1.5">
          <Label>{t("client.src.renewal_notice_days")}</Label>
          <Input type="number" value={form.renewalNoticeDays} onChange={e => setForm({
            ...form,
            renewalNoticeDays: parseInt(e.target.value)
          })} />
        </div>
      </div>
      <DialogFooter className="pt-2"><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <PageShell title={t("client.src.leases")} description={t("client.src.manage_rental_agreements_and")} createLabel={t("client.src.create_new_lease", "Yeni Sözleşme Ekle")} onCreateClick={() => {
    setForm(EMPTY_FORM);
    setCreateOpen(true);
  }} searchValue={search} onSearchChange={setSearch} searchPlaceholder={t("client.src.search_by_property_or_tenant", "Mülk veya kiracı ile ara...")} stats={[{
    label: t("client.src.total_leases"),
    value: leases.length
  }, {
    label: t("common.active"),
    value: leases.filter(l => l.status === "active").length
  }, {
    label: t("common.expired"),
    value: leases.filter(l => l.status === "expired").length
  }, {
    label: t("client.src.terminated"),
    value: leases.filter(l => l.status === "terminated").length
  }]}>
      <div className="space-y-6">
        <div className="flex items-center justify-between space-x-4">
          <Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-40 h-9">
              <SelectValue placeholder={t("common.all_status")} />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("common.all_status")}</SelectItem>
              {Object.keys(STATUS_CONFIG).map(status => <SelectItem key={status} value={status}>{STATUS_CONFIG[status as keyof typeof STATUS_CONFIG].label}</SelectItem>)}
            </SelectContent>
          </Select>
        </div>

        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("common.tenant")}</TableHead>
                <TableHead>{t("common.property")}</TableHead>
                <TableHead>{t("client.src.period")}</TableHead>
                <TableHead>{t("client.src.rent")}</TableHead>
                <TableHead>{t("common.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : filteredLeases.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_leases_found")}</TableCell></TableRow> : filteredLeases.map(lease => {
              const prop = properties.find(p => p.id === lease.propertyId);
              const tenant = tenants.find(t => t.id === lease.tenantId);
              return <TableRow key={lease.id} className="hover:bg-muted/40 transition-colors">
                      <TableCell>
                        <div className="font-semibold text-sm">{tenant ? `${tenant.firstName} ${tenant.lastName}` : "Unknown Tenant"}</div>
                        <div className="text-[10px] text-muted-foreground font-mono">{lease.tenantId}</div>
                      </TableCell>
                      <TableCell>
                        <div className="text-sm font-medium">{prop?.name || "Unknown Property"}</div>
                        <div className="text-[10px] text-muted-foreground line-clamp-1">{prop?.addressLine1}</div>
                      </TableCell>
                      <TableCell className="text-sm">
                        {new Date(lease.startDate).toLocaleDateString()} - {new Date(lease.endDate).toLocaleDateString()}
                      </TableCell>
                      <TableCell className="font-bold">${lease.monthlyRent}</TableCell>
                      <TableCell>
                        <Badge className={`${STATUS_CONFIG[lease.status as keyof typeof STATUS_CONFIG]?.cls} border-0 text-xs`}>
                          {STATUS_CONFIG[lease.status as keyof typeof STATUS_CONFIG]?.label || lease.status}
                        </Badge>
                      </TableCell>
                      <TableCell>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem onClick={() => openEdit(lease)}><Edit className="w-4 h-4 mr-2" />{t("common.edit")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleDeleteLease(lease.id)} className="text-destructive font-medium"><Trash2 className="w-4 h-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>;
            })}
            </TableBody>
          </Table>
        </div>

        <Dialog open={createOpen} onOpenChange={setCreateOpen}>
          <DialogContent className="sm:max-w-[600px]">
            <DialogHeader><DialogTitle>{t("client.src.create_new_lease")}</DialogTitle></DialogHeader>
            <LeaseForm onSubmit={handleCreateLease} label={t("client.src.create_lease")} />
          </DialogContent>
        </Dialog>

        <Dialog open={editOpen} onOpenChange={setEditOpen}>
          <DialogContent className="sm:max-w-[600px]">
            <DialogHeader><DialogTitle>{t("client.src.edit_lease")}</DialogTitle></DialogHeader>
            <LeaseForm onSubmit={handleUpdateLease} label={t("common.save")} />
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}