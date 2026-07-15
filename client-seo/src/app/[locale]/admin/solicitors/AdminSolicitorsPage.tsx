"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Scale,
  Search,
  Plus,
  Phone,
  Mail,
  Building2,
  ArrowUpRight,
  Edit,
  Trash2,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Solicitor {
  id: string;
  firmName: string;
  contactName: string;
  email: string;
  phone: string;
  specialisation: string;
  status: "ACTIVE" | "INACTIVE";
}

const mockSolicitors: Solicitor[] = [
  { id: "1", firmName: "Smith & Co Legal", contactName: "John Smith", email: "john@smithlegal.com", phone: "+44 20 7123 4567", specialisation: "Property Law", status: "ACTIVE" },
  { id: "2", firmName: "Brown & Partners", contactName: "Sarah Brown", email: "sarah@brownpartners.com", phone: "+44 20 7234 5678", specialisation: "Immigration", status: "ACTIVE" },
  { id: "3", firmName: "Wilson Legal Services", contactName: "Mike Wilson", email: "mike@wilsonlegal.com", phone: "+44 20 7345 6789", specialisation: "Corporate Law", status: "INACTIVE" },
  { id: "4", firmName: "Davis Solicitors", contactName: "Emma Davis", email: "emma@davissolicitors.com", phone: "+44 20 7456 7890", specialisation: "Tenancy Law", status: "ACTIVE" },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
};

export default function AdminSolicitorsPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<Solicitor[]>(mockSolicitors);
  const [editingItem, setEditingItem] = useState<Solicitor | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<Solicitor | null>(null);

  const filtered = items.filter(s =>
    s.firmName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.contactName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<Solicitor, "id">) => {
    const newItem: Solicitor = { ...data, id: String(Date.now()) };
    setItems(prev => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: Solicitor) => {
    setItems(prev => prev.map(item => item.id === updatedItem.id ? updatedItem : item));
    setIsEditOpen(false);
    setEditingItem(null);
  };

  const handleDelete = (id: string) => {
    setItems(prev => prev.filter(item => item.id !== id));
    setIsDeleteOpen(false);
    setDeletingItem(null);
  };

  return (
    <div className="min-h-screen bg-background">
      <div className="container mx-auto px-4 py-8">
        <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_solicitors_title")}</h1>
              <p className="text-muted-foreground">{t("admin_solicitors_description")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_solicitors_back_to_dashboard")}
            </Button>
          </div>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_solicitors_search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-muted/30 border-border text-foreground placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_solicitors_add_solicitor")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Scale className="w-5 h-5" />
                {t("admin_solicitors_list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((solicitor) => (
                  <div key={solicitor.id} className="flex items-center justify-between p-4 bg-muted/30 rounded-lg hover:bg-muted/50 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-muted/50 flex items-center justify-center">
                        <Scale className="w-5 h-5 text-muted-foreground" />
                      </div>
                      <div>
                        <div className="text-foreground font-medium">{solicitor.firmName}</div>
                        <div className="text-sm text-muted-foreground flex items-center gap-2">
                          <Building2 className="w-3 h-3" />
                          {solicitor.contactName}
                        </div>
                        <div className="text-xs text-muted-foreground/70 flex items-center gap-3 mt-1">
                          <span className="flex items-center gap-1"><Mail className="w-3 h-3" />{solicitor.email}</span>
                          <span className="flex items-center gap-1"><Phone className="w-3 h-3" />{solicitor.phone}</span>
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <span className="text-xs text-muted-foreground">{solicitor.specialisation}</span>
                      <Badge className={STATUS_COLORS[solicitor.status]}>{solicitor.status}</Badge>
                      <div className="flex gap-2">
                        <Button onClick={() => { setEditingItem(solicitor); setIsEditOpen(true); }} variant="ghost" size="icon" className="h-8 w-8"><Edit className="w-4 h-4" /></Button>
                        <Button onClick={() => { setDeletingItem(solicitor); setIsDeleteOpen(true); }} variant="ghost" size="icon" className="h-8 w-8 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>

        {/* Create Dialog */}
        <CreateSolicitorDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {/* Edit Dialog */}
        {editingItem && (
          <EditSolicitorDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />
        )}
        {/* Delete Dialog */}
        {deletingItem && (
          <DeleteSolicitorDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />
        )}
      </div>
    </div>
  );
}

function CreateSolicitorDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<Solicitor, "id">) => void }) {
    const { t } = useTranslation();
  const [firmName, setFirmName] = useState("");
  const [contactName, setContactName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [specialisation, setSpecialisation] = useState("");
  const [status, setStatus] = useState<"ACTIVE" | "INACTIVE">("ACTIVE");
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_solicitors_add_solicitor", "Add Solicitor")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_add_a_new_solicitor_firm_to_the_system", "Add a new solicitor firm to the system.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_firm_name", "Firm Name")}</Label>
            <Input value={firmName} onChange={e => setFirmName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_contact_name", "Contact Name")}</Label>
            <Input value={contactName} onChange={e => setContactName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_email", "Email")}</Label>
            <Input value={email} onChange={e => setEmail(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_phone", "Phone")}</Label>
            <Input value={phone} onChange={e => setPhone(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_specialisation", "Specialisation")}</Label>
            <Input value={specialisation} onChange={e => setSpecialisation(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as "ACTIVE" | "INACTIVE")}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="ACTIVE">{t("mobile.property_admin.active", "ACTIVE")}</SelectItem>
                <SelectItem value="INACTIVE">{t("admin_auto_inactive", "INACTIVE")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ firmName, contactName, email, phone, specialisation, status })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditSolicitorDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: Solicitor; onSubmit: (data: Solicitor) => void }) {
    const { t } = useTranslation();
  const [firmName, setFirmName] = useState(item.firmName);
  const [contactName, setContactName] = useState(item.contactName);
  const [email, setEmail] = useState(item.email);
  const [phone, setPhone] = useState(item.phone);
  const [specialisation, setSpecialisation] = useState(item.specialisation);
  const [status, setStatus] = useState<"ACTIVE" | "INACTIVE">(item.status);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_auto_edit_solicitor", "Edit Solicitor")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_update_solicitor_details", "Update solicitor details.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_firm_name", "Firm Name")}</Label>
            <Input value={firmName} onChange={e => setFirmName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_contact_name", "Contact Name")}</Label>
            <Input value={contactName} onChange={e => setContactName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_email", "Email")}</Label>
            <Input value={email} onChange={e => setEmail(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_phone", "Phone")}</Label>
            <Input value={phone} onChange={e => setPhone(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_specialisation", "Specialisation")}</Label>
            <Input value={specialisation} onChange={e => setSpecialisation(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as "ACTIVE" | "INACTIVE")}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="ACTIVE">{t("mobile.property_admin.active", "ACTIVE")}</SelectItem>
                <SelectItem value="INACTIVE">{t("admin_auto_inactive", "INACTIVE")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ id: item.id, firmName, contactName, email, phone, specialisation, status })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteSolicitorDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: Solicitor; onConfirm: () => void }) {
    const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_auto_delete_solicitor", "Delete Solicitor")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_are_you_sure_you_want_to_delete", "Are you sure you want to delete")}{item.firmName}{t("admin_auto_this_action_cannot_be_undone", "? This action cannot be undone.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-destructive hover:bg-destructive/90">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
