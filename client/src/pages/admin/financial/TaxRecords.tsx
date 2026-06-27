import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect, FormEvent } from "react";
import { PageShell } from "../../client/layout/PageShell";
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
    label: t("admin.financial.paid"),
    cls: "bg-green-100 text-green-700"
  },
  UNPAID: {
    label: t("admin.financial.unpaid"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  PARTIAL: {
    label: t("admin.financial.partial"),
    cls: "bg-blue-100 text-blue-700"
  },
  OVERDUE: {
    label: t("admin.financial.overdue"),
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
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const queryClient = useQueryClient();

  const { data: recordsData, isLoading: loading, refetch: fetchRecords } = useQuery({
    queryKey: ['financialRecords', 'TAX'],
    queryFn: async () => {
      const response = await financialsApi.getRecords();
      const allRecords: any[] = Array.isArray(response) ? response : (response as any)?.data || [];
      return allRecords.filter(r => r.category === "TAX" || (r.description || "").toLowerCase().includes("tax"));
    }
  });

  const records: FinancialRecord[] = recordsData || [];
  const filtered = records.filter(row => (row.description || "").toLowerCase().includes(search.toLowerCase()) || (row.category || "").toLowerCase().includes(search.toLowerCase()));
  const createMutation = useMutation({
    mutationFn: (data: any) => financialsApi.createRecord(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['financialRecords', 'TAX'] });
      setCreateOpen(false);
      toast({ title: t("admin.financial.tax_record_created") });
    },
    onError: () => {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_create_tax"),
        variant: "destructive"
      });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => financialsApi.updateRecord(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['financialRecords', 'TAX'] });
      setEditOpen(false);
      toast({ title: t("admin.financial.tax_record_updated") });
    },
    onError: () => {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_update_tax"),
        variant: "destructive"
      });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => financialsApi.deleteRecord(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['financialRecords', 'TAX'] });
      toast({ title: t("admin.financial.tax_record_deleted") });
    },
    onError: () => {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_delete_tax"),
        variant: "destructive"
      });
    }
  });

  const handleCreate = (e: FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      ...form,
      amount: parseFloat(form.amount)
    });
  };
  const handleEdit = (e: FormEvent) => {
    e.preventDefault();
    if (!form.id) return;
    updateMutation.mutate({
      id: form.id,
      data: {
        ...form,
        amount: parseFloat(form.amount)
      }
    });
  };
  const handleDelete = (id: string) => {
    if (!confirm(t("admin.financial.are_you_sure", "Emin misiniz?"))) return;
    deleteMutation.mutate(id);
  };
  const openEdit = (row: FinancialRecord) => {
    setForm({
      id: row.id,
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
          <div className="space-y-1.5"><Label>{t("admin.financial.org_id")}</Label><Input value={form.orgId} onChange={e => setForm({
            ...form,
            orgId: e.target.value
          })} required /></div>
          <div className="space-y-1.5"><Label>{t("admin.financial.property_id")}</Label><Input value={form.propertyId} onChange={e => setForm({
            ...form,
            propertyId: e.target.value
          })} required /></div>
        </>}
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("admin.financial.amount")}</Label><Input type="number" value={form.amount} onChange={e => setForm({
            ...form,
            amount: e.target.value
          })} required /></div>
        <div className="space-y-1.5"><Label>{t("admin.financial.currency")}</Label><Input value={form.currency} onChange={e => setForm({
            ...form,
            currency: e.target.value
          })} /></div>
      </div>
      <div className="space-y-1.5"><Label>{t("admin.financial.date")}</Label><Input type="date" value={form.occurredAt} onChange={e => setForm({
          ...form,
          occurredAt: e.target.value
        })} /></div>
      <div className="space-y-1.5"><Label>{t("admin.financial.description")}</Label><Input value={form.description} onChange={e => setForm({
          ...form,
          description: e.target.value
        })} /></div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("admin.financial.tax_records")} description={t("admin.financial.manage_property_tax_records")} createLabel={t("admin.financial.add_tax_record", "Vergi Kaydı Ekle")} onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder={t("admin.financial.search_tax_records", "Vergi kayıtlarında ara...")} stats={[{
      label: t("admin.financial.total"),
      value: records.length
    }, {
      label: t("admin.financial.paid"),
      value: records.filter(r => r.paymentStatus === 'PAID').length
    }, {
      label: t("admin.financial.total_paid"),
      value: `$${records.filter(r => r.paymentStatus === 'PAID').reduce((s, r) => s + (r.amount || 0), 0).toLocaleString()}`
    }]} actions={<Button variant="outline" size="sm" onClick={() => fetchRecords()} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("admin.financial.refresh")}</Button>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("admin.financial.date")}</TableHead>
                <TableHead>{t("admin.financial.type")}</TableHead>
                <TableHead>{t("admin.financial.amount")}</TableHead>
                <TableHead>{t("admin.financial.description")}</TableHead>
                <TableHead>{t("admin.financial.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("admin.financial.no_tax_records_found")}</TableCell></TableRow> : filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.occurredAt ? new Date(row.occurredAt).toLocaleDateString() : "—"}</TableCell>
                    <TableCell className="text-sm font-medium">{row.category || "TAX"}</TableCell>
                    <TableCell className="text-sm font-semibold">${row.amount.toLocaleString()}</TableCell>
                    <TableCell className="text-xs text-muted-foreground">{row.description || "—"}</TableCell>
                    <TableCell>
                      {STATUS[row.paymentStatus || "UNPAID"] ? <Badge className={`${STATUS[row.paymentStatus || "UNPAID"].cls} border-0 text-xs shadow-sm`}>{STATUS[row.paymentStatus || "UNPAID"].label}</Badge> : <span className="text-xs text-muted-foreground">{row.paymentStatus}</span>}
                    </TableCell>
                    <TableCell>
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("admin.financial.edit")}</DropdownMenuItem>
                          <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("admin.financial.delete")}</DropdownMenuItem>
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
          <DialogHeader><DialogTitle>{t("admin.financial.add_tax_record")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("admin.financial.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("admin.financial.edit_tax_record")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("admin.financial.save_changes")} isEdit={true} />
        </DialogContent>
      </Dialog>
    </>;
}