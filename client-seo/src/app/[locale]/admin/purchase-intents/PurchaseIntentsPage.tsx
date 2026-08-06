"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import {
  Home,
  Search,
  Plus,
  ArrowUpRight,
  Edit,
  Trash2,
  TrendingUp,
  Wallet,
  Target,
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";
import { tEnum } from "@/lib/admin-enums";
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

interface PurchaseIntent {
  id: string;
  tenantId: string;
  tenantName: string;
  propertyId: string;
  propertyName: string;
  status: "INTENT_DECLARED" | "DOWN_PAYMENT_SAVING" | "MORTGAGE_PREAPPROVED" | "CONTRACT_EXCHANGED" | "COMPLETION" | "OWNERSHIP_TRANSFERRED";
  readinessTier: "NOT_READY" | "EARLY_STAGE" | "MID_STAGE" | "ALMOST_READY" | "BUYER_READY";
  buyerReadinessScore: number;
  equityAccumulated: number;
  savingsProgress: number;
  monthlySavings: number;
  createdAt: string;
}

const mockIntents: PurchaseIntent[] = [
  {
    id: "1", tenantId: "T-301", tenantName: "Ahmet Yilmaz",
    propertyId: "P-201", propertyName: "Beyoglu Apartment",
    status: "DOWN_PAYMENT_SAVING", readinessTier: "MID_STAGE",
    buyerReadinessScore: 62, equityAccumulated: 18600, savingsProgress: 55,
    monthlySavings: 1500, createdAt: "2026-01-15",
  },
  {
    id: "2", tenantId: "T-302", tenantName: "Emily Chen",
    propertyId: "P-202", propertyName: "Kadikoy Loft",
    status: "MORTGAGE_PREAPPROVED", readinessTier: "ALMOST_READY",
    buyerReadinessScore: 85, equityAccumulated: 42500, savingsProgress: 82,
    monthlySavings: 2000, createdAt: "2025-06-01",
  },
  {
    id: "3", tenantId: "T-303", tenantName: "Marco Rossi",
    propertyId: "P-203", propertyName: "Besiktas Studio",
    status: "INTENT_DECLARED", readinessTier: "EARLY_STAGE",
    buyerReadinessScore: 28, equityAccumulated: 5600, savingsProgress: 22,
    monthlySavings: 800, createdAt: "2026-03-01",
  },
  {
    id: "4", tenantId: "T-304", tenantName: "Sara Lindgren",
    propertyId: "P-204", propertyName: "Sisli Penthouse",
    status: "CONTRACT_EXCHANGED", readinessTier: "BUYER_READY",
    buyerReadinessScore: 95, equityAccumulated: 75000, savingsProgress: 98,
    monthlySavings: 3000, createdAt: "2025-03-15",
  },
  {
    id: "5", tenantId: "T-305", tenantName: "James Wilson",
    propertyId: "P-205", propertyName: "Uskudar Villa",
    status: "OWNERSHIP_TRANSFERRED", readinessTier: "BUYER_READY",
    buyerReadinessScore: 100, equityAccumulated: 120000, savingsProgress: 100,
    monthlySavings: 0, createdAt: "2024-06-01",
  },
];

const STATUS_COLORS: Record<string, string> = {
  INTENT_DECLARED: "bg-blue-500/20 text-info",
  DOWN_PAYMENT_SAVING: "bg-cyan-500/20 text-cyan-400",
  MORTGAGE_PREAPPROVED: "bg-brand/20 text-brand",
  CONTRACT_EXCHANGED: "bg-amber-500/20 text-warning",
  COMPLETION: "bg-blue-500/20 text-blue-400",
  OWNERSHIP_TRANSFERRED: "bg-blue-500/20 text-success",
};

const TIER_COLORS: Record<string, string> = {
  NOT_READY: "bg-gray-500/20 text-gray-400",
  EARLY_STAGE: "bg-blue-500/20 text-info",
  MID_STAGE: "bg-cyan-500/20 text-cyan-400",
  ALMOST_READY: "bg-amber-500/20 text-warning",
  BUYER_READY: "bg-blue-500/20 text-blue-400",
};

function getReadinessColor(score: number): string {
  if (score >= 90) return "bg-blue-500";
  if (score >= 70) return "bg-blue-500";
  if (score >= 50) return "bg-cyan-500";
  if (score >= 30) return "bg-amber-500";
  return "bg-red-500";
}

