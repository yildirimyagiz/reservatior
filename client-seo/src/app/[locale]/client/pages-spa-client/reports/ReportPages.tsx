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
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { Download, Play, MoreHorizontal, BarChart3, Clock, CheckCircle2, XCircle, RefreshCw, Webhook, Globe, Edit, Trash2 } from "lucide-react";
import { useEffect } from "react";
import { apiClient } from "@/lib/api/client";

// ─── Reports ─────────────────────────────────────────────────────────────────
interface Report {
  id: string;
  name: string;
  type: string;
  schedule: string;
  lastRun?: string;
  status: "READY" | "RUNNING" | "FAILED";
  format: string;
}
const MOCK_REPORTS: Report[] = [{
  id: "1",
  name: "Monthly Revenue Summary",
  type: "Financial",
  schedule: "Monthly",
  lastRun: "2025-01-01 06:00",
  status: "READY",
  format: "PDF"
}, {
  id: "2",
  name: "Occupancy Rate Report",
  type: "Property",
  schedule: "Weekly",
  lastRun: "2025-01-06 07:00",
  status: "READY",
  format: "Excel"
}, {
  id: "3",
  name: "Lead Conversion Funnel",
  type: "Sales",
  schedule: "Weekly",
  lastRun: "2025-01-06 07:00",
  status: "READY",
  format: "PDF"
}, {
  id: "4",
  name: "Maintenance Cost Analysis",
  type: "Operational",
  schedule: "Monthly",
  lastRun: "2025-01-01 06:00",
  status: "RUNNING",
  format: "PDF"
}, {
  id: "5",
  name: "Tenant Satisfaction Survey",
  type: "Tenant",
  schedule: "Quarterly",
  status: "FAILED",
  format: "CSV"
}];
export function Reports() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [createOpen, setCreateOpen] = useState(false);
  const [form, setForm] = useState({
    name: "",
    type: "",
    schedule: "Monthly",
    format: "PDF"
  });
  const [reports, setReports] = useState<Report[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  
  const fetchReports = async () => {
    try {
      setIsLoading(true);
      const res: any = await apiClient.get('/reports').catch(() => null);
      if (res && res.data) {
        setReports(res.data.map((r: any) => ({
          id: r.id,
          name: r.name || 'Unnamed Report',
          type: r.type || 'Operational',
          schedule: r.schedule || 'Manual',
          lastRun: r.lastRun ? new Date(r.lastRun).toLocaleString() : undefined,
          status: r.status || 'READY',
          format: r.format || 'PDF'
        })));
      }
    } catch (e) {
      console.error(e);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchReports();
  }, []);

  const handleRun = async (r: Report) => {
    try {
      await apiClient.post(`/reports/${r.id}/run`);
      toast({ title: `Running ${r.name}...` });
      fetchReports();
    } catch {
      toast({ title: `Error running ${r.name}`, variant: 'destructive' });
    }
  };
  const handleDownload = (r: Report) => toast({
    title: t("client.src.downloading"),
    description: r.name
  });
  const handleCreate = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await apiClient.post('/reports', form);
      setCreateOpen(false);
      toast({ title: t("client.src.report_created") });
      fetchReports();
    } catch {
      toast({ title: "Error creating report", variant: 'destructive' });
    }
  };
  const handleDelete = async (r: Report) => {
    try {
      await apiClient.delete(`/reports/${r.id}`);
      fetchReports();
    } catch {
      toast({ title: "Error deleting report", variant: 'destructive' });
    }
  };
  const STATUS_ICONS = {
    READY: CheckCircle2,
    RUNNING: RefreshCw,
    FAILED: XCircle
  };
  const STATUS_CLS = {
    READY: "bg-blue-100 text-blue-700",
    RUNNING: "bg-blue-100 text-blue-700",
    FAILED: "bg-red-100 text-red-700"
  };
  return <>
      <PageShell title={t("client.src.reports")} description={t("client.src.scheduled_and_ondemand_business")} createLabel="New Report" onCreateClick={() => setCreateOpen(true)} stats={[{
      label: t("client.src.total_reports"),
      value: reports.length
    }, {
      label: t("client.src.ready"),
      value: reports.filter(r => r.status === "READY").length
    }, {
      label: t("client.src.running"),
      value: reports.filter(r => r.status === "RUNNING").length
    }, {
      label: t("common.failed"),
      value: reports.filter(r => r.status === "FAILED").length
    }]}>
        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
          {isLoading ? (
            <p className="text-muted-foreground text-sm col-span-3">Loading...</p>
          ) : reports.length === 0 ? (
            <p className="text-muted-foreground text-sm col-span-3">No reports found.</p>
          ) : reports.map(r => {
          const SIcon = STATUS_ICONS[r.status] || CheckCircle2;
          return <div key={r.id} className="bg-card border border-border rounded-xl p-5 space-y-4">
                <div className="flex items-start justify-between">
                  <div className="flex items-center gap-3">
                    <div className="w-9 h-9 rounded-lg bg-primary/10 flex items-center justify-center"><BarChart3 className="w-4 h-4 text-primary" /></div>
                    <div>
                      <p className="font-semibold text-sm">{r.name}</p>
                      <p className="text-xs text-muted-foreground">{r.type} · {r.format}</p>
                    </div>
                  </div>
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                      <DropdownMenuItem onClick={() => handleRun(r)}><Play className="w-4 h-4 mr-2" />{t("client.src.run_now")}</DropdownMenuItem>
                      {r.status === "READY" && <DropdownMenuItem onClick={() => handleDownload(r)}><Download className="w-4 h-4 mr-2" />{t("common.download")}</DropdownMenuItem>}
                      <DropdownMenuItem className="text-destructive" onClick={() => handleDelete(r)}><Trash2 className="w-4 h-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </div>
                <div className="flex items-center justify-between">
                  <Badge className={`${STATUS_CLS[r.status] || STATUS_CLS.READY} border-0 text-xs`}><SIcon className={`w-3 h-3 mr-1 ${r.status === "RUNNING" ? "animate-spin" : ""}`} />{r.status}</Badge>
                  <div className="text-xs text-muted-foreground flex items-center gap-1"><Clock className="w-3 h-3" />{r.schedule}</div>
                </div>
                {r.lastRun && <p className="text-xs text-muted-foreground">{t("client.src.last_run")}{r.lastRun}</p>}
              </div>;
        })}
        </div>
      </PageShell>
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader><DialogTitle>{t("client.src.new_report")}</DialogTitle></DialogHeader>
          <form onSubmit={handleCreate} className="space-y-4 py-2">
            <div className="space-y-1.5"><Label>{t("client.src.report_name")}</Label><Input value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} required /></div>
            <div className="space-y-1.5"><Label>{t("common.type")}</Label>
              <Select value={form.type} onValueChange={v => setForm({
              ...form,
              type: v
            })}>
                <SelectTrigger><SelectValue placeholder={t("common.select_type")} /></SelectTrigger>
                <SelectContent><SelectItem value="Financial">{t("client.src.financial")}</SelectItem><SelectItem value="Property">{t("common.property")}</SelectItem><SelectItem value="Sales">{t("client.src.sales")}</SelectItem><SelectItem value="Operational">{t("client.src.operational")}</SelectItem><SelectItem value="Tenant">{t("common.tenant")}</SelectItem></SelectContent>
              </Select>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1.5"><Label>{t("client.src.schedule")}</Label>
                <Select value={form.schedule} onValueChange={v => setForm({
                ...form,
                schedule: v
              })}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent><SelectItem value="Daily">{t("client.src.daily")}</SelectItem><SelectItem value="Weekly">{t("client.src.weekly")}</SelectItem><SelectItem value="Monthly">{t("client.src.monthly")}</SelectItem><SelectItem value="Quarterly">{t("client.src.quarterly")}</SelectItem><SelectItem value="Manual">{t("client.src.manual_only")}</SelectItem></SelectContent>
                </Select>
              </div>
              <div className="space-y-1.5"><Label>{t("client.src.format")}</Label>
                <Select value={form.format} onValueChange={v => setForm({
                ...form,
                format: v
              })}>
                  <SelectTrigger><SelectValue /></SelectTrigger>
                  <SelectContent><SelectItem value="PDF">{t("client.src.pdf")}</SelectItem><SelectItem value="Excel">{t("client.src.excel")}</SelectItem><SelectItem value="CSV">{t("client.src.csv")}</SelectItem></SelectContent>
                </Select>
              </div>
            </div>
            <DialogFooter><Button type="submit">{t("client.src.create_report")}</Button></DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </>;
}

