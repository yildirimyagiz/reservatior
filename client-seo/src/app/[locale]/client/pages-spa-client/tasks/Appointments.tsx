"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal } from "lucide-react";
const STATUS: Record<string, {
  label: string;
  cls: string;
}> = {
  CONFIRMED: {
    label: t("client.src.confirmed"),
    cls: "bg-green-100 text-green-700"
  },
  PENDING: {
    label: t("client.src.pending"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  COMPLETED: {
    label: t("client.src.completed"),
    cls: "bg-blue-100 text-blue-700"
  },
  CANCELLED: {
    label: t("client.src.cancelled"),
    cls: "bg-red-100 text-red-700"
  }
};
const MOCK: any[] = [{
  "id": "1",
  "title": "Property Viewing - Sunset Villa",
  "clientName": "John Smith",
  "agentName": "Sarah Johnson",
  "scheduledAt": "2025-01-15 10:00",
  "type": "VIEWING",
  "status": "CONFIRMED",
  "location": "123 Sunset Blvd"
}, {
  "id": "2",
  "title": "Initial Consultation",
  "clientName": "Anna Lee",
  "agentName": "Michael Chen",
  "scheduledAt": "2025-01-16 14:00",
  "type": "CONSULTATION",
  "status": "PENDING",
  "location": "Office"
}, {
  "id": "3",
  "title": "Contract Signing",
  "clientName": "Robert Davis",
  "agentName": "Sarah Johnson",
  "scheduledAt": "2025-01-20 11:00",
  "type": "SIGNING",
  "status": "CONFIRMED",
  "location": "Legal Office"
}, {
  "id": "4",
  "title": "Follow-up Call",
  "clientName": "Maria Garcia",
  "agentName": "Emma Williams",
  "scheduledAt": "2025-01-12 09:00",
  "type": "CALL",
  "status": "COMPLETED",
  "location": "Remote"
}];
const EMPTY_FORM = {
  title: "",
  clientName: "",
  agentName: "",
  scheduledAt: "",
  type: "",
  location: "",
  status: ""
};
export default function Appointments() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const filtered = MOCK.filter(row => (String(row.title ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.clientName ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.agentName ?? "").toLowerCase().includes(search.toLowerCase())) && (filterStatus === "all" || row.status === filterStatus));
  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    setCreateOpen(false);
    toast({
      title: t("client.src.appointments_created")
    });
    setForm(EMPTY_FORM);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    setEditOpen(false);
    toast({
      title: t("client.src.appointments_updated")
    });
  };
  const handleDelete = () => toast({
    title: t("client.src.appointments_deleted"),
    variant: "destructive"
  });
  const openEdit = (row: any) => {
    const f: any = {};
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
        <Label>{t("client.src.title")}</Label>
        <Input type="text" value={form.title} onChange={e => setForm({
          ...form,
          title: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.client")}</Label>
        <Input type="text" value={form.clientName} onChange={e => setForm({
          ...form,
          clientName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.agent")}</Label>
        <Input type="text" value={form.agentName} onChange={e => setForm({
          ...form,
          agentName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.scheduled_at")}</Label>
        <Input type="date" value={form.scheduledAt} onChange={e => setForm({
          ...form,
          scheduledAt: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.type")}</Label>
        <Select value={form.type} onValueChange={v => setForm({
          ...form,
          type: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="VIEWING">{t("client.src.viewing")}</SelectItem>
          <SelectItem value="CONSULTATION">{t("client.src.consultation")}</SelectItem>
          <SelectItem value="SIGNING">{t("client.src.signing")}</SelectItem>
          <SelectItem value="CALL">{t("client.src.call")}</SelectItem>
          <SelectItem value="INSPECTION">{t("client.src.inspection")}</SelectItem></SelectContent></Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.location")}</Label>
        <Input type="text" value={form.location} onChange={e => setForm({
          ...form,
          location: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({
          ...form,
          status: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
          <SelectItem value="CONFIRMED">{t("client.src.confirmed")}</SelectItem>
          <SelectItem value="COMPLETED">{t("client.src.completed")}</SelectItem>
          <SelectItem value="CANCELLED">{t("client.src.cancelled")}</SelectItem></SelectContent></Select>
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.appointments")} description={t("client.src.schedule_and_manage_property")} createLabel="Add Appointments" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search appointments..." stats={[{
      label: t("client.src.total"),
      value: MOCK.length
    }, {
      label: t("client.src.confirmed"),
      value: MOCK.filter(r => r.status === 'CONFIRMED').length
    }, {
      label: t("client.src.today"),
      value: 0
    }, {
      label: t("client.src.completed"),
      value: MOCK.filter(r => r.status === 'COMPLETED').length
    }]} filters={<Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-40"><SelectValue placeholder={t("client.src.status")} /></SelectTrigger>
            <SelectContent>              <SelectItem value="all">{t("client.src.all")}</SelectItem>
              <SelectItem value="CONFIRMED">{t("client.src.confirmed")}</SelectItem>
              <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
              <SelectItem value="COMPLETED">{t("client.src.completed")}</SelectItem>
              <SelectItem value="CANCELLED">{t("client.src.cancelled")}</SelectItem></SelectContent>
          </Select>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("client.src.title")}</TableHead>
              <TableHead>{t("client.src.client")}</TableHead>
              <TableHead>{t("client.src.agent")}</TableHead>
              <TableHead>{t("client.src.scheduled")}</TableHead>
              <TableHead>{t("client.src.type")}</TableHead>
              <TableHead>{t("client.src.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("client.src.no_appointments_found")}</TableCell></TableRow>}
              {filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.title ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.clientName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.agentName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.scheduledAt ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.type ?? "—"}</TableCell>
                    <TableCell>
                      {STATUS[row.status] ? <Badge className={`${STATUS[row.status].cls} border-0 text-xs`}>{STATUS[row.status].label}</Badge> : <span className="text-xs text-muted-foreground">{row.status}</span>}
                    </TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                        <DropdownMenuItem onClick={() => handleDelete()} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
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
          <DialogHeader><DialogTitle>{t("client.src.add_appointments")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("client.src.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_appointments")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("client.src.save_changes")} />
        </DialogContent>
      </Dialog>
    </>;
}