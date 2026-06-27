import { useTranslation } from "react-i18next";
import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, RefreshCw, Loader2 } from "lucide-react";
import { commissionsApi, type Commission, type CommissionType, type CommissionStatus, type CommissionFrequency } from "@/lib/api/commissions";

const STATUS_STYLES: Record<string, { label: string; cls: string }> = {
  PAID: { label: "Paid", cls: "bg-green-100 text-green-700" },
  PENDING: { label: "Pending", cls: "bg-yellow-100 text-yellow-700" },
  CALCULATED: { label: "Calculated", cls: "bg-blue-100 text-blue-700" },
  DISPUTED: { label: "Disputed", cls: "bg-red-100 text-red-700" },
  CANCELLED: { label: "Cancelled", cls: "bg-gray-100 text-gray-700" },
};

const TYPE_STYLES: Record<string, { label: string; cls: string }> = {
  LEASING_COMMISSION: { label: "One-Time", cls: "bg-purple-100 text-purple-700" },
  SUBSCRIPTION_COMMISSION: { label: "Subscription", cls: "bg-indigo-100 text-indigo-700" },
  CO_BROKERAGE: { label: "Co-Brokerage", cls: "bg-orange-100 text-orange-700" },
  REFERRAL: { label: "Referral", cls: "bg-teal-100 text-teal-700" },
  MANAGEMENT: { label: "Management", cls: "bg-slate-100 text-slate-700" },
};

const FREQ_LABELS: Record<string, string> = {
  MONTHLY: "Monthly",
  QUARTERLY: "Quarterly",
  YEARLY: "Yearly",
  ONE_TIME: "One-Time",
};

const EMPTY_FORM = {
  agentName: "",
  propertyName: "",
  salePrice: "",
  commissionRate: "",
  commissionAmount: "",
  status: "",
};

