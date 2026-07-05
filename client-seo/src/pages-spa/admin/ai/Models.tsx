"use client";

import { useTranslation } from "react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Settings, Play, Pause, RefreshCw, Activity } from "lucide-react";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { useMutation, useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { useToast } from "@/hooks/use-toast";
import { apiClient } from "@/lib/api/client";

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
  name: "Property Valuation Model",
  type: "Regression",
  status: "active",
  accuracy: "97.2%",
  lastTrained: "2 days ago",
  predictions: "12,543"
}, {
  name: "Lead Scoring Engine",
  type: "Classification",
  status: "active",
  accuracy: "94.8%",
  lastTrained: "1 week ago",
  predictions: "8,234"
}, {
  name: "Market Prediction Model",
  type: "Time Series",
  status: "training",
  accuracy: "92.1%",
  lastTrained: "3 days ago",
  predictions: "5,678"
}, {
  name: "Recommendation System",
  type: "Collaborative Filtering",
  status: "active",
  accuracy: "96.5%",
  lastTrained: "5 days ago",
  predictions: "15,892"
}, {
  name: "Image Recognition",
  type: "Computer Vision",
  status: "inactive",
  accuracy: "89.3%",
  lastTrained: "2 weeks ago",
  predictions: "3,456"
}, {
  name: "Natural Language Processor",
  type: "NLP",
  status: "active",
  accuracy: "91.7%",
  lastTrained: "4 days ago",
  predictions: "7,234"
}];

const trainingQueue = [{
  model: "Market Prediction Model",
  progress: 75,
  status: "training"
}, {
  model: "Customer Segmentation",
  progress: 100,
  status: "completed"
}, {
  model: "Fraud Detection Model",
  progress: 30,
  status: "queued"
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
      toast({ title: "Success", description: "AI Model registered" });
    },
    onError: (err: any) => {
      toast({ title: "Error", description: err.message, variant: "destructive" });
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

  return <div className="min-h-screen p-4 md:p-8 space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-white">{t("admin.ai.ai_models")}</h1>
          <p className="text-slate-400">{t("admin.ai.manage_and_monitor_artificial")}</p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" className="border-white/10 text-slate-400">
            <RefreshCw className="w-4 h-4 mr-2" />{t("admin.ai.refresh_models")}
          </Button>
          <Dialog open={isAddOpen} onOpenChange={setIsAddOpen}>
            <DialogTrigger asChild>
              <Button>Register Model</Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[500px] bg-white/5 border-white/10 text-white">
              <DialogHeader>
                <DialogTitle>Register New AI Model</DialogTitle>
                <DialogDescription className="text-slate-400">
                  Register a new model endpoint and metadata.
                </DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label className="text-right text-xs text-slate-400">Model Name</Label>
                  <Input className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={newModel.modelName} onChange={e => setNewModel({...newModel, modelName: e.target.value})} placeholder="Property Valuator" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label className="text-right text-xs text-slate-400">Version</Label>
                  <Input className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={newModel.modelVersion} onChange={e => setNewModel({...newModel, modelVersion: e.target.value})} placeholder="v1.0" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label className="text-right text-xs text-slate-400">Type</Label>
                  <Input className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={newModel.modelType} onChange={e => setNewModel({...newModel, modelType: e.target.value})} placeholder="Regression" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label className="text-right text-xs text-slate-400">Provider</Label>
                  <Input className="col-span-3 h-10 bg-white/5 border-white/10 text-white" value={newModel.provider} onChange={e => setNewModel({...newModel, provider: e.target.value})} placeholder="OpenAI" />
                </div>
              </div>
              <DialogFooter>
                <Button variant="outline" className="border-white/10 text-slate-400" onClick={() => setIsAddOpen(false)}>Cancel</Button>
                <Button onClick={() => createMutation.mutate(newModel)} disabled={createMutation.isPending}>
                  {createMutation.isPending ? "Saving..." : "Register"}
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {displayModels.map((model, i) => <Card key={i} className="bg-white/5 border-white/10">
            <CardHeader>
              <div className="flex items-center justify-between">
                <CardTitle className="text-lg text-white">{model.name}</CardTitle>
                <Badge variant={model.status === "active" ? "default" : model.status === "training" ? "secondary" : "outline"}>
                  {model.status}
                </Badge>
              </div>
              <p className="text-sm text-slate-400">{model.type}</p>
            </CardHeader>
            <CardContent className="space-y-4">
              <div className="grid grid-cols-2 gap-4 text-sm">
                <div>
                  <p className="font-medium text-slate-400">{t("admin.ai.accuracy")}</p>
                  <p className="text-white">{model.accuracy}</p>
                </div>
                <div>
                  <p className="font-medium text-slate-400">{t("admin.ai.predictions")}</p>
                  <p className="text-white">{model.predictions}</p>
                </div>
              </div>

              <div className="text-sm">
                <p className="font-medium text-slate-400">{t("admin.ai.last_trained")}</p>
                <p className="text-white">{model.lastTrained}</p>
              </div>

              <div className="flex gap-2">
                <Button size="sm" variant="outline" className="border-white/10 text-slate-400">
                  <Settings className="w-4 h-4 mr-2" />{t("admin.ai.configure")}</Button>
                <Button size="sm" variant="outline" className="border-white/10 text-slate-400">
                  {model.status === "active" ? <>
                      <Pause className="w-4 h-4 mr-2" />{t("admin.ai.pause")}</> : <>
                      <Play className="w-4 h-4 mr-2" />{t("admin.ai.start")}</>}
                </Button>
              </div>
            </CardContent>
          </Card>)}
      </div>

      <Card className="bg-white/5 border-white/10">
        <CardHeader>
          <CardTitle className="text-white">{t("admin.ai.model_training_queue")}</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {trainingQueue.map((training, i) => <div key={i} className="space-y-2">
                <div className="flex items-center justify-between">
                  <p className="font-medium text-white">{training.model}</p>
                  <Badge variant={training.status === "completed" ? "default" : "secondary"}>
                    {training.status}
                  </Badge>
                </div>
                <div className="w-full bg-white/5 rounded-full h-2">
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
