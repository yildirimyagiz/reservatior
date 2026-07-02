import React from 'react';
import { apiClient } from "@/lib/api/client";
import { useQuery, useMutation } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { inventoryApi } from "@/lib/api/inventory";
import { Search, Plus, AlertCircle, Camera, Activity, Zap, Box, Eye } from "lucide-react";
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
        return "bg-blue-500/10 text-blue-400 border-blue-500/20";
      case "poor":
      case "damaged":
        return "bg-rose-500/10 text-rose-400 border-rose-500/20";
      default:
        return "bg-slate-500/10 text-slate-400 border-white/10";
    }
  };

  const getLocalizedType = (type: string) => {
    const map: Record<string, string> = {
      'CHECK_IN': t('admin.inventory.type.check_in', 'Giriş'),
      'CHECK_OUT': t('admin.inventory.type.check_out', 'Çıkış'),
      'INTERIM': t('admin.inventory.type.interim', 'Ara Kontrol'),
      'MAINTENANCE': t('admin.inventory.type.maintenance', 'Bakım')
    };
    return map[type] || type;
  };

  const getLocalizedCondition = (condition: string) => {
    const map: Record<string, string> = {
      'new': t('admin.inventory.condition.new', 'Yeni'),
      'excellent': t('admin.inventory.condition.excellent', 'Mükemmel'),
      'good': t('admin.inventory.condition.good', 'İyi'),
      'fair': t('admin.inventory.condition.fair', 'Orta'),
      'poor': t('admin.inventory.condition.poor', 'Kötü'),
      'damaged': t('admin.inventory.condition.damaged', 'Hasarlı')
    };
    return map[condition.toLowerCase()] || condition;
  };

  const filteredInventories = inventories.filter(item =>
    item.propertyId?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    item.inventoryType?.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="p-6 space-y-6">
      {/* KPI GRID */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        {[{
          label: t("admin.inventory.total_assets"),
          val: inventories.length,
          icon: Box,
          color: "text-blue-400"
        }, {
          label: t("admin.inventory.anomalies"),
          val: inventories.filter(i => i.cleaningRequired).length,
          icon: AlertCircle,
          color: "text-rose-500"
        }, {
          label: t("admin.inventory.excellent_condition"),
          val: inventories.filter(i => i.overallCondition?.toLowerCase() === 'excellent' || i.overallCondition?.toLowerCase() === 'new').length,
          icon: Zap,
          color: "text-emerald-400"
        }, {
          label: t("admin.inventory.sync_status"),
          val: t("admin.inventory.optimal", "Optimal"),
          icon: Activity,
          color: "text-purple-400"
        }].map((stat, i) => (
          <Card key={i} className="bg-white/5 border-white/10 rounded-3xl overflow-hidden shadow-2xl relative group">
            <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
              <stat.icon className="w-12 h-12" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-slate-400 mb-1">{stat.label}</p>
              <h3 className="text-xl font-bold text-white leading-none">{stat.val}</h3>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* TACTICAL FILTERS */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 px-4">
        <div className="relative flex-1 max-w-md group">
          <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 group-focus-within:text-blue-500 transition-colors" />
          <Input
            placeholder={t("admin.inventory.search_inventory_cluster")}
            className="bg-white/5 border-white/10 rounded-2xl pl-12 h-14 text-white focus:ring-blue-500/20 transition-all font-medium"
            value={searchTerm}
            onChange={e => setSearchTerm(e.target.value)}
          />
        </div>

        <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
          <DialogTrigger asChild>
            <Button className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-white font-bold text-[10px] gap-2 shadow-xl shadow-blue-600/20">
              <Plus className="w-4 h-4" />{t("admin.inventory.initialize_inventory")}
            </Button>
          </DialogTrigger>
          <DialogContent className="sm:max-w-[425px] bg-white/5 border-white/10 text-white">
            <DialogHeader>
              <DialogTitle>Create New Inventory</DialogTitle>
              <DialogDescription className="text-slate-400">
                Enter the details for the new inventory.
              </DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="propertyId" className="text-right text-xs text-slate-400">Property ID</Label>
                <Input
                  id="propertyId"
                  className="col-span-3 h-10 bg-white/5 border-white/10 text-white"
                  value={formData.propertyId}
                  onChange={e => setFormData({ ...formData, propertyId: e.target.value })}
                  placeholder="Enter property id"
                />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="type" className="text-right text-xs text-slate-400">Type</Label>
                <Input
                  id="type"
                  className="col-span-3 h-10 bg-white/5 border-white/10 text-white"
                  value={formData.type}
                  onChange={e => setFormData({ ...formData, type: e.target.value })}
                  placeholder="Enter type"
                />
              </div>
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="quantity" className="text-right text-xs text-slate-400">Quantity</Label>
                <Input
                  id="quantity"
                  className="col-span-3 h-10 bg-white/5 border-white/10 text-white"
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
      <Card className="bg-white/5 border-white/10 rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
        <CardContent className="p-0">
          <Table>
            <TableHeader className="bg-white/5 border-b border-white/10">
              <TableRow className="hover:bg-transparent border-none">
                <TableHead className="text-[10px] font-bold text-slate-400 py-6 px-8">{t("admin.inventory.asset_identity")}</TableHead>
                <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.inventory.category_class")}</TableHead>
                <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.inventory.temporal_state")}</TableHead>
                <TableHead className="text-[10px] font-bold text-slate-400 px-8">{t("admin.inventory.condition_profile")}</TableHead>
                <TableHead className="text-[10px] font-bold text-slate-400 px-8 text-right">{t("admin.inventory.actions")}</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? (
                <TableRow>
                  <TableCell colSpan={5} className="py-20 text-center">
                    <Activity className="w-8 h-8 text-blue-500 animate-spin mx-auto mb-4 opacity-50" />
                    <p className="text-xs font-bold text-slate-400 animate-pulse">{t("admin.inventory.syncing_inventory_matrix")}</p>
                  </TableCell>
                </TableRow>
              ) : filteredInventories.map(inventory => (
                <TableRow key={inventory.id} className="border-b border-white/10 hover:bg-white/5 transition-all group">
                  <TableCell className="py-8 px-8">
                    <div className="flex items-center gap-6">
                      <div className="p-3 bg-white/5 border border-white/10 rounded-2xl group-hover:rotate-12 transition-all">
                        <Box className="w-5 h-5 text-blue-400" />
                      </div>
                      <div>
                        <h6 className="text-sm font-bold text-white leading-none">{t("admin.inventory.ref")}{inventory.propertyId?.substring(0, 8)}</h6>
                        <p className="text-[10px] font-bold text-slate-400 mt-1">{inventory.conductedBy}</p>
                      </div>
                    </div>
                  </TableCell>
                  <TableCell className="px-8">
                    <Badge variant="outline" className="text-[9px] font-bold border-white/10 text-slate-400 px-2 py-0.5">
                      {getLocalizedType(inventory.inventoryType)}
                    </Badge>
                  </TableCell>
                  <TableCell className="px-8">
                    <span className="text-[10px] font-bold text-slate-400">{new Date(inventory.inventoryDate).toLocaleDateString()}</span>
                  </TableCell>
                  <TableCell className="px-8">
                    <div className="flex flex-col gap-2">
                      <Badge className={cn("text-[8px] font-bold px-2 py-0.5 border-none w-fit", getConditionStyle(inventory.overallCondition))}>
                        {getLocalizedCondition(inventory.overallCondition)}
                      </Badge>
                      {inventory.cleaningRequired && (
                        <div className="flex items-center gap-1 text-[8px] font-bold text-rose-500">
                          <AlertCircle className="w-3 h-3" />{t("admin.inventory.sanitization_req")}
                        </div>
                      )}
                    </div>
                  </TableCell>
                  <TableCell className="px-8 text-right">
                    <div className="flex justify-end gap-2">
                      <Button variant="ghost" onClick={() => navigate(`/admin/inventory/${inventory.id}/scan`)} className="h-12 w-12 rounded-2xl hover:bg-white/5 text-slate-400 hover:text-white" title={t("admin.inventory.spatial_scan")}>
                        <Camera className="w-5 h-5" />
                      </Button>
                      <Button variant="ghost" onClick={() => navigate(`/admin/inventory/${inventory.id}`)} className="h-12 w-12 rounded-2xl hover:bg-white/5 text-slate-400 hover:text-white">
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
