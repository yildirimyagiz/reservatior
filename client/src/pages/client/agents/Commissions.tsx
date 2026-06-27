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
  PAID: {
    label: t("client.src.paid"),
    cls: "bg-green-100 text-green-700"
  },
  PENDING: {
    label: t("client.src.pending"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  DISPUTED: {
    label: t("client.src.disputed"),
    cls: "bg-red-100 text-red-700"
  }
};
const MOCK: any[] = [{
  "id": "1",
  "agentName": "Sarah Johnson",
  "propertyName": "Sunset Villa",
  "salePrice": 850000,
  "commissionRate": 3,
  "commissionAmount": 25500,
  "status": "PAID",
  "paidAt": "2025-01-05"
}, {
  "id": "2",
  "agentName": "Michael Chen",
  "propertyName": "City Loft",
  "salePrice": 320000,
  "commissionRate": 2.5,
  "commissionAmount": 8000,
  "status": "PENDING",
  "paidAt": null
}, {
  "id": "3",
  "agentName": "Emma Williams",
  "propertyName": "Mountain Cabin",
  "salePrice": 210000,
  "commissionRate": 3,
  "commissionAmount": 6300,
  "status": "PAID",
  "paidAt": "2024-12-20"
}];
const EMPTY_FORM = {
  agentName: "",
  propertyName: "",
  salePrice: "",
  commissionRate: "",
  commissionAmount: "",
  status: ""
};
export default function Commissions() {
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
  const filtered = MOCK.filter(row => (String(row.agentName ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.propertyName ?? "").toLowerCase().includes(search.toLowerCase())) && (filterStatus === "all" || row.status === filterStatus));
  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    setCreateOpen(false);
    toast({
      title: t("client.src.commissions_created")
    });
    setForm(EMPTY_FORM);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    setEditOpen(false);
    toast({
      title: t("client.src.commissions_updated")
    });
  };
  const handleDelete = () => toast({
    title: t("client.src.commissions_deleted"),
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
        <Label>{t("client.src.agent")}</Label>
        <Input type="text" value={form.agentName} onChange={e => setForm({
          ...form,
          agentName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.property")}</Label>
        <Input type="text" value={form.propertyName} onChange={e => setForm({
          ...form,
          propertyName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.sale_price")}</Label>
        <Input type="number" value={form.salePrice} onChange={e => setForm({
          ...form,
          salePrice: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.commission_rate")}</Label>
        <Input type="number" value={form.commissionRate} onChange={e => setForm({
          ...form,
          commissionRate: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.commission_amount")}</Label>
        <Input type="number" value={form.commissionAmount} onChange={e => setForm({
          ...form,
          commissionAmount: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({
          ...form,
          status: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
          <SelectItem value="PAID">{t("client.src.paid")}</SelectItem>
          <SelectItem value="DISPUTED">{t("client.src.disputed")}</SelectItem></SelectContent></Select>
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.commissions")} description={t("client.src.track_and_manage_agent")} createLabel="Add Commissions" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search commissions..." stats={[{
      label: t("client.src.total"),
      value: MOCK.length
    }, {
      label: t("client.src.paid"),
      value: MOCK.filter(r => r.status === 'PAID').length
    }, {
      label: t("client.src.pending"),
      value: MOCK.filter(r => r.status === 'PENDING').length
    }, {
      label: t("client.src.total_paid"),
      value: `$${MOCK.filter(r => r.status === 'PAID').reduce((s, r) => s + (r.commissionAmount || 0), 0).toLocaleString()}`
    }]} filters={<Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-40"><SelectValue placeholder={t("client.src.status")} /></SelectTrigger>
            <SelectContent>              <SelectItem value="all">{t("client.src.all")}</SelectItem>
              <SelectItem value="PAID">{t("client.src.paid")}</SelectItem>
              <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
              <SelectItem value="DISPUTED">{t("client.src.disputed")}</SelectItem></SelectContent>
          </Select>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("client.src.agent")}</TableHead>
              <TableHead>{t("client.src.property")}</TableHead>
              <TableHead>{t("client.src.sale_price")}</TableHead>
              <TableHead>{t("client.src.commission_rate")}</TableHead>
              <TableHead>{t("client.src.commission_amount")}</TableHead>
              <TableHead>{t("client.src.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("client.src.no_commissions_found")}</TableCell></TableRow>}
              {filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.agentName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.propertyName ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.salePrice ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.commissionRate ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.commissionAmount ?? "—"}</TableCell>
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
          <DialogHeader><DialogTitle>{t("client.src.add_commissions")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("client.src.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_commissions")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("client.src.save_changes")} />
        </DialogContent>
      </Dialog>
    </>;
}