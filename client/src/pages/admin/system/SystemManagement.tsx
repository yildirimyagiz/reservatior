import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Switch } from "@/components/ui/switch";
import { Progress } from "@/components/ui/progress";
import { Link, TrendingUp, Eye, RefreshCw, Plus, Search, Bot, Database, Wifi, Activity, Edit, Pause, Play, Settings } from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api";
interface AutomationRule {
  id: string;
  name: string;
  description: string;
  trigger: {
    type: 'SCHEDULE' | 'EVENT' | 'WEBHOOK' | 'API_CALL';
    config: any;
  };
  actions: {
    type: 'EMAIL' | 'WEBHOOK' | 'API_CALL' | 'DATABASE_UPDATE' | 'FILE_PROCESS';
    config: any;
  }[];
  status: 'ACTIVE' | 'INACTIVE' | 'PAUSED' | 'ERROR';
  schedule?: string;
  lastRun?: string;
  nextRun?: string;
  executionCount: number;
  successRate: number;
  averageRuntime: number;
  createdBy: string;
  createdAt: string;
}
interface AutomationExecution {
  id: string;
  ruleId: string;
  ruleName: string;
  status: 'PENDING' | 'RUNNING' | 'COMPLETED' | 'FAILED' | 'CANCELLED';
  startedAt: string;
  completedAt?: string;
  duration?: number;
  trigger: string;
  result?: any;
  error?: string;
  executionContext: any;
}
interface QueueMessage {
  id: string;
  queueName: string;
  messageType: string;
  payload: any;
  status: 'PENDING' | 'PROCESSING' | 'COMPLETED' | 'FAILED' | 'RETRY';
  priority: 'LOW' | 'NORMAL' | 'HIGH' | 'CRITICAL';
  attempts: number;
  maxAttempts: number;
  createdAt: string;
  scheduledAt?: string;
  processedAt?: string;
  error?: string;
  processingTime?: number;
}
interface QueueConfiguration {
  id: string;
  name: string;
  type: 'FIFO' | 'PRIORITY' | 'DELAYED' | 'DEAD_LETTER';
  maxSize: number;
  currentSize: number;
  processingRate: number;
  retryPolicy: {
    maxAttempts: number;
    backoffStrategy: 'LINEAR' | 'EXPONENTIAL' | 'FIXED';
    delay: number;
  };
  deadLetterQueue?: string;
  visibilityTimeout: number;
  messageRetention: number;
  isActive: boolean;
}
interface IntegrationLog {
  id: string;
  integrationName: string;
  integrationType: 'API' | 'WEBHOOK' | 'DATABASE' | 'FILE_TRANSFER' | 'MESSAGE_QUEUE';
  direction: 'INBOUND' | 'OUTBOUND';
  status: 'SUCCESS' | 'ERROR' | 'TIMEOUT' | 'RETRY';
  timestamp: string;
  duration: number;
  requestSize: number;
  responseSize: number;
  endpoint?: string;
  method?: string;
  statusCode?: number;
  error?: string;
  payload?: any;
  correlationId?: string;
  userId?: string;
}
interface SystemMetrics {
  totalAutomations: number;
  activeAutomations: number;
  totalExecutions: number;
  successRate: number;
  averageExecutionTime: number;
  queueSize: number;
  processingRate: number;
  errorRate: number;
  integrationCount: number;
  activeIntegrations: number;
  systemHealth: 'HEALTHY' | 'WARNING' | 'CRITICAL';
  uptime: number;
  memoryUsage: number;
  cpuUsage: number;
}
export default function SystemManagement() {
  const {
    t
  } = useTranslation();
  const [automationRules, setAutomationRules] = useState<AutomationRule[]>([]);
  const [executions, setExecutions] = useState<AutomationExecution[]>([]);
  const [queueMessages, setQueueMessages] = useState<QueueMessage[]>([]);
  const [queueConfigs, setQueueConfigs] = useState<QueueConfiguration[]>([]);
  const [integrationLogs, setIntegrationLogs] = useState<IntegrationLog[]>([]);
  const [systemMetrics, setSystemMetrics] = useState<SystemMetrics | null>(null);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState("ALL");
  const [priorityFilter, setPriorityFilter] = useState("ALL");
  const {
    toast
  } = useToast();
  useEffect(() => {
    fetchSystemData();
  }, []);
  const fetchSystemData = async () => {
    try {
      const [rulesRes, executionsRes, messagesRes, configsRes, logsRes, metricsRes] = await Promise.all([apiClient.get('/automation-rule') as Promise<{
        data: AutomationRule[];
      }>, apiClient.get('/automation-execution') as Promise<{
        data: AutomationExecution[];
      }>, apiClient.get('/queue-message') as Promise<{
        data: QueueMessage[];
      }>, apiClient.get('/queue-configuration') as Promise<{
        data: QueueConfiguration[];
      }>, apiClient.get('/integration-log') as Promise<{
        data: IntegrationLog[];
      }>, apiClient.get('/system-metrics') as Promise<{
        data: SystemMetrics;
      }>]);
      setAutomationRules(rulesRes.data);
      setExecutions(executionsRes.data);
      setQueueMessages(messagesRes.data);
      setQueueConfigs(configsRes.data);
      setIntegrationLogs(logsRes.data);
      setSystemMetrics(metricsRes.data);
    } catch (error) {
      toast({
        title: t("admin.system.error"),
        description: t("admin.system.failed_to_fetch_system"),
        variant: "destructive"
      });
    } finally {
      setLoading(false);
    }
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'ACTIVE':
      case 'COMPLETED':
      case 'SUCCESS':
        return 'bg-green-500';
      case 'INACTIVE':
      case 'PENDING':
        return 'bg-yellow-500';
      case 'PAUSED':
      case 'PROCESSING':
        return 'bg-blue-500';
      case 'ERROR':
      case 'FAILED':
      case 'CRITICAL':
        return 'bg-red-500';
      case 'TIMEOUT':
      case 'RETRY':
        return 'bg-orange-500';
      case 'CANCELLED':
        return 'bg-gray-500';
      default:
        return 'bg-gray-500';
    }
  };
  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'CRITICAL':
        return 'bg-red-500';
      case 'HIGH':
        return 'bg-orange-500';
      case 'NORMAL':
        return 'bg-blue-500';
      case 'LOW':
        return 'bg-gray-500';
      default:
        return 'bg-gray-500';
    }
  };
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
  if (loading) {
    return <PageShell title={t("admin.system.system_management")}>
        <div className="flex items-center justify-center h-64">
          <Settings className="h-8 w-8 animate-spin" />
        </div>
      </PageShell>;
  }
  return <PageShell title={t("admin.system.system_management")}>
      <div className="space-y-6">
        {/* System Overview Cards */}
        {systemMetrics && <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
            <Card>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">{t("admin.system.active_automations")}</CardTitle>
                <Bot className="h-4 w-4 text-muted-foreground" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{systemMetrics.activeAutomations}</div>
                <p className="text-xs text-muted-foreground">{t("admin.system.of")}{systemMetrics.totalAutomations}{t("admin.system.total")}</p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">{t("admin.system.success_rate")}</CardTitle>
                <TrendingUp className="h-4 w-4 text-muted-foreground" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold text-green-600">{systemMetrics.successRate.toFixed(1)}%</div>
                <p className="text-xs text-muted-foreground">{t("admin.system.last_24_hours")}</p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">{t("admin.system.queue_size")}</CardTitle>
                <Database className="h-4 w-4 text-muted-foreground" />
              </CardHeader>
              <CardContent>
                <div className="text-2xl font-bold">{systemMetrics.queueSize.toLocaleString()}</div>
                <p className="text-xs text-muted-foreground">
                  {systemMetrics.processingRate}/min processing
                </p>
              </CardContent>
            </Card>

            <Card>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">{t("admin.system.system_health")}</CardTitle>
                <Activity className="h-4 w-4 text-muted-foreground" />
              </CardHeader>
              <CardContent>
                <div className={`text-2xl font-bold ${systemMetrics.systemHealth === 'HEALTHY' ? 'text-green-600' : systemMetrics.systemHealth === 'WARNING' ? 'text-yellow-600' : 'text-red-600'}`}>
                  {systemMetrics.systemHealth === 'HEALTHY' ? t("admin.system.health_healthy", "Sağlıklı") : systemMetrics.systemHealth === 'WARNING' ? t("admin.system.health_warning", "Uyarı") : t("admin.system.health_critical", "Kritik")}
                </div>
                <p className="text-xs text-muted-foreground">
                  {Math.floor(systemMetrics.uptime / 3600)}{t("admin.system.h_uptime")}</p>
              </CardContent>
            </Card>
          </div>}

        <Tabs defaultValue="automation" className="space-y-4">
          <TabsList>
            <TabsTrigger value="automation">{t("admin.system.automation_rules")}</TabsTrigger>
            <TabsTrigger value="executions">{t("admin.system.executions")}</TabsTrigger>
            <TabsTrigger value="queue">{t("admin.system.message_queue")}</TabsTrigger>
            <TabsTrigger value="integrations">{t("admin.system.integration_logs")}</TabsTrigger>
            <TabsTrigger value="metrics">{t("admin.system.system_metrics")}</TabsTrigger>
          </TabsList>

          <TabsContent value="automation" className="space-y-4">
            <div className="flex justify-between items-center">
              <div className="flex gap-2">
                <div className="relative">
                  <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                  <Input placeholder={t("admin.system.search_rules")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-32">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("admin.system.all_status")}</SelectItem>
                    <SelectItem value="ACTIVE">{t("admin.system.active")}</SelectItem>
                    <SelectItem value="INACTIVE">{t("admin.system.inactive")}</SelectItem>
                    <SelectItem value="PAUSED">{t("admin.system.paused")}</SelectItem>
                    <SelectItem value="ERROR">{t("admin.system.error")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <Button onClick={() => {}}>
                <Plus className="h-4 w-4 mr-2" />{t("admin.system.create_rule")}</Button>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>{t("admin.system.automation_rules")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.system.name")}</TableHead>
                      <TableHead>{t("admin.system.trigger")}</TableHead>
                      <TableHead>{t("admin.system.status")}</TableHead>
                      <TableHead>{t("admin.system.success_rate")}</TableHead>
                      <TableHead>{t("admin.system.executions")}</TableHead>
                      <TableHead>{t("admin.system.avg_runtime")}</TableHead>
                      <TableHead>{t("admin.system.last_run")}</TableHead>
                      <TableHead>{t("admin.system.next_run")}</TableHead>
                      <TableHead>{t("admin.system.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredRules.map(rule => <TableRow key={rule.id}>
                        <TableCell>
                          <div>
                            <div className="font-medium">{rule.name}</div>
                            <div className="text-sm text-muted-foreground truncate max-w-xs">
                              {rule.description}
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant="outline">{rule.trigger.type}</Badge>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(rule.status)}`} />
                            <span className="capitalize">{t(`admin.system.status_${rule.status.toLowerCase()}`, rule.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <Progress value={rule.successRate} className="w-16" />
                            <span className="text-sm">{rule.successRate.toFixed(1)}%</span>
                          </div>
                        </TableCell>
                        <TableCell>{rule.executionCount.toLocaleString()}</TableCell>
                        <TableCell>{rule.averageRuntime}{t("admin.system.ms")}</TableCell>
                        <TableCell>
                          {rule.lastRun ? new Date(rule.lastRun).toLocaleString() : 'Never'}
                        </TableCell>
                        <TableCell>
                          {rule.nextRun ? new Date(rule.nextRun).toLocaleString() : 'Not scheduled'}
                        </TableCell>
                        <TableCell>
                          <div className="flex gap-1">
                            <Button variant="ghost" size="sm">
                              <Eye className="h-4 w-4" />
                            </Button>
                            <Button variant="ghost" size="sm">
                              <Edit className="h-4 w-4" />
                            </Button>
                            {rule.status === 'ACTIVE' ? <Button variant="ghost" size="sm">
                                <Pause className="h-4 w-4" />
                              </Button> : <Button variant="ghost" size="sm">
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
            <Card>
              <CardHeader>
                <CardTitle>{t("admin.system.recent_executions")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.system.rule")}</TableHead>
                      <TableHead>{t("admin.system.status")}</TableHead>
                      <TableHead>{t("admin.system.trigger")}</TableHead>
                      <TableHead>{t("admin.system.started")}</TableHead>
                      <TableHead>{t("admin.system.duration")}</TableHead>
                      <TableHead>{t("admin.system.result")}</TableHead>
                      <TableHead>{t("admin.system.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {executions.slice(0, 20).map(execution => <TableRow key={execution.id}>
                        <TableCell className="font-medium">{execution.ruleName}</TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(execution.status)}`} />
                            <span className="capitalize">{t(`admin.system.status_${execution.status.toLowerCase()}`, execution.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant="outline">{execution.trigger}</Badge>
                        </TableCell>
                        <TableCell>{new Date(execution.startedAt).toLocaleString()}</TableCell>
                        <TableCell>
                          {execution.duration ? `${execution.duration}ms` : '-'}
                        </TableCell>
                        <TableCell>
                          {execution.error ? <span className="text-red-600 text-sm truncate max-w-xs">
                              {execution.error}
                            </span> : <span className="text-green-600 text-sm">
                              {execution.status === 'COMPLETED' ? t("admin.system.success", "Başarılı") : t(`admin.system.status_${execution.status.toLowerCase()}`, execution.status)}
                            </span>}
                        </TableCell>
                        <TableCell>
                          <Button variant="ghost" size="sm">
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
                  <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                  <Input placeholder={t("admin.system.search_messages")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
                </div>
                <Select value={statusFilter} onValueChange={setStatusFilter}>
                  <SelectTrigger className="w-32">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("admin.system.all_status")}</SelectItem>
                    <SelectItem value="PENDING">{t("admin.system.pending")}</SelectItem>
                    <SelectItem value="PROCESSING">{t("admin.system.processing")}</SelectItem>
                    <SelectItem value="COMPLETED">{t("admin.system.completed")}</SelectItem>
                    <SelectItem value="FAILED">{t("admin.system.failed")}</SelectItem>
                    <SelectItem value="RETRY">{t("admin.system.retry")}</SelectItem>
                  </SelectContent>
                </Select>
                <Select value={priorityFilter} onValueChange={setPriorityFilter}>
                  <SelectTrigger className="w-32">
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="ALL">{t("admin.system.all_priority")}</SelectItem>
                    <SelectItem value="CRITICAL">{t("admin.system.critical")}</SelectItem>
                    <SelectItem value="HIGH">{t("admin.system.high")}</SelectItem>
                    <SelectItem value="NORMAL">{t("admin.system.normal")}</SelectItem>
                    <SelectItem value="LOW">{t("admin.system.low")}</SelectItem>
                  </SelectContent>
                </Select>
              </div>
              <Button onClick={() => {}}>
                <Plus className="h-4 w-4 mr-2" />{t("admin.system.configure_queue")}</Button>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
              {queueConfigs.map(config => <Card key={config.id}>
                  <CardContent className="p-4">
                    <div className="flex items-center justify-between mb-2">
                      <div className="font-medium">{config.name}</div>
                      <Switch checked={config.isActive} />
                    </div>
                    <div className="space-y-1 text-sm">
                      <div className="flex justify-between">
                        <span>{t("admin.system.type")}</span>
                        <Badge variant="outline">{config.type}</Badge>
                      </div>
                      <div className="flex justify-between">
                        <span>{t("admin.system.size")}</span>
                        <span>{config.currentSize}/{config.maxSize}</span>
                      </div>
                      <div className="flex justify-between">
                        <span>{t("admin.system.rate")}</span>
                        <span>{config.processingRate}/min</span>
                      </div>
                    </div>
                  </CardContent>
                </Card>)}
            </div>

            <Card>
              <CardHeader>
                <CardTitle>{t("admin.system.queue_messages")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.system.queue")}</TableHead>
                      <TableHead>{t("admin.system.type")}</TableHead>
                      <TableHead>{t("admin.system.priority")}</TableHead>
                      <TableHead>{t("admin.system.status")}</TableHead>
                      <TableHead>{t("admin.system.attempts")}</TableHead>
                      <TableHead>{t("admin.system.created")}</TableHead>
                      <TableHead>{t("admin.system.scheduled")}</TableHead>
                      <TableHead>{t("admin.system.processing_time")}</TableHead>
                      <TableHead>{t("admin.system.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredMessages.slice(0, 20).map(message => <TableRow key={message.id}>
                        <TableCell className="font-medium">{message.queueName}</TableCell>
                        <TableCell>
                          <Badge variant="outline">{message.messageType}</Badge>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getPriorityColor(message.priority)}`} />
                            <span className="capitalize">{t(`admin.system.priority_${message.priority.toLowerCase()}`, message.priority)}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(message.status)}`} />
                            <span className="capitalize">{t(`admin.system.status_${message.status.toLowerCase()}`, message.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            {message.attempts}/{message.maxAttempts}
                          </div>
                        </TableCell>
                        <TableCell>{new Date(message.createdAt).toLocaleString()}</TableCell>
                        <TableCell>
                          {message.scheduledAt ? new Date(message.scheduledAt).toLocaleString() : 'Immediate'}
                        </TableCell>
                        <TableCell>
                          {message.processingTime ? `${message.processingTime}ms` : '-'}
                        </TableCell>
                        <TableCell>
                          <div className="flex gap-1">
                            <Button variant="ghost" size="sm">
                              <Eye className="h-4 w-4" />
                            </Button>
                            {message.status === 'FAILED' && <Button variant="ghost" size="sm">
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
                <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                <Input placeholder={t("admin.system.search_logs")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-64" />
              </div>
              <Select value={statusFilter} onValueChange={setStatusFilter}>
                <SelectTrigger className="w-32">
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="ALL">{t("admin.system.all_status")}</SelectItem>
                  <SelectItem value="SUCCESS">{t("admin.system.success")}</SelectItem>
                  <SelectItem value="ERROR">{t("admin.system.error")}</SelectItem>
                  <SelectItem value="TIMEOUT">{t("admin.system.timeout")}</SelectItem>
                  <SelectItem value="RETRY">{t("admin.system.retry")}</SelectItem>
                </SelectContent>
              </Select>
            </div>

            <Card>
              <CardHeader>
                <CardTitle>{t("admin.system.integration_logs")}</CardTitle>
              </CardHeader>
              <CardContent>
                <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin.system.integration")}</TableHead>
                      <TableHead>{t("admin.system.type")}</TableHead>
                      <TableHead>{t("admin.system.direction")}</TableHead>
                      <TableHead>{t("admin.system.status")}</TableHead>
                      <TableHead>{t("admin.system.endpoint")}</TableHead>
                      <TableHead>{t("admin.system.duration")}</TableHead>
                      <TableHead>{t("admin.system.timestamp")}</TableHead>
                      <TableHead>{t("admin.system.size")}</TableHead>
                      <TableHead>{t("admin.system.actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredLogs.slice(0, 20).map(log => <TableRow key={log.id}>
                        <TableCell className="font-medium">{log.integrationName}</TableCell>
                        <TableCell>
                          <Badge variant="outline">{log.integrationType}</Badge>
                        </TableCell>
                        <TableCell>
                          <div className={`flex items-center gap-1 ${log.direction === 'INBOUND' ? 'text-blue-600' : 'text-green-600'}`}>
                            {log.direction === 'INBOUND' ? <Wifi className="h-3 w-3" /> : <Link className="h-3 w-3" />}
                            <span className="capitalize">{t(`admin.system.direction_${log.direction.toLowerCase()}`, log.direction)}</span>
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center gap-2">
                            <div className={`w-2 h-2 rounded-full ${getStatusColor(log.status)}`} />
                            <span className="capitalize">{t(`admin.system.status_${log.status.toLowerCase()}`, log.status)}</span>
                          </div>
                        </TableCell>
                        <TableCell className="font-mono text-sm max-w-xs truncate">
                          {log.endpoint || '-'}
                        </TableCell>
                        <TableCell>{log.duration}{t("admin.system.ms")}</TableCell>
                        <TableCell>{new Date(log.timestamp).toLocaleString()}</TableCell>
                        <TableCell>
                          <div className="text-sm">
                            <div>↓{log.requestSize}B</div>
                            <div>↑{log.responseSize}B</div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Button variant="ghost" size="sm">
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
                <Card>
                  <CardHeader>
                    <CardTitle>{t("admin.system.system_performance")}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-4">
                      <div>
                        <div className="flex justify-between text-sm">
                          <span>{t("admin.system.cpu_usage")}</span>
                          <span>{systemMetrics.cpuUsage.toFixed(1)}%</span>
                        </div>
                        <Progress value={systemMetrics.cpuUsage} />
                      </div>
                      <div>
                        <div className="flex justify-between text-sm">
                          <span>{t("admin.system.memory_usage")}</span>
                          <span>{systemMetrics.memoryUsage.toFixed(1)}%</span>
                        </div>
                        <Progress value={systemMetrics.memoryUsage} />
                      </div>
                      <div>
                        <div className="flex justify-between text-sm">
                          <span>{t("admin.system.error_rate")}</span>
                          <span>{systemMetrics.errorRate.toFixed(2)}%</span>
                        </div>
                        <Progress value={systemMetrics.errorRate} className="bg-red-100" />
                      </div>
                    </div>
                  </CardContent>
                </Card>

                <Card>
                  <CardHeader>
                    <CardTitle>{t("admin.system.integration_status")}</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <div className="space-y-3">
                      <div className="flex justify-between items-center">
                        <span>{t("admin.system.total_integrations")}</span>
                        <Badge variant="outline">{systemMetrics.integrationCount}</Badge>
                      </div>
                      <div className="flex justify-between items-center">
                        <span>{t("admin.system.active_integrations")}</span>
                        <Badge className="bg-green-500">{systemMetrics.activeIntegrations}</Badge>
                      </div>
                      <div className="flex justify-between items-center">
                        <span>{t("admin.system.average_execution_time")}</span>
                        <span>{systemMetrics.averageExecutionTime}{t("admin.system.ms")}</span>
                      </div>
                      <div className="flex justify-between items-center">
                        <span>{t("admin.system.total_executions_24h")}</span>
                        <span>{systemMetrics.totalExecutions.toLocaleString()}</span>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              </div>}
          </TabsContent>
        </Tabs>
      </div>
    </PageShell>;
}