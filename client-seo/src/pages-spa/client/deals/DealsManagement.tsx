import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useMemo } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useToast } from "@/hooks/use-toast";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { PageShell } from "../../client/layout/PageShell";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Plus, Search, Edit, Trash2, Eye, MoreHorizontal, DollarSign, Building, Calendar, MapPin, FileText, TrendingUp, Activity, Zap } from "lucide-react";
import { dealsApi } from "@/lib/api/deals";
import { cn } from "@/lib/utils";
interface Deal {
  id: string;
  title: string;
  address?: string;
  city?: string;
  dealType: string;
  status: string;
  listingPrice?: number;
  salePrice?: number;
  agentId?: string;
  orgId?: string;
  startDate?: string;
  createdAt: string;
  updatedAt: string;
}
interface DealCreate {
  title: string;
  address?: string;
  city?: string;
  dealType: string;
  status: string;
  listingPrice?: number;
  salePrice?: number;
  agentId?: string;
  orgId: string;
  startDate: string;
}
interface DealUpdate {
  title?: string;
  address?: string;
  city?: string;
  dealType?: string;
  status?: string;
  listingPrice?: number;
  salePrice?: number;
  agentId?: string;
}
export default function DealsManagement() {
  const {
    t
  } = useTranslation();
  const queryClient = useQueryClient();
  const {
    toast
  } = useToast();
  const [searchTerm, setSearchTerm] = useState("");
  const [filterType, setFilterType] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [editingDeal, setEditingDeal] = useState<Deal | null>(null);
  const [formData, setFormData] = useState<DealCreate>({
    title: "",
    address: "",
    city: "",
    dealType: "SALE",
    status: "LEAD",
    listingPrice: 0,
    salePrice: 0,
    agentId: "",
    orgId: "",
    startDate: new Date().toISOString().split("T")[0]
  });
  const { data: deals = [], isLoading: loading } = useQuery({
    queryKey: ['deals'],
    queryFn: async () => {
      const response = (await dealsApi.getAll()) as any;
      return (response.data || []) as Deal[];
    }
  });
  const filteredDeals = useMemo(() => {
    return deals.filter(deal => {
      const matchesSearch = searchTerm === "" || deal.title.toLowerCase().includes(searchTerm.toLowerCase()) || deal.address?.toLowerCase().includes(searchTerm.toLowerCase()) || deal.city?.toLowerCase().includes(searchTerm.toLowerCase());
      const matchesType = filterType === "all" || deal.dealType === filterType;
      const matchesStatus = filterStatus === "all" || deal.status === filterStatus;
      return matchesSearch && matchesType && matchesStatus;
    });
  }, [deals, searchTerm, filterType, filterStatus]);
  const createMutation = useMutation({
    mutationFn: () => dealsApi.create(formData),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['deals'] });
      setIsCreateDialogOpen(false);
      resetForm();
      toast({
        title: t("client.src.success"),
        description: t("client.src.deal_created_successfully")
      });
    },
    onError: () => {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_create_deal"),
        variant: "destructive"
      });
    }
  });

  const updateMutation = useMutation({
    mutationFn: () => {
      if (!editingDeal) throw new Error("No deal selected");
      return dealsApi.update(editingDeal.id, formData);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['deals'] });
      setEditingDeal(null);
      resetForm();
      toast({
        title: t("client.src.success"),
        description: t("client.src.deal_updated_successfully")
      });
    },
    onError: () => {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_update_deal"),
        variant: "destructive"
      });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => dealsApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['deals'] });
      toast({
        title: t("client.src.success"),
        description: t("client.src.deal_purged_from_pipeline")
      });
    },
    onError: () => {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_delete_record"),
        variant: "destructive"
      });
    }
  });
  const resetForm = () => {
    setFormData({
      title: "",
      address: "",
      city: "",
      dealType: "SALE",
      status: "LEAD",
      listingPrice: 0,
      salePrice: 0,
      agentId: "",
      orgId: "",
      startDate: new Date().toISOString().split("T")[0]
    });
  };
  const openEditDialog = (deal: Deal) => {
    setEditingDeal(deal);
    setFormData({
      title: deal.title,
      address: deal.address || "",
      city: deal.city || "",
      dealType: deal.dealType,
      status: deal.status,
      listingPrice: deal.listingPrice || 0,
      salePrice: deal.salePrice || 0,
      agentId: deal.agentId || "",
      orgId: deal.orgId || "",
      startDate: deal.startDate || new Date().toISOString().split("T")[0]
    });
  };
  const getStatusBadge = (status: string) => {
    switch (status) {
      case "LEAD":
        return <Badge className="bg-blue-500/10 text-blue-400 border-blue-500/20 text-[10px] font-black italic tracking-widest">{t("client.src.lead")}</Badge>;
      case "ACTIVE":
        return <Badge className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20 text-[10px] font-black italic tracking-widest">{t("client.src.active")}</Badge>;
      case "PENDING":
        return <Badge className="bg-orange-500/10 text-orange-400 border-orange-500/20 text-[10px] font-black italic tracking-widest">{t("client.src.pending")}</Badge>;
      case "CLOSED":
        return <Badge className="bg-violet-500/10 text-violet-400 border-violet-500/20 text-[10px] font-black italic tracking-widest">{t("client.src.closed")}</Badge>;
      case "CANCELLED":
        return <Badge className="bg-red-500/10 text-red-400 border-red-500/20 text-[10px] font-black italic tracking-widest">{t("client.src.cancelled")}</Badge>;
      default:
        return <Badge className="bg-slate-500/10 text-slate-400 border-slate-500/20 text-[10px] font-black italic tracking-widest">{status}</Badge>;
    }
  };
  const stats = {
    totalDeals: deals.length,
    activeDeals: deals.filter(d => d.status === "ACTIVE").length,
    totalValue: deals.reduce((sum, d) => sum + (d.salePrice || d.listingPrice || 0), 0),
    closedDeals: deals.filter(d => d.status === "CLOSED").length
  };
  return <PageShell title={t("client.src.deals_intelligence")} description={t("client.src.administrative_control_of_transaction")}>
      <div className="space-y-10 pb-20">
        
        {/* KPI Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <Card className="bg-[#14151a]/40 border-white/5 rounded-3xl overflow-hidden shadow-2xl relative group">
            <CardContent className="p-8">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-[10px] font-black text-slate-500 tracking-widest mb-1 italic">{t("client.src.pipeline_scale")}</p>
                  <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stats.totalDeals}</h3>
                </div>
                <Building className="w-10 h-10 text-slate-500 opacity-20" />
              </div>
            </CardContent>
          </Card>

          <Card className="bg-[#14151a]/40 border-white/5 rounded-3xl overflow-hidden shadow-2xl relative group border-l-emerald-500/30 border-l-2">
            <CardContent className="p-8">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-[10px] font-black text-slate-500 tracking-widest mb-1 italic">{t("client.src.gross_volume")}</p>
                  <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">${stats.totalValue.toLocaleString()}</h3>
                </div>
                <DollarSign className="w-10 h-10 text-emerald-500 opacity-20" />
              </div>
            </CardContent>
          </Card>

          <Card className="bg-[#14151a]/40 border-white/5 rounded-3xl overflow-hidden shadow-2xl relative group border-l-violet-500/30 border-l-2">
            <CardContent className="p-8">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-[10px] font-black text-slate-500 tracking-widest mb-1 italic">{t("client.src.active_nodes")}</p>
                  <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stats.activeDeals}</h3>
                </div>
                <Zap className="w-10 h-10 text-violet-500 opacity-20" />
              </div>
            </CardContent>
          </Card>

          <Card className="bg-[#14151a]/40 border-white/5 rounded-3xl overflow-hidden shadow-2xl relative group border-l-orange-500/30 border-l-2">
            <CardContent className="p-8">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-[10px] font-black text-slate-500 tracking-widest mb-1 italic">{t("client.src.conversions")}</p>
                  <h3 className="text-4xl font-black text-white italic tracking-tighter leading-none">{stats.closedDeals}</h3>
                </div>
                <Calendar className="w-10 h-10 text-orange-500 opacity-20" />
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Search & Filter Bar */}
        <div className="flex flex-col md:flex-row items-center justify-between gap-4 px-4 bg-[#14151a]/40 p-6 rounded-3xl border border-white/5 shadow-2xl relative">
          <div className="absolute top-0 left-0 w-full h-px bg-gradient-to-r from-transparent via-white/5 to-transparent"></div>
          <div className="relative flex-1 max-w-md group">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500 group-focus-within:text-orange-500 transition-colors" />
            <Input placeholder={t("client.src.filter_by_title_address")} className="bg-black/40 border-white/5 rounded-2xl pl-12 h-14 text-white focus:ring-orange-500/20 focus:border-orange-500/40 transition-all font-medium" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
          </div>
          <div className="flex gap-3">
            <Select value={filterType} onValueChange={setFilterType}>
              <SelectTrigger className="h-14 w-40 rounded-2xl bg-black/40 border-white/5 text-slate-300 font-bold text-[10px] tracking-widest px-6">
                <SelectValue placeholder={t("client.src.type")} />
              </SelectTrigger>
              <SelectContent className="bg-[#14151a] border-white/10 rounded-2xl text-white">
                <SelectItem value="all">{t("client.src.all_types")}</SelectItem>
                <SelectItem value="SALE">{t("client.src.sale")}</SelectItem>
                <SelectItem value="RENTAL">{t("client.src.rental")}</SelectItem>
                <SelectItem value="COMMERCIAL">{t("client.src.commercial")}</SelectItem>
              </SelectContent>
            </Select>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="h-14 w-40 rounded-2xl bg-black/40 border-white/5 text-slate-300 font-bold text-[10px] tracking-widest px-6">
                <SelectValue placeholder={t("client.src.status")} />
              </SelectTrigger>
              <SelectContent className="bg-[#14151a] border-white/10 rounded-2xl text-white">
                <SelectItem value="all">{t("client.src.all_status")}</SelectItem>
                <SelectItem value="LEAD">{t("client.src.lead")}</SelectItem>
                <SelectItem value="ACTIVE">{t("client.src.active")}</SelectItem>
                <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
                <SelectItem value="CLOSED">{t("client.src.closed")}</SelectItem>
                <SelectItem value="CANCELLED">{t("client.src.cancelled")}</SelectItem>
              </SelectContent>
            </Select>
            <Button onClick={() => setIsCreateDialogOpen(true)} className="h-14 px-8 rounded-2xl bg-orange-600 hover:bg-orange-500 text-white font-black tracking-widest text-xs shadow-xl shadow-orange-600/30 gap-2">
              <Plus className="w-5 h-5" />{t("client.src.initialize")}</Button>
          </div>
        </div>

        {/* Data Table */}
        <Card className="bg-[#14151a]/40 border-white/5 rounded-4xl overflow-hidden shadow-2xl relative border-l border-t">
          <div className="absolute top-0 left-0 w-full h-px bg-gradient-to-r from-orange-600/50 via-transparent to-transparent"></div>
          <CardContent className="p-0">
            <div className="overflow-x-auto">
              <Table>
                <TableHeader className="bg-white/5 border-b border-white/5">
                  <TableRow className="hover:bg-transparent border-none">
                    <TableHead className="text-[10px] font-black text-slate-500 tracking-widest py-6 px-8">{t("client.src.transaction_profile")}</TableHead>
                    <TableHead className="text-[10px] font-black text-slate-500 tracking-widest px-8">{t("client.src.location")}</TableHead>
                    <TableHead className="text-[10px] font-black text-slate-500 tracking-widest px-8">{t("client.src.valuation")}</TableHead>
                    <TableHead className="text-[10px] font-black text-slate-500 tracking-widest px-8">{t("client.src.sync_status")}</TableHead>
                    <TableHead className="text-[10px] font-black text-slate-500 tracking-widest px-8 text-right">{t("client.src.intel")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {loading ? <TableRow>
                      <TableCell colSpan={5} className="py-24 text-center">
                        <Activity className="w-10 h-10 text-orange-500 animate-spin mx-auto mb-4 opacity-50" />
                        <p className="text-[10px] font-black text-slate-500 tracking-widest italic animate-pulse">{t("client.src.synchronizing_neural_pipeline")}</p>
                      </TableCell>
                    </TableRow> : filteredDeals.length === 0 ? <TableRow>
                      <TableCell colSpan={5} className="py-24 text-center">
                        <p className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("client.src.zero_records_identified_in")}</p>
                      </TableCell>
                    </TableRow> : <AnimatePresence mode="popLayout">
                      {filteredDeals.map(deal => <motion.tr key={deal.id} initial={{
                    opacity: 0,
                    y: 10
                  }} animate={{
                    opacity: 1,
                    y: 0
                  }} exit={{
                    opacity: 0,
                    scale: 0.95
                  }} className="border-b border-white/5 hover:bg-white/5 transition-all group">
                          <TableCell className="py-8 px-8">
                            <div className="flex items-center gap-6">
                              <div className="w-14 h-14 bg-black/40 border border-white/5 rounded-2xl flex items-center justify-center group-hover:scale-110 transition-all font-black text-slate-600 italic">
                                <FileText className="w-6 h-6" />
                              </div>
                              <div className="space-y-1">
                                <h4 className="text-lg font-black text-white italic tracking-tighter leading-tight">{deal.title}</h4>
                                <div className="flex items-center gap-2">
                                  <span className="text-[9px] font-black text-orange-500 tracking-tighter">{t("client.src.id")}{deal.id.slice(0, 8).toUpperCase()}</span>
                                  <Badge variant="outline" className="text-[8px] font-black text-blue-400 border-blue-400/20 bg-blue-500/5">{deal.dealType}</Badge>
                                </div>
                              </div>
                            </div>
                          </TableCell>
                          <TableCell className="px-8">
                            <div className="space-y-1">
                              <p className="text-sm font-bold text-slate-300 italic">{deal.address || 'Global Sector'}</p>
                              <div className="flex items-center gap-1 text-[9px] font-black text-slate-500 italic">
                                <MapPin className="w-3 h-3 text-orange-500" /> {deal.city || 'Undeclared'}
                              </div>
                            </div>
                          </TableCell>
                          <TableCell className="px-8 font-black text-emerald-400 italic text-lg">
                            ${(deal.salePrice || deal.listingPrice || 0).toLocaleString()}
                          </TableCell>
                          <TableCell className="px-8">
                            {getStatusBadge(deal.status)}
                          </TableCell>
                          <TableCell className="px-8 text-right">
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild>
                                <Button variant="ghost" className="h-10 w-10 rounded-xl hover:bg-white/10 text-slate-500">
                                  <MoreHorizontal className="w-5 h-5" />
                                </Button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent align="end" className="bg-[#14151a] border-white/10 rounded-2xl p-2 min-w-[180px] shadow-2xl">
                                <DropdownMenuItem onClick={() => openEditDialog(deal)} className="rounded-xl px-4 py-3 text-xs font-bold italic tracking-tight hover:bg-white/5 hover:text-white transition-all cursor-pointer">
                                  <Edit className="w-4 h-4 mr-3 text-orange-500" />{t("client.src.modifyintel")}</DropdownMenuItem>
                                <DropdownMenuItem onClick={() => deleteMutation.mutate(deal.id)} className="rounded-xl px-4 py-3 text-xs font-bold italic tracking-tight text-red-400 hover:bg-red-400/5 transition-all cursor-pointer">
                                  <Trash2 className="w-4 h-4 mr-3" />{t("client.src.purgerecord")}</DropdownMenuItem>
                              </DropdownMenuContent>
                            </DropdownMenu>
                          </TableCell>
                        </motion.tr>)}
                    </AnimatePresence>}
                </TableBody>
              </Table>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Initialize / Update Dialog */}
      <Dialog open={isCreateDialogOpen || !!editingDeal} onOpenChange={open => {
      if (!open) {
        setIsCreateDialogOpen(false);
        setEditingDeal(null);
        resetForm();
      }
    }}>
        <DialogContent className="bg-[#14151a] border-white/10 rounded-4xl text-white sm:max-w-xl p-0 overflow-hidden shadow-[0_0_50px_rgba(0,0,0,0.5)]">
          <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-orange-600 via-transparent to-transparent"></div>
          <DialogHeader className="p-8 border-b border-white/5 bg-white/5">
            <DialogTitle className="text-2xl font-black italic tracking-tighter flex items-center gap-3">
              <Zap className="w-6 h-6 text-orange-500" />
              {editingDeal ? 'Update Transaction Neural' : 'Initialize New Pipeline'}
            </DialogTitle>
          </DialogHeader>
          <div className="p-10 space-y-8">
            <div className="grid grid-cols-2 gap-8">
              <div className="col-span-2 space-y-3">
                <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-3">{t("client.src.project_designation")}</Label>
                <Input value={formData.title} onChange={e => setFormData({
                ...formData,
                title: e.target.value
              })} placeholder={t("client.src.ex_neuralluxuryvillasync")} className="bg-black/40 border-white/5 rounded-2xl h-16 font-black italic tracking-tight px-6 text-lg focus:ring-orange-500/20" />
              </div>
              <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-3">{t("client.src.sector_address")}</Label>
                <Input value={formData.address} onChange={e => setFormData({
                ...formData,
                address: e.target.value
              })} placeholder={t("client.src.street_sector")} className="bg-black/40 border-white/5 rounded-2xl h-14 font-bold px-6" />
              </div>
              <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-3">{t("client.src.neutral_city")}</Label>
                <Input value={formData.city} onChange={e => setFormData({
                ...formData,
                city: e.target.value
              })} placeholder={t("client.src.region")} className="bg-black/40 border-white/5 rounded-2xl h-14 font-bold px-6" />
              </div>
              <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-3">{t("client.src.transaction_type")}</Label>
                <Select value={formData.dealType} onValueChange={val => setFormData({
                ...formData,
                dealType: val
              })}>
                  <SelectTrigger className="bg-black/40 border-white/5 rounded-2xl h-14 font-black text-[10px] tracking-widest px-6">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-white/10 text-white rounded-2xl">
                    <SelectItem value="SALE" className="font-black italic">{t("client.src.sale")}</SelectItem>
                    <SelectItem value="RENTAL" className="font-black italic">{t("client.src.rental")}</SelectItem>
                    <SelectItem value="COMMERCIAL" className="font-black italic">{t("client.src.commercial")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-3">{t("client.src.pipeline_status")}</Label>
                <Select value={formData.status} onValueChange={val => setFormData({
                ...formData,
                status: val
              })}>
                  <SelectTrigger className="bg-black/40 border-white/5 rounded-2xl h-14 font-black text-[10px] tracking-widest px-6">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-white/10 text-white rounded-2xl">
                    <SelectItem value="LEAD" className="font-black italic">{t("client.src.lead")}</SelectItem>
                    <SelectItem value="ACTIVE" className="font-black italic">{t("client.src.active")}</SelectItem>
                    <SelectItem value="PENDING" className="font-black italic">{t("client.src.pending")}</SelectItem>
                    <SelectItem value="CLOSED" className="font-black italic">{t("client.src.closed")}</SelectItem>
                    <SelectItem value="CANCELLED" className="font-black italic text-red-500">{t("client.src.cancelled")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-3">{t("client.src.valuation_index")}</Label>
                <Input type="number" value={formData.listingPrice} onChange={e => setFormData({
                ...formData,
                listingPrice: Number(e.target.value)
              })} className="bg-black/40 border-white/5 rounded-2xl h-14 font-black px-6 text-emerald-400" />
              </div>
              <div className="space-y-3">
                <Label className="text-[10px] font-black text-slate-500 tracking-widest italic ml-3">{t("client.src.conversion_price")}</Label>
                <Input type="number" value={formData.salePrice} onChange={e => setFormData({
                ...formData,
                salePrice: Number(e.target.value)
              })} className="bg-black/40 border-white/5 rounded-2xl h-14 font-black px-6 text-emerald-400" />
              </div>
            </div>
            <div className="flex gap-4 pt-10">
              <Button variant="ghost" className="flex-1 h-16 rounded-2xl font-black text-[10px] tracking-widest hover:bg-white/5" onClick={() => {
              setIsCreateDialogOpen(false);
              setEditingDeal(null);
              resetForm();
            }}>{t("client.src.abort")}</Button>
              <Button onClick={() => editingDeal ? updateMutation.mutate() : createMutation.mutate()} disabled={createMutation.isPending || updateMutation.isPending} className="flex-3 h-16 rounded-2xl bg-orange-600 hover:bg-orange-500 text-white font-black text-[10px] tracking-widest shadow-xl shadow-orange-600/30">
                {editingDeal ? 'SYNCHRONIZE_INTEL' : 'EXECUTE_INITIALIZATION'}
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </PageShell>;
}