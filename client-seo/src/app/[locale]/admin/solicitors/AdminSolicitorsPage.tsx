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
  solicitorFirm: string;
  solicitorName: string;
  solicitorEmail: string;
  solicitorPhone?: string;
  solicitorType: "LOCAL_LEGAL_COUNSEL" | "TENANT_INTERNATIONAL_LAWYER" | "LANDLORD_REPRESENTATIVE";
  status: "ENGAGED" | "VERIFIED" | "DISPUTE_OPEN" | "COMPLETED" | "TERMINATED";
  countryCode: string;
  barRegistrationNo: string;
  legalNoticeAddress: string;
  referredByAgencyId?: string;
  appointmentType?: string;
  appointmentDate?: string;
  completionDate?: string;
}

const mockSolicitors: Solicitor[] = [
  { 
    id: "1", 
    solicitorFirm: "Smith & Co Legal", 
    solicitorName: "John Smith", 
    solicitorEmail: "john@smithlegal.com", 
    solicitorPhone: "+44 20 7123 4567", 
    solicitorType: "TENANT_INTERNATIONAL_LAWYER",
    status: "VERIFIED",
    countryCode: "GB",
    barRegistrationNo: "BAR-GB-12345",
    legalNoticeAddress: "123 Legal Street, London, UK",
    appointmentType: "INITIAL_CONSULTATION",
    appointmentDate: "2026-08-01"
  },
  { 
    id: "2", 
    solicitorFirm: "Brown & Partners", 
    solicitorName: "Sarah Brown", 
    solicitorEmail: "sarah@brownpartners.com", 
    solicitorPhone: "+44 20 7234 5678", 
    solicitorType: "LOCAL_LEGAL_COUNSEL",
    status: "ENGAGED",
    countryCode: "TR",
    barRegistrationNo: "BAR-TR-67890",
    legalNoticeAddress: "456 Hukuk Caddesi, Istanbul, Turkey",
    appointmentType: "EXCHANGE",
    appointmentDate: "2026-07-25"
  },
  { 
    id: "3", 
    solicitorFirm: "Wilson Legal Services", 
    solicitorName: "Mike Wilson", 
    solicitorEmail: "mike@wilsonlegal.com", 
    solicitorPhone: "+44 20 7345 6789", 
    solicitorType: "LANDLORD_REPRESENTATIVE",
    status: "DISPUTE_OPEN",
    countryCode: "US",
    barRegistrationNo: "BAR-US-11111",
    legalNoticeAddress: "789 Court Avenue, New York, USA",
    appointmentType: "COMPLETION",
    completionDate: "2026-09-15"
  },
  { 
    id: "4", 
    solicitorFirm: "Davis Solicitors", 
    solicitorName: "Emma Davis", 
    solicitorEmail: "emma@davissolicitors.com", 
    solicitorPhone: "+44 20 7456 7890", 
    solicitorType: "TENANT_INTERNATIONAL_LAWYER",
    status: "COMPLETED",
    countryCode: "DE",
    barRegistrationNo: "BAR-DE-22222",
    legalNoticeAddress: "321 Rechtsstraße, Berlin, Germany",
    referredByAgencyId: "agency-001",
    appointmentType: "COMPLETION",
    completionDate: "2026-06-30"
  },
];

const STATUS_COLORS: Record<string, string> = {
  ENGAGED: "bg-blue-500/20 text-blue-400",
  VERIFIED: "bg-green-500/20 text-green-400",
  DISPUTE_OPEN: "bg-red-500/20 text-red-400",
  COMPLETED: "bg-emerald-500/20 text-emerald-400",
  TERMINATED: "bg-gray-500/20 text-gray-400",
};

