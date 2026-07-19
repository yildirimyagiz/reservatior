"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Box,
  Search,
  Plus,
  Edit,
  Trash2,
  Package,
  Tag,
} from "lucide-react";
import { motion } from "framer-motion";
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

const BUNDLE_TYPES = ["STAGING_BASIC", "STAGING_PREMIUM", "STAGING_LUXURY", "FURNITURE_ESSENTIALS", "KITCHEN_STARTER", "BEDROOM_SET", "CUSTOM"];

const BUNDLE_COLORS: Record<string, string> = {
  STAGING_BASIC: "bg-blue-500/20 text-blue-400",
  STAGING_PREMIUM: "bg-purple-500/20 text-purple-400",
  STAGING_LUXURY: "bg-amber-500/20 text-amber-400",
  FURNITURE_ESSENTIALS: "bg-green-500/20 text-green-400",
  KITCHEN_STARTER: "bg-orange-500/20 text-orange-400",
  BEDROOM_SET: "bg-pink-500/20 text-pink-400",
  CUSTOM: "bg-gray-500/20 text-gray-400",
};

const mockBundles = [
  { id: "1", orgId: "org1", name: "Studio Starter Pack", description: "Essential furniture for studio apartments", bundleType: "STAGING_BASIC", totalPrice: 2499, currency: "USD", bedrooms: 0, originalPrice: 3199, discountPct: 22, isActive: true, items: [{ id: "i1", bundleId: "1", productId: "p1", quantity: 1, unitPrice: 599, totalPrice: 599 }, { id: "i2", bundleId: "1", productId: "p2", quantity: 1, unitPrice: 899, totalPrice: 899 }, { id: "i3", bundleId: "1", productId: "p3", quantity: 2, unitPrice: 249, totalPrice: 498 }, { id: "i4", bundleId: "1", productId: "p4", quantity: 1, unitPrice: 503, totalPrice: 503 }], createdAt: "2026-01-01", updatedAt: "2026-01-01" },
  { id: "2", orgId: "org1", name: "1BR Premium Staging", description: "Premium staging for 1-bedroom apartments", bundleType: "STAGING_PREMIUM", totalPrice: 5999, currency: "USD", bedrooms: 1, originalPrice: 7499, discountPct: 20, isActive: true, items: [{ id: "i5", bundleId: "2", productId: "p5", quantity: 1, unitPrice: 1299, totalPrice: 1299 }, { id: "i6", bundleId: "2", productId: "p6", quantity: 1, unitPrice: 899, totalPrice: 899 }, { id: "i7", bundleId: "2", productId: "p7", quantity: 3, unitPrice: 299, totalPrice: 897 }, { id: "i8", bundleId: "2", productId: "p8", quantity: 2, unitPrice: 1452, totalPrice: 2904 }], createdAt: "2026-01-05", updatedAt: "2026-01-05" },
  { id: "3", orgId: "org1", name: "Luxury Penthouse Suite", description: "Full luxury staging for high-end properties", bundleType: "STAGING_LUXURY", totalPrice: 15999, currency: "USD", bedrooms: 3, originalPrice: 21999, discountPct: 27, isActive: true, items: [{ id: "i9", bundleId: "3", productId: "p9", quantity: 1, unitPrice: 4999, totalPrice: 4999 }, { id: "i10", bundleId: "3", productId: "p10", quantity: 1, unitPrice: 3499, totalPrice: 3499 }, { id: "i11", bundleId: "3", productId: "p11", quantity: 4, unitPrice: 899, totalPrice: 3596 }, { id: "i12", bundleId: "3", productId: "p12", quantity: 2, unitPrice: 1952, totalPrice: 3904 }], createdAt: "2026-01-10", updatedAt: "2026-01-10" },
  { id: "4", orgId: "org1", name: "Kitchen Essentials", description: "Complete kitchen setup for any property", bundleType: "KITCHEN_STARTER", totalPrice: 3499, currency: "USD", bedrooms: null, originalPrice: 4299, discountPct: 19, isActive: false, items: [{ id: "i13", bundleId: "4", productId: "p13", quantity: 1, unitPrice: 1299, totalPrice: 1299 }, { id: "i14", bundleId: "4", productId: "p14", quantity: 1, unitPrice: 899, totalPrice: 899 }, { id: "i15", bundleId: "4", productId: "p15", quantity: 1, unitPrice: 1301, totalPrice: 1301 }], createdAt: "2026-01-15", updatedAt: "2026-01-15" },
];

