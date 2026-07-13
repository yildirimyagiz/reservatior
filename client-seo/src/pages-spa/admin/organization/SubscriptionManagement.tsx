"use client";
import React from 'react';
import { useMutation, useQueryClient } from '@tanstack/react-query';

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from"../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { CreditCard, Users, Plus, MoreHorizontal, Edit, Trash2, Activity, Search, Eye, TrendingUp } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";
interface Plan {
 id: string;
 key: string;
 name: string;
 limits: any;
 priceMonthlyCents?: number;
 createdAt: Date;
 updatedAt: Date;
}
interface OrgSubscription {
 id: string;
 orgId: string;
 planId: string;
 status: string;
 stripeCustomerId?: string;
 stripeSubscriptionId?: string;
 currentPeriodEnd?: Date;
 createdAt: Date;
 updatedAt: Date;
 organization: {
 name: string;
 };
 plan: Plan;
}
interface Subscription {
 id: string;
 orgId: string;
 userId?: string;
 planId: string;
 status: string;
 commissionDiscount: number;
 loyaltyMultiplier: number;
 isActive: boolean;
 boostedListings?: number;
 socialMediaPosts?: number;
 googleAdsCredits?: number;
 tagAllowances?: any;
 adCredits?: number;
 userSubscriptions?: any;
 createdBy?: string;
 createdAt: Date;
 updatedAt: Date;
 organization?: {
 name: string;
 };
 plan?: Plan;
 user?: {
 firstName: string;
 lastName: string;
 email: string;
 };
}
export default function SubscriptionManagement() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const [editingId, setEditingId] = React.useState<string | null>(null);

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/admin/subscriptionmanagement/${data.id}`, data),
 onSuccess: () => { toast({ title:"Updated", description:"Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/admin/subscriptionmanagement/${id}`),
 onSuccess: () => { toast({ title:"Deleted", description:"Record deleted successfully" }); queryClient.invalidateQueries(); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 
 const {
 t
 } = useTranslation();
 const [orgSubscriptions, setOrgSubscriptions] = useState<OrgSubscription[]>([]);
 const [subscriptions, setSubscriptions] = useState<Subscription[]>([]);
 const [plans, setPlans] = useState<Plan[]>([]);
 const [loading, setLoading] = useState(true);
 const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
 const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
 const [selectedSubscription, setSelectedSubscription] = useState<OrgSubscription | null>(null);
 const [searchTerm, setSearchTerm] = useState('');
 const [statusFilter, setStatusFilter] = useState<string>('all');
 const [createData, setCreateData] = useState({
 orgId: '',
 planId: '',
 status: 'ACTIVE',
 stripeCustomerId: '',
 stripeSubscriptionId: ''
 });
 const [editData, setEditData] = useState({
 planId: '',
 status: '',
 stripeCustomerId: '',
 stripeSubscriptionId: ''
 });
 useEffect(() => {
 fetchSubscriptions();
 fetchPlans();
 }, [statusFilter]);
 const fetchSubscriptions = async () => {
 try {
 const response = await apiClient.get<{
 data: OrgSubscription[];
 }>('/org-subscriptions');
 setOrgSubscriptions(response.data);
 const userSubsResponse = await apiClient.get<{
 data: Subscription[];
 }>('/subscriptions');
 setSubscriptions(userSubsResponse.data);
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_fetch_subscriptions"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 const fetchPlans = async () => {
 try {
 const response = await apiClient.get<{
 data: Plan[];
 }>('/plans');
 setPlans(response.data);
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_fetch_plans"),
 variant:"destructive"
 });
 }
 };
 const createSubscription = async () => {
 try {
 const response = (await apiClient.post('/org-subscription', createData)) as {
 data: OrgSubscription;
 };
 setOrgSubscriptions([...orgSubscriptions, response.data]);
 setIsCreateDialogOpen(false);
 setCreateData({
 orgId: '',
 planId: '',
 status: 'ACTIVE',
 stripeCustomerId: '',
 stripeSubscriptionId: ''
 });
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_subscription_created_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_create_subscription"),
 variant:"destructive"
 });
 }
 };
 const updateSubscription = async () => {
 if (!selectedSubscription) return;
 try {
 await apiClient.put(`/org-subscription/${selectedSubscription.id}`, editData);
 setOrgSubscriptions(orgSubscriptions.map(sub => sub.id === selectedSubscription.id ? {
 ...sub,
 ...editData
 } : sub));
 setIsEditDialogOpen(false);
 setSelectedSubscription(null);
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_subscription_updated_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_update_subscription"),
 variant:"destructive"
 });
 }
 };
 const cancelSubscription = async (subscriptionId: string) => {
 try {
 await apiClient.put(`/org-subscription/${subscriptionId}`, {
 status: 'CANCELLED'
 });
 setOrgSubscriptions(orgSubscriptions.map(sub => sub.id === subscriptionId ? {
 ...sub,
 status: 'CANCELLED'
 } : sub));
 toast({
 title: t("admin_organization_success"),
 description: t("admin_organization_subscription_cancelled_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_organization_error"),
 description: t("admin_organization_failed_to_cancel_subscription"),
 variant:"destructive"
 });
 }
 };
 const openEditDialog = (subscription: OrgSubscription) => {
 setSelectedSubscription(subscription);
 setEditData({
 planId: subscription.planId,
 status: subscription.status,
 stripeCustomerId: subscription.stripeCustomerId || '',
 stripeSubscriptionId: subscription.stripeSubscriptionId || ''
 });
 setIsEditDialogOpen(true);
 };
 const filteredSubscriptions = orgSubscriptions.filter(subscription => {
 const matchesSearch = subscription.organization?.name.toLowerCase().includes(searchTerm.toLowerCase()) || subscription.plan?.name.toLowerCase().includes(searchTerm.toLowerCase());
 const matchesStatus = statusFilter === 'all' || subscription.status === statusFilter;
 return matchesSearch && matchesStatus;
 });
 const totalSubscriptions = orgSubscriptions.length;
 const activeSubscriptions = orgSubscriptions.filter(sub => sub.status === 'ACTIVE').length;
 const totalRevenue = orgSubscriptions.reduce((acc, sub) => acc + (sub.plan?.priceMonthlyCents || 0), 0);
 const totalUsers = subscriptions.length;
 if (loading) {
 return <PageShell title={t("admin_organization_subscription_management")}>
 <div className="flex items-center justify-center h-64">
 <Activity className="h-8 w-8 animate-spin" />
 </div>
 </PageShell>;
 }
 return <PageShell title={t("admin_organization_subscription_management")}>
 <div className="space-y-6">
 {/* Opaque Financial Matrix Banner */}
 <Card className="bg-gradient-to-r from-orange-600/10 to-slate-600/5 border-orange-500/20 rounded-2xl p-6 relative overflow-hidden">
 <div className="flex flex-col md:flex-row items-start md:items-center justify-between gap-4">
 <div className="space-y-1">
 <div className="flex items-center gap-2">
 <Badge className="bg-orange-500/10 text-orange-400 border border-orange-500/20 text-[9px] font-black uppercase">
 Opaque Shield Active
 </Badge>
 <span className="text-[10px] text-muted-foreground font-mono">AES-256-GCM Verified</span>
 </div>
 <h3 className="text-lg font-black text-foreground italic tracking-tight">
 Secure Partner Agreement Gateway
 </h3>
 <p className="text-xs text-muted-foreground max-w-3xl">
 Custom negotiated rates, time-decay amortization schedules, and behavioral loyalty multipliers are encrypted. Core financial calculations are run internally on the server event stream to prevent competitive reverse-engineering.
 </p>
 </div>
 <Button variant="outline" className="border-orange-500/20 hover:border-orange-500/40 text-xs font-black text-orange-400 hover:text-orange-300 bg-orange-500/5 h-10 px-4 rounded-xl">{t("admin_auto_audit_contracts", "Audit Contracts")}</Button>
 </div>
 </Card>

 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_total_subscriptions")}</CardTitle>
 <CreditCard className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold">{totalSubscriptions}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_organization_subscriptions")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_active_subscriptions")}</CardTitle>
 <TrendingUp className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-green-600">{activeSubscriptions}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_currently_active")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_monthly_revenue")}</CardTitle>
 <TrendingUp className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-slate-600">
 ${(totalRevenue / 100).toLocaleString()}
 </div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_from_active_subscriptions")}</p>
 </CardContent>
 </Card>

 <Card>
 <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
 <CardTitle className="text-sm font-medium">{t("admin_organization_total_users")}</CardTitle>
 <Users className="h-4 w-4 text-muted-foreground" />
 </CardHeader>
 <CardContent>
 <div className="text-2xl font-bold text-slate-600">{totalUsers}</div>
 <p className="text-xs text-muted-foreground">{t("admin_organization_individual_subscriptions")}</p>
 </CardContent>
 </Card>
 </div>

 {/* Filters and Actions */}
 <div className="flex justify-between items-center">
 <div className="flex gap-4">
 <div className="relative">
 <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input placeholder={t("admin_organization_search_subscriptions")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
 </div>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-[140px]">
 <SelectValue placeholder={t("admin_organization_status")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="all">{t("admin_organization_all_statuses")}</SelectItem>
 <SelectItem value="ACTIVE">{t("admin_organization_active")}</SelectItem>
 <SelectItem value="INACTIVE">{t("admin_organization_inactive")}</SelectItem>
 <SelectItem value="CANCELLED">{t("admin_organization_cancelled")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
 <DialogTrigger asChild>
 <Button>
 <Plus className="h-4 w-4 mr-2" />{t("admin_organization_create_subscription")}</Button>
 </DialogTrigger>
 <DialogContent className="max-w-lg">
 <DialogHeader>
 <DialogTitle>{t("admin_organization_create_new_subscription")}</DialogTitle>
 <DialogDescription>{t("admin_organization_set_up_a_new")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="orgId">{t("admin_organization_organization_id")}</Label>
 <Input id="orgId" value={createData.orgId} onChange={e => setCreateData({
 ...createData,
 orgId: e.target.value
 })} placeholder={t("admin_organization_organization_id")} required />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="planId">{t("admin_organization_plan")}</Label>
 <Select value={createData.planId} onValueChange={value => setCreateData({
 ...createData,
 planId: value
 })}>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_organization_select_plan")} />
 </SelectTrigger>
 <SelectContent>
 {plans.map(plan => <SelectItem key={plan.id} value={plan.id}>
 {plan.name} - ${plan.priceMonthlyCents ? (plan.priceMonthlyCents / 100).toFixed(2) : 'Free'}/month
 </SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="stripeCustomerId">{t("admin_organization_stripe_customer_id")}</Label>
 <Input id="stripeCustomerId" value={createData.stripeCustomerId} onChange={e => setCreateData({
 ...createData,
 stripeCustomerId: e.target.value
 })} placeholder={t("admin_organization_cus")} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="stripeSubscriptionId">{t("admin_organization_stripe_subscription_id")}</Label>
 <Input id="stripeSubscriptionId" value={createData.stripeSubscriptionId} onChange={e => setCreateData({
 ...createData,
 stripeSubscriptionId: e.target.value
 })} placeholder={t("admin_organization_sub")} />
 </div>
 </div>
 </div>
 <DialogFooter>
 <Button onClick={createSubscription}>{t("admin_organization_create_subscription")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>

 {/* Edit Subscription Dialog */}
 <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
 <DialogContent className="max-w-lg">
 <DialogHeader>
 <DialogTitle>{t("admin_organization_edit_subscription")}</DialogTitle>
 <DialogDescription>{t("admin_organization_update_subscription_details_and")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid gap-2">
 <Label htmlFor="editPlanId">{t("admin_organization_plan")}</Label>
 <Select value={editData.planId} onValueChange={value => setEditData({
 ...editData,
 planId: value
 })}>
 <SelectTrigger>
 <SelectValue placeholder={t("admin_organization_select_plan")} />
 </SelectTrigger>
 <SelectContent>
 {plans.map(plan => <SelectItem key={plan.id} value={plan.id}>
 {plan.name} - ${plan.priceMonthlyCents ? (plan.priceMonthlyCents / 100).toFixed(2) : 'Free'}/month
 </SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 <div className="grid grid-cols-2 gap-4">
 <div className="grid gap-2">
 <Label htmlFor="editStripeCustomerId">{t("admin_organization_stripe_customer_id")}</Label>
 <Input id="editStripeCustomerId" value={editData.stripeCustomerId} onChange={e => setEditData({
 ...editData,
 stripeCustomerId: e.target.value
 })} />
 </div>
 <div className="grid gap-2">
 <Label htmlFor="editStripeSubscriptionId">{t("admin_organization_stripe_subscription_id")}</Label>
 <Input id="editStripeSubscriptionId" value={editData.stripeSubscriptionId} onChange={e => setEditData({
 ...editData,
 stripeSubscriptionId: e.target.value
 })} />
 </div>
 </div>
 </div>
 <DialogFooter>
 <Button onClick={updateSubscription}>{t("admin_organization_update_subscription")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 {/* Organization Subscriptions Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_organization_subscriptions")}</CardTitle>
 <p className="text-sm text-muted-foreground">{t("admin_organization_manage_organization_subscription_plans")}</p>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_organization_organization")}</TableHead>
 <TableHead>{t("admin_organization_plan")}</TableHead>
 <TableHead>{t("admin_organization_status")}</TableHead>
 <TableHead>{t("admin_organization_monthly_price")}</TableHead>
 <TableHead>{t("admin_organization_boosted_listings")}</TableHead>
 <TableHead>{t("admin_organization_social_posts")}</TableHead>
 <TableHead>{t("admin_organization_ad_credits")}</TableHead>
 <TableHead>{t("admin_organization_period_end")}</TableHead>
 <TableHead>{t("admin_organization_stripe_id")}</TableHead>
 <TableHead>{t("admin_organization_created")}</TableHead>
 <TableHead className="text-right">{t("admin_organization_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredSubscriptions.map(subscription => <TableRow key={subscription.id}>
 <TableCell className="font-medium">
 <div>
 <div className="flex items-center gap-2">
 <CreditCard className="h-4 w-4 text-muted-foreground" />
 {subscription.organization?.name || 'Unknown'}
 </div>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline">{subscription.plan?.name || 'Unknown'}</Badge>
 </TableCell>
 <TableCell>
 <Badge variant={subscription.status === 'ACTIVE' ?"default" :"secondary"} className="text-xs">
 {subscription.status}
 </Badge>
 </TableCell>
 <TableCell>
 {subscription.plan?.priceMonthlyCents ? `$${(subscription.plan.priceMonthlyCents / 100).toFixed(2)}` : 'Free'}
 </TableCell>
 <TableCell>
 <Badge variant="outline" className="bg-orange-500/10 text-orange-400 border-orange-500/20">
 {subscription.boostedListings || 0}
 </Badge>
 </TableCell>
 <TableCell>
 <Badge variant="outline" className="bg-blue-500/10 text-blue-400 border-blue-500/20">
 {subscription.socialMediaPosts || 0}
 </Badge>
 </TableCell>
 <TableCell>
 <Badge variant="outline" className="bg-emerald-500/10 text-emerald-400 border-emerald-500/20">
 {subscription.adCredits || 0}
 </Badge>
 </TableCell>
 <TableCell>
 {subscription.currentPeriodEnd ? new Date(subscription.currentPeriodEnd).toLocaleDateString() : '-'}
 </TableCell>
 <TableCell className="font-mono text-xs">
 {subscription.stripeSubscriptionId || '-'}
 </TableCell>
 <TableCell>
 {new Date(subscription.createdAt).toLocaleDateString()}
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0">
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end">
 <DropdownMenuLabel>{t("admin_organization_actions")}</DropdownMenuLabel>
 <DropdownMenuItem onClick={() => openEditDialog(subscription)}>
 <Edit className="h-4 w-4 mr-2" />{t("admin_organization_edit_subscription")}</DropdownMenuItem>
 <DropdownMenuItem>
 <Eye className="h-4 w-4 mr-2" />{t("admin_organization_view_details")}</DropdownMenuItem>
 {subscription.status === 'ACTIVE' && <DropdownMenuItem onClick={() => cancelSubscription(subscription.id)} className="text-red-600">
 <Trash2 className="h-4 w-4 mr-2" />{t("admin_organization_cancel_subscription")}</DropdownMenuItem>}
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 {/* Subscription Plans Overview */}
 <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_available_plans")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 {plans.map(plan => <div key={plan.id} className="p-4 border rounded-lg">
 <div className="flex justify-between items-start">
 <div>
 <h4 className="font-semibold">{plan.name}</h4>
 <p className="text-sm text-muted-foreground">
 {plan.priceMonthlyCents ? `$${(plan.priceMonthlyCents / 100).toFixed(2)}/month` : 'Free'}
 </p>
 </div>
 <Badge variant="outline">
 {orgSubscriptions.filter(sub => sub.planId === plan.id).length}{t("admin_organization_active")}</Badge>
 </div>
 {plan.limits && <div className="mt-2 text-sm">
 <p className="font-medium">{t("admin_organization_features_limits")}</p>
 <pre className="text-xs text-muted-foreground bg-card p-2 rounded-lg">
 {JSON.stringify(plan.limits, null, 2)}
 </pre>
 </div>}
 </div>)}
 </div>
 </CardContent>
 </Card>

 <Card>
 <CardHeader>
 <CardTitle>{t("admin_organization_subscription_statistics")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 <div className="flex justify-between items-center">
 <span className="text-sm">{t("admin_organization_trial_subscriptions")}</span>
 <span className="font-medium">
 {orgSubscriptions.filter(sub => sub.plan?.key?.includes('TRIAL')).length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm">{t("admin_organization_silver_plans")}</span>
 <span className="font-medium">
 {orgSubscriptions.filter(sub => sub.plan?.key?.includes('SILVER')).length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm">{t("admin_organization_gold_plans")}</span>
 <span className="font-medium">
 {orgSubscriptions.filter(sub => sub.plan?.key?.includes('GOLD')).length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm">{t("admin_organization_professional_plans")}</span>
 <span className="font-medium">
 {orgSubscriptions.filter(sub => sub.plan?.key?.includes('PROFESSIONAL')).length}
 </span>
 </div>
 <div className="flex justify-between items-center">
 <span className="text-sm">{t("admin_organization_enterprise_plans")}</span>
 <span className="font-medium">
 {orgSubscriptions.filter(sub => sub.plan?.key?.includes('ENTERPRISE')).length}
 </span>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 </PageShell>;
}