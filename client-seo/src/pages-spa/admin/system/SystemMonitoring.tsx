"use client";

import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from"@/components/ui/tabs";
import { Progress } from"@/components/ui/progress";
import { Server, Database, Cpu, HardDrive, Wifi, AlertTriangle, Activity, Clock, Zap, Network, Shield, RefreshCw, Download, Settings, TrendingUp, TrendingDown, Minus } from"lucide-react";

interface SystemMetric {
 id: string;
 name: string;
 type: 'cpu' | 'memory' | 'disk' | 'network' | 'database' | 'service';
 value: number;
 unit: string;
 status: 'normal' | 'warning' | 'critical';
 threshold: { warning: number; critical: number };
 history: Array<{ timestamp: Date; value: number }>;
 metadata?: { description?: string; details?: Record<string, any> };
}
interface ServiceStatus {
 id: string;
 name: string;
 type: 'api' | 'database' | 'cache' | 'queue' | 'storage' | 'monitoring';
 status: 'running' | 'stopped' | 'error' | 'maintenance';
 uptime: number;
 lastCheck: Date;
 responseTime?: number;
 errorRate?: number;
 version?: string;
 endpoint?: string;
 dependencies?: string[];
}
interface Alert {
 id: string;
 type: 'system' | 'security' | 'performance' | 'availability';
 severity: 'low' | 'medium' | 'high' | 'critical';
 title: string;
 message: string;
 timestamp: Date;
 status: 'active' | 'acknowledged' | 'resolved';
 source: string;
 metadata?: Record<string, any>;
}
export default function SystemMonitoring() {
 const { t } = useTranslation();
 const [metrics, setMetrics] = useState<SystemMetric[]>([]);
 const [services, setServices] = useState<ServiceStatus[]>([]);
 const [alerts, setAlerts] = useState<Alert[]>([]);
 const [isLive, setIsLive] = useState(true);
 const [selectedMetric, setSelectedMetric] = useState<SystemMetric | null>(null);
 const [selectedService, setSelectedService] = useState<ServiceStatus | null>(null);
 const [timeRange, setTimeRange] = useState<'1h' | '6h' | '24h' | '7d'>('1h');

 const generateMockMetrics = (): SystemMetric[] => {
 const now = new Date();
 const generateHistory = (baseValue: number, variance: number) => {
 return Array.from({ length: 60 }, (_, i) => ({
 timestamp: new Date(now.getTime() - (59 - i) * 60000),
 value: baseValue + (Math.random() - 0.5) * variance
 }));
 };
 return [
 { id: 'cpu-usage', name: 'CPU Usage', type: 'cpu' as const, value: 45.2, unit: '%', status: 'normal' as const, threshold: { warning: 70, critical: 90 }, history: generateHistory(45, 15), metadata: { description: t("admin_system_total_cpu_usage_rate"), details: { cores: 8, frequency: '2.4GHz' } } },
 { id: 'memory-usage', name: 'Memory Usage', type: 'memory' as const, value: 68.7, unit: '%', status: 'warning' as const, threshold: { warning: 70, critical: 90 }, history: generateHistory(68, 10), metadata: { description: t("admin_system_system_memory_usage_rate"), details: { total: '32GB', used: '22GB', available: '10GB' } } },
 { id: 'disk-usage', name: 'Disk Usage', type: 'disk' as const, value: 78.3, unit: '%', status: 'warning' as const, threshold: { warning: 80, critical: 95 }, history: generateHistory(78, 5), metadata: { description: t("admin_system_total_disk_usage_rate"), details: { total: '500GB', used: '391GB', available: '109GB' } } },
 { id: 'network-in', name: 'Network In', type: 'network' as const, value: 125.4, unit: 'Mbps', status: 'normal' as const, threshold: { warning: 500, critical: 800 }, history: generateHistory(125, 50), metadata: { description: t("admin_system_network_incoming_speed"), details: { interface: 'eth0', packets: '1.2K/s' } } },
 { id: 'network-out', name: 'Network Out', type: 'network' as const, value: 89.7, unit: 'Mbps', status: 'normal' as const, threshold: { warning: 500, critical: 800 }, history: generateHistory(89, 40), metadata: { description: t("admin_system_network_outgoing_speed"), details: { interface: 'eth0', packets: '950/s' } } },
 { id: 'database-connections', name: 'Database Connections', type: 'database' as const, value: 45, unit: 'conn', status: 'normal' as const, threshold: { warning: 80, critical: 95 }, history: generateHistory(45, 15), metadata: { description: t("admin_system_active_database_connection_count"), details: { max: 100, pool: 'primary' } } },
 ];
 };
 const generateMockServices = (): ServiceStatus[] => {
 return [
 { id: 'api-server', name: 'API Server', type: 'api' as const, status: 'running' as const, uptime: 99.97, lastCheck: new Date(), responseTime: 145, errorRate: 0.02, version: '2.1.0', endpoint: 'http://api.example.com', dependencies: ['database', 'cache', 'queue'] },
 { id: 'database', name: 'Database', type: 'database' as const, status: 'running' as const, uptime: 99.99, lastCheck: new Date(), responseTime: 23, errorRate: 0.001, version: 'PostgreSQL 14.2', endpoint: 'postgresql://db.example.com:5432' },
 { id: 'redis-cache', name: 'Redis Cache', type: 'cache' as const, status: 'running' as const, uptime: 99.95, lastCheck: new Date(), responseTime: 5, errorRate: 0.0, version: '6.2.7', endpoint: 'redis://cache.example.com:6379' },
 { id: 'message-queue', name: 'Message Queue', type: 'queue' as const, status: 'running' as const, uptime: 99.91, lastCheck: new Date(), responseTime: 12, errorRate: 0.01, version: 'RabbitMQ 3.9.0', endpoint: 'amqp://queue.example.com:5672' },
 { id: 'file-storage', name: 'File Storage', type: 'storage' as const, status: 'running' as const, uptime: 99.98, lastCheck: new Date(), responseTime: 89, errorRate: 0.005, version: 'MinIO 4.0.0', endpoint: 'https://storage.example.com' },
 { id: 'monitoring', name: 'Monitoring Service', type: 'monitoring' as const, status: 'maintenance' as const, uptime: 0, lastCheck: new Date(), version: 'Prometheus 2.35.0', endpoint: 'http://monitoring.example.com' },
 ];
 };
 const generateMockAlerts = (): Alert[] => {
 return [
 { id: '1', type: 'system' as const, severity: 'medium' as const, title: t("admin_system_high_memory_usage"), message: t("admin_system_system_memory_usage_reached"), timestamp: new Date(Date.now() - 1000 * 60 * 15), status: 'active' as const, source: 'system-monitor', metadata: { metric: 'memory-usage', value: 68.7 } },
 { id: '2', type: 'performance' as const, severity: 'low' as const, title: t("admin_system_slow_api_response"), message: t("admin_system_api_server_response_time"), timestamp: new Date(Date.now() - 1000 * 60 * 30), status: 'acknowledged' as const, source: 'api-monitor', metadata: { endpoint: '/data', responseTime: 145 } },
 { id: '3', type: 'availability' as const, severity: 'high' as const, title: t("admin_system_monitoring_service_in_maintenance"), message: t("admin_system_monitoring_service_stopped_for"), timestamp: new Date(Date.now() - 1000 * 60 * 45), status: 'resolved' as const, source: 'service-monitor', metadata: { service: 'monitoring' } },
 { id: '4', type: 'security' as const, severity: 'critical' as const, title: t("admin_system_suspicious_login_attempt"), message: t("admin_system_multiple_failed_login_attempts"), timestamp: new Date(Date.now() - 1000 * 60 * 60), status: 'active' as const, source: 'security-monitor', metadata: { ip: '185.220.101.45', attempts: 5 } },
 ];
 };

 useEffect(() => {
 setMetrics(generateMockMetrics());
 setServices(generateMockServices());
 setAlerts(generateMockAlerts());
 }, []);

 useEffect(() => {
 if (!isLive) return;
 const interval = setInterval(() => {
 setMetrics(prev => prev.map(metric => ({
 ...metric,
 value: Math.max(0, metric.value + (Math.random() - 0.5) * 5),
 history: [...metric.history.slice(-59), { timestamp: new Date(), value: metric.value }],
 status: metric.value > metric.threshold.critical ? 'critical' : metric.value > metric.threshold.warning ? 'warning' : 'normal'
 })));
 setServices(prev => prev.map(service => {
 if (Math.random() > 0.95) {
 const statuses: ServiceStatus['status'][] = ['running', 'stopped', 'error'];
 return { ...service, status: statuses[Math.floor(Math.random() * statuses.length)], lastCheck: new Date() };
 }
 return service;
 }));
 }, 5000);
 return () => clearInterval(interval);
 }, [isLive]);

 const getMetricIcon = (type: string) => {
 switch (type) {
 case 'cpu': return <Cpu className="w-5 h-5" />;
 case 'memory': return <Cpu className="w-5 h-5" />;
 case 'disk': return <HardDrive className="w-5 h-5" />;
 case 'network': return <Network className="w-5 h-5" />;
 case 'database': return <Database className="w-5 h-5" />;
 default: return <Server className="w-5 h-5" />;
 }
 };
 const getServiceIcon = (type: string) => {
 switch (type) {
 case 'api': return <Server className="w-5 h-5" />;
 case 'database': return <Database className="w-5 h-5" />;
 case 'cache': return <Zap className="w-5 h-5" />;
 case 'queue': return <Activity className="w-5 h-5" />;
 case 'storage': return <HardDrive className="w-5 h-5" />;
 case 'monitoring': return <Shield className="w-5 h-5" />;
 default: return <Server className="w-5 h-5" />;
 }
 };
 const getStatusColor = (status: string) => {
 switch (status) {
 case 'normal': case 'running': return 'bg-green-100 text-green-800';
 case 'warning': return 'bg-yellow-100 text-yellow-800';
 case 'critical': case 'error': return 'bg-red-100 text-red-800';
 case 'stopped': return 'bg-card text-slate-300';
 case 'maintenance': return 'bg-slate-100 text-slate-800';
 default: return 'bg-card text-slate-300';
 }
 };
 const getSeverityColor = (severity: string) => {
 switch (severity) {
 case 'low': return 'bg-slate-100 text-slate-800';
 case 'medium': return 'bg-yellow-100 text-yellow-800';
 case 'high': return 'bg-orange-100 text-orange-800';
 case 'critical': return 'bg-red-100 text-red-800';
 default: return 'bg-card text-slate-300';
 }
 };
 const getAlertIcon = (type: string) => {
 switch (type) {
 case 'system': return <Server className="w-4 h-4" />;
 case 'security': return <Shield className="w-4 h-4" />;
 case 'performance': return <Activity className="w-4 h-4" />;
 case 'availability': return <Wifi className="w-4 h-4" />;
 default: return <AlertTriangle className="w-4 h-4" />;
 }
 };
 const getTrendIcon = (history: Array<{ value: number }>) => {
 if (history.length < 2) return <Minus className="w-4 h-4" />;
 const recent = history.slice(-5);
 const average = recent.reduce((sum, h) => sum + h.value, 0) / recent.length;
 const current = recent[recent.length - 1].value;
 if (current > average * 1.05) return <TrendingUp className="w-4 h-4 text-red-500" />;
 if (current < average * 0.95) return <TrendingDown className="w-4 h-4 text-green-500" />;
 return <Minus className="w-4 h-4 text-muted-foreground" />;
 };
 const exportMonitoringData = () => {
 const data = { timestamp: new Date().toISOString(), metrics: metrics.map(m => ({ name: m.name, type: m.type, value: m.value, unit: m.unit, status: m.status })), services: services.map(s => ({ name: s.name, type: s.type, status: s.status, uptime: s.uptime, responseTime: s.responseTime, errorRate: s.errorRate })), alerts: alerts.map(a => ({ type: a.type, severity: a.severity, title: a.title, message: a.message, status: a.status, timestamp: a.timestamp.toISOString() })) };
 const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
 const url = window.URL.createObjectURL(blob);
 const a = document.createElement('a');
 a.href = url; a.download = `monitoring-data-${new Date().toISOString().split('T')[0]}.json`; a.click();
 window.URL.revokeObjectURL(url);
 };
 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen bg-background">
 <div className="p-6 space-y-6">
 <div className="bg-card p-6 rounded-2xl border border-border">
 <h1 className="text-xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_system_system_monitoring")}</h1>
 <p className="text-sm text-muted-foreground">{t("admin_system_monitor_system_performance_and")}</p>
 </div>

 <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
 <div className="flex flex-wrap gap-2">
 <Button variant={isLive ?"default" :"outline"} size="sm" onClick={() => setIsLive(!isLive)}>
 {isLive ? <Activity className="w-4 h-4 mr-2" /> : <Clock className="w-4 h-4 mr-2" />}
 {isLive ?"Live" :"Pause"}
 </Button>
 <Button variant="outline" size="sm" onClick={() => { setMetrics(generateMockMetrics()); setServices(generateMockServices()); setAlerts(generateMockAlerts()); }}>
 <RefreshCw className="w-4 h-4 mr-2" />{t("admin_system_refresh")}</Button>
 <Button variant="outline" size="sm" onClick={exportMonitoringData}>
 <Download className="w-4 h-4 mr-2" />{t("admin_system_download")}</Button>
 </div>
 <select aria-label="Filter by time range" className="px-3 py-1 border rounded-xl text-sm bg-card border-border text-foreground" value={timeRange} onChange={e => setTimeRange(e.target.value as any)}>
 <option value="1h">{t("admin_system_last_1_hour")}</option>
 <option value="6h">{t("admin_system_last_6_hours")}</option>
 <option value="24h">{t("admin_system_last_24_hours")}</option>
 <option value="7d">{t("admin_system_last_7_days")}</option>
 </select>
 </div>

 <Tabs defaultValue="metrics" className="w-full">
 <TabsList className="grid w-full grid-cols-3 bg-card border-border">
 <TabsTrigger value="metrics" className="text-foreground data-[state=active]:bg-white/10">{t("admin_system_metrics")}</TabsTrigger>
 <TabsTrigger value="services" className="text-foreground data-[state=active]:bg-white/10">{t("admin_system_services")}</TabsTrigger>
 <TabsTrigger value="alerts" className="text-foreground data-[state=active]:bg-white/10">{t("admin_system_alerts")}</TabsTrigger>
 </TabsList>

 <TabsContent value="metrics" className="space-y-6">
 <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
 {metrics.map(metric => <Card key={metric.id} className="bg-card border-border cursor-pointer" onClick={() => setSelectedMetric(metric)}>
 <CardContent className="p-4">
 <div className="flex items-center justify-between mb-3">
 <div className="flex items-center gap-2">
 {getMetricIcon(metric.type)}
  <h2 className="font-medium text-foreground">{metric.name}</h2>
 </div>
 <div className="flex items-center gap-1">
 {getTrendIcon(metric.history)}
 <Badge className={getStatusColor(metric.status)}>
 {metric.status === 'normal' ? t("admin_system_status_normal","Normal") : metric.status === 'warning' ? t("admin_system_status_warning","Uyarı") : t("admin_system_status_critical","Kritik")}
 </Badge>
 </div>
 </div>
 <div className="mb-3">
 <div className="text-2xl font-bold text-foreground">
 {metric.value.toFixed(1)} {metric.unit}
 </div>
 <Progress value={metric.value} className="mt-2" />
 </div>
 <div className="text-xs text-muted-foreground">{metric.metadata?.description}</div>
 </CardContent>
 </Card>)}
 </div>

 {selectedMetric && <Card className="bg-card border-border">
 <CardHeader>
 <div className="flex items-center justify-between">
 <CardTitle className="text-foreground">{selectedMetric.name}{t("admin_system_detail")}</CardTitle>
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-foreground" onClick={() => setSelectedMetric(null)}>×</Button>
 </div>
 </CardHeader>
 <CardContent>
 <div className="grid grid-cols-2 gap-4 mb-4">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_system_current_value")}</p>
 <p className="text-2xl font-bold text-foreground">{selectedMetric.value.toFixed(2)} {selectedMetric.unit}</p>
 </div>
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_system_status")}</p>
 <Badge className={getStatusColor(selectedMetric.status)}>{selectedMetric.status === 'normal' ? t("admin_system_status_normal","Normal") : selectedMetric.status === 'warning' ? t("admin_system_status_warning","Uyarı") : t("admin_system_status_critical","Kritik")}</Badge>
 </div>
 </div>
 {selectedMetric.metadata?.details && <div className="mb-4">
 <p className="text-sm font-medium text-muted-foreground mb-2">{t("admin_system_details")}</p>
 <div className="bg-card p-3 rounded-xl">
 <pre className="text-xs text-foreground">{JSON.stringify(selectedMetric.metadata.details, null, 2)}</pre>
 </div>
 </div>}
 </CardContent>
 </Card>}
 </TabsContent>

 <TabsContent value="services" className="space-y-6">
 <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
 {services.map(service => <Card key={service.id} className="bg-card border-border cursor-pointer" onClick={() => setSelectedService(service)}>
 <CardContent className="p-4">
 <div className="flex items-center justify-between mb-3">
 <div className="flex items-center gap-2">
 {getServiceIcon(service.type)}
  <h2 className="font-medium text-foreground">{service.name}</h2>
 </div>
 <Badge className={getStatusColor(service.status)}>
 {service.status === 'running' ? t("admin_system_status_running","Çalışıyor") : service.status === 'stopped' ? t("admin_system_status_stopped","Durduruldu") : service.status === 'error' ? t("admin_system_status_error","Hata") : t("admin_system_status_maintenance","Bakım")}
 </Badge>
 </div>
 <div className="space-y-2 text-sm">
 <div className="flex justify-between">
 <span className="text-muted-foreground">{t("admin_system_uptime")}</span>
 <span className="font-medium text-foreground">{service.uptime.toFixed(2)}%</span>
 </div>
 {service.responseTime && <div className="flex justify-between">
 <span className="text-muted-foreground">{t("admin_system_response_time")}</span>
 <span className="font-medium text-foreground">{service.responseTime}{t("admin_system_ms")}</span>
 </div>}
 {service.errorRate !== undefined && <div className="flex justify-between">
 <span className="text-muted-foreground">{t("admin_system_error_rate")}</span>
 <span className="font-medium text-foreground">{(service.errorRate * 100).toFixed(2)}%</span>
 </div>}
 </div>
 </CardContent>
 </Card>)}
 </div>
 {selectedService && <Card className="bg-card border-border">
 <CardHeader>
 <div className="flex items-center justify-between">
 <CardTitle className="text-foreground">{selectedService.name}{t("admin_system_detail")}</CardTitle>
 <Button variant="ghost" size="sm" className="text-muted-foreground hover:text-foreground" onClick={() => setSelectedService(null)}>×</Button>
 </div>
 </CardHeader>
 <CardContent>
 <div className="grid grid-cols-2 gap-4 mb-4">
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_system_status")}</p>
 <Badge className={getStatusColor(selectedService.status)}>{selectedService.status === 'running' ? t("admin_system_status_running","Çalışıyor") : selectedService.status === 'stopped' ? t("admin_system_status_stopped","Durduruldu") : selectedService.status === 'error' ? t("admin_system_status_error","Hata") : t("admin_system_status_maintenance","Bakım")}</Badge>
 </div>
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_system_uptime")}</p>
 <p className="font-medium text-foreground">{selectedService.uptime.toFixed(2)}%</p>
 </div>
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_system_version")}</p>
 <p className="font-medium text-foreground">{selectedService.version || '-'}</p>
 </div>
 <div>
 <p className="text-sm font-medium text-muted-foreground">{t("admin_system_endpoint")}</p>
 <p className="font-medium text-sm text-foreground">{selectedService.endpoint || '-'}</p>
 </div>
 </div>
 {selectedService.dependencies && selectedService.dependencies.length > 0 && <div>
 <p className="text-sm font-medium text-muted-foreground mb-2">{t("admin_system_dependencies")}</p>
 <div className="flex gap-2 flex-wrap">
 {selectedService.dependencies.map((dep, index) => <Badge key={index} variant="outline" className="border-border text-muted-foreground">{dep}</Badge>)}
 </div>
 </div>}
 </CardContent>
 </Card>}
 </TabsContent>

 <TabsContent value="alerts" className="space-y-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_system_active_alerts")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-3">
 {alerts.map(alert => <div key={alert.id} className="flex items-start gap-3 p-4 border border-border rounded-lg hover:bg-card transition-colors">
 <div className="mt-1 text-muted-foreground">{getAlertIcon(alert.type)}</div>
 <div className="flex-1 min-w-0">
 <div className="flex items-center gap-2 mb-1">
  <h2 className="font-medium text-foreground">{alert.title}</h2>
 <Badge className={getSeverityColor(alert.severity)}>{alert.severity === 'low' ? t("admin_system_severity_low","Düşük") : alert.severity === 'medium' ? t("admin_system_severity_medium","Orta") : alert.severity === 'high' ? t("admin_system_severity_high","Yüksek") : t("admin_system_severity_critical","Kritik")}</Badge>
 <Badge className={getStatusColor(alert.status)}>{alert.status === 'active' ? t("admin_system_alert_active","Aktif") : alert.status === 'acknowledged' ? t("admin_system_alert_acknowledged","Onaylandı") : t("admin_system_alert_resolved","Çözüldü")}</Badge>
 </div>
 <p className="text-sm text-muted-foreground mb-1">{alert.message}</p>
 <div className="flex items-center gap-4 text-xs text-muted-foreground">
 <span>{alert.source}</span>
 <span>{alert.timestamp.toLocaleString()}</span>
 </div>
 </div>
 <div className="flex gap-1">
 <Button variant="outline" size="sm" className="border-border text-muted-foreground"><Settings className="w-4 h-4" /></Button>
 </div>
 </div>)}
 </div>
 </CardContent>
 </Card>
 </TabsContent>
 </Tabs>
 </div>
 </div>;
}
