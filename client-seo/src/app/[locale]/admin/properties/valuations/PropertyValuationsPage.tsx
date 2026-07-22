"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { 
  TrendingUp, Search, Plus, ArrowUpRight, Building2, DollarSign, Calendar, BarChart3, Edit, Trash2, Check, AlertTriangle
} from "lucide-react";
import { m, AnimatePresence } from "framer-motion";
import { useTranslation } from "react-i18next";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";

interface Valuation {
  id: string;
  propertyName: string;
  currentValue: number;
  previousValue: number;
  change: number;
  changePercent: number;
  lastUpdated: string;
  type: "APPRAISAL" | "MARKET" | "AI_ESTIMATE";
}

const mockValuations: Valuation[] = [
  { id: "1", propertyName: "Luxury Villa", currentValue: 1250000, previousValue: 1200000, change: 50000, changePercent: 4.2, lastUpdated: "2024-04-15", type: "APPRAISAL" },
  { id: "2", propertyName: "Downtown Apartment", currentValue: 890000, previousValue: 850000, change: 40000, changePercent: 4.7, lastUpdated: "2024-04-14", type: "MARKET" },
  { id: "3", propertyName: "Beachfront Condo", currentValue: 750000, previousValue: 780000, change: -30000, changePercent: -3.8, lastUpdated: "2024-04-13", type: "AI_ESTIMATE" },
  { id: "4", propertyName: "Studio Loft", currentValue: 420000, previousValue: 400000, change: 20000, changePercent: 5.0, lastUpdated: "2024-04-12", type: "APPRAISAL" }
];

const TYPE_COLORS: Record<string, string> = {
  APPRAISAL: "bg-blue-500/10 text-blue-400 border border-blue-500/20",
  MARKET: "bg-violet-500/10 text-violet-400 border border-violet-500/20",
  AI_ESTIMATE: "bg-emerald-500/10 text-emerald-400 border border-emerald-500/20"
};

function GlassModal({ open, onOpenChange, title, description, children, footer }: any) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[480px] bg-slate-900/90 backdrop-blur-xl border border-white/10 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-white to-white/70">{title}</DialogTitle>
          {description && <DialogDescription className="text-slate-400">{description}</DialogDescription>}
        </DialogHeader>
        <div className="py-4 space-y-4">{children}</div>
        {footer && <DialogFooter className="pt-4 border-t border-white/10">{footer}</DialogFooter>}
      </DialogContent>
    </Dialog>
  );
}

