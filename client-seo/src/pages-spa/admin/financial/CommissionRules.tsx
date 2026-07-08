"use client";

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
import { Percent, DollarSign, TrendingUp, ShieldCheck, Plus, Edit, Trash2, Loader2 } from "lucide-react";
import { useState } from "react";
import { cn } from "@/lib/utils";

interface CommissionRule {
  id: string;
  providerId: string;
  ruleType: "PERCENTAGE" | "FLAT" | "TIERED";
  commission: number;
  minVolume?: number;
  maxVolume?: number;
  conditions?: any;
  createdAt: string;
}

export default function CommissionRules() {
  const { t } = useTranslation();
  const queryClient = useQueryClient();
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [editingRule, setEditingRule] = useState<CommissionRule | null>(null);
  const [formData, setFormData] = useState({ providerId: "", ruleType: "PERCENTAGE" as CommissionRule["ruleType"], commission: 0, minVolume: 0 });

  const { data: rulesData, isLoading } = useQuery({
    queryKey: ['commission-rules'],
    queryFn: async () => {
      const res: any = await apiClient.get('/financials/commission-rules');
      return (res?.data || []) as CommissionRule[];
    },
  });

  const rules = (rulesData || []) as CommissionRule[];

  const createMutation = useMutation({
    mutationFn: async (data: typeof formData) => {
      return apiClient.post('/financials/commission-rules', data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['commission-rules'] });
      setIsAddOpen(false);
      setFormData({ providerId: "", ruleType: "PERCENTAGE", commission: 0, minVolume: 0 });
    },
  });

  const updateMutation = useMutation({
    mutationFn: async ({ id, data }: { id: string; data: Partial<CommissionRule> }) => {
      return apiClient.patch(`/financials/commission-rules/${id}`, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['commission-rules'] });
      setEditingRule(null);
    },
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => {
      return apiClient.delete(`/financials/commission-rules/${id}`);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['commission-rules'] });
    },
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (editingRule) {
      updateMutation.mutate({ id: editingRule.id, data: formData });
    } else {
      createMutation.mutate(formData);
    }
  };

  const openEdit = (rule: CommissionRule) => {
    setEditingRule(rule);
    setFormData({
      providerId: rule.providerId,
      ruleType: rule.ruleType,
      commission: rule.commission,
      minVolume: rule.minVolume || 0,
    });
  };

  const avgCommission = rules.length > 0
    ? (rules.reduce((s, r) => s + r.commission, 0) / rules.length).toFixed(1)
    : "0";

  return (
    <div className="space-y-6 min-h-screen">
      <div className="flex justify-between items-center bg-white/5 p-6 rounded-2xl border border-slate-200 dark:border-white/10">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-slate-600 rounded-xl shadow-lg shadow-slate-600/20">
            <Percent className="w-8 h-8 text-slate-900 dark:text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-slate-900 dark:text-white">
              {t("admin.financial.commission_rules", "Commission Rules")}
            </h1>
            <p className="text-slate-500 dark:text-slate-400">
              {t("admin.financial.define_and_track_commission", "Define and track commission rules")}
            </p>
          </div>
        </div>
        <Dialog open={isAddOpen || !!editingRule} onOpenChange={(open) => { if (!open) { setIsAddOpen(false); setEditingRule(null); } }}>
          <DialogTrigger asChild>
            <Button className="bg-slate-600 hover:bg-slate-700 text-slate-900 dark:text-white shadow-lg shadow-slate-500/20" onClick={() => { setIsAddOpen(true); setFormData({ providerId: "", ruleType: "PERCENTAGE", commission: 0, minVolume: 0 }); }}>
              <Plus className="w-4 h-4 mr-2" />
              {t("admin.financial.new_rule", "New Rule")}
            </Button>
          </DialogTrigger>
          <DialogContent className="sm:max-w-[425px] bg-white dark:bg-slate-900 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
            <DialogHeader>
              <DialogTitle>
                {editingRule ? t("admin.financial.edit_rule", "Edit Rule") : t("admin.financial.new_rule", "New Rule")}
              </DialogTitle>
              <DialogDescription className="text-slate-500 dark:text-slate-400">
                {editingRule ? t("admin.financial.edit_rule_desc", "Update the commission rule details") : t("admin.financial.new_rule_desc", "Enter the details for the new rule")}
              </DialogDescription>
            </DialogHeader>
            <form onSubmit={handleSubmit} className="space-y-4 pt-4">
              <div className="space-y-2">
                <Label htmlFor="providerId">{t("admin.financial.provider", "Provider")}</Label>
                <Input id="providerId" className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white" value={formData.providerId} onChange={e => setFormData({ ...formData, providerId: e.target.value })} required />
              </div>
              <div className="space-y-2">
                <Label htmlFor="ruleType">{t("admin.financial.rule_type", "Rule Type")}</Label>
                <Select value={formData.ruleType} onValueChange={(v: CommissionRule["ruleType"]) => setFormData({ ...formData, ruleType: v })}>
                  <SelectTrigger className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white"><SelectValue /></SelectTrigger>
                  <SelectContent className="bg-white dark:bg-slate-900 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                    <SelectItem value="PERCENTAGE">{t("admin.financial.percentage", "Percentage")}</SelectItem>
                    <SelectItem value="FLAT">{t("admin.financial.flat", "Flat")}</SelectItem>
                    <SelectItem value="TIERED">{t("admin.financial.tiered", "Tiered")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label htmlFor="commission">{t("admin.financial.commission", "Commission")}</Label>
                <Input id="commission" type="number" className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white" value={formData.commission} onChange={e => setFormData({ ...formData, commission: Number(e.target.value) })} required />
              </div>
              <div className="space-y-2">
                <Label htmlFor="minVolume">{t("admin.financial.min_volume", "Min Volume")}</Label>
                <Input id="minVolume" type="number" className="bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white" value={formData.minVolume} onChange={e => setFormData({ ...formData, minVolume: Number(e.target.value) })} />
              </div>
              <DialogFooter>
                <Button type="button" variant="ghost" onClick={() => { setIsAddOpen(false); setEditingRule(null); }} className="text-slate-300">{t("common.cancel", "Cancel")}</Button>
                <Button type="submit" className="bg-slate-600 hover:bg-slate-700" disabled={createMutation.isPending || updateMutation.isPending}>
                  {(createMutation.isPending || updateMutation.isPending) ? t("common.saving", "Saving...") : (editingRule ? t("common.update", "Update") : t("common.create", "Create"))}
                </Button>
              </DialogFooter>
            </form>
          </DialogContent>
        </Dialog>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <Card className="bg-white/5 border-slate-200 dark:border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-500 dark:text-slate-400">{t("admin.financial.avg_commission", "Avg Commission")}</p>
                <h3 className="text-2xl font-bold text-slate-900 dark:text-white mt-1">{avgCommission}%</h3>
              </div>
              <div className="p-3 bg-slate-500/20 rounded-lg"><Percent className="w-5 h-5 text-slate-500 dark:text-slate-400" /></div>
            </div>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-slate-200 dark:border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-500 dark:text-slate-400">{t("admin.financial.total_payouts", "Total Payouts")}</p>
                <h3 className="text-2xl font-bold text-slate-900 dark:text-white mt-1">${(rules.reduce((s, r) => s + r.commission, 0)).toLocaleString()}</h3>
              </div>
              <div className="p-3 bg-emerald-500/20 rounded-lg"><DollarSign className="w-5 h-5 text-emerald-400" /></div>
            </div>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-slate-200 dark:border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-500 dark:text-slate-400">{t("admin.financial.active_rules", "Active Rules")}</p>
                <h3 className="text-2xl font-bold text-slate-900 dark:text-white mt-1">{rules.length}</h3>
              </div>
              <div className="p-3 bg-slate-500/20 rounded-lg"><ShieldCheck className="w-5 h-5 text-slate-500 dark:text-slate-400" /></div>
            </div>
          </CardContent>
        </Card>
      </div>

      <Card className="bg-white/5 border-slate-200 dark:border-white/10 overflow-hidden">
        <CardContent className="p-0">
          <Table>
            <TableHeader className="bg-white/5 border-b border-slate-200 dark:border-white/10">
              <TableRow className="hover:bg-transparent border-none">
                <TableHead className="text-xs font-medium text-slate-500 dark:text-slate-400 py-4 px-6">{t("admin.financial.provider_source", "Provider")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-500 dark:text-slate-400 px-6">{t("admin.financial.rule_type", "Type")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-500 dark:text-slate-400 px-6">{t("admin.financial.commission", "Commission")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-500 dark:text-slate-400 px-6">{t("admin.financial.min_volume", "Min Volume")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-500 dark:text-slate-400 px-6">{t("admin.financial.created", "Created")}</TableHead>
                <TableHead className="text-xs font-medium text-slate-500 dark:text-slate-400 px-6">{t("admin.financial.actions", "Actions")}</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? (
                <TableRow><TableCell colSpan={6} className="text-center py-8 text-slate-500"><Loader2 className="w-6 h-6 animate-spin mx-auto" /></TableCell></TableRow>
              ) : rules.length === 0 ? (
                <TableRow><TableCell colSpan={6} className="text-center py-8 text-slate-500">{t("admin.financial.no_rules", "No commission rules found")}</TableCell></TableRow>
              ) : rules.map(rule => (
                <TableRow key={rule.id} className="border-b border-slate-200 dark:border-white/10 hover:bg-white/5 transition-colors">
                  <TableCell className="py-4 px-6 font-medium text-slate-900 dark:text-white">{rule.providerId}</TableCell>
                  <TableCell className="px-6">
                    <Badge className={cn(
                      "border-0 text-[10px]",
                      rule.ruleType === "PERCENTAGE" ? "bg-slate-500/20 text-slate-500 dark:text-slate-400" :
                      rule.ruleType === "FLAT" ? "bg-emerald-500/20 text-emerald-400" :
                      "bg-slate-500/20 text-slate-500 dark:text-slate-400"
                    )}>
                      {rule.ruleType}
                    </Badge>
                  </TableCell>
                  <TableCell className="px-6 font-bold text-slate-900 dark:text-white">
                    {rule.ruleType === "PERCENTAGE" ? `${rule.commission}%` : `$${rule.commission.toLocaleString()}`}
                  </TableCell>
                  <TableCell className="px-6 text-sm text-slate-500 dark:text-slate-400">
                    {rule.minVolume ? `$${rule.minVolume.toLocaleString()}+` : "—"}
                  </TableCell>
                  <TableCell className="px-6 text-xs text-slate-500 dark:text-slate-400 font-mono">
                    {new Date(rule.createdAt).toLocaleDateString()}
                  </TableCell>
                  <TableCell className="px-6">
                    <div className="flex gap-2">
                      <Button size="sm" variant="ghost" className="text-slate-500 dark:text-slate-400 hover:text-white" onClick={() => openEdit(rule)}>
                        <Edit className="w-3 h-3" />
                      </Button>
                      <Button size="sm" variant="ghost" className="text-red-400 hover:text-red-300" onClick={() => deleteMutation.mutate(rule.id)}>
                        <Trash2 className="w-3 h-3" />
                      </Button>
                    </div>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  );
}
