"use client";

import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { apiClient } from "@/lib/api/client";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from "@/components/ui/table";
import { Progress } from "@/components/ui/progress";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import {
  Users, Play, DollarSign, TrendingUp, Eye, Target, Search, Plus,
  Crown, Star, Trophy, Video, Camera, BarChart3, Lock, Unlock,
  Wallet, ArrowRightLeft, CreditCard, Zap, ShieldCheck, Globe,
  ChevronRight, ExternalLink, RefreshCw
} from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { cn } from "@/lib/utils";

interface CreatorProfile {
  id: string;
  displayName: string;
  bio: string;
  tier: string;
  status: string;
  totalFollowers: number;
  averageEngagementRate: number;
  totalContentViews: number;
  totalLeadsGenerated: number;
  totalConversions: number;
  conversionRate: number;
  totalEarnings: number;
  pendingPayout: number;
  platforms: { platform: string; handle: string; followers: number; engagementRate: number }[];
}

interface LiquidityPool {
  id: string;
  totalLiquidity: number;
  availableLiquidity: number;
  committedLiquidity: number;
  currency: string;
  dailyLimit: number;
  weeklyLimit: number;
  currentWeekUsage: number;
  pendingRecoupments: number;
  totalRecouped: number;
  status: string;
}

interface ZeroUpfrontCampaign {
  id: string;
  creatorId: string;
  propertyId: string;
  fundedAmount: number;
  campaignType: string;
  networks: string[];
  actualLeads: number;
  expectedLeads: number;
  actualRevenue: number;
  expectedRevenue: number;
  status: string;
  createdAt: string;
}

interface Settlement {
  id: string;
  reservationId: string;
  totalTransactionValue: number;
  platformFee: number;
  adSpendRecouped: number;
  creatorSharesPaid: number;
  agentCommissions: number;
  insurancePremiumsCollected: number;
  netSettlement: number;
  settlementStatus: string;
  createdAt: string;
}

const TIER_CONFIG: Record<string, { icon: any; color: string; bg: string }> = {
  PLATINUM: { icon: Crown, color: "text-violet-400", bg: "bg-violet-500/20" },
  GOLD: { icon: Star, color: "text-warning", bg: "bg-amber-500/20" },
  SILVER: { icon: Star, color: "text-muted-foreground", bg: "bg-muted" },
  BRONZE: { icon: Star, color: "text-warning", bg: "bg-orange-500/20" },
};

const PLATFORM_ICONS: Record<string, string> = {
  YOUTUBE: "📺", TIKTOK: "🎵", INSTAGRAM: "📸", LINKEDIN: "💼",
  WEIBO: "🔴", NAVER: "🟢", VK: "🔵", WHATSAPP: "💬",
};

