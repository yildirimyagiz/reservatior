"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Edit, Trash2, MoreHorizontal } from "lucide-react";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { agentPerformanceApi, AgentPerformance as ApiAgentPerformance } from "@/lib/api/agent-performance";
import { useAuth } from "@/lib/auth/hooks";
import { Loader2 } from "lucide-react";

const EMPTY_FORM = {
  agentName: "",
  period: "",
  leadsGenerated: "",
  dealsClosed: "",
  commissionEarned: "",
  rating: ""
};
export default function AgentPerformance() {
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
  const { user } = useAuth();
  const orgId = (user as any)?.organizationId || "org-1";

  const { data: rawData = [], isLoading } = useQuery({
    queryKey: ['agent-performance', orgId],
    queryFn: async () => {
      const response = await agentPerformanceApi.getAll(orgId) as any;
      return (response.data || response || []) as ApiAgentPerformance[];
    }
  });

  const performances = rawData.map(p => ({
    id: p.id,
    agentName: p.agent ? `${p.agent.firstName} ${p.agent.lastName}` : "Unknown Agent",
    period: p.period,
    leadsGenerated: p.leadsGenerated || 0,
    showingsCompleted: p.showingsCompleted || 0,
    offersSubmitted: p.offersSubmitted || 0,
    dealsClosed: p.dealsClosed || 0,
    commissionEarned: p.commissionEarned || 0,
    rating: p.rating || 0
  }));

  const filtered = performances.filter(row => String(row.agentName ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.period ?? "").toLowerCase().includes(search.toLowerCase()));

  const createMutation = useMutation({
    mutationFn: (data: Partial<ApiAgentPerformance>) => agentPerformanceApi.create(orgId, data as any),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agent-performance', orgId] });
      setCreateOpen(false);
      setForm(EMPTY_FORM);
      toast({ title: t("client.src.agentperformance_created") });
    }
  });

  const updateMutation = useMutation({
    mutationFn: (vars: { id: string, data: Partial<ApiAgentPerformance> }) => agentPerformanceApi.update(orgId, vars.id, vars.data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agent-performance', orgId] });
      setEditOpen(false);
      toast({ title: t("client.src.agentperformance_updated") });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => agentPerformanceApi.delete(orgId, id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agent-performance', orgId] });
      toast({ title: t("client.src.agentperformance_deleted"), variant: "destructive" });
    }
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      period: form.period,
      leadsGenerated: Number(form.leadsGenerated),
      dealsClosed: Number(form.dealsClosed),
      commissionEarned: Number(form.commissionEarned),
      rating: Number(form.rating),
      agentId: "agent-id" // Needs actual agent ID selection in real UI
    });
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({
        id: form.id,
        data: {
          period: form.period,
          leadsGenerated: Number(form.leadsGenerated),
          dealsClosed: Number(form.dealsClosed),
          commissionEarned: Number(form.commissionEarned),
          rating: Number(form.rating)
        }
      });
    }
  };

  const handleDelete = (id: string) => deleteMutation.mutate(id);
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
        <Label>{t("client.src.agent_name")}</Label>
        <Input type="text" value={form.agentName} onChange={e => setForm({
          ...form,
          agentName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.period")}</Label>
        <Input type="text" value={form.period} onChange={e => setForm({
          ...form,
          period: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.leads_generated")}</Label>
        <Input type="number" value={form.leadsGenerated} onChange={e => setForm({
          ...form,
          leadsGenerated: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.deals_closed")}</Label>
        <Input type="number" value={form.dealsClosed} onChange={e => setForm({
          ...form,
          dealsClosed: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.commission_earned")}</Label>
        <Input type="number" value={form.commissionEarned} onChange={e => setForm({
          ...form,
          commissionEarned: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.rating")}</Label>
        <Input type="number" value={form.rating} onChange={e => setForm({
          ...form,
          rating: e.target.value
        })} />
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.agent_performance")} description={t("client.src.track_agent_kpis_and")} createLabel="Add AgentPerformance" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search agent performance..." stats={[{
      label: t("client.src.agents"),
      value: performances.length
    }, {
      label: t("client.src.total_deals"),
      value: performances.reduce((s, r) => s + (r.dealsClosed || 0), 0)
    }, {
      label: t("client.src.total_commission"),
      value: `$${performances.reduce((s, r) => s + (r.commissionEarned || 0), 0).toLocaleString()}`
    }, {
      label: t("client.src.avg_rating"),
      value: performances.length ? `${(performances.reduce((s, r) => s + (r.rating || 0), 0) / performances.length).toFixed(1)}` : "0"
    }]} filters={null}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("common.agent")}</TableHead>
              <TableHead>{t("client.src.period")}</TableHead>
              <TableHead>{t("client.src.leads")}</TableHead>
              <TableHead>{t("client.src.deals_closed")}</TableHead>
              <TableHead>{t("client.src.success_rate")}</TableHead>
              <TableHead>{t("client.src.rating")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground"><Loader2 className="w-8 h-8 animate-spin mx-auto text-primary" /></TableCell></TableRow>}
              {!isLoading && filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("client.src.no_agent_performance_found")}</TableCell></TableRow>}
              {filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.agentName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.period ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.leadsGenerated ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.dealsClosed ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.commissionEarned ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.rating ?? "—"}</TableCell>
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
          <DialogHeader><DialogTitle>{t("client.src.add_agentperformance")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("common.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_agentperformance")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("common.save")} />
        </DialogContent>
      </Dialog>
    </>;
}