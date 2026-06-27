import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
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
import { PageShell } from "@/pages/client/layout/PageShell";
const getStatusConfig = (t: any): Record<string, {
  label: string;
  cls: string;
}> => ({
  CONFIRMED: {
    label: t("admin.reservations.confirmed", "Onaylandı"),
    cls: "bg-green-100 text-green-700"
  },
  PENDING: {
    label: t("admin.reservations.pending", "Bekliyor"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  COMPLETED: {
    label: t("admin.reservations.completed", "Tamamlandı"),
    cls: "bg-blue-100 text-blue-700"
  },
  CANCELLED: {
    label: t("admin.reservations.cancelled", "İptal Edildi"),
    cls: "bg-red-100 text-red-700"
  }
});
const MOCK: any[] = [{
  "id": "1",
  "guestName": "Tom Baker",
  "guestEmail": "tom@email.com",
  "propertyName": "Sunset Villa",
  "checkIn": "2025-01-15",
  "checkOut": "2025-01-22",
  "nights": 7,
  "totalAmount": 2450,
  "currency": "$",
  "status": "CONFIRMED",
  "createdAt": "2025-01-01"
}, {
  "id": "2",
  "guestName": "Nina Ross",
  "guestEmail": "nina@email.com",
  "propertyName": "Ocean Bungalow",
  "checkIn": "2025-02-01",
  "checkOut": "2025-02-08",
  "nights": 7,
  "totalAmount": 3100,
  "currency": "$",
  "status": "PENDING",
  "createdAt": "2025-01-10"
}, {
  "id": "3",
  "guestName": "Leo Park",
  "guestEmail": "leo@email.com",
  "propertyName": "Mountain Cabin",
  "checkIn": "2024-12-20",
  "checkOut": "2024-12-27",
  "nights": 7,
  "totalAmount": 1890,
  "currency": "$",
  "status": "COMPLETED",
  "createdAt": "2024-12-01"
}];
const EMPTY_FORM = {
  guestName: "",
  guestEmail: "",
  propertyName: "",
  checkIn: "",
  checkOut: "",
  totalAmount: "",
  currency: "",
  status: ""
};
export default function Reservations() {
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
  const filtered = MOCK.filter(row => (String(row.guestName ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.propertyName ?? "").toLowerCase().includes(search.toLowerCase())) && (filterStatus === "all" || row.status === filterStatus));
  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    setCreateOpen(false);
    toast({
      title: t("admin.reservations.reservations_created")
    });
    setForm(EMPTY_FORM);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    setEditOpen(false);
    toast({
      title: t("admin.reservations.reservations_updated")
    });
  };
  const handleDelete = () => toast({
    title: t("admin.reservations.reservations_deleted"),
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
        <Label>{t("admin.reservations.guest_name")}</Label>
        <Input type="text" value={form.guestName} onChange={e => setForm({
          ...form,
          guestName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("admin.reservations.guest_email")}</Label>
        <Input type="email" value={form.guestEmail} onChange={e => setForm({
          ...form,
          guestEmail: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("admin.reservations.property")}</Label>
        <Input type="text" value={form.propertyName} onChange={e => setForm({
          ...form,
          propertyName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("admin.reservations.checkin")}</Label>
        <Input type="date" value={form.checkIn} onChange={e => setForm({
          ...form,
          checkIn: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("admin.reservations.checkout")}</Label>
        <Input type="date" value={form.checkOut} onChange={e => setForm({
          ...form,
          checkOut: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("admin.reservations.total_amount")}</Label>
        <Input type="number" value={form.totalAmount} onChange={e => setForm({
          ...form,
          totalAmount: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("admin.reservations.currency")}</Label>
        <Input type="text" value={form.currency} onChange={e => setForm({
          ...form,
          currency: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("admin.reservations.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({
          ...form,
          status: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="PENDING">{t("admin.reservations.pending")}</SelectItem>
          <SelectItem value="CONFIRMED">{t("admin.reservations.confirmed")}</SelectItem>
          <SelectItem value="COMPLETED">{t("admin.reservations.completed")}</SelectItem>
          <SelectItem value="CANCELLED">{t("admin.reservations.cancelled")}</SelectItem></SelectContent></Select>
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("admin.reservations.reservations")} description={t("admin.reservations.manage_property_reservations")} createLabel={t("admin.reservations.add_reservations", "Yeni Rezervasyon")} onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder={t("admin.reservations.search_placeholder", "Rezervasyon ara...")} stats={[{
      label: t("admin.reservations.total"),
      value: MOCK.length
    }, {
      label: t("admin.reservations.confirmed"),
      value: MOCK.filter(r => r.status === 'CONFIRMED').length
    }, {
      label: t("admin.reservations.pending"),
      value: MOCK.filter(r => r.status === 'PENDING').length
    }, {
      label: t("admin.reservations.revenue"),
      value: `$${MOCK.filter(r => r.status !== 'CANCELLED').reduce((s, r) => s + (r.totalAmount || 0), 0).toLocaleString()}`
    }]} filters={<Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-40"><SelectValue placeholder={t("admin.reservations.status")} /></SelectTrigger>
            <SelectContent>              <SelectItem value="all">{t("admin.reservations.all")}</SelectItem>
              <SelectItem value="CONFIRMED">{t("admin.reservations.confirmed")}</SelectItem>
              <SelectItem value="PENDING">{t("admin.reservations.pending")}</SelectItem>
              <SelectItem value="COMPLETED">{t("admin.reservations.completed")}</SelectItem>
              <SelectItem value="CANCELLED">{t("admin.reservations.cancelled")}</SelectItem></SelectContent>
          </Select>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("admin.reservations.guest")}</TableHead>
              <TableHead>{t("admin.reservations.property")}</TableHead>
              <TableHead>{t("admin.reservations.checkin")}</TableHead>
              <TableHead>{t("admin.reservations.checkout")}</TableHead>
              <TableHead>{t("admin.reservations.status")}</TableHead>
              <TableHead>{t("admin.reservations.total_amount")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("admin.reservations.no_reservations_found")}</TableCell></TableRow>}
              {filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.guestName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.propertyName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.checkIn ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.checkOut ?? "—"}</TableCell>
                    <TableCell>
                      {getStatusConfig(t)[row.status] ? <Badge className={`${getStatusConfig(t)[row.status].cls} border-0 text-xs`}>{getStatusConfig(t)[row.status].label}</Badge> : <span className="text-xs text-muted-foreground">{row.status}</span>}
                    </TableCell>
                    <TableCell className="text-sm">{row.totalAmount ?? "—"}</TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("admin.reservations.edit")}</DropdownMenuItem>
                        <DropdownMenuItem onClick={() => handleDelete()} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("admin.reservations.delete")}</DropdownMenuItem>
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
          <DialogHeader><DialogTitle>{t("admin.reservations.add_reservations")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("admin.reservations.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("admin.reservations.edit_reservations")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("admin.reservations.save_changes")} />
        </DialogContent>
      </Dialog>
    </>;
}