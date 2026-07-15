"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import {
  Globe,
  Search,
  Plus,
  Edit,
  Trash2,
  ArrowUpRight,
  Wifi,
  WifiOff,
  RefreshCw,
  Building2,
} from "lucide-react";
import { motion } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Channel {
  id: string;
  name: string;
  type: "OTA" | "GDS" | "DIRECT";
  status: "CONNECTED" | "DISCONNECTED" | "ERROR";
  properties: number;
  lastSync: string;
  commission: string;
}

const mockChannels: Channel[] = [
  { id: "1", name: "Booking.com", type: "OTA", status: "CONNECTED", properties: 45, lastSync: "2 min ago", commission: "15%" },
  { id: "2", name: "Airbnb", type: "OTA", status: "CONNECTED", properties: 38, lastSync: "5 min ago", commission: "3%" },
  { id: "3", name: "Expedia", type: "OTA", status: "CONNECTED", properties: 42, lastSync: "10 min ago", commission: "18%" },
  { id: "4", name: "VRBO", type: "OTA", status: "ERROR", properties: 12, lastSync: "1 hour ago", commission: "8%" },
  { id: "5", name: "Google Travel", type: "GDS", status: "CONNECTED", properties: 30, lastSync: "15 min ago", commission: "0%" },
  { id: "6", name: "TripAdvisor", type: "GDS", status: "DISCONNECTED", properties: 0, lastSync: "Never", commission: "12%" },
  { id: "7", name: "Direct Website", type: "DIRECT", status: "CONNECTED", properties: 50, lastSync: "1 min ago", commission: "0%" },
];

const TYPE_COLORS: Record<string, string> = {
  OTA: "bg-slate-500/20 text-slate-400",
  GDS: "bg-slate-500/20 text-slate-400",
  DIRECT: "bg-emerald-500/20 text-emerald-400",
};

const STATUS_COLORS: Record<string, string> = {
  CONNECTED: "bg-green-500/20 text-green-400",
  DISCONNECTED: "bg-gray-500/20 text-gray-400",
  ERROR: "bg-red-500/20 text-red-400",
};

