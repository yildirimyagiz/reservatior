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
 {t("admin_facilities_title","Facilities Management")}
 </h1>
 <p className="text-muted-foreground mt-2">
 {t("admin_facilities_subtitle","Monitor and configure amenities, common areas, and shared spaces")}
 </p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="bg-card border-border hover:bg-white/10">
 {t("common.export","Export")}
 </Button>
 <Dialog open={isAddModalOpen} onOpenChange={setIsAddModalOpen}>
 <DialogTrigger asChild>
 <Button className="bg-slate-600 hover:bg-slate-700 text-foreground shadow-lg shadow-slate-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_facilities_add","Add Facility")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_facilities_add","Add Facility")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="name">Facility Name</Label>
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
 <Label htmlFor="feeAmount">Fee Amount</Label>
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
 <Label htmlFor="feeCurrency">Currency</Label>
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
 <Button type="button" variant="ghost" onClick={() => setIsAddModalOpen(false)}>Cancel</Button>
 <Button type="submit" className="bg-slate-600 hover:bg-slate-700" disabled={createMutation.isPending}>
 {createMutation.isPending ?"Saving..." :"Save Facility"}
 </Button>
 </div>
 </form>
 </DialogContent>
 </Dialog>
 <Dialog open={isEditModalOpen} onOpenChange={setIsEditModalOpen}>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_facilities_edit","Edit Facility")}</DialogTitle>
 </DialogHeader>
 <form onSubmit={handleEditSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="edit-name">Facility Name</Label>
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
 <Label htmlFor="edit-feeAmount">Fee Amount</Label>
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
 <Label htmlFor="edit-feeCurrency">Currency</Label>
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
 <Button type="button" variant="ghost" onClick={() => setIsEditModalOpen(false)}>Cancel</Button>
 <Button type="submit" className="bg-slate-600 hover:bg-slate-700" disabled={updateMutation.isPending}>
 {updateMutation.isPending ?"Saving..." :"Save Changes"}
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
 <CardTitle className="text-sm font-medium text-slate-300">Registered Facilities</CardTitle>
 <Building className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">8,451</div>
 <p className="text-xs text-green-400 mt-1">Across 120 properties</p>
 </CardContent>
 </Card>
 
 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Shared Spaces</CardTitle>
 <Home className="w-4 h-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">1,240</div>
 <p className="text-xs text-muted-foreground mt-1">Pools, Gyms, Lounges</p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader className="flex flex-row items-center justify-between pb-2">
 <CardTitle className="text-sm font-medium text-slate-300">Under Maintenance</CardTitle>
 <Warehouse className="w-4 h-4 text-amber-400" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">34</div>
 <p className="text-xs text-muted-foreground mt-1">Currently offline</p>
 </CardContent>
 </Card>
 </div>

 <Card className="bg-card border-border backdrop-blur-sm">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_facilities_list","Facilities Index")}</CardTitle>
 </CardHeader>
 <CardContent>
 {isLoading ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("common.loading","Loading facilities data...")}
 </div>
 ) : facilities.length === 0 ? (
 <div className="flex items-center justify-center py-20 text-muted-foreground">
 {t("admin_facilities_noData","No facilities found.")}
 </div>
 ) : (
 <div className="rounded-xl border border-border">
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-slate-300">Name</TableHead>
 <TableHead className="text-slate-300">Property</TableHead>
 <TableHead className="text-slate-300">Fee Amount</TableHead>
 <TableHead className="text-slate-300 text-right">Actions</TableHead>
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
 size="icon" 
 className="text-muted-foreground hover:text-white"
 onClick={() => openEditModal(f)}
 >
 <Edit className="w-4 h-4" />
 </Button>
 <Button 
 variant="ghost" 
 size="icon" 
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