export default function Commissions() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [detailOpen, setDetailOpen] = useState(false);
  const [selectedCommission, setSelectedCommission] = useState<Commission | null>(null);
  const [form, setForm] = useState<any>(EMPTY_FORM);

  const { data: commissionsData, isLoading, refetch } = useQuery({
    queryKey: ["agent-commissions"],
    queryFn: async () => {
      const res = await commissionsApi.getAll({ limit: 100 });
      return res.data || [];
    },
  });

  const commissions = commissionsData || [];

  const deleteMutation = useMutation({
    mutationFn: (id: string) => commissionsApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["agent-commissions"] });
      toast({ title: t("client.src.commissions_deleted"), variant: "destructive" });
    },
  });

  const filtered = commissions.filter(row => {
    const searchStr = search.toLowerCase();
    const matchesSearch = !search || [row.agent?.firstName, row.agent?.lastName, row.id].some(f => f?.toLowerCase().includes(searchStr));
    const matchesStatus = filterStatus === "all" || row.status === filterStatus;
    return matchesSearch && matchesStatus;
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    setCreateOpen(false);
    toast({ title: t("client.src.commissions_created") });
    setForm(EMPTY_FORM);
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    setEditOpen(false);
    toast({ title: t("client.src.commissions_updated") });
  };

  const openEdit = (row: Commission) => {
    const f: any = {};
    Object.keys(EMPTY_FORM).forEach(k => {
      f[k] = String((row as any)[k] ?? "");
    });
    setForm(f);
    setEditOpen(true);
  };

  const openDetail = (row: Commission) => {
    setSelectedCommission(row);
    setDetailOpen(true);
  };

  const EntityForm = ({ onSubmit, label }: { onSubmit: (e: React.FormEvent) => void; label: string }) => (
    <form onSubmit={onSubmit} className="space-y-4 py-2">
      <div className="space-y-1.5">
        <Label>{t("client.src.agent")}</Label>
        <Input type="text" value={form.agentName} onChange={e => setForm({ ...form, agentName: e.target.value })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.property")}</Label>
        <Input type="text" value={form.propertyName} onChange={e => setForm({ ...form, propertyName: e.target.value })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.sale_price")}</Label>
        <Input type="number" value={form.salePrice} onChange={e => setForm({ ...form, salePrice: e.target.value })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.commission_rate")}</Label>
        <Input type="number" value={form.commissionRate} onChange={e => setForm({ ...form, commissionRate: e.target.value })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.commission_amount")}</Label>
        <Input type="number" value={form.commissionAmount} onChange={e => setForm({ ...form, commissionAmount: e.target.value })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({ ...form, status: v })}>
          <SelectTrigger><SelectValue /></SelectTrigger>
          <SelectContent>
            <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
            <SelectItem value="PAID">{t("client.src.paid")}</SelectItem>
            <SelectItem value="DISPUTED">{t("client.src.disputed")}</SelectItem>
          </SelectContent>
        </Select>
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>
  );

  const InstallmentProgress = ({ commission }: { commission: Commission }) => {
    if (commission.frequency === "ONE_TIME" || !commission.totalInstallments) return null;
    const completed = commission.completedInstallments || 0;
    const total = commission.totalInstallments;
    const pct = total > 0 ? Math.round((completed / total) * 100) : 0;
    return (
      <div className="flex items-center gap-2 min-w-[120px]">
        <div className="flex-1 h-1.5 bg-gray-200 rounded-full overflow-hidden">
          <div className="h-full bg-indigo-500 rounded-full transition-all" style={{ width: `${pct}%` }} />
        </div>
        <span className="text-[10px] font-mono text-muted-foreground whitespace-nowrap">{completed}/{total}</span>
      </div>
    );
  };

  const SplitBreakdown = ({ commission }: { commission: Commission }) => {
    if (!commission.splits?.length) return <span className="text-xs text-muted-foreground">No splits</span>;
    return (
      <div className="space-y-1">
        {commission.splits.map(split => (
          <div key={split.id} className="flex items-center justify-between text-xs">
            <Badge variant="outline" className="text-[10px] px-1.5 py-0">{split.partyType}</Badge>
            <span className="font-mono">{split.rate}% (${split.amount})</span>
          </div>
        ))}
      </div>
    );
  };

  return (
    <>
      <PageShell
        title={t("client.src.commissions")}
        description={t("client.src.track_and_manage_agent")}
        createLabel="Add Commission"
        onCreateClick={() => { setForm(EMPTY_FORM); setCreateOpen(true); }}
        searchValue={search}
        onSearchChange={setSearch}
        searchPlaceholder="Search commissions..."
        stats={[
          { label: t("client.src.total"), value: commissions.length },
          { label: t("client.src.paid"), value: commissions.filter(r => r.status === 'PAID').length },
          { label: t("client.src.pending"), value: commissions.filter(r => r.status === 'PENDING').length },
          { label: "Total Value", value: `$${commissions.reduce((s, r) => s + (r.commissionAmount || 0), 0).toLocaleString()}` },
        ]}
        filters={
          <Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-40"><SelectValue placeholder={t("client.src.status")} /></SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("client.src.all")}</SelectItem>
              <SelectItem value="PAID">{t("client.src.paid")}</SelectItem>
              <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
              <SelectItem value="DISPUTED">{t("client.src.disputed")}</SelectItem>
            </SelectContent>
          </Select>
        }
        actions={
          <Button variant="outline" size="sm" onClick={() => refetch()} disabled={isLoading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${isLoading ? 'animate-spin' : ''}`} />Refresh
          </Button>
        }
      >
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.agent")}</TableHead>
                <TableHead>Type</TableHead>
                <TableHead>Base Amount</TableHead>
                <TableHead>Commission</TableHead>
                <TableHead>Rate</TableHead>
                <TableHead>Frequency</TableHead>
                <TableHead>Progress</TableHead>
                <TableHead>{t("client.src.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? (
                <TableRow>
                  <TableCell colSpan={9} className="h-64 text-center">
                    <div className="flex flex-col items-center justify-center gap-2">
                      <Loader2 className="w-8 h-8 animate-spin text-primary" />
                      <span className="text-sm text-muted-foreground">Loading commissions...</span>
                    </div>
                  </TableCell>
                </TableRow>
              ) : filtered.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={9} className="text-center py-12 text-muted-foreground">
                    {t("client.src.no_commissions_found")}
                  </TableCell>
                </TableRow>
              ) : (
                filtered.map(row => (
                  <TableRow
                    key={row.id}
                    className="hover:bg-muted/40 cursor-pointer"
                    onClick={() => openDetail(row)}
                  >
                    <TableCell className="text-sm font-medium">
                      {row.agent ? `${row.agent.firstName} ${row.agent.lastName}` : row.agentId || "—"}
                    </TableCell>
                    <TableCell>
                      {TYPE_STYLES[row.type] ? (
                        <Badge className={`${TYPE_STYLES[row.type].cls} border-0 text-xs`}>
                          {TYPE_STYLES[row.type].label}
                        </Badge>
                      ) : (
                        <span className="text-xs text-muted-foreground">{row.type}</span>
                      )}
                    </TableCell>
                    <TableCell className="text-sm font-mono">${Number(row.amountBase).toLocaleString()}</TableCell>
                    <TableCell className="text-sm font-mono font-semibold">${Number(row.commissionAmount).toLocaleString()}</TableCell>
                    <TableCell className="text-sm">{row.commissionRate ?? row.agentRate ?? "—"}%</TableCell>
                    <TableCell className="text-xs">{FREQ_LABELS[row.frequency] || row.frequency}</TableCell>
                    <TableCell><InstallmentProgress commission={row} /></TableCell>
                    <TableCell>
                      {STATUS_STYLES[row.status] ? (
                        <Badge className={`${STATUS_STYLES[row.status].cls} border-0 text-xs`}>
                          {STATUS_STYLES[row.status].label}
                        </Badge>
                      ) : (
                        <span className="text-xs text-muted-foreground">{row.status}</span>
                      )}
                    </TableCell>
                    <TableCell>
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild onClick={e => e.stopPropagation()}>
                          <Button variant="ghost" size="icon" className="h-8 w-8">
                            <MoreHorizontal className="w-4 h-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuItem onClick={e => { e.stopPropagation(); openEdit(row); }}>
                            <Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}
                          </DropdownMenuItem>
                          <DropdownMenuItem
                            onClick={e => { e.stopPropagation(); deleteMutation.mutate(row.id); }}
                            className="text-destructive"
                          >
                            <Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}
                          </DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>
                ))
              )}
            </TableBody>
          </Table>
        </div>
      </PageShell>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.add_commissions")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("client.src.create")} />
        </DialogContent>
      </Dialog>

      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_commissions")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("client.src.save_changes")} />
        </DialogContent>
      </Dialog>

      <Dialog open={detailOpen} onOpenChange={setDetailOpen}>
        <DialogContent className="sm:max-w-2xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle>Commission Details</DialogTitle>
          </DialogHeader>
          {selectedCommission && (
            <div className="space-y-6 py-2">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label className="text-xs text-muted-foreground">Type</Label>
                  <p className="text-sm font-medium">
                    {TYPE_STYLES[selectedCommission.type]?.label || selectedCommission.type}
                  </p>
                </div>
                <div>
                  <Label className="text-xs text-muted-foreground">Status</Label>
                  <Badge className={`${STATUS_STYLES[selectedCommission.status]?.cls} border-0 text-xs mt-1`}>
                    {STATUS_STYLES[selectedCommission.status]?.label || selectedCommission.status}
                  </Badge>
                </div>
                <div>
                  <Label className="text-xs text-muted-foreground">Frequency</Label>
                  <p className="text-sm font-medium">{FREQ_LABELS[selectedCommission.frequency] || selectedCommission.frequency}</p>
                </div>
                <div>
                  <Label className="text-xs text-muted-foreground">Base Amount</Label>
                  <p className="text-sm font-mono font-medium">${Number(selectedCommission.amountBase).toLocaleString()}</p>
                </div>
                <div>
                  <Label className="text-xs text-muted-foreground">Commission Amount</Label>
                  <p className="text-sm font-mono font-semibold">${Number(selectedCommission.commissionAmount).toLocaleString()}</p>
                </div>
                <div>
                  <Label className="text-xs text-muted-foreground">Currency</Label>
                  <p className="text-sm font-medium">{selectedCommission.currency}</p>
                </div>
              </div>

              {selectedCommission.frequency !== "ONE_TIME" && selectedCommission.totalInstallments && (
                <div>
                  <Label className="text-xs text-muted-foreground">Installment Progress</Label>
                  <div className="mt-1 flex items-center gap-3">
                    <div className="flex-1 h-2 bg-gray-200 rounded-full overflow-hidden">
                      <div
                        className="h-full bg-indigo-500 rounded-full transition-all"
                        style={{ width: `${((selectedCommission.completedInstallments || 0) / selectedCommission.totalInstallments) * 100}%` }}
                      />
                    </div>
                    <span className="text-sm font-mono">
                      {selectedCommission.completedInstallments || 0}/{selectedCommission.totalInstallments}
                    </span>
                  </div>
                  {selectedCommission.nextBillingDate && (
                    <p className="text-xs text-muted-foreground mt-1">
                      Next billing: {new Date(selectedCommission.nextBillingDate).toLocaleDateString()}
                    </p>
                  )}
                </div>
              )}

              <div>
                <Label className="text-xs text-muted-foreground">Split Breakdown</Label>
                <div className="mt-2 space-y-2">
                  {selectedCommission.splits?.length ? (
                    <Table>
                      <TableHeader>
                        <TableRow>
                          <TableHead className="text-xs">Party</TableHead>
                          <TableHead className="text-xs">Rate</TableHead>
                          <TableHead className="text-xs">Amount</TableHead>
                          <TableHead className="text-xs">Status</TableHead>
                        </TableRow>
                      </TableHeader>
                      <TableBody>
                        {selectedCommission.splits.map(split => (
                          <TableRow key={split.id}>
                            <TableCell className="text-xs">{split.partyName || split.partyType}</TableCell>
                            <TableCell className="text-xs font-mono">{split.rate}%</TableCell>
                            <TableCell className="text-xs font-mono">${Number(split.amount).toLocaleString()}</TableCell>
                            <TableCell>
                              <Badge className={`${STATUS_STYLES[split.status]?.cls} border-0 text-[10px]`}>
                                {STATUS_STYLES[split.status]?.label || split.status}
                              </Badge>
                            </TableCell>
                          </TableRow>
                        ))}
                      </TableBody>
                    </Table>
                  ) : (
                    <p className="text-xs text-muted-foreground">No split data available</p>
                  )}
                </div>
              </div>

              {selectedCommission.isCoBrokerage && (
                <div className="bg-orange-50 border border-orange-200 rounded-lg p-3">
                  <Label className="text-xs text-orange-700 font-semibold">Co-Brokerage</Label>
                  <p className="text-xs text-orange-600 mt-1">
                    Co-Agency rate: {selectedCommission.coAgencyRate}% | Co-Agent rate: {selectedCommission.coAgentRate}%
                  </p>
                </div>
              )}
            </div>
          )}
          <DialogFooter>
            <Button variant="outline" onClick={() => setDetailOpen(false)}>Close</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>
  );
}
