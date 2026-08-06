"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Building2,
  Search,
  Plus,
  ArrowUpRight,
  Edit,
  Trash2,
  DollarSign,
  TrendingUp,
  Users,
  Percent,
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

interface REOPortfolio {
  id: string;
  name: string;
  totalValue: number;
  totalEquity: number;
  occupancyRate: number;
  capRate: number;
  propertyCount: number;
  status: "BANK_OWNED" | "PRE_FORECLOSURE" | "AUGMENTATION" | "LISTED" | "UNDER_CONTRACT" | "SOLD";
  properties: REOProperty[];
  createdAt: string;
}

interface REOProperty {
  id: string;
  name: string;
  value: number;
  status: "OCCUPIED" | "VACANT" | "RENOVATION" | "LISTED";
  acquisitionDate: string;
}

const mockPortfolios: REOPortfolio[] = [
  {
    id: "1", name: "Istanbul Core Portfolio", totalValue: 2500000, totalEquity: 1250000,
    occupancyRate: 88, capRate: 6.2, propertyCount: 12, status: "BANK_OWNED", createdAt: "2025-03-01",
    properties: [
      { id: "p1", name: "Beyoglu Apartment", value: 450000, status: "OCCUPIED", acquisitionDate: "2025-03-01" },
      { id: "p2", name: "Kadikoy Loft", value: 380000, status: "OCCUPIED", acquisitionDate: "2025-04-15" },
      { id: "p3", name: "Besiktas Studio", value: 290000, status: "VACANT", acquisitionDate: "2025-05-20" },
      { id: "p4", name: "Sisli Penthouse", value: 620000, status: "RENOVATION", acquisitionDate: "2025-06-01" },
    ],
  },
  {
    id: "2", name: "Antalya Coastal", totalValue: 1800000, totalEquity: 900000,
    occupancyRate: 75, capRate: 5.8, propertyCount: 8, status: "AUGMENTATION", createdAt: "2025-06-15",
    properties: [
      { id: "p5", name: "Lara Beach Villa", value: 520000, status: "OCCUPIED", acquisitionDate: "2025-06-15" },
      { id: "p6", name: "Kalkan Terrace", value: 340000, status: "LISTED", acquisitionDate: "2025-07-01" },
      { id: "p7", name: "Alanya Apartment", value: 280000, status: "OCCUPIED", acquisitionDate: "2025-08-10" },
    ],
  },
  {
    id: "3", name: "Ankara Business District", totalValue: 1200000, totalEquity: 600000,
    occupancyRate: 92, capRate: 7.1, propertyCount: 6, status: "PRE_FORECLOSURE", createdAt: "2025-09-01",
    properties: [
      { id: "p8", name: "Cankaya Office", value: 350000, status: "OCCUPIED", acquisitionDate: "2025-09-01" },
      { id: "p9", name: "Kizilay Flat", value: 220000, status: "OCCUPIED", acquisitionDate: "2025-10-15" },
    ],
  },
  {
    id: "4", name: "Bodrum Premium", totalValue: 3200000, totalEquity: 1600000,
    occupancyRate: 65, capRate: 4.9, propertyCount: 10, status: "SOLD", createdAt: "2024-12-01",
    properties: [
      { id: "p10", name: "Yalıkavak Villa", value: 890000, status: "OCCUPIED", acquisitionDate: "2024-12-01" },
      { id: "p11", name: "Gumbet Apartment", value: 420000, status: "LISTED", acquisitionDate: "2025-01-10" },
    ],
  },
];

const STATUS_COLORS: Record<string, string> = {
  BANK_OWNED: "bg-blue-500/20 text-info",
  PRE_FORECLOSURE: "bg-amber-500/20 text-warning",
  AUGMENTATION: "bg-brand/20 text-brand",
  LISTED: "bg-cyan-500/20 text-cyan-400",
  UNDER_CONTRACT: "bg-orange-500/20 text-warning",
  SOLD: "bg-blue-500/20 text-blue-400",
};