// ─── Webhooks ─────────────────────────────────────────────────────────────────
interface WebhookDef {
  id: string;
  name: string;
  url: string;
  events: string[];
  isActive: boolean;
  successRate: number;
  lastDelivery?: string;
}
const MOCK_WEBHOOKS: WebhookDef[] = [{
  id: "1",
  name: "CRM Sync Webhook",
  url: "https://crm.company.com/webhook",
  events: ["booking.created", "lead.updated"],
  isActive: true,
  successRate: 98.5,
  lastDelivery: "2025-01-10 09:12"
}, {
  id: "2",
  name: "Payment Processor",
  url: "https://payments.service.com/notify",
  events: ["payment.completed", "payment.failed"],
  isActive: true,
  successRate: 99.9,
  lastDelivery: "2025-01-10 08:45"
}, {
  id: "3",
  name: "Slack Notifications",
  url: "https://hooks.slack.com/services/XXX",
  events: ["lease.expiring", "maintenance.urgent"],
  isActive: false,
  successRate: 100,
  lastDelivery: "2025-01-05 10:00"
}];
export function Webhooks() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [createOpen, setCreateOpen] = useState(false);
  const [form, setForm] = useState({
    name: "",
    url: "",
    events: [] as string[]
  });
  const [webhooks, setWebhooks] = useState<WebhookDef[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  const fetchWebhooks = async () => {
    try {
      setIsLoading(true);
      const res: any = await apiClient.get('/webhooks').catch(() => null);
      if (res && res.data) {
        setWebhooks(res.data.map((w: any) => ({
          id: w.id,
          name: w.name || 'Unnamed Webhook',
          url: w.url || '',
          events: w.events || [],
          isActive: w.isActive !== undefined ? w.isActive : true,
          successRate: w.successRate || 100,
          lastDelivery: w.lastDelivery ? new Date(w.lastDelivery).toLocaleString() : undefined
        })));
      }
    } catch (e) {
      console.error(e);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchWebhooks();
  }, []);

  const AVAILABLE_EVENTS = ["booking.created", "booking.cancelled", "lead.created", "lead.updated", "payment.completed", "payment.failed", "lease.created", "lease.expiring", "maintenance.urgent", "property.listed"];
  const toggleEvent = (e: string) => setForm(f => ({
    ...f,
    events: f.events.includes(e) ? f.events.filter(x => x !== e) : [...f.events, e]
  }));
  const handleToggle = async (w: WebhookDef) => {
    try {
      await apiClient.put(`/webhooks/${w.id}`, { isActive: !w.isActive });
      fetchWebhooks();
      toast({ title: !w.isActive ? "Webhook Enabled" : "Webhook Disabled" });
    } catch {
      toast({ title: "Error toggling webhook", variant: 'destructive' });
    }
  };
  const handleTest = async (w: WebhookDef) => {
    try {
      await apiClient.post(`/webhooks/${w.id}/test`);
      toast({ title: t("client.src.test_payload_sent"), description: w.url });
    } catch {
      toast({ title: "Error testing webhook", variant: 'destructive' });
    }
  };
  const handleCreate = async (ev: React.FormEvent) => {
    ev.preventDefault();
    try {
      await apiClient.post('/webhooks', form);
      setCreateOpen(false);
      toast({ title: t("client.src.webhook_created") });
      fetchWebhooks();
    } catch {
      toast({ title: "Error creating webhook", variant: 'destructive' });
    }
  };
  const handleDelete = async (w: WebhookDef) => {
    try {
      await apiClient.delete(`/webhooks/${w.id}`);
      fetchWebhooks();
    } catch {
      toast({ title: "Error deleting webhook", variant: 'destructive' });
    }
  };
  return <>
      <PageShell title={t("client.src.webhooks")} description={t("client.src.realtime_event_notifications_to")} createLabel="Add Webhook" onCreateClick={() => {
      setForm({
        name: "",
        url: "",
        events: []
      });
      setCreateOpen(true);
    }} stats={[{
      label: t("common.total"),
      value: webhooks.length
    }, {
      label: t("common.active"),
      value: webhooks.filter(w => w.isActive).length
    }, {
      label: t("client.src.avg_success_rate"),
      value: `${webhooks.length ? (webhooks.reduce((s, w) => s + w.successRate, 0) / webhooks.length).toFixed(1) : 0}%`
    }, {
      label: t("client.src.events_tracked"),
      value: [...new Set(webhooks.flatMap(w => w.events))].length
    }]}>
        <div className="space-y-3">
          {isLoading ? (
            <p className="text-muted-foreground text-sm">Loading...</p>
          ) : webhooks.length === 0 ? (
            <p className="text-muted-foreground text-sm">No webhooks found.</p>
          ) : webhooks.map(w => <div key={w.id} className={`bg-card border rounded-xl p-5 space-y-3 ${!w.isActive ? "opacity-60" : "border-border"}`}>
              <div className="flex items-start justify-between">
                <div className="flex items-center gap-3">
                  <div className="w-9 h-9 rounded-lg bg-primary/10 flex items-center justify-center"><Webhook className="w-4 h-4 text-primary" /></div>
                  <div>
                    <p className="font-semibold text-sm">{w.name}</p>
                    <p className="text-xs font-mono text-muted-foreground truncate max-w-xs">{w.url}</p>
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  <Button variant="outline" size="sm" onClick={() => handleTest(w)}>{t("client.src.test")}</Button>
                  <Button variant="outline" size="sm" onClick={() => handleToggle(w)}>{w.isActive ? "Disable" : "Enable"}</Button>
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild><Button variant="ghost" size="icon" aria-label={t("common.more")} className="h-8 w-8"><MoreHorizontal className="w-4 h-4" /></Button></DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                      <DropdownMenuItem><Edit className="w-4 h-4 mr-2" />{t("common.edit")}</DropdownMenuItem>
                      <DropdownMenuItem className="text-destructive" onClick={() => handleDelete(w)}><Trash2 className="w-4 h-4 mr-2" />{t("common.delete")}</DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </div>
              </div>
              <div className="flex items-center gap-3 flex-wrap">
                {w.events.map(e => <Badge key={e} className="bg-secondary border-0 text-xs">{e}</Badge>)}
              </div>
              <div className="flex items-center justify-between text-xs text-muted-foreground pt-1 border-t border-border">
                <span>{t("client.src.success_rate")}<strong className="text-foreground">{w.successRate}%</strong></span>
                {w.lastDelivery && <span>{t("client.src.last_delivery")}{w.lastDelivery}</span>}
                <Badge className={`${w.isActive ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-gray-500"} border-0 text-xs`}>{w.isActive ? "Active" : "Inactive"}</Badge>
              </div>
            </div>)}
        </div>
      </PageShell>
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-lg max-h-[90vh] overflow-y-auto">
          <DialogHeader><DialogTitle>{t("client.src.add_webhook")}</DialogTitle></DialogHeader>
          <form onSubmit={handleCreate} className="space-y-4 py-2">
            <div className="space-y-1.5"><Label>{t("client.src.webhook_name")}</Label><Input value={form.name} onChange={e => setForm({
              ...form,
              name: e.target.value
            })} required /></div>
            <div className="space-y-1.5"><Label>{t("client.src.endpoint_url")}</Label><Input type="url" value={form.url} onChange={e => setForm({
              ...form,
              url: e.target.value
            })} placeholder={t("client.src.httpsyourservicecomwebhook")} required /></div>
            <div className="space-y-2">
              <Label>{t("client.src.events_to_subscribe")}</Label>
              <div className="grid grid-cols-2 gap-2">
                {AVAILABLE_EVENTS.map(evt => <label key={evt} className={`flex items-center gap-2 p-2 rounded-lg border cursor-pointer text-xs transition-colors ${form.events.includes(evt) ? "border-primary bg-primary/5" : "border-border hover:bg-muted/30"}`}>
                    <input type="checkbox" className="w-3.5 h-3.5" checked={form.events.includes(evt)} onChange={() => toggleEvent(evt)} />
                    {evt}
                  </label>)}
              </div>
            </div>
            <DialogFooter><Button type="submit">{t("client.src.create_webhook")}</Button></DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </>;
}

