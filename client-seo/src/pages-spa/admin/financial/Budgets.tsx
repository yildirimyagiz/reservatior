"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect, FormEvent } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { financialsApi, type Budget } from "@/lib/api/financials";
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
const EMPTY_FORM = {
  orgId: "",
  propertyId: "",
  year: new Date().getFullYear().toString(),
  totalAmount: "",
  notes: "",
  name: "",
  budgetType: "OPERATIONAL",
  period: "ANNUAL",
  startDate: new Date(new Date().getFullYear(), 0, 1).toISOString().split('T')[0],
  endDate: new Date(new Date().getFullYear(), 11, 31).toISOString().split('T')[0]
};
export default function Budgets() {
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

  const { data: budgetsData, isLoading: loading, refetch: fetchBudgets } = useQuery({
    queryKey: ['financialBudgets'],
    queryFn: async () => {
      const response = (await financialsApi.getBudgets()) as any;
      return Array.isArray(response) ? response : response?.data || [];
    }
  });

  const budgets = budgetsData || [];
  const filtered = budgets.filter((row: { notes: any; year: { toString: () => string | string[]; }; }) => (row.notes || "").toLowerCase().includes(search.toLowerCase()) || row.year.toString().includes(search));
  const createMutation = useMutation({
    mutationFn: (data: any) => financialsApi.createBudget(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['financialBudgets'] });
      setCreateOpen(false);
      toast({ title: t("admin_financial_budget_created") });
    },
    onError: () => {
      toast({
        title: t("admin_financial_error"),
        description: t("admin_financial_failed_to_create_budget"),
        variant: "destructive"
      });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => financialsApi.updateBudget(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['financialBudgets'] });
      setEditOpen(false);
      toast({ title: t("admin_financial_budget_updated") });
    },
    onError: () => {
      toast({
        title: t("admin_financial_error"),
        description: t("admin_financial_failed_to_update_budget"),
        variant: "destructive"
      });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => financialsApi.deleteBudget(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['financialBudgets'] });
      toast({ title: t("admin_financial_budget_deleted") });
    },
    onError: () => {
      toast({
        title: t("admin_financial_error"),
        description: t("admin_financial_failed_to_delete_budget"),
        variant: "destructive"
      });
    }
  });

  const handleCreate = (e: FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      ...form,
      name: form.name || `Budget ${form.year}`,
      year: parseInt(form.year),
      totalAmount: parseFloat(form.totalAmount)
    });
  };
  const handleEdit = (e: FormEvent) => {
    e.preventDefault();
    if (!form.id) return;
    updateMutation.mutate({
      id: form.id,
      data: {
        ...form,
        year: parseInt(form.year),
        totalAmount: parseFloat(form.totalAmount)
      }
    });
  };
  const handleDelete = (id: string) => {
    if (!confirm(t("admin_financial_are_you_sure", "Emin misiniz?"))) return;
    deleteMutation.mutate(id);
  };
  const openEdit = (row: Budget) => {
    setForm({
      id: row.id,
      orgId: row.orgId,
      propertyId: row.propertyId || "",
      year: row.year.toString(),
      totalAmount: row.totalAmount.toString(),
      notes: row.notes || "",
      name: (row as any).name || "",
      budgetType: (row as any).budgetType || "OPERATIONAL",
      period: (row as any).period || "ANNUAL",
      startDate: (row as any).startDate ? new Date((row as any).startDate).toISOString().split('T')[0] : "",
      endDate: (row as any).endDate ? new Date((row as any).endDate).toISOString().split('T')[0] : ""
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
      {!isEdit && <div className="space-y-1.5"><Label>{t("admin_financial_org_id")}</Label><Input value={form.orgId} onChange={e => setForm({
          ...form,
          orgId: e.target.value
        })} required /></div>}
      <div className="space-y-1.5"><Label>{t("admin_financial_budget_name")}</Label><Input value={form.name} onChange={e => setForm({
          ...form,
          name: e.target.value
        })} required placeholder={t("admin_financial_eg_annual_maintenance_2024")} /></div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("admin_financial_year")}</Label><Input type="number" value={form.year} onChange={e => setForm({
            ...form,
            year: e.target.value
          })} required /></div>
        <div className="space-y-1.5"><Label>{t("admin_financial_total_amount")}</Label><Input type="number" value={form.totalAmount} onChange={e => setForm({
            ...form,
            totalAmount: e.target.value
          })} required /></div>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("admin_financial_start_date")}</Label><Input type="date" value={form.startDate} onChange={e => setForm({
            ...form,
            startDate: e.target.value
          })} required /></div>
        <div className="space-y-1.5"><Label>{t("admin_financial_end_date")}</Label><Input type="date" value={form.endDate} onChange={e => setForm({
            ...form,
            endDate: e.target.value
          })} required /></div>
      </div>
      <div className="space-y-1.5">
        <Label>{t("admin_financial_notes")}</Label>
        <Input type="text" value={form.notes} onChange={e => setForm({
          ...form,
          notes: e.target.value
        })} />
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("admin_financial_budgets")} description={t("admin_financial_plan_and_track_property")} createLabel={t("admin_financial_add_budget", "Bütçe Ekle")} onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder={t("admin_financial_search_budgets", "Bütçelerde ara...")} stats={[{
      label: t("admin_financial_budgets"),
      value: budgets.length
    }, {
      label: t("admin_financial_total_allocated"),
      value: `$${budgets.reduce((s: any, r: { totalAmount: any; }) => s + (r.totalAmount || 0), 0).toLocaleString()}`
    }, {
      label: t("admin_financial_total_spent"),
      value: `$${budgets.reduce((s: any, r: { spentAmount: any; }) => s + (r.spentAmount || 0), 0).toLocaleString()}`
    }]} actions={<Button variant="outline" size="sm" onClick={() => fetchBudgets()} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("admin_financial_refresh")}</Button>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("admin_financial_year")}</TableHead>
                <TableHead>{t("admin_financial_notes")}</TableHead>
                <TableHead>{t("admin_financial_total_amount")}</TableHead>
                <TableHead>{t("admin_financial_spent_amount")}</TableHead>
                <TableHead>{t("admin_financial_utilization")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("admin_financial_no_budgets_found")}</TableCell></TableRow> : filtered.map((row: Budget) => {
              const util = row.totalAmount > 0 ? (row.spentAmount || 0) / row.totalAmount * 100 : 0;
              return <TableRow key={row.id} className="hover:bg-muted/40">
                      <TableCell className="text-sm font-medium">{row.year}</TableCell>
                      <TableCell className="text-sm">{row.notes || "—"}</TableCell>
                      <TableCell className="text-sm">${row.totalAmount.toLocaleString()}</TableCell>
                      <TableCell className="text-sm">${(row.spentAmount || 0).toLocaleString()}</TableCell>
                      <TableCell>
                        <div className="flex items-center gap-2">
                          <div className="w-24 h-1.5 bg-muted rounded-full overflow-hidden">
                            <div className={`h-full rounded-full ${util > 100 ? 'bg-red-500' : 'bg-primary'}`} style={{
                        width: `${Math.min(util, 100)}%`
                      }} />
                          </div>
                          <span className="text-[10px] text-muted-foreground">{util.toFixed(0)}%</span>
                        </div>
                      </TableCell>
                      <TableCell>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("admin_financial_edit")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("admin_financial_delete")}</DropdownMenuItem>
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
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("admin_financial_add_budget")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("admin_financial_create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("admin_financial_edit_budget")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("admin_financial_save_changes")} isEdit={true} />
        </DialogContent>
      </Dialog>
    </>;
}