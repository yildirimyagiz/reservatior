"use client";

import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { ShieldCheck, Lock, Unlock, Plus, DollarSign, Clock, Search, ArrowRightLeft } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { cn } from "@/lib/utils";

interface EscrowAccount {
  id: string;
  orgId: string;
  reservationId: string;
  totalAmount: number;
  depositAmount: number;
  currency: string;
  status: "HOLDING" | "RELEASED" | "DISPUTED" | "REFUNDED";
  heldAt: string;
  releasedAt?: string;
}

export default function EscrowDashboard() {
  const { t } = useTranslation();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/escrow-account/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  const [searchTerm, setSearchTerm] = useState("");
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [releaseTarget, setReleaseTarget] = useState<EscrowAccount | null>(null);
  const [newAccount, setNewAccount] = useState({
    reservationId: "",
    totalAmount: 0,
    depositAmount: 0,
    currency: "USD",
  });

  const { data: accountsData, isLoading } = useQuery({
    queryKey: ['escrow-accounts'],
    queryFn: async () => {
      const res: any = await apiClient.get('/escrow-account');
      return (res?.data || []) as EscrowAccount[];
    },
  });

  const accounts = (accountsData || []) as EscrowAccount[];

  const stats = {
    locked: accounts.filter(a => a.status === "HOLDING").reduce((s, a) => s + a.totalAmount, 0),
    released: accounts.filter(a => a.status === "RELEASED").reduce((s, a) => s + a.totalAmount, 0),
    disputed: accounts.filter(a => a.status === "DISPUTED").length,
    total: accounts.length,
  };

  const createMutation = useMutation({
    mutationFn: async (data: typeof newAccount) => {
      return apiClient.post('/escrow-account', {
        ...data,
        orgId: "org_1",
        heldAt: new Date().toISOString(),
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['escrow-accounts'] });
      setIsAddOpen(false);
      setNewAccount({ reservationId: "", totalAmount: 0, depositAmount: 0, currency: "USD" });
    },
  });

  const releaseMutation = useMutation({
    mutationFn: async ({ id }: { id: string }) => {
      return apiClient.patch(`/escrow-account/${id}`, {
        status: "RELEASED",
        releasedAt: new Date().toISOString(),
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['escrow-accounts'] });
      setReleaseTarget(null);
    },
  });

  const handleAddSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(newAccount);
  };

  const filtered = accounts.filter(a =>
    a.id.toLowerCase().includes(searchTerm.toLowerCase()) ||
    a.reservationId.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const statusConfig: Record<string, { label: string; class: string; icon: any }> = {
    HOLDING: { label: t("admin.escrow.holding", "HOLDING"), class: "bg-slate-500/20 text-slate-400", icon: Lock },
    RELEASED: { label: t("admin.escrow.released", "RELEASED"), class: "bg-emerald-500/20 text-emerald-400", icon: Unlock },
    DISPUTED: { label: t("admin.escrow.disputed", "DISPUTED"), class: "bg-amber-500/20 text-amber-400", icon: ShieldCheck },
    REFUNDED: { label: t("admin.escrow.refunded", "REFUNDED"), class: "bg-slate-500/20 text-slate-400", icon: ArrowRightLeft },
  };

  return (
    <div className="space-y-6 min-h-screen">
      <div className="flex justify-between items-center bg-white/5 p-6 rounded-2xl border border-white/10">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-slate-600 rounded-xl shadow-lg shadow-slate-600/20">
            <ShieldCheck className="w-8 h-8 text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-white">
              {t("admin.escrow.title", "Escrow Management")}
            </h1>
            <p className="text-slate-400">
              {t("admin.escrow.subtitle", "Track and manage SafeStay™ escrow payments")}
            </p>
          </div>
        </div>
        <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
          <DialogTrigger asChild>
            <Button className="bg-slate-600 hover:bg-slate-700 text-white shadow-lg shadow-slate-500/20">
              <Plus className="w-4 h-4 mr-2" />
              {t("admin.escrow.add", "New Escrow")}
            </Button>
          </DialogTrigger>
          <DialogContent className="sm:max-w-[425px] bg-slate-900 border-white/10 text-white">
            <DialogHeader>
              <DialogTitle>{t("admin.escrow.add", "New Escrow Account")}</DialogTitle>
              <DialogDescription className="text-slate-400">
                {t("admin.escrow.add_desc", "Create a new escrow account for a reservation")}
              </DialogDescription>
            </DialogHeader>
            <form onSubmit={handleAddSubmit} className="space-y-4 pt-4">
              <div className="space-y-2">
                <Label htmlFor="reservationId">{t("admin.escrow.reservation_id", "Reservation ID")}</Label>
                <Input id="reservationId" className="bg-white/5 border-white/10 text-white" value={newAccount.reservationId} onChange={e => setNewAccount({ ...newAccount, reservationId: e.target.value })} required />
              </div>
              <div className="space-y-2">
                <Label htmlFor="totalAmount">{t("admin.escrow.total_amount", "Total Amount")}</Label>
                <Input id="totalAmount" type="number" className="bg-white/5 border-white/10 text-white" value={newAccount.totalAmount} onChange={e => setNewAccount({ ...newAccount, totalAmount: Number(e.target.value) })} required />
              </div>
              <div className="space-y-2">
                <Label htmlFor="depositAmount">{t("admin.escrow.deposit_amount", "Deposit Amount")}</Label>
                <Input id="depositAmount" type="number" className="bg-white/5 border-white/10 text-white" value={newAccount.depositAmount} onChange={e => setNewAccount({ ...newAccount, depositAmount: Number(e.target.value) })} required />
              </div>
              <div className="space-y-2">
                <Label htmlFor="currency">{t("admin.escrow.currency", "Currency")}</Label>
                <Input id="currency" className="bg-white/5 border-white/10 text-white" value={newAccount.currency} onChange={e => setNewAccount({ ...newAccount, currency: e.target.value })} />
              </div>
              <DialogFooter>
                <Button type="button" variant="ghost" onClick={() => setIsAddOpen(false)} className="text-slate-300">{t("common.cancel", "Cancel")}</Button>
                <Button type="submit" className="bg-slate-600 hover:bg-slate-700" disabled={createMutation.isPending}>
                  {createMutation.isPending ? t("common.saving", "Saving...") : t("admin.escrow.create", "Create")}
                </Button>
              </DialogFooter>
            </form>
          </DialogContent>
        </Dialog>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.escrow.locked_amount", "Locked Amount")}</p>
                <h3 className="text-2xl font-bold text-white mt-1">${stats.locked.toLocaleString()}</h3>
              </div>
              <div className="p-3 bg-slate-500/20 rounded-lg"><Lock className="w-5 h-5 text-slate-400" /></div>
            </div>
            <p className="text-xs text-slate-500 mt-2">{stats.locked > 0 ? t("admin.escrow.awaiting_release", "Awaiting release") : t("admin.escrow.none_locked", "No locked funds")}</p>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.escrow.released_amount", "Released Amount")}</p>
                <h3 className="text-2xl font-bold text-white mt-1">${stats.released.toLocaleString()}</h3>
              </div>
              <div className="p-3 bg-emerald-500/20 rounded-lg"><Unlock className="w-5 h-5 text-emerald-400" /></div>
            </div>
            <p className="text-xs text-slate-500 mt-2">{t("admin.escrow.transferred", "Transferred to accounts")}</p>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.escrow.disputed_count", "Disputed")}</p>
                <h3 className="text-2xl font-bold text-white mt-1">{stats.disputed}</h3>
              </div>
              <div className="p-3 bg-amber-500/20 rounded-lg"><ShieldCheck className="w-5 h-5 text-amber-400" /></div>
            </div>
            <p className="text-xs text-slate-500 mt-2">{t("admin.escrow.in_dispute", "In dispute resolution")}</p>
          </CardContent>
        </Card>
        <Card className="bg-white/5 border-white/10">
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-xs font-medium text-slate-400">{t("admin.escrow.total", "Total Escrows")}</p>
                <h3 className="text-2xl font-bold text-white mt-1">{stats.total}</h3>
              </div>
              <div className="p-3 bg-slate-500/20 rounded-lg"><DollarSign className="w-5 h-5 text-slate-400" /></div>
            </div>
            <p className="text-xs text-slate-500 mt-2">{t("admin.escrow.all_accounts", "All escrow accounts")}</p>
          </CardContent>
        </Card>
      </div>

      <div className="space-y-4">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div className="relative flex-1 max-w-md">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-500" />
            <Input
              placeholder={t("admin.escrow.search", "Search by ID or reservation...")}
              className="bg-white/5 border-white/10 pl-10 text-white placeholder:text-slate-500"
              value={searchTerm}
              onChange={e => setSearchTerm(e.target.value)}
            />
          </div>
        </div>

        <Card className="bg-white/5 border-white/10 overflow-hidden">
          <CardContent className="p-0">
            <div className="overflow-x-auto">
              <Table>
                <TableHeader className="bg-white/5 border-b border-white/10">
                  <TableRow className="hover:bg-transparent border-none">
                    <TableHead className="text-xs font-medium text-slate-400 py-4 px-6">{t("admin.escrow.id", "ID")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.escrow.reservation", "Reservation")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.escrow.amount", "Amount")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.escrow.status", "Status")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.escrow.date", "Date")}</TableHead>
                    <TableHead className="text-xs font-medium text-slate-400 px-6">{t("admin.escrow.actions", "Actions")}</TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {isLoading ? (
                    <TableRow><TableCell colSpan={6} className="text-center py-8 text-slate-500">{t("common.loading", "Loading...")}</TableCell></TableRow>
                  ) : filtered.length === 0 ? (
                    <TableRow><TableCell colSpan={6} className="text-center py-8 text-slate-500">{t("admin.escrow.no_accounts", "No escrow accounts found")}</TableCell></TableRow>
                  ) : filtered.map((acc) => {
                    const cfg = statusConfig[acc.status] || statusConfig.REFUNDED;
                    const Icon = cfg.icon;
                    return (
                      <TableRow key={acc.id} className="border-b border-white/10 hover:bg-white/5 transition-colors">
                        <TableCell className="py-4 px-6">
                          <span className="text-sm font-mono text-white">{acc.id.slice(0, 8)}...</span>
                        </TableCell>
                        <TableCell className="px-6 text-sm text-slate-300">{acc.reservationId.slice(0, 12)}...</TableCell>
                        <TableCell className="px-6 font-bold text-white">${acc.totalAmount.toLocaleString()}</TableCell>
                        <TableCell className="px-6">
                          <Badge className={cn("border-0 gap-1", cfg.class)}>
                            <Icon className="w-3 h-3" /> {cfg.label}
                          </Badge>
                        </TableCell>
                        <TableCell className="px-6 text-sm text-slate-400">{new Date(acc.heldAt).toLocaleDateString()}</TableCell>
                        <TableCell className="px-6">
                          <div className="flex gap-2">
                            {acc.status === "HOLDING" && (
                              <Dialog open={releaseTarget?.id === acc.id} onOpenChange={(open) => !open && setReleaseTarget(null)}>
                                <DialogTrigger asChild>
                                  <Button size="sm" variant="outline" className="bg-white/5 border-white/10 text-slate-300 hover:bg-white/10" onClick={() => setReleaseTarget(acc)}>
                                    <Unlock className="w-3 h-3 mr-1" /> {t("admin.escrow.release", "Release")}
                                  </Button>
                                </DialogTrigger>
                                <DialogContent className="sm:max-w-[400px] bg-slate-900 border-white/10 text-white">
                                  <DialogHeader>
                                    <DialogTitle>{t("admin.escrow.confirm_release", "Confirm Release")}</DialogTitle>
                                    <DialogDescription className="text-slate-400">
                                      {t("admin.escrow.release_desc", "Release ${amount} from escrow account {id}", { amount: acc.totalAmount.toLocaleString(), id: acc.id.slice(0, 8) })}
                                    </DialogDescription>
                                  </DialogHeader>
                                  <DialogFooter>
                                    <Button variant="ghost" onClick={() => setReleaseTarget(null)} className="text-slate-300">{t("common.cancel", "Cancel")}</Button>
                                    <Button className="bg-emerald-600 hover:bg-emerald-700" onClick={() => releaseMutation.mutate({ id: acc.id })} disabled={releaseMutation.isPending}>
                                      {releaseMutation.isPending ? t("common.processing", "Processing...") : t("admin.escrow.confirm", "Confirm Release")}
                                    </Button>
                                  </DialogFooter>
                                </DialogContent>
                              </Dialog>
                            )}
                          </div>
                        </TableCell>
                      </TableRow>
                    );
                  })}
                </TableBody>
              </Table>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