function CreateValuationDialog({ open, onOpenChange, onSubmit }: any) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState<Omit<Valuation, "id">>({
    propertyName: "", currentValue: 0, previousValue: 0, change: 0, changePercent: 0, lastUpdated: new Date().toISOString().split("T")[0], type: "MARKET"
  });

  const calcChange = (current: number, previous: number) => {
    const change = current - previous;
    const percent = previous > 0 ? Number(((change / previous) * 100).toFixed(1)) : 0;
    return { change, changePercent: percent };
  };

  return (
    <GlassModal open={open} onOpenChange={onOpenChange} title={t("admin_properties_valuations_add", "Add Valuation")}
      footer={
        <div className="flex justify-end gap-2 w-full">
          <Button variant="ghost" onClick={() => onOpenChange(false)} className="text-slate-300 hover:text-white">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => {
            const { change, changePercent } = calcChange(formData.currentValue, formData.previousValue);
            onSubmit({ ...formData, change, changePercent });
          }} className="bg-primary hover:bg-primary/90 shadow-lg shadow-primary/20">
            <Check className="w-4 h-4 mr-2" />{t("admin_action_create", "Create")}
          </Button>
        </div>
      }
    >
      <div className="grid gap-4 text-white">
        <div className="grid gap-2">
          <Label>{t("admin_ai_property", "Property Name")}</Label>
          <Input value={formData.propertyName} onChange={e => setFormData({ ...formData, propertyName: e.target.value })} className="bg-white/5 border-white/10 focus:border-primary/50" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_auto_current_value", "Current Value")}</Label>
            <Input type="number" value={formData.currentValue} onChange={e => setFormData({ ...formData, currentValue: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_auto_previous_value", "Previous Value")}</Label>
            <Input type="number" value={formData.previousValue} onChange={e => setFormData({ ...formData, previousValue: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_ai_type", "Type")}</Label>
            <Select value={formData.type} onValueChange={(v: any) => setFormData({ ...formData, type: v })}>
              <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
              <SelectContent>
                <SelectItem value="APPRAISAL">{t("admin_auto_appraisal", "Appraisal")}</SelectItem>
                <SelectItem value="MARKET">{t("admin_auto_market", "Market")}</SelectItem>
                <SelectItem value="AI_ESTIMATE">{t("admin_auto_ai_estimate", "AI Estimate")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_auto_date", "Date")}</Label>
            <Input type="date" value={formData.lastUpdated} onChange={e => setFormData({ ...formData, lastUpdated: e.target.value })} className="bg-white/5 border-white/10 [&::-webkit-calendar-picker-indicator]:invert" />
          </div>
        </div>
      </div>
    </GlassModal>
  );
}

function EditValuationDialog({ open, onOpenChange, item, onSubmit }: any) {
  const { t } = useTranslation();
  const [formData, setFormData] = useState<Valuation>(item);

  const calcChange = (current: number, previous: number) => {
    const change = current - previous;
    const percent = previous > 0 ? Number(((change / previous) * 100).toFixed(1)) : 0;
    return { change, changePercent: percent };
  };

  return (
    <GlassModal open={open} onOpenChange={onOpenChange} title={t("admin_action_edit", "Edit")}
      footer={
        <div className="flex justify-end gap-2 w-full">
          <Button variant="ghost" onClick={() => onOpenChange(false)} className="text-slate-300 hover:text-white">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={() => {
            const { change, changePercent } = calcChange(formData.currentValue, formData.previousValue);
            onSubmit({ ...formData, change, changePercent });
          }} className="bg-primary hover:bg-primary/90 shadow-lg shadow-primary/20">
            <Check className="w-4 h-4 mr-2" />{t("admin_action_save", "Save")}
          </Button>
        </div>
      }
    >
      <div className="grid gap-4 text-white">
        <div className="grid gap-2">
          <Label>{t("admin_ai_property", "Property Name")}</Label>
          <Input value={formData.propertyName} onChange={e => setFormData({ ...formData, propertyName: e.target.value })} className="bg-white/5 border-white/10 focus:border-primary/50" />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_auto_current_value", "Current Value")}</Label>
            <Input type="number" value={formData.currentValue} onChange={e => setFormData({ ...formData, currentValue: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_auto_previous_value", "Previous Value")}</Label>
            <Input type="number" value={formData.previousValue} onChange={e => setFormData({ ...formData, previousValue: Number(e.target.value) })} className="bg-white/5 border-white/10" />
          </div>
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="grid gap-2">
            <Label>{t("admin_ai_type", "Type")}</Label>
            <Select value={formData.type} onValueChange={(v: any) => setFormData({ ...formData, type: v })}>
              <SelectTrigger className="bg-white/5 border-white/10 text-white"><SelectValue /></SelectTrigger>
              <SelectContent>
                <SelectItem value="APPRAISAL">{t("admin_auto_appraisal", "Appraisal")}</SelectItem>
                <SelectItem value="MARKET">{t("admin_auto_market", "Market")}</SelectItem>
                <SelectItem value="AI_ESTIMATE">{t("admin_auto_ai_estimate", "AI Estimate")}</SelectItem>
              </SelectContent>
            </Select>
          </div>
          <div className="grid gap-2">
            <Label>{t("admin_auto_date", "Date")}</Label>
            <Input type="date" value={formData.lastUpdated} onChange={e => setFormData({ ...formData, lastUpdated: e.target.value })} className="bg-white/5 border-white/10 [&::-webkit-calendar-picker-indicator]:invert" />
          </div>
        </div>
      </div>
    </GlassModal>
  );
}

function DeleteValuationDialog({ open, onOpenChange, item, onConfirm }: any) {
  const { t } = useTranslation();
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[425px] bg-slate-900/90 backdrop-blur-xl border border-red-500/20 shadow-2xl">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2 text-red-500">
            <AlertTriangle className="w-5 h-5" />{t("admin_action_delete", "Delete")}
          </DialogTitle>
          <DialogDescription className="pt-2 text-slate-300">
            {t("admin_auto_are_you_sure_you_want_to_delete", "Are you sure you want to delete")} <span className="font-bold text-white">{item?.propertyName}</span>? {t("admin_auto_this_action_cannot_be_undone", "This action cannot be undone.")}
          </DialogDescription>
        </DialogHeader>
        <DialogFooter className="pt-4 border-t border-white/5">
          <Button variant="ghost" onClick={() => onOpenChange(false)} className="text-slate-300 hover:text-white">{t("admin_action_cancel", "Cancel")}</Button>
          <Button onClick={onConfirm} className="bg-red-500 hover:bg-red-600 text-white shadow-lg shadow-red-500/20">{t("admin_action_delete", "Delete")}</Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
}

export default function PropertyValuationsPage() {
  const { t } = useTranslation();
  const router = useRouter();
  const [searchTerm, setSearchTerm] = useState("");
  const [items, setItems] = useState<Valuation[]>(mockValuations);
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<Valuation | null>(null);
  const [deletingItem, setDeletingItem] = useState<Valuation | null>(null);

  const filteredValuations = items.filter(valuation => 
    valuation.propertyName.toLowerCase().includes(searchTerm.toLowerCase())
  );

  const handleCreate = (data: Omit<Valuation, "id">) => {
    setItems(prev => [...prev, { ...data, id: String(Date.now()) }]);
    setIsCreateOpen(false);
  };
  const handleEdit = (updatedItem: Valuation) => {
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
              <h1 className="text-3xl font-bold text-white mb-2">{t("admin_properties_valuations_title")}</h1>
              <p className="text-gray-400">{t("admin_properties_valuations_description")}</p>
            </div>
            <Button onClick={() => router.push('/admin/dashboard')} className="bg-slate-600 hover:bg-slate-700">
              <ArrowUpRight className="w-4 h-4 mr-2" />{t("admin_properties_valuations_back_to_dashboard")}
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
                    <Input placeholder={t("admin_properties_valuations_search_placeholder")} value={searchTerm} onChange={(e) => setSearchTerm(e.target.value)} className="pl-10 bg-white/10 border-slate-500/30 text-white placeholder:text-gray-400" />
                  </div>
                </div>
                <Button onClick={() => setIsCreateOpen(true)} className="bg-primary hover:bg-primary/90 shadow-md">
                  <Plus className="w-4 h-4 mr-2" />{t("admin_properties_valuations_add", "Add Valuation")}
                </Button>
              </div>
            </CardContent>
          </Card>
        </m.div>

        <m.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 }}>
          <Card className="bg-white/5 backdrop-blur-xl border-slate-500/20">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <BarChart3 className="w-5 h-5 text-primary" />
                {t("admin_properties_valuations_list_title")} ({filteredValuations.length})
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                <AnimatePresence>
                  {filteredValuations.map((valuation) => (
                    <m.div key={valuation.id} layout initial={{ opacity: 0, scale: 0.98 }} animate={{ opacity: 1, scale: 1 }} exit={{ opacity: 0, scale: 0.98 }}
                      className="flex items-center justify-between p-4 bg-white/5 rounded-xl hover:bg-white/10 transition-all border border-transparent hover:border-slate-500/30 group"
                    >
                      <div className="flex items-center gap-4">
                        <div className="w-12 h-12 rounded-lg bg-gradient-to-br from-slate-500/20 to-slate-500/10 border border-slate-500/20 flex items-center justify-center">
                          <Building2 className="w-6 h-6 text-slate-400" />
                        </div>
                        <div>
                          <div className="text-white font-semibold text-lg">{valuation.propertyName}</div>
                          <div className="text-sm text-gray-400 flex items-center gap-2 mt-0.5">
                            <Calendar className="w-3 h-3" />{valuation.lastUpdated}
                          </div>
                        </div>
                      </div>
                      <div className="flex items-center gap-4">
                        <Badge className={TYPE_COLORS[valuation.type]}>{valuation.type.replace("_", " ")}</Badge>
                        <div className="text-right">
                          <div className="text-white font-bold"><DollarSign className="w-4 h-4 inline" />{valuation.currentValue.toLocaleString()}</div>
                          <div className={`text-sm flex items-center gap-1 justify-end ${valuation.change >= 0 ? 'text-green-400' : 'text-red-400'}`}>
                            <TrendingUp className={`w-3 h-3 ${valuation.change < 0 ? 'rotate-180' : ''}`} />
                            {valuation.change >= 0 ? '+' : ''}{valuation.changePercent}%
                          </div>
                        </div>
                        <div className="flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                          <Button onClick={() => setEditingItem(valuation)} variant="outline" size="icon" className="h-9 w-9 bg-white/5 hover:bg-white/10 border-slate-500/30">
                            <Edit className="w-4 h-4 text-white/70" />
                          </Button>
                          <Button onClick={() => setDeletingItem(valuation)} variant="outline" size="icon" className="h-9 w-9 bg-white/5 hover:bg-red-500/10 border-slate-500/30 hover:border-red-500/30 group/btn">
                            <Trash2 className="w-4 h-4 text-red-500/70 group-hover/btn:text-red-500" />
                          </Button>
                        </div>
                      </div>
                    </m.div>
                  ))}
                </AnimatePresence>
                {filteredValuations.length === 0 && (
                  <div className="py-12 text-center text-slate-500">{t("admin_auto_no_results_found", "No results found")}</div>
                )}
              </div>
            </CardContent>
          </Card>
        </m.div>

        <CreateValuationDialog open={isCreateOpen} onOpenChange={setIsCreateOpen} onSubmit={handleCreate} />
        {editingItem && <EditValuationDialog open={!!editingItem} onOpenChange={(open: boolean) => !open && setEditingItem(null)} item={editingItem} onSubmit={handleEdit} />}
        {deletingItem && <DeleteValuationDialog open={!!deletingItem} onOpenChange={(open: boolean) => !open && setDeletingItem(null)} item={deletingItem} onConfirm={() => handleDelete(deletingItem.id)} />}
      </div>
    </div>
  );
}
