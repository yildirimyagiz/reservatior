"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { 
  Building2, Search, Plus, Edit, Trash2, ArrowUpRight, MapPin, DollarSign, Star, Check, AlertTriangle
} from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Listing {
  id: string;
  title: string;
  type: "SALE" | "RENT" | "SHORT_TERM";
  price: number;
  address: string;
  city: string;
  featured: boolean;
  views: number;
  status: "ACTIVE" | "PENDING" | "SOLD";
}

const mockListings: Listing[] = [
  { id: "1", title: "Luxury Villa with Ocean View", type: "SALE", price: 1250000, address: "123 Palm Beach Dr", city: "Miami", featured: true, views: 2450, status: "ACTIVE" },
  { id: "2", title: "Modern Downtown Apartment", type: "RENT", price: 4500, address: "456 Broadway", city: "New York", featured: false, views: 1890, status: "ACTIVE" },
  { id: "3", title: "Beachfront Condo", type: "SHORT_TERM", price: 350, address: "789 Ocean Blvd", city: "Los Angeles", featured: true, views: 3200, status: "PENDING" },
  { id: "4", title: "Cozy Studio Loft", type: "RENT", price: 1800, address: "321 Arts District", city: "San Francisco", featured: false, views: 980, status: "SOLD" }
];

const TYPE_COLORS: Record<string, string> = {
  SALE: "bg-blue-500/10 text-blue-400 border border-blue-500/20",
  RENT: "bg-violet-500/10 text-violet-400 border border-violet-500/20",
  SHORT_TERM: "bg-emerald-500/10 text-emerald-400 border border-emerald-500/20"
};

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-emerald-500/10 text-emerald-400 border border-emerald-500/20",
  PENDING: "bg-amber-500/10 text-amber-400 border border-amber-500/20",
  SOLD: "bg-slate-500/10 text-slate-400 border border-slate-500/20"
};

function GlassModal({ open, onOpenChange, title, description, children, footer }: any) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[480px] bg-slate-900/90 backdrop-blur-xl border border-white/10 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-white to-white/70">
            {title}
          </DialogTitle>
          {description && <DialogDescription className="text-slate-400">{description}</DialogDescription>}
        </DialogHeader>
        <div className="py-4 space-y-4">{children}</div>
        {footer && <DialogFooter className="pt-4 border-t border-white/10">{footer}</DialogFooter>}
      </DialogContent>
    </Dialog>
  );
}

