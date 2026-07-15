"use client";

import { useToast } from"@/hooks/use-toast";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Building2, Plus, Users, Globe, Settings, Edit, Trash2 } from 'lucide-react';
import { Button } from"@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { useState } from 'react';
import { apiClient } from"@/lib/api";

const AgenciesManagement = () => {
 const { t } = useTranslation();
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [newAgency, setNewAgency] = useState<any>({ name: '', email: '', phoneNumber: '', status: 'ACTIVE', website: '' });
 const { toast } = useToast();
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingId, setEditingId] = useState<string | null>(null);

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/agency/${editingId}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-agencies'] });
 setIsEditModalOpen(false);
 setEditingId(null);
 setNewAgency({ name: '', email: '', phoneNumber: '', status: 'ACTIVE', website: '' });
 toast({ title:"Success", description:"Agency updated successfully" });
 }
 });

 const handleEditClick = (agency: any) => {
 setEditingId(agency.id);
 setNewAgency({
 name: agency.name || '',
 email: agency.email || '',
 phoneNumber: agency.phoneNumber || '',
 status: agency.status || 'ACTIVE',
 website: agency.website || ''
 });
 setIsEditModalOpen(true);
 };


 const { data: agenciesRes, isLoading } = useQuery({
 queryKey: ['admin-agencies'],
 queryFn: async () => {
 const res: any = await apiClient.get('/agency');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/agency', { 
 ...data, 
 organizationId: 'org_1'
 });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-agencies'] });
 setIsAddModalOpen(false);
 setNewAgency({ name: '', email: '', phoneNumber: '' });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/agency/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-agencies'] });
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate(newAgency);
 };

 const agencies = agenciesRes?.data || [];
 
 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
 {t("admin_agencies_title","Agencies Management")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_agencies_subtitle","Manage real estate agencies, brokerage firms, and corporate accounts")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-white/10">
 <Globe className="w-4 h-4 mr-2" />
 {t("common.export","Export")}
 </Button>
 <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
 <DialogTrigger asChild>
 <Button className="bg-slate-600 hover:bg-slate-700 text-foreground shadow-lg shadow-slate-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_agencies_add","Add Agency")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_agencies_add","Add Agency")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="name">{t("admin_auto_agency_name", "Agency Name")}</Label>
 <Input 
 id="name" 
 className="bg-card border-border" 
 value={newAgency.name}
 onChange={e => setNewAgency({...newAgency, name: e.target.value})}
 required
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="email">{t("admin_auto_email", "Email")}</Label>
 <Input 
 id="email" 
 type="email"
 className="bg-card border-border" 
 value={newAgency.email}
 onChange={e => setNewAgency({...newAgency, email: e.target.value})}
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="phoneNumber">{t("admin_auto_phone_number", "Phone Number")}</Label>
 <Input 
 id="phoneNumber" 
 className="bg-card border-border" 
 value={newAgency.phoneNumber}
 onChange={e => setNewAgency({...newAgency, phoneNumber: e.target.value})}
 />
 </div>
 
 <div className="space-y-2">
 <Label htmlFor="website">{t("admin_auto_website", "Website")}</Label>
 <Input 
 id="website" 
 className="bg-card border-border" 
 value={newAgency.website || ''}
 onChange={e => setNewAgency({...newAgency, website: e.target.value})}
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_auto_status", "Status")}</Label>
 <Select value={newAgency.status} onValueChange={v => setNewAgency({...newAgency, status: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_auto_select_status", "Select status")} />
 </SelectTrigger>
 <SelectContent className="bg-background border-border text-foreground">
 <SelectItem value="PENDING">{t("admin_ai_pending", "Pending")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_ai_active", "Active")}</SelectItem>
 <SelectItem value="INACTIVE">{t("admin_ai_inactive", "Inactive")}</SelectItem>
 <SelectItem value="SUSPENDED">{t("admin_organization_suspended", "Suspended")}</SelectItem>
 </SelectContent>
 </Select>
 </div>

 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsAddModalOpen(false)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button type="submit" className="bg-slate-600 hover:bg-slate-700" disabled={createMutation.isPending}>
 {createMutation.isPending ?"Saving..." :"Create Agency"}
 </Button>
 </div>
 </form>
 </DialogContent>
 </Dialog>

 <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_agencies_edit","Edit Agency")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={(e) => { e.preventDefault(); updateMutation.mutate(newAgency); }} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="edit-name">{t("admin_auto_agency_name", "Agency Name")}</Label>
 <Input id="edit-name" className="bg-card border-border" value={newAgency.name} onChange={e => setNewAgency({...newAgency, name: e.target.value})} required />
 </div>
 <div className="space-y-2">
 <Label htmlFor="edit-email">{t("admin_auto_email", "Email")}</Label>
 <Input id="edit-email" type="email" className="bg-card border-border" value={newAgency.email} onChange={e => setNewAgency({...newAgency, email: e.target.value})} />
 </div>
 <div className="space-y-2">
 <Label htmlFor="edit-phoneNumber">{t("admin_auto_phone_number", "Phone Number")}</Label>
 <Input id="edit-phoneNumber" className="bg-card border-border" value={newAgency.phoneNumber} onChange={e => setNewAgency({...newAgency, phoneNumber: e.target.value})} />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_auto_status", "Status")}</Label>
 <Select value={newAgency.status} onValueChange={v => setNewAgency({...newAgency, status: v})}>
 <SelectTrigger className="bg-card border-border"><SelectValue placeholder={t("admin_auto_select_status", "Select status")} /></SelectTrigger>
 <SelectContent className="bg-background border-border text-foreground">
 <SelectItem value="PENDING">{t("admin_ai_pending", "Pending")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_ai_active", "Active")}</SelectItem>
 <SelectItem value="INACTIVE">{t("admin_ai_inactive", "Inactive")}</SelectItem>
 <SelectItem value="SUSPENDED">{t("admin_organization_suspended", "Suspended")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsEditModalOpen(false)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button type="submit" className="bg-slate-600 hover:bg-slate-700" disabled={updateMutation.isPending}>
 {updateMutation.isPending ?"Saving..." :"Update Agency"}
 </Button>
 </div>
 </form>
 </DialogContent>
 </Dialog>

 </div>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">{t("client.src.total_agencies", "Total Agencies")}</CardTitle>
 <Building2 className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">124</div>
 <p className="text-xs text-green-400 mt-1">{t("admin_auto_12_this_month", "+12 this month")}</p>
 </CardContent>
 </Card>
 
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">{t("admin_reports_active_agents", "Active Agents")}</CardTitle>
 <Users className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">8,432</div>
 <p className="text-xs text-green-400 mt-1">{t("admin_auto_142_this_month", "+142 this month")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">{t("admin_auto_system_integration", "System Integration")}</CardTitle>
 <Settings className="w-4 h-4 text-amber-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">98%</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_auto_api_health", "API Health")}</p>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_agencies_list","Agency Directory")}</CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("common.loading","Loading data...")}
 </div>
 ) : agencies.length === 0 ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("mobile.auto.no_agencies_found", "No agencies found.")}</div>
 ) : (
 <div className="rounded-xl border border-border">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-slate-300">{t("admin_auto_agency_name", "Agency Name")}</TableHead>
 <TableHead className="text-slate-300">{t("admin_auto_email", "Email")}</TableHead>
 <TableHead className="text-slate-300">{t("admin_auto_phone", "Phone")}</TableHead>
 <TableHead className="text-slate-300">{t("admin_ai_status", "Status")}</TableHead>
 <TableHead className="text-slate-300 text-right">{t("admin_ai_actions", "Actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {agencies.map((a: any) => (
 <TableRow key={a.id} className="border-border hover:bg-card transition-colors">
 <TableCell className="font-medium text-foreground">{a.name}</TableCell>
 <TableCell className="text-muted-foreground">{a.email || 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">{a.phoneNumber || 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">
 <span className="px-2 py-1 bg-card rounded-full text-xs">
 {a.status}
 </span>
 </TableCell>
 <TableCell className="text-right">
 <Button variant="ghost" size="icon" className="text-muted-foreground hover:text-white" onClick={() => handleEditClick(a)}><Edit className="w-4 h-4" /></Button>
 <Button 
 variant="ghost" 
 size="icon" 
 className="text-red-400 hover:text-red-300 hover:bg-red-400/10"
 onClick={() => deleteMutation.mutate(a.id)}
 disabled={deleteMutation.isPending}
 >
 <Trash2 className="w-4 h-4" />
 </Button>
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

export default AgenciesManagement;
