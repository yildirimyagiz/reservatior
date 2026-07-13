"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Plus, User, Edit, Trash2, Mail, Phone, ShieldCheck, AlertCircle, CheckCircle, Search } from 'lucide-react';
import { Button } from"@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { apiClient } from '@/lib/api';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogDescription, DialogFooter } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Badge } from"@/components/ui/badge";
import { Textarea } from"@/components/ui/textarea";
import { Avatar, AvatarFallback, AvatarImage } from"@/components/ui/avatar";
import { useState } from 'react';
import { useCountryGuard } from '@/lib/hooks/useCountryGuard';

interface Tenant {
 id: string;
 orgId: string;
 userId?: string;
 name: string;
 email: string;
 phone?: string;
 dateOfBirth?: string;
 nationality?: string;
 idNumber?: string;
 idType?: string;
 employmentStatus?: string;
 monthlyIncome?: number;
 creditScore?: number;
 reliabilityScore?: number;
 verificationStatus: 'PENDING' | 'VERIFIED' | 'FAILED';
 notes?: string;
 createdAt: string;
 updatedAt: string;
 user?: {
 id: string;
 avatar?: string;
 };
}

const TenantManagement = () => {
 const { t } = useTranslation();
 const { isFieldAllowed } = useCountryGuard(undefined);
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingItem, setEditingItem] = useState<Tenant | null>(null);
 const [searchQuery, setSearchQuery] = useState('');
 const [verificationFilter, setVerificationFilter] = useState<string>('ALL');
 const [newItem, setNewItem] = useState({ 
 name: '', 
 email: '', 
 phone: '', 
 dateOfBirth: '',
 nationality: '',
 idNumber: '',
 idType: 'PASSPORT',
 employmentStatus: '',
 monthlyIncome: '',
 creditScore: '',
 verificationStatus: 'PENDING',
 notes: ''
 });

 const { data: tenantsRes, isLoading } = useQuery({
 queryKey: ['admin-tenants'],
 queryFn: async () => {
 const res: any = await apiClient.get('/tenant');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/tenant', data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-tenants'] });
 setIsAddModalOpen(false);
 setNewItem({ 
 name: '', 
 email: '', 
 phone: '', 
 dateOfBirth: '',
 nationality: '',
 idNumber: '',
 idType: 'PASSPORT',
 employmentStatus: '',
 monthlyIncome: '',
 creditScore: '',
 verificationStatus: 'PENDING',
 notes: ''
 });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/tenant/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-tenants'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/tenant/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-tenants'] });
 setIsEditModalOpen(false);
 setEditingItem(null);
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate({
 ...newItem,
 monthlyIncome: newItem.monthlyIncome ? parseFloat(newItem.monthlyIncome) : null,
 creditScore: newItem.creditScore ? parseInt(newItem.creditScore) : null
 });
 };

 const handleEditSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 if (editingItem) {
 updateMutation.mutate(editingItem);
 }
 };

 const openEditModal = (item: Tenant) => {
 setEditingItem(item);
 setIsEditModalOpen(true);
 };

 const getVerificationBadge = (status: string) => {
 const statusConfig: Record<string, { icon: any; color: string; label: string }> = {
 'PENDING': { icon: AlertCircle, color: 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20', label: t('admin_tenant_pending', 'Pending') },
 'VERIFIED': { icon: CheckCircle, color: 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20', label: t('admin_tenant_verified', 'Verified') },
 'FAILED': { icon: AlertCircle, color: 'bg-red-500/10 text-red-400 border-red-500/20', label: t('admin_tenant_failed', 'Failed') }
 };
 const config = statusConfig[status] || statusConfig['PENDING'];
 const Icon = config.icon;
 return (
 <Badge className={config.color}>
 <Icon className="w-3 h-3 mr-1" />
 {config.label}
 </Badge>
 );
 };

 const tenants = tenantsRes?.data || [];
 
 const filteredTenants = tenants.filter((item: Tenant) => {
 const matchesSearch = item.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
 item.email.toLowerCase().includes(searchQuery.toLowerCase());
 const matchesFilter = verificationFilter === 'ALL' || item.verificationStatus === verificationFilter;
 return matchesSearch && matchesFilter;
 });

 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
 {t("admin_tenant_title","Tenant Management")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_tenant_subtitle","Manage tenant profiles and verification status")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-white/10">
 {t("common.export","Export")}
 </Button>
 <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
 <DialogTrigger asChild>
 <Button className="bg-slate-600 hover:bg-muted0 text-white">
 <Plus className="w-4 h-4 mr-2" />
 {t("common.add","Add Tenant")}
 </Button>
 </DialogTrigger>
 <DialogContent className="bg-card border-border text-foreground max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_tenant_add_title","Add New Tenant")}</DialogTitle>
 <DialogDescription>{t("admin_tenant_add_desc","Create a new tenant profile")}</DialogDescription>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_tenant_name","Full Name")}</Label>
 <Input 
 value={newItem.name} 
 onChange={(e) => setNewItem({...newItem, name: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_email","Email")}</Label>
 <Input 
 type="email"
 value={newItem.email} 
 onChange={(e) => setNewItem({...newItem, email: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_tenant_phone","Phone")}</Label>
 <Input 
 value={newItem.phone} 
 onChange={(e) => setNewItem({...newItem, phone: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_dob","Date of Birth")}</Label>
 <Input 
 type="date"
 value={newItem.dateOfBirth} 
 onChange={(e) => setNewItem({...newItem, dateOfBirth: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_tenant_nationality","Nationality")}</Label>
 <Input 
 value={newItem.nationality} 
 onChange={(e) => setNewItem({...newItem, nationality: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_id_type","ID Type")}</Label>
 <Select value={newItem.idType} onValueChange={(v) => setNewItem({...newItem, idType: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="PASSPORT">{t("admin_tenant_passport","Passport")}</SelectItem>
 <SelectItem value="NATIONAL_ID">{t("admin_tenant_national_id","National ID")}</SelectItem>
 <SelectItem value="DRIVERS_LICENSE">{t("admin_tenant_drivers_license","Driver's License")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_id_number","ID Number")}</Label>
 <Input 
 value={newItem.idNumber} 
 onChange={(e) => setNewItem({...newItem, idNumber: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_tenant_employment","Employment Status")}</Label>
 <Input 
 value={newItem.employmentStatus} 
 onChange={(e) => setNewItem({...newItem, employmentStatus: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_monthly_income","Monthly Income")}</Label>
 <Input 
 type="number"
 value={newItem.monthlyIncome} 
 onChange={(e) => setNewItem({...newItem, monthlyIncome: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_tenant_credit_score","Credit Score")}</Label>
 <Input 
 type="number"
 value={newItem.creditScore} 
 onChange={(e) => setNewItem({...newItem, creditScore: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_verification","Verification Status")}</Label>
 <Select value={newItem.verificationStatus} onValueChange={(v) => setNewItem({...newItem, verificationStatus: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="PENDING">{t("admin_tenant_pending","Pending")}</SelectItem>
 <SelectItem value="VERIFIED">{t("admin_tenant_verified","Verified")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_tenant_failed","Failed")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_notes","Notes")}</Label>
 <Textarea 
 value={newItem.notes} 
 onChange={(e) => setNewItem({...newItem, notes: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_tenant_notes_placeholder","Optional notes")}
 rows={3}
 />
 </div>
 </form>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsAddModalOpen(false)} className="bg-card border-border">
 {t("common.cancel","Cancel")}
 </Button>
 <Button onClick={handleAddSubmit} className="bg-slate-600 hover:bg-muted0 text-white">
 {t("common.save","Save")}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </div>

 {/* Filters Section */}
 <div className="flex gap-4">
 <div className="relative flex-1 max-w-md">
 <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500" />
 <Input
 placeholder={t("common.search","Search...")}
 value={searchQuery}
 onChange={(e) => setSearchQuery(e.target.value)}
 className="pl-10 bg-card border-border"
 />
 </div>
 <Select value={verificationFilter} onValueChange={setVerificationFilter}>
 <SelectTrigger className="w-40 bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="ALL">{t("common.all","All")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_tenant_pending","Pending")}</SelectItem>
 <SelectItem value="VERIFIED">{t("admin_tenant_verified","Verified")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_tenant_failed","Failed")}</SelectItem>
 </SelectContent>
 </Select>
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2">
 <User className="w-5 h-5" />
 {t("admin_tenant_list_title","Tenant Profiles")}
 </CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="text-center py-8 text-slate-500">{t("common.loading","Loading...")}</div>
 ) : filteredTenants.length === 0 ? (
 <div className="text-center py-8 text-slate-500">{t("admin_tenant_empty","No tenants found")}</div>
 ) : (
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_tenant_name","Name")}</TableHead>
 <TableHead>{t("admin_tenant_contact","Contact")}</TableHead>
 <TableHead>{t("admin_tenant_id_info","ID Info")}</TableHead>
 <TableHead>{t("admin_tenant_employment","Employment")}</TableHead>
 <TableHead>{t("admin_tenant_reliability","Reliability")}</TableHead>
 <TableHead>{t("admin_tenant_verification","Verification")}</TableHead>
 <TableHead className="text-right">{t("common.actions","Actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredTenants.map((item: Tenant) => (
 <TableRow key={item.id}>
 <TableCell className="font-medium">
 <div className="flex items-center gap-3">
 <Avatar>
 <AvatarImage src={item.user?.avatar} />
 <AvatarFallback>{item.name.charAt(0)}</AvatarFallback>
 </Avatar>
 <div>
 <div className="font-medium">{item.name}</div>
 <div className="text-xs text-slate-500">{item.nationality || '-'}</div>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <div className="space-y-1">
 <div className="flex items-center gap-1 text-sm">
 <Mail className="w-3 h-3 text-slate-500" />
 {item.email}
 </div>
 {item.phone && (
 <div className="flex items-center gap-1 text-sm text-slate-500">
 <Phone className="w-3 h-3" />
 {item.phone}
 </div>
 )}
 </div>
 </TableCell>
 <TableCell className="text-slate-500">
 <div className="text-sm">
 <div>{item.idType}</div>
 <div className="text-xs">{item.idNumber || '-'}</div>
 </div>
 </TableCell>
 <TableCell className="text-slate-500">
 <div className="text-sm">
 <div>{item.employmentStatus || '-'}</div>
 {item.monthlyIncome && (
 <div className="text-xs">${item.monthlyIncome.toLocaleString()}/mo</div>
 )}
 </div>
 </TableCell>
 <TableCell>
 <div className="space-y-1">
 {item.creditScore && (
 <div className="text-sm">
 <span className="text-slate-500">{t("admin_tenant_credit","Credit")}:</span> {item.creditScore}
 </div>
 )}
 {item.reliabilityScore && (
 <div className="text-sm">
 <span className="text-slate-500">{t("admin_tenant_reliability","Reliability")}:</span> 
 <Badge variant="outline" className="ml-1">{item.reliabilityScore}</Badge>
 </div>
 )}
 </div>
 </TableCell>
 <TableCell>{getVerificationBadge(item.verificationStatus)}</TableCell>
 <TableCell className="text-right">
 <div className="flex justify-end gap-2">
 <Button variant="ghost" size="icon" onClick={() => openEditModal(item)}>
 <Edit className="w-4 h-4" />
 </Button>
 <Button variant="ghost" size="icon" onClick={() => deleteMutation.mutate(item.id)}>
 <Trash2 className="w-4 h-4 text-red-500" />
 </Button>
 </div>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 )}
 </CardContent>
 </Card>

 {/* Edit Modal */}
 <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
 <DialogContent className="bg-card border-border text-foreground max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_tenant_edit_title","Edit Tenant")}</DialogTitle>
 <DialogDescription>{t("admin_tenant_edit_desc","Update tenant profile details")}</DialogDescription>
 </DialogHeader>
 {editingItem && (
 <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_tenant_name","Full Name")}</Label>
 <Input 
 value={editingItem.name}
 onChange={(e) => setEditingItem({...editingItem, name: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_email","Email")}</Label>
 <Input 
 type="email"
 value={editingItem.email}
 onChange={(e) => setEditingItem({...editingItem, email: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_tenant_phone","Phone")}</Label>
 <Input 
 value={editingItem.phone || ''}
 onChange={(e) => setEditingItem({...editingItem, phone: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_verification","Verification Status")}</Label>
 <Select value={editingItem.verificationStatus} onValueChange={(v) => setEditingItem({...editingItem, verificationStatus: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="PENDING">{t("admin_tenant_pending","Pending")}</SelectItem>
 <SelectItem value="VERIFIED">{t("admin_tenant_verified","Verified")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_tenant_failed","Failed")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_tenant_monthly_income","Monthly Income")}</Label>
 <Input 
 type="number"
 value={editingItem.monthlyIncome || ''}
 onChange={(e) => setEditingItem({...editingItem, monthlyIncome: parseFloat(e.target.value)})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_credit_score","Credit Score")}</Label>
 <Input 
 type="number"
 value={editingItem.creditScore || ''}
 onChange={(e) => setEditingItem({...editingItem, creditScore: parseInt(e.target.value)})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_tenant_notes","Notes")}</Label>
 <Textarea 
 value={editingItem.notes || ''}
 onChange={(e) => setEditingItem({...editingItem, notes: e.target.value})}
 className="bg-card border-border"
 rows={3}
 />
 </div>
 </form>
 )}
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsEditModalOpen(false)} className="bg-card border-border">
 {t("common.cancel","Cancel")}
 </Button>
 <Button onClick={handleEditSubmit} className="bg-slate-600 hover:bg-muted0 text-white">
 {t("common.save","Save")}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 );
};

export default TenantManagement;
