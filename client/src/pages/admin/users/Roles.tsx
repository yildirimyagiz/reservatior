import { t } from "i18next";
import React, { useState } from "react";
import { useTranslation } from "react-i18next";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
import { Edit, Trash2, Shield, Lock, Plus, Search, Users, ShieldAlert, ShieldCheck, Fingerprint, Activity, Zap, Layers, ChevronRight, MoreHorizontal } from "lucide-react";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { cn } from "@/lib/utils";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { motion, AnimatePresence } from "framer-motion";
interface Permission {
  id: string;
  key: string;
  name: string;
  description: string;
  group: string;
  createdAt: string;
}
interface Role {
  id: string;
  orgId: string;
  key: string;
  name: string;
  description?: string;
  isSystem: boolean;
  userCount: number;
  permissions: Permission[];
  createdAt: string;
  updatedAt: string;
}
const PERMISSION_GROUPS = (t: any) => {
  return {
    properties: {
      label: t("properties"),
      color: "bg-blue-500/10 text-blue-600 dark:text-blue-400 border-blue-500/20"
    },
    listings: {
      label: t("listings"),
      color: "bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border-emerald-500/20"
    },
    tenants: {
      label: t("tenants"),
      color: "bg-orange-500/10 text-orange-600 dark:text-orange-400 border-orange-500/20"
    },
    financial: {
      label: t("rolesGroupsFinancial"),
      color: "bg-purple-500/10 text-purple-600 dark:text-purple-400 border-purple-500/20"
    },
    reports: {
      label: t("reports"),
      color: "bg-indigo-500/10 text-indigo-600 dark:text-indigo-400 border-indigo-500/20"
    },
    admin: {
      label: t("admin.roles.groups.admin"),
      color: "bg-red-500/10 text-red-600 dark:text-red-500 border-red-500/20"
    },
    integrations: {
      label: t("integrations"),
      color: "bg-indigo-500/10 text-indigo-600 dark:text-indigo-400 border-indigo-500/20"
    },
    ai: {
      label: t("ai"),
      color: "bg-pink-500/10 text-pink-600 dark:text-pink-400 border-pink-500/20"
    }
  };
};
export default function Roles() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterSystem, setFilterSystem] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const pg = PERMISSION_GROUPS(t);
  const [selectedRole, setSelectedRole] = useState<Role | null>(null);
  const [roleName, setRoleName] = useState("");
  const [roleDescription, setRoleDescription] = useState("");
  const [selectedPermissionIds, setSelectedPermissionIds] = useState<string[]>([]);
  const queryClient = useQueryClient();

  const { data: rolesData, isLoading: loadingRoles } = useQuery<Role[]>({
    queryKey: ['adminRoles'],
    queryFn: async () => {
      try {
        const rolesRes = await apiClient.get('/role', {
          page: "1",
          limit: "50",
          include: "permissions"
        });
        return (rolesRes as any).data || [];
      } catch (e) {
        toast({
          title: t("admin.users.sync_failure"),
          description: t("admin.users.global_permission_matrix_unreachable"),
          variant: "destructive"
        });
        return [];
      }
    }
  });

  const { data: permissionsData, isLoading: loadingPermissions } = useQuery<Permission[]>({
    queryKey: ['adminPermissions'],
    queryFn: async () => {
      try {
        const permissionsRes = await apiClient.get('/permission', {
          page: "1",
          limit: "100"
        });
        return (permissionsRes as any).data || [];
      } catch (e) {
        return [];
      }
    }
  });

  const roles: Role[] = rolesData || [];
  const permissions: Permission[] = permissionsData || [];
  const loading = loadingRoles || loadingPermissions;
  const handlePermissionToggle = (permissionId: string) => {
    setSelectedPermissionIds(prev => prev.includes(permissionId) ? prev.filter(id => id !== permissionId) : [...prev, permissionId]);
  };
  const filteredRoles = roles.filter((role: Role) => {
    const matchesSearch = role.name.toLowerCase().includes(search.toLowerCase()) || role.description?.toLowerCase().includes(search.toLowerCase());
    const matchesSystem = filterSystem === "all" || filterSystem === "system" && role.isSystem || filterSystem === "custom" && !role.isSystem;
    return matchesSearch && matchesSystem;
  });
  const stats = {
    total: filteredRoles.length,
    system: filteredRoles.filter((r: Role) => r.isSystem).length,
    custom: filteredRoles.filter((r: Role) => !r.isSystem).length,
    users: filteredRoles.reduce((sum: number, r: Role) => sum + r.userCount, 0)
  };
  const handleCreateRole = async () => {
    try {
      if (!roleName) {
        toast({
          title: t("admin.users.validationerror"),
          description: t("admin.users.role_designation_requires_a"),
          variant: "destructive"
        });
        return;
      }
      const data = {
        name: roleName,
        key: roleName.toUpperCase().replace(/\s+/g, '_'),
        description: roleDescription,
        orgId: roles[0]?.orgId || "system",
        permissionIds: selectedPermissionIds
      };
      await apiClient.post('/role', data);
      setCreateOpen(false);
      resetForm();
      toast({
        title: t("admin.users.node_provisioned"),
        description: t("admin.users.new_authorization_role_has")
      });
      queryClient.invalidateQueries({ queryKey: ['adminRoles'] });
    } catch (error) {
      toast({
        title: t("admin.users.provisioning_error"),
        description: t("admin.users.failed_to_initialize_new"),
        variant: "destructive"
      });
    }
  };
  const handleUpdateRole = async (id: string) => {
    try {
      const data = {
        name: roleName,
        description: roleDescription,
        permissionIds: selectedPermissionIds
      };
      await apiClient.patch(`/role/${id}`, data);
      setEditOpen(false);
      resetForm();
      toast({
        title: t("admin.users.role_reconfigured"),
        description: t("admin.users.authorization_parameters_updated_successfully")
      });
      queryClient.invalidateQueries({ queryKey: ['adminRoles'] });
    } catch (error) {
      toast({
        title: t("admin.users.sync_error"),
        description: t("admin.users.failed_to_reconfigure_role"),
        variant: "destructive"
      });
    }
  };
  const resetForm = () => {
    setRoleName("");
    setRoleDescription("");
    setSelectedPermissionIds([]);
    setSelectedRole(null);
  };
  const handleDeleteRole = async (id: string) => {
    if (!confirm(t('deleteConfirm'))) return;
    try {
      await apiClient.delete(`/role/${id}`);
      queryClient.invalidateQueries({ queryKey: ['adminRoles'] });
      toast({
        title: t("admin.users.node_terminated"),
        description: t("admin.users.role_removed_from_global")
      });
    } catch (error) {
      toast({
        title: t("admin.users.termination_error"),
        description: t("admin.users.failed_to_remove_role"),
        variant: "destructive"
      });
    }
  };
  const groupedPermissions = permissions.reduce((acc: Record<string, Permission[]>, permission: Permission) => {
    if (!acc[permission.group]) acc[permission.group] = [];
    acc[permission.group].push(permission);
    return acc;
  }, {} as Record<string, Permission[]>);
  return <PageShell title={t('rolesTitle')} description={t('rolesDesc')}>
      <div className="space-y-10 pb-20 selection:bg-primary/30">
        
        {/* KPI Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 px-4">
           {[{
          label: t('total'),
          value: stats.total,
          icon: Shield,
          color: "text-blue-500"
        }, {
          label: t('admin.roles.systemCores'),
          value: stats.system,
          icon: Lock,
          color: "text-red-500"
        }, {
          label: t('admin.roles.customNodes'),
          value: stats.custom,
          icon: Zap,
          color: "text-emerald-500"
        }, {
          label: t('admin.roles.authorizedUsers'),
          value: stats.users,
          icon: Users,
          color: "text-violet-500"
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

        {/* Tactical Search & Actions Interface */}
        <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
          <div className="flex flex-wrap items-center gap-3 flex-1">
            <div className="relative group min-w-[320px]">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-orange-500 transition-colors" />
              <Input placeholder={t("searchPlaceholder")} value={search} onChange={e => setSearch(e.target.value)} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-orange-500/20 focus:border-orange-500/40 transition-all font-medium border-l border-t" />
            </div>
            <Select value={filterSystem} onValueChange={setFilterSystem}>
                <SelectTrigger className="w-48 bg-card/60 backdrop-blur-md border-border dark:border-border rounded-2xl h-14 text-foreground font-bold text-[10px] tracking-[0.2em] border-l-2 border-t-2">
                  <SelectValue placeholder={t('admin.roles.nodeType')} />
                </SelectTrigger>
                <SelectContent className="bg-card border-border rounded-2xl">
                  <SelectItem value="all">{t('admin.roles.allNodes')}</SelectItem>
                  <SelectItem value="system">{t('admin.roles.coreSystem')}</SelectItem>
                  <SelectItem value="custom">{t('admin.roles.userDefined')}</SelectItem>
                </SelectContent>
            </Select>
          </div>
          <Button onClick={() => {
          setSelectedRole(null);
          setRoleName("");
          setRoleDescription("");
          setSelectedPermissionIds([]);
          setCreateOpen(true);
        }} className="bg-blue-600 hover:bg-blue-500 text-foreground h-14 px-8 rounded-2xl font-bold text-[10px] gap-3 shadow-xl shadow-blue-600/20">
            <Plus className="w-4 h-4" />
            {t("rolesInitnode")}
          </Button>
        </div>

        {/* Global Data Table */}
        <div className="px-4">
          <div className="bg-card/40 backdrop-blur-xl border-border dark:border-border rounded-4xl overflow-hidden shadow-2xl border-l-2 border-t-2 relative">
             <div className="absolute top-0 left-0 w-full h-1 bg-linear-to-r from-blue-600 via-transparent to-transparent opacity-30"></div>
             <Table>
                <TableHeader className="bg-muted/50 border-b border-border">
                  <TableRow className="border-none hover:bg-transparent">
                    <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t("rolesIdentity")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("permissions")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("rolesCapacity")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t("rolesStatus")}</TableHead>
                    <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t("rolesActions")}</TableHead>
                  </TableRow>
                </TableHeader>
               <TableBody>
                  {loading ? <TableRow>
                      <TableCell colSpan={5} className="py-24 text-center">
                        <Activity className="w-12 h-12 text-blue-500 animate-spin mx-auto mb-4 opacity-50" />
                        <p className="text-[10px] font-bold text-muted-foreground animate-pulse">{t('admin.roles.syncing')}</p>
                      </TableCell>
                    </TableRow> : filteredRoles.map((role: Role) => <TableRow key={role.id} className="border-b border-border hover:bg-muted/20 transition-all group">
                         <TableCell className="py-8 px-8">
                           <div className="flex items-center gap-4">
                              <div className="w-12 h-12 rounded-xl bg-background border border-border flex items-center justify-center group-hover:scale-110 transition-all shadow-inner">
                                 {role.isSystem ? <ShieldCheck className="w-6 h-6 text-red-500" /> : <Fingerprint className="w-6 h-6 text-emerald-500" />}
                              </div>
                              <div>
                                 <div className="text-lg font-bold text-foreground leading-tight flex items-center gap-2 group-hover:text-primary transition-colors">
                                    {role.name}
                                    {role.isSystem && <Lock className="w-3 h-3 text-muted-foreground/30" />}
                                 </div>
                                 <div className="text-[10px] font-bold text-muted-foreground max-w-sm truncate">{role.description || t('admin.roles.noDesignation')}</div>
                              </div>
                           </div>
                         </TableCell>
                         <TableCell className="px-8">
                            <div className="flex flex-wrap gap-2 max-w-[300px]">
                              {Array.from(new Set(role.permissions.map((p: Permission) => p.group))).map((group: unknown) => {
                      const groupString = String(group);
                      const groupKey = groupString.toLowerCase();
                      const config = (pg as any)[groupKey];
                      return <Badge key={groupString} variant="outline" className={cn("text-[9px] font-bold   px-2 py-0.5 rounded-full  border-none shadow-sm", config?.color || "bg-slate-500/10")}>
                                    {config?.label || groupString}
                                  </Badge>;
                    })}
                            </div>
                         </TableCell>
                         <TableCell className="px-8 font-bold">
                            <div className="flex items-center gap-3">
                               <Users className="w-4 h-4 text-muted-foreground/30" />
                               <span className="text-lg text-foreground leading-none">{role.userCount}</span>
                            </div>
                         </TableCell>
                         <TableCell className="px-8 text-right">
                            <div className="flex items-center justify-end gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                               <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-card hover:text-foreground text-muted-foreground border border-transparent hover:border-border transition-all" onClick={() => {
                      setSelectedRole(role);
                      setRoleName(role.name);
                      setRoleDescription(role.description || "");
                      setSelectedPermissionIds(role.permissions.map((p: { id: any; }) => p.id));
                      setEditOpen(true);
                    }}>
                                  <Edit className="w-4 h-4" />
                               </Button>
                               {!role.isSystem && <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-red-500/10 text-muted-foreground hover:text-red-500 border border-transparent hover:border-red-500/20 transition-all" onClick={() => handleDeleteRole(role.id)}>
                                    <Trash2 className="w-4 h-4" />
                                 </Button>}
                               <Button variant="ghost" size="icon" className="h-10 w-10 rounded-xl hover:bg-card hover:text-foreground text-muted-foreground border border-transparent hover:border-border transition-all">
                                  <MoreHorizontal className="w-4 h-4" />
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
            resetForm();
          }
        }}>
              <DialogContent className="max-w-4xl bg-card border-border text-foreground rounded-4xl p-0 overflow-hidden shadow-3xl">
                 <div className="absolute top-0 left-0 w-full h-1 bg-linear-to-r from-primary via-transparent to-transparent"></div>
                 <DialogHeader className="p-8 border-b border-border bg-muted/20">
                    <DialogTitle className="text-3xl font-bold flex items-center gap-3 text-foreground leading-none">
                       <ShieldAlert className="w-8 h-8 text-primary" />
                       {createOpen ? t('admin.roles.initTitle') : t('editTitle')}
                    </DialogTitle>
                    <DialogDescription className="text-[10px] font-bold text-muted-foreground tracking-[0.2em] mt-2">
                       {t('admin.roles.description')}
                    </DialogDescription>
                 </DialogHeader>

                 <div className="p-10 grid grid-cols-1 lg:grid-cols-2 gap-10 max-h-[60vh] overflow-y-auto custom-scrollbar">
                    <div className="space-y-8">
                       <div className="space-y-3">
                          <Label className="text-[10px] font-bold text-muted-foreground ml-3">{t('admin.roles.formalDesignation')}</Label>
                          <Input value={roleName} onChange={e => setRoleName(e.target.value)} placeholder={t("admin.users.designationid")} className="bg-background/40 border-border rounded-2xl h-16 font-bold tracking-tight px-6 text-xl focus:ring-primary/20 shadow-inner" />
                       </div>
                       <div className="space-y-3">
                          <Label className="text-[10px] font-bold text-muted-foreground ml-3">{t('admin.roles.functionalDescription')}</Label>
                          <Textarea value={roleDescription} onChange={e => setRoleDescription(e.target.value)} rows={4} placeholder={t('admin.roles.descriptionPlaceholder')} className="bg-background/40 border-border rounded-2xl p-6 font-medium tracking-tight focus:ring-primary/20 shadow-inner resize-none min-h-[160px]" />
                       </div>
                    </div>

                    <div className="space-y-6">
                       <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t('admin.roles.syncMatrix')}</Label>
                       <div className="space-y-8">
                          {Object.entries(groupedPermissions).map(([group, groupPermissions]) => <div key={group} className="space-y-3">
                               <div className="flex items-center gap-3">
                                  <div className={cn("p-2 rounded-lg shadow-sm border border-border/50", (pg as any)[group.toLowerCase()]?.color || "bg-muted text-muted-foreground")}>
                                     <Layers className="w-3 h-3" />
                                  </div>
                                  <span className="text-[10px] font-bold text-muted-foreground tracking-[0.2em]">{t(`admin.roles.groups.${group.toLowerCase()}`)}</span>
                               </div>
                               <div className="grid grid-cols-1 gap-2">
                                  {(groupPermissions as Permission[]).map(permission => <div key={permission.id} onClick={() => handlePermissionToggle(permission.id)} className={cn("flex items-center justify-between p-4 rounded-xl border cursor-pointer transition-all shadow-sm", selectedPermissionIds.includes(permission.id) ? "bg-primary/5 border-primary/40 text-primary" : "bg-background/50 border-border text-muted-foreground hover:bg-muted/50")}>
                                       <div className="flex flex-col">
                                          <span className="text-[11px] font-bold tracking-tight">{permission.name}</span>
                                          <span className="text-[8px] font-bold opacity-60 mt-0.5">{permission.description.slice(0, 40)}...</span>
                                       </div>
                                       {selectedPermissionIds.includes(permission.id) ? <ShieldCheck className="w-4 h-4 text-primary" /> : <div className="w-4 h-4 rounded-full border-2 border-border" />}
                                    </div>)}
                               </div>
                            </div>)}
                       </div>
                    </div>
                 </div>

                 <DialogFooter className="p-8 bg-muted/20 border-t border-border flex gap-4">
                    <Button variant="ghost" className="flex-1 h-16 rounded-2xl font-bold text-[10px] tracking-[0.3em] text-muted-foreground hover:text-foreground transition-all" onClick={() => {
                setCreateOpen(false);
                setEditOpen(false);
                resetForm();
              }}>{t('abort')}</Button>
                    <Button onClick={createOpen ? handleCreateRole : () => selectedRole && handleUpdateRole(selectedRole.id)} className="flex-2 h-16 rounded-2xl bg-primary hover:bg-primary/90 text-primary-foreground font-bold text-[10px] tracking-[0.3em] shadow-xl shadow-primary/20 gap-3">
                       {createOpen ? t('admin.roles.execInit') : t('commit')} <ChevronRight className="w-4 h-4 shadow-sm" />
                    </Button>
                 </DialogFooter>
              </DialogContent>
            </Dialog>}
        </AnimatePresence>
      </div>
    </PageShell>;
}