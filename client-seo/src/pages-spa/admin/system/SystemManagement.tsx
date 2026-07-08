"use client";

import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { Progress } from "@/components/ui/progress";
import { Link, TrendingUp, Eye, RefreshCw, Plus, Search, Bot, Database, Wifi, Activity, Edit, Pause, Play, Settings, MoreHorizontal, Trash2 } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";

interface AutomationRule {
  id: string; name: string; description: string;
  trigger: { type: 'SCHEDULE' | 'EVENT' | 'WEBHOOK' | 'API_CALL'; config: any };
  actions: { type: 'EMAIL' | 'WEBHOOK' | 'API_CALL' | 'DATABASE_UPDATE' | 'FILE_PROCESS'; config: any }[];
  status: 'ACTIVE' | 'INACTIVE' | 'PAUSED' | 'ERROR';
  schedule?: string; lastRun?: string; nextRun?: string;
  executionCount: number; successRate: number; averageRuntime: number;
  createdBy: string; createdAt: string;
}
interface AutomationExecution {
  id: string; ruleId: string; ruleName: string;
  status: 'PENDING' | 'RUNNING' | 'COMPLETED' | 'FAILED' | 'CANCELLED';
  startedAt: string; completedAt?: string; duration?: number;
  trigger: string; result?: any; error?: string; executionContext: any;
}
interface QueueMessage {
  id: string; queueName: string; messageType: string; payload: any;
  status: 'PENDING' | 'PROCESSING' | 'COMPLETED' | 'FAILED' | 'RETRY';
  priority: 'LOW' | 'NORMAL' | 'HIGH' | 'CRITICAL';
  attempts: number; maxAttempts: number;
  createdAt: string; scheduledAt?: string; processedAt?: string;
  error?: string; processingTime?: number;
}
interface QueueConfiguration {
  id: string; name: string; type: 'FIFO' | 'PRIORITY' | 'DELAYED' | 'DEAD_LETTER';
  maxSize: number; currentSize: number; processingRate: number;
  retryPolicy: { maxAttempts: number; backoffStrategy: 'LINEAR' | 'EXPONENTIAL' | 'FIXED'; delay: number };
  deadLetterQueue?: string; visibilityTimeout: number; messageRetention: number; isActive: boolean;
}
interface IntegrationLog {
  id: string; integrationName: string;
  integrationType: 'API' | 'WEBHOOK' | 'DATABASE' | 'FILE_TRANSFER' | 'MESSAGE_QUEUE';
  direction: 'INBOUND' | 'OUTBOUND';
  status: 'SUCCESS' | 'ERROR' | 'TIMEOUT' | 'RETRY';
  timestamp: string; duration: number; requestSize: number; responseSize: number;
  endpoint?: string; method?: string; statusCode?: number; error?: string;
  payload?: any; correlationId?: string; userId?: string;
}
interface SystemMetrics {
  totalAutomations: number; activeAutomations: number; totalExecutions: number;
  successRate: number; averageExecutionTime: number; queueSize: number;
  processingRate: number; errorRate: number; integrationCount: number;
  activeIntegrations: number; systemHealth: 'HEALTHY' | 'WARNING' | 'CRITICAL';
  uptime: number; memoryUsage: number; cpuUsage: number;
}
export default function SystemManagement() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("ALL");
  const [priorityFilter, setPriorityFilter] = useState("ALL");
  const { data: systemData, isLoading } = useQuery({
    queryKey: ['system-management'],
    queryFn: async () => {
      const [rulesRes, executionsRes, messagesRes, configsRes, logsRes, metricsRes] = await Promise.all([
        apiClient.get('/automation-rule') as Promise<{ data: AutomationRule[] }>,
        apiClient.get('/automation-execution') as Promise<{ data: AutomationExecution[] }>,
        apiClient.get('/queue-message') as Promise<{ data: QueueMessage[] }>,
        apiClient.get('/queue-configuration') as Promise<{ data: QueueConfiguration[] }>,
        apiClient.get('/integration-log') as Promise<{ data: IntegrationLog[] }>,
        apiClient.get('/system-metrics') as Promise<{ data: SystemMetrics }>
      ]);
      return {
        automationRules: rulesRes.data,
        executions: executionsRes.data,
        queueMessages: messagesRes.data,
        queueConfigs: configsRes.data,
        integrationLogs: logsRes.data,
        systemMetrics: metricsRes.data
      };
    }
  });
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'ACTIVE': case 'COMPLETED': case 'SUCCESS': return 'bg-green-500';
      case 'INACTIVE': case 'PENDING': return 'bg-yellow-500';
      case 'PAUSED': case 'PROCESSING': return 'bg-slate-500';
      case 'ERROR': case 'FAILED': case 'CRITICAL': return 'bg-red-500';
      case 'TIMEOUT': case 'RETRY': return 'bg-orange-500';
      case 'CANCELLED': return 'bg-white/10';
      default: return 'bg-white/10';
    }
  };
  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'CRITICAL': return 'bg-red-500';
      case 'HIGH': return 'bg-orange-500';
      case 'NORMAL': return 'bg-slate-500';
      case 'LOW': return 'bg-white/10';
      default: return 'bg-white/10';
    }
  };
  const automationRules = systemData?.automationRules || [];
  const executions = systemData?.executions || [];
  const queueMessages = systemData?.queueMessages || [];
  const queueConfigs = systemData?.queueConfigs || [];
  const integrationLogs = systemData?.integrationLogs || [];
  const systemMetrics = systemData?.systemMetrics || null;
  const filteredRules = automationRules.filter(rule => {
    const matchesSearch = rule.name.toLowerCase().includes(searchTerm.toLowerCase()) || rule.description.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || rule.status === statusFilter;
    return matchesSearch && matchesStatus;
  });
  const filteredMessages = queueMessages.filter(message => {
    const matchesSearch = message.queueName.toLowerCase().includes(searchTerm.toLowerCase()) || message.messageType.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || message.status === statusFilter;
    const matchesPriority = priorityFilter === "ALL" || message.priority === priorityFilter;
    return matchesSearch && matchesStatus && matchesPriority;
  });
  const filteredLogs = integrationLogs.filter(log => {
    const matchesSearch = log.integrationName.toLowerCase().includes(searchTerm.toLowerCase()) || log.endpoint && log.endpoint.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === "ALL" || log.status === statusFilter;
    return matchesSearch && matchesStatus;
  });
  if (isLoading) {
    return <div className="min-h-screen bg-background p-6">
        <div className="bg-white/5 p-6 rounded-2xl border border-slate-200 dark:border-white/10">
          <h1 className="text-xl font-bold text-slate-900 dark:text-white">{t("admin_system_system_management")}</h1>
        </div>
        <div className="flex items-center justify-center h-64 mt-6">
          <Settings className="h-8 w-8 animate-spin text-slate-900 dark:text-white" />
        </div>
      </div>;
  }
  return <div className="min-h-screen bg-background">
      <div className="p-6 space-y-6">
        <div className="bg-white/5 p-6 rounded-2xl border border-slate-200 dark:border-white/10">
          <h1 className="text-xl font-bold text-slate-900 dark:text-white">{t("admin_system_system_management")}</h1>
        </div>

        {systemMetrics && <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
            <Card className="bg-white/5 border-slate-200 dark:border-white/10">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">{t("admin_system_active_automations")}</CardTitle>
                <Bot className="h-4 w-4 text-slate-500 dark:text-slate-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-900 dark:text-white">{systemMetrics.activeAutomations}</div>
                <p className="text-xs text-slate-500 dark:text-slate-400">{t("admin_system_of")}{systemMetrics.totalAutomations}{t("admin_system_total")}</p>
              </CardContent>
            </Card>

            <Card className="bg-white/5 border-slate-200 dark:border-white/10">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">{t("admin_system_success_rate")}</CardTitle>
                <TrendingUp className="h-4 w-4 text-slate-500 dark:text-slate-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-green-400">{systemMetrics.successRate.toFixed(1)}%</div>
                <p className="text-xs text-slate-500 dark:text-slate-400">{t("admin_system_last_24_hours")}</p>
              </CardContent>
            </Card>

            <Card className="bg-white/5 border-slate-200 dark:border-white/10">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">{t("admin_system_queue_size")}</CardTitle>
                <Database className="h-4 w-4 text-slate-500 dark:text-slate-400" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-slate-900 dark:text-white">{systemMetrics.queueSize.toLocaleString()}</div>
                <p className="text-xs text-slate-500 dark:text-slate-400">{systemMetrics.processingRate}/min processing</p>
              </CardContent>
            </Card>

            <Card className="bg-white/5 border-slate-200 dark:border-white/10">
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium text-slate-500 dark:text-slate-400">{t("admin_system_system_health")}</CardTitle>
                <Activity className="h-4 w-4 text-slate-500 dark:text-slate-400" />
              </CardHeader>
              <CardContent>
                <div className={`text-2xl font-bold ${systemMetrics.systemHealth === 'HEALTHY' ? 'text-green-400' : systemMetrics.systemHealth === 'WARNING' ? 'text-yellow-400' : 'text-red-400'}`}>
                  {systemMetrics.systemHealth === 'HEALTHY' ? t("admin.system.health_healthy", "Sağlıklı") : systemMetrics.systemHealth === 'WARNING' ? t("admin.system.health_warning", "Uyarı") : t("admin.system.health_critical", "Kritik")}
                </div>
                <p className="text-xs text-slate-500 dark:text-slate-400">{Math.floor(systemMetrics.uptime / 3600)}{t("admin_system_h_uptime")}</p>
              </CardContent>
            </Card>
          </div>}

        <Tabs defaultValue="automation" className="space-y-4">
          <TabsList className="bg-white/5 border border-slate-200 dark:border-white/10">
            <TabsTrigger value="automation" className="text-slate-500 dark:text-slate-400 data-[state=active]:bg-white/10 data-[state=active]:text-white">{t("admin_system_automation_rules")}</TabsTrigger>
            <TabsTrigger value="executions" className="text-slate-500 dark:text-slate-400 data-[state=active]:bg-white/10 data-[state=active]:text-white">{t("admin_system_executions")}</TabsTrigger>
            <TabsTrigger value="queue" className="text-slate-500 dark:text-slate-400 data-[state=active]:bg-white/10 data-[state=active]:text-white">{t("admin_system_message_queue")}</TabsTrigger>
            <TabsTrigger value="integrations" className="text-slate-500 dark:text-slate-400 data-[state=active]:bg-white/10 data-[state=active]:text-white">{t("admin_system_integration_logs")}</TabsTrigger>
            <TabsTrigger value="metrics" className="text-slate-500 dark:text-slate-400 data-[state=active]:bg-white/10 data-[state=active]:text-white">{t("admin_system_system_metrics")}</TabsTrigger>
          </TabsList>

          <TabsContent value="automation" className="space-y-4">
            <div className="flex justify-between items-center">
              <div className="flex gap-2">
                <div className="relative">
                  <Search className="absolute left-2 top-2.5 h-4 w-4 text-slate-500 dark:text-slate-400" />
                  <Input placeholder={t("admin_system_search_rules")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64 bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white placeholder:text-slate-500" />
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-32 bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                    <SelectItem value="ALL">{t("admin_system_all_status")}</SelectItem>
                    <SelectItem value="ACTIVE">{t("admin_system_active")}</SelectItem>
                    <SelectItem value="INACTIVE">{t("admin_system_inactive")}</SelectItem>
                    <SelectItem value="PAUSED">{t("admin_system_paused")}</SelectItem>
                    <SelectItem value="ERROR">{t("admin_system_error")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <Card className="bg-white/5 border-slate-200 dark:border-white/10">
              <CardHeader>
                <CardTitle className="text-slate-900 dark:text-white">{t("admin_system_automation_rules")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow className="border-slate-200 dark:border-white/10">
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_name")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_trigger")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_status")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_success_rate")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_executions")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_avg_runtime")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_last_run")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_next_run")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredRules.map(rule => <TableRow key={rule.id} className="border-slate-200 dark:border-white/10">
                        <TableCell className="text-slate-900 dark:text-white">
                          <div>
                            <div className="font-medium text-slate-900 dark:text-white">{rule.name}</div>
                            <div className="text-sm text-slate-500 dark:text-slate-400 truncate max-w-xs">{rule.description}</div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant="outline" className="text-slate-500 dark:text-slate-400 border-slate-200 dark:border-white/10">{rule.trigger.type}</Badge>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2 text-slate-900 dark:text-white">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(rule.status)}`} />
                            <span className="capitalize">{t(`admin.system.status_${rule.status.toLowerCase()}`, rule.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <Progress value={rule.successRate} className="w-16 bg-white/10 [&>div]:bg-emerald-500" />
                            <span className="text-sm text-slate-900 dark:text-white">{rule.successRate.toFixed(1)}%</span>
                          </div>
                        </TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{rule.executionCount.toLocaleString()}</TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{rule.averageRuntime}{t("admin_system_ms")}</TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{rule.lastRun ? new Date(rule.lastRun).toLocaleString() : 'Never'}</TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{rule.nextRun ? new Date(rule.nextRun).toLocaleString() : 'Not scheduled'}</TableCell>
                        <TableCell>
                          <div className="flex gap-1">
                            <Button variant="ghost" size="sm" className="text-slate-500 dark:text-slate-400">
                              <Eye className="h-4 w-4" />
                            </Button>
                            <Button variant="ghost" size="sm" className="text-slate-500 dark:text-slate-400">
                              <Edit className="h-4 w-4" />
                            </Button>
                            {rule.status === 'ACTIVE' ? <Button variant="ghost" size="sm" className="text-slate-500 dark:text-slate-400">
                                <Pause className="h-4 w-4" />
                              </Button> : <Button variant="ghost" size="sm" className="text-slate-500 dark:text-slate-400">
                                <Play className="h-4 w-4" />
                              </Button>}
                          </div>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="executions" className="space-y-4">
            <Card className="bg-white/5 border-slate-200 dark:border-white/10">
              <CardHeader>
                <CardTitle className="text-slate-900 dark:text-white">{t("admin_system_recent_executions")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow className="border-slate-200 dark:border-white/10">
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_rule")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_status")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_trigger")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_started")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_duration")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_result")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {executions.slice(0, 20).map(execution => <TableRow key={execution.id} className="border-slate-200 dark:border-white/10">
                        <TableCell className="font-medium text-slate-900 dark:text-white">{execution.ruleName}</TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2 text-slate-900 dark:text-white">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(execution.status)}`} />
                            <span className="capitalize">{t(`admin.system.status_${execution.status.toLowerCase()}`, execution.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant="outline" className="text-slate-500 dark:text-slate-400 border-slate-200 dark:border-white/10">{execution.trigger}</Badge>
                        </TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{new Date(execution.startedAt).toLocaleString()}</TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{execution.duration ? `${execution.duration}ms` : '-'}</TableCell>
                        <TableCell>
                          {execution.error ? <span className="text-red-400 text-sm truncate max-w-xs">{execution.error}</span> : <span className="text-green-400 text-sm">{execution.status === 'COMPLETED' ? t("admin.system.success", "Başarılı") : t(`admin.system.status_${execution.status.toLowerCase()}`, execution.status)}</span>}
                        </TableCell>
                        <TableCell>
                          <Button variant="ghost" size="sm" className="text-slate-500 dark:text-slate-400">
                            <Eye className="h-4 w-4" />
                          </Button>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="queue" className="space-y-4">
            <div className="flex justify-between items-center">
              <div className="flex gap-2">
                <div className="relative">
                  <Search className="absolute left-2 top-2.5 h-4 w-4 text-slate-500 dark:text-slate-400" />
                  <Input placeholder={t("admin_system_search_messages")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64 bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white placeholder:text-slate-500" />
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-32 bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                    <SelectItem value="ALL">{t("admin_system_all_status")}</SelectItem>
                    <SelectItem value="PENDING">{t("admin_system_pending")}</SelectItem>
                    <SelectItem value="PROCESSING">{t("admin_system_processing")}</SelectItem>
                    <SelectItem value="COMPLETED">{t("admin_system_completed")}</SelectItem>
                    <SelectItem value="FAILED">{t("admin_system_failed")}</SelectItem>
                    <SelectItem value="RETRY">{t("admin_system_retry")}</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={priorityFilter} onValueChange={setPriorityFilter}>
                  <SelectTrigger className="w-32 bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                    <SelectItem value="ALL">{t("admin_system_all_priority")}</SelectItem>
                    <SelectItem value="CRITICAL">{t("admin_system_critical")}</SelectItem>
                    <SelectItem value="HIGH">{t("admin_system_high")}</SelectItem>
                    <SelectItem value="NORMAL">{t("admin_system_normal")}</SelectItem>
                    <SelectItem value="LOW">{t("admin_system_low")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
              {queueConfigs.map(config => <Card key={config.id} className="bg-white/5 border-slate-200 dark:border-white/10">
                  <CardContent className="p-4">
                    <div className="flex items-center justify-between mb-2">
                      <div className="font-medium text-slate-900 dark:text-white">{config.name}</div>
                      <Switch checked={config.isActive} className="data-[state=checked]:bg-emerald-600" />
                    </div>
                    <div className="space-y-1 text-sm">
                      <div className="flex justify-between">
                        <span className="text-slate-500 dark:text-slate-400">{t("admin_system_type")}</span>
                        <Badge variant="outline" className="text-slate-500 dark:text-slate-400 border-slate-200 dark:border-white/10">{config.type}</Badge>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-slate-500 dark:text-slate-400">{t("admin_system_size")}</span>
                        <span className="text-slate-900 dark:text-white">{config.currentSize}/{config.maxSize}</span>
                      </div>
                      <div className="flex justify-between">
                        <span className="text-slate-500 dark:text-slate-400">{t("admin_system_rate")}</span>
                        <span className="text-slate-900 dark:text-white">{config.processingRate}/min</span>
                      </div>
                    </div>
                  </CardContent>
                </Card>)}
            </div>

            <Card className="bg-white/5 border-slate-200 dark:border-white/10">
              <CardHeader>
                <CardTitle className="text-slate-900 dark:text-white">{t("admin_system_queue_messages")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow className="border-slate-200 dark:border-white/10">
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_queue")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_type")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_priority")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_status")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_attempts")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_created")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_scheduled")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_processing_time")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredMessages.slice(0, 20).map(message => <TableRow key={message.id} className="border-slate-200 dark:border-white/10">
                        <TableCell className="font-medium text-slate-900 dark:text-white">{message.queueName}</TableCell>
                        <TableCell>
                          <Badge variant="outline" className="text-slate-500 dark:text-slate-400 border-slate-200 dark:border-white/10">{message.messageType}</Badge>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2 text-slate-900 dark:text-white">
                            <div className={`w-2 h-2 rounded-full ${getPriorityColor(message.priority)}`} />
                            <span className="capitalize">{t(`admin.system.priority_${message.priority.toLowerCase()}`, message.priority)}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2 text-slate-900 dark:text-white">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(message.status)}`} />
                            <span className="capitalize">{t(`admin.system.status_${message.status.toLowerCase()}`, message.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">
                          <div className="text-sm">{message.attempts}/{message.maxAttempts}</div>
                        </TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{new Date(message.createdAt).toLocaleString()}</TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{message.scheduledAt ? new Date(message.scheduledAt).toLocaleString() : 'Immediate'}</TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{message.processingTime ? `${message.processingTime}ms` : '-'}</TableCell>
                        <TableCell>
                          <div className="flex gap-1">
                            <Button variant="ghost" size="sm" className="text-slate-500 dark:text-slate-400">
                              <Eye className="h-4 w-4" />
                            </Button>
                            {message.status === 'FAILED' && <Button variant="ghost" size="sm" className="text-slate-500 dark:text-slate-400">
                                <RefreshCw className="h-4 w-4" />
                              </Button>}
                          </div>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="integrations" className="space-y-4">
            <div className="flex gap-2">
              <div className="relative">
                <Search className="absolute left-2 top-2.5 h-4 w-4 text-slate-500 dark:text-slate-400" />
                <Input placeholder={t("admin_system_search_logs")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64 bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white placeholder:text-slate-500" />
              </div>
              <Select value={statusFilter} onValueChange={setStatusFilter}>
                <SelectTrigger className="w-32 bg-white/5 border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent className="bg-[#14151a] border-slate-200 dark:border-white/10 text-slate-900 dark:text-white">
                  <SelectItem value="ALL">{t("admin_system_all_status")}</SelectItem>
                  <SelectItem value="SUCCESS">{t("admin_system_success")}</SelectItem>
                  <SelectItem value="ERROR">{t("admin_system_error")}</SelectItem>
                  <SelectItem value="TIMEOUT">{t("admin_system_timeout")}</SelectItem>
                  <SelectItem value="RETRY">{t("admin_system_retry")}</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <Card className="bg-white/5 border-slate-200 dark:border-white/10">
              <CardHeader>
                <CardTitle className="text-slate-900 dark:text-white">{t("admin_system_integration_logs")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow className="border-slate-200 dark:border-white/10">
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_integration")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_type")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_direction")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_status")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_endpoint")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_duration")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_timestamp")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_size")}</TableHead>
                      <TableHead className="text-slate-500 dark:text-slate-400">{t("admin_system_actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredLogs.slice(0, 20).map(log => <TableRow key={log.id} className="border-slate-200 dark:border-white/10">
                        <TableCell className="font-medium text-slate-900 dark:text-white">{log.integrationName}</TableCell>
                        <TableCell>
                          <Badge variant="outline" className="text-slate-500 dark:text-slate-400 border-slate-200 dark:border-white/10">{log.integrationType}</Badge>
                        </TableCell>
                        <TableCell>
                          <div className={`flex items-center gap-1 ${log.direction === 'INBOUND' ? 'text-slate-500 dark:text-slate-400' : 'text-green-400'}`}>
                            {log.direction === 'INBOUND' ? <Wifi className="h-3 w-3" /> : <Link className="h-3 w-3" />}
                            <span className="capitalize">{t(`admin.system.direction_${log.direction.toLowerCase()}`, log.direction)}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2 text-slate-900 dark:text-white">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(log.status)}`} />
                            <span className="capitalize">{t(`admin.system.status_${log.status.toLowerCase()}`, log.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell className="font-mono text-sm max-w-xs truncate text-slate-500 dark:text-slate-400">{log.endpoint || '-'}</TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{log.duration}{t("admin_system_ms")}</TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">{new Date(log.timestamp).toLocaleString()}</TableCell>
                        <TableCell className="text-slate-500 dark:text-slate-400">
                          <div className="text-sm">
                            <div>↓{log.requestSize}B</div>
                            <div>↑{log.responseSize}B</div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Button variant="ghost" size="sm" className="text-slate-500 dark:text-slate-400">
                            <Eye className="h-4 w-4" />
                          </Button>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>
              </CardContent>
            </Card>
          </TabsContent>

          <TabsContent value="metrics" className="space-y-4">
            {systemMetrics && <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <Card className="bg-white/5 border-slate-200 dark:border-white/10">
                  <CardHeader>
                    <CardTitle className="text-slate-900 dark:text-white">{t("admin_system_system_performance")}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-4">
                      <div>
                        <div className="flex justify-between text-sm">
                          <span className="text-slate-500 dark:text-slate-400">{t("admin_system_cpu_usage")}</span>
                          <span className="text-slate-900 dark:text-white">{systemMetrics.cpuUsage.toFixed(1)}%</span>
                        </div>
                        <Progress value={systemMetrics.cpuUsage} className="bg-white/10 [&>div]:bg-slate-500" />
                      </div>
                      <div>
                        <div className="flex justify-between text-sm">
                          <span className="text-slate-500 dark:text-slate-400">{t("admin_system_memory_usage")}</span>
                          <span className="text-slate-900 dark:text-white">{systemMetrics.memoryUsage.toFixed(1)}%</span>
                        </div>
                        <Progress value={systemMetrics.memoryUsage} className="bg-white/10 [&>div]:bg-slate-500" />
                      </div>
                      <div>
                        <div className="flex justify-between text-sm">
                          <span className="text-slate-500 dark:text-slate-400">{t("admin_system_error_rate")}</span>
                          <span className="text-slate-900 dark:text-white">{systemMetrics.errorRate.toFixed(2)}%</span>
                        </div>
                        <Progress value={systemMetrics.errorRate} className="bg-red-500/10 [&>div]:bg-red-500" />
                      </div>
                    </div>
                  </CardContent>
                </Card>

                <Card className="bg-white/5 border-slate-200 dark:border-white/10">
                  <CardHeader>
                    <CardTitle className="text-slate-900 dark:text-white">{t("admin_system_integration_status")}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-3">
                      <div className="flex justify-between items-center">
                        <span className="text-slate-500 dark:text-slate-400">{t("admin_system_total_integrations")}</span>
                        <Badge variant="outline" className="text-slate-500 dark:text-slate-400 border-slate-200 dark:border-white/10">{systemMetrics.integrationCount}</Badge>
                      </div>
                      <div className="flex justify-between items-center">
                        <span className="text-slate-500 dark:text-slate-400">{t("admin_system_active_integrations")}</span>
                        <Badge className="bg-green-600 text-slate-900 dark:text-white">{systemMetrics.activeIntegrations}</Badge>
                      </div>
                      <div className="flex justify-between items-center">
                        <span className="text-slate-500 dark:text-slate-400">{t("admin_system_average_execution_time")}</span>
                        <span className="text-slate-900 dark:text-white">{systemMetrics.averageExecutionTime}{t("admin_system_ms")}</span>
                      </div>
                      <div className="flex justify-between items-center">
                        <span className="text-slate-500 dark:text-slate-400">{t("admin_system_total_executions_24h")}</span>
                        <span className="text-slate-900 dark:text-white">{systemMetrics.totalExecutions.toLocaleString()}</span>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </div>}
          </TabsContent>
        </Tabs>
      </div>
    </div>;
}
