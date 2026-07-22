"use client";

import { useTranslation } from"react-i18next";
import { useState } from"react";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Progress } from"@/components/ui/progress";
import { Cloud, Server, Database, Globe, Shield, CheckCircle, AlertTriangle, Zap, Activity, DollarSign, TrendingUp, Clock, Rocket, BarChart3 } from"lucide-react";
import { m } from"framer-motion";
import { cn } from"@/lib/utils";
import { useToast } from"@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from"@tanstack/react-query";
import { cloudApi, type CloudService } from"@/lib/api/cloud";
import { apiClient } from"@/lib/api";

export default function GoogleCloudManager() {
 const { t } = useTranslation();
 const [deploying, setDeploying] = useState<string | null>(null);
 const { toast } = useToast();
 const queryClient = useQueryClient();
 const deleteMutation = useMutation({
 mutationFn: async (id: string) => apiClient.delete(`/unknown/${id}`),
 onSuccess: () => {
 toast({ title:"Deleted", description:"Record deleted successfully" });
 queryClient.invalidateQueries();
 },
 onError: (err: any) => toast({ title:"Error", description: err.message, variant:"destructive" })
 });
 


 const { data: services = [], isLoading } = useQuery({
 queryKey: ['cloudServices'],
 queryFn: () => cloudApi.getServices(),
 });

 const deployMutation = useMutation({
 mutationFn: (name: string) => cloudApi.deployService(name),
 onSuccess: (_data, name) => {
 queryClient.invalidateQueries({ queryKey: ['cloudServices'] });
 setDeploying(null);
 },
 onError: (error: any) => {
 toast({
 title: t("admin_cloud_deployment_failed"),
 description: error?.message ||"Deployment failed.",
 variant:"destructive"
 });
 setDeploying(null);
 }
 });

 const stopMutation = useMutation({
 mutationFn: (name: string) => cloudApi.stopService(name),
 onSuccess: (_data, name) => {
 queryClient.invalidateQueries({ queryKey: ['cloudServices'] });
 toast({
 title: t("admin_cloud_service_stopped"),
 description: `${name} has been stopped.`
 });
 },
 onError: (error: any) => {
 toast({
 title: t("admin_cloud_stop_failed"),
 description: error?.message ||"Failed to stop service.",
 variant:"destructive"
 });
 }
 });

 const getStatusColor = (status: string) => {
 switch (status) {
 case 'ACTIVE':
 return 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20';
 case 'DEPLOYING':
 return 'bg-muted0/10 text-muted-foreground border-slate-500/20';
 case 'ERROR':
 return 'bg-red-500/10 text-red-400 border-red-500/20';
 case 'STOPPED':
 return 'bg-muted0/10 text-muted-foreground border-slate-500/20';
 default:
 return 'bg-orange-500/10 text-orange-400 border-orange-500/20';
 }
 };

 const getStatusIcon = (status: string) => {
 switch (status) {
 case 'ACTIVE':
 return <CheckCircle className="w-4 h-4" />;
 case 'DEPLOYING':
 return <Activity className="w-4 h-4" />;
 case 'ERROR':
 return <AlertTriangle className="w-4 h-4" />;
 case 'STOPPED':
 return <Clock className="w-4 h-4" />;
 default:
 return <Clock className="w-4 h-4" />;
 }
 };

 const handleDeploy = (serviceName: string) => {
 setDeploying(serviceName);
 toast({
 title: t("admin_cloud_deployment_started"),
 description: `${serviceName} is being deployed to Google Cloud.`
 });
 queryClient.setQueryData(['cloudServices'], (old: CloudService[] | undefined) =>
 old?.map(service => service.name === serviceName ? { ...service, status: 'DEPLOYING' } : service)
 );
 deployMutation.mutate(serviceName);
 };

 const handleStop = (serviceName: string) => {
 stopMutation.mutate(serviceName);
 };

 const totalUsage = {
 cpu: services.reduce((sum, service) => sum + service.usage.cpu, 0),
 memory: services.reduce((sum, service) => sum + service.usage.memory, 0),
 storage: services.reduce((sum, service) => sum + service.usage.storage, 0),
 bandwidth: services.reduce((sum, service) => sum + service.usage.bandwidth, 0)
 };
 const totalLimits = {
 cpu: services.reduce((sum, service) => sum + service.limits.cpu, 0),
 memory: services.reduce((sum, service) => sum + service.limits.memory, 0),
 storage: services.reduce((sum, service) => sum + service.limits.storage, 0),
 bandwidth: services.reduce((sum, service) => sum + service.limits.bandwidth, 0)
 };
 const totalCost = services.reduce((sum, service) => sum + service.cost.current, 0);

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6">
 <div className="max-w-7xl mx-auto space-y-8">
 {/* Header */}
 <div className="bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center justify-between">
 <div>
 <h1 className="text-3xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_cloud_google_cloud_infrastructure")}</h1>
 <p className="text-sm text-muted-foreground mt-1">{t("admin_cloud_free_tier_deployment_and")}</p>
 </div>
 <div className="flex items-center gap-4">
 <Badge className="bg-emerald-500/20 text-emerald-400 border-emerald-500/20 px-4 py-2">
 <div className="flex items-center gap-2">
 <Zap className="w-4 h-4" />
 <span className="font-bold text-xs">{t("admin_cloud_free_tier_active")}</span>
 </div>
 </Badge>
 </div>
 </div>
 </div>

 {/* Overview Cards */}
 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
 <Card className="bg-card border-border rounded-3xl p-6">
 <div className="flex items-center gap-3">
 <div className="w-10 h-10 rounded-xl bg-muted0/20 flex items-center justify-center">
 <Server className="w-5 h-5 text-muted-foreground" />
 </div>
 <div>
 <p className="text-[10px] font-bold text-muted-foreground">{t("admin_cloud_active_services")}</p>
 <p className="text-2xl font-bold text-foreground">{services.filter(s => s.status === 'ACTIVE').length}</p>
 </div>
 </div>
 </Card>
 <Card className="bg-card border-border rounded-3xl p-6">
 <div className="flex items-center gap-3">
 <div className="w-10 h-10 rounded-xl bg-emerald-500/20 flex items-center justify-center">
 <DollarSign className="w-5 h-5 text-emerald-400" />
 </div>
 <div>
 <p className="text-[10px] font-bold text-muted-foreground">{t("admin_cloud_monthly_cost")}</p>
 <p className="text-2xl font-bold text-foreground">{t("currency_symbol", "$")}{totalCost.toFixed(2)}</p>
 </div>
 </div>
 </Card>
 <Card className="bg-card border-border rounded-3xl p-6">
 <div className="flex items-center gap-3">
 <div className="w-10 h-10 rounded-xl bg-orange-500/20 flex items-center justify-center">
 <TrendingUp className="w-5 h-5 text-orange-400" />
 </div>
 <div>
 <p className="text-[10px] font-bold text-muted-foreground">{t("admin_cloud_cpu_usage")}</p>
 <p className="text-2xl font-bold text-foreground">{totalUsage.cpu}%</p>
 </div>
 </div>
 </Card>
 <Card className="bg-card border-border rounded-3xl p-6">
 <div className="flex items-center gap-3">
 <div className="w-10 h-10 rounded-xl bg-muted0/20 flex items-center justify-center">
 <Database className="w-5 h-5 text-muted-foreground" />
 </div>
 <div>
 <p className="text-[10px] font-bold text-muted-foreground">{t("admin_cloud_storage_used")}</p>
 <p className="text-2xl font-bold text-foreground">{(totalUsage.storage / 1024).toFixed(1)}{t("admin_cloud_gb")}</p>
 </div>
 </div>
 </Card>
 </div>

 {/* Resource Usage Overview */}
 <Card className="bg-card border-border rounded-3xl p-8">
 <CardHeader>
 <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
 <BarChart3 className="w-5 h-5 text-slate-500" />{t("admin_cloud_resource_usage_overview")}</CardTitle>
 </CardHeader>
 <CardContent className="space-y-6">
 <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
 <div className="space-y-4">
 <div className="flex items-center justify-between text-sm">
 <span className="text-muted-foreground">{t("admin_cloud_cpu_usage")}</span>
 <span className="text-foreground">{totalUsage.cpu}% / {totalLimits.cpu}%</span>
 </div>
 <Progress value={totalUsage.cpu} className="h-2" />
 </div>
 <div className="space-y-4">
 <div className="flex items-center justify-between text-sm">
 <span className="text-muted-foreground">{t("admin_cloud_memory_usage")}</span>
 <span className="text-foreground">{totalUsage.memory}{t("admin_cloud_mb")} {t("/", "/")}{totalLimits.memory}{t("admin_cloud_mb")}</span>
 </div>
 <Progress value={totalUsage.memory / totalLimits.memory * 100} className="h-2" />
 </div>
 <div className="space-y-4">
 <div className="flex items-center justify-between text-sm">
 <span className="text-muted-foreground">{t("admin_cloud_storage_usage")}</span>
 <span className="text-foreground">{totalUsage.storage}{t("admin_cloud_mb")} {t("/", "/")}{totalLimits.storage}{t("admin_cloud_mb")}</span>
 </div>
 <Progress value={totalUsage.storage / totalLimits.storage * 100} className="h-2" />
 </div>
 <div className="space-y-4">
 <div className="flex items-center justify-between text-sm">
 <span className="text-muted-foreground">{t("admin_cloud_bandwidth_usage")}</span>
 <span className="text-foreground">{totalUsage.bandwidth}{t("admin_cloud_gb")} {t("/", "/")}{totalLimits.bandwidth}{t("admin_cloud_gb")}</span>
 </div>
 <Progress value={totalUsage.bandwidth / totalLimits.bandwidth * 100} className="h-2" />
 </div>
 </div>
 </CardContent>
 </Card>

 {/* Services List */}
 <div className="space-y-6">
 <h2 className="text-xl font-bold text-foreground mb-4">{t("admin_cloud_cloud_services")}</h2>
 <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
 {services.map(service => (
 <m.div key={service.name} whileHover={{ scale: 1.02 }} className="bg-card border-border rounded-3xl p-6">
 <div className="flex items-center justify-between mb-4">
 <div className="flex items-center gap-3">
 <Cloud className="w-5 h-5 text-muted-foreground" />
 <h3 className="text-lg font-bold text-foreground">{service.name}</h3>
 </div>
 <div className="flex items-center gap-2">
 {getStatusIcon(service.status)}
 <Badge className={cn("text-[9px] font-bold px-2", getStatusColor(service.status))}>
 {service.status}
 </Badge>
 </div>
 </div>
 {service.url && (
 <div className="mb-4">
 <a href={service.url} target="_blank" rel="noopener noreferrer" className="text-xs text-muted-foreground hover:text-slate-300 transition-colors">
 {service.url}
 </a>
 </div>
 )}
 <div className="space-y-3">
 <div className="grid grid-cols-2 gap-4 text-sm">
 <div>
 <p className="text-muted-foreground">{t("admin_cloud_cpu")}</p>
 <p className="text-foreground">{service.usage.cpu}% / {service.limits.cpu}%</p>
 </div>
 <div>
 <p className="text-muted-foreground">{t("admin_cloud_memory")}</p>
 <p className="text-foreground">{service.usage.memory}{t("admin_cloud_mb")} {t("/", "/")}{service.limits.memory}{t("admin_cloud_mb")}</p>
 </div>
 <div>
 <p className="text-muted-foreground">{t("admin_cloud_storage")}</p>
 <p className="text-foreground">{service.usage.storage}{t("admin_cloud_mb")} {t("/", "/")}{service.limits.storage}{t("admin_cloud_mb")}</p>
 </div>
 <div>
 <p className="text-muted-foreground">{t("admin_cloud_bandwidth")}</p>
 <p className="text-foreground">{service.usage.bandwidth}{t("admin_cloud_gb")} {t("/", "/")}{service.limits.bandwidth}{t("admin_cloud_gb")}</p>
 </div>
 </div>
 <div className="flex items-center justify-between pt-3 border-t border-border">
 <div>
 <p className="text-xs text-muted-foreground">{t("admin_cloud_monthly_cost")}</p>
 <p className="text-lg font-bold text-foreground">{t("currency_symbol", "$")}{service.cost.current.toFixed(2)}</p>
 </div>
 <div className="flex items-center gap-2">
 {service.status === 'ACTIVE' ? (
 <Button size="sm" variant="outline" onClick={() => handleStop(service.name)} className="border-red-500/20 text-red-400 hover:bg-red-500/10">
 {t("admin_cloud_stop")}
 </Button>
 ) : (
 <Button size="sm" onClick={() => handleDeploy(service.name)} disabled={deploying === service.name} className="bg-emerald-600 hover:bg-emerald-500">
 {deploying === service.name ? (
 <><Activity className="w-3 h-3 mr-1 animate-spin" />{t("admin_cloud_deploying")}</>
 ) : (
 <><Rocket className="w-3 h-3 mr-1" />{t("admin_cloud_deploy")}</>
 )}
 </Button>
 )}
 </div>
 </div>
 </div>
 </m.div>
 ))}
 </div>
 </div>

 {/* Free Tier Benefits */}
 <Card className="bg-gradient-to-r from-slate-600/10 to-slate-600/10 border-border rounded-3xl p-8">
 <CardHeader>
 <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
 <Shield className="w-5 h-5 text-emerald-400" />{t("admin_cloud_free_tier_benefits")}</CardTitle>
 </CardHeader>
 <CardContent className="space-y-4">
 <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
 <div className="space-y-3">
 <h4 className="text-sm font-bold text-foreground">{t("admin_cloud_compute")}</h4>
 <ul className="space-y-2 text-sm text-muted-foreground">
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_1_f1micro_instance_744")}</span>
 </li>
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_shared_cpu_infrastructure")}</span>
 </li>
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_preemptible_vm_instances")}</span>
 </li>
 </ul>
 </div>
 <div className="space-y-3">
 <h4 className="text-sm font-bold text-foreground">{t("admin_cloud_storage")}</h4>
 <ul className="space-y-2 text-sm text-muted-foreground">
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_5_gb_standard_storage")}</span>
 </li>
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_5_gb_cloud_storage")}</span>
 </li>
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_30_gb_cloud_sql")}</span>
 </li>
 </ul>
 </div>
 <div className="space-y-3">
 <h4 className="text-sm font-bold text-foreground">{t("admin_cloud_networking")}</h4>
 <ul className="space-y-2 text-sm text-muted-foreground">
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_1_gb_egressmonth")}</span>
 </li>
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_load_balancing")}</span>
 </li>
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_ssl_certificates")}</span>
 </li>
 </ul>
 </div>
 <div className="space-y-3">
 <h4 className="text-sm font-bold text-foreground">{t("admin_cloud_services")}</h4>
 <ul className="space-y-2 text-sm text-muted-foreground">
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_2m_cloud_functions_invocations")}</span>
 </li>
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_28_instancehoursday_app_engine")}</span>
 </li>
 <li className="flex items-center gap-2">
 <CheckCircle className="w-3 h-3 text-emerald-400" />
 <span>{t("admin_cloud_180k_vcpusecondsmonth_cloud_run")}</span>
 </li>
 </ul>
 </div>
 </div>
 <div className="mt-6 p-4 bg-emerald-500/10 rounded-2xl border border-emerald-500/20">
 <div className="flex items-center gap-3">
 <DollarSign className="w-5 h-5 text-emerald-400" />
 <div>
 <p className="text-sm font-bold text-emerald-400">{t("admin_cloud_monthly_savings")}</p>
 <p className="text-2xl font-bold text-emerald-400">$100-200+</p>
 </div>
 </div>
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 );
}
