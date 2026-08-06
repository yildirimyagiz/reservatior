"use client";

import React from 'react';
import { apiClient } from"@/lib/api/client";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { useTranslation } from"react-i18next";
import { useState } from"react";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Megaphone, Users, Target, TrendingUp, BarChart3, Eye, Plus, Search, Mail, Phone, Star } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Label } from"@/components/ui/label";
import { MoreHorizontal, Edit, Trash2 } from"lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";

export type CampaignStatus = 'DRAFT' | 'PLANNED' | 'ACTIVE' | 'PAUSED' | 'COMPLETED' | 'CANCELLED';
export type AmbassadorStatus = 'PROSPECT' | 'CONTACTED' | 'NEGOTIATING' | 'SIGNED' | 'ACTIVE' | 'INACTIVE' | 'RESTRICTED';
export type AmbassadorCategory = 'CELEBRITY' | 'MACRO' | 'MICRO' | 'NANO' | 'COMMUNITY' | 'CUSTOMER';
export type ContractStatus = 'DRAFT' | 'REVIEW' | 'APPROVED' | 'SIGNING' | 'ACTIVE' | 'EXPIRING' | 'RENEWED' | 'TERMINATED' | 'ARCHIVED';

interface MarketingCampaign {
 id: string;
 orgId: string;
 ambassadorId: string;
 name: string;
 description?: string;
 startDate?: string;
 endDate?: string;
 budget?: number;
 actualSpend?: number;
 currency: string;
 status: CampaignStatus;
 targetReach?: number;
 actualReach?: number;
 impressions?: number;
 clicks?: number;
 conversions?: number;
 conversionValue?: number;
 roi?: number;
 platforms: string[];
}

interface BrandAmbassador {
 id: string;
 orgId: string;
 fullName: string;
 emailCiphertext?: string;
 phoneCiphertext?: string;
 category: AmbassadorCategory;
 platform: string[];
 followerCount?: number;
 engagementRate?: number;
 contractStart?: string;
 contractEnd?: string;
 equityPercent?: number;
 upfrontFee?: number;
 currency: string;
 tier?: string;
 status: AmbassadorStatus;
 agencyName?: string;
 agencyContact?: string;
 ndaSigned: boolean;
 ndaSignedAt?: string;
 notes?: string;
 actualReach?: number;
 totalRoi?: number;
 createdAt: string;
 updatedAt: string;
}

interface AmbassadorContract {
 id: string;
 orgId?: string;
 ambassadorId: string;
 version: number;
 equityPercent?: number;
 upfrontFee?: number;
 currency: string;
 startDate: string;
 endDate?: string;
 signedAt?: string;
 documentUrl?: string;
 status: ContractStatus;
 notes?: string;
 createdAt: string;
 updatedAt: string;
 ambassadorName?: string;
}