export default function PurchaseIntentsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState<string>("ALL");
  const [tierFilter, setTierFilter] = useState<string>("ALL");
  const [items, setItems] = useState<PurchaseIntent[]>(mockIntents);
  const [editingItem, setEditingItem] = useState<PurchaseIntent | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<PurchaseIntent | null>(null);

  const filtered = items.filter((s) => {
    const matchesSearch = s.tenantName.toLowerCase().includes(searchTerm.toLowerCase()) || s.propertyName.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || s.status === statusFilter;
    const matchesTier = tierFilter === "ALL" || s.readinessTier === tierFilter;
    return matchesSearch && matchesStatus && matchesTier;
  });

  const totalEquity = items.reduce((sum, i) => sum + i.equityAccumulated, 0);
  const avgReadiness = Math.round(items.reduce((sum, i) => sum + i.buyerReadinessScore, 0) / items.length);

  const handleCreate = (data: Omit<PurchaseIntent, "id">) => {
    const newItem: PurchaseIntent = { ...data, id: String(Date.now()) };
    setItems((prev) => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: PurchaseIntent) => {
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
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_rto_title", "Kademeli Satın Alma (Rent-to-Own RTO)")}</h1>
              <p className="text-muted-foreground">{t("admin_rto_description", "Kiralayarak satın alma niyetlerini ve sözleşmelerini yönetin")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_rto_back_to_dashboard", "Panele Dön")}
            </Button>
          </div>
        </m.div>

        {/* Summary Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Home className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_rto_total_intents", "Toplam Niyet")}</p>
                  <p className="text-2xl font-bold text-foreground">{items.length}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Wallet className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_rto_total_equity", "Toplam Birikim")}</p>
                  <p className="text-2xl font-bold text-foreground">${totalEquity.toLocaleString()}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-brand/10"><Target className="w-5 h-5 text-brand" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_rto_avg_readiness", "Ort. Hazırlık")}</p>
                  <p className="text-2xl font-bold text-foreground">{avgReadiness}%</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10"><TrendingUp className="w-5 h-5 text-amber-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_rto_buyer_ready", "Alıcı Hazır")}</p>
                  <p className="text-2xl font-bold text-foreground">{items.filter((i) => i.readinessTier === "BUYER_READY").length}</p>
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
                      placeholder={t("admin_rto_search_placeholder", "Satın alma niyetleri ara...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[200px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_rto_filter_status", "Duruma Göre Filtrele")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("admin_rto_all_status", "Tüm Durumlar")}</SelectItem>
                    <SelectItem value="INTENT_DECLARED">{tEnum(t, "INTENT_DECLARED")}</SelectItem>
                    <SelectItem value="DOWN_PAYMENT_SAVING">{tEnum(t, "DOWN_PAYMENT_SAVING")}</SelectItem>
                    <SelectItem value="MORTGAGE_PREAPPROVED">{tEnum(t, "MORTGAGE_PREAPPROVED")}</SelectItem>
                    <SelectItem value="CONTRACT_EXCHANGED">{tEnum(t, "CONTRACT_EXCHANGED")}</SelectItem>
                    <SelectItem value="COMPLETION">{tEnum(t, "COMPLETION")}</SelectItem>
                    <SelectItem value="OWNERSHIP_TRANSFERRED">{tEnum(t, "OWNERSHIP_TRANSFERRED")}</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={tierFilter} onValueChange={setTierFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_rto_readiness_tier", "Hazırlık Seviyesi")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("admin_rto_all_tiers", "Tüm Kademeler")}</SelectItem>
                    <SelectItem value="NOT_READY">{tEnum(t, "NOT_READY")}</SelectItem>
                    <SelectItem value="EARLY_STAGE">{tEnum(t, "EARLY_STAGE")}</SelectItem>
                    <SelectItem value="MID_STAGE">{tEnum(t, "MID_STAGE")}</SelectItem>
                    <SelectItem value="ALMOST_READY">{tEnum(t, "ALMOST_READY")}</SelectItem>
                    <SelectItem value="BUYER_READY">{tEnum(t, "BUYER_READY")}</SelectItem>
                  </SelectContent>
                </Select>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_rto_add_intent", "Niyet Ekle")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Intents Table */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Home className="w-5 h-5" />
                {t("admin_rto_list_title", "Satın Alma Niyetleri")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-border">
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_rto_tenant", "Kiracı")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_rto_property", "Emlak")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_rto_readiness", "Hazırlık")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_rto_equity", "Birikim")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_rto_status", "Durum")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_rto_tier", "Seviye")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_kumbara_actions", "İşlemler")}</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filtered.map((intent) => (
                      <tr key={intent.id} className="border-b border-border/50 hover:bg-muted/30 transition-colors">
                        <td className="py-3 px-4">
                          <div className="text-foreground font-medium">{intent.tenantName}</div>
                          <div className="text-xs text-muted-foreground">{intent.tenantId}</div>
                        </td>
                        <td className="py-3 px-4 text-foreground">{intent.propertyName}</td>
                        <td className="py-3 px-4 min-w-[160px]">
                          <div className="flex items-center gap-3">
                            <Progress value={intent.buyerReadinessScore} className="flex-1" indicatorClassName={getReadinessColor(intent.buyerReadinessScore)} />
                            <span className="text-xs text-muted-foreground whitespace-nowrap">{intent.buyerReadinessScore}%</span>
                          </div>
                        </td>
                        <td className="py-3 px-4 text-foreground">${intent.equityAccumulated.toLocaleString()}</td>
                        <td className="py-3 px-4">
                          <Badge className={STATUS_COLORS[intent.status]}>{tEnum(t, intent.status)}</Badge>
                        </td>
                        <td className="py-3 px-4">
                          <Badge className={TIER_COLORS[intent.readinessTier]}>{tEnum(t, intent.readinessTier)}</Badge>
                        </td>
                        <td className="py-3 px-4">
                          <div className="flex justify-end gap-2">
                            <Button onClick={() => { setEditingItem(intent); setIsEditOpen(true); }} variant="ghost" size="icon" aria-label={t("common.edit")} className="min-h-10 min-w-10 h-10 w-10"><Edit className="w-4 h-4" /></Button>
                            <Button onClick={() => { setDeletingItem(intent); setIsDeleteOpen(true); }} variant="ghost" size="icon" aria-label={t("common.delete")} className="min-h-10 min-w-10 h-10 w-10 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                          </div>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Create Dialog */}
        <CreateIntentDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {editingItem && <EditIntentDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />}
        {deletingItem && <DeleteIntentDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />}
      </div>
    </div>
  );
}

function CreateIntentDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<PurchaseIntent, "id">) => void }) {
  const { t } = useTranslation();
  const [tenantId, setTenantId] = useState("");
  const [tenantName, setTenantName] = useState("");
  const [propertyId, setPropertyId] = useState("");
  const [propertyName, setPropertyName] = useState("");
  const [status, setStatus] = useState<PurchaseIntent["status"]>("INTENT_DECLARED");
  const [readinessTier, setReadinessTier] = useState<PurchaseIntent["readinessTier"]>("NOT_READY");
  const [buyerReadinessScore, setBuyerReadinessScore] = useState("");
  const [equityAccumulated, setEquityAccumulated] = useState("");
  const [monthlySavings, setMonthlySavings] = useState("");

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_rto_create_intent", "Satın Alma Niyeti Oluştur")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_rto_create_intent_desc", "Yeni bir kiracı satın alma niyeti beyan edin")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_tenant_id", "Kiracı ID")}</Label>
            <Input value={tenantId} onChange={(e) => setTenantId(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_tenant_name", "Kiracı Adı")}</Label>
            <Input value={tenantName} onChange={(e) => setTenantName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_property_id", "Emlak ID")}</Label>
            <Input value={propertyId} onChange={(e) => setPropertyId(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_property_name", "Emlak Adı")}</Label>
            <Input value={propertyName} onChange={(e) => setPropertyName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_readiness_score", "Hazırlık Puanı")}</Label>
            <Input type="number" value={buyerReadinessScore} onChange={(e) => setBuyerReadinessScore(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_equity", "Birikim")}</Label>
            <Input type="number" value={equityAccumulated} onChange={(e) => setEquityAccumulated(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_monthly_savings", "Aylık Birikim")}</Label>
            <Input type="number" value={monthlySavings} onChange={(e) => setMonthlySavings(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_status", "Durum")}</Label>
            <Select value={status} onValueChange={(v) => setStatus(v as PurchaseIntent["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="INTENT_DECLARED">{tEnum(t, "INTENT_DECLARED")}</SelectItem>
                <SelectItem value="DOWN_PAYMENT_SAVING">{tEnum(t, "DOWN_PAYMENT_SAVING")}</SelectItem>
                <SelectItem value="MORTGAGE_PREAPPROVED">{tEnum(t, "MORTGAGE_PREAPPROVED")}</SelectItem>
                <SelectItem value="CONTRACT_EXCHANGED">{tEnum(t, "CONTRACT_EXCHANGED")}</SelectItem>
                <SelectItem value="COMPLETION">{tEnum(t, "COMPLETION")}</SelectItem>
                <SelectItem value="OWNERSHIP_TRANSFERRED">{tEnum(t, "OWNERSHIP_TRANSFERRED")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_readiness_tier", "Hazırlık Seviyesi")}</Label>
            <Select value={readinessTier} onValueChange={(v) => setReadinessTier(v as PurchaseIntent["readinessTier"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="NOT_READY">{tEnum(t, "NOT_READY")}</SelectItem>
                <SelectItem value="EARLY_STAGE">{tEnum(t, "EARLY_STAGE")}</SelectItem>
                <SelectItem value="MID_STAGE">{tEnum(t, "MID_STAGE")}</SelectItem>
                <SelectItem value="ALMOST_READY">{tEnum(t, "ALMOST_READY")}</SelectItem>
                <SelectItem value="BUYER_READY">{tEnum(t, "BUYER_READY")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
          <Button onClick={() => onSubmit({ tenantId, tenantName, propertyId, propertyName, status, readinessTier, buyerReadinessScore: Number(buyerReadinessScore), equityAccumulated: Number(equityAccumulated), savingsProgress: 0, monthlySavings: Number(monthlySavings), createdAt: new Date().toISOString().split("T")[0] })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Oluştur")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditIntentDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: PurchaseIntent; onSubmit: (data: PurchaseIntent) => void }) {
  const { t } = useTranslation();
  const [tenantName, setTenantName] = useState(item.tenantName);
  const [propertyName, setPropertyName] = useState(item.propertyName);
  const [buyerReadinessScore, setBuyerReadinessScore] = useState(String(item.buyerReadinessScore));
  const [equityAccumulated, setEquityAccumulated] = useState(String(item.equityAccumulated));
  const [status, setStatus] = useState(item.status);
  const [readinessTier, setReadinessTier] = useState(item.readinessTier);

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_rto_edit_intent", "Satın Alma Niyetini Düzenle")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_rto_edit_intent_desc", "Satın alma niyeti detaylarını güncelleyin")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_tenant_name", "Kiracı Adı")}</Label>
            <Input value={tenantName} onChange={(e) => setTenantName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_property_name", "Emlak Adı")}</Label>
            <Input value={propertyName} onChange={(e) => setPropertyName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_readiness_score", "Hazırlık Puanı")}</Label>
            <Input type="number" value={buyerReadinessScore} onChange={(e) => setBuyerReadinessScore(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_equity", "Birikim")}</Label>
            <Input type="number" value={equityAccumulated} onChange={(e) => setEquityAccumulated(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_status", "Durum")}</Label>
            <Select value={status} onValueChange={(v) => setStatus(v as PurchaseIntent["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="INTENT_DECLARED">{tEnum(t, "INTENT_DECLARED")}</SelectItem>
                <SelectItem value="DOWN_PAYMENT_SAVING">{tEnum(t, "DOWN_PAYMENT_SAVING")}</SelectItem>
                <SelectItem value="MORTGAGE_PREAPPROVED">{tEnum(t, "MORTGAGE_PREAPPROVED")}</SelectItem>
                <SelectItem value="CONTRACT_EXCHANGED">{tEnum(t, "CONTRACT_EXCHANGED")}</SelectItem>
                <SelectItem value="COMPLETION">{tEnum(t, "COMPLETION")}</SelectItem>
                <SelectItem value="OWNERSHIP_TRANSFERRED">{tEnum(t, "OWNERSHIP_TRANSFERRED")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_rto_readiness_tier", "Hazırlık Seviyesi")}</Label>
            <Select value={readinessTier} onValueChange={(v) => setReadinessTier(v as PurchaseIntent["readinessTier"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="NOT_READY">{tEnum(t, "NOT_READY")}</SelectItem>
                <SelectItem value="EARLY_STAGE">{tEnum(t, "EARLY_STAGE")}</SelectItem>
                <SelectItem value="MID_STAGE">{tEnum(t, "MID_STAGE")}</SelectItem>
                <SelectItem value="ALMOST_READY">{tEnum(t, "ALMOST_READY")}</SelectItem>
                <SelectItem value="BUYER_READY">{tEnum(t, "BUYER_READY")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
          <Button onClick={() => onSubmit({ ...item, tenantName, propertyName, buyerReadinessScore: Number(buyerReadinessScore), equityAccumulated: Number(equityAccumulated), status, readinessTier })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Kaydet")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteIntentDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: PurchaseIntent; onConfirm: () => void }) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_rto_delete_intent", "Satın Alma Niyetini Sil")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_rto_delete_intent_desc", "Bu satın alma niyetini silmek istediğinizden emin misiniz?")}{item.tenantName}{t("admin_auto_this_action_cannot_be_undone", "? Bu eylem geri alınamaz.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Sil")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
