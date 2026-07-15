"use client";

import React from 'react';
import { useMutation, useQuery, useQueryClient } from"@tanstack/react-query";
import { useState } from"react";
import { useNavigate } from"@/lib/react-router-shim";
import { useTranslation } from"react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Progress } from"@/components/ui/progress";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { Building, MapPin, Users, DollarSign, Calendar, TrendingUp, Filter, Search, Download, MoreHorizontal, Plus, Activity, Star, MessageSquare, FileText, CheckCircle, Clock, AlertTriangle, CreditCard, ShieldCheck, Zap, BarChart3, TrendingDown, Edit, ArrowRight } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
import { motion, AnimatePresence } from"framer-motion";
import { cn } from"@/lib/utils";
import { useCountryGuard } from"@/lib/hooks/useCountryGuard";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Label } from"@/components/ui/label";

interface AdminProperty {
 id: string;
 name: string;
 type: string;
 city: string;
 addressLine1: string;
 listingStatus: string;
 listingType?: string;
 listingPrice: number;
 bedrooms: number;
 bathrooms: number;
 areaSqm: number;
 legalComplianceStatus: string;
 occupancyRate?: number;
 revenue?: number;
 bookings?: any[];
 leads?: any[];
 expenses?: any[];
 events?: any[];
}
export default function AdminProperties() {
 const { t } = useTranslation();
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const navigate = useNavigate();
 const [editingId, setEditingId] = React.useState<string | null>(null);
 const [formData, setFormData] = React.useState({ title:"", type:"", price:"" });
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [isEditOpen, setIsEditOpen] = useState(false);
 const [searchTerm, setSearchTerm] = useState("");
 const [selectedProperty, setSelectedProperty] = useState<AdminProperty | null>(null);
 const [activeTab, setActiveTab] = useState("portfolio");
 const [listingFilter, setListingFilter] = useState("ALL");

 const { isFieldAllowed } = useCountryGuard(undefined);

 const { data: properties = [], isLoading } = useQuery({
 queryKey: ['admin-properties'],
 queryFn: async () => {
 const response = await apiClient.get('/property') as { data: any[] };
 return response.data.map(p => ({
 ...p,
 occupancyRate: Math.floor(Math.random() * 40) + 60,
 revenue: Math.floor(Math.random() * 50000) + 10000
 }));
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/admin/adminproperties/${data.id}`, data),
 onSuccess: () => { toast({ title:"Updated", description:"Record updated successfully" }); queryClient.invalidateQueries({ queryKey: ['admin-properties'] }); setEditingId(null); setIsEditOpen(false); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const openEditModal = (property: AdminProperty) => {
 setEditingId(property.id);
 setFormData({
 title: property.name,
 type: property.type,
 price: property.listingPrice.toString()
 });
 setSelectedProperty(property);
 setIsEditOpen(true);
 };

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/admin/adminproperties/${id}`),
 onSuccess: () => { toast({ title:"Deleted", description:"Record deleted successfully" }); queryClient.invalidateQueries({ queryKey: ['admin-properties'] }); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return await apiClient.post('/properties', data);
 },
 onSuccess: () => {
 setIsAddOpen(false);
 queryClient.invalidateQueries({ queryKey: ['admin-properties'] });
 toast({ title:"Success", description:"Property created successfully" });
 },
 onError: (err: any) => {
 toast({ title:"Error", description: err.message, variant:"destructive" });
 }
 });

 const archiveMutation = useMutation({
 mutationFn: async (propertyId: string) => {
 await apiClient.patch(`/property/${propertyId}`, { listingStatus: 'SOLD' });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['admin-properties'] });
 toast({ title: t('success'), description: t('admin_property_archiveSuccess', 'Property has been archived successfully.') });
 },
 onError: () => {
 toast({ title: t('error'), description: t('admin_property_archiveFailed', 'Failed to archive property.'), variant:"destructive" });
 }
 });

 const brochureMutation = useMutation({
 mutationFn: async (propertyId: string) => {
 await apiClient.post('/crm/generate-brochure', { propertyId });
 },
 onSuccess: () => {
 toast({ title: t('admin_brochure_title',"AI Brochure"), description: t('admin_brochure_success',"AI brochure generation triggered. You will be notified via email.") });
 },
 onError: () => {
 toast({ title: t('error'), description: t('admin_brochure_error',"Failed to generate brochure."), variant:"destructive" });
 }
 });

 const getStatusColor = (status: string) => {
 switch (status.toUpperCase()) {
 case 'AVAILABLE': return 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20';
 case 'SOLD': return 'bg-muted0/10 text-muted-foreground border-slate-500/20';
 case 'PENDING': return 'bg-orange-500/10 text-orange-400 border-orange-500/20';
 case 'RENTED': return 'bg-muted0/10 text-muted-foreground border-slate-500/20';
 default: return 'bg-muted0/10 text-muted-foreground border-slate-500/20';
 }
 };
 const getLocalizedStatus = (status: string) => {
 const map: Record<string, string> = {
 'AVAILABLE': t('admin_property_available', 'Müsait'),
 'SOLD': t('admin_property_sold', 'Satıldı'),
 'PENDING': t('admin_property_pending', 'Bekliyor'),
 'RENTED': t('admin_property_rented', 'Kiralandı')
 };
 return map[status.toUpperCase()] || status;
 };
 const getLocalizedType = (type: string) => {
 if (!type) return '--';
 const key = `client.property.types.${type}`;
 const translated = t(key);
 return translated !== key ? translated : type;
 };
 const getComplianceBadge = (status: string) => {
 switch (status.toUpperCase()) {
 case 'VERIFIED': return <Badge className="bg-emerald-500/20 text-emerald-400 border-none gap-1 font-bold leading-none"><ShieldCheck className="w-3 h-3" /> {t('success')}</Badge>;
 case 'PENDING': return <Badge className="bg-orange-500/20 text-orange-400 border-none gap-1 font-bold leading-none"><Clock className="w-3 h-3" /> {t('admin_plans_status_pending')}</Badge>;
 case 'FAILED': return <Badge className="bg-red-500/20 text-red-400 border-none gap-1 font-bold leading-none"><AlertTriangle className="w-3 h-3" /> {t('failed')}</Badge>;
 default: return <Badge className="bg-muted0/20 text-muted-foreground border-none font-bold leading-none">{status}</Badge>;
 }
 };
 const filteredProperties = properties.filter(p => {
 const matchesSearch = p.name.toLowerCase().includes(searchTerm.toLowerCase()) || p.city.toLowerCase().includes(searchTerm.toLowerCase());
 const matchesFilter = listingFilter ==="ALL" || p.listingType === listingFilter;
 return matchesSearch && matchesFilter;
 });
 const stats = {
 totalProperties: properties.length,
 activeListings: properties.filter(p => p.listingStatus === 'AVAILABLE').length,
 totalRevenue: properties.reduce((acc, p) => acc + (p.revenue || 0), 0),
 avgOccupancy: properties.length > 0 ? (properties.reduce((acc, p) => acc + (p.occupancyRate || 0), 0) / properties.length).toFixed(1) : 0
 };
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen bg-background">
 <div className="p-6 space-y-10 pb-20">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t('admin_properties_title')}</h1>
 <p className="text-sm text-muted-foreground mt-1">{t('admin_properties_description')}</p>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all">
 <Building className="w-12 h-12 text-foreground" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('globalAssets')}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">{stats.totalProperties}</h3>
 <p className="text-[10px] font-bold text-emerald-400 mt-4 flex items-center gap-1">
 <TrendingUp className="w-3 h-3" /> {t('vsPrevMonth', { count: 2 })}
 </p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-emerald-500">
 <DollarSign className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('projectedYield')}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">{t("currency_symbol", "$")}{stats.totalRevenue.toLocaleString()}</h3>
 <p className="text-[10px] font-bold text-orange-400 mt-4 flex items-center gap-1">
 <Clock className="w-3 h-3" /> {t('propertyNextpayout', { days: 4 })}
 </p>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
 <Zap className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('propertyAvgoccupancy')}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">{stats.avgOccupancy}%</h3>
 <div className="mt-4 h-1.5 w-full bg-white/10 rounded-full overflow-hidden">
 <div className="h-full bg-slate-600 rounded-full shadow-[0_0_10px_#7c3aed]" style={{ width: `${stats.avgOccupancy}%` }}></div>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group">
 <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
 <Clock className="w-12 h-12" />
 </div>
 <CardContent className="p-8">
 <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('pendingRequests')}</p>
 <h3 className="text-xl font-bold text-foreground leading-none">24</h3>
 <p className="text-[10px] font-bold text-muted-foreground mt-4 flex items-center gap-2">
 {t('requestsSummary', { leads: 12, bookings: 8, repairs: 4 })}
 </p>
 </CardContent>
 </Card>
 </div>

 <div className="grid grid-cols-1 xl:grid-cols-12 gap-8">
 <div className="xl:col-span-3 space-y-6">
 <Card className="bg-card backdrop-blur-xl border-border rounded-4xl overflow-hidden shadow-2xl">
 <CardHeader className="p-6 border-b border-border">
 <CardTitle className="text-xs font-bold text-foreground flex items-center gap-2">
 <Activity className="w-4 h-4 text-orange-500" /> {t('adminCommand')}
 </CardTitle>
 </CardHeader>
 <div className="p-4 space-y-2">
 {[{ label:"Escrow Havuzu", icon: ShieldCheck, path:"/admin/escrow" },
 { label: t('commissionTax'), icon: DollarSign, path:"/admin/financial-reports" },
 { label: t('expenseLedger'), icon: CreditCard, path:"/admin/expenses" },
 { label: t('maintenanceEvents'), icon: Calendar, path:"/admin/maintenance" },
 { label: t('propertyInventory'), icon: Building, path:"/admin/inventory" },
 { label: t('complianceHub'), icon: ShieldCheck, path:"/admin/compliance" },
 { label: t('leadsProspects'), icon: Users, path:"/admin/leads" }].map((item, i) => <Button key={i} variant="ghost" onClick={() => window.location.href = item.path} className="w-full justify-between h-14 rounded-2xl px-4 hover:bg-card text-muted-foreground hover:text-foreground transition-all group">
 <div className="flex items-center gap-3">
 <div className="p-2 bg-card rounded-xl group-hover:scale-110 transition-all">
 <item.icon className="w-4 h-4" />
 </div>
 <span className="text-xs font-bold tracking-tight">{item.label}</span>
 </div>
 <ArrowRight className="w-4 h-4 opacity-0 group-hover:opacity-100 transition-all" />
 </Button>)}
 </div>
 </Card>

 <Card className="bg-gradient-to-br from-slate-600/20 to-transparent border-border rounded-4xl p-8 relative overflow-hidden shadow-2xl">
 <div className="relative z-10 space-y-4">
 <Star className="w-10 h-10 text-muted-foreground" />
 <h4 className="text-xl font-bold text-foreground">{t('admin_properties_ai_insight_title')}</h4>
 <p className="text-xs text-muted-foreground font-medium leading-relaxed">
 {t('admin_properties_ai_insight_description', { percent:"12.5" })}
 </p>
 <Button className="w-full bg-slate-600 hover:bg-muted0 text-foreground font-bold h-12 rounded-2xl text-[10px] shadow-xl shadow-slate-600/20">{t('viewAnalytics')}</Button>
 </div>
 <Activity className="absolute -bottom-10 -right-10 w-40 h-40 text-muted-foreground/5 rotate-12" />
 </Card>
 </div>

 <div className="xl:col-span-9 space-y-6">
 <Tabs defaultValue="ALL" value={listingFilter} onValueChange={setListingFilter} className="w-full">
 <TabsList className="bg-card border border-border p-1 rounded-2xl h-14 mb-4">
 <TabsTrigger value="ALL" className="rounded-xl h-10 px-6 data-[state=active]:bg-emerald-600 data-[state=active]:text-white transition-all text-xs font-bold tracking-widest text-muted-foreground">{t("admin_auto_t_m_i_lanlar", "TÜM İLANLAR")}</TabsTrigger>
 <TabsTrigger value="SALE" className="rounded-xl h-10 px-6 data-[state=active]:bg-emerald-600 data-[state=active]:text-white transition-all text-xs font-bold tracking-widest text-muted-foreground">{t("admin_auto_satilik", "SATILIK")}</TabsTrigger>
 <TabsTrigger value="RENT" className="rounded-xl h-10 px-6 data-[state=active]:bg-emerald-600 data-[state=active]:text-white transition-all text-xs font-bold tracking-widest text-muted-foreground">{t("admin_auto_ki_ralik", "KİRALIK")}</TabsTrigger>
 <TabsTrigger value="BOOKING" className="rounded-xl h-10 px-6 data-[state=active]:bg-emerald-600 data-[state=active]:text-white transition-all text-xs font-bold tracking-widest text-muted-foreground">{t("admin_auto_g_nl_k_otel", "GÜNLÜK / OTEL")}</TabsTrigger>
 </TabsList>
 </Tabs>

 <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 px-4">
 <div className="relative flex-1 max-w-md group">
 <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-orange-500 transition-colors" />
 <Input placeholder={t('searchPlaceholder')} className="bg-card border-border rounded-2xl pl-12 h-14 text-foreground focus:ring-orange-500/20 focus:border-orange-500/40 transition-all font-medium shadow-2xl" value={searchTerm} onChange={e => setSearchTerm(e.target.value)} />
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="h-14 px-6 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground hover:bg-slate-100 dark:hover:bg-white/10 gap-2">
 <Filter className="w-4 h-4" /> {t('commonFilter')}
 </Button>
 <Button variant="outline" className="h-14 px-6 rounded-2xl border-border bg-card text-muted-foreground hover:text-foreground hover:bg-slate-100 dark:hover:bg-white/10 gap-2">
 <Download className="w-4 h-4" /> {t('commonExport')}
 </Button>
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button className="h-14 px-8 rounded-2xl bg-orange-600 hover:bg-orange-500 text-foreground font-bold text-[10px] shadow-xl shadow-orange-600/30 gap-2">
 <Plus className="w-4 h-4" /> {t('addAsset')}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-card border-border text-foreground">
 <DialogHeader>
 <DialogTitle className="text-foreground">{t("admin_auto_create_new_property", "Create New Property")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">{t("admin_auto_enter_the_details_for_the_new_property", "Enter the details for the new property.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="title" className="text-right text-xs text-muted-foreground">{t("admin_auto_title", "Title")}</Label>
 <Input id="title" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.title} onChange={e => setFormData({ ...formData, title: e.target.value })} placeholder={t("admin_auto_enter_title", "Enter title")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="type" className="text-right text-xs text-muted-foreground">{t("admin_auto_property_type", "Property Type")}</Label>
 <Input id="type" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.type} onChange={e => setFormData({ ...formData, type: e.target.value })} placeholder={t("admin_auto_enter_property_type", "Enter property type")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="price" className="text-right text-xs text-muted-foreground">{t("admin_auto_price", "Price")}</Label>
 <Input id="price" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.price} onChange={e => setFormData({ ...formData, price: e.target.value })} placeholder={t("admin_auto_enter_price", "Enter price")} />
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" className="border-border text-foreground bg-card" onClick={() => setIsAddOpen(false)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button onClick={() => createMutation.mutate(formData)} disabled={createMutation.isPending} className="bg-orange-600 hover:bg-orange-500 text-foreground">
 {createMutation.isPending ?"Saving..." :"Save Changes"}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 <Dialog open={isEditOpen} onOpenChange={setIsEditOpen}>
 <DialogContent className="sm:max-w-[425px] bg-card border-border text-foreground">
 <DialogHeader>
 <DialogTitle className="text-foreground">{t("admin_auto_edit_property", "Edit Property")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">{t("admin_auto_update_the_property_details", "Update the property details.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-title" className="text-right text-xs text-muted-foreground">{t("admin_auto_title", "Title")}</Label>
 <Input id="edit-title" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.title} onChange={e => setFormData({ ...formData, title: e.target.value })} placeholder={t("admin_auto_enter_title", "Enter title")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-type" className="text-right text-xs text-muted-foreground">{t("admin_auto_property_type", "Property Type")}</Label>
 <Input id="edit-type" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.type} onChange={e => setFormData({ ...formData, type: e.target.value })} placeholder={t("admin_auto_enter_property_type", "Enter property type")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-price" className="text-right text-xs text-muted-foreground">{t("admin_auto_price", "Price")}</Label>
 <Input id="edit-price" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.price} onChange={e => setFormData({ ...formData, price: e.target.value })} placeholder={t("admin_auto_enter_price", "Enter price")} />
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" className="border-border text-foreground bg-card" onClick={() => setIsEditOpen(false)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button onClick={() => updateMutation.mutate({ id: editingId, ...formData })} disabled={updateMutation.isPending} className="bg-orange-600 hover:bg-orange-500 text-foreground">
 {updateMutation.isPending ?"Saving..." :"Save Changes"}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </div>

 <Card className="bg-card border-border rounded-4xl overflow-hidden shadow-2xl relative">
 <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-orange-600 via-transparent to-transparent opacity-50"></div>
 <CardContent className="p-0">
 <div className="overflow-x-auto">
 <Table>
 <TableHeader className="bg-card border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-[10px] font-bold text-muted-foreground py-6 px-8">{t('propertyAssetprofile')}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t('performanceYield')}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-center">{t('propertyRequests')}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8">{t('propertyCompliance')}</TableHead>
 <TableHead className="text-[10px] font-bold text-muted-foreground px-8 text-right">{t('admin_property_actions')}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {isLoading ? <TableRow>
 <TableCell colSpan={5} className="py-20 text-center">
 <Activity className="w-8 h-8 text-orange-500 animate-spin mx-auto mb-4 opacity-50" />
 <p className="text-[10px] font-bold text-muted-foreground animate-pulse">{t('propertySyncing')}</p>
 </TableCell>
 </TableRow> : filteredProperties.length === 0 ? <TableRow>
 <TableCell colSpan={5} className="py-20 text-center">
 <p className="text-[10px] font-bold text-muted-foreground">{t('noAssets')}</p>
 </TableCell>
 </TableRow> : filteredProperties.map(property => <TableRow key={property.id} className="border-b border-border hover:bg-card transition-all group">
 <TableCell className="py-8 px-8">
 <div className="flex items-center gap-6">
 <div className="w-16 h-16 bg-card border border-border rounded-2xl flex items-center justify-center group-hover:scale-105 transition-all overflow-hidden relative">
 <Building className="w-8 h-8 text-slate-600" />
 </div>
 <div className="space-y-1">
 <h4 className="text-lg font-bold text-foreground leading-tight">{property.name}</h4>
 <p className="text-[10px] font-bold text-muted-foreground flex items-center gap-1 leading-none">
 <MapPin className="w-3 h-3 text-orange-500" /> {property.city}
 </p>
 <div className="flex gap-2 mt-3 flex-wrap">
 <Badge className={cn("text-[9px] font-bold px-2", getStatusColor(property.listingStatus))}>
 {getLocalizedStatus(property.listingStatus)}
 </Badge>
 <Badge variant="outline" className="text-[9px] font-bold text-muted-foreground border-border px-2">{getLocalizedType(property.type)}</Badge>
 </div>
 </div>
 </div>
 </TableCell>
 <TableCell className="px-8">
 <div className="space-y-3 min-w-[200px]">
 <div className="flex justify-between items-end">
 <span className="text-[10px] font-bold text-muted-foreground">{t("admin_property_yield_dna")}</span>
 <span className="text-sm font-bold text-emerald-400">{t("currency_symbol", "$")}{property.revenue?.toLocaleString()}</span>
 </div>
 <div className="flex justify-between items-end">
 <span className="text-[10px] font-bold text-muted-foreground">{t("admin_property_occupancy")}</span>
 <span className="text-xs font-bold text-foreground">{property.occupancyRate}%</span>
 </div>
 <Progress value={property.occupancyRate} className="h-1 bg-white/10 [&>div]:bg-emerald-500" />
 </div>
 </TableCell>
 <TableCell className="px-8 text-center">
 <div className="flex justify-center gap-4">
 <div className="flex flex-col items-center">
 <span className="text-xl font-bold text-foreground leading-none">8</span>
 <span className="text-[9px] font-bold text-muted-foreground mt-1">{t('newLeads')}</span>
 </div>
 <div className="flex flex-col items-center">
 <span className="text-xl font-bold text-foreground leading-none">{t("client.pricing.tiers.enterprise.3", "3")}</span>
 <span className="text-[9px] font-bold text-muted-foreground mt-1">{t('activeBookings')}</span>
 </div>
 </div>
 </TableCell>
 <TableCell className="px-8">
 {getComplianceBadge(property.legalComplianceStatus)}
 </TableCell>
 <TableCell className="px-8 text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-12 w-12 rounded-2xl hover:bg-card text-muted-foreground hover:text-foreground transition-all">
 <MoreHorizontal className="w-5 h-5" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-card border-border rounded-2xl shadow-2xl p-2 min-w-[180px]">
 <DropdownMenuLabel className="text-[10px] font-bold text-muted-foreground p-3">{t('administrative')}</DropdownMenuLabel>
 <DropdownMenuItem onClick={() => openEditModal(property)} className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
 <Edit className="w-4 h-4 mr-3 text-orange-500" /> {t('editMetadata')}
 </DropdownMenuItem>
 <DropdownMenuItem onClick={() => navigate('/admin/leads')} className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
 <Users className="w-4 h-4 mr-3 text-muted-foreground" /> {t('manageRequests')}
 </DropdownMenuItem>
 <DropdownMenuItem onClick={() => brochureMutation.mutate(property.id)} className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
 <FileText className="w-4 h-4 mr-3 text-[#C5A059]" /> {t('admin_brochure_generate', 'Generate AI Brochure')}
 </DropdownMenuItem>
 <DropdownMenuItem onClick={() => navigate('/admin/financial-reports')} className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
 <DollarSign className="w-4 h-4 mr-3 text-emerald-400" /> {t('viewPL')}
 </DropdownMenuItem>
 <DropdownMenuItem onClick={() => navigate('/admin/maintenance')} className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
 <Calendar className="w-4 h-4 mr-3 text-muted-foreground" /> {t('scheduleMaintenance')}
 </DropdownMenuItem>
 <DropdownMenuSeparator className="bg-white/10" />
 <DropdownMenuItem onClick={() => archiveMutation.mutate(property.id)} className="rounded-xl px-4 py-3 text-[10px] font-bold text-red-400 hover:text-red-300 hover:bg-red-400/5 transition-all cursor-pointer">
 {t('archiveAsset')}
 </DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>

 <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
 <Card className="bg-card border-border rounded-4xl p-10 overflow-hidden shadow-2xl relative group">
 <BarChart3 className="absolute -right-10 -top-10 w-48 h-48 text-orange-500/5 group-hover:scale-110 transition-all duration-1000" />
 <div className="relative z-10 space-y-8">
 <div className="flex items-center gap-4">
 <div className="p-4 bg-orange-600/10 border border-orange-500/20 rounded-3xl">
 <TrendingUp className="w-10 h-10 text-orange-400" />
 </div>
 <div>
 <h3 className="text-3xl font-bold text-foreground">{t('admin_properties_velocity_title')}</h3>
 <p className="text-[10px] font-bold text-muted-foreground">{t('admin_properties_velocity_description')}</p>
 </div>
 </div>
 <div className="grid grid-cols-3 gap-6">
 <div className="space-y-4">
 <div className="flex items-center gap-2">
 <Users className="w-4 h-4 text-muted-foreground" />
 <span className="text-[10px] font-bold text-muted-foreground">{t('newLeads')}</span>
 </div>
 <div className="flex items-end gap-2">
 <span className="text-3xl font-bold text-foreground">142</span>
 <span className="text-[10px] font-bold text-emerald-400 mb-1">+12%</span>
 </div>
 <Progress value={78} className="h-1 bg-white/10 [&>div]:bg-muted0" />
 </div>
 <div className="space-y-4">
 <div className="flex items-center gap-2">
 <Zap className="w-4 h-4 text-muted-foreground" />
 <span className="text-[10px] font-bold text-muted-foreground">{t('conversions')}</span>
 </div>
 <div className="flex items-end gap-2">
 <span className="text-3xl font-bold text-foreground">84</span>
 <span className="text-[10px] font-bold text-emerald-400 mb-1">+8%</span>
 </div>
 <Progress value={62} className="h-1 bg-white/10 [&>div]:bg-muted0" />
 </div>
 <div className="space-y-4">
 <div className="flex items-center gap-2">
 <Clock className="w-4 h-4 text-orange-400" />
 <span className="text-[10px] font-bold text-muted-foreground">{t('avgReplyTime')}</span>
 </div>
 <div className="flex items-end gap-2">
 <span className="text-3xl font-bold text-foreground">{t("admin_property_12m")}</span>
 <span className="text-[10px] font-bold text-emerald-400 mb-1">{t("admin_property_2m")}</span>
 </div>
 <Progress value={45} className="h-1 bg-white/10 [&>div]:bg-orange-500" />
 </div>
 </div>
 <Button variant="ghost" className="text-[10px] font-bold text-muted-foreground hover:text-foreground flex items-center gap-2 px-0">
 {t('viewPipeline')} <ArrowRight className="w-4 h-4" />
 </Button>
 </div>
 </Card>

 <Card className="bg-card border-border rounded-4xl p-10 overflow-hidden shadow-2xl relative group">
 <CreditCard className="absolute -right-10 -top-10 w-48 h-48 text-emerald-500/5 group-hover:scale-110 transition-all duration-1000" />
 <div className="relative z-10 space-y-8">
 <div className="flex items-center gap-4">
 <div className="p-4 bg-emerald-600/10 border border-emerald-500/20 rounded-3xl">
 <DollarSign className="w-10 h-10 text-emerald-400" />
 </div>
 <div>
 <h3 className="text-3xl font-bold text-foreground">{t('admin_properties_financial_title')}</h3>
 <p className="text-[10px] font-bold text-muted-foreground">{t('admin_properties_financial_description')}</p>
 </div>
 </div>
 <div className="space-y-6">
 <div className="flex justify-between items-center group">
 <div className="flex items-center gap-3">
 <div className="w-1.5 h-1.5 rounded-full bg-emerald-500 border border-emerald-400/50"></div>
 <span className="text-[10px] font-bold text-muted-foreground tracking-tight">{t('netOperatingIncome')}</span>
 </div>
 <span className="text-lg font-bold text-foreground leading-none font-mono">$842,000</span>
 </div>
 <div className="flex justify-between items-center group">
 <div className="flex items-center gap-3">
 <div className="w-1.5 h-1.5 rounded-full bg-red-500 border border-red-400/50"></div>
 <span className="text-[10px] font-bold text-muted-foreground tracking-tight">{t('totalMonthlyExpenses')}</span>
 </div>
 <span className="text-lg font-bold text-muted-foreground leading-none font-mono">$114,200</span>
 </div>
 <div className="flex justify-between items-center group">
 <div className="flex items-center gap-3">
 <div className="w-1.5 h-1.5 rounded-full bg-muted0 border border-slate-400/50"></div>
 <span className="text-[10px] font-bold text-muted-foreground tracking-tight">{t('pendingCommissions')}</span>
 </div>
 <span className="text-lg font-bold text-muted-foreground leading-none font-mono">$42,500</span>
 </div>
 <div className="flex justify-between items-center group">
 <div className="flex items-center gap-3">
 <div className="w-1.5 h-1.5 rounded-full bg-orange-500 border border-orange-400/50"></div>
 <span className="text-[10px] font-bold text-muted-foreground tracking-tight">{t('taxLiability')}</span>
 </div>
 <span className="text-lg font-bold text-muted-foreground leading-none font-mono">$12,800</span>
 </div>
 </div>
 <div className="pt-4 border-t border-border flex gap-4">
 <Button className="flex-1 bg-emerald-600 hover:bg-emerald-500 text-foreground font-bold h-12 rounded-2xl text-[10px] shadow-xl shadow-emerald-600/20">{t('executeDisbursements')}</Button>
 <Button variant="outline" className="flex-1 border-border text-muted-foreground hover:text-foreground h-12 rounded-2xl text-[10px] group">{t('viewFullLedger')}</Button>
 </div>
 </div>
 </Card>
 </div>
 </div>
 </div>;
}
