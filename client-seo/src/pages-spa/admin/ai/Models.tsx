"use client";

import { useTranslation } from"react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Badge } from"@/components/ui/badge";
import { Button } from"@/components/ui/button";
import { Settings, Play, Pause, RefreshCw, Activity } from"lucide-react";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from"@/components/ui/dialog";
import { Input } from"@/components/ui/input";
import { Label } from"@/components/ui/label";
import { useMutation, useQuery } from"@tanstack/react-query";
import { useState } from"react";
import { useToast } from"@/hooks/use-toast";
import { apiClient } from"@/lib/api/client";

interface AIModel {
 id: string;
 modelName: string;
 modelVersion: string;
 modelType: string;
 provider: string;
 status: string;
 accuracy?: string;
 lastTrained?: string;
 predictions?: string;
 createdAt: string;
}

const fallbackModels = [{
 name:"Property Valuation Model",
 type:"Regression",
 status:"active",
 accuracy:"97.2%",
 lastTrained:"2 days ago",
 predictions:"12,543"
}, {
 name:"Lead Scoring Engine",
 type:"Classification",
 status:"active",
 accuracy:"94.8%",
 lastTrained:"1 week ago",
 predictions:"8,234"
}, {
 name:"Market Prediction Model",
 type:"Time Series",
 status:"training",
 accuracy:"92.1%",
 lastTrained:"3 days ago",
 predictions:"5,678"
}, {
 name:"Recommendation System",
 type:"Collaborative Filtering",
 status:"active",
 accuracy:"96.5%",
 lastTrained:"5 days ago",
 predictions:"15,892"
}, {
 name:"Image Recognition",
 type:"Computer Vision",
 status:"inactive",
 accuracy:"89.3%",
 lastTrained:"2 weeks ago",
 predictions:"3,456"
}, {
 name:"Natural Language Processor",
 type:"NLP",
 status:"active",
 accuracy:"91.7%",
 lastTrained:"4 days ago",
 predictions:"7,234"
}];

const trainingQueue = [{
 model:"Market Prediction Model",
 progress: 75,
 status:"training"
}, {
 model:"Customer Segmentation",
 progress: 100,
 status:"completed"
}, {
 model:"Fraud Detection Model",
 progress: 30,
 status:"queued"
}];

