"use client";

import React from 'react';
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { useTranslation } from"react-i18next";
import { Wrench, Plus, AlertTriangle, ShieldAlert, CheckCircle, Edit, Trash2 } from 'lucide-react';
import { Button } from"@/components/ui/button";
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { apiClient } from '@/lib/api';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogDescription, DialogFooter } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { useState } from 'react';

const MaintenanceManagement = () => {
 const { t } = useTranslation();
 const queryClient = useQueryClient();
 const [isAddModalOpen, setIsAddModalOpen] = useState(false);
 const [isEditModalOpen, setIsEditModalOpen] = useState(false);
 const [editingOrder, setEditingOrder] = useState<any>(null);
 const [newOrder, setNewOrder] = useState({ title: '', description: '', priority: 'HIGH', category: 'GENERAL' });

 const { data: ordersRes, isLoading } = useQuery({
 queryKey: ['admin-maintenance'],
 queryFn: async () => {
 const res: any = await apiClient.get('/maintenance-work-order');
 return res.data;
 }
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/maintenance-work-order', { 
 ...data, 
 propertyId: 'prop_1', 
 reportedBy: 'admin_user',
 reportedAt: new Date().toISOString()
 });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-maintenance'] });
 setIsAddModalOpen(false);
 setNewOrder({ title: '', description: '', priority: 'HIGH', category: 'GENERAL' });
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => {
 return apiClient.delete(`/maintenance-work-order/${id}`);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-maintenance'] });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.put(`/maintenance-work-order/${data.id}`, data);
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-maintenance'] });
 setIsEditModalOpen(false);
 setEditingOrder(null);
 }
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate(newOrder);
 };

 const handleEditSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 updateMutation.mutate(editingOrder);
 };

 const openEditModal = (order: any) => {
 setEditingOrder(order);
 setIsEditModalOpen(true);
 };

 const workOrders = ordersRes?.data || [];
 
 return (
 <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
 <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-red-400 to-orange-400">
 {t("admin_maintenance_title","Maintenance & Repairs")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_maintenance_subtitle","Track work orders, property damage, and predictive maintenance schedules")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-white/10">
 {t("common.export","Export Report")}
 </Button>
 <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
 <DialogTrigger asChild>
 <Button className="bg-red-600 hover:bg-red-700 text-foreground shadow-lg shadow-red-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_maintenance_create","Create Work Order")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_maintenance_create","Create Work Order")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="title">{t("admin_auto_issue_title", "Issue Title")}</Label>
 <Input 
 id="title" 
 className="bg-card border-border" 
 value={newOrder.title}
 onChange={e => setNewOrder({...newOrder, title: e.target.value})}
 required
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="description">{t("admin_auto_description", "Description")}</Label>
 <Input 
 id="description" 
 className="bg-card border-border" 
 value={newOrder.description}
 onChange={e => setNewOrder({...newOrder, description: e.target.value})}
 required
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label htmlFor="priority">{t("admin_auto_priority", "Priority")}</Label>
 <Input 
 id="priority" 
 className="bg-card border-border" 
 value={newOrder.priority}
 onChange={e => setNewOrder({...newOrder, priority: e.target.value})}
 placeholder="e.g. HIGH, MEDIUM"
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="category">{t("admin_auto_category", "Category")}</Label>
 <Input 
 id="category" 
 className="bg-card border-border" 
 value={newOrder.category}
 onChange={e => setNewOrder({...newOrder, category: e.target.value})}
 placeholder="e.g. PLUMBING"
 />
 </div>
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsAddModalOpen(false)}>Cancel</Button>
 <Button type="submit" className="bg-red-600 hover:bg-red-700" disabled={createMutation.isPending}>
 {createMutation.isPending ?"Creating..." :"Save Order"}
 </Button>
 </div>
 </form>
 </DialogContent>
 </Dialog>
 <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_maintenance_edit","Edit Work Order")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleEditSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="edit-title">{t("admin_auto_issue_title", "Issue Title")}</Label>
 <Input 
 id="edit-title" 
 className="bg-card border-border" 
 value={editingOrder?.title || ''}
 onChange={e => setEditingOrder({...editingOrder, title: e.target.value})}
 required
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="edit-description">{t("admin_auto_description", "Description")}</Label>
 <Input 
 id="edit-description" 
 className="bg-card border-border" 
 value={editingOrder?.description || ''}
 onChange={e => setEditingOrder({...editingOrder, description: e.target.value})}
 required
 />
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label htmlFor="edit-priority">{t("admin_auto_priority", "Priority")}</Label>
 <Input 
 id="edit-priority" 
 className="bg-card border-border" 
 value={editingOrder?.priority || ''}
 onChange={e => setEditingOrder({...editingOrder, priority: e.target.value})}
 placeholder="e.g. HIGH, MEDIUM"
 />
 </div>
 <div className="space-y-2">
 <Label htmlFor="edit-category">{t("admin_auto_category", "Category")}</Label>
 <Input 
 id="edit-category" 
 className="bg-card border-border" 
 value={editingOrder?.category || ''}
 onChange={e => setEditingOrder({...editingOrder, category: e.target.value})}
 placeholder="e.g. PLUMBING"
 />
 </div>
 </div>
 <div className="pt-4 flex justify-end gap-2">
 <Button type="button" variant="ghost" onClick={() => setIsEditModalOpen(false)}>Cancel</Button>
 <Button type="submit" className="bg-red-600 hover:bg-red-700" disabled={updateMutation.isPending}>
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
 <CardTitle className="text-sm font-medium text-slate-300">Open Tickets</CardTitle>
 <Wrench className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">312</div>
 <p className="text-xs text-muted-foreground mt-1">Pending dispatch</p>
 </CardContent>
 </Card>
 
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">In Progress</CardTitle>
 <AlertTriangle className="w-4 h-4 text-amber-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">84</div>
 <p className="text-xs text-amber-400 mt-1">Actively being worked</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Emergency</CardTitle>
 <ShieldAlert className="w-4 h-4 text-red-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">12</div>
 <p className="text-xs text-red-400 mt-1">Requires immediate action</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Resolved</CardTitle>
 <CheckCircle className="w-4 h-4 text-green-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">1,402</div>
 <p className="text-xs text-muted-foreground mt-1">This month</p>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_maintenance_list","Work Orders Board")}</CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("common.loading","Loading maintenance registry...")}
 </div>
 ) : workOrders.length === 0 ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 No work orders found.
 </div>
 ) : (
 <div className="rounded-xl border border-border">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-slate-300">Title</TableHead>
 <TableHead className="text-slate-300">Priority</TableHead>
 <TableHead className="text-slate-300">Category</TableHead>
 <TableHead className="text-slate-300">Status</TableHead>
 <TableHead className="text-slate-300 text-right">Actions</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {workOrders.map((w: any) => (
 <TableRow key={w.id} className="border-border hover:bg-card transition-colors">
 <TableCell className="font-medium text-foreground">{w.title}</TableCell>
 <TableCell className={`text-muted-foreground ${w.priority === 'EMERGENCY' ? 'text-red-400' : ''}`}>
 {w.priority}
 </TableCell>
 <TableCell className="text-muted-foreground">{w.category}</TableCell>
 <TableCell className="text-muted-foreground">
 <span className="px-2 py-1 bg-card rounded-full text-xs">
 {w.status}
 </span>
 </TableCell>
 <TableCell className="text-right">
 <Button 
 variant="ghost" 
 size="icon" 
 className="text-muted-foreground hover:text-white"
 onClick={() => openEditModal(w)}
 >
 <Edit className="w-4 h-4" />
 </Button>
 <Button 
 variant="ghost" 
 size="icon" 
 className="text-red-400 hover:text-red-300 hover:bg-red-400/10"
 onClick={() => deleteMutation.mutate(w.id)}
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

export default MaintenanceManagement;
