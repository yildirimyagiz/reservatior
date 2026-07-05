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
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal, Building2, ExternalLink, Globe, Phone, Mail, Loader2 } from "lucide-react";
import { Textarea } from "@/components/ui/textarea";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { agenciesApi, Agency as ApiAgency } from "@/lib/api/agencies";

interface LocalAgency {
  id: string;
  name: string;
  email?: string;
  phoneNumber?: string;
  address?: string;
  website?: string;
  logoUrl?: string;
  status: "ACTIVE" | "PENDING" | "SUSPENDED";
  agentCount?: number;
  propertyCount?: number;
  createdAt: string;
}
const STATUS_COLORS: Record<string, string> = {
  ACTIVE: "bg-green-100 text-green-700",
  PENDING: "bg-yellow-100 text-yellow-700",
  SUSPENDED: "bg-red-100 text-red-700"
};

const EMPTY_FORM = {
  name: "",
  email: "",
  phoneNumber: "",
  address: "",
  website: "",
  status: "PENDING",
  description: ""
};
export default function Agencies() {
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
  const queryClient = useQueryClient();

  const { data: rawAgencies = [], isLoading } = useQuery({
    queryKey: ['agencies'],
    queryFn: async () => {
      const data = await agenciesApi.getAll();
      return data;
    }
  });

  const agencies: LocalAgency[] = rawAgencies.map((a: ApiAgency) => ({
    id: a.id,
    name: a.name,
    email: a.email || "",
    phoneNumber: a.phoneNumber || "",
    address: a.address || "",
    website: "", // Not strictly in API model, keeping for UI compat
    logoUrl: "",
    status: a.isActive ? "ACTIVE" : "PENDING", // Map bool to UI status enum
    agentCount: a._count?.Agent || a.Agent?.length || 0,
    propertyCount: 0, // Fallback if API lacks it
    createdAt: a.createdAt,
  }));

  const filtered = agencies.filter(a => {
    const m = a.name.toLowerCase().includes(search.toLowerCase()) || a.email?.toLowerCase().includes(search.toLowerCase());
    return m && (filterStatus === "all" || a.status === filterStatus);
  });

  const createMutation = useMutation({
    mutationFn: (data: Partial<ApiAgency>) => agenciesApi.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agencies'] });
      setCreateOpen(false);
      toast({ title: t("client.src.agency_created"), description: `${form.name} has been added.` });
    },
    onError: () => toast({ title: "Error", description: "Failed to create agency", variant: "destructive" })
  });

  const updateMutation = useMutation({
    mutationFn: (variables: {id: string, data: Partial<ApiAgency>}) => agenciesApi.update(variables.id, variables.data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agencies'] });
      setEditOpen(false);
      toast({ title: t("client.src.agency_updated") });
    },
    onError: () => toast({ title: "Error", description: "Failed to update agency", variant: "destructive" })
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      name: form.name,
      email: form.email,
      phoneNumber: form.phoneNumber,
      address: form.address,
      isActive: form.status === "ACTIVE",
      description: form.description
    });
  };

  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({
        id: form.id,
        data: {
          name: form.name,
          email: form.email,
          phoneNumber: form.phoneNumber,
          address: form.address,
          isActive: form.status === "ACTIVE",
          description: form.description
        }
      });
    }
  };
  const openEdit = (a: LocalAgency) => {
    setForm({
      id: a.id,
      name: a.name,
      email: a.email || "",
      phoneNumber: a.phoneNumber || "",
      address: a.address || "",
      website: a.website || "",
      status: a.status as any,
      description: ""
    });
    setEditOpen(true);
  };
  const AgencyForm = ({
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
        <Label>{t("client.src.agency_name")}</Label>
        <Input value={form.name} onChange={e => setForm({
          ...form,
          name: e.target.value
        })} required />
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5">
          <Label>{t("client.src.email")}</Label>
          <Input type="email" value={form.email} onChange={e => setForm({
            ...form,
            email: e.target.value
          })} />
        </div>
        <div className="space-y-1.5">
          <Label>{t("client.src.phone")}</Label>
          <Input value={form.phoneNumber} onChange={e => setForm({
            ...form,
            phoneNumber: e.target.value
          })} />
        </div>
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.address")}</Label>
        <Input value={form.address} onChange={e => setForm({
          ...form,
          address: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.website")}</Label>
        <Input type="url" value={form.website} onChange={e => setForm({
          ...form,
          website: e.target.value
        })} placeholder={t("client.src.https")} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({
          ...form,
          status: v as any
        })}>
          <SelectTrigger><SelectValue /></SelectTrigger>
          <SelectContent>
            <SelectItem value="ACTIVE">{t("client.src.active")}</SelectItem>
            <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
            <SelectItem value="SUSPENDED">{t("client.src.suspended")}</SelectItem>
          </SelectContent>
        </Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.description")}</Label>
        <Textarea value={form.description} onChange={e => setForm({
          ...form,
          description: e.target.value
        })} rows={3} />
      </div>
      <DialogFooter>
        <Button type="submit">{label}</Button>
      </DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.agencies")} description={t("client.src.manage_real_estate_agencies")} createLabel="Add Agency" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search agencies..." stats={[{
      label: t("client.src.total_agencies"),
      value: agencies.length
    }, {
      label: t("client.src.active"),
      value: agencies.filter(a => a.status === "ACTIVE").length
    }, {
      label: t("client.src.total_agents"),
      value: agencies.reduce((s, a) => s + (a.agentCount || 0), 0)
    }, {
      label: t("client.src.total_properties"),
      value: agencies.reduce((s, a) => s + (a.propertyCount || 0), 0)
    }]} filters={<Select value={filterStatus} onValueChange={setFilterStatus}>
            <SelectTrigger className="w-36"><SelectValue placeholder={t("client.src.status")} /></SelectTrigger>
            <SelectContent>
              <SelectItem value="all">{t("client.src.all_statuses")}</SelectItem>
              <SelectItem value="ACTIVE">{t("client.src.active")}</SelectItem>
              <SelectItem value="PENDING">{t("client.src.pending")}</SelectItem>
              <SelectItem value="SUSPENDED">{t("client.src.suspended")}</SelectItem>
            </SelectContent>
          </Select>}>
        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
          {isLoading && <div className="col-span-full flex justify-center py-16 text-muted-foreground"><Loader2 className="w-8 h-8 animate-spin text-primary" /></div>}
          {!isLoading && filtered.length === 0 && <div className="col-span-full text-center py-16 text-muted-foreground">{t("client.src.no_agencies_found")}</div>}
          {filtered.map(agency => <div key={agency.id} className="bg-card border border-border rounded-xl p-5 space-y-4">
              <div className="flex items-start justify-between">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center">
                    <Building2 className="w-5 h-5 text-primary" />
                  </div>
                  <div>
                    <p className="font-semibold text-sm">{agency.name}</p>
                    <Badge className={`${STATUS_COLORS[agency.status]} border-0 text-xs mt-0.5`}>{agency.status}</Badge>
                  </div>
                </div>
                <DropdownMenu>
                  <DropdownMenuTrigger asChild>
                    <Button variant="ghost" size="icon" className="h-8 w-8">
                      <MoreHorizontal className="w-4 h-4" />
                    </Button>
                  </DropdownMenuTrigger>
                  <DropdownMenuContent align="end">
                    <DropdownMenuItem onClick={() => openEdit(agency)}><Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                    <DropdownMenuItem className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                  </DropdownMenuContent>
                </DropdownMenu>
              </div>
              <div className="space-y-1.5 text-xs text-muted-foreground">
                {agency.email && <p className="flex items-center gap-1.5"><Mail className="w-3.5 h-3.5" />{agency.email}</p>}
                {agency.phoneNumber && <p className="flex items-center gap-1.5"><Phone className="w-3.5 h-3.5" />{agency.phoneNumber}</p>}
                {agency.website && <a href={agency.website} target="_blank" rel="noopener noreferrer" className="flex items-center gap-1.5 text-primary hover:underline">
                    <Globe className="w-3.5 h-3.5" />{agency.website.replace("https://", "")}
                    <ExternalLink className="w-3 h-3" />
                  </a>}
              </div>
              <div className="grid grid-cols-2 gap-2 pt-2 border-t border-border">
                <div className="text-center">
                  <p className="text-lg font-bold">{agency.agentCount}</p>
                  <p className="text-xs text-muted-foreground">{t("client.src.agents")}</p>
                </div>
                <div className="text-center">
                  <p className="text-lg font-bold">{agency.propertyCount}</p>
                  <p className="text-xs text-muted-foreground">{t("client.src.properties")}</p>
                </div>
              </div>
            </div>)}
        </div>
      </PageShell>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg">
          <DialogHeader><DialogTitle>{t("client.src.add_agency")}</DialogTitle><DialogDescription>{t("client.src.create_a_new_agency")}</DialogDescription></DialogHeader>
          <AgencyForm onSubmit={handleCreate} label={t("client.src.create_agency")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg">
          <DialogHeader><DialogTitle>{t("client.src.edit_agency")}</DialogTitle></DialogHeader>
          <AgencyForm onSubmit={handleEdit} label={t("client.src.save_changes")} />
        </DialogContent>
      </Dialog>
    </>;
}