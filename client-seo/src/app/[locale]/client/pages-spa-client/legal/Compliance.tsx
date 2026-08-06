"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { JSXElementConstructor, Key, ReactElement, ReactNode, useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
import { Switch } from "@/components/ui/switch";
import { Edit, Trash2, MoreHorizontal, Loader2 } from "lucide-react";
import { complianceApi } from "@/lib/api/compliance";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
const STATUS: Record<string, {
  label: string;
  cls: string;
}> = {
  COMPLIANT: {
    label: t("client.src.compliant"),
    cls: "bg-blue-100 text-blue-700"
  },
  NON_COMPLIANT: {
    label: t("client.src.non_compliant"),
    cls: "bg-red-100 text-red-700"
  },
  EXPIRING_SOON: {
    label: t("client.src.expiring_soon"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  PENDING: {
    label: t("common.processing"),
    cls: "bg-gray-100 text-gray-500"
  }
};
const EMPTY_FORM = {
  entityType: "",
  type: "",
  status: "",
  expiryDate: "",
  isVerified: false,
  notes: ""
};
export default function Compliance() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);

  // Fetch compliance records from API
  const { data: complianceData, isLoading } = useQuery({
    queryKey: ['compliance-records'],
    queryFn: () => complianceApi.getComplianceRecords().then((res: any) => res.data || [])
  });

  // Create mutation
  const createMutation = useMutation({
    mutationFn: (data: any) => complianceApi.createComplianceRecord(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['compliance-records'] });
      toast({ title: t("client.src.compliance_created") });
      setCreateOpen(false);
      setForm(EMPTY_FORM);
    },
    onError: () => {
      toast({ title: t("common.error"), variant: "destructive" });
    }
  });

  // Update mutation
  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string; data: any }) => complianceApi.updateComplianceRecord(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['compliance-records'] });
      toast({ title: t("client.src.compliance_updated") });
      setEditOpen(false);
    },
    onError: () => {
      toast({ title: t("common.error"), variant: "destructive" });
    }
  });

  // Delete mutation
  const deleteMutation = useMutation({
    mutationFn: (id: string) => complianceApi.deleteComplianceRecord(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['compliance-records'] });
      toast({ title: t("client.src.compliance_deleted") });
    },
    onError: () => {
      toast({ title: t("common.error"), variant: "destructive" });
    }
  });

  const filtered = (complianceData || []).filter((row: any) => (String(row.entityType ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.type ?? "").toLowerCase().includes(search.toLowerCase())) && (filterStatus === "all" || row.status === filterStatus));
  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(form);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({ id: form.id, data: form });
    }
  };
  const handleDelete = (id: string) => {
    if (confirm("Are you sure?")) {
      deleteMutation.mutate(id);
    }
  };
  const openEdit = (row: any) => {
    const f: any = {};
    Object.keys(EMPTY_FORM).forEach(k => {
      f[k] = String(row[k] ?? "");
    });
    setForm(f);
    setEditOpen(true);
  };
  const EntityForm = ({
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
      <div className="space-y-1.5">
        <Label>{t("client.src.entity_type")}</Label>
        <Select value={form.entityType} onValueChange={v => setForm({
          ...form,
          entityType: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="Property">{t("common.property")}</SelectItem>
          <SelectItem value="Agent">{t("common.agent")}</SelectItem>
          <SelectItem value="Agency">{t("common.agency")}</SelectItem></SelectContent></Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.compliance_type")}</Label>
        <Select value={form.type} onValueChange={v => setForm({
          ...form,
          type: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="ENERGY_CERT">{t("client.src.energy_certificate")}</SelectItem>
          <SelectItem value="GAS_SAFETY">{t("client.src.gas_safety")}</SelectItem>
          <SelectItem value="FIRE_SAFETY">{t("client.src.fire_safety")}</SelectItem>
          <SelectItem value="LICENSE">{t("client.src.license")}</SelectItem>
          <SelectItem value="INSURANCE">{t("client.src.insurance")}</SelectItem></SelectContent></Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({
          ...form,
          status: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="COMPLIANT">{t("client.src.compliant")}</SelectItem>
          <SelectItem value="NON_COMPLIANT">{t("client.src.non_compliant")}</SelectItem>
          <SelectItem value="EXPIRING_SOON">{t("client.src.expiring_soon")}</SelectItem>
          <SelectItem value="PENDING">{t("common.processing")}</SelectItem></SelectContent></Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.expiry_date")}</Label>
        <Input type="date" value={form.expiryDate} onChange={e => setForm({
          ...form,
          expiryDate: e.target.value
        })} />
      </div>
      <div className="flex items-center justify-between rounded-lg border border-border p-3">
        <Label>{t("client.src.verified")}</Label>
        <Switch checked={form.isVerified === "true" || form.isVerified === true} onCheckedChange={v => setForm({
          ...form,
          isVerified: String(v)
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.notes")}</Label>
        <Textarea value={form.notes} onChange={e => setForm({
          ...form,
          notes: e.target.value
        })} rows={3} />
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  if (isLoading) {
    return (
      <PageShell title={t("client.src.compliance_records")} description={t("client.src.track_property_and_regulatory")}>
        <div className="flex items-center justify-center h-64">
          <Loader2 className="w-8 h-8 animate-spin text-muted-foreground" />
        </div>
      </PageShell>
    );
  }

  return <>
      <PageShell title={t("client.src.compliance_records")} description={t("client.src.track_property_and_regulatory")} createLabel="Add Compliance" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search compliance records..." stats={[{
      label: t("common.total"),
      value: (complianceData || []).length
    }, {
      label: t("client.src.compliant"),
      value: (complianceData || []).filter((r: any) => r.status === 'COMPLIANT').length
    }, {
      label: t("client.src.issues"),
      value: (complianceData || []).filter((r: any) => r.status === 'NON_COMPLIANT' || r.status === 'EXPIRING_SOON').length
    }]} filters={<Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-40"><SelectValue placeholder={t("common.status")} /></SelectTrigger>
            <SelectContent>              <SelectItem value="all">{t("common.all")}</SelectItem>
              <SelectItem value="COMPLIANT">{t("client.src.compliant")}</SelectItem>
              <SelectItem value="NON_COMPLIANT">{t("client.src.non_compliant")}</SelectItem>
              <SelectItem value="EXPIRING_SOON">{t("client.src.expiring_soon")}</SelectItem></SelectContent>
          </Select>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("client.src.entity_type")}</TableHead>
              <TableHead>{t("client.src.compliance_type")}</TableHead>
              <TableHead>{t("common.status")}</TableHead>
              <TableHead>{t("client.src.expiry")}</TableHead>
              <TableHead>{t("client.src.verified")}</TableHead>
              <TableHead>{t("common.notes")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("client.src.no_compliance_records_found")}</TableCell></TableRow>}
              {filtered.map((row: any) => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.entityType ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.type ?? "—"}</TableCell>
                    <TableCell>
                      {STATUS[row.status] ? <Badge className={`${STATUS[row.status].cls} border-0 text-xs`}>{STATUS[row.status].label}</Badge> : <span className="text-xs text-muted-foreground">{row.status}</span>}
                    </TableCell>
                    <TableCell className="text-sm">{row.expiryDate ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.isVerified ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.notes ?? "—"}</TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("common.edit")}</DropdownMenuItem>
                        <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </TableCell>
                </TableRow>)}
            </TableBody>
          </Table>
        </div>
      </PageShell>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.add_compliance")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("common.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_compliance")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("common.save")} />
        </DialogContent>
      </Dialog>
    </>;
}