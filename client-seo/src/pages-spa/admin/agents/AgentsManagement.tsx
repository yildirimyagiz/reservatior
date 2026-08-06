"use client";


import React, { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { BadgeCheck, Plus, UserCircle, Star, Target, MoreHorizontal, Edit, Trash2 } from 'lucide-react';
import { Button } from"@/components/ui/button";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

import { useToast } from"@/hooks/use-toast";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { apiClient } from '@/lib/api';

const AgentsManagement = () => {
 const { t } = useTranslation();
 const queryClient = useQueryClient();
 const { toast } = useToast();
 
 const [isInviteOpen, setIsInviteOpen] = useState(false);
 const [isEditOpen, setIsEditOpen] = useState(false);
 const [editingId, setEditingId] = useState<string | null>(null);
 const [formData, setFormData] = useState({ name: '', email: '', role: 'Agent', licenseNumber: '', specialization: '' });

 const { data: agentsRes, isLoading } = useQuery({
 queryKey: ['admin-agents'],
 queryFn: async () => {
 const res: any = await apiClient.get('/agent');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => apiClient.post('/agent', data),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-agents'] });
 setIsInviteOpen(false);
 setFormData({ name: '', email: '', role: 'Agent', licenseNumber: '', specialization: '' });
 toast({ title:"Success", description:"Agent created successfully" });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/agent/${editingId}`, data),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-agents'] });
 setIsEditOpen(false);
 setEditingId(null);
 setFormData({ name: '', email: '', role: 'Agent', licenseNumber: '', specialization: '' });
 toast({ title:"Updated", description:"Agent updated successfully" });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/agent/${id}`),
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-agents'] });
 toast({ title:"Deleted", description:"Agent deleted successfully" });
 }
 });

 const agents = agentsRes?.data || [];

 const openEdit = (a: any) => {
 setEditingId(a.id);
 setFormData({
 name: a.name || '',
 email: a.email || '',
 role: a.role || 'Agent',
 licenseNumber: a.licenseNumber || '',
 specialization: a.specialization || ''
 });
 setIsEditOpen(true);
 };

 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-pink-400">
 {t("admin_agents_title", "Acente Yönetimi")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_agents_subtitle", "Acente performansını, lisanslarını ve durumunu izleyin")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-muted dark:hover:bg-card/10">
 {t("common.export", "Dışa aktar")}
 </Button>
 
 <Dialog open={isInviteOpen} onOpenChange={setIsInviteOpen}>
 <DialogTrigger asChild>
 <Button className="bg-muted hover:bg-muted text-foreground shadow-lg shadow-slate-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_agents_add", "Temsilciyi Davet Et")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background text-foreground border-border">
 <DialogHeader>
 <DialogTitle>{t("admin_agents_add", "Temsilciyi Davet Et")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">{t("admin_auto_enter_the_details_of_the_agent_you_want", "Platforma davet etmek istediğiniz temsilcinin ayrıntılarını girin.")}</DialogDescription>
 </DialogHeader>
 <form onSubmit={e => { e.preventDefault(); createMutation.mutate(formData); }} className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="name" className="text-right text-muted-foreground">{t("admin_auto_name", "İsim")}</Label>
 <Input id="name" required value={formData.name} onChange={(e) => setFormData({...formData, name: e.target.value})} className="col-span-3 bg-card border-border text-foreground" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="email" className="text-right text-muted-foreground">{t("admin_auto_email", "E-posta")}</Label>
 <Input id="email" type="email" required value={formData.email} onChange={(e) => setFormData({...formData, email: e.target.value})} className="col-span-3 bg-card border-border text-foreground" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="license" className="text-right text-muted-foreground">{t("admin_auto_license", "Lisans")}</Label>
 <Input id="license" value={formData.licenseNumber} onChange={(e) => setFormData({...formData, licenseNumber: e.target.value})} className="col-span-3 bg-card border-border text-foreground" />
 </div>
 <DialogFooter className="mt-4">
 <Button type="button" variant="outline" className="bg-transparent border-border text-foreground hover:bg-card" onClick={() => setIsInviteOpen(false)}>{t("admin_action_cancel", "İptal")}</Button>
 <Button type="submit" disabled={createMutation.isPending} className="bg-muted hover:bg-muted text-foreground">{createMutation.isPending ? 'Saving...' : 'Send Invitation'}</Button>
 </DialogFooter>
 </form>
 </DialogContent>
 </Dialog>

 <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
 <DialogContent className="sm:max-w-[425px] bg-background text-foreground border-border">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_edit_agent", "Temsilciyi Düzenle")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={e => { e.preventDefault(); updateMutation.mutate(formData); }} className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-name" className="text-right text-muted-foreground">{t("admin_auto_name", "İsim")}</Label>
 <Input id="edit-name" required value={formData.name} onChange={(e) => setFormData({...formData, name: e.target.value})} className="col-span-3 bg-card border-border text-foreground" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-email" className="text-right text-muted-foreground">{t("admin_auto_email", "E-posta")}</Label>
 <Input id="edit-email" type="email" required value={formData.email} onChange={(e) => setFormData({...formData, email: e.target.value})} className="col-span-3 bg-card border-border text-foreground" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-license" className="text-right text-muted-foreground">{t("admin_auto_license", "Lisans")}</Label>
 <Input id="edit-license" value={formData.licenseNumber} onChange={(e) => setFormData({...formData, licenseNumber: e.target.value})} className="col-span-3 bg-card border-border text-foreground" />
 </div>
 <DialogFooter className="mt-4">
 <Button type="button" variant="outline" className="bg-transparent border-border text-foreground hover:bg-card" onClick={() => setIsEditOpen(false)}>{t("admin_action_cancel", "İptal")}</Button>
 <Button type="submit" disabled={updateMutation.isPending} className="bg-muted hover:bg-muted text-foreground">{updateMutation.isPending ? 'Saving...' : 'Update Agent'}</Button>
 </DialogFooter>
 </form>
 </DialogContent>
 </Dialog>
 </div>
 </div>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_layout_agent_directory", "Danışman Rehberi")}</CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">{t("admin_system_loading", "Yükleniyor...")}</div>
 ) : agents.length === 0 ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">{t("admin_auto_no_agents_found", "Hiçbir temsilci bulunamadı.")}</div>
 ) : (
 <div className="rounded-xl border border-border">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-muted-foreground">{t("admin_ai_name", "Sistem Adı")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_auto_email", "E-posta")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_auto_license", "Lisans")}</TableHead>
 <TableHead className="text-muted-foreground text-right">{t("admin_ai_actions", "İşlemler")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {agents.map((a: any) => (
 <TableRow key={a.id} className="border-border hover:bg-card transition-colors">
 <TableCell className="font-medium text-foreground">{a.name}</TableCell>
 <TableCell className="text-muted-foreground">{a.email}</TableCell>
 <TableCell className="text-muted-foreground">{a.licenseNumber || 'N/A'}</TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0" aria-label={t("common.more")}><MoreHorizontal className="h-4 w-4 text-muted-foreground" /></Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-background border-border text-foreground">
 <DropdownMenuItem onClick={() => openEdit(a)} className="cursor-pointer hover:bg-muted dark:hover:bg-card/10"><Edit className="mr-2 h-4 w-4" /> {t("admin_action_edit", "Düzenle")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => deleteMutation.mutate(a.id)} className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> {t("admin_action_delete", "Sil")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </div>
 )}
 </CardContent>
 </Card>
 </div>
 );
};

export default AgentsManagement;
