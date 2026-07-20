"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
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
import { Edit, Trash2, MoreHorizontal, Loader2, RefreshCw, AlertTriangle, Clock, CheckCircle2 } from "lucide-react";
import { tasksApi, type Task } from "@/lib/api/tasks";
import { propertiesApi, type Property } from "@/lib/api/properties";
const PRIORITY_COLORS: Record<string, string> = {
  LOW: "bg-gray-100 text-gray-600",
  MEDIUM: "bg-blue-100 text-blue-700",
  HIGH: "bg-orange-100 text-orange-700",
  URGENT: "bg-red-100 text-red-700"
};
const STATUS_CONFIG: Record<string, {
  cls: string;
  icon: any;
}> = {
  OPEN: {
    cls: "bg-yellow-100 text-yellow-700",
    icon: Clock
  },
  IN_PROGRESS: {
    cls: "bg-blue-100 text-blue-700",
    icon: RefreshCw
  },
  COMPLETED: {
    cls: "bg-green-100 text-green-700",
    icon: CheckCircle2
  },
  CANCELLED: {
    cls: "bg-gray-100 text-gray-500",
    icon: AlertTriangle
  }
};

// CATEGORIES removed

const EMPTY_FORM = {
  title: "",
  description: "",
  propertyId: "",
  taskType: "MAINTENANCE",
  priority: "MEDIUM",
  status: "OPEN",
  dueDate: "",
  orgId: "" // Will be set from user context if available, but for now we rely on API to handle
};
export default function Maintenance() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [loading, setLoading] = useState(true);
  const [tasks, setTasks] = useState<Task[]>([]);
  const [properties, setProperties] = useState<Property[]>([]);
  const [filterStatus, setFilterStatus] = useState("all");
  const [filterPriority, setFilterPriority] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [editOpen, setEditOpen] = useState(false);
  const [form, setForm] = useState<any>(EMPTY_FORM);
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const fetchData = async () => {
    try {
      setLoading(true);
      const [tasksRes, propsRes] = await Promise.all([tasksApi.getAll({
        taskType: "MAINTENANCE"
      }), propertiesApi.getAll()]);
      setTasks(tasksRes.data || []);
      setProperties(propsRes || []);
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_load_data"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchData();
  }, []);
  const filtered = tasks.filter(t => {
    const m = `${t.title} ${t.description || ""}`.toLowerCase().includes(search.toLowerCase());
    const s = filterStatus === "all" || t.status === filterStatus;
    const p = filterPriority === "all" || t.priority === filterPriority;
    return m && s && p;
  });
  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      // In a real app, we'd get orgId from auth context
      const orgId = properties.find(p => p.id === form.propertyId)?.orgId || "";
      await tasksApi.create({
        ...form,
        orgId
      });
      setCreateOpen(false);
      toast({
        title: t("client.src.work_order_created")
      });
      setForm(EMPTY_FORM);
      fetchData();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_create_work"),
        variant: "destructive"
      });
    }
  };
  const handleEdit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedId) return;
    try {
      await tasksApi.update(selectedId, form);
      setEditOpen(false);
      toast({
        title: t("client.src.work_order_updated")
      });
      fetchData();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_update_work"),
        variant: "destructive"
      });
    }
  };
  const handleDelete = async (id: string) => {
    if (!confirm("Are you sure?")) return;
    try {
      await tasksApi.delete(id);
      toast({
        title: t("client.src.work_order_deleted"),
        variant: "destructive"
      });
      fetchData();
    } catch (error) {
      toast({
        title: t("client.src.error"),
        description: t("client.src.failed_to_delete_work"),
        variant: "destructive"
      });
    }
  };
  const openEdit = (t: Task) => {
    setSelectedId(t.id);
    setForm({
      title: t.title,
      description: t.description || "",
      propertyId: t.propertyId || "",
      priority: t.priority,
      status: t.status,
      dueDate: t.dueDate ? t.dueDate.split("T")[0] : "",
      taskType: "MAINTENANCE"
    });
    setEditOpen(true);
  };
  const WOForm = ({
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
        <Input value={form.title} onChange={e => setForm({
          ...form,
          title: e.target.value
        })} required placeholder={t("client.src.eg_broken_ac_in")} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.property")}</Label>
        <Select value={form.propertyId} onValueChange={v => setForm({
          ...form,
          propertyId: v
        })}>
          <SelectTrigger><SelectValue placeholder={t("client.src.select_property")} /></SelectTrigger>
          <SelectContent>
            {properties.map(p => <SelectItem key={p.id} value={p.id}>{p.name}</SelectItem>)}
          </SelectContent>
        </Select>
      </div>
      <div className="grid grid-cols-2 gap-4">
        <div className="space-y-1.5">
          <Label>{t("client.src.priority")}</Label>
          <Select value={form.priority} onValueChange={v => setForm({
            ...form,
            priority: v
          })}>
            <SelectTrigger><SelectValue /></SelectTrigger>
            <SelectContent>
              {Object.keys(PRIORITY_COLORS).map(p => <SelectItem key={p} value={p}>{p}</SelectItem>)}
            </SelectContent>
          </Select>
        </div>
        <div className="space-y-1.5">
          <Label>{t("client.src.status")}</Label>
          <Select value={form.status} onValueChange={v => setForm({
            ...form,
            status: v
          })}>
            <SelectTrigger><SelectValue /></SelectTrigger>
            <SelectContent>
              {Object.keys(STATUS_CONFIG).map(s => <SelectItem key={s} value={s}>{s.replace(/_/g, " ")}</SelectItem>)}
            </SelectContent>
          </Select>
        </div>
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.due_date")}</Label>
        <Input type="date" value={form.dueDate} onChange={e => setForm({
          ...form,
          dueDate: e.target.value
        })} />
      </div>
      <div className="space-y-1.5">
        <Label>{t("client.src.description")}</Label>
        <Textarea value={form.description} onChange={e => setForm({
          ...form,
          description: e.target.value
        })} rows={3} placeholder={t("client.src.detailed_issue_description")} />
      </div>
      <DialogFooter className="pt-2"><Button type="submit">{label}</Button></DialogFooter>
    </form>;
  };
  return <>
      <PageShell title={t("client.src.maintenance")} description={t("client.src.track_and_manage_property")} createLabel="New Work Order" onCreateClick={() => {
      setForm(EMPTY_FORM);
      setCreateOpen(true);
    }} searchValue={search} onSearchChange={setSearch} searchPlaceholder="Search work orders..." stats={[{
      label: t("client.src.total"),
      value: tasks.length
    }, {
      label: t("client.src.open"),
      value: tasks.filter(w => w.status === "OPEN").length
    }, {
      label: t("client.src.in_progress"),
      value: tasks.filter(w => w.status === "IN_PROGRESS").length
    }, {
      label: t("client.src.urgent"),
      value: tasks.filter(w => w.priority === "URGENT").length
    }]} actions={<Button variant="outline" size="icon" onClick={fetchData} disabled={loading}>
            <RefreshCw className={`w-4 h-4 ${loading ? 'animate-spin' : ''}`} />
          </Button>} filters={<div className="flex gap-2">
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-[140px] h-9"><SelectValue placeholder={t("client.src.status")} /></SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_status")}</SelectItem>
                {Object.keys(STATUS_CONFIG).map(s => <SelectItem key={s} value={s}>{s.replace(/_/g, " ")}</SelectItem>)}
              </SelectContent>
            </Select>
             <Select value={filterPriority} onValueChange={setFilterPriority}>
              <SelectTrigger className="w-[140px] h-9"><SelectValue placeholder={t("client.src.priority")} /></SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("client.src.all_priority")}</SelectItem>
                {Object.keys(PRIORITY_COLORS).map(p => <SelectItem key={p} value={p}>{p}</SelectItem>)}
              </SelectContent>
            </Select>
          </div>}>
        <div className="bg-card border border-border rounded-xl overflow-hidden shadow-sm">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.work_order")}</TableHead>
                <TableHead>{t("client.src.property")}</TableHead>
                <TableHead>{t("client.src.priority")}</TableHead>
                <TableHead>{t("client.src.status")}</TableHead>
                <TableHead>{t("client.src.due_date")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {loading ? <TableRow><TableCell colSpan={6} className="text-center py-12"><Loader2 className="w-6 h-6 animate-spin mx-auto text-muted-foreground" /></TableCell></TableRow> : filtered.length === 0 ? <TableRow><TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("client.src.no_work_orders_found")}</TableCell></TableRow> : filtered.map(task => {
              const s = STATUS_CONFIG[task.status] || STATUS_CONFIG.OPEN;
              const SIcon = s.icon;
              const pName = properties.find(p => p.id === task.propertyId)?.name || "—";
              return <TableRow key={task.id} className="hover:bg-muted/40 transition-colors">
                      <TableCell>
                        <div className="font-semibold text-sm">{task.title}</div>
                        <div className="text-[11px] text-muted-foreground line-clamp-1">{task.description || "No description"}</div>
                      </TableCell>
                      <TableCell className="text-sm font-medium">{pName}</TableCell>
                      <TableCell><Badge className={`${PRIORITY_COLORS[task.priority]} border-0 text-[10px]`}>{task.priority}</Badge></TableCell>
                      <TableCell><Badge className={`${s.cls} border-0 text-[10px] items-center gap-1`}><SIcon className="w-3 h-3" />{task.status.replace(/_/g, " ")}</Badge></TableCell>
                      <TableCell className="text-xs text-muted-foreground">{task.dueDate ? new Date(task.dueDate).toLocaleDateString() : "—"}</TableCell>
                      <TableCell>
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="w-32">
                            <DropdownMenuItem onClick={() => openEdit(task)}><Edit className="w-4 h-4 mr-2" />{t("client.src.edit")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => handleDelete(task.id)} className="text-destructive font-medium"><Trash2 className="w-4 h-4 mr-2" />{t("client.src.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </TableCell>
                    </TableRow>;
            })}
            </TableBody>
          </Table>
        </div>
      </PageShell>

      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg shadow-2xl">
          <DialogHeader><DialogTitle>{t("client.src.new_work_order")}</DialogTitle></DialogHeader>
          <WOForm onSubmit={handleCreate} label={t("client.src.create_work_order")} />
        </DialogContent>
      </Dialog>
      <Dialog open={editOpen} onOpenChange={setEditOpen}>
        <DialogContent className="sm:max-w-lg shadow-2xl">
          <DialogHeader><DialogTitle>{t("client.src.edit_work_order")}</DialogTitle></DialogHeader>
          <WOForm onSubmit={handleEdit} label={t("client.src.save_changes")} />
        </DialogContent>
      </Dialog>
    </>;
}