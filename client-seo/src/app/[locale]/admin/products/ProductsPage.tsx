"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Package,
  Search,
  Plus,
  Edit,
  Trash2,
  Filter,
  DollarSign,
  Tag,
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
import { useProductsStore } from "@/lib/store/products-store";
import { tEnum } from "@/lib/admin-enums";

const CATEGORIES = ["FURNITURE", "APPLIANCE", "ELECTRONICS", "DECOR", "LIGHTING", "TEXTILE", "KITCHEN", "BATHROOM", "OUTDOOR", "OTHER"];
const STATUSES = ["ACTIVE", "INACTIVE", "DISCONTINUED", "OUT_OF_STOCK"];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-blue-500/20 text-blue-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
  DISCONTINUED: "bg-red-500/20 text-red-400",
  OUT_OF_STOCK: "bg-amber-500/20 text-warning",
};

const CATEGORY_COLORS: Record<string, string> = {
  FURNITURE: "bg-blue-500/20 text-info",
  APPLIANCE: "bg-brand/20 text-brand",
  ELECTRONICS: "bg-cyan-500/20 text-cyan-400",
  DECOR: "bg-pink-500/20 text-pink-400",
  LIGHTING: "bg-amber-500/20 text-warning",
  TEXTILE: "bg-blue-500/20 text-success",
  KITCHEN: "bg-orange-500/20 text-warning",
  BATHROOM: "bg-blue-500/20 text-blue-400",
  OUTDOOR: "bg-lime-500/20 text-lime-400",
  OTHER: "bg-muted text-muted-foreground",
};

const mockProducts = [
  { id: "1", orgId: "org1", name: "Modern Sofa Set", category: "FURNITURE", price: 1299, currency: "USD", status: "ACTIVE", isActive: true, sku: "FRN-001", description: "3-seat modern sofa with ottoman", supplierId: "s1", commissionRate: 10, createdAt: "2026-01-10", updatedAt: "2026-01-10" },
  { id: "2", orgId: "org1", name: "Smart LED TV 55\"", category: "ELECTRONICS", price: 899, currency: "USD", status: "ACTIVE", isActive: true, sku: "ELC-002", description: "55-inch 4K Smart TV", supplierId: "s2", commissionRate: 8, createdAt: "2026-01-12", updatedAt: "2026-01-12" },
  { id: "3", orgId: "org1", name: "Ceramic Table Lamp", category: "LIGHTING", price: 149, currency: "USD", status: "ACTIVE", isActive: true, sku: "LGT-003", description: "Handcrafted ceramic table lamp", supplierId: "s3", commissionRate: 12, createdAt: "2026-01-15", updatedAt: "2026-01-15" },
  { id: "4", orgId: "org1", name: "Premium Coffee Machine", category: "APPLIANCE", price: 459, currency: "USD", status: "INACTIVE", isActive: false, sku: "APL-004", description: "Espresso coffee machine with grinder", supplierId: "s1", commissionRate: 15, createdAt: "2026-02-01", updatedAt: "2026-02-01" },
  { id: "5", orgId: "org1", name: "Abstract Wall Art", category: "DECOR", price: 249, currency: "USD", status: "ACTIVE", isActive: true, sku: "DRC-005", description: "Contemporary abstract canvas art", supplierId: "s4", commissionRate: 20, createdAt: "2026-02-05", updatedAt: "2026-02-05" },
  { id: "6", orgId: "org1", name: "King Size Bed Frame", category: "FURNITURE", price: 899, currency: "USD", status: "OUT_OF_STOCK", isActive: true, sku: "FRN-006", description: "Solid wood king size bed frame", supplierId: "s1", commissionRate: 10, createdAt: "2026-02-10", updatedAt: "2026-02-10" },
];

