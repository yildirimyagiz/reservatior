import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "../../client/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Progress } from "@/components/ui/progress";
import { Switch } from "@/components/ui/switch";
import { Cloud, Server, Database, Globe, Shield, CheckCircle, AlertTriangle, Zap, Activity, DollarSign, TrendingUp, Clock, Settings, Rocket, BarChart3 } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { useToast } from "@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { cloudApi, type CloudService } from "@/lib/api/cloud";
export default function GoogleCloudManager() {
  const {
    t
  } = useTranslation();
  const [deploying, setDeploying] = useState<string | null>(null);
  const {
    toast
  } = useToast();
  const queryClient = useQueryClient();

  const { data: services = [], isLoading } = useQuery({
    queryKey: ['cloudServices'],
    queryFn: () => cloudApi.getServices(),
  });

  const deployMutation = useMutation({
    mutationFn: (name: string) => cloudApi.deployService(name),
    onSuccess: (data, name) => {
      queryClient.invalidateQueries({ queryKey: ['cloudServices'] });
      setDeploying(null);
    },
    onError: (error: any) => {
      toast({
        title: t("admin.cloud.deployment_failed"),
        description: error?.message || "Deployment failed.",
        variant: "destructive"
      });
      setDeploying(null);
    }
  });

  const stopMutation = useMutation({
    mutationFn: (name: string) => cloudApi.stopService(name),
    onSuccess: (data, name) => {
      queryClient.invalidateQueries({ queryKey: ['cloudServices'] });
      toast({
        title: t("admin.cloud.service_stopped"),
        description: `${name} has been stopped.`
      });
    },
    onError: (error: any) => {
      toast({
        title: t("admin.cloud.stop_failed"),
        description: error?.message || "Failed to stop service.",
        variant: "destructive"
      });
    }
  });
  const getStatusColor = (status: string) => {
    switch (status) {
      case 'ACTIVE':
        return 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20';
      case 'DEPLOYING':
        return 'bg-blue-500/10 text-blue-400 border-blue-500/20';
      case 'ERROR':
        return 'bg-red-500/10 text-red-400 border-red-500/20';
      case 'STOPPED':
        return 'bg-slate-500/10 text-muted-foreground border-slate-500/20';
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
      title: t("admin.cloud.deployment_started"),
      description: `${serviceName} is being deployed to Google Cloud.`
    });
    // Optimistically update status
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
  return <PageShell title={t("admin.cloud.google_cloud_manager")} description={t("admin.cloud.free_tier_cloud_infrastructure")}>
      <div className="max-w-7xl mx-auto px-4 lg:px-8 py-10 space-y-8">
        
        {/* Header */}
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-3xl font-bold text-foreground">{t("admin.cloud.google_cloud_infrastructure")}</h1>
            <p className="text-sm text-muted-foreground mt-1">{t("admin.cloud.free_tier_deployment_and")}</p>
          </div>
          
          <div className="flex items-center gap-4">
            <Badge className="bg-emerald-500/20 text-emerald-400 border-emerald-500/20 px-4 py-2">
              <div className="flex items-center gap-2">
                <Zap className="w-4 h-4" />
                <span className="font-bold text-xs">{t("admin.cloud.free_tier_active")}</span>
              </div>
            </Badge>
          </div>
        </div>

        {/* Overview Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <Card className="bg-card border-border rounded-3xl p-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-blue-500/20 flex items-center justify-center">
                <Server className="w-5 h-5 text-blue-400" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-muted-foreground">{t("admin.cloud.active_services")}</p>
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
                <p className="text-[10px] font-bold text-muted-foreground">{t("admin.cloud.monthly_cost")}</p>
                <p className="text-2xl font-bold text-foreground">${totalCost.toFixed(2)}</p>
              </div>
            </div>
          </Card>
          
          <Card className="bg-card border-border rounded-3xl p-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-orange-500/20 flex items-center justify-center">
                <TrendingUp className="w-5 h-5 text-orange-400" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-muted-foreground">{t("admin.cloud.cpu_usage")}</p>
                <p className="text-2xl font-bold text-foreground">{totalUsage.cpu}%</p>
              </div>
            </div>
          </Card>
          
          <Card className="bg-card border-border rounded-3xl p-6">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 rounded-xl bg-violet-500/20 flex items-center justify-center">
                <Database className="w-5 h-5 text-violet-400" />
              </div>
              <div>
                <p className="text-[10px] font-bold text-muted-foreground">{t("admin.cloud.storage_used")}</p>
                <p className="text-2xl font-bold text-foreground">{(totalUsage.storage / 1024).toFixed(1)}{t("admin.cloud.gb")}</p>
              </div>
            </div>
          </Card>
        </div>

        {/* Resource Usage Overview */}
        <Card className="bg-card border-border rounded-3xl p-8">
          <CardHeader>
            <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
              <BarChart3 className="w-5 h-5 text-purple-500" />{t("admin.cloud.resource_usage_overview")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
              <div className="space-y-4">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">{t("admin.cloud.cpu_usage")}</span>
                  <span className="text-foreground">{totalUsage.cpu}% / {totalLimits.cpu}%</span>
                </div>
                <Progress value={totalUsage.cpu} className="h-2" />
              </div>
              
              <div className="space-y-4">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">{t("admin.cloud.memory_usage")}</span>
                  <span className="text-foreground">{totalUsage.memory}{t("admin.cloud.mb")}{totalLimits.memory}{t("admin.cloud.mb")}</span>
                </div>
                <Progress value={totalUsage.memory / totalLimits.memory * 100} className="h-2" />
              </div>
              
              <div className="space-y-4">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">{t("admin.cloud.storage_usage")}</span>
                  <span className="text-foreground">{totalUsage.storage}{t("admin.cloud.mb")}{totalLimits.storage}{t("admin.cloud.mb")}</span>
                </div>
                <Progress value={totalUsage.storage / totalLimits.storage * 100} className="h-2" />
              </div>
              
              <div className="space-y-4">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">{t("admin.cloud.bandwidth_usage")}</span>
                  <span className="text-foreground">{totalUsage.bandwidth}{t("admin.cloud.gb")}{totalLimits.bandwidth}{t("admin.cloud.gb")}</span>
                </div>
                <Progress value={totalUsage.bandwidth / totalLimits.bandwidth * 100} className="h-2" />
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Services List */}
        <div className="space-y-6">
          <h2 className="text-xl font-bold text-foreground mb-4">{t("admin.cloud.cloud_services")}</h2>
          
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            {services.map(service => <motion.div key={service.name} whileHover={{
            scale: 1.02
          }} className="bg-card border-border rounded-3xl p-6">
                <div className="flex items-center justify-between mb-4">
                  <div className="flex items-center gap-3">
                    <Cloud className="w-5 h-5 text-blue-400" />
                    <h3 className="text-lg font-bold text-foreground">{service.name}</h3>
                  </div>
                  
                  <div className="flex items-center gap-2">
                    {getStatusIcon(service.status)}
                    <Badge className={cn("text-[9px] font-bold   px-2", getStatusColor(service.status))}>
                      {service.status}
                    </Badge>
                  </div>
                </div>
                
                {service.url && <div className="mb-4">
                    <a href={service.url} target="_blank" rel="noopener noreferrer" className="text-xs text-blue-400 hover:text-blue-300 transition-colors">
                      {service.url}
                    </a>
                  </div>}
                
                <div className="space-y-3">
                  <div className="grid grid-cols-2 gap-4 text-sm">
                    <div>
                      <p className="text-muted-foreground">{t("admin.cloud.cpu")}</p>
                      <p className="text-foreground">{service.usage.cpu}% / {service.limits.cpu}%</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">{t("admin.cloud.memory")}</p>
                      <p className="text-foreground">{service.usage.memory}{t("admin.cloud.mb")}{service.limits.memory}{t("admin.cloud.mb")}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">{t("admin.cloud.storage")}</p>
                      <p className="text-foreground">{service.usage.storage}{t("admin.cloud.mb")}{service.limits.storage}{t("admin.cloud.mb")}</p>
                    </div>
                    <div>
                      <p className="text-muted-foreground">{t("admin.cloud.bandwidth")}</p>
                      <p className="text-foreground">{service.usage.bandwidth}{t("admin.cloud.gb")}{service.limits.bandwidth}{t("admin.cloud.gb")}</p>
                    </div>
                  </div>
                  
                  <div className="flex items-center justify-between pt-3 border-t border-border">
                    <div>
                      <p className="text-xs text-muted-foreground">{t("admin.cloud.monthly_cost")}</p>
                      <p className="text-lg font-bold text-foreground">${service.cost.current.toFixed(2)}</p>
                    </div>
                    
                    <div className="flex items-center gap-2">
                      {service.status === 'ACTIVE' ? <Button size="sm" variant="outline" onClick={() => handleStop(service.name)} className="border-red-500/20 text-red-400 hover:bg-red-500/10">{t("admin.cloud.stop")}</Button> : <Button size="sm" onClick={() => handleDeploy(service.name)} disabled={deploying === service.name} className="bg-emerald-600 hover:bg-emerald-500">
                          {deploying === service.name ? <>
                              <Activity className="w-3 h-3 mr-1 animate-spin" />{t("admin.cloud.deploying")}</> : <>
                              <Rocket className="w-3 h-3 mr-1" />{t("admin.cloud.deploy")}</>}
                        </Button>}
                    </div>
                  </div>
                </div>
              </motion.div>)}
          </div>
        </div>

        {/* Free Tier Benefits */}
        <Card className="bg-linear-to-r from-blue-600/10 to-purple-600/10 border-border rounded-3xl p-8">
          <CardHeader>
            <CardTitle className="text-lg font-bold text-foreground flex items-center gap-2">
              <Shield className="w-5 h-5 text-emerald-400" />{t("admin.cloud.free_tier_benefits")}</CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="space-y-3">
                <h4 className="text-sm font-bold text-foreground">{t("admin.cloud.compute")}</h4>
                <ul className="space-y-2 text-sm text-muted-foreground">
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.1_f1micro_instance_744")}</span>
                  </li>
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.shared_cpu_infrastructure")}</span>
                  </li>
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.preemptible_vm_instances")}</span>
                  </li>
                </ul>
              </div>
              
              <div className="space-y-3">
                <h4 className="text-sm font-bold text-foreground">{t("admin.cloud.storage")}</h4>
                <ul className="space-y-2 text-sm text-muted-foreground">
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.5_gb_standard_storage")}</span>
                  </li>
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.5_gb_cloud_storage")}</span>
                  </li>
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.30_gb_cloud_sql")}</span>
                  </li>
                </ul>
              </div>
              
              <div className="space-y-3">
                <h4 className="text-sm font-bold text-foreground">{t("admin.cloud.networking")}</h4>
                <ul className="space-y-2 text-sm text-muted-foreground">
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.1_gb_egressmonth")}</span>
                  </li>
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.load_balancing")}</span>
                  </li>
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.ssl_certificates")}</span>
                  </li>
                </ul>
              </div>
              
              <div className="space-y-3">
                <h4 className="text-sm font-bold text-foreground">{t("admin.cloud.services")}</h4>
                <ul className="space-y-2 text-sm text-muted-foreground">
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.2m_cloud_functions_invocations")}</span>
                  </li>
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.28_instancehoursday_app_engine")}</span>
                  </li>
                  <li className="flex items-center gap-2">
                    <CheckCircle className="w-3 h-3 text-emerald-400" />
                    <span>{t("admin.cloud.180k_vcpusecondsmonth_cloud_run")}</span>
                  </li>
                </ul>
              </div>
            </div>
            
            <div className="mt-6 p-4 bg-emerald-500/10 rounded-2xl border border-emerald-500/20">
              <div className="flex items-center gap-3">
                <DollarSign className="w-5 h-5 text-emerald-400" />
                <div>
                  <p className="text-sm font-bold text-emerald-400">{t("admin.cloud.monthly_savings")}</p>
                  <p className="text-2xl font-bold text-emerald-400">$100-200+</p>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </PageShell>;
}