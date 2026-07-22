"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Users, Search, Plus, Home, Phone, Mail, Calendar, ArrowUpRight, Edit, Trash2, AlertTriangle, Check
} from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useRouter } from "next/navigation";

interface Tenant {
  id: string;
  name: string;
  email: string;
  phone: string;
  property: string;
  leaseStart: string;
  leaseEnd: string;
  status: "ACTIVE" | "NOTICE" | "PAST_DUE" | "TERMINATED";
}

const mockTenants: Tenant[] = [
  { id: "1", name: "Alice Johnson", email: "alice@example.com", phone: "+44 7700 100001", property: "Luxury Villa", leaseStart: "2024-01-01", leaseEnd: "2025-01-01", status: "ACTIVE" },
  { id: "2", name: "Bob Williams", email: "bob@example.com", phone: "+44 7700 100002", property: "Downtown Apartment", leaseStart: "2023-06-01", leaseEnd: "2024-06-01", status: "NOTICE" },
  { id: "3", name: "Carol Martinez", email: "carol@example.com", phone: "+44 7700 100003", property: "Beachfront Condo", leaseStart: "2024-03-01", leaseEnd: "2025-03-01", status: "PAST_DUE" },
  { id: "4", name: "Daniel Taylor", email: "daniel@example.com", phone: "+44 7700 100004", property: "Studio Loft", leaseStart: "2022-09-01", leaseEnd: "2023-09-01", status: "TERMINATED" },
  { id: "5", name: "Eve Anderson", email: "eve@example.com", phone: "+44 7700 100005", property: "Penthouse Suite", leaseStart: "2024-02-01", leaseEnd: "2025-02-01", status: "ACTIVE" },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-emerald-500/10 text-emerald-500 border border-emerald-500/20",
  NOTICE: "bg-amber-500/10 text-amber-500 border border-amber-500/20",
  PAST_DUE: "bg-red-500/10 text-red-500 border border-red-500/20",
  TERMINATED: "bg-slate-500/10 text-slate-500 border border-slate-500/20",
};

// Generic Modal Container with Glassmorphism
function GlassModal({ open, onOpenChange, title, description, children, footer }: any) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">
            {title}
          </DialogTitle>
          {description && <DialogDescription>{description}</DialogDescription>}
        </DialogHeader>
        <div className="py-4 space-y-4">
          {children}
        </div>
        {footer && <DialogFooter className="pt-4 border-t border-white/10">{footer}</DialogFooter>}
      </DialogContent>
    </Dialog>
  );
}

function CreateTenantDialog({ open, onOpenChange, onSubmit }: any) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState<Omit<Tenant, "id">>({
    name: "", email: "", phone: "", property: "", leaseStart: "", leaseEnd: "", status: "ACTIVE"
  });

  return (
    <GlassModal
      open={open}
      onOpenChange={onOpenChange}
      title={t("admin_tenants_add_tenant")}
      footer={
        <div className="flex justify-end gap-2 w-full">
          <Button variant="ghost" onClick={() => onOpenChange(false)}>{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit(formData)} className="bg-primary hover:bg-primary/90 text-primary-foreground shadow-lg shadow-primary/20">
            <Check className="w-4 h-4 mr-2" />
            {t("admin_action_create", "Create")}
          </Button>
        </div>
      }
    >
      <div className="grid gap-4">
        <div className="grid gap-2">
          <Label>{t("admin_ai_name", "Name")}</Label>
          <Input value={formData.name} onChange={e => setFormData({ ...formData, name: e.target.value })} className="bg-white/5 border-white/10 focus:border-primary/50 transition-colors" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>Email</Label>
            <Input value={formData.email} onChange={e => setFormData({ ...formData, email: e.target.value })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_phone", "Phone")}</Label>
            <Input value={formData.phone} onChange={e => setFormData({ ...formData, phone: e.target.value })} className="bg-white/5 border-white/10" />
          </div>
        </div>
        <div className="grid gap-2">
          <Label>{t("admin_ai_property", "Property")}</Label>
          <Input value={formData.property} onChange={e => setFormData({ ...formData, property: e.target.value })} className="bg-white/5 border-white/10" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_ai_start_date", "Start Date")}</Label>
            <Input type="date" value={formData.leaseStart} onChange={e => setFormData({ ...formData, leaseStart: e.target.value })} className="bg-white/5 border-white/10 [&::-webkit-calendar-picker-indicator]:invert" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_end_date", "End Date")}</Label>
            <Input type="date" value={formData.leaseEnd} onChange={e => setFormData({ ...formData, leaseEnd: e.target.value })} className="bg-white/5 border-white/10 [&::-webkit-calendar-picker-indicator]:invert" />
          </div>
        </div>
        <div className="grid gap-2">
          <Label>{t("admin_ai_status", "Status")}</Label>
          <Select value={formData.status} onValueChange={(v: any) => setFormData({ ...formData, status: v })}>
            <SelectTrigger className="bg-white/5 border-white/10">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="ACTIVE">{t("admin_status_active")}</SelectItem>
              <SelectItem value="NOTICE">{t("admin_status_notice")}</SelectItem>
              <SelectItem value="PAST_DUE">{t("admin_status_past_due")}</SelectItem>
              <SelectItem value="TERMINATED">{t("admin_status_terminated")}</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>
    </GlassModal>
  );
}

