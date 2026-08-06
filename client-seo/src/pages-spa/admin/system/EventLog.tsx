"use client";

import { useState, useEffect, useCallback } from"react";
import { useTranslation } from"react-i18next";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Button } from"@/components/ui/button";
import { Input } from"@/components/ui/input";
import { Badge } from"@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from"@/components/ui/dialog";
import { systemEventsApi } from"@/lib/api/system-events";
import { Eye, RefreshCw, Search } from"lucide-react";

const SEVERITY_COLORS: Record<string, string> = {
 INFO:"bg-muted text-muted-foreground",
 WARNING:"bg-yellow-100 text-yellow-800",
 ERROR:"bg-red-100 text-red-800",
 CRITICAL:"bg-muted text-muted-foreground",
};

const EVENT_TYPES = ["PROPERTY_CREATED","PROPERTY_UPDATED","PROPERTY_DELETED","BOOKING_CREATED","BOOKING_CONFIRMED","BOOKING_CANCELLED","BOOKING_CHECKED_IN","BOOKING_CHECKED_OUT","PAYMENT_RECEIVED","PAYMENT_REFUNDED","PAYMENT_FAILED","LEASE_CREATED","LEASE_SIGNED","LEASE_EXPIRED","LEASE_TERMINATED","TENANT_ADDED","TENANT_REMOVED","MAINTENANCE_REQUESTED","MAINTENANCE_COMPLETED","INVOICE_CREATED","INVOICE_PAID","INVOICE_OVERDUE","LEAD_CREATED","LEAD_CONVERTED","LEAD_LOST","CONTRACT_CREATED","CONTRACT_SIGNED","CONTRACT_EXPIRED","USER_REGISTERED","USER_LOGIN","USER_LOGGED_OUT","SYSTEM_ERROR","SYSTEM_WARNING","SYSTEM_CONFIG_CHANGED",
];

