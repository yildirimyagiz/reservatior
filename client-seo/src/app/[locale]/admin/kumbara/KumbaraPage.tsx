"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import {
  PiggyBank,
  Search,
  Plus,
  ArrowUpRight,
  Edit,
  Trash2,
  TrendingUp,
  CheckCircle,
  AlertTriangle,
  RotateCcw,
  History,
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Sheet, SheetContent, SheetHeader, SheetTitle } from "@/components/ui/sheet";

interface KumbaraDeposit {
  id: string;
  leaseId: string;
  propertyId: string;
  tenantId: string;
  tenantName: string;
  propertyName: string;
  totalTarget: number;
  totalContributed: number;
  ruleType: "FIXED_MONTHLY" | "PERCENTAGE_OF_RENT" | "CUSTOM_SCHEDULE";
  contributionRate: number;
  status: "ACTIVE" | "COMPLETED" | "DEFAULTED" | "REFUNDED";
  createdAt: string;
  contributions: Contribution[];
}

interface Contribution {
  id: string;
  amount: number;
  date: string;
  method: string;
}

const mockDeposits: KumbaraDeposit[] = [
  {
    id: "1", leaseId: "L-1001", propertyId: "P-201", tenantId: "T-301",
    tenantName: "Ahmet Yilmaz", propertyName: "Beyoglu Apartment",
    totalTarget: 12000, totalContributed: 8400, ruleType: "FIXED_MONTHLY",
    contributionRate: 1000, status: "ACTIVE", createdAt: "2026-01-15",
    contributions: [
      { id: "c1", amount: 1000, date: "2026-02-01", method: "BANK_TRANSFER" },
      { id: "c2", amount: 1000, date: "2026-03-01", method: "BANK_TRANSFER" },
      { id: "c3", amount: 1200, date: "2026-04-01", method: "BANK_TRANSFER" },
      { id: "c4", amount: 1000, date: "2026-05-01", method: "BANK_TRANSFER" },
      { id: "c5", amount: 1000, date: "2026-06-01", method: "BANK_TRANSFER" },
      { id: "c6", amount: 1200, date: "2026-07-01", method: "BANK_TRANSFER" },
    ],
  },
  {
    id: "2", leaseId: "L-1002", propertyId: "P-202", tenantId: "T-302",
    tenantName: "Emily Chen", propertyName: "Kadikoy Loft",
    totalTarget: 8000, totalContributed: 8000, ruleType: "PERCENTAGE_OF_RENT",
    contributionRate: 15, status: "COMPLETED", createdAt: "2025-06-01",
    contributions: [
      { id: "c7", amount: 900, date: "2025-07-01", method: "CARD" },
      { id: "c8", amount: 900, date: "2025-08-01", method: "CARD" },
      { id: "c9", amount: 900, date: "2025-09-01", method: "BANK_TRANSFER" },
      { id: "c10", amount: 900, date: "2025-10-01", method: "BANK_TRANSFER" },
    ],
  },
  {
    id: "3", leaseId: "L-1003", propertyId: "P-203", tenantId: "T-303",
    tenantName: "Marco Rossi", propertyName: "Besiktas Studio",
    totalTarget: 15000, totalContributed: 3000, ruleType: "FIXED_MONTHLY",
    contributionRate: 500, status: "DEFAULTED", createdAt: "2025-09-01",
    contributions: [
      { id: "c11", amount: 500, date: "2025-10-01", method: "BANK_TRANSFER" },
      { id: "c12", amount: 500, date: "2025-11-01", method: "BANK_TRANSFER" },
      { id: "c13", amount: 500, date: "2025-12-01", method: "BANK_TRANSFER" },
    ],
  },
  {
    id: "4", leaseId: "L-1004", propertyId: "P-204", tenantId: "T-304",
    tenantName: "Sara Lindgren", propertyName: "Sisli Penthouse",
    totalTarget: 20000, totalContributed: 20000, ruleType: "CUSTOM_SCHEDULE",
    contributionRate: 2000, status: "REFUNDED", createdAt: "2024-12-01",
    contributions: [
      { id: "c14", amount: 2000, date: "2025-01-01", method: "BANK_TRANSFER" },
      { id: "c15", amount: 2000, date: "2025-03-01", method: "BANK_TRANSFER" },
      { id: "c16", amount: 2000, date: "2025-05-01", method: "BANK_TRANSFER" },
    ],
  },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-blue-500/20 text-blue-400",
  COMPLETED: "bg-green-500/20 text-green-400",
  DEFAULTED: "bg-red-500/20 text-red-400",
  REFUNDED: "bg-amber-500/20 text-amber-400",
};

