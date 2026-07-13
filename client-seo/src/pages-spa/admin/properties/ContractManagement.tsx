"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Plus, FileText, Edit, Trash2, Calendar, DollarSign, User, AlertCircle, CheckCircle, Clock, Search } from 'lucide-react';
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
import { useState } from 'react';
import { useCountryGuard } from '@/lib/hooks/useCountryGuard';

interface Contract {
 id: string;
 orgId: string;
 propertyId: string;
 type: 'LEASE' | 'SALE' | 'SERVICE' | 'MAINTENANCE' | 'MANAGEMENT';
 status: 'DRAFT' | 'ACTIVE' | 'EXPIRED' | 'TERMINATED' | 'PENDING_SIGNATURE';
 startDate: string;
 endDate?: string;
 value?: number;
 currency?: string;
 parties: string[];
 terms?: string;
 signedAt?: string;
 expiresAt?: string;
 autoRenew: boolean;
 noticePeriod?: number;
 createdAt: string;
 updatedAt: string;
 property?: {
 id: string;
 name: string;
 addressLine1: string;
 };
}

const ContractManagement = () => {
 const { t } = useTranslation();
 const { isFieldAllowed } = useCountryGuard(undefined);
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingItem, setEditingItem] = useState<Contract | null>(null);
 const [searchQuery, setSearchQuery] = useState('');
 const [statusFilter, setStatusFilter] = useState<string>('ALL');
 const [newItem, setNewItem] = useState({ 
 propertyId: '', 
 type: 'LEASE', 
 status: 'DRAFT', 
 startDate: '', 
 endDate: '', 
 value: '', 
 currency: 'USD',
 parties: '',
 terms: '',
 autoRenew: false,
 noticePeriod: ''
 });

 const { data: contractsRes, isLoading } = useQuery({
 queryKey: ['admin-contracts'],
 queryFn: async () => {
 const res: any = await apiClient.get('/contract');
 return res.data;
 }
 });

 const { data: propertiesRes } = useQuery({
 queryKey: ['admin-properties'],
 queryFn: async () => {
 const res: any = await apiClient.get('/property');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/contract', data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-contracts'] });
 setIsAddModalOpen(false);
 setNewItem({ 
 propertyId: '', 
 type: 'LEASE', 
 status: 'DRAFT', 
 startDate: '', 
 endDate: '', 
 value: '', 
 currency: 'USD',
 parties: '',
 terms: '',
 autoRenew: false,
 noticePeriod: ''
 });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/contract/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-contracts'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/contract/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-contracts'] });
 setIsEditModalOpen(false);
 setEditingItem(null);
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate({
 ...newItem,
 value: newItem.value ? parseFloat(newItem.value) : null,
 parties: newItem.parties.split(',').map(p => p.trim()).filter(Boolean),
 noticePeriod: newItem.noticePeriod ? parseInt(newItem.noticePeriod) : null
 });
 };

 const handleEditSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 if (editingItem) {
 updateMutation.mutate(editingItem);
 }
 };

 const openEditModal = (item: Contract) => {
 setEditingItem(item);
 setIsEditModalOpen(true);
 };

 const getStatusBadge = (status: string) => {
 const statusConfig: Record<string, { icon: any; color: string; label: string }> = {
 'DRAFT': { icon: Clock, color: 'bg-muted0/10 text-muted-foreground border-slate-500/20', label: t('admin_contract_draft', 'Draft') },
 'ACTIVE': { icon: CheckCircle, color: 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20', label: t('admin_contract_active', 'Active') },
 'EXPIRED': { icon: AlertCircle, color: 'bg-red-500/10 text-red-400 border-red-500/20', label: t('admin_contract_expired', 'Expired') },
 'TERMINATED': { icon: AlertCircle, color: 'bg-red-500/10 text-red-400 border-red-500/20', label: t('admin_contract_terminated', 'Terminated') },
 'PENDING_SIGNATURE': { icon: Clock, color: 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20', label: t('admin_contract_pending_signature', 'Pending Signature') }
 };
 const config = statusConfig[status] || statusConfig['DRAFT'];
 const Icon = config.icon;
 return (
 <Badge className={config.color}>
 <Icon className="w-3 h-3 mr-1" />
 {config.label}
 </Badge>
 );
 };

 const getTypeBadge = (type: string) => {
 const typeConfig: Record<string, { color: string; label: string }> = {
 'LEASE': { color: 'bg-blue-500/10 text-blue-400 border-blue-500/20', label: t('admin_contract_lease', 'Lease') },
 'SALE': { color: 'bg-orange-500/10 text-orange-400 border-orange-500/20', label: t('admin_contract_sale', 'Sale') },
 'SERVICE': { color: 'bg-purple-500/10 text-purple-400 border-purple-500/20', label: t('admin_contract_service', 'Service') },
 'MAINTENANCE': { color: 'bg-green-500/10 text-green-400 border-green-500/20', label: t('admin_contract_maintenance', 'Maintenance') },
 'MANAGEMENT': { color: 'bg-cyan-500/10 text-cyan-400 border-cyan-500/20', label: t('admin_contract_management', 'Management') }
 };
 const config = typeConfig[type] || typeConfig['LEASE'];
 return <Badge className={config.color}>{config.label}</Badge>;
 };

 const contracts = contractsRes?.data || [];
 const properties = propertiesRes?.data || [];
 
 const filteredContracts = contracts.filter((item: Contract) => {
 const matchesSearch = item.property?.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
 item.type.toLowerCase().includes(searchQuery.toLowerCase());
 const matchesFilter = statusFilter === 'ALL' || item.status === statusFilter;
 return matchesSearch && matchesFilter;
 });

 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
 {t("admin_contract_title","Contract Management")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_contract_subtitle","Manage property contracts and agreements")}
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
 {t("common.add","Add Contract")}
 </Button>
 </DialogTrigger>
 <DialogContent className="bg-card border-border text-foreground max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_contract_add_title","Add New Contract")}</DialogTitle>
 <DialogDescription>{t("admin_contract_add_desc","Create a new contract agreement")}</DialogDescription>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_contract_property","Property")}</Label>
 <Select value={newItem.propertyId} onValueChange={(v) => setNewItem({...newItem, propertyId: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_contract_select_property","Select property")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 {properties.map((p: any) => (
 <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_contract_type","Contract Type")}</Label>
 <Select value={newItem.type} onValueChange={(v) => setNewItem({...newItem, type: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="LEASE">{t("admin_contract_lease","Lease")}</SelectItem>
 <SelectItem value="SALE">{t("admin_contract_sale","Sale")}</SelectItem>
 <SelectItem value="SERVICE">{t("admin_contract_service","Service")}</SelectItem>
 <SelectItem value="MAINTENANCE">{t("admin_contract_maintenance","Maintenance")}</SelectItem>
 <SelectItem value="MANAGEMENT">{t("admin_contract_management","Management")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_contract_status","Status")}</Label>
 <Select value={newItem.status} onValueChange={(v) => setNewItem({...newItem, status: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="DRAFT">{t("admin_contract_draft","Draft")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_contract_active","Active")}</SelectItem>
 <SelectItem value="EXPIRED">{t("admin_contract_expired","Expired")}</SelectItem>
 <SelectItem value="TERMINATED">{t("admin_contract_terminated","Terminated")}</SelectItem>
 <SelectItem value="PENDING_SIGNATURE">{t("admin_contract_pending_signature","Pending Signature")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_contract_value","Contract Value")}</Label>
 <div className="flex gap-2">
 <Input 
 type="number" 
 value={newItem.value} 
 onChange={(e) => setNewItem({...newItem, value: e.target.value})}
 className="bg-card border-border flex-1"
 />
 <Select value={newItem.currency} onValueChange={(v) => setNewItem({...newItem, currency: v})}>
 <SelectTrigger className="bg-card border-border w-24">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="USD">USD</SelectItem>
 <SelectItem value="EUR">EUR</SelectItem>
 <SelectItem value="GBP">GBP</SelectItem>
 <SelectItem value="TRY">TRY</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_contract_start_date","Start Date")}</Label>
 <Input 
 type="date" 
 value={newItem.startDate} 
 onChange={(e) => setNewItem({...newItem, startDate: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_contract_end_date","End Date")}</Label>
 <Input 
 type="date" 
 value={newItem.endDate} 
 onChange={(e) => setNewItem({...newItem, endDate: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_contract_parties","Parties (comma-separated)")}</Label>
 <Input 
 value={newItem.parties} 
 onChange={(e) => setNewItem({...newItem, parties: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_contract_parties_placeholder","e.g. John Doe, Jane Smith")}
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_contract_notice_period","Notice Period (days)")}</Label>
 <Input 
 type="number" 
 value={newItem.noticePeriod} 
 onChange={(e) => setNewItem({...newItem, noticePeriod: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="flex items-center gap-2 pt-6">
 <input 
 type="checkbox" 
 id="autoRenew"
 checked={newItem.autoRenew}
 onChange={(e) => setNewItem({...newItem, autoRenew: e.target.checked})}
 className="rounded"
 />
 <Label htmlFor="autoRenew">{t("admin_contract_auto_renew","Auto Renew")}</Label>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_contract_terms","Terms and Conditions")}</Label>
 <Textarea 
 value={newItem.terms} 
 onChange={(e) => setNewItem({...newItem, terms: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_contract_terms_placeholder","Contract terms and conditions")}
 rows={4}
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
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-40 bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="ALL">{t("common.all","All")}</SelectItem>
 <SelectItem value="DRAFT">{t("admin_contract_draft","Draft")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_contract_active","Active")}</SelectItem>
 <SelectItem value="EXPIRED">{t("admin_contract_expired","Expired")}</SelectItem>
 <SelectItem value="TERMINATED">{t("admin_contract_terminated","Terminated")}</SelectItem>
 <SelectItem value="PENDING_SIGNATURE">{t("admin_contract_pending_signature","Pending Signature")}</SelectItem>
 </SelectContent>
 </Select>
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2">
 <FileText className="w-5 h-5" />
 {t("admin_contract_list_title","Contract Agreements")}
 </CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="text-center py-8 text-slate-500">{t("common.loading","Loading...")}</div>
 ) : filteredContracts.length === 0 ? (
 <div className="text-center py-8 text-slate-500">{t("admin_contract_empty","No contracts found")}</div>
 ) : (
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_contract_property","Property")}</TableHead>
 <TableHead>{t("admin_contract_type","Type")}</TableHead>
 <TableHead>{t("admin_contract_status","Status")}</TableHead>
 <TableHead>{t("admin_contract_value","Value")}</TableHead>
 <TableHead>{t("admin_contract_period","Period")}</TableHead>
 <TableHead>{t("admin_contract_parties","Parties")}</TableHead>
 <TableHead className="text-right">{t("common.actions","Actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredContracts.map((item: Contract) => (
 <TableRow key={item.id}>
 <TableCell className="font-medium">{item.property?.name || '-'}</TableCell>
 <TableCell>{getTypeBadge(item.type)}</TableCell>
 <TableCell>{getStatusBadge(item.status)}</TableCell>
 <TableCell>
 {item.value ? (
 <div className="flex items-center gap-1">
 <DollarSign className="w-4 h-4" />
 {item.value.toLocaleString()} {item.currency}
 </div>
 ) : '-'}
 </TableCell>
 <TableCell className="text-slate-500">
 <div className="flex items-center gap-1">
 <Calendar className="w-3 h-3" />
 {new Date(item.startDate).toLocaleDateString()}
 {item.endDate && ` - ${new Date(item.endDate).toLocaleDateString()}`}
 </div>
 </TableCell>
 <TableCell className="text-slate-500">
 <div className="flex items-center gap-1">
 <User className="w-3 h-3" />
 {item.parties.length} {t("admin_contract_parties_count","parties")}
 </div>
 </TableCell>
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
 <DialogTitle>{t("admin_contract_edit_title","Edit Contract")}</DialogTitle>
 <DialogDescription>{t("admin_contract_edit_desc","Update contract details")}</DialogDescription>
 </DialogHeader>
 {editingItem && (
 <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_contract_status","Status")}</Label>
 <Select value={editingItem.status} onValueChange={(v) => setEditingItem({...editingItem, status: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="DRAFT">{t("admin_contract_draft","Draft")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_contract_active","Active")}</SelectItem>
 <SelectItem value="EXPIRED">{t("admin_contract_expired","Expired")}</SelectItem>
 <SelectItem value="TERMINATED">{t("admin_contract_terminated","Terminated")}</SelectItem>
 <SelectItem value="PENDING_SIGNATURE">{t("admin_contract_pending_signature","Pending Signature")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_contract_value","Contract Value")}</Label>
 <Input 
 type="number"
 value={editingItem.value || ''}
 onChange={(e) => setEditingItem({...editingItem, value: parseFloat(e.target.value)})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_contract_end_date","End Date")}</Label>
 <Input 
 type="date"
 value={editingItem.endDate || ''}
 onChange={(e) => setEditingItem({...editingItem, endDate: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="flex items-center gap-2 pt-6">
 <input 
 type="checkbox" 
 id="editAutoRenew"
 checked={editingItem.autoRenew}
 onChange={(e) => setEditingItem({...editingItem, autoRenew: e.target.checked})}
 className="rounded"
 />
 <Label htmlFor="editAutoRenew">{t("admin_contract_auto_renew","Auto Renew")}</Label>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_contract_terms","Terms and Conditions")}</Label>
 <Textarea 
 value={editingItem.terms || ''}
 onChange={(e) => setEditingItem({...editingItem, terms: e.target.value})}
 className="bg-card border-border"
 rows={4}
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

export default ContractManagement;