// ─── MLS Connections ─────────────────────────────────────────────────────────
export function MLSConnections() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const connections = [{
    id: "1",
    name: "RETS MLS Feed",
    provider: "RETS",
    status: "CONNECTED",
    listingsCount: 1240,
    lastSync: "2025-01-10 09:00",
    region: "California"
  }, {
    id: "2",
    name: "IDX Broker",
    provider: "IDX",
    status: "CONNECTED",
    listingsCount: 3400,
    lastSync: "2025-01-10 08:30",
    region: "Florida"
  }, {
    id: "3",
    name: "BRIGHT MLS",
    provider: "BrightMLS",
    status: "DISCONNECTED",
    listingsCount: 0,
    region: "Mid-Atlantic"
  }];
  const handleSync = (c: typeof connections[0]) => toast({
    title: `Syncing ${c.name}...`
  });
  const handleConnect = (c: typeof connections[0]) => toast({
    title: `${c.name} Connection Initiated`
  });
  return <PageShell title={t("client.src.mls_connections")} description={t("client.src.manage_mls_feed_connections")} createLabel="Add MLS" onCreateClick={() => toast({
    title: t("common.coming_soon")
  })} stats={[{
    label: t("client.src.total_connections"),
    value: connections.length
  }, {
    label: t("common.active"),
    value: connections.filter(c => c.status === "CONNECTED").length
  }, {
    label: t("client.src.total_listings_synced"),
    value: connections.reduce((s, c) => s + c.listingsCount, 0).toLocaleString()
  }, {
    label: t("common.last_sync"),
    value: "9:00 AM"
  }]}>
      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4">
        {connections.map(c => <div key={c.id} className="bg-card border border-border rounded-xl p-5 space-y-4">
            <div className="flex items-start justify-between">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-lg bg-blue-100 flex items-center justify-center text-lg">🏠</div>
                <div>
                  <p className="font-semibold text-sm">{c.name}</p>
                  <p className="text-xs text-muted-foreground">{c.provider} · {c.region}</p>
                </div>
              </div>
              <Badge className={`${c.status === "CONNECTED" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-gray-500"} border-0 text-xs`}>{c.status}</Badge>
            </div>
            <div className="text-sm text-muted-foreground space-y-1">
              <p><strong className="text-foreground">{c.listingsCount.toLocaleString()}</strong>{t("client.src.listings_synced")}</p>
              {c.lastSync && <p>{t("common.last_sync")}{c.lastSync}</p>}
            </div>
            <div className="flex gap-2">
              {c.status === "CONNECTED" ? <Button variant="outline" size="sm" className="flex-1" onClick={() => handleSync(c)}><RefreshCw className="w-3.5 h-3.5 mr-1.5" />{t("client.src.sync_now")}</Button> : <Button size="sm" className="flex-1" onClick={() => handleConnect(c)}><Globe className="w-3.5 h-3.5 mr-1.5" />{t("client.src.connect")}</Button>}
              <Button variant="ghost" size="icon" aria-label={t("common.edit")} className="h-8 w-8"><Edit className="w-3.5 h-3.5" /></Button>
            </div>
          </div>)}
      </div>
    </PageShell>;
}

