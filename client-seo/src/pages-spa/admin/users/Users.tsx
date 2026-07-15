"use client";
import React from 'react';

import { t } from"i18next";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from"@/components/ui/card";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from"@/components/ui/dialog";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Avatar, AvatarFallback, AvatarImage } from"@/components/ui/avatar";
import { Search, Filter, Plus, Edit, Trash2, Shield, UserCheck, UserX, Users as UsersIcon, Zap, Activity, Fingerprint, Terminal, ChevronRight, MoreVertical } from"lucide-react";
import { motion, AnimatePresence } from"framer-motion";
import { useState, useEffect } from"react";
import { useToast } from"@/hooks/use-toast";
import { useQuery } from"@tanstack/react-query";
import { useTranslation } from"react-i18next";
import { usersApi, User } from"@/lib/api/users";
import { cn } from"@/lib/utils";
import { useMutation, useQueryClient } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import { MoreHorizontal } from"lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
export default function Users() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const [editingId, setEditingId] = React.useState<string | null>(null);

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/admin/users/${data.id}`, data),
 onSuccess: () => { toast({ title:"Updated", description:"Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/admin/users/${id}`),
 onSuccess: () => { toast({ title:"Deleted", description:"Record deleted successfully" }); queryClient.invalidateQueries(); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 
 const {
 t
 } = useTranslation();
 const [searchTerm, setSearchTerm] = useState("");
 const [filterRole, setFilterRole] = useState("all");
 const [filterStatus, setFilterStatus] = useState("all");
 const [createOpen, setCreateOpen] = useState(false);
 const [editOpen, setEditOpen] = useState(false);
 const [selectedUser, setSelectedUser] = useState<User | null>(null);
 const [mounted, setMounted] = useState(false);
 useEffect(() => {
 setMounted(true);
 }, []);
 const {
 data: users = [],
 refetch
 } = useQuery<User[]>({
 queryKey: ["users", searchTerm, filterRole, filterStatus],
 queryFn: () => usersApi.getAll({
 search: searchTerm,
 role: filterRole !=="all" ? filterRole : undefined
 }),
 enabled: mounted
 });
 const handleCreate = async (e: React.FormEvent) => {
 e.preventDefault();
 const formData = new FormData(e.currentTarget as HTMLFormElement);
 const payload = Object.fromEntries(formData.entries());
 try {
 await usersApi.create(payload);
 setCreateOpen(false);
 toast({
 title: t("admin_users_entity_initialized"),
 description: t("admin_users_new_identity_node_has")
 });
 refetch();
 } catch (error) {
 toast({
 title: t("admin_users_sync_failed"),
 description: t("admin_users_failed_to_initialize_identity"),
 variant:"destructive"
 });
 }
 };
 const handleEdit = async (e: React.FormEvent) => {
 e.preventDefault();
 if (!selectedUser) return;
 const formData = new FormData(e.currentTarget as HTMLFormElement);
 const payload = Object.fromEntries(formData.entries());
 try {
 await usersApi.update(selectedUser.id, payload);
 setEditOpen(false);
 toast({
 title: t("admin_users_identity_reconfigured"),
 description: t("admin_users_node_parameters_updated_successfully")
 });
 refetch();
 } catch (error) {
 toast({
 title: t("admin_users_update_failed"),
 description: t("admin_users_failed_to_reconfigure_node"),
 variant:"destructive"
 });
 }
 };
 const handleToggleStatus = async (user: User) => {
 try {
 await usersApi.update(user.id, {
 status: user.status ==="ACTIVE" ?"INACTIVE" :"ACTIVE"
 });
 toast({
 title: t("admin_users_status_synchronized"),
 description: t("admin_users_node_is_now", { status: user.status ==="ACTIVE" ? t("admin_users_offline","ÇEVRİMDIŞI") : t("admin_users_active","AKTİF") })
 });
 refetch();
 } catch (error) {
 toast({
 title: t("admin_users_error"),
 description: t("admin_users_failed_to_update_node"),
 variant:"destructive"
 });
 }
 };
 const handleDelete = async (id: string) => {
 if (!confirm(t("admin_users_terminate_confirm","Bu kimlik düğümünü kalıcı olarak sonlandırmak istiyor musunuz?"))) return;
 try {
 await usersApi.delete(id);
 toast({
 title: t("admin_users_entity_terminated"),
 description: t("admin_users_identity_node_removed_from")
 });
 refetch();
 } catch (error) {
 toast({
 title: t("admin_users_termination_failed"),
 description: t("admin_users_failed_to_remove_identity"),
 variant:"destructive"
 });
 }
 };
 const getRoleConfig = (role: string) => {
 switch (role) {
 case 'SUPER_ADMIN':
 return {
 label: t("admin_users_supernode"),
 color: 'bg-red-500/10 text-red-600 dark:text-red-400 border-red-500/20'
 };
 case 'ADMIN':
 return {
 label: t("admin_users_coreadmin"),
 color: 'bg-orange-500/10 text-orange-600 dark:text-orange-400 border-orange-500/20'
 };
 case 'AGENT':
 return {
 label: t("admin_users_fieldagent"),
 color: 'bg-muted0/10 text-slate-600 dark:text-slate-400 border-slate-500/20'
 };
 default:
 return {
 label: t("admin_users_entitynode"),
 color: 'bg-muted text-muted-foreground border-border'
 };
 }
 };
 if (!mounted) return null;
 return <PageShell title={t("usersTitle")} description={t("usersDesc")}>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-10 pb-20">
 {/* KPI Neural Grid */}
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-muted-foreground">
 <UsersIcon className="w-10 h-10" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("total")}</p>
 <h3 className="text-3xl font-bold text-foreground leading-none">{users.length}</h3>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
 <UserCheck className="w-10 h-10" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("active")}</p>
 <h3 className="text-3xl font-bold text-emerald-400 leading-none font-mono">{users.filter(u => u.status === 'ACTIVE').length}</h3>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
 <Shield className="w-10 h-10" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("users")}</p>
 <h3 className="text-3xl font-bold text-muted-foreground leading-none font-mono">{users.filter(u => u.role === 'ADMIN').length}</h3>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t transition-all hover:bg-card">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
 <Activity className="w-10 h-10" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t("usersNew")}</p>
 <h3 className="text-3xl font-bold text-orange-400 leading-none font-mono">
 {users.filter(u => new Date(u.createdAt).getTime() > Date.now() - 24 * 60 * 60 * 1000).length}
 </h3>
 </CardContent>
 </Card>
 </div>

 {/* Tactical Search & Actions Interface */}
 <div className="flex flex-col lg:flex-row items-center justify-between gap-6 px-4">
 <div className="flex flex-wrap items-center gap-3 flex-1">
 <div className="relative group min-w-[320px]">
 <Search className="absolute left-4 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-orange-500 transition-colors" />
 <Input placeholder={t("commonSearch")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-orange-500/20 focus:border-orange-500/40 transition-all font-medium border-l border-t" />
 </div>
 </div>
 <Button onClick={() => {
 setSelectedUser(null);
 setCreateOpen(true);
 }} className="bg-slate-600 hover:bg-muted0 text-foreground h-14 px-8 rounded-2xl font-bold text-[10px] gap-3 shadow-xl shadow-slate-600/20">
 <Plus className="w-4 h-4" />
 {t("initEntity")}
 </Button>
 </div>

 {/* Identity Grid */}
 <div className="grid grid-cols-1 lg:grid-cols-2 2xl:grid-cols-3 gap-8 px-4">
 <AnimatePresence>
 {users.map((user, idx) => <motion.div layout key={user.id} initial={{
 opacity: 0,
 scale: 0.9
 }} animate={{
 opacity: 1,
 scale: 1
 }} exit={{
 opacity: 0,
 scale: 0.9
 }} transition={{
 delay: idx * 0.05
 }}>
 <Card className="bg-card/40 backdrop-blur-md border-border dark:border-border rounded-4xl p-8 shadow-3xl hover:bg-muted/10 transition-all group cursor-pointer border-l-2 border-t-2 relative overflow-hidden">
 <div className="absolute top-0 right-0 p-10 opacity-5 group-hover:opacity-10 transition-all text-primary">
 <Fingerprint className="w-24 h-24" />
 </div>
 
 <div className="flex items-start gap-6 relative z-10">
 <div className="relative">
 <Avatar className="w-20 h-20 border-2 border-border rounded-3xl p-1 group-hover:scale-105 transition-transform bg-background">
 <AvatarImage src={`https://i.pravatar.cc/150?u=${user.id}`} className="rounded-2xl" />
 <AvatarFallback className="bg-muted text-muted-foreground font-bold rounded-2xl">{user.name?.slice(0, 2).toUpperCase()}</AvatarFallback>
 </Avatar>
 <div className={cn("absolute -bottom-1 -right-1 w-5 h-5 rounded-full border-4 border-card", user.status === 'ACTIVE' ?"bg-emerald-500 shadow-[0_0_15px_#10b981]" :"bg-muted-foreground")} />
 </div>
 
 <div className="flex-1 min-w-0 space-y-1">
 <div className="flex items-center justify-between">
 <h4 className="text-xl font-bold text-foreground truncate leading-none group-hover:text-primary transition-colors">{user.name}</h4>
 <Button variant="ghost" size="icon" className="h-8 w-8 rounded-lg hover:bg-muted text-muted-foreground">
 <MoreVertical className="w-4 h-4" />
 </Button>
 </div>
 <p className="text-[10px] font-bold text-muted-foreground truncate">{user.email}</p>
 
 <div className="flex flex-wrap gap-2 mt-6">
 <Badge className={cn("text-[8px] font-bold tracking-[0.2em] px-3 py-1 rounded-xl border-none shadow-sm", getRoleConfig(user.role || 'USER').color)}>
 {getRoleConfig(user.role || 'USER').label}
 </Badge>
 {user.status === 'ACTIVE' ? <Badge className="bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border-none text-[8px] font-bold tracking-[0.2em] px-3 py-1 shadow-sm">{t("admin_users_activesignal")}</Badge> : <Badge className="bg-muted text-muted-foreground border-none text-[8px] font-bold tracking-[0.2em] px-3 py-1">{t("admin_users_offline")}</Badge>}
 </div>
 </div>
 </div>

 <div className="mt-8 pt-8 border-t border-border flex items-center justify-between">
 <div className="flex items-center gap-6">
 <Button variant="ghost" size="sm" onClick={e => {
 e.stopPropagation();
 setSelectedUser(user);
 setEditOpen(true);
 }} className="text-[9px] font-bold text-muted-foreground hover:text-primary tracking-[0.2em] h-8 px-0 gap-2 transition-colors">
 <Edit className="w-3 h-3" />{t("admin_users_reconfig")}</Button>
 <Button variant="ghost" size="sm" onClick={e => {
 e.stopPropagation();
 handleToggleStatus(user);
 }} className={cn("text-[9px] font-bold tracking-[0.2em] h-8 px-0 gap-2 transition-colors", user.status === 'ACTIVE' ?"text-muted-foreground hover:text-red-500" :"text-muted-foreground hover:text-emerald-500")}>
 <UserCheck className="w-3 h-3" /> {user.status === 'ACTIVE' ? t('admin_users_kill_signal', 'SİNYALİ KES') : t('admin_users_awaken', 'UYANDIR')}
 </Button>
 </div>
 
 <Button variant="ghost" size="icon" onClick={e => {
 e.stopPropagation();
 handleDelete(user.id);
 }} className="h-10 w-10 rounded-xl hover:bg-red-500/10 text-muted-foreground/30 hover:text-red-500 transition-all border border-transparent hover:border-red-500/20">
 <Trash2 className="w-4 h-4" />
 </Button>
 </div>
 </Card>
 </motion.div>)}
 </AnimatePresence>
 </div>

 {/* Empty State Overlay */}
 {users.length === 0 && <div className="min-h-[400px] bg-muted/10 border-2 border-dashed border-border rounded-[40px] flex flex-col items-center justify-center space-y-6 opacity-60 mx-4">
 <div className="h-24 w-24 rounded-3xl bg-background border border-border flex items-center justify-center shadow-inner">
 <UsersIcon className="w-10 h-10 text-muted-foreground" />
 </div>
 <p className="text-[10px] font-bold text-muted-foreground tracking-[0.3em]">{t("admin_users_awaiting_identity_node_broadcast")}</p>
 </div>}
 </div>

 {/* Initialize Dialog Hub */}
 <Dialog open={createOpen} onOpenChange={setCreateOpen}>
 <DialogContent className="bg-card border-border border-l-2 border-t-2 shadow-3xl text-foreground rounded-4xl p-0 overflow-hidden max-w-xl">
 <form onSubmit={handleCreate}>
 <div className="p-10 space-y-12">
 <DialogHeader>
 <DialogTitle className="text-3xl font-bold text-foreground leading-none">{t("admin_users_initialize_entity")}</DialogTitle>
 <DialogDescription className="text-[10px] font-bold text-muted-foreground tracking-[0.2em] mt-2">{t("admin_users_provisioning_new_identity_node")}</DialogDescription>
 </DialogHeader>
 
 <div className="space-y-8">
 <div className="space-y-3">
 <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin_users_full_identity_alias")}</Label>
 <Input name="name" required className="h-14 bg-background/40 border-border rounded-xl text-foreground pl-4 font-bold focus:ring-primary/20" placeholder={t("admin_users_coreident01")} />
 </div>
 <div className="space-y-3">
 <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin_users_network_comm_link_email")}</Label>
 <Input name="email" type="email" required className="h-14 bg-background/40 border-border rounded-xl text-foreground pl-4 font-bold focus:ring-primary/20" placeholder={t("admin_users_nodenexuscom")} />
 </div>
 <div className="grid grid-cols-2 gap-6">
 <div className="space-y-3">
 <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin_users_role_hierarchies")}</Label>
 <Select name="role" defaultValue="AGENT">
 <SelectTrigger className="h-14 bg-background/40 border-border rounded-xl text-foreground font-bold text-[10px] focus:ring-primary/20">
 <SelectValue placeholder={t("admin_users_nodeclass")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border rounded-xl">
 <SelectItem value="ADMIN" className="font-bold text-[10px]">{t("admin_users_coreadmin")}</SelectItem>
 <SelectItem value="AGENT" className="font-bold text-[10px]">{t("admin_users_fieldagent")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-3">
 <Label className="text-[10px] font-bold text-muted-foreground ml-1">{t("admin_users_initial_pulse_state")}</Label>
 <Select name="status" defaultValue="ACTIVE">
 <SelectTrigger className="h-14 bg-background/40 border-border rounded-xl text-foreground font-bold text-[10px] focus:ring-primary/20">
 <SelectValue placeholder={t("admin_users_pulsestate")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border rounded-xl">
 <SelectItem value="ACTIVE" className="font-bold text-[10px]">{t("admin_users_awakened")}</SelectItem>
 <SelectItem value="INACTIVE" className="font-bold text-[10px]">{t("admin_users_dormant")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 </div>
 </div>
 
 <footer className="p-8 bg-muted/20 border-t border-border flex gap-4">
 <Button type="button" variant="ghost" onClick={() => setCreateOpen(false)} className="h-12 flex-1 rounded-xl text-[10px] font-bold text-muted-foreground tracking-[0.2em] hover:text-foreground transition-all">{t("admin_users_abort_cycle")}</Button>
 <Button type="submit" className="h-12 flex-1 rounded-xl bg-primary hover:bg-primary/90 text-primary-foreground font-bold text-[10px] tracking-[0.2em] shadow-xl shadow-primary/20 transition-all">{t("admin_users_push_node")}<ChevronRight className="w-3 h-3 ml-2" />
 </Button>
 </footer>
 </form>
 </DialogContent>
 </Dialog>
 </PageShell>;
}