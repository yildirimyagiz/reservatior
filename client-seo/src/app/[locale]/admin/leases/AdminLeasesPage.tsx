"use client";

import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import {
  FileText,
  Search,
  Plus,
  Home,
  User,
  Calendar,
  DollarSign,
  ArrowUpRight,
  Edit,
  Trash2,
  Clock,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Lease {
  id: string;
  tenantName: string;
  propertyName: string;
  startDate: string;
  endDate: string;
  monthlyRent: number;
  status: "ACTIVE" | "EXPIRING" | "EXPIRED" | "DRAFT";
}

const mockLeases: Lease[] = [
  { id: "1", tenantName: "Alice Johnson", propertyName: "Luxury Villa", startDate: "2024-01-01", endDate: "2025-01-01", monthlyRent: 2500, status: "ACTIVE" },
  { id: "2", tenantName: "Bob Williams", propertyName: "Downtown Apartment", startDate: "2023-06-01", endDate: "2024-06-01", monthlyRent: 1200, status: "EXPIRING" },
  { id: "3", tenantName: "Carol Martinez", propertyName: "Beachfront Condo", startDate: "2022-03-01", endDate: "2023-03-01", monthlyRent: 1800, status: "EXPIRED" },
  { id: "4", tenantName: "David Lee", propertyName: "Studio Loft", startDate: "2024-04-01", endDate: "2025-04-01", monthlyRent: 900, status: "DRAFT" },
  { id: "5", tenantName: "Eve Anderson", propertyName: "Penthouse Suite", startDate: "2024-02-01", endDate: "2025-02-01", monthlyRent: 3500, status: "ACTIVE" },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  EXPIRING: "bg-yellow-500/20 text-yellow-400",
  EXPIRED: "bg-red-500/20 text-red-400",
  DRAFT: "bg-slate-500/20 text-slate-400",
};

export default function AdminLeasesPage() {
  const { t } = useTranslation();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<Lease[]>(mockLeases);
  const [editingItem, setEditingItem] = useState<Lease | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<Lease | null>(null);

  const filtered = items.filter(lease =>
    lease.tenantName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    lease.propertyName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<Lease, "id">) => {
    const newItem: Lease = { ...data, id: String(Date.now()) };
    setItems(prev => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: Lease) => {
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
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_leases_title")}</h1>
              <p className="text-muted-foreground">{t("admin_leases_description")}</p>
            </div>
            <Button className="bg-primary hover:bg-primary/90">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_leases_back_to_dashboard")}
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
                      placeholder={t("admin_leases_search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-muted/30 border-border text-foreground placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_leases_add_lease")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <FileText className="w-5 h-5" />
                {t("admin_leases_list_title")} ({filtered.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filtered.map((lease) => (
                  <div key={lease.id} className="flex items-center justify-between p-4 bg-muted/30 rounded-lg hover:bg-muted/50 transition-colors">
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-muted/50 flex items-center justify-center">
                        <FileText className="w-5 h-5 text-muted-foreground" />
                      </div>
                      <div>
                        <div className="text-foreground font-medium">{lease.propertyName}</div>
                        <div className="text-sm text-muted-foreground flex items-center gap-2">
                          <User className="w-3 h-3" />
                          {lease.tenantName}
                        </div>
                        <div className="text-xs text-muted-foreground/70 flex items-center gap-3 mt-1">
                          <span className="flex items-center gap-1"><Calendar className="w-3 h-3" />{lease.startDate} - {lease.endDate}</span>
                          <span className="flex items-center gap-1"><Clock className="w-3 h-3" />{
                            t("admin.leases.days_remaining", { days: Math.ceil((new Date(lease.endDate).getTime() - new Date().getTime()) / (1000 * 60 * 60 * 24)) })
                          }</span>
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className="text-right">
                        <div className="text-foreground font-medium">${lease.monthlyRent.toLocaleString()}/mo</div>
                      </div>
                      <Badge className={STATUS_COLORS[lease.status]}>{lease.status}</Badge>
                      <div className="flex gap-2">
                        <Button onClick={() => { setEditingItem(lease); setIsEditOpen(true); }} variant="ghost" size="icon" className="h-8 w-8"><Edit className="w-4 h-4" /></Button>
                        <Button onClick={() => { setDeletingItem(lease); setIsDeleteOpen(true); }} variant="ghost" size="icon" className="h-8 w-8 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>
        {/* Create Dialog */}
        <CreateLeaseDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {/* Edit Dialog */}
        {editingItem && (
          <EditLeaseDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />
        )}
        {/* Delete Dialog */}
        {deletingItem && (
          <DeleteLeaseDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />
        )}
      </div>
    </div>
  );
}

function CreateLeaseDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<Lease, "id">) => void }) {
  const [tenantName, setTenantName] = useState("");
  const [propertyName, setPropertyName] = useState("");
  const [startDate, setStartDate] = useState(new Date().toISOString().split("T")[0]);
  const [endDate, setEndDate] = useState("");
  const [monthlyRent, setMonthlyRent] = useState(0);
  const [status, setStatus] = useState<Lease["status"]>("DRAFT");
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">Add Lease</DialogTitle>
          <DialogDescription className="text-muted-foreground">Add a new lease agreement.</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Tenant Name</Label>
            <Input value={tenantName} onChange={e => setTenantName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Property Name</Label>
            <Input value={propertyName} onChange={e => setPropertyName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Start Date</Label>
            <Input type="date" value={startDate} onChange={e => setStartDate(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">End Date</Label>
            <Input type="date" value={endDate} onChange={e => setEndDate(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Monthly Rent ($)</Label>
            <Input type="number" value={monthlyRent} onChange={e => setMonthlyRent(Number(e.target.value))} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Status</Label>
            <Select value={status} onValueChange={v => setStatus(v as Lease["status"])}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="ACTIVE">Active</SelectItem>
                <SelectItem value="EXPIRING">Expiring</SelectItem>
                <SelectItem value="EXPIRED">Expired</SelectItem>
                <SelectItem value="DRAFT">Draft</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">Cancel</Button>
          <Button onClick={() => onSubmit({ tenantName, propertyName, startDate, endDate, monthlyRent, status })} className="bg-primary hover:bg-primary/90">Create</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditLeaseDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: Lease; onSubmit: (data: Lease) => void }) {
  const [tenantName, setTenantName] = useState(item.tenantName);
  const [propertyName, setPropertyName] = useState(item.propertyName);
  const [startDate, setStartDate] = useState(item.startDate);
  const [endDate, setEndDate] = useState(item.endDate);
  const [monthlyRent, setMonthlyRent] = useState(item.monthlyRent);
  const [status, setStatus] = useState<Lease["status"]>(item.status);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">Edit Lease</DialogTitle>
          <DialogDescription className="text-muted-foreground">Update lease details.</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Tenant Name</Label>
            <Input value={tenantName} onChange={e => setTenantName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Property Name</Label>
            <Input value={propertyName} onChange={e => setPropertyName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Start Date</Label>
            <Input type="date" value={startDate} onChange={e => setStartDate(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">End Date</Label>
            <Input type="date" value={endDate} onChange={e => setEndDate(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Monthly Rent ($)</Label>
            <Input type="number" value={monthlyRent} onChange={e => setMonthlyRent(Number(e.target.value))} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">Status</Label>
            <Select value={status} onValueChange={v => setStatus(v as Lease["status"])}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="ACTIVE">Active</SelectItem>
                <SelectItem value="EXPIRING">Expiring</SelectItem>
                <SelectItem value="EXPIRED">Expired</SelectItem>
                <SelectItem value="DRAFT">Draft</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">Cancel</Button>
          <Button onClick={() => onSubmit({ id: item.id, tenantName, propertyName, startDate, endDate, monthlyRent, status })} className="bg-primary hover:bg-primary/90">Save</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteLeaseDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: Lease; onConfirm: () => void }) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">Delete Lease</DialogTitle>
          <DialogDescription className="text-muted-foreground">Are you sure you want to delete the lease for {item.propertyName} ({item.tenantName})? This action cannot be undone.</DialogDescription>
        </DialogHeader>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">Cancel</Button>
          <Button onClick={onConfirm} className="bg-destructive hover:bg-destructive/90">Delete</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
