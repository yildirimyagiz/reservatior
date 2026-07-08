"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import React, { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Plus, Search, Download, FileText, Eye, Trash2, Play, Pause, CheckCircle, XCircle, Clock, AlertTriangle, Settings, FileDown, Database, Users, Building2, Home } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogFooter } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { Progress } from "@/components/ui/progress";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
interface ExportJob {
  id: string;
  orgId: string;
  type: ExportType;
  status: ExportStatus;
  parameters: {
    filters?: Record<string, any>;
    format: string;
    compression?: boolean;
    includeHeaders?: boolean;
    dateRange?: {
      start: string;
      end: string;
    };
    fields?: string[];
  };
  config: {
    scheduled?: boolean;
    schedule?: string;
    recipients?: string[];
    retention?: number;
    encryption?: boolean;
  };
  progress?: {
    total: number;
    processed: number;
    percentage: number;
    currentStep?: string;
  };
  result?: {
    filePath?: string;
    fileSize?: number;
    recordCount?: number;
    downloadUrl?: string;
    expiresAt?: string;
  };
  error?: {
    message: string;
    code?: string;
    details?: any;
  };
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  startedAt?: string;
  completedAt?: string;
  user?: {
    id: string;
    name: string;
    email: string;
  };
}
enum ExportType {
  USERS = "USERS",
  PROPERTIES = "PROPERTIES",
  LISTINGS = "LISTINGS",
  CONTRACTS = "CONTRACTS",
  PAYMENTS = "PAYMENTS",
  REPORTS = "REPORTS",
  AUDIT_LOGS = "AUDIT_LOGS",
  FINANCIAL_DATA = "FINANCIAL_DATA",
  CUSTOM = "CUSTOM",
}
enum ExportStatus {
  PENDING = "PENDING",
  RUNNING = "RUNNING",
  COMPLETED = "COMPLETED",
  FAILED = "FAILED",
  CANCELLED = "CANCELLED",
  EXPIRED = "EXPIRED",
}
const EXPORT_TYPE_CONFIG = {
  USERS: {
    label: t("admin_integrations_users"),
    icon: Users,
    color: "bg-slate-100 text-slate-700"
  },
  PROPERTIES: {
    label: t("admin_integrations_properties"),
    icon: Building2,
    color: "bg-green-100 text-green-700"
  },
  LISTINGS: {
    label: t("admin_integrations_listings"),
    icon: Home,
    color: "bg-slate-100 text-slate-700"
  },
  CONTRACTS: {
    label: t("admin_integrations_contracts"),
    icon: FileText,
    color: "bg-orange-100 text-orange-700"
  },
  PAYMENTS: {
    label: t("admin_integrations_payments"),
    icon: Database,
    color: "bg-red-100 text-red-700"
  },
  REPORTS: {
    label: t("admin_integrations_reports"),
    icon: FileText,
    color: "bg-slate-100 text-slate-700"
  },
  AUDIT_LOGS: {
    label: t("admin_integrations_audit_logs"),
    icon: Settings,
    color: "bg-white/5 text-slate-300"
  },
  FINANCIAL_DATA: {
    label: t("admin_integrations_financial_data"),
    icon: Database,
    color: "bg-emerald-100 text-emerald-700"
  },
  CUSTOM: {
    label: t("admin_integrations_custom"),
    icon: Settings,
    color: "bg-pink-100 text-pink-700"
  }
};
const STATUS_CONFIG = {
  PENDING: {
    label: t("admin_integrations_pending"),
    color: "bg-yellow-100 text-yellow-700",
    icon: Clock
  },
  RUNNING: {
    label: t("admin_integrations_running"),
    color: "bg-slate-100 text-slate-700",
    icon: Play
  },
  COMPLETED: {
    label: t("admin_integrations_completed"),
    color: "bg-green-100 text-green-700",
    icon: CheckCircle
  },
  FAILED: {
    label: t("admin_integrations_failed"),
    color: "bg-red-100 text-red-700",
    icon: XCircle
  },
  CANCELLED: {
    label: t("admin_integrations_cancelled"),
    color: "bg-white/5 text-slate-300",
    icon: XCircle
  },
  EXPIRED: {
    label: t("admin_integrations_expired"),
    color: "bg-orange-100 text-orange-700",
    icon: AlertTriangle
  }
};
export default function ExportJobs() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const [search, setSearch] = useState("");
  const [filterType, setFilterType] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [createOpen, setCreateOpen] = useState(false);
  const [viewOpen, setViewOpen] = useState(false);
  const [jobs, setJobs] = useState<ExportJob[]>([]);
  const [loading, setLoading] = useState(true);
  const [selectedJob, setSelectedJob] = useState<ExportJob | null>(null);

  // Fetch export jobs from API
  useEffect(() => {
    const fetchJobs = async () => {
      try {
        setLoading(true);
        const response = await apiClient.get('/export-jobs', {
          page: "1",
          limit: "50",
          include: "user,result"
        });
        setJobs((response as any).data || []);
      } catch (error) {
        console.error('Error fetching export jobs:', error);
        toast({
          title: t("admin_integrations_error"),
          description: t("admin_integrations_failed_to_load_export"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };
    fetchJobs();
  }, []);
  const filteredJobs = jobs.filter(job => {
    const matchesSearch = job.type.toLowerCase().includes(search.toLowerCase()) || job.user?.name?.toLowerCase().includes(search.toLowerCase());
    const matchesType = filterType === "all" || job.type === filterType;
    const matchesStatus = filterStatus === "all" || job.status === filterStatus;
    return matchesSearch && matchesType && matchesStatus;
  });
  const totalJobs = filteredJobs.length;
  const runningJobs = filteredJobs.filter(j => j.status === "RUNNING").length;
  const completedJobs = filteredJobs.filter(j => j.status === "COMPLETED").length;
  const failedJobs = filteredJobs.filter(j => j.status === "FAILED").length;
  const handleCreateJob = async (data: any) => {
    try {
      await apiClient.post('/export-jobs', data);
      setCreateOpen(false);
      toast({
        title: t("admin_integrations_export_job_created"),
        description: t("admin_integrations_new_export_job_has")
      });
      // Refresh data
      const response = await apiClient.get('/export-jobs', {
        include: "user,result"
      });
      setJobs((response as any).data || []);
    } catch (error) {
      console.error('Error creating export job:', error);
      toast({
        title: t("admin_integrations_error"),
        description: t("admin_integrations_failed_to_create_export"),
        variant: "destructive"
      });
    }
  };
  const handleRunJob = async (id: string) => {
    try {
      await apiClient.post(`/export-jobs/${id}/run`);
      setJobs(jobs.map(job => job.id === id ? {
        ...job,
        status: ExportStatus.RUNNING,
        startedAt: new Date().toISOString()
      } : job));
      toast({
        title: t("admin_integrations_job_started"),
        description: t("admin_integrations_export_job_has_been")
      });
    } catch (error) {
      console.error('Error starting job:', error);
    }
  };
  const handlePauseJob = async (id: string) => {
    try {
      await apiClient.post(`/export-jobs/${id}/pause`);
      setJobs(jobs.map(job => job.id === id ? {
        ...job,
        status: ExportStatus.PENDING
      } : job));
      toast({
        title: t("admin_integrations_job_paused"),
        description: t("admin_integrations_export_job_has_been")
      });
    } catch (error) {
      console.error('Error pausing job:', error);
    }
  };
  const handleCancelJob = async (id: string) => {
    try {
      await apiClient.post(`/export-jobs/${id}/cancel`);
      setJobs(jobs.map(job => job.id === id ? {
        ...job,
        status: ExportStatus.CANCELLED
      } : job));
      toast({
        title: t("admin_integrations_job_cancelled"),
        description: t("admin_integrations_export_job_has_been")
      });
    } catch (error) {
      console.error('Error cancelling job:', error);
    }
  };
  const handleDeleteJob = async (id: string) => {
    try {
      await apiClient.delete(`/export-jobs/${id}`);
      setJobs(jobs.filter(job => job.id !== id));
      toast({
        title: t("admin_integrations_job_deleted"),
        description: t("admin_integrations_export_job_has_been")
      });
    } catch (error) {
      console.error('Error deleting job:', error);
    }
  };
  const handleDownloadResult = async (job: ExportJob) => {
    try {
      if (job.result?.downloadUrl) {
        window.open(job.result.downloadUrl, '_blank');
      } else if (job.result?.filePath) {
        const response = await apiClient.get(`/export-jobs/${job.id}/download`, {
          responseType: 'blob'
        });

        // Create download link
        const blob = new Blob([(response as any).data]);
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `export-${job.type.toLowerCase()}-${job.id}.${job.parameters.format}`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        window.URL.revokeObjectURL(url);
      }
    } catch (error) {
      console.error('Error downloading result:', error);
      toast({
        title: t("admin_integrations_download_failed"),
        description: t("admin_integrations_failed_to_download_export"),
        variant: "destructive"
      });
    }
  };
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString();
  };
  const formatDateTime = (dateString: string) => {
    return new Date(dateString).toLocaleString();
  };
  const formatFileSize = (bytes: number) => {
    if (bytes === 0) return '0 Bytes';
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  };
  const getExportTypeConfig = (type: ExportType) => {
    const config = EXPORT_TYPE_CONFIG[type as keyof typeof EXPORT_TYPE_CONFIG];
    return config || {
      label: type,
      icon: Settings,
      color: "bg-white/5 text-slate-300"
    };
  };
  const getStatusConfig = (status: ExportStatus) => {
    const config = STATUS_CONFIG[status as keyof typeof STATUS_CONFIG];
    return config || {
      label: status,
      icon: Clock,
      color: "bg-white/5 text-slate-300"
    };
  };
  return <PageShell title={t("admin_integrations_export_jobs")} description={t("admin_integrations_manage_data_export_jobs")}>
      <div className="space-y-6">
        {/* Summary Cards */}
        <div className="grid gap-4 md:grid-cols-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_integrations_total_jobs")}</CardTitle>
              <FileDown className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalJobs}</div>
              <p className="text-xs text-muted-foreground">{t("admin_integrations_all_export_jobs")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_integrations_running")}</CardTitle>
              <Play className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-slate-600">{runningJobs}</div>
              <p className="text-xs text-muted-foreground">{t("admin_integrations_currently_processing")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_integrations_completed")}</CardTitle>
              <CheckCircle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">{completedJobs}</div>
              <p className="text-xs text-muted-foreground">{t("admin_integrations_successfully_exported")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_integrations_failed")}</CardTitle>
              <XCircle className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-red-600">{failedJobs}</div>
              <p className="text-xs text-muted-foreground">{t("admin_integrations_need_attention")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex items-center justify-between space-x-4">
          <div className="flex items-center space-x-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-slate-500 dark:text-slate-400" />
              <Input placeholder={t("admin_integrations_search_jobs")} value={search} onChange={(e: React.ChangeEvent<HTMLInputElement>) => setSearch(e.target.value)} className="pl-8 w-64" />
            </div>
            <Select value={filterType} onValueChange={setFilterType}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("admin_integrations_type")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin_integrations_all_types")}</SelectItem>
                {Object.entries(EXPORT_TYPE_CONFIG).map(([key, config]) => <SelectItem key={key} value={key}>
                    {config.label}
                  </SelectItem>)}
              </SelectContent>
            </Select>
            <Select value={filterStatus} onValueChange={setFilterStatus}>
              <SelectTrigger className="w-32">
                <SelectValue placeholder={t("admin_integrations_status")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin_integrations_all_status")}</SelectItem>
                {Object.entries(STATUS_CONFIG).map(([key, config]) => <SelectItem key={key} value={key}>
                    {config.label}
                  </SelectItem>)}
              </SelectContent>
            </Select>
          </div>
          <Button onClick={() => setCreateOpen(true)}>
            <Plus className="h-4 w-4 mr-2" />{t("admin_integrations_create_export_job")}</Button>
        </div>

        {/* Export Jobs Table */}
        <Card>
          <CardHeader>
            <CardTitle>{t("admin_integrations_export_jobs")}</CardTitle>
            <CardDescription>{t("admin_integrations_monitor_and_manage_data")}</CardDescription>
          </CardHeader>
          <CardContent>
            {loading ? <div className="flex items-center justify-center py-8">
                <div className="text-sm text-muted-foreground">{t("admin_integrations_loading_export_jobs")}</div>
              </div> : <Table>
                <TableHeader>
                  <TableRow>
                    <TableHead>{t("admin_integrations_type")}</TableHead>
                    <TableHead>{t("admin_integrations_status")}</TableHead>
                    <TableHead>{t("admin_integrations_progress")}</TableHead>
                    <TableHead>{t("admin_integrations_created_by")}</TableHead>
                    <TableHead>{t("admin_integrations_created")}</TableHead>
                    <TableHead>{t("admin_integrations_completed")}</TableHead>
                    <TableHead>{t("admin_integrations_result")}</TableHead>
                    <TableHead className="w-[50px]"></TableHead>
                  </TableRow>
                </TableHeader>
                <TableBody>
                  {filteredJobs.length === 0 ? <TableRow>
                      <TableCell colSpan={9} className="text-center py-8">{t("admin_integrations_no_export_jobs_found")}</TableCell>
                    </TableRow> : filteredJobs.map(job => {
                const typeConfig = getExportTypeConfig(job.type);
                const statusConfig = getStatusConfig(job.status);
                const TypeIcon = typeConfig.icon;
                const StatusIcon = statusConfig.icon;
                return <TableRow key={job.id}>
                          <TableCell>
                            <div className="flex items-center space-x-2">
                              <TypeIcon className="h-4 w-4" />
                              <div>
                                <div className="font-medium">{typeConfig.label}</div>
                                <div className="text-sm text-slate-500 dark:text-slate-400">{job.parameters.format}</div>
                              </div>
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="flex items-center space-x-2">
                              <StatusIcon className="h-4 w-4" />
                              <Badge className={statusConfig.color}>
                                {statusConfig.label}
                              </Badge>
                            </div>
                          </TableCell>
                          <TableCell>
                            {job.progress ? <div className="w-32">
                                <Progress value={job.progress.percentage} className="w-full" />
                                <div className="text-xs text-slate-500 dark:text-slate-400 mt-1">
                                  {job.progress.processed} / {job.progress.total}
                                </div>
                                {job.progress.currentStep && <div className="text-xs text-slate-500 dark:text-slate-400 truncate">
                                    {job.progress.currentStep}
                                  </div>}
                              </div> : <div className="text-sm text-slate-500 dark:text-slate-400">-</div>}
                          </TableCell>
                          <TableCell>
                            <div>
                              <div className="font-medium">{job.user?.name}</div>
                              <div className="text-sm text-slate-500 dark:text-slate-400">{job.user?.email}</div>
                            </div>
                          </TableCell>
                          <TableCell>
                            <div className="text-sm">{formatDate(job.createdAt)}</div>
                          </TableCell>
                          <TableCell>
                            <div className="text-sm">
                              {job.completedAt ? formatDateTime(job.completedAt) : "-"}
                            </div>
                          </TableCell>
                          <TableCell>
                            {job.result ? <div className="text-sm">
                                <div>{formatFileSize(job.result.fileSize || 0)}</div>
                                <div className="text-slate-500 dark:text-slate-400">{job.result.recordCount || 0}{t("admin_integrations_records")}</div>
                                {job.result.expiresAt && <div className="text-xs text-orange-500">{t("admin_integrations_expires")}{formatDate(job.result.expiresAt)}
                                  </div>}
                              </div> : job.error ? <div className="text-sm text-red-500">
                                {job.error.message}
                              </div> : <div className="text-sm text-slate-500 dark:text-slate-400">-</div>}
                          </TableCell>
                          <TableCell>
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild>
                                <Button variant="ghost" size="sm">
                                  <MoreHorizontal className="h-4 w-4" />
                                </Button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent>
                                <DropdownMenuItem onClick={() => {
                          setSelectedJob(job);
                          setViewOpen(true);
                        }}>
                                  <Eye className="h-4 w-4 mr-2" />{t("admin_integrations_view_details")}</DropdownMenuItem>
                                {job.status === "PENDING" && <DropdownMenuItem onClick={() => handleRunJob(job.id)}>
                                    <Play className="h-4 w-4 mr-2" />{t("admin_integrations_run_job")}</DropdownMenuItem>}
                                {job.status === "RUNNING" && <DropdownMenuItem onClick={() => handlePauseJob(job.id)}>
                                    <Pause className="h-4 w-4 mr-2" />{t("admin_integrations_pause_job")}</DropdownMenuItem>}
                                {(job.status === "RUNNING" || job.status === "PENDING") && <DropdownMenuItem onClick={() => handleCancelJob(job.id)}>
                                    <XCircle className="h-4 w-4 mr-2" />{t("admin_integrations_cancel_job")}</DropdownMenuItem>}
                                {job.status === "COMPLETED" && job.result && <DropdownMenuItem onClick={() => handleDownloadResult(job)}>
                                    <Download className="h-4 w-4 mr-2" />{t("admin_integrations_download_result")}</DropdownMenuItem>}
                                <DropdownMenuItem className="text-red-600" onClick={() => handleDeleteJob(job.id)}>
                                  <Trash2 className="h-4 w-4 mr-2" />{t("admin_integrations_delete_job")}</DropdownMenuItem>
                              </DropdownMenuContent>
                            </DropdownMenu>
                          </TableCell>
                        </TableRow>;
              })}
                </TableBody>
              </Table>}
          </CardContent>
        </Card>

        {/* Create Export Job Dialog */}
        <Dialog open={createOpen} onOpenChange={setCreateOpen}>
          <DialogContent className="sm:max-w-[600px]">
            <DialogHeader>
              <DialogTitle>{t("admin_integrations_create_export_job")}</DialogTitle>
              <DialogDescription>{t("admin_integrations_create_a_new_data")}</DialogDescription>
            </DialogHeader>
            <div className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="type">{t("admin_integrations_export_type")}</Label>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={t("admin_integrations_select_type")} />
                    </SelectTrigger>
                    <SelectContent>
                      {Object.entries(EXPORT_TYPE_CONFIG).map(([key, config]) => <SelectItem key={key} value={key}>
                          {config.label}
                        </SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label htmlFor="format">{t("admin_integrations_format")}</Label>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder={t("admin_integrations_select_format")} />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="csv">{t("admin_integrations_csv")}</SelectItem>
                      <SelectItem value="json">{t("admin_integrations_json")}</SelectItem>
                      <SelectItem value="xlsx">{t("admin_integrations_excel")}</SelectItem>
                      <SelectItem value="pdf">{t("admin_integrations_pdf")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
              <div>
                <Label htmlFor="description">{t("admin_integrations_description")}</Label>
                <Textarea id="description" placeholder={t("admin_integrations_enter_export_job_description")} rows={3} />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="flex items-center space-x-2">
                  <input type="checkbox" id="includeHeaders" className="rounded-lg" />
                  <Label htmlFor="includeHeaders">{t("admin_integrations_include_headers")}</Label>
                </div>
                <div className="flex items-center space-x-2">
                  <input type="checkbox" id="compression" className="rounded-lg" />
                  <Label htmlFor="compression">{t("admin_integrations_compress_output")}</Label>
                </div>
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label htmlFor="dateStart">{t("admin_integrations_date_range_start")}</Label>
                  <Input id="dateStart" type="date" />
                </div>
                <div>
                  <Label htmlFor="dateEnd">{t("admin_integrations_date_range_end")}</Label>
                  <Input id="dateEnd" type="date" />
                </div>
              </div>
              <div>
                <Label htmlFor="recipients">{t("admin_integrations_email_recipients")}</Label>
                <Input id="recipients" placeholder={t("admin_integrations_email1examplecom_email2examplecom")} />
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setCreateOpen(false)}>{t("admin_integrations_cancel")}</Button>
              <Button onClick={() => handleCreateJob({})}>{t("admin_integrations_create_job")}</Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* View Details Dialog */}
        <Dialog open={viewOpen} onOpenChange={setViewOpen}>
          <DialogContent className="sm:max-w-[800px]">
            <DialogHeader>
              <DialogTitle>{t("admin_integrations_export_job_details")}</DialogTitle>
            </DialogHeader>
            {selectedJob && <div className="space-y-4">
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label>{t("admin_integrations_export_type")}</Label>
                    <div className="flex items-center space-x-2">
                      {React.createElement(getExportTypeConfig(selectedJob.type).icon, {
                    className: "h-4 w-4"
                  })}
                      <Badge className={getExportTypeConfig(selectedJob.type).color}>
                        {getExportTypeConfig(selectedJob.type).label}
                      </Badge>
                    </div>
                  </div>
                  <div>
                    <Label>{t("admin_integrations_status")}</Label>
                    <div className="flex items-center space-x-2">
                      {React.createElement(getStatusConfig(selectedJob.status).icon, {
                    className: "h-4 w-4"
                  })}
                      <Badge className={getStatusConfig(selectedJob.status).color}>
                        {getStatusConfig(selectedJob.status).label}
                      </Badge>
                    </div>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <Label>{t("admin_integrations_format")}</Label>
                    <div className="text-sm">{selectedJob.parameters.format}</div>
                  </div>
                  <div>
                    <Label>{t("admin_integrations_created_by")}</Label>
                    <div>
                      <div className="font-medium">{selectedJob.user?.name}</div>
                      <div className="text-sm text-slate-500 dark:text-slate-400">{selectedJob.user?.email}</div>
                    </div>
                  </div>
                </div>
                <div className="grid grid-cols-3 gap-4">
                  <div>
                    <Label>{t("admin_integrations_created")}</Label>
                    <div className="text-sm">{formatDateTime(selectedJob.createdAt)}</div>
                  </div>
                  <div>
                    <Label>{t("admin_integrations_started")}</Label>
                    <div className="text-sm">
                      {selectedJob.startedAt ? formatDateTime(selectedJob.startedAt) : "Not started"}
                    </div>
                  </div>
                  <div>
                    <Label>{t("admin_integrations_completed")}</Label>
                    <div className="text-sm">
                      {selectedJob.completedAt ? formatDateTime(selectedJob.completedAt) : "Not completed"}
                    </div>
                  </div>
                </div>
                {selectedJob.progress && <div>
                    <Label>{t("admin_integrations_progress")}</Label>
                    <div className="space-y-2">
                      <Progress value={selectedJob.progress.percentage} className="w-full" />
                      <div className="text-sm">
                        {selectedJob.progress.processed} / {selectedJob.progress.total} ({selectedJob.progress.percentage}%)
                      </div>
                      {selectedJob.progress.currentStep && <div className="text-sm text-slate-500 dark:text-slate-400">{t("admin_integrations_current")}{selectedJob.progress.currentStep}</div>}
                    </div>
                  </div>}
                {selectedJob.result && <div>
                    <Label>{t("admin_integrations_result")}</Label>
                    <div className="grid grid-cols-2 gap-4 text-sm">
                      <div>{t("admin_integrations_file_size")}{formatFileSize(selectedJob.result.fileSize || 0)}</div>
                      <div>{t("admin_integrations_records")}{selectedJob.result.recordCount || 0}</div>
                      {selectedJob.result.expiresAt && <div>{t("admin_integrations_expires")}{formatDate(selectedJob.result.expiresAt)}</div>}
                    </div>
                  </div>}
                {selectedJob.error && <div>
                    <Label>{t("admin_integrations_error")}</Label>
                    <div className="text-sm text-red-600">
                      <div className="font-medium">{selectedJob.error.message}</div>
                      {selectedJob.error.code && <div className="text-xs">{t("admin_integrations_code")}{selectedJob.error.code}</div>}
                    </div>
                  </div>}
              </div>}
            <DialogFooter>
              <Button variant="outline" onClick={() => setViewOpen(false)}>{t("admin_integrations_close")}</Button>
              {selectedJob?.status === "COMPLETED" && selectedJob.result && <Button onClick={() => handleDownloadResult(selectedJob)}>
                  <Download className="h-4 w-4 mr-2" />{t("admin_integrations_download_result")}</Button>}
            </DialogFooter>
          </DialogContent>
        </Dialog>
      </div>
    </PageShell>;
}