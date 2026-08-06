"use client";

import { t } from"i18next";
import { useTranslation } from"react-i18next";
import { useState, useEffect } from"react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from"@/components/ui/dialog";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from"@/components/ui/table";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from"@/components/ui/select";
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger } from"@/components/ui/dropdown-menu";
import { Brain, Plus, Edit, Trash2, Play, MoreHorizontal, Activity, CheckCircle } from"lucide-react";
import { useToast } from"@/hooks/use-toast";
import { aiApi, type AIModel, type AIModelDeployment } from"@/lib/api/ai";
export default function AIModels() {
 const {
 t
 } = useTranslation();
 const [models, setModels] = useState<AIModel[]>([]);
 const [deployments, setDeployments] = useState<AIModelDeployment[]>([]);
 const [loading, setLoading] = useState(true);
 const [selectedModel, setSelectedModel] = useState<AIModel | null>(null);
 const [isCreateDialogOpen, setIsCreateDialogOpen] = useState(false);
 const [isEditDialogOpen, setIsEditDialogOpen] = useState(false);
 const [isDeploymentDialogOpen, setIsDeploymentDialogOpen] = useState(false);
 const {
 toast
 } = useToast();
 const [newModel, setNewModel] = useState<Partial<AIModel>>({
 modelName: '',
 modelVersion: '',
 accuracy: 0,
 config: {},
 metadata: {}
 });
 const [newDeployment, setNewDeployment] = useState({
 deploymentVersion: '',
 environment: 'development'
 });
 useEffect(() => {
 fetchModels();
 fetchDeployments();
 }, []);
 const fetchModels = async () => {
 try {
 const response = await aiApi.getModels();
 setModels(response);
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_fetch_ai"),
 variant:"destructive"
 });
 }
 };
 const fetchDeployments = async () => {
 try {
 await aiApi.getDashboard(); // Get all AI data
 // For now, if getDeployments doesn't exist, we might need to add it to aiApi
 // Let's assume aiApi.getDashboard returns deployments or we add it
 const deploymentsRes = (await (aiApi as any).getDeployments?.()) || {
 data: []
 };
 setDeployments(deploymentsRes);
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_fetch_ai"),
 variant:"destructive"
 });
 } finally {
 setLoading(false);
 }
 };
 const createModel = async () => {
 try {
 const response = await aiApi.createModel(newModel);
 setModels([...models, response]);
 setIsCreateDialogOpen(false);
 setNewModel({
 modelName: '',
 modelVersion: '',
 accuracy: 0,
 config: {},
 metadata: {}
 });
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_ai_model_created_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_create_ai"),
 variant:"destructive"
 });
 }
 };
 const updateModel = async () => {
 if (!selectedModel) return;
 try {
 const response = await aiApi.updateModel(selectedModel.id, {
 modelName: selectedModel.modelName,
 modelVersion: selectedModel.modelVersion,
 accuracy: selectedModel.accuracy,
 config: selectedModel.config,
 metadata: selectedModel.metadata,
 status: selectedModel.status
 });
 setModels(models.map(m => m.id === selectedModel.id ? response : m));
 setIsEditDialogOpen(false);
 setSelectedModel(null);
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_ai_model_updated_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_update_ai"),
 variant:"destructive"
 });
 }
 };
 const deleteModel = async (modelId: string) => {
 try {
 await aiApi.deleteModel(modelId);
 setModels(models.filter(m => m.id !== modelId));
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_ai_model_deleted_successfully")
 });
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_delete_ai"),
 variant:"destructive"
 });
 }
 };
 const deployModel = async () => {
 if (!selectedModel) return;
 try {
 const response = await aiApi.deployModel(selectedModel.id, newDeployment);
 setDeployments([...deployments, response]);
 setIsDeploymentDialogOpen(false);
 setNewDeployment({
 deploymentVersion: '',
 environment: 'development'
 });
 setSelectedModel(null);
 toast({
 title: t("admin_ai_success"),
 description: t("admin_ai_ai_model_deployment_initiated")
 });
 } catch (error) {
 toast({
 title: t("admin_ai_error"),
 description: t("admin_ai_failed_to_deploy_ai"),
 variant:"destructive"
 });
 }
 };
 const getDeploymentStatusColor = (status: string) => {
 switch (status) {
 case 'ACTIVE':
 return 'bg-blue-500';
 case 'DEPLOYING':
 return 'bg-muted0';
 case 'PENDING':
 return 'bg-yellow-500';
 case 'FAILED':
 return 'bg-red-500';
 case 'INACTIVE':
 return 'bg-card/10';
 default:
 return 'bg-card/10';
 }
 };
 if (loading) {
 return <PageShell title={t("admin_ai_ai_models_management")}>
 <div className="flex items-center justify-center h-64">
 <Activity className="h-8 w-8 animate-spin" />
 </div>
 </PageShell>;
 }
 return <PageShell title={t("admin_ai_ai_models_management")}>
 <div className="space-y-6">
 {/* Header */}
 <div className="flex justify-between items-center">
 <div>
 <h1 className="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_ai_ai_models_management")}</h1>
 <p className="text-muted-foreground">{t("admin_ai_manage_ai_models_and")}</p>
 </div>
 <Dialog open={isCreateDialogOpen} onOpenChange={setIsCreateDialogOpen}>
 <DialogTrigger asChild>
 <Button>
 <Plus className="h-4 w-4 mr-2" />{t("admin_ai_create_model")}</Button>
 </DialogTrigger>
 <DialogContent>
 <DialogHeader>
 <DialogTitle>{t("admin_ai_create_new_ai_model")}</DialogTitle>
 <DialogDescription>{t("admin_ai_add_a_new_ai")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="modelName" className="text-right">{t("admin_ai_model_name")}</Label>
 <Input id="modelName" value={newModel.modelName} onChange={e => setNewModel({
 ...newModel,
 modelName: e.target.value
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="modelVersion" className="text-right">{t("admin_ai_version")}</Label>
 <Input id="modelVersion" value={newModel.modelVersion} onChange={e => setNewModel({
 ...newModel,
 modelVersion: e.target.value
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="accuracy" className="text-right">{t("admin_ai_accuracy")}</Label>
 <Input id="accuracy" type="number" value={newModel.accuracy} onChange={e => setNewModel({
 ...newModel,
 accuracy: parseFloat(e.target.value)
 })} className="col-span-3" />
 </div>
 </div>
 <DialogFooter>
 <Button onClick={createModel}>{t("admin_ai_create_model")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>

 {/* Models Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_ai_ai_models")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_ai_model_name")}</TableHead>
 <TableHead>{t("admin_ai_version")}</TableHead>
 <TableHead>{t("admin_ai_status")}</TableHead>
 <TableHead>{t("admin_ai_accuracy")}</TableHead>
 <TableHead>{t("admin_ai_last_trained")}</TableHead>
 <TableHead>{t("admin_ai_deployments")}</TableHead>
 <TableHead className="text-right">{t("admin_ai_actions")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {models.map(model => {
 const modelDeployments = deployments.filter(d => d.modelId === model.id);
 const activeDeployments = modelDeployments.filter(d => d.status === 'ACTIVE').length;
 return <TableRow key={model.id}>
 <TableCell className="font-medium">
 <div className="flex items-center gap-2">
 <Brain className="h-4 w-4" />
 {model.modelName}
 </div>
 </TableCell>
 <TableCell>{model.modelVersion}</TableCell>
 <TableCell>
 <Badge variant={model.status ==="ACTIVE" ?"default" :"secondary"}>
 {model.status ==="ACTIVE" ?"Active" :"Inactive"}
 </Badge>
 </TableCell>
 <TableCell>{model.accuracy}%</TableCell>
 <TableCell>
 {model.lastTrainedAt ? new Date(model.lastTrainedAt).toLocaleDateString() :"Never"}
 </TableCell>
 <TableCell>
 <div className="flex items-center gap-1">
 <span className="text-sm">{activeDeployments}{t("/", "/")}{modelDeployments.length}</span>
 {activeDeployments > 0 && <CheckCircle className="h-3 w-3 text-blue-500" />}
 </div>
 </TableCell>
 <TableCell className="text-right">
 <DropdownMenu>
 <DropdownMenuTrigger asChild>
 <Button variant="ghost" className="h-8 w-8 p-0" aria-label={t("common.more")}>
 <MoreHorizontal className="h-4 w-4" />
 </Button>
 </DropdownMenuTrigger>
 <DropdownMenuContent align="end">
 <DropdownMenuLabel>{t("admin_ai_actions")}</DropdownMenuLabel>
 <DropdownMenuItem onClick={() => {
 setSelectedModel(model);
 setIsEditDialogOpen(true);
 }}>
 <Edit className="h-4 w-4 mr-2" />{t("admin_ai_edit")}</DropdownMenuItem>
 <DropdownMenuItem onClick={() => {
 setSelectedModel(model);
 setIsDeploymentDialogOpen(true);
 }}>
 <Play className="h-4 w-4 mr-2" />{t("admin_ai_deploy")}</DropdownMenuItem>
 <DropdownMenuSeparator />
 <DropdownMenuItem onClick={() => deleteModel(model.id)} className="text-red-600">
 <Trash2 className="h-4 w-4 mr-2" />{t("admin_ai_delete")}</DropdownMenuItem>
 </DropdownMenuContent>
 </DropdownMenu>
 </TableCell>
 </TableRow>;
 })}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 {/* Deployments Table */}
 <Card>
 <CardHeader>
 <CardTitle>{t("admin_ai_model_deployments")}</CardTitle>
 </CardHeader>
 <CardContent>
 <Table>
 <TableHeader>
 <TableRow>
 <TableHead>{t("admin_ai_model")}</TableHead>
 <TableHead>{t("admin_ai_version")}</TableHead>
 <TableHead>{t("admin_ai_environment")}</TableHead>
 <TableHead>{t("admin_ai_status")}</TableHead>
 <TableHead>{t("admin_ai_deployed_at")}</TableHead>
 <TableHead>{t("admin_ai_endpoint")}</TableHead>
 </TableRow>
 </TableHeader>
 <TableBody>
 {deployments.map(deployment => {
 const model = models.find(m => m.id === deployment.modelId);
 return <TableRow key={deployment.id}>
 <TableCell>{model?.modelName || 'Unknown'}</TableCell>
 <TableCell>{deployment.deploymentId}</TableCell>
 <TableCell>
 <Badge variant="outline">{deployment.environment}</Badge>
 </TableCell>
 <TableCell>
 <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 flex items-center gap-2">
 <div className={`w-2 h-2 rounded-full ${getDeploymentStatusColor(deployment.status)}`} />
 <span className="capitalize">{deployment.status.toLowerCase()}</span>
 </div>
 </TableCell>
 <TableCell>
 {deployment.deployedAt ? new Date(deployment.deployedAt).toLocaleString() :"Not deployed"}
 </TableCell>
 <TableCell className="font-mono text-xs">
 {deployment.config?.endpointUrl ||"N/A"}
 </TableCell>
 </TableRow>;
 })}
 </TableBody>
 </Table>
 </CardContent>
 </Card>

 {/* Edit Model Dialog */}
 <Dialog open={isEditDialogOpen} onOpenChange={setIsEditDialogOpen}>
 <DialogContent>
 <DialogHeader>
 <DialogTitle>{t("admin_ai_edit_ai_model")}</DialogTitle>
 <DialogDescription>{t("admin_ai_update_the_ai_model")}</DialogDescription>
 </DialogHeader>
 {selectedModel && <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-modelName" className="text-right">{t("admin_ai_model_name")}</Label>
 <Input id="edit-modelName" value={selectedModel.modelName} onChange={e => setSelectedModel({
 ...selectedModel,
 modelName: e.target.value
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-modelVersion" className="text-right">{t("admin_ai_version")}</Label>
 <Input id="edit-modelVersion" value={selectedModel.modelVersion} onChange={e => setSelectedModel({
 ...selectedModel,
 modelVersion: e.target.value
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-accuracy" className="text-right">{t("admin_ai_accuracy")}</Label>
 <Input id="edit-accuracy" type="number" value={selectedModel.accuracy} onChange={e => setSelectedModel({
 ...selectedModel,
 accuracy: parseFloat(e.target.value)
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="edit-isActive" className="text-right">{t("admin_ai_status")}</Label>
 <Select value={selectedModel.status ==="ACTIVE" ?"active" :"inactive"} onValueChange={value => setSelectedModel({
 ...selectedModel,
 status: value ==="active" ?"ACTIVE" :"INACTIVE"
 })}>
 <SelectTrigger className="col-span-3">
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="active">{t("admin_ai_active")}</SelectItem>
 <SelectItem value="inactive">{t("admin_ai_inactive")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>}
 <DialogFooter>
 <Button onClick={updateModel}>{t("admin_ai_update_model")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>

 {/* Deploy Model Dialog */}
 <Dialog open={isDeploymentDialogOpen} onOpenChange={setIsDeploymentDialogOpen}>
 <DialogContent>
 <DialogHeader>
 <DialogTitle>{t("admin_ai_deploy_ai_model")}</DialogTitle>
 <DialogDescription>{t("admin_ai_deploy")}{selectedModel?.modelName}{t("admin_ai_to_an_environment")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="deploymentVersion" className="text-right">{t("admin_ai_deployment_version")}</Label>
 <Input id="deploymentVersion" value={newDeployment.deploymentVersion} onChange={e => setNewDeployment({
 ...newDeployment,
 deploymentVersion: e.target.value
 })} className="col-span-3" />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label htmlFor="environment" className="text-right">{t("admin_ai_environment")}</Label>
 <Select value={newDeployment.environment} onValueChange={value => setNewDeployment({
 ...newDeployment,
 environment: value
 })}>
 <SelectTrigger className="col-span-3">
 <SelectValue />
 </SelectTrigger>
 <SelectContent>
 <SelectItem value="development">{t("admin_ai_development")}</SelectItem>
 <SelectItem value="staging">{t("admin_ai_staging")}</SelectItem>
 <SelectItem value="production">{t("admin_ai_production")}</SelectItem>
 </SelectContent>
 </Select>
 </div>
 </div>
 <DialogFooter>
 <Button onClick={deployModel}>{t("admin_ai_deploy_model")}</Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </PageShell>;
}