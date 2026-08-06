"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, FormEvent } from "react";
import { PageShell } from "../layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, FileText, CheckCircle2, XCircle, PenTool, Eye, Download, Sparkles, Mic, Brain } from "lucide-react";
import { AI_MODELS } from "@/lib/ai-models";
import { apiClient } from "@/lib/api/client";
import { useEffect } from "react";
interface Contract {
  id: string;
  title: string;
  type: "SALE" | "LEASE" | "MANAGEMENT" | "SERVICE";
  status: "DRAFT" | "PENDING_SIGNATURE" | "ACTIVE" | "COMPLETED" | "TERMINATED";
  parties: string[];
  startDate: string;
  endDate?: string;
  value?: number;
  currency: string;
  createdAt: string;
  signedAt?: string;
}
const STATUS = {
  DRAFT: {
    label: t("common.draft"),
    cls: "bg-gray-100 text-gray-600",
    icon: FileText
  },
  PENDING_SIGNATURE: {
    label: t("client.src.awaiting_signature"),
    cls: "bg-yellow-100 text-yellow-700",
    icon: PenTool
  },
  ACTIVE: {
    label: t("common.active"),
    cls: "bg-blue-100 text-blue-700",
    icon: CheckCircle2
  },
  COMPLETED: {
    label: t("common.completed"),
    cls: "bg-blue-100 text-blue-700",
    icon: CheckCircle2
  },
  TERMINATED: {
    label: t("client.src.terminated"),
    cls: "bg-red-100 text-red-700",
    icon: XCircle
  }
};
const EMPTY_FORM = {
  title: "",
  type: "LEASE" as const,
  status: "DRAFT" as const,
  parties: "",
  startDate: "",
  endDate: "",
  value: "",
  currency: "USD",
  notes: ""
};
export default function Contracts() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [contracts, setContracts] = useState<Contract[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [search, setSearch] = useState("");
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterType, setFilterType] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [aiCreateOpen, setAiCreateOpen] = useState(false);
  const [aiPrompt, setAiPrompt] = useState("");
  const [selectedModel, setSelectedModel] = useState("gemini-pro");
  const [isGenerating, setIsGenerating] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [viewOpen, setViewOpen] = useState(false);
  const [selected, setSelected] = useState<Contract | null>(null);
  const [form, setForm] = useState(EMPTY_FORM);

  const fetchContracts = async () => {
    try {
      setIsLoading(true);
      const res: any = await apiClient.get('/contracts').catch(() => null);
      if (res && res.data) {
        const mapped = res.data.map((c: any) => ({
          id: c.id,
          title: c.title || 'Untitled Contract',
          type: c.type || 'SERVICE',
          status: c.status || 'DRAFT',
          parties: c.parties || ['System'],
          startDate: c.effectiveFrom ? new Date(c.effectiveFrom).toISOString().split('T')[0] : (c.createdAt ? new Date(c.createdAt).toISOString().split('T')[0] : ''),
          endDate: c.effectiveTo ? new Date(c.effectiveTo).toISOString().split('T')[0] : '',
          value: c.value || 0,
          currency: c.currency || 'USD',
          createdAt: c.createdAt ? new Date(c.createdAt).toISOString().split('T')[0] : '',
          signedAt: c.signedAt ? new Date(c.signedAt).toISOString().split('T')[0] : '',
        }));
        setContracts(mapped);
      }
    } catch (e) {
      console.error(e);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchContracts();
  }, []);

  const filtered = contracts.filter(c => {
    const m = `${c.title} ${c.parties.join(" ")}`.toLowerCase().includes(search.toLowerCase());
    const s = filterStatus === "all" || c.status === filterStatus;
    const t = filterType === "all" || c.type === filterType;
    return m && s && t;
  });

  const handleCreate = async (e: FormEvent) => {
    e.preventDefault();
    try {
      await apiClient.post('/contracts', form);
      setCreateOpen(false);
      toast({
        title: t("client.src.contract_created")
      });
      fetchContracts();
    } catch (error) {
      toast({ title: "Error creating contract", variant: "destructive" });
    }
  };

  const handleEdit = async (e: FormEvent) => {
    e.preventDefault();
    if (!selected) return;
    try {
      await apiClient.put(`/contracts/${selected.id}`, form);
      setEditOpen(false);
      toast({
        title: t("client.src.contract_updated")
      });
      fetchContracts();
    } catch (error) {
      toast({ title: "Error updating contract", variant: "destructive" });
    }
  };

  const handleAiGenerate = async () => {
    setIsGenerating(true);
    const model = AI_MODELS.find(m => m.id === selectedModel);
    // Simulate calling the backend Elysia API: POST /contract-generation
    setTimeout(() => {
      setIsGenerating(false);
      setAiCreateOpen(false);
      toast({
        title: "Contract Generated via AI",
        description: `Generated using ${model?.name || 'AI'}. Your prompt has been successfully parsed into a legal document.`,
        variant: "default"
      });
      fetchContracts();
    }, 2000);
  };
  const handleSendForSignature = (c: Contract) => toast({
    title: t("client.src.sent_for_signature"),
    description: `${c.title} sent to parties.`
  });
  const handleDownload = (c: Contract) => toast({
    title: t("client.src.downloading"),
    description: c.title
  });
  const handleDelete = async (c: Contract) => {
    try {
      await apiClient.delete(`/contracts/${c.id}`);
      fetchContracts();
    } catch (e) {
      toast({ title: "Error deleting contract", variant: "destructive" });
    }
  };
  const openEdit = (c: Contract) => {
    setSelected(c);
    setForm({
      title: c.title,
      type: c.type as any,
      status: c.status as any,
      parties: c.parties.join(", "),
      startDate: c.startDate,
      endDate: c.endDate || "",
      value: String(c.value || ""),
      currency: c.currency,
      notes: ""
    });
    setEditOpen(true);
  };
  const ContractForm = ({
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
      <div className="space-y-1.5"><Label>{t("common.title")}</Label><Input value={form.title} onChange={e => setForm({
          ...form,
          title: e.target.value
        })} required /></div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("common.type")}</Label>
          <Select value={form.type} onValueChange={v => setForm({
            ...form,
            type: v as any
          })}>
            <SelectTrigger><SelectValue /></SelectTrigger>
            <SelectContent>
              <SelectItem value="SALE">{t("client.src.sale")}</SelectItem>
              <SelectItem value="LEASE">{t("client.src.lease")}</SelectItem>
              <SelectItem value="MANAGEMENT">{t("client.src.management")}</SelectItem>
              <SelectItem value="SERVICE">{t("client.src.service")}</SelectItem>
            </SelectContent>
          </Select>
        </div>
        <div className="space-y-1.5"><Label>{t("common.status")}</Label>
          <Select value={form.status} onValueChange={v => setForm({
            ...form,
            status: v as any
          })}>
            <SelectTrigger><SelectValue /></SelectTrigger>
            <SelectContent>{Object.entries(STATUS).map(([k, v]) => <SelectItem key={k} value={k}>{v.label}</SelectItem>)}</SelectContent>
          </Select>
        </div>
      </div>
      <div className="space-y-1.5"><Label>{t("client.src.parties_commaseparated")}</Label><Input value={form.parties} onChange={e => setForm({
          ...form,
          parties: e.target.value
        })} placeholder={t("client.src.person_a_company_b")} /></div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("client.src.start_date")}</Label><Input type="date" value={form.startDate} onChange={e => setForm({
            ...form,
            startDate: e.target.value
          })} /></div>
        <div className="space-y-1.5"><Label>{t("client.src.end_date")}</Label><Input type="date" value={form.endDate} onChange={e => setForm({
            ...form,
            endDate: e.target.value
          })} /></div>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5"><Label>{t("client.src.contract_value")}</Label><Input type="number" value={form.value} onChange={e => setForm({
            ...form,
            value: e.target.value
          })} min="0" /></div>
        <div className="space-y-1.5"><Label>{t("common.currency")}</Label>
          <Select value={form.currency} onValueChange={v => setForm({
            ...form,
            currency: v
          })}>
            <SelectTrigger><SelectValue /></SelectTrigger>
            <SelectContent><SelectItem value="USD">{t("client.src.usd")}</SelectItem><SelectItem value="EUR">{t("client.src.eur")}</SelectItem><SelectItem value="GBP">{t("client.src.gbp")}</SelectItem></SelectContent>
          </Select>
        </div>
      </div>
      <div className="space-y-1.5"><Label>{t("common.notes")}</Label><Textarea value={form.notes} onChange={e => setForm({
          ...form,
          notes: e.target.value
        })} rows={3} /></div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("common.contracts")} description={t("client.src.manage_sale_lease_and")} createLabel="New Contract" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search contracts..." 
      actions={
        <Button onClick={() => setAiCreateOpen(true)} className="bg-gradient-to-r from-orange-500 to-amber-500 hover:from-orange-600 hover:to-amber-600 text-white shadow-orange-500/20 shadow-lg border-0 mr-2">
          <Sparkles className="w-4 h-4 mr-2" />
          AI Contract Generator
        </Button>
      }
      stats={[{
      label: t("common.total"),
      value: contracts.length
    }, {
      label: t("common.active"),
      value: contracts.filter(c => c.status === "ACTIVE").length
    }, {
      label: t("client.src.pending_signature"),
      value: contracts.filter(c => c.status === "PENDING_SIGNATURE").length
    }, {
      label: t("client.src.total_value"),
      value: `$${contracts.reduce((s, c) => s + (c.value || 0), 0).toLocaleString()}`
    }]} filters={<div className="flex gap-2">
            <Select value={filterType} onValueChange={setFilterType}>
              <SelectTrigger className="w-36"><SelectValue placeholder={t("common.type")} /></SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("common.all_types")}</SelectItem>
                <SelectItem value="SALE">{t("client.src.sale")}</SelectItem>
                <SelectItem value="LEASE">{t("client.src.lease")}</SelectItem>
                <SelectItem value="MANAGEMENT">{t("client.src.management")}</SelectItem>
                <SelectItem value="SERVICE">{t("client.src.service")}</SelectItem>
              </SelectContent>
            </Select>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-44"><SelectValue placeholder={t("common.status")} /></SelectTrigger>
              <SelectContent><SelectItem value="all">{t("common.all")}</SelectItem>{Object.entries(STATUS).map(([k, v]) => <SelectItem key={k} value={k}>{v.label}</SelectItem>)}</SelectContent>
            </Select>
          </div>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.contract")}</TableHead>
                <TableHead>{t("common.type")}</TableHead>
                <TableHead>{t("client.src.parties")}</TableHead>
                <TableHead>{t("client.src.period")}</TableHead>
                <TableHead>{t("client.src.value")}</TableHead>
                <TableHead>{t("common.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading ? (
                <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">Loading...</TableCell></TableRow>
              ) : filtered.length === 0 ? (
                <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("client.src.no_contracts_found")}</TableCell></TableRow>
              ) : (
                <>
              {filtered.map(c => {
              const s = STATUS[c.status];
              const SIcon = s.icon;
              return <TableRow key={c.id} className="hover:bg-muted/40">
                    <TableCell>
                      <p className="text-sm font-medium">{c.title}</p>
                      <p className="text-xs text-muted-foreground">{t("common.created")}{c.createdAt}</p>
                    </TableCell>
                    <TableCell><Badge className="bg-secondary border-0 text-xs">{c.type}</Badge></TableCell>
                    <TableCell className="text-xs text-muted-foreground">{c.parties.slice(0, 2).join(", ")}{c.parties.length > 2 ? ` +${c.parties.length - 2}` : ""}</TableCell>
                    <TableCell className="text-xs text-muted-foreground">{c.startDate}{c.endDate ? ` → ${c.endDate}` : ""}</TableCell>
                    <TableCell className="text-sm font-medium">{c.value ? `$${c.value.toLocaleString()}` : "—"}</TableCell>
                    <TableCell><Badge className={`${s.cls} border-0 text-xs`}><SIcon className="w-3 h-3 mr-1" />{s.label}</Badge></TableCell>
                    <TableCell>
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuItem onClick={() => {
                        setSelected(c);
                        setViewOpen(true);
                      }}><Eye className="w-4 h-4 mr-2" />{t("common.view")}</DropdownMenuItem>
                          <DropdownMenuItem onClick={() => openEdit(c)}><Edit className="w-4 h-4 mr-2" />{t("common.edit")}</DropdownMenuItem>
                          {c.status === "DRAFT" && <DropdownMenuItem onClick={() => handleSendForSignature(c)}><PenTool className="w-4 h-4 mr-2" />{t("client.src.send_for_signature")}</DropdownMenuItem>}
                          <DropdownMenuItem onClick={() => handleDownload(c)}><Download className="w-4 h-4 mr-2" />{t("client.src.download_pdf")}</DropdownMenuItem>
                          <DropdownMenuItem className="text-destructive" onClick={() => handleDelete(c)}><Trash2 className="w-4 h-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>;
            })}
                </>
              )}
            </TableBody>
          </Table>
        </div>
      </PageShell>
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto"><DialogHeader><DialogTitle>{t("client.src.new_contract")}</DialogTitle></DialogHeader><ContractForm onSubmit={handleCreate} label={t("client.src.create_contract")} /></DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto"><DialogHeader><DialogTitle>{t("client.src.edit_contract")}</DialogTitle></DialogHeader><ContractForm onSubmit={handleEdit} label={t("common.save")} /></DialogContent>
      </Dialog>
      <Dialog open={viewOpen} onOpenChange={setViewOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader><DialogTitle>{selected?.title}</DialogTitle></DialogHeader>
          {selected && <div className="space-y-3 py-2 text-sm">
              <div className="grid grid-cols-2 gap-3">
                <div><p className="text-xs text-muted-foreground">{t("common.type")}</p><p>{selected.type}</p></div>
                <div><p className="text-xs text-muted-foreground">{t("common.status")}</p><Badge className={`${STATUS[selected.status].cls} border-0 text-xs`}>{STATUS[selected.status].label}</Badge></div>
                <div><p className="text-xs text-muted-foreground">{t("client.src.start")}</p><p>{selected.startDate}</p></div>
                <div><p className="text-xs text-muted-foreground">{t("client.src.end")}</p><p>{selected.endDate || "Open-ended"}</p></div>
                <div><p className="text-xs text-muted-foreground">{t("client.src.value")}</p><p className="font-semibold">{selected.value ? `$${selected.value.toLocaleString()}` : "—"}</p></div>
                <div><p className="text-xs text-muted-foreground">{t("common.signed")}</p><p>{selected.signedAt || "Not yet"}</p></div>
              </div>
              <div><p className="text-xs text-muted-foreground mb-1">{t("client.src.parties")}</p><div className="flex flex-wrap gap-1">{selected.parties.map((p, i) => <Badge key={i} className="bg-secondary border-0 text-xs">{p}</Badge>)}</div></div>
            </div>}
        </DialogContent>
      </Dialog>
      
      {/* AI Voice-to-Contract Generator Dialog */}
      <Dialog open={aiCreateOpen} onOpenChange={setAiCreateOpen}>
        <DialogContent className="sm:max-w-lg border-orange-500/30 bg-card">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2 text-orange-500">
              <Brain className="w-5 h-5" />
              AI Contract Generator
            </DialogTitle>
          </DialogHeader>
          <div className="space-y-4 py-4">
            <div className="space-y-1.5">
              <Label>AI Model</Label>
              <Select value={selectedModel} onValueChange={setSelectedModel}>
                <SelectTrigger className="bg-black/20 border-warning/20">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  {AI_MODELS.filter(m => m.provider === "Google").map(model => (
                    <SelectItem key={model.id} value={model.id}>
                      <div className="flex items-center gap-2">
                        <Brain className="w-4 h-4 text-orange-500" />
                        <div>
                          <p className="font-medium">{model.name}</p>
                          <p className="text-xs text-muted-foreground">{model.description}</p>
                        </div>
                      </div>
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
            <p className="text-sm text-muted-foreground">
              Describe the contract you want to create or speak into the microphone. AI will generate a legally binding document automatically using the regional templates.
            </p>
            <div className="relative">
              <Textarea
                value={aiPrompt}
                onChange={(e) => setAiPrompt(e.target.value)}
                placeholder="e.g. Create a residential lease for 12 months at $2000/month with zero-deposit enabled."
                className="pr-12 h-32 resize-none bg-black/20 border-warning/20 focus-visible:ring-orange-500"
              />
              <Button
                size="icon" aria-label={t("common.voice_input")}
                variant="ghost"
                className="absolute bottom-2 right-2 rounded-full hover:bg-warning/20 hover:text-orange-500 text-muted-foreground"
                onClick={() => toast({ title: "Listening...", description: "Speak now. (Mock integration)" })}
              >
                <Mic className="w-5 h-5" />
              </Button>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setAiCreateOpen(false)}>Cancel</Button>
            <Button
              className="bg-orange-500 hover:bg-orange-600 text-white"
              onClick={handleAiGenerate}
              disabled={!aiPrompt || isGenerating}
            >
              {isGenerating ? "Generating..." : "Generate Smart Contract"}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </>;
}