export default function ProductsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [categoryFilter, setCategoryFilter] = useState("all");
  const [statusFilter, setStatusFilter] = useState("all");
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<any>(null);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<any>(null);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);

  const filtered = mockProducts.filter((p) => {
    const matchesSearch = p.name.toLowerCase().includes(searchTerm.toLowerCase()) || p.sku?.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesCategory = categoryFilter === "all" || p.category === categoryFilter;
    const matchesStatus = statusFilter === "all" || p.status === statusFilter;
    return matchesSearch && matchesCategory && matchesStatus;
  });

  const totalProducts = mockProducts.length;
  const activeProducts = mockProducts.filter((p) => p.status === "ACTIVE").length;
  const totalValue = mockProducts.reduce((sum, p) => sum + p.price, 0);

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <m.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_products_title", "Ürünler ve Hizmetler Kataloğu")}</h1>
              <p className="text-muted-foreground">{t("admin_products_description", "Platform ürünlerini, stok durumunu ve fiyatlandırmayı yönetin")}</p>
            </div>
          </div>
        </m.div>

        {/* Summary Cards */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Package className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_products_total", "Toplam Ürün")}</p>
                  <p className="text-2xl font-bold text-foreground">{totalProducts}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Tag className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_products_active", "Aktif Ürünler")}</p>
                  <p className="text-2xl font-bold text-foreground">{activeProducts}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10"><DollarSign className="w-5 h-5 text-amber-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_products_total_value", "Toplam Değer")}</p>
                  <p className="text-2xl font-bold text-foreground">${totalValue.toLocaleString()}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Search and Filters */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.15 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4 flex-wrap">
                <div className="flex-1 min-w-[200px]">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_products_search_placeholder", "Ada veya SKU'ya göre ara...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={categoryFilter} onValueChange={setCategoryFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_products_category", "Kategori")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("admin_products_all_categories", "Tüm Kategoriler")}</SelectItem>
                    {CATEGORIES.map((cat) => (
                      <SelectItem key={cat} value={cat}>{tEnum(t, cat)}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-[180px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_products_status", "Durum")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("admin_products_all_status", "Tüm Durumlar")}</SelectItem>
                    {STATUSES.map((s) => (
                      <SelectItem key={s} value={s}>{tEnum(t, s)}</SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_products_add", "Yeni Ürün Ekle")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Products Table */}
        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Package className="w-5 h-5" />
                {t("admin_products_list_title", "Ürünler")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-sm">
                  <thead>
                    <tr className="border-b border-border">
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_products_name", "Ad")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_products_sku", "SKU")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_products_category_col", "Kategori")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_products_price", "Fiyat")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_products_commission", "Komisyon")}</th>
                      <th className="text-left py-3 px-4 text-muted-foreground font-medium">{t("admin_products_status_col", "Durum")}</th>
                      <th className="text-right py-3 px-4 text-muted-foreground font-medium">{t("admin_products_actions", "İşlemler")}</th>
                    </tr>
                  </thead>
                  <tbody>
                    {filtered.map((product) => (
                      <tr key={product.id} className="border-b border-border/50 hover:bg-muted/30 transition-colors">
                        <td className="py-3 px-4">
                          <div className="text-foreground font-medium">{product.name}</div>
                          <div className="text-xs text-muted-foreground truncate max-w-[200px]">{product.description}</div>
                        </td>
                        <td className="py-3 px-4 text-muted-foreground font-mono text-xs">{product.sku}</td>
                        <td className="py-3 px-4">
                          <Badge className={CATEGORY_COLORS[product.category]}>{tEnum(t, product.category)}</Badge>
                        </td>
                        <td className="py-3 px-4 text-right font-medium text-foreground">${product.price.toLocaleString()}</td>
                        <td className="py-3 px-4 text-right text-muted-foreground">{product.commissionRate}%</td>
                        <td className="py-3 px-4">
                          <Badge className={STATUS_COLORS[product.status]}>{tEnum(t, product.status)}</Badge>
                        </td>
                        <td className="py-3 px-4">
                          <div className="flex justify-end gap-2">
                            <Button onClick={() => { setEditingItem(product); setIsEditOpen(true); }} variant="ghost" size="icon" aria-label={t("common.edit")} className="min-h-10 min-w-10 h-10 w-10"><Edit className="w-4 h-4" /></Button>
                            <Button onClick={() => { setDeletingItem(product); setIsDeleteOpen(true); }} variant="ghost" size="icon" aria-label={t("common.delete")} className="min-h-10 min-w-10 h-10 w-10 text-red-400"><Trash2 className="w-4 h-4" /></Button>
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
        <CreateProductDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} />
        {editingItem && <EditProductDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} />}
        {deletingItem && <DeleteProductDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => setIsDeleteOpen(false)} />}
      </div>
    </div>
  );
}

function CreateProductDialog({ open, onOpenChange }: { open: boolean; onOpenChange: (open: boolean) => void }) {
  const { t } = useTranslation();
  const [name, setName] = useState("");
  const [category, setCategory] = useState("FURNITURE");
  const [price, setPrice] = useState("");
  const [sku, setSku] = useState("");
  const [description, setDescription] = useState("");
  const [commissionRate, setCommissionRate] = useState("");

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_products_create_title", "Ürün Ekle")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_products_create_desc", "Kataloğa yeni bir ürün ekleyin.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_products_name", "Ad")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_products_category", "Kategori")}</Label>
            <Select value={category} onValueChange={setCategory}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"><SelectValue /></SelectTrigger>
              <SelectContent>{CATEGORIES.map((c) => <SelectItem key={c} value={c}>{tEnum(t, c)}</SelectItem>)}</SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_products_price", "Fiyat")}</Label>
            <Input type="number" value={price} onChange={(e) => setPrice(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_products_sku", "SKU")}</Label>
            <Input value={sku} onChange={(e) => setSku(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_products_commission", "Komisyon")}</Label>
            <Input type="number" value={commissionRate} onChange={(e) => setCommissionRate(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_products_description", "Platform ürünlerini, stok durumunu ve fiyatlandırmayı yönetin")}</Label>
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

function EditProductDialog({ open, onOpenChange, item }: { open: boolean; onOpenChange: (open: boolean) => void; item: any }) {
  const { t } = useTranslation();
  const [name, setName] = useState(item.name);
  const [category, setCategory] = useState(item.category);
  const [price, setPrice] = useState(String(item.price));
  const [commissionRate, setCommissionRate] = useState(String(item.commissionRate || ""));

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_products_edit_title", "Ürünü Düzenle")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_products_edit_desc", "Ürün bilgilerini güncelleyin.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_products_name", "Ad")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_products_category", "Kategori")}</Label>
            <Select value={category} onValueChange={setCategory}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"><SelectValue /></SelectTrigger>
              <SelectContent>{CATEGORIES.map((c) => <SelectItem key={c} value={c}>{tEnum(t, c)}</SelectItem>)}</SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_products_price", "Fiyat")}</Label>
            <Input type="number" value={price} onChange={(e) => setPrice(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_products_commission", "Komisyon")}</Label>
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

function DeleteProductDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: any; onConfirm: () => void }) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_products_delete_title", "Ürünü Sil")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_products_delete_desc", "Bu kaydı sistemden güvenli şekilde arşivlemek istediğinize emin misiniz?")}{item.name}{t("admin_auto_this_action_cannot_be_undone", "? Bu eylem geri alınamaz.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "İptal")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Sil")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
