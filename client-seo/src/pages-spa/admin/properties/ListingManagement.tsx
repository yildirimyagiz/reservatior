"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Plus, Home, Edit, Trash2, Eye, Calendar, DollarSign, MapPin, Tag } from 'lucide-react';
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

interface Listing {
 id: string;
 orgId: string;
 propertyId: string;
 type: 'SALE' | 'RENT' | 'BOOKING';
 status: 'ACTIVE' | 'INACTIVE' | 'PENDING' | 'SOLD' | 'RENTED';
 listingPrice: number;
 currency: string;
 title?: string;
 description?: string;
 availableFrom?: string;
 availableTo?: string;
 minStay?: number;
 maxStay?: number;
 createdAt: string;
 updatedAt: string;
 property?: {
 id: string;
 name: string;
 type: string;
 city: string;
 addressLine1: string;
 };
}

const ListingManagement = () => {
 const { t } = useTranslation();
 const { isFieldAllowed } = useCountryGuard(undefined);
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingItem, setEditingItem] = useState<Listing | null>(null);
 const [newItem, setNewItem] = useState({ 
 propertyId: '', 
 type: 'SALE', 
 status: 'ACTIVE', 
 listingPrice: '', 
 currency: 'USD',
 title: '',
 description: '',
 availableFrom: '',
 availableTo: '',
 minStay: '',
 maxStay: ''
 });

 const { data: listingsRes, isLoading } = useQuery({
 queryKey: ['admin-listings'],
 queryFn: async () => {
 const res: any = await apiClient.get('/listing');
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
 return apiClient.post('/listing', data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-listings'] });
 setIsAddModalOpen(false);
 setNewItem({ 
 propertyId: '', 
 type: 'SALE', 
 status: 'ACTIVE', 
 listingPrice: '', 
 currency: 'USD',
 title: '',
 description: '',
 availableFrom: '',
 availableTo: '',
 minStay: '',
 maxStay: ''
 });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/listing/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-listings'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/listing/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-listings'] });
 setIsEditModalOpen(false);
 setEditingItem(null);
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate({
 ...newItem,
 listingPrice: parseFloat(newItem.listingPrice) || 0,
 minStay: newItem.minStay ? parseInt(newItem.minStay) : null,
 maxStay: newItem.maxStay ? parseInt(newItem.maxStay) : null
 });
 };

 const handleEditSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 if (editingItem) {
 updateMutation.mutate(editingItem);
 }
 };

 const openEditModal = (item: Listing) => {
 setEditingItem(item);
 setIsEditModalOpen(true);
 };

 const getStatusBadge = (status: string) => {
 const statusConfig: Record<string, { color: string; label: string }> = {
 'ACTIVE': { color: 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20', label: t('admin_listing_active', 'Active') },
 'INACTIVE': { color: 'bg-muted0/10 text-muted-foreground border-slate-500/20', label: t('admin_listing_inactive', 'Inactive') },
 'PENDING': { color: 'bg-yellow-500/10 text-yellow-400 border-yellow-500/20', label: t('admin_listing_pending', 'Pending') },
 'SOLD': { color: 'bg-blue-500/10 text-blue-400 border-blue-500/20', label: t('admin_listing_sold', 'Sold') },
 'RENTED': { color: 'bg-purple-500/10 text-purple-400 border-purple-500/20', label: t('admin_listing_rented', 'Rented') }
 };
 const config = statusConfig[status] || statusConfig['ACTIVE'];
 return <Badge className={config.color}>{config.label}</Badge>;
 };

 const getTypeBadge = (type: string) => {
 const typeConfig: Record<string, { color: string; label: string }> = {
 'SALE': { color: 'bg-orange-500/10 text-orange-400 border-orange-500/20', label: t('admin_listing_sale', 'Sale') },
 'RENT': { color: 'bg-blue-500/10 text-blue-400 border-blue-500/20', label: t('admin_listing_rent', 'Rent') },
 'BOOKING': { color: 'bg-green-500/10 text-green-400 border-green-500/20', label: t('admin_listing_booking', 'Booking') }
 };
 const config = typeConfig[type] || typeConfig['SALE'];
 return <Badge className={config.color}>{config.label}</Badge>;
 };

 const listings = listingsRes?.data || [];
 const properties = propertiesRes?.data || [];

 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
 {t("admin_listing_title","Listing Management")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_listing_subtitle","Manage property listings for sale, rent, and booking")}
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
 {t("common.add","Add Listing")}
 </Button>
 </DialogTrigger>
 <DialogContent className="bg-card border-border text-foreground max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_listing_add_title","Add Property Listing")}</DialogTitle>
 <DialogDescription>{t("admin_listing_add_desc","Create a new listing for a property")}</DialogDescription>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_listing_property","Property")}</Label>
 <Select value={newItem.propertyId} onValueChange={(v) => setNewItem({...newItem, propertyId: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_listing_select_property","Select property")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 {properties.map((p: any) => (
 <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_listing_type","Listing Type")}</Label>
 <Select value={newItem.type} onValueChange={(v) => setNewItem({...newItem, type: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="SALE">{t("admin_listing_sale","Sale")}</SelectItem>
 <SelectItem value="RENT">{t("admin_listing_rent","Rent")}</SelectItem>
 <SelectItem value="BOOKING">{t("admin_listing_booking","Booking")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_listing_price","Price")}</Label>
 <Input 
 type="number" 
 value={newItem.listingPrice} 
 onChange={(e) => setNewItem({...newItem, listingPrice: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_listing_currency","Currency")}</Label>
 <Select value={newItem.currency} onValueChange={(v) => setNewItem({...newItem, currency: v})}>
 <SelectTrigger className="bg-card border-border">
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
 <div className="space-y-2">
 <Label>{t("admin_listing_title","Title")}</Label>
 <Input 
 value={newItem.title} 
 onChange={(e) => setNewItem({...newItem, title: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_listing_title_placeholder","Listing title")}
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_listing_description","Description")}</Label>
 <Textarea 
 value={newItem.description} 
 onChange={(e) => setNewItem({...newItem, description: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_listing_description_placeholder","Property description")}
 rows={3}
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_listing_available_from","Available From")}</Label>
 <Input 
 type="date" 
 value={newItem.availableFrom} 
 onChange={(e) => setNewItem({...newItem, availableFrom: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_listing_available_to","Available To")}</Label>
 <Input 
 type="date" 
 value={newItem.availableTo} 
 onChange={(e) => setNewItem({...newItem, availableTo: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_listing_min_stay","Min Stay (nights)")}</Label>
 <Input 
 type="number" 
 value={newItem.minStay} 
 onChange={(e) => setNewItem({...newItem, minStay: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_listing_max_stay","Max Stay (nights)")}</Label>
 <Input 
 type="number" 
 value={newItem.maxStay} 
 onChange={(e) => setNewItem({...newItem, maxStay: e.target.value})}
 className="bg-card border-border"
 />
 </div>
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

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2">
 <Home className="w-5 h-5" />
 {t("admin_listing_list_title","Property Listings")}
 </CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="text-center py-8 text-slate-500">{t("common.loading","Loading...")}</div>
 ) : listings.length === 0 ? (
 <div className="text-center py-8 text-slate-500">{t("admin_listing_empty","No listings found")}</div>
 ) : (
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_listing_property","Property")}</TableHead>
 <TableHead>{t("admin_listing_type","Type")}</TableHead>
 <TableHead>{t("admin_listing_price","Price")}</TableHead>
 <TableHead>{t("admin_listing_status","Status")}</TableHead>
 <TableHead>{t("admin_listing_availability","Availability")}</TableHead>
 <TableHead>{t("admin_listing_created","Created")}</TableHead>
 <TableHead className="text-right">{t("common.actions","Actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {listings.map((item: Listing) => (
 <TableRow key={item.id}>
 <TableCell className="font-medium">
 <div>
 <div className="font-medium">{item.title || item.property?.name || '-'}</div>
 <div className="text-xs text-slate-500 flex items-center gap-1">
 <MapPin className="w-3 h-3" />
 {item.property?.city || '-'}
 </div>
 </div>
 </TableCell>
 <TableCell>{getTypeBadge(item.type)}</TableCell>
 <TableCell>
 <div className="flex items-center gap-1">
 <DollarSign className="w-4 h-4" />
 {item.listingPrice.toLocaleString()} {item.currency}
 </div>
 </TableCell>
 <TableCell>{getStatusBadge(item.status)}</TableCell>
 <TableCell className="text-slate-500">
 {item.availableFrom ? new Date(item.availableFrom).toLocaleDateString() : '-'}
 {item.availableTo && ` - ${new Date(item.availableTo).toLocaleDateString()}`}
 </TableCell>
 <TableCell className="text-slate-500">
 {new Date(item.createdAt).toLocaleDateString()}
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
 <DialogTitle>{t("admin_listing_edit_title","Edit Listing")}</DialogTitle>
 <DialogDescription>{t("admin_listing_edit_desc","Update listing details")}</DialogDescription>
 </DialogHeader>
 {editingItem && (
 <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_listing_status","Status")}</Label>
 <Select value={editingItem.status} onValueChange={(v) => setEditingItem({...editingItem, status: v as any})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="ACTIVE">{t("admin_listing_active","Active")}</SelectItem>
 <SelectItem value="INACTIVE">{t("admin_listing_inactive","Inactive")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_listing_pending","Pending")}</SelectItem>
 <SelectItem value="SOLD">{t("admin_listing_sold","Sold")}</SelectItem>
 <SelectItem value="RENTED">{t("admin_listing_rented","Rented")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_listing_price","Price")}</Label>
 <Input 
 type="number" 
 value={editingItem.listingPrice}
 onChange={(e) => setEditingItem({...editingItem, listingPrice: parseFloat(e.target.value)})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_listing_title","Title")}</Label>
 <Input 
 value={editingItem.title || ''}
 onChange={(e) => setEditingItem({...editingItem, title: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_listing_description","Description")}</Label>
 <Textarea 
 value={editingItem.description || ''}
 onChange={(e) => setEditingItem({...editingItem, description: e.target.value})}
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

export default ListingManagement;
