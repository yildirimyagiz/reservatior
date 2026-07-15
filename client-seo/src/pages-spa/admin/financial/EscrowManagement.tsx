"use client";

import React from 'react';
import { useTranslation } from"react-i18next";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuTrigger, DropdownMenuContent, DropdownMenuItem } from"@/components/ui/dropdown-menu";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { useToast } from"@/hooks/use-toast";
import { DollarSign, Shield, AlertTriangle, Clock, Plus, Search, Loader2, MoreHorizontal, Edit, Trash2 } from"lucide-react";
import { useState } from"react";
import { cn } from"@/lib/utils";

interface EscrowAccount {
 id: string;
 accountNumber: string;
 propertyName: string;
 buyerName: string;
 sellerName: string;
 totalAmount: number;
 currentBalance: number;
 status: 'PENDING' | 'FUNDED' | 'RELEASED' | 'DISPUTED' | 'CLOSED';
 createdAt: string;
 releaseDate?: string;
 dealId: string;
 isZeroDeposit?: boolean;
}

interface EscrowRelease {
 id: string;
 escrowAccountId: string;
 amount: number;
 releaseType: 'FULL' | 'PARTIAL' | 'CONTINGENT';
 recipient: string;
 status: 'PENDING' | 'APPROVED' | 'REJECTED' | 'COMPLETED';
 requestedAt: string;
 processedAt?: string;
 notes?: string;
}

interface EscrowDispute {
 id: string;
 escrowAccountId: string;
 initiatedBy: string;
 disputeType: 'FUNDS' | 'TIMELINE' | 'DOCUMENTS' | 'OTHER';
 description: string;
 status: 'OPEN' | 'INVESTIGATING' | 'RESOLVED' | 'CLOSED';
 createdAt: string;
 resolvedAt?: string;
 resolution?: string;
}