const PROP_STATUS_COLORS: Record<string, string> = {
  OCCUPIED: "bg-blue-500/20 text-blue-400",
  VACANT: "bg-red-500/20 text-red-400",
  RENOVATION: "bg-amber-500/20 text-warning",
  LISTED: "bg-blue-500/20 text-info",
};

export default function REOPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState<string>("ALL");
  const [items, setItems] = useState<REOPortfolio[]>(mockPortfolios);
  const [editingItem, setEditingItem] = useState<REOPortfolio | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<REOPortfolio | null>(null);

  const filtered = items.filter((s) => {
    const matchesSearch = s.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || s.status === statusFilter;
    return matchesSearch && matchesStatus;
  });

  const totalValue = items.reduce((sum, p) => sum + p.totalValue, 0);
  const totalEquity = items.reduce((sum, p) => sum + p.totalEquity, 0);
  const avgOccupancy = Math.round(items.reduce((sum, p) => sum + p.occupancyRate, 0) / items.length);

  const handleCreate = (data: Omit<REOPortfolio, "id" | "properties" | "createdAt">) => {
    const newItem: REOPortfolio = { ...data, id: String(Date.now()), properties: [], createdAt: new Date().toISOString().split("T")[0] };
    setItems((prev) => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: REOPortfolio) => {
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
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_reo_title", "Kurumsal Portföy (REO Portfolio)")}</h1>
              <p className="text-muted-foreground">{t("admin_reo_description", "Banka ve kurumsal gayrimenkul portföylerini yönetin")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_reo_back_to_dashboard", "Panele Dön")}
            </Button>
          </div>
        </m.div>

        {/* Summary Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><DollarSign className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_reo_total_value", "Toplam Değer")}</p>
                  <p className="text-2xl font-bold text-foreground">${(totalValue / 1000000).toFixed(1)}M</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><TrendingUp className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_reo_total_equity", "Toplam Birikim")}</p>
                  <p className="text-2xl font-bold text-foreground">${(totalEquity / 1000000).toFixed(1)}M</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-brand/10"><Users className="w-5 h-5 text-brand" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_reo_avg_occupancy", "Ort. Doluluk")}</p>
                  <p className="text-2xl font-bold text-foreground">{avgOccupancy}%</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10"><Building2 className="w-5 h-5 text-amber-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_reo_total_properties", "Toplam Emlak")}</p>
                  <p className="text-2xl font-bold text-foreground">{items.reduce((sum, p) => sum + p.propertyCount, 0)}</p>
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
                      placeholder={t("admin_reo_search_placeholder", "Portföy ara...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_reo_filter_status", "Duruma Göre Filtrele")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("admin_reo_all_status", "Tüm Durumlar")}</SelectItem>
                    <SelectItem value="BANK_OWNED">{tEnum(t, "BANK_OWNED")}</SelectItem>
                    <SelectItem value="PRE_FORECLOSURE">{tEnum(t, "PRE_FORECLOSURE")}</SelectItem>
                    <SelectItem value="AUGMENTATION">{tEnum(t, "AUGMENTATION")}</SelectItem>
                    <SelectItem value="LISTED">{tEnum(t, "LISTED")}</SelectItem>
                    <SelectItem value="UNDER_CONTRACT">{tEnum(t, "UNDER_CONTRACT")}</SelectItem>
                    <SelectItem value="SOLD">{tEnum(t, "SOLD")}</SelectItem>
                  </SelectContent>
                </Select>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_reo_add_portfolio", "Portföy Ekle")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Portfolio Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {filtered.map((portfolio) => (
              <Card key={portfolio.id} className="bg-card border-border">
                <CardHeader className="pb-3">
                  <div className="flex items-start justify-between">
                    <div>
                      <CardTitle className="text-foreground">{portfolio.name}</CardTitle>
                      <p className="text-sm text-muted-foreground mt-1">{portfolio.propertyCount} {t("admin_reo_properties", "mülk")}</p>
                    </div>
                    <div className="flex items-center gap-2">
                      <Badge className={STATUS_COLORS[portfolio.status]}>{tEnum(t, portfolio.status)}</Badge>
                      <Button onClick={() => { setEditingItem(portfolio); setIsEditOpen(true); }} variant="ghost" size="icon" aria-label={t("common.edit")} className="min-h-10 min-w-10 h-10 w-10"><Edit className="w-4 h-4" /></Button>
                      <Button onClick={() => { setDeletingItem(portfolio); setIsDeleteOpen(true); }} variant="ghost" size="icon" aria-label={t("common.delete")} className="min-h-10 min-w-10 h-10 w-10 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                    </div>
                  </div>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-2 gap-3 mb-4">
                    <div className="p-3 bg-muted/30 rounded-lg">
                      <p className="text-xs text-muted-foreground">{t("admin_reo_value", "Değer")}</p>
                      <p className="text-lg font-bold text-foreground">${(portfolio.totalValue / 1000000).toFixed(2)}M</p>
                    </div>
                    <div className="p-3 bg-muted/30 rounded-lg">
                      <p className="text-xs text-muted-foreground">{t("admin_reo_equity", "Birikim")}</p>
                      <p className="text-lg font-bold text-foreground">${(portfolio.totalEquity / 1000000).toFixed(2)}M</p>
                    </div>
                    <div className="p-3 bg-muted/30 rounded-lg">
                      <p className="text-xs text-muted-foreground">{t("admin_reo_occupancy", "Doluluk")}</p>
                      <p className="text-lg font-bold text-foreground">{portfolio.occupancyRate}%</p>
                    </div>
                    <div className="p-3 bg-muted/30 rounded-lg">
                      <p className="text-xs text-muted-foreground">{t("admin_reo_cap_rate", "Kap Oranı")}</p>
                      <p className="text-lg font-bold text-foreground">{portfolio.capRate}%</p>
                    </div>
                  </div>
                  <div className="space-y-2">
                    {portfolio.properties.map((prop) => (
                      <div key={prop.id} className="flex items-center justify-between p-2 bg-muted/20 rounded-lg">
                        <div>
                          <span className="text-sm text-foreground">{prop.name}</span>
                          <span className="text-xs text-muted-foreground ml-2">${(prop.value / 1000).toFixed(0)}K</span>
                        </div>
                        <Badge className={PROP_STATUS_COLORS[prop.status]}>{tEnum(t, prop.status)}</Badge>
                      </div>
                    ))}
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </m.div>

        {/* Create Dialog */}
        <CreatePortfolioDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {editingItem && <EditPortfolioDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />}
        {deletingItem && <DeletePortfolioDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />}
      </div>
    </div>
  );
}

function CreatePortfolioDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<REOPortfolio, "id" | "properties" | "createdAt">) => void }) {
  const { t } = useTranslation();
  const [name, setName] = useState("");
  const [totalValue, setTotalValue] = useState("");
  const [totalEquity, setTotalEquity] = useState("");
  const [occupancyRate, setOccupancyRate] = useState("");
  const [capRate, setCapRate] = useState("");
  const [propertyCount, setPropertyCount] = useState("");
  const [status, setStatus] = useState<REOPortfolio["status"]>("BANK_OWNED");

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_reo_create_portfolio", "Portföy Oluştur")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_reo_create_portfolio_desc", "Yeni bir kurumsal portföy ayarlayın")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_name", "Ad")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_total_value", "Toplam Değer")}</Label>
            <Input type="number" value={totalValue} onChange={(e) => setTotalValue(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_total_equity", "Toplam Birikim")}</Label>
            <Input type="number" value={totalEquity} onChange={(e) => setTotalEquity(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_occupancy_rate", "Doluluk Oranı")}</Label>
            <Input type="number" value={occupancyRate} onChange={(e) => setOccupancyRate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_cap_rate", "Kap Oranı")}</Label>
            <Input type="number" value={capRate} onChange={(e) => setCapRate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_property_count", "Emlak Sayısı")}</Label>
            <Input type="number" value={propertyCount} onChange={(e) => setPropertyCount(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Durum")}</Label>
            <Select value={status} onValueChange={(v) => setStatus(v as REOPortfolio["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="BANK_OWNED">{tEnum(t, "BANK_OWNED")}</SelectItem>
                <SelectItem value="PRE_FORECLOSURE">{tEnum(t, "PRE_FORECLOSURE")}</SelectItem>
                <SelectItem value="AUGMENTATION">{tEnum(t, "AUGMENTATION")}</SelectItem>
                <SelectItem value="LISTED">{tEnum(t, "LISTED")}</SelectItem>
                <SelectItem value="UNDER_CONTRACT">{tEnum(t, "UNDER_CONTRACT")}</SelectItem>
                <SelectItem value="SOLD">{tEnum(t, "SOLD")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
          <Button onClick={() => onSubmit({ name, totalValue: Number(totalValue), totalEquity: Number(totalEquity), occupancyRate: Number(occupancyRate), capRate: Number(capRate), propertyCount: Number(propertyCount), status })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Oluştur")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditPortfolioDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: REOPortfolio; onSubmit: (data: REOPortfolio) => void }) {
  const { t } = useTranslation();
  const [name, setName] = useState(item.name);
  const [totalValue, setTotalValue] = useState(String(item.totalValue));
  const [totalEquity, setTotalEquity] = useState(String(item.totalEquity));
  const [occupancyRate, setOccupancyRate] = useState(String(item.occupancyRate));
  const [capRate, setCapRate] = useState(String(item.capRate));
  const [status, setStatus] = useState(item.status);

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_reo_edit_portfolio", "Portföy Düzenle")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_reo_edit_portfolio_desc", "Portföy detaylarını güncelleyin")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_name", "Ad")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_total_value", "Toplam Değer")}</Label>
            <Input type="number" value={totalValue} onChange={(e) => setTotalValue(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_total_equity", "Toplam Birikim")}</Label>
            <Input type="number" value={totalEquity} onChange={(e) => setTotalEquity(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_occupancy_rate", "Doluluk Oranı")}</Label>
            <Input type="number" value={occupancyRate} onChange={(e) => setOccupancyRate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reo_cap_rate", "Kap Oranı")}</Label>
            <Input type="number" value={capRate} onChange={(e) => setCapRate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Durum")}</Label>
            <Select value={status} onValueChange={(v) => setStatus(v as REOPortfolio["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="BANK_OWNED">{tEnum(t, "BANK_OWNED")}</SelectItem>
                <SelectItem value="PRE_FORECLOSURE">{tEnum(t, "PRE_FORECLOSURE")}</SelectItem>
                <SelectItem value="AUGMENTATION">{tEnum(t, "AUGMENTATION")}</SelectItem>
                <SelectItem value="LISTED">{tEnum(t, "LISTED")}</SelectItem>
                <SelectItem value="UNDER_CONTRACT">{tEnum(t, "UNDER_CONTRACT")}</SelectItem>
                <SelectItem value="SOLD">{tEnum(t, "SOLD")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
          <Button onClick={() => onSubmit({ ...item, name, totalValue: Number(totalValue), totalEquity: Number(totalEquity), occupancyRate: Number(occupancyRate), capRate: Number(capRate), status })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Kaydet")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeletePortfolioDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: REOPortfolio; onConfirm: () => void }) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_reo_delete_portfolio", "Portföy Sil")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_reo_delete_portfolio_desc", "Bu portföyü silmek istediğinizden emin misiniz?")}{item.name}{t("admin_auto_this_action_cannot_be_undone", "? Bu eylem geri alınamaz.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Sil")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
