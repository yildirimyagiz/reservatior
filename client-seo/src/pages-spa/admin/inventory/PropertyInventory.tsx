"use client";

import React from 'react';
import { apiClient } from "@/lib/api/client";
import { useQuery, useMutation } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { useNavigate } from "@/lib/react-router-shim";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { inventoryApi } from "@/lib/api/inventory";
import { propertiesApi } from "@/lib/api/properties";
import { Search, Plus, AlertCircle, Camera, Activity, Zap, Box, Eye, Sparkles } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { cn } from "@/lib/utils";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";

export default function PropertyInventoryManagement() {
  const { toast } = useToast();
  const { t } = useTranslation();
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [formData, setFormData] = React.useState({ propertyId: "", type: "", quantity: "" });
  const [searchTerm, setSearchTerm] = useState("");
  const navigate = useNavigate();

  const { data: inventories = [], isLoading } = useQuery({
    queryKey: ['property-inventories'],
    queryFn: async () => {
      const response = await inventoryApi.getInventories();
      return (response as any).data || [];
    },
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      const res = await apiClient.post('/property-inventory', data);
      return res;
    },
    onSuccess: () => {
      setIsAddOpen(false);
      toast({ title: "Success", description: "Inventory created successfully" });
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
    }
  });

  const getConditionStyle = (condition: string) => {
    switch (condition.toLowerCase()) {
      case "excellent":
      case "new":
        return "bg-emerald-500/10 text-emerald-400 border-emerald-500/20";
      case "good":
      case "fair":
        return "bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-500/20";
      case "poor":
      case "damaged":
        return "bg-rose-500/10 text-rose-400 border-rose-500/20";
      default:
        return "bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-200 dark:border-white/10";
    }
  };

  const getLocalizedType = (type: string) => {
    const map: Record<string, string> = {
      'CHECK_IN': t('admin_inventory_type_check_in', 'Giriş'),
      'CHECK_OUT': t('admin_inventory_type_check_out', 'Çıkış'),
      'INTERIM': t('admin_inventory_type_interim', 'Ara Kontrol'),
      'MAINTENANCE': t('admin_inventory_type_maintenance', 'Bakım')
    };
    return map[type] || type;
  };

  const getLocalizedCondition = (condition: string) => {
    const map: Record<string, string> = {
      'new': t('admin_inventory_condition_new', 'Yeni'),
      'excellent': t('admin_inventory_condition_excellent', 'Mükemmel'),
      'good': t('admin_inventory_condition_good', 'İyi'),
      'fair': t('admin_inventory_condition_fair', 'Orta'),
      'poor': t('admin_inventory_condition_poor', 'Kötü'),
      'damaged': t('admin_inventory_condition_damaged', 'Hasarlı')
    };
    return map[condition.toLowerCase()] || condition;
  };

  const filteredInventories = inventories.filter((item: any) =>
    item.propertyId?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    item.inventoryType?.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="space-y-6">
      {/* KPI GRID */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        {[{
          label: t("admin_inventory_total_assets"),
          val: inventories.length,
          icon: Box,
          color: "text-slate-500 dark:text-slate-400"
        }, {
          label: t("admin_inventory_anomalies"),
          val: inventories.filter((i: any) => i.cleaningRequired).length,
          icon: AlertCircle,
          color: "text-rose-500"
        }, {
          label: t("admin_inventory_excellent_condition"),
          val: inventories.filter((i: any) => i.overallCondition?.toLowerCase() === 'excellent' || i.overallCondition?.toLowerCase() === 'new').length,
          icon: Zap,
          color: "text-emerald-400"
        }, {
          label: t("admin_inventory_sync_status"),
          val: t("admin_inventory_optimal", "Optimal"),
          icon: Activity,
          color: "text-slate-500 dark:text-slate-400"
        }].map((stat, i) => (
          <Card key={i} className="bg-white/5 border-slate-200 dark:border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group">
            <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
              <stat.icon className="w-12 h-12" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mb-1">{stat.label}</p>
              <h3 className="text-xl font-bold text-slate-900 dark:text-white leading-none">{stat.val}</h3>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* TACTICAL FILTERS */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 px-4">
        <div className="relative flex-1 max-w-md group">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500 dark:text-slate-400 group-focus-within:text-slate-500 transition-colors" />
          <Input
            placeholder={t("admin_inventory_search_inventory_cluster")}
            className="bg-white/5 border-slate-200 dark:border-white/10 rounded-2xl pl-12 h-14 text-slate-900 dark:text-white focus:ring-slate-500/20 transition-all font-medium"
            value={searchTerm}
            onChange={e => setSearchTerm(e.target.value)}
          />
        </div>

        <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
          <DialogTrigger asChild>
            <Button className="h-14 px-8 rounded-2xl bg-slate-600 hover:bg-slate-500 text-slate-900 dark:text-white font-bold text-[10px] gap-2 shadow-xl shadow-slate-600/20">
              <Plus className="w-4 h-4" />{t("admin_inventory_initialize_inventory")}
            </Button>
          </DialogTrigger>
          <DialogContent className="sm:max-w-[425px] bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
            <DialogHeader>
              <DialogTitle>Create New Inventory</DialogTitle>
              <DialogDescription className="text-slate-500 dark:text-slate-400">
                Enter the details for the new inventory.
              </DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="propertyId" className="text-right text-xs text-slate-500 dark:text-slate-400">Property ID</Label>
                <Input
                  id="propertyId"
                  className="col-span-3 h-10 bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white"
                  value={formData.propertyId}
                  onChange={e => setFormData({ ...formData, propertyId: e.target.value })}
                  placeholder="Enter property id"
                />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="type" className="text-right text-xs text-slate-500 dark:text-slate-400">Type</Label>
                <Input
                  id="type"
                  className="col-span-3 h-10 bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white"
                  value={formData.type}
                  onChange={e => setFormData({ ...formData, type: e.target.value })}
                  placeholder="Enter type"
                />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="quantity" className="text-right text-xs text-slate-500 dark:text-slate-400">Quantity</Label>
                <Input
                  id="quantity"
                  className="col-span-3 h-10 bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white"
                  value={formData.quantity}
                  onChange={e => setFormData({ ...formData, quantity: e.target.value })}
                  placeholder="Enter quantity"
                />
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setIsAddOpen(false)}>Cancel</Button>
              <Button onClick={() => createMutation.mutate(formData)} disabled={createMutation.isPending}>
                {createMutation.isPending ? "Saving..." : "Save Changes"}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>

      {/* DATA TABLE */}
      <Card className="bg-white/5 border-slate-200 dark:border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
        <CardContent className="p-0">
          <Table>
            <TableHeader className="bg-white/5 border-b border-slate-200 dark:border-white/10">
              <TableRow className="hover:bg-transparent border-none">
                <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 py-6 px-8">{t("admin_inventory_asset_identity")}</TableHead>
                <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8">{t("admin_inventory_category_class")}</TableHead>
                <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8">{t("admin_inventory_temporal_state")}</TableHead>
                <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8">{t("admin_inventory_condition_profile")}</TableHead>
                <TableHead className="text-[10px] font-bold text-slate-500 dark:text-slate-400 px-8 text-right">{t("admin_inventory_actions")}</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? (
                <TableRow>
                  <TableCell colSpan={5} className="py-20 text-center">
                    <Activity className="w-8 h-8 text-slate-500 animate-spin mx-auto mb-4 opacity-50" />
                    <p className="text-xs font-bold text-slate-500 dark:text-slate-400 animate-pulse">{t("admin_inventory_syncing_inventory_matrix")}</p>
                  </TableCell>
                </TableRow>
              ) : filteredInventories.map((inventory: any) => (
                <TableRow key={inventory.id} className="border-b border-slate-200 dark:border-white/10 hover:bg-white/5 transition-all group">
                  <TableCell className="py-8 px-8">
                    <div className="flex items-center gap-6">
                      <div className="p-3 bg-white/5 border border-slate-200 dark:border-white/10 rounded-2xl group-hover:rotate-12 transition-all">
                        <Box className="w-5 h-5 text-slate-500 dark:text-slate-400" />
                      </div>
                      <div>
                        <h6 className="text-sm font-bold text-slate-900 dark:text-white leading-none">{t("admin_inventory_ref")}{inventory.propertyId?.substring(0, 8)}</h6>
                        <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mt-1">{inventory.conductedBy}</p>
                      </div>
                    </div>
                  </TableCell>
                  <TableCell className="px-8">
                    <Badge variant="outline" className="text-[9px] font-bold border-slate-200 dark:border-white/10 text-slate-500 dark:text-slate-400 px-2 py-0.5">
                      {getLocalizedType(inventory.inventoryType)}
                    </Badge>
                  </TableCell>
                  <TableCell className="px-8">
                    <span className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{new Date(inventory.inventoryDate).toLocaleDateString()}</span>
                  </TableCell>
                  <TableCell className="px-8">
                    <div className="flex flex-col gap-2">
                      <Badge className={cn("text-[8px] font-bold px-2 py-0.5 border-none w-fit", getConditionStyle(inventory.overallCondition))}>
                        {getLocalizedCondition(inventory.overallCondition)}
                      </Badge>
                      {inventory.cleaningRequired && (
                        <div className="flex items-center gap-1 text-[8px] font-bold text-rose-500">
                          <AlertCircle className="w-3 h-3" />{t("admin_inventory_sanitization_req")}
                        </div>
                      )}
                    </div>
                  </TableCell>
                  <TableCell className="px-8 text-right">
                    <div className="flex justify-end gap-2">
                      <Button variant="ghost" onClick={() => navigate(`/admin/inventory/${inventory.id}/scan`)} className="h-12 w-12 rounded-2xl hover:bg-white/5 text-slate-500 dark:text-slate-400 hover:text-white" title={t("admin_inventory_spatial_scan")}>
                        <Camera className="w-5 h-5" />
                      </Button>
                      <Button variant="ghost" onClick={() => {
                        toast({ title: t("admin_inventory_ai_staging_started", "AI Staging Started"), description: t("admin_inventory_ai_processing", "Visuals are being processed by AI models.") });
                        propertiesApi.runAIStaging(inventory.propertyId).then(() => {
                          toast({ title: t("admin_inventory_ai_staging_complete", "AI Staging Complete"), description: t("admin_inventory_ai_staging_success", "Images have been successfully staged.") });
                        }).catch((err: any) => {
                          toast({ title: "Error", description: err.message, variant: "destructive" });
                        });
                      }} className="h-12 w-12 rounded-2xl hover:bg-white/5 text-slate-500 dark:text-slate-400 hover:text-indigo-400" title={t("admin_inventory_run_ai_staging", "Run AI Staging")}>
                        <Sparkles className="w-5 h-5 text-indigo-400" />
                      </Button>
                      <Button variant="ghost" onClick={() => navigate(`/admin/inventory/${inventory.id}`)} className="h-12 w-12 rounded-2xl hover:bg-white/5 text-slate-500 dark:text-slate-400 hover:text-white">
                        <Eye className="w-5 h-5" />
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