export default function AdminChannelsPage() {
  const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<Channel[]>(mockChannels);
  const [editingItem, setEditingItem] = useState<Channel | null>(null);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [isEditOpen, setIsEditOpen] = useState(false);
  const [isDeleteOpen, setIsDeleteOpen] = useState(false);
  const [deletingItem, setDeletingItem] = useState<Channel | null>(null);

  const filteredChannels = items.filter(ch =>
    ch.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<Channel, "id">) => {
    const newItem: Channel = { ...data, id: String(Date.now()) };
    setItems(prev => [...prev, newItem]);
    setIsCreateOpen(false);
  };

  const handleEdit = (updatedItem: Channel) => {
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
              <h1 className="text-3xl font-bold text-foreground mb-2">{t("admin_channels_title")}</h1>
              <p className="text-muted-foreground">{t("admin_channels_description")}</p>
            </div>
            <Button
              onClick={() => router.push('/admin/dashboard')}
              className="bg-primary hover:bg-primary/90"
            >
              <ArrowUpRight className="w-4 h-4 mr-2" />
              {t("admin_channels_back_to_dashboard")}
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
                      placeholder={t("admin_channels_search_placeholder")}
                      value={searchTerm}
                      onChange={(e) => setSearchTerm(e.target.value)}
                      className="pl-10 bg-muted/30 border-border text-foreground placeholder:text-muted-foreground"
                    />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90">
                  <Plus className="w-4 h-4 mr-2" />
                  {t("admin_channels_add_channel")}
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
                <Globe className="w-5 h-5" />
                {t("admin_channels_list_title")} ({filteredChannels.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {filteredChannels.map((channel) => (
                  <div
                    key={channel.id}
                    className="flex items-center justify-between p-4 bg-muted/30 rounded-lg hover:bg-muted/50 transition-colors"
                  >
                    <div className="flex items-center gap-4">
                      <div className="w-10 h-10 rounded-full bg-muted/50 flex items-center justify-center">
                        {channel.status === "CONNECTED" ? (
                          <Wifi className="w-5 h-5 text-green-400" />
                        ) : channel.status === "ERROR" ? (
                          <RefreshCw className="w-5 h-5 text-red-400" />
                        ) : (
                          <WifiOff className="w-5 h-5 text-muted-foreground" />
                        )}
                      </div>
                      <div>
                        <div className="text-foreground font-medium">{channel.name}</div>
                        <div className="text-sm text-muted-foreground flex items-center gap-2">
                          <Building2 className="w-3 h-3" />
                          {t("admin_channels_properties_count", { count: channel.properties })} {t("admin_auto_middot", "&middot;")}{t("admin_channels_commission_rate", { rate: channel.commission })}
                        </div>
                      </div>
                    </div>
                    <div className="flex items-center gap-4">
                      <Badge className={TYPE_COLORS[channel.type]}>{t(`admin_auto_channel_type_${channel.type.toLowerCase()}`, channel.type)}</Badge>
                      <Badge className={STATUS_COLORS[channel.status]}>{t(`admin_auto_channel_status_${channel.status.toLowerCase()}`, channel.status)}</Badge>
                      <div className="text-xs text-muted-foreground/70">{channel.lastSync}</div>
                      <div className="flex gap-2">
                        <Button onClick={() => { setEditingItem(channel); setIsEditOpen(true); }} variant="ghost" size="icon" className="h-8 w-8">
                          <Edit className="w-4 h-4" />
                        </Button>
                        <Button onClick={() => { setDeletingItem(channel); setIsDeleteOpen(true); }} variant="ghost" size="icon" className="h-8 w-8 text-red-400">
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
        <CreateChannelDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {/* Edit Dialog */}
        {editingItem && (
          <EditChannelDialog open={isEditOpen} onOpenChange={setIsEditOpen} item={editingItem} onSubmit={handleEdit} />
        )}
        {/* Delete Dialog */}
        {deletingItem && (
          <DeleteChannelDialog open={isDeleteOpen} onOpenChange={setIsDeleteOpen} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />
        )}
      </div>
    </div>
  );
}

function CreateChannelDialog({ open, onOpenChange, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; onSubmit: (data: Omit<Channel, "id">) => void }) {
    const { t } = useTranslation();
  const [name, setName] = useState("");
  const [type, setType] = useState<Channel["type"]>("OTA");
  const [status, setStatus] = useState<Channel["status"]>("CONNECTED");
  const [properties, setProperties] = useState(0);
  const [lastSync, setLastSync] = useState("Just now");
  const [commission, setCommission] = useState("");
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_channels_add_channel", "Add Channel")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_add_a_new_distribution_channel", "Add a new distribution channel.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_name", "Name")}</Label>
            <Input value={name} onChange={e => setName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_type", "Type")}</Label>
            <Select value={type} onValueChange={v => setType(v as Channel["type"])}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="OTA">{t("admin_auto_ota", "OTA")}</SelectItem>
                <SelectItem value="GDS">{t("admin_auto_gds", "GDS")}</SelectItem>
                <SelectItem value="DIRECT">{t("client.src.direct", "Direct")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as Channel["status"])}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="CONNECTED">{t("mobile.auto.connected", "Connected")}</SelectItem>
                <SelectItem value="DISCONNECTED">{t("admin_auto_disconnected", "Disconnected")}</SelectItem>
                <SelectItem value="ERROR">{t("admin_analytics_error", "Error")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_integrations_properties", "Properties")}</Label>
            <Input type="number" value={properties} onChange={e => setProperties(Number(e.target.value))} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_integrations_last_sync", "Last Sync")}</Label>
            <Input value={lastSync} onChange={e => setLastSync(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_financial_commission", "Commission")}</Label>
            <Input value={commission} onChange={e => setCommission(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ name, type, status, properties, lastSync, commission })} className="bg-primary hover:bg-primary/90">{t("admin_action_create", "Create")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function EditChannelDialog({ open, onOpenChange, item, onSubmit }: { open: boolean; onOpenChange: (open: boolean) => void; item: Channel; onSubmit: (data: Channel) => void }) {
    const { t } = useTranslation();
  const [name, setName] = useState(item.name);
  const [type, setType] = useState<Channel["type"]>(item.type);
  const [status, setStatus] = useState<Channel["status"]>(item.status);
  const [properties, setProperties] = useState(item.properties);
  const [lastSync, setLastSync] = useState(item.lastSync);
  const [commission, setCommission] = useState(item.commission);
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_auto_edit_channel", "Edit Channel")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_update_channel_details", "Update channel details.")}</DialogDescription>
        </DialogHeader>
        <div className="grid gap-4 py-4">
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_name", "Name")}</Label>
            <Input value={name} onChange={e => setName(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_auto_type", "Type")}</Label>
            <Select value={type} onValueChange={v => setType(v as Channel["type"])}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="OTA">{t("admin_auto_ota", "OTA")}</SelectItem>
                <SelectItem value="GDS">{t("admin_auto_gds", "GDS")}</SelectItem>
                <SelectItem value="DIRECT">{t("client.src.direct", "Direct")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_ai_status", "Status")}</Label>
            <Select value={status} onValueChange={v => setStatus(v as Channel["status"])}>
              <SelectTrigger className="col-span-3 bg-muted/30 border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-card border-border text-foreground">
                <SelectItem value="CONNECTED">{t("mobile.auto.connected", "Connected")}</SelectItem>
                <SelectItem value="DISCONNECTED">{t("admin_auto_disconnected", "Disconnected")}</SelectItem>
                <SelectItem value="ERROR">{t("admin_analytics_error", "Error")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_integrations_properties", "Properties")}</Label>
            <Input type="number" value={properties} onChange={e => setProperties(Number(e.target.value))} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_integrations_last_sync", "Last Sync")}</Label>
            <Input value={lastSync} onChange={e => setLastSync(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
          <div className="grid grid-cols-4 items-center gap-4">
            <Label className="text-right text-foreground">{t("admin_financial_commission", "Commission")}</Label>
            <Input value={commission} onChange={e => setCommission(e.target.value)} className="col-span-3 bg-muted/30 border-border text-foreground" />
          </div>
        </div>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => onSubmit({ id: item.id, name, type, status, properties, lastSync, commission })} className="bg-primary hover:bg-primary/90">{t("admin_action_save", "Save")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

function DeleteChannelDialog({ open, onOpenChange, item, onConfirm }: { open: boolean; onOpenChange: (open: boolean) => void; item: Channel; onConfirm: () => void }) {
    const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-background border-border text-foreground">
        <DialogHeader>
          <DialogTitle className="text-foreground">{t("admin_auto_delete_channel", "Delete Channel")}</DialogTitle>
          <DialogDescription className="text-muted-foreground">{t("admin_auto_are_you_sure_you_want_to_delete", "Are you sure you want to delete")}{item.name}{t("admin_auto_this_action_cannot_be_undone", "? This action cannot be undone.")}</DialogDescription>
        </DialogHeader>
        <DialogFooter>
          <Button variant="outline" onClick={() => onOpenChange(false)} className="border-border text-foreground">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-destructive hover:bg-destructive/90">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}
