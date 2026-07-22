"use client";

import { t } from "i18next";
import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { useTranslation } from "react-i18next";
import { m, AnimatePresence } from "framer-motion";
import { cn } from "@/lib/utils";
import { Plus, Edit, Trash2, Settings, BarChart3, Users, Calendar, DollarSign, MapPin, TrendingUp, Activity as ActivityIcon } from "lucide-react";
import { dashboardWidgetsApi } from "@/lib/api/dashboard-widgets";
import { toast } from "@/components/hooks/use-toast";
import { DashboardWidget } from "@/lib/store/dashboard-widgets-store";
const WIDGET_TYPES = (t: any) => {
  return [{
    value: "STATS_CARD",
    label: t("client.dashboardWidgets.types"),
    icon: BarChart3
  }, {
    value: "CHART",
    label: t("chart"),
    icon: TrendingUp
  }, {
    value: "USER_LIST",
    label: t("users"),
    icon: Users
  }, {
    value: "CALENDAR",
    label: t("calendar"),
    icon: Calendar
  }, {
    value: "FINANCIAL_SUMMARY",
    label: t("dashboardWidgetsTypesFinancial"),
    icon: DollarSign
  }, {
    value: "MAP_WIDGET",
    label: t("dashboardWidgetsTypesMap"),
    icon: MapPin
  }, {
    value: "RECENT_ACTIVITY",
    label: t("activity"),
    icon: ActivityIcon
  }];
};
export default function DashboardWidgets() {
  const {
    t
  } = useTranslation();
  const [widgets, setWidgets] = useState<DashboardWidget[]>([]);
  const [loading, setLoading] = useState(true);
  const [createDialogOpen, setCreateDialogOpen] = useState(false);
  const [editDialogOpen, setEditDialogOpen] = useState(false);
  const [currentWidget, setCurrentWidget] = useState<DashboardWidget | null>(null);
  const [formData, setFormData] = useState({
    widgetType: "",
    title: "",
    config: "{}",
    position: '{"x": 0, "y": 0, "width": 4, "height": 2}',
    isVisible: true
  });
  useEffect(() => {
    loadWidgets();
  }, []);
  const loadWidgets = async () => {
    try {
      const response = (await dashboardWidgetsApi.getAll()) as {
        data: DashboardWidget[];
      };
      setWidgets(response.data || []);
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("loadError"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const handleCreate = async () => {
    try {
      const config = JSON.parse(formData.config);
      const position = JSON.parse(formData.position);
      await dashboardWidgetsApi.create({
        widgetType: formData.widgetType,
        title: formData.title,
        config,
        position
      });
      toast({
        title: t("client.src.success"),
        description: t("createSuccess")
      });
      setCreateDialogOpen(false);
      resetForm();
      loadWidgets();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("createError"),
        variant: "destructive"
      });
    }
  };
  const handleUpdate = async () => {
    if (!currentWidget) return;
    try {
      const config = JSON.parse(formData.config);
      const position = JSON.parse(formData.position);
      await dashboardWidgetsApi.update(currentWidget.id, {
        widgetType: formData.widgetType,
        title: formData.title,
        config,
        position
      });
      toast({
        title: t("client.src.success"),
        description: t("updateSuccess")
      });
      setEditDialogOpen(false);
      resetForm();
      loadWidgets();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("updateError"),
        variant: "destructive"
      });
    }
  };
  const handleDelete = async (id: string) => {
    if (!confirm(t("confirmDelete"))) return;
    try {
      await dashboardWidgetsApi.delete(id);
      toast({
        title: t("client.src.success"),
        description: t("deleteSuccess")
      });
      loadWidgets();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("deleteError"),
        variant: "destructive"
      });
    }
  };
  const openEditDialog = (widget: DashboardWidget) => {
    setCurrentWidget(widget);
    setFormData({
      widgetType: widget.widgetType,
      title: widget.title || "",
      config: JSON.stringify(widget.config, null, 2),
      position: JSON.stringify(widget.position, null, 2),
      isVisible: true
    });
    setEditDialogOpen(true);
  };
  const resetForm = () => {
    setFormData({
      widgetType: "",
      title: "",
      config: "{}",
      position: '{"x": 0, "y": 0, "width": 4, "height": 2}',
      isVisible: true
    });
    setCurrentWidget(null);
  };
  if (loading) {
    return <div className="flex flex-col items-center justify-center min-h-[60vh] gap-6">
        <ActivityIcon className="w-12 h-12 text-blue-500 animate-pulse" />
        <p className="text-[10px] font-black tracking-[0.3em] italic text-slate-600">{t("loading")}</p>
      </div>;
  }
  return <div className="p-8 lg:p-12 space-y-12 max-w-[1600px] mx-auto bg-[#14151a] min-h-screen">
      <header className="relative py-12 px-10 rounded-[40px] bg-[#1a1b1e]/40 border border-white/5 border-l border-t overflow-hidden shadow-3xl">
         <div className="absolute top-0 right-0 p-40 opacity-5 pointer-events-none text-blue-600">
            <Settings className="w-96 h-96" />
         </div>
         
         <div className="relative z-10 flex flex-col md:flex-row items-center justify-between gap-10">
            <div className="space-y-2">
               <h1 className="text-5xl font-black text-white italic tracking-tighter leading-none">{t("dashboardWidgetsTitle")}</h1>
               <p className="text-lg font-black text-slate-500 italic tracking-widest leading-none mt-2">{t("dashboardWidgetsSubtitle")}</p>
            </div>
            
            <Button onClick={() => setCreateDialogOpen(true)} className="h-16 px-10 rounded-2xl bg-white text-black hover:bg-slate-200 font-black italic text-xs tracking-widest shadow-xl transition-all hover:scale-105 active:scale-95">
               <Plus className="w-4 h-4 mr-3" />
               {t("addWidget")}
            </Button>
         </div>
      </header>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        {widgets.map((widget, idx) => {
        const widgetType = WIDGET_TYPES(t).find(t => t.value === widget.widgetType);
        const Icon = widgetType?.icon || Settings;
        return <m.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: idx * 0.1
        }} key={widget.id}>
              <Card className="border-white/5 bg-[#1a1b1e]/60 backdrop-blur-3xl hover:bg-white/5 transition-all group rounded-[32px] overflow-hidden shadow-2xl relative border-l border-t h-full">
                <CardHeader className="p-8 pb-4">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-4">
                      <div className="p-3 rounded-xl bg-black/40 border border-white/5 text-blue-400 group-hover:scale-110 transition-transform">
                        <Icon className="w-5 h-5" />
                      </div>
                      <div>
                        <CardTitle className="text-lg font-black text-white italic tracking-tighter">{widget.title}</CardTitle>
                        <Badge className="bg-blue-500/10 text-blue-400 border-none text-[8px] font-black italic tracking-widest mt-1">
                          {widgetType?.label || widget.widgetType}
                        </Badge>
                      </div>
                    </div>
                    <div className="flex gap-2">
                      <Button variant="ghost" className="h-10 w-10 p-0 rounded-xl bg-white/5 hover:bg-white/10" onClick={() => openEditDialog(widget)}>
                        <Edit className="w-4 h-4 text-slate-400" />
                      </Button>
                      <Button variant="ghost" className="h-10 w-10 p-0 rounded-xl bg-white/5 hover:bg-red-500/20" onClick={() => handleDelete(widget.id)}>
                        <Trash2 className="w-4 h-4 text-red-400/60" />
                      </Button>
                    </div>
                  </div>
                </CardHeader>
                <CardContent className="p-8 pt-4 space-y-6">
                  <div className="grid grid-cols-2 gap-4 pt-6 border-t border-white/5">
                    <div className="space-y-1">
                      <p className="text-[9px] font-black text-slate-500 tracking-widest italic">{t("dashboardWidgetsCardPosition")}</p>
                      <p className="text-sm font-black text-white italic font-mono">
                        {(widget.position as any)?.x || 0},{" "}{(widget.position as any)?.y || 0}
                      </p>
                    </div>
                    <div className="space-y-1">
                      <p className="text-[9px] font-black text-slate-500 tracking-widest italic">{t("size")}</p>
                      <p className="text-sm font-black text-white italic font-mono">
                        {(widget.position as any)?.width || 4}x{(widget.position as any)?.height || 2}
                      </p>
                    </div>
                  </div>
                  <div className="space-y-1">
                    <p className="text-[9px] font-black text-slate-500 tracking-widest italic">{t("dashboardWidgetsCardCreated")}</p>
                    <p className="text-xs font-black text-slate-400 italic">
                      {new Date((widget as any).createdAt).toLocaleDateString()}
                    </p>
                  </div>
                </CardContent>
              </Card>
            </m.div>;
      })}
      </div>

      {/* Create Dialog */}
      <Dialog open={createDialogOpen} onOpenChange={setCreateDialogOpen}>
        <DialogContent className="bg-[#1a1b1e] border-white/10 text-white rounded-[40px] sm:max-w-2xl p-0 overflow-hidden">
          <DialogHeader className="p-10 pb-0">
            <DialogTitle className="text-2xl font-black italic tracking-tighter">{t("createTitle")}</DialogTitle>
            <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic">
              {t("dashboardWidgetsCreatedesc")}
            </DialogDescription>
          </DialogHeader>
          <div className="p-10 space-y-8">
            <div className="grid md:grid-cols-2 gap-8">
              <div className="space-y-2">
                <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("dashboardWidgetsFieldsType")}</Label>
                <Select value={formData.widgetType} onValueChange={value => setFormData({
                ...formData,
                widgetType: value
              })}>
                  <SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-white italic">
                    <SelectValue placeholder={t("typePlaceholder")} />
                  </SelectTrigger>
                  <SelectContent className="bg-[#1a1b1e] border-white/10 font-display">
                    {WIDGET_TYPES(t).map(type => <SelectItem key={type.value} value={type.value} className="text-slate-400 font-bold italic">
                        <div className="flex items-center gap-2">
                          <type.icon className="w-4 h-4" />
                          {type.label}
                        </div>
                      </SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("dashboardWidgetsFieldsTitle")}</Label>
                <Input className="h-14 bg-black/40 border-white/5 rounded-2xl text-white placeholder:text-slate-700 font-bold italic" value={formData.title} onChange={e => setFormData({
                ...formData,
                title: e.target.value
              })} placeholder={t("dashboardWidgetsFieldsTitleplaceholder")} />
              </div>
            </div>
            <div className="space-y-2">
              <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("config")}</Label>
              <Textarea className="bg-black/40 border-white/5 rounded-3xl text-white placeholder:text-slate-700 font-mono text-xs italic p-6" value={formData.config} onChange={e => setFormData({
              ...formData,
              config: e.target.value
            })} placeholder={t("configPlaceholder")} rows={4} />
            </div>
            <div className="space-y-2">
              <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("dashboardWidgetsFieldsPosition")}</Label>
              <Textarea className="bg-black/40 border-white/5 rounded-3xl text-white placeholder:text-slate-700 font-mono text-xs italic p-6" value={formData.position} onChange={e => setFormData({
              ...formData,
              position: e.target.value
            })} placeholder={t("positionPlaceholder")} rows={2} />
            </div>
            <div className="flex gap-4 pt-4">
               <Button variant="ghost" onClick={() => setCreateDialogOpen(false)} className="h-16 px-8 text-[10px] font-black italic text-slate-500">{t("abort")}</Button>
               <Button onClick={handleCreate} className="flex-1 h-16 rounded-[24px] bg-blue-600 hover:bg-blue-500 text-white font-black text-xs italic tracking-widest shadow-xl shadow-blue-600/20">
                 {t("commit")}
               </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>

      {/* Edit Dialog */}
      <Dialog open={editDialogOpen} onOpenChange={setEditDialogOpen}>
        <DialogContent className="bg-[#1a1b1e] border-white/10 text-white rounded-[40px] sm:max-w-2xl p-0 overflow-hidden">
          <DialogHeader className="p-10 pb-0">
            <DialogTitle className="text-2xl font-black italic tracking-tighter">{t("editTitle")}</DialogTitle>
            <DialogDescription className="text-[10px] font-black text-slate-500 tracking-widest italic">{t("editDesc")}</DialogDescription>
          </DialogHeader>
          <div className="p-10 space-y-8">
            <div className="grid md:grid-cols-2 gap-8">
              <div className="space-y-2">
                <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("dashboardWidgetsFieldsType")}</Label>
                <Select value={formData.widgetType} onValueChange={value => setFormData({
                ...formData,
                widgetType: value
              })}>
                  <SelectTrigger className="h-14 bg-black/40 border-white/5 rounded-2xl text-white italic">
                    <SelectValue placeholder={t("typePlaceholder")} />
                  </SelectTrigger>
                  <SelectContent className="bg-[#1a1b1e] border-white/10 font-display">
                    {WIDGET_TYPES(t).map(type => <SelectItem key={type.value} value={type.value} className="text-slate-400 font-bold italic">
                        <div className="flex items-center gap-2">
                          <type.icon className="w-4 h-4" />
                          {type.label}
                        </div>
                      </SelectItem>)}
                  </SelectContent>
                </Select>
              </div>
              <div className="space-y-2">
                <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("dashboardWidgetsFieldsTitle")}</Label>
                <Input className="h-14 bg-black/40 border-white/5 rounded-2xl text-white placeholder:text-slate-700 font-bold italic" value={formData.title} onChange={e => setFormData({
                ...formData,
                title: e.target.value
              })} placeholder={t("dashboardWidgetsFieldsTitleplaceholder")} />
              </div>
            </div>
            <div className="space-y-2">
              <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("config")}</Label>
              <Textarea className="bg-black/40 border-white/5 rounded-3xl text-white placeholder:text-slate-700 font-mono text-xs italic p-6" value={formData.config} onChange={e => setFormData({
              ...formData,
              config: e.target.value
            })} placeholder={t("configPlaceholder")} rows={4} />
            </div>
            <div className="space-y-2">
              <Label className="text-[10px] font-black text-slate-400 tracking-widest italic">{t("dashboardWidgetsFieldsPosition")}</Label>
              <Textarea className="bg-black/40 border-white/5 rounded-3xl text-white placeholder:text-slate-700 font-mono text-xs italic p-6" value={formData.position} onChange={e => setFormData({
              ...formData,
              position: e.target.value
            })} placeholder={t("positionPlaceholder")} rows={2} />
            </div>
            <div className="flex gap-4 pt-4">
              <Button variant="ghost" onClick={() => setEditDialogOpen(false)} className="h-16 px-8 text-[10px] font-black italic text-slate-500">{t("abort")}</Button>
              <Button onClick={handleUpdate} className="flex-1 h-16 rounded-[24px] bg-blue-600 hover:bg-blue-500 text-white font-black text-xs italic tracking-widest shadow-xl shadow-blue-600/20">
                {t("dashboardWidgetsUpdate")}
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </div>;
}