export default function BundlesPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [typeFilter, setTypeFilter] = useState("all");
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<any>(null);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<any>(null);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);

  const filtered = mockBundles.filter((b) => {
    const matchesSearch = b.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesType = typeFilter === "all" || b.bundleType === typeFilter;
    return matchesSearch && matchesType;
  });

  const totalBundles = mockBundles.length;
  const activeBundles = mockBundles.filter((b) => b.isActive).length;
  const totalRevenue = mockBundles.reduce((sum, b) => sum + b.totalPrice, 0);

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_bundles_title", "Product Bundles")}</h1>
              <p className="text-muted-foreground">{t("admin_bundles_description", "Create and manage staging bundles for properties")}</p>
            </div>
          </div>
        </motion.div>

        {/* Summary Cards */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-blue-500/10"><Box className="w-5 h-5 text-blue-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_bundles_total", "Total Bundles")}</p>
                  <p className="text-2xl font-bold text-foreground">{totalBundles}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-green-500/10"><Package className="w-5 h-5 text-green-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_bundles_active", "Active")}</p>
                  <p className="text-2xl font-bold text-foreground">{activeBundles}</p>
                </div>
              </div>
            </CardContent>
          </Card>
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-amber-500/10"><Tag className="w-5 h-5 text-amber-500" /></div>
                <div>
                  <p className="text-sm text-muted-foreground">{t("admin_bundles_total_value", "Total Value")}</p>
                  <p className="text-2xl font-bold text-foreground">${totalRevenue.toLocaleString()}</p>
                </div>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Search and Filter */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.15 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4 flex-wrap">
                <div className="flex-1 min-w-[200px]">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_bundles_search_placeholder", "Search bundles...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Select value={typeFilter} onValueChange={setTypeFilter}>
                  <SelectTrigger className="w-[200px] bg-white/5 border-white/10 text-foreground">
                    <SelectValue placeholder={t("admin_bundles_type", "Bundle Type")} />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">{t("admin_bundles_all_types", "All Types")}</SelectItem>
                    {BUNDLE_TYPES.map((bt) => <SelectItem key={bt} value={bt}>{bt.replace(/_/g, " ")}</SelectItem>)}
                  </SelectContent>
                </Select>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_bundles_add", "Create Bundle")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Bundle Cards */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }} className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {filtered.map((bundle) => (
            <Card key={bundle.id} className="bg-card border-border hover:border-primary/20 transition-colors">
              <CardContent className="p-5">
                <div className="flex items-start justify-between mb-3">
                  <div>
                    <h3 className="font-semibold text-foreground">{bundle.name}</h3>
                    <Badge className={`${BUNDLE_COLORS[bundle.bundleType]} mt-1`}>{bundle.bundleType.replace(/_/g, " ")}</Badge>
                  </div>
                  {bundle.isActive ? <Badge className="bg-green-500/20 text-green-400">Active</Badge> : <Badge className="bg-gray-500/20 text-gray-400">Inactive</Badge>}
                </div>
                <p className="text-sm text-muted-foreground mb-4 line-clamp-2">{bundle.description}</p>
                <div className="flex items-center gap-2 mb-2 text-xs text-muted-foreground">
                  <Package className="w-3.5 h-3.5" />{bundle.items.length} items
                  {bundle.bedrooms != null && <span>• {bundle.bedrooms} BR</span>}
                </div>
                <div className="flex items-baseline gap-2 mb-4">
                  <span className="text-xl font-bold text-foreground">${bundle.totalPrice.toLocaleString()}</span>
                  {bundle.originalPrice && <span className="text-sm text-muted-foreground line-through">${bundle.originalPrice.toLocaleString()}</span>}
                  {bundle.discountPct && <Badge className="bg-red-500/20 text-red-400 text-xs">-{bundle.discountPct}%</Badge>}
                </div>
                <div className="flex gap-2 pt-3 border-t border-border">
                  <Button onClick={() => { setEditingItem(bundle); setIsEditOpen(true); }} variant="ghost" size="sm" className="flex-1"><Edit className="w-3.5 h-3.5 mr-1" />{t("admin_action_edit", "Edit")}</Button>
                  <Button onClick={() => { setDeletingItem(bundle); setIsDeleteOpen(true); }} variant="ghost" size="sm" className="text-red-400"><Trash2 className="w-3.5 h-3.5" /></Button>
                </div>
              </CardContent>
            </Card>
          ))}
        </motion.div>

        {/* Dialogs */}
        <CreateBundleDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} />
        {editingItem && <EditBundleDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} />}
        {deletingItem && <DeleteBundleDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => setIsDeleteOpen(false)} />}
      </div>
    </div>
  );
}

function CreateBundleDialog({ open, onOpenChange }: { open: boolean; onOpenChange: (open: boolean) => void }) {
  const { t } = useTranslation();
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [bundleType, setBundleType] = useState("STAGING_BASIC");
  const [totalPrice, setTotalPrice] = useState("");
  const [currency, setCurrency] = useState("USD");

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_bundles_create_title", "Create Bundle")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_bundles_create_desc", "Create a new staging bundle.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bundles_name", "Name")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bundles_type", "Type")}</Label>
            <Select value={bundleType} onValueChange={setBundleType}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"><SelectValue /></SelectTrigger>
              <SelectContent>{BUNDLE_TYPES.map((bt) => <SelectItem key={bt} value={bt}>{bt.replace(/_/g, " ")}</SelectItem>)}</SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bundles_price", "Price")}</Label>
            <Input type="number" value={totalPrice} onChange={(e) => setTotalPrice(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bundles_description", "Description")}</Label>
            <Input value={description} onChange={(e) => setDescription(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onOpenChange(false)} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditBundleDialog({ open, onOpenChange, item }: { open: boolean; onOpenChange: (open: boolean) => void; item: any }) {
  const { t } = useTranslation();
  const [name, setName] = useState(item.name);
  const [totalPrice, setTotalPrice] = useState(String(item.totalPrice));
  const [bundleType, setBundleType] = useState(item.bundleType);

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_bundles_edit_title", "Edit Bundle")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_bundles_edit_desc", "Update bundle details.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bundles_name", "Name")}</Label>
            <Input value={name} onChange={(e) => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bundles_type", "Type")}</Label>
            <Select value={bundleType} onValueChange={setBundleType}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors"><SelectValue /></SelectTrigger>
              <SelectContent>{BUNDLE_TYPES.map((bt) => <SelectItem key={bt} value={bt}>{bt.replace(/_/g, " ")}</SelectItem>)}</SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_bundles_price", "Price")}</Label>
            <Input type="number" value={totalPrice} onChange={(e) => setTotalPrice(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onOpenChange(false)} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteBundleDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: any; onConfirm: () => void }) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_bundles_delete_title", "Delete Bundle")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_bundles_delete_desc", "Are you sure you want to delete")}{item.name}{t("admin_auto_this_action_cannot_be_undone", "? This action cannot be undone.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
