"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Plus, User, Edit, Trash2, Mail, Phone, Star, Calendar, ShieldCheck, AlertCircle, CheckCircle, Search } from 'lucide-react';
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

interface Guest {
 id: string;
 orgId: string;
 userId?: string;
 name: string;
 email: string;
 phone?: string;
 nationality?: string;
 dateOfBirth?: string;
 idNumber?: string;
 idType?: string;
 verificationStatus: 'PENDING' | 'VERIFIED' | 'FAILED';
 totalBookings?: number;
 totalSpent?: number;
 averageRating?: number;
 notes?: string;
 createdAt: string;
 updatedAt: string;
 user?: {
 id: string;
 avatar?: string;
 };
}

const GuestManagement = () => {
 const { t } = useTranslation();
 const { isFieldAllowed } = useCountryGuard(undefined);
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingItem, setEditingItem] = useState<Guest | null>(null);
 const [searchQuery, setSearchQuery] = useState('');
 const [verificationFilter, setVerificationFilter] = useState<string>('ALL');
 const [newItem, setNewItem] = useState({ 
 name: '', 
 email: '', 
 phone: '', 
 nationality: '',
 dateOfBirth: '',
 idNumber: '',
 idType: 'PASSPORT',
 verificationStatus: 'PENDING',
 notes: ''
 });

 const { data: guestsRes, isLoading } = useQuery({
 queryKey: ['admin-guests'],
 queryFn: async () => {
 const res: any = await apiClient.get('/guest');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/guest', data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-guests'] });
 setIsAddModalOpen(false);
 setNewItem({ 
 name: '', 
 email: '', 
 phone: '', 
 nationality: '',
 dateOfBirth: '',
 idNumber: '',
 idType: 'PASSPORT',
 verificationStatus: 'PENDING',
 notes: ''
 });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/guest/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-guests'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/guest/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-guests'] });
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

 const openEditModal = (item: Guest) => {
 setEditingItem(item);
 setIsEditModalOpen(true);
 };

 const getVerificationBadge = (status: string) => {
 const statusConfig: Record<string, { icon: any; color: string; label: string }> = {
 'PENDING': { icon: AlertCircle, color: 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20', label: t('admin_guest_pending', 'Beklemede') },
 'VERIFIED': { icon: CheckCircle, color: 'bg-blue-500/10 text-success border-blue-500/20', label: t('admin_guest_verified', 'Doğrulandı') },
 'FAILED': { icon: AlertCircle, color: 'bg-red-500/10 text-red-400 border-red-500/20', label: t('admin_guest_failed', 'Başarısız') }
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

 const getRatingStars = (rating?: number) => {
 if (!rating) return '-';
 return (
 <div className="flex items-center gap-1">
 <Star className="w-4 h-4 text-yellow-400 fill-yellow-400" />
 <span className="text-sm">{rating.toFixed(1)}</span>
 </div>
 );
 };

 const guests = guestsRes?.data || [];
 
 const filteredGuests = guests.filter((item: Guest) => {
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
 {t("admin_guest_title", "Misafir Yönetimi")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_guest_subtitle", "Misafir profillerini ve rezervasyon geçmişini yönetin")}
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
 <DialogTitle>{t("admin_guest_add_title", "Yeni Misafir Ekle")}</DialogTitle>
 <DialogDescription>{t("admin_guest_add_desc", "Yeni bir misafir profili oluşturun")}</DialogDescription>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_guest_name", "Tam Ad")}</Label>
 <Input 
 value={newItem.name} 
 onChange={(e) => setNewItem({...newItem, name: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_guest_email", "E-posta")}</Label>
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
 <Label>{t("admin_guest_phone", "Telefon")}</Label>
 <Input 
 value={newItem.phone} 
 onChange={(e) => setNewItem({...newItem, phone: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_guest_nationality", "Uyruk")}</Label>
 <Input 
 value={newItem.nationality} 
 onChange={(e) => setNewItem({...newItem, nationality: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_guest_dob", "Doğum Tarihi")}</Label>
 <Input 
 type="date"
 value={newItem.dateOfBirth} 
 onChange={(e) => setNewItem({...newItem, dateOfBirth: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_guest_id_type", "Kimlik Tipi")}</Label>
 <Select value={newItem.idType} onValueChange={(v) => setNewItem({...newItem, idType: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="PASSPORT">{t("admin_guest_passport", "Pasaport")}</SelectItem>
 <SelectItem value="NATIONAL_ID">{t("admin_guest_national_id", "Ulusal Kimlik")}</SelectItem>
 <SelectItem value="DRIVERS_LICENSE">{t("admin_guest_drivers_license","Driver's License")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_guest_id_number", "Kimlik Numarası")}</Label>
 <Input 
 value={newItem.idNumber} 
 onChange={(e) => setNewItem({...newItem, idNumber: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_guest_verification", "Doğrulama Durumu")}</Label>
 <Select value={newItem.verificationStatus} onValueChange={(v) => setNewItem({...newItem, verificationStatus: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="PENDING">{t("admin_guest_pending", "Beklemede")}</SelectItem>
 <SelectItem value="VERIFIED">{t("admin_guest_verified", "Doğrulandı")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_guest_failed", "Başarısız")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_guest_notes", "Notlar")}</Label>
 <Textarea 
 value={newItem.notes} 
 onChange={(e) => setNewItem({...newItem, notes: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_guest_notes_placeholder", "İsteğe bağlı notlar")}
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

 {/* Filters Section */}
 <div className="flex gap-4">
 <div className="relative flex-1 max-w-md">
 <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
 <Input
 placeholder={t("common.search", "Ara")}
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
 <SelectItem value="ALL">{t("common.all", "Tümü")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_guest_pending", "Beklemede")}</SelectItem>
 <SelectItem value="VERIFIED">{t("admin_guest_verified", "Doğrulandı")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_guest_failed", "Başarısız")}</SelectItem>
 </SelectContent>
 </Select>
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2">
 <User className="w-5 h-5" />
 {t("admin_guest_list_title", "Misafir Profilleri")}
 </CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="text-center py-8 text-muted-foreground">{t("common.loading", "Yükleniyor")}</div>
 ) : filteredGuests.length === 0 ? (
 <div className="text-center py-8 text-muted-foreground">{t("admin_guest_empty", "Misafir bulunamadı")}</div>
 ) : (
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_guest_name", "Tam Ad")}</TableHead>
 <TableHead>{t("admin_guest_contact", "İletişim")}</TableHead>
 <TableHead>{t("admin_guest_id_info", "Kimlik Bilgisi")}</TableHead>
 <TableHead>{t("admin_guest_stats", "İstatistikler")}</TableHead>
 <TableHead>{t("admin_guest_rating", "Puan")}</TableHead>
 <TableHead>{t("admin_guest_verification", "Doğrulama Durumu")}</TableHead>
 <TableHead className="text-right">{t("common.actions", "İşlemler")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredGuests.map((item: Guest) => (
 <TableRow key={item.id}>
 <TableCell className="font-medium">
 <div className="flex items-center gap-3">
 <Avatar>
 <AvatarImage src={item.user?.avatar} />
 <AvatarFallback>{item.name.charAt(0)}</AvatarFallback>
 </Avatar>
 <div>
 <div className="font-medium">{item.name}</div>
 <div className="text-xs text-muted-foreground">{item.nationality || '-'}</div>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <div className="space-y-1">
 <div className="flex items-center gap-1 text-sm">
 <Mail className="w-3 h-3 text-muted-foreground" />
 {item.email}
 </div>
 {item.phone && (
 <div className="flex items-center gap-1 text-sm text-muted-foreground">
 <Phone className="w-3 h-3" />
 {item.phone}
 </div>
 )}
 </div>
 </TableCell>
 <TableCell className="text-muted-foreground">
 <div className="text-sm">
 <div>{item.idType}</div>
 <div className="text-xs">{item.idNumber || '-'}</div>
 </div>
 </TableCell>
 <TableCell className="text-muted-foreground">
 <div className="text-sm space-y-1">
 <div className="flex items-center gap-1">
 <Calendar className="w-3 h-3" />
 {item.totalBookings || 0} {t("admin_guest_bookings", "rezervasyonlar")}
 </div>
 {item.totalSpent && (
 <div>{t("currency_symbol", "$")}{item.totalSpent.toLocaleString()} {t("admin_guest_spent", "harcanan")}</div>
 )}
 </div>
 </TableCell>
 <TableCell>{getRatingStars(item.averageRating)}</TableCell>
 <TableCell>{getVerificationBadge(item.verificationStatus)}</TableCell>
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
 <DialogTitle>{t("admin_guest_edit_title", "Misafiri Düzenle")}</DialogTitle>
 <DialogDescription>{t("admin_guest_edit_desc", "Misafir profil detaylarını güncelleyin")}</DialogDescription>
 </DialogHeader>
 {editingItem && (
 <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_guest_name", "Tam Ad")}</Label>
 <Input 
 value={editingItem.name}
 onChange={(e) => setEditingItem({...editingItem, name: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_guest_email", "E-posta")}</Label>
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
 <Label>{t("admin_guest_phone", "Telefon")}</Label>
 <Input 
 value={editingItem.phone || ''}
 onChange={(e) => setEditingItem({...editingItem, phone: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_guest_verification", "Doğrulama Durumu")}</Label>
 <Select value={editingItem.verificationStatus} onValueChange={(v) => setEditingItem({...editingItem, verificationStatus: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="PENDING">{t("admin_guest_pending", "Beklemede")}</SelectItem>
 <SelectItem value="VERIFIED">{t("admin_guest_verified", "Doğrulandı")}</SelectItem>
 <SelectItem value="FAILED">{t("admin_guest_failed", "Başarısız")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_guest_notes", "Notlar")}</Label>
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

export default GuestManagement;