export default function AIModels() {
 const { t } = useTranslation();
 const { toast } = useToast();
 const [isAddOpen, setIsAddOpen] = useState(false);
 const [newModel, setNewModel] = useState({
 modelName: '',
 modelVersion: 'v1.0',
 modelType: 'Regression',
 provider: 'OpenAI'
 });

 const { data: serverModels = [] } = useQuery({
 queryKey: ['ai-models'],
 queryFn: async () => {
 const res = await apiClient.get('/ai-models');
 return (res as any)?.data || [];
 },
 });

 const createMutation = useMutation({
 mutationFn: async (data: any) => {
 return apiClient.post('/ai-models', data);
 },
 onSuccess: () => {
 setIsAddOpen(false);
 toast({ title:"Success", description:"AI Model registered" });
 },
 onError: (err: any) => {
 toast({ title:"Error", description: err.message, variant:"destructive" });
 }
 });

 const displayModels = (serverModels as AIModel[]).length > 0
 ? (serverModels as AIModel[]).map(m => ({
 name: m.modelName,
 type: m.modelType,
 status: m.status || 'active',
 accuracy: m.accuracy || 'N/A',
 lastTrained: m.lastTrained || 'N/A',
 predictions: m.predictions || 'N/A'
 }))
 : fallbackModels;

 return <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 min-h-screen p-4 md:p-8 space-y-6">
 <div className="flex items-center justify-between">
 <div>
 <h1 className="text-3xl font-bold text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">{t("admin_ai_ai_models")}</h1>
 <p className="text-muted-foreground">{t("admin_ai_manage_and_monitor_artificial")}</p>
 </div>
 <div className="flex gap-2">
 <Button variant="outline" className="border-border text-muted-foreground">
 <RefreshCw className="w-4 h-4 mr-2" />{t("admin_ai_refresh_models")}
 </Button>
 <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
 <DialogTrigger asChild>
 <Button>{t("admin_auto_register_model", "Register Model")}</Button>
 </DialogTrigger>
 <DialogContent className="sm:max-w-[500px] bg-card border-border text-foreground">
 <DialogHeader>
 <DialogTitle>{t("admin_auto_register_new_ai_model", "Register New AI Model")}</DialogTitle>
 <DialogDescription className="text-muted-foreground">{t("admin_auto_register_a_new_model_endpoint_and_metada", "Register a new model endpoint and metadata.")}</DialogDescription>
 </DialogHeader>
 <div className="grid gap-4 py-4">
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right text-xs text-muted-foreground">{t("admin_auto_model_name", "Model Name")}</Label>
 <Input className="col-span-3 h-10 bg-card border-border text-foreground" value={newModel.modelName} onChange={e => setNewModel({...newModel, modelName: e.target.value})} placeholder={t("admin_auto_property_valuator", "Property Valuator")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right text-xs text-muted-foreground">{t("admin_auto_version", "Version")}</Label>
 <Input className="col-span-3 h-10 bg-card border-border text-foreground" value={newModel.modelVersion} onChange={e => setNewModel({...newModel, modelVersion: e.target.value})} placeholder={t("admin_auto_v1_0", "v1.0")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right text-xs text-muted-foreground">{t("admin_auto_type", "Type")}</Label>
 <Input className="col-span-3 h-10 bg-card border-border text-foreground" value={newModel.modelType} onChange={e => setNewModel({...newModel, modelType: e.target.value})} placeholder={t("admin_ai_regression", "Regression")} />
 </div>
 <div className="grid grid-cols-4 items-center gap-4">
 <Label className="text-right text-xs text-muted-foreground">{t("admin_auto_provider", "Provider")}</Label>
 <Input className="col-span-3 h-10 bg-card border-border text-foreground" value={newModel.provider} onChange={e => setNewModel({...newModel, provider: e.target.value})} placeholder={t("admin_auto_openai", "OpenAI")} />
 </div>
 </div>
 <DialogFooter>
 <Button variant="outline" className="border-border text-muted-foreground" onClick={() => setIsAddOpen(false)}>{t("admin_action_cancel", "Cancel")}</Button>
 <Button onClick={() => createMutation.mutate(newModel)} disabled={createMutation.isPending}>
 {createMutation.isPending ?"Saving..." :"Register"}
 </Button>
 </DialogFooter>
 </DialogContent>
 </Dialog>
 </div>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
 {displayModels.map((model, i) => <Card key={i} className="bg-card border-border">
 <CardHeader>
 <div className="flex items-center justify-between">
 <CardTitle className="text-lg text-foreground">{model.name}</CardTitle>
 <Badge variant={model.status ==="active" ?"default" : model.status ==="training" ?"secondary" :"outline"}>
 {model.status}
 </Badge>
 </div>
 <p className="text-sm text-muted-foreground">{model.type}</p>
 </CardHeader>
 <CardContent className="space-y-4">
 <div className="grid grid-cols-2 gap-4 text-sm">
 <div>
 <p className="font-medium text-muted-foreground">{t("admin_ai_accuracy")}</p>
 <p className="text-foreground">{model.accuracy}</p>
 </div>
 <div>
 <p className="font-medium text-muted-foreground">{t("admin_ai_predictions")}</p>
 <p className="text-foreground">{model.predictions}</p>
 </div>
 </div>

 <div className="text-sm">
 <p className="font-medium text-muted-foreground">{t("admin_ai_last_trained")}</p>
 <p className="text-foreground">{model.lastTrained}</p>
 </div>

 <div className="flex gap-2">
 <Button size="sm" variant="outline" className="border-border text-muted-foreground">
 <Settings className="w-4 h-4 mr-2" />{t("admin_ai_configure")}</Button>
 <Button size="sm" variant="outline" className="border-border text-muted-foreground">
 {model.status ==="active" ? <>
 <Pause className="w-4 h-4 mr-2" />{t("admin_ai_pause")}</> : <>
 <Play className="w-4 h-4 mr-2" />{t("admin_ai_start")}</>}
 </Button>
 </div>
 </CardContent>
 </Card>)}
 </div>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground">{t("admin_ai_model_training_queue")}</CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 {trainingQueue.map((training, i) => <div key={i} className="space-y-2">
 <div className="flex items-center justify-between">
 <p className="font-medium text-foreground">{training.model}</p>
 <Badge variant={training.status ==="completed" ?"default" :"secondary"}>
 {training.status}
 </Badge>
 </div>
 <div className="w-full bg-card rounded-full h-2">
 <div className="bg-slate-600 h-2 rounded-full" style={{
 width: `${training.progress}%`
 }}></div>
 </div>
 </div>)}
 </div>
 </CardContent>
 </Card>
 </div>;
}
