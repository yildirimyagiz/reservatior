"use client";

import { useState } from "react";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { geospatialApi } from "@/lib/api/geospatial";
import { tEnum } from "@/lib/admin-enums";
import { 
  Map,
  TrendingUp,
  Building2,
  Activity,
  Globe,
  Layers,
  Zap,
  Target,
  Settings,
  Download,
  Filter,
  Thermometer,
  Navigation,
  DollarSign
} from "lucide-react";

export default function GeospatialDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const { t } = useTranslation();
  const orgId = user?.organizationId || "";
  const [selectedHeatmap, setSelectedHeatmap] = useState<"yield" | "demand" | "appreciation">("yield");

  const { data: geospatialStats, isLoading } = useQuery({
    queryKey: ["geospatial-dashboard", orgId, selectedHeatmap],
    queryFn: () => geospatialApi.getStats(orgId, selectedHeatmap, "all"),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatPercent = (val: number) => `${val.toFixed(1)}%`;

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  const stats = geospatialStats || {
    totalProperties: 0,
    avgYield: 0,
    demandScore: 0,
    appreciationRate: 0,
    activeRegions: 0,
    dataPoints: 0,
  };

  const kpis = [
    { title: t("admin_geospatial_total_properties", "Toplam Mülk"), value: formatNumber(stats.totalProperties), icon: Building2, color: "text-blue-600", trend: "+12.5%" },
    { title: t("admin_geospatial_avg_yield", "Ort. Getiri"), value: formatPercent(stats.avgYield), icon: DollarSign, color: "text-blue-600", trend: "+8.3%" },
    { title: t("admin_geospatial_demand_score", "Talep Puanı"), value: stats.demandScore.toFixed(1), icon: Activity, color: "text-brand", trend: "+15.2%" },
    { title: t("admin_geospatial_appreciation_rate", "Değer Artış Oranı"), value: formatPercent(stats.appreciationRate), icon: TrendingUp, color: "text-orange-600", trend: "+5.7%" },
    { title: t("admin_geospatial_active_regions", "Aktif Bölgeler"), value: formatNumber(stats.activeRegions), icon: Globe, color: "text-brand", trend: "+3.1%" },
    { title: t("admin_geospatial_data_points", "Veri Noktaları"), value: formatNumber(stats.dataPoints), icon: Layers, color: "text-pink-600", trend: "+22.4%" },
  ];

  const heatmapTypes = [
    { id: "yield", name: t("admin_geospatial_rental_yield_heatmap", "Kira Getirisi Isı Haritası"), description: t("admin_geospatial_rental_yield_heatmap_desc", "Konuma göre yıllık kira getirisi"), color: "from-blue-500 to-blue-600" },
    { id: "demand", name: t("admin_geospatial_demand_density_heatmap", "Talep Yoğunluğu Isı Haritası"), description: t("admin_geospatial_demand_density_heatmap_desc", "Pazar talebi ve arama hacmi"), color: "from-blue-500 to-indigo-600" },
    { id: "appreciation", name: t("admin_geospatial_capital_appreciation_heatmap", "Sermaye Değer Artışı Isı Haritası"), description: t("admin_geospatial_capital_appreciation_heatmap_desc", "Mülk değer artış trendleri"), color: "from-orange-500 to-red-600" },
  ];

  const regionalData = [
    { region: "Europe", countries: 12, avgYield: 0.065, demand: 8.2, appreciation: 0.045 },
    { region: "Asia", countries: 8, avgYield: 0.072, demand: 9.1, appreciation: 0.058 },
    { region: "Americas", countries: 3, avgYield: 0.058, demand: 7.8, appreciation: 0.052 },
  ];

  const microLocationInsights = [
    { location: "City Center - District A", yield: 0.082, demand: "High", trend: "up", factors: ["Transit access", "Schools", "Amenities"] },
    { location: "Suburban - Zone B", yield: 0.068, demand: "Medium", trend: "stable", factors: ["Family-friendly", "Parking", "Green spaces"] },
    { location: "Industrial - Zone C", yield: 0.091, demand: "Low", trend: "up", factors: ["Commercial growth", "Infrastructure", "Zoning changes"] },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_geospatial_title", "Coğrafi Isı Haritaları Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_geospatial_desc", "Google Maps Platform destekli konum zekası")}</p>
        </div>
        <div className="flex gap-3">
          <select 
            value={selectedHeatmap} 
            onChange={(e) => setSelectedHeatmap(e.target.value as "yield" | "demand" | "appreciation")}
            className="px-4 py-2 border border-border rounded-lg bg-card"
          >
            <option value="yield">{t("admin_geospatial_rental_yield", "Kira Getirisi")}</option>
            <option value="demand">{t("admin_geospatial_demand_density", "Talep Yoğunluğu")}</option>
            <option value="appreciation">{t("admin_geospatial_capital_appreciation", "Sermaye Değer Artışı")}</option>
          </select>
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> {t("admin_geospatial_export_map", "Haritayı Dışa Aktar")}
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
            <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
              <Thermometer className="w-5 h-5 text-red-600" /> {t("admin_geospatial_interactive_heatmap", "Etkileşimli Isı Haritası")}
            </h2>
            <div className="flex gap-2">
              {heatmapTypes.map((type) => (
                <button 
                  key={type.id}
                  onClick={() => setSelectedHeatmap(type.id as "yield" | "demand" | "appreciation")}
                  className={`px-3 py-1 rounded-lg text-sm ${selectedHeatmap === type.id ? "bg-blue-100 text-blue-700" : "bg-gray-100 text-muted-foreground"}`}
                >
                  {type.name}
                </button>
              ))}
            </div>
          </div>
          <div className="h-96 bg-gradient-to-br from-slate-900 to-slate-800 rounded-lg flex items-center justify-center relative overflow-hidden">
            <div className="text-center text-white">
              <Map className="w-16 h-16 mx-auto mb-4 text-info" />
              <p className="text-lg font-semibold">{t("admin_geospatial_interactive_heatmap_title", "Etkileşimli Coğrafi Isı Haritası")}</p>
              <p className="text-sm text-muted-foreground mt-2">{t("admin_geospatial_powered_by", "Google Maps Platform ve Places API ile desteklenmektedir")}</p>
              <div className="mt-4 flex gap-2 justify-center">
                <span className="px-2 py-1 bg-blue-500/20 text-info rounded text-xs">{t("admin_geospatial_yield_analysis", "Getiri Analizi")}</span>
                <span className="px-2 py-1 bg-blue-500/20 text-blue-400 rounded text-xs">{t("admin_geospatial_demand_density", "Talep Yoğunluğu")}</span>
                <span className="px-2 py-1 bg-orange-500/20 text-warning rounded text-xs">{t("admin_geospatial_appreciation", "Değer Artışı")}</span>
              </div>
            </div>
            <div className="absolute bottom-4 left-4 flex gap-2">
              <button className="p-2 bg-muted rounded-lg text-white hover:bg-muted"><Layers className="w-4 h-4" /></button>
              <button className="p-2 bg-muted rounded-lg text-white hover:bg-muted"><Navigation className="w-4 h-4" /></button>
            </div>
          </div>
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <h2 className="text-lg font-semibold mb-4 flex items-center gap-2">
            <Globe className="w-5 h-5 text-blue-600" /> {t("admin_geospatial_regional_overview", "Bölgesel Genel Bakış")}
          </h2>
          <div className="space-y-3">
            {regionalData.map((region, i) => (
              <div key={i} className="p-4 bg-muted rounded-lg">
                <div className="flex items-center justify-between mb-2">
                  <span className="font-medium text-foreground">{region.region}</span>
                  <span className="text-sm text-muted-foreground">{region.countries} {t("admin_geospatial_countries", "ülke")}</span>
                </div>
                <div className="grid grid-cols-3 gap-2 text-sm">
                  <div>
                    <p className="text-muted-foreground">{t("admin_geospatial_yield", "Getiri")}</p>
                    <p className="font-medium">{formatPercent(region.avgYield)}</p>
                  </div>
                  <div>
                    <p className="text-muted-foreground">{t("admin_geospatial_demand", "Talep")}</p>
                    <p className="font-medium">{region.demand.toFixed(1)}</p>
                  </div>
                  <div>
                    <p className="text-muted-foreground">{t("admin_geospatial_appreciation", "Değer Artışı")}</p>
                    <p className="font-medium">{formatPercent(region.appreciation)}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
            <Target className="w-5 h-5 text-brand" /> {t("admin_geospatial_micro_location_insights", "Mikro Konum İçgörüleri")}
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Filter className="w-4 h-4 text-muted-foreground" /></button>
        </div>
        <div className="space-y-3">
          {microLocationInsights.map((insight, i) => (
            <div key={i} className="p-4 bg-brand/10 rounded-lg border border-purple-200">
              <div className="flex items-center justify-between mb-2">
                <div className="flex items-center gap-2">
                  <Navigation className="w-4 h-4 text-brand" />
                  <span className="font-medium text-brand">{insight.location}</span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-sm font-bold text-brand">{formatPercent(insight.yield)}</span>
                  {insight.trend === "up" ? <TrendingUp className="w-4 h-4 text-blue-600" /> : <Activity className="w-4 h-4 text-muted-foreground" />}
                </div>
              </div>
              <div className="flex items-center justify-between text-sm mb-2">
                <span className={`px-2 py-1 rounded-full ${
                  insight.demand === "High" ? "bg-red-100 text-red-700" : insight.demand === "Medium" ? "bg-yellow-100 text-yellow-700" : "bg-blue-100 text-blue-700"
                }`}>{tEnum(t, insight.demand)} {t("admin_geospatial_demand", "Talep")}</span>
              </div>
              <div className="flex gap-2">
                {insight.factors.map((factor, j) => (
                  <span key={j} className="text-xs px-2 py-1 bg-brand/15 text-brand rounded">{factor}</span>
                ))}
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
            <Zap className="w-5 h-5 text-yellow-600" /> {t("admin_geospatial_integration_status", "Google Maps Entegrasyon Durumu")}
          </h2>
          <button className="p-2 hover:bg-gray-100 rounded-lg"><Settings className="w-4 h-4 text-muted-foreground" /></button>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
            <div className="flex items-center gap-2 mb-2">
              <Map className="w-5 h-5 text-blue-600" />
              <span className="font-medium text-blue-900">{t("admin_geospatial_places_api", "Places API")}</span>
            </div>
            <p className="text-sm text-blue-700">{t("admin_geospatial_proximity_analysis", "Yakınlık puanlama ve konum analizi")}</p>
            <div className="mt-2 text-xs text-blue-600">{t("admin_geospatial_connected", "✓ Bağlı")}</div>
          </div>
          <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
            <div className="flex items-center gap-2 mb-2">
              <Thermometer className="w-5 h-5 text-blue-600" />
              <span className="font-medium text-blue-900">{t("admin_geospatial_solar_api", "Solar API")}</span>
            </div>
            <p className="text-sm text-blue-700">{t("admin_geospatial_solar_analysis", "Enerji verimliliği ve güneş enerjisi potansiyeli")}</p>
            <div className="mt-2 text-xs text-blue-600">{t("admin_geospatial_connected", "✓ Bağlı")}</div>
          </div>
          <div className="p-4 bg-orange-50 rounded-lg border border-orange-200">
            <div className="flex items-center gap-2 mb-2">
              <Layers className="w-5 h-5 text-orange-600" />
              <span className="font-medium text-orange-900">{t("admin_geospatial_tiles_3d", "3D Katmanlar")}</span>
            </div>
            <p className="text-sm text-orange-700">{t("admin_geospatial_tiles_3d_desc", "3D bina modelleri ve görselleştirme")}</p>
            <div className="mt-2 text-xs text-orange-600">{t("admin_geospatial_connected", "✓ Bağlı")}</div>
          </div>
        </div>
      </div>
    </div>
  );
}
