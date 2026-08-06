"use client";
import React from 'react';

import { useState, useEffect, useCallback } from"react";
import { useTranslation } from"react-i18next";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Badge } from"@/components/ui/badge";
import { Switch } from"@/components/ui/switch";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from"@/components/ui/dialog";
import { Textarea } from"@/components/ui/textarea";
import { notificationTemplatesApi } from"@/lib/api/notification-templates";
import { Plus, Edit, Trash2 } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { useMutation, useQueryClient } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import { MoreHorizontal } from"lucide-react";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";

const CHANNELS = ["EMAIL","SMS","IN_APP","PUSH","WHATSAPP","SLACK","TEAMS"];

const EMPTY_FORM = {
 name:"",
 description:"",
 channel:"EMAIL",
 subject:"",
 body:"",
 variables:"",
 isActive: true,
};

export default function NotificationTemplates() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const [editingId, setEditingId] = React.useState<string | null>(null);

 const updateMutation = useMutation({
 mutationFn: async (data: any) => apiClient.put(`/admin/notificationtemplates/${data.id}`, data),
 onSuccess: () => { toast({ title:"Updated", description:"Record updated successfully" }); queryClient.invalidateQueries(); setEditingId(null); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });

 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/admin/notificationtemplates/${id}`),
 onSuccess: () => { toast({ title:"Deleted", description:"Record deleted successfully" }); queryClient.invalidateQueries(); },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 
 const { t } = useTranslation();
 const [templates, setTemplates] = useState<any[]>([]);
 const [total, setTotal] = useState(0);
 const [page, setPage] = useState(1);
 const [limit] = useState(20);
 const [channel, setChannel] = useState("");
 const [loading, setLoading] = useState(false);
 const [createOpen, setCreateOpen] = useState(false);
 const [editOpen, setEditOpen] = useState(false);
 const [form, setForm] = useState<any>(EMPTY_FORM);
 const load = useCallback(async () => {
 setLoading(true);
 try {
 const res: any = await notificationTemplatesApi.list({ page, limit, channel: channel || undefined });
 setTemplates(res.data || []);
 setTotal(res.total || 0);
 } catch (e) {
 console.error(e);
 } finally {
 setLoading(false);
 }
 }, [page, limit, channel]);

 useEffect(() => { load(); }, [load]);

 const totalPages = Math.ceil(total / limit);

 const handleCreate = async (e: React.FormEvent) => {
 e.preventDefault();
 try {
 const data = { ...form, variables: form.variables ? form.variables.split(",").map((v: string) => v.trim()) : [] };
 await notificationTemplatesApi.create(data);
 toast({ title: t("admin_system_template_created") });
 setCreateOpen(false);
 setForm(EMPTY_FORM);
 load();
 } catch (err: any) {
 toast({ title: err.message || t("admin_system_error"), variant:"destructive" });
 }
 };

 const handleEdit = async (e: React.FormEvent) => {
 e.preventDefault();
 if (!editingId) return;
 try {
 const data = { ...form, variables: form.variables ? form.variables.split(",").map((v: string) => v.trim()) : [] };
 await notificationTemplatesApi.update(editingId, data);
 toast({ title: t("admin_system_template_updated") });
 setEditOpen(false);
 setForm(EMPTY_FORM);
 setEditingId(null);
 load();
 } catch (err: any) {
 toast({ title: err.message || t("admin_system_error"), variant:"destructive" });
 }
 };

 const handleDelete = async (id: string) => {
 if (!confirm(t("admin_system_confirm_delete"))) return;
 try {
 await notificationTemplatesApi.delete(id);
 toast({ title: t("admin_system_template_deleted") });
 load();
 } catch (err: any) {
 toast({ title: err.message || t("admin_system_error"), variant:"destructive" });
 }
 };

 const openEdit = async (row: any) => {
 try {
 const res: any = await notificationTemplatesApi.getById(row.id);
 const tmpl = res.data || res;
 setForm({
 name: tmpl.name ||"",
 description: tmpl.description ||"",
 channel: tmpl.channel ||"EMAIL",
 subject: tmpl.subject ||"",
 body: tmpl.body ||"",
 variables: Array.isArray(tmpl.variables) ? tmpl.variables.join(",") :"",
 isActive: tmpl.isActive ?? true,
 });
 setEditingId(tmpl.id);
 setEditOpen(true);
 } catch (err) {
 console.error(err);
 }
 };

 const EntityForm = ({ onSubmit, label }: { onSubmit: (e: React.FormEvent) => void; label: string }) => (
 <form onSubmit={onSubmit} className="space-y-4">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_system_template_name")}</Label>
 <Input value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} required />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_system_channel")}</Label>
 <Select value={form.channel} onValueChange={(v) => setForm({ ...form, channel: v })}>
 <SelectTrigger>
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 {CHANNELS.map((ch) => (
 <SelectItem key={ch} value={ch}>{ch}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_system_description")}</Label>
 <Input value={form.description} onChange={(e) => setForm({ ...form, description: e.target.value })} />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_system_subject")}</Label>
 <Input value={form.subject} onChange={(e) => setForm({ ...form, subject: e.target.value })} />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_system_body")}</Label>
 <Textarea
 value={form.body}
 onChange={(e) => setForm({ ...form, body: e.target.value })}
 rows={6}
 required
 />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_system_variables")}</Label>
 <Input
 value={form.variables}
 onChange={(e) => setForm({ ...form, variables: e.target.value })}
 placeholder={t("admin_auto_name_email_propertyname", "ad, e-posta, mülkAdı")}
 />
 <p className="text-xs text-muted-foreground">{t("admin_system_variables_hint")}</p>
 </div>
 <div className="flex items-center gap-2">
 <Switch
 checked={form.isActive}
 onCheckedChange={(v) => setForm({ ...form, isActive: v })}
 />
 <Label>{t("admin_system_active")}</Label>
 </div>
 <DialogFooter>
 <Button type="submit">{label}</Button>
 </DialogFooter>
 </form>
 );

 return (
 <PageShell title={t("admin_system_notification_templates")}>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-4">
 <div className="flex items-center justify-between">
 <div className="flex gap-3">
 <Select value={channel} onValueChange={(v) => { setChannel(v); setPage(1); }}>
 <SelectTrigger className="w-[180px]">
 <SelectValue placeholder={t("admin_system_all_channels")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="">{t("admin_system_all_channels")}</SelectItem>
 {CHANNELS.map((ch) => (
 <SelectItem key={ch} value={ch}>{ch}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 </div>
 <Button onClick={() => { setForm(EMPTY_FORM); setCreateOpen(true); }}>
 <Plus className="h-4 w-4 mr-2" />{t("admin_system_new_template")}
 </Button>
 </div>

 <div className="border rounded-lg">
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_system_template_name")}</TableHead>
 <TableHead>{t("admin_system_channel")}</TableHead>
 <TableHead>{t("admin_system_subject")}</TableHead>
 <TableHead>{t("admin_system_active")}</TableHead>
 <TableHead className="w-24">{t("admin_system_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {templates.length === 0 ? (
 <TableRow>
 <TableCell colSpan={5} className="text-center py-8 text-muted-foreground">
 {loading ? t("admin_system_loading") : t("admin_system_no_templates")}
 </TableCell>
 </TableRow>
 ) : templates.map((tmpl: any) => (
 <TableRow key={tmpl.id}>
 <TableCell className="font-medium">{tmpl.name}</TableCell>
 <TableCell><Badge variant="outline">{tmpl.channel}</Badge></TableCell>
 <TableCell className="text-sm max-w-[200px] truncate">{tmpl.subject ||"-"}</TableCell>
 <TableCell>
 <span className={`px-2 py-0.5 rounded-lg text-xs font-medium ${tmpl.isActive ?"bg-blue-100 text-blue-800" :"bg-card text-muted-foreground"}`}>
 {tmpl.isActive ? t("admin_system_yes") : t("admin_system_no")}
 </span>
 </TableCell>
 <TableCell>
 <div className="flex gap-1">
 <Button variant="ghost" size="sm" onClick={() => openEdit(tmpl)} aria-label={t("common.edit")}>
 <Edit className="h-4 w-4" />
 </Button>
 <Button variant="ghost" size="sm" onClick={() => handleDelete(tmpl.id)} aria-label={t("common.delete")}>
 <Trash2 className="h-4 w-4 text-red-500" />
 </Button>
 </div>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </div>

 {totalPages > 1 && (
 <div className="flex items-center justify-between">
 <span className="text-sm text-muted-foreground">{t("admin_system_total_templates", { count: total })}</span>
 <div className="flex gap-2">
 <Button variant="outline" size="sm" disabled={page <= 1} onClick={() => setPage(p => p - 1)}>
 {t("admin_system_previous")}
 </Button>
 <span className="flex items-center text-sm">{page} {t("/", "/")}{totalPages}</span>
 <Button variant="outline" size="sm" disabled={page >= totalPages} onClick={() => setPage(p => p + 1)}>
 {t("admin_system_next")}
 </Button>
 </div>
 </div>
 )}
 </div>

 <Dialog open={createOpen} onOpenChange={setCreateOpen}>
 <DialogContent className="max-w-lg">
 <DialogHeader>
 <DialogTitle>{t("admin_system_new_template")}</DialogTitle>
 </DialogHeader>
 <EntityForm onSubmit={handleCreate} label={t("admin_system_create")} />
 </DialogContent>
 </Dialog>

 <Dialog open={editOpen} onOpenChange={setEditOpen}>
 <DialogContent className="max-w-lg">
 <DialogHeader>
 <DialogTitle>{t("admin_system_edit_template")}</DialogTitle>
 </DialogHeader>
 <EntityForm onSubmit={handleEdit} label={t("admin_system_update")} />
 </DialogContent>
 </Dialog>
 </PageShell>
 );
}
