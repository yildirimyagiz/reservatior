import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { aiExtendedApi, AiServiceTask } from "@/lib/api/ai-extended";
import { Video, FileText, Search, Database, RefreshCcw, ExternalLink, AlertCircle, CheckCircle2, Clock } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
export default function MLTasks() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [tasks, setTasks] = useState<AiServiceTask[]>([]);
  const [loading, setLoading] = useState(true);
  const fetchTasks = async () => {
    try {
      setLoading(true);
      const res = await aiExtendedApi.getTasks();
      setTasks(res);
    } catch (error) {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_fetch_ml"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  useEffect(() => {
    fetchTasks();
    const interval = setInterval(fetchTasks, 10000); // Polling every 10s
    return () => clearInterval(interval);
  }, []);
  const getTaskIcon = (type: string) => {
    switch (type) {
      case "REELS_VIDEO_GEN":
        return <Video className="w-4 h-4 text-purple-400" />;
      case "BROCHURE_GEN":
        return <FileText className="w-4 h-4 text-blue-400" />;
      case "SEO_DESCRIPTION":
        return <Search className="w-4 h-4 text-green-400" />;
      case "DOCUMENT_EXTRACT":
        return <Database className="w-4 h-4 text-orange-400" />;
      default:
        return <RefreshCcw className="w-4 h-4" />;
    }
  };
  const getStatusBadge = (status: string) => {
    switch (status) {
      case "COMPLETED":
        return <Badge className="bg-green-500/20 text-green-500 border-green-500/50">{t("admin.ai.completed")}</Badge>;
      case "PROCESSING":
        return <Badge className="bg-blue-500/20 text-blue-500 border-blue-500/50 animate-pulse">{t("admin.ai.processing")}</Badge>;
      case "FAILED":
        return <Badge className="bg-red-500/20 text-red-500 border-red-500/50">{t("admin.ai.failed")}</Badge>;
      default:
        return <Badge variant="outline">{t("admin.ai.pending")}</Badge>;
    }
  };
  return <PageShell title={t("admin.ai.ml_service_tasks")} description={t("admin.ai.monitor_and_manage_aidriven")}>
      <div className="space-y-6">
        <div className="grid gap-4 md:grid-cols-3">
          <Card className="bg-card/50 border-border">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.active_tasks")}</CardTitle>
              <Clock className="h-4 w-4 text-blue-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{tasks.filter(t => t.status === "PROCESSING").length}</div>
            </CardContent>
          </Card>
          <Card className="bg-card/50 border-border">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.completed_24h")}</CardTitle>
              <CheckCircle2 className="h-4 w-4 text-green-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{tasks.filter(t => t.status === "COMPLETED").length}</div>
            </CardContent>
          </Card>
          <Card className="bg-card/50 border-border">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium">{t("admin.ai.failed_tasks")}</CardTitle>
              <AlertCircle className="h-4 w-4 text-red-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{tasks.filter(t => t.status === "FAILED").length}</div>
            </CardContent>
          </Card>
        </div>

        <Card className="bg-card border-border">
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle>{t("admin.ai.work_order_pipeline")}</CardTitle>
            <Button variant="outline" size="sm" onClick={fetchTasks} className="gap-2">
              <RefreshCcw className="w-4 h-4" />{t("admin.ai.refresh")}</Button>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow className="hover:bg-transparent border-border">
                  <TableHead>{t("admin.ai.service_type")}</TableHead>
                  <TableHead>{t("admin.ai.listing_property")}</TableHead>
                  <TableHead>{t("admin.ai.status")}</TableHead>
                  <TableHead>{t("admin.ai.progress")}</TableHead>
                  <TableHead>{t("admin.ai.submitted")}</TableHead>
                  <TableHead className="text-right">{t("admin.ai.action")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {tasks.map(task => <TableRow key={task.id} className="border-border hover:bg-card/50">
                    <TableCell>
                      <div className="flex items-center gap-2">
                        {getTaskIcon(task.taskType)}
                        <span className="font-medium text-sm">{task.taskType}</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="text-xs text-muted-foreground font-mono">
                        {task.listingId || task.propertyId || "General"}
                      </div>
                    </TableCell>
                    <TableCell>{getStatusBadge(task.status)}</TableCell>
                    <TableCell className="min-w-[120px]">
                      <div className="flex items-center gap-2">
                        <Progress value={task.progress} className="h-1.5 w-24" />
                        <span className="text-[10px] text-muted-foreground">%{task.progress}</span>
                      </div>
                    </TableCell>
                    <TableCell className="text-xs text-muted-foreground">
                      {new Date(task.createdAt).toLocaleString()}
                    </TableCell>
                    <TableCell className="text-right">
                      {task.status === "COMPLETED" && task.outputData?.url && <Button variant="ghost" size="sm" asChild>
                          <a href={task.outputData.url} target="_blank" rel="noreferrer">
                            <ExternalLink className="w-4 h-4" />
                          </a>
                        </Button>}
                      {task.status === "FAILED" && <Button variant="ghost" size="sm" onClick={() => alert(task.error)}>
                          <AlertCircle className="w-4 h-4 text-red-400" />
                        </Button>}
                    </TableCell>
                  </TableRow>)}
                {!loading && tasks.length === 0 && <TableRow>
                    <TableCell colSpan={6} className="text-center py-12 text-muted-foreground">{t("admin.ai.no_ml_tasks_found")}</TableCell>
                  </TableRow>}
              </TableBody>
            </Table>
          </CardContent>
        </Card>
      </div>
    </PageShell>;
}