export default function EscrowManagement() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 
 
 
 const { t } = useTranslation();
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [searchTerm, setSearchTerm] = useState("");
 const [statusFilter, setStatusFilter] = useState("ALL");
 const [formData, setFormData] = useState({ reservationId:"", totalAmount: 0, depositAmount: 0, currency:"USD" });

 const [editingId, setEditingId] = useState<string | null>(null);
 const [editingAccount, setEditingAccount] = useState<any>(null);

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/escrow-account/${data.id}`, data),
 onSuccess: () => {
 toast({ title:"Updated", description:"Escrow account updated successfully" });
 queryClient.invalidateQueries({ queryKey: ['escrowAccounts'] });
 setEditingId(null);
 setEditingAccount(null);
 }
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/escrow-account/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Item deleted successfully" });
 queryClient.invalidateQueries({ queryKey: ['escrowAccounts'] });
 queryClient.invalidateQueries({ queryKey: ['escrowReleases'] });
 queryClient.invalidateQueries({ queryKey: ['escrowDisputes'] });
 }
 });

 const { data: accountsData, isLoading: loadingAccounts } = useQuery({
 queryKey: ['escrowAccounts'],
 queryFn: async () => {
 const res: any = await apiClient.get('/escrow-account');
 return (res?.data || []) as EscrowAccount[];
 },
 });

 const { data: releasesData, isLoading: loadingReleases } = useQuery({
 queryKey: ['escrowReleases'],
 queryFn: async () => {
 const res: any = await apiClient.get('/escrow-release');
 return (res?.data || []) as EscrowRelease[];
 },
 });

 const { data: disputesData, isLoading: loadingDisputes } = useQuery({
 queryKey: ['escrowDisputes'],
 queryFn: async () => {
 const res: any = await apiClient.get('/escrow-dispute');
 return (res?.data || []) as EscrowDispute[];
 },
 });

 const accounts = (accountsData || []) as EscrowAccount[];
 const releases = (releasesData || []) as EscrowRelease[];
 const disputes = (disputesData || []) as EscrowDispute[];
 const loading = loadingAccounts || loadingReleases || loadingDisputes;

 const createMutation = useMutation({
 mutationFn: async (data: typeof formData) => {
 return apiClient.post('/escrow-account', {
 ...data,
 orgId:"org_1",
 heldAt: new Date().toISOString(),
 });
 },
 onSuccess: () => {
 queryClient.invalidateQueries({ queryKey: ['escrowAccounts'] });
 setIsAddOpen(false);
 setFormData({ reservationId:"", totalAmount: 0, depositAmount: 0, currency:"USD" });
 },
 });

 const handleAddSubmit = (e: React.FormEvent) => {
 e.preventDefault();
 createMutation.mutate(formData);
 };

 const filteredAccounts = accounts.filter(account => {
 const matchesSearch = account.propertyName?.toLowerCase().includes(searchTerm.toLowerCase()) ||
 account.buyerName?.toLowerCase().includes(searchTerm.toLowerCase()) ||
 account.sellerName?.toLowerCase().includes(searchTerm.toLowerCase());
 const matchesStatus = statusFilter ==="ALL" || account.status === statusFilter;
 return matchesSearch && matchesStatus;
 });

 const totalEscrowAmount = accounts.reduce((sum, a) => sum + a.totalAmount, 0);
 const totalCurrentBalance = accounts.reduce((sum, a) => sum + a.currentBalance, 0);
 const activeDisputes = disputes.filter(d => d.status === 'OPEN' || d.status === 'INVESTIGATING').length;
 const pendingReleases = releases.filter(r => r.status === 'PENDING').length;

 const statusColor = (status: string) => {
 const map: Record<string, string> = {
 PENDING: 'bg-amber-500', FUNDED: 'bg-muted0', RELEASED: 'bg-emerald-500',
 DISPUTED: 'bg-red-500', CLOSED: 'bg-muted0', OPEN: 'bg-red-500',
 INVESTIGATING: 'bg-orange-500', RESOLVED: 'bg-emerald-500',
 APPROVED: 'bg-emerald-600', REJECTED: 'bg-red-600', COMPLETED: 'bg-emerald-500',
 };
 return map[status] || 'bg-muted0';
 };

 if (loading) {
 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen flex items-center justify-center space-y-6">
 <Loader2 className="w-8 h-8 animate-spin text-muted-foreground" />
 </div>
 );
 }

 return (
 <div className="p-6 space-y-6 min-h-screen">
 <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center gap-4">
 <div className="p-3 bg-slate-600 rounded-xl shadow-lg shadow-slate-600/20">
 <Shield className="w-8 h-8 text-foreground" />
 </div>
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">
 {t("admin_financial_escrow_title","Escrow Management")}
 </h1>
 <p className="text-muted-foreground">
 {t("admin_financial_escrow_desc","Manage secure payment transactions, releases and disputes")}
 </p>
 </div>
 </div>
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button className="bg-slate-600 hover:bg-slate-700 text-foreground shadow-lg shadow-slate-500/20">
 <Plus className="w-4 h-4 mr-2" />
 {t("admin_financial_new_escrow","New Escrow")}
 </Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_financial_new_escrow","New Escrow Account")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">{t("admin_financial_escrow_add_desc","Enter the escrow account details")}</DialogDescription>
 </DialogHeader>
 <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label htmlFor="reservationId">{t("admin_financial_reservation_id","Reservation ID")}</Label>
 <Input id="reservationId" className="bg-card border-border text-foreground" value={formData.reservationId} onChange={e => setFormData({ ...formData, reservationId: e.target.value })} required />
 </div>
 <div className="space-y-2">
 <Label htmlFor="totalAmount">{t("admin_financial_total_amount","Total Amount")}</Label>
 <Input id="totalAmount" type="number" className="bg-card border-border text-foreground" value={formData.totalAmount} onChange={e => setFormData({ ...formData, totalAmount: Number(e.target.value) })} required />
 </div>
 <div className="space-y-2">
 <Label htmlFor="depositAmount">{t("admin_financial_deposit_amount","Deposit Amount")}</Label>
 <Input id="depositAmount" type="number" className="bg-card border-border text-foreground" value={formData.depositAmount} onChange={e => setFormData({ ...formData, depositAmount: Number(e.target.value) })} required />
 </div>
 <DialogFooter>
 <Button type="button" variant="ghost" onClick={() => setIsAddOpen(false)} className="text-slate-300">{t("common.cancel","Cancel")}</Button>
 <Button type="submit" className="bg-slate-600 hover:bg-slate-700" disabled={createMutation.isPending}>
 {createMutation.isPending ? t("common.saving","Saving...") : t("common.create","Create")}
 </Button>
 </DialogFooter>
 </form>
 </DialogContent>
 </Dialog>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_total","Total")}</p>
 <h3 className="text-2xl font-bold text-foreground mt-1">{t("currency_symbol", "$")}{totalEscrowAmount.toLocaleString()}</h3>
 </div>
 <div className="p-3 bg-muted0/20 rounded-lg"><DollarSign className="w-5 h-5 text-muted-foreground" /></div>
 </div>
 <p className="text-xs text-slate-500 mt-2">{accounts.length} {t("admin_financial_active_accounts","accounts")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_balance","Balance")}</p>
 <h3 className="text-2xl font-bold text-emerald-400 mt-1">{t("currency_symbol", "$")}{totalCurrentBalance.toLocaleString()}</h3>
 </div>
 <div className="p-3 bg-emerald-500/20 rounded-lg"><Shield className="w-5 h-5 text-emerald-400" /></div>
 </div>
 <p className="text-xs text-slate-500 mt-2">{t("admin_financial_held_funds","Held in escrow")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_disputes","Disputes")}</p>
 <h3 className="text-2xl font-bold text-red-400 mt-1">{activeDisputes}</h3>
 </div>
 <div className="p-3 bg-red-500/20 rounded-lg"><AlertTriangle className="w-5 h-5 text-red-400" /></div>
 </div>
 <p className="text-xs text-slate-500 mt-2">{t("admin_financial_require_attention","Requires attention")}</p>
 </CardContent>
 </Card>
 <Card className="bg-card border-border">
 <CardContent className="p-6">
 <div className="flex items-center justify-between">
 <div>
 <p className="text-xs font-medium text-muted-foreground">{t("admin_financial_pending_releases","Pending Releases")}</p>
 <h3 className="text-2xl font-bold text-orange-400 mt-1">{pendingReleases}</h3>
 </div>
 <div className="p-3 bg-orange-500/20 rounded-lg"><Clock className="w-5 h-5 text-orange-400" /></div>
 </div>
 <p className="text-xs text-slate-500 mt-2">{t("admin_financial_awaiting_approval","Awaiting approval")}</p>
 </CardContent>
 </Card>
 </div>

 <Tabs defaultValue="accounts" className="space-y-6">
 <TabsList className="bg-card border border-border">
 <TabsTrigger value="accounts" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">
 {t("admin_financial_accounts","Accounts")}
 </TabsTrigger>
 <TabsTrigger value="releases" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">
 {t("admin_financial_releases","Releases")}
 </TabsTrigger>
 <TabsTrigger value="disputes" className="data-[state=active]:bg-slate-600 data-[state=active]:text-white">
 {t("admin_financial_disputes","Disputes")}
 </TabsTrigger>
 </TabsList>

 <TabsContent value="accounts" className="space-y-4">
 <div className="flex flex-col md:flex-row items-center justify-between gap-4">
 <div className="flex flex-wrap items-center gap-3 flex-1">
 <div className="relative flex-1 max-w-md">
 <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500" />
 <Input placeholder={t("admin_financial_search","Search...")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="bg-card border-border pl-10 text-foreground placeholder:text-slate-500" />
 </div>
 <Select value={statusFilter} onValueChange={setStatusFilter}>
 <SelectTrigger className="w-36 bg-card border-border text-foreground"><SelectValue /></SelectTrigger>
 <SelectContent className="bg-background border-border text-foreground">
 <SelectItem value="ALL">{t("admin_financial_all_status","All")}</SelectItem>
 <SelectItem value="PENDING">{t("admin_ai_pending", "Pending")}</SelectItem>
 <SelectItem value="FUNDED">{t("admin_financial_funded", "Funded")}</SelectItem>
 <SelectItem value="RELEASED">{t("admin_financial_released", "Released")}</SelectItem>
 <SelectItem value="DISPUTED">{t("admin_financial_disputed", "Disputed")}</SelectItem>
 <SelectItem value="CLOSED">{t("admin_financial_closed", "Closed")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>

 <Card className="bg-card border-border overflow-hidden">
 <CardContent className="p-0">
 <Table>
 <TableHeader className="bg-card border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_financial_account","Account")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_property","Property")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_parties","Parties")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_amount","Amount")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_balance","Balance")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_status","Status")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_created","Created")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filteredAccounts.map(account => (
 <TableRow key={account.id} className="border-b border-border hover:bg-card transition-colors">
 <TableCell className="py-4 px-6 font-mono text-xs text-muted-foreground">#{account.accountNumber}</TableCell>
 <TableCell className="px-6 text-sm text-foreground">{account.propertyName}</TableCell>
 <TableCell className="px-6">
 <div className="text-sm text-slate-300">
 <div>{account.buyerName}</div>
 <div className="text-xs text-slate-500">{account.sellerName}</div>
 </div>
 </TableCell>
 <TableCell className="px-6 font-bold text-foreground">{t("currency_symbol", "$")}{account.totalAmount.toLocaleString()}</TableCell>
 <TableCell className="px-6 text-emerald-400 font-medium">{t("currency_symbol", "$")}{account.currentBalance.toLocaleString()}</TableCell>
 <TableCell className="px-6">
 <div className="flex items-center gap-2">
 <div className={cn("w-2 h-2 rounded-full", statusColor(account.status))} />
 <span className="text-sm text-slate-300">{account.status}</span>
 </div>
 </TableCell>
 <TableCell className="px-6 text-xs text-muted-foreground font-mono">{new Date(account.createdAt).toLocaleDateString()}</TableCell>
 <TableCell className="px-6 text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild><Button variant="ghost" className="h-8 w-8 p-0"><MoreHorizontal className="h-4 w-4" /></Button></DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-background border-border text-foreground">
 <DropdownMenuItem onClick={() => setEditingId(account.id)} className="cursor-pointer hover:bg-white/10"><Edit className="mr-2 h-4 w-4" /> {t("admin_action_edit", "Edit")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => deleteMutation.mutate(account.id)} className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> {t("admin_action_delete", "Delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>
 ))}
 {filteredAccounts.length === 0 && (
 <TableRow><TableCell colSpan={8} className="text-center py-8 text-slate-500">{t("admin_financial_no_accounts","No accounts found")}</TableCell></TableRow>
 )}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="releases">
 <Card className="bg-card border-border overflow-hidden">
 <CardContent className="p-0">
 <Table>
 <TableHeader className="bg-card border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_financial_account","Account")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_amount","Amount")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_type","Type")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_recipient","Recipient")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_status","Status")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_requested","Requested")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {releases.map(release => (
 <TableRow key={release.id} className="border-b border-border hover:bg-card transition-colors">
 <TableCell className="py-4 px-6 font-mono text-xs text-muted-foreground">#{release.escrowAccountId.slice(0, 8)}</TableCell>
 <TableCell className="px-6 font-bold text-foreground">{t("currency_symbol", "$")}{release.amount.toLocaleString()}</TableCell>
 <TableCell className="px-6"><Badge className="bg-card text-slate-300 border-border">{release.releaseType}</Badge></TableCell>
 <TableCell className="px-6 text-sm text-slate-300">{release.recipient}</TableCell>
 <TableCell className="px-6">
 <div className="flex items-center gap-2">
 <div className={cn("w-2 h-2 rounded-full", statusColor(release.status))} />
 <span className="text-sm text-slate-300">{release.status}</span>
 </div>
 </TableCell>
 <TableCell className="px-6 text-xs text-muted-foreground">{new Date(release.requestedAt).toLocaleDateString()}</TableCell>
 <TableCell className="px-6 text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild><Button variant="ghost" className="h-8 w-8 p-0"><MoreHorizontal className="h-4 w-4" /></Button></DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-background border-border text-foreground">
 <DropdownMenuItem onClick={() => deleteMutation.mutate(release.id)} className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> {t("admin_action_delete", "Delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>
 ))}
 {releases.length === 0 && (
 <TableRow><TableCell colSpan={7} className="text-center py-8 text-slate-500">{t("admin_financial_no_releases","No releases found")}</TableCell></TableRow>
 )}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>

 <TabsContent value="disputes">
 <Card className="bg-card border-border overflow-hidden">
 <CardContent className="p-0">
 <Table>
 <TableHeader className="bg-card border-b border-border">
 <TableRow className="hover:bg-transparent border-none">
 <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_financial_account","Account")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_initiated_by","Initiated By")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_type","Type")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_description","Description")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_status","Status")}</TableHead>
 <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_financial_created","Created")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {disputes.map(dispute => (
 <TableRow key={dispute.id} className="border-b border-border hover:bg-card transition-colors">
 <TableCell className="py-4 px-6 font-mono text-xs text-muted-foreground">#{dispute.escrowAccountId.slice(0, 8)}</TableCell>
 <TableCell className="px-6 text-sm text-slate-300">{dispute.initiatedBy}</TableCell>
 <TableCell className="px-6"><Badge className="bg-card text-slate-300 border-border">{dispute.disputeType}</Badge></TableCell>
 <TableCell className="px-6 text-sm text-muted-foreground max-w-xs truncate">{dispute.description}</TableCell>
 <TableCell className="px-6">
 <div className="flex items-center gap-2">
 <div className={cn("w-2 h-2 rounded-full", statusColor(dispute.status))} />
 <span className="text-sm text-slate-300">{dispute.status}</span>
 </div>
 </TableCell>
 <TableCell className="px-6 text-xs text-muted-foreground">{new Date(dispute.createdAt).toLocaleDateString()}</TableCell>
 <TableCell className="px-6 text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild><Button variant="ghost" className="h-8 w-8 p-0"><MoreHorizontal className="h-4 w-4" /></Button></DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="bg-background border-border text-foreground">
 <DropdownMenuItem onClick={() => deleteMutation.mutate(dispute.id)} className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> {t("admin_action_delete", "Delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>
 ))}
 {disputes.length === 0 && (
 <TableRow><TableCell colSpan={7} className="text-center py-8 text-slate-500">{t("admin_financial_no_disputes","No disputes found")}</TableCell></TableRow>
 )}
 </TableBody>
 </Table>
 </CardContent>
 </Card>
 </TabsContent>
 </Tabs>

 <Dialog open={!!editingId} onOpenChange={(open) => {
 if (!open) {
 setEditingId(null);
 setEditingAccount(null);
 }
 }}>
 <DialogContent className="sm:max-w-[425px] bg-background border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_edit_escrow_status", "Edit Escrow Status")}</DialogTitle>
 </DialogHeader>
 <div className="space-y-4 pt-4">
 <div className="space-y-2">
 <Label>{t("admin_auto_status", "Status")}</Label>
 <Select value={editingAccount?.status ||"HOLDING"} onValueChange={v => setEditingAccount({ ...editingAccount, status: v })}>
 <SelectTrigger className="bg-card border-border text-foreground"><SelectValue /></SelectTrigger>
 <SelectContent className="bg-background border-border text-foreground">
 <SelectItem value="HOLDING">{t("mobile.finance.escrowHolding", "HOLDING")}</SelectItem>
 <SelectItem value="RELEASED">{t("mobile.finance.escrowReleased", "RELEASED")}</SelectItem>
 <SelectItem value="DISPUTED">{t("mobile.finance.escrowDisputed", "DISPUTED")}</SelectItem>
 <SelectItem value="CLOSED">{t("admin_auto_closed", "CLOSED")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 <DialogFooter>
 <Button variant="ghost" onClick={() => setEditingId(null)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button className="bg-slate-600 hover:bg-slate-700" onClick={() => updateMutation.mutate({ id: editingId, ...editingAccount })}>{t("admin_action_save", "Save")}</Button>
 </DialogFooter>
 </div>
 </DialogContent>
 </Dialog>
 </div>
 );
}