// ─── Exports ──────────────────────────────────────────────────────────────────
export function Exports() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [createOpen, setCreateOpen] = useState(false);
  const [form, setForm] = useState({
    entity: "properties",
    format: "CSV",
    dateFrom: "",
    dateTo: ""
  });
  const exports = [{
    id: "1",
    name: "Properties Export",
    entity: "Properties",
    format: "CSV",
    status: "COMPLETED",
    size: "2.4 MB",
    createdAt: "2025-01-10 08:00",
    expiresAt: "2025-01-17"
  }, {
    id: "2",
    name: "Tenants & Leases",
    entity: "Tenants",
    format: "Excel",
    status: "COMPLETED",
    size: "1.1 MB",
    createdAt: "2025-01-09 15:30",
    expiresAt: "2025-01-16"
  }, {
    id: "3",
    name: "Financial Records Q4",
    entity: "Payments",
    format: "Excel",
    status: "PROCESSING",
    createdAt: "2025-01-10 09:30",
    expiresAt: ""
  }, {
    id: "4",
    name: "Audit Logs Jan",
    entity: "Audit",
    format: "CSV",
    status: "FAILED",
    createdAt: "2025-01-08 10:00",
    expiresAt: ""
  }];
  const STATUS_CLS = {
    COMPLETED: "bg-blue-100 text-blue-700",
    PROCESSING: "bg-blue-100 text-blue-700",
    FAILED: "bg-red-100 text-red-700"
  };
  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    setCreateOpen(false);
    toast({
      title: t("client.src.export_started")
    });
  };
  return <>
      <PageShell title={t("client.src.exports")} description={t("client.src.download_data_exports_for")} createLabel="New Export" onCreateClick={() => setCreateOpen(true)} stats={[{
      label: t("client.src.total_exports"),
      value: exports.length
    }, {
      label: t("common.completed"),
      value: exports.filter(e => e.status === "COMPLETED").length
    }, {
      label: t("common.processing"),
      value: exports.filter(e => e.status === "PROCESSING").length
    }, {
      label: t("common.failed"),
      value: exports.filter(e => e.status === "FAILED").length
    }]}>
        <div className="bg-card border border-border rounded-xl overflow-hidden">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("client.src.export")}</TableHead>
                <TableHead>{t("client.src.entity")}</TableHead>
                <TableHead>{t("client.src.format")}</TableHead>
                <TableHead>{t("client.src.size")}</TableHead>
                <TableHead>{t("common.created")}</TableHead>
                <TableHead>{t("client.src.expires")}</TableHead>
                <TableHead>{t("common.status")}</TableHead>
                <TableHead className="w-10" />
              </TableRow>
            </TableHeader>
            <TableBody>
              {exports.map(e => <TableRow key={e.id} className="hover:bg-muted/40">
                  <TableCell className="font-medium text-sm">{e.name}</TableCell>
                  <TableCell className="text-sm text-muted-foreground">{e.entity}</TableCell>
                  <TableCell><Badge className="bg-secondary border-0 text-xs">{e.format}</Badge></TableCell>
                  <TableCell className="text-sm text-muted-foreground">{e.size || "—"}</TableCell>
                  <TableCell className="text-xs text-muted-foreground">{e.createdAt}</TableCell>
                  <TableCell className="text-xs text-muted-foreground">{e.expiresAt || "—"}</TableCell>
                  <TableCell><Badge className={`${STATUS_CLS[e.status as keyof typeof STATUS_CLS]} border-0 text-xs`}>{e.status}</Badge></TableCell>
                  <TableCell>
                    {e.status === "COMPLETED" && <Button variant="ghost" size="icon" aria-label={t("common.download")} className="h-8 w-8" onClick={() => toast({
                  title: t("client.src.downloading")
                })}><Download className="w-4 h-4" /></Button>}
                  </TableCell>
                </TableRow>)}
            </TableBody>
          </Table>
        </div>
      </PageShell>
      <Dialog open={createOpen} onOpenChange={setCreateOpen}>
        <DialogContent className="sm:max-w-md">
          <DialogHeader><DialogTitle>{t("client.src.new_export")}</DialogTitle></DialogHeader>
          <form onSubmit={handleCreate} className="space-y-4 py-2">
            <div className="space-y-1.5"><Label>{t("client.src.entity")}</Label>
              <Select value={form.entity} onValueChange={v => setForm({
              ...form,
              entity: v
            })}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent>{["properties", "listings", "tenants", "payments", "leases", "bookings", "leads", "audit-logs"].map(e => <SelectItem key={e} value={e} className="capitalize">{e.replace(/-/g, " ")}</SelectItem>)}</SelectContent>
              </Select>
            </div>
            <div className="space-y-1.5"><Label>{t("client.src.format")}</Label>
              <Select value={form.format} onValueChange={v => setForm({
              ...form,
              format: v
            })}>
                <SelectTrigger><SelectValue /></SelectTrigger>
                <SelectContent><SelectItem value="CSV">{t("client.src.csv")}</SelectItem><SelectItem value="Excel">{t("client.src.excel_xlsx")}</SelectItem><SelectItem value="JSON">{t("client.src.json")}</SelectItem></SelectContent>
              </Select>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1.5"><Label>{t("client.src.date_from")}</Label><Input type="date" value={form.dateFrom} onChange={e => setForm({
                ...form,
                dateFrom: e.target.value
              })} /></div>
              <div className="space-y-1.5"><Label>{t("client.src.date_to")}</Label><Input type="date" value={form.dateTo} onChange={e => setForm({
                ...form,
                dateTo: e.target.value
              })} /></div>
            </div>
            <DialogFooter><Button type="submit">{t("client.src.start_export")}</Button></DialogFooter>
          </form>
        </DialogContent>
      </Dialog>
    </>;
}