"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import {
  Users,
  Search,
  Plus,
  Edit,
  Trash2,
  ArrowUpRight,
  Mail,
  Phone,
  Calendar,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Guest {
  id: string;
  name: string;
  email: string;
  phone: string;
  totalBookings: number;
  totalSpent: string;
  status: "ACTIVE" | "INACTIVE" | "BLACKLISTED";
  lastStay: string;
}

const mockGuests: Guest[] = [
  { id: "1", name: "Emily Johnson", email: "emily@example.com", phone: "+1 (555) 123-4567", totalBookings: 12, totalSpent: "$8,450", status: "ACTIVE", lastStay: "2024-06-15" },
  { id: "2", name: "Michael Chen", email: "michael@example.com", phone: "+1 (555) 234-5678", totalBookings: 8, totalSpent: "$5,200", status: "ACTIVE", lastStay: "2024-06-10" },
  { id: "3", name: "Sarah Williams", email: "sarah@example.com", phone: "+1 (555) 345-6789", totalBookings: 5, totalSpent: "$3,100", status: "ACTIVE", lastStay: "2024-05-28" },
  { id: "4", name: "David Martinez", email: "david@example.com", phone: "+1 (555) 456-7890", totalBookings: 3, totalSpent: "$1,950", status: "INACTIVE", lastStay: "2024-03-15" },
  { id: "5", name: "Lisa Thompson", email: "lisa@example.com", phone: "+1 (555) 567-8901", totalBookings: 15, totalSpent: "$11,200", status: "ACTIVE", lastStay: "2024-06-18" },
  { id: "6", name: "James Wilson", email: "james@example.com", phone: "+1 (555) 678-9012", totalBookings: 1, totalSpent: "$850", status: "BLACKLISTED", lastStay: "2024-01-05" },
];

const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-500/20 text-green-400",
  INACTIVE: "bg-gray-500/20 text-gray-400",
  BLACKLISTED: "bg-red-500/20 text-red-400",
};

