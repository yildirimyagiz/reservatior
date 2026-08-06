"use client";

import { useTranslation } from "react-i18next";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { digitalTwinApi } from "@/lib/api/digital-twin";
import { 
  Copy, 
  Play, 
  BarChart3,
  CheckCircle,
  Box,
  Layers,
  Zap,
  Brain,
  Globe,
  TrendingUp,
  Target,
  Settings,
  Eye,
  Download,
  Share2
} from "lucide-react";
import { tEnum } from "@/lib/admin-enums";

export default function DigitalTwinDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const [selectedTwin, setSelectedTwin] = useState<string | null>(null);
  const [viewMode, setViewMode] = useState<"3d" | "layers" | "analytics">("3d");
  const { t } = useTranslation();

  const { data: twinStats, isLoading } = useQuery({
    queryKey: ["digital-twin-dashboard", orgId],
    queryFn: () => digitalTwinApi.getStats(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = twinStats || {
    totalTwins: 0,
    activeSimulations: 0,
    completedSimulations: 0,
    avgAccuracy: 0,
    syncStatus: 0,
    aiInsights: 0,
    spatialLayers: 0,
    predictionAccuracy: 0,
  };

  const kpis = [
    { title: t("admin_digital_twin_digital_twins", "Dijital İkizler"), value: formatNumber(stats.totalTwins), icon: Copy, color: "text-blue-600", trend: "+12.5%" },
    { title: t("admin_digital_twin_active_simulations", "Aktif Simülasyonlar"), value: formatNumber(stats.activeSimulations), icon: Play, color: "text-blue-600", trend: "+25.3%" },
    { title: t("admin_digital_twin_completed", "Tamamlandı"), value: formatNumber(stats.completedSimulations), icon: CheckCircle, color: "text-brand", trend: "+18.7%" },
    { title: t("admin_digital_twin_avg_accuracy", "Ort. Doğruluk"), value: `${stats.avgAccuracy.toFixed(1)}%`, icon: BarChart3, color: "text-orange-600", trend: "+5.2%" },
    { title: t("admin_digital_twin_ai_insights", "Yapay Zeka İçgörüleri"), value: formatNumber(stats.aiInsights), icon: Brain, color: "text-brand", trend: "+32.1%" },
    { title: t("admin_digital_twin_spatial_layers", "Mekansal Katmanlar"), value: formatNumber(stats.spatialLayers), icon: Layers, color: "text-pink-600", trend: "+15.7%" },
  ];

  const activeTwins = [
    { id: "twin-1", name: "Property Twin #123", type: "Residential", status: "Synced", accuracy: 94.5, lastSync: "2 min ago" },
    { id: "twin-2", name: "Commercial Twin #45", type: "Commercial", status: "Synced", accuracy: 91.2, lastSync: "5 min ago" },
    { id: "twin-3", name: "Land Twin #78", type: "Land", status: "Syncing", accuracy: 87.8, lastSync: "Processing" },
  ];

  const simulationResults = [
    { name: "Performance Optimization", value: "+15%", icon: TrendingUp, color: "text-blue-600" },
    { name: "Cost Reduction", value: "-8%", icon: Target, color: "text-brand" },
    { name: "Lead Conversion", value: "+12%", icon: Zap, color: "text-pink-600" },
    { name: "Revenue Prediction", value: "+22%", icon: Globe, color: "text-orange-600" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_digital_twin_title", "Dijital İkiz Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_digital_twin_desc", "Yapay zeka destekli 3D mülk modelleme ve mekansal zeka")}</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
            <Box className="w-4 h-4" /> {t("admin_digital_twin_create_twin", "Dijital İkiz Oluştur")}
          </button>
          <button className="px-4 py-2 border border-border rounded-lg hover:bg-muted transition flex items-center gap-2">
            <Download className="w-4 h-4" /> {t("admin_digital_twin_export", "Dışa Aktar")}
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

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <div className="lg:col-span-2 bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_digital_twin_viewer_title", "3D İkiz Görüntüleyici")}</h2>
            <div className="flex gap-2">
              <button onClick={() => setViewMode("3d")} className={`px-3 py-1 rounded-lg text-sm ${viewMode === "3d" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-muted-foreground"}`}>
                <Eye className="w-4 h-4 inline mr-1" /> {t("admin_digital_twin_view_3d", "3D Görünüm")}
              </button>
              <button onClick={() => setViewMode("layers")} className={`px-3 py-1 rounded-lg text-sm ${viewMode === "layers" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-muted-foreground"}`}>
                <Layers className="w-4 h-4 inline mr-1" /> {t("admin_digital_twin_layers", "Katmanlar")}
              </button>
              <button onClick={() => setViewMode("analytics")} className={`px-3 py-1 rounded-lg text-sm ${viewMode === "analytics" ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-muted-foreground"}`}>
                <BarChart3 className="w-4 h-4 inline mr-1" /> {t("admin_digital_twin_analytics", "Analitik")}
              </button>
            </div>
          </div>
          <div className="h-96 bg-gradient-to-br from-slate-900 to-slate-800 rounded-lg flex items-center justify-center relative overflow-hidden">
            <div className="text-center text-white">
              <Box className="w-16 h-16 mx-auto mb-4 text-info" />
              <p className="text-lg font-semibold">{t("admin_digital_twin_model_viewer", "3D Mülk Modeli Görüntüleyici")}</p>
              <p className="text-sm text-muted-foreground mt-2">{t("admin_digital_twin_powered_by", "Vertex AI ve Gemini Multimodal ile desteklenmektedir")}</p>
              <div className="mt-4 flex gap-2 justify-center">
                <span className="px-2 py-1 bg-blue-500/20 text-info rounded text-xs">{t("admin_digital_twin_spatial_reasoning", "Mekansal Muhakeme")}</span>
                <span className="px-2 py-1 bg-blue-500/20 text-blue-400 rounded text-xs">{t("admin_digital_twin_ai_analysis", "Yapay Zeka Analizi")}</span>
                <span className="px-2 py-1 bg-brand/20 text-brand rounded text-xs">{t("admin_digital_twin_realtime_sync", "Gerçek Zamanlı Senkronizasyon")}</span>
              </div>
            </div>
            <div className="absolute bottom-4 left-4 flex gap-2">
              <button className="p-2 bg-muted rounded-lg text-white hover:bg-muted"><Settings className="w-4 h-4" /></button>
              <button className="p-2 bg-muted rounded-lg text-white hover:bg-muted"><Share2 className="w-4 h-4" /></button>
            </div>
          </div>
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <h2 className="text-lg font-semibold mb-4">{t("admin_digital_twin_active_twins", "Aktif İkizler")}</h2>
          <div className="space-y-3">
            {activeTwins.map((twin) => (
              <div 
                key={twin.id}
                onClick={() => setSelectedTwin(twin.id)}
                className={`p-4 rounded-lg cursor-pointer transition ${
                  selectedTwin === twin.id ? "bg-blue-50 border-2 border-blue-500" : "bg-muted border-2 border-transparent hover:bg-gray-100"
                }`}
              >
                <div className="flex items-center justify-between mb-2">
                  <span className="font-medium text-foreground">{twin.name}</span>
                  <span className={`text-xs px-2 py-1 rounded-full ${
                    twin.status === "Synced" ? "bg-blue-100 text-blue-700" : "bg-yellow-100 text-yellow-700"
                  }`}>{tEnum(t, twin.status)}</span>
                </div>
                <div className="flex items-center justify-between text-sm">
                  <span className="text-muted-foreground">{tEnum(t, twin.type)}</span>
                  <span className="text-muted-foreground">{twin.accuracy.toFixed(1)}% {t("admin_digital_twin_accuracy", "doğruluk")}</span>
                </div>
                <div className="text-xs text-gray-400 mt-1">{twin.lastSync}</div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
            <Brain className="w-5 h-5 text-brand" /> {t("admin_digital_twin_ai_powered_insights", "Yapay Zeka Destekli İçgörüler")}
          </h2>
          <div className="space-y-3">
            <div className="p-4 bg-brand/10 rounded-lg border border-purple-200">
              <div className="flex items-center gap-2 mb-2">
                <Zap className="w-4 h-4 text-brand" />
                <span className="font-medium text-brand">{t("admin_digital_twin_spatial_analysis", "Mekansal Analiz")}</span>
              </div>
              <p className="text-sm text-brand">{t("admin_digital_twin_insight_spatial_detail", "Mülk düzeni doğal ışık ve havalandırma için optimize edilmiştir. Potansiyel enerji tasarrufu: %23")}</p>
            </div>
            <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
              <div className="flex items-center gap-2 mb-2">
                <Target className="w-4 h-4 text-blue-600" />
                <span className="font-medium text-blue-900">{t("admin_digital_twin_market_positioning", "Pazar Konumlandırması")}</span>
              </div>
              <p className="text-sm text-blue-700">{t("admin_digital_twin_insight_market_detail", "Bölgedeki karşılaştırılabilir mülkler %15 fiyat artış potansiyeline işaret ediyor.")}</p>
            </div>
            <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
              <div className="flex items-center gap-2 mb-2">
                <TrendingUp className="w-4 h-4 text-blue-600" />
                <span className="font-medium text-blue-900">{t("admin_digital_twin_investment_potential", "Yatırım Potansiyeli")}</span>
              </div>
              <p className="text-sm text-blue-700">{t("admin_digital_twin_insight_investment_detail", "Pazar trendlerine dayalı 5 yılda %12,5 yatırım getirisi öngörülüyor.")}</p>
            </div>
          </div>
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <h2 className="text-lg font-semibold mb-4">{t("admin_digital_twin_simulation_results", "Simülasyon Sonuçları")}</h2>
          <div className="space-y-3">
            {simulationResults.map((result, i) => {
              const Icon = result.icon;
              return (
                <div key={i} className="flex items-center justify-between p-4 bg-muted rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className={`p-2 rounded-lg ${result.color.replace("text-", "bg-").replace("600", "100")}`}>
                      <Icon className={`w-5 h-5 ${result.color}`} />
                    </div>
                    <span className="font-medium text-foreground">{result.name}</span>
                  </div>
                  <span className={`font-bold ${result.color}`}>{result.value}</span>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </div>
  );
}