const SOLICITOR_TYPE_COLORS: Record<string, string> = {
  LOCAL_LEGAL_COUNSEL: "bg-purple-500/20 text-purple-400",
  TENANT_INTERNATIONAL_LAWYER: "bg-orange-500/20 text-orange-400",
  LANDLORD_REPRESENTATIVE: "bg-cyan-500/20 text-cyan-400",
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
    s.solicitorFirm.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.solicitorName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.countryCode.toLowerCase().includes(searchTerm.toLowerCase()) ||
    s.barRegistrationNo.toLowerCase().includes(searchTerm.toLowerCase())
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
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
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
                        <div className="text-foreground font-medium">{solicitor.solicitorFirm}</div>
                        <div className="text-sm text-muted-foreground flex items-center gap-2">
                          <Building2 className="w-3 h-3" />
                          {solicitor.solicitorName}
                        </div>
                        <div className="text-xs text-muted-foreground/70 flex items-center gap-3 mt-1">
                          <span className="flex items-center gap-1"><Mail className="w-3 h-3" />{solicitor.solicitorEmail}</span>
                          <span className="flex items-center gap-1"><Phone className="w-3 h-3" />{solicitor.solicitorPhone}</span>
                          <span className="flex items-center gap-1">🌍 {solicitor.countryCode}</span>
                        </div>
                        <div className="text-xs text-muted-foreground/50 mt-1">
                          Bar: {solicitor.barRegistrationNo}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <Badge className={SOLICITOR_TYPE_COLORS[solicitor.solicitorType]}>{solicitor.solicitorType.replace(/_/g, ' ')}</Badge>
                      <Badge className={STATUS_COLORS[solicitor.status]}>{solicitor.status.replace(/_/g, ' ')}</Badge>
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
  const [solicitorFirm, setSolicitorFirm] = useState("");
  const [solicitorName, setSolicitorName] = useState("");
  const [solicitorEmail, setSolicitorEmail] = useState("");
  const [solicitorPhone, setSolicitorPhone] = useState("");
  const [solicitorType, setSolicitorType] = useState<"LOCAL_LEGAL_COUNSEL" | "TENANT_INTERNATIONAL_LAWYER" | "LANDLORD_REPRESENTATIVE">("TENANT_INTERNATIONAL_LAWYER");
  const [status, setStatus] = useState<"ENGAGED" | "VERIFIED" | "DISPUTE_OPEN" | "COMPLETED" | "TERMINATED">("ENGAGED");
  const [countryCode, setCountryCode] = useState("");
  const [barRegistrationNo, setBarRegistrationNo] = useState("");
  const [legalNoticeAddress, setLegalNoticeAddress] = useState("");
  const [appointmentType, setAppointmentType] = useState("INITIAL_CONSULTATION");
  
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_solicitors_add_solicitor", "Add Solicitor")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_add_a_new_solicitor_firm_to_the_system", "Add a new solicitor firm to the system.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_firm_name", "Firm Name")}</Label>
            <Input value={solicitorFirm} onChange={e => setSolicitorFirm(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_contact_name", "Contact Name")}</Label>
            <Input value={solicitorName} onChange={e => setSolicitorName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_email", "Email")}</Label>
            <Input value={solicitorEmail} onChange={e => setSolicitorEmail(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_phone", "Phone")}</Label>
            <Input value={solicitorPhone} onChange={e => setSolicitorPhone(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Solicitor Type</Label>
            <Select value={solicitorType} onValueChange={v => setSolicitorType(v as "LOCAL_LEGAL_COUNSEL" | "TENANT_INTERNATIONAL_LAWYER" | "LANDLORD_REPRESENTATIVE")}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="LOCAL_LEGAL_COUNSEL">Local Legal Counsel</SelectItem>
                <SelectItem value="TENANT_INTERNATIONAL_LAWYER">Tenant International Lawyer</SelectItem>
                <SelectItem value="LANDLORD_REPRESENTATIVE">Landlord Representative</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Country Code</Label>
            <Input value={countryCode} onChange={e => setCountryCode(e.target.value)} placeholder="GB, TR, US, DE" className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Bar Registration No</Label>
            <Input value={barRegistrationNo} onChange={e => setBarRegistrationNo(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Legal Notice Address</Label>
            <Input value={legalNoticeAddress} onChange={e => setLegalNoticeAddress(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Appointment Type</Label>
            <Select value={appointmentType} onValueChange={setAppointmentType}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="INITIAL_CONSULTATION">Initial Consultation</SelectItem>
                <SelectItem value="EXCHANGE">Exchange</SelectItem>
                <SelectItem value="COMPLETION">Completion</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as "ENGAGED" | "VERIFIED" | "DISPUTE_OPEN" | "COMPLETED" | "TERMINATED")}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="ENGAGED">Engaged</SelectItem>
                <SelectItem value="VERIFIED">Verified</SelectItem>
                <SelectItem value="DISPUTE_OPEN">Dispute Open</SelectItem>
                <SelectItem value="COMPLETED">Completed</SelectItem>
                <SelectItem value="TERMINATED">Terminated</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ 
            solicitorFirm, solicitorName, solicitorEmail, solicitorPhone, 
            solicitorType, status, countryCode, barRegistrationNo, legalNoticeAddress, 
            appointmentType 
          })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditSolicitorDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: Solicitor; onSubmit: (data: Solicitor) => void }) {
    const { t } = useTranslation();
  const [solicitorFirm, setSolicitorFirm] = useState(item.solicitorFirm);
  const [solicitorName, setSolicitorName] = useState(item.solicitorName);
  const [solicitorEmail, setSolicitorEmail] = useState(item.solicitorEmail);
  const [solicitorPhone, setSolicitorPhone] = useState(item.solicitorPhone || "");
  const [solicitorType, setSolicitorType] = useState<"LOCAL_LEGAL_COUNSEL" | "TENANT_INTERNATIONAL_LAWYER" | "LANDLORD_REPRESENTATIVE">(item.solicitorType);
  const [status, setStatus] = useState<"ENGAGED" | "VERIFIED" | "DISPUTE_OPEN" | "COMPLETED" | "TERMINATED">(item.status);
  const [countryCode, setCountryCode] = useState(item.countryCode);
  const [barRegistrationNo, setBarRegistrationNo] = useState(item.barRegistrationNo);
  const [legalNoticeAddress, setLegalNoticeAddress] = useState(item.legalNoticeAddress);
  const [appointmentType, setAppointmentType] = useState(item.appointmentType || "INITIAL_CONSULTATION");
  
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[600px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_auto_edit_solicitor", "Edit Solicitor")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_update_solicitor_details", "Update solicitor details.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_firm_name", "Firm Name")}</Label>
            <Input value={solicitorFirm} onChange={e => setSolicitorFirm(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_contact_name", "Contact Name")}</Label>
            <Input value={solicitorName} onChange={e => setSolicitorName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_email", "Email")}</Label>
            <Input value={solicitorEmail} onChange={e => setSolicitorEmail(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_phone", "Phone")}</Label>
            <Input value={solicitorPhone} onChange={e => setSolicitorPhone(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Solicitor Type</Label>
            <Select value={solicitorType} onValueChange={v => setSolicitorType(v as "LOCAL_LEGAL_COUNSEL" | "TENANT_INTERNATIONAL_LAWYER" | "LANDLORD_REPRESENTATIVE")}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="LOCAL_LEGAL_COUNSEL">Local Legal Counsel</SelectItem>
                <SelectItem value="TENANT_INTERNATIONAL_LAWYER">Tenant International Lawyer</SelectItem>
                <SelectItem value="LANDLORD_REPRESENTATIVE">Landlord Representative</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Country Code</Label>
            <Input value={countryCode} onChange={e => setCountryCode(e.target.value)} placeholder="GB, TR, US, DE" className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Bar Registration No</Label>
            <Input value={barRegistrationNo} onChange={e => setBarRegistrationNo(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Legal Notice Address</Label>
            <Input value={legalNoticeAddress} onChange={e => setLegalNoticeAddress(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Appointment Type</Label>
            <Select value={appointmentType} onValueChange={setAppointmentType}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="INITIAL_CONSULTATION">Initial Consultation</SelectItem>
                <SelectItem value="EXCHANGE">Exchange</SelectItem>
                <SelectItem value="COMPLETION">Completion</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as "ENGAGED" | "VERIFIED" | "DISPUTE_OPEN" | "COMPLETED" | "TERMINATED")}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="ENGAGED">Engaged</SelectItem>
                <SelectItem value="VERIFIED">Verified</SelectItem>
                <SelectItem value="DISPUTE_OPEN">Dispute Open</SelectItem>
                <SelectItem value="COMPLETED">Completed</SelectItem>
                <SelectItem value="TERMINATED">Terminated</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ 
            id: item.id, 
            solicitorFirm, solicitorName, solicitorEmail, solicitorPhone, 
            solicitorType, status, countryCode, barRegistrationNo, legalNoticeAddress, 
            appointmentType,
            referredByAgencyId: item.referredByAgencyId,
            appointmentDate: item.appointmentDate,
            completionDate: item.completionDate
          })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteSolicitorDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: Solicitor; onConfirm: () => void }) {
    const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_auto_delete_solicitor", "Delete Solicitor")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_are_you_sure_you_want_to_delete", "Are you sure you want to delete")}{item.solicitorFirm}{t("admin_auto_this_action_cannot_be_undone", "? This action cannot be undone.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
