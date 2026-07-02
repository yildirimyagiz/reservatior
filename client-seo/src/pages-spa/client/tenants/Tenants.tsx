import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Avatar, AvatarFallback } from "@/components/ui/avatar";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, AlertCircle, CheckCircle2, Clock, Search, Plus, Users, Building, CreditCard, Zap, Shield, Activity, ArrowUpRight, Fingerprint, Brain, Loader2 } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { tenantsApi, Tenant } from "@/lib/api/tenants";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";

export default function Tenants() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [selectedTenant, setSelectedTenant] = useState<Tenant | null>(null);

  // Fetch tenants from API
  const { data: tenantsData, isLoading } = useQuery({
    queryKey: ['tenants'],
    queryFn: () => tenantsApi.getAll().then(res => res.data)
  });

  // Calculate score mutation
  const calculateScoreMutation = useMutation({
    mutationFn: (id: string) => tenantsApi.calculateScore(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['tenants'] });
      toast({ title: t("client.src.score_calculated") });
    },
    onError: () => {
      toast({ title: t("client.src.error"), variant: "destructive" });
    }
  });

  const getPaymentConfig = (status: string) => {
    switch (status) {
      case "PAID":
        return {
          label: t("client.src.sync_complete"),
          color: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20 shadow-[0_0_15px_rgba(16,185,129,0.1)]"
        };
      case "OVERDUE":
        return {
          label: t("client.src.payment_drift"),
          color: "bg-red-500/10 text-red-400 border-red-500/20 animate-pulse"
        };
      case "PARTIAL":
        return {
          label: t("client.src.partial_sync"),
          color: "bg-orange-500/10 text-orange-400 border-orange-500/20"
        };
      default:
        return {
          label: t("client.src.unverified"),
          color: "bg-slate-500/10 text-slate-400 border-slate-500/20"
        };
    }
  };
  const getTrustColor = (score: number) => {
    if (score > 0.9) return "text-emerald-400";
    if (score > 0.8) return "text-blue-400";
    return "text-orange-400";
  };
  const stats = [{
    label: t("client.src.active_residents"),
    value: tenantsData?.length || 0
  }, {
    label: t("client.src.yield_stability"),
    value: "98.4%"
  }, {
    label: t("client.src.collection_delta"),
    value: "+4.2%",
    color: "text-emerald-400"
  }, {
    label: t("client.src.trust_index"),
    value: "0.89",
    color: "text-blue-500"
  }];
  if (isLoading) {
    return (
      <PageShell title={t("client.src.tenant_matrix")} description={t("client.src.neural_resident_orchestration_occupancy")} stats={stats}>
        <div className="flex items-center justify-center h-64">
          <Loader2 className="w-8 h-8 animate-spin text-muted-foreground" />
        </div>
      </PageShell>
    );
  }

  return <PageShell title={t("client.src.tenant_matrix")} description={t("client.src.neural_resident_orchestration_occupancy")} stats={stats} onSearchChange={setSearch} searchValue={search}>
      <div className="space-y-12">
        {/* Control Layer */}
        <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
           <div className="flex items-center gap-4 flex-1 w-full max-w-2xl relative group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500 group-focus-within:text-blue-500 transition-colors" />
              <Input placeholder={t("client.src.scanning_resident_signatures")} value={search} onChange={e => setSearch(e.target.value)} className="bg-black/40 border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-blue-500/20 focus:border-blue-500/40 transition-all font-display border-l border-t" />
           </div>
           <div className="flex items-center gap-4 w-full lg:w-auto">
              <Select value={filterStatus} onValueChange={setFilterStatus}>
                <SelectTrigger className="h-14 w-48 bg-card border-border rounded-2xl text-[10px] font-bold text-slate-400">
                   <SelectValue placeholder={t("client.src.occupancy_sector")} />
                </SelectTrigger>
                <SelectContent className="bg-[#1a1b1e] border-border font-display">
                   <SelectItem value="all" className="text-slate-400 font-bold">{t("client.src.all_matrices")}</SelectItem>
                   <SelectItem value="PAID" className="text-slate-400 font-bold">{t("client.src.paid")}</SelectItem>
                   <SelectItem value="OVERDUE" className="text-slate-400 font-bold">{t("client.src.overdue")}</SelectItem>
                </SelectContent>
              </Select>
              <Button onClick={() => setCreateOpen(true)} className="h-14 px-8 rounded-2xl bg-blue-600 hover:bg-blue-500 text-foreground font-bold text-[10px] shadow-xl shadow-blue-600/20 border-t border-border shrink-0">
                 <Plus className="w-4 h-4 mr-2" />{t("client.src.add_occupant")}</Button>
           </div>
        </div>

        {/* Resident Nodes Grid */}
        <div className="grid grid-cols-1 xl:grid-cols-2 gap-8 px-4">
           <AnimatePresence mode="popLayout">
              {tenantsData?.map((tenant, idx) => <motion.div key={tenant.id} initial={{
            opacity: 0,
            y: 20
          }} animate={{
            opacity: 1,
            y: 0
          }} exit={{
            opacity: 0,
            scale: 0.95
          }} transition={{
            delay: idx * 0.05
          }} whileHover={{
            y: -5
          }} className="p-8 rounded-[40px] bg-card border border-border backdrop-blur-3xl shadow-3xl group relative overflow-hidden flex flex-col justify-between border-l border-t transition-all">
                  <div className="absolute top-0 right-0 p-10 opacity-5 group-hover:opacity-10 transition-all pointer-events-none text-blue-500">
                     <Fingerprint className="w-32 h-32" />
                  </div>

                  <div className="space-y-6 relative z-10">
                     <div className="flex items-center justify-between">
                        <Badge className={cn("text-[9px] font-bold  tracking-[0.2em]  border-none py-1 px-4 rounded-full", getPaymentConfig(tenant.employmentStatus || "ACTIVE").color)}>
                           {getPaymentConfig(tenant.employmentStatus || "ACTIVE").label}
                        </Badge>
                        <div className="flex items-center gap-4">
                           <div className="text-right">
                              <p className="text-[9px] font-bold text-slate-600">{t("client.src.trust_score")}</p>
                              <p className={cn("text-xs font-bold ", getTrustColor(tenant.overallScore || 0))}>{((tenant.overallScore || 0) / 100).toFixed(2)}</p>
                           </div>
                           <div className="h-10 w-10 rounded-xl bg-black/40 border border-border flex items-center justify-center text-slate-400 group-hover:text-foreground transition-colors cursor-pointer" onClick={() => calculateScoreMutation.mutate(tenant.id)}>
                              <Brain className="w-4 h-4" />
                           </div>
                        </div>
                     </div>

                     <div className="flex items-center gap-6">
                        <Avatar className="h-20 w-20 rounded-2xl border border-border shadow-2xl p-0.5 bg-gradient-to-br from-blue-500/20 to-transparent">
                           <AvatarFallback className="rounded-2xl bg-black/40 text-xl font-bold text-blue-400">
                              {tenant.firstName[0]}{tenant.lastName[0]}
                           </AvatarFallback>
                        </Avatar>
                        <div>
                           <h3 className="text-2xl font-bold text-foreground leading-tight group-hover:text-blue-400 transition-colors">
                              {tenant.firstName} {tenant.lastName}
                           </h3>
                           <p className="text-[10px] font-bold text-slate-500 mt-1 leading-none">{tenant.email}</p>
                           <div className="flex items-center gap-2 mt-4 px-3 py-1.5 bg-white/5 rounded-full border border-border w-fit">
                              <Activity className="w-3 h-3 text-blue-500" />
                              <span className="text-[8px] font-bold text-slate-400">{tenant.professionCategory || "RESIDENTIAL"}</span>
                           </div>
                        </div>
                     </div>

                     <div className="grid grid-cols-2 md:grid-cols-3 gap-6 pt-6 border-t border-border">
                        <div className="space-y-1">
                           <p className="text-[8px] font-bold text-slate-600 flex items-center gap-1.5"><Building className="w-2.5 h-2.5" />{t("client.src.domain_node")}</p>
                           <p className="text-[10px] font-bold text-foreground tracking-tight">{tenant.propertyId}</p>
                        </div>
                        <div className="space-y-1">
                           <p className="text-[8px] font-bold text-slate-600 flex items-center gap-1.5"><CreditCard className="w-2.5 h-2.5" />{t("client.src.fiscal_flow")}</p>
                           <p className="text-[10px] font-bold text-foreground tracking-tight font-mono">{tenant.paymentMethod || "CREDIT_CARD"}</p>
                        </div>
                        <div className="space-y-1">
                           <p className="text-[8px] font-bold text-slate-600 flex items-center gap-1.5"><Clock className="w-2.5 h-2.5" />{t("client.src.cycle_end")}</p>
                           <p className="text-[10px] font-bold text-foreground tracking-tight font-mono">{new Date(tenant.leaseEndDate).toLocaleDateString()}</p>
                        </div>
                     </div>
                  </div>

                  <div className="mt-8 flex items-center justify-between">
                     <div className="flex items-center gap-4">
                        <div className={`p-2 rounded-lg border ${tenant.riskLevel === 'LOW' ? 'bg-emerald-500/10 border-emerald-500/20' : tenant.riskLevel === 'MEDIUM' ? 'bg-yellow-500/10 border-yellow-500/20' : tenant.riskLevel === 'HIGH' ? 'bg-orange-500/10 border-orange-500/20' : 'bg-red-500/10 border-red-500/20'}`}>
                           <Shield className={`w-4 h-4 ${tenant.riskLevel === 'LOW' ? 'text-emerald-400' : tenant.riskLevel === 'MEDIUM' ? 'text-yellow-400' : tenant.riskLevel === 'HIGH' ? 'text-orange-400' : 'text-red-400'}`} />
                        </div>
                        <div>
                           <p className={`text-[8px] font-bold ${tenant.riskLevel === 'LOW' ? 'text-emerald-400' : tenant.riskLevel === 'MEDIUM' ? 'text-yellow-400' : tenant.riskLevel === 'HIGH' ? 'text-orange-400' : 'text-red-400'}`}>{t("client.src.risk_level")}: {tenant.riskLevel}</p>
                           <p className="text-[7px] font-bold text-slate-600 mt-0.5">{t("client.src.score")}: {tenant.overallScore?.toFixed(1) || 0}/100</p>
                        </div>
                     </div>
                     <Button variant="ghost" onClick={() => setSelectedTenant(tenant)} className="h-10 text-xs font-bold text-blue-400 hover:text-foreground gap-2 group/btn">{t("client.src.scan_record")}<ArrowUpRight className="w-3 h-3 group-hover/btn:translate-x-0.5 group-hover/btn:-translate-y-0.5 transition-transform" />
                     </Button>
                  </div>
                </motion.div>)}
           </AnimatePresence>
        </div>
      </div>

      
      {/* Detail Dialog */}
      <Dialog open={!!selectedTenant} onOpenChange={(open) => !open && setSelectedTenant(null)}>
        <DialogContent className="max-w-2xl bg-card border border-border text-foreground font-sans">
          <DialogHeader className="p-8 pb-4">
            <DialogTitle className="text-2xl font-bold flex items-center gap-4">
               <Avatar className="h-12 w-12 rounded-xl">
                 <AvatarFallback className="bg-primary/10 text-primary">
                    {selectedTenant?.firstName?.[0]}{selectedTenant?.lastName?.[0]}
                 </AvatarFallback>
               </Avatar>
               <div>
                 <div>{selectedTenant?.firstName} {selectedTenant?.lastName}</div>
                 <div className="text-sm text-muted-foreground font-normal">{selectedTenant?.email}</div>
               </div>
            </DialogTitle>
          </DialogHeader>
          <div className="p-8 pt-0 grid gap-6">
             <div className="grid grid-cols-2 gap-4">
                <div className="p-4 rounded-xl border border-border bg-muted/50 space-y-1">
                   <div className="text-xs text-muted-foreground font-semibold">Birim Adı</div>
                   <div className="font-bold">{selectedTenant?.propertyId}</div>
                </div>
                <div className="p-4 rounded-xl border border-border bg-muted/50 space-y-1">
                   <div className="text-xs text-muted-foreground font-semibold">Ödeme Yöntemi</div>
                   <div className="font-bold">{selectedTenant?.paymentMethod || "CREDIT_CARD"}</div>
                </div>
                <div className="p-4 rounded-xl border border-border bg-muted/50 space-y-1">
                   <div className="text-xs text-muted-foreground font-semibold">Sözleşme Bitiş</div>
                   <div className="font-bold">{selectedTenant?.leaseEndDate ? new Date(selectedTenant.leaseEndDate).toLocaleDateString() : "—"}</div>
                </div>
                <div className="p-4 rounded-xl border border-border bg-muted/50 space-y-1">
                   <div className="text-xs text-muted-foreground font-semibold">Güven Skoru</div>
                   <div className="font-bold text-emerald-500">{selectedTenant?.overallScore?.toFixed(1) || 0}/100</div>
                </div>
             </div>
             <div className="flex gap-4">
                <Button className="w-full">Sözleşmeyi İndir</Button>
                <Button variant="outline" className="w-full text-red-500 border-red-200 hover:bg-red-50">Sözleşmeyi Feshet</Button>
             </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Modern Dialogs */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border border-border rounded-[32px] shadow-3xl text-foreground font-display overflow-hidden">
          <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-blue-600 via-transparent to-transparent opacity-50"></div>
          <DialogHeader className="p-8">
            <DialogTitle className="text-3xl font-bold flex items-center gap-4">
               <div className="p-3 bg-blue-600 rounded-2xl shadow-xl shadow-blue-600/20">
                  <Users className="w-6 h-6 text-foreground" />
               </div>{t("client.src.register_occupant")}</DialogTitle>
            <DialogDescription className="text-[10px] font-bold text-slate-500 mt-4">{t("client.src.onboard_new_resident_identity")}</DialogDescription>
          </DialogHeader>
          
          <div className="p-8 pt-0 space-y-6">
             <div className="grid grid-cols-2 gap-6">
                <div className="space-y-2">
                   <Label className="text-[9px] font-bold text-slate-500">{t("client.src.first_name")}</Label>
                   <Input className="h-12 bg-black/40 border-border rounded-xl text-foreground focus:ring-blue-500/20" placeholder={t("client.src.eg_alexander")} />
                </div>
                <div className="space-y-2">
                   <Label className="text-[9px] font-bold text-slate-500">{t("client.src.last_name")}</Label>
                   <Input className="h-12 bg-black/40 border-border rounded-xl text-foreground focus:ring-blue-500/20" placeholder={t("client.src.eg_vault")} />
                </div>
             </div>
             <div className="space-y-2">
                <Label className="text-[9px] font-bold text-slate-500">{t("client.src.neural_signature_email")}</Label>
                <Input type="email" className="h-12 bg-black/40 border-border rounded-xl text-foreground focus:ring-blue-500/20" placeholder={t("client.src.avaultneuralnet")} />
             </div>
             <div className="grid grid-cols-2 gap-6">
                <div className="space-y-2">
                   <Label className="text-[9px] font-bold text-slate-500">{t("client.src.fiscal_commitment")}</Label>
                   <Input type="number" className="h-12 bg-black/40 border-border rounded-xl text-foreground focus:ring-blue-500/20" placeholder="4500" />
                </div>
                <div className="space-y-2">
                   <Label className="text-[9px] font-bold text-slate-500">{t("client.src.domain_assignment")}</Label>
                   <Select>
                      <SelectTrigger className="h-12 bg-black/40 border-border rounded-xl text-foreground">
                         <SelectValue placeholder={t("client.src.select_node")} />
                      </SelectTrigger>
                      <SelectContent className="bg-black border-border">
                         <SelectItem value="1">{t("client.src.sunset_terminal_4")}</SelectItem>
                         <SelectItem value="2">{t("client.src.downtown_logic_loft")}</SelectItem>
                      </SelectContent>
                   </Select>
                </div>
             </div>
          </div>

          <DialogFooter className="p-8 pt-0 flex gap-4">
            <Button variant="ghost" onClick={() => setCreateOpen(false)} className="h-12 rounded-xl text-[10px] font-bold text-slate-500 hover:text-foreground transition-all">{t("client.src.abort_registration")}</Button>
            <Button className="h-12 px-8 rounded-xl bg-blue-600 hover:bg-blue-500 text-foreground font-bold text-[10px] shadow-xl shadow-blue-600/20">{t("client.src.confirm_onboarding")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}