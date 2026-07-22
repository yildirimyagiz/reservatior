"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { 
  Building2, Search, Plus, Edit, Trash2, ArrowUpRight, MapPin, Bed, Bath, DollarSign, Check, AlertTriangle
} from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Property {
  id: string;
  name: string;
  type: string;
  address: string;
  city: string;
  price: number;
  bedrooms: number;
  bathrooms: number;
  area: number;
  status: "AVAILABLE" | "RENTED" | "MAINTENANCE";
}

const mockProperties: Property[] = [
  { id: "1", name: "Luxury Villa", type: "VILLA", address: "123 Palm Beach Dr", city: "Miami", price: 1250000, bedrooms: 5, bathrooms: 4, area: 450, status: "AVAILABLE" },
  { id: "2", name: "Downtown Apartment", type: "APARTMENT", address: "456 Broadway", city: "New York", price: 4500, bedrooms: 2, bathrooms: 2, area: 120, status: "RENTED" },
  { id: "3", name: "Beachfront Condo", type: "CONDO", address: "789 Ocean Blvd", city: "Los Angeles", price: 890000, bedrooms: 3, bathrooms: 2, area: 180, status: "AVAILABLE" },
  { id: "4", name: "Studio Loft", type: "STUDIO", address: "321 Arts District", city: "San Francisco", price: 1800, bedrooms: 1, bathrooms: 1, area: 65, status: "MAINTENANCE" }
];

const STATUS_COLORS: Record<string, string> = {
  AVAILABLE: "bg-emerald-500/10 text-emerald-400 border border-emerald-500/20",
  RENTED: "bg-slate-500/10 text-slate-400 border border-slate-500/20",
  MAINTENANCE: "bg-amber-500/10 text-amber-400 border border-amber-500/20"
};

function GlassModal({ open, onOpenChange, title, description, children, footer }: any) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[480px] bg-slate-900/90 backdrop-blur-xl border border-white/10 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-white to-white/70">{title}</DialogTitle>
          {description && <DialogDescription className="text-slate-400">{description}</DialogDescription>}
        </DialogHeader>
        <div className="py-4 space-y-4">{children}</div>
        {footer && <DialogFooter className="pt-4 border-t border-white/10">{footer}</DialogFooter>}
      </DialogContent>
    </Dialog>
  );
}

