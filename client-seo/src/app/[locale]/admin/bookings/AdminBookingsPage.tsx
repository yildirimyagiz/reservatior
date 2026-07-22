"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { 
  Calendar, 
  Search, 
  Filter, 
  ArrowUpRight,
  Building2,
  Clock,
  CheckCircle,
  XCircle,
  AlertCircle
} from "lucide-react";
import { m } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Plus, Edit, Trash2 } from "lucide-react";

interface Booking {
  id: string;
  guestName: string;
  propertyName: string;
  checkIn: string;
  checkOut: string;
  status: "CONFIRMED" | "PENDING" | "CANCELLED" | "COMPLETED";
  totalAmount: number;
}

const mockBookings: Booking[] = [
  { id: "1", guestName: "John Doe", propertyName: "Luxury Villa", checkIn: "2024-04-15", checkOut: "2024-04-20", status: "CONFIRMED", totalAmount: 5000 },
  { id: "2", guestName: "Jane Smith", propertyName: "Downtown Apartment", checkIn: "2024-04-18", checkOut: "2024-04-22", status: "PENDING", totalAmount: 2000 },
  { id: "3", guestName: "Bob Wilson", propertyName: "Beachfront Condo", checkIn: "2024-04-10", checkOut: "2024-04-14", status: "COMPLETED", totalAmount: 3500 },
  { id: "4", guestName: "Alice Brown", propertyName: "Studio Loft", checkIn: "2024-04-25", checkOut: "2024-04-28", status: "CANCELLED", totalAmount: 1200 },
  { id: "5", guestName: "Charlie Davis", propertyName: "Penthouse Suite", checkIn: "2024-05-01", checkOut: "2024-05-07", status: "CONFIRMED", totalAmount: 8000 }
];

const STATUS_COLORS: Record<string, string> = {
  CONFIRMED: "bg-green-500/20 text-green-400",
  PENDING: "bg-yellow-500/20 text-yellow-400",
  CANCELLED: "bg-red-500/20 text-red-400",
  COMPLETED: "bg-slate-500/20 text-slate-400"
};

const STATUS_ICONS: Record<string, any> = {
  CONFIRMED: CheckCircle,
  PENDING: AlertCircle,
  CANCELLED: XCircle,
  COMPLETED: CheckCircle
};

