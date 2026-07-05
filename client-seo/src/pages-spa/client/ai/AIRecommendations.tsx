"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { aiApi } from "@/lib/api/ai";
const STATUS: Record<string, {
  label: string;
  cls: string;
}> = {
  PENDING: {
    label: t("client.src.pending"),
    cls: "bg-gray-100 text-gray-500"
  },
  SENT: {
    label: t("client.src.sent"),
    cls: "bg-blue-100 text-blue-700"
  },
  VIEWED: {
    label: t("client.src.viewed"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  ACCEPTED: {
    label: t("client.src.accepted"),
    cls: "bg-green-100 text-green-700"
  },
  REJECTED: {
    label: t("client.src.rejected"),
    cls: "bg-red-100 text-red-700"
  }
};
const EMPTY_FORM = {
  userId: "",
  propertyIds: "",
  score: "",
  reasoning: "",
  status: "PENDING"
};
export default function AIRecommendations() {
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

  const { data: rawData = [], isLoading } = useQuery({
    queryKey: ['ai-recommendations'],
    queryFn: async () => {
      const response = await aiApi.getRecommendations();
      return (response as any).data || response || [];
    }
  });

  const recommendations = Array.isArray(rawData) ? rawData : [];
  const filtered = recommendations.filter((row: any) => String(row.userId ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.propertyIds ?? "").toLowerCase().includes(search.toLowerCase()));

  const createMutation = useMutation({
    mutationFn: (data: any) => aiApi.createRecommendation(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['ai-recommendations'] });
      setCreateOpen(false);
      setForm(EMPTY_FORM);
      toast({ title: t("client.src.airecommendations_created") });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => aiApi.updateRecommendation(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['ai-recommendations'] });
      setEditOpen(false);
      toast({ title: t("client.src.airecommendations_updated") });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => aiApi.deleteRecommendation(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['ai-recommendations'] });
      toast({ title: t("client.src.airecommendations_deleted"), variant: "destructive" });
    }
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      userId: form.userId,
      propertyIds: typeof form.propertyIds === 'string' ? form.propertyIds.split(',').map((s: string) => s.trim()) : form.propertyIds,
      score: Number(form.score),
      reasoning: form.reasoning,
      algorithm: "hybrid-matching"
    });
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({
        id: form.id,
        data: {
          userId: form.userId,
          propertyIds: typeof form.propertyIds === 'string' ? form.propertyIds.split(',').map((s: string) => s.trim()) : form.propertyIds,
          score: Number(form.score),
          reasoning: form.reasoning
        }
      });
    }
  };

  const handleDelete = (id: string) => {
    if (confirm("Are you sure you want to delete this recommendation?")) {
      deleteMutation.mutate(id);
    }
  };

  const openEdit = (row: any) => {
    setForm({
      id: row.id,
      userId: row.userId,
      propertyIds: Array.isArray(row.propertyIds) ? row.propertyIds.join(', ') : row.propertyIds,
      score: row.score,
      reasoning: row.reasoning,
      status: row.status || 'PENDING'
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
        <Label>{t("client.src.client")}</Label>
        <Input type="text" value={form.userId} onChange={e => setForm({
          ...form,
          userId: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.property")}</Label>
        <Input type="text" value={form.propertyIds} onChange={e => setForm({
          ...form,
          propertyIds: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.score_0100")}</Label>
        <Input type="number" value={form.score} onChange={e => setForm({
          ...form,
          score: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.reason")}</Label>
        <Textarea value={form.reasoning} onChange={e => setForm({
          ...form,
          reasoning: e.target.value
        })} rows={3} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({
          ...form,
          status: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
          <SelectItem value="SENT">{t("client.src.sent")}</SelectItem>
          <SelectItem value="VIEWED">{t("client.src.viewed")}</SelectItem>
          <SelectItem value="ACCEPTED">{t("client.src.accepted")}</SelectItem>
          <SelectItem value="REJECTED">{t("client.src.rejected")}</SelectItem></SelectContent></Select>
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.ai_recommendations")} description={t("client.src.personalized_property_recommendations_for")} createLabel="Add AIRecommendations" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search ai recommendations..." stats={[{
      label: t("client.src.total"),
      value: recommendations.length
    }, {
      label: t("client.src.sent"),
      value: recommendations.filter((r: any) => r.status === 'SENT' || r.status === 'VIEWED').length
    }, {
      label: t("client.src.accepted"),
      value: recommendations.filter((r: any) => r.status === 'ACCEPTED').length
    }, {
      label: t("client.src.avg_score"),
      value: recommendations.length ? `${Math.round(recommendations.reduce((s: any, r: any) => s + (r.score || 0), 0) / recommendations.length)}` : "0"
    }]} filters={null}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("client.src.client")}</TableHead>
              <TableHead>{t("client.src.recommended_property")}</TableHead>
              <TableHead>{t("client.src.score100")}</TableHead>
              <TableHead>{t("client.src.reason")}</TableHead>
              <TableHead>{t("client.src.status")}</TableHead>
              <TableHead>{t("client.src.generated")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("client.src.no_ai_recommendations_found")}</TableCell></TableRow>}
              {filtered.map((row: any) => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.userId ?? "—"}</TableCell>
                    <TableCell className="text-sm">{Array.isArray(row.propertyIds) ? row.propertyIds.join(', ') : (row.propertyIds ?? "—")}</TableCell>
                    <TableCell className="text-sm">{row.score ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.reasoning ?? "—"}</TableCell>
                    <TableCell>
                      {STATUS[row.status || 'PENDING'] ? <Badge className={`${STATUS[row.status || 'PENDING'].cls} border-0 text-xs`}>{STATUS[row.status || 'PENDING'].label}</Badge> : <span className="text-xs text-muted-foreground">{row.status}</span>}
                    </TableCell>
                    <TableCell className="text-sm">{row.createdAt ? new Date(row.createdAt).toLocaleDateString() : "—"}</TableCell>
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
          <DialogHeader><DialogTitle>{t("client.src.add_airecommendations")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("client.src.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_airecommendations")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("client.src.save_changes")} />
        </DialogContent>
      </Dialog>
    </>;
}