function CreateListingDialog({ open, onOpenChange, onSubmit }: any) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState<Omit<Listing, "id">>({
    title: "", type: "SALE", price: 0, address: "", city: "", featured: false, views: 0, status: "ACTIVE"
  });

  return (
    <GlassModal open={open} onOpenChange={onOpenChange} title={t("listings.propertylistingspage.auto_ext_4", "Add Listing")}
      footer={
        <div className="flex justify-end gap-2 w-full">
          <Button variant="ghost" onClick={() => onOpenChange(false)} className="text-slate-300 hover:text-white">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit(formData)} className="bg-primary hover:bg-primary/90 shadow-lg shadow-primary/20">
            <Check className="w-4 h-4 mr-2" />{t("admin_action_create", "Create")}
          </Button>
        </div>
      }
    >
      <div className="grid gap-4 text-white">
        <div className="grid gap-2">
          <Label>{t("admin_ai_title", "Title")}</Label>
          <Input value={formData.title} onChange={e => setFormData({ ...formData, title: e.target.value })} className="bg-white/5 border-white/10 focus:border-primary/50" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_ai_type", "Type")}</Label>
            <Select value={formData.type} onValueChange={(v: any) => setFormData({ ...formData, type: v })}>
              <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
              <SelectContent>
                <SelectItem value="SALE">{t("admin_status_sold", "Sale")}</SelectItem>
                <SelectItem value="RENT">{t("admin_status_rented", "Rent")}</SelectItem>
                <SelectItem value="SHORT_TERM">{t("admin_auto_short_term", "Short Term")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_auto_amount", "Price")}</Label>
            <Input type="number" value={formData.price} onChange={e => setFormData({ ...formData, price: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
        </div>
        <div className="grid gap-2">
          <Label>{t("admin_auto_address", "Address")}</Label>
          <Input value={formData.address} onChange={e => setFormData({ ...formData, address: e.target.value })} className="bg-white/5 border-white/10" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_auto_city", "City")}</Label>
            <Input value={formData.city} onChange={e => setFormData({ ...formData, city: e.target.value })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_status", "Status")}</Label>
            <Select value={formData.status} onValueChange={(v: any) => setFormData({ ...formData, status: v })}>
              <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
              <SelectContent>
                <SelectItem value="ACTIVE">{t("admin_status_active")}</SelectItem>
                <SelectItem value="PENDING">{t("admin_status_pending")}</SelectItem>
                <SelectItem value="SOLD">{t("admin_status_sold")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
      </div>
    </GlassModal>
  );
}

function EditListingDialog({ open, onOpenChange, item, onSubmit }: any) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState<Listing>(item);

  return (
    <GlassModal open={open} onOpenChange={onOpenChange} title={t("admin_action_edit", "Edit")}
      footer={
        <div className="flex justify-end gap-2 w-full">
          <Button variant="ghost" onClick={() => onOpenChange(false)} className="text-slate-300 hover:text-white">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit(formData)} className="bg-primary hover:bg-primary/90 shadow-lg shadow-primary/20">
            <Check className="w-4 h-4 mr-2" />{t("admin_action_save", "Save")}
          </Button>
        </div>
      }
    >
      <div className="grid gap-4 text-white">
        <div className="grid gap-2">
          <Label>{t("admin_ai_title", "Title")}</Label>
          <Input value={formData.title} onChange={e => setFormData({ ...formData, title: e.target.value })} className="bg-white/5 border-white/10 focus:border-primary/50" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_ai_type", "Type")}</Label>
            <Select value={formData.type} onValueChange={(v: any) => setFormData({ ...formData, type: v })}>
              <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
              <SelectContent>
                <SelectItem value="SALE">{t("admin_status_sold", "Sale")}</SelectItem>
                <SelectItem value="RENT">{t("admin_status_rented", "Rent")}</SelectItem>
                <SelectItem value="SHORT_TERM">{t("admin_auto_short_term", "Short Term")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_auto_amount", "Price")}</Label>
            <Input type="number" value={formData.price} onChange={e => setFormData({ ...formData, price: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
        </div>
        <div className="grid gap-2">
          <Label>{t("admin_auto_address", "Address")}</Label>
          <Input value={formData.address} onChange={e => setFormData({ ...formData, address: e.target.value })} className="bg-white/5 border-white/10" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_auto_city", "City")}</Label>
            <Input value={formData.city} onChange={e => setFormData({ ...formData, city: e.target.value })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_status", "Status")}</Label>
            <Select value={formData.status} onValueChange={(v: any) => setFormData({ ...formData, status: v })}>
              <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
              <SelectContent>
                <SelectItem value="ACTIVE">{t("admin_status_active")}</SelectItem>
                <SelectItem value="PENDING">{t("admin_status_pending")}</SelectItem>
                <SelectItem value="SOLD">{t("admin_status_sold")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
      </div>
    </GlassModal>
  );
}

function DeleteListingDialog({ open, onOpenChange, item, onConfirm }: any) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-slate-900/90 backdrop-blur-xl border border-red-500/20 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2 text-red-500">
            <AlertTriangle className="w-5 h-5" />{t("admin_action_delete", "Delete")}
          </DialogTitle>
          <DialogDescription className="pt-2 text-slate-300">
            {t("admin_auto_are_you_sure_you_want_to_delete", "Are you sure you want to delete")} <span className="font-bold text-white">{item?.title}</span>? {t("admin_auto_this_action_cannot_be_undone", "This action cannot be undone.")}
          </DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/5">
          <Button variant="ghost" onClick={() => onOpenChange(false)} className="text-slate-300 hover:text-white">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

export default function PropertyListingsPage() {
  const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<Listing[]>(mockListings);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<Listing | null>(null);
  const [deletingItem, setDeletingItem] = useState<Listing | null>(null);

  const filteredListings = items.filter(listing => 
    listing.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
    listing.city.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<Listing, "id">) => {
    setItems(prev => [...prev, { ...data, id: String(Date.now()) }]);
    setIsCreateOpen(false);
  };
  const handleEdit = (updatedItem: Listing) => {
    setItems(prev => prev.map(item => item.id === updatedItem.id ? updatedItem : item));
    setEditingItem(null);
  };
  const handleDelete = (id: string) => {
    setItems(prev => prev.filter(item => item.id !== id));
    setDeletingItem(null);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 via-slate-900 to-slate-900">
      <div className="container mx-auto px-4 py-8">
        <m.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-white mb-2">{t("client.src.property_listings", "Property Listings")}</h1>
              <p className="text-gray-400">{t("listings.propertylistingspage.auto_ext_2", "Manage your property listings")}</p>
            </div>
            <Button onClick={() => router.push('/admin/dashboard')} className="bg-slate-600 hover:bg-slate-700">
              <ArrowUpRight className="w-4 h-4 mr-2" />{t("admin_adminpage_auto_ext_3", "Dashboard")}
            </Button>
          </div>
        </m.div>

        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="mb-6">
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                    <Input placeholder={t("client.src.search_listings", "Search listings...")} value={searchTerm} onChange={(e) => setSearchTerm(e.target.value)} className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400" />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90 shadow-md">
                  <Plus className="w-4 h-4 mr-2" />{t("listings.propertylistingspage.auto_ext_4", "Add Listing")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <Building2 className="w-5 h-5 text-primary" />
                {t("listings.propertylistingspage.auto_ext_5", "All Listings")} ({filteredListings.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <AnimatePresence>
                  {filteredListings.map((listing) => (
                    <m.div key={listing.id} layout initial={{ opacity: 0, scale: 0.98 }} animate={{ opacity: 1, scale: 1 }} exit={{ opacity: 0, scale: 0.98 }}
                      className="flex items-center justify-between p-4 bg-white/5 rounded-xl hover:bg-white/10 transition-all border border-transparent hover:border-slate-500/30 group"
                    >
                      <div className="flex items-center gap-4">
                        <div className="w-12 h-12 rounded-lg bg-gradient-to-br from-slate-500/20 to-slate-500/10 border border-slate-500/20 flex items-center justify-center">
                          <Building2 className="w-6 h-6 text-slate-400" />
                        </div>
                        <div>
                          <div className="flex items-center gap-2">
                            <div className="text-white font-semibold">{listing.title}</div>
                            {listing.featured && <Star className="w-4 h-4 text-yellow-400 fill-yellow-400" />}
                          </div>
                          <div className="text-sm text-gray-400 flex items-center gap-2 mt-0.5">
                            <MapPin className="w-3 h-3" />{listing.address}, {listing.city}
                          </div>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <Badge className={TYPE_COLORS[listing.type]}>{listing.type}</Badge>
                        <Badge className={STATUS_COLORS[listing.status]}>{t("admin_status_" + String(listing.status).toLowerCase())}</Badge>
                        <div className="text-white font-bold"><DollarSign className="w-4 h-4 inline" />{listing.price.toLocaleString()}</div>
                        <div className="text-sm text-gray-400">{listing.views} {t("listings.propertylistingspage.auto_ext_6", "views")}</div>
                        <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                          <Button onClick={() => setEditingItem(listing)} variant="outline" size="icon" className="h-9 w-9 bg-white/5 hover:bg-white/10 border-slate-500/30">
                            <Edit className="w-4 h-4 text-white/70" />
                          </Button>
                          <Button onClick={() => setDeletingItem(listing)} variant="outline" size="icon" className="h-9 w-9 bg-white/5 hover:bg-red-500/10 border-slate-500/30 hover:border-red-500/30 group/btn">
                            <Trash2 className="w-4 h-4 text-red-500/70 group-hover/btn:text-red-500" />
                          </Button>
                        </div>
                      </div>
                    </m.div>
                  ))}
                </AnimatePresence>
                {filteredListings.length === 0 && (
                  <div className="py-12 text-center text-slate-500">{t("admin_auto_no_results_found", "No results found")}</div>
                )}
              </div>
            </CardContent>
          </Card>
        </m.div>

        <CreateListingDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {editingItem && <EditListingDialog open={!!editingItem} onOpenChange={(open: boolean) => !open && setEditingItem(null)} item={editingItem} onSubmit={handleEdit} />}
        {deletingItem && <DeleteListingDialog open={!!deletingItem} onOpenChange={(open: boolean) => !open && setDeletingItem(null)} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />}
      </div>
    </div>
  );
}
