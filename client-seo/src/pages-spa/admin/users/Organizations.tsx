"use client";
import { apiClient } from '@/lib/api/client';

import React, { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { adminApi } from "@/lib/api/admin";
import { Edit, Trash2, MoreHorizontal, CheckCircle2, XCircle, Plus, Search, Users, Home, Building, Shield, Globe, Activity, Zap, TrendingUp, Layers, UserCheck } from "lucide-react";
import { cn } from "@/lib/utils";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { motion, AnimatePresence } from "framer-motion";
import { Card, CardContent } from "@/components/ui/card";
import { useTranslation } from "react-i18next";
interface Organization {
  id: string;
  name: string;
  type: string;
  plan: string;
  status: "ACTIVE" | "SUSPENDED" | "TRIAL";
  userCount: number;
  propertyCount: number;
  maxUsers: number;
  maxProperties: number;
  billingEmail: string;
  phone?: string;
  address?: string;
  domain?: string;
  owner?: {
    id: string;
    name: string;
    email: string;
  };
  createdAt: string;
  updatedAt: string;
}
const ORG_STATUS = (t: any) => {
  return {
    ACTIVE: {
      label: t("activeNode"),
      color: "bg-emerald-500/10 text-emerald-400 border-emerald-500/20"
    },
    SUSPENDED: {
      label: t("suspendedNode"),
      color: "bg-red-500/10 text-red-500 border-red-500/20"
    },
    TRIAL: {
      label: t("trialNode"),
      color: "bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-500/20"
    }
  };
};
const PLAN_CONFIG = (t: any) => {
  return {
    STARTER: {
      label: t("starterTier"),
      color: "bg-slate-500/10 text-muted-foreground border-slate-500/20"
    },
    PRO: {
      label: t("proTierLabel"),
      color: "bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-500/20"
    },
    ENTERPRISE: {
      label: t("enterpriseTier"),
      color: "bg-slate-500/10 text-slate-500 dark:text-slate-400 border-slate-500/20"
    }
  };
};
export default function Organizations() {
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [editingId, setEditingId] = React.useState<string | null>(null);
  const [editOpen, setEditOpen] = React.useState(false);
  const [editFormData, setEditFormData] = React.useState<any>({});

  const updateMutation = useMutation({
    mutationFn: async (data: any) => apiClient.put(`/admin/organizations/${data.id}`, data),
    onSuccess: () => { toast({ title: "Updated", description: "Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); setEditOpen(false); },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/admin/organizations/${id}`),
    onSuccess: () => { toast({ title: "Deleted", description: "Record deleted successfully" }); queryClient.invalidateQueries(); },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });

  const openEditModal = (org: Organization) => {
    setEditingId(org.id);
    setEditFormData({
      id: org.id,
      name: org.name,
      type: org.type,
      plan: org.plan,
      status: org.status,
      maxUsers: org.maxUsers,
      maxProperties: org.maxProperties,
      billingEmail: org.billingEmail,
      phone: org.phone,
      address: org.address,
      domain: org.domain
    });
    setEditOpen(true);
  };
  
  const {
    t
  } = useTranslation();
  const [search, setSearch] = useState("");
  const [createOpen, setCreateOpen] = useState(false);
  const orgStatus = ORG_STATUS(t);
  const planConfig = PLAN_CONFIG(t);

  const { data: organizations = [], isLoading: loading } = useQuery<Organization[]>({
    queryKey: ['adminOrganizations'],
    queryFn: async () => {
      try {
        const response = await adminApi.getOrganizations({
          page: "1",
          limit: "50",
          include: "owner"
        });
        return (response as any).data || [];
      } catch (error) {
        toast({
          title: t("admin_users_nexus_organizations_syncFailure") || "Sync Failure",
          description: t("admin_users_nexus_organizations_unreachable") || "Global matrix unreachable",
          variant: "destructive"
        });
        return [];
      }
    }
  });
  const filteredOrgs = organizations.filter(org => org.name.toLowerCase().includes(search.toLowerCase()) || org.domain?.toLowerCase().includes(search.toLowerCase()));
  const stats = {
    totalNodes: organizations.length,
    activeEntities: organizations.filter(o => o.status === "ACTIVE").length,
    proTier: organizations.filter(o => o.plan === "PRO").length,
    enterpriseTier: organizations.filter(o => o.plan === "ENTERPRISE").length
  };
  return <PageShell title={t("usersOrganizationsTitle")} description={t("usersOrganizationsDesc")}>
      <div className="space-y-10 pb-20">
        
        {/* KPI Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card font-medium">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
               <Building className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("total")}</p>
              <h3 className="text-3xl font-bold text-foreground leading-none">{stats.totalNodes}</h3>
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400 mt-4 leading-none">{t('organizations.globalStructureNodes')}</p>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card font-medium">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
               <Globe className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("active")}</p>
              <h3 className="text-3xl font-bold text-emerald-400 leading-none">{stats.activeEntities}</h3>
              <p className="text-[10px] font-bold text-emerald-500/60 mt-4 leading-none">{t('organizations.verifiedOpStatus')}</p>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card font-medium">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
               <Zap className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("pro")}</p>
              <h3 className="text-3xl font-bold text-slate-500 dark:text-slate-400 leading-none">{stats.proTier}</h3>
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400/60 mt-4 leading-none">{t('organizations.enhancedFeatureNodes')}</p>
            </CardContent>
          </Card>

          <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card font-medium">
             <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
               <Shield className="w-10 h-10" />
            </div>
            <CardContent className="p-8">
              <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("enterprise")}</p>
              <h3 className="text-3xl font-bold text-slate-500 dark:text-slate-400 leading-none">{stats.enterpriseTier}</h3>
              <p className="text-[10px] font-bold text-slate-500 dark:text-slate-400/60 mt-4 leading-none">{t('organizations.maxSecurityProtocols')}</p>
            </CardContent>
          </Card>
        </div>

        {/* Tactical Search & Actions Interface */}
        <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
           <div className="relative group min-w-[320px]">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-orange-500 transition-colors" />
              <Input placeholder={t("searchPlaceholder")} value={search} onChange={e => setSearch(e.target.value)} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-orange-500/20 focus:border-orange-500/40 transition-all font-medium border-l border-t" />
           </div>
           <Button onClick={() => setCreateOpen(true)} className="bg-slate-600 hover:bg-slate-500 text-foreground h-14 px-8 rounded-2xl font-bold text-[10px] gap-3 shadow-xl shadow-slate-600/20">
              <Plus className="w-4 h-4" />
              {t("initOrg")}
           </Button>
        </div>

        {/* Global Data Table */}
        <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
            <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-slate-600 via-transparent to-transparent opacity-50"></div>
            <CardContent className="p-0">
               <Table>
                  <TableHeader className="bg-muted/50 border-b border-border">
                    <TableRow className="border-none hover:bg-transparent">
                      <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t('organizations.orgIdentity')}</TableHead>
                      <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t('organizations.domainAccess')}</TableHead>
                      <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t('organizations.archPlan')}</TableHead>
                      <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t('organizations.capacityIndex')}</TableHead>
                      <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t('organizations.syncStatus')}</TableHead>
                      <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t('administrative')}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                     {loading ? <TableRow>
                          <TableCell colSpan={6} className="py-24 text-center">
                            <Activity className="w-12 h-12 text-slate-500 animate-spin mx-auto mb-4 opacity-50" />
                            <p className="text-[10px] font-bold text-muted-foreground animate-pulse">{t('organizations.syncing')}</p>
                          </TableCell>
                        </TableRow> : filteredOrgs.map(org => <TableRow key={org.id} className="border-b border-border hover:bg-muted/50 transition-all group">
                              <TableCell className="py-8 px-8">
                                 <div className="flex items-center gap-4">
                                    <div className="w-14 h-14 rounded-2xl bg-card border border-border flex items-center justify-center font-bold text-slate-700 group-hover:scale-110 transition-all font-mono">
                                       {org.name.slice(0, 2).toUpperCase()}
                                    </div>
                                    <div>
                                       <div className="text-lg font-bold text-foreground leading-tight">{org.name}</div>
                                       <div className="text-[10px] font-bold text-muted-foreground leading-none mt-1">{t("admin_users_id")}{org.id.slice(0, 8).toUpperCase()}</div>
                                    </div>
                                 </div>
                              </TableCell>
                              <TableCell className="px-8">
                                 <div className="text-sm font-bold text-muted-foreground leading-tight">{org.domain || "GLOBAL_CLUSTER"}</div>
                                 <div className="text-[10px] font-bold text-slate-600 leading-none mt-1">{org.owner?.email || "UNSET_AUTHORITY"}</div>
                              </TableCell>
                              <TableCell className="px-8 font-bold">
                                 <Badge className={cn("text-[8px] font-bold   px-3 py-1 rounded-full  border-none shadow-lg", (planConfig as any)[org.plan]?.color || "bg-slate-500/10")}>
                                    {(planConfig as any)[org.plan] ? (planConfig as any)[org.plan].label : org.plan}
                                 </Badge>
                              </TableCell>
                              <TableCell className="px-8">
                                 <div className="flex flex-col gap-1">
                                    <div className="flex items-center justify-between text-[10px] font-bold text-muted-foreground w-32">
                                       <span>{t('users')}</span>
                                       <span>{org.userCount}/{org.maxUsers}</span>
                                    </div>
                                    <div className="h-1.5 w-32 bg-muted/50 rounded-full overflow-hidden">
                                       <div className="h-full bg-slate-500 shadow-[0_0_10px_#3b82f6]" style={{
                        width: `${org.userCount / org.maxUsers * 100}%`
                      }}></div>
                                    </div>
                                    <div className="flex items-center justify-between text-[10px] font-bold text-muted-foreground w-32 mt-1">
                                       <span>{t('properties')}</span>
                                       <span>{org.propertyCount}/{org.maxProperties}</span>
                                    </div>
                                    <div className="h-1.5 w-32 bg-muted/50 rounded-full overflow-hidden">
                                       <div className="h-full bg-emerald-500 shadow-[0_0_10px_#10b981]" style={{
                        width: `${org.propertyCount / org.maxProperties * 100}%`
                      }}></div>
                                    </div>
                                 </div>
                              </TableCell>
                              <TableCell className="px-8">
                                 <Badge className={cn("text-[8px] font-bold   px-3 py-1 rounded-full  border shadow-lg", (orgStatus as any)[org.status].color)}>
                                    {(orgStatus as any)[org.status].label}
                                 </Badge>
                              </TableCell>
                              <TableCell className="px-8 text-right">
                                 <div className="flex items-center justify-end gap-2">
                                    <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-muted/50 text-muted-foreground" onClick={() => openEditModal(org)}>
                                       <Edit className="w-4 h-4" />
                                    </Button>
                                    <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-muted/50 text-muted-foreground hover:text-red-500 transition-all" onClick={() => deleteMutation.mutate(org.id)}>
                                       <Trash2 className="w-4 h-4" />
                                    </Button>
                                    <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-muted/50 text-muted-foreground">
                                       <MoreHorizontal className="w-4 h-4" />
                                    </Button>
                                 </div>
                              </TableCell>
                           </TableRow>)}
                  </TableBody>
               </Table>
            </CardContent>
        </Card>
      </div>

      {/* Modernized Initialization Dialog */}
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border-border text-foreground rounded-4xl p-0 overflow-hidden shadow-[0_0_50px_rgba(0,0,0,0.5)]">
           <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-slate-600 via-transparent to-transparent"></div>
           <DialogHeader className="p-8 border-b border-border bg-muted/50">
              <DialogTitle className="text-2xl font-bold flex items-center gap-3 text-foreground">
                <Layers className="w-6 h-6 text-slate-500" />
                {t('organizations.initDialogTitle')}
              </DialogTitle>
              <DialogDescription className="text-[10px] font-bold text-muted-foreground mt-1">{t('organizations.initDialogDesc')}</DialogDescription>
           </DialogHeader>

           <div className="p-10 space-y-8">
              <div className="grid grid-cols-2 gap-8">
                 <div className="col-span-2 space-y-2">
                    <Label className="text-[10px] font-bold text-muted-foreground ml-3">{t('organizations.formalDesignation')}</Label>
                    <Input placeholder={t('organizations.namePlaceholder')} className="bg-card border-border rounded-2xl h-16 font-bold tracking-tight px-6 text-lg focus:ring-slate-500/20" />
                 </div>
                 <div className="space-y-2">
                    <Label className="text-[10px] font-bold text-muted-foreground ml-3">{t('organizations.entityRole')}</Label>
                    <Select>
                       <SelectTrigger className="bg-card border-border rounded-2xl h-14 font-bold text-[10px] px-6 border-l border-t">
                          <SelectValue placeholder={t('organizations.rolePlaceholder')} />
                       </SelectTrigger>
                       <SelectContent className="bg-[#14151a] border-border text-foreground rounded-2xl">
                          <SelectItem value="AGENCY" className="font-bold">{t('organizations.roles.agency')}</SelectItem>
                          <SelectItem value="INVESTOR" className="font-bold">{t('organizations.roles.investor')}</SelectItem>
                          <SelectItem value="DEVELOPER" className="font-bold">{t('organizations.roles.dev')}</SelectItem>
                       </SelectContent>
                    </Select>
                 </div>
                 <div className="space-y-2">
                    <Label className="text-[10px] font-bold text-muted-foreground ml-3">{t('organizations.neuralClusterPlan')}</Label>
                    <Select>
                       <SelectTrigger className="bg-card border-border rounded-2xl h-14 font-bold text-[10px] px-6 border-l border-t">
                          <SelectValue placeholder={t('organizations.archPlaceholder')} />
                       </SelectTrigger>
                       <SelectContent className="bg-[#14151a] border-border text-foreground rounded-2xl">
                          <SelectItem value="STARTER" className="font-bold">{t('organizations.plans.starter')}</SelectItem>
                          <SelectItem value="PRO" className="font-bold">{t('pro')}</SelectItem>
                          <SelectItem value="ENTERPRISE" className="font-bold">{t('enterprise')}</SelectItem>
                       </SelectContent>
                    </Select>
                 </div>
              </div>
           </div>

           <DialogFooter className="p-8 bg-card border-t border-border flex gap-4">
              <Button variant="ghost" className="flex-1 h-16 rounded-2xl font-bold text-[10px] text-muted-foreground hover:text-foreground transition-all" onClick={() => setCreateOpen(false)}>{t('organizations.abortMod')}</Button>
              <Button className="flex-2 h-16 rounded-2xl bg-slate-600 hover:bg-slate-500 text-foreground font-bold text-[10px] shadow-xl shadow-slate-600/30">{t('organizations.execInit')}</Button>
           </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Edit Organization Dialog */}
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="max-w-2xl bg-[#14151a] border-border text-foreground rounded-4xl p-0 overflow-hidden shadow-[0_0_50px_rgba(0,0,0,0.5)]">
           <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-slate-600 via-transparent to-transparent"></div>
           <DialogHeader className="p-8 border-b border-border bg-muted/50">
              <DialogTitle className="text-2xl font-bold flex items-center gap-3 text-foreground">
                <Edit className="w-6 h-6 text-slate-500" />
                Edit Organization
              </DialogTitle>
              <DialogDescription className="text-[10px] font-bold text-muted-foreground mt-1">Update organization details and settings</DialogDescription>
           </DialogHeader>

           <form onSubmit={(e) => { e.preventDefault(); updateMutation.mutate(editFormData); }} className="p-10 space-y-8">
              <div className="grid grid-cols-2 gap-8">
                 <div className="col-span-2 space-y-2">
                    <Label className="text-[10px] font-bold text-muted-foreground ml-3">Organization Name</Label>
                    <Input value={editFormData.name || ''} onChange={e => setEditFormData({...editFormData, name: e.target.value})} className="bg-card border-border rounded-2xl h-16 font-bold tracking-tight px-6 text-lg focus:ring-slate-500/20" />
                 </div>
                 <div className="space-y-2">
                    <Label className="text-[10px] font-bold text-muted-foreground ml-3">Status</Label>
                    <Select value={editFormData.status} onValueChange={v => setEditFormData({...editFormData, status: v})}>
                       <SelectTrigger className="bg-card border-border rounded-2xl h-14 font-bold text-[10px] px-6 border-l border-t">
                          <SelectValue />
                       </SelectTrigger>
                       <SelectContent className="bg-[#14151a] border-border text-foreground rounded-2xl">
                          <SelectItem value="ACTIVE">Active</SelectItem>
                          <SelectItem value="SUSPENDED">Suspended</SelectItem>
                          <SelectItem value="TRIAL">Trial</SelectItem>
                       </SelectContent>
                    </Select>
                 </div>
                 <div className="space-y-2">
                    <Label className="text-[10px] font-bold text-muted-foreground ml-3">Plan</Label>
                    <Select value={editFormData.plan} onValueChange={v => setEditFormData({...editFormData, plan: v})}>
                       <SelectTrigger className="bg-card border-border rounded-2xl h-14 font-bold text-[10px] px-6 border-l border-t">
                          <SelectValue />
                       </SelectTrigger>
                       <SelectContent className="bg-[#14151a] border-border text-foreground rounded-2xl">
                          <SelectItem value="STARTER">Starter</SelectItem>
                          <SelectItem value="PRO">Pro</SelectItem>
                          <SelectItem value="ENTERPRISE">Enterprise</SelectItem>
                       </SelectContent>
                    </Select>
                 </div>
                 <div className="space-y-2">
                    <Label className="text-[10px] font-bold text-muted-foreground ml-3">Max Users</Label>
                    <Input type="number" value={editFormData.maxUsers || ''} onChange={e => setEditFormData({...editFormData, maxUsers: parseInt(e.target.value)})} className="bg-card border-border rounded-2xl h-14 font-bold text-[10px] px-6 border-l border-t" />
                 </div>
                 <div className="space-y-2">
                    <Label className="text-[10px] font-bold text-muted-foreground ml-3">Max Properties</Label>
                    <Input type="number" value={editFormData.maxProperties || ''} onChange={e => setEditFormData({...editFormData, maxProperties: parseInt(e.target.value)})} className="bg-card border-border rounded-2xl h-14 font-bold text-[10px] px-6 border-l border-t" />
                 </div>
                 <div className="col-span-2 space-y-2">
                    <Label className="text-[10px] font-bold text-muted-foreground ml-3">Billing Email</Label>
                    <Input type="email" value={editFormData.billingEmail || ''} onChange={e => setEditFormData({...editFormData, billingEmail: e.target.value})} className="bg-card border-border rounded-2xl h-14 font-bold text-[10px] px-6 border-l border-t" />
                 </div>
              </div>
           </form>

           <DialogFooter className="p-8 bg-card border-t border-border flex gap-4">
              <Button type="button" variant="ghost" className="flex-1 h-16 rounded-2xl font-bold text-[10px] text-muted-foreground hover:text-foreground transition-all" onClick={() => setEditOpen(false)}>Cancel</Button>
              <Button type="button" onClick={() => updateMutation.mutate(editFormData)} disabled={updateMutation.isPending} className="flex-2 h-16 rounded-2xl bg-slate-600 hover:bg-slate-500 text-foreground font-bold text-[10px] shadow-xl shadow-slate-600/30">
                {updateMutation.isPending ? "Saving..." : "Save Changes"}
              </Button>
           </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}