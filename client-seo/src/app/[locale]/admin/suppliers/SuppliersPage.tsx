"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Truck,
  Search,
  Plus,
  Edit,
  Trash2,
  Star,
  Mail,
  Phone,
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

const STATUSES = ["ACTIVE", "INACTIVE", "PENDING", "SUSPENDED"];
const BUSINESS_TYPES = ["MANUFACTURER", "DISTRIBUTOR", "WHOLESALER", "RETAILER"];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-blue-500/20 text-blue-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
  PENDING: "bg-amber-500/20 text-warning",
  SUSPENDED: "bg-red-500/20 text-red-400",
};

const mockSuppliers = [
  { id: "1", orgId: "org1", name: "Nordic Design Co.", description: "Scandinavian furniture manufacturer", contactName: "Erik Svenson", email: "erik@nordicdesign.com", phone: "+1-555-0101", website: "https://nordicdesign.com", taxId: "US-12345", businessType: "MANUFACTURER", country: "Sweden", city: "Stockholm", paymentTerms: "NET_30", minimumOrder: 500, currency: "USD", leadTimeDays: 14, commissionRate: 10, status: "ACTIVE", rating: 4.8, verifiedAt: "2025-06-15", createdAt: "2025-06-01", updatedAt: "2026-01-10" },
  { id: "2", orgId: "org1", name: "TechHome Electronics", description: "Consumer electronics distributor", contactName: "Sarah Chen", email: "sarah@techhome.com", phone: "+1-555-0102", website: "https://techhome.com", taxId: "US-67890", businessType: "DISTRIBUTOR", country: "USA", city: "San Francisco", paymentTerms: "NET_45", minimumOrder: 1000, currency: "USD", leadTimeDays: 7, commissionRate: 8, status: "ACTIVE", rating: 4.5, verifiedAt: "2025-08-20", createdAt: "2025-07-15", updatedAt: "2026-01-15" },
  { id: "3", orgId: "org1", name: "Artisan Lighting", description: "Handcrafted lighting solutions", contactName: "Marco Bianchi", email: "marco@artisanlighting.com", phone: "+1-555-0103", website: "https://artisanlighting.com", taxId: "US-11223", businessType: "MANUFACTURER", country: "Italy", city: "Milan", paymentTerms: "NET_30", minimumOrder: 200, currency: "EUR", leadTimeDays: 21, commissionRate: 12, status: "ACTIVE", rating: 4.9, verifiedAt: "2025-09-10", createdAt: "2025-08-01", updatedAt: "2026-02-01" },
  { id: "4", orgId: "org1", name: "DecorWorld", description: "Home decor wholesale supplier", contactName: "Aiko Tanaka", email: "aiko@decorworld.com", phone: "+1-555-0104", website: "https://decorworld.com", taxId: "US-44556", businessType: "WHOLESALER", country: "Japan", city: "Tokyo", paymentTerms: "NET_60", minimumOrder: 300, currency: "JPY", leadTimeDays: 10, commissionRate: 15, status: "PENDING", rating: 4.2, createdAt: "2025-10-01", updatedAt: "2026-01-20" },
];

function renderStars(rating: number) {
  return Array.from({ length: 5 }, (_, i) => (
    <Star key={i} className={`w-3.5 h-3.5 ${i < Math.round(rating) ? "fill-amber-400 text-warning" : "text-muted-foreground/30"}`} />
  ));
}

