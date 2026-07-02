import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { aiApi, type AiServiceTask } from "@/lib/api/ai";
import { Settings, Play, Pause, CheckCircle, XCircle, MoreHorizontal } from "lucide-react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";

export default function AiServiceTaskPage() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [selectedTask, setSelectedTask] = useState<AiServiceTask | null>(null);
  const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
  const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
  
  const [form, setForm] = useState({
    orgId: '',
    propertyId: '',
    listingId: '',
    taskType: 'REELS_VIDEO_GEN' as AiServiceTask['taskType'],
    inputData: '',
    progress: 0,
    error: ''
  });

  const { data: tasks = [], isLoading: loading } = useQuery({
    queryKey: ['aiServiceTasks'],
    queryFn: () => aiApi.getServiceTasks(),
    refetchInterval: (query) => {
      // Smart polling: only poll if there are pending or processing tasks
      const data = query?.state?.data as any[];
      const hasActive = data?.some(t => t.status === 'PENDING' || t.status === 'PROCESSING');
      return hasActive ? 1500 : false;
    }
  });

  const createMutation = useMutation({
    mutationFn: () => aiApi.createServiceTask({
      orgId: form.orgId || undefined,
      propertyId: form.propertyId || undefined,
      listingId: form.listingId || undefined,
      taskType: form.taskType,
      inputData: form.inputData ? JSON.parse(form.inputData) : undefined,
      progress: form.progress,
      error: form.error || undefined
    }),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['aiServiceTasks'] });
      setIsCreateDialogOpen(false);
      resetForm();
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.service_task_created_successfully")
      });
    },
    onError: () => {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_create_service"),
        variant: "destructive"
      });
    }
  });

  const updateMutation = useMutation({
    mutationFn: () => {
      if (!selectedTask) throw new Error("No task selected");
      return aiApi.updateServiceTask(selectedTask.id, {
        progress: form.progress,
        error: form.error || undefined
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['aiServiceTasks'] });
      setIsEditDialogOpen(false);
      setSelectedTask(null);
      resetForm();
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.service_task_updated_successfully")
      });
    },
    onError: () => {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_update_service"),
        variant: "destructive"
      });
    }
  });

  const cancelMutation = useMutation({
    mutationFn: (id: string) => aiApi.cancelServiceTask(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['aiServiceTasks'] });
      toast({
        title: t("admin.ai.success"),
        description: t("admin.ai.service_task_cancelled_successfully")
      });
    },
    onError: () => {
      toast({
        title: t("admin.ai.error"),
        description: t("admin.ai.failed_to_cancel_service"),
        variant: "destructive"
      });
    }
  });

  const resetForm = () => {
    setForm({
      orgId: '',
      propertyId: '',
      listingId: '',
      taskType: 'REELS_VIDEO_GEN',
      inputData: '',
      progress: 0,
      error: ''
    });
  };

  const openEdit = (task: AiServiceTask) => {
    setSelectedTask(task);
    setForm({
      orgId: task.orgId,
      propertyId: task.propertyId || '',
      listingId: task.listingId || '',
      taskType: task.taskType,
      inputData: JSON.stringify(task.inputData, null, 2),
      progress: task.progress,
      error: task.error || ''
    });
    setIsEditDialogOpen(true);
  };

  const getStatusIcon = (status: AiServiceTask['status']) => {
    switch (status) {
      case 'COMPLETED':
        return <CheckCircle className="h-4 w-4 text-green-500" />;
      case 'FAILED':
        return <XCircle className="h-4 w-4 text-red-500" />;
      case 'PROCESSING':
        return <Settings className="h-4 w-4 text-blue-500 animate-spin" />;
      case 'PENDING':
        return <Play className="h-4 w-4 text-yellow-500" />;
      default:
        return <Settings className="h-4 w-4 text-gray-500" />;
    }
  };

  const getStatusColor = (status: AiServiceTask['status']) => {
    switch (status) {
      case 'COMPLETED':
        return 'bg-green-100 text-green-800';
      case 'FAILED':
        return 'bg-red-100 text-red-800';
      case 'PROCESSING':
        return 'bg-blue-100 text-blue-800';
      case 'PENDING':
        return 'bg-yellow-100 text-yellow-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };

  if (loading) {
    return <PageShell title={t("admin.ai.ai_service_tasks_management")}>
        <div className="flex items-center justify-center h-64">
          <Settings className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }

  return <PageShell title={t("admin.ai.ai_service_tasks_management")}>
      <div className="space-y-6">
        <div className="flex justify-between items-center">
          <div>
            <h1 className="text-3xl font-bold">{t("admin.ai.ai_service_tasks")}</h1>
            <p className="text-muted-foreground">{t("admin.ai.manage_aipowered_service_tasks")}</p>
          </div>
          <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
            <DialogTrigger asChild>
              <Button>
                <Play className="h-4 w-4 mr-2" />{t("admin.ai.create_task")}</Button>
            </DialogTrigger>
            <DialogContent className="max-w-2xl">
              <DialogHeader>
                <DialogTitle>{t("admin.ai.create_new_service_task")}</DialogTitle>
                <DialogDescription>{t("admin.ai.create_a_new_ai")}</DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="orgId" className="text-right">{t("admin.ai.organization_id")}</Label>
                  <Input id="orgId" value={form.orgId} onChange={e => setForm({
                  ...form,
                  orgId: e.target.value
                })} className="col-span-3" placeholder={t("admin.ai.org")} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="propertyId" className="text-right">{t("admin.ai.property_id")}</Label>
                  <Input id="propertyId" value={form.propertyId} onChange={e => setForm({
                  ...form,
                  propertyId: e.target.value
                })} className="col-span-3" placeholder={t("admin.ai.prop")} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="listingId" className="text-right">{t("admin.ai.listing_id")}</Label>
                  <Input id="listingId" value={form.listingId} onChange={e => setForm({
                  ...form,
                  listingId: e.target.value
                })} className="col-span-3" placeholder={t("admin.ai.listing")} />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="taskType" className="text-right">{t("admin.ai.task_type")}</Label>
                  <Select value={form.taskType} onValueChange={value => setForm({
                  ...form,
                  taskType: value as AiServiceTask['taskType']
                })}>
                    <SelectTrigger className="col-span-3">
                      <SelectValue />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="REELS_VIDEO_GEN">{t("admin.ai.reels_video_generation")}</SelectItem>
                      <SelectItem value="BROCHURE_GEN">{t("admin.ai.brochure_generation")}</SelectItem>
                      <SelectItem value="SEO_DESCRIPTION">{t("admin.ai.seo_description")}</SelectItem>
                      <SelectItem value="DOCUMENT_EXTRACT">{t("admin.ai.document_extraction")}</SelectItem>
                      <SelectItem value="SENTIMENT_ANALYSIS">{t("admin.ai.sentiment_analysis")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="progress" className="text-right">{t("admin.ai.progress")}</Label>
                  <Input id="progress" type="number" min="0" max="100" value={form.progress} onChange={e => setForm({
                  ...form,
                  progress: parseInt(e.target.value)
                })} className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-start gap-4">
                  <Label htmlFor="inputData" className="text-right pt-2">{t("admin.ai.input_data_json")}</Label>
                  <Textarea id="inputData" value={form.inputData} onChange={e => setForm({
                  ...form,
                  inputData: e.target.value
                })} className="col-span-3 min-h-32" placeholder={t("admin.ai.key_value")} />
                </div>
                <div className="grid grid-cols-4 items-start gap-4">
                  <Label htmlFor="error" className="text-right pt-2">{t("admin.ai.error_message")}</Label>
                  <Textarea id="error" value={form.error} onChange={e => setForm({
                  ...form,
                  error: e.target.value
                })} className="col-span-3 min-h-16" placeholder={t("admin.ai.error_message_if_any")} />
                </div>
              </div>
              <DialogFooter>
                <Button onClick={() => createMutation.mutate()} disabled={createMutation.isPending}>{t("admin.ai.create_task")}</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>

        <Card>
          <CardHeader>
            <CardTitle>{t("admin.ai.service_tasks")}</CardTitle>
          </CardHeader>
          <CardContent>
            <Table>
              <TableHeader>
                <TableRow>
                  <TableHead>{t("admin.ai.task_type")}</TableHead>
                  <TableHead>{t("admin.ai.entity")}</TableHead>
                  <TableHead>{t("admin.ai.status")}</TableHead>
                  <TableHead>{t("admin.ai.progress")}</TableHead>
                  <TableHead>{t("admin.ai.created")}</TableHead>
                  <TableHead className="text-right">{t("admin.ai.actions")}</TableHead>
                </TableRow>
              </TableHeader>
              <TableBody>
                {tasks.map((task: AiServiceTask) => <TableRow key={task.id}>
                    <TableCell className="font-medium">
                      <div className="flex items-center gap-2">
                        {getStatusIcon(task.status)}
                        <div>
                          <div className="font-medium">{task.taskType.replace(/_/g, ' ')}</div>
                          <div className="text-xs text-muted-foreground">
                            {task.propertyId ? `Property: ${task.propertyId}` : task.listingId ? `Listing: ${task.listingId}` : 'No entity'}
                          </div>
                        </div>
                      </div>
                    </TableCell>
                    <TableCell>
                      <div className="text-sm">
                        <div>{t("admin.ai.org")}{task.orgId}</div>
                        {task.propertyId && <div>{t("admin.ai.prop")}{task.propertyId}</div>}
                        {task.listingId && <div>{t("admin.ai.list")}{task.listingId}</div>}
                      </div>
                    </TableCell>
                    <TableCell>
                      <Badge className={getStatusColor(task.status)}>
                        {task.status}
                      </Badge>
                    </TableCell>
                    <TableCell>
                      <div className="flex items-center gap-2">
                        <div className="w-16 bg-gray-200 rounded-full h-2">
                          <div className="bg-blue-500 h-2 rounded-full transition-all duration-300" style={{
                        width: `${task.progress}%`
                      }} />
                        </div>
                        <span className="text-sm">{task.progress}%</span>
                      </div>
                    </TableCell>
                    <TableCell>
                      {new Date(task.createdAt).toLocaleDateString()}
                    </TableCell>
                    <TableCell className="text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" className="h-8 w-8 p-0">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuLabel>{t("admin.ai.actions")}</DropdownMenuLabel>
                          <DropdownMenuItem onClick={() => openEdit(task)}>
                            <Settings className="h-4 w-4 mr-2" />{t("admin.ai.edit")}</DropdownMenuItem>
                          {task.status !== 'COMPLETED' && task.status !== 'FAILED' && <DropdownMenuItem onClick={() => cancelMutation.mutate(task.id)} className="text-red-600">
                              <XCircle className="h-4 w-4 mr-2" />{t("admin.ai.cancel")}</DropdownMenuItem>}
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </TableCell>
                  </TableRow>)}
              </TableBody>
            </Table>
          </CardContent>
        </Card>

        <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
          <DialogContent className="max-w-2xl">
            <DialogHeader>
              <DialogTitle>{t("admin.ai.edit_service_task")}</DialogTitle>
              <DialogDescription>{t("admin.ai.update_the_service_task")}</DialogDescription>
            </DialogHeader>
            <div className="grid gap-4 py-4">
              <div className="grid grid-cols-4 items-center gap-4">
                <Label htmlFor="edit-progress" className="text-right">{t("admin.ai.progress")}</Label>
                <Input id="edit-progress" type="number" min="0" max="100" value={form.progress} onChange={e => setForm({
                ...form,
                progress: parseInt(e.target.value)
              })} className="col-span-3" />
              </div>
              <div className="grid grid-cols-4 items-start gap-4">
                <Label htmlFor="edit-error" className="text-right pt-2">{t("admin.ai.error_message")}</Label>
                <Textarea id="edit-error" value={form.error} onChange={e => setForm({
                ...form,
                error: e.target.value
              })} className="col-span-3 min-h-16" placeholder={t("admin.ai.error_message_if_any")} />
              </div>
            </div>
            <DialogFooter>
              <Button onClick={() => updateMutation.mutate()} disabled={updateMutation.isPending}>{t("admin.ai.update_task")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}