export default function AdminBookingsPage() {
    const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<Booking[]>(mockBookings);
  const [editingItem, setEditingItem] = useState<Booking | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<Booking | null>(null);

  const filteredBookings = items.filter(booking => 
    booking.guestName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    booking.propertyName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<Booking, "id">) => {
    const newItem: Booking = { ...data, id: String(Date.now()) };
    setItems(prev => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: Booking) => {
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
        <m.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_bookings_title")}</h1>
              <p className="text-muted-foreground">{t("admin_bookings_description")}</p>
            </div>
            <Button
              onClick={() => router.push('/admin/dashboard')}
              className="bg-primary hover:bg-primary/90"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_bookings_back_to_dashboard")}
                                      </Button>
          </div>
        </m.div>

        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="mb-6"
        >
          <Card className="bg-card border-border">
            <CardContent className="p-4">
              <div className="flex gap-4">
                <div className="flex-1">
                  <div className="relative">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
                    <Input
                      placeholder={t("admin_bookings_search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Button variant="outline" className="bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                  <Filter className="w-4 h-4 mr-2" />
                  {t("admin_bookings_filter")}
                </Button>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_bookings_add_booking")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        <m.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Calendar className="w-5 h-5" />
                {t("admin_bookings_list_title")}{filteredBookings.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredBookings.map((booking) => {
                  const StatusIcon = STATUS_ICONS[booking.status];
                  return (
                    <div
                      key={booking.id}
                      className="flex items-center justify-between p-4 bg-white/5 rounded-lg hover:bg-white/10 transition-colors"
                    >
                      <div className="flex items-center gap-4">
                        <div className="w-10 h-10 rounded-full bg-muted/50 flex items-center justify-center text-muted-foreground font-bold">
                          {booking.guestName.split(' ').map(n => n[0]).join('')}
                        </div>
                        <div>
                          <div className="text-foreground font-medium">{booking.guestName}</div>
                          <div className="text-sm text-muted-foreground flex items-center gap-2">
                            <Building2 className="w-3 h-3" />
                            {booking.propertyName}
                          </div>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <div className="text-sm text-muted-foreground flex items-center gap-1">
                          <Clock className="w-3 h-3" />
                          {booking.checkIn} - {booking.checkOut}
                        </div>
                        <div className={`flex items-center gap-1 ${STATUS_COLORS[booking.status]} px-2 py-1 rounded`}>
                          <StatusIcon className="w-3 h-3" />
                          <span className="text-xs font-medium">{t(`admin_bookings_status_${booking.status.toLowerCase()}`, booking.status)}</span>
                        </div>
                        <div className="text-foreground font-bold">
                          ${booking.totalAmount.toLocaleString()}
                        </div>
                        <div className="flex gap-2">
                          <Button onClick={() => { setEditingItem(booking); setIsEditOpen(true); }} variant="ghost" size="icon" className="min-h-10 min-w-10 h-10 w-10"><Edit className="w-4 h-4" /></Button>
                          <Button onClick={() => { setDeletingItem(booking); setIsDeleteOpen(true); }} variant="ghost" size="icon" className="min-h-10 min-w-10 h-10 w-10 text-red-400"><Trash2 className="w-4 h-4" /></Button>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </CardContent>
          </Card>
        </m.div>
        {/* Create Dialog */}
        <CreateBookingDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {/* Edit Dialog */}
        {editingItem && (
          <EditBookingDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />
        )}
        {/* Delete Dialog */}
        {deletingItem && (
          <DeleteBookingDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />
        )}
      </div>
    </div>
  );
}

function CreateBookingDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<Booking, "id">) => void }) {
    const { t } = useTranslation();
  const [guestName, setGuestName] = useState("");
  const [propertyName, setPropertyName] = useState("");
  const [checkIn, setCheckIn] = useState(new Date().toISOString().split("T")[0]);
  const [checkOut, setCheckOut] = useState("");
  const [totalAmount, setTotalAmount] = useState(0);
  const [status, setStatus] = useState<Booking["status"]>("PENDING");
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_auto_add_booking", "Add Booking")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_add_a_new_booking", "Add a new booking.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reservations_guest_name", "Guest Name")}</Label>
            <Input value={guestName} onChange={e => setGuestName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.property_name", "Property Name")}</Label>
            <Input value={propertyName} onChange={e => setPropertyName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_inventory_type_check_in", "Check In")}</Label>
            <Input type="date" value={checkIn} onChange={e => setCheckIn(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_inventory_type_check_out", "Check Out")}</Label>
            <Input type="date" value={checkOut} onChange={e => setCheckOut(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_total_amount", "Total Amount ($)")}</Label>
            <Input type="number" value={totalAmount} onChange={e => setTotalAmount(Number(e.target.value))} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as Booking["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="CONFIRMED">{t("admin_property_confirmed", "Confirmed")}</SelectItem>
                <SelectItem value="PENDING">{t("admin_ai_pending", "Pending")}</SelectItem>
                <SelectItem value="CANCELLED">{t("admin_bookings_status_cancelled", "Cancelled")}</SelectItem>
                <SelectItem value="COMPLETED">{t("admin_ai_completed", "Completed")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ guestName, propertyName, checkIn, checkOut, totalAmount, status })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditBookingDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: Booking; onSubmit: (data: Booking) => void }) {
    const { t } = useTranslation();
  const [guestName, setGuestName] = useState(item.guestName);
  const [propertyName, setPropertyName] = useState(item.propertyName);
  const [checkIn, setCheckIn] = useState(item.checkIn);
  const [checkOut, setCheckOut] = useState(item.checkOut);
  const [totalAmount, setTotalAmount] = useState(item.totalAmount);
  const [status, setStatus] = useState<Booking["status"]>(item.status);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("mobile.booking.formEdit", "Edit Booking")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_update_booking_details", "Update booking details.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_reservations_guest_name", "Guest Name")}</Label>
            <Input value={guestName} onChange={e => setGuestName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.property_name", "Property Name")}</Label>
            <Input value={propertyName} onChange={e => setPropertyName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_inventory_type_check_in", "Check In")}</Label>
            <Input type="date" value={checkIn} onChange={e => setCheckIn(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_inventory_type_check_out", "Check Out")}</Label>
            <Input type="date" value={checkOut} onChange={e => setCheckOut(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_total_amount", "Total Amount ($)")}</Label>
            <Input type="number" value={totalAmount} onChange={e => setTotalAmount(Number(e.target.value))} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as Booking["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="CONFIRMED">{t("admin_property_confirmed", "Confirmed")}</SelectItem>
                <SelectItem value="PENDING">{t("admin_ai_pending", "Pending")}</SelectItem>
                <SelectItem value="CANCELLED">{t("admin_bookings_status_cancelled", "Cancelled")}</SelectItem>
                <SelectItem value="COMPLETED">{t("admin_ai_completed", "Completed")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ id: item.id, guestName, propertyName, checkIn, checkOut, totalAmount, status })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteBookingDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: Booking; onConfirm: () => void }) {
    const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_auto_delete_booking", "Delete Booking")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_are_you_sure_you_want_to_delete_the_book", "Are you sure you want to delete the booking for")}{item.guestName}{t("admin_auto_this_action_cannot_be_undone", "? This action cannot be undone.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
