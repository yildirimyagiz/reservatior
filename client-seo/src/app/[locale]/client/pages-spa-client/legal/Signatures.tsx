"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
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
import { signaturesApi, type SignatureRequest, type SignatureStatus } from "@/lib/api/signatures";
import { Edit, Trash2, MoreHorizontal, Loader2, AlertCircle, RefreshCw } from "lucide-react";
const STATUS: Record<SignatureStatus, {
  label: string;
  cls: string;
}> = {
  PENDING: {
    label: t("common.processing"),
    cls: "bg-yellow-100 text-yellow-700"
  },
  COMPLETED: {
    label: t("common.completed"),
    cls: "bg-blue-100 text-blue-700"
  },
  DECLINED: {
    label: t("client.src.declined"),
    cls: "bg-red-100 text-red-700"
  },
  EXPIRED: {
    label: t("common.expired"),
    cls: "bg-gray-100 text-gray-500"
  }
};
const EMPTY_FORM = {
  orgId: "",
  contractId: "",
  expiresAt: "",
  status: "PENDING" as SignatureStatus
};
export default function Signatures() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [requests, setRequests] = useState<SignatureRequest[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [selected, setSelected] = useState<SignatureRequest | null>(null);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const fetchRequests = async () => {
    try {
      setLoading(true);
      const response = (await signaturesApi.getSignatureRequests()) as any;
      setRequests(Array.isArray(response) ? response : response?.data || []);
      setError(null);
    } catch (err: any) {
      setError("Failed to fetch signature requests");
      toast({
        variant: "destructive",
        title: t("common.error"),
        description: t("client.src.could_not_load_signature")
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchRequests();
  }, []);
  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await signaturesApi.createSignatureRequest(form);
      setCreateOpen(false);
      setForm(EMPTY_FORM);
      toast({
        title: t("client.src.signature_request_created")
      });
      fetchRequests();
    } catch (err: any) {
      toast({
        variant: "destructive",
        title: t("common.error"),
        description: t("client.src.failed_to_create_request")
      });
    }
  };
  const handleEdit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selected) return;
    try {
      await signaturesApi.updateSignatureRequest(selected.id, form);
      setEditOpen(false);
      toast({
        title: t("client.src.signature_request_updated")
      });
      fetchRequests();
    } catch (err: any) {
      toast({
        variant: "destructive",
        title: t("common.error"),
        description: t("client.src.failed_to_update_request")
      });
    }
  };
  const handleDelete = async (id: string) => {
    if (!confirm("Are you sure you want to delete this signature request?")) return;
    try {
      await signaturesApi.deleteSignatureRequest(id);
      toast({
        title: t("client.src.signature_request_deleted"),
        variant: "destructive"
      });
      fetchRequests();
    } catch (err: any) {
      toast({
        variant: "destructive",
        title: t("common.error"),
        description: t("client.src.failed_to_delete_request")
      });
    }
  };
  const openEdit = (row: SignatureRequest) => {
    setSelected(row);
    setForm({
      orgId: row.orgId,
      contractId: row.contractId,
      expiresAt: row.expiresAt ? new Date(row.expiresAt).toISOString().split('T')[0] : "",
      status: row.status
    });
    setEditOpen(true);
  };
  const filtered = requests.filter(row => {
    const signerName = row.signers?.[0]?.fullName || "No Signer";
    const contractId = row.contractId || "";
    return signerName.toLowerCase().includes(search.toLowerCase()) || contractId.toLowerCase().includes(search.toLowerCase());
  });
  const EntityForm = ({
    onSubmit,
    label,
    isEdit = false
  }: {
    onSubmit: (e: React.FormEvent) => void;
    label: string;
    isEdit?: boolean;
  }) => {
    const {
      t
    } = useTranslation();
    return <form onSubmit={onSubmit} className="space-y-4 py-2">
      {!isEdit && <>
          <div className="space-y-1.5"><Label>{t("client.src.org_id")}</Label><Input value={form.orgId} onChange={e => setForm({
            ...form,
            orgId: e.target.value
          })} required /></div>
          <div className="space-y-1.5"><Label>{t("client.src.contract_id")}</Label><Input value={form.contractId} onChange={e => setForm({
            ...form,
            contractId: e.target.value
          })} required /></div>
        </>}
      <div className="space-y-1.5"><Label>{t("client.src.expires_at")}</Label><Input type="date" value={form.expiresAt} onChange={e => setForm({
          ...form,
          expiresAt: e.target.value
        })} /></div>
      <div className="space-y-1.5">
        <Label>{t("common.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({
          ...form,
          status: v as SignatureStatus
        })}>
          <SelectTrigger><SelectValue /></SelectTrigger>
          <SelectContent>
            {Object.entries(STATUS).map(([k, v]) => <SelectItem key={k} value={k}>{v.label}</SelectItem>)}
          </SelectContent>
        </Select>
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.signature_requests")} description={t("client.src.track_document_signing_requests")} createLabel="New Request" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search signature requests..." stats={[{
      label: t("common.total"),
      value: requests.length
    }, {
      label: t("common.processing"),
      value: requests.filter(r => r.status === 'PENDING').length
    }, {
      label: t("common.completed"),
      value: requests.filter(r => r.status === 'COMPLETED').length
    }]} actions={<Button variant="outline" size="sm" onClick={fetchRequests} disabled={loading}>
            <RefreshCw className={`w-4 h-4 mr-2 ${loading ? 'animate-spin' : ''}`} />{t("common.refresh")}</Button>}>
        {loading ? <div className="flex flex-col items-center justify-center py-24 text-muted-foreground gap-3">
            <Loader2 className="w-8 h-8 animate-spin" />
            <p>{t("client.src.loading_signature_requests")}</p>
          </div> : error ? <div className="flex flex-col items-center justify-center py-24 text-destructive gap-3 text-center px-4">
            <AlertCircle className="w-10 h-10" />
            <p className="font-semibold text-lg">{t("client.src.failed_to_load")}</p>
            <Button variant="outline" onClick={fetchRequests} className="mt-2">{t("client.src.try_again")}</Button>
          </div> : <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
            <Table>
              <TableHeader>
                <TableRow>
                <TableHead>{t("client.src.contract_id")}</TableHead>
                <TableHead>{t("client.src.signers")}</TableHead>
                <TableHead>{t("common.status")}</TableHead>
                <TableHead>{t("client.src.expires")}</TableHead>
                <TableHead>{t("client.src.created_at")}</TableHead>
                  <TableHead className="w-10" />
                </TableRow>
              </TableHeader>
              <TableBody>
                {filtered.length === 0 && <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_signature_requests_found")}</TableCell></TableRow>}
                {filtered.map(row => {
              const s = STATUS[row.status] || STATUS.PENDING;
              const firstSigner = row.signers?.[0];
              const signerText = firstSigner ? row.signers.length > 1 ? `${firstSigner.fullName} (+${row.signers.length - 1})` : firstSigner.fullName : "None";
              return <TableRow key={row.id} className="hover:bg-muted/40">
                        <TableCell className="text-sm font-medium">{row.contractId}</TableCell>
                        <TableCell>
                          <p className="text-sm">{signerText}</p>
                          {firstSigner?.email && <p className="text-xs text-muted-foreground">{firstSigner.email}</p>}
                        </TableCell>
                        <TableCell><Badge className={`${s.cls} border-0 text-xs`}>{s.label}</Badge></TableCell>
                        <TableCell className="text-sm text-muted-foreground">{row.expiresAt ? new Date(row.expiresAt).toLocaleDateString() : "—"}</TableCell>
                        <TableCell className="text-sm text-muted-foreground">{new Date(row.createdAt).toLocaleDateString()}</TableCell>
                      <TableCell>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end">
                            <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("common.edit")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>;
            })}
              </TableBody>
            </Table>
          </div>}
      </PageShell>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.new_signature_request")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("common.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_signature_request")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("common.save")} isEdit={true} />
        </DialogContent>
      </Dialog>
    </>;
}