export default function AdminGuestsPage() {
  const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<Guest[]>(mockGuests);
  const [editingItem, setEditingItem] = useState<Guest | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<Guest | null>(null);

  const filteredGuests = items.filter(guest =>
    guest.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    guest.email.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<Guest, "id">) => {
    const newItem: Guest = { ...data, id: String(Date.now()) };
    setItems(prev => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: Guest) => {
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
        <motion.div
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          className="mb-8"
        >
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_guests_title")}</h1>
              <p className="text-muted-foreground">{t("admin_guests_description")}</p>
            </div>
            <Button
              onClick={() => router.push('/admin/dashboard')}
              className="bg-primary hover:bg-primary/90"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_guests_back_to_dashboard")}
            </Button>
          </div>
        </motion.div>

        <motion.div
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
                      placeholder={t("admin_guests_search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_guests_add_guest")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
        >
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Users className="w-5 h-5" />
                {t("admin_guests_list_title")}({filteredGuests.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredGuests.map((guest) => (
                  <div
                    key={guest.id}
                    className="flex items-center justify-between p-4 bg-muted/30 rounded-lg hover:bg-muted/50 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-muted/50 flex items-center justify-center text-muted-foreground font-bold">
                        {guest.name.split(' ').map(n => n[0]).join('')}
                      </div>
                      <div>
                        <div className="text-foreground font-medium">{guest.name}</div>
                        <div className="text-sm text-muted-foreground flex items-center gap-2">
                          <Mail className="w-3 h-3" />
                          {guest.email}
                          <span className="mx-1">{t("admin_auto_middot", "&middot;")}</span>
                          <Phone className="w-3 h-3" />
                          {guest.phone}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <div className="text-right">
                        <div className="text-foreground text-sm">{t("admin_guests_stays_count", { count: guest.totalBookings })}</div>
                        <div className="text-muted-foreground text-xs">{guest.totalSpent}</div>
                      </div>
                      <Badge className={STATUS_COLORS[guest.status]}>{t("admin_status_" + String(guest.status).toLowerCase())}</Badge>
                      <div className="flex items-center gap-1 text-xs text-muted-foreground/70">
                        <Calendar className="w-3 h-3" />
                        {guest.lastStay}
                      </div>
                      <div className="flex gap-2">
                        <Button onClick={() => { setEditingItem(guest); setIsEditOpen(true); }} variant="ghost" size="icon" className="h-8 w-8">
                          <Edit className="w-4 h-4" />
                        </Button>
                        <Button onClick={() => { setDeletingItem(guest); setIsDeleteOpen(true); }} variant="ghost" size="icon" className="h-8 w-8 text-red-400">
                          <Trash2 className="w-4 h-4" />
                        </Button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </motion.div>
        {/* Create Dialog */}
        <CreateGuestDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {/* Edit Dialog */}
        {editingItem && (
          <EditGuestDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />
        )}
        {/* Delete Dialog */}
        {deletingItem && (
          <DeleteGuestDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />
        )}
      </div>
    </div>
  );
}

function CreateGuestDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<Guest, "id">) => void }) {
    const { t } = useTranslation();
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [totalBookings, setTotalBookings] = useState(0);
  const [totalSpent, setTotalSpent] = useState("$0");
  const [status, setStatus] = useState<Guest["status"]>("ACTIVE");
  const [lastStay, setLastStay] = useState(new Date().toISOString().split("T")[0]);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_guests_add_guest", "Add Guest")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_add_a_new_guest_to_the_system", "Add a new guest to the system.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_name", "Name")}</Label>
            <Input value={name} onChange={e => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_email", "Email")}</Label>
            <Input value={email} onChange={e => setEmail(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_phone", "Phone")}</Label>
            <Input value={phone} onChange={e => setPhone(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.total_bookings", "Total Bookings")}</Label>
            <Input type="number" value={totalBookings} onChange={e => setTotalBookings(Number(e.target.value))} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_financial_total_spent", "Total Spent")}</Label>
            <Input value={totalSpent} onChange={e => setTotalSpent(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as Guest["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="ACTIVE">{t("admin_ai_active", "Active")}</SelectItem>
                <SelectItem value="INACTIVE">{t("admin_ai_inactive", "Inactive")}</SelectItem>
                <SelectItem value="BLACKLISTED">{t("admin_auto_blacklisted", "Blacklisted")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_last_stay", "Last Stay")}</Label>
            <Input type="date" value={lastStay} onChange={e => setLastStay(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ name, email, phone, totalBookings, totalSpent, status, lastStay })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditGuestDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: Guest; onSubmit: (data: Guest) => void }) {
    const { t } = useTranslation();
  const [name, setName] = useState(item.name);
  const [email, setEmail] = useState(item.email);
  const [phone, setPhone] = useState(item.phone);
  const [totalBookings, setTotalBookings] = useState(item.totalBookings);
  const [totalSpent, setTotalSpent] = useState(item.totalSpent);
  const [status, setStatus] = useState<Guest["status"]>(item.status);
  const [lastStay, setLastStay] = useState(item.lastStay);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_guest_edit_title", "Edit Guest")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_update_guest_details", "Update guest details.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_name", "Name")}</Label>
            <Input value={name} onChange={e => setName(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_email", "Email")}</Label>
            <Input value={email} onChange={e => setEmail(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_phone", "Phone")}</Label>
            <Input value={phone} onChange={e => setPhone(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("client.src.total_bookings", "Total Bookings")}</Label>
            <Input type="number" value={totalBookings} onChange={e => setTotalBookings(Number(e.target.value))} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_financial_total_spent", "Total Spent")}</Label>
            <Input value={totalSpent} onChange={e => setTotalSpent(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as Guest["status"])}>
              <SelectTrigger className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="ACTIVE">{t("admin_ai_active", "Active")}</SelectItem>
                <SelectItem value="INACTIVE">{t("admin_ai_inactive", "Inactive")}</SelectItem>
                <SelectItem value="BLACKLISTED">{t("admin_auto_blacklisted", "Blacklisted")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_last_stay", "Last Stay")}</Label>
            <Input type="date" value={lastStay} onChange={e => setLastStay(e.target.value)} className="col-span-3 bg-white/5 border-white/10 text-foreground focus:border-primary/50 transition-colors" />
          </div>
        </div>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ id: item.id, name, email, phone, totalBookings, totalSpent, status, lastStay })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteGuestDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: Guest; onConfirm: () => void }) {
    const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-background/80 backdrop-blur-xl border border-white/10 shadow-2xl text-foreground">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-foreground to-foreground/70">{t("admin_auto_delete_guest", "Delete Guest")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_are_you_sure_you_want_to_delete", "Are you sure you want to delete")}{item.name}{t("admin_auto_this_action_cannot_be_undone", "? This action cannot be undone.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/10">
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
