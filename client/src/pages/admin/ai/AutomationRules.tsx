import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Switch } from "@/components/ui/switch";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Edit, Trash2, MoreHorizontal } from "lucide-react";
const MOCK: any[] = [{
  "id": "1",
  "name": "Auto-assign leads",
  "trigger": "LEAD_CREATED",
  "action": "ASSIGN_AGENT",
  "isActive": true,
  "executionCount": 142,
  "lastRun": "2025-01-10 08:45"
}, {
  "id": "2",
  "name": "Rent reminder 3 days before",
  "trigger": "PAYMENT_DUE",
  "action": "SEND_EMAIL",
  "isActive": true,
  "executionCount": 56,
  "lastRun": "2025-01-09 07:00"
}, {
  "id": "3",
  "name": "Lease expiry alert",
  "trigger": "LEASE_EXPIRING",
  "action": "NOTIFY_MANAGER",
  "isActive": true,
  "executionCount": 8,
  "lastRun": "2025-01-05 09:00"
}, {
  "id": "4",
  "name": "Score leads daily",
  "trigger": "SCHEDULE_DAILY",
  "action": "AI_LEAD_SCORE",
  "isActive": false,
  "executionCount": 0,
  "lastRun": null
}];
const EMPTY_FORM = {
  name: "",
  trigger: "",
  action: "",
  isActive: false
};
export default function AutomationRules() {
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
  const filtered = MOCK.filter(row => String(row.name ?? "").toLowerCase().includes(search.toLowerCase()) || String(row.trigger ?? "").toLowerCase().includes(search.toLowerCase()));
  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    setCreateOpen(false);
    toast({
      title: t("admin.ai.automationrules_created")
    });
    setForm(EMPTY_FORM);
  };
  const handleEdit = (e: React.FormEvent) => {
    e.preventDefault();
    setEditOpen(false);
    toast({
      title: t("admin.ai.automationrules_updated")
    });
  };
  const handleDelete = () => toast({
    title: t("admin.ai.automationrules_deleted"),
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
        <Label>{t("admin.ai.rule_name")}</Label>
        <Input type="text" value={form.name} onChange={e => setForm({
          ...form,
          name: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("admin.ai.trigger_event")}</Label>
        <Select value={form.trigger} onValueChange={v => setForm({
          ...form,
          trigger: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="LEAD_CREATED">{t("admin.ai.lead_created")}</SelectItem>
          <SelectItem value="PAYMENT_DUE">{t("admin.ai.payment_due")}</SelectItem>
          <SelectItem value="LEASE_EXPIRING">{t("admin.ai.lease_expiring")}</SelectItem>
          <SelectItem value="BOOKING_CONFIRMED">{t("admin.ai.booking_confirmed")}</SelectItem>
          <SelectItem value="SCHEDULE_DAILY">{t("admin.ai.daily_schedule")}</SelectItem></SelectContent></Select>
      </div>
      <div className="space-y-1.5">
        <Label>{t("admin.ai.action")}</Label>
        <Select value={form.action} onValueChange={v => setForm({
          ...form,
          action: v as any
        })}><SelectTrigger><SelectValue /></SelectTrigger><SelectContent>          <SelectItem value="ASSIGN_AGENT">{t("admin.ai.assign_agent")}</SelectItem>
          <SelectItem value="SEND_EMAIL">{t("admin.ai.send_email")}</SelectItem>
          <SelectItem value="NOTIFY_MANAGER">{t("admin.ai.notify_manager")}</SelectItem>
          <SelectItem value="AI_LEAD_SCORE">{t("admin.ai.ai_lead_score")}</SelectItem>
          <SelectItem value="CREATE_TASK">{t("admin.ai.create_task")}</SelectItem></SelectContent></Select>
      </div>
      <div className="flex items-center justify-between rounded-lg border border-border p-3">
        <Label>{t("admin.ai.active")}</Label>
        <Switch checked={form.isActive === "true" || form.isActive === true} onCheckedChange={v => setForm({
          ...form,
          isActive: String(v)
        })} />
      </div>
      <DialogFooter><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("admin.ai.automation_rules")} description={t("admin.ai.configure_automated_workflows_and")} createLabel={t("admin.ai.add_automation_rules", "Otomasyon Kuralı Ekle")} onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder={t("admin.ai.search_automation_rules", "Otomasyon kurallarında ara...")} stats={[{
      label: t("admin.ai.total_rules"),
      value: MOCK.length
    }, {
      label: t("admin.ai.active"),
      value: MOCK.filter(r => r.isActive).length
    }, {
      label: t("admin.ai.total_runs"),
      value: MOCK.reduce((s, r) => s + (r.executionCount || 0), 0)
    }]} filters={null}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
              <TableHead>{t("admin.ai.rule_name")}</TableHead>
              <TableHead>{t("admin.ai.trigger")}</TableHead>
              <TableHead>{t("admin.ai.action")}</TableHead>
              <TableHead>{t("admin.ai.active")}</TableHead>
              <TableHead>{t("admin.ai.runs")}</TableHead>
              <TableHead>{t("admin.ai.last_run")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {filtered.length === 0 && <TableRow><TableCell colSpan={7} className="text-center py-12 text-muted-foreground">{t("admin.ai.no_automation_rules_found")}</TableCell></TableRow>}
              {filtered.map(row => <TableRow key={row.id} className="hover:bg-muted/40">
                    <TableCell className="text-sm">{row.name ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.trigger ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.action ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.isActive ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.executionCount ?? "—"}</TableCell>
                    <TableCell className="text-sm">{row.lastRun ?? "—"}</TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                      <DropdownMenuContent align="end">
                        <DropdownMenuItem onClick={() => openEdit(row)}><Edit className="w-4 h-4 mr-2" />{t("admin.ai.edit")}</DropdownMenuItem>
                        <DropdownMenuItem onClick={() => handleDelete()} className="text-destructive"><Trash2 className="w-4 h-4 mr-2" />{t("admin.ai.delete")}</DropdownMenuItem>
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
          <DialogHeader><DialogTitle>{t("admin.ai.add_automationrules")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleCreate} label={t("admin.ai.create")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("admin.ai.edit_automationrules")}</DialogTitle></DialogHeader>
          <EntityForm onSubmit={handleEdit} label={t("admin.ai.save_changes")} />
        </DialogContent>
      </Dialog>
    </>;
}