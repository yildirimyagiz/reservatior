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
import { Edit, Trash2, MoreHorizontal, Loader2 } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { agentTeamsApi, AgentTeam } from "@/lib/api/agent-teams";
import { useAuth } from "@/lib/auth/hooks";
const STATUS: Record<string, {
  label: string;
  cls: string;
}> = {
  ACTIVE: {
    label: t("client.src.active"),
    cls: "bg-green-100 text-green-700"
  },
  INACTIVE: {
    label: t("client.src.inactive"),
    cls: "bg-gray-100 text-gray-500"
  }
};
// MOCK removed
const EMPTY_FORM = {
  name: "",
  agencyName: "",
  leadAgentName: "",
  status: ""
};
export default function AgentTeams() {
  const {
    t
  } = useTranslation();
  const { toast } = useToast();
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const orgId = user?.orgId || (user as any)?.organizationId || "org_123";
  const [search, setSearch] = useState("");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const { data: teamsData = [], isLoading } = useQuery({
    queryKey: ['agent-teams', orgId],
    queryFn: async () => {
      const res = await agentTeamsApi.getAll(orgId);
      return (res as any)?.data || res || [];
    },
    enabled: !!orgId
  });

  const teams = Array.isArray(teamsData) ? teamsData : [];

  const filtered = teams.filter(row => String(row.name ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.name ?? "").toLowerCase().includes(search.toLowerCase()));
  
  const createMutation = useMutation({
    mutationFn: (data: any) => agentTeamsApi.create(orgId, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agent-teams'] });
      setCreateOpen(false);
      toast({ title: t("client.src.agentteams_created") });
      setForm(EMPTY_FORM);
    }
  });

  const updateMutation = useMutation({
    mutationFn: ({ id, data }: { id: string, data: any }) => agentTeamsApi.update(orgId, id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agent-teams'] });
      setEditOpen(false);
      toast({ title: t("client.src.agentteams_updated") });
    }
  });

  const deleteMutation = useMutation({
    mutationFn: (id: string) => agentTeamsApi.delete(orgId, id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['agent-teams'] });
      toast({ title: t("client.src.agentteams_deleted"), variant: "destructive" });
    }
  });

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    createMutation.mutate({
      name: form.name,
      teamLeadId: form.leadAgentName || "lead_1", // Needs proper lookup in real app
      status: form.status || "ACTIVE"
    });
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    if (form.id) {
      updateMutation.mutate({
        id: form.id,
        data: {
          name: form.name,
          teamLeadId: form.leadAgentName,
          status: form.status
        }
      });
    }
  };
  const handleDelete = (id: string) => {
    deleteMutation.mutate(id);
  };
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
        <Label>{t("client.src.team_name")}</Label>
        <Input type="text" value={form.name} onChange={e => setForm({
          ...form,
          name: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.agency")}</Label>
        <Input type="text" value={form.agencyName} onChange={e => setForm({
          ...form,
          agencyName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.lead_agent")}</Label>
        <Input type="text" value={form.leadAgentName} onChange={e => setForm({
          ...form,
          leadAgentName: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.status")}</Label>
        <Select value={form.status} onValueChange={v => setForm({
          ...form,
          status: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="ACTIVE">{t("client.src.active")}</SelectItem>
          <SelectItem value="INACTIVE">{t("client.src.inactive")}</SelectItem></SelectContent></Select>
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.agent_teams")} description={t("client.src.manage_teams_and_team")} createLabel="Add AgentTeams" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search agent teams..." stats={[{
      label: t("client.src.total_teams"),
      value: teams.length
    }, {
      label: t("client.src.active"),
      value: teams.filter(r => r.status === 'ACTIVE').length
    }, {
      label: t("client.src.total_members"),
      value: teams.reduce((s, r) => s + (r.members?.length || 0), 0)
    }]} filters={null}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("client.src.team_name")}</TableHead>
              <TableHead>{t("client.src.agency")}</TableHead>
              <TableHead>{t("client.src.members")}</TableHead>
              <TableHead>{t("client.src.lead_agent")}</TableHead>
              <TableHead>{t("client.src.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {isLoading && <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground"><Loader2 className="w-8 h-8 animate-spin mx-auto text-primary" /></TableCell></TableRow>}
              {!isLoading && filtered.length === 0 && <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_agent_teams_found")}</TableCell></TableRow>}
              {filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.name ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.agencyName || "—"}</TableCell>
                    <TableCell className="text-sm">{row.members?.length || 0}</TableCell>
                    <TableCell className="text-sm">{row.teamLead?.firstName ? `${row.teamLead.firstName} ${row.teamLead.lastName}` : (row.teamLeadId || "—")}</TableCell>
                    <TableCell>
                      {STATUS[row.status] ? <Badge className={`${STATUS[row.status].cls} border-0 text-xs`}>{STATUS[row.status].label}</Badge> : <span className="text-xs text-muted-foreground">{row.status}</span>}
                    </TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                        <DropdownMenuItem onClick={() => handleDelete(row.id)} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
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
          <DialogHeader><DialogTitle>{t("client.src.add_agentteams")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("client.src.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.edit_agentteams")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("client.src.save_changes")} />
        </DialogContent>
      </Dialog>
    </>;
}