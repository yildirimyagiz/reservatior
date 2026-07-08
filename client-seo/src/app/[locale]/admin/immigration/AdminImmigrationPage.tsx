"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  Search,
  Plus,
  FileText,
  Calendar,
  ArrowUpRight,
  Edit,
  Trash2,
  FolderOpen,
  Clock,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface DocumentRecord {
  id: string;
  clientName: string;
  documentType: string;
  status: "PENDING" | "RECEIVED" | "VERIFIED" | "EXPIRED" | "REJECTED";
  uploadDate: string;
}

const mockDocuments: DocumentRecord[] = [
  { id: "1", clientName: "Ahmet Yılmaz", documentType: "Pasaport", status: "VERIFIED", uploadDate: "2024-03-15" },
  { id: "2", clientName: "Zeynep Kaya", documentType: "Vize", status: "PENDING", uploadDate: "2024-06-10" },
  { id: "3", clientName: "Mehmet Demir", documentType: "İkamet İzni", status: "RECEIVED", uploadDate: "2024-05-20" },
  { id: "4", clientName: "Ayşe Çelik", documentType: "Kimlik", status: "EXPIRED", uploadDate: "2023-01-10" },
  { id: "5", clientName: "Ali Öztürk", documentType: "Tapu", status: "VERIFIED", uploadDate: "2024-04-05" },
];

const STATUS_COLORS: Record<string, string> = {
  PENDING: "bg-yellow-500/20 text-yellow-400",
  RECEIVED: "bg-blue-500/20 text-blue-400",
  VERIFIED: "bg-green-500/20 text-green-400",
  EXPIRED: "bg-red-500/20 text-red-400",
  REJECTED: "bg-slate-500/20 text-slate-400",
};

export default function AdminImmigrationPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<DocumentRecord[]>(mockDocuments);
  const [editingItem, setEditingItem] = useState<DocumentRecord | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<DocumentRecord | null>(null);

  const filtered = items.filter(d =>
    d.clientName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    d.documentType.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<DocumentRecord, "id">) => {
    const newItem: DocumentRecord = { ...data, id: String(Date.now()) };
    setItems(prev => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: DocumentRecord) => {
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
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_immigration_title")}</h1>
              <p className="text-muted-foreground">{t("admin_immigration_description")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_immigration_back_to_dashboard")}
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
                      placeholder={t("admin_immigration_search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-muted/30 border-border text-foreground placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_immigration_add_case")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <FolderOpen className="w-5 h-5" />
                {t("admin_immigration_list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((doc) => (
                  <div key={doc.id} className="flex items-center justify-between p-4 bg-muted/30 rounded-lg hover:bg-muted/50 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-muted/50 flex items-center justify-center">
                        <FileText className="w-5 h-5 text-muted-foreground" />
                      </div>
                      <div>
                        <div className="text-foreground font-medium">{doc.clientName}</div>
                        <div className="text-sm text-muted-foreground flex items-center gap-2">
                          <FolderOpen className="w-3 h-3" />
                          {doc.documentType}
                        </div>
                        <div className="text-xs text-muted-foreground/70 flex items-center gap-1 mt-1">
                          <Calendar className="w-3 h-3" />
                          {doc.uploadDate}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <Badge className={STATUS_COLORS[doc.status]}>{t("admin_immigration_status_" + doc.status.toLowerCase())}</Badge>
                      <div className="flex gap-2">
                        <Button onClick={() => { setEditingItem(doc); setIsEditOpen(true); }} variant="ghost" size="icon" className="h-8 w-8"><Edit className="w-4 h-4" /></Button>
                        <Button onClick={() => { setDeletingItem(doc); setIsDeleteOpen(true); }} variant="ghost" size="icon" className="h-8 w-8 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>
        {/* Create Dialog */}
        <CreateDocumentDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {/* Edit Dialog */}
        {editingItem && (
          <EditDocumentDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />
        )}
        {/* Delete Dialog */}
        {deletingItem && (
          <DeleteDocumentDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />
        )}
      </div>
    </div>
  );
}

function CreateDocumentDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<DocumentRecord, "id">) => void }) {
  const [clientName, setClientName] = useState("");
  const [documentType, setDocumentType] = useState("");
  const [status, setStatus] = useState<DocumentRecord["status"]>("PENDING");
  const [uploadDate, setUploadDate] = useState(new Date().toISOString().split("T")[0]);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_immigration_add_document")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_immigration_add_document_desc")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_immigration_client_name")}</Label>
            <Input value={clientName} onChange={e => setClientName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_immigration_document_type")}</Label>
            <Input value={documentType} onChange={e => setDocumentType(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_immigration_status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as DocumentRecord["status"])}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="PENDING">{t("admin_immigration_status_pending")}</SelectItem>
                <SelectItem value="RECEIVED">{t("admin_immigration_status_received")}</SelectItem>
                <SelectItem value="VERIFIED">{t("admin_immigration_status_verified")}</SelectItem>
                <SelectItem value="EXPIRED">{t("admin_immigration_status_expired")}</SelectItem>
                <SelectItem value="REJECTED">{t("admin_immigration_status_rejected")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_immigration_upload_date")}</Label>
            <Input type="date" value={uploadDate} onChange={e => setUploadDate(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_immigration_cancel")}</Button>
          <Button onClick={() => onSubmit({ clientName, documentType, status, uploadDate })} className="bg-primary hover:bg-primary/90">{t("admin_immigration_create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditDocumentDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: DocumentRecord; onSubmit: (data: DocumentRecord) => void }) {
  const [clientName, setClientName] = useState(item.clientName);
  const [documentType, setDocumentType] = useState(item.documentType);
  const [status, setStatus] = useState<DocumentRecord["status"]>(item.status);
  const [uploadDate, setUploadDate] = useState(item.uploadDate);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_immigration_edit_document")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_immigration_edit_document_desc")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_immigration_client_name")}</Label>
            <Input value={clientName} onChange={e => setClientName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_immigration_document_type")}</Label>
            <Input value={documentType} onChange={e => setDocumentType(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_immigration_status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as DocumentRecord["status"])}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="PENDING">{t("admin_immigration_status_pending")}</SelectItem>
                <SelectItem value="RECEIVED">{t("admin_immigration_status_received")}</SelectItem>
                <SelectItem value="VERIFIED">{t("admin_immigration_status_verified")}</SelectItem>
                <SelectItem value="EXPIRED">{t("admin_immigration_status_expired")}</SelectItem>
                <SelectItem value="REJECTED">{t("admin_immigration_status_rejected")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_immigration_upload_date")}</Label>
            <Input type="date" value={uploadDate} onChange={e => setUploadDate(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_immigration_cancel")}</Button>
          <Button onClick={() => onSubmit({ id: item.id, clientName, documentType, status, uploadDate })} className="bg-primary hover:bg-primary/90">{t("admin_immigration_save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteDocumentDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: DocumentRecord; onConfirm: () => void }) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_immigration_delete_document")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_immigration_delete_document_desc", { clientName: item.clientName })}</DialogDescription>
        </DialogHeader>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_immigration_cancel")}</Button>
          <Button onClick={onConfirm} className="bg-destructive hover:bg-destructive/90">{t("admin_immigration_delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
