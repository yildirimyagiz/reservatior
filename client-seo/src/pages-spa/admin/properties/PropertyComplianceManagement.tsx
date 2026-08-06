"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Plus, ShieldCheck, AlertTriangle, CheckCircle, Clock, Edit, Trash2, FileText } from 'lucide-react';
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

interface PropertyCompliance {
 id: string;
 propertyId: string;
 complianceType: string;
 status: 'PENDING' | 'VERIFIED' | 'FAILED' | 'EXPIRED';
 expiryDate?: string;
 documentId?: string;
 notes?: string;
 verifiedBy?: string;
 verifiedAt?: string;
 property?: {
 id: string;
 name: string;
 };
}

const PropertyComplianceManagement = () => {
 const { t } = useTranslation();
 const { isFieldAllowed } = useCountryGuard(undefined);
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingItem, setEditingItem] = useState<PropertyCompliance | null>(null);
 const [newItem, setNewItem] = useState({ propertyId: '', complianceType: '', status: 'PENDING', expiryDate: '', notes: '' });

 const { data: complianceRes, isLoading } = useQuery({
 queryKey: ['admin-property-compliance'],
 queryFn: async () => {
 const res: any = await apiClient.get('/property-compliance');
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
 return apiClient.post('/property-compliance', data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-property-compliance'] });
 setIsAddModalOpen(false);
 setNewItem({ propertyId: '', complianceType: '', status: 'PENDING', expiryDate: '', notes: '' });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/property-compliance/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-property-compliance'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/property-compliance/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-property-compliance'] });
 setIsEditModalOpen(false);
 setEditingItem(null);
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate(newItem);
 };

 const handleEditSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 if (editingItem) {
 updateMutation.mutate(editingItem);
 }
 };

 const openEditModal = (item: PropertyCompliance) => {
 setEditingItem(item);
 setIsEditModalOpen(true);
 };

 const getStatusBadge = (status: string) => {
 const statusConfig: Record<string, { icon: any; color: string; label: string }> = {
 'PENDING': { icon: Clock, color: 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20', label: t('admin_compliance_pending', 'Askıda olması') },
 'VERIFIED': { icon: CheckCircle, color: 'bg-blue-500/10 text-success border-blue-500/20', label: t('admin_compliance_verified', 'Doğrulandı') },
 'FAILED': { icon: AlertTriangle, color: 'bg-red-500/10 text-red-400 border-red-500/20', label: t('admin_compliance_failed', 'Arızalı') },
 'EXPIRED': { icon: AlertTriangle, color: 'bg-muted0/10 text-muted-foreground border-slate-500/20', label: t('admin_compliance_expired', 'Günü geçmiş') }
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

 const complianceTypes = [
 'FIRE_SAFETY',
 'BUILDING_CODE',
 'HEALTH_SAFETY',
 'ENVIRONMENTAL',
 'ACCESSIBILITY',
 'INSURANCE',
 'LICENSE',
 'TAX_COMPLIANCE',
 'ZONING'
 ];

 const complianceItems = complianceRes?.data || [];
 const properties = propertiesRes?.data || [];

 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
 {t("admin_property_compliance_title", "Mülkiyet Uygunluk Yönetimi")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_property_compliance_subtitle", "Mülk uyumluluk kayıtlarını ve sertifikalarını izleyin ve yönetin")}
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
 <DialogContent className="bg-card border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_property_compliance_add_title", "Özellik Uyumluluğu Ekle")}</DialogTitle>
 <DialogDescription>{t("admin_property_compliance_add_desc", "Bir mülk için yeni bir uyumluluk kaydı ekleme")}</DialogDescription>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
 <div className="space-y-2">
 <Label>{t("admin_property_compliance_property", "Mülk")}</Label>
 <Select value={newItem.propertyId} onValueChange={(v) => setNewItem({...newItem, propertyId: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_property_compliance_select_property", "Mülk seçin")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 {properties.map((p: any) => (
 <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_property_compliance_type", "Uyumluluk Türü")}</Label>
 <Select value={newItem.complianceType} onValueChange={(v) => setNewItem({...newItem, complianceType: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_property_compliance_select_type", "Uyumluluk türünü seçin")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 {complianceTypes.map(type => (
 <SelectItem key={type} value={type}>{type.replace(/_/g, ' ')}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_property_compliance_status", "Durum")}</Label>
 <Select value={newItem.status} onValueChange={(v) => setNewItem({...newItem, status: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_property_compliance_select_status", "Durum seç")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="PENDING">{t("admin_compliance_pending", "Askıda olması")}</SelectItem>
 <SelectItem value="VERIFIED">{t("admin_compliance_verified", "Doğrulandı")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_compliance_failed", "Arızalı")}</SelectItem>
 <SelectItem value="EXPIRED">{t("admin_compliance_expired", "Günü geçmiş")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_property_compliance_expiry", "Son kullanma tarihi")}</Label>
 <Input 
 type="date" 
 value={newItem.expiryDate} 
 onChange={(e) => setNewItem({...newItem, expiryDate: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_property_compliance_notes", "Notlar")}</Label>
 <Textarea 
 value={newItem.notes} 
 onChange={(e) => setNewItem({...newItem, notes: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_property_compliance_notes_placeholder", "İsteğe bağlı notlar")}
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
 <ShieldCheck className="w-5 h-5" />
 {t("admin_property_compliance_list_title", "Mülkiyet Uygunluk Kayıtları")}
 </CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="text-center py-8 text-muted-foreground">{t("common.loading", "Yükleniyor")}</div>
 ) : complianceItems.length === 0 ? (
 <div className="text-center py-8 text-muted-foreground">{t("admin_property_compliance_empty", "Uyumluluk kaydı bulunamadı")}</div>
 ) : (
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_property_compliance_property", "Mülk")}</TableHead>
 <TableHead>{t("admin_property_compliance_type", "Uyumluluk Türü")}</TableHead>
 <TableHead>{t("admin_property_compliance_status", "Durum")}</TableHead>
 <TableHead>{t("admin_property_compliance_expiry", "Son kullanma tarihi")}</TableHead>
 <TableHead>{t("admin_property_compliance_verified", "Doğrulayan")}</TableHead>
 <TableHead>{t("admin_property_compliance_notes", "Notlar")}</TableHead>
 <TableHead className="text-right">{t("common.actions", "İşlemler")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {complianceItems.map((item: PropertyCompliance) => (
 <TableRow key={item.id}>
 <TableCell className="font-medium">{item.property?.name || '-'}</TableCell>
 <TableCell>{item.complianceType.replace(/_/g, ' ')}</TableCell>
 <TableCell>{getStatusBadge(item.status)}</TableCell>
 <TableCell>{item.expiryDate ? new Date(item.expiryDate).toLocaleDateString() : '-'}</TableCell>
 <TableCell className="text-muted-foreground">{item.verifiedBy || '-'}</TableCell>
 <TableCell className="text-muted-foreground max-w-xs truncate">{item.notes || '-'}</TableCell>
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
 <DialogContent className="bg-card border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_property_compliance_edit_title", "Özellik Uyumluluğunu Düzenle")}</DialogTitle>
 <DialogDescription>{t("admin_property_compliance_edit_desc", "Uyumluluk kaydı ayrıntılarını güncelleyin")}</DialogDescription>
 </DialogHeader>
 {editingItem && (
 <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
 <div className="space-y-2">
 <Label>{t("admin_property_compliance_status", "Durum")}</Label>
 <Select value={editingItem.status} onValueChange={(v) => setEditingItem({...editingItem, status: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="PENDING">{t("admin_compliance_pending", "Askıda olması")}</SelectItem>
 <SelectItem value="VERIFIED">{t("admin_compliance_verified", "Doğrulandı")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_compliance_failed", "Arızalı")}</SelectItem>
 <SelectItem value="EXPIRED">{t("admin_compliance_expired", "Günü geçmiş")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_property_compliance_expiry", "Son kullanma tarihi")}</Label>
 <Input 
 type="date" 
 value={editingItem.expiryDate || ''}
 onChange={(e) => setEditingItem({...editingItem, expiryDate: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_property_compliance_notes", "Notlar")}</Label>
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

export default PropertyComplianceManagement;
