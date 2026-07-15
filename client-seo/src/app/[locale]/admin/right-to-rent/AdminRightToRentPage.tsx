"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  FileSearch,
  Search,
  Plus,
  UserCheck,
  Calendar,
  ArrowUpRight,
  Edit,
  Trash2,
  ShieldCheck,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface RightToRentRecord {
  id: string;
  tenantName: string;
  propertyAddress: string;
  checkDate: string;
  expiryDate: string;
  status: "VERIFIED" | "PENDING" | "EXPIRED" | "FAILED";
  documentType: string;
}

const mockRecords: RightToRentRecord[] = [
  { id: "1", tenantName: "James Wilson", propertyAddress: "123 Main St, London", checkDate: "2024-01-15", expiryDate: "2025-01-15", status: "VERIFIED", documentType: "Passport" },
  { id: "2", tenantName: "Emily Clark", propertyAddress: "456 Oak Ave, Manchester", checkDate: "2024-02-20", expiryDate: "2024-08-20", status: "PENDING", documentType: "Biometric Residency" },
  { id: "3", tenantName: "David Lee", propertyAddress: "789 Pine Rd, Birmingham", checkDate: "2023-03-10", expiryDate: "2024-03-10", status: "EXPIRED", documentType: "Visa" },
  { id: "4", tenantName: "Sarah Johnson", propertyAddress: "321 Elm St, Leeds", checkDate: "2024-04-05", expiryDate: "2025-04-05", status: "VERIFIED", documentType: "Passport" },
  { id: "5", tenantName: "Michael Brown", propertyAddress: "654 Birch Ln, Bristol", checkDate: "2024-03-01", expiryDate: "2024-09-01", status: "FAILED", documentType: "Share Code" },
];

const STATUS_COLORS: Record<string, string> = {
  VERIFIED: "bg-green-500/20 text-green-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
  EXPIRED: "bg-red-500/20 text-red-400",
  FAILED: "bg-gray-500/20 text-gray-400",
};

const STATUS_ICONS: Record<string, any> = {
  VERIFIED: ShieldCheck,
  PENDING: FileSearch,
  EXPIRED: FileSearch,
  FAILED: FileSearch,
};