export default function EventLog() {
 const { t } = useTranslation();
 const [events, setEvents] = useState<any[]>([]);
 const [total, setTotal] = useState(0);
 const [page, setPage] = useState(1);
 const [limit] = useState(20);
 const [search, setSearch] = useState("");
 const [eventType, setEventType] = useState("");
 const [loading, setLoading] = useState(false);
 const [selected, setSelected] = useState<any>(null);

 const loadEvents = useCallback(async () => {
 setLoading(true);
 try {
 const res: any = await systemEventsApi.list({ page, limit, eventType: eventType || undefined });
 setEvents(res.data || []);
 setTotal(res.total || 0);
 } catch (e) {
 console.error(e);
 } finally {
 setLoading(false);
 }
 }, [page, limit, eventType]);

 useEffect(() => { loadEvents(); }, [loadEvents]);

 const filtered = events.filter((e: any) =>
 !search || JSON.stringify(e).toLowerCase().includes(search.toLowerCase())
 );
 const totalPages = Math.ceil(total / limit);

 const viewDetails = async (id: string) => {
 try {
 const res: any = await systemEventsApi.getById(id);
 setSelected(res.data || res);
 } catch (e) {
 console.error(e);
 }
 };

 const formatDate = (d: string) => {
 if (!d) return"-";
 return new Date(d).toLocaleString();
 };

 return (
 <PageShell title={t("admin_system_event_log")}>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-4">
 <div className="flex flex-wrap gap-3 items-center">
 <div className="relative flex-1 min-w-[200px]">
 <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
 <Input
 placeholder={t("admin_system_search_events")}
 className="pl-9"
 value={search}
 onChange={(e) => setSearch(e.target.value)}
 />
 </div>
 <Select value={eventType} onValueChange={(v) => { setEventType(v); setPage(1); }}>
 <SelectTrigger className="w-[200px]">
 <SelectValue placeholder={t("admin_system_all_event_types")} />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="">{t("admin_system_all_event_types")}</SelectItem>
 {EVENT_TYPES.map((et) => (
 <SelectItem key={et} value={et}>{et}</SelectItem>
 ))}
 </SelectContent>
 </Select>
 <Button variant="outline" onClick={loadEvents} disabled={loading}>
 <RefreshCw className={`h-4 w-4 mr-2 ${loading ?"animate-spin" :""}`} />
 {t("admin_system_refresh")}
 </Button>
 </div>

 <div className="border rounded-lg">
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_system_date")}</TableHead>
 <TableHead>{t("admin_system_event_type")}</TableHead>
 <TableHead>{t("admin_system_severity")}</TableHead>
 <TableHead>{t("admin_system_entity")}</TableHead>
 <TableHead>{t("admin_system_source")}</TableHead>
 <TableHead className="w-20">{t("admin_system_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {filtered.length === 0 ? (
 <TableRow>
 <TableCell colSpan={6} className="text-center py-8 text-muted-foreground">
 {loading ? t("admin_system_loading") : t("admin_system_no_events")}
 </TableCell>
 </TableRow>
 ) : filtered.map((event: any) => (
 <TableRow key={event.id}>
 <TableCell className="text-sm">{formatDate(event.createdAt)}</TableCell>
 <TableCell>
 <Badge variant="outline">{event.eventType}</Badge>
 </TableCell>
 <TableCell>
 <span className={`px-2 py-0.5 rounded-lg text-xs font-medium ${SEVERITY_COLORS[event.severity] ||"bg-card"}`}>
 {event.severity}
 </span>
 </TableCell>
 <TableCell className="text-sm">
 {event.entityType && event.entityId
 ? `${event.entityType}:${event.entityId?.slice(0, 8)}...`
 :"-"}
 </TableCell>
 <TableCell className="text-sm">{event.source ||"-"}</TableCell>
 <TableCell>
 <Button variant="ghost" size="sm" onClick={() => viewDetails(event.id)} aria-label={t("common.view")}>
 <Eye className="h-4 w-4" />
 </Button>
 </TableCell>
 </TableRow>
 ))}
 </TableBody>
 </Table>
 </div>

 {totalPages > 1 && (
 <div className="flex items-center justify-between">
 <span className="text-sm text-muted-foreground">{t("admin_system_total_events", { count: total })}</span>
 <div className="flex gap-2">
 <Button variant="outline" size="sm" disabled={page <= 1} onClick={() => setPage(p => p - 1)}>
 {t("admin_system_previous")}
 </Button>
 <span className="flex items-center text-sm">{page} {t("/", "/")}{totalPages}</span>
 <Button variant="outline" size="sm" disabled={page >= totalPages} onClick={() => setPage(p => p + 1)}>
 {t("admin_system_next")}
 </Button>
 </div>
 </div>
 )}
 </div>

 <Dialog open={!!selected} onOpenChange={() => setSelected(null)}>
 <DialogContent className="max-w-2xl">
 <DialogHeader>
 <DialogTitle>{t("admin_system_event_details")}</DialogTitle>
 </DialogHeader>
 {selected && (
 <div className="space-y-3 text-sm">
 <div className="grid grid-cols-2 gap-2">
 <div><span className="font-medium">{t("admin_system_event_type")}{t("mobile.leftovers.", ":")}</span> {selected.eventType}</div>
 <div><span className="font-medium">{t("admin_system_severity")}{t("mobile.leftovers.", ":")}</span> {selected.severity}</div>
 <div><span className="font-medium">{t("admin_system_date")}{t("mobile.leftovers.", ":")}</span> {formatDate(selected.createdAt)}</div>
 <div><span className="font-medium">{t("admin_system_source")}{t("mobile.leftovers.", ":")}</span> {selected.source ||"-"}</div>
 {selected.entityType && (
 <div><span className="font-medium">{t("admin_system_entity_type")}{t("mobile.leftovers.", ":")}</span> {selected.entityType}</div>
 )}
 {selected.entityId && (
 <div><span className="font-medium">{t("admin_system_entity_id")}{t("mobile.leftovers.", ":")}</span> {selected.entityId}</div>
 )}
 {selected.entityLabel && (
 <div><span className="font-medium">{t("admin_system_entity_label")}{t("mobile.leftovers.", ":")}</span> {selected.entityLabel}</div>
 )}
 <div><span className="font-medium">{t("admin_system_org_id")}{t("mobile.leftovers.", ":")}</span> {selected.orgId}</div>
 </div>
 {selected.payload && (
 <div>
 <span className="font-medium">{t("admin_system_payload")}{t("mobile.leftovers.", ":")}</span>
 <pre className="mt-1 p-2 bg-card rounded-lg text-xs overflow-auto max-h-48">
 {JSON.stringify(selected.payload, null, 2)}
 </pre>
 </div>
 )}
 {selected.metadata && (
 <div>
 <span className="font-medium">{t("admin_system_metadata")}{t("mobile.leftovers.", ":")}</span>
 <pre className="mt-1 p-2 bg-card rounded-lg text-xs overflow-auto max-h-32">
 {JSON.stringify(selected.metadata, null, 2)}
 </pre>
 </div>
 )}
 {selected.executions && selected.executions.length > 0 && (
 <div>
 <span className="font-medium">{t("admin_system_triggered_executions")}{t("mobile.leftovers.", ":")}</span>
 <div className="mt-1 space-y-1">
 {selected.executions.map((ex: any) => (
 <div key={ex.id} className="p-2 bg-card rounded-lg text-xs">
 <span className="font-medium">{ex.rule?.ruleName || ex.ruleId}</span>
 {" -"}{t("admin_property_status", "Durum:")}{ex.status} {t(" - ", "-")}{formatDate(ex.executedAt)}
 </div>
 ))}
 </div>
 </div>
 )}
 </div>
 )}
 </DialogContent>
 </Dialog>
 </PageShell>
 );
}
