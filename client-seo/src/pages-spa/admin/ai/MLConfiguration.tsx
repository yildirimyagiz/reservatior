"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState, useEffect } from "react";
import { PageShell } from "@/pages-spa/client/layout/PageShell";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { MoreHorizontal, Plus, Search, Filter, Brain, Cpu, Zap, Settings, Play, Trash2, Eye, Edit, BarChart, Download, Upload } from "lucide-react";
import { Input } from "@/components/ui/input";
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { Textarea } from "@/components/ui/textarea";
import { Switch } from "@/components/ui/switch";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";

// Type definitions
interface MLModel {
  id: string;
  orgId: string;
  name: string;
  type: MLModelType;
  version: string;
  description?: string;
  config: {
    algorithm: string;
    parameters: Record<string, any>;
    features: string[];
    hyperparameters: Record<string, any>;
  };
  performance?: {
    accuracy?: number;
    precision?: number;
    recall?: number;
    f1Score?: number;
    mse?: number;
    rmse?: number;
  };
  trainingData?: {
    datasetSize: number;
    trainingDate: string;
    validationSplit: number;
  };
  isActive: boolean;
  isDeployed: boolean;
  endpoint?: string;
  lastTrainedAt?: string;
  createdAt: string;
  updatedAt: string;
}
interface MLConfiguration {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  modelId: string;
  config: {
    predictionThreshold: number;
    batchSize: number;
    maxRetries: number;
    timeout: number;
    environment: "development" | "staging" | "production";
    logging: boolean;
    monitoring: boolean;
  };
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
  model?: MLModel;
}
enum MLModelType {
  PREDICTIVE_ANALYTICS = "PREDICTIVE_ANALYTICS",
  CLASSIFICATION = "CLASSIFICATION",
  REGRESSION = "REGRESSION",
  CLUSTERING = "CLUSTERING",
  NATURAL_LANGUAGE_PROCESSING = "NATURAL_LANGUAGE_PROCESSING",
  COMPUTER_VISION = "COMPUTER_VISION",
  RECOMMENDATION = "RECOMMENDATION",
  ANOMALY_DETECTION = "ANOMALY_DETECTION",
  TIME_SERIES = "TIME_SERIES",
  SENTIMENT_ANALYSIS = "SENTIMENT_ANALYSIS",
}
export default function MLConfiguration() {
  const {
    t
  } = useTranslation();
  const [activeTab, setActiveTab] = useState<"models" | "configurations">("models");
  const [searchTerm, setSearchTerm] = useState("");
  const [filterType, setFilterType] = useState("all");
  const [filterStatus, setFilterStatus] = useState("all");
  const [isModelDialogOpen, setIsModelDialogOpen] = useState(false);
  const [isConfigDialogOpen, setIsConfigDialogOpen] = useState(false);
  const [models, setModels] = useState<MLModel[]>([]);
  const [configurations, setConfigurations] = useState<MLConfiguration[]>([]);
  const [loading, setLoading] = useState(true);
  const {
    toast
  } = useToast();

  // Fetch data from API
  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const [modelsRes, configsRes] = await Promise.all([apiClient.get('/ml-models'), apiClient.get('/ml-configurations')]);
        setModels((modelsRes as any).data || []);
        setConfigurations((configsRes as any).data || []);
      } catch (error) {
        console.error('Error fetching ML data:', error);
        toast({
          title: t("admin_ai_error"),
          description: t("admin_ai_failed_to_load_ml"),
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, []);
  const filteredModels = models.filter(model => {
    const matchesSearch = model.name.toLowerCase().includes(searchTerm.toLowerCase()) || model.description?.toLowerCase().includes(searchTerm.toLowerCase()) || model.type.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesType = filterType === "all" || model.type === filterType;
    const matchesStatus = filterStatus === "all" || filterStatus === "active" && model.isActive || filterStatus === "inactive" && !model.isActive || filterStatus === "deployed" && model.isDeployed;
    return matchesSearch && matchesType && matchesStatus;
  });
  const filteredConfigs = configurations.filter(config => {
    const matchesSearch = config.name.toLowerCase().includes(searchTerm.toLowerCase()) || config.description?.toLowerCase().includes(searchTerm.toLowerCase()) || config.model?.name.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = filterStatus === "all" || filterStatus === "active" && config.isActive || filterStatus === "inactive" && !config.isActive;
    return matchesSearch && matchesStatus;
  });
  const totalModels = filteredModels.length;
  const activeModels = filteredModels.filter(m => m.isActive).length;
  const deployedModels = filteredModels.filter(m => m.isDeployed).length;
  const totalConfigs = filteredConfigs.length;
  const activeConfigs = filteredConfigs.filter(c => c.isActive).length;
  const handleCreateModel = async (data: any) => {
    try {
      await apiClient.post('/ml-models', data);
      setIsModelDialogOpen(false);
      toast({
        title: t("admin_ai_model_created"),
        description: t("admin_ai_ml_model_has_been")
      });
      // Refresh data
      const response = await apiClient.get('/ml-models');
      setModels((response as any).data || []);
    } catch (error) {
      console.error('Error creating model:', error);
      toast({
        title: t("admin_ai_error"),
        description: t("admin_ai_failed_to_create_ml"),
        variant: "destructive"
      });
    }
  };
  const handleCreateConfiguration = async (data: any) => {
    try {
      await apiClient.post('/ml-configurations', data);
      setIsConfigDialogOpen(false);
      toast({
        title: t("admin_ai_configuration_created"),
        description: t("admin_ai_ml_configuration_has_been")
      });
      // Refresh data
      const response = await apiClient.get('/ml-configurations');
      setConfigurations((response as any).data || []);
    } catch (error) {
      console.error('Error creating configuration:', error);
      toast({
        title: t("admin_ai_error"),
        description: t("admin_ai_failed_to_create_ml"),
        variant: "destructive"
      });
    }
  };
  const handleToggleModel = async (id: string, isActive: boolean) => {
    try {
      await apiClient.patch(`/ml-models/${id}`, {
        isActive
      });
      setModels(models.map(m => m.id === id ? {
        ...m,
        isActive
      } : m));
    } catch (error) {
      console.error('Error toggling model:', error);
    }
  };
  const handleDeployModel = async (id: string, isDeployed: boolean) => {
    try {
      await apiClient.patch(`/ml-models/${id}`, {
        isDeployed
      });
      setModels(models.map(m => m.id === id ? {
        ...m,
        isDeployed
      } : m));
      toast({
        title: isDeployed ? "Model Deployed" : "Model Undeployed",
        description: `Model has been ${isDeployed ? "deployed" : "undeployed"} successfully.`
      });
    } catch (error) {
      console.error('Error deploying model:', error);
    }
  };
  const handleTrainModel = async (id: string) => {
    try {
      await apiClient.post(`/ml-models/${id}/train`);
      toast({
        title: t("admin_ai_training_started"),
        description: t("admin_ai_model_training_has_been")
      });
    } catch (error) {
      console.error('Error training model:', error);
    }
  };
  const handleDeleteModel = async (id: string) => {
    try {
      await apiClient.delete(`/ml-models/${id}`);
      setModels(models.filter(m => m.id !== id));
      toast({
        title: t("admin_ai_model_deleted"),
        description: t("admin_ai_ml_model_has_been")
      });
    } catch (error) {
      console.error('Error deleting model:', error);
    }
  };
  const getModelTypeColor = (type: MLModelType) => {
    switch (type) {
      case "PREDICTIVE_ANALYTICS":
        return "default";
      case "CLASSIFICATION":
        return "outline";
      case "REGRESSION":
        return "secondary";
      case "CLUSTERING":
        return "outline";
      case "NATURAL_LANGUAGE_PROCESSING":
        return "destructive";
      case "COMPUTER_VISION":
        return "destructive";
      case "RECOMMENDATION":
        return "default";
      case "ANOMALY_DETECTION":
        return "outline";
      case "TIME_SERIES":
        return "secondary";
      case "SENTIMENT_ANALYSIS":
        return "default";
      default:
        return "secondary";
    }
  };
  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString();
  };
  const formatRelativeTime = (dateString: string) => {
    const date = new Date(dateString);
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
    if (diffDays === 0) return "Today";
    if (diffDays === 1) return "Yesterday";
    if (diffDays < 7) return `${diffDays} days ago`;
    return formatDate(dateString);
  };
  return <PageShell title={t("admin_ai_ml_configuration")} description={t("admin_ai_manage_machine_learning_models")}>
      <div className="space-y-6">
        {/* Tab Navigation */}
        <div className="flex space-x-1 bg-muted p-1 rounded-lg w-fit">
          <Button variant={activeTab === "models" ? "default" : "ghost"} size="sm" onClick={() => setActiveTab("models")}>
            <Brain className="h-4 w-4 mr-2" />{t("admin_ai_models")}</Button>
          <Button variant={activeTab === "configurations" ? "default" : "ghost"} size="sm" onClick={() => setActiveTab("configurations")}>
            <Settings className="h-4 w-4 mr-2" />{t("admin_ai_configurations")}</Button>
        </div>

        {/* Summary Cards */}
        <div className="grid gap-4 md:grid-cols-4">
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_ai_total_models")}</CardTitle>
              <Brain className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold">{totalModels}</div>
              <p className="text-xs text-muted-foreground">{t("admin_ai_ml_models")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_ai_active")}</CardTitle>
              <Zap className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-green-600">
                {activeModels}
              </div>
              <p className="text-xs text-muted-foreground">
                {totalModels > 0 ? (activeModels / totalModels * 100).toFixed(1) : 0}{t("admin_ai_active")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_ai_deployed")}</CardTitle>
              <Cpu className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-slate-600">
                {deployedModels}
              </div>
              <p className="text-xs text-muted-foreground">{t("admin_ai_in_production")}</p>
            </CardContent>
          </Card>
          
          <Card>
            <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
              <CardTitle className="text-sm font-medium">{t("admin_ai_configurations")}</CardTitle>
              <Settings className="h-4 w-4 text-muted-foreground" />
            </CardHeader>
            <CardContent>
              <div className="text-2xl font-bold text-slate-600">
                {activeConfigs}
              </div>
              <p className="text-xs text-muted-foreground">
                {totalConfigs}{t("admin_ai_total")}</p>
            </CardContent>
          </Card>
        </div>

        {/* Filters and Actions */}
        <div className="flex items-center justify-between space-x-2">
          <div className="flex items-center space-x-2">
            <div className="relative">
              <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
              <Input placeholder={t("admin_ai_search")} value={searchTerm} onChange={e => setSearchTerm(e.target.value)} className="pl-8 w-[250px]" />
            </div>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="outline" size="sm">
                  <Filter className="h-4 w-4 mr-2" />{t("admin_ai_type")}{filterType === "all" ? "All" : filterType}
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent>
                <DropdownMenuItem onClick={() => setFilterType("all")}>{t("admin_ai_all_types")}</DropdownMenuItem>
                {Object.values(MLModelType).map(type => <DropdownMenuItem key={type} onClick={() => setFilterType(type)}>
                    {type.replace("_", " ")}
                  </DropdownMenuItem>)}
              </DropdownMenuContent>
            </DropdownMenu>
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button variant="outline" size="sm">{t("admin_ai_status")}{filterStatus === "all" ? "All" : filterStatus}
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent>
                <DropdownMenuItem onClick={() => setFilterStatus("all")}>{t("admin_ai_all_status")}</DropdownMenuItem>
                <DropdownMenuItem onClick={() => setFilterStatus("active")}>{t("admin_ai_active")}</DropdownMenuItem>
                <DropdownMenuItem onClick={() => setFilterStatus("inactive")}>{t("admin_ai_inactive")}</DropdownMenuItem>
                <DropdownMenuItem onClick={() => setFilterStatus("deployed")}>{t("admin_ai_deployed")}</DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
          {activeTab === "models" ? <Dialog open={isModelDialogOpen} onOpenChange={setIsModelDialogOpen}>
              <DialogTrigger asChild>
                <Button>
                  <Plus className="h-4 w-4 mr-2" />{t("admin_ai_create_model")}</Button>
              </DialogTrigger>
              <DialogContent className="sm:max-w-[600px]">
                <DialogHeader>
                  <DialogTitle>{t("admin_ai_create_ml_model")}</DialogTitle>
                  <DialogDescription>{t("admin_ai_define_a_new_machine")}</DialogDescription>
                </DialogHeader>
                <div className="grid gap-4 py-4">
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="name" className="text-right">{t("admin_ai_name")}</Label>
                    <Input id="name" placeholder={t("admin_ai_enter_model_name")} className="col-span-3" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="type" className="text-right">{t("admin_ai_type")}</Label>
                    <Select>
                      <SelectTrigger className="col-span-3">
                        <SelectValue placeholder={t("admin_ai_select_model_type")} />
                      </SelectTrigger>
                      <SelectContent>
                        {Object.values(MLModelType).map(type => <SelectItem key={type} value={type}>
                            {type.replace("_", " ")}
                          </SelectItem>)}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="algorithm" className="text-right">{t("admin_ai_algorithm")}</Label>
                    <Select>
                      <SelectTrigger className="col-span-3">
                        <SelectValue placeholder={t("admin_ai_select_algorithm")} />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="random_forest">{t("admin_ai_random_forest")}</SelectItem>
                        <SelectItem value="neural_network">{t("admin_ai_neural_network")}</SelectItem>
                        <SelectItem value="svm">{t("admin_ai_support_vector_machine")}</SelectItem>
                        <SelectItem value="linear_regression">{t("admin_ai_linear_regression")}</SelectItem>
                        <SelectItem value="logistic_regression">{t("admin_ai_logistic_regression")}</SelectItem>
                        <SelectItem value="gradient_boosting">{t("admin_ai_gradient_boosting")}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="version" className="text-right">{t("admin_ai_version")}</Label>
                    <Input id="version" placeholder="1.0.0" className="col-span-3" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="description" className="text-right">{t("admin_ai_description")}</Label>
                    <Textarea id="description" placeholder={t("admin_ai_model_description")} className="col-span-3" rows={3} />
                  </div>
                </div>
                <div className="flex justify-end space-x-2">
                  <Button variant="outline" onClick={() => setIsModelDialogOpen(false)}>{t("admin_ai_cancel")}</Button>
                  <Button onClick={() => handleCreateModel({})}>{t("admin_ai_create_model")}</Button>
                </div>
              </DialogContent>
            </Dialog> : <Dialog open={isConfigDialogOpen} onOpenChange={setIsConfigDialogOpen}>
              <DialogTrigger asChild>
                <Button>
                  <Plus className="h-4 w-4 mr-2" />{t("admin_ai_create_configuration")}</Button>
              </DialogTrigger>
              <DialogContent className="sm:max-w-[500px]">
                <DialogHeader>
                  <DialogTitle>{t("admin_ai_create_ml_configuration")}</DialogTitle>
                  <DialogDescription>{t("admin_ai_configure_ml_model_settings")}</DialogDescription>
                </DialogHeader>
                <div className="grid gap-4 py-4">
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="name" className="text-right">{t("admin_ai_name")}</Label>
                    <Input id="name" placeholder={t("admin_ai_configuration_name")} className="col-span-3" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="model" className="text-right">{t("admin_ai_model")}</Label>
                    <Select>
                      <SelectTrigger className="col-span-3">
                        <SelectValue placeholder={t("admin_ai_select_model")} />
                      </SelectTrigger>
                      <SelectContent>
                        {models.map(model => <SelectItem key={model.id} value={model.id}>
                            {model.name} ({model.type})
                          </SelectItem>)}
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="threshold" className="text-right">{t("admin_ai_threshold")}</Label>
                    <Input id="threshold" type="number" step="0.1" placeholder="0.5" className="col-span-3" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="batchSize" className="text-right">{t("admin_ai_batch_size")}</Label>
                    <Input id="batchSize" type="number" placeholder="32" className="col-span-3" />
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="environment" className="text-right">{t("admin_ai_environment")}</Label>
                    <Select>
                      <SelectTrigger className="col-span-3">
                        <SelectValue placeholder={t("admin_ai_select_environment")} />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="development">{t("admin_ai_development")}</SelectItem>
                        <SelectItem value="staging">{t("admin_ai_staging")}</SelectItem>
                        <SelectItem value="production">{t("admin_ai_production")}</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                  <div className="grid grid-cols-4 items-center gap-4">
                    <Label htmlFor="logging" className="text-right">{t("admin_ai_logging")}</Label>
                    <div className="col-span-3 flex items-center space-x-2">
                      <Switch id="logging" />
                      <Label htmlFor="logging">{t("admin_ai_enable_logging")}</Label>
                    </div>
                  </div>
                </div>
                <div className="flex justify-end space-x-2">
                  <Button variant="outline" onClick={() => setIsConfigDialogOpen(false)}>{t("admin_ai_cancel")}</Button>
                  <Button onClick={() => handleCreateConfiguration({})}>{t("admin_ai_create_configuration")}</Button>
                </div>
              </DialogContent>
            </Dialog>}
        </div>

        {/* Content based on active tab */}
        {activeTab === "models" && <Card>
            <CardHeader>
              <CardTitle>{t("admin_ai_ml_models")}</CardTitle>
              <CardDescription>{t("admin_ai_manage_machine_learning_models")}</CardDescription>
            </CardHeader>
            <CardContent>
              {loading ? <div className="flex items-center justify-center py-8">
                  <div className="text-sm text-muted-foreground">{t("admin_ai_loading")}</div>
                </div> : <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin_ai_name")}</TableHead>
                      <TableHead>{t("admin_ai_type")}</TableHead>
                      <TableHead>{t("admin_ai_version")}</TableHead>
                      <TableHead>{t("admin_ai_performance")}</TableHead>
                      <TableHead>{t("admin_ai_status")}</TableHead>
                      <TableHead>{t("admin_ai_last_trained")}</TableHead>
                      <TableHead>{t("admin_ai_actions")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredModels.map(model => <TableRow key={model.id}>
                        <TableCell className="font-medium">
                          <div>
                            <div className="font-medium">{model.name}</div>
                            {model.description && <div className="text-sm text-muted-foreground truncate max-w-[200px]">
                                {model.description}
                              </div>}
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant={getModelTypeColor(model.type)}>
                            {model.type.replace("_", " ")}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <code className="text-sm bg-white/5 px-2 py-1 rounded-lg">
                            {model.version}
                          </code>
                        </TableCell>
                        <TableCell>
                          {model.performance ? <div className="text-sm">
                              {model.performance.accuracy && <div>{t("admin_ai_accuracy")}{(model.performance.accuracy * 100).toFixed(1)}%</div>}
                              {model.performance.f1Score && <div>{t("admin_ai_f1")}{(model.performance.f1Score * 100).toFixed(1)}%</div>}
                            </div> : <span className="text-muted-foreground">{t("admin_ai_not_trained")}</span>}
                        </TableCell>
                        <TableCell>
                          <div className="flex flex-col space-y-1">
                            <div className="flex items-center space-x-2">
                              <Switch checked={model.isActive} onCheckedChange={checked => handleToggleModel(model.id, checked)} />
                              <span className="text-sm">{model.isActive ? "Active" : "Inactive"}</span>
                            </div>
                            {model.isDeployed && <Badge variant="default" className="text-xs">{t("admin_ai_deployed")}</Badge>}
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            {model.lastTrainedAt ? formatRelativeTime(model.lastTrainedAt) : "Never"}
                          </div>
                        </TableCell>
                        <TableCell>
                          <div className="flex items-center space-x-1">
                            <Button variant="outline" size="sm" onClick={() => handleTrainModel(model.id)}>
                              <Play className="h-4 w-4" />
                            </Button>
                            <Button variant={model.isDeployed ? "secondary" : "default"} size="sm" onClick={() => handleDeployModel(model.id, !model.isDeployed)}>
                              <Upload className="h-4 w-4" />
                            </Button>
                            <DropdownMenu>
                              <DropdownMenuTrigger asChild>
                                <Button variant="ghost" size="sm">
                                  <MoreHorizontal className="h-4 w-4" />
                                </Button>
                              </DropdownMenuTrigger>
                              <DropdownMenuContent>
                                <DropdownMenuItem>
                                  <Eye className="h-4 w-4 mr-2" />{t("admin_ai_view_details")}</DropdownMenuItem>
                                <DropdownMenuItem>
                                  <BarChart className="h-4 w-4 mr-2" />{t("admin_ai_performance")}</DropdownMenuItem>
                                <DropdownMenuItem>
                                  <Download className="h-4 w-4 mr-2" />{t("admin_ai_export_model")}</DropdownMenuItem>
                                <DropdownMenuItem>
                                  <Edit className="h-4 w-4 mr-2" />{t("admin_ai_edit")}</DropdownMenuItem>
                                <DropdownMenuItem className="text-red-600" onClick={() => handleDeleteModel(model.id)}>
                                  <Trash2 className="h-4 w-4 mr-2" />{t("admin_ai_delete")}</DropdownMenuItem>
                              </DropdownMenuContent>
                            </DropdownMenu>
                          </div>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>}
            </CardContent>
          </Card>}

        {activeTab === "configurations" && <Card>
            <CardHeader>
              <CardTitle>{t("admin_ai_ml_configurations")}</CardTitle>
              <CardDescription>{t("admin_ai_manage_deployment_configurations_and")}</CardDescription>
            </CardHeader>
            <CardContent>
              {loading ? <div className="flex items-center justify-center py-8">
                  <div className="text-sm text-muted-foreground">{t("admin_ai_loading")}</div>
                </div> : <Table>
                  <TableHeader>
                    <TableRow>
                      <TableHead>{t("admin_ai_name")}</TableHead>
                      <TableHead>{t("admin_ai_model")}</TableHead>
                      <TableHead>{t("admin_ai_environment")}</TableHead>
                      <TableHead>{t("admin_ai_threshold")}</TableHead>
                      <TableHead>{t("admin_ai_status")}</TableHead>
                      <TableHead>{t("admin_ai_created")}</TableHead>
                      <TableHead className="w-[50px]"></TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {filteredConfigs.map(config => <TableRow key={config.id}>
                        <TableCell className="font-medium">
                          <div>
                            <div className="font-medium">{config.name}</div>
                            {config.description && <div className="text-sm text-muted-foreground truncate max-w-[200px]">
                                {config.description}
                              </div>}
                          </div>
                        </TableCell>
                        <TableCell>
                          <div>
                            <div className="font-medium">{config.model?.name}</div>
                            <div className="text-sm text-muted-foreground">
                              {config.model?.type.replace("_", " ")}
                            </div>
                          </div>
                        </TableCell>
                        <TableCell>
                          <Badge variant={config.config.environment === "production" ? "destructive" : config.config.environment === "staging" ? "outline" : "secondary"}>
                            {config.config.environment}
                          </Badge>
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">
                            {(config.config.predictionThreshold * 100).toFixed(0)}%
                          </div>
                        </TableCell>
                        <TableCell>
                          <Switch checked={config.isActive} onCheckedChange={_checked => {
                    // Handle toggle
                  }} />
                        </TableCell>
                        <TableCell>
                          <div className="text-sm">{formatDate(config.createdAt)}</div>
                        </TableCell>
                        <TableCell>
                          <DropdownMenu>
                            <DropdownMenuTrigger asChild>
                              <Button variant="ghost" size="sm">
                                <MoreHorizontal className="h-4 w-4" />
                              </Button>
                            </DropdownMenuTrigger>
                            <DropdownMenuContent>
                              <DropdownMenuItem>
                                <Eye className="h-4 w-4 mr-2" />{t("admin_ai_view_details")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Settings className="h-4 w-4 mr-2" />{t("admin_ai_edit_configuration")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Play className="h-4 w-4 mr-2" />{t("admin_ai_test_configuration")}</DropdownMenuItem>
                              <DropdownMenuItem>
                                <Download className="h-4 w-4 mr-2" />{t("admin_ai_export_config")}</DropdownMenuItem>
                            </DropdownMenuContent>
                          </DropdownMenu>
                        </TableCell>
                      </TableRow>)}
                  </TableBody>
                </Table>}
            </CardContent>
          </Card>}
      </div>
    </PageShell>;
}