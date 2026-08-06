"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Contact, Plus, PhoneCall, Mail, MessageSquare, Edit, Trash2 } from 'lucide-react';
import { Button } from"@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { apiClient } from '@/lib/api';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogDescription, DialogFooter } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { useState } from 'react';

import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { useToast } from"@/hooks/use-toast";
import { FileSignature, Send, FileText } from 'lucide-react';

const ContactsManagement = () => {
 const { toast } = useToast();
 const { t } = useTranslation();
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingContact, setEditingContact] = useState<any>(null);
 const [newContact, setNewContact] = useState({ fullName: '', email: '', phone: '', type: 'OTHER' });

 const { data: contactsRes, isLoading } = useQuery({
 queryKey: ['admin-contacts'],
 queryFn: async () => {
 const res: any = await apiClient.get('/contact');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/contact', { 
 ...data, 
 orgId: 'org_1'
 });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-contacts'] });
 setIsAddModalOpen(false);
 setNewContact({ fullName: '', email: '', phone: '', type: 'OTHER' });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/contact/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-contacts'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/contact/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-contacts'] });
 setIsEditModalOpen(false);
 setEditingContact(null);
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate(newContact);
 };

 const handleEditSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 updateMutation.mutate(editingContact);
 };

 const openEditModal = (contact: any) => {
 setEditingContact(contact);
 setIsEditModalOpen(true);
 };

 const handleSendContract = async (contact: any, contractType: string) => {
 try {
 toast({ title: t('admin_contracts_sending', "Gönderiliyor..."), description: t('admin_contracts_sendingDesc',"{{type}} is being sent.", { type: contractType }) });
 await apiClient.post('/crm/request-contract-signature', {
 email: contact.email,
 name: contact.fullName,
 contractType: contractType,
 propertyId:"default_property_id" // Placeholder
 });
 toast({ title: t('success'), description: t('admin_contracts_success', "Hukuki belge başarıyla müşteriye e-posta ile gönderildi.") });
 } catch (error) {
 toast({ title: t('error'), description: t('admin_contracts_error', "Sözleşme gönderilemedi."), variant:"destructive" });
 }
 };

 const contacts = contactsRes?.data || [];
 
 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-blue-400 to-slate-400">
 {t("admin_contacts_title", "Kişiler ve Potansiyel Müşteriler")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_contacts_subtitle", "Tüm mülk sorguları, potansiyel müşteriler ve müşteri ilişkileri için merkezi CRM")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-muted dark:hover:bg-card/10">
 {t("common.export", "Dışa aktar")}
 </Button>
 <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
 <DialogTrigger asChild>
 <Button className="bg-blue-600 hover:bg-blue-700 text-foreground shadow-lg shadow-blue-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_contacts_add", "Yeni Kişi")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_contacts_add", "Yeni Kişi")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="fullName">{t("admin_auto_full_name", "Ad Soyad")}</Label>
 <Input 
 id="fullName" 
 className="bg-card border-border" 
 value={newContact.fullName}
 onChange={e => setNewContact({...newContact, fullName: e.target.value})}
 required
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="email">{t("admin_auto_email", "E-posta")}</Label>
 <Input 
 id="email" 
 type="email"
 className="bg-card border-border" 
 value={newContact.email}
 onChange={e => setNewContact({...newContact, email: e.target.value})}
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label htmlFor="phone">{t("admin_auto_phone", "Telefon")}</Label>
 <Input 
 id="phone" 
 className="bg-card border-border" 
 value={newContact.phone}
 onChange={e => setNewContact({...newContact, phone: e.target.value})}
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="type">{t("admin_auto_contact_type", "İletişim Türü")}</Label>
 <Input 
 id="type" 
 className="bg-card border-border" 
 value={newContact.type}
 onChange={e => setNewContact({...newContact, type: e.target.value})}
 placeholder={t("admin_auto_tenant_owner_contact", "KİRACI, SAHİP_İLETİŞİM...")}
 />
 </div>
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsAddModalOpen(false)}>{t("admin_action_cancel", "İptal")}</Button>
 <Button type="submit" className="bg-blue-600 hover:bg-blue-700" disabled={createMutation.isPending}>
 {createMutation.isPending ?"Saving..." :"Create Contact"}
 </Button>
 </div>
 </form>
 </DialogContent>
 </Dialog>
 <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_contacts_edit", "Kişiyi Düzenle")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleEditSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="edit-fullName">{t("admin_auto_full_name", "Ad Soyad")}</Label>
 <Input 
 id="edit-fullName" 
 className="bg-card border-border" 
 value={editingContact?.fullName || ''}
 onChange={e => setEditingContact({...editingContact, fullName: e.target.value})}
 required
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="edit-email">{t("admin_auto_email", "E-posta")}</Label>
 <Input 
 id="edit-email" 
 type="email"
 className="bg-card border-border" 
 value={editingContact?.email || ''}
 onChange={e => setEditingContact({...editingContact, email: e.target.value})}
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label htmlFor="edit-phone">{t("admin_auto_phone", "Telefon")}</Label>
 <Input 
 id="edit-phone" 
 className="bg-card border-border" 
 value={editingContact?.phone || ''}
 onChange={e => setEditingContact({...editingContact, phone: e.target.value})}
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="edit-type">{t("admin_auto_contact_type", "İletişim Türü")}</Label>
 <Input 
 id="edit-type" 
 className="bg-card border-border" 
 value={editingContact?.type || 'OTHER'}
 onChange={e => setEditingContact({...editingContact, type: e.target.value})}
 placeholder={t("admin_auto_tenant_owner_contact", "KİRACI, SAHİP_İLETİŞİM...")}
 />
 </div>
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsEditModalOpen(false)}>{t("admin_action_cancel", "İptal")}</Button>
 <Button type="submit" className="bg-blue-600 hover:bg-blue-700" disabled={updateMutation.isPending}>
 {updateMutation.isPending ?"Saving..." :"Save Changes"}
 </Button>
 </div>
 </form>
 </DialogContent>
 </Dialog>
 </div>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_auto_total_leads", "Toplam Potansiyel Müşteriler")}</CardTitle>
 <Contact className="w-4 h-4 text-success" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">45,210</div>
 <p className="text-xs text-blue-400 mt-1">{t("admin_auto_1_200_this_week", "+1.200 bu hafta")}</p>
 </CardContent>
 </Card>
 
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_auto_emails_sent", "Gönderilen E-postalar")}</CardTitle>
 <Mail className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{t("admin_auto_128k", "128 bin")}</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_auto_98_delivery_rate", "%98 teslimat oranı")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_auto_active_calls", "Aktif Aramalar")}</CardTitle>
 <PhoneCall className="w-4 h-4 text-warning" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">342</div>
 <p className="text-xs text-muted-foreground mt-1">{t("common.today", "Bugün")}</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-muted-foreground">{t("admin_ai_messages", "Mesajlar")}</CardTitle>
 <MessageSquare className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">8,901</div>
 <p className="text-xs text-muted-foreground mt-1">{t("admin_auto_unread_12", "Okunmamış: 12")}</p>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_contacts_list", "Küresel Dizin")}</CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("common.loading", "Yükleniyor")}
 </div>
 ) : contacts.length === 0 ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("admin_contacts_empty", "KİŞİ Bulunamadı.")}</div>
 ) : (
 <div className="rounded-xl border border-border">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-muted-foreground">{t("admin_ai_name", "Sistem Adı")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_auto_email", "E-posta")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_auto_phone", "Telefon")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_auto_type", "Tip")}</TableHead>
 <TableHead className="text-muted-foreground text-right">{t("admin_ai_actions", "İşlemler")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {contacts.map((c: any) => (
 <TableRow key={c.id} className="border-border hover:bg-card transition-colors">
 <TableCell className="font-medium text-foreground">{c.fullName}</TableCell>
 <TableCell className="text-muted-foreground">{c.email || 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">{c.phone || 'N/A'}</TableCell>
 <TableCell className="text-muted-foreground">
 <span className="px-2 py-1 bg-card rounded-full text-xs">
 {c.type}
 </span>
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-foreground bg-blue-600/10 hover:bg-blue-600/20 text-success mr-2">
 <FileSignature className="w-4 h-4 mr-2" /> {t('admin_contracts_actions', 'İşlem Yap')}
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-background border-border text-foreground">
 <DropdownMenuItem className="cursor-pointer hover:bg-muted dark:hover:bg-card/10" onClick={() => handleSendContract(c, t('admin_contracts_salesType', "Satış Sözleşmesi"))}>
 <FileText className="w-4 h-4 mr-2 text-muted-foreground" /> {t('admin_contracts_sendSales', 'Satış Sözleşmesi Gönder')}
 </DropdownMenuItem>
 <DropdownMenuItem className="cursor-pointer hover:bg-muted dark:hover:bg-card/10" onClick={() => handleSendContract(c, t('admin_contracts_evictionType', "Tahliye Taahhüdü"))}>
 <FileText className="w-4 h-4 mr-2 text-warning" /> {t('admin_contracts_sendEviction', 'Tahliye Taahhüdü Gönder')}
 </DropdownMenuItem>
 <DropdownMenuItem className="cursor-pointer hover:bg-muted dark:hover:bg-card/10" onClick={() => handleSendContract(c, t('admin_contracts_rentalType', "Kira Kontratı"))}>
 <FileText className="w-4 h-4 mr-2 text-success" /> {t('admin_contracts_sendRental', 'Kira Kontratı Gönder')}
 </DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>

 <Button 
 variant="ghost" 
 size="icon" aria-label={t("common.edit")} 
 className="text-muted-foreground hover:text-foreground"
 onClick={() => openEditModal(c)}
 >
 <Edit className="w-4 h-4" />
 </Button>
 <Button 
 variant="ghost" 
 size="icon" aria-label={t("common.delete")} 
 className="text-red-400 hover:text-red-300 hover:bg-red-400/10"
 onClick={() => deleteMutation.mutate(c.id)}
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

export default ContactsManagement;
