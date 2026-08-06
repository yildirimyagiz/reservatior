"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Megaphone,
  Search,
  Plus,
  Edit,
  Trash2,
  Play,
  Pause,
  TrendingUp,
  Users,
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
import { tEnum } from "@/lib/admin-enums";

const STATUSES = ["DRAFT", "ACTIVE", "PAUSED", "COMPLETED", "ARCHIVED"];
const CAMPAIGN_TYPES = ["DISCOUNT", "FLASH_SALE", "SEASONAL", "REFERRAL", "BUNDLE_PROMO", "LOYALTY"];

const STATUS_COLORS: Record<string, string> = {
  DRAFT: "bg-gray-500/20 text-gray-400",
  ACTIVE: "bg-blue-500/20 text-blue-400",
  PAUSED: "bg-amber-500/20 text-warning",
  COMPLETED: "bg-blue-500/20 text-info",
  ARCHIVED: "bg-muted text-muted-foreground",
};

const mockCampaigns = [
  { id: "1", orgId: "org1", name: "New Year Staging Sale", description: "20% off all staging bundles in January", campaignType: "DISCOUNT", status: "COMPLETED", discountType: "PERCENTAGE", discountValue: 20, startDate: "2026-01-01", endDate: "2026-01-31", targetAudience: "ALL", maxRedemptions: 100, currentRedemptions: 87, totalRevenue: 45000, totalOrders: 87, createdAt: "2025-12-15", updatedAt: "2026-02-01" },
  { id: "2", orgId: "org1", name: "Spring Furniture Flash", description: "48-hour flash sale on furniture categories", campaignType: "FLASH_SALE", status: "ACTIVE", discountType: "FIXED", discountValue: 100, startDate: "2026-02-15", endDate: "2026-02-17", targetAudience: "NEW_CUSTOMERS", maxRedemptions: 50, currentRedemptions: 23, totalRevenue: 12500, totalOrders: 23, createdAt: "2026-02-10", updatedAt: "2026-02-15" },
  { id: "3", orgId: "org1", name: "Referral Rewards Program", description: "Earn $50 credit for each referral", campaignType: "REFERRAL", status: "ACTIVE", discountType: "FIXED", discountValue: 50, startDate: "2026-01-01", endDate: "2026-12-31", targetAudience: "ALL", maxRedemptions: null, currentRedemptions: 156, totalRevenue: 7800, totalOrders: 156, createdAt: "2026-01-01", updatedAt: "2026-02-10" },
  { id: "4", orgId: "org1", name: "Bundle & Save", description: "15% off when buying 3+ items", campaignType: "BUNDLE_PROMO", status: "PAUSED", discountType: "PERCENTAGE", discountValue: 15, startDate: "2026-02-01", endDate: "2026-03-31", targetAudience: "ALL", maxRedemptions: 200, currentRedemptions: 42, totalRevenue: 18900, totalOrders: 42, createdAt: "2026-01-20", updatedAt: "2026-02-05" },
  { id: "5", orgId: "org1", name: "Summer Clearance", description: "End of season clearance up to 40% off", campaignType: "SEASONAL", status: "DRAFT", discountType: "PERCENTAGE", discountValue: 40, startDate: "2026-06-01", endDate: "2026-08-31", targetAudience: "ALL", maxRedemptions: 500, currentRedemptions: 0, totalRevenue: 0, totalOrders: 0, createdAt: "2026-02-15", updatedAt: "2026-02-15" },
];

