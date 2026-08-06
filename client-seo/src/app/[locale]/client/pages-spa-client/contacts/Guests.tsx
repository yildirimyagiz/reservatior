"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, Loader2 } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { guestsApi } from "@/lib/api/guests";
import { apiClient } from "@/lib/api/client";

const EMPTY_FORM = {
  name: "",
  email: "",
  phone: "",
  nationality: "",
  gender: "",
  passportNumber: "",
  birthDate: ""
};
export default function Guests() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const queryClient = useQueryClient();

  const { data: rawData, isLoading } = useQuery({
    queryKey: ['guests-contacts'],
    queryFn: async () => {
      const response = await guestsApi.getAll() as any;
      return (response.data || []) as any[];
    }
  });

  const guestsData = rawData || [];
  const filtered = guestsData.filter(row => String(row.name ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.email ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.nationality ?? "").toLowerCase().includes(search.toLowerCase()));

  const createMutation = useMutation({
    mutationFn: (data: any) => apiClient.post("/guests", data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['guests-contacts'] });
      setCreateOpen(false);
      setForm(EMPTY_FORM);
      toast({ title: t("client.src.guests_created") });
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => apiClient.patch(`/guests/${id}`, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['guests-contacts'] });
      setEditOpen(false);
      toast({ title: t("client.src.guests_updated") });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => apiClient.delete(`/guests/${id}`),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['guests-contacts'] });
      toast({ title: t("client.src.guest_deleted"), variant: "destructive" });
    }
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate(form);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({ id: form.id, data: form });
    }
  };
  const handleDelete = (id: string) => deleteMutation.mutate(id);

  const openEdit = (row: any) => {
    const f: any = { id: row.id };
    Object.keys(EMPTY_FORM).forEach(k => {
      f[k] = String(row[k] ?? "");
    });
    setForm(f);
    setEditOpen(true);
  };
  const EntityForm = ({
    onSubmit,
    label
  }: {
    onSubmit: (e: React.FormEvent) => void;
    label: string;
  }) => {
    const {
      t
    } = useTranslation();
    return <form onSubmit={onSubmit} className="space-y-4 py-2">
      <div className="space-y-1.5">
        <Label>{t("client.src.full_name")}</Label>
        <Input type="text" value={form.name} onChange={e => setForm({
          ...form,
          name: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.email")}</Label>
        <Input type="email" value={form.email} onChange={e => setForm({
          ...form,
          email: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.phone")}</Label>
        <Input type="text" value={form.phone} onChange={e => setForm({
          ...form,
          phone: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.nationality_iso_code")}</Label>
        <Input type="text" value={form.nationality} onChange={e => setForm({
          ...form,
          nationality: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.gender")}</Label>
        <Select value={form.gender} onValueChange={v => setForm({
          ...form,
          gender: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="MALE">{t("client.src.male")}</SelectItem>
          <SelectItem value="FEMALE">{t("client.src.female")}</SelectItem>
          <SelectItem value="OTHER">{t("client.src.other")}</SelectItem></SelectContent></Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.passport_number")}</Label>
        <Input type="text" value={form.passportNumber} onChange={e => setForm({
          ...form,
          passportNumber: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.date_of_birth")}</Label>
        <Input type="date" value={form.birthDate} onChange={e => setForm({
          ...form,
          birthDate: e.target.value
        })} />
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.guests")} description={t("client.src.manage_guest_profiles_for")} createLabel="Add Guests" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search guests..." stats={[{
      label: t("client.src.total_guests"),
      value: guestsData.length
    }, {
      label: t("client.src.nationalities"),
      value: `${new Set(guestsData.map(r => r.nationality)).size}`
    }, {
      label: t("client.src.total_bookings"),
      value: guestsData.reduce((s, r) => s + (r.bookingCount || 0), 0)
    }]} filters={null}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("common.name")}</TableHead>
              <TableHead>{t("common.email")}</TableHead>
              <TableHead>{t("client.src.nationality")}</TableHead>
              <TableHead>{t("client.src.gender")}</TableHead>
              <TableHead>{t("common.bookings")}</TableHead>
              <TableHead>{t("client.src.registered")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading && <TableRow><TableCell colSpan={7} className="text-center py-12"><Loader2 className="w-8 h-8 animate-spin mx-auto text-primary" /></TableCell></TableRow>}
              {!isLoading && filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("client.src.no_guests_found")}</TableCell></TableRow>}
              {filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.name ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.email ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.nationality ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.gender ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.bookingCount ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.createdAt ?? "—"}</TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("common.edit")}</DropdownMenuItem>
                        <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </TableCell>
                </TableRow>)}
            </TableBody>
          </Table>
        </div>
      </PageShell>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.add_guests")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("common.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_guests")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("common.save")} />
        </DialogContent>
      </Dialog>
    </>;
}