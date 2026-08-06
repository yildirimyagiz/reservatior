"use client";
import { useMutation, useQueryClient } from '@tanstack/react-query';

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { Building, Users, DollarSign, MoreHorizontal, Activity, Plus, Search, Eye, Edit, Trash2, CheckCircle, XCircle } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
interface Organization {
 id: string;
 name: string;
 description?: string;
 domain?: string;
 industry?: string;
 size: 'STARTUP' | 'SMALL' | 'MEDIUM' | 'LARGE' | 'ENTERPRISE';
 status: 'ACTIVE' | 'INACTIVE' | 'SUSPENDED' | 'PENDING';
 subscriptionTier: 'FREE' | 'BASIC' | 'PROFESSIONAL' | 'ENTERPRISE';
 billingEmail?: string;
 address?: {
 street?: string;
 city?: string;
 state?: string;
 zipCode?: string;
 country?: string;
 };
 contactPerson?: {
 name: string;
 email: string;
 phone?: string;
 };
 settings: {
 timezone: string;
 currency: string;
 language: string;
 allowPublicListings: boolean;
 requireApproval: boolean;
 };
 memberCount: number;
 propertyCount: number;
 revenue: number;
 createdAt: Date;
 updatedAt: Date;
}
export default function Organizations() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 
 
 
 const {
 t
 } = useTranslation();
 const [organizations, setOrganizations] = useState<Organization[]>([]);
 const [loading, setLoading] = useState(true);
 const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
 const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
 const [editingOrg, setEditingOrg] = useState<any>(null);

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/organization/${data.id}`, data),
 onSuccess: () => { 
 toast({ title:"Updated", description:"Organization updated successfully" }); 
 queryClient.invalidateQueries({ queryKey: ['admin-organizations'] }); 
 setIsEditDialogOpen(false); 
 setEditingOrg(null);
 fetchOrganizations();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/organization/${id}`),
 onSuccess: () => { 
 toast({ title:"Deleted", description:"Organization deleted successfully" }); 
 fetchOrganizations();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const handleEdit = (org: any) => {
 setEditingOrg(org);
 setIsEditDialogOpen(true);
 };

 const [searchTerm, setSearchTerm] = useState('');
 const [statusFilter, setStatusFilter] = useState<string>('all');
 const [sizeFilter, setSizeFilter] = useState<string>('all');
 const [newOrg, setNewOrg] = useState({
 name: '',
 description: '',
 domain: '',
 industry: '',
 size: 'SMALL',
 subscriptionTier: 'FREE',
 billingEmail: '',
 timezone: 'UTC',
 currency: 'USD',
 language: 'en',
 allowPublicListings: true,
 requireApproval: false
 });
 useEffect(() => {
 fetchOrganizations();
 }, [statusFilter, sizeFilter]);
 const fetchOrganizations = async () => {
 try {
 const params = new URLSearchParams();
 if (statusFilter !== 'all') params.append('status', statusFilter);
 if (sizeFilter !== 'all') params.append('size', sizeFilter);
 if (searchTerm) params.append('search', searchTerm);
 const response = (await apiClient.get(`/organization?${params}`)) as {
 data: Organization[];
 };
 setOrganizations(response.data);
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_fetch_organizations"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 const createOrganization = async () => {
 try {
 const response = (await apiClient.post('/organization', {
 ...newOrg,
 settings: {
 timezone: newOrg.timezone,
 currency: newOrg.currency,
 language: newOrg.language,
 allowPublicListings: newOrg.allowPublicListings,
 requireApproval: newOrg.requireApproval
 }
 })) as {
 data: Organization;
 };
 setOrganizations([...organizations, response.data]);
 setIsCreateDialogOpen(false);
 setNewOrg({
 name: '',
 description: '',
 domain: '',
 industry: '',
 size: 'SMALL',
 subscriptionTier: 'FREE',
 billingEmail: '',
 timezone: 'UTC',
 currency: 'USD',
 language: 'en',
 allowPublicListings: true,
 requireApproval: false
 });
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_organization_created_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_create_organization"),
 variant:"destructive"
 });
 }
 };
 const updateOrganizationStatus = async (orgId: string, status: string) => {
 try {
 await apiClient.put(`/organization/${orgId}`, {
 status
 });
 setOrganizations(organizations.map(org => org.id === orgId ? {
 ...org,
 status: status as any
 } : org));
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_organization_status_updated_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_update_organization"),
 variant:"destructive"
 });
 }
 };
 const getStatusColor = (status: string) => {
 switch (status) {
 case 'ACTIVE':
 return 'bg-blue-500';
 case 'INACTIVE':
 return 'bg-card/10';
 case 'SUSPENDED':
 return 'bg-red-500';
 case 'PENDING':
 return 'bg-yellow-500';
 default:
 return 'bg-card/10';
 }
 };
 const getSizeColor = (size: string) => {
 switch (size) {
 case 'STARTUP':
 return 'bg-muted0';
 case 'SMALL':
 return 'bg-blue-500';
 case 'MEDIUM':
 return 'bg-yellow-500';
 case 'LARGE':
 return 'bg-orange-500';
 case 'ENTERPRISE':
 return 'bg-muted0';
 default:
 return 'bg-card/10';
 }
 };
 const filteredOrganizations = organizations.filter(org => org.name.toLowerCase().includes(searchTerm.toLowerCase()) || org.domain?.toLowerCase().includes(searchTerm.toLowerCase()) || org.industry?.toLowerCase().includes(searchTerm.toLowerCase()));
 const activeOrgs = organizations.filter(org => org.status === 'ACTIVE').length;
 const totalRevenue = organizations.reduce((acc, org) => acc + org.revenue, 0);
 const totalMembers = organizations.reduce((acc, org) => acc + org.memberCount, 0);
 const totalProperties = organizations.reduce((acc, org) => acc + org.propertyCount, 0);
 if (loading) {
 return <PageShell title={t("admin_organization_organizations")}>
 <div className="flex items-center justify-center h-64">
 <Activity className="h-8 w-8 animate-spin" />
 </div>
 
 {/* Edit Dialog */}
 <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
 <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
 <DialogHeader>
 <DialogTitle>{t("admin_organization_edit_organization", "Organizasyonu Düzenle")}</DialogTitle>
 </DialogHeader>
 {editingOrg && (
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="edit-name">{t("admin_organization_organization_name")}</Label>
 <Input id="edit-name" value={editingOrg.name || ''} onChange={e => setEditingOrg({...editingOrg, name: e.target.value})} required />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="edit-domain">{t("admin_organization_domain")}</Label>
 <Input id="edit-domain" value={editingOrg.domain || ''} onChange={e => setEditingOrg({...editingOrg, domain: e.target.value})} />
 </div>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="edit-description">{t("admin_organization_description")}</Label>
 <Input id="edit-description" value={editingOrg.description || ''} onChange={e => setEditingOrg({...editingOrg, description: e.target.value})} />
 </div>
 </div>
 )}
 <DialogFooter>
 <Button onClick={() => updateMutation.mutate(editingOrg)} disabled={updateMutation.isPending}>{t("admin_organization_update_organization", "Organizasyonu Güncelle")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 </PageShell>;
 }
 return <PageShell title={t("admin_organization_organizations")}>
 <div className="space-y-6">
 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_active_organizations")}</CardTitle>
 <Building className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{activeOrgs}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_of")}{organizations.length}{t("admin_organization_total")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_total_members")}</CardTitle>
 <Users className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{totalMembers.toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_across_all_organizations")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_total_properties")}</CardTitle>
 <Building className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{totalProperties.toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_managed_properties")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_total_revenue")}</CardTitle>
 <DollarSign className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{t("currency_symbol", "$")}{totalRevenue.toLocaleString()}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_monthly_recurring")}</p>
 </CardContent>
 </Card>
 </div>

 {/* Filters and Search */}
 <div className="flex justify-between items-center">
 <div className="flex gap-4">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_organization_search_organizations")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
 </div>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-[140px]">
 <SelectValue placeholder={t("admin_organization_status")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_organization_all_statuses")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_organization_active")}</SelectItem>
 <SelectItem value="INACTIVE">{t("admin_organization_inactive")}</SelectItem>
 <SelectItem value="SUSPENDED">{t("admin_organization_suspended")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_organization_pending")}</SelectItem>
 </SelectContent>
 </Select>
 <Select value={sizeFilter} onValueChange={setSizeFilter}>
 <SelectTrigger className="w-[120px]">
 <SelectValue placeholder={t("admin_organization_size")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_organization_all_sizes")}</SelectItem>
 <SelectItem value="STARTUP">{t("admin_organization_startup")}</SelectItem>
 <SelectItem value="SMALL">{t("admin_organization_small")}</SelectItem>
 <SelectItem value="MEDIUM">{t("admin_organization_medium")}</SelectItem>
 <SelectItem value="LARGE">{t("admin_organization_large")}</SelectItem>
 <SelectItem value="ENTERPRISE">{t("admin_organization_enterprise")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
 <DialogTrigger asChild>
 <Button>
 <Plus className="h-4 w-4 mr-2" />{t("admin_organization_add_organization")}</Button>
 </DialogTrigger>
 <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
 <DialogHeader>
 <DialogTitle>{t("admin_organization_add_new_organization")}</DialogTitle>
 <DialogDescription>{t("admin_organization_create_a_new_organization")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="name">{t("admin_organization_organization_name")}</Label>
 <Input id="name" value={newOrg.name} onChange={e => setNewOrg({
 ...newOrg,
 name: e.target.value
 })} required />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="domain">{t("admin_organization_domain")}</Label>
 <Input id="domain" value={newOrg.domain} onChange={e => setNewOrg({
 ...newOrg,
 domain: e.target.value
 })} placeholder={t("admin_organization_companycom")} />
 </div>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="description">{t("admin_organization_description")}</Label>
 <Input id="description" value={newOrg.description} onChange={e => setNewOrg({
 ...newOrg,
 description: e.target.value
 })} placeholder={t("admin_organization_brief_description_of_the")} />
 </div>
 <div className="grid grid-cols-3 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="industry">{t("admin_organization_industry")}</Label>
 <Input id="industry" value={newOrg.industry} onChange={e => setNewOrg({
 ...newOrg,
 industry: e.target.value
 })} placeholder={t("admin_organization_real_estate_technology_etc")} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="size">{t("admin_organization_organization_size")}</Label>
 <Select value={newOrg.size} onValueChange={value => setNewOrg({
 ...newOrg,
 size: value
 })}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="STARTUP">{t("admin_organization_startup_110")}</SelectItem>
 <SelectItem value="SMALL">{t("admin_organization_small_1150")}</SelectItem>
 <SelectItem value="MEDIUM">{t("admin_organization_medium_51200")}</SelectItem>
 <SelectItem value="LARGE">{t("admin_organization_large_2011000")}</SelectItem>
 <SelectItem value="ENTERPRISE">{t("admin_organization_enterprise_1000")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="tier">{t("admin_organization_subscription_tier")}</Label>
 <Select value={newOrg.subscriptionTier} onValueChange={value => setNewOrg({
 ...newOrg,
 subscriptionTier: value
 })}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="FREE">{t("admin_organization_free")}</SelectItem>
 <SelectItem value="BASIC">{t("admin_organization_basic")}</SelectItem>
 <SelectItem value="PROFESSIONAL">{t("admin_organization_professional")}</SelectItem>
 <SelectItem value="ENTERPRISE">{t("admin_organization_enterprise")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="billingEmail">{t("admin_organization_billing_email")}</Label>
 <Input id="billingEmail" type="email" value={newOrg.billingEmail} onChange={e => setNewOrg({
 ...newOrg,
 billingEmail: e.target.value
 })} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="timezone">{t("admin_organization_timezone")}</Label>
 <Select value={newOrg.timezone} onValueChange={value => setNewOrg({
 ...newOrg,
 timezone: value
 })}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="UTC">{t("admin_organization_utc")}</SelectItem>
 <SelectItem value="America/New_York">{t("admin_organization_eastern_time")}</SelectItem>
 <SelectItem value="America/Chicago">{t("admin_organization_central_time")}</SelectItem>
 <SelectItem value="America/Denver">{t("admin_organization_mountain_time")}</SelectItem>
 <SelectItem value="America/Los_Angeles">{t("admin_organization_pacific_time")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="currency">{t("admin_organization_currency")}</Label>
 <Select value={newOrg.currency} onValueChange={value => setNewOrg({
 ...newOrg,
 currency: value
 })}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="USD">{t("admin_organization_usd")}</SelectItem>
 <SelectItem value="EUR">{t("admin_organization_eur")}</SelectItem>
 <SelectItem value="GBP">{t("admin_organization_gbp")}</SelectItem>
 <SelectItem value="CAD">{t("admin_organization_cad_c")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <div className="grid gap-2">
 <Label htmlFor="language">{t("admin_organization_language")}</Label>
 <Select value={newOrg.language} onValueChange={value => setNewOrg({
 ...newOrg,
 language: value
 })}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="en">{t("admin_organization_english")}</SelectItem>
 <SelectItem value="es">{t("admin_organization_spanish")}</SelectItem>
 <SelectItem value="fr">{t("admin_organization_french")}</SelectItem>
 <SelectItem value="de">{t("admin_organization_german")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="flex items-center gap-4">
 <div className="flex items-center space-x-2">
 <input type="checkbox" id="allowPublicListings" checked={newOrg.allowPublicListings} onChange={e => setNewOrg({
 ...newOrg,
 allowPublicListings: e.target.checked
 })} />
 <Label htmlFor="allowPublicListings">{t("admin_organization_allow_public_listings")}</Label>
 </div>
 <div className="flex items-center space-x-2">
 <input type="checkbox" id="requireApproval" checked={newOrg.requireApproval} onChange={e => setNewOrg({
 ...newOrg,
 requireApproval: e.target.checked
 })} />
 <Label htmlFor="requireApproval">{t("admin_organization_require_approval_for_listings")}</Label>
 </div>
 </div>
 </div>
 <DialogFooter>
 <Button onClick={createOrganization}>{t("admin_organization_create_organization")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>

 {/* Organizations Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_organizations")}</CardTitle>
 <p className="text-sm text-muted-foreground">{t("admin_organization_manage_organization_accounts_subscriptions")}</p>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_organization_organization")}</TableHead>
 <TableHead>{t("admin_organization_size")}</TableHead>
 <TableHead>{t("admin_organization_status")}</TableHead>
 <TableHead>{t("admin_organization_tier")}</TableHead>
 <TableHead>{t("admin_organization_members")}</TableHead>
 <TableHead>{t("admin_organization_properties")}</TableHead>
 <TableHead>{t("admin_organization_revenue")}</TableHead>
 <TableHead>{t("admin_organization_created")}</TableHead>
 <TableHead className="text-right">{t("admin_organization_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredOrganizations.map(org => <TableRow key={org.id}>
 <TableCell className="font-medium">
 <div>
 <div className="flex items-center gap-2">
 <Building className="h-4 w-4 text-muted-foreground" />
 <div>
 <div>{org.name}</div>
 <div className="text-xs text-muted-foreground">
 {org.domain && `@${org.domain}`}
 {org.industry && ` • ${org.industry}`}
 </div>
 </div>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline" className="text-xs">
 <div className={`w-2 h-2 rounded-full ${getSizeColor(org.size)} mr-1`} />
 {org.size}
 </Badge>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getStatusColor(org.status)}`} />
 <span className="capitalize text-sm">{org.status.toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline">{org.subscriptionTier}</Badge>
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-1">
 <Users className="h-3 w-3" />
 <span>{org.memberCount}</span>
 </div>
 </TableCell>
 <TableCell>{org.propertyCount}</TableCell>
 <TableCell className="font-medium">
 {t("currency_symbol", "$")}{org.revenue.toLocaleString()}
 </TableCell>
 <TableCell>
 {new Date(org.createdAt).toLocaleDateString()}
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0" aria-label={t("common.more")}>
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end">
 <DropdownMenuLabel>{t("admin_organization_actions")}</DropdownMenuLabel>
 <DropdownMenuItem>
 <Eye className="h-4 w-4 mr-2" />{t("admin_organization_view_details")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => handleEdit(org)}><Edit className="h-4 w-4 mr-2" />{t("admin_organization_edit_organization")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Users className="h-4 w-4 mr-2" />{t("admin_organization_manage_members")}</DropdownMenuItem>
 {org.status === 'ACTIVE' && <DropdownMenuItem onClick={() => updateOrganizationStatus(org.id, 'SUSPENDED')} className="text-red-600">
 <XCircle className="h-4 w-4 mr-2" />{t("admin_organization_suspend")}</DropdownMenuItem>}
 {org.status === 'SUSPENDED' && <DropdownMenuItem onClick={() => updateOrganizationStatus(org.id, 'ACTIVE')}>
 <CheckCircle className="h-4 w-4 mr-2" />{t("admin_organization_activate")}</DropdownMenuItem>}
 <DropdownMenuSeparator />
 <DropdownMenuItem onClick={() => deleteMutation.mutate(org.id)} className="text-red-600"><Trash2 className="h-4 w-4 mr-2" />{t("admin_organization_delete_organization")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 {/* Organization Statistics */}
 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_subscription_distribution")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 {['FREE', 'BASIC', 'PROFESSIONAL', 'ENTERPRISE'].map(tier => {
 const count = organizations.filter(org => org.subscriptionTier === tier).length;
 const percentage = organizations.length > 0 ? count / organizations.length * 100 : 0;
 return <div key={tier} className="flex justify-between items-center">
 <span className="text-sm">{tier}</span>
 <div className="text-right">
 <div className="font-medium">{count}</div>
 <div className="text-xs text-muted-foreground">{percentage.toFixed(1)}%</div>
 </div>
 </div>;
 })}
 </div>
 </CardContent>
 </Card>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_organization_sizes")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 {['STARTUP', 'SMALL', 'MEDIUM', 'LARGE', 'ENTERPRISE'].map(size => {
 const count = organizations.filter(org => org.size === size).length;
 return <div key={size} className="animate-in fade-in slide-in-from-bottom-4 duration-700 flex justify-between items-center">
 <span className="text-sm">{size}</span>
 <span className="font-medium">{count}</span>
 </div>;
 })}
 </div>
 </CardContent>
 </Card>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_status_overview")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-blue-500" />{t("admin_organization_active")}</span>
 <span className="font-medium">{activeOrgs}</span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-card/10" />{t("admin_organization_inactive")}</span>
 <span className="font-medium">
 {organizations.filter(org => org.status === 'INACTIVE').length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-yellow-500" />{t("admin_organization_pending")}</span>
 <span className="font-medium">
 {organizations.filter(org => org.status === 'PENDING').length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm flex items-center gap-2">
 <div className="w-2 h-2 rounded-full bg-red-500" />{t("admin_organization_suspended")}</span>
 <span className="font-medium">
 {organizations.filter(org => org.status === 'SUSPENDED').length}
 </span>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 </PageShell>;
}