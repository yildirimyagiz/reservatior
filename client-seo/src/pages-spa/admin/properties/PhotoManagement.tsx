"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Plus, Image as ImageIcon, Edit, Trash2, Eye, Star, Calendar, Download, Upload, Search } from 'lucide-react';
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

interface Photo {
 id: string;
 orgId: string;
 propertyId: string;
 url: string;
 caption?: string;
 order: number;
 isPrimary: boolean;
 isFeatured: boolean;
 category: string;
 width?: number;
 height?: number;
 fileSize?: number;
 mimeType?: string;
 uploadedAt: string;
 property?: {
 id: string;
 name: string;
 };
}

const PhotoManagement = () => {
 const { t } = useTranslation();
 const { isFieldAllowed } = useCountryGuard(undefined);
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingItem, setEditingItem] = useState<Photo | null>(null);
 const [searchQuery, setSearchQuery] = useState('');
 const [categoryFilter, setCategoryFilter] = useState<string>('ALL');
 const [newItem, setNewItem] = useState({ 
 propertyId: '', 
 url: '', 
 caption: '', 
 order: '0',
 isPrimary: false,
 isFeatured: false,
 category: 'EXTERIOR'
 });

 const { data: photosRes, isLoading } = useQuery({
 queryKey: ['admin-photos'],
 queryFn: async () => {
 const res: any = await apiClient.get('/photo');
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
 return apiClient.post('/photo', data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-photos'] });
 setIsAddModalOpen(false);
 setNewItem({ 
 propertyId: '', 
 url: '', 
 caption: '', 
 order: '0',
 isPrimary: false,
 isFeatured: false,
 category: 'EXTERIOR'
 });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/photo/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-photos'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/photo/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-photos'] });
 setIsEditModalOpen(false);
 setEditingItem(null);
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate({
 ...newItem,
 order: parseInt(newItem.order) || 0
 });
 };

 const handleEditSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 if (editingItem) {
 updateMutation.mutate(editingItem);
 }
 };

 const openEditModal = (item: Photo) => {
 setEditingItem(item);
 setIsEditModalOpen(true);
 };

 const getCategoryBadge = (category: string) => {
 const categoryConfig: Record<string, { color: string; label: string }> = {
 'EXTERIOR': { color: 'bg-blue-500/10 text-blue-400 border-blue-500/20', label: t('admin_photo_exterior', 'Exterior') },
 'INTERIOR': { color: 'bg-orange-500/10 text-orange-400 border-orange-500/20', label: t('admin_photo_interior', 'Interior') },
 'AMENITY': { color: 'bg-green-500/10 text-green-400 border-green-500/20', label: t('admin_photo_amenity', 'Amenity') },
 'FLOOR_PLAN': { color: 'bg-purple-500/10 text-purple-400 border-purple-500/20', label: t('admin_photo_floor_plan', 'Floor Plan') },
 'NEIGHBORHOOD': { color: 'bg-cyan-500/10 text-cyan-400 border-cyan-500/20', label: t('admin_photo_neighborhood', 'Neighborhood') }
 };
 const config = categoryConfig[category] || categoryConfig['EXTERIOR'];
 return <Badge className={config.color}>{config.label}</Badge>;
 };

 const formatFileSize = (bytes?: number) => {
 if (!bytes) return '-';
 const sizes = ['Bytes', 'KB', 'MB', 'GB'];
 const i = Math.floor(Math.log(bytes) / Math.log(1024));
 return Math.round(bytes / Math.pow(1024, i) * 100) / 100 + ' ' + sizes[i];
 };

 const photos = photosRes?.data || [];
 const properties = propertiesRes?.data || [];
 
 const filteredPhotos = photos.filter((item: Photo) => {
 const matchesSearch = item.property?.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
 item.caption?.toLowerCase().includes(searchQuery.toLowerCase());
 const matchesFilter = categoryFilter === 'ALL' || item.category === categoryFilter;
 return matchesSearch && matchesFilter;
 });

 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-400 to-slate-400">
 {t("admin_photo_title","Photo Management")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_photo_subtitle","Manage property photos and images")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-slate-100 dark:hover:bg-white/10">
 {t("common.export","Export")}
 </Button>
 <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
 <DialogTrigger asChild>
 <Button className="bg-slate-600 hover:bg-muted0 text-white">
 <Plus className="w-4 h-4 mr-2" />
 {t("common.add","Add Photo")}
 </Button>
 </DialogTrigger>
 <DialogContent className="bg-card border-border text-foreground max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_photo_add_title","Add New Photo")}</DialogTitle>
 <DialogDescription>{t("admin_photo_add_desc","Upload a new photo for a property")}</DialogDescription>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 py-4">
 <div className="space-y-2">
 <Label>{t("admin_photo_property","Property")}</Label>
 <Select value={newItem.propertyId} onValueChange={(v) => setNewItem({...newItem, propertyId: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue placeholder={t("admin_photo_select_property","Select property")} />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 {properties.map((p: any) => (
 <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_photo_url","Photo URL")}</Label>
 <Input 
 value={newItem.url} 
 onChange={(e) => setNewItem({...newItem, url: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_auto_https_example_com_photo_jpg", "https://example.com/photo.jpg")}
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_photo_caption","Caption")}</Label>
 <Textarea 
 value={newItem.caption} 
 onChange={(e) => setNewItem({...newItem, caption: e.target.value})}
 className="bg-card border-border"
 placeholder={t("admin_photo_caption_placeholder","Photo description")}
 rows={2}
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_photo_category","Category")}</Label>
 <Select value={newItem.category} onValueChange={(v) => setNewItem({...newItem, category: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="EXTERIOR">{t("admin_photo_exterior","Exterior")}</SelectItem>
 <SelectItem value="INTERIOR">{t("admin_photo_interior","Interior")}</SelectItem>
 <SelectItem value="AMENITY">{t("admin_photo_amenity","Amenity")}</SelectItem>
 <SelectItem value="FLOOR_PLAN">{t("admin_photo_floor_plan","Floor Plan")}</SelectItem>
 <SelectItem value="NEIGHBORHOOD">{t("admin_photo_neighborhood","Neighborhood")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_photo_order","Display Order")}</Label>
 <Input 
 type="number" 
 value={newItem.order} 
 onChange={(e) => setNewItem({...newItem, order: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="flex gap-4">
 <div className="flex items-center gap-2">
 <input 
 type="checkbox" 
 id="isPrimary"
 checked={newItem.isPrimary}
 onChange={(e) => setNewItem({...newItem, isPrimary: e.target.checked})}
 className="rounded"
 />
 <Label htmlFor="isPrimary">{t("admin_photo_primary","Primary Photo")}</Label>
 </div>
 <div className="flex items-center gap-2">
 <input 
 type="checkbox" 
 id="isFeatured"
 checked={newItem.isFeatured}
 onChange={(e) => setNewItem({...newItem, isFeatured: e.target.checked})}
 className="rounded"
 />
 <Label htmlFor="isFeatured">{t("admin_photo_featured","Featured")}</Label>
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
 <Select value={categoryFilter} onValueChange={setCategoryFilter}>
 <SelectTrigger className="w-40 bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="ALL">{t("common.all","All")}</SelectItem>
 <SelectItem value="EXTERIOR">{t("admin_photo_exterior","Exterior")}</SelectItem>
 <SelectItem value="INTERIOR">{t("admin_photo_interior","Interior")}</SelectItem>
 <SelectItem value="AMENITIES">{t("admin_photo_amenities","Amenities")}</SelectItem>
 <SelectItem value="FLOOR_PLAN">{t("admin_photo_floor_plan","Floor Plan")}</SelectItem>
 <SelectItem value="NEIGHBORHOOD">{t("admin_photo_neighborhood","Neighborhood")}</SelectItem>
 </SelectContent>
 </Select>
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="flex items-center gap-2">
 <ImageIcon className="w-5 h-5" />
 {t("admin_photo_list_title","Property Photos")}
 </CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="text-center py-8 text-slate-500">{t("common.loading","Loading...")}</div>
 ) : filteredPhotos.length === 0 ? (
 <div className="text-center py-8 text-slate-500">{t("admin_photo_empty","No photos found")}</div>
 ) : (
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_photo_preview","Preview")}</TableHead>
 <TableHead>{t("admin_photo_property","Property")}</TableHead>
 <TableHead>{t("admin_photo_category","Category")}</TableHead>
 <TableHead>{t("admin_photo_caption","Caption")}</TableHead>
 <TableHead>{t("admin_photo_order","Order")}</TableHead>
 <TableHead>{t("admin_photo_flags","Flags")}</TableHead>
 <TableHead>{t("admin_photo_info","Info")}</TableHead>
 <TableHead>{t("admin_photo_uploaded","Uploaded")}</TableHead>
 <TableHead className="text-right">{t("common.actions","Actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredPhotos.map((item: Photo) => (
 <TableRow key={item.id}>
 <TableCell>
 <div className="w-16 h-16 rounded-lg overflow-hidden bg-card">
 {item.url ? (
 <img src={item.url} alt={item.caption || ''} className="w-full h-full object-cover" />
 ) : (
 <div className="w-full h-full flex items-center justify-center text-slate-500">
 <ImageIcon className="w-6 h-6" />
 </div>
 )}
 </div>
 </TableCell>
 <TableCell className="font-medium">{item.property?.name || '-'}</TableCell>
 <TableCell>{getCategoryBadge(item.category)}</TableCell>
 <TableCell className="text-slate-500 max-w-xs truncate">{item.caption || '-'}</TableCell>
 <TableCell className="text-slate-500">{item.order}</TableCell>
 <TableCell>
 <div className="flex gap-1">
 {item.isPrimary && <Badge variant="outline" className="text-xs">{t("admin_photo_primary","Primary")}</Badge>}
 {item.isFeatured && <Badge variant="secondary" className="text-xs"><Star className="w-3 h-3 mr-1" />{t("admin_photo_featured","Featured")}</Badge>}
 </div>
 </TableCell>
 <TableCell className="text-slate-500 text-sm">
 <div>{item.width && item.height && `${item.width}x${item.height}`}</div>
 <div>{formatFileSize(item.fileSize)}</div>
 </TableCell>
 <TableCell className="text-slate-500 text-sm">
 <div className="flex items-center gap-1">
 <Calendar className="w-3 h-3" />
 {new Date(item.uploadedAt).toLocaleDateString()}
 </div>
 </TableCell>
 <TableCell className="text-right">
 <div className="flex justify-end gap-2">
 {item.url && (
 <Button variant="ghost" size="icon" onClick={() => window.open(item.url, '_blank')}>
 <Eye className="w-4 h-4" />
 </Button>
 )}
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
 <DialogTitle>{t("admin_photo_edit_title","Edit Photo")}</DialogTitle>
 <DialogDescription>{t("admin_photo_edit_desc","Update photo details")}</DialogDescription>
 </DialogHeader>
 {editingItem && (
 <form onSubmit={handleEditSubmit} className="space-y-4 py-4">
 <div className="space-y-2">
 <Label>{t("admin_photo_url","Photo URL")}</Label>
 <Input 
 value={editingItem.url}
 onChange={(e) => setEditingItem({...editingItem, url: e.target.value})}
 className="bg-card border-border"
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_photo_caption","Caption")}</Label>
 <Textarea 
 value={editingItem.caption || ''}
 onChange={(e) => setEditingItem({...editingItem, caption: e.target.value})}
 className="bg-card border-border"
 rows={2}
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_photo_category","Category")}</Label>
 <Select value={editingItem.category} onValueChange={(v) => setEditingItem({...editingItem, category: v})}>
 <SelectTrigger className="bg-card border-border">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border">
 <SelectItem value="EXTERIOR">{t("admin_photo_exterior","Exterior")}</SelectItem>
 <SelectItem value="INTERIOR">{t("admin_photo_interior","Interior")}</SelectItem>
 <SelectItem value="AMENITY">{t("admin_photo_amenity","Amenity")}</SelectItem>
 <SelectItem value="FLOOR_PLAN">{t("admin_photo_floor_plan","Floor Plan")}</SelectItem>
 <SelectItem value="NEIGHBORHOOD">{t("admin_photo_neighborhood","Neighborhood")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_photo_order","Display Order")}</Label>
 <Input 
 type="number"
 value={editingItem.order}
 onChange={(e) => setEditingItem({...editingItem, order: parseInt(e.target.value)})}
 className="bg-card border-border"
 />
 </div>
 </div>
 <div className="flex gap-4">
 <div className="flex items-center gap-2">
 <input 
 type="checkbox" 
 id="editIsPrimary"
 checked={editingItem.isPrimary}
 onChange={(e) => setEditingItem({...editingItem, isPrimary: e.target.checked})}
 className="rounded"
 />
 <Label htmlFor="editIsPrimary">{t("admin_photo_primary","Primary Photo")}</Label>
 </div>
 <div className="flex items-center gap-2">
 <input 
 type="checkbox" 
 id="editIsFeatured"
 checked={editingItem.isFeatured}
 onChange={(e) => setEditingItem({...editingItem, isFeatured: e.target.checked})}
 className="rounded"
 />
 <Label htmlFor="editIsFeatured">{t("admin_photo_featured","Featured")}</Label>
 </div>
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

export default PhotoManagement;
