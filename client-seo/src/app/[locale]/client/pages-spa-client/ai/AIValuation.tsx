"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { valuationsApi, PropertyValuation } from "@/lib/api/valuations";

const EMPTY_FORM = {
  propertyId: "",
  method: ""
};
export default function AIValuation() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const queryClient = useQueryClient();
  const [search, setSearch] = useState("");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);

  const { data: rawValuations = [], isLoading } = useQuery({
    queryKey: ['valuations'],
    queryFn: async () => {
      const response = await valuationsApi.getValuations();
      return (response as any).data?.data || (response as any).data || response || [];
    }
  });

  const valuations = Array.isArray(rawValuations) ? rawValuations : [];
  const filtered = valuations.filter((row: any) => String(row.property?.name ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.valuationType ?? "").toLowerCase().includes(search.toLowerCase()));

  const createMutation = useMutation({
    mutationFn: (data: any) => valuationsApi.createValuation(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['valuations'] });
      setCreateOpen(false);
      setForm(EMPTY_FORM);
      toast({ title: t("client.src.aivaluation_created") });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => valuationsApi.updateValuation(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['valuations'] });
      setEditOpen(false);
      toast({ title: t("client.src.aivaluation_updated") });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => valuationsApi.deleteValuation(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['valuations'] });
      toast({ title: t("client.src.aivaluation_deleted"), variant: "destructive" });
    }
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      propertyId: form.propertyId,
      valuationType: form.method
    });
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({ id: form.id, data: { valuationType: form.method } });
    }
  };

  const handleDelete = (id: string) => {
    if (confirm("Are you sure you want to delete this valuation?")) {
      deleteMutation.mutate(id);
    }
  };

  const openEdit = (row: any) => {
    setForm({
      id: row.id,
      propertyId: row.propertyId,
      method: row.valuationType
    });
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
        <Label>{t("client.src.property_id")}</Label>
        <Input type="text" value={form.propertyId} onChange={e => setForm({
          ...form,
          propertyId: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.valuation_method")}</Label>
        <Select value={form.method} onValueChange={v => setForm({
          ...form,
          method: v as any
        })}>
          <SelectTrigger><SelectValue /></SelectTrigger>
          <SelectContent>
            <SelectItem value="COMPARABLE_SALES">{t("client.src.comparable_sales")}</SelectItem>
            <SelectItem value="INCOME_APPROACH">{t("client.src.income_approach")}</SelectItem>
            <SelectItem value="COST_APPROACH">{t("client.src.cost_approach")}</SelectItem>
          </SelectContent>
        </Select>
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.ai_property_valuations")} description={t("client.src.aipowered_automated_property_valuations")} createLabel="Add AIValuation" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search ai property valuations..." stats={[{
      label: t("client.src.valuations"),
      value: valuations.length
    }, {
      label: t("client.src.avg_value"),
      value: valuations.length ? `$${Math.round(valuations.reduce((s: any, r: any) => s + (r.value || 0), 0) / valuations.length).toLocaleString()}` : "$0"
    }, {
      label: t("client.src.avg_confidence"),
      value: valuations.length ? `${Math.round(valuations.reduce((s: any, r: any) => s + (r.confidence || 0), 0) / valuations.length * 100)}%` : "0%"
    }, {
      label: t("client.src.rising_market"),
      value: valuations.filter((r: any) => r.status === 'COMPLETED').length
    }]} filters={null}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.property")}</TableHead>
                <TableHead>{t("client.src.estimated_value")}</TableHead>
                <TableHead>{t("client.src.confidence_score")}</TableHead>
                <TableHead>{t("client.src.trend")}</TableHead>
                <TableHead>{t("client.src.valued_at")}</TableHead>
                <TableHead>{t("client.src.method")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("client.src.no_ai_property_valuations")}</TableCell></TableRow>}
              {filtered.map((row: any) => <TableRow key={row.id} className="hover:bg-muted/40">
                  <TableCell className="text-sm">{row.property?.name ?? "—"}</TableCell>
                  <TableCell className="text-sm">${row.value ?? "—"}</TableCell>
                  <TableCell className="text-sm">{(row.confidence || 0).toFixed(2)}</TableCell>
                  <TableCell className="text-sm">{row.status ?? "—"}</TableCell>
                  <TableCell className="text-sm">{row.valuationDate ? new Date(row.valuationDate).toLocaleDateString() : "—"}</TableCell>
                  <TableCell className="text-sm">{row.valuationType ?? "—"}</TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                        <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
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
          <DialogHeader><DialogTitle>{t("client.src.add_aivaluation")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("client.src.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_aivaluation")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("client.src.save_changes")} />
        </DialogContent>
      </Dialog>
    </>;
}