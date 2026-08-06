"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, FormEvent } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal } from "lucide-react";
const STATUS: Record<string, {
  label: string;
  cls: string;
}> = {
  OUTSTANDING: {
    label: t("client.src.outstanding"),
    cls: "bg-red-100 text-red-700"
  },
  PARTIAL: {
    label: t("client.src.partial"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  RESOLVED: {
    label: t("client.src.resolved"),
    cls: "bg-blue-100 text-blue-700"
  },
  LEGAL: {
    label: t("client.src.legal_action"),
    cls: "bg-brand/15 text-brand"
  }
};
const MOCK: any[] = [{
  "id": "1",
  "tenantName": "Robert Davis",
  "propertyName": "Oak Street 12",
  "arrearsAmount": 1850,
  "periodStart": "2024-12-01",
  "status": "OUTSTANDING",
  "noticeSent": true,
  "legalAction": false
}, {
  "id": "2",
  "tenantName": "David Wilson",
  "propertyName": "Central Studio",
  "arrearsAmount": 800,
  "periodStart": "2025-01-01",
  "status": "PARTIAL",
  "noticeSent": false,
  "legalAction": false
}, {
  "id": "3",
  "tenantName": "Old Tenant",
  "propertyName": "Sunset Apt 1A",
  "arrearsAmount": 5500,
  "periodStart": "2024-06-01",
  "status": "LEGAL",
  "noticeSent": true,
  "legalAction": true
}];
const EMPTY_FORM = {
  tenantName: "",
  propertyName: "",
  arrearsAmount: "",
  periodStart: "",
  status: "",
  noticeSent: false
};
export default function RentArrears() {
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
  const filtered = MOCK.filter(row => (String(row.tenantName ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.propertyName ?? "").toLowerCase().includes(search.toLowerCase())) && (filterStatus === "all" || filterStatus === "OUTSTANDING" && row.status === "OUTSTANDING" || filterStatus === "LEGAL" && row.legalAction));
  const handleCreate = (e: FormEvent) => {
    e.preventDefault();
    setCreateOpen(false);
    toast({
      title: t("client.src.rentarrears_created")
    });
    setForm(EMPTY_FORM);
  };
  const handleEdit = (e: FormEvent) => {
    e.preventDefault();
    setEditOpen(false);
    toast({
      title: t("client.src.rentarrears_updated")
    });
  };
  const handleDelete = () => toast({
    title: t("client.src.rentarrears_deleted"),
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
    onSubmit: (e: FormEvent) => void;
    label: string;
  }) => {
    const {
      t
    } = useTranslation();
    return <form onSubmit={onSubmit} className="space-y-4 py-2">
      <div className="space-y-1.5">
        <Label>{t("common.tenant")}</Label>
        <Input type="text" value={form.tenantName} onChange={e => setForm({
          ...form,
          tenantName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.property")}</Label>
        <Input type="text" value={form.propertyName} onChange={e => setForm({
          ...form,
          propertyName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.arrears_amount")}</Label>
        <Input type="number" value={form.arrearsAmount} onChange={e => setForm({
          ...form,
          arrearsAmount: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.period_start")}</Label>
        <Input type="date" value={form.periodStart} onChange={e => setForm({
          ...form,
          periodStart: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({
          ...form,
          status: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="OUTSTANDING">{t("client.src.outstanding")}</SelectItem>
          <SelectItem value="PARTIAL">{t("client.src.partial")}</SelectItem>
          <SelectItem value="RESOLVED">{t("client.src.resolved")}</SelectItem>
          <SelectItem value="LEGAL">{t("client.src.legal_action")}</SelectItem></SelectContent></Select>
      </div>
      <div className="flex items-center justify-between rounded-lg border border-border p-3">
        <Label>{t("client.src.notice_sent")}</Label>
        <Switch checked={form.noticeSent === "true" || form.noticeSent === true} onCheckedChange={v => setForm({
          ...form,
          noticeSent: String(v)
        })} />
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.rent_arrears")} description={t("client.src.track_and_manage_overdue")} createLabel="Add RentArrears" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search rent arrears..." stats={[{
      label: t("client.src.total_cases"),
      value: MOCK.length
    }, {
      label: t("client.src.outstanding"),
      value: MOCK.filter(r => r.status === 'OUTSTANDING').length
    }, {
      label: t("client.src.legal_action"),
      value: MOCK.filter(r => r.legalAction).length
    }, {
      label: t("client.src.total_owed"),
      value: `$${MOCK.reduce((s, r) => s + (r.arrearsAmount || 0), 0).toLocaleString()}`
    }]} filters={<div className="flex gap-2">
          <Button variant={filterStatus === "all" ? "default" : "outline"} size="sm" onClick={() => setFilterStatus("all")}>{t("common.all")}</Button>
          <Button variant={filterStatus === "OUTSTANDING" ? "default" : "outline"} size="sm" onClick={() => setFilterStatus("OUTSTANDING")}>{t("client.src.outstanding")}</Button>
          <Button variant={filterStatus === "LEGAL" ? "default" : "outline"} size="sm" onClick={() => setFilterStatus("LEGAL")}>{t("client.src.legal_action")}</Button>
        </div>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("common.tenant")}</TableHead>
              <TableHead>{t("common.property")}</TableHead>
              <TableHead>{t("client.src.arrears_amount")}</TableHead>
              <TableHead>{t("client.src.period_start")}</TableHead>
              <TableHead>{t("common.status")}</TableHead>
              <TableHead>{t("client.src.notice_sent")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("client.src.no_rent_arrears_found")}</TableCell></TableRow>}
              {filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.tenantName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.propertyName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.arrearsAmount ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.periodStart ?? "—"}</TableCell>
                    <TableCell>
                      {STATUS[row.status] ? <Badge className={`${STATUS[row.status].cls} border-0 text-xs`}>{STATUS[row.status].label}</Badge> : <span className="text-xs text-muted-foreground">{row.status}</span>}
                    </TableCell>
                    <TableCell className="text-sm">{row.noticeSent ?? "—"}</TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("common.edit")}</DropdownMenuItem>
                        <DropdownMenuItem onClick={() => handleDelete()} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
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
          <DialogHeader><DialogTitle>{t("client.src.add_rentarrears")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("common.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_rentarrears")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("common.save")} />
        </DialogContent>
      </Dialog>
    </>;
}