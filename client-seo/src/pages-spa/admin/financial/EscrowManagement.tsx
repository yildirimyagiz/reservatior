import React from 'react';
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { DollarSign, Shield, AlertTriangle, Clock, Plus, Search, Loader2 } from "lucide-react";
import { useState } from "react";
import { cn } from "@/lib/utils";

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
  const [formData, setFormData] = useState({ reservationId: "", totalAmount: 0, depositAmount: 0, currency: "USD" });

  const [editingId, setEditingId] = useState<string | null>(null);
  const [editingAccount, setEditingAccount] = useState<any>(null);

  const updateMutation = useMutation({
    mutationFn: async (data: any) => apiClient.put(`/escrow-account/${data.id}`, data),
    onSuccess: () => {
      toast({ title: "Updated", description: "Escrow account updated successfully" });
      queryClient.invalidateQueries({ queryKey: ['escrowAccounts'] });
      setEditingId(null);
      setEditingAccount(null);
    }
  });

  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/escrow-account/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Item deleted successfully" });
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
        orgId: "org_1",
        heldAt: new Date().toISOString(),
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['escrowAccounts'] });
      setIsAddOpen(false);
      setFormData({ reservationId: "", totalAmount: 0, depositAmount: 0, currency: "USD" });
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
    const matchesStatus = statusFilter === "ALL" || account.status === statusFilter;
    return matchesSearch && matchesStatus;
  });

  const totalEscrowAmount = accounts.reduce((sum, a) => sum + a.totalAmount, 0);
  const totalCurrentBalance = accounts.reduce((sum, a) => sum + a.currentBalance, 0);
  const activeDisputes = disputes.filter(d => d.status === 'OPEN' || d.status === 'INVESTIGATING').length;
  const pendingReleases = releases.filter(r => r.status === 'PENDING').length;

  const statusColor = (status: string) => {
    const map: Record<string, string> = {
      PENDING: 'bg-amber-500', FUNDED: 'bg-blue-500', RELEASED: 'bg-emerald-500',
      DISPUTED: 'bg-red-500', CLOSED: 'bg-slate-500', OPEN: 'bg-red-500',
      INVESTIGATING: 'bg-orange-500', RESOLVED: 'bg-emerald-500',
      APPROVED: 'bg-emerald-600', REJECTED: 'bg-red-600', COMPLETED: 'bg-emerald-500',
    };
    return map[status] || 'bg-slate-500';
  };

  if (loading) {
    return (
      <div className="p-6 min-h-screen flex items-center justify-center">
        <Loader2 className="w-8 h-8 animate-spin text-slate-400" />
      </div>
    );
  }

  return (
    <div className="p-6 space-y-6 min-h-screen">
      <div className="flex justify-between items-center bg-white/5 p-6 rounded-2xl border border-white/10">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-blue-600 rounded-xl shadow-lg shadow-blue-600/20">
            <Shield className="w-8 h-8 text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-white">
              {t("admin.financial.escrow_title", "Escrow Management")}
            </h1>
            <p className="text-slate-400">
              {t("admin.financial.escrow_desc", "Manage secure payment transactions, releases and disputes")}
            </p>
          </div>
        </div>
        <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
          <DialogTrigger asChild>
            <Button className="bg-blue-600 hover:bg-blue-700 text-white shadow-lg shadow-blue-500/20">
              <Plus className="w-4 h-4 mr-2" />
              {t("admin.financial.new_escrow", "New Escrow")}
            </Button>
          </DialogTrigger>
          <DialogContent className="sm:max-w-[425px] bg-slate-900 border-white/10 text-white">
            <DialogHeader>
              <DialogTitle>{t("admin.financial.new_escrow", "New Escrow Account")}</DialogTitle>
              <DialogDescription className="text-slate-400">{t("admin.financial.escrow_add_desc", "Enter the escrow account details")}</DialogDescription>
            </DialogHeader>
            <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
              <div className="space-y-2">
                <Label htmlFor="reservationId">{t("admin.financial.reservation_id", "Reservation ID")}</Label>
                <Input id="reservationId" className="bg-white/5 border-white/10 text-white" value={formData.reservationId} onChange={e => setFormData({ ...formData, reservationId: e.target.value })} required />
              </div>
              <div className="space-y-2">
                <Label htmlFor="totalAmount">{t("admin.financial.total_amount", "Total Amount")}</Label>
                <Input id="totalAmount" type="number" className="bg-white/5 border-white/10 text-white" value={formData.totalAmount} onChange={e => setFormData({ ...formData, totalAmount: Number(e.target.value) })} required />
              </div>
              <div className="space-y-2">
                <Label htmlFor="depositAmount">{t("admin.financial.deposit_amount", "Deposit Amount")}</Label>
                <Input id="depositAmount" type="number" className="bg-white/5 border-white/10 text-white" value={formData.depositAmount} onChange={e => setFormData({ ...formData, depositAmount: Number(e.target.value) })} required />
              </div>
              <DialogFooter>
                <Button type="button" variant="ghost" onClick={() => setIsAddOpen(false)} className="text-slate-300">{t("common.cancel", "Cancel")}</Button>
                <Button type="submit" className="bg-blue-600 hover:bg-blue-700" disabled={createMutation.isPending}>
                  {createMutation.isPending ? t("common.saving", "Saving...") : t("common.create", "Create")}
                </Button>
              </DialogFooter>
            </form>
          </DialogContent>
        </Dialog>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.financial.total", "Total")}</p>
                <h3 className="text-2xl font-bold text-white mt-1">${totalEscrowAmount.toLocaleString()}</h3>
              </div>
              <div className="p-3 bg-blue-500/20 rounded-lg"><DollarSign className="w-5 h-5 text-blue-400" /></div>
            </div>
            <p className="text-xs text-slate-500 mt-2">{accounts.length} {t("admin.financial.active_accounts", "accounts")}</p>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.financial.balance", "Balance")}</p>
                <h3 className="text-2xl font-bold text-emerald-400 mt-1">${totalCurrentBalance.toLocaleString()}</h3>
              </div>
              <div className="p-3 bg-emerald-500/20 rounded-lg"><Shield className="w-5 h-5 text-emerald-400" /></div>
            </div>
            <p className="text-xs text-slate-500 mt-2">{t("admin.financial.held_funds", "Held in escrow")}</p>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.financial.disputes", "Disputes")}</p>
                <h3 className="text-2xl font-bold text-red-400 mt-1">{activeDisputes}</h3>
              </div>
              <div className="p-3 bg-red-500/20 rounded-lg"><AlertTriangle className="w-5 h-5 text-red-400" /></div>
            </div>
            <p className="text-xs text-slate-500 mt-2">{t("admin.financial.require_attention", "Requires attention")}</p>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.financial.pending_releases", "Pending Releases")}</p>
                <h3 className="text-2xl font-bold text-orange-400 mt-1">{pendingReleases}</h3>
              </div>
              <div className="p-3 bg-orange-500/20 rounded-lg"><Clock className="w-5 h-5 text-orange-400" /></div>
            </div>
            <p className="text-xs text-slate-500 mt-2">{t("admin.financial.awaiting_approval", "Awaiting approval")}</p>
          </CardContent>
        </Card>
      </div>

      <Tabs defaultValue="accounts" className="space-y-6">
        <TabsList className="bg-white/5 border border-white/10">
          <TabsTrigger value="accounts" className="data-[state=active]:bg-blue-600 data-[state=active]:text-white">
            {t("admin.financial.accounts", "Accounts")}
          </TabsTrigger>
          <TabsTrigger value="releases" className="data-[state=active]:bg-blue-600 data-[state=active]:text-white">
            {t("admin.financial.releases", "Releases")}
          </TabsTrigger>
          <TabsTrigger value="disputes" className="data-[state=active]:bg-blue-600 data-[state=active]:text-white">
            {t("admin.financial.disputes", "Disputes")}
          </TabsTrigger>
        </TabsList>

        <TabsContent value="accounts" className="space-y-4">
          <div className="flex flex-col md:flex-row items-center justify-between gap-4">
            <div className="flex flex-wrap items-center gap-3 flex-1">
              <div className="relative flex-1 max-w-md">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500" />
                <Input placeholder={t("admin.financial.search", "Search...")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="bg-white/5 border-white/10 pl-10 text-white placeholder:text-slate-500" />
              </div>
              <Select value={statusFilter} onValueChange={setStatusFilter}>
                <SelectTrigger className="w-36 bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
                <SelectContent className="bg-slate-900 border-white/10 text-white">
                  <SelectItem value="ALL">{t("admin.financial.all_status", "All")}</SelectItem>
                  <SelectItem value="PENDING">Pending</SelectItem>
                  <SelectItem value="FUNDED">Funded</SelectItem>
                  <SelectItem value="RELEASED">Released</SelectItem>
                  <SelectItem value="DISPUTED">Disputed</SelectItem>
                  <SelectItem value="CLOSED">Closed</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>

          <Card className="bg-white/5 border-white/10 overflow-hidden">
            <CardContent className="p-0">
              <Table>
                <TableHeader className="bg-white/5 border-b border-white/10">
                  <TableRow className="hover:bg-transparent border-none">
                    <TableHead className="text-xs font-medium text-slate-400 py-4 px-6">{t("admin.financial.account", "Account")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.property", "Property")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.parties", "Parties")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.amount", "Amount")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.balance", "Balance")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.status", "Status")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.created", "Created")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredAccounts.map(account => (
                    <TableRow key={account.id} className="border-b border-white/10 hover:bg-white/5 transition-colors">
                      <TableCell className="py-4 px-6 font-mono text-xs text-slate-400">#{account.accountNumber}</TableCell>
                      <TableCell className="px-6 text-sm text-white">{account.propertyName}</TableCell>
                      <TableCell className="px-6">
                        <div className="text-sm text-slate-300">
                          <div>{account.buyerName}</div>
                          <div className="text-xs text-slate-500">{account.sellerName}</div>
                        </div>
                      </TableCell>
                      <TableCell className="px-6 font-bold text-white">${account.totalAmount.toLocaleString()}</TableCell>
                      <TableCell className="px-6 text-emerald-400 font-medium">${account.currentBalance.toLocaleString()}</TableCell>
                      <TableCell className="px-6">
                        <div className="flex items-center gap-2">
                          <div className={cn("w-2 h-2 rounded-full", statusColor(account.status))} />
                          <span className="text-sm text-slate-300">{account.status}</span>
                        </div>
                      </TableCell>
                      <TableCell className="px-6 text-xs text-slate-400 font-mono">{new Date(account.createdAt).toLocaleDateString()}</TableCell>
                      <TableCell className="px-6 text-right">
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" className="h-8 w-8 p-0"><MoreHorizontal className="h-4 w-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="bg-slate-900 border-white/10 text-white">
                            <DropdownMenuItem onClick={() => setEditingId(account.id)} className="cursor-pointer hover:bg-white/10"><Edit className="mr-2 h-4 w-4" /> Edit</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => deleteMutation.mutate(account.id)} className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> Delete</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>
                  ))}
                  {filteredAccounts.length === 0 && (
                    <TableRow><TableCell colSpan={8} className="text-center py-8 text-slate-500">{t("admin.financial.no_accounts", "No accounts found")}</TableCell></TableRow>
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="releases">
          <Card className="bg-white/5 border-white/10 overflow-hidden">
            <CardContent className="p-0">
              <Table>
                <TableHeader className="bg-white/5 border-b border-white/10">
                  <TableRow className="hover:bg-transparent border-none">
                    <TableHead className="text-xs font-medium text-slate-400 py-4 px-6">{t("admin.financial.account", "Account")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.amount", "Amount")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.type", "Type")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.recipient", "Recipient")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.status", "Status")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.requested", "Requested")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {releases.map(release => (
                    <TableRow key={release.id} className="border-b border-white/10 hover:bg-white/5 transition-colors">
                      <TableCell className="py-4 px-6 font-mono text-xs text-slate-400">#{release.escrowAccountId.slice(0, 8)}</TableCell>
                      <TableCell className="px-6 font-bold text-white">${release.amount.toLocaleString()}</TableCell>
                      <TableCell className="px-6"><Badge className="bg-white/5 text-slate-300 border-white/10">{release.releaseType}</Badge></TableCell>
                      <TableCell className="px-6 text-sm text-slate-300">{release.recipient}</TableCell>
                      <TableCell className="px-6">
                        <div className="flex items-center gap-2">
                          <div className={cn("w-2 h-2 rounded-full", statusColor(release.status))} />
                          <span className="text-sm text-slate-300">{release.status}</span>
                        </div>
                      </TableCell>
                      <TableCell className="px-6 text-xs text-slate-400">{new Date(release.requestedAt).toLocaleDateString()}</TableCell>
                      <TableCell className="px-6 text-right">
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" className="h-8 w-8 p-0"><MoreHorizontal className="h-4 w-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="bg-slate-900 border-white/10 text-white">
                            <DropdownMenuItem onClick={() => deleteMutation.mutate(release.id)} className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> Delete</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>
                  ))}
                  {releases.length === 0 && (
                    <TableRow><TableCell colSpan={7} className="text-center py-8 text-slate-500">{t("admin.financial.no_releases", "No releases found")}</TableCell></TableRow>
                  )}
                </TableBody>
              </Table>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="disputes">
          <Card className="bg-white/5 border-white/10 overflow-hidden">
            <CardContent className="p-0">
              <Table>
                <TableHeader className="bg-white/5 border-b border-white/10">
                  <TableRow className="hover:bg-transparent border-none">
                    <TableHead className="text-xs font-medium text-slate-400 py-4 px-6">{t("admin.financial.account", "Account")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.initiated_by", "Initiated By")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.type", "Type")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.description", "Description")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.status", "Status")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.financial.created", "Created")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {disputes.map(dispute => (
                    <TableRow key={dispute.id} className="border-b border-white/10 hover:bg-white/5 transition-colors">
                      <TableCell className="py-4 px-6 font-mono text-xs text-slate-400">#{dispute.escrowAccountId.slice(0, 8)}</TableCell>
                      <TableCell className="px-6 text-sm text-slate-300">{dispute.initiatedBy}</TableCell>
                      <TableCell className="px-6"><Badge className="bg-white/5 text-slate-300 border-white/10">{dispute.disputeType}</Badge></TableCell>
                      <TableCell className="px-6 text-sm text-slate-400 max-w-xs truncate">{dispute.description}</TableCell>
                      <TableCell className="px-6">
                        <div className="flex items-center gap-2">
                          <div className={cn("w-2 h-2 rounded-full", statusColor(dispute.status))} />
                          <span className="text-sm text-slate-300">{dispute.status}</span>
                        </div>
                      </TableCell>
                      <TableCell className="px-6 text-xs text-slate-400">{new Date(dispute.createdAt).toLocaleDateString()}</TableCell>
                      <TableCell className="px-6 text-right">
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" className="h-8 w-8 p-0"><MoreHorizontal className="h-4 w-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="bg-slate-900 border-white/10 text-white">
                            <DropdownMenuItem onClick={() => deleteMutation.mutate(dispute.id)} className="cursor-pointer text-red-400 hover:bg-red-400/10"><Trash2 className="mr-2 h-4 w-4" /> Delete</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>
                  ))}
                  {disputes.length === 0 && (
                    <TableRow><TableCell colSpan={7} className="text-center py-8 text-slate-500">{t("admin.financial.no_disputes", "No disputes found")}</TableCell></TableRow>
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
        <DialogContent className="sm:max-w-[425px] bg-slate-900 border-white/10 text-white">
          <DialogHeader>
            <DialogTitle>Edit Escrow Status</DialogTitle>
          </DialogHeader>
          <div className="space-y-4 pt-4">
            <div className="space-y-2">
              <Label>Status</Label>
              <Select value={editingAccount?.status || "HOLDING"} onValueChange={v => setEditingAccount({ ...editingAccount, status: v })}>
                <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
                <SelectContent className="bg-slate-900 border-white/10 text-white">
                  <SelectItem value="HOLDING">HOLDING</SelectItem>
                  <SelectItem value="RELEASED">RELEASED</SelectItem>
                  <SelectItem value="DISPUTED">DISPUTED</SelectItem>
                  <SelectItem value="CLOSED">CLOSED</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <DialogFooter>
              <Button variant="ghost" onClick={() => setEditingId(null)}>Cancel</Button>
              <Button className="bg-blue-600 hover:bg-blue-700" onClick={() => updateMutation.mutate({ id: editingId, ...editingAccount })}>Save</Button>
            </DialogFooter>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}