const RULE_COLORS: Record<string, string> = {
  FIXED_MONTHLY: "bg-purple-500/20 text-purple-400",
  PERCENTAGE_OF_RENT: "bg-cyan-500/20 text-cyan-400",
  CUSTOM_SCHEDULE: "bg-orange-500/20 text-orange-400",
};

export default function KumbaraPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState<string>("ALL");
  const [items, setItems] = useState<KumbaraDeposit[]>(mockDeposits);
  const [editingItem, setEditingItem] = useState<KumbaraDeposit | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<KumbaraDeposit | null>(null);
  const [historyItem, setHistoryItem] = useState<KumbaraDeposit | null>(null);

  const filtered = items.filter((s) => {
    const matchesSearch =
      s.tenantName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      s.propertyName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      s.leaseId.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || s.status === statusFilter;
    return matchesSearch && matchesStatus;
  });

  const totalDeposits = items.length;
  const activeDeposits = items.filter((d) => d.status === "ACTIVE").length;
  const completedDeposits = items.filter((d) => d.status === "COMPLETED").length;
  const totalContributed = items.reduce((sum, d) => sum + d.totalContributed, 0);

  const handleCreate = (data: Omit<KumbaraDeposit, "id" | "contributions">) => {
    const newItem: KumbaraDeposit = { ...data, id: String(Date.now()), contributions: [] };
    setItems((prev) => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: KumbaraDeposit) => {
    setItems((prev) => prev.map((item) => (item.id === updatedItem.id ? updatedItem : item)));
    setIsEditOpen(false);
    setEditingItem(null);
  };

  const handleDelete = (id: string) => {
    setItems((prev) => prev.filter((item) => item.id !== id));
    setIsDeleteOpen(false);
    setDeletingItem(null);
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <m.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_kumbara_title", "Kumbara Deposits")}</h1>
              <p className="text-muted-foreground">{t("admin_kumbara_description", "Manage tenant deposit savings accounts and contribution tracking")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_kumbara_back_to_dashboard", "Back to Dashboard")}
            </Button>
          </div>
        </m.div>

        {/* Summary Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><PiggyBank className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_kumbara_total_deposits", "Total Deposits")}</p>
                  <p className="text-2xl font-bold text-foreground">{totalDeposits}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-green-500/10"><TrendingUp className="w-5 h-5 text-green-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_kumbara_active", "Active")}</p>
                  <p className="text-2xl font-bold text-foreground">{activeDeposits}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-emerald-500/10"><CheckCircle className="w-5 h-5 text-emerald-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_kumbara_completed", "Completed")}</p>
                  <p className="text-2xl font-bold text-foreground">{completedDeposits}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10"><RotateCcw className="w-5 h-5 text-amber-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_kumbara_total_contributed", "Total Contributed")}</p>
                  <p className="text-2xl font-bold text-foreground">${totalContributed.toLocaleString()}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Search and Filter */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.15 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4 flex-wrap">
                <div className="flex-1 min-w-[200px]">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_kumbara_search_placeholder", "Search by tenant, property, or lease ID...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_kumbara_filter_status", "Filter Status")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("admin_kumbara_all_status", "All Status")}</SelectItem>
                    <SelectItem value="ACTIVE">Active</SelectItem>
                    <SelectItem value="COMPLETED">Completed</SelectItem>
                    <SelectItem value="DEFAULTED">Defaulted</SelectItem>
                    <SelectItem value="REFUNDED">Refunded</SelectItem>
                  </SelectContent>
                </Select>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_kumbara_add_deposit", "Add Deposit")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Deposits Table */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <PiggyBank className="w-5 h-5" />
                {t("admin_kumbara_list_title", "Deposits")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-border">
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_kumbara_tenant", "Tenant")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_kumbara_property", "Property")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_kumbara_rule_type", "Rule Type")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_kumbara_progress", "Progress")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_kumbara_status", "Status")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_kumbara_actions", "Actions")}</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filtered.map((deposit) => {
                      const progress = Math.round((deposit.totalContributed / deposit.totalTarget) * 100);
                      return (
                        <tr key={deposit.id} className="border-b border-border/50 hover:bg-muted/30 transition-colors">
                          <td className="py-3 px-4">
                            <div className="text-foreground font-medium">{deposit.tenantName}</div>
                            <div className="text-xs text-muted-foreground">{deposit.leaseId}</div>
                          </td>
                          <td className="py-3 px-4 text-foreground">{deposit.propertyName}</td>
                          <td className="py-3 px-4">
                            <Badge className={RULE_COLORS[deposit.ruleType]}>{deposit.ruleType.replace(/_/g, " ")}</Badge>
                          </td>
                          <td className="py-3 px-4 min-w-[180px]">
                            <div className="flex items-center gap-3">
                              <Progress value={progress} className="flex-1" indicatorClassName={progress >= 100 ? "bg-green-500" : progress >= 50 ? "bg-blue-500" : "bg-amber-500"} />
                              <span className="text-xs text-muted-foreground whitespace-nowrap">${deposit.totalContributed.toLocaleString()} / ${deposit.totalTarget.toLocaleString()}</span>
                            </div>
                          </td>
                          <td className="py-3 px-4">
                            <Badge className={STATUS_COLORS[deposit.status]}>{deposit.status}</Badge>
                          </td>
                          <td className="py-3 px-4">
                            <div className="flex justify-end gap-2">
                              <Button onClick={() => setHistoryItem(deposit)} variant="ghost" size="icon" className="min-h-10 min-w-10 h-10 w-10"><History className="w-4 h-4" /></Button>
                              <Button onClick={() => { setEditingItem(deposit); setIsEditOpen(true); }} variant="ghost" size="icon" className="min-h-10 min-w-10 h-10 w-10"><Edit className="w-4 h-4" /></Button>
                              <Button onClick={() => { setDeletingItem(deposit); setIsDeleteOpen(true); }} variant="ghost" size="icon" className="min-h-10 min-w-10 h-10 w-10 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                            </div>
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Contribution History Drawer */}
        <Sheet open={!!historyItem} onOpenChange={() => setHistoryItem(null)}>
          <SheetContent className="w-[400px] sm:w-[540px]">
            <SheetHeader>
              <SheetTitle className="text-foreground">{t("admin_kumbara_contribution_history", "Contribution History")}</SheetTitle>
            </SheetHeader>
            {historyItem && (
              <div className="mt-6 space-y-4">
                <div className="p-4 bg-muted/30 rounded-lg">
                  <div className="text-sm text-muted-foreground">{historyItem.tenantName} - {historyItem.propertyName}</div>
                  <div className="text-lg font-bold text-foreground mt-1">${historyItem.totalContributed.toLocaleString()} / ${historyItem.totalTarget.toLocaleString()}</div>
                  <Progress value={Math.round((historyItem.totalContributed / historyItem.totalTarget) * 100)} className="mt-2" />
                </div>
                <div className="space-y-3">
                  {historyItem.contributions.map((c) => (
                    <div key={c.id} className="flex items-center justify-between p-3 bg-muted/20 rounded-lg">
                      <div>
                        <div className="text-sm text-foreground font-medium">${c.amount.toLocaleString()}</div>
                        <div className="text-xs text-muted-foreground">{c.date}</div>
                      </div>
                      <Badge variant="secondary">{c.method.replace(/_/g, " ")}</Badge>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </SheetContent>
        </Sheet>

        {/* Create Dialog */}
        <CreateDepositDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {editingItem && <EditDepositDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />}
        {deletingItem && <DeleteDepositDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />}
      </div>
    </div>
  );
}

function CreateDepositDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<KumbaraDeposit, "id" | "contributions">) => void }) {
  const { t } = useTranslation();
  const [leaseId, setLeaseId] = useState("");
  const [propertyId, setPropertyId] = useState("");
  const [tenantId, setTenantId] = useState("");
  const [tenantName, setTenantName] = useState("");
  const [propertyName, setPropertyName] = useState("");
  const [totalTarget, setTotalTarget] = useState("");
  const [ruleType, setRuleType] = useState<"FIXED_MONTHLY" | "PERCENTAGE_OF_RENT" | "CUSTOM_SCHEDULE">("FIXED_MONTHLY");
  const [contributionRate, setContributionRate] = useState("");
  const [status, setStatus] = useState<"ACTIVE" | "COMPLETED" | "DEFAULTED" | "REFUNDED">("ACTIVE");

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_kumbara_create_deposit", "Create Deposit")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_kumbara_create_deposit_desc", "Set up a new savings deposit for a tenant.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_lease_id", "Lease ID")}</Label>
            <Input value={leaseId} onChange={(e) => setLeaseId(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_property_id", "Property ID")}</Label>
            <Input value={propertyId} onChange={(e) => setPropertyId(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_tenant_id", "Tenant ID")}</Label>
            <Input value={tenantId} onChange={(e) => setTenantId(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_tenant_name", "Tenant Name")}</Label>
            <Input value={tenantName} onChange={(e) => setTenantName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_property_name", "Property Name")}</Label>
            <Input value={propertyName} onChange={(e) => setPropertyName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_total_target", "Total Target")}</Label>
            <Input type="number" value={totalTarget} onChange={(e) => setTotalTarget(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_rule_type", "Rule Type")}</Label>
            <Select value={ruleType} onValueChange={(v) => setRuleType(v as "FIXED_MONTHLY" | "PERCENTAGE_OF_RENT" | "CUSTOM_SCHEDULE")}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="FIXED_MONTHLY">Fixed Monthly</SelectItem>
                <SelectItem value="PERCENTAGE_OF_RENT">Percentage of Rent</SelectItem>
                <SelectItem value="CUSTOM_SCHEDULE">Custom Schedule</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_contribution_rate", "Contribution Rate")}</Label>
            <Input type="number" value={contributionRate} onChange={(e) => setContributionRate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={(v) => setStatus(v as "ACTIVE" | "COMPLETED" | "DEFAULTED" | "REFUNDED")}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="ACTIVE">Active</SelectItem>
                <SelectItem value="COMPLETED">Completed</SelectItem>
                <SelectItem value="DEFAULTED">Defaulted</SelectItem>
                <SelectItem value="REFUNDED">Refunded</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ leaseId, propertyId, tenantId, tenantName, propertyName, totalTarget: Number(totalTarget), ruleType, contributionRate: Number(contributionRate), status, totalContributed: 0, createdAt: new Date().toISOString().split("T")[0] })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditDepositDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: KumbaraDeposit; onSubmit: (data: KumbaraDeposit) => void }) {
  const { t } = useTranslation();
  const [tenantName, setTenantName] = useState(item.tenantName);
  const [propertyName, setPropertyName] = useState(item.propertyName);
  const [totalTarget, setTotalTarget] = useState(String(item.totalTarget));
  const [ruleType, setRuleType] = useState(item.ruleType);
  const [contributionRate, setContributionRate] = useState(String(item.contributionRate));
  const [status, setStatus] = useState(item.status);

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_kumbara_edit_deposit", "Edit Deposit")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_kumbara_edit_deposit_desc", "Update deposit details.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_tenant_name", "Tenant Name")}</Label>
            <Input value={tenantName} onChange={(e) => setTenantName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_property_name", "Property Name")}</Label>
            <Input value={propertyName} onChange={(e) => setPropertyName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_total_target", "Total Target")}</Label>
            <Input type="number" value={totalTarget} onChange={(e) => setTotalTarget(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_rule_type", "Rule Type")}</Label>
            <Select value={ruleType} onValueChange={(v) => setRuleType(v as "FIXED_MONTHLY" | "PERCENTAGE_OF_RENT" | "CUSTOM_SCHEDULE")}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="FIXED_MONTHLY">Fixed Monthly</SelectItem>
                <SelectItem value="PERCENTAGE_OF_RENT">Percentage of Rent</SelectItem>
                <SelectItem value="CUSTOM_SCHEDULE">Custom Schedule</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_kumbara_contribution_rate", "Contribution Rate")}</Label>
            <Input type="number" value={contributionRate} onChange={(e) => setContributionRate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={(v) => setStatus(v as "ACTIVE" | "COMPLETED" | "DEFAULTED" | "REFUNDED")}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="ACTIVE">Active</SelectItem>
                <SelectItem value="COMPLETED">Completed</SelectItem>
                <SelectItem value="DEFAULTED">Defaulted</SelectItem>
                <SelectItem value="REFUNDED">Refunded</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ ...item, tenantName, propertyName, totalTarget: Number(totalTarget), ruleType, contributionRate: Number(contributionRate), status })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteDepositDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: KumbaraDeposit; onConfirm: () => void }) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_kumbara_delete_deposit", "Delete Deposit")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_kumbara_delete_deposit_desc", "Are you sure you want to delete the deposit for")}{item.tenantName}{t("admin_auto_this_action_cannot_be_undone", "? This action cannot be undone.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
