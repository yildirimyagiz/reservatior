"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
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
import { Edit, Trash2, MoreHorizontal, Loader2 } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { marketingApi } from "@/lib/api/marketing";
const STATUS: Record<string, {
  label: string;
  cls: string;
}> = {
  PENDING: {
    label: t("common.processing"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  CONVERTED: {
    label: t("client.src.converted"),
    cls: "bg-blue-100 text-blue-700"
  },
  REWARDED: {
    label: t("client.src.rewarded"),
    cls: "bg-blue-100 text-blue-700"
  }
};

const EMPTY_FORM = {
  referrerName: "",
  refereeName: "",
  type: "",
  status: "",
  rewardAmount: ""
};
export default function Referrals() {
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

  const { data: rawData, isLoading } = useQuery({
    queryKey: ['referrals'],
    queryFn: async () => {
      const response = await marketingApi.getReferrals() as any;
      return (response.data || []) as any[];
    }
  });

  const referrals = rawData || [];

  const filtered = referrals.filter(row => String(row.referrerName ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.refereeName ?? "").toLowerCase().includes(search.toLowerCase()));

  const createMutation = useMutation({
    mutationFn: (data: any) => marketingApi.createReferral(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['referrals'] });
      setCreateOpen(false);
      setForm(EMPTY_FORM);
      toast({ title: t("client.src.referrals_created") });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => marketingApi.updateReferral(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['referrals'] });
      setEditOpen(false);
      toast({ title: t("client.src.referrals_updated") });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => marketingApi.deleteReferral(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['referrals'] });
      toast({ title: t("client.src.referrals_deleted"), variant: "destructive" });
    }
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      referrerName: form.referrerName,
      refereeName: form.refereeName,
      type: form.type,
      status: form.status,
      rewardAmount: Number(form.rewardAmount) || 0
    });
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({
        id: form.id,
        data: {
          referrerName: form.referrerName,
          refereeName: form.refereeName,
          type: form.type,
          status: form.status,
          rewardAmount: Number(form.rewardAmount) || 0
        }
      });
    }
  };

  const handleDelete = (id: string) => deleteMutation.mutate(id);
  const openEdit = (row: any) => {
    const f: any = { id: row.id };
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
        <Label>{t("client.src.referrer_name")}</Label>
        <Input type="text" value={form.referrerName} onChange={e => setForm({
          ...form,
          referrerName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.referee_name")}</Label>
        <Input type="text" value={form.refereeName} onChange={e => setForm({
          ...form,
          refereeName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.type")}</Label>
        <Select value={form.type} onValueChange={v => setForm({
          ...form,
          type: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="CLIENT">{t("common.client")}</SelectItem>
          <SelectItem value="AGENT">{t("common.agent")}</SelectItem>
          <SelectItem value="VENDOR">{t("client.src.vendor")}</SelectItem></SelectContent></Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({
          ...form,
          status: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="PENDING">{t("common.processing")}</SelectItem>
          <SelectItem value="CONVERTED">{t("client.src.converted")}</SelectItem>
          <SelectItem value="REWARDED">{t("client.src.rewarded")}</SelectItem></SelectContent></Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.reward_amount")}</Label>
        <Input type="number" value={form.rewardAmount} onChange={e => setForm({
          ...form,
          rewardAmount: e.target.value
        })} />
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.referrals")} description={t("client.src.track_referral_sources_and")} createLabel="Add Referrals" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search referrals..." stats={[{
      label: t("common.total"),
      value: referrals.length
    }, {
      label: t("client.src.converted"),
      value: referrals.filter(r => r.status !== 'PENDING').length
    }, {
      label: t("client.src.rewards_paid"),
      value: `$${referrals.filter(r => r.rewardAmount).reduce((s, r) => s + (Number(r.rewardAmount) || 0), 0)}`
    }]} filters={null}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("client.src.referrer")}</TableHead>
              <TableHead>{t("client.src.referee")}</TableHead>
              <TableHead>{t("common.type")}</TableHead>
              <TableHead>{t("common.status")}</TableHead>
              <TableHead>{t("client.src.reward")}</TableHead>
              <TableHead>{t("common.date")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading && <TableRow><TableCell colSpan={7} className="text-center py-12"><Loader2 className="w-8 h-8 animate-spin mx-auto text-primary" /></TableCell></TableRow>}
              {!isLoading && filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("client.src.no_referrals_found")}</TableCell></TableRow>}
              {filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.referrerName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.refereeName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.type ?? "—"}</TableCell>
                    <TableCell>
                      {STATUS[row.status] ? <Badge className={`${STATUS[row.status].cls} border-0 text-xs`}>{STATUS[row.status].label}</Badge> : <span className="text-xs text-muted-foreground">{row.status}</span>}
                    </TableCell>
                    <TableCell className="text-sm">{row.rewardAmount ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.createdAt ?? "—"}</TableCell>
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
          <DialogHeader><DialogTitle>{t("client.src.add_referrals")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("common.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_referrals")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("common.save")} />
        </DialogContent>
      </Dialog>
    </>;
}