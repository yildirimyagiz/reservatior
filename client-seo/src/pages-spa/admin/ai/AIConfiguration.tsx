"use client";

import { t } from "i18next";
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
import { useTranslation } from "react-i18next";
import { useToast } from "@/hooks/use-toast";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { aiApi } from "@/lib/api/ai";
import { Brain, Cpu, Zap, Settings, Play, RefreshCw, Edit, Eye, Plus, MoreHorizontal, Activity, Database, Globe, BarChart3, FileText, TrendingUp, Clock, DollarSign, ArrowRight, Loader2 } from "lucide-react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";
import { Progress } from "@/components/ui/progress";
import { apiClient } from "@/lib/api";
interface AIModel {
  id: string;
  name: string;
  type: "TEXT_GENERATION" | "IMAGE_GENERATION" | "TRANSLATION" | "ANALYSIS" | "CLASSIFICATION";
  provider: "OPENAI" | "ANTHROPIC" | "GOOGLE" | "AZURE" | "HUGGING_FACE" | "CUSTOM";
  version: string;
  status: "ACTIVE" | "INACTIVE" | "TRAINING" | "ERROR";
  description: string;
  capabilities: string[];
  parameters: Record<string, any>;
  usage: {
    requests: number;
    tokens: number;
    cost: number;
    lastUsed?: string;
  };
  performance: {
    accuracy: number;
    latency: number;
    throughput: number;
  };
  createdAt: string;
  updatedAt: string;
  trainingData?: {
    samples: number;
    accuracy: number;
    loss: number;
  };
}
interface AIWorkflow {
  id: string;
  name: string;
  description: string;
  trigger: string;
  models: string[];
  status: "ACTIVE" | "INACTIVE" | "ERROR";
  executionCount: number;
  avgExecutionTime: number;
  successRate: number;
  lastExecuted: string;
  config: Record<string, any>;
  createdAt: string;
}
interface AIService {
  id: string;
  name: string;
  type: "API" | "WEBHOOK" | "SCHEDULED" | "STREAMING";
  endpoint: string;
  method: string;
  headers: Record<string, string>;
  authType: "NONE" | "API_KEY" | "OAUTH" | "BASIC";
  isActive: boolean;
  rateLimit: {
    requests: number;
    window: string;
  };
  lastHealthCheck: string;
  healthStatus: "HEALTHY" | "UNHEALTHY" | "DEGRADED";
}
const MOCK_MODELS: AIModel[] = [{
  id: "1",
  name: "GPT-4 Turbo",
  type: "TEXT_GENERATION",
  provider: "OPENAI",
  version: "4.0-turbo",
  status: "ACTIVE",
  description: t("admin_ai_highperformance_text_generation_model"),
  capabilities: ["text-generation", "summarization", "translation", "analysis"],
  parameters: {
    temperature: 0.7,
    maxTokens: 4096,
    topP: 0.9,
    frequencyPenalty: 0.0,
    presencePenalty: 0.0
  },
  usage: {
    requests: 15420,
    tokens: 2345678,
    cost: 1234.56,
    lastUsed: "2024-03-28T10:30:00Z"
  },
  performance: {
    accuracy: 94.5,
    latency: 1250,
    throughput: 850
  },
  createdAt: "2024-03-15",
  updatedAt: "2024-03-28"
}, {
  id: "2",
  name: "Claude 3 Opus",
  type: "TEXT_GENERATION",
  provider: "ANTHROPIC",
  version: "3.0-opus",
  status: "ACTIVE",
  description: t("admin_ai_advanced_reasoning_model_for"),
  capabilities: ["text-generation", "analysis", "reasoning", "coding"],
  parameters: {
    temperature: 0.5,
    maxTokens: 8192,
    topP: 0.95
  },
  usage: {
    requests: 8934,
    tokens: 1876543,
    cost: 987.23,
    lastUsed: "2024-03-28T09:45:00Z"
  },
  performance: {
    accuracy: 96.2,
    latency: 2100,
    throughput: 620
  },
  createdAt: "2024-03-20",
  updatedAt: "2024-03-27"
}, {
  id: "3",
  name: "Property Analysis Model",
  type: "ANALYSIS",
  provider: "CUSTOM",
  version: "1.2.0",
  status: "TRAINING",
  description: t("admin_ai_custom_trained_model_for"),
  capabilities: ["property-analysis", "price-prediction", "market-trends"],
  parameters: {
    confidence: 0.85,
    features: ["location", "size", "amenities", "market-data"]
  },
  usage: {
    requests: 0,
    tokens: 0,
    cost: 0,
    lastUsed: undefined
  },
  performance: {
    accuracy: 87.3,
    latency: 3400,
    throughput: 290
  },
  createdAt: "2024-03-10",
  updatedAt: "2024-03-28",
  trainingData: {
    samples: 50000,
    accuracy: 87.3,
    loss: 0.234
  }
}];
const MOCK_WORKFLOWS: AIWorkflow[] = [{
  id: "1",
  name: "Property Description Generator",
  description: t("admin_ai_generate_compelling_property_descriptions"),
  trigger: "property_created",
  models: ["1", "2"],
  status: "ACTIVE",
  executionCount: 1234,
  avgExecutionTime: 2.3,
  successRate: 98.5,
  lastExecuted: "2024-03-28T10:15:00Z",
  config: {
    maxLength: 500,
    tone: "professional",
    includeFeatures: true
  },
  createdAt: "2024-03-15"
}, {
  id: "2",
  name: "Lead Scoring",
  description: t("admin_ai_score_and_prioritize_leads"),
  trigger: "lead_created",
  models: ["3"],
  status: "ACTIVE",
  executionCount: 3456,
  avgExecutionTime: 1.8,
  successRate: 99.2,
  lastExecuted: "2024-03-28T09:30:00Z",
  config: {
    scoreThreshold: 0.7,
    factors: ["budget", "timeline", "location", "source"]
  },
  createdAt: "2024-03-10"
}];
const MOCK_SERVICES: AIService[] = [{
  id: "1",
  name: "OpenAI API",
  type: "API",
  endpoint: "https://api.openai.com/v1",
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  authType: "API_KEY",
  isActive: true,
  rateLimit: {
    requests: 3500,
    window: "1m"
  },
  lastHealthCheck: "2024-03-28T10:30:00Z",
  healthStatus: "HEALTHY"
}, {
  id: "2",
  name: "Anthropic Claude API",
  type: "API",
  endpoint: "https://api.anthropic.com/v1",
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    "anthropic-version": "2023-06-01"
  },
  authType: "API_KEY",
  isActive: true,
  rateLimit: {
    requests: 1000,
    window: "1m"
  },
  lastHealthCheck: "2024-03-28T10:29:00Z",
  healthStatus: "HEALTHY"
}];
export default function AIConfiguration() {
  const {
    t
  } = useTranslation();
  const {
    toast
  } = useToast();
  const queryClient = useQueryClient();
  const deleteMutation = useMutation({
    mutationFn: async (id: string) => apiClient.delete(`/unknown/${id}`),
    onSuccess: () => {
      toast({ title: "Deleted", description: "Record deleted successfully" });
      queryClient.invalidateQueries();
    },
    onError: (err: any) => toast({ title: "Error", description: err.message, variant: "destructive" })
  });
  

  const [workflows, setWorkflows] = useState<AIWorkflow[]>(MOCK_WORKFLOWS);
  const [services, setServices] = useState<AIService[]>(MOCK_SERVICES);
  const [activeTab, setActiveTab] = useState("models");
  const [modelDialogOpen, setModelDialogOpen] = useState(false);

  const { data: modelsData, isLoading: loadingModels } = useQuery({
    queryKey: ['aiModels'],
    queryFn: async () => {
      const res = await aiApi.getModels();
      const apiModels = Array.isArray(res) ? res : ((res as any).data || []);
      
      return apiModels.map((m: any) => ({
        id: m.id,
        name: m.modelName || m.name || "Unknown Model",
        type: m.modelType || m.type || "TEXT_GENERATION",
        provider: m.provider || "CUSTOM",
        version: m.modelVersion || m.version || "1.0",
        status: m.status || "ACTIVE",
        description: m.description || m.metadata?.description || "No description provided",
        capabilities: m.capabilities || m.metadata?.capabilities || ["text-generation"],
        parameters: m.config?.parameters || m.parameters || {},
        usage: m.usage || { requests: 0, tokens: 0, cost: 0, lastUsed: m.updatedAt },
        performance: m.performance || { accuracy: m.accuracy || 90, latency: 1000, throughput: 500 },
        createdAt: m.createdAt || new Date().toISOString(),
        updatedAt: m.updatedAt || new Date().toISOString(),
        trainingData: m.trainingData || undefined
      })) as AIModel[];
    }
  });

  const models = modelsData || MOCK_MODELS;

  const updateModelMutation = useMutation({
    mutationFn: async ({ id, data }: { id: string, data: any }) => {
      return await aiApi.updateModel(id, data);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['aiModels'] });
    },
    onError: (error: any) => {
      toast({
        title: t("admin_ai_error"),
        description: error.message,
        variant: "destructive"
      });
    }
  });
  const getModelIcon = (type: string) => {
    switch (type) {
      case "TEXT_GENERATION":
        return <FileText className="w-4 h-4" />;
      case "IMAGE_GENERATION":
        return <Brain className="w-4 h-4" />;
      case "TRANSLATION":
        return <Globe className="w-4 h-4" />;
      case "ANALYSIS":
        return <BarChart3 className="w-4 h-4" />;
      case "CLASSIFICATION":
        return <Database className="w-4 h-4" />;
      default:
        return <Cpu className="w-4 h-4" />;
    }
  };
  const getStatusColor = (status: string) => {
    switch (status) {
      case "ACTIVE":
      case "HEALTHY":
        return "bg-emerald-500/10 text-emerald-400 border-none";
      case "INACTIVE":
        return "bg-slate-500/10 text-muted-foreground border-none";
      case "TRAINING":
        return "bg-slate-500/10 text-slate-500 dark:text-slate-400 border-none";
      case "ERROR":
      case "UNHEALTHY":
        return "bg-red-500/10 text-red-500 border-none";
      case "DEGRADED":
        return "bg-orange-500/10 text-orange-400 border-none";
      default:
        return "bg-slate-500/10 text-muted-foreground border-none";
    }
  };
  const getProviderIcon = (provider: string) => {
    switch (provider) {
      case "OPENAI":
        return <Brain className="w-4 h-4 text-green-600" />;
      case "ANTHROPIC":
        return <Brain className="w-4 h-4 text-slate-600" />;
      case "GOOGLE":
        return <Brain className="w-4 h-4 text-slate-600" />;
      case "AZURE":
        return <Brain className="w-4 h-4 text-orange-600" />;
      case "HUGGING_FACE":
        return <Brain className="w-4 h-4 text-yellow-600" />;
      case "CUSTOM":
        return <Cpu className="w-4 h-4 text-slate-500 dark:text-slate-400" />;
      default:
        return <Brain className="w-4 h-4 text-slate-500 dark:text-slate-400" />;
    }
  };
  const toggleModel = (model: AIModel) => {
    updateModelMutation.mutate({
      id: model.id,
      data: { status: model.status === "ACTIVE" ? "INACTIVE" : "ACTIVE" }
    });
    toast({
      title: t("admin_ai_model_updated"),
      description: t("admin_ai_model_status_has_been")
    });
  };
  const toggleWorkflow = (workflowId: string) => {
    setWorkflows(workflows.map(w => w.id === workflowId ? {
      ...w,
      status: w.status === "ACTIVE" ? "INACTIVE" : "ACTIVE" as any
    } : w));
    toast({
      title: t("admin_ai_workflow_updated"),
      description: t("admin_ai_workflow_status_has_been")
    });
  };
  const toggleService = (serviceId: string) => {
    setServices(services.map(s => s.id === serviceId ? {
      ...s,
      isActive: !s.isActive
    } : s));
    toast({
      title: t("admin_ai_service_updated"),
      description: t("admin_ai_service_status_has_been")
    });
  };
  const testModel = (model: AIModel) => {
    toast({
      title: t("admin_ai_test_started"),
      description: `Testing ${model.name}...`
    });
  };
  const trainModel = (modelId: string) => {
    updateModelMutation.mutate({
      id: modelId,
      data: { status: "TRAINING" }
    });
    toast({
      title: t("admin_ai_training_started"),
      description: t("admin_ai_model_training_has_been")
    });
  };
  const stats = {
    totalModels: models.length,
    activeModels: models.filter(m => m.status === "ACTIVE").length,
    trainingModels: models.filter(m => m.status === "TRAINING").length,
    totalWorkflows: workflows.length,
    activeWorkflows: workflows.filter(w => w.status === "ACTIVE").length,
    totalServices: services.length,
    activeServices: services.filter(s => s.isActive).length,
    totalTokens: models.reduce((sum, m) => sum + m.usage.tokens, 0),
    totalCost: models.reduce((sum, m) => sum + m.usage.cost, 0)
  };
  return <PageShell title={t('admin_ai_title')} description={t('admin_ai_description')}>
      <div className="space-y-10 pb-20 selection:bg-primary/30">
        {/* Stats Cards - Neural Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.1
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l border-t">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
                <Brain className="w-12 h-12" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('activeModels')}</p>
                <h3 className="text-xl font-bold text-foreground leading-none">{stats.activeModels}</h3>
                <p className="text-[10px] font-bold text-muted-foreground mt-4 flex items-center gap-1">{t("admin_ai_of")}{stats.totalModels}{t("admin_ai_total")}</p>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.2
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-slate-500/30 border-l border-t">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-slate-500">
                <Zap className="w-12 h-12" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('activeWorkflows')}</p>
                <h3 className="text-xl font-bold text-foreground leading-none">{stats.activeWorkflows}</h3>
                <p className="text-[10px] font-bold text-muted-foreground mt-4 flex items-center gap-1">{t("admin_ai_of")}{stats.totalWorkflows}{t("admin_ai_total")}</p>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.3
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-orange-500/30 border-l border-t">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-orange-500">
                <Cpu className="w-12 h-12" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('tokensUsed')}</p>
                <h3 className="text-xl font-bold text-foreground leading-none">{stats.totalTokens.toLocaleString()}</h3>
                <p className="text-[10px] font-bold text-orange-400 mt-4 flex items-center gap-1">
                  <Activity className="w-3 h-3" />{t("admin_ai_alltimesync")}</p>
              </CardContent>
            </Card>
          </motion.div>

          <motion.div initial={{
          opacity: 0,
          y: 20
        }} animate={{
          opacity: 1,
          y: 0
        }} transition={{
          delay: 0.4
        }}>
            <Card className="bg-card border-border rounded-3xl overflow-hidden shadow-2xl relative group border-l-red-500/30 border-l border-t">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-all text-red-500">
                <DollarSign className="w-12 h-12" />
              </div>
              <CardContent className="p-8">
                <p className="text-[10px] font-bold text-muted-foreground mb-1">{t('totalCost')}</p>
                <h3 className="text-xl font-bold text-foreground leading-none">${stats.totalCost.toFixed(2)}</h3>
                <p className="text-[10px] font-bold text-red-400 mt-4 flex items-center gap-1">
                  <TrendingUp className="w-3 h-3" />{t("admin_ai_monthlyburn")}</p>
              </CardContent>
            </Card>
          </motion.div>
        </div>

        {/* Neural Hub Tabs */}
        <Card className="bg-card backdrop-blur-xl border-border rounded-4xl overflow-hidden shadow-2xl border-l border-t relative">
          <Tabs value={activeTab} onValueChange={setActiveTab}>
            <div className="flex items-center justify-between px-8 py-6 border-b border-border">
              <TabsList className="bg-muted/50 p-1 rounded-2xl h-12 border border-border">
                <TabsTrigger value="models" className="rounded-xl px-6 text-[10px] font-bold data-[state=active]:bg-primary data-[state=active]:text-foreground">{t('models')}</TabsTrigger>
                <TabsTrigger value="workflows" className="rounded-xl px-6 text-[10px] font-bold data-[state=active]:bg-primary data-[state=active]:text-foreground">{t('workflows')}</TabsTrigger>
                <TabsTrigger value="services" className="rounded-xl px-6 text-[10px] font-bold data-[state=active]:bg-primary data-[state=active]:text-foreground">{t('services')}</TabsTrigger>
                <TabsTrigger value="monitoring" className="rounded-xl px-6 text-[10px] font-bold data-[state=active]:bg-primary data-[state=active]:text-foreground">{t('monitoring')}</TabsTrigger>
              </TabsList>
            </div>

            <TabsContent value="models" className="p-8 space-y-8 mt-0">
              <div className="flex justify-between items-center">
                <h3 className="text-2xl font-bold text-foreground">{t('admin_ai_models_title')}</h3>
                <Button onClick={() => setModelDialogOpen(true)} className="bg-primary hover:bg-primary/90 text-foreground font-bold rounded-2xl text-[10px] h-12 px-8 shadow-xl shadow-primary/20">
                  <Plus className="w-4 h-4 mr-2" />
                  {t('addModel')}
                </Button>
              </div>

              <div className="grid grid-cols-1 gap-6">
              {loadingModels ? (
                <div className="flex items-center justify-center py-12 text-muted-foreground">
                   <Loader2 className="w-8 h-8 animate-spin mx-auto mb-2" />
                </div>
              ) : models.map(model => <Card key={model.id} className="bg-muted/50 border-border rounded-3xl group hover:bg-muted/50 transition-all border-l border-t shadow-xl">
                  <CardContent className="p-8">
                    <div className="flex items-start justify-between">
                      <div className="flex-1 space-y-4">
                        <div className="flex items-center gap-4">
                          <div className="w-12 h-12 rounded-2xl bg-[#14151a] flex items-center justify-center text-primary border border-border">
                            {getModelIcon(model.type)}
                          </div>
                          <div>
                            <h4 className="text-xl font-bold text-foreground">{model.name}</h4>
                            <div className="flex items-center gap-3 mt-1">
                              <span className="text-[10px] font-bold text-muted-foreground flex items-center gap-1">
                                {getProviderIcon(model.provider)} {model.provider} <span className="opacity-50">v{model.version}</span>
                              </span>
                              <Badge className={cn("text-[9px] font-bold   px-3 py-0.5 rounded-full ", getStatusColor(model.status))}>
                                {model.status}
                              </Badge>
                            </div>
                          </div>
                        </div>
                        
                        <p className="text-xs text-muted-foreground font-medium leading-relaxed max-w-2xl">{model.description}</p>
                        
                        <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
                          <div>
                            <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('admin_ai_models_requests')}</p>
                            <p className="text-lg font-bold text-foreground leading-none">{model.usage.requests.toLocaleString()}</p>
                          </div>
                          <div>
                            <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('admin_ai_models_tokens')}</p>
                            <p className="text-lg font-bold text-foreground leading-none">{model.usage.tokens.toLocaleString()}</p>
                          </div>
                          <div>
                            <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('admin_ai_models_accuracy')}</p>
                            <p className="text-lg font-bold text-foreground leading-none">{model.performance.accuracy}%</p>
                          </div>
                          <div>
                            <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('admin_ai_models_latency')}</p>
                            <p className="text-lg font-bold text-foreground leading-none">{model.performance.latency}{t("admin_ai_ms")}</p>
                          </div>
                        </div>

                        {model.trainingData && <div className="p-6 bg-card rounded-2xl border border-border space-y-4">
                            <div className="flex items-center justify-between">
                                <span className="text-[10px] font-bold text-slate-500 dark:text-slate-400">{t('trainingProgress')}</span>
                                <span className="text-xs font-bold text-foreground">{model.trainingData.accuracy}%</span>
                            </div>
                            <Progress value={model.trainingData.accuracy} className="h-1.5 bg-muted/50" indicatorClassName="bg-slate-500 shadow-[0_0_10px_#3b82f6]" />
                          </div>}
                      </div>
                      
                      <div className="flex items-center gap-4">
                        <Switch checked={model.status === "ACTIVE"} onCheckedChange={() => toggleModel(model)} className="data-[state=checked]:bg-emerald-500" />
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="ghost" size="icon" className="h-10 w-10 text-muted-foreground hover:text-foreground hover:bg-muted/50 rounded-xl transition-all">
                              <MoreHorizontal className="w-5 h-5" />
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="bg-[#14151a] border-border rounded-2xl shadow-2xl p-2 min-w-[180px]">
                            <DropdownMenuItem onClick={() => testModel(model)} className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
                              <Play className="w-4 h-4 mr-3 text-emerald-500" /> {t('testModel')}
                            </DropdownMenuItem>
                            {model.provider === "CUSTOM" && <DropdownMenuItem onClick={() => trainModel(model.id)} className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
                                <RefreshCw className="w-4 h-4 mr-3 text-slate-500 dark:text-slate-400" /> {t('retrain')}
                              </DropdownMenuItem>}
                            <DropdownMenuItem className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
                              <Settings className="w-4 h-4 mr-3 text-muted-foreground" /> {t('admin_ai_models_configure')}
                            </DropdownMenuItem>
                            <DropdownMenuItem className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
                              <Eye className="w-4 h-4 mr-3 text-slate-500 dark:text-slate-400" /> {t('viewDetails')}
                            </DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      </div>
                    </div>
                  </CardContent>
                </Card>)}
            </div>
            </TabsContent>

            <TabsContent value="workflows" className="p-8 space-y-8">
              <div className="flex justify-between items-center">
                <h3 className="text-2xl font-bold text-foreground">{t('admin_ai_workflows_title')}</h3>
                <Button className="bg-primary hover:bg-primary/90 text-foreground font-bold rounded-2xl text-[10px] h-12 px-8 shadow-xl shadow-primary/20">
                  <Plus className="w-4 h-4 mr-2" />
                  {t('admin_ai_workflows_create')}
                </Button>
              </div>

              <div className="grid grid-cols-1 gap-6">
                {workflows.map(workflow => <Card key={workflow.id} className="bg-muted/50 border-border rounded-3xl group hover:bg-muted/50 transition-all border-l border-t shadow-xl">
                    <CardContent className="p-8">
                      <div className="flex items-start justify-between">
                        <div className="flex-1 space-y-4">
                          <div className="flex items-center gap-4">
                            <div className="w-12 h-12 rounded-2xl bg-[#14151a] flex items-center justify-center text-primary border border-border">
                              <Zap className="w-6 h-6" />
                            </div>
                            <div>
                                <h4 className="text-xl font-bold text-foreground">{workflow.name}</h4>
                                <div className="flex items-center gap-3 mt-1">
                                  <Badge variant="outline" className="text-[9px] font-bold px-3 py-0.5 rounded-full border-border bg-muted/50 text-muted-foreground">
                                    {workflow.trigger}
                                  </Badge>
                                  <Badge className={cn("text-[9px] font-bold   px-3 py-0.5 rounded-full ", getStatusColor(workflow.status))}>
                                    {workflow.status}
                                  </Badge>
                                </div>
                            </div>
                          </div>
                          
                          <p className="text-xs text-muted-foreground font-medium leading-relaxed max-w-2xl">{workflow.description}</p>
                          
                          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
                            <div>
                              <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('executions')}</p>
                              <p className="text-lg font-bold text-foreground leading-none">{workflow.executionCount.toLocaleString()}</p>
                            </div>
                            <div>
                              <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('admin_ai_workflows_avgTime')}</p>
                              <p className="text-lg font-bold text-foreground leading-none">{workflow.avgExecutionTime}s</p>
                            </div>
                            <div>
                              <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('successRate')}</p>
                              <p className="text-lg font-bold text-foreground leading-none">{workflow.successRate}%</p>
                            </div>
                            <div>
                              <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('lastRun')}</p>
                              <p className="text-lg font-bold text-foreground leading-none">{new Date(workflow.lastExecuted).toLocaleDateString()}</p>
                            </div>
                          </div>
                        </div>
                        
                        <div className="flex items-center gap-4">
                          <Switch checked={workflow.status === "ACTIVE"} onCheckedChange={() => toggleWorkflow(workflow.id)} className="data-[state=checked]:bg-emerald-500" />
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                                <Button variant="ghost" size="icon" className="h-10 w-10 text-muted-foreground hover:text-foreground hover:bg-muted/50 rounded-xl transition-all">
                                  <MoreHorizontal className="w-5 h-5" />
                                </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent align="end" className="bg-[#14151a] border-border rounded-2xl shadow-2xl p-2 min-w-[180px]">
                              <DropdownMenuItem className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
                                <Play className="w-4 h-4 mr-3 text-emerald-500" /> {t('runNow')}
                              </DropdownMenuItem>
                              <DropdownMenuItem className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
                                <Edit className="w-4 h-4 mr-3 text-slate-500 dark:text-slate-400" /> {t('edit')}
                              </DropdownMenuItem>
                              <DropdownMenuItem className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
                                <Eye className="w-4 h-4 mr-3 text-slate-500 dark:text-slate-400" /> {t('viewLogs')}
                              </DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </div>
                      </div>
                    </CardContent>
                  </Card>)}
              </div>
            </TabsContent>

            <TabsContent value="services" className="p-8 space-y-8">
              <div className="flex justify-between items-center">
                <h3 className="text-2xl font-bold text-foreground">{t('admin_ai_services_title')}</h3>
                <Button className="bg-primary hover:bg-primary/90 text-foreground font-bold rounded-2xl text-[10px] h-12 px-8 shadow-xl shadow-primary/20">
                  <Plus className="w-4 h-4 mr-2" />
                  {t('admin_ai_services_add')}
                </Button>
              </div>

              <div className="grid grid-cols-1 gap-6">
                {services.map(service => <Card key={service.id} className="bg-muted/50 border-border rounded-3xl group hover:bg-muted/50 transition-all border-l border-t shadow-xl">
                    <CardContent className="p-8">
                      <div className="flex items-start justify-between">
                        <div className="flex-1 space-y-4">
                          <div className="flex items-center gap-4">
                            <div className="w-12 h-12 rounded-2xl bg-[#14151a] flex items-center justify-center text-primary border border-border">
                              <Globe className="w-6 h-6" />
                            </div>
                            <div>
                                <h4 className="text-xl font-bold text-foreground">{service.name}</h4>
                                <div className="flex items-center gap-3 mt-1">
                                  <Badge variant="outline" className="text-[9px] font-bold px-3 py-0.5 rounded-full border-border bg-muted/50 text-muted-foreground">{service.type}</Badge>
                                  <Badge variant="outline" className="text-[9px] font-bold px-3 py-0.5 rounded-full border-border bg-muted/50 text-muted-foreground">{service.method}</Badge>
                                  <Badge className={cn("text-[9px] font-bold   px-3 py-0.5 rounded-full ", getStatusColor(service.healthStatus))}>
                                    {service.healthStatus}
                                  </Badge>
                                </div>
                            </div>
                          </div>
                          
                          <div className="text-xs text-muted-foreground font-mono bg-card p-3 rounded-xl border border-border max-w-fit">
                            {service.endpoint}
                          </div>
                          
                          <div className="grid grid-cols-2 md:grid-cols-3 gap-8">
                            <div>
                              <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('authType')}</p>
                              <p className="text-lg font-bold text-foreground leading-none">{service.authType}</p>
                            </div>
                            <div>
                              <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('rateLimit')}</p>
                              <p className="text-lg font-bold text-foreground leading-none">
                                {service.rateLimit.requests}/{service.rateLimit.window}
                              </p>
                            </div>
                            <div>
                              <p className="text-[9px] font-bold text-muted-foreground mb-1">{t('lastCheck')}</p>
                              <p className="text-lg font-bold text-foreground leading-none">
                                {new Date(service.lastHealthCheck).toLocaleTimeString()}
                              </p>
                            </div>
                          </div>
                        </div>
                        
                        <div className="flex items-center gap-4">
                          <Switch checked={service.isActive} onCheckedChange={() => toggleService(service.id)} className="data-[state=checked]:bg-emerald-500" />
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                                <Button variant="ghost" size="icon" className="h-10 w-10 text-muted-foreground hover:text-foreground hover:bg-muted/50 rounded-xl transition-all">
                                  <MoreHorizontal className="w-5 h-5" />
                                </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent align="end" className="bg-[#14151a] border-border rounded-2xl shadow-2xl p-2 min-w-[180px]">
                              <DropdownMenuItem className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
                                <RefreshCw className="w-4 h-4 mr-3 text-slate-500 dark:text-slate-400" /> {t('test')}
                              </DropdownMenuItem>
                              <DropdownMenuItem className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
                                <Edit className="w-4 h-4 mr-3 text-orange-500" /> {t('edit')}
                              </DropdownMenuItem>
                              <DropdownMenuItem className="rounded-xl px-4 py-3 text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer">
                                <Eye className="w-4 h-4 mr-3 text-slate-500 dark:text-slate-400" /> {t('viewLogs')}
                              </DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </div>
                      </div>
                    </CardContent>
                  </Card>)}
              </div>
            </TabsContent>

            <TabsContent value="monitoring" className="p-8 space-y-8">
              <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                <Card className="bg-muted/50 border-border rounded-3xl border-l border-t shadow-xl">
                  <CardHeader className="p-8 border-b border-border">
                    <CardTitle className="text-xl font-bold text-foreground tracking-[0.2em]">{t('monitoring')}</CardTitle>
                    <CardDescription className="text-[10px] font-bold text-muted-foreground">{t("admin_ai_realtime_performance_metrics")}</CardDescription>
                  </CardHeader>
                  <CardContent className="p-8">
                    <div className="space-y-6">
                      {models.filter(m => m.status === "ACTIVE").map(model => <div key={model.id} className="p-6 bg-card rounded-2xl border border-border space-y-4 group hover:bg-card transition-all">
                          <div className="flex items-center justify-between">
                            <span className="text-sm font-bold text-foreground tracking-tight">{model.name}</span>
                            <Badge className={cn("text-[8px] font-bold  tracking-[0.2em] px-3 py-0.5 rounded-full ", getStatusColor(model.status))}>
                              {model.status}
                            </Badge>
                          </div>
                          <div className="grid grid-cols-2 gap-4">
                            <div className="space-y-2">
                              <div className="flex justify-between text-[10px] font-bold text-muted-foreground">
                                <span>{t("admin_ai_accuracy")}</span>
                                <span className={cn(model.performance.accuracy > 90 ? 'text-emerald-400' : 'text-amber-400')}>{model.performance.accuracy}%</span>
                              </div>
                              <Progress value={model.performance.accuracy} className="h-1 bg-muted/50" indicatorClassName={cn(model.performance.accuracy > 90 ? 'bg-emerald-500 shadow-[0_0_8px_#10b981]' : 'bg-amber-500')} />
                            </div>
                            <div className="space-y-2">
                              <div className="flex justify-between text-[10px] font-bold text-muted-foreground">
                                <span>{t("admin_ai_latency")}</span>
                                <span className="text-slate-500 dark:text-slate-400">{model.performance.latency}{t("admin_ai_ms")}</span>
                              </div>
                              <Progress value={(1 - model.performance.latency / 4000) * 100} className="h-1 bg-muted/50" indicatorClassName="bg-slate-500 shadow-[0_0_8px_#8b5cf6]" />
                            </div>
                          </div>
                        </div>)}
                    </div>
                  </CardContent>
                </Card>

                <Card className="bg-muted/50 border-border rounded-3xl border-l border-t shadow-xl">
                  <CardHeader className="p-8 border-b border-border">
                    <CardTitle className="text-xl font-bold text-foreground tracking-[0.2em]">{t("admin_ai_cost_analysis")}</CardTitle>
                    <CardDescription className="text-[10px] font-bold text-muted-foreground">{t("admin_ai_ai_service_cost_breakdown")}</CardDescription>
                  </CardHeader>
                  <CardContent className="p-8">
                    <div className="space-y-6">
                      {models.map(model => <div key={model.id} className="flex items-center justify-between p-6 bg-card rounded-2xl border border-border hover:bg-card transition-all">
                          <div className="space-y-1">
                            <div className="text-sm font-bold text-foreground tracking-tight">{model.name}</div>
                            <div className="text-[10px] font-bold text-muted-foreground">
                              {model.usage.tokens.toLocaleString()}{t("admin_ai_tokensconsumed")}</div>
                          </div>
                          <div className="text-xl font-bold text-emerald-400">
                            ${model.usage.cost.toFixed(2)}
                          </div>
                        </div>)}
                    </div>
                  </CardContent>
                </Card>
              </div>
            </TabsContent>
          </Tabs>
        </Card>
      </div>

      {/* Add Model Dialog - Neural Themed */}
      <Dialog open={modelDialogOpen} onOpenChange={setModelDialogOpen}>
        <DialogContent className="bg-[#14151a] border-border rounded-3xl shadow-2xl p-8 max-w-2xl overflow-hidden">
          <div className="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-primary via-transparent to-transparent opacity-30"></div>
          <DialogHeader>
            <DialogTitle className="text-3xl font-bold text-foreground">{t('addModel')}</DialogTitle>
            <DialogDescription className="text-[10px] font-bold text-muted-foreground">{t("admin_ai_register_a_new_neural")}</DialogDescription>
          </DialogHeader>
          <div className="grid grid-cols-2 gap-8 py-8">
             <div className="space-y-4">
                <Label className="text-[10px] font-bold text-muted-foreground">{t("admin_ai_node_name")}</Label>
                <Input placeholder={t("admin_ai_gpt4x_neural_engine")} className="h-12 bg-muted/50 border-border rounded-xl px-4 text-foreground placeholder:text-slate-600 font-bold text-[10px]" />
             </div>
             <div className="space-y-4">
                <Label className="text-[10px] font-bold text-muted-foreground">{t("admin_ai_provider_atlas")}</Label>
                <Select>
                  <SelectTrigger className="h-12 bg-muted/50 border-border rounded-xl px-4 text-foreground font-bold text-[10px]">
                    <SelectValue placeholder={t("admin_ai_selectprovider")} />
                  </SelectTrigger>
                  <SelectContent className="bg-[#14151a] border-border rounded-xl">
                    <SelectItem value="OPENAI" className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground">{t("admin_ai_openaicore")}</SelectItem>
                    <SelectItem value="ANTHROPIC" className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground">{t("admin_ai_anthropicpulse")}</SelectItem>
                    <SelectItem value="GOOGLE" className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground">{t("admin_ai_googlevertex")}</SelectItem>
                    <SelectItem value="AZURE" className="text-[10px] font-bold focus:bg-muted/50 focus:text-foreground">{t("admin_ai_azurecloud")}</SelectItem>
                  </SelectContent>
                </Select>
             </div>
             <div className="col-span-2 space-y-4">
                <Label className="text-[10px] font-bold text-muted-foreground">{t("admin_ai_operational_logic_description")}</Label>
                <Textarea placeholder={t("admin_ai_define_the_primary_focus")} className="bg-muted/50 border-border rounded-xl p-4 text-foreground placeholder:text-slate-600 min-h-[100px] font-bold text-[10px]" />
             </div>
          </div>
          <DialogFooter className="pt-4 gap-4">
            <Button variant="ghost" className="h-14 px-8 rounded-2xl text-[10px] font-bold text-muted-foreground hover:text-foreground" onClick={() => setModelDialogOpen(false)}>{t("admin_ai_terminateinit")}</Button>
            <Button className="h-14 px-10 rounded-2xl bg-primary hover:bg-primary/90 text-foreground font-bold text-[10px] shadow-xl shadow-primary/20">{t("admin_ai_executedeployment")}</Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </PageShell>;
}