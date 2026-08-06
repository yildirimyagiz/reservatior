"use client";

import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { aiLearningApi } from "@/lib/api/ai-learning";
import { 
  Brain,
  TrendingUp,
  Target,
  BarChart3,
  Activity,
  Zap,
  ArrowUpRight,
  ArrowDownRight,
  Settings,
  Download,
  RefreshCw,
  CheckCircle,
  Clock,
  LineChart,
  Layers
} from "lucide-react";
import { tEnum } from "@/lib/admin-enums";

export default function AILearningDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const [selectedLoop, setSelectedLoop] = useState<"campaign" | "price" | "negotiation" | "portfolio">("campaign");
  const { t } = useTranslation();

  const { data: learningStats, isLoading } = useQuery({
    queryKey: ["ai-learning-dashboard", orgId, selectedLoop],
    queryFn: () => aiLearningApi.getStats(orgId, selectedLoop),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatPercent = (val: number) => `${val.toFixed(1)}%`;

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = learningStats || {
    totalIterations: 0,
    accuracyImprovement: 0,
    modelVersion: 0,
    lastRetrained: "",
    predictionAccuracy: 0,
    learningRate: 0,
  };

  const kpis = [
    { title: t("admin_ai_learning_total_iterations", "Toplam Yineleme"), value: formatNumber(stats.totalIterations), icon: RefreshCw, color: "text-blue-600", trend: "+45.2%" },
    { title: t("admin_ai_learning_accuracy_improvement", "Doğruluk İyileştirmesi"), value: formatPercent(stats.accuracyImprovement), icon: TrendingUp, color: "text-blue-600", trend: "+12.8%" },
    { title: t("admin_ai_learning_model_version", "Model Sürümü"), value: `v${stats.modelVersion.toFixed(1)}`, icon: Layers, color: "text-brand", trend: t("admin_ai_learning_latest", "En Güncel") },
    { title: t("admin_ai_learning_prediction_accuracy", "Tahmin Doğruluğu"), value: formatPercent(stats.predictionAccuracy), icon: Target, color: "text-orange-600", trend: "+5.3%" },
    { title: t("admin_ai_learning_learning_rate", "Öğrenme Oranı"), value: formatPercent(stats.learningRate), icon: Zap, color: "text-brand", trend: "+8.7%" },
    { title: t("admin_ai_learning_last_retrained", "Son Yeniden Eğitim"), value: stats.lastRetrained, icon: Clock, color: "text-pink-600", trend: "2h ago" },
  ];

  const learningLoops = [
    { id: "campaign", name: "Campaign Learning", status: "active", accuracy: 0.92, iterations: 234, lastUpdate: "1h ago" },
    { id: "price", name: "Price Learning", status: "active", accuracy: 0.89, iterations: 189, lastUpdate: "3h ago" },
    { id: "negotiation", name: "Negotiation Learning", status: "training", accuracy: 0.85, iterations: 145, lastUpdate: "5h ago" },
    { id: "portfolio", name: "Portfolio Learning", status: "active", accuracy: 0.91, iterations: 267, lastUpdate: "2h ago" },
  ];

  const learningMetrics = [
    { metric: "ROAS Optimization", current: 2.8, target: 3.5, progress: 80, trend: "up" },
    { metric: "Price Accuracy", current: 0.89, target: 0.95, progress: 94, trend: "up" },
    { metric: "Conversion Rate", current: 0.12, target: 0.15, progress: 80, trend: "up" },
    { metric: "Cost Reduction", current: 0.08, target: 0.12, progress: 67, trend: "up" },
  ];

  const recentImprovements = [
    { loop: "Campaign Learning", improvement: "+15%", metric: "ROAS", date: "2h ago" },
    { loop: "Price Learning", improvement: "+8%", metric: "Accuracy", date: "4h ago" },
    { loop: "Negotiation Learning", improvement: "+12%", metric: "Success Rate", date: "6h ago" },
    { loop: "Portfolio Learning", improvement: "+10%", metric: "ROI", date: "8h ago" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_ai_learning_title", "Yapay Zeka Öğrenme Döngüleri Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_ai_learning_desc", "Sürekli yapay zeka iyileştirmesi ve model yeniden eğitimi")}</p>
        </div>
        <div className="flex gap-3">
          <select 
            value={selectedLoop} 
            onChange={(e) => setSelectedLoop(e.target.value as "campaign" | "price" | "negotiation" | "portfolio")}
            className="px-4 py-2 border border-border rounded-lg bg-card"
          >
            <option value="campaign">{t("admin_ai_learning_campaign_learning", "Kampanya Öğrenmesi")}</option>
            <option value="price">{t("admin_ai_learning_price_learning", "Fiyat Öğrenmesi")}</option>
            <option value="negotiation">{t("admin_ai_learning_negotiation_learning", "Müzakere Öğrenmesi")}</option>
            <option value="portfolio">{t("admin_ai_learning_portfolio_learning", "Portföy Öğrenmesi")}</option>
          </select>
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
            <RefreshCw className="w-4 h-4" /> {t("admin_ai_learning_retrain_models", "Modelleri Yeniden Eğit")}
          </button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-muted-foreground">{kpi.title}</p>
                  <p className="text-2xl font-bold text-foreground mt-2">{kpi.value}</p>
                  <p className="text-sm text-blue-600 mt-1">{kpi.trend}</p>
                </div>
                <div className={`p-3 bg-muted rounded-lg ${kpi.color}`}>
                  <Icon className="w-6 h-6" />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
              <Brain className="w-5 h-5 text-brand" /> {t("admin_ai_learning_active_loops", "Aktif Öğrenme Döngüleri")}
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-muted-foreground" /></button>
          </div>
          <div className="space-y-3">
            {learningLoops.map((loop) => (
              <div 
                key={loop.id}
                onClick={() => setSelectedLoop(loop.id as "campaign" | "price" | "negotiation" | "portfolio")}
                className={`p-4 rounded-lg cursor-pointer transition ${
                  selectedLoop === loop.id ? "bg-blue-50 border-2 border-blue-500" : "bg-muted border-2 border-transparent hover:bg-gray-100"
                }`}
              >
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-3">
                    <span className="font-medium text-foreground">{loop.name}</span>
                    <span className={`text-xs px-2 py-1 rounded-full ${
                      loop.status === "active" ? "bg-blue-100 text-blue-700" : "bg-yellow-100 text-yellow-700"
                    }`}>{tEnum(t, loop.status)}</span>
                  </div>
                  <span className="text-sm font-bold text-foreground">{loop.accuracy.toFixed(0)}%</span>
                </div>
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">{loop.iterations} {t("admin_ai_learning_iterations", "yineleme")}</span>
                  <span className="text-muted-foreground">{loop.lastUpdate}</span>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
              <Activity className="w-5 h-5 text-orange-600" /> {t("admin_ai_learning_metrics", "Öğrenme Metrikleri")}
            </h2>
            <button className="p-2 hover:bg-gray-100 rounded-lg"><Download className="w-4 h-4 text-muted-foreground" /></button>
          </div>
          <div className="space-y-3">
            {learningMetrics.map((metric, i) => (
              <div key={i} className="p-4 bg-muted rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-medium text-foreground">{metric.metric}</span>
                  <div className="flex items-center gap-2">
                    <span className="text-sm text-muted-foreground">{metric.current.toFixed(2)}</span>
                    {metric.trend === "up" ? <ArrowUpRight className="w-4 h-4 text-blue-600" /> : <ArrowDownRight className="w-4 h-4 text-red-600" />}
                  </div>
                </div>
                <div className="flex items-center gap-3">
                  <div className="flex-1 bg-gray-200 rounded-full h-2">
                    <div className="bg-orange-500 h-2 rounded-full" style={{ width: `${metric.progress}%` }} />
                  </div>
                  <span className="text-xs text-muted-foreground">{metric.progress}%</span>
                </div>
                <p className="text-xs text-muted-foreground mt-1">{t("admin_ai_learning_target", "Hedef:")} {metric.target.toFixed(2)}</p>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
            <Zap className="w-5 h-5 text-yellow-600" /> {t("admin_ai_learning_recent_improvements", "Son İyileştirmeler")}
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><RefreshCw className="w-4 h-4 text-muted-foreground" /></button>
        </div>
        <div className="space-y-3">
          {recentImprovements.map((improvement, i) => (
            <div key={i} className="flex items-center justify-between p-4 bg-blue-50 rounded-lg border border-blue-200">
              <div className="flex items-center gap-3">
                <CheckCircle className="w-5 h-5 text-blue-600" />
                <div>
                  <p className="font-medium text-blue-900">{improvement.loop}</p>
                  <p className="text-sm text-blue-700">{improvement.metric} {t("admin_ai_learning_improvement", "iyileştirme")}</p>
                </div>
              </div>
              <div className="text-right">
                <span className="text-lg font-bold text-blue-600">{improvement.improvement}</span>
                <p className="text-xs text-blue-600">{improvement.date}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
            <LineChart className="w-5 h-5 text-brand" /> {t("admin_ai_learning_progress_visualization", "Öğrenme İlerleme Görselleştirmesi")}
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-muted-foreground" /></button>
        </div>
        <div className="h-64 bg-gradient-to-br from-brand/10 to-indigo-100 rounded-lg flex items-center justify-center">
          <div className="text-center">
            <BarChart3 className="w-12 h-12 mx-auto mb-3 text-brand" />
            <p className="text-lg font-semibold text-brand">{t("admin_ai_learning_progress_chart", "Yapay Zeka Öğrenme İlerleme Grafiği")}</p>
            <p className="text-sm text-brand mt-1">{t("admin_ai_learning_progress_chart_desc", "Zaman içinde model doğruluğu ve performansı")}</p>
          </div>
        </div>
      </div>
    </div>
  );
}