function CreatePropertyDialog({ open, onOpenChange, onSubmit }: any) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState<Omit<Property, "id">>({
    name: "", type: "APARTMENT", address: "", city: "", price: 0, bedrooms: 1, bathrooms: 1, area: 0, status: "AVAILABLE"
  });

  return (
    <GlassModal open={open} onOpenChange={onOpenChange} title={t("admin_properties_management_add_property")}
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
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_ai_name", "Name")}</Label>
            <Input value={formData.name} onChange={e => setFormData({ ...formData, name: e.target.value })} className="bg-white/5 border-white/10 focus:border-primary/50" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_type", "Type")}</Label>
            <Select value={formData.type} onValueChange={(v: any) => setFormData({ ...formData, type: v })}>
              <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
              <SelectContent>
                <SelectItem value="VILLA">Villa</SelectItem>
                <SelectItem value="APARTMENT">Apartment</SelectItem>
                <SelectItem value="CONDO">Condo</SelectItem>
                <SelectItem value="STUDIO">Studio</SelectItem>
              </SelectContent>
            </Select>
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
            <Label>{t("admin_auto_amount", "Price")}</Label>
            <Input type="number" value={formData.price} onChange={e => setFormData({ ...formData, price: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
        </div>
        <div className="grid grid-cols-3 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_auto_bedrooms", "Bedrooms")}</Label>
            <Input type="number" value={formData.bedrooms} onChange={e => setFormData({ ...formData, bedrooms: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_auto_bathrooms", "Bathrooms")}</Label>
            <Input type="number" value={formData.bathrooms} onChange={e => setFormData({ ...formData, bathrooms: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_properties_management_sqft_label", "m²")}</Label>
            <Input type="number" value={formData.area} onChange={e => setFormData({ ...formData, area: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
        </div>
        <div className="grid gap-2">
          <Label>{t("admin_ai_status", "Status")}</Label>
          <Select value={formData.status} onValueChange={(v: any) => setFormData({ ...formData, status: v })}>
            <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
            <SelectContent>
              <SelectItem value="AVAILABLE">{t("admin_status_available")}</SelectItem>
              <SelectItem value="RENTED">{t("admin_status_rented")}</SelectItem>
              <SelectItem value="MAINTENANCE">{t("admin_status_maintenance")}</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>
    </GlassModal>
  );
}

function EditPropertyDialog({ open, onOpenChange, item, onSubmit }: any) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState<Property>(item);

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
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_ai_name", "Name")}</Label>
            <Input value={formData.name} onChange={e => setFormData({ ...formData, name: e.target.value })} className="bg-white/5 border-white/10 focus:border-primary/50" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_type", "Type")}</Label>
            <Select value={formData.type} onValueChange={(v: any) => setFormData({ ...formData, type: v })}>
              <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
              <SelectContent>
                <SelectItem value="VILLA">Villa</SelectItem>
                <SelectItem value="APARTMENT">Apartment</SelectItem>
                <SelectItem value="CONDO">Condo</SelectItem>
                <SelectItem value="STUDIO">Studio</SelectItem>
              </SelectContent>
            </Select>
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
            <Label>{t("admin_auto_amount", "Price")}</Label>
            <Input type="number" value={formData.price} onChange={e => setFormData({ ...formData, price: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
        </div>
        <div className="grid grid-cols-3 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_auto_bedrooms", "Bedrooms")}</Label>
            <Input type="number" value={formData.bedrooms} onChange={e => setFormData({ ...formData, bedrooms: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_auto_bathrooms", "Bathrooms")}</Label>
            <Input type="number" value={formData.bathrooms} onChange={e => setFormData({ ...formData, bathrooms: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_properties_management_sqft_label", "m²")}</Label>
            <Input type="number" value={formData.area} onChange={e => setFormData({ ...formData, area: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
        </div>
        <div className="grid gap-2">
          <Label>{t("admin_ai_status", "Status")}</Label>
          <Select value={formData.status} onValueChange={(v: any) => setFormData({ ...formData, status: v })}>
            <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
            <SelectContent>
              <SelectItem value="AVAILABLE">{t("admin_status_available")}</SelectItem>
              <SelectItem value="RENTED">{t("admin_status_rented")}</SelectItem>
              <SelectItem value="MAINTENANCE">{t("admin_status_maintenance")}</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>
    </GlassModal>
  );
}

function DeletePropertyDialog({ open, onOpenChange, item, onConfirm }: any) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-slate-900/90 backdrop-blur-xl border border-red-500/20 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2 text-red-500">
            <AlertTriangle className="w-5 h-5" />{t("admin_action_delete", "Delete")}
          </DialogTitle>
          <DialogDescription className="pt-2 text-slate-300">
            {t("admin_auto_are_you_sure_you_want_to_delete", "Are you sure you want to delete")} <span className="font-bold text-white">{item?.name}</span>? {t("admin_auto_this_action_cannot_be_undone", "This action cannot be undone.")}
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

export default function PropertyManagementPage() {
  const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<Property[]>(mockProperties);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<Property | null>(null);
  const [deletingItem, setDeletingItem] = useState<Property | null>(null);

  const filteredProperties = items.filter(property => 
    property.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    property.city.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<Property, "id">) => {
    setItems(prev => [...prev, { ...data, id: String(Date.now()) }]);
    setIsCreateOpen(false);
  };
  const handleEdit = (updatedItem: Property) => {
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
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin_properties_management_title")}</h1>
              <p className="text-gray-400">{t("admin_properties_management_description")}</p>
            </div>
            <Button onClick={() => router.push('/admin/dashboard')} className="bg-slate-600 hover:bg-slate-700">
              <ArrowUpRight className="w-4 h-4 mr-2" />{t("admin_properties_management_back_to_dashboard")}
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
                    <Input placeholder={t("admin_properties_management_search_placeholder")} value={searchTerm} onChange={(e) => setSearchTerm(e.target.value)} className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400" />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90 shadow-md">
                  <Plus className="w-4 h-4 mr-2" />{t("admin_properties_management_add_property")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <AnimatePresence>
              {filteredProperties.map((property) => (
                <m.div key={property.id} layout initial={{ opacity: 0, scale: 0.95 }} animate={{ opacity: 1, scale: 1 }} exit={{ opacity: 0, scale: 0.95 }}>
                  <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20 hover:border-slate-500/40 transition-all group">
                    <CardHeader>
                      <div className="flex items-start justify-between mb-2">
                        <Badge className={STATUS_COLORS[property.status]}>{t("admin_status_" + String(property.status).toLowerCase())}</Badge>
                        <Badge variant="outline" className="border-slate-500/30 text-slate-300">{property.type}</Badge>
                      </div>
                      <CardTitle className="text-white">{property.name}</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-4">
                      <div className="flex items-center gap-2 text-gray-400">
                        <MapPin className="w-4 h-4" />
                        <span className="text-sm">{property.address}, {property.city}</span>
                      </div>
                      <div className="flex items-center gap-4 text-sm">
                        <div className="flex items-center gap-1 text-white"><Bed className="w-4 h-4" /><span>{property.bedrooms}</span></div>
                        <div className="flex items-center gap-1 text-white"><Bath className="w-4 h-4" /><span>{property.bathrooms}</span></div>
                        <div className="flex items-center gap-1 text-white"><Building2 className="w-4 h-4" /><span>{property.area} {t("admin_properties_management_sqft_label")}</span></div>
                      </div>
                      <div className="pt-4 border-t border-slate-500/20">
                        <div className="flex items-center justify-between">
                          <div className="text-xl font-bold text-white"><DollarSign className="w-4 h-4 inline" />{property.price.toLocaleString()}</div>
                          <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                            <Button onClick={() => setEditingItem(property)} variant="outline" size="icon" className="h-9 w-9 bg-white/5 hover:bg-white/10 border-slate-500/30">
                              <Edit className="w-4 h-4 text-white/70" />
                            </Button>
                            <Button onClick={() => setDeletingItem(property)} variant="outline" size="icon" className="h-9 w-9 bg-white/5 hover:bg-red-500/10 border-slate-500/30 hover:border-red-500/30 group/btn">
                              <Trash2 className="w-4 h-4 text-red-500/70 group-hover/btn:text-red-500" />
                            </Button>
                          </div>
                        </div>
                      </div>
                    </CardContent>
                  </Card>
                </m.div>
              ))}
            </AnimatePresence>
          </div>
          {filteredProperties.length === 0 && (
            <div className="py-12 text-center text-slate-500">{t("admin_auto_no_results_found", "No results found")}</div>
          )}
        </m.div>

        <CreatePropertyDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {editingItem && <EditPropertyDialog open={!!editingItem} onOpenChange={(open: boolean) => !open && setEditingItem(null)} item={editingItem} onSubmit={handleEdit} />}
        {deletingItem && <DeletePropertyDialog open={!!deletingItem} onOpenChange={(open: boolean) => !open && setDeletingItem(null)} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />}
      </div>
    </div>
  );
}
