"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Building, Plus, Home, Warehouse, Edit, Trash2 } from 'lucide-react';
import { Button } from"@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { apiClient } from '@/lib/api';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogDescription, DialogFooter } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { useState } from 'react';
import { useCountryGuard } from '@/lib/hooks/useCountryGuard';

const FacilitiesManagement = () => {
 const { t } = useTranslation();
 const { isFieldAllowed } = useCountryGuard(undefined); // Could be hooked to a global admin country selector
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingFacility, setEditingFacility] = useState<any>(null);
 const [newFacility, setNewFacility] = useState({ name: '', feeAmount: '', feeCurrency: 'USD' });

 const { data: facilitiesRes, isLoading } = useQuery({
 queryKey: ['admin-facilities'],
 queryFn: async () => {
 const res: any = await apiClient.get('/facility');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 // Mocking orgId and propertyId since we might not have them in context yet
 return apiClient.post('/facility', { ...data, orgId: 'org_1', propertyId: 'prop_1' });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-facilities'] });
 setIsAddModalOpen(false);
 setNewFacility({ name: '', feeAmount: '', feeCurrency: 'USD' });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/facility/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-facilities'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/facility/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-facilities'] });
 setIsEditModalOpen(false);
 setEditingFacility(null);
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate({
 name: newFacility.name,
 feeAmount: parseFloat(newFacility.feeAmount) || 0,
 feeCurrency: newFacility.feeCurrency
 });
 };

 const handleEditSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 updateMutation.mutate(editingFacility);
 };

 const openEditModal = (facility: any) => {
 setEditingFacility(facility);
 setIsEditModalOpen(true);
 };

 const facilities = facilitiesRes?.data || [];
 
 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
 {t("admin_facilities_title", "Tesis Yönetimi")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_facilities_subtitle", "Olanakları, ortak alanları ve ortak alanları izleyin ve yapılandırın")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-muted dark:hover:bg-card/10">
 {t("common.export", "Dışa aktar")}
 </Button>
 <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
 <DialogTrigger asChild>
 <Button className="bg-muted hover:bg-muted text-foreground shadow-lg shadow-slate-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_facilities_add", "Tesis Ekle")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_facilities_add", "Tesis Ekle")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="name">{t("admin_auto_facility_name", "Tesis Adı")}</Label>
 <Input 
 id="name" 
 className="bg-card border-border" 
 value={newFacility.name}
 onChange={e => setNewFacility({...newFacility, name: e.target.value})}
 required
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 {isFieldAllowed('Facility', 'feeAmount') && (
 <div className="space-y-2">
 <Label htmlFor="feeAmount">{t("admin_auto_fee_amount", "Ücret Tutarı")}</Label>
 <Input 
 id="feeAmount" 
 type="number"
 className="bg-card border-border" 
 value={newFacility.feeAmount}
 onChange={e => setNewFacility({...newFacility, feeAmount: e.target.value})}
 />
 </div>
 )}
 {isFieldAllowed('Facility', 'feeCurrency') && (
 <div className="space-y-2">
 <Label htmlFor="feeCurrency">{t("admin_auto_currency", "Para birimi")}</Label>
 <Input 
 id="feeCurrency" 
 className="bg-card border-border" 
 value={newFacility.feeCurrency}
 onChange={e => setNewFacility({...newFacility, feeCurrency: e.target.value})}
 />
 </div>
 )}
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsAddModalOpen(false)}>{t("admin_action_cancel", "İptal")}</Button>
 <Button type="submit" className="bg-muted hover:bg-muted" disabled={createMutation.isPending}>
 {createMutation.isPending ? t("admin_action_saving", "Kaydediliyor...") : t("admin_action_save_facility", "Tesisi Kaydet")}
 </Button>
 </div>
 </form>
 </DialogContent>
 </Dialog>
 <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_facilities_edit", "Tesisi Düzenle")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleEditSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="edit-name">{t("admin_auto_facility_name", "Tesis Adı")}</Label>
 <Input 
 id="edit-name" 
 className="bg-card border-border" 
 value={editingFacility?.name || ''}
 onChange={e => setEditingFacility({...editingFacility, name: e.target.value})}
 required
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 {isFieldAllowed('Facility', 'feeAmount') && (
 <div className="space-y-2">
 <Label htmlFor="edit-feeAmount">{t("admin_auto_fee_amount", "Ücret Tutarı")}</Label>
 <Input 
 id="edit-feeAmount" 
 type="number"
 className="bg-card border-border" 
 value={editingFacility?.feeAmount || ''}
 onChange={e => setEditingFacility({...editingFacility, feeAmount: parseFloat(e.target.value) || 0})}
 />
 </div>
 )}
 {isFieldAllowed('Facility', 'feeCurrency') && (
 <div className="space-y-2">
 <Label htmlFor="edit-feeCurrency">{t("admin_auto_currency", "Para birimi")}</Label>
 <Input 
 id="edit-feeCurrency" 
 className="bg-card border-border" 
 value={editingFacility?.feeCurrency || 'USD'}
 onChange={e => setEditingFacility({...editingFacility, feeCurrency: e.target.value})}
 />
 </div>
 )}
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsEditModalOpen(false)}>{t("admin_action_cancel", "İptal")}</Button>
 <Button type="submit" className="bg-muted hover:bg-muted" disabled={updateMutation.isPending}>
 {updateMutation.isPending ? t("admin_action_saving", "Kaydediliyor...") : t("admin_action_save_changes", "Değişiklikleri Kaydet")}
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
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_auto_registered_facilities", "Kayıtlı Tesisler")}</CardTitle>
 <Building className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">8,451</div>
 <p className="text-xs text-blue-400 mt-1">{t("admin_auto_across_120_properties", "120 mülkte")}</p>
 </CardContent>
 </Card>
 
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_auto_shared_spaces", "Paylaşılan Alanlar")}</CardTitle>
 <Home className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">1,240</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_auto_pools_gyms_lounges", "Havuzlar, Spor Salonları, Salonlar")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_auto_under_maintenance", "Bakımda")}</CardTitle>
 <Warehouse className="w-4 h-4 text-warning" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">34</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_auto_currently_offline", "Şu anda çevrimdışı")}</p>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_facilities_list", "Tesis Endeksi")}</CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("common.loading", "Yükleniyor")}
 </div>
 ) : facilities.length === 0 ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("admin_facilities_noData", "Tesis bulunamadı.")}
 </div>
 ) : (
 <div className="rounded-xl border border-border">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-muted-foreground">{t("admin_ai_name", "Sistem Adı")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_ai_property", "Mülk")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_auto_fee_amount", "Ücret Tutarı")}</TableHead>
 <TableHead className="text-muted-foreground text-right">{t("admin_ai_actions", "İşlemler")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {facilities.map((f: any) => (
 <TableRow key={f.id} className="border-border hover:bg-card transition-colors">
 <TableCell className="font-medium text-foreground">{f.name}</TableCell>
 <TableCell className="text-muted-foreground">{f.propertyId || 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">
 {f.feeAmount ? `${f.feeAmount} ${f.feeCurrency || 'USD'}` : 'Free'}
 </TableCell>
 <TableCell className="text-right">
 <Button 
 variant="ghost" 
 size="icon" aria-label={t("common.edit")} 
 className="text-muted-foreground hover:text-foreground"
 onClick={() => openEditModal(f)}
 >
 <Edit className="w-4 h-4" />
 </Button>
 <Button 
 variant="ghost" 
 size="icon" aria-label={t("common.delete")} 
 className="text-red-400 hover:text-red-300 hover:bg-red-400/10"
 onClick={() => deleteMutation.mutate(f.id)}
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

export default FacilitiesManagement;