export default function CreatorCommerceDashboard() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [searchTerm, setSearchTerm] = useState("");
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [activeTab, setActiveTab] = useState("creators");

  const { data: creatorsData, isLoading: creatorsLoading } = useQuery({
    queryKey: ["creators"],
    queryFn: async () => {
      const res: any = await apiClient.get("/creators");
      return (res?.data || []) as CreatorProfile[];
    },
  });

  const { data: poolData } = useQuery({
    queryKey: ["liquidity-pool"],
    queryFn: async () => {
      const res: any = await apiClient.get("/ad-liquidity-pool");
      return res?.data as LiquidityPool | undefined;
    },
  });

  const { data: campaignsData } = useQuery({
    queryKey: ["zero-upfront-campaigns"],
    queryFn: async () => {
      const res: any = await apiClient.get("/zero-upfront-campaigns");
      return (res?.data || []) as ZeroUpfrontCampaign[];
    },
  });

  const { data: settlementsData } = useQuery({
    queryKey: ["settlements"],
    queryFn: async () => {
      const res: any = await apiClient.get("/closed-loop-settlements");
      return (res?.data || []) as Settlement[];
    },
  });

  const creators = (creatorsData || []) as CreatorProfile[];
  const pool = poolData as LiquidityPool | undefined;
  const zeroUpfront = (campaignsData || []) as ZeroUpfrontCampaign[];
  const settlements = (settlementsData || []) as Settlement[];

  const stats = {
    activeCreators: creators.filter((c) => c.status === "ACTIVE").length,
    totalFollowers: creators.reduce((s, c) => s + c.totalFollowers, 0),
    totalContentViews: creators.reduce((s, c) => s + c.totalContentViews, 0),
    totalLeads: creators.reduce((s, c) => s + c.totalLeadsGenerated, 0),
    totalConversions: creators.reduce((s, c) => s + c.totalConversions, 0),
    totalEarnings: creators.reduce((s, c) => s + c.totalEarnings, 0),
    pendingPayouts: creators.reduce((s, c) => s + c.pendingPayout, 0),
    liquidityAvailable: pool?.availableLiquidity || 0,
    liquidityTotal: pool?.totalLiquidity || 0,
    activeCampaigns: zeroUpfront.filter((c) => c.status === "ACTIVE").length,
    totalSettled: settlements.reduce((s, c) => s + c.netSettlement, 0),
  };

  const filtered = creators.filter((c) =>
    c.displayName.toLowerCase().includes(searchTerm.toLowerCase()) ||
    c.id.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
      <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-rose-600 rounded-xl shadow-lg shadow-rose-600/20">
            <Users className="w-8 h-8 text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-rose-200 to-rose-500">
              {t("admin_creator_title", "Yaratıcı Ticaret ve Escrow")}
            </h1>
            <p className="text-muted-foreground">
              {t("admin_creator_subtitle", "Sıfır ön ödemeli kampanyalar, yaratıcı ödemeleri ve kapalı döngü mutabakatları")}
            </p>
          </div>
        </div>
        <div className="flex gap-3">
          <Button variant="outline" className="gap-2 bg-card border-border hover:bg-muted dark:hover:bg-card/10 text-foreground">
            <Wallet className="w-4 h-4" />
            {t("admin_creator_liquidity", "L havuz Havuzu")}
          </Button>
          <Dialog open={isCreateOpen} onOpenChange={setIsCreateOpen}>
            <DialogTrigger asChild>
              <Button className="gap-2 bg-rose-600 hover:bg-rose-700 shadow-lg shadow-rose-600/20 text-white">
                <Plus className="w-4 h-4" />
                {t("admin_creator_new_campaign", "Sıfır Ön Ödemeli Kampanya")}
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[480px] bg-background border-border text-foreground">
              <DialogHeader>
                <DialogTitle>{t("admin_creator_launch_campaign", "Sıfır Ön Ödemeli Kampanya Başlat")}</DialogTitle>
                <DialogDescription className="text-muted-foreground">
                  {t("admin_creator_launch_desc", "Reklam Likidite Havuzundan finanse edin — işlem kapanışında escrow'dan geri alın")}
                </DialogDescription>
              </DialogHeader>
              <div className="space-y-4 pt-4">
                <div className="space-y-2">
                  <Label>{t("admin_creator_select_creator", "Yaratıcı")}</Label>
                  <Select>
                    <SelectTrigger className="bg-card border-border text-foreground">
                      <SelectValue placeholder={t("admin_creator_select_placeholder", "Bir yaratıcı seçin...")} />
                    </SelectTrigger>
                    <SelectContent className="bg-background border-border">
                      {creators.filter((c) => c.status === "ACTIVE").map((c) => (
                        <SelectItem key={c.id} value={c.id}>{c.displayName} ({c.tier})</SelectItem>
                      ))}
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_creator_property_id", "Mülk Kimliği")}</Label>
                  <Input className="bg-card border-border text-foreground" placeholder={t("admin_creator_property_id_placeholder", "prop_xxx")} />
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_creator_networks", "Reklam Ağları")}</Label>
                  <div className="grid grid-cols-2 gap-2">
                    {["GOOGLE_ADS", "META_CAPI", "TIKTOK", "NAVER_SEARCH_ADS"].map((n) => (
                      <label key={n} className="flex items-center gap-2 p-2 rounded-lg bg-card border border-border cursor-pointer hover:border-rose-500/50">
                        <input type="checkbox" className="rounded" defaultChecked={n === "GOOGLE_ADS"} />
                        <span className="text-sm text-foreground">{n.replace(/_/g, " ")}</span>
                      </label>
                    ))}
                  </div>
                </div>
                <div className="p-4 bg-blue-500/10 border border-blue-500/20 rounded-xl">
                  <div className="flex items-center gap-2 mb-2">
                    <Lock className="w-4 h-4 text-success" />
                    <span className="text-sm font-semibold text-success">{t("admin_creator_zero_upfront", "Sıfır Ön Ödeme Maliyeti")}</span>
                  </div>
                  <p className="text-xs text-muted-foreground">{t("admin_creator_zero_upfront_desc", "Kampanya havuzdan finanse edilir. Başarılı işlem sonrası escrow'dan geri alınır. Platform ücreti ve yaratıcı payı kesilir.")}</p>
                </div>
              </div>
              <DialogFooter>
                <Button variant="ghost" onClick={() => setIsCreateOpen(false)} className="text-muted-foreground">{t("common.cancel", "İptal")}</Button>
                <Button className="bg-rose-600 hover:bg-rose-700 text-white" onClick={() => {
                  setIsCreateOpen(false);
                  toast({ title: "🚀 Campaign Created", description: "Zero-upfront campaign launched from Ad Liquidity Pool" });
                }}>
                  <Zap className="w-4 h-4 mr-1" /> {t("admin_creator_launch", "Kampanyayı Başlat")}
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        {[
          { label: t("admin_creator_active_creators", "Aktif Yaratıcılar"), value: stats.activeCreators, icon: Users, color: "bg-rose-500/20", iconColor: "text-rose-400" },
          { label: t("admin_creator_total_views", "Toplam İçerik Görüntüleme"), value: stats.totalContentViews.toLocaleString(), icon: Eye, color: "bg-blue-500/20", iconColor: "text-info" },
          { label: t("admin_creator_leads", "Yaratıcılardan Gelen Müşteri Adayları"), value: stats.totalLeads, icon: Target, color: "bg-blue-500/20", iconColor: "text-success" },
          { label: t("admin_creator_pool", "Mevcut Likidite"), value: `$${stats.liquidityAvailable.toLocaleString()}`, icon: Wallet, color: "bg-violet-500/20", iconColor: "text-violet-400" },
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
          <TabsTrigger value="creators" className="data-[state=active]:bg-rose-600 data-[state=active]:text-white">
            <Users className="w-4 h-4 mr-2" /> {t("admin_creator_tab_creators", "Yaratıcı Liderlik Tablosu")}
          </TabsTrigger>
          <TabsTrigger value="liquidity" className="data-[state=active]:bg-rose-600 data-[state=active]:text-white">
            <Wallet className="w-4 h-4 mr-2" /> {t("admin_creator_tab_liquidity", "Likidite Havuzu")}
          </TabsTrigger>
          <TabsTrigger value="campaigns" className="data-[state=active]:bg-rose-600 data-[state=active]:text-white">
            <Target className="w-4 h-4 mr-2" /> {t("admin_creator_tab_campaigns", "Sıfır Ön Ödeme")}
          </TabsTrigger>
          <TabsTrigger value="settlements" className="data-[state=active]:bg-rose-600 data-[state=active]:text-white">
            <DollarSign className="w-4 h-4 mr-2" /> {t("admin_creator_tab_settlements", "Mutabakatlar")}
          </TabsTrigger>
        </TabsList>

        <TabsContent value="creators" className="space-y-6">
          <div className="flex items-center gap-4">
            <div className="relative flex-1 max-w-md">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input placeholder={t("admin_creator_search", "Yaratıcı ara...")} className="bg-card border-border pl-10 text-foreground" value={searchTerm} onChange={(e) => setSearchTerm(e.target.value)} />
            </div>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {filtered.map((creator, idx) => {
              const tierCfg = TIER_CONFIG[creator.tier] || TIER_CONFIG.BRONZE;
              const TierIcon = tierCfg.icon;
              return (
                <Card key={creator.id} className="bg-card border-border hover:border-rose-500/30 transition-all">
                  <CardContent className="p-6">
                    <div className="flex items-start justify-between mb-4">
                      <div className="flex items-center gap-3">
                        <div className="relative">
                          <div className={cn("w-12 h-12 rounded-full flex items-center justify-center text-xl font-bold", tierCfg.bg, tierCfg.color)}>
                            {creator.displayName.charAt(0)}
                          </div>
                          <div className="absolute -top-1 -right-1">
                            <Badge className={cn("border-0 text-[8px] px-1", tierCfg.bg, tierCfg.color)}>
                              <TierIcon className="w-2 h-2 mr-0.5" /> {creator.tier}
                            </Badge>
                          </div>
                        </div>
                        <div>
                          <h4 className="text-sm font-semibold text-foreground">{creator.displayName}</h4>
                          <p className="text-xs text-muted-foreground">{creator.bio?.slice(0, 50)}...</p>
                        </div>
                      </div>
                      <Badge className={cn("border-0", creator.status === "ACTIVE" ? "bg-blue-500/20 text-success" : "bg-muted0/20 text-muted-foreground")}>
                        {creator.status}
                      </Badge>
                    </div>

                    <div className="flex gap-2 mb-4">
                      {(creator.platforms || []).slice(0, 4).map((p) => (
                        <Badge key={p.platform} className="border-0 bg-card text-muted-foreground text-[10px]">
                          {PLATFORM_ICONS[p.platform] || "🌐"} {p.followers?.toLocaleString()}
                        </Badge>
                      ))}
                    </div>

                    <div className="grid grid-cols-3 gap-4 mb-4">
                      <div className="text-center p-2 bg-card rounded-lg">
                        <p className="text-xs text-muted-foreground">{t("admin_creator_followers", "Takipçiler")}</p>
                        <p className="text-sm font-bold text-foreground">{(creator.totalFollowers / 1000).toFixed(0)}K</p>
                      </div>
                      <div className="text-center p-2 bg-card rounded-lg">
                        <p className="text-xs text-muted-foreground">{t("admin_creator_leads_col", "Müşteri Adayları")}</p>
                        <p className="text-sm font-bold text-foreground">{creator.totalLeadsGenerated}</p>
                      </div>
                      <div className="text-center p-2 bg-card rounded-lg">
                        <p className="text-xs text-muted-foreground">{t("admin_creator_conv", "Dönüşüm Oranı")}</p>
                        <p className="text-sm font-bold text-foreground">{creator.conversionRate?.toFixed(1)}%</p>
                      </div>
                    </div>

                    <div className="flex items-center justify-between p-3 bg-card rounded-lg">
                      <div>
                        <p className="text-xs text-muted-foreground">{t("admin_creator_earnings", "Toplam Kazanç")}</p>
                        <p className="text-sm font-bold text-foreground">${creator.totalEarnings.toLocaleString()}</p>
                      </div>
                      <div className="text-right">
                        <p className="text-xs text-muted-foreground">{t("admin_creator_pending", "Bekleyen Ödeme")}</p>
                        <p className="text-sm font-bold text-warning">${creator.pendingPayout.toLocaleString()}</p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              );
            })}
          </div>
        </TabsContent>

        <TabsContent value="liquidity" className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <Card className="bg-card border-border md:col-span-2">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <Wallet className="w-5 h-5 text-violet-400" />
                  {t("admin_creator_pool_overview", "Reklam Likidite Havuzu Durumu")}
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-6">
                <div className="grid grid-cols-2 gap-6">
                  <div>
                    <p className="text-xs text-muted-foreground mb-1">{t("admin_creator_total_pool", "Toplam Likidite")}</p>
                    <h3 className="text-3xl font-bold text-foreground">${stats.liquidityTotal.toLocaleString()}</h3>
                  </div>
                  <div>
                    <p className="text-xs text-muted-foreground mb-1">{t("admin_creator_available", "Mevcut")}</p>
                    <h3 className="text-3xl font-bold text-success">${stats.liquidityAvailable.toLocaleString()}</h3>
                  </div>
                </div>
                {pool && (
                  <>
                    <div>
                      <div className="flex justify-between text-sm mb-1">
                        <span className="text-muted-foreground">{t("admin_creator_utilization", "Havuz Kullanımı")}</span>
                        <span className="font-bold text-foreground">{pool.totalLiquidity > 0 ? ((pool.committedLiquidity / pool.totalLiquidity) * 100).toFixed(1) : 0}%</span>
                      </div>
                      <Progress value={pool.totalLiquidity > 0 ? (pool.committedLiquidity / pool.totalLiquidity) * 100 : 0} className="h-3" />
                    </div>
                    <div className="grid grid-cols-2 gap-4">
                      <div className="p-4 bg-card rounded-xl border border-border">
                        <p className="text-xs text-muted-foreground">{t("admin_creator_daily_limit", "Günlük Limit")}</p>
                        <p className="text-lg font-bold text-foreground">${pool.dailyLimit.toLocaleString()}</p>
                      </div>
                      <div className="p-4 bg-card rounded-xl border border-border">
                        <p className="text-xs text-muted-foreground">{t("admin_creator_weekly_usage", "Haftalık Kullanım")}</p>
                        <p className="text-lg font-bold text-foreground">${pool.currentWeekUsage.toLocaleString()}</p>
                      </div>
                      <div className="p-4 bg-card rounded-xl border border-border">
                        <p className="text-xs text-muted-foreground">{t("admin_creator_pending_recoup", "Bekleyen Geri Alımlar")}</p>
                        <p className="text-lg font-bold text-warning">{pool.pendingRecoupments}</p>
                      </div>
                      <div className="p-4 bg-card rounded-xl border border-border">
                        <p className="text-xs text-muted-foreground">{t("admin_creator_total_recouped", "Toplam Geri Alınan")}</p>
                        <p className="text-lg font-bold text-success">${pool.totalRecouped.toLocaleString()}</p>
                      </div>
                    </div>
                  </>
                )}
                {!pool && (
                  <div className="text-center py-8">
                    <p className="text-muted-foreground">{t("admin_creator_no_pool", "Likidite havuzu verisi mevcut değil")}</p>
                    <Button className="mt-4 bg-violet-600 hover:bg-violet-700 text-white" size="sm">
                      <Wallet className="w-4 h-4 mr-1" /> {t("admin_creator_fund_pool", "Likidite Havuzunu Finanse Et")}
                    </Button>
                  </div>
                )}
              </CardContent>
            </Card>

            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <ShieldCheck className="w-5 h-5 text-success" />
                  {t("admin_creator_recoup_model", "Geri Alma Modeli")}
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-4">
                <div className="p-4 bg-card rounded-xl border border-border">
                  <h4 className="text-sm font-semibold text-foreground mb-2">{t("admin_creator_how_it_works", "Nasıl Çalışır")}</h4>
                  <div className="space-y-3">
                    {[
                      { step: "1", label: t("admin_creator_step1", "Kampanya Finanse Edildi"), desc: t("admin_creator_step1_desc", "Reklam Likidite Havuzundan"), icon: Wallet, color: "text-violet-400" },
                      { step: "2", label: t("admin_creator_step2", "Müşteri Adayları Üretildi"), desc: t("admin_creator_step2_desc", "Yaratıcı içerik müşteri adayı sağlar"), icon: Target, color: "text-cyan-400" },
                      { step: "3", label: t("admin_creator_step3", "İşlem Kapanır"), desc: t("admin_creator_step3_desc", "Escrow depozitosu alındı"), icon: Lock, color: "text-warning" },
                      { step: "4", label: t("admin_creator_step4", "Fonlar Geri Alındı"), desc: t("admin_creator_step4_desc", "Reklam harcaması ve ücretleri kesildi"), icon: DollarSign, color: "text-success" },
                    ].map((s) => (
                      <div key={s.step} className="flex items-center gap-3">
                        <div className={cn("w-8 h-8 rounded-full flex items-center justify-center text-xs font-bold bg-card border border-border", s.color)}>
                          {s.step}
                        </div>
                        <div>
                          <p className="text-sm font-medium text-foreground">{s.label}</p>
                          <p className="text-xs text-muted-foreground">{s.desc}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="campaigns" className="space-y-6">
          <Card className="bg-card border-border overflow-hidden">
            <CardContent className="p-0">
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader className="bg-card border-b border-border">
                    <TableRow className="hover:bg-transparent border-none">
                      <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_creator_prop", "Mülk")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_type", "Tür")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_funded", "Finanse Edilen")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_leads_progress", "Müşteri Adayları")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_revenue_progress", "Gelir")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_status", "Durum")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_date", "Tarih")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {zeroUpfront.length === 0 ? (
                      <TableRow><TableCell colSpan={7} className="text-center py-8 text-muted-foreground">{t("admin_creator_no_campaigns", "Henüz sıfır ön ödemeli kampanya yok")}</TableCell></TableRow>
                    ) : zeroUpfront.map((c) => (
                      <TableRow key={c.id} className="border-b border-border hover:bg-card transition-colors">
                        <TableCell className="py-4 px-6 text-sm font-mono text-foreground">{c.propertyId.slice(0, 12)}...</TableCell>
                        <TableCell className="px-6"><Badge className="border-0 bg-rose-500/20 text-rose-400 text-[10px]">{c.campaignType.replace(/_/g, " ")}</Badge></TableCell>
                        <TableCell className="px-6 text-sm font-bold text-foreground">${c.fundedAmount.toLocaleString()}</TableCell>
                        <TableCell className="px-6">
                          <div className="flex items-center gap-2">
                            <Progress value={c.expectedLeads > 0 ? (c.actualLeads / c.expectedLeads) * 100 : 0} className="w-16 h-1.5" />
                            <span className="text-xs text-foreground">{c.actualLeads}/{c.expectedLeads}</span>
                          </div>
                        </TableCell>
                        <TableCell className="px-6 text-sm font-bold text-foreground">${c.actualRevenue.toLocaleString()}</TableCell>
                        <TableCell className="px-6">
                          <Badge className={cn("border-0 text-[10px]", c.status === "ACTIVE" ? "bg-blue-500/20 text-success" : c.status === "FULLY_RECOUPED" ? "bg-blue-500/20 text-info" : "bg-muted0/20 text-muted-foreground")}>
                            {c.status.replace(/_/g, " ")}
                          </Badge>
                        </TableCell>
                        <TableCell className="px-6 text-xs text-muted-foreground">{new Date(c.createdAt).toLocaleDateString()}</TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="settlements" className="space-y-6">
          <Card className="bg-card border-border overflow-hidden">
            <CardContent className="p-0">
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader className="bg-card border-b border-border">
                    <TableRow className="hover:bg-transparent border-none">
                      <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_creator_settlement_id", "Mutabakat")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_tx_value", "İşlem Değeri")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_platform_fee", "Platform Ücreti")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_ad_recoup", "Reklam Geri Alma")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_creator_share", "Yaratıcı Payı")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_insurance", "Sigorta")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_net", "Net Mutabakat")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_creator_status", "Durum")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {settlements.length === 0 ? (
                      <TableRow><TableCell colSpan={8} className="text-center py-8 text-muted-foreground">{t("admin_creator_no_settlements", "Henüz mutabakat işlenmemiş")}</TableCell></TableRow>
                    ) : settlements.map((s) => (
                      <TableRow key={s.id} className="border-b border-border hover:bg-card transition-colors">
                        <TableCell className="py-4 px-6 text-sm font-mono text-foreground">{s.id.slice(0, 10)}...</TableCell>
                        <TableCell className="px-6 text-sm font-bold text-foreground">${s.totalTransactionValue.toLocaleString()}</TableCell>
                        <TableCell className="px-6 text-sm text-warning">-${s.platformFee.toLocaleString()}</TableCell>
                        <TableCell className="px-6 text-sm text-cyan-400">-${s.adSpendRecouped.toLocaleString()}</TableCell>
                        <TableCell className="px-6 text-sm text-rose-400">-${s.creatorSharesPaid.toLocaleString()}</TableCell>
                        <TableCell className="px-6 text-sm text-violet-400">${s.insurancePremiumsCollected.toLocaleString()}</TableCell>
                        <TableCell className="px-6 text-sm font-bold text-success">${s.netSettlement.toLocaleString()}</TableCell>
                        <TableCell className="px-6">
                          <Badge className={cn("border-0 text-[10px]", s.settlementStatus === "COMPLETED" ? "bg-blue-500/20 text-success" : s.settlementStatus === "PROCESSING" ? "bg-amber-500/20 text-warning" : "bg-muted0/20 text-muted-foreground")}>
                            {s.settlementStatus}
                          </Badge>
                        </TableCell>
                      </TableRow>
                    ))}
                  </TableBody>
                </Table>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
