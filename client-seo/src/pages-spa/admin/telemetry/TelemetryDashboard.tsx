"use client";

import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Progress } from "@/components/ui/progress";
import { ScrollArea } from "@/components/ui/scroll-area";
import {
  Activity, Zap, Trophy, Target, BarChart3, Bell, CheckCircle2,
  AlertTriangle, Clock, Flame, Star, Shield, Brain, TrendingUp,
  Globe, RefreshCw, ChevronRight, Sparkles, Award, Gift, Eye, Users
} from "lucide-react";
import { useGrowthEngineStore } from "@/lib/store/growth-engine-store";
import { useTelemetryStream } from "@/hooks/use-telemetry-stream";
import { cn } from "@/lib/utils";

interface TelemetryEvent {
  id: string;
  type: string;
  emoji: string;
  title: string;
  description: string;
  severity: string;
  timestamp: string;
  acknowledged: boolean;
}

interface GamificationState {
  totalPoints: number;
  level: number;
  levelName: string;
  nextLevelPoints: number;
  achievements: { id: string; name: string; description: string; emoji: string; points: number; tier: string; unlocked: boolean; progress: number; target: number }[];
  unlockedCount: number;
  totalAchievements: number;
  streak: number;
}

interface GrowthSummary {
  spatialAnalytics: { propertiesAnalyzed: number; defectsFound: number; healthReportsGenerated: number; virtualStagesCreated: number; insurancePoliciesAttached: number };
  adRouter: { totalSpend: number; totalRevenue: number; overallROAS: number; networkShifts: number; arbitrageSavings: number; rebateSavings: number; activeCampaigns: number };
  creatorCommerce: { activeCreators: number; totalContentViews: number; leadsFromCreators: number; creatorConversions: number; liquidityPoolUtilization: number; zeroUpfrontCampaigns: number };
  escrow: { totalLocked: number; totalReleased: number; totalRecouped: number; pendingSettlements: number; disputesOpen: number };
}

interface ConversionFunnel {
  propertyViews: number;
  leadCaptures: number;
  qualifiedLeads: number;
  viewingsScheduled: number;
  applicationsSubmitted: number;
  escrowDeposits: number;
  transactionsClosed: number;
  overallConversionRate: number;
  averageCycleDays: number;
}

const EVENT_EMOJI_MAP: Record<string, string> = {
  AD_BUDGET_SHIFTED: "⚡", PROPERTY_ANALYZED: "🔍", DEFECT_DETECTED: "⚠️",
  INSURANCE_ATTACHED: "🛡️", LEAD_CAPTURED: "💬", DEPOSIT_SECURED: "🔒",
  BROCHURE_GENERATED: "📄", VIDEO_LOCALIZED: "🎬", CAMPAIGN_LAUNCHED: "🚀",
  CREATIVE_OPTIMIZED: "✨", CONVERSION_TRACKED: "📈", ESCROW_FUNDED: "💰",
  PAYOUT_PROCESSED: "💳", ARBITRAGE_COMPLETED: "🔀", REBATE_APPLIED: "🎁",
  STAGE_GENERATED: "🏠", HEALTH_REPORT_CREATED: "📋", OFFLINE_CONVERSION_SYNCED: "🔄",
};

const SEVERITY_CONFIG: Record<string, { class: string }> = {
  INFO: { class: "bg-blue-500/20 text-info" },
  SUCCESS: { class: "bg-blue-500/20 text-success" },
  WARNING: { class: "bg-amber-500/20 text-warning" },
  ERROR: { class: "bg-red-500/20 text-red-400" },
};

const TIER_COLORS: Record<string, string> = {
  BRONZE: "bg-orange-500/20 text-warning", SILVER: "bg-muted text-muted-foreground",
  GOLD: "bg-amber-500/20 text-warning", PLATINUM: "bg-violet-500/20 text-violet-400",
};