function EditTenantDialog({ open, onOpenChange, item, onSubmit }: any) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState<Tenant>(item);

  return (
    <GlassModal
      open={open}
      onOpenChange={onOpenChange}
      title={t("admin_action_edit", "Edit")}
      footer={
        <div className="flex justify-end gap-2 w-full">
          <Button variant="ghost" onClick={() => onOpenChange(false)}>{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit(formData)} className="bg-primary hover:bg-primary/90 shadow-lg shadow-primary/20">
            <Check className="w-4 h-4 mr-2" />
            {t("admin_action_save", "Save")}
          </Button>
        </div>
      }
    >
      <div className="grid gap-4">
        <div className="grid gap-2">
          <Label>{t("admin_ai_name", "Name")}</Label>
          <Input value={formData.name} onChange={e => setFormData({ ...formData, name: e.target.value })} className="bg-white/5 border-white/10 focus:border-primary/50 transition-colors" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>Email</Label>
            <Input value={formData.email} onChange={e => setFormData({ ...formData, email: e.target.value })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_phone", "Phone")}</Label>
            <Input value={formData.phone} onChange={e => setFormData({ ...formData, phone: e.target.value })} className="bg-white/5 border-white/10" />
          </div>
        </div>
        <div className="grid gap-2">
          <Label>{t("admin_ai_property", "Property")}</Label>
          <Input value={formData.property} onChange={e => setFormData({ ...formData, property: e.target.value })} className="bg-white/5 border-white/10" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_ai_start_date", "Start Date")}</Label>
            <Input type="date" value={formData.leaseStart} onChange={e => setFormData({ ...formData, leaseStart: e.target.value })} className="bg-white/5 border-white/10 [&::-webkit-calendar-picker-indicator]:invert" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_end_date", "End Date")}</Label>
            <Input type="date" value={formData.leaseEnd} onChange={e => setFormData({ ...formData, leaseEnd: e.target.value })} className="bg-white/5 border-white/10 [&::-webkit-calendar-picker-indicator]:invert" />
          </div>
        </div>
        <div className="grid gap-2">
          <Label>{t("admin_ai_status", "Status")}</Label>
          <Select value={formData.status} onValueChange={(v: any) => setFormData({ ...formData, status: v })}>
            <SelectTrigger className="bg-white/5 border-white/10">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="ACTIVE">{t("admin_status_active")}</SelectItem>
              <SelectItem value="NOTICE">{t("admin_status_notice")}</SelectItem>
              <SelectItem value="PAST_DUE">{t("admin_status_past_due")}</SelectItem>
              <SelectItem value="TERMINATED">{t("admin_status_terminated")}</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </div>
    </GlassModal>
  );
}

