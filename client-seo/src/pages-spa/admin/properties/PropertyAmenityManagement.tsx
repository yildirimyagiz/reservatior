"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Plus, Home, Edit, Trash2, Star, Wifi, Car, Coffee, Dumbbell, Waves } from 'lucide-react';
import { Button } from"@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { apiClient } from '@/lib/api';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogDescription, DialogFooter } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Badge } from"@/components/ui/badge";
import { useState } from 'react';
import { useCountryGuard } from '@/lib/hooks/useCountryGuard';

interface PropertyAmenity {
 id: string;
 propertyId: string;
 amenityId: string;
 quantity?: number;
 isPrivate?: boolean;
 notes?: string;
 amenity?: {
 id: string;
 name: string;
 category: string;
 icon?: string;
 };
 property?: {
 id: string;
 name: string;
 };
}

const PropertyAmenityManagement = () => {
 const { t } = useTranslation();
 const { isFieldAllowed } = useCountryGuard(undefined);
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingItem, setEditingItem] = useState<PropertyAmenity | null>(null);
 const [newItem, setNewItem] = useState({ propertyId: '', amenityId: '', quantity: '1', isPrivate: false, notes: '' });

 const { data: amenitiesRes, isLoading } = useQuery({
 queryKey: ['admin-property-amenities'],
 queryFn: async () => {
 const res: any = await apiClient.get('/property-amenity');
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

 const { data: amenityTypesRes } = useQuery({
 queryKey: ['admin-amenity-types'],
 queryFn: async () => {
 const res: any = await apiClient.get('/amenity');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/property-amenity', data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-property-amenities'] });
 setIsAddModalOpen(false);
 setNewItem({ propertyId: '', amenityId: '', quantity: '1', isPrivate: false, notes: '' });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/property-amenity/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-property-amenities'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/property-amenity/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-property-amenities'] });
 setIsEditModalOpen(false);
 setEditingItem(null);
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate({
 ...newItem,
 quantity: parseInt(newItem.quantity) || 1,
 isPrivate: newItem.isPrivate
 });
 };

 const handleEditSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 if (editingItem) {
 updateMutation.mutate(editingItem);
 }
 };

 const openEditModal = (item: PropertyAmenity) => {
 setEditingItem(item);
 setIsEditModalOpen(true);
 };

 const getAmenityIcon = (category: string) => {
 const icons: Record<string, any> = {
 'WIFI': Wifi,
 'PARKING': Car,
 'KITCHEN': Coffee,
 'GYM': Dumbbell,
 'POOL': Waves,
 'DEFAULT': Star
 };
 return icons[category] || icons['DEFAULT'];
 };

 const amenities = amenitiesRes?.data || [];
 const properties = propertiesRes?.data || [];
 const amenityTypes = amenityTypesRes?.data || [];

 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
 {t("admin_property_amenities_title","Property Amenities Management")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_property_amenities_subtitle","Manage amenities and features for properties")}
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
 {t("common.add","Add Amenity")}
 </Button>
 </DialogTrigger>
 <DialogContent className="bg-card border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_property_amenities_add_title","Add Property Amenity")}</DialogTitle>
 <DialogDescription>{t("admin_property_amenities_add_desc","Assign an amenity to a property")}</DialogDescription>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
 <div className="space-y-2">
 <Label>{t("admin_property_amenities_property","Property")}</Label>
 <Select value={newItem.propertyId} onValueChange={(v) => setNewItem({...newItem, propertyId: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_property_amenities_select_property","Select property")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 {properties.map((p: any) => (
 <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_property_amenities_amenity","Amenity")}</Label>
 <Select value={newItem.amenityId} onValueChange={(v) => setNewItem({...newItem, amenityId: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_property_amenities_select_amenity","Select amenity")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 {amenityTypes.map((a: any) => (
 <SelectItem key={a.id} value={a.id}>{a.name}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_property_amenities_quantity","Quantity")}</Label>
 <Input 
 type="number" 
 value={newItem.quantity} 
 onChange={(e) => setNewItem({...newItem, quantity: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="flex items-center gap-2">
 <input 
 type="checkbox" 
 id="isPrivate"
 checked={newItem.isPrivate}
 onChange={(e) => setNewItem({...newItem, isPrivate: e.target.checked})}
 className="rounded"
 />
 <Label htmlFor="isPrivate">{t("admin_property_amenities_private","Private Amenity")}</Label>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_property_amenities_notes","Notes")}</Label>
 <Input 
 value={newItem.notes} 
 onChange={(e) => setNewItem({...newItem, notes: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_property_amenities_notes_placeholder","Optional notes")}
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

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2">
 <Home className="w-5 h-5" />
 {t("admin_property_amenities_list_title","Property Amenities")}
 </CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="text-center py-8 text-slate-500">{t("common.loading","Loading...")}</div>
 ) : amenities.length === 0 ? (
 <div className="text-center py-8 text-slate-500">{t("admin_property_amenities_empty","No amenities found")}</div>
 ) : (
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_property_amenities_property","Property")}</TableHead>
 <TableHead>{t("admin_property_amenities_amenity","Amenity")}</TableHead>
 <TableHead>{t("admin_property_amenities_quantity","Quantity")}</TableHead>
 <TableHead>{t("admin_property_amenities_type","Type")}</TableHead>
 <TableHead>{t("admin_property_amenities_notes","Notes")}</TableHead>
 <TableHead className="text-right">{t("common.actions","Actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {amenities.map((item: PropertyAmenity) => {
 const Icon = getAmenityIcon(item.amenity?.category || 'DEFAULT');
 return (
 <TableRow key={item.id}>
 <TableCell className="font-medium">{item.property?.name || '-'}</TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <Icon className="w-4 h-4 text-slate-500" />
 {item.amenity?.name || '-'}
 </div>
 </TableCell>
 <TableCell>{item.quantity || 1}</TableCell>
 <TableCell>
 <Badge variant={item.isPrivate ?"destructive" :"secondary"}>
 {item.isPrivate ? t("admin_property_amenities_private","Private") : t("admin_property_amenities_shared","Shared")}
 </Badge>
 </TableCell>
 <TableCell className="text-slate-500">{item.notes || '-'}</TableCell>
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
 );
 })}
 </TableBody>
 </Table>
 )}
 </CardContent>
 </Card>

 {/* Edit Modal */}
 <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
 <DialogContent className="bg-card border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_property_amenities_edit_title","Edit Property Amenity")}</DialogTitle>
 <DialogDescription>{t("admin_property_amenities_edit_desc","Update amenity details")}</DialogDescription>
 </DialogHeader>
 {editingItem && (
 <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
 <div className="space-y-2">
 <Label>{t("admin_property_amenities_quantity","Quantity")}</Label>
 <Input 
 type="number" 
 value={editingItem.quantity || 1}
 onChange={(e) => setEditingItem({...editingItem, quantity: parseInt(e.target.value)})}
 className="bg-card border-border"
 />
 </div>
 <div className="flex items-center gap-2">
 <input 
 type="checkbox" 
 id="editIsPrivate"
 checked={editingItem.isPrivate}
 onChange={(e) => setEditingItem({...editingItem, isPrivate: e.target.checked})}
 className="rounded"
 />
 <Label htmlFor="editIsPrivate">{t("admin_property_amenities_private","Private Amenity")}</Label>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_property_amenities_notes","Notes")}</Label>
 <Input 
 value={editingItem.notes || ''}
 onChange={(e) => setEditingItem({...editingItem, notes: e.target.value})}
 className="bg-card border-border"
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

export default PropertyAmenityManagement;