export default function AdminRightToRentPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<RightToRentRecord[]>(mockRecords);
  const [editingItem, setEditingItem] = useState<RightToRentRecord | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<RightToRentRecord | null>(null);

  const filtered = items.filter(r =>
    r.tenantName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    r.propertyAddress.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<RightToRentRecord, "id">) => {
    const newItem: RightToRentRecord = { ...data, id: String(Date.now()) };
    setItems(prev => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: RightToRentRecord) => {
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
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_righttorent_title")}</h1>
              <p className="text-muted-foreground">{t("admin_righttorent_description")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_righttorent_back_to_dashboard")}
            </Button>
          </div>
        </motion.div>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
          {[
            { label: t("admin_righttorent_verified"), value: "124", color: "text-green-400", icon: ShieldCheck },
            { label: t("admin_righttorent_pending"), value: "18", color: "text-yellow-400", icon: FileSearch },
            { label: t("admin_righttorent_expired"), value: "7", color: "text-red-400", icon: FileSearch },
            { label: t("admin_righttorent_failed"), value: "3", color: "text-muted-foreground", icon: FileSearch },
          ].map((stat, idx) => (
            <motion.div key={stat.label} initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.05 * idx }}>
              <Card className="bg-card border-border">
                <CardContent className="p-4">
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="text-sm text-muted-foreground">{stat.label}</div>
                      <div className={`text-2xl font-bold ${stat.color}`}>{stat.value}</div>
                    </div>
                    <stat.icon className={`w-6 h-6 ${stat.color}`} />
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          ))}
        </div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }} className="mb-6">
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_righttorent_search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-muted/30 border-border text-foreground placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_righttorent_add_record")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.3 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <UserCheck className="w-5 h-5" />
                {t("admin_righttorent_list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((record) => {
                  const StatusIcon = STATUS_ICONS[record.status];
                  return (
                    <div key={record.id} className="flex items-center justify-between p-4 bg-muted/30 rounded-lg hover:bg-muted/50 transition-colors">
                      <div className="flex items-center gap-4">
                        <div className="w-10 h-10 rounded-full bg-muted/50 flex items-center justify-center">
                          <UserCheck className="w-5 h-5 text-muted-foreground" />
                        </div>
                        <div>
                          <div className="text-foreground font-medium">{record.tenantName}</div>
                          <div className="text-sm text-muted-foreground">{record.propertyAddress}</div>
                          <div className="text-xs text-muted-foreground/70 flex items-center gap-3 mt-1">
                            <span className="flex items-center gap-1"><Calendar className="w-3 h-3" />{t("admin_righttorent_check")}: {record.checkDate}</span>
                            <span className="flex items-center gap-1"><Calendar className="w-3 h-3" />{t("admin_righttorent_expires")}: {record.expiryDate}</span>
                            <span>{record.documentType}</span>
                          </div>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <Badge className={STATUS_COLORS[record.status]}>
                          <StatusIcon className="w-3 h-3 mr-1 inline" />
                          {record.status}
                        </Badge>
                        <div className="flex gap-2">
                          <Button onClick={() => { setEditingItem(record); setIsEditOpen(true); }} variant="ghost" size="icon" className="h-8 w-8"><Edit className="w-4 h-4" /></Button>
                          <Button onClick={() => { setDeletingItem(record); setIsDeleteOpen(true); }} variant="ghost" size="icon" className="h-8 w-8 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </CardContent>
          </Card>
        </motion.div>
        {/* Create Dialog */}
        <CreateRightToRentDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {/* Edit Dialog */}
        {editingItem && (
          <EditRightToRentDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />
        )}
        {/* Delete Dialog */}
        {deletingItem && (
          <DeleteRightToRentDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />
        )}
      </div>
    </div>
  );
}

function CreateRightToRentDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<RightToRentRecord, "id">) => void }) {
    const { t } = useTranslation();
  const [tenantName, setTenantName] = useState("");
  const [propertyAddress, setPropertyAddress] = useState("");
  const [checkDate, setCheckDate] = useState(new Date().toISOString().split("T")[0]);
  const [expiryDate, setExpiryDate] = useState("");
  const [status, setStatus] = useState<RightToRentRecord["status"]>("PENDING");
  const [documentType, setDocumentType] = useState("");
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_auto_add_right_to_rent_record", "Add Right to Rent Record")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_add_a_new_right_to_rent_check_record", "Add a new right to rent check record.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.tenant_name", "Tenant Name")}</Label>
            <Input value={tenantName} onChange={e => setTenantName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.property_address", "Property Address")}</Label>
            <Input value={propertyAddress} onChange={e => setPropertyAddress(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("mobile.admin.field_check_date", "Check Date")}</Label>
            <Input type="date" value={checkDate} onChange={e => setCheckDate(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.expiry_date", "Expiry Date")}</Label>
            <Input type="date" value={expiryDate} onChange={e => setExpiryDate(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as RightToRentRecord["status"])}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="VERIFIED">{t("admin_bookings_verification_verified", "Verified")}</SelectItem>
                <SelectItem value="PENDING">{t("admin_ai_pending", "Pending")}</SelectItem>
                <SelectItem value="EXPIRED">{t("admin_compliance_status_expired", "Expired")}</SelectItem>
                <SelectItem value="FAILED">{t("admin_ai_failed", "Failed")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_immigration_document_type", "Document Type")}</Label>
            <Input value={documentType} onChange={e => setDocumentType(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ tenantName, propertyAddress, checkDate, expiryDate, status, documentType })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditRightToRentDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: RightToRentRecord; onSubmit: (data: RightToRentRecord) => void }) {
    const { t } = useTranslation();
  const [tenantName, setTenantName] = useState(item.tenantName);
  const [propertyAddress, setPropertyAddress] = useState(item.propertyAddress);
  const [checkDate, setCheckDate] = useState(item.checkDate);
  const [expiryDate, setExpiryDate] = useState(item.expiryDate);
  const [status, setStatus] = useState<RightToRentRecord["status"]>(item.status);
  const [documentType, setDocumentType] = useState(item.documentType);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_auto_edit_right_to_rent_record", "Edit Right to Rent Record")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_update_right_to_rent_record_details", "Update right to rent record details.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.tenant_name", "Tenant Name")}</Label>
            <Input value={tenantName} onChange={e => setTenantName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.property_address", "Property Address")}</Label>
            <Input value={propertyAddress} onChange={e => setPropertyAddress(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("mobile.admin.field_check_date", "Check Date")}</Label>
            <Input type="date" value={checkDate} onChange={e => setCheckDate(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.expiry_date", "Expiry Date")}</Label>
            <Input type="date" value={expiryDate} onChange={e => setExpiryDate(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as RightToRentRecord["status"])}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="VERIFIED">{t("admin_bookings_verification_verified", "Verified")}</SelectItem>
                <SelectItem value="PENDING">{t("admin_ai_pending", "Pending")}</SelectItem>
                <SelectItem value="EXPIRED">{t("admin_compliance_status_expired", "Expired")}</SelectItem>
                <SelectItem value="FAILED">{t("admin_ai_failed", "Failed")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_immigration_document_type", "Document Type")}</Label>
            <Input value={documentType} onChange={e => setDocumentType(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ id: item.id, tenantName, propertyAddress, checkDate, expiryDate, status, documentType })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteRightToRentDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: RightToRentRecord; onConfirm: () => void }) {
    const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_auto_delete_right_to_rent_record", "Delete Right to Rent Record")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_are_you_sure_you_want_to_delete_the_reco", "Are you sure you want to delete the record for")}{item.tenantName}{t("admin_auto_this_action_cannot_be_undone", "? This action cannot be undone.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-destructive hover:bg-destructive/90">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
