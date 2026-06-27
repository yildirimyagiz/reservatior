import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { inventoryApi, PropertyInventory } from "@/lib/api/inventory";
import { Search, Plus, Filter, AlertCircle, Camera, Activity, Zap, Box, Eye } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { cn } from "@/lib/utils";
export default function PropertyInventoryManagement() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [loading, setLoading] = useState(true);
  const [inventories, setInventories] = useState<PropertyInventory[]>([]);
  const [searchTerm, setSearchTerm] = useState("");
  const navigate = useNavigate();
  useEffect(() => {
    fetchInventories();
  }, []);
  const fetchInventories = async () => {
    try {
      setLoading(true);
      const response = await inventoryApi.getInventories();
      setInventories((response as any).data || []);
    } catch (error) {
      toast({
        title: t("admin.inventory.sync_failed"),
        description: t("admin.inventory.inventory_database_unreachable"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
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
        return "bg-slate-500/10 text-muted-foreground border-border";
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
  const filteredInventories = inventories.filter(item => item.propertyId.toLowerCase().includes(searchTerm.toLowerCase()) || item.inventoryType.toLowerCase().includes(searchTerm.toLowerCase()));
  return <PageShell title={t("admin.inventory.asset_inventory_matrix")} description={t("admin.inventory.tracking_property_condition_structural")}>
      <div className="space-y-10 pb-20">
        
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
          val: inventories.filter(i => i.overallCondition.toLowerCase() === 'excellent' || i.overallCondition.toLowerCase() === 'new').length,
          icon: Zap,
          color: "text-emerald-400"
        }, {
          label: t("admin.inventory.sync_status"),
          val: t("admin.inventory.optimal", "Optimal"),
          icon: Activity,
          color: "text-purple-400"
        }].map((stat, i) => <Card key={i} className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
                <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
                   <stat.icon className="w-12 h-12" />
                </div>
                <CardContent className="p-8">
                  <p className="text-[10px] font-bold text-muted-foreground mb-1">{stat.label}</p>
                  <h3 className="text-xl font-bold text-foreground leading-none">{stat.val}</h3>
                </CardContent>
             </Card>)}
        </div>

        {/* TACTICAL FILTERS */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 px-4">
           <div className="relative flex-1 max-w-md group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-blue-500 transition-colors" />
              <Input placeholder={t("admin.inventory.search_inventory_cluster")} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-blue-500/20 transition-all font-medium" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
           </div>
           <Button className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-foreground font-bold text-[10px] gap-2 shadow-xl shadow-blue-600/20">
              <Plus className="w-4 h-4" />{t("admin.inventory.initialize_inventory")}</Button>
        </div>

        {/* DATA TABLE */}
        <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
           <CardContent className="p-0">
              <Table>
                 <TableHeader className="bg-muted/50 border-b border-border">
                    <TableRow className="hover:bg-transparent border-none">
                       <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("admin.inventory.asset_identity")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.inventory.category_class")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.inventory.temporal_state")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("admin.inventory.condition_profile")}</TableHead>
                       <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("admin.inventory.actions")}</TableHead>
                    </TableRow>
                 </TableHeader>
                 <TableBody>
                    {loading ? <TableRow>
                          <TableCell colSpan={5} className="py-20 text-center">
                             <Activity className="w-8 h-8 text-blue-500 animate-spin mx-auto mb-4 opacity-50" />
                             <p className="text-xs font-bold text-muted-foreground animate-pulse">{t("admin.inventory.syncing_inventory_matrix")}</p>
                          </TableCell>
                       </TableRow> : filteredInventories.map(inventory => <TableRow key={inventory.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                           <TableCell className="py-8 px-8">
                              <div className="flex items-center gap-6">
                                 <div className="p-3 bg-card border border-border rounded-2xl group-hover:rotate-12 transition-all">
                                    <Box className="w-5 h-5 text-blue-400" />
                                 </div>
                                 <div>
                                    <h6 className="text-sm font-bold text-foreground leading-none">{t("admin.inventory.ref")}{inventory.propertyId.substring(0, 8)}</h6>
                                    <p className="text-[10px] font-bold text-muted-foreground mt-1">{inventory.conductedBy}</p>
                                 </div>
                              </div>
                           </TableCell>
                           <TableCell className="px-8">
                              <Badge variant="outline" className="text-[9px] font-bold border-border text-muted-foreground px-2 py-0.5">
                                 {getLocalizedType(inventory.inventoryType)}
                              </Badge>
                           </TableCell>
                           <TableCell className="px-8">
                              <span className="text-[10px] font-bold text-muted-foreground">{new Date(inventory.inventoryDate).toLocaleDateString()}</span>
                           </TableCell>
                           <TableCell className="px-8">
                              <div className="flex flex-col gap-2">
                                 <Badge className={cn("text-[8px] font-bold   px-2 py-0.5 border-none w-fit", getConditionStyle(inventory.overallCondition))}>
                                    {getLocalizedCondition(inventory.overallCondition)}
                                 </Badge>
                                 {inventory.cleaningRequired && <div className="flex items-center gap-1 text-[8px] font-bold text-rose-500">
                                      <AlertCircle className="w-3 h-3" />{t("admin.inventory.sanitization_req")}</div>}
                              </div>
                           </TableCell>
                           <TableCell className="px-8 text-right">
                              <div className="flex justify-end gap-2">
                                 <Button variant="ghost" onClick={() => navigate(`/admin/inventory/${inventory.id}/scan`)} className="h-12 w-12 rounded-2xl hover:bg-muted/50 text-muted-foreground hover:text-foreground" title={t("admin.inventory.spatial_scan")}>
                                    <Camera className="w-5 h-5" />
                                 </Button>
                                 <Button variant="ghost" onClick={() => navigate(`/admin/inventory/${inventory.id}`)} className="h-12 w-12 rounded-2xl hover:bg-muted/50 text-muted-foreground hover:text-foreground">
                                    <Eye className="w-5 h-5" />
                                 </Button>
                              </div>
                           </TableCell>
                        </TableRow>)}
                 </TableBody>
              </Table>
           </CardContent>
        </Card>
      </div>
    </PageShell>;
}