function DeleteTenantDialog({ open, onOpenChange, item, onConfirm }: any) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-red-500/20 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2 text-red-500">
            <AlertTriangle className="w-5 h-5" />
            {t("admin_action_delete", "Delete")}
          </DialogTitle>
          <DialogDescription className="pt-2 text-foreground/80">
            {t("admin_auto_are_you_sure_you_want_to_delete", "Are you sure you want to delete")} <span className="font-bold text-foreground">{item?.name}</span>? {t("admin_auto_this_action_cannot_be_undone", "This action cannot be undone.")}
          </DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/5">
          <Button variant="ghost" onClick={() => onOpenChange(false)}>{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">
            {t("admin_action_delete", "Delete")}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

export default function AdminTenantsPage() {
  const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  
  const [items, setItems] = useState<Tenant[]>(mockTenants);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<Tenant | null>(null);
  const [deletingItem, setDeletingItem] = useState<Tenant | null>(null);

  const filtered = items.filter(tenant =>
    tenant.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    tenant.property.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<Tenant, "id">) => {
    setItems(prev => [...prev, { ...data, id: String(Date.now()) }]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: Tenant) => {
    setItems(prev => prev.map(item => item.id === updatedItem.id ? updatedItem : item));
    setEditingItem(null);
  };

  const handleDelete = (id: string) => {
    setItems(prev => prev.filter(item => item.id !== id));
    setDeletingItem(null);
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <m.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_tenants_title")}</h1>
              <p className="text-muted-foreground">{t("admin_tenants_description")}</p>
            </div>
            <Button onClick={() => router.push('/admin/dashboard')} className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_tenants_back_to_dashboard")}
            </Button>
          </div>
        </m.div>

        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="mb-6">
          <Card className="bg-card border-border shadow-sm">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_tenants_search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-muted/30 border-border text-foreground placeholder:text-muted-foreground transition-all focus:bg-muted/50"
                    />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90 shadow-md">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_tenants_add_tenant")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border shadow-sm">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Users className="w-5 h-5 text-primary" />
                {t("admin_tenants_list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <AnimatePresence>
                  {filtered.map((tenant) => (
                    <m.div 
                      key={tenant.id} 
                      layout
                      initial={{ opacity: 0, scale: 0.98 }}
                      animate={{ opacity: 1, scale: 1 }}
                      exit={{ opacity: 0, scale: 0.98 }}
                      className="flex items-center justify-between p-4 bg-muted/30 rounded-xl hover:bg-muted/50 transition-all border border-transparent hover:border-border group"
                    >
                      <div className="flex items-center gap-4">
                        <div className="w-12 h-12 rounded-full bg-gradient-to-br from-primary/20 to-primary/10 border border-primary/20 flex items-center justify-center text-primary font-bold shadow-inner">
                          {tenant.name.split(" ").map(n => n[0]).join("")}
                        </div>
                        <div>
                          <div className="text-foreground font-semibold text-lg">{tenant.name}</div>
                          <div className="text-sm text-muted-foreground flex items-center gap-2 mt-0.5">
                            <Home className="w-3.5 h-3.5" />
                            {tenant.property}
                          </div>
                          <div className="text-xs text-muted-foreground/80 flex items-center gap-4 mt-2">
                            <span className="flex items-center gap-1.5"><Mail className="w-3.5 h-3.5" />{tenant.email}</span>
                            <span className="flex items-center gap-1.5"><Phone className="w-3.5 h-3.5" />{tenant.phone}</span>
                            <span className="flex items-center gap-1.5"><Calendar className="w-3.5 h-3.5" />{tenant.leaseStart} - {tenant.leaseEnd}</span>
                          </div>
                        </div>
                      </div>
                      <div className="flex flex-col sm:flex-row items-end sm:items-center gap-4">
                        <Badge className={STATUS_COLORS[tenant.status]}>{t("admin_status_" + String(tenant.status).toLowerCase())}</Badge>
                        <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                          <Button onClick={() => setEditingItem(tenant)} variant="outline" size="icon" className="h-9 w-9 bg-background/50 hover:bg-background border-border">
                            <Edit className="w-4 h-4 text-foreground/70" />
                          </Button>
                          <Button onClick={() => setDeletingItem(tenant)} variant="outline" size="icon" className="h-9 w-9 bg-background/50 hover:bg-red-500/10 border-border hover:border-red-500/30 group/btn">
                            <Trash2 className="w-4 h-4 text-red-500/70 group-hover/btn:text-red-500" />
                          </Button>
                        </div>
                      </div>
                    </m.div>
                  ))}
                </AnimatePresence>
                {filtered.length === 0 && (
                  <div className="py-12 text-center text-muted-foreground">
                    {t("admin_auto_no_results_found", "No results found")}
                  </div>
                )}
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Modals */}
        <CreateTenantDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {editingItem && (
          <EditTenantDialog open={!!editingItem} onOpenChange={(open: boolean) => !open && setEditingItem(null)} item={editingItem} onSubmit={handleEdit} />
        )}
        {deletingItem && (
          <DeleteTenantDialog open={!!deletingItem} onOpenChange={(open: boolean) => !open && setDeletingItem(null)} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />
        )}
      </div>
    </div>
  );
}
