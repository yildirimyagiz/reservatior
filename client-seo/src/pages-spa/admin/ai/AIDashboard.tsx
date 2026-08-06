"use client";

import { useTranslation } from"react-i18next";
import { Card, CardContent, CardHeader, CardTitle } from"@/components/ui/card";
import { Button } from"@/components/ui/button";
import { Badge } from"@/components/ui/badge";
import { Brain, Settings, Activity, Cpu, ShieldCheck, Zap, Bot, Sparkles, BarChart3, Network } from"lucide-react";
import { useQuery } from"@tanstack/react-query";
import { apiClient } from"@/lib/api/client";
import { cn } from"@/lib/utils";
import { useToast } from"@/hooks/use-toast";

interface AIStatus {
 status: string;
 uptime: number;
 metrics: {
 totalSessions: number;
 activeSessions: number;
 totalValuations: number;
 pendingTasks: number;
 };
 models: {
 valuation: string;
 chatbot: string;
 recommendation: string;
 };
 lastHeartbeat: string;
}

interface AIModel {
 id: string;
 modelName: string;
 modelVersion: string;
 modelType: string;
 provider: string;
 status: string;
 accuracy: number | null;
 createdAt: string;
}

export default function AIDashboard() {
 const { t } = useTranslation();
 const { toast } = useToast();

 const { data: statusData } = useQuery({
 queryKey: ['ai-status'],
 queryFn: async () => {
 const res: any = await apiClient.get('/ai/status');
 return res as AIStatus;
 },
 refetchInterval: 30000,
 });

 const { data: modelsData } = useQuery({
 queryKey: ['ai-models'],
 queryFn: async () => {
 const res: any = await apiClient.get('/ai/models');
 return (res?.data || []) as AIModel[];
 },
 });

 const status = statusData as AIStatus | undefined;
 const models = (modelsData || []) as AIModel[];

 return (<div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
 <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
 <div className="flex items-center gap-4">
 <div className="p-3 bg-muted rounded-xl shadow-lg shadow-slate-600/20">
 <Brain className="w-8 h-8 text-foreground" />
 </div>
 <div>
 <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-slate-200 to-slate-500">
 {t("admin_ai_ai_central_intelligence", "Merkezi Yapay Zeka İstihbaratı")}
 </h1>
 <p className="text-muted-foreground">
 {t("admin_ai_monitoring_and_managing_reservatior", "Reservator AI altyapısını izleme ve yönetme")}
 </p>
 </div>
 </div>
 <div className="flex gap-3">
 <Button variant="outline" className="gap-2 bg-card border-border hover:bg-muted dark:hover:bg-card/10 text-foreground">
 <Settings className="w-4 h-4" />
 {t("admin_ai_global_config", "Sistem Yapılandırması")}
 </Button>
 <Button onClick={() => {
 toast({ title: t("admin_ai_retraining_started", "Yeniden Eğitim Başladı"), description: t("admin_ai_models_retraining", "Konum Zekası ve Fiyat Tahmin modelleri güncelleniyor.") });
 apiClient.post('/ai/models/retrain').then(() => {
 toast({ title: t("admin_ai_retraining_complete", "Yeniden Eğitim Tamamlandı"), description: t("admin_ai_retraining_success", "Modeller başarıyla yeniden eğitildi.") });
 }).catch((err: any) => {
 toast({ title:"Error", description: err.message, variant:"destructive" });
 });
 }} className="gap-2 bg-muted hover:bg-muted shadow-lg shadow-slate-600/20 text-foreground">
 <Zap className="w-4 h-4" />
 {t("admin_ai_retrain_models", "Modelleri Yeniden Eğit")}
 </Button>
 </div>
 </div>

 <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground flex items-center gap-2">
 <Cpu className="w-4 h-4 text-muted-foreground" />
 {t("admin_ai_infrastructure_health", "Altyapı Sağlık Durumu")}
 </CardTitle>
 </CardHeader>
 <CardContent className="space-y-4">
 <div className="flex justify-between items-center text-sm p-3 bg-card rounded-lg">
 <span className="text-muted-foreground">{t("admin_ai_system_status", "Sistem Durumu")}</span>
 <Badge className={cn("border-0",
 status?.status ==="online" ?"bg-blue-500/20 text-success" :"bg-amber-500/20 text-warning"
 )}>
 {status?.status ||"checking..."}
 </Badge>
 </div>
 <div className="flex justify-between items-center text-sm p-3 bg-card rounded-lg">
 <span className="text-muted-foreground">{t("admin_ai_active_sessions", "Aktif Oturumlar")}</span>
 <span className="font-bold text-foreground">{status?.metrics?.activeSessions ??"—"}</span>
 </div>
 <div className="flex justify-between items-center text-sm p-3 bg-card rounded-lg">
 <span className="text-muted-foreground">{t("admin_ai_pending_tasks", "Bekleyen Görevler")}</span>
 <span className="font-bold text-foreground">{status?.metrics?.pendingTasks ??"—"}</span>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground flex items-center gap-2">
 <Activity className="w-4 h-4 text-muted-foreground" />
 {t("admin_ai_usage_metrics", "Kullanım Metrikleri")}
 </CardTitle>
 </CardHeader>
 <CardContent className="space-y-4">
 <div className="flex justify-between items-center text-sm p-3 bg-card rounded-lg">
 <span className="text-muted-foreground">{t("admin_ai_total_sessions", "Toplam Oturum Sayısı")}</span>
 <span className="font-bold text-foreground">{status?.metrics?.totalSessions ??"—"}</span>
 </div>
 <div className="flex justify-between items-center text-sm p-3 bg-card rounded-lg">
 <span className="text-muted-foreground">{t("admin_ai_total_valuations", "Toplam Değerleme")}</span>
 <span className="font-bold text-foreground">{status?.metrics?.totalValuations ??"—"}</span>
 </div>
 <div className="flex justify-between items-center text-sm p-3 bg-card rounded-lg">
 <span className="text-muted-foreground">{t("admin_ai_uptime", "Çalışma süresi")}</span>
 <span className="font-bold text-foreground">
 {status?.uptime ? `${Math.floor(status.uptime / 60)}m` :"—"}
 </span>
 </div>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground flex items-center gap-2">
 <ShieldCheck className="w-4 h-4 text-success" />
 {t("admin_ai_active_models", "Aktif Modeller")}
 </CardTitle>
 </CardHeader>
 <CardContent className="space-y-4">
 <div className="flex justify-between items-center text-sm p-3 bg-card rounded-lg">
 <span className="text-muted-foreground">{t("admin_ai_valuation_model", "Değerleme / Fiyat Tahmini")}</span>
 <span className="font-medium text-foreground">{status?.models?.valuation ??"XGBoost-v4"}</span>
 </div>
 <div className="flex justify-between items-center text-sm p-3 bg-card rounded-lg">
 <span className="text-muted-foreground">{t("admin_ai_location_model", "Konum Zekası")}</span>
 <span className="font-medium text-foreground">{"GeoGraph-v2"}</span>
 </div>
 <div className="flex justify-between items-center text-sm p-3 bg-card rounded-lg">
 <span className="text-muted-foreground">{t("admin_ai_chatbot_model", "Sohbet robotu")}</span>
 <span className="font-medium text-foreground">{status?.models?.chatbot ??"—"}</span>
 </div>
 <div className="flex justify-between items-center text-sm p-3 bg-card rounded-lg">
 <span className="text-muted-foreground">{t("admin_ai_recommendation_model", "Öneri Motoru")}</span>
 <span className="font-medium text-foreground">{status?.models?.recommendation ??"—"}</span>
 </div>
 </CardContent>
 </Card>
 </div>

 <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
 <Card className="bg-card border-border overflow-hidden">
 <CardHeader className="bg-card">
 <CardTitle className="flex items-center gap-2 text-foreground">
 <Bot className="w-5 h-5 text-muted-foreground" />
 {t("admin_ai_model_fleet_status", "Model Ağı Durumu")}
 </CardTitle>
 </CardHeader>
 <CardContent className="p-0">
 <table className="w-full text-left">
 <thead>
 <tr className="border-b border-border bg-card">
 <th className="px-6 py-4 font-medium text-xs tracking-wider text-muted-foreground">
 {t("admin_ai_model_name", "Model Adı")}
 </th>
 <th className="px-6 py-4 font-medium text-xs tracking-wider text-muted-foreground">
 {t("admin_ai_type", "Tip")}
 </th>
 <th className="px-6 py-4 font-medium text-xs tracking-wider text-muted-foreground">
 {t("admin_ai_status", "Durum")}
 </th>
 <th className="px-6 py-4 font-medium text-xs tracking-wider text-muted-foreground">
 {t("admin_ai_accuracy", "Doğruluk")}
 </th>
 </tr>
 </thead>
 <tbody className="divide-y divide-white/10">
 {models.length === 0 ? (
 <tr>
 <td colSpan={4} className="px-6 py-8 text-center text-muted-foreground text-sm">
 {t("admin_ai_no_models", "Model bulunamadı")}
 </td>
 </tr>
 ) : models.slice(0, 10).map((model) => (
 <tr key={model.id} className="hover:bg-card transition-colors">
 <td className="px-6 py-4">
 <div className="flex flex-col">
 <span className="text-sm font-medium text-foreground">{model.modelName}</span>
 <span className="text-xs text-muted-foreground">{t("admin_auto_v", "v")}{model.modelVersion}</span>
 </div>
 </td>
 <td className="px-6 py-4 text-sm text-muted-foreground">{model.modelType}</td>
 <td className="px-6 py-4">
 <Badge className={cn("border-0 text-[10px]",
 model.status ==="ACTIVE" || model.status ==="Active"
 ?"bg-blue-500/20 text-success"
 : model.status ==="TRAINING" || model.status ==="Training"
 ?"bg-muted0/20 text-muted-foreground"
 :"bg-muted0/20 text-muted-foreground"
 )}>
 {model.status}
 </Badge>
 </td>
 <td className="px-6 py-4 text-sm text-foreground">
 {model.accuracy != null ? `${(model.accuracy * 100).toFixed(1)}%` :"—"}
 </td>
 </tr>
 ))}
 </tbody>
 </table>
 </CardContent>
 </Card>

 <Card className="bg-card border-border">
 <CardHeader>
 <CardTitle className="text-foreground flex items-center gap-2">
 <BarChart3 className="w-5 h-5 text-warning" />
 {t("admin_ai_model_breakdown", "Model Dağılımı")}
 </CardTitle>
 </CardHeader>
 <CardContent>
 <div className="space-y-4">
 {[
 { label: t("admin_ai_regression", "Regresyon"), count: models.filter(m => m.modelType ==="Regression").length, color:"bg-muted0" },
 { label: t("admin_ai_nlp","NLP"), count: models.filter(m => m.modelType ==="NLP").length, color:"bg-muted0" },
 { label: t("admin_ai_classification", "Sınıflandırma"), count: models.filter(m => m.modelType ==="Classification").length, color:"bg-blue-500" },
 { label: t("admin_ai_diffusion", "Difüzyon"), count: models.filter(m => m.modelType ==="Diffusion").length, color:"bg-amber-500" },
 { label: t("admin_ai_other", "Diğer"), count: models.filter(m => !["Regression","NLP","Classification","Diffusion"].includes(m.modelType)).length, color:"bg-muted0" },
 ].filter(g => g.count > 0).map((group) => (
 <div key={group.label} className="flex items-center justify-between p-3 bg-card rounded-lg">
 <div className="flex items-center gap-3">
 <div className={cn("w-3 h-3 rounded-full", group.color)} />
 <span className="text-sm text-muted-foreground">{group.label}</span>
 </div>
 <span className="text-sm font-bold text-foreground">{group.count}</span>
 </div>
 ))}
 {models.length === 0 && (
 <p className="text-center text-muted-foreground text-sm py-8">
 {t("admin_ai_no_models_data", "Model verisi mevcut değil")}
 </p>
 )}
 </div>
 </CardContent>
 </Card>
 </div>
 </div>
 );
}