export default function MarketingAutomation() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const { t } = useTranslation();
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [formData, setFormData] = React.useState({ name:"", type:"", status:"" });
 const [searchTerm, setSearchTerm] = useState("");
 const [statusFilter, setStatusFilter] = useState("ALL");

 const { data: { campaigns = [], ambassadors = [], contracts = [] } = {}, isLoading } = useQuery({
 queryKey: ['marketing-data'],
 queryFn: async () => {
 const [campaignsRes, ambassadorsRes, contractsRes] = await Promise.all([
 apiClient.get('/marketing-campaign') as Promise<{ data: MarketingCampaign[] }>,
 apiClient.get('/brand-ambassador') as Promise<{ data: BrandAmbassador[] }>,
 apiClient.get('/ambassador-contract') as Promise<{ data: AmbassadorContract[] }>,
 ]);
 return {
 campaigns: campaignsRes.data || [],
 ambassadors: ambassadorsRes.data || [],
 contracts: contractsRes.data || [],
 };
 },
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 const res = await apiClient.post('/marketing-campaigns', data);
 return res;
 },
 onSuccess: () => {
 setIsAddOpen(false);
 queryClient.invalidateQueries({ queryKey: ['marketing-data'] });
 toast({ title:"Success", description:"Campaign created successfully" });
 },
 onError: (err: any) => {
 toast({ title:"Error", description: err.message, variant:"destructive" });
 }
 });

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/marketing-campaigns/${data.id}`, data),
 onSuccess: () => {
 toast({ title:"Updated", description:"Record updated successfully" });
 queryClient.invalidateQueries({ queryKey: ['marketing-data'] });
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/marketing-campaigns/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries({ queryKey: ['marketing-data'] });
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const getLocalizedStatus = (status: string) => {
 const map: Record<string, string> = {
 'DRAFT': t('admin_marketing_status_draft', 'Taslak'),
 'PLANNED': t('admin_marketing_status_planned', 'Planlandi'),
 'ACTIVE': t('admin_marketing_status_active', 'Aktif'),
 'PAUSED': t('admin_marketing_status_paused', 'Duraklatildi'),
 'COMPLETED': t('admin_marketing_status_completed', 'Tamamlandi'),
 'CANCELLED': t('admin_marketing_status_cancelled', 'Iptal Edildi'),
 'PROSPECT': t('admin_marketing_status_prospect', 'Aday'),
 'CONTACTED': t('admin_marketing_status_contacted', 'Iletisime Gecildi'),
 'NEGOTIATING': t('admin_marketing_status_negotiating', 'Gorusuluyor'),
 'SIGNED': t('admin_marketing_status_signed', 'İmzalandı'),
 'INACTIVE': t('admin_marketing_status_inactive', 'Pasif'),
 'RESTRICTED': t('admin_marketing_status_restricted', 'Kısıtlı'),
 'REVIEW': t('admin_marketing_status_review', 'Incelemede'),
 'APPROVED': t('admin_marketing_status_approved', 'Onaylandi'),
 'SIGNING': t('admin_marketing_status_signing', 'Imza Asamasinda'),
 'EXPIRING': t('admin_marketing_status_expiring', 'Süresi Doluyor'),
 'RENEWED': t('admin_marketing_status_renewed', 'Yenilendi'),
 'TERMINATED': t('admin_marketing_status_terminated', 'Feshedildi'),
 'ARCHIVED': t('admin_marketing_status_archived', 'Arşivlendi')
 };
 return map[status] || status;
 };

 const getStatusColor = (status: string) => {
 switch (status) {
 case 'ACTIVE':
 case 'COMPLETED':
 return 'bg-blue-500';
 case 'DRAFT':
 case 'PLANNED':
 case 'PENDING':
 return 'bg-yellow-500';
 case 'PAUSED':
 return 'bg-orange-500';
 case 'CANCELLED':
 case 'EXPIRED':
 case 'TERMINATED':
 case 'INACTIVE':
 return 'bg-red-500';
 default:
 return 'bg-card/10';
 }
 };

 const getTierColor = (tier: string) => {
 switch (tier) {
 case 'PLATINUM':
 return 'bg-muted0';
 case 'GOLD':
 return 'bg-yellow-500';
 case 'SILVER':
 return 'bg-card/10';
 case 'BRONZE':
 return 'bg-orange-600';
 default:
 return 'bg-card/10';
 }
 };

 const formatCurrency = (amount: number) => {
 return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(amount);
 };

 const filteredCampaigns = campaigns.filter(campaign => {
 const matchesSearch = campaign.name.toLowerCase().includes(searchTerm.toLowerCase());
 const matchesStatus = statusFilter ==="ALL" || campaign.status === statusFilter;
 return matchesSearch && matchesStatus;
 });

 const activeCampaigns = campaigns.filter(c => c.status === 'ACTIVE').length;
 const totalBudget = campaigns.reduce((sum, c) => sum + (c.budget || 0), 0);
 const totalSpent = campaigns.reduce((sum, c) => sum + (c.actualSpend || 0), 0);
 const activeAmbassadors = ambassadors.filter(a => a.status === 'ACTIVE').length;
 const totalConversions = campaigns.reduce((sum, c) => sum + (c.conversions || 0), 0);
 const totalRevenue = campaigns.reduce((sum, c) => sum + (c.conversionValue || 0), 0);

 if (isLoading) {
 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6">
 <div className="flex items-center justify-center h-64">
 <Megaphone className="h-8 w-8 animate-spin text-muted-foreground" />
 </div>
 </div>
 );
 }

 return (
 <div className="p-6 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_marketing_marketing_automation")}</h1>
 </div>

 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t("admin_marketing_active_campaigns")}</CardTitle>
 <Megaphone className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{activeCampaigns}</div>
 <p className="text-xs text-muted-foreground">{t("admin_marketing_of")}{campaigns.length}{t("admin_marketing_total")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t("admin_marketing_total_budget")}</CardTitle>
 <Target className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{formatCurrency(totalBudget)}</div>
 <p className="text-xs text-muted-foreground">{formatCurrency(totalSpent)}{t("admin_marketing_spent")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t("admin_marketing_active_ambassadors")}</CardTitle>
 <Users className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{activeAmbassadors}</div>
 <p className="text-xs text-muted-foreground">{t("admin_marketing_of")}{ambassadors.length}{t("admin_marketing_total")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium text-foreground">{t("admin_marketing_total_conversions")}</CardTitle>
 <TrendingUp className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-foreground">{totalConversions.toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{formatCurrency(totalRevenue)}{t("admin_marketing_revenue")}</p>
 </CardContent>
 </Card>
 </div>

 <Tabs defaultValue="campaigns" className="space-y-4">
 <TabsList className="bg-card border border-border">
 <TabsTrigger value="campaigns" className="text-foreground data-[state=active]:bg-muted">{t("admin_marketing_campaigns")}</TabsTrigger>
 <TabsTrigger value="ambassadors" className="text-foreground data-[state=active]:bg-muted">{t("admin_marketing_ambassadors")}</TabsTrigger>
 <TabsTrigger value="contracts" className="text-foreground data-[state=active]:bg-muted">{t("admin_marketing_contracts")}</TabsTrigger>
 <TabsTrigger value="social-impact" className="text-foreground data-[state=active]:bg-muted">{t("admin_marketing_social_impact")}</TabsTrigger>
 </TabsList>

 <TabsContent value="campaigns" className="space-y-4">
 <div className="flex justify-between items-center">
 <div className="flex gap-2">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_marketing_search_campaigns")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64 bg-card border-border text-foreground" />
 </div>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-32 bg-card border-border text-foreground">
 <SelectValue />
 </SelectTrigger>
 <SelectContent className="bg-card border-border text-foreground">
 <SelectItem value="ALL">{t("admin_marketing_all_status")}</SelectItem>
 <SelectItem value="DRAFT">{t("admin_marketing_draft")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_marketing_active")}</SelectItem>
 <SelectItem value="PAUSED">{t("admin_marketing_paused")}</SelectItem>
 <SelectItem value="COMPLETED">{t("admin_marketing_completed")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button className="bg-muted hover:bg-muted0 text-foreground">
 <Plus className="h-4 w-4 mr-2" />{t("admin_marketing_new_campaign")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-card border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_create_new_campaign", "Yeni Kampanya Oluştur")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">{t("admin_auto_enter_the_details_for_the_new_campaign", "Yeni kampanyanın ayrıntılarını girin.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="name" className="text-right text-xs text-muted-foreground">{t("admin_auto_campaign_name", "Kampanya Adı")}</Label>
 <Input id="name" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.name} onChange={e => setFormData({ ...formData, name: e.target.value })} placeholder={t("admin_auto_enter_campaign_name", "Kampanya adını girin")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="type" className="text-right text-xs text-muted-foreground">{t("admin_auto_type", "Tip")}</Label>
 <Input id="type" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.type} onChange={e => setFormData({ ...formData, type: e.target.value })} placeholder={t("admin_auto_enter_type", "Türü girin")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="status" className="text-right text-xs text-muted-foreground">{t("admin_auto_status", "Durum")}</Label>
 <Input id="status" className="col-span-3 h-10 bg-card border-border text-foreground" value={formData.status} onChange={e => setFormData({ ...formData, status: e.target.value })} placeholder={t("admin_auto_enter_status", "Durumu girin")} />
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" onClick={() => setIsAddOpen(false)}>{t("admin_action_cancel", "İptal")}</Button>
 <Button onClick={() => createMutation.mutate(formData)} disabled={createMutation.isPending}>
 {createMutation.isPending ?"Saving..." :"Save Changes"}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_marketing_marketing_campaigns")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-muted-foreground">{t("admin_marketing_name")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_type")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_objective")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_status")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_budget")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_performance")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_duration")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredCampaigns.map(campaign => (
 <TableRow key={campaign.id} className="border-border hover:bg-card">
 <TableCell className="font-medium text-foreground">{campaign.name}</TableCell>
 <TableCell>
 <Badge variant="outline" className="border-border text-muted-foreground">{campaign.platforms.join(', ') || 'N/A'}</Badge>
 </TableCell>
 <TableCell>
 <Badge variant="secondary" className="bg-card text-muted-foreground">{getLocalizedStatus(campaign.status)}</Badge>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(campaign.status)}`} />
 <span className="capitalize text-foreground">{getLocalizedStatus(campaign.status).toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 <div>
 <div className="font-semibold text-foreground">{formatCurrency(campaign.actualSpend || 0)}</div>
 <div className="text-xs text-muted-foreground">{t("admin_marketing_of")}{formatCurrency(campaign.budget || 0)}</div>
 </div>
 </TableCell>
 <TableCell>
 <div className="space-y-1">
 <div className="flex justify-between text-xs text-muted-foreground">
 <span>{t("admin_marketing_reach")}{campaign.actualReach || 0}</span>
 <span>{t("admin_marketing_impress")}{campaign.impressions || 0}</span>
 </div>
 <div className="flex justify-between text-xs text-muted-foreground">
 <span>{t("admin_marketing_click")}{campaign.clicks || 0}</span>
 <span>{t("admin_marketing_conv")}{campaign.conversions || 0}</span>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <div className="text-sm text-foreground">
 <div>{campaign.startDate ? new Date(campaign.startDate).toLocaleDateString() : 'N/A'}</div>
 {campaign.endDate && <div className="text-muted-foreground">{t("admin_marketing_to")}{new Date(campaign.endDate).toLocaleDateString()}</div>}
 </div>
 </TableCell>
 <TableCell>
 <div className="flex gap-1">
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-foreground" aria-label={t("common.view")}><Eye className="h-4 w-4" /></Button>
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-foreground" aria-label={t("common.analytics")}><BarChart3 className="h-4 w-4" /></Button>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0 text-muted-foreground hover:text-foreground"><span className="sr-only">{t("admin_auto_open_menu", "Menüyü aç")}</span><MoreHorizontal className="h-4 w-4" /></Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-card border-border text-foreground">
 <DropdownMenuItem className="cursor-pointer hover:bg-muted dark:hover:bg-card/10" onClick={() => {
 setFormData(campaign as any);
 setIsAddOpen(true);
 }}><Edit className="mr-2 h-4 w-4" /> {t("admin_action_edit", "Düzenle")}</DropdownMenuItem>
 <DropdownMenuItem className="cursor-pointer text-red-400 hover:bg-red-400/10" onClick={() => deleteMutation.mutate(campaign.id)}><Trash2 className="mr-2 h-4 w-4" /> {t("admin_action_delete", "Sil")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </div>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="ambassadors" className="space-y-4">
 <div className="flex justify-end">
 <Button className="bg-muted hover:bg-muted0 text-foreground">
 <Plus className="h-4 w-4 mr-2" />{t("admin_marketing_add_ambassador")}
 </Button>
 </div>
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_marketing_brand_ambassadors")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-muted-foreground">{t("admin_marketing_name")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_contact")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_tier")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_status")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_performance")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_referrals")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_earnings")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {ambassadors.map(ambassador => (
 <TableRow key={ambassador.id} className="border-border hover:bg-card">
 <TableCell className="font-medium text-foreground">{ambassador.fullName}</TableCell>
 <TableCell>
 <div className="text-sm text-foreground">
 <div className="flex items-center gap-1"><Mail className="h-3 w-3 text-muted-foreground" />{ambassador.emailCiphertext ? t("admin_marketing_encrypted","[Sifreli]") :"N/A"}</div>
 <div className="flex items-center gap-1"><Phone className="h-3 w-3 text-muted-foreground" />{ambassador.phoneCiphertext ? t("admin_marketing_encrypted","[Sifreli]") :"N/A"}</div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getTierColor(ambassador.tier ||"BRONZE")}`} />
 <Badge variant="outline" className="border-border text-muted-foreground">{ambassador.tier ||"BRONZE"}</Badge>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(ambassador.status)}`} />
 <span className="capitalize text-foreground">{getLocalizedStatus(ambassador.status).toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 <div className="space-y-1">
 <div className="flex items-center gap-1">
 <Star className="h-3 w-3 text-yellow-500" />
 <span className="text-sm text-foreground">{(ambassador.totalRoi || 0).toFixed(1)}{t("admin_marketing_roi")}</span>
 </div>
 <div className="text-xs text-muted-foreground">{ambassador.engagementRate || 0}{t("admin_marketing_engagement")}</div>
 </div>
 </TableCell>
 <TableCell>
 <div className="text-sm text-foreground">
 <div>{ambassador.actualReach || 0}</div>
 <div className="text-xs text-muted-foreground">{t("admin_marketing_actual_reach")}</div>
 </div>
 </TableCell>
 <TableCell>
 <div>
 <div className="font-semibold text-foreground">{formatCurrency(ambassador.upfrontFee || 0)}</div>
 <div className="text-xs text-muted-foreground">{t("admin_marketing_upfront_fee")}</div>
 </div>
 </TableCell>
 <TableCell>
 <div className="flex gap-1">
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-foreground" aria-label={t("common.view")}><Eye className="h-4 w-4" /></Button>
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-foreground" aria-label={t("common.edit")}><Edit className="h-4 w-4" /></Button>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0 text-muted-foreground hover:text-foreground"><span className="sr-only">{t("admin_auto_open_menu", "Menüyü aç")}</span><MoreHorizontal className="h-4 w-4" /></Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-card border-border text-foreground">
 <DropdownMenuItem className="cursor-pointer hover:bg-muted dark:hover:bg-card/10" onClick={() => {
 // Add edit handler if needed
 }}><Edit className="mr-2 h-4 w-4" /> {t("admin_action_edit", "Düzenle")}</DropdownMenuItem>
 <DropdownMenuItem className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> {t("admin_action_delete", "Sil")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </div>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="contracts" className="space-y-4">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_marketing_ambassador_contracts")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow className="border-border hover:bg-transparent">
 <TableHead className="text-muted-foreground">{t("admin_marketing_ambassador")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_type")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_commission")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_status")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_period")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_total_payouts")}</TableHead>
 <TableHead className="text-muted-foreground">{t("admin_marketing_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {contracts.map(contract => (
 <TableRow key={contract.id} className="border-border hover:bg-card">
 <TableCell className="font-medium text-foreground">{contract.ambassadorName}</TableCell>
 <TableCell>
 <Badge variant="outline" className="border-border text-muted-foreground">{getLocalizedStatus(contract.status)}</Badge>
 </TableCell>
 <TableCell>
 <div className="text-foreground">
 {contract.equityPercent && `${contract.equityPercent}% ${t("admin_marketing_equity","hisse")}`}{contract.upfrontFee && ` + ${formatCurrency(contract.upfrontFee)} ${t("admin_marketing_upfront", "yıkadım")}`}
 </div>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(contract.status)}`} />
 <span className="capitalize text-foreground">{getLocalizedStatus(contract.status).toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 <div className="text-sm text-foreground">
 <div>{contract.startDate ? new Date(contract.startDate).toLocaleDateString() : 'N/A'}</div>
 {contract.endDate && <div className="text-muted-foreground">{t("admin_marketing_to")}{new Date(contract.endDate).toLocaleDateString()}</div>}
 </div>
 </TableCell>
 <TableCell className="text-foreground">{contract.upfrontFee ? formatCurrency(contract.upfrontFee) : '-'}</TableCell>
 <TableCell>
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-foreground" aria-label={t("common.view")}><Eye className="h-4 w-4" /></Button>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0 text-muted-foreground hover:text-foreground"><span className="sr-only">{t("admin_auto_open_menu", "Menüyü aç")}</span><MoreHorizontal className="h-4 w-4" /></Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-card border-border text-foreground">
 <DropdownMenuItem className="cursor-pointer hover:bg-muted dark:hover:bg-card/10"><Edit className="mr-2 h-4 w-4" /> {t("admin_action_edit", "Düzenle")}</DropdownMenuItem>
 <DropdownMenuItem className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> {t("admin_action_delete", "Sil")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="social-impact" className="space-y-4">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_marketing_social_impact_tracking")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="flex flex-col items-center justify-center h-48 text-muted-foreground">
 <BarChart3 className="h-12 w-12 mb-4 opacity-20" />
 <p>{t("admin_marketing_social_impact_tracking_is")}</p>
 </div>
 </CardContent>
 </Card>
 </TabsContent>
 </Tabs>
 </div>
 );
}
