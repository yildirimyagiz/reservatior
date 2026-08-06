"use client";
import { apiClient } from '@/lib/api/client';
import { useMutation, useQueryClient } from '@tanstack/react-query';

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { useToast } from"@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw, Tag, DollarSign, Calendar, CheckCircle2, Clock } from"lucide-react";
import { Badge } from"@/components/ui/badge";
import { Textarea } from"@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { extraChargeApi, type ExtraCharge, ExtraChargeType } from"@/lib/api/extra-charges";
const EMPTY_FORM = {
 propertyId:"",
 reservationId:"",
 name:"",
 description:"",
 amount:"",
 chargeType: ExtraChargeType.OTHER,
 isPaid: false
};
export default function ExtraCharges() {
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/unknown/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 

 
 
 
 const {
 t
 } = useTranslation();
 const [search, setSearch] = useState("");
 const [charges, setCharges] = useState<ExtraCharge[]>([]);
 const [loading, setLoading] = useState(true);
 const [createOpen, setCreateOpen] = useState(false);
 const [editOpen, setEditOpen] = useState(false);
 const [form, setForm] = useState<any>(EMPTY_FORM);
 const [selectedCharge, setSelectedCharge] = useState<ExtraCharge | null>(null);
 const fetchCharges = async () => {
 try {
 setLoading(true);
 const response = (await extraChargeApi.getCharges()) as any;
 setCharges(Array.isArray(response) ? response : response?.data || []);
 } catch (error) {
 toast({
 title: t("admin_financial_error"),
 description: t("admin_financial_failed_to_load_extra"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 useEffect(() => {
 fetchCharges();
 }, []);
 const filtered = charges.filter(row => row.name.toLowerCase().includes(search.toLowerCase()) || row.chargeType.toLowerCase().includes(search.toLowerCase()) || (row.description ||"").toLowerCase().includes(search.toLowerCase()));
 const handleCreate = async (e: React.FormEvent) => {
 e.preventDefault();
 try {
 if (!form.propertyId || !form.name || !form.amount) {
 toast({
 title: t("admin_financial_validation_error"),
 description: t("admin_financial_missing_required_fields"),
 variant:"destructive"
 });
 return;
 }
 await extraChargeApi.createCharge({
 ...form,
 amount: parseFloat(form.amount),
 reservationId: form.reservationId || undefined
 } as any);
 setCreateOpen(false);
 toast({
 title: t("admin_financial_extra_charge_added")
 });
 setForm(EMPTY_FORM);
 fetchCharges();
 } catch (error) {
 toast({
 title: t("admin_financial_error"),
 description: t("admin_financial_failed_to_add_charge"),
 variant:"destructive"
 });
 }
 };
 const handleEdit = async (e: React.FormEvent) => {
 e.preventDefault();
 if (!selectedCharge) return;
 try {
 await extraChargeApi.updateCharge(selectedCharge.id, {
 ...form,
 amount: parseFloat(form.amount),
 reservationId: form.reservationId || undefined
 });
 setEditOpen(false);
 toast({
 title: t("admin_financial_extra_charge_updated")
 });
 fetchCharges();
 } catch (error) {
 toast({
 title: t("admin_financial_error"),
 description: t("admin_financial_failed_to_update_charge"),
 variant:"destructive"
 });
 }
 };
 const handleDelete = async (id: string) => {
 if (!confirm(t("admin_financial_are_you_sure","Emin misiniz?"))) return;
 try {
 await extraChargeApi.deleteCharge(id);
 toast({
 title: t("admin_financial_charge_deleted")
 });
 fetchCharges();
 } catch (error) {
 toast({
 title: t("admin_financial_error"),
 description: t("admin_financial_failed_to_delete_charge"),
 variant:"destructive"
 });
 }
 };
 const openEdit = (row: ExtraCharge) => {
 setSelectedCharge(row);
 setForm({
 propertyId: row.propertyId,
 reservationId: row.reservationId ||"",
 name: row.name,
 description: row.description ||"",
 amount: row.amount.toString(),
 chargeType: row.chargeType,
 isPaid: row.isPaid
 });
 setEditOpen(true);
 };
 const ChargeForm = ({
 onSubmit,
 label
 }: {
 onSubmit: (e: React.FormEvent) => void;
 label: string;
 }) => {
 const {
 t
 } = useTranslation();
 return <form onSubmit={onSubmit} className="space-y-4 py-2 text-sm">
 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_financial_property_id")}</Label>
 <Input placeholder={t("admin_financial_prop_id")} value={form.propertyId} onChange={e => setForm({
 ...form,
 propertyId: e.target.value
 })} required />
 </div>
 <div className="space-y-2">
 <Label>{t("admin_financial_reservation_id_optional")}</Label>
 <Input placeholder={t("admin_financial_res_id")} value={form.reservationId} onChange={e => setForm({
 ...form,
 reservationId: e.target.value
 })} />
 </div>
 </div>
 
 <div className="space-y-2">
 <Label>{t("admin_financial_charge_name")}</Label>
 <Input placeholder={t("admin_financial_eg_pet_fee")} value={form.name} onChange={e => setForm({
 ...form,
 name: e.target.value
 })} required />
 </div>

 <div className="grid grid-cols-2 gap-4">
 <div className="space-y-2">
 <Label>{t("admin_financial_amount")}</Label>
 <div className="relative">
 <DollarSign className="absolute left-2.5 top-2.5 h-4 w-4 text-muted-foreground" />
 <Input type="number" step="0.01" className="pl-8" placeholder="0.00" value={form.amount} onChange={e => setForm({
 ...form,
 amount: e.target.value
 })} required />
 </div>
 </div>
 <div className="space-y-2">
 <Label>{t("admin_financial_charge_type")}</Label>
 <Select value={form.chargeType} onValueChange={v => setForm({
 ...form,
 chargeType: v
 })}>
 <SelectTrigger><SelectValue /></SelectTrigger>
 <SelectContent>
 {Object.entries(ExtraChargeType).map(([key, val]) => <SelectItem key={val} value={val}>{key.replace('_', ' ')}</SelectItem>)}
 </SelectContent>
 </Select>
 </div>
 </div>

 <div className="flex items-center space-x-2 py-1">
 <input type="checkbox" id="isPaid" checked={form.isPaid} onChange={e => setForm({
 ...form,
 isPaid: e.target.checked
 })} className="rounded-lg border-border text-primary focus:ring-primary h-4 w-4" />
 <Label htmlFor="isPaid" className="cursor-pointer">{t("admin_financial_payment_has_been_received")}</Label>
 </div>

 <div className="space-y-2">
 <Label>{t("admin_financial_description")}</Label>
 <Textarea placeholder={t("admin_financial_note_about_this_charge")} value={form.description} onChange={e => setForm({
 ...form,
 description: e.target.value
 })} rows={3} />
 </div>

 <DialogFooter className="pt-4">
 <Button variant="outline" type="button" onClick={() => {
 setCreateOpen(false);
 setEditOpen(false);
 }}>{t("admin_financial_cancel")}</Button>
 <Button type="submit">{label}</Button>
 </DialogFooter>
 </form>;
 };
 return <>
 <PageShell title={t("admin_financial_extra_charges")} description={t("admin_financial_manage_additional_fees_damage")} createLabel={t("admin_financial_add_extra_charge","Ek Ücret Ekle")} onCreateClick={() => {
 setForm(EMPTY_FORM);
 setCreateOpen(true);
 }} searchValue={search} onSearchChange={setSearch} searchPlaceholder={t("admin_financial_search_charges","Ücretlerde ara...")} stats={[{
 label: t("admin_financial_total_charges"),
 value: charges.length
 }, {
 label: t("admin_financial_paid"),
 value: charges.filter(r => r.isPaid).length
 }, {
 label: t("admin_financial_unpaid"),
 value: charges.filter(r => !r.isPaid).length
 }, {
 label: t("admin_financial_total_value"),
 value: `$${charges.reduce((s, r) => s + r.amount, 0).toLocaleString()}`
 }]} actions={<Button variant="outline" size="icon" aria-label={t("common.refresh")} className="h-9 w-9" onClick={fetchCharges} disabled={loading}>
 <RefreshCw className={`h-4 w-4 ${loading ? 'animate-spin' : ''}`} />
 </Button>}>
 <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_financial_charge_details")}</TableHead>
 <TableHead>{t("admin_financial_type")}</TableHead>
 <TableHead>{t("admin_financial_target")}</TableHead>
 <TableHead>{t("admin_financial_amount")}</TableHead>
 <TableHead>{t("admin_financial_status")}</TableHead>
 <TableHead>{t("admin_financial_date")}</TableHead>
 <TableHead className="w-10" />
 </TableRow>
 </TableHeader>
 <TableBody>
 {loading ? <TableRow><TableCell colSpan={7} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("admin_financial_no_extra_charges_found")}</TableCell></TableRow> : filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40 transition-colors">
 <TableCell>
 <div className="flex items-center gap-2">
 <Tag className="w-4 h-4 text-primary" />
 <div>
 <div className="font-semibold text-sm">{row.name}</div>
 <div className="text-[11px] text-muted-foreground truncate max-w-[200px]">{row.description ||"—"}</div>
 </div>
 </div>
 </TableCell>
 <TableCell>
 <Badge variant="outline" className="text-[10px] capitalize bg-muted/50 border-0">{row.chargeType.replace('_', ' ')}</Badge>
 </TableCell>
 <TableCell>
 <div className="text-xs">
 {row.reservationId ? <div className="flex items-center gap-1 text-primary font-medium">
 <Calendar className="w-3 h-3" />{t("admin_financial_res")}{row.reservationId.slice(0, 8)}...
 </div> : <div className="flex items-center gap-1 text-muted-foreground">
 <Building2 className="w-3 h-3" />{t("admin_financial_prop")}{row.propertyId.slice(0, 8)}...
 </div>}
 </div>
 </TableCell>
 <TableCell className="text-sm font-bold text-card-foreground">
 {t("currency_symbol", "$")}{row.amount.toLocaleString(undefined, {
 minimumFractionDigits: 2
 })}
 </TableCell>
 <TableCell>
 {row.isPaid ? <div className="flex items-center gap-1 text-[11px] text-blue-600 font-medium bg-blue-50 px-2 py-0.5 rounded-full w-fit">
 <CheckCircle2 className="w-3 h-3" />{t("admin_financial_paid")}</div> : <div className="flex items-center gap-1 text-[11px] text-yellow-600 font-medium bg-yellow-50 px-2 py-0.5 rounded-full w-fit">
 <Clock className="w-3 h-3" />{t("admin_financial_unpaid")}</div>}
 </TableCell>
 <TableCell className="text-[11px] text-muted-foreground">
 {new Date(row.createdAt).toLocaleDateString()}
 </TableCell>
 <TableCell>
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end" className="w-32">
 <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("admin_financial_edit")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive font-medium"><Trash2 className="w-4 h-4 mr-2" />{t("admin_financial_delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>)}
 </TableBody>
 </Table>
 </div>
 </PageShell>

 <Dialog open={createOpen} onOpenChange={setCreateOpen}>
 <DialogContent className="sm:max-w-md max-h-[90vh] overflow-y-auto">
 <DialogHeader>
 <DialogTitle>{t("admin_financial_add_extra_charge")}</DialogTitle>
 <DialogDescription>{t("admin_financial_create_a_new_additional")}</DialogDescription>
 </DialogHeader>
 <ChargeForm onSubmit={handleCreate} label={t("admin_financial_add_charge")} />
 </DialogContent>
 </Dialog>

 <Dialog open={editOpen} onOpenChange={setEditOpen}>
 <DialogContent className="sm:max-w-md max-h-[90vh] overflow-y-auto">
 <DialogHeader>
 <DialogTitle>{t("admin_financial_edit_extra_charge")}</DialogTitle>
 <DialogDescription>{t("admin_financial_update_the_details_for")}</DialogDescription>
 </DialogHeader>
 <ChargeForm onSubmit={handleEdit} label={t("admin_financial_save_changes")} />
 </DialogContent>
 </Dialog>
 </>;
}
const Building2 = ({
 className
}: {
 className?: string;
}) => <svg className={className} xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><rect width="16" height="20" x="4" y="2" rx="2" ry="2" /><path d="M9 22v-4h6v4" /><path d="M8 6h.01" /><path d="M16 6h.01" /><path d="M8 10h.01" /><path d="M16 10h.01" /><path d="M8 14h.01" /><path d="M16 14h.01" /></svg>;