"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Plus, FileText, Edit, Trash2, Calendar, DollarSign, User, AlertCircle, CheckCircle } from 'lucide-react';
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

interface Lease {
 id: string;
 orgId: string;
 listingId: string;
 tenantId: string;
 startDate: string;
 endDate: string;
 monthlyRent: number;
 currency: string;
 depositAmount?: number;
 status: 'ACTIVE' | 'PENDING' | 'EXPIRED' | 'TERMINATED';
 paymentFrequency: 'MONTHLY' | 'QUARTERLY' | 'ANNUALLY';
 autoRenew: boolean;
 noticePeriod?: number;
 terms?: string;
 createdAt: string;
 updatedAt: string;
 listing?: {
 id: string;
 title: string;
 property?: {
 id: string;
 name: string;
 addressLine1: string;
 };
 };
 tenant?: {
 id: string;
 name: string;
 email: string;
 };
}

const LeaseManagement = () => {
 const { t } = useTranslation();
 const { isFieldAllowed } = useCountryGuard(undefined);
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingItem, setEditingItem] = useState<Lease | null>(null);
 const [newItem, setNewItem] = useState({ 
 listingId: '', 
 tenantId: '', 
 startDate: '', 
 endDate: '', 
 monthlyRent: '', 
 currency: 'USD',
 depositAmount: '',
 status: 'PENDING',
 paymentFrequency: 'MONTHLY',
 autoRenew: false,
 noticePeriod: '',
 terms: ''
 });

 const { data: leasesRes, isLoading } = useQuery({
 queryKey: ['admin-leases'],
 queryFn: async () => {
 const res: any = await apiClient.get('/lease');
 return res.data;
 }
 });

 const { data: listingsRes } = useQuery({
 queryKey: ['admin-listings'],
 queryFn: async () => {
 const res: any = await apiClient.get('/listing');
 return res.data;
 }
 });

 const { data: tenantsRes } = useQuery({
 queryKey: ['admin-tenants'],
 queryFn: async () => {
 const res: any = await apiClient.get('/tenant');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/lease', data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-leases'] });
 setIsAddModalOpen(false);
 setNewItem({ 
 listingId: '', 
 tenantId: '', 
 startDate: '', 
 endDate: '', 
 monthlyRent: '', 
 currency: 'USD',
 depositAmount: '',
 status: 'PENDING',
 paymentFrequency: 'MONTHLY',
 autoRenew: false,
 noticePeriod: '',
 terms: ''
 });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/lease/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-leases'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/lease/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-leases'] });
 setIsEditModalOpen(false);
 setEditingItem(null);
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate({
 ...newItem,
 monthlyRent: parseFloat(newItem.monthlyRent) || 0,
 depositAmount: newItem.depositAmount ? parseFloat(newItem.depositAmount) : null,
 noticePeriod: newItem.noticePeriod ? parseInt(newItem.noticePeriod) : null
 });
 };

 const handleEditSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 if (editingItem) {
 updateMutation.mutate(editingItem);
 }
 };

 const openEditModal = (item: Lease) => {
 setEditingItem(item);
 setIsEditModalOpen(true);
 };

 const getStatusBadge = (status: string) => {
 const statusConfig: Record<string, { icon: any; color: string; label: string }> = {
 'ACTIVE': { icon: CheckCircle, color: 'bg-blue-500/10 text-success border-blue-500/20', label: t('admin_lease_active', 'Aktif') },
 'PENDING': { icon: AlertCircle, color: 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20', label: t('admin_lease_pending', 'Askıda olması') },
 'EXPIRED': { icon: AlertCircle, color: 'bg-muted0/10 text-muted-foreground border-slate-500/20', label: t('admin_lease_expired', 'Günü geçmiş') },
 'TERMINATED': { icon: AlertCircle, color: 'bg-red-500/10 text-red-400 border-red-500/20', label: t('admin_lease_terminated', 'Feshedildi') }
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

 const leases = leasesRes?.data || [];
 const listings = listingsRes?.data || [];
 const tenants = tenantsRes?.data || [];

 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
 {t("admin_lease_title", "Kira Yönetimi")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_lease_subtitle", "Kira sözleşmelerini ve kiracı sözleşmelerini yönetin")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-muted dark:hover:bg-card/10">
 {t("common.export", "Dışa aktar")}
 </Button>
 <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
 <DialogTrigger asChild>
 <Button className="bg-muted hover:bg-muted0 text-white">
 <Plus className="w-4 h-4 mr-2" />
 {t("common.add", "Ekle")}
 </Button>
 </DialogTrigger>
 <DialogContent className="bg-card border-border text-foreground max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_lease_add_title", "Yeni Kira Ekle")}</DialogTitle>
 <DialogDescription>{t("admin_lease_add_desc", "Yeni bir kira sözleşmesi oluşturun")}</DialogDescription>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_lease_listing", "Listeleme")}</Label>
 <Select value={newItem.listingId} onValueChange={(v) => setNewItem({...newItem, listingId: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_lease_select_listing", "İlanı seçin")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 {listings.map((l: any) => (
 <SelectItem key={l.id} value={l.id}>{l.title || l.property?.name}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_lease_tenant", "Kiracı")}</Label>
 <Select value={newItem.tenantId} onValueChange={(v) => setNewItem({...newItem, tenantId: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_lease_select_tenant", "Kiracı seçin")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 {tenants.map((t: any) => (
 <SelectItem key={t.id} value={t.id}>{t.name}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_lease_start_date", "Başlangıç ​​Tarihi")}</Label>
 <Input 
 type="date" 
 value={newItem.startDate} 
 onChange={(e) => setNewItem({...newItem, startDate: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_lease_end_date", "Bitiş Tarihi")}</Label>
 <Input 
 type="date" 
 value={newItem.endDate} 
 onChange={(e) => setNewItem({...newItem, endDate: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_lease_monthly_rent", "Aylık Kira")}</Label>
 <Input 
 type="number" 
 value={newItem.monthlyRent} 
 onChange={(e) => setNewItem({...newItem, monthlyRent: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_lease_currency", "Para birimi")}</Label>
 <Select value={newItem.currency} onValueChange={(v) => setNewItem({...newItem, currency: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="USD">{t("admin_financial_usd", "Usd")}</SelectItem>
 <SelectItem value="EUR">{t("admin_financial_eur", "Eur")}</SelectItem>
 <SelectItem value="GBP">{t("admin_auto_gbp", "GBP")}</SelectItem>
 <SelectItem value="TRY">{t("admin_auto_try", "DENEMEK")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_lease_deposit", "Yatırma Tutarı")}</Label>
 <Input 
 type="number" 
 value={newItem.depositAmount} 
 onChange={(e) => setNewItem({...newItem, depositAmount: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_lease_payment_frequency", "Ödeme Sıklığı")}</Label>
 <Select value={newItem.paymentFrequency} onValueChange={(v) => setNewItem({...newItem, paymentFrequency: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="MONTHLY">{t("admin_lease_monthly", "Aylık")}</SelectItem>
 <SelectItem value="QUARTERLY">{t("admin_lease_quarterly", "Üç ayda bir")}</SelectItem>
 <SelectItem value="ANNUALLY">{t("admin_lease_annually", "Yıllık")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_lease_notice_period", "İhbar Süresi (gün)")}</Label>
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
 <Label htmlFor="autoRenew">{t("admin_lease_auto_renew", "Otomatik Yenileme")}</Label>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_lease_terms", "Şartlar ve koşullar")}</Label>
 <Textarea 
 value={newItem.terms} 
 onChange={(e) => setNewItem({...newItem, terms: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_lease_terms_placeholder", "Kiralama hüküm ve koşulları")}
 rows={3}
 />
 </div>
 </form>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsAddModalOpen(false)} className="bg-card border-border">
 {t("common.cancel", "İptal")}
 </Button>
 <Button onClick={handleAddSubmit} className="bg-muted hover:bg-muted0 text-white">
 {t("common.save", "Kaydet")}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2">
 <FileText className="w-5 h-5" />
 {t("admin_lease_list_title", "Kira Sözleşmeleri")}
 </CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="text-center py-8 text-muted-foreground">{t("common.loading", "Yükleniyor")}</div>
 ) : leases.length === 0 ? (
 <div className="text-center py-8 text-muted-foreground">{t("admin_lease_empty", "Kiralama bulunamadı")}</div>
 ) : (
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_lease_property", "Mülk")}</TableHead>
 <TableHead>{t("admin_lease_tenant", "Kiracı")}</TableHead>
 <TableHead>{t("admin_lease_period", "Dönem")}</TableHead>
 <TableHead>{t("admin_lease_rent", "Aylık Kira")}</TableHead>
 <TableHead>{t("admin_lease_status", "Durum")}</TableHead>
 <TableHead>{t("admin_lease_payment", "Ödeme")}</TableHead>
 <TableHead className="text-right">{t("common.actions", "İşlemler")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {leases.map((item: Lease) => (
 <TableRow key={item.id}>
 <TableCell className="font-medium">
 {item.listing?.property?.name || item.listing?.title || '-'}
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <User className="w-4 h-4 text-muted-foreground" />
 {item.tenant?.name || '-'}
 </div>
 </TableCell>
 <TableCell className="text-muted-foreground">
 <div className="flex items-center gap-1">
 <Calendar className="w-3 h-3" />
 {new Date(item.startDate).toLocaleDateString()} {t(" - ", "-")}{new Date(item.endDate).toLocaleDateString()}
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-1">
 <DollarSign className="w-4 h-4" />
 {item.monthlyRent.toLocaleString()} {item.currency}
 </div>
 </TableCell>
 <TableCell>{getStatusBadge(item.status)}</TableCell>
 <TableCell className="text-muted-foreground">
 {item.paymentFrequency}
 {item.autoRenew && <Badge variant="outline" className="ml-2">{t("admin_lease_auto", "Otomatik")}</Badge>}
 </TableCell>
 <TableCell className="text-right">
 <div className="flex justify-end gap-2">
 <Button variant="ghost" size="icon" aria-label={t("common.edit")} onClick={() => openEditModal(item)}>
 <Edit className="w-4 h-4" />
 </Button>
 <Button variant="ghost" size="icon" aria-label={t("common.delete")} onClick={() => deleteMutation.mutate(item.id)}>
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
 <DialogTitle>{t("admin_lease_edit_title", "Kiralamayı Düzenle")}</DialogTitle>
 <DialogDescription>{t("admin_lease_edit_desc", "Kira sözleşmesi ayrıntılarını güncelleyin")}</DialogDescription>
 </DialogHeader>
 {editingItem && (
 <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_lease_status", "Durum")}</Label>
 <Select value={editingItem.status} onValueChange={(v) => setEditingItem({...editingItem, status: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="ACTIVE">{t("admin_lease_active", "Aktif")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_lease_pending", "Askıda olması")}</SelectItem>
 <SelectItem value="EXPIRED">{t("admin_lease_expired", "Günü geçmiş")}</SelectItem>
 <SelectItem value="TERMINATED">{t("admin_lease_terminated", "Feshedildi")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_lease_monthly_rent", "Aylık Kira")}</Label>
 <Input 
 type="number" 
 value={editingItem.monthlyRent}
 onChange={(e) => setEditingItem({...editingItem, monthlyRent: parseFloat(e.target.value)})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_lease_end_date", "Bitiş Tarihi")}</Label>
 <Input 
 type="date" 
 value={editingItem.endDate}
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
 <Label htmlFor="editAutoRenew">{t("admin_lease_auto_renew", "Otomatik Yenileme")}</Label>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_lease_terms", "Şartlar ve koşullar")}</Label>
 <Textarea 
 value={editingItem.terms || ''}
 onChange={(e) => setEditingItem({...editingItem, terms: e.target.value})}
 className="bg-card border-border"
 rows={3}
 />
 </div>
 </form>
 )}
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsEditModalOpen(false)} className="bg-card border-border">
 {t("common.cancel", "İptal")}
 </Button>
 <Button onClick={handleEditSubmit} className="bg-muted hover:bg-muted0 text-white">
 {t("common.save", "Kaydet")}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 );
};

export default LeaseManagement;