export default function CampaignsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<any>(null);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<any>(null);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);

  const filtered = mockCampaigns.filter((c) => {
    const matchesSearch = c.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "all" || c.status === statusFilter;
    return matchesSearch && matchesStatus;
  });

  const totalCampaigns = mockCampaigns.length;
  const activeCampaigns = mockCampaigns.filter((c) => c.status === "ACTIVE").length;
  const totalRevenue = mockCampaigns.reduce((sum, c) => sum + c.totalRevenue, 0);

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <m.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_campaigns_title", "Kampanyalar ve İndirimler")}</h1>
              <p className="text-muted-foreground">{t("admin_campaigns_description", "Pazarlama kampanyalarını ve promosyon kodlarını yönetin")}</p>
            </div>
          </div>
        </m.div>

        {/* Summary Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Megaphone className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_campaigns_total", "Toplam Kampanya")}</p>
                  <p className="text-2xl font-bold text-foreground">{totalCampaigns}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Play className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_campaigns_active", "Aktif")}</p>
                  <p className="text-2xl font-bold text-foreground">{activeCampaigns}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10"><TrendingUp className="w-5 h-5 text-amber-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_campaigns_revenue", "Toplam Gelir")}</p>
                  <p className="text-2xl font-bold text-foreground">${totalRevenue.toLocaleString()}</p>
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
                      placeholder={t("admin_campaigns_search_placeholder", "Kampanya ara...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_campaigns_status", "Durum")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("admin_campaigns_all_status", "Tüm Durumlar")}</SelectItem>
                    {STATUSES.map((s) => <SelectItem key={s} value={s}>{tEnum(t, s)}</SelectItem>)}
                  </SelectContent>
                </Select>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_campaigns_add", "Kampanya Oluştur")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Campaign Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {filtered.map((campaign) => (
            <Card key={campaign.id} className="bg-card border-border hover:border-primary/20 transition-colors">
              <CardContent className="p-5">
                <div className="flex items-start justify-between mb-3">
                  <div>
                    <h2 className="font-semibold text-foreground">{campaign.name}</h2>
                    <Badge className={`${STATUS_COLORS[campaign.status]} mt-1`}>{tEnum(t, campaign.status)}</Badge>
                  </div>
                  <Badge className="bg-muted text-muted-foreground">{tEnum(t, campaign.campaignType)}</Badge>
                </div>
                <p className="text-sm text-muted-foreground mb-3 line-clamp-2">{campaign.description}</p>
                <div className="space-y-2 mb-4">
                  <div className="flex items-center justify-between text-xs">
                    <span className="text-muted-foreground">{t("admin_campaigns_discount", "İndirim")}</span>
                    <span className="text-foreground font-medium">{campaign.discountType === "PERCENTAGE" ? `${campaign.discountValue}%` : `$${campaign.discountValue}`}</span>
                  </div>
                  <div className="flex items-center justify-between text-xs">
                    <span className="text-muted-foreground">{t("admin_campaigns_redemptions", "Kullanımlar")}</span>
                    <span className="text-foreground font-medium">{campaign.currentRedemptions}{campaign.maxRedemptions ? ` / ${campaign.maxRedemptions}` : ""}</span>
                  </div>
                  <div className="flex items-center justify-between text-xs">
                    <span className="text-muted-foreground">{t("admin_campaigns_revenue", "Toplam Gelir")}</span>
                    <span className="text-foreground font-medium">${campaign.totalRevenue.toLocaleString()}</span>
                  </div>
                </div>
                <div className="flex gap-2 pt-3 border-t border-border">
                  {campaign.status === "ACTIVE" ? (
                    <Button variant="ghost" size="sm" className="flex-1 text-warning"><Pause className="w-3.5 h-3.5 mr-1" />{t("admin_campaigns_pause", "Duraklat")}</Button>
                  ) : campaign.status === "PAUSED" ? (
                    <Button variant="ghost" size="sm" className="flex-1 text-blue-400"><Play className="w-3.5 h-3.5 mr-1" />{t("admin_action_activate", "Etkinleştir")}</Button>
                  ) : (
                    <Button variant="ghost" size="sm" className="flex-1"><Play className="w-3.5 h-3.5 mr-1" />{t("admin_action_activate", "Etkinleştir")}</Button>
                  )}
                  <Button onClick={() => { setEditingItem(campaign); setIsEditOpen(true); }} variant="ghost" size="icon" aria-label={t("common.edit")} className="min-h-10 min-w-10 h-10 w-10"><Edit className="w-4 h-4" /></Button>
                  <Button onClick={() => { setDeletingItem(campaign); setIsDeleteOpen(true); }} variant="ghost" size="icon" aria-label={t("common.delete")} className="min-h-10 min-w-10 h-10 w-10 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                </div>
              </CardContent>
            </Card>
          ))}
        </m.div>

        {/* Dialogs */}
        <CreateCampaignDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} />
        {editingItem && <EditCampaignDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} />}
        {deletingItem && (
          <Dialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen}>
            <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
              <DialogHeader>
                <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_campaigns_delete_title", "Kampanyayı Sil")}</DialogTitle>
                <DialogDescription className="text-muted-foreground">{t("admin_campaigns_delete_desc", "Bu kaydı sistemden güvenli şekilde arşivlemek istediğinize emin misiniz?")}{deletingItem.name}{t("admin_auto_this_action_cannot_be_undone", "? Bu eylem geri alınamaz.")}</DialogDescription>
              </DialogHeader>
              <DialogFooter className="pt-4 border-t border-white/10">
                <Button variant="outline" onClick={() => setIsDeleteOpen(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
                <Button onClick={() => setIsDeleteOpen(false)} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Sil")}</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        )}
      </div>
    </div>
  );
}

function CreateCampaignDialog({ open, onOpenChange }: { open: boolean; onOpenChange: (open: boolean) => void }) {
  const { t } = useTranslation();
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [campaignType, setCampaignType] = useState("DISCOUNT");
  const [discountValue, setDiscountValue] = useState("");

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_campaigns_create_title", "Kampanya Oluştur")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_campaigns_create_desc", "Yeni bir pazarlama kampanyası başlatın.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_campaigns_name", "Ad")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_campaigns_type", "Tür")}</Label>
            <Select value={campaignType} onValueChange={setCampaignType}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"><SelectValue /></SelectTrigger>
              <SelectContent>{CAMPAIGN_TYPES.map((ct) => <SelectItem key={ct} value={ct}>{tEnum(t, ct)}</SelectItem>)}</SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_campaigns_discount", "İndirim")}</Label>
            <Input type="number" value={discountValue} onChange={(e) => setDiscountValue(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_campaigns_description", "Pazarlama kampanyalarını ve promosyon kodlarını yönetin")}</Label>
            <Input value={description} onChange={(e) => setDescription(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
          <Button onClick={() => onOpenChange(false)} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Oluştur")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditCampaignDialog({ open, onOpenChange, item }: { open: boolean; onOpenChange: (open: boolean) => void; item: any }) {
  const { t } = useTranslation();
  const [name, setName] = useState(item.name);
  const [description, setDescription] = useState(item.description);
  const [discountValue, setDiscountValue] = useState(String(item.discountValue));

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_campaigns_edit_title", "Kampanyayı Düzenle")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_campaigns_edit_desc", "Kampanya bilgilerini güncelleyin.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_campaigns_name", "Ad")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_campaigns_discount", "İndirim")}</Label>
            <Input type="number" value={discountValue} onChange={(e) => setDiscountValue(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_campaigns_description", "Pazarlama kampanyalarını ve promosyon kodlarını yönetin")}</Label>
            <Input value={description} onChange={(e) => setDescription(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
          <Button onClick={() => onOpenChange(false)} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Kaydet")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
