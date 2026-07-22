"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Badge } from "@/components/ui/badge";
import { 
  Calendar, Search, Filter, ArrowUpRight, Building2, Clock, CheckCircle, XCircle, AlertCircle, Edit, Trash2, Check, AlertTriangle, Plus
} from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Reservation {
  id: string;
  guestName: string;
  propertyName: string;
  checkIn: string;
  checkOut: string;
  status: "CONFIRMED" | "PENDING" | "CANCELLED" | "COMPLETED";
  totalAmount: number;
}

const mockReservations: Reservation[] = [
  { id: "1", guestName: "John Doe", propertyName: "Luxury Villa", checkIn: "2024-04-15", checkOut: "2024-04-20", status: "CONFIRMED", totalAmount: 5000 },
  { id: "2", guestName: "Jane Smith", propertyName: "Downtown Apartment", checkIn: "2024-04-18", checkOut: "2024-04-22", status: "PENDING", totalAmount: 2000 },
  { id: "3", guestName: "Bob Wilson", propertyName: "Beachfront Condo", checkIn: "2024-04-10", checkOut: "2024-04-14", status: "COMPLETED", totalAmount: 3500 },
  { id: "4", guestName: "Alice Brown", propertyName: "Studio Loft", checkIn: "2024-04-25", checkOut: "2024-04-28", status: "CANCELLED", totalAmount: 1200 }
];

const STATUS_COLORS: Record<string, string> = {
  CONFIRMED: "bg-emerald-500/10 text-emerald-500 border-emerald-500/20",
  PENDING: "bg-amber-500/10 text-amber-500 border-amber-500/20",
  CANCELLED: "bg-red-500/10 text-red-500 border-red-500/20",
  COMPLETED: "bg-slate-500/10 text-slate-500 border-slate-500/20"
};

const STATUS_ICONS: Record<string, React.ComponentType<{ className?: string }>> = {
  CONFIRMED: CheckCircle,
  PENDING: AlertCircle,
  CANCELLED: XCircle,
  COMPLETED: CheckCircle
};

// Generic Modal Container with Glassmorphism
function GlassModal({ open, onOpenChange, title, description, children, footer }: any) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-slate-900/90 backdrop-blur-xl border border-white/10 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-white to-white/70">
            {title}
          </DialogTitle>
          {description && <DialogDescription className="text-slate-400">{description}</DialogDescription>}
        </DialogHeader>
        <div className="py-4 space-y-4">
          {children}
        </div>
        {footer && <DialogFooter className="pt-4 border-t border-white/10">{footer}</DialogFooter>}
      </DialogContent>
    </Dialog>
  );
}