export default function TelemetryDashboard() {
  const { t } = useTranslation();
  const [activeTab, setActiveTab] = useState("telemetry");
  const { liveEvents, summary, gamification, setSummary, setGamification, acknowledgeEvent } = useGrowthEngineStore();

  const { connected } = useTelemetryStream("org_1");

  const { data: summaryData } = useQuery({
    queryKey: ["growth-summary"],
    queryFn: async () => {
      const res: any = await apiClient.get("/growth-engine/summary");
      return res?.data as GrowthSummary | undefined;
    },
    refetchInterval: 30000,
  });

  const { data: gamificationData } = useQuery({
    queryKey: ["gamification-state"],
    queryFn: async () => {
      const res: any = await apiClient.get("/gamification/state");
      return res?.data as GamificationState | undefined;
    },
    refetchInterval: 60000,
  });

  const { data: funnelData } = useQuery({
    queryKey: ["conversion-funnel"],
    queryFn: async () => {
      const res: any = await apiClient.get("/growth-engine/funnel");
      return res?.data as ConversionFunnel | undefined;
    },
  });

  const { data: eventsData } = useQuery({
    queryKey: ["telemetry-feed"],
    queryFn: async () => {
      const res: any = await apiClient.get("/telemetry/feed", { limit: 50 });
      return (res?.data?.events || []) as TelemetryEvent[];
    },
  });

  useEffect(() => { if (summaryData) setSummary(summaryData as any); }, [summaryData, setSummary]);
  useEffect(() => { if (gamificationData) setGamification(gamificationData as any); }, [gamificationData, setGamification]);

  const s = summary as GrowthSummary | undefined;
  const g = gamification as GamificationState | undefined;
  const funnel = funnelData as ConversionFunnel | undefined;
  const events = (eventsData || []) as TelemetryEvent[];

  const displayEvents = liveEvents.length > 0 ? liveEvents.slice(0, 30) : events;

  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
      <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-amber-600 rounded-xl shadow-lg shadow-amber-600/20">
            <Activity className="w-8 h-8 text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-amber-200 to-amber-500">
              {t("admin_telemetry_title", "Telemetri ve Oyunlaştırma")}
            </h1>
            <p className="text-muted-foreground">
              {t("admin_telemetry_subtitle", "Canlı uygulama izi, başarılar ve dönüşüm hunisi")}
            </p>
          </div>
        </div>
        <div className="flex items-center gap-3">
          <Badge className={cn("border-0 px-3 py-1.5", connected ? "bg-blue-500/20 text-success" : "bg-red-500/20 text-red-400")}>
            <span className={cn("w-2 h-2 rounded-full mr-1.5", connected ? "bg-blue-400 animate-pulse" : "bg-red-400")} />
            {connected ? t("admin_telemetry_live", "CANLI") : t("admin_telemetry_offline", "ÇEVRIMDIŞI")}
          </Badge>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        {[
          { label: t("admin_telemetry_events_today", "Bugünkü Olaylar"), value: s?.adRouter?.activeCampaigns || events.length, icon: Activity, color: "bg-amber-500/20", iconColor: "text-warning" },
          { label: t("admin_telemetry_points", "Oyunlaştırma Puanları"), value: g?.totalPoints || 0, icon: Trophy, color: "bg-violet-500/20", iconColor: "text-violet-400" },
          { label: t("admin_telemetry_achievements", "Başarılar"), value: g ? `${g.unlockedCount}/${g.totalAchievements}` : "0/0", icon: Award, color: "bg-blue-500/20", iconColor: "text-success" },
          { label: t("admin_telemetry_streak", "Aktivite Serisi"), value: `${g?.streak || 0}d`, icon: Flame, color: "bg-rose-500/20", iconColor: "text-rose-400" },
        ].map((kpi, i) => (
          <Card key={i} className="bg-card border-border">
            <CardContent className="p-6">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-xs font-medium text-muted-foreground">{kpi.label}</p>
                  <h3 className="text-2xl font-bold text-foreground mt-1">{kpi.value}</h3>
                </div>
                <div className={cn("p-3 rounded-lg", kpi.color)}>
                  <kpi.icon className={cn("w-5 h-5", kpi.iconColor)} />
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      <Tabs value={activeTab} onValueChange={setActiveTab}>
        <TabsList className="bg-card border border-border">
          <TabsTrigger value="telemetry" className="data-[state=active]:bg-amber-600 data-[state=active]:text-white">
            <Activity className="w-4 h-4 mr-2" /> {t("admin_telemetry_tab_feed", "Canlı Akış")}
          </TabsTrigger>
          <TabsTrigger value="achievements" className="data-[state=active]:bg-amber-600 data-[state=active]:text-white">
            <Trophy className="w-4 h-4 mr-2" /> {t("admin_telemetry_tab_achievements", "Başarılar")}
          </TabsTrigger>
          <TabsTrigger value="funnel" className="data-[state=active]:bg-amber-600 data-[state=active]:text-white">
            <BarChart3 className="w-4 h-4 mr-2" /> {t("admin_telemetry_tab_funnel", "Dönüşüm Hunisi")}
          </TabsTrigger>
          <TabsTrigger value="overview" className="data-[state=active]:bg-amber-600 data-[state=active]:text-white">
            <Globe className="w-4 h-4 mr-2" /> {t("admin_telemetry_tab_overview", "Motor Özeti")}
          </TabsTrigger>
        </TabsList>

        <TabsContent value="telemetry" className="space-y-6">
          <Card className="bg-card border-border">
            <CardHeader>
              <CardTitle className="text-foreground flex items-center gap-2">
                <Bell className="w-5 h-5 text-warning" />
                {t("admin_telemetry_realtime_feed", "Gerçek Zamanlı Uygulama İzi")}
              </CardTitle>
            </CardHeader>
            <CardContent>
              <ScrollArea className="h-[600px]">
                <div className="space-y-3">
                  {displayEvents.length === 0 ? (
                    <div className="text-center py-12">
                      <Activity className="w-10 h-10 mx-auto text-muted-foreground mb-3" />
                      <p className="text-muted-foreground">{t("admin_telemetry_no_events", "Olaylar bekleniyor...")}</p>
                    </div>
                  ) : displayEvents.map((event, idx) => {
                    const emoji = event.emoji || EVENT_EMOJI_MAP[event.type] || "📌";
                    const sevCfg = SEVERITY_CONFIG[event.severity] || SEVERITY_CONFIG.INFO;
                    return (
                      <div
                        key={event.id || idx}
                        className={cn(
                          "flex items-start gap-4 p-4 rounded-xl border transition-all hover:bg-card/50",
                          event.acknowledged ? "border-border opacity-60" : "border-border"
                        )}
                      >
                        <span className="text-2xl mt-0.5 shrink-0">{emoji}</span>
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2 mb-1">
                            <h4 className="text-sm font-semibold text-foreground">{event.title}</h4>
                            <Badge className={cn("border-0 text-[10px]", sevCfg.class)}>{event.severity}</Badge>
                          </div>
                          <p className="text-xs text-muted-foreground">{event.description}</p>
                          <p className="text-xs text-muted-foreground mt-1">{new Date(event.timestamp).toLocaleString()}</p>
                        </div>
                        {!event.acknowledged && (
                          <Button
                            size="sm"
                            variant="ghost"
                            className="text-xs text-muted-foreground hover:text-foreground"
                            onClick={() => acknowledgeEvent(event.id)}
                           aria-label={t("common.verify")}>
                            <CheckCircle2 className="w-3 h-3" />
                          </Button>
                        )}
                      </div>
                    );
                  })}
                </div>
              </ScrollArea>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="achievements" className="space-y-6">
          {g && (
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <Trophy className="w-5 h-5 text-warning" />
                  {t("admin_telemetry_level_progress", "Seviye İlerlemesi")}
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="flex items-center gap-6 mb-6">
                  <div className="text-center">
                    <div className="w-20 h-20 rounded-full bg-gradient-to-br from-amber-500 to-amber-700 flex items-center justify-center">
                      <span className="text-2xl font-bold text-white">{g.level}</span>
                    </div>
                    <p className="text-xs text-muted-foreground mt-2">{g.levelName}</p>
                  </div>
                  <div className="flex-1">
                    <div className="flex justify-between text-sm mb-1">
                      <span className="text-muted-foreground">{t("admin_telemetry_xp", "Deneyim Puanları")}</span>
                      <span className="font-bold text-foreground">{g.totalPoints} / {g.nextLevelPoints}</span>
                    </div>
                    <Progress value={g.nextLevelPoints > 0 ? (g.totalPoints / g.nextLevelPoints) * 100 : 0} className="h-4" />
                  </div>
                </div>
              </CardContent>
            </Card>
          )}

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {(g?.achievements || []).map((ach) => (
              <Card key={ach.id} className={cn("bg-card border-border transition-all", ach.unlocked ? "border-amber-500/30 shadow-lg shadow-amber-500/10" : "")}>
                <CardContent className="p-6">
                  <div className="flex items-start justify-between mb-3">
                    <span className="text-3xl">{ach.emoji}</span>
                    <Badge className={cn("border-0 text-[10px]", TIER_COLORS[ach.tier] || "")}>{ach.tier}</Badge>
                  </div>
                  <h4 className="text-sm font-semibold text-foreground mb-1">{ach.name}</h4>
                  <p className="text-xs text-muted-foreground mb-3">{ach.description}</p>
                  <div className="flex items-center justify-between mb-1">
                    <span className="text-xs text-muted-foreground">{ach.progress}/{ach.target}</span>
                    <span className="text-xs font-bold text-foreground">{ach.points} {t("admin_telemetry_pts", "puan")}</span>
                  </div>
                  <Progress value={ach.target > 0 ? (ach.progress / ach.target) * 100 : 0} className="h-2" />
                  {ach.unlocked && (
                    <Badge className="mt-3 border-0 bg-amber-500/20 text-warning">
                      <CheckCircle2 className="w-3 h-3 mr-1" /> {t("admin_telemetry_unlocked", "Kilidi Açıldı")}
                    </Badge>
                  )}
                </CardContent>
              </Card>
            ))}
          </div>
        </TabsContent>

        <TabsContent value="funnel" className="space-y-6">
          {funnel ? (
            <>
              <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
                {[
                  { label: t("admin_telemetry_property_views", "Mülk Görüntüleme"), value: funnel.propertyViews, color: "from-blue-500 to-blue-700" },
                  { label: t("admin_telemetry_lead_captures", "Müşteri Adayı Yakalama"), value: funnel.leadCaptures, color: "from-cyan-500 to-cyan-700" },
                  { label: t("admin_telemetry_qualified_leads", "Nitelikli Müşteri Adayları"), value: funnel.qualifiedLeads, color: "from-violet-500 to-violet-700" },
                  { label: t("admin_telemetry_transactions", "Kapanan İşlemler"), value: funnel.transactionsClosed, color: "from-blue-500 to-blue-700" },
                ].map((stage, i) => (
                  <Card key={i} className={cn("bg-gradient-to-br text-white border-0", stage.color)}>
                    <CardContent className="p-6">
                      <p className="text-sm opacity-80">{stage.label}</p>
                      <h3 className="text-3xl font-bold mt-1">{stage.value.toLocaleString()}</h3>
                    </CardContent>
                  </Card>
                ))}
              </div>

              <Card className="bg-card border-border">
                <CardHeader>
                  <CardTitle className="text-foreground flex items-center gap-2">
                    <BarChart3 className="w-5 h-5 text-cyan-400" />
                    {t("admin_telemetry_funnel_visual", "Dönüşüm Hunisi")}
                  </CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="space-y-4">
                    {[
                      { label: t("admin_telemetry_stage_views", "Mülk Görüntüleme"), count: funnel.propertyViews, max: funnel.propertyViews },
                      { label: t("admin_telemetry_stage_captures", "Müşteri Adayı Yakalama"), count: funnel.leadCaptures, max: funnel.propertyViews },
                      { label: t("admin_telemetry_stage_qualified", "Nitelikli Müşteri Adayları"), count: funnel.qualifiedLeads, max: funnel.propertyViews },
                      { label: t("admin_telemetry_stage_viewings", "Planlanan Görüşmeler"), count: funnel.viewingsScheduled, max: funnel.propertyViews },
                      { label: t("admin_telemetry_stage_applications", "Başvurular"), count: funnel.applicationsSubmitted, max: funnel.propertyViews },
                      { label: t("admin_telemetry_stage_escrow", "Escrow Depozitoları"), count: funnel.escrowDeposits, max: funnel.propertyViews },
                      { label: t("admin_telemetry_stage_closed", "Kapanan"), count: funnel.transactionsClosed, max: funnel.propertyViews },
                    ].map((stage, i) => (
                      <div key={i} className="flex items-center gap-4">
                        <span className="text-sm text-muted-foreground w-40 shrink-0">{stage.label}</span>
                        <div className="flex-1">
                          <Progress value={stage.max > 0 ? (stage.count / stage.max) * 100 : 0} className="h-6" />
                        </div>
                        <span className="text-sm font-bold text-foreground w-16 text-right">{stage.count.toLocaleString()}</span>
                      </div>
                    ))}
                  </div>
                  <div className="flex items-center justify-between mt-6 p-4 bg-card rounded-xl border border-border">
                    <div>
                      <p className="text-xs text-muted-foreground">{t("admin_telemetry_overall_conv", "Genel Dönüşüm Oranı")}</p>
                      <p className="text-xl font-bold text-foreground">{funnel.overallConversionRate?.toFixed(2)}%</p>
                    </div>
                    <div className="text-right">
                      <p className="text-xs text-muted-foreground">{t("admin_telemetry_avg_cycle", "Ort. Satış Döngüsü")}</p>
                      <p className="text-xl font-bold text-foreground">{funnel.averageCycleDays} {t("admin_telemetry_days", "gün")}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </>
          ) : (
            <Card className="bg-card border-border">
              <CardContent className="py-12 text-center">
                <BarChart3 className="w-10 h-10 mx-auto text-muted-foreground mb-3" />
                <p className="text-muted-foreground">{t("admin_telemetry_no_funnel", "Huni verisi mevcut değil")}</p>
              </CardContent>
            </Card>
          )}
        </TabsContent>

        <TabsContent value="overview" className="space-y-6">
          {s && (
            <>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                <Card className="bg-card border-border">
                  <CardHeader>
                    <CardTitle className="text-sm text-foreground flex items-center gap-2">
                      <Eye className="w-4 h-4 text-violet-400" /> {t("admin_telemetry_spatial", "Mekansal Analitik")}
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-2">
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_analyzed", "Analiz Edilen")}</span><span className="font-bold text-foreground">{s.spatialAnalytics.propertiesAnalyzed}</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_defects", "Kusurlar")}</span><span className="font-bold text-foreground">{s.spatialAnalytics.defectsFound}</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_stages", "Aşamalar")}</span><span className="font-bold text-foreground">{s.spatialAnalytics.virtualStagesCreated}</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_policies", "Poliçeler")}</span><span className="font-bold text-foreground">{s.spatialAnalytics.insurancePoliciesAttached}</span></div>
                  </CardContent>
                </Card>
                <Card className="bg-card border-border">
                  <CardHeader>
                    <CardTitle className="text-sm text-foreground flex items-center gap-2">
                      <Zap className="w-4 h-4 text-cyan-400" /> {t("admin_telemetry_ads", "Reklam Yönlendirici")}
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-2">
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_spend", "Harcama")}</span><span className="font-bold text-foreground">${s.adRouter.totalSpend.toLocaleString()}</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_roas", "ROAS")}</span><span className="font-bold text-success">{s.adRouter.overallROAS?.toFixed(1)}x</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_shifts", "Kaydırmalar")}</span><span className="font-bold text-foreground">{s.adRouter.networkShifts}</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_savings", "Tasarruflar")}</span><span className="font-bold text-success">${(s.adRouter.arbitrageSavings + s.adRouter.rebateSavings).toLocaleString()}</span></div>
                  </CardContent>
                </Card>
                <Card className="bg-card border-border">
                  <CardHeader>
                    <CardTitle className="text-sm text-foreground flex items-center gap-2">
                      <Users className="w-4 h-4 text-rose-400" /> {t("admin_telemetry_creators", "Yaratıcı Ticareti")}
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-2">
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_active_creators", "Yaratıcılar")}</span><span className="font-bold text-foreground">{s.creatorCommerce.activeCreators}</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_views", "Görüntülemeler")}</span><span className="font-bold text-foreground">{(s.creatorCommerce.totalContentViews / 1000).toFixed(0)}K</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_creator_leads", "Müşteri Adayları")}</span><span className="font-bold text-foreground">{s.creatorCommerce.leadsFromCreators}</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_zu_campaigns", "Sıfır Ön Ödeme")}</span><span className="font-bold text-foreground">{s.creatorCommerce.zeroUpfrontCampaigns}</span></div>
                  </CardContent>
                </Card>
                <Card className="bg-card border-border">
                  <CardHeader>
                    <CardTitle className="text-sm text-foreground flex items-center gap-2">
                      <Shield className="w-4 h-4 text-warning" /> {t("admin_telemetry_escrow", "SafeStay™ Escrow Güvencesi")}
                    </CardTitle>
                  </CardHeader>
                  <CardContent className="space-y-2">
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_locked", "Kilitli")}</span><span className="font-bold text-foreground">${s.escrow.totalLocked.toLocaleString()}</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_released", "Serbest Bırakılan")}</span><span className="font-bold text-success">${s.escrow.totalReleased.toLocaleString()}</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_recouped", "Geri Alınan")}</span><span className="font-bold text-foreground">${s.escrow.totalRecouped.toLocaleString()}</span></div>
                    <div className="flex justify-between text-sm"><span className="text-muted-foreground">{t("admin_telemetry_disputes", "Uyuşmazlıklar")}</span><span className="font-bold text-warning">{s.escrow.disputesOpen}</span></div>
                  </CardContent>
                </Card>
              </div>
            </>
          )}
        </TabsContent>
      </Tabs>
    </div>
  );
}
