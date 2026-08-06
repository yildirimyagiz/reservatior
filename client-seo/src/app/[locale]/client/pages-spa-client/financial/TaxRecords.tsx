"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect, FormEvent } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { financialsApi, type FinancialRecord } from "@/lib/api/financials";
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
const STATUS: Record<string, {
  label: string;
  cls: string;
}> = {
  PAID: {
    label: t("common.paid"),
    cls: "bg-blue-100 text-blue-700"
  },
  UNPAID: {
    label: t("client.src.unpaid"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  PARTIAL: {
    label: t("client.src.partial"),
    cls: "bg-blue-100 text-blue-700"
  },
  OVERDUE: {
    label: t("common.overdue"),
    cls: "bg-red-100 text-red-700"
  }
};
const EMPTY_FORM = {
  orgId: "",
  propertyId: "",
  type: "EXPENSE" as any,
  amount: "",
  currency: "USD",
  category: "TAX",
  description: "",
  occurredAt: ""
};
export default function TaxRecords() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const queryClient = useQueryClient();
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);

  const { data: recordsData = [], isLoading: loading, refetch: fetchRecords } = useQuery<FinancialRecord[]>({
    queryKey: ['taxRecords'],
    queryFn: async () => {
      const response = await financialsApi.getRecords();
      const allRecords: any[] = Array.isArray(response) ? response : (response as any)?.data || [];
      return allRecords.filter(r => r.category === "TAX" || (r.description || "").toLowerCase().includes("tax"));
    }
  });

  const records = recordsData;

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      return await financialsApi.createRecord(data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['taxRecords'] });
      setCreateOpen(false);
      toast({ title: t("client.src.tax_record_created") });
    },
    onError: () => {
      toast({ title: t("common.error"), description: t("client.src.failed_to_create_tax"), variant: "destructive" });
    }
  });
  const filtered = records.filter(row => (row.description || "").toLowerCase().includes(search.toLowerCase()) || (row.category || "").toLowerCase().includes(search.toLowerCase()));
  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      ...form,
      amount: parseFloat(form.amount)
    });
  };
  const handleEdit = async (e: FormEvent) => {
    e.preventDefault();
    setEditOpen(false);
    toast({
      title: t("client.src.update_not_implemented"),
      description: t("client.src.backend_needs_update_endpoint")
    });
  };
  const handleDelete = async (id: string) => {
    if (!confirm("Are you sure?")) return;
    console.log("Deleting tax record:", id);
    toast({
      title: t("client.src.delete_not_implemented"),
      description: t("client.src.backend_needs_delete_endpoint")
    });
  };
  const openEdit = (row: FinancialRecord) => {
    setForm({
      orgId: row.orgId,
      propertyId: row.propertyId,
      type: row.type,
      amount: row.amount.toString(),
      currency: row.currency,
      category: row.category || "TAX",
      description: row.description || "",
      occurredAt: row.occurredAt ? new Date(row.occurredAt).toISOString().split('T')[0] : ""
    });
    setEditOpen(true);
  };
  const EntityForm = ({
    onSubmit,
    label,
    isEdit = false
  }: {
    onSubmit: (e: FormEvent) => void;
    label: string;
    isEdit?: boolean;
  }) => {
    const {
      t
    } = useTranslation();
    return <form onSubmit={onSubmit} className="space-y-4 py-2">
      {!isEdit && <>
          <div className="space-y-1.5"><Label>{t("client.src.org_id")}</Label><Input value={form.orgId} onChange={e => setForm({
            ...form,
            orgId: e.target.value
          })} required /></div>
          <div className="space-y-1.5"><Label>{t("client.src.property_id")}</Label><Input value={form.propertyId} onChange={e => setForm({
            ...form,
            propertyId: e.target.value
          })} required /></div>
        </>}
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("common.amount")}</Label><Input type="number" value={form.amount} onChange={e => setForm({
            ...form,
            amount: e.target.value
          })} required /></div>
        <div className="space-y-1.5"><Label>{t("common.currency")}</Label><Input value={form.currency} onChange={e => setForm({
            ...form,
            currency: e.target.value
          })} /></div>
      </div>
      <div className="space-y-1.5"><Label>{t("common.date")}</Label><Input type="date" value={form.occurredAt} onChange={e => setForm({
          ...form,
          occurredAt: e.target.value
        })} /></div>
      <div className="space-y-1.5"><Label>{t("common.description")}</Label><Input value={form.description} onChange={e => setForm({
          ...form,
          description: e.target.value
        })} /></div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.tax_records")} description={t("client.src.manage_property_tax_records")} createLabel="Add Tax Record" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search tax records..." stats={[{
      label: t("common.total"),
      value: records.length
    }, {
      label: t("common.paid"),
      value: records.filter(r => r.paymentStatus === 'PAID').length
    }, {
      label: t("client.src.total_paid"),
      value: `$${records.filter(r => r.paymentStatus === 'PAID').reduce((s, r) => s + (r.amount || 0), 0).toLocaleString()}`
    }]} actions={<Button variant="outline" size="sm" onClick={() => fetchRecords()} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("common.refresh")}</Button>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("common.date")}</TableHead>
                <TableHead>{t("common.type")}</TableHead>
                <TableHead>{t("common.amount")}</TableHead>
                <TableHead>{t("common.description")}</TableHead>
                <TableHead>{t("common.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_tax_records_found")}</TableCell></TableRow> : filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.occurredAt ? new Date(row.occurredAt).toLocaleDateString() : "—"}</TableCell>
                    <TableCell className="text-sm font-medium">{row.category || "TAX"}</TableCell>
                    <TableCell className="text-sm font-semibold">${row.amount.toLocaleString()}</TableCell>
                    <TableCell className="text-xs text-muted-foreground">{row.description || "—"}</TableCell>
                    <TableCell>
                      {STATUS[row.paymentStatus || "UNPAID"] ? <Badge className={`${STATUS[row.paymentStatus || "UNPAID"].cls} border-0 text-xs shadow-sm`}>{STATUS[row.paymentStatus || "UNPAID"].label}</Badge> : <span className="text-xs text-muted-foreground">{row.paymentStatus}</span>}
                    </TableCell>
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
          <DialogHeader><DialogTitle>{t("client.src.add_tax_record")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("common.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_tax_record")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("common.save")} isEdit={true} />
        </DialogContent>
      </Dialog>
    </>;
}