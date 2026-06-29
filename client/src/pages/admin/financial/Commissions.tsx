import React from 'react';
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { DollarSign, TrendingUp, ShieldCheck, Plus, Edit, Trash2, Loader2 } from "lucide-react";
import { useState } from "react";
import { cn } from "@/lib/utils";

interface Commission {
  id: string;
  orgId: string;
  agentId?: string;
  agencyId?: string;
  transactionId?: string;
  reservationId?: string;
  commissionAmount: number;
  commissionRate: number;
  amountBase: number;
  currency: string;
  status: string;
  createdAt: string;
}

const statusConfig: Record<string, { label: string; class: string }> = {
  PENDING: { label: "Pending", class: "bg-amber-500/20 text-amber-400" },
  APPROVED: { label: "Approved", class: "bg-blue-500/20 text-blue-400" },
  PAID: { label: "Paid", class: "bg-emerald-500/20 text-emerald-400" },
  CANCELLED: { label: "Cancelled", class: "bg-slate-500/20 text-slate-400" },
  OVERDUE: { label: "Overdue", class: "bg-red-500/20 text-red-400" },
  DISPUTED: { label: "Disputed", class: "bg-purple-500/20 text-purple-400" },
};

export default function Commissions() {
  const { t } = useTranslation();
  const queryClient = useQueryClient();
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [editingCommission, setEditingCommission] = useState<Commission | null>(null);
  const [formData, setFormData] = useState({ agentId: "", amountBase: 0, commissionRate: 0, currency: "USD", status: "PENDING" });

  const { data: commissionsData, isLoading } = useQuery({
    queryKey: ['commissions'],
    queryFn: async () => {
      const res: any = await apiClient.get('/commission');
      return (res?.data || []) as Commission[];
    },
  });

  const commissions = (commissionsData || []) as Commission[];

  const createMutation = useMutation({
    mutationFn: async (data: typeof formData) => {
      return apiClient.post('/commission', {
        commissionAmount: data.amountBase * (data.commissionRate / 100),
        commissionRate: data.commissionRate,
        amountBase: data.amountBase,
        currency: data.currency,
        status: data.status,
        orgId: "org_1",
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['commissions'] });
      setIsAddOpen(false);
      setFormData({ agentId: "", amountBase: 0, commissionRate: 0, currency: "USD", status: "PENDING" });
    },
  });

  const updateMutation = useMutation({
    mutationFn: async ({ id, data }: { id: string; data: any }) => {
      return apiClient.patch(`/commission/${id}`, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['commissions'] });
      setEditingCommission(null);
    },
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      return apiClient.delete(`/commission/${id}`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['commissions'] });
    },
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (editingCommission) {
      updateMutation.mutate({ id: editingCommission.id, data: { status: formData.status } });
    } else {
      createMutation.mutate(formData);
    }
  };

  const openEdit = (c: Commission) => {
    setEditingCommission(c);
    setFormData({ agentId: c.agentId || "", amountBase: c.amountBase, commissionRate: c.commissionRate, currency: c.currency, status: c.status });
  };

  const totalPaid = commissions.filter(c => c.status === "PAID").reduce((s, c) => s + c.commissionAmount, 0);
  const totalPending = commissions.filter(c => c.status === "PENDING").reduce((s, c) => s + c.commissionAmount, 0);

  return (
    <div className="p-6 space-y-6 min-h-screen">
      <div className="flex justify-between items-center bg-white/5 p-6 rounded-2xl border border-white/10">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-blue-600 rounded-xl shadow-lg shadow-blue-600/20">
            <DollarSign className="w-8 h-8 text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-white">
              {t("admin.financial.commission_management", "Commission Management")}
            </h1>
            <p className="text-slate-400">
              {t("admin.financial.define_and_track_commission", "Track and manage commissions")}
            </p>
          </div>
        </div>
        <Dialog open={isAddOpen || !!editingCommission} onOpenChange={(open) => { if (!open) { setIsAddOpen(false); setEditingCommission(null); } }}>
          <DialogTrigger asChild>
            <Button className="bg-blue-600 hover:bg-blue-700 text-white shadow-lg shadow-blue-500/20" onClick={() => { setIsAddOpen(true); setFormData({ agentId: "", amountBase: 0, commissionRate: 0, currency: "USD", status: "PENDING" }); }}>
              <Plus className="w-4 h-4 mr-2" />
              {t("admin.financial.new_commission", "New Commission")}
            </Button>
          </DialogTrigger>
          <DialogContent className="sm:max-w-[425px] bg-slate-900 border-white/10 text-white">
            <DialogHeader>
              <DialogTitle>
                {editingCommission ? t("admin.financial.edit_commission", "Edit Commission") : t("admin.financial.new_commission", "New Commission")}
              </DialogTitle>
              <DialogDescription className="text-slate-400">
                {editingCommission ? t("admin.financial.edit_commission_desc", "Update the commission status") : t("admin.financial.new_commission_desc", "Enter the commission details")}
              </DialogDescription>
            </DialogHeader>
            <form onSubmit={handleSubmit} className="space-y-4 pt-4">
              {!editingCommission && (
                <>
                  <div className="space-y-2">
                    <Label htmlFor="agentId">{t("admin.financial.agent_id", "Agent ID")}</Label>
                    <Input id="agentId" className="bg-white/5 border-white/10 text-white" value={formData.agentId} onChange={e => setFormData({ ...formData, agentId: e.target.value })} />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="amountBase">{t("admin.financial.base_amount", "Base Amount")}</Label>
                    <Input id="amountBase" type="number" className="bg-white/5 border-white/10 text-white" value={formData.amountBase} onChange={e => setFormData({ ...formData, amountBase: Number(e.target.value) })} required />
                  </div>
                  <div className="space-y-2">
                    <Label htmlFor="commissionRate">{t("admin.financial.commission_rate", "Rate (%)")}</Label>
                    <Input id="commissionRate" type="number" className="bg-white/5 border-white/10 text-white" value={formData.commissionRate} onChange={e => setFormData({ ...formData, commissionRate: Number(e.target.value) })} required />
                  </div>
                </>
              )}
              <div className="space-y-2">
                <Label htmlFor="status">{t("admin.financial.status", "Status")}</Label>
                <Select value={formData.status} onValueChange={(v: string) => setFormData({ ...formData, status: v })}>
                  <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
                  <SelectContent className="bg-slate-900 border-white/10 text-white">
                    {Object.keys(statusConfig).map(s => (
                      <SelectItem key={s} value={s}>{s}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
              <DialogFooter>
                <Button type="button" variant="ghost" onClick={() => { setIsAddOpen(false); setEditingCommission(null); }} className="text-slate-300">{t("common.cancel", "Cancel")}</Button>
                <Button type="submit" className="bg-blue-600 hover:bg-blue-700" disabled={createMutation.isPending || updateMutation.isPending}>
                  {(createMutation.isPending || updateMutation.isPending) ? t("common.saving", "Saving...") : (editingCommission ? t("common.update", "Update") : t("common.create", "Create"))}
                </Button>
              </DialogFooter>
            </form>
          </DialogContent>
        </Dialog>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.financial.total_commissions", "Total Commissions")}</p>
                <h3 className="text-2xl font-bold text-white mt-1">{commissions.length}</h3>
              </div>
              <div className="p-3 bg-blue-500/20 rounded-lg"><DollarSign className="w-5 h-5 text-blue-400" /></div>
            </div>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.financial.total_paid", "Total Paid")}</p>
                <h3 className="text-2xl font-bold text-white mt-1">${totalPaid.toLocaleString()}</h3>
              </div>
              <div className="p-3 bg-emerald-500/20 rounded-lg"><TrendingUp className="w-5 h-5 text-emerald-400" /></div>
            </div>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.financial.pending_amount", "Pending")}</p>
                <h3 className="text-2xl font-bold text-white mt-1">${totalPending.toLocaleString()}</h3>
              </div>
              <div className="p-3 bg-amber-500/20 rounded-lg"><ShieldCheck className="w-5 h-5 text-amber-400" /></div>
            </div>
          </CardContent>
        </Card>
      </div>

      <Card className="bg-white/5 border-white/10 overflow-hidden">
        <CardContent className="p-0">
          <Table>
            <TableHeader className="bg-white/5 border-b border-white/10">
              <TableRow className="hover:bg-transparent border-none">
                <TableHead className="text-xs font-medium text-slate-400 py-4 px-6">{t("admin.financial.id", "ID")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.amount", "Amount")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.rate", "Rate")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.base", "Base")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.status", "Status")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.created", "Created")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.actions", "Actions")}</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? (
                <TableRow><TableCell colSpan={7} className="text-center py-8 text-slate-500"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow>
              ) : commissions.length === 0 ? (
                <TableRow><TableCell colSpan={7} className="text-center py-8 text-slate-500">{t("admin.financial.no_commissions", "No commissions found")}</TableCell></TableRow>
              ) : commissions.map(c => {
                const cfg = statusConfig[c.status] || statusConfig.PENDING;
                return (
                  <TableRow key={c.id} className="border-b border-white/10 hover:bg-white/5 transition-colors">
                    <TableCell className="py-4 px-6 font-mono text-xs text-slate-400">{c.id.slice(0, 8)}...</TableCell>
                    <TableCell className="px-6 font-bold text-white">${c.commissionAmount.toLocaleString()}</TableCell>
                    <TableCell className="px-6 text-sm text-slate-300">{c.commissionRate}%</TableCell>
                    <TableCell className="px-6 text-sm text-slate-400">${c.amountBase.toLocaleString()}</TableCell>
                    <TableCell className="px-6">
                      <Badge className={cn("border-0", cfg.class)}>{cfg.label}</Badge>
                    </TableCell>
                    <TableCell className="px-6 text-xs text-slate-400 font-mono">{new Date(c.createdAt).toLocaleDateString()}</TableCell>
                    <TableCell className="px-6">
                      <div className="flex gap-2">
                        <Button size="sm" variant="ghost" className="text-slate-400 hover:text-white" onClick={() => openEdit(c)}>
                          <Edit className="w-3 h-3" />
                        </Button>
                        <Button size="sm" variant="ghost" className="text-red-400 hover:text-red-300" onClick={() => deleteMutation.mutate(c.id)}>
                          <Trash2 className="w-3 h-3" />
                        </Button>
                      </div>
                    </TableCell>
                  </TableRow>
                );
              })}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
}
