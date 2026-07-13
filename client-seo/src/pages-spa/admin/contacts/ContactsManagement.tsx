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
 toast({ title: t('admin_contracts_sending',"Sending..."), description: t('admin_contracts_sendingDesc',"{{type}} is being sent.", { type: contractType }) });
 await apiClient.post('/crm/request-contract-signature', {
 email: contact.email,
 name: contact.fullName,
 contractType: contractType,
 propertyId:"default_property_id" // Placeholder
 });
 toast({ title: t('success'), description: t('admin_contracts_success',"Legal document successfully sent to client via email.") });
 } catch (error) {
 toast({ title: t('error'), description: t('admin_contracts_error',"Failed to send contract."), variant:"destructive" });
 }
 };

 const contacts = contactsRes?.data || [];
 
 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-emerald-400 to-slate-400">
 {t("admin_contacts_title","Contacts & Leads")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_contacts_subtitle","Centralized CRM for all property inquiries, leads, and client relations")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-white/10">
 {t("common.export","Export CSV")}
 </Button>
 <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
 <DialogTrigger asChild>
 <Button className="bg-emerald-600 hover:bg-emerald-700 text-foreground shadow-lg shadow-emerald-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_contacts_add","New Contact")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_contacts_add","New Contact")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="fullName">{t("admin_auto_full_name", "Full Name")}</Label>
 <Input 
 id="fullName" 
 className="bg-card border-border" 
 value={newContact.fullName}
 onChange={e => setNewContact({...newContact, fullName: e.target.value})}
 required
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="email">{t("admin_auto_email", "Email")}</Label>
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
 <Label htmlFor="phone">{t("admin_auto_phone", "Phone")}</Label>
 <Input 
 id="phone" 
 className="bg-card border-border" 
 value={newContact.phone}
 onChange={e => setNewContact({...newContact, phone: e.target.value})}
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="type">{t("admin_auto_contact_type", "Contact Type")}</Label>
 <Input 
 id="type" 
 className="bg-card border-border" 
 value={newContact.type}
 onChange={e => setNewContact({...newContact, type: e.target.value})}
 placeholder="TENANT, OWNER_CONTACT..."
 />
 </div>
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsAddModalOpen(false)}>Cancel</Button>
 <Button type="submit" className="bg-emerald-600 hover:bg-emerald-700" disabled={createMutation.isPending}>
 {createMutation.isPending ?"Saving..." :"Create Contact"}
 </Button>
 </div>
 </form>
 </DialogContent>
 </Dialog>
 <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_contacts_edit","Edit Contact")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleEditSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="edit-fullName">{t("admin_auto_full_name", "Full Name")}</Label>
 <Input 
 id="edit-fullName" 
 className="bg-card border-border" 
 value={editingContact?.fullName || ''}
 onChange={e => setEditingContact({...editingContact, fullName: e.target.value})}
 required
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="edit-email">{t("admin_auto_email", "Email")}</Label>
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
 <Label htmlFor="edit-phone">{t("admin_auto_phone", "Phone")}</Label>
 <Input 
 id="edit-phone" 
 className="bg-card border-border" 
 value={editingContact?.phone || ''}
 onChange={e => setEditingContact({...editingContact, phone: e.target.value})}
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="edit-type">{t("admin_auto_contact_type", "Contact Type")}</Label>
 <Input 
 id="edit-type" 
 className="bg-card border-border" 
 value={editingContact?.type || 'OTHER'}
 onChange={e => setEditingContact({...editingContact, type: e.target.value})}
 placeholder="TENANT, OWNER_CONTACT..."
 />
 </div>
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsEditModalOpen(false)}>Cancel</Button>
 <Button type="submit" className="bg-emerald-600 hover:bg-emerald-700" disabled={updateMutation.isPending}>
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
 <CardTitle className="text-sm font-medium text-slate-300">Total Leads</CardTitle>
 <Contact className="w-4 h-4 text-emerald-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">45,210</div>
 <p className="text-xs text-green-400 mt-1">+1,200 this week</p>
 </CardContent>
 </Card>
 
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Emails Sent</CardTitle>
 <Mail className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">128k</div>
 <p className="text-xs text-muted-foreground mt-1">98% delivery rate</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Active Calls</CardTitle>
 <PhoneCall className="w-4 h-4 text-amber-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">342</div>
 <p className="text-xs text-muted-foreground mt-1">Today</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Messages</CardTitle>
 <MessageSquare className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">8,901</div>
 <p className="text-xs text-muted-foreground mt-1">Unread: 12</p>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_contacts_list","Global Directory")}</CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("common.loading","Loading global CRM data...")}
 </div>
 ) : contacts.length === 0 ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 No contacts found.
 </div>
 ) : (
 <div className="rounded-xl border border-border">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-slate-300">Name</TableHead>
 <TableHead className="text-slate-300">Email</TableHead>
 <TableHead className="text-slate-300">Phone</TableHead>
 <TableHead className="text-slate-300">Type</TableHead>
 <TableHead className="text-slate-300 text-right">Actions</TableHead>
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
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-white bg-emerald-600/10 hover:bg-emerald-600/20 text-emerald-400 mr-2">
 <FileSignature className="w-4 h-4 mr-2" /> {t('admin_contracts_actions', 'Process')}
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-background border-border text-foreground">
 <DropdownMenuItem className="cursor-pointer hover:bg-white/10" onClick={() => handleSendContract(c, t('admin_contracts_salesType',"Sales Contract"))}>
 <FileText className="w-4 h-4 mr-2 text-muted-foreground" /> {t('admin_contracts_sendSales', 'Send Sales Contract')}
 </DropdownMenuItem>
 <DropdownMenuItem className="cursor-pointer hover:bg-white/10" onClick={() => handleSendContract(c, t('admin_contracts_evictionType',"Eviction Agreement"))}>
 <FileText className="w-4 h-4 mr-2 text-orange-400" /> {t('admin_contracts_sendEviction', 'Send Eviction Agreement')}
 </DropdownMenuItem>
 <DropdownMenuItem className="cursor-pointer hover:bg-white/10" onClick={() => handleSendContract(c, t('admin_contracts_rentalType',"Rental Contract"))}>
 <FileText className="w-4 h-4 mr-2 text-emerald-400" /> {t('admin_contracts_sendRental', 'Send Rental Contract')}
 </DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>

 <Button 
 variant="ghost" 
 size="icon" 
 className="text-muted-foreground hover:text-white"
 onClick={() => openEditModal(c)}
 >
 <Edit className="w-4 h-4" />
 </Button>
 <Button 
 variant="ghost" 
 size="icon" 
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
