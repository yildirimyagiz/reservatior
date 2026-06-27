import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogDescription, DialogFooter } from "@/components/ui/dialog";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Switch } from "@/components/ui/switch";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { useToast } from "@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { customReportsApi } from "@/lib/api/custom-reports";
import { FileText, Plus, Edit, Trash2, Eye, Download, Play, RefreshCw, MoreHorizontal, BarChart3, PieChart, TrendingUp, Calendar, DollarSign, Home, Copy, Share2, Loader2 } from "lucide-react";
interface CustomReport {
  id: string;
  name: string;
  description: string;
  type: "TABULAR" | "CHART" | "DASHBOARD" | "SUMMARY";
  category: string;
  dataSource: string[];
  query: string;
  parameters: Record<string, any>;
  schedule: {
    enabled: boolean;
    frequency: "DAILY" | "WEEKLY" | "MONTHLY" | "QUARTERLY";
    time: string;
    recipients: string[];
  };
  format: "PDF" | "EXCEL" | "CSV" | "JSON";
  isActive: boolean;
  createdBy: string;
  createdAt: string;
  lastRun?: string;
  nextRun?: string;
  runCount: number;
  avgRunTime: number;
}
interface ReportTemplate {
  id: string;
  name: string;
  description: string;
  category: string;
  type: "TABULAR" | "CHART" | "DASHBOARD" | "SUMMARY";
  query: string;
  parameters: Record<string, any>;
  isPublic: boolean;
  usageCount: number;
}
const MOCK_REPORTS: CustomReport[] = [{
  id: "1",
  name: "Monthly Performance Summary",
  description: t("admin.reports.comprehensive_monthly_performance_report"),
  type: "DASHBOARD",
  category: "Performance",
  dataSource: ["agents", "properties", "bookings", "deals"],
  query: "SELECT * FROM agent_performance WHERE month = :month",
  parameters: {
    month: {
      type: "date",
      required: true
    },
    includeCharts: {
      type: "boolean",
      default: true
    }
  },
  schedule: {
    enabled: true,
    frequency: "MONTHLY",
    time: "09:00",
    recipients: ["manager@company.com", "team@company.com"]
  },
  format: "PDF",
  isActive: true,
  createdBy: "admin",
  createdAt: "2024-03-01",
  lastRun: "2024-03-28T09:00:00Z",
  nextRun: "2024-04-01T09:00:00Z",
  runCount: 28,
  avgRunTime: 45.2
}, {
  id: "2",
  name: "Lead Conversion Analysis",
  description: t("admin.reports.detailed_analysis_of_lead"),
  type: "CHART",
  category: "Sales",
  dataSource: ["leads", "agents", "deals"],
  query: "SELECT conversion_rate, source, agent FROM lead_analysis WHERE date BETWEEN :start_date AND :end_date",
  parameters: {
    startDate: {
      type: "date",
      required: true
    },
    endDate: {
      type: "date",
      required: true
    },
    groupBy: {
      type: "select",
      options: ["source", "agent", "property"],
      default: "source"
    }
  },
  schedule: {
    enabled: false,
    frequency: "WEEKLY",
    time: "10:00",
    recipients: []
  },
  format: "EXCEL",
  isActive: true,
  createdBy: "admin",
  createdAt: "2024-03-15",
  lastRun: "2024-03-27T14:30:00Z",
  nextRun: undefined,
  runCount: 12,
  avgRunTime: 23.8
}, {
  id: "3",
  name: "Property Inventory Report",
  description: t("admin.reports.complete_inventory_of_all"),
  type: "TABULAR",
  category: "Properties",
  dataSource: ["properties"],
  query: "SELECT * FROM properties WHERE status = :status",
  parameters: {
    status: {
      type: "select",
      options: ["active", "sold", "pending", "inactive"],
      default: "active"
    },
    includePhotos: {
      type: "boolean",
      default: false
    }
  },
  schedule: {
    enabled: true,
    frequency: "DAILY",
    time: "08:00",
    recipients: ["inventory@company.com"]
  },
  format: "CSV",
  isActive: true,
  createdBy: "admin",
  createdAt: "2024-03-10",
  lastRun: "2024-03-28T08:00:00Z",
  nextRun: "2024-03-29T08:00:00Z",
  runCount: 18,
  avgRunTime: 12.5
}];
const MOCK_TEMPLATES: ReportTemplate[] = [{
  id: "1",
  name: "Agent Performance Template",
  description: t("admin.reports.standard_template_for_agent"),
  category: "Performance",
  type: "DASHBOARD",
  query: "SELECT * FROM agent_performance WHERE date BETWEEN :start_date AND :end_date",
  parameters: {
    startDate: {
      type: "date",
      required: true
    },
    endDate: {
      type: "date",
      required: true
    },
    includeCharts: {
      type: "boolean",
      default: true
    }
  },
  isPublic: true,
  usageCount: 45
}, {
  id: "2",
  name: "Financial Summary Template",
  description: t("admin.reports.financial_performance_summary_template"),
  category: "Financial",
  type: "SUMMARY",
  query: "SELECT * FROM financial_summary WHERE period = :period",
  parameters: {
    period: {
      type: "select",
      options: ["monthly", "quarterly", "yearly"],
      default: "monthly"
    }
  },
  isPublic: true,
  usageCount: 23
}];
export default function CustomReports() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const queryClient = useQueryClient();
  const [activeTab, setActiveTab] = useState("reports");
  const [reportDialogOpen, setReportDialogOpen] = useState(false);

  const { data: reportsData, isLoading: loadingReports } = useQuery({
    queryKey: ['customReports'],
    queryFn: async () => {
      const res = await customReportsApi.getAll("current");
      const apiReports = Array.isArray(res) ? res : ((res as any).data || []);
      
      return apiReports.map((r: any) => ({
        id: r.id,
        name: r.name || "Unknown Report",
        description: r.description || "",
        type: (r.type === "DASHBOARD" || r.type === "CHART" || r.type === "SUMMARY") ? r.type : "TABULAR",
        category: r.category || "Performance",
        dataSource: r.configuration?.dataSource?.type ? [r.configuration.dataSource.type] : ["database"],
        query: r.configuration?.dataSource?.query || "",
        parameters: r.configuration?.dataSource?.parameters || {},
        schedule: {
          enabled: r.configuration?.scheduling?.enabled || false,
          frequency: r.configuration?.scheduling?.frequency === "WEEKLY" ? "WEEKLY" : (r.configuration?.scheduling?.frequency === "MONTHLY" ? "MONTHLY" : "DAILY"),
          time: "09:00",
          recipients: r.configuration?.scheduling?.recipients?.map((rec: any) => rec.destination) || [],
        },
        format: r.configuration?.scheduling?.recipients?.[0]?.format || "PDF",
        isActive: r.status === "ACTIVE",
        createdBy: r.createdBy || "system",
        createdAt: r.createdAt || new Date().toISOString(),
        lastRun: r.performance?.lastExecuted,
        nextRun: r.configuration?.scheduling?.nextRun,
        runCount: r.performance?.totalRecords || 0,
        avgRunTime: r.performance?.averageExecutionTime || 0
      })) as CustomReport[];
    }
  });

  const reports = reportsData && reportsData.length > 0 ? reportsData : MOCK_REPORTS;
  const [templates] = useState<ReportTemplate[]>(MOCK_TEMPLATES);

  const toggleReportMutation = useMutation({
    mutationFn: async (report: CustomReport) => {
      return await customReportsApi.update("current", report.id, {
        status: report.isActive ? "INACTIVE" as any : "ACTIVE"
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['customReports'] });
      toast({
        title: t("admin.reports.report_updated"),
        description: t("admin.reports.report_status_has_been")
      });
    },
    onError: (error: any) => {
      toast({
        title: t("admin.reports.error", "Hata"),
        description: error.message,
        variant: "destructive"
      });
    }
  });
  const getReportIcon = (type: string) => {
    switch (type) {
      case "TABULAR":
        return <FileText className="w-4 h-4" />;
      case "CHART":
        return <BarChart3 className="w-4 h-4" />;
      case "DASHBOARD":
        return <PieChart className="w-4 h-4" />;
      case "SUMMARY":
        return <TrendingUp className="w-4 h-4" />;
      default:
        return <FileText className="w-4 h-4" />;
    }
  };
  const getCategoryIcon = (category: string) => {
    switch (category) {
      case "Performance":
        return <TrendingUp className="w-4 h-4 text-green-600" />;
      case "Sales":
        return <DollarSign className="w-4 h-4 text-blue-600" />;
      case "Properties":
        return <Home className="w-4 h-4 text-purple-600" />;
      case "Financial":
        return <DollarSign className="w-4 h-4 text-orange-600" />;
      default:
        return <FileText className="w-4 h-4 text-gray-600" />;
    }
  };
  const getFormatIcon = (format: string) => {
    switch (format) {
      case "PDF":
        return <FileText className="w-4 h-4 text-red-600" />;
      case "EXCEL":
        return <FileText className="w-4 h-4 text-green-600" />;
      case "CSV":
        return <FileText className="w-4 h-4 text-blue-600" />;
      case "JSON":
        return <FileText className="w-4 h-4 text-gray-600" />;
      default:
        return <FileText className="w-4 h-4" />;
    }
  };
  const toggleReport = (report: CustomReport) => {
    toggleReportMutation.mutate(report);
  };
  const runReport = (report: CustomReport) => {
    toast({
      title: t("admin.reports.report_started"),
      description: `Running ${report.name}...`
    });
  };
  const duplicateReportMutation = useMutation({
    mutationFn: async (report: CustomReport) => {
      // Assuming you duplicate via creating a new report based on existing one
      return await customReportsApi.create("current", {
        orgId: "current",
        name: `${report.name} (Copy)`,
        description: report.description,
        type: report.type as any,
        category: report.category as any,
        status: report.isActive ? "ACTIVE" : "DRAFT",
        visibility: "PRIVATE",
        configuration: {
          dataSource: {
            type: "DATABASE",
            query: report.query,
            parameters: report.parameters,
          },
          visualization: {
            type: "TABLE",
            styling: { theme: "light", colorPalette: [] },
            interactions: {}
          },
          calculations: [],
          scheduling: {
            enabled: report.schedule.enabled,
            frequency: report.schedule.frequency,
            recipients: report.schedule.recipients.map(r => ({ destination: r, type: "EMAIL", format: report.format, enabled: true }))
          },
          caching: {
            enabled: false,
            ttl: undefined,
            strategy: undefined,
            maxSize: undefined
          }
        },
        permissions: {
          owner: "",
          viewers: [],
          editors: [],
          administrators: [],
          publicAccess: false,
          shareable: false,
          exportable: false
        },
        security: {
          encryption: false,
          dataMasking: {
            enabled: false,
            fields: []
          },
          accessControl: {
            enabled: false,
            roles: [],
            conditions: undefined
          },
          audit: {
            enabled: false,
            logLevel: "ERROR",
            retention: 0
          }
        },
        createdBy: ""
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['customReports'] });
      toast({
        title: t("admin.reports.report_duplicated"),
        description: t("admin.reports.report_has_been_duplicated")
      });
    }
  });

  const duplicateReport = (report: CustomReport) => {
    duplicateReportMutation.mutate(report);
  };
  const deleteReportMutation = useMutation({
    mutationFn: async (reportId: string) => {
      return await customReportsApi.delete("current", reportId);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['customReports'] });
      toast({
        title: t("admin.reports.report_deleted"),
        description: t("admin.reports.report_has_been_removed")
      });
    }
  });

  const deleteReport = (reportId: string) => {
    deleteReportMutation.mutate(reportId);
  };
  const stats = {
    totalReports: reports.length,
    activeReports: reports.filter(r => r.isActive).length,
    scheduledReports: reports.filter(r => r.schedule.enabled).length,
    totalRuns: reports.reduce((sum, r) => sum + r.runCount, 0),
    avgRunTime: reports.reduce((sum, r) => sum + r.avgRunTime, 0) / reports.length,
    totalTemplates: templates.length,
    publicTemplates: templates.filter(t => t.isPublic).length
  };
  return <PageShell title={t("admin.reports.custom_reports")} description={t("admin.reports.create_manage_and_schedule")}>
      <div className="space-y-6">
        {/* Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.reports.total_reports")}</p>
                  <p className="text-2xl font-bold">{stats.totalReports}</p>
                  <p className="text-xs text-gray-500">{t("admin.reports.all_reports")}</p>
                </div>
                <FileText className="w-8 h-8 text-blue-600" />
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.reports.active_reports")}</p>
                  <p className="text-2xl font-bold text-green-600">{stats.activeReports}</p>
                  <p className="text-xs text-gray-500">{t("admin.reports.currently_running")}</p>
                </div>
                <Play className="w-8 h-8 text-green-600" />
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.reports.scheduled_reports")}</p>
                  <p className="text-2xl font-bold text-purple-600">{stats.scheduledReports}</p>
                  <p className="text-xs text-gray-500">{t("admin.reports.automated_reports")}</p>
                </div>
                <Calendar className="w-8 h-8 text-purple-600" />
              </div>
            </CardContent>
          </Card>
          <Card>
            <CardContent className="p-4">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{t("admin.reports.total_runs")}</p>
                  <p className="text-2xl font-bold text-orange-600">{stats.totalRuns}</p>
                  <p className="text-xs text-gray-500">{t("admin.reports.all_time")}</p>
                </div>
                <RefreshCw className="w-8 h-8 text-orange-600" />
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Tabs */}
        <Tabs value={activeTab} onValueChange={setActiveTab}>
          <TabsList className="grid w-full grid-cols-3">
            <TabsTrigger value="reports">{t("admin.reports.reports")}</TabsTrigger>
            <TabsTrigger value="templates">{t("admin.reports.templates")}</TabsTrigger>
            <TabsTrigger value="scheduling">{t("admin.reports.scheduling")}</TabsTrigger>
          </TabsList>

          <TabsContent value="reports" className="space-y-6">
            <div className="flex justify-between items-center">
              <h3 className="text-lg font-semibold">{t("admin.reports.custom_reports")}</h3>
              <Button onClick={() => setReportDialogOpen(true)}>
                <Plus className="w-4 h-4 mr-2" />{t("admin.reports.create_report")}</Button>
            </div>

            <div className="space-y-4">
              {loadingReports ? (
                <div className="flex justify-center items-center py-12 text-muted-foreground">
                  <Loader2 className="w-8 h-8 animate-spin" />
                </div>
              ) : reports.map(report => <Card key={report.id}>
                  <CardContent className="p-6">
                    <div className="flex items-center justify-between">
                      <div className="flex-1">
                        <div className="flex items-center gap-3 mb-2">
                          {getReportIcon(report.type)}
                          <div>
                            <h4 className="font-medium">{report.name}</h4>
                            <div className="flex items-center gap-2 text-sm text-gray-600">
                              {getCategoryIcon(report.category)}
                              <Badge variant="outline">{report.category}</Badge>
                              <Badge variant="outline">{report.type}</Badge>
                              {getFormatIcon(report.format)}
                              <Badge variant="outline">{report.format}</Badge>
                            </div>
                          </div>
                        </div>
                        
                        <p className="text-sm text-gray-600 mb-3">{report.description}</p>
                        
                        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
                          <div>
                            <span className="text-gray-600">{t("admin.reports.runs")}</span>
                            <div className="font-medium">{report.runCount}</div>
                          </div>
                          <div>
                            <span className="text-gray-600">{t("admin.reports.avg_time")}</span>
                            <div className="font-medium">{report.avgRunTime}s</div>
                          </div>
                          <div>
                            <span className="text-gray-600">{t("admin.reports.last_run")}</span>
                            <div className="font-medium">
                              {report.lastRun ? new Date(report.lastRun).toLocaleDateString() : t("admin.reports.never", "Hiç")}
                            </div>
                          </div>
                          <div>
                            <span className="text-gray-600">{t("admin.reports.next_run")}</span>
                            <div className="font-medium">
                              {report.nextRun ? new Date(report.nextRun).toLocaleDateString() : t("admin.reports.not_scheduled", "Planlanmadı")}
                            </div>
                          </div>
                        </div>

                        {report.schedule.enabled && <div className="mt-3 p-3 bg-blue-50 rounded-lg">
                            <div className="text-sm font-medium mb-1">{t("admin.reports.schedule")}</div>
                            <div className="flex items-center gap-4 text-sm">
                              <span>{report.schedule.frequency}{t("admin.reports.at")}{report.schedule.time}</span>
                              <span>{report.schedule.recipients.length}{t("admin.reports.recipients")}</span>
                            </div>
                          </div>}
                      </div>
                      
                      <div className="flex items-center gap-3">
                        <Switch checked={report.isActive} onCheckedChange={() => toggleReport(report)} />
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="sm">
                              <MoreHorizontal className="w-4 h-4" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent>
                            <DropdownMenuItem onClick={() => runReport(report)}>
                              <Play className="w-4 h-4 mr-2" />{t("admin.reports.run_now")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => duplicateReport(report)}>
                              <Copy className="w-4 h-4 mr-2" />{t("admin.reports.duplicate")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Edit className="w-4 h-4 mr-2" />{t("admin.reports.edit")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Download className="w-4 h-4 mr-2" />{t("admin.reports.export")}</DropdownMenuItem>
                            <DropdownMenuItem>
                              <Share2 className="w-4 h-4 mr-2" />{t("admin.reports.share")}</DropdownMenuItem>
                            <DropdownMenuItem onClick={() => deleteReport(report.id)} className="text-red-600">
                              <Trash2 className="w-4 h-4 mr-2" />{t("admin.reports.delete")}</DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                    </div>
                  </CardContent>
                </Card>)}
            </div>
          </TabsContent>

          <TabsContent value="templates" className="space-y-6">
            <div className="flex justify-between items-center">
              <h3 className="text-lg font-semibold">{t("admin.reports.report_templates")}</h3>
              <Button onClick={() => toast({
              title: t("admin.reports.template_creator_coming_soon")
            })}>
                <Plus className="w-4 h-4 mr-2" />{t("admin.reports.create_template")}</Button>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {templates.map(template => <Card key={template.id} className="cursor-pointer hover:shadow-md transition-shadow">
                  <CardContent className="p-6">
                    <div className="flex items-center gap-3 mb-3">
                      {getReportIcon(template.type)}
                      <div className="flex-1">
                        <h4 className="font-medium">{template.name}</h4>
                        <div className="flex items-center gap-2 text-sm text-gray-600">
                          <Badge variant="outline">{template.category}</Badge>
                          {template.isPublic && <Badge className="bg-green-100 text-green-700">{t("admin.reports.public")}</Badge>}
                        </div>
                      </div>
                    </div>
                    
                    <p className="text-sm text-gray-600 mb-3">{template.description}</p>
                    
                    <div className="flex justify-between items-center text-sm">
                      <span className="text-gray-500">{t("admin.reports.used")}{template.usageCount}{t("admin.reports.times")}</span>
                      <div className="flex gap-2">
                        <Button variant="outline" size="sm">
                          <Eye className="w-3 h-3 mr-1" />{t("admin.reports.preview")}</Button>
                        <Button variant="outline" size="sm">
                          <Copy className="w-3 h-3 mr-1" />{t("admin.reports.use")}</Button>
                      </div>
                    </div>
                  </CardContent>
                </Card>)}
            </div>
          </TabsContent>

          <TabsContent value="scheduling" className="space-y-6">
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              <Card>
                <CardHeader>
                  <CardTitle>{t("admin.reports.schedule_overview")}</CardTitle>
                  <CardDescription>{t("admin.reports.upcoming_scheduled_reports")}</CardDescription>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {reports.filter(r => r.schedule.enabled && r.nextRun).map(report => <div key={report.id} className="flex items-center justify-between p-3 border rounded-lg">
                        <div className="flex items-center gap-3">
                          <Calendar className="w-4 h-4 text-blue-600" />
                          <div>
                            <div className="font-medium">{report.name}</div>
                            <div className="text-sm text-gray-500">
                              {report.schedule.frequency}{t("admin.reports.at")}{report.schedule.time}
                            </div>
                          </div>
                        </div>
                        <div className="text-right">
                          <div className="font-medium">
                            {report.nextRun ? new Date(report.nextRun).toLocaleDateString() : ""}
                          </div>
                          <div className="text-sm text-gray-500">
                            {report.nextRun ? new Date(report.nextRun).toLocaleTimeString() : ""}
                          </div>
                        </div>
                      </div>)}
                  </div>
                </CardContent>
              </Card>

              <Card>
                <CardHeader>
                  <CardTitle>{t("admin.reports.schedule_settings")}</CardTitle>
                  <CardDescription>{t("admin.reports.global_scheduling_preferences")}</CardDescription>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="font-medium">{t("admin.reports.default_time_zone")}</div>
                      <div className="text-sm text-gray-500">{t("admin.reports.time_zone_for_scheduled")}</div>
                    </div>
                    <Select defaultValue="UTC">
                      <SelectTrigger className="w-[150px]">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="UTC">{t("admin.reports.utc")}</SelectItem>
                        <SelectItem value="EST">{t("admin.reports.est")}</SelectItem>
                        <SelectItem value="PST">{t("admin.reports.pst")}</SelectItem>
                        <SelectItem value="CET">{t("admin.reports.cet")}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="font-medium">{t("admin.reports.retry_failed_reports")}</div>
                      <div className="text-sm text-gray-500">{t("admin.reports.automatically_retry_failed_reports")}</div>
                    </div>
                    <Switch defaultChecked />
                  </div>
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="font-medium">{t("admin.reports.max_concurrent_runs")}</div>
                      <div className="text-sm text-gray-500">{t("admin.reports.maximum_simultaneous_report_runs")}</div>
                    </div>
                    <Select defaultValue="5">
                      <SelectTrigger className="w-[100px]">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="1">1</SelectItem>
                        <SelectItem value="3">3</SelectItem>
                        <SelectItem value="5">5</SelectItem>
                        <SelectItem value="10">10</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="font-medium">{t("admin.reports.retention_period")}</div>
                      <div className="text-sm text-gray-500">{t("admin.reports.how_long_to_keep")}</div>
                    </div>
                    <Select defaultValue="90">
                      <SelectTrigger className="w-[150px]">
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="30">{t("admin.reports.30_days")}</SelectItem>
                        <SelectItem value="90">{t("admin.reports.90_days")}</SelectItem>
                        <SelectItem value="180">{t("admin.reports.180_days")}</SelectItem>
                        <SelectItem value="365">{t("admin.reports.1_year")}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </CardContent>
              </Card>
            </div>
          </TabsContent>
        </Tabs>
      </div>

      {/* Create Report Dialog */}
      <Dialog open={reportDialogOpen} onOpenChange={setReportDialogOpen}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle>{t("admin.reports.create_custom_report")}</DialogTitle>
            <DialogDescription>{t("admin.reports.design_a_new_custom")}</DialogDescription>
          </DialogHeader>
          <div className="grid grid-cols-2 gap-4 py-4">
            <div className="space-y-2">
              <Label>{t("admin.reports.report_name")}</Label>
              <Input placeholder={t("admin.reports.enter_report_name")} />
            </div>
            <div className="space-y-2">
              <Label>{t("admin.reports.category")}</Label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("admin.reports.select_category")} />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Performance">{t("admin.reports.performance")}</SelectItem>
                  <SelectItem value="Sales">{t("admin.reports.sales")}</SelectItem>
                  <SelectItem value="Properties">{t("admin.reports.properties")}</SelectItem>
                  <SelectItem value="Financial">{t("admin.reports.financial")}</SelectItem>
                  <SelectItem value="Marketing">{t("admin.reports.marketing")}</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>{t("admin.reports.type")}</Label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("admin.reports.select_type")} />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="TABULAR">{t("admin.reports.tabular")}</SelectItem>
                  <SelectItem value="CHART">{t("admin.reports.chart")}</SelectItem>
                  <SelectItem value="DASHBOARD">{t("admin.reports.dashboard")}</SelectItem>
                  <SelectItem value="SUMMARY">{t("admin.reports.summary")}</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>{t("admin.reports.format")}</Label>
              <Select>
                <SelectTrigger>
                  <SelectValue placeholder={t("admin.reports.select_format")} />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="PDF">{t("admin.reports.pdf")}</SelectItem>
                  <SelectItem value="EXCEL">{t("admin.reports.excel")}</SelectItem>
                  <SelectItem value="CSV">{t("admin.reports.csv")}</SelectItem>
                  <SelectItem value="JSON">{t("admin.reports.json")}</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2 col-span-2">
              <Label>{t("admin.reports.description")}</Label>
              <Textarea placeholder={t("admin.reports.describe_the_report_purpose")} />
            </div>
            <div className="space-y-2 col-span-2">
              <Label>{t("admin.reports.sql_query")}</Label>
              <Textarea placeholder={t("admin.reports.enter_your_sql_query")} rows={4} className="font-mono" />
            </div>
            <div className="flex items-center space-x-2 col-span-2">
              <Switch />
              <Label>{t("admin.reports.enable_scheduling")}</Label>
            </div>
            <div className="flex items-center space-x-2 col-span-2">
              <Switch />
              <Label>{t("admin.reports.activate_report_immediately")}</Label>
            </div>
          </div>
          <DialogFooter>
            <Button variant="outline" onClick={() => setReportDialogOpen(false)}>{t("admin.reports.cancel")}</Button>
            <Button>{t("admin.reports.create_report")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}