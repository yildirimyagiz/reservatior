import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Button } from "@/components/ui/button";
import { Progress } from "@/components/ui/progress";
import { Video, FileText, Search, Database, RefreshCcw, ExternalLink, AlertCircle, CheckCircle2, Clock } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useMutation, useQuery } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";

interface AiServiceTask {
  id: string;
  orgId?: string;
  taskType: string;
  priority: number;
  status: string;
  progress: number;
  listingId?: string;
  propertyId?: string;
  outputData?: { url?: string };
  error?: string;
  createdAt: string;
  updatedAt?: string;
}

export default function MLTasks() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [newTask, setNewTask] = useState({
    orgId: 'org_1',
    taskType: 'REELS_VIDEO_GEN',
    priority: 1
  });

  const { data: tasks = [], isLoading } = useQuery({
    queryKey: ['ml-tasks'],
    queryFn: async () => {
      const res = await apiClient.get('/api/v1/ai-service-task');
      return (res as any)?.data || [];
    },
    refetchInterval: 10000,
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => {
      const res = await apiClient.post('/api/v1/ai-service-task', data);
      return res;
    },
    onSuccess: () => {
      setIsAddOpen(false);
      toast({ title: "Success", description: "Task dispatched successfully" });
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
    }
  });

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
        return <RefreshCcw className="w-4 h-4 text-slate-400" />;
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
        return <Badge variant="outline" className="text-slate-400">{t("admin.ai.pending")}</Badge>;
    }
  };
  return <div className="min-h-screen p-4 md:p-8 space-y-6">
      <div className="space-y-6">
        <div className="grid gap-4 md:grid-cols-3">
          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.ai.active_tasks")}</CardTitle>
              <Clock className="h-4 w-4 text-blue-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-white">{tasks.filter((t: AiServiceTask) => t.status === "PROCESSING").length}</div>
            </CardContent>
          </Card>
          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.ai.completed_24h")}</CardTitle>
              <CheckCircle2 className="h-4 w-4 text-green-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-white">{tasks.filter((t: AiServiceTask) => t.status === "COMPLETED").length}</div>
            </CardContent>
          </Card>
          <Card className="bg-white/5 border-white/10">
            <CardHeader className="flex flex-row items-center justify-between pb-2">
              <CardTitle className="text-sm font-medium text-slate-400">{t("admin.ai.failed_tasks")}</CardTitle>
              <AlertCircle className="h-4 w-4 text-red-400" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-white">{tasks.filter((t: AiServiceTask) => t.status === "FAILED").length}</div>
            </CardContent>
          </Card>
        </div>

        <Card className="bg-white/5 border-white/10">
          <CardHeader className="flex flex-row items-center justify-between">
            <CardTitle className="text-white">{t("admin.ai.work_order_pipeline")}</CardTitle>
            <div className="flex gap-2">
              <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
                <DialogTrigger asChild>
                  <Button size="sm">Dispatch Task</Button>
                </DialogTrigger>
                <DialogContent className="sm:max-w-[425px] bg-white/5 border-white/10 text-white">
                  <DialogHeader>
                    <DialogTitle>Dispatch AI Task</DialogTitle>
                    <DialogDescription className="text-slate-400">
                      Create a new async task in the background.
                    </DialogDescription>
                  </DialogHeader>
                  <div className="grid gap-4 py-4">
                    <div className="grid grid-cols-4 items-center gap-4">
                      <Label className="text-right text-xs text-slate-400">Org ID</Label>
                      <Input className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={newTask.orgId} onChange={e => setNewTask({...newTask, orgId: e.target.value})} placeholder="org_1" />
                    </div>
                    <div className="grid grid-cols-4 items-center gap-4">
                      <Label className="text-right text-xs text-slate-400">Task Type</Label>
                      <Select value={newTask.taskType} onValueChange={v => setNewTask({...newTask, taskType: v})}>
                        <SelectTrigger className="col-span-3 h-10 bg-white/5 border-white/10 text-white"><SelectValue placeholder="Type" /></SelectTrigger>
                        <SelectContent className="bg-white/5 border-white/10 text-white">
                          <SelectItem value="REELS_VIDEO_GEN">Reels Gen</SelectItem>
                          <SelectItem value="PDF_BROCHURE_GEN">Brochure Gen</SelectItem>
                          <SelectItem value="DOCUMENT_OCR">Document OCR</SelectItem>
                          <SelectItem value="PROPERTY_VALUATION">Property Valuation</SelectItem>
                          <SelectItem value="MLS_SYNC">MLS Sync</SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                  </div>
                  <DialogFooter>
                    <Button variant="outline" className="border-white/10 text-slate-400" onClick={() => setIsAddOpen(false)}>Cancel</Button>
                    <Button onClick={() => createMutation.mutate(newTask)} disabled={createMutation.isPending}>
                      {createMutation.isPending ? "Dispatching..." : "Dispatch"}
                    </Button>
                  </DialogFooter>
                </DialogContent>
              </Dialog>
            </div>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow className="border-white/10">
                  <TableHead className="text-slate-400">{t("admin.ai.service_type")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.ai.listing_property")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.ai.status")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.ai.progress")}</TableHead>
                  <TableHead className="text-slate-400">{t("admin.ai.submitted")}</TableHead>
                  <TableHead className="text-right text-slate-400">{t("admin.ai.action")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {tasks.map((task: AiServiceTask) => <TableRow key={task.id} className="border-white/10">
                    <TableCell>
                      <div className="flex items-center gap-2">
                        {getTaskIcon(task.taskType)}
                        <span className="font-medium text-sm text-white">{task.taskType}</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="text-xs text-slate-400 font-mono">
                        {task.listingId || task.propertyId || "General"}
                      </div>
                    </TableCell>
                    <TableCell>{getStatusBadge(task.status)}</TableCell>
                    <TableCell className="min-w-[120px]">
                      <div className="flex items-center gap-2">
                        <Progress value={task.progress} className="h-1.5 w-24" />
                        <span className="text-[10px] text-slate-400">%{task.progress}</span>
                      </div>
                    </TableCell>
                    <TableCell className="text-xs text-slate-400">
                      {new Date(task.createdAt).toLocaleString()}
                    </TableCell>
                    <TableCell className="text-right">
                      {task.status === "COMPLETED" && task.outputData?.url && <Button variant="ghost" size="sm" asChild>
                          <a href={task.outputData.url} target="_blank" rel="noreferrer">
                            <ExternalLink className="w-4 h-4 text-slate-400" />
                          </a>
                        </Button>}
                      {task.status === "FAILED" && <Button variant="ghost" size="sm" onClick={() => alert(task.error)}>
                          <AlertCircle className="w-4 h-4 text-red-400" />
                        </Button>}
                    </TableCell>
                  </TableRow>)}
                {!isLoading && tasks.length === 0 && <TableRow>
                    <TableCell colSpan={6} className="text-center py-12 text-slate-400">{t("admin.ai.no_ml_tasks_found")}</TableCell>
                  </TableRow>}
              </TableBody>
            </Table>
          </CardContent>
        </Card>
      </div>
    </div>;
}