export default function SuppliersPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<any>(null);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<any>(null);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);

  const filtered = mockSuppliers.filter((s) => {
    const matchesSearch = s.name.toLowerCase().includes(searchTerm.toLowerCase()) || s.contactName.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "all" || s.status === statusFilter;
    return matchesSearch && matchesStatus;
  });

  const totalSuppliers = mockSuppliers.length;
  const activeSuppliers = mockSuppliers.filter((s) => s.status === "ACTIVE").length;
  const avgRating = mockSuppliers.reduce((sum, s) => sum + (s.rating || 0), 0) / mockSuppliers.length;

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <m.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_suppliers_title", "Tedarikçiler ve Servisler Rehberi")}</h1>
              <p className="text-muted-foreground">{t("admin_suppliers_description", "Tedarikçi dizinini, iletişim kişilerini ve komisyon oranlarını yönetin")}</p>
            </div>
          </div>
        </m.div>

        {/* Summary Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Truck className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_suppliers_total", "Toplam Tedarikçi")}</p>
                  <p className="text-2xl font-bold text-foreground">{totalSuppliers}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Truck className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_suppliers_active", "Aktif Tedarikçiler")}</p>
                  <p className="text-2xl font-bold text-foreground">{activeSuppliers}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10"><Star className="w-5 h-5 text-amber-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_suppliers_avg_rating", "Ortalama Derecelendirme")}</p>
                  <p className="text-2xl font-bold text-foreground">{avgRating.toFixed(1)}</p>
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
                      placeholder={t("admin_suppliers_search_placeholder", "Tedarikçi adı veya yetkili ara...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_suppliers_status", "Durum")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("admin_suppliers_all_status", "Tüm Durumlar")}</SelectItem>
                    {STATUSES.map((s) => <SelectItem key={s} value={s}>{tEnum(t, s)}</SelectItem>)}
                  </SelectContent>
                </Select>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_suppliers_add", "Yeni Tedarikçi Ekle")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Suppliers Grid */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {filtered.map((supplier) => (
            <Card key={supplier.id} className="bg-card border-border hover:border-primary/20 transition-colors">
              <CardContent className="p-5">
                <div className="flex items-start justify-between mb-3">
                  <div>
                    <h2 className="font-semibold text-foreground">{supplier.name}</h2>
                    <p className="text-xs text-muted-foreground">{tEnum(t, supplier.businessType)}</p>
                  </div>
                  <Badge className={STATUS_COLORS[supplier.status]}>{tEnum(t, supplier.status)}</Badge>
                </div>
                <div className="flex items-center gap-1 mb-2">{renderStars(supplier.rating || 0)}</div>
                <p className="text-sm text-muted-foreground mb-3 line-clamp-2">{supplier.description}</p>
                <div className="space-y-1 text-xs text-muted-foreground">
                  {supplier.contactName && <div className="flex items-center gap-2"><Truck className="w-3 h-3" />{supplier.contactName}</div>}
                  {supplier.email && <div className="flex items-center gap-2"><Mail className="w-3 h-3" />{supplier.email}</div>}
                  {supplier.phone && <div className="flex items-center gap-2"><Phone className="w-3 h-3" />{supplier.phone}</div>}
                </div>
                <div className="flex items-center justify-between mt-4 pt-3 border-t border-border">
                  <div className="text-xs text-muted-foreground">{t("admin_suppliers_commission", "Komisyon")}: <span className="text-foreground font-medium">{supplier.commissionRate}%</span></div>
                  <div className="flex gap-1">
                    <Button onClick={() => { setEditingItem(supplier); setIsEditOpen(true); }} variant="ghost" size="icon" aria-label={t("common.edit")} className="min-h-10 min-w-10 h-10 w-10"><Edit className="w-4 h-4" /></Button>
                    <Button onClick={() => { setDeletingItem(supplier); setIsDeleteOpen(true); }} variant="ghost" size="icon" aria-label={t("common.delete")} className="min-h-10 min-w-10 h-10 w-10 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </m.div>

        {/* Dialogs */}
        <CreateSupplierDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} />
        {editingItem && <EditSupplierDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} />}
        {deletingItem && <DeleteSupplierDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => setIsDeleteOpen(false)} />}
      </div>
    </div>
  );
}

function CreateSupplierDialog({ open, onOpenChange }: { open: boolean; onOpenChange: (open: boolean) => void }) {
  const { t } = useTranslation();
  const [name, setName] = useState("");
  const [contactName, setContactName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [businessType, setBusinessType] = useState("MANUFACTURER");
  const [commissionRate, setCommissionRate] = useState("");

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_suppliers_create_title", "Tedarikçi Ekle")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_suppliers_create_desc", "Dizine yeni bir tedarikçi ekleyin.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_suppliers_name", "Ad")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_suppliers_contact", "İletişim")}</Label>
            <Input value={contactName} onChange={(e) => setContactName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_suppliers_email", "E-posta")}</Label>
            <Input value={email} onChange={(e) => setEmail(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_suppliers_phone", "Telefon")}</Label>
            <Input value={phone} onChange={(e) => setPhone(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_suppliers_type", "Tür")}</Label>
            <Select value={businessType} onValueChange={setBusinessType}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"><SelectValue /></SelectTrigger>
              <SelectContent>{BUSINESS_TYPES.map((b) => <SelectItem key={b} value={b}>{tEnum(t, b)}</SelectItem>)}</SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_suppliers_commission", "Komisyon")}</Label>
            <Input type="number" value={commissionRate} onChange={(e) => setCommissionRate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
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

function EditSupplierDialog({ open, onOpenChange, item }: { open: boolean; onOpenChange: (open: boolean) => void; item: any }) {
  const { t } = useTranslation();
  const [name, setName] = useState(item.name);
  const [contactName, setContactName] = useState(item.contactName);
  const [email, setEmail] = useState(item.email);
  const [commissionRate, setCommissionRate] = useState(String(item.commissionRate || ""));

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_suppliers_edit_title", "Tedarikçiyi Düzenle")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_suppliers_edit_desc", "Tedarikçi bilgilerini güncelleyin.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_suppliers_name", "Ad")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_suppliers_contact", "İletişim")}</Label>
            <Input value={contactName} onChange={(e) => setContactName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_suppliers_email", "E-posta")}</Label>
            <Input value={email} onChange={(e) => setEmail(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_suppliers_commission", "Komisyon")}</Label>
            <Input type="number" value={commissionRate} onChange={(e) => setCommissionRate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
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

function DeleteSupplierDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: any; onConfirm: () => void }) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_suppliers_delete_title", "Tedarikçiyi Sil")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_suppliers_delete_desc", "Bu kaydı sistemden güvenli şekilde arşivlemek istediğinize emin misiniz?")}{item.name}{t("admin_auto_this_action_cannot_be_undone", "? Bu eylem geri alınamaz.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Sil")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