function CreateReservationDialog({ open, onOpenChange, onSubmit }: any) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState<Omit<Reservation, "id">>({
    guestName: "", propertyName: "", checkIn: "", checkOut: "", status: "PENDING", totalAmount: 0
  });

  return (
    <GlassModal
      open={open}
      onOpenChange={onOpenChange}
      title={t("admin_bookings_add", "Add Reservation")}
      footer={
        <div className="flex justify-end gap-2 w-full">
          <Button variant="ghost" onClick={() => onOpenChange(false)} className="text-slate-300 hover:text-white">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit(formData)} className="bg-primary hover:bg-primary/90 text-primary-foreground shadow-lg shadow-primary/20">
            <Check className="w-4 h-4 mr-2" />
            {t("admin_action_create", "Create")}
          </Button>
        </div>
      }
    >
      <div className="grid gap-4 text-white">
        <div className="grid gap-2">
          <Label>{t("admin_ai_name", "Guest Name")}</Label>
          <Input value={formData.guestName} onChange={e => setFormData({ ...formData, guestName: e.target.value })} className="bg-white/5 border-white/10 focus:border-primary/50 transition-colors" />
        </div>
        <div className="grid gap-2">
          <Label>{t("admin_ai_property", "Property")}</Label>
          <Input value={formData.propertyName} onChange={e => setFormData({ ...formData, propertyName: e.target.value })} className="bg-white/5 border-white/10" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_ai_start_date", "Check In")}</Label>
            <Input type="date" value={formData.checkIn} onChange={e => setFormData({ ...formData, checkIn: e.target.value })} className="bg-white/5 border-white/10 [&::-webkit-calendar-picker-indicator]:invert" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_end_date", "Check Out")}</Label>
            <Input type="date" value={formData.checkOut} onChange={e => setFormData({ ...formData, checkOut: e.target.value })} className="bg-white/5 border-white/10 [&::-webkit-calendar-picker-indicator]:invert" />
          </div>
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_auto_amount", "Amount")}</Label>
            <Input type="number" value={formData.totalAmount} onChange={e => setFormData({ ...formData, totalAmount: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_status", "Status")}</Label>
            <Select value={formData.status} onValueChange={(v: any) => setFormData({ ...formData, status: v })}>
              <SelectTrigger className="bg-white/5 border-white/10 text-white">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="CONFIRMED">{t("admin_status_confirmed")}</SelectItem>
                <SelectItem value="PENDING">{t("admin_status_pending")}</SelectItem>
                <SelectItem value="CANCELLED">{t("admin_status_cancelled")}</SelectItem>
                <SelectItem value="COMPLETED">{t("admin_status_completed")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
      </div>
    </GlassModal>
  );
}

function EditReservationDialog({ open, onOpenChange, item, onSubmit }: any) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState<Reservation>(item);

  return (
    <GlassModal
      open={open}
      onOpenChange={onOpenChange}
      title={t("admin_action_edit", "Edit Reservation")}
      footer={
        <div className="flex justify-end gap-2 w-full">
          <Button variant="ghost" onClick={() => onOpenChange(false)} className="text-slate-300 hover:text-white">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit(formData)} className="bg-primary hover:bg-primary/90 shadow-lg shadow-primary/20">
            <Check className="w-4 h-4 mr-2" />
            {t("admin_action_save", "Save")}
          </Button>
        </div>
      }
    >
      <div className="grid gap-4 text-white">
        <div className="grid gap-2">
          <Label>{t("admin_ai_name", "Guest Name")}</Label>
          <Input value={formData.guestName} onChange={e => setFormData({ ...formData, guestName: e.target.value })} className="bg-white/5 border-white/10 focus:border-primary/50 transition-colors" />
        </div>
        <div className="grid gap-2">
          <Label>{t("admin_ai_property", "Property")}</Label>
          <Input value={formData.propertyName} onChange={e => setFormData({ ...formData, propertyName: e.target.value })} className="bg-white/5 border-white/10" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_ai_start_date", "Check In")}</Label>
            <Input type="date" value={formData.checkIn} onChange={e => setFormData({ ...formData, checkIn: e.target.value })} className="bg-white/5 border-white/10 [&::-webkit-calendar-picker-indicator]:invert" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_end_date", "Check Out")}</Label>
            <Input type="date" value={formData.checkOut} onChange={e => setFormData({ ...formData, checkOut: e.target.value })} className="bg-white/5 border-white/10 [&::-webkit-calendar-picker-indicator]:invert" />
          </div>
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_auto_amount", "Amount")}</Label>
            <Input type="number" value={formData.totalAmount} onChange={e => setFormData({ ...formData, totalAmount: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_ai_status", "Status")}</Label>
            <Select value={formData.status} onValueChange={(v: any) => setFormData({ ...formData, status: v })}>
              <SelectTrigger className="bg-white/5 border-white/10 text-white">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="CONFIRMED">{t("admin_status_confirmed")}</SelectItem>
                <SelectItem value="PENDING">{t("admin_status_pending")}</SelectItem>
                <SelectItem value="CANCELLED">{t("admin_status_cancelled")}</SelectItem>
                <SelectItem value="COMPLETED">{t("admin_status_completed")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
      </div>
    </GlassModal>
  );
}

function DeleteReservationDialog({ open, onOpenChange, item, onConfirm }: any) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-slate-900/90 backdrop-blur-xl border border-red-500/20 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2 text-red-500">
            <AlertTriangle className="w-5 h-5" />
            {t("admin_action_delete", "Delete")}
          </DialogTitle>
          <DialogDescription className="pt-2 text-slate-300">
            {t("admin_auto_are_you_sure_you_want_to_delete", "Are you sure you want to delete")} <span className="font-bold text-white">{item?.guestName}</span>? {t("admin_auto_this_action_cannot_be_undone", "This action cannot be undone.")}
          </DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/5">
          <Button variant="ghost" onClick={() => onOpenChange(false)} className="text-slate-300 hover:text-white">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">
            {t("admin_action_delete", "Delete")}
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

export default function PropertyReservationsPage() {
  const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  
  const [items, setItems] = useState<Reservation[]>(mockReservations);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<Reservation | null>(null);
  const [deletingItem, setDeletingItem] = useState<Reservation | null>(null);

  const filteredReservations = items.filter(reservation => 
    reservation.guestName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    reservation.propertyName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<Reservation, "id">) => {
    setItems(prev => [...prev, { ...data, id: String(Date.now()) }]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: Reservation) => {
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
              <h1 className="text-3xl font-bold text-white mb-2">{t("reservations.propertyreservationspage.auto_ext_1", "Property Reservations")}</h1>
              <p className="text-gray-400">{t("reservations.propertyreservationspage.auto_ext_2", "Manage property reservations and bookings")}</p>
            </div>
            <Button onClick={() => router.push('/admin/dashboard')} className="bg-slate-600 hover:bg-slate-700">
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_adminpage_auto_ext_3", "Dashboard")}
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
                    <Input
                      placeholder={t("admin_auto_search_reservations", "Search reservations...")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400 transition-colors focus:bg-white/10"
                    />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90 shadow-md">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_bookings_add", "Add Reservation")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <Calendar className="w-5 h-5 text-primary" />
                {t("reservations.propertyreservationspage.auto_ext_5", "All Reservations")} ({filteredReservations.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <AnimatePresence>
                  {filteredReservations.map((reservation) => {
                    const StatusIcon = STATUS_ICONS[reservation.status];
                    return (
                      <m.div
                        key={reservation.id}
                        layout
                        initial={{ opacity: 0, scale: 0.98 }}
                        animate={{ opacity: 1, scale: 1 }}
                        exit={{ opacity: 0, scale: 0.98 }}
                        className="flex items-center justify-between p-4 bg-white/5 rounded-xl hover:bg-white/10 transition-all border border-transparent hover:border-slate-500/30 group"
                      >
                        <div className="flex items-center gap-4">
                          <div className="w-12 h-12 rounded-full bg-gradient-to-br from-slate-500/20 to-slate-500/10 border border-slate-500/20 flex items-center justify-center text-slate-300 font-bold shadow-inner">
                            {reservation.guestName.split(' ').map(n => n[0]).join('')}
                          </div>
                          <div>
                            <div className="text-white font-semibold text-lg">{reservation.guestName}</div>
                            <div className="text-sm text-gray-400 flex items-center gap-2 mt-0.5">
                              <Building2 className="w-3.5 h-3.5" />
                              {reservation.propertyName}
                            </div>
                            <div className="text-xs text-gray-400/80 flex items-center gap-4 mt-2">
                              <span className="flex items-center gap-1.5"><Clock className="w-3.5 h-3.5" />{reservation.checkIn} - {reservation.checkOut}</span>
                            </div>
                          </div>
                        </div>
                        <div className="flex flex-col sm:flex-row items-end sm:items-center gap-4">
                          <div className="text-right">
                            <div className="text-white font-bold">${reservation.totalAmount}</div>
                            <Badge variant="outline" className={`mt-1 border ${STATUS_COLORS[reservation.status]}`}>
                              <StatusIcon className="w-3 h-3 mr-1" />
                              {t("admin_status_" + String(reservation.status).toLowerCase())}
                            </Badge>
                          </div>
                          <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                            <Button onClick={() => setEditingItem(reservation)} variant="outline" size="icon" className="h-9 w-9 bg-white/5 hover:bg-white/10 border-slate-500/30">
                              <Edit className="w-4 h-4 text-white/70" />
                            </Button>
                            <Button onClick={() => setDeletingItem(reservation)} variant="outline" size="icon" className="h-9 w-9 bg-white/5 hover:bg-red-500/10 border-slate-500/30 hover:border-red-500/30 group/btn">
                              <Trash2 className="w-4 h-4 text-red-500/70 group-hover/btn:text-red-500" />
                            </Button>
                          </div>
                        </div>
                      </m.div>
                    );
                  })}
                </AnimatePresence>
                {filteredReservations.length === 0 && (
                  <div className="py-12 text-center text-slate-500">
                    {t("admin_auto_no_results_found", "No results found")}
                  </div>
                )}
              </div>
            </CardContent>
          </Card>
        </m.div>

        {/* Modals */}
        <CreateReservationDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {editingItem && (
          <EditReservationDialog open={!!editingItem} onOpenChange={(open: boolean) => !open && setEditingItem(null)} item={editingItem} onSubmit={handleEdit} />
        )}
        {deletingItem && (
          <DeleteReservationDialog open={!!deletingItem} onOpenChange={(open: boolean) => !open && setDeletingItem(null)} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />
        )}
      </div>
    </div>
  );
}
