import { t } from "i18next";
import React, { useState } from "react";
import { useTranslation } from "react-i18next";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
import { Edit, Trash2, MoreHorizontal, CreditCard, Users, Building2, RefreshCw, Zap, Shield, Rocket, Sparkles, Activity, Layers, ChevronRight, Globe, DollarSign, Search, Plus } from "lucide-react";
import { cn } from "@/lib/utils";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { motion, AnimatePresence } from "framer-motion";
import { Card, CardContent } from "@/components/ui/card";
interface PlanLimits {
  maxUsers?: number;
  maxProperties?: number;
  maxListings?: number;
  aiFeatures?: boolean;
  customIntegrations?: boolean;
  prioritySupport?: boolean;
  [key: string]: any;
}
interface Plan {
  id: string;
  key: string;
  name: string;
  limits: PlanLimits;
  priceMonthlyCents: number | null;
  createdAt: string;
  updatedAt: string;
  deletedAt?: string | null;
  _count?: {
    orgSubscriptions: number;
  };
}
const EMPTY_FORM = {
  key: "",
  name: "",
  priceMonthlyCents: "",
  maxUsers: "",
  maxProperties: "",
  maxListings: "",
  aiFeatures: false,
  customIntegrations: false,
  prioritySupport: false
};
function formatPrice(cents: number | null, t: any): string {
  if (cents === null || cents === undefined) return t("freeTier");
  return `$${(cents / 100).toFixed(0)}${t("plansMonthly")}`;
}
function planToForm(plan: Plan) {
  return {
    key: plan.key ?? "",
    name: plan.name ?? "",
    priceMonthlyCents: plan.priceMonthlyCents != null ? String(plan.priceMonthlyCents / 100) : "",
    maxUsers: plan.limits?.maxUsers != null ? String(plan.limits.maxUsers) : "",
    maxProperties: plan.limits?.maxProperties != null ? String(plan.limits.maxProperties) : "",
    maxListings: plan.limits?.maxListings != null ? String(plan.limits.maxListings) : "",
    aiFeatures: plan.limits?.aiFeatures ?? false,
    customIntegrations: plan.limits?.customIntegrations ?? false,
    prioritySupport: plan.limits?.prioritySupport ?? false
  };
}
export default function Plans() {
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
  const [deleteOpen, setDeleteOpen] = useState(false);
  const [selectedPlan, setSelectedPlan] = useState<Plan | null>(null);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const [saving, setSaving] = useState(false);
  const { data: plans = [], isLoading: loading } = useQuery<Plan[]>({
    queryKey: ['adminPlans'],
    queryFn: async () => {
      try {
        const res = (await apiClient.get("/plan", {
          include: "subscriptionCount"
        })) as {
          data: Plan[];
        };
        return res.data || [];
      } catch (error) {
        toast({
          title: t("admin.users.sync_failure"),
          description: t("admin.users.global_pricing_matrix_unreachable"),
          variant: "destructive"
        });
        return [];
      }
    }
  });
  const buildPayload = (f: typeof EMPTY_FORM) => ({
    key: f.key.trim().toLowerCase().replace(/\s+/g, "_"),
    name: f.name.trim(),
    priceMonthlyCents: f.priceMonthlyCents !== "" ? Math.round(parseFloat(f.priceMonthlyCents) * 100) : null,
    limits: {
      ...(f.maxUsers !== "" && {
        maxUsers: parseInt(f.maxUsers)
      }),
      ...(f.maxProperties !== "" && {
        maxProperties: parseInt(f.maxProperties)
      }),
      ...(f.maxListings !== "" && {
        maxListings: parseInt(f.maxListings)
      }),
      aiFeatures: f.aiFeatures,
      customIntegrations: f.customIntegrations,
      prioritySupport: f.prioritySupport
    }
  });
  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      setSaving(true);
      await apiClient.post("/plan", buildPayload(form));
      toast({
        title: t("admin.users.architecture_initialized"),
        description: t("admin.users.new_architecture_tier_has")
      });
      setCreateOpen(false);
      setForm(EMPTY_FORM);
      queryClient.invalidateQueries({ queryKey: ['adminPlans'] });
    } catch (error) {
      toast({
        title: t("admin.users.provisioning_error"),
        description: t("admin.users.failed_to_initialize_architecture"),
        variant: "destructive"
      });
    } finally {
      setSaving(false);
    }
  };
  const handleEdit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedPlan) return;
    try {
      setSaving(true);
      await apiClient.patch(`/plan/${selectedPlan.id}`, buildPayload(form));
      toast({
        title: t("admin.users.architecture_reconfigured"),
        description: t("admin.users.pricing_tier_parameters_updated")
      });
      setEditOpen(false);
      queryClient.invalidateQueries({ queryKey: ['adminPlans'] });
    } catch (error) {
      toast({
        title: t("admin.users.sync_error"),
        description: t("admin.users.failed_to_reconfigure_tier"),
        variant: "destructive"
      });
    } finally {
      setSaving(false);
    }
  };
  const handleDelete = async () => {
    if (!selectedPlan) return;
    try {
      await apiClient.delete(`/plan/${selectedPlan.id}`);
      toast({
        title: t("admin.users.tier_terminated"),
        description: t("admin.users.architecture_node_removed_from")
      });
      setDeleteOpen(false);
      queryClient.invalidateQueries({ queryKey: ['adminPlans'] });
    } catch (error) {
      toast({
        title: t("admin.users.termination_error"),
        description: t("admin.users.failed_to_remove_architecture"),
        variant: "destructive"
      });
    }
  };
  const openEdit = (plan: Plan) => {
    setSelectedPlan(plan);
    setForm(planToForm(plan));
    setEditOpen(true);
  };
  const openDelete = (plan: Plan) => {
    setSelectedPlan(plan);
    setDeleteOpen(true);
  };
  const filtered = plans.filter(p => p.name.toLowerCase().includes(search.toLowerCase()) || p.key.toLowerCase().includes(search.toLowerCase()));
  const totalSubscribers = plans.reduce((s, p) => s + (p._count?.orgSubscriptions ?? 0), 0);
  const monthlyRevenue = plans.reduce((s, p) => s + (p.priceMonthlyCents ?? 0) * (p._count?.orgSubscriptions ?? 0), 0);
  return <PageShell title={t('plansTitle')} description={t('plansDesc')}>
      <div className="space-y-10 pb-20 selection:bg-primary/30">
        
        {/* KPI Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 px-4">
           {[{
          label: t('admin.plans.availableTiers'),
          value: plans.length,
          icon: Layers,
          color: "text-blue-500"
        }, {
          label: t('admin.plans.totalSubscribers'),
          value: totalSubscribers,
          icon: Users,
          color: "text-emerald-500"
        }, {
          label: t('admin.plans.monthlyVelocity'),
          value: `$${(monthlyRevenue / 100).toLocaleString()}`,
          icon: Activity,
          color: "text-purple-500"
        }].map((stat, i) => <motion.div key={i} initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: i * 0.1
        }}>
               <div className="bg-card/40 backdrop-blur-md border-border dark:border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-2 border-t-2 transition-all hover:bg-card/60 p-8">
                  <div className={cn("absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all", stat.color)}>
                    <stat.icon className="w-10 h-10" />
                  </div>
                  <p className="text-[10px] font-bold text-muted-foreground tracking-[0.2em] mb-2">{stat.label}</p>
                  <h3 className="text-xl font-bold text-foreground leading-none">{stat.value}</h3>
                  <div className={cn("absolute bottom-0 left-0 w-full h-1 opacity-50", stat.color.replace('text-', 'bg-'))}></div>
               </div>
             </motion.div>)}
        </div>

        {/* Tactical Toolbar */}
        <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
           <div className="flex items-center gap-4 flex-1">
              <div className="relative group min-w-[320px]">
                <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-blue-500 transition-colors" />
                <Input placeholder={t('admin.plans.filterPlaceholder')} value={search} onChange={e => setSearch(e.target.value)} className="bg-card/60 backdrop-blur-md border-border dark:border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-blue-500/20 focus:border-blue-500/40 transition-all font-bold border-l-2 border-t-2 shadow-2xl tracking-tight" />
              </div>
              <Button variant="outline" size="icon" className="h-14 w-14 rounded-2xl border-border dark:border-border bg-card/60 text-muted-foreground hover:text-foreground transition-all shadow-xl hover:bg-card/80" onClick={() => queryClient.invalidateQueries({ queryKey: ['adminPlans'] })}>
                <RefreshCw className={cn("w-5 h-5", loading && "animate-spin")} />
              </Button>
           </div>
           <Button onClick={() => {
          setForm(EMPTY_FORM);
          setCreateOpen(true);
        }} className="h-14 px-8 rounded-2xl bg-primary hover:bg-primary/90 text-primary-foreground font-bold tracking-[0.3em] text-[10px] shadow-xl shadow-primary/20 gap-3">
              <Plus className="w-5 h-5" /> {t('admin.plans.initTierNode')}
           </Button>
        </div>

        {/* Pricing Matrix Table */}
        <div className="px-4">
          <div className="bg-card/40 backdrop-blur-xl border-border dark:border-border rounded-4xl overflow-hidden shadow-2xl border-l-2 border-t-2 relative">
             <div className="absolute top-0 left-0 w-full h-1 bg-linear-to-r from-emerald-600 via-transparent to-transparent opacity-30"></div>
             <Table>
               <TableHeader className="bg-muted/10 border-b border-border">
                  <TableRow className="border-none hover:bg-transparent">
                    <TableHead className="text-[10px] font-bold text-muted-foreground tracking-[0.2em] py-6 px-8">{t("plansIdentity")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground tracking-[0.2em] px-8">{t("economics")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground tracking-[0.2em] px-8">{t("limits")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground tracking-[0.2em] px-8">{t("adoption")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground tracking-[0.2em] px-8 text-right">{t("plansActions")}</TableHead>
                  </TableRow>
               </TableHeader>
               <TableBody>
                  {loading ? <TableRow>
                      <TableCell colSpan={6} className="py-24 text-center">
                        <Activity className="w-12 h-12 text-blue-500 animate-spin mx-auto mb-4 opacity-50" />
                        <p className="text-[10px] font-bold text-muted-foreground animate-pulse">{t('admin.plans.syncingGrid')}</p>
                      </TableCell>
                    </TableRow> : filtered.length === 0 ? <TableRow>
                       <TableCell colSpan={6} className="py-24 text-center">
                          <p className="text-[10px] font-bold text-muted-foreground">{t('admin.plans.noNodes')}</p>
                       </TableCell>
                    </TableRow> : filtered.map(plan => <TableRow key={plan.id} className="border-b border-border hover:bg-muted/20 transition-all group">
                         <TableCell className="py-8 px-8">
                           <div className="flex items-center gap-4">
                              <div className="w-12 h-12 rounded-xl bg-background border border-border flex items-center justify-center group-hover:scale-110 transition-all font-bold text-xs text-muted-foreground shadow-inner">
                                 {plan.name.slice(0, 2).toUpperCase()}
                              </div>
                              <div>
                                 <div className="text-lg font-bold text-foreground leading-tight group-hover:text-primary transition-colors">{plan.name}</div>
                                 <div className="text-[10px] font-mono text-muted-foreground mt-1">{t("admin.users.hash")}{plan.key}</div>
                              </div>
                           </div>
                         </TableCell>
                         <TableCell className="px-8">
                           <div className="text-sm font-bold text-emerald-500 leading-tight font-mono">
                             {formatPrice(plan.priceMonthlyCents, t)}
                           </div>
                         </TableCell>
                         <TableCell className="px-8">
                            <div className="flex flex-col gap-1.5">
                               <div className="flex items-center gap-2 text-[10px] font-bold text-muted-foreground/70">
                                  <Users className="w-3 h-3 text-blue-500" /> {plan.limits?.maxUsers ?? "∞"} {t('maxUsers')}
                               </div>
                               <div className="flex items-center gap-2 text-[10px] font-bold text-muted-foreground/70">
                                  <Building2 className="w-3 h-3 text-emerald-500" /> {plan.limits?.maxProperties ?? "∞"} {t('admin.plans.maxEntityProps')}
                               </div>
                            </div>
                         </TableCell>
                         <TableCell className="px-8">
                            <div className="flex flex-wrap gap-2">
                               {plan.limits?.aiFeatures && <Badge className="bg-pink-500/10 text-pink-600 dark:text-pink-400 border-none text-[8px] font-bold px-2 py-0.5 shadow-sm">{t('admin.plans.neuralAi')}</Badge>}
                               {plan.limits?.customIntegrations && <Badge className="bg-indigo-500/10 text-indigo-600 dark:text-indigo-400 border-none text-[8px] font-bold px-2 py-0.5 shadow-sm">{t('admin.plans.externalSync')}</Badge>}
                               {plan.limits?.prioritySupport && <Badge className="bg-blue-500/10 text-blue-600 dark:text-blue-400 border-none text-[8px] font-bold px-2 py-0.5 shadow-sm">{t('admin.plans.highPriorityLink')}</Badge>}
                               {!plan.limits?.aiFeatures && !plan.limits?.customIntegrations && !plan.limits?.prioritySupport && <span className="text-[10px] font-bold text-muted-foreground/30">{t('admin.plans.baseFeaturesOnly')}</span>}
                            </div>
                         </TableCell>
                         <TableCell className="px-8 text-right">
                            <div className="flex items-center justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                               <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-card hover:text-foreground text-muted-foreground border border-transparent hover:border-border transition-all" onClick={() => openEdit(plan)}>
                                  <Edit className="w-4 h-4" />
                               </Button>
                               <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-red-500/10 text-muted-foreground hover:text-red-500 border border-transparent hover:border-red-500/20 transition-all" onClick={() => openDelete(plan)}>
                                  <Trash2 className="w-4 h-4" />
                               </Button>
                            </div>
                         </TableCell>
                      </TableRow>)}
               </TableBody>
             </Table>
          </div>
        </div>

        {/* Management Dialogs */}
        <AnimatePresence>
          {(createOpen || editOpen) && <Dialog open={createOpen || editOpen} onOpenChange={val => {
          if (!val) {
            setCreateOpen(false);
            setEditOpen(false);
          }
        }}>
              <DialogContent className="max-w-2xl bg-card border-border text-foreground rounded-4xl p-0 overflow-hidden shadow-3xl">
                 <div className="absolute top-0 left-0 w-full h-1 bg-linear-to-r from-primary via-transparent to-transparent"></div>
                 <DialogHeader className="p-8 border-b border-border bg-muted/20">
                    <DialogTitle className="text-3xl font-bold flex items-center gap-3 text-foreground leading-none">
                       <CreditCard className="w-8 h-8 text-primary" />
                       {createOpen ? t('admin.plans.initTitle') : t('editTitle')}
                    </DialogTitle>
                    <DialogDescription className="text-[10px] font-bold text-muted-foreground tracking-[0.2em] mt-2">
                       {t('admin.plans.description')}
                    </DialogDescription>
                 </DialogHeader>

                 <form onSubmit={createOpen ? handleCreate : handleEdit}>
                    <div className="p-10 space-y-10 max-h-[60vh] overflow-y-auto custom-scrollbar">
                       <div className="grid grid-cols-2 gap-8">
                          <div className="space-y-3">
                             <Label className="text-[10px] font-bold text-muted-foreground ml-3">{t('admin.plans.formalDesignation')}</Label>
                             <Input required value={form.name} onChange={e => setForm({
                      ...form,
                      name: e.target.value
                    })} placeholder={t("admin.users.tiername")} className="bg-background/40 border-border rounded-2xl h-16 font-bold tracking-tight px-6 text-xl focus:ring-primary/20 shadow-inner" />
                          </div>
                          <div className="space-y-3">
                             <Label className="text-[10px] font-bold text-muted-foreground ml-3">{t('admin.plans.uniqueKey')}</Label>
                             <Input required value={form.key} onChange={e => setForm({
                      ...form,
                      key: e.target.value
                    })} placeholder={t("admin.users.tierkey")} className="bg-background/40 border-border rounded-2xl h-16 font-bold tracking-tight px-6 text-xl focus:ring-primary/20 shadow-inner" />
                          </div>
                       </div>
 
                       <div className="space-y-3">
                          <Label className="text-[10px] font-bold text-muted-foreground ml-3">{t('admin.plans.economicPulse')}</Label>
                          <div className="relative group">
                             <DollarSign className="absolute left-6 top-1/2 -translate-y-1/2 w-6 h-6 text-muted-foreground group-focus-within:text-primary transition-all font-bold" />
                             <Input type="number" step="0.01" value={form.priceMonthlyCents} onChange={e => setForm({
                      ...form,
                      priceMonthlyCents: e.target.value
                    })} placeholder="0.00" className="bg-background/40 border-border rounded-2xl h-20 font-bold pl-16 text-3xl focus:ring-primary/20 shadow-inner font-mono" />
                             <div className="absolute right-6 top-1/2 -translate-y-1/2 text-[10px] font-bold text-muted-foreground/60">{t('admin.plans.usdCycle')}</div>
                          </div>
                       </div>

                       <div className="grid grid-cols-3 gap-6">
                          {[{
                    id: "maxUsers",
                    label: t('admin.plans.userLimit'),
                    icon: Users,
                    placeholder: "∞"
                  }, {
                    id: "maxProperties",
                    label: t('admin.plans.entityLimit'),
                    icon: Building2,
                    placeholder: "∞"
                  }, {
                    id: "maxListings",
                    label: t('admin.plans.listingLimit'),
                    icon: Layers,
                    placeholder: "∞"
                  }].map(field => <div key={field.id} className="space-y-3">
                               <Label className="text-[10px] font-bold text-muted-foreground ml-1">{field.label}</Label>
                               <Input type="number" value={form[field.id]} onChange={e => setForm({
                      ...form,
                      [field.id]: e.target.value
                    })} placeholder={field.placeholder} className="bg-background/40 border-border rounded-xl h-14 font-bold text-center focus:ring-primary/20" />
                            </div>)}
                       </div>

                       <div className="bg-muted/10 border border-border rounded-3xl p-8 space-y-6">
                          <p className="text-[10px] font-bold text-muted-foreground mb-2">{t('admin.plans.featureMatrix')}</p>
                          {[{
                    key: "aiFeatures",
                    label: t('admin.plans.aiEnabled'),
                    icon: Sparkles
                  }, {
                    key: "customIntegrations",
                    label: t('admin.plans.dataSync'),
                    icon: Globe
                  }, {
                    key: "prioritySupport",
                    label: t('admin.plans.redLineSupport'),
                    icon: Shield
                  }].map(feature => <div key={feature.key} className="flex items-center justify-between p-5 bg-background/50 rounded-2xl border border-border shadow-sm">
                               <div className="flex items-center gap-4">
                                  <feature.icon className="w-5 h-5 text-primary" />
                                  <span className="text-[11px] font-bold text-foreground/80">{feature.label}</span>
                                </div>
                               <Switch checked={!!form[feature.key]} onCheckedChange={v => setForm({
                      ...form,
                      [feature.key]: v
                    })} className="data-[state=checked]:bg-primary" />
                            </div>)}
                       </div>
                    </div>

                    <DialogFooter className="p-8 bg-muted/20 border-t border-border flex gap-4">
                       <Button type="button" variant="ghost" className="flex-1 h-16 rounded-2xl font-bold text-[10px] tracking-[0.3em] text-muted-foreground hover:text-foreground transition-all" onClick={() => {
                  setCreateOpen(false);
                  setEditOpen(false);
                }}>{t('admin.plans.abortCycle')}</Button>
                       <Button type="submit" disabled={saving} className="flex-2 h-16 rounded-2xl bg-primary hover:bg-primary/90 text-primary-foreground font-bold text-[10px] tracking-[0.3em] shadow-xl shadow-primary/20 gap-3">
                          {saving ? <Activity className="w-4 h-4 animate-spin" /> : createOpen ? t('initTier') : t('admin.plans.commitChanges')} <ChevronRight className="w-4 h-4 shadow-sm" />
                       </Button>
                    </DialogFooter>
                 </form>
              </DialogContent>
            </Dialog>}
        </AnimatePresence>

        {/* Delete Confirmation */}
        <Dialog open={deleteOpen} onOpenChange={setDeleteOpen}>
          <DialogContent className="max-w-md bg-card border-border text-foreground rounded-3xl p-8 overflow-hidden shadow-2xl">
             <div className="absolute top-0 left-0 w-full h-1 bg-red-600"></div>
             <DialogHeader>
                <DialogTitle className="text-2xl font-bold text-foreground flex items-center gap-3">
                   <Shield className="w-6 h-6 text-red-500" />
                   {t('admin.plans.delete.title')}
                </DialogTitle>
             </DialogHeader>
             <div className="py-6 space-y-4">
                <p className="text-sm font-medium text-muted-foreground leading-relaxed">
                   {t('admin.plans.delete.description', {
                name: selectedPlan?.name
              })}
                </p>
                {(selectedPlan?._count?.orgSubscriptions ?? 0) > 0 && <div className="p-5 bg-red-500/10 border border-red-500/20 rounded-xl shadow-inner">
                     <p className="text-[10px] font-bold text-red-600 dark:text-red-400 animate-pulse">
                        {t('warning', {
                  count: selectedPlan?._count?.orgSubscriptions
                })}
                     </p>
                  </div>}
             </div>
             <DialogFooter className="flex gap-4 pt-4">
                <Button variant="ghost" className="flex-1 text-[10px] font-bold text-muted-foreground hover:text-foreground" onClick={() => setDeleteOpen(false)}>{t('admin.plans.delete.abortTerm')}</Button>
                <Button variant="destructive" className="flex-1 h-14 rounded-xl bg-red-600 hover:bg-red-500 font-bold text-[10px] shadow-xl shadow-red-600/30" onClick={handleDelete}>{t('admin.plans.delete.executeTerm')}</Button>
             </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}