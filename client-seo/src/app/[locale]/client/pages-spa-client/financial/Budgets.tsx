"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, FormEvent, useEffect } from "react";
import { useQuery } from "@tanstack/react-query";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { financialsApi, type Budget } from "@/lib/api/financials";
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw } from "lucide-react";
const EMPTY_FORM = {
  orgId: "",
  propertyId: "",
  year: new Date().getFullYear().toString(),
  totalAmount: "",
  notes: ""
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
  const { data: budgetsData = [], isLoading: loading, refetch: fetchBudgets } = useQuery<Budget[]>({
    queryKey: ['budgets'],
    queryFn: async () => {
      try {
        const response = (await financialsApi.getBudgets()) as any;
        return Array.isArray(response) ? response : response?.data || [];
      } catch (error) {
        toast({
          title: t("common.error"),
          description: t("client.src.failed_to_load_budgets"),
          variant: "destructive"
        });
        return [];
      }
    }
  });
  const budgets = budgetsData || [];
  const filtered = budgets.filter(row => (row.notes || "").toLowerCase().includes(search.toLowerCase()) || row.year.toString().includes(search));
  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    try {
      await financialsApi.createBudget({
        ...form,
        year: parseInt(form.year),
        totalAmount: parseFloat(form.totalAmount)
      });
      setCreateOpen(false);
      toast({
        title: t("client.src.budget_created")
      });
      fetchBudgets();
    } catch (error) {
      toast({
        title: t("common.error"),
        description: t("client.src.failed_to_create_budget"),
        variant: "destructive"
      });
    }
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
    console.log("Deleting budget:", id);
    toast({
      title: t("client.src.delete_not_implemented"),
      description: t("client.src.backend_needs_delete_endpoint")
    });
  };
  const openEdit = (row: Budget) => {
    setForm({
      orgId: row.orgId,
      propertyId: row.propertyId || "",
      year: row.year.toString(),
      totalAmount: row.totalAmount.toString(),
      notes: row.notes || ""
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
      {!isEdit && <div className="space-y-1.5"><Label>{t("client.src.org_id")}</Label><Input value={form.orgId} onChange={e => setForm({
          ...form,
          orgId: e.target.value
        })} required /></div>}
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("client.src.year")}</Label><Input type="number" value={form.year} onChange={e => setForm({
            ...form,
            year: e.target.value
          })} required /></div>
        <div className="space-y-1.5"><Label>{t("common.total_amount")}</Label><Input type="number" value={form.totalAmount} onChange={e => setForm({
            ...form,
            totalAmount: e.target.value
          })} required /></div>
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.notes")}</Label>
        <Input type="text" value={form.notes} onChange={e => setForm({
          ...form,
          notes: e.target.value
        })} />
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.budgets")} description={t("client.src.plan_and_track_property")} createLabel="Add Budget" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search budgets..." stats={[{
      label: t("client.src.budgets"),
      value: budgets.length
    }, {
      label: t("client.src.total_allocated"),
      value: `$${budgets.reduce((s, r) => s + (r.totalAmount || 0), 0).toLocaleString()}`
    }, {
      label: t("client.src.total_spent"),
      value: `$${budgets.reduce((s, r) => s + (r.spentAmount || 0), 0).toLocaleString()}`
    }]} actions={<Button variant="outline" size="sm" onClick={() => fetchBudgets()} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("common.refresh")}</Button>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.year")}</TableHead>
                <TableHead>{t("common.notes")}</TableHead>
                <TableHead>{t("common.total_amount")}</TableHead>
                <TableHead>{t("client.src.spent_amount")}</TableHead>
                <TableHead>{t("client.src.utilization")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_budgets_found")}</TableCell></TableRow> : filtered.map(row => {
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
                          <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("common.edit")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
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
          <DialogHeader><DialogTitle>{t("client.src.add_budget")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("common.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_budget")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("common.save")} isEdit={true} />
        </DialogContent>
      </Dialog>
    </>;
}