import { useState, useEffect, useCallback } from "react";
import { useTranslation } from "react-i18next";
import { PageShell } from "../../client/layout/PageShell";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";

import { Eye, RefreshCw } from "lucide-react";
import { automationExecutionsApi } from "@/lib/api/automation-rules";

const STATUS_COLORS: Record<string, string> = {
  COMPLETED: "bg-green-100 text-green-800",
  PARTIAL: "bg-yellow-100 text-yellow-800",
  FAILED: "bg-red-100 text-red-800",
  PENDING: "bg-blue-100 text-blue-800",
  SKIPPED: "bg-gray-100 text-gray-500",
};

export default function AutomationExecutionHistory() {
  const { t } = useTranslation();
  const [executions, setExecutions] = useState<any[]>([]);
  const [total, setTotal] = useState(0);
  const [page, setPage] = useState(1);
  const [limit] = useState(20);
  const [status, setStatus] = useState("");
  const [loading, setLoading] = useState(false);
  const [selected, setSelected] = useState<any>(null);

  const load = useCallback(async () => {
    setLoading(true);
    try {
      const res: any = await automationExecutionsApi.list({ page, limit, status: status || undefined });
      setExecutions(res.data || []);
      setTotal(res.total || 0);
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  }, [page, limit, status]);

  useEffect(() => { load(); }, [load]);

  const totalPages = Math.ceil(total / limit);
  const formatDate = (d: string) => d ? new Date(d).toLocaleString() : "-";

  return (
    <PageShell title={t("admin.system.execution_history")}>
      <div className="space-y-4">
        <div className="flex items-center gap-3">
          <Select value={status} onValueChange={(v) => { setStatus(v); setPage(1); }}>
            <SelectTrigger className="w-[180px]">
              <SelectValue placeholder={t("admin.system.all_statuses")} />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value="">{t("admin.system.all_statuses")}</SelectItem>
              <SelectItem value="COMPLETED">COMPLETED</SelectItem>
              <SelectItem value="PARTIAL">PARTIAL</SelectItem>
              <SelectItem value="FAILED">FAILED</SelectItem>
              <SelectItem value="PENDING">PENDING</SelectItem>
            </SelectContent>
          </Select>
          <Button variant="outline" onClick={load} disabled={loading}>
            <RefreshCw className={`h-4 w-4 mr-2 ${loading ? "animate-spin" : ""}`} />
            {t("admin.system.refresh")}
          </Button>
        </div>

        <div className="border rounded-lg">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>{t("admin.system.date")}</TableHead>
                <TableHead>{t("admin.system.rule_name")}</TableHead>
                <TableHead>{t("admin.system.event_type")}</TableHead>
                <TableHead>{t("admin.system.status")}</TableHead>
                <TableHead>{t("admin.system.processing_time")}</TableHead>
                <TableHead className="w-20">{t("admin.system.actions")}</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {executions.length === 0 ? (
                <TableRow>
                  <TableCell colSpan={6} className="text-center py-8 text-gray-500">
                    {loading ? t("admin.system.loading") : t("admin.system.no_executions")}
                  </TableCell>
                </TableRow>
              ) : executions.map((ex: any) => (
                <TableRow key={ex.id}>
                  <TableCell className="text-sm">{formatDate(ex.executedAt || ex.createdAt)}</TableCell>
                  <TableCell className="font-medium">{ex.rule?.ruleName || ex.ruleId}</TableCell>
                  <TableCell>
                    {ex.event?.eventType ? (
                      <Badge variant="outline">{ex.event.eventType}</Badge>
                    ) : ex.triggerEvent?.type ? (
                      <Badge variant="outline">{ex.triggerEvent.type}</Badge>
                    ) : "-"}
                  </TableCell>
                  <TableCell>
                    <span className={`px-2 py-0.5 rounded text-xs font-medium ${STATUS_COLORS[ex.status] || "bg-gray-100"}`}>
                      {ex.status}
                    </span>
                  </TableCell>
                  <TableCell className="text-sm">
                    {ex.processingTimeMs ? `${ex.processingTimeMs}ms` : "-"}
                  </TableCell>
                  <TableCell>
                    <Button variant="ghost" size="sm" onClick={() => setSelected(ex)}>
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
            <span className="text-sm text-gray-500">{t("admin.system.total_executions", { count: total })}</span>
            <div className="flex gap-2">
              <Button variant="outline" size="sm" disabled={page <= 1} onClick={() => setPage(p => p - 1)}>
                {t("admin.system.previous")}
              </Button>
              <span className="flex items-center text-sm">{page} / {totalPages}</span>
              <Button variant="outline" size="sm" disabled={page >= totalPages} onClick={() => setPage(p => p + 1)}>
                {t("admin.system.next")}
              </Button>
            </div>
          </div>
        )}
      </div>

      <Dialog open={!!selected} onOpenChange={() => setSelected(null)}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>{t("admin.system.execution_details")}</DialogTitle>
          </DialogHeader>
          {selected && (
            <div className="space-y-3 text-sm">
              <div className="grid grid-cols-2 gap-2">
                <div><span className="font-medium">{t("admin.system.rule_name")}:</span> {selected.rule?.ruleName || selected.ruleId}</div>
                <div><span className="font-medium">{t("admin.system.status")}:</span> {selected.status}</div>
                <div><span className="font-medium">{t("admin.system.executed_at")}:</span> {formatDate(selected.executedAt)}</div>
                <div><span className="font-medium">{t("admin.system.processing_time")}:</span> {selected.processingTimeMs ? `${selected.processingTimeMs}ms` : "-"}</div>
              </div>
              {selected.event?.eventType && (
                <div>
                  <span className="font-medium">{t("admin.system.trigger_event")}:</span>
                  <div className="mt-1 p-2 bg-gray-50 rounded text-xs">
                    Type: {selected.event.eventType}
                    {selected.event.severity && ` | Severity: ${selected.event.severity}`}
                    {selected.event.entityType && ` | Entity: ${selected.event.entityType}:${selected.event.entityId || ""}`}
                  </div>
                </div>
              )}
              {selected.triggerEvent && (
                <div>
                  <span className="font-medium">{t("admin.system.trigger_data")}:</span>
                  <pre className="mt-1 p-2 bg-gray-50 rounded text-xs overflow-auto max-h-32">
                    {JSON.stringify(selected.triggerEvent, null, 2)}
                  </pre>
                </div>
              )}
              {selected.resultData && (
                <div>
                  <span className="font-medium">{t("admin.system.results")}:</span>
                  <pre className="mt-1 p-2 bg-gray-50 rounded text-xs overflow-auto max-h-48">
                    {JSON.stringify(selected.resultData, null, 2)}
                  </pre>
                </div>
              )}
              {selected.errorMessage && (
                <div>
                  <span className="font-medium">{t("admin.system.error")}:</span>
                  <pre className="mt-1 p-2 bg-red-50 rounded text-xs text-red-700">
                    {selected.errorMessage}
                  </pre>
                </div>
              )}
              {selected.executionData && (
                <div>
                  <span className="font-medium">{t("admin.system.execution_data")}:</span>
                  <pre className="mt-1 p-2 bg-gray-50 rounded text-xs overflow-auto max-h-48">
                    {JSON.stringify(selected.executionData, null, 2)}
                  </pre>
                </div>
              )}
            </div>
          )}
        </DialogContent>
      </Dialog>
    </PageShell>
  );
}
