"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect, FormEvent } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { escrowApi, type EscrowAccount } from "@/lib/api/escrow";
import { MoreHorizontal, CheckCircle2, AlertCircle, Loader2, RefreshCw } from "lucide-react";
const STATUS = {
  HOLDING: {
    label: t("admin.financial.holding"),
    cls: "bg-slate-100 text-slate-700",
    icon: "Clock"
  },
  RELEASED: {
    label: t("admin.financial.released"),
    cls: "bg-green-100 text-green-700",
    icon: "CheckCircle2"
  },
  DISPUTED: {
    label: t("admin.financial.disputed"),
    cls: "bg-red-100 text-red-700",
    icon: "AlertCircle"
  },
  REFUNDED: {
    label: t("admin.financial.refunded"),
    cls: "bg-yellow-100 text-yellow-700",
    icon: "DollarSign"
  }
};
const EMPTY_FORM = {
  orgId: "",
  reservationId: "",
  totalAmount: "",
  depositAmount: "",
  currency: "USD"
};
export default function Escrow() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [accounts, setAccounts] = useState<EscrowAccount[]>([]);
  const [loading, setLoading] = useState(true);
  const [createOpen, setCreateOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const fetchAccounts = async () => {
    try {
      setLoading(true);
      const response = (await escrowApi.getAccounts()) as any;
      setAccounts(Array.isArray(response) ? response : response?.data || []);
    } catch (error) {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_load_escrow"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchAccounts();
  }, []);
  const filtered = accounts.filter(e => {
    const m = e.reservationId.toLowerCase().includes(search.toLowerCase()) || (e.reservation?.listing?.name || "").toLowerCase().includes(search.toLowerCase());
    return m && (filterStatus === "all" || e.status === filterStatus);
  });
  const handleCreate = async (ev: FormEvent) => {
    ev.preventDefault();
    try {
      await escrowApi.createAccount({
        ...form,
        totalAmount: parseFloat(form.totalAmount),
        depositAmount: parseFloat(form.depositAmount)
      });
      setCreateOpen(false);
      toast({
        title: t("admin.financial.escrow_account_created")
      });
      fetchAccounts();
    } catch (error) {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_create_escrow"),
        variant: "destructive"
      });
    }
  };
  const handleRelease = async (e: EscrowAccount) => {
    try {
      await escrowApi.releaseFunds(e.id, {
        orgId: e.orgId,
        triggerEvent: "MANUAL_RELEASE",
        releasePercent: 100,
        amount: e.depositAmount,
        currency: e.currency
      });
      toast({
        title: t("admin.financial.funds_released")
      });
      fetchAccounts();
    } catch (error) {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_release_funds"),
        variant: "destructive"
      });
    }
  };
  const handleDispute = async (e: EscrowAccount) => {
    try {
      await escrowApi.openDispute(e.id, {
        orgId: e.orgId,
        openedBy: "SYSTEM_USER",
        // Mocked user
        disputeType: "SECURITY_DEPOSIT_DISPUTE",
        description: t("admin.financial.manually_opened_dispute")
      });
      toast({
        title: t("admin.financial.dispute_opened"),
        variant: "destructive"
      });
      fetchAccounts();
    } catch (error) {
      toast({
        title: t("admin.financial.error"),
        description: t("admin.financial.failed_to_open_dispute"),
        variant: "destructive"
      });
    }
  };
  const EscrowForm = ({
    onSubmit,
    label
  }: {
    onSubmit: (e: FormEvent) => void;
    label: string;
  }) => {
    const {
      t
    } = useTranslation();
    return <form onSubmit={onSubmit} className="space-y-4 py-2">
      <div className="space-y-1.5"><Label>{t("admin.financial.org_id")}</Label><Input value={form.orgId} onChange={e => setForm({
          ...form,
          orgId: e.target.value
        })} required /></div>
      <div className="space-y-1.5"><Label>{t("admin.financial.reservation_id")}</Label><Input value={form.reservationId} onChange={e => setForm({
          ...form,
          reservationId: e.target.value
        })} required /></div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("admin.financial.total_amount")}</Label><Input type="number" value={form.totalAmount} onChange={e => setForm({
            ...form,
            totalAmount: e.target.value
          })} required min="0" /></div>
        <div className="space-y-1.5"><Label>{t("admin.financial.deposit_amount")}</Label><Input type="number" value={form.depositAmount} onChange={e => setForm({
            ...form,
            depositAmount: e.target.value
          })} required min="0" /></div>
      </div>
      <div className="space-y-1.5"><Label>{t("admin.financial.currency")}</Label><Input value={form.currency} onChange={e => setForm({
          ...form,
          currency: e.target.value
        })} /></div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  const holdingTotal = accounts.filter(e => e.status === "HOLDING").reduce((s, e) => s + (e.depositAmount || 0), 0);
  return <>
      <PageShell title={t("admin.financial.escrow_accounts")} description={t("admin.financial.manage_escrow_funds_releases")} createLabel={t("admin.financial.create_escrow", "Güvenli Ödeme Oluştur")} onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder={t("admin.financial.search_by_reservation", "Rezervasyon ile ara...")} stats={[{
      label: t("admin.financial.accounts"),
      value: accounts.length
    }, {
      label: t("admin.financial.holding"),
      value: accounts.filter(e => e.status === "HOLDING").length
    }, {
      label: t("admin.financial.disputed"),
      value: accounts.filter(e => e.status === "DISPUTED").length
    }, {
      label: t("admin.financial.held_funds"),
      value: `$${holdingTotal.toLocaleString()}`
    }]} actions={<div className="flex items-center gap-2">
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-36 h-9"><SelectValue placeholder={t("admin.financial.status")} /></SelectTrigger>
              <SelectContent><SelectItem value="all">{t("admin.financial.all")}</SelectItem>{Object.entries(STATUS).map(([k, v]) => <SelectItem key={k} value={k}>{v.label}</SelectItem>)}</SelectContent>
            </Select>
            <Button variant="outline" size="sm" onClick={fetchAccounts} disabled={loading}><RefreshCw className={`w-4 h-4 ${loading ? 'animate-spin' : ''}`} /></Button>
          </div>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("admin.financial.reservation")}</TableHead>
                <TableHead>{t("admin.financial.total_amount")}</TableHead>
                <TableHead>{t("admin.financial.deposit")}</TableHead>
                <TableHead>{t("admin.financial.currency")}</TableHead>
                <TableHead>{t("admin.financial.held_at")}</TableHead>
                <TableHead>{t("admin.financial.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={7} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("admin.financial.no_escrow_accounts_found")}</TableCell></TableRow> : filtered.map(e => {
              const s = STATUS[e.status as keyof typeof STATUS] || {
                label: e.status,
                cls: "bg-white/5"
              };
              return <TableRow key={e.id} className="hover:bg-muted/40">
                      <TableCell>
                        <div className="font-mono text-xs">{e.reservationId}</div>
                        <div className="text-[10px] text-muted-foreground">{e.reservation?.listing?.name || "—"}</div>
                      </TableCell>
                      <TableCell className="font-semibold text-sm">${(e.totalAmount || 0).toLocaleString()}</TableCell>
                      <TableCell className="text-sm font-medium text-primary">${(e.depositAmount || 0).toLocaleString()}</TableCell>
                      <TableCell className="text-xs">{e.currency}</TableCell>
                      <TableCell className="text-xs text-muted-foreground">{e.heldAt ? new Date(e.heldAt).toLocaleDateString() : "—"}</TableCell>
                      <TableCell><Badge className={`${s.cls} border-0 text-[10px] shadow-sm`}>{s.label}</Badge></TableCell>
                      <TableCell>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="w-40">
                            {e.status === "HOLDING" && <DropdownMenuItem onClick={() => handleRelease(e)}><CheckCircle2 className="w-4 h-4 mr-2" />{t("admin.financial.release_funds")}</DropdownMenuItem>}
                            {e.status === "HOLDING" && <DropdownMenuItem onClick={() => handleDispute(e)} className="text-destructive font-medium"><AlertCircle className="w-4 h-4 mr-2" />{t("admin.financial.open_dispute")}</DropdownMenuItem>}
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>;
            })}
            </TableBody>
          </Table>
        </div>
      </PageShell>
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-md"><DialogHeader><DialogTitle>{t("admin.financial.create_escrow_account")}</DialogTitle></DialogHeader><EscrowForm onSubmit={handleCreate} label={t("admin.financial.create")} /></DialogContent>
      </Dialog>
    </>;
}