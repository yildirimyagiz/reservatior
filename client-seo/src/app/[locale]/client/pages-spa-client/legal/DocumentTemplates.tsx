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
import { Edit, Trash2, MoreHorizontal } from "lucide-react";
import { Switch } from "@radix-ui/react-switch";
const MOCK: any[] = [{
  "id": "1",
  "name": "Standard Lease Agreement",
  "type": "LEASE",
  "templateType": "CONTRACT",
  "channels": ["EMAIL", "DOCUSIGN"],
  "isActive": true,
  "variables": {
    "tenantName": "string",
    "propertyAddress": "string"
  }
}, {
  "id": "2",
  "name": "Welcome Email",
  "type": "EMAIL",
  "templateType": "COMMUNICATION",
  "channels": ["EMAIL"],
  "isActive": true
}, {
  "id": "3",
  "name": "Rent Increase Notice",
  "type": "NOTICE",
  "templateType": "LEGAL",
  "channels": ["EMAIL", "POST"],
  "isActive": true
}, {
  "id": "4",
  "name": "Old NDA Template",
  "type": "NDA",
  "templateType": "CONTRACT",
  "channels": ["EMAIL"],
  "isActive": false
}];
const EMPTY_FORM = {
  name: "",
  type: "",
  templateType: "",
  subject: "",
  isActive: false
};
export default function DocumentTemplates() {
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
  const filtered = MOCK.filter(row => String(row.name ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.type ?? "").toLowerCase().includes(search.toLowerCase()));
  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    setCreateOpen(false);
    toast({
      title: t("client.src.documenttemplates_created")
    });
    setForm(EMPTY_FORM);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    setEditOpen(false);
    toast({
      title: t("client.src.documenttemplates_updated")
    });
  };
  const handleDelete = () => toast({
    title: t("client.src.documenttemplates_deleted"),
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
        <Label>{t("client.src.template_name")}</Label>
        <Input type="text" value={form.name} onChange={e => setForm({
          ...form,
          name: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.type")}</Label>
        <Input type="text" value={form.type} onChange={e => setForm({
          ...form,
          type: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("common.category")}</Label>
        <Select value={form.templateType} onValueChange={v => setForm({
          ...form,
          templateType: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="CONTRACT">{t("client.src.contract")}</SelectItem>
          <SelectItem value="COMMUNICATION">{t("client.src.communication")}</SelectItem>
          <SelectItem value="LEGAL">{t("client.src.legal")}</SelectItem>
          <SelectItem value="FINANCIAL">{t("client.src.financial")}</SelectItem></SelectContent></Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.email_subject")}</Label>
        <Input type="text" value={form.subject} onChange={e => setForm({
          ...form,
          subject: e.target.value
        })} />
      </div>
      <div className="flex items-center justify-between rounded-lg border border-border p-3">
        <Label>{t("common.active")}</Label>
        <Switch checked={form.isActive === "true" || form.isActive === true} onCheckedChange={v => setForm({
          ...form,
          isActive: String(v)
        })} />
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.document_templates")} description={t("client.src.reusable_document_and_contract")} createLabel="Add DocumentTemplates" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search document templates..." stats={[{
      label: t("common.total"),
      value: MOCK.length
    }, {
      label: t("common.active"),
      value: MOCK.filter(r => r.isActive).length
    }, {
      label: t("common.inactive"),
      value: MOCK.filter(r => !r.isActive).length
    }]}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("client.src.template_name")}</TableHead>
              <TableHead>{t("common.type")}</TableHead>
              <TableHead>{t("common.category")}</TableHead>
              <TableHead>{t("client.src.channels")}</TableHead>
              <TableHead>{t("common.active")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 && <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_document_templates_found")}</TableCell></TableRow>}
              {filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.name ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.type ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.templateType ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.channels ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.isActive ?? "—"}</TableCell>
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
          <DialogHeader><DialogTitle>{t("client.src.add_documenttemplates")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("common.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_documenttemplates")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("common.save")} />
        </DialogContent>
      </Dialog>
    </>;
}