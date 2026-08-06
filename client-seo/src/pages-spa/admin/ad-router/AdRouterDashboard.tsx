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
  Radio, Globe, TrendingUp, TrendingDown, DollarSign, Zap, Search,
  ArrowRightLeft, BarChart3, Target, AlertCircle, CheckCircle2,
  Pause, Play, Settings, RefreshCw, ChevronRight, Eye, Network, Wifi,
  WifiOff, ArrowUpRight, ArrowDownRight, Brain, Shuffle
} from "lucide-react";
import { useToast } from "@/hooks/use-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogTrigger, DialogFooter, DialogDescription } from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { cn } from "@/lib/utils";
import { useAdRouterStore } from "@/lib/store/ad-router-store";
import { useArbitrageEngine } from "@/hooks/use-arbitrage-engine";

interface AdCampaign {
  id: string;
  name: string;
  objective: string;
  status: string;
  networks: string[];
  totalBudget: number;
  spentAmount: number;
  currency: string;
  startDate: string;
  endDate?: string;
  performance: {
    impressions: number;
    clicks: number;
    ctr: number;
    conversions: number;
    cpc: number;
    spend: number;
    roas: number;
    qualifiedLeads: number;
    executedTransactions: number;
    cpet: number;
    cpql: number;
    networkBreakdown: {
      network: string;
      impressions: number;
      clicks: number;
      conversions: number;
      cpc: number;
      spend: number;
      roas: number;
      healthScore: number;
      cpet: number;
    }[];
  };
}

interface AdNetworkConfig {
  network: string;
  category: string;
  isEnabled: boolean;
  accountId: string;
  currency: string;
  monthlyBudgetCap: number;
  dailyBudgetCap: number;
  status: string;
  lastSyncAt: string;
  connectedRegions: string[];
}

interface BudgetShift {
  id: string;
  campaignId: string;
  fromNetwork: string;
  toNetwork: string;
  amount: number;
  reason: string;
  cpetBefore: number;
  cpetAfter: number;
  triggeredBy: string;
  timestamp: string;
}

const NETWORK_LABELS: Record<string, string> = {
  GOOGLE_ADS: "Google Ads", META_CAPI: "Meta CAPI", TIKTOK: "TikTok",
  LINKEDIN: "LinkedIn", MICROSOFT_BING: "Microsoft Bing", BAIDU_MARKETING: "Baidu Marketing",
  NAVER_SEARCH_ADS: "Naver Search Ads", YAHOO_JAPAN: "Yahoo! Japan",
  YANDEX_DIRECT: "Yandex Direct", WHATSAPP_BUSINESS: "WhatsApp Business",
};

const NETWORK_COLORS: Record<string, string> = {
  GOOGLE_ADS: "bg-blue-500/20 text-info", META_CAPI: "bg-brand/20 text-brand",
  TIKTOK: "bg-pink-500/20 text-pink-400", LINKEDIN: "bg-sky-500/20 text-sky-400",
  MICROSOFT_BING: "bg-blue-500/20 text-blue-400", BAIDU_MARKETING: "bg-red-500/20 text-red-400",
  NAVER_SEARCH_ADS: "bg-blue-500/20 text-blue-400", YAHOO_JAPAN: "bg-brand/20 text-brand",
  YANDEX_DIRECT: "bg-red-400/20 text-red-300", WHATSAPP_BUSINESS: "bg-blue-500/20 text-success",
};

const STATUS_CONFIG: Record<string, { class: string; icon: any }> = {
  ACTIVE: { class: "bg-blue-500/20 text-success", icon: Play },
  PAUSED: { class: "bg-amber-500/20 text-warning", icon: Pause },
  DRAFT: { class: "bg-muted0/20 text-muted-foreground", icon: Eye },
  COMPLETED: { class: "bg-blue-500/20 text-info", icon: CheckCircle2 },
  PENDING_REVIEW: { class: "bg-orange-500/20 text-warning", icon: AlertCircle },
  SCHEDULED: { class: "bg-violet-500/20 text-violet-400", icon: Target },
};

export default function AdRouterDashboard() {
  const { t } = useTranslation();
  const { toast } = useToast();
  const queryClient = useQueryClient();
  const [searchTerm, setSearchTerm] = useState("");
  const [isCreateOpen, setIsCreateOpen] = useState(false);
  const [networkFilter, setNetworkFilter] = useState("ALL");
  const [activeTab, setActiveTab] = useState("campaigns");
  const { autoArbitrageEnabled } = useAdRouterStore();
  const { executeAutoArbitrage } = useArbitrageEngine();

  const { data: campaignsData, isLoading: campaignsLoading } = useQuery({
    queryKey: ["ad-campaigns"],
    queryFn: async () => {
      const res: any = await apiClient.get("/ad-campaigns");
      return (res?.data || []) as AdCampaign[];
    },
  });

  const { data: networksData } = useQuery({
    queryKey: ["ad-networks"],
    queryFn: async () => {
      const res: any = await apiClient.get("/ad-networks");
      return (res?.data || []) as AdNetworkConfig[];
    },
  });

  const { data: shiftsData } = useQuery({
    queryKey: ["ad-budget-shifts"],
    queryFn: async () => {
      const res: any = await apiClient.get("/ad-budget-shifts");
      return (res?.data || []) as BudgetShift[];
    },
  });

  const { data: arbitrageData } = useQuery({
    queryKey: ["ad-arbitrage-report"],
    queryFn: async () => {
      const res: any = await apiClient.get("/ad-arbitrage/report");
      return res;
    },
  });

  const campaigns = (campaignsData || []) as AdCampaign[];
  const networks = (networksData || []) as AdNetworkConfig[];
  const shifts = (shiftsData || []) as BudgetShift[];
  const arbitrage = arbitrageData as any;

  const stats = {
    activeCampaigns: campaigns.filter((c) => c.status === "ACTIVE").length,
    totalSpend: campaigns.reduce((s, c) => s + c.spentAmount, 0),
    totalRevenue: campaigns.reduce((s, c) => s + (c.performance?.spend * (c.performance?.roas || 0) / 100 || 0), 0),
    overallROAS: campaigns.length > 0 ? campaigns.reduce((s, c) => s + (c.performance?.roas || 0), 0) / campaigns.length : 0,
    connectedNetworks: networks.filter((n) => n.isEnabled).length,
    totalShifts: shifts.length,
    savingsFromArbitrage: arbitrage?.savingsFromArbitrage || 0,
    savingsFromRebates: arbitrage?.savingsFromRebates || 0,
  };

  const filtered = campaigns.filter((c) => {
    const matchesSearch = c.name.toLowerCase().includes(searchTerm.toLowerCase()) || c.id.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesNetwork = networkFilter === "ALL" || c.networks.includes(networkFilter);
    return matchesSearch && matchesNetwork;
  });

  const createMutation = useMutation({
    mutationFn: async (data: any) => apiClient.post("/ad-campaigns", data),
    onSuccess: () => {
      setIsCreateOpen(false);
      queryClient.invalidateQueries({ queryKey: ["ad-campaigns"] });
      toast({ title: t("admin_adrouter_campaign_created", "⚡ Kampanya Oluşturuldu"), description: t("admin_adrouter_campaign_created_desc", "Seçilen ağlarda yeni reklam kampanyası başlatıldı") });
    },
    onError: (err: any) => toast({ title: t("admin_common_error", "Hata"), description: err.message, variant: "destructive" }),
  });

  const arbitrageMutation = useMutation({
    mutationFn: async (campaignId: string) => apiClient.post(`/ad-campaigns/${campaignId}/arbitrage`),
    onSuccess: (res: any) => {
      queryClient.invalidateQueries({ queryKey: ["ad-budget-shifts"] });
      const savings = res?.savings || 0;
      toast({ title: t("admin_adrouter_budget_shifted", "⚡ Reklam Bütçesi Otomatik Kaydırıldı!"), description: t("admin_adrouter_arb_saved_desc", "Arbitrage saved ${{amount}} by reallocating to lower-CPET networks", { amount: savings.toFixed(2) }) });
    },
    onError: (err: any) => toast({ title: t("admin_common_error", "Hata"), description: err.message, variant: "destructive" }),
  });

  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-6 min-h-screen">
      <div className="flex justify-between items-center bg-card p-6 rounded-2xl border border-border">
        <div className="flex items-center gap-4">
          <div className="p-3 bg-cyan-600 rounded-xl shadow-lg shadow-cyan-600/20">
            <Radio className="w-8 h-8 text-white" />
          </div>
          <div>
            <h1 className="text-3xl font-bold tracking-tight text-foreground bg-clip-text text-transparent bg-gradient-to-r from-cyan-200 to-cyan-500">
              {t("admin_adrouter_title", "Evrensel Reklam Yönlendirici ve Arbitraj")}
            </h1>
            <p className="text-muted-foreground">
              {t("admin_adrouter_subtitle", "Yapay zeka destekli bütçe arbitrajı ve hacim indirimleriyle çok kanallı reklam yönetimi")}
            </p>
          </div>
        </div>
        <div className="flex gap-3">
          <Badge className={cn("border-0 px-3 py-1.5", autoArbitrageEnabled ? "bg-blue-500/20 text-success" : "bg-muted0/20 text-muted-foreground")}>
            <Zap className="w-3 h-3 mr-1" />
            {autoArbitrageEnabled ? t("admin_adrouter_auto_arb_on", "Oto-Arb Açık") : t("admin_adrouter_auto_arb_off", "Oto-Arb Kapalı")}
          </Badge>
          <Dialog open={isCreateOpen} onOpenChange={setIsCreateOpen}>
            <DialogTrigger asChild>
              <Button className="gap-2 bg-cyan-600 hover:bg-cyan-700 shadow-lg shadow-cyan-600/20 text-white">
                <Target className="w-4 h-4" />
                {t("admin_adrouter_new_campaign", "Yeni Kampanya")}
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[520px] bg-background border-border text-foreground">
              <DialogHeader>
                <DialogTitle>{t("admin_adrouter_create_campaign", "Reklam Kampanyası Oluştur")}</DialogTitle>
                <DialogDescription className="text-muted-foreground">
                  {t("admin_adrouter_create_desc", "Tüm ağlarda yapay zeka arbitrajıyla sıfır çaba kampanyası başlatın")}
                </DialogDescription>
              </DialogHeader>
              <div className="space-y-4 pt-4">
                <div className="space-y-2">
                  <Label>{t("admin_adrouter_campaign_name", "Kampanya Adı")}</Label>
                  <Input className="bg-card border-border text-foreground" placeholder={t("admin_adrouter_summer_campaign_placeholder", "Yaz İlanları Kampanyası")} />
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_adrouter_networks", "Ağlar")}</Label>
                  <div className="grid grid-cols-2 gap-2">
                    {["GOOGLE_ADS", "META_CAPI", "TIKTOK", "BAIDU_MARKETING", "NAVER_SEARCH_ADS", "YANDEX_DIRECT"].map((n) => (
                      <label key={n} className="flex items-center gap-2 p-2 rounded-lg bg-card border border-border cursor-pointer hover:border-cyan-500/50">
                        <input type="checkbox" className="rounded" defaultChecked={n === "GOOGLE_ADS" || n === "META_CAPI"} />
                        <span className="text-sm text-foreground">{NETWORK_LABELS[n] || n}</span>
                      </label>
                    ))}
                  </div>
                </div>
                <div className="space-y-2">
                  <Label>{t("admin_adrouter_budget", "Toplam Bütçe (USD)")}</Label>
                  <Input type="number" className="bg-card border-border text-foreground" placeholder="5000" defaultValue={5000} />
                </div>
              </div>
              <DialogFooter>
                <Button variant="ghost" onClick={() => setIsCreateOpen(false)} className="text-muted-foreground">{t("common.cancel", "İptal")}</Button>
                <Button
                  className="bg-cyan-600 hover:bg-cyan-700 text-white"
                  onClick={() => createMutation.mutate({ name: "New Campaign", objective: "LEAD_GENERATION", networks: ["GOOGLE_ADS", "META_CAPI"], totalBudget: 5000, currency: "USD" })}
                  disabled={createMutation.isPending}
                >
                  <Zap className="w-4 h-4 mr-1" />
                  {createMutation.isPending ? t("common.processing", "İşleniyor") : t("admin_adrouter_launch", "Yapay Zeka Arbitrajıyla Başlat")}
                </Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        {[
          { label: t("admin_adrouter_active", "Aktif Kampanyalar"), value: stats.activeCampaigns, icon: Target, color: "bg-cyan-500/20", iconColor: "text-cyan-400" },
          { label: t("admin_adrouter_spend", "Toplam Harcama"), value: `$${stats.totalSpend.toLocaleString()}`, icon: DollarSign, color: "bg-amber-500/20", iconColor: "text-warning" },
          { label: t("admin_adrouter_roas", "Ort. ROAS"), value: `${stats.overallROAS.toFixed(1)}x`, icon: TrendingUp, color: "bg-blue-500/20", iconColor: "text-success" },
          { label: t("admin_adrouter_networks", "Ağlar"), value: stats.connectedNetworks, icon: Network, color: "bg-violet-500/20", iconColor: "text-violet-400" },
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
          <TabsTrigger value="campaigns" className="data-[state=active]:bg-cyan-600 data-[state=active]:text-white">
            <Target className="w-4 h-4 mr-2" /> {t("admin_adrouter_tab_campaigns", "Kampanyalar")}
          </TabsTrigger>
          <TabsTrigger value="networks" className="data-[state=active]:bg-cyan-600 data-[state=active]:text-white">
            <Network className="w-4 h-4 mr-2" /> {t("admin_adrouter_tab_networks", "Ağlar")}
          </TabsTrigger>
          <TabsTrigger value="arbitrage" className="data-[state=active]:bg-cyan-600 data-[state=active]:text-white">
            <Shuffle className="w-4 h-4 mr-2" /> {t("admin_adrouter_tab_arbitrage", "Arbitraj")}
          </TabsTrigger>
          <TabsTrigger value="shifts" className="data-[state=active]:bg-cyan-600 data-[state=active]:text-white">
            <ArrowRightLeft className="w-4 h-4 mr-2" /> {t("admin_adrouter_tab_shifts", "Bütçe Kaydırmaları")}
          </TabsTrigger>
        </TabsList>

        <TabsContent value="campaigns" className="space-y-6">
          <div className="flex items-center gap-4">
            <div className="relative flex-1 max-w-md">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <Input placeholder={t("admin_adrouter_search", "Kampanya ara...")} className="bg-card border-border pl-10 text-foreground" value={searchTerm} onChange={(e) => setSearchTerm(e.target.value)} />
            </div>
            <Select value={networkFilter} onValueChange={setNetworkFilter}>
              <SelectTrigger className="w-48 bg-card border-border text-foreground">
                <SelectValue />
              </SelectTrigger>
              <SelectContent className="bg-background border-border">
                <SelectItem value="ALL">{t("admin_adrouter_all_networks", "Tüm Ağlar")}</SelectItem>
                {Object.entries(NETWORK_LABELS).map(([k, v]) => (
                  <SelectItem key={k} value={k}>{v}</SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
          <Card className="bg-card border-border overflow-hidden">
            <CardContent className="p-0">
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader className="bg-card border-b border-border">
                    <TableRow className="hover:bg-transparent border-none">
                      <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_adrouter_name", "Kampanya")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_networks_col", "Ağlar")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_budget_col", "Bütçe")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_spend_col", "Harcanan")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_cpet", "İşlem Başı Maliyet")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_roas_col", "ROAS")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_status", "Durum")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_actions", "İşlemler")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {campaignsLoading ? (
                      <TableRow><TableCell colSpan={8} className="text-center py-8 text-muted-foreground">{t("common.loading", "Yükleniyor")}</TableCell></TableRow>
                    ) : filtered.length === 0 ? (
                      <TableRow><TableCell colSpan={8} className="text-center py-8 text-muted-foreground">{t("admin_adrouter_no_campaigns", "Kampanya bulunamadı")}</TableCell></TableRow>
                    ) : filtered.map((campaign) => {
                      const statusCfg = STATUS_CONFIG[campaign.status] || STATUS_CONFIG.DRAFT;
                      const StatusIcon = statusCfg.icon;
                      const utilization = campaign.totalBudget > 0 ? (campaign.spentAmount / campaign.totalBudget) * 100 : 0;
                      return (
                        <TableRow key={campaign.id} className="border-b border-border hover:bg-card transition-colors">
                          <TableCell className="py-4 px-6">
                            <div>
                              <span className="text-sm font-medium text-foreground">{campaign.name}</span>
                              <p className="text-xs text-muted-foreground">{campaign.objective.replace("_", " ")}</p>
                            </div>
                          </TableCell>
                          <TableCell className="px-6">
                            <div className="flex flex-wrap gap-1">
                              {campaign.networks.slice(0, 3).map((n) => (
                                <Badge key={n} className={cn("border-0 text-[10px]", NETWORK_COLORS[n] || "bg-muted0/20 text-muted-foreground")}>
                                  {NETWORK_LABELS[n] || n}
                                </Badge>
                              ))}
                              {campaign.networks.length > 3 && (
                                <Badge className="border-0 bg-muted0/20 text-muted-foreground text-[10px]">+{campaign.networks.length - 3}</Badge>
                              )}
                            </div>
                          </TableCell>
                          <TableCell className="px-6">
                            <div>
                              <span className="text-sm font-bold text-foreground">${campaign.totalBudget.toLocaleString()}</span>
                              <Progress value={utilization} className="w-20 h-1.5 mt-1" />
                            </div>
                          </TableCell>
                          <TableCell className="px-6 text-sm font-bold text-foreground">${campaign.spentAmount.toLocaleString()}</TableCell>
                          <TableCell className="px-6">
                            <span className={cn("text-sm font-bold", campaign.performance?.cpet < 50 ? "text-success" : campaign.performance?.cpet < 100 ? "text-warning" : "text-red-400")}>
                              ${campaign.performance?.cpet?.toFixed(2) || "—"}
                            </span>
                          </TableCell>
                          <TableCell className="px-6">
                            <span className={cn("text-sm font-bold", (campaign.performance?.roas || 0) >= 3 ? "text-success" : (campaign.performance?.roas || 0) >= 1.5 ? "text-warning" : "text-red-400")}>
                              {campaign.performance?.roas?.toFixed(1) || "—"}x
                            </span>
                          </TableCell>
                          <TableCell className="px-6">
                            <Badge className={cn("border-0 gap-1", statusCfg.class)}>
                              <StatusIcon className="w-3 h-3" /> {campaign.status.replace("_", " ")}
                            </Badge>
                          </TableCell>
                          <TableCell className="px-6">
                            <div className="flex gap-2">
                              {campaign.status === "ACTIVE" && (
                                <Button
                                  size="sm"
                                  variant="outline"
                                  className="bg-card border-border text-foreground hover:bg-cyan-600 hover:text-white"
                                  onClick={() => arbitrageMutation.mutate(campaign.id)}
                                  disabled={arbitrageMutation.isPending}
                                >
                                  <Shuffle className="w-3 h-3 mr-1" /> {t("admin_adrouter_arb_short", "Arb")}
                                </Button>
                              )}
                            </div>
                          </TableCell>
                        </TableRow>
                      );
                    })}
                  </TableBody>
                </Table>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="networks" className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {networks.map((net) => (
              <Card key={net.network} className={cn("bg-card border-border transition-all hover:shadow-lg", net.isEnabled ? "border-cyan-500/30" : "opacity-60")}>
                <CardContent className="p-6">
                  <div className="flex items-center justify-between mb-4">
                    <div className="flex items-center gap-3">
                      <div className={cn("p-2 rounded-lg", NETWORK_COLORS[net.network] || "bg-muted0/20")}>
                        <Network className="w-5 h-5" />
                      </div>
                      <div>
                        <h4 className="text-sm font-semibold text-foreground">{NETWORK_LABELS[net.network] || net.network}</h4>
                        <p className="text-xs text-muted-foreground">{net.category.replace("_", " ")}</p>
                      </div>
                    </div>
                    <Badge className={cn("border-0", net.isEnabled ? "bg-blue-500/20 text-success" : "bg-muted0/20 text-muted-foreground")}>
                      {net.isEnabled ? "Connected" : "Disconnected"}
                    </Badge>
                  </div>
                  <div className="space-y-3">
                    <div className="flex justify-between text-sm">
                      <span className="text-muted-foreground">{t("admin_adrouter_monthly_cap", "Aylık Üst Limit")}</span>
                      <span className="font-bold text-foreground">${net.monthlyBudgetCap.toLocaleString()}</span>
                    </div>
                    <div className="flex justify-between text-sm">
                      <span className="text-muted-foreground">{t("admin_adrouter_daily_cap", "Günlük Üst Limit")}</span>
                      <span className="font-bold text-foreground">${net.dailyBudgetCap.toLocaleString()}</span>
                    </div>
                    <div className="flex justify-between text-sm">
                      <span className="text-muted-foreground">{t("admin_adrouter_regions", "Bölgeler")}</span>
                      <span className="font-bold text-foreground">{net.connectedRegions?.length || 0}</span>
                    </div>
                    <div className="flex justify-between text-sm">
                      <span className="text-muted-foreground">{t("admin_adrouter_last_sync", "Son Senkronizasyon")}</span>
                      <span className="text-foreground">{net.lastSyncAt ? new Date(net.lastSyncAt).toLocaleString() : "—"}</span>
                    </div>
                  </div>
                </CardContent>
              </Card>
            ))}
          </div>
        </TabsContent>

        <TabsContent value="arbitrage" className="space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            <Card className="bg-card border-border">
              <CardContent className="p-6">
                <div className="flex items-center justify-between mb-4">
                  <p className="text-xs font-medium text-muted-foreground">{t("admin_adrouter_arb_savings", "Arbitraj Tasarrufu")}</p>
                  <div className="p-3 bg-blue-500/20 rounded-lg"><DollarSign className="w-5 h-5 text-success" /></div>
                </div>
                <h3 className="text-2xl font-bold text-foreground">${stats.savingsFromArbitrage.toLocaleString()}</h3>
                <p className="text-xs text-success mt-1">{t("admin_adrouter_saved_this_month", "Bu ay yapay zeka bütçe kaydırmalarından tasarruf")}</p>
              </CardContent>
            </Card>
            <Card className="bg-card border-border">
              <CardContent className="p-6">
                <div className="flex items-center justify-between mb-4">
                  <p className="text-xs font-medium text-muted-foreground">{t("admin_adrouter_rebate_savings", "İndirim Tasarrufu")}</p>
                  <div className="p-3 bg-violet-500/20 rounded-lg"><TrendingUp className="w-5 h-5 text-violet-400" /></div>
                </div>
                <h3 className="text-2xl font-bold text-foreground">${stats.savingsFromRebates.toLocaleString()}</h3>
                <p className="text-xs text-violet-400 mt-1">{t("admin_adrouter_volume_rebates", "Hacim indirimleri (%3-%8) uygulandı")}</p>
              </CardContent>
            </Card>
            <Card className="bg-card border-border">
              <CardContent className="p-6">
                <div className="flex items-center justify-between mb-4">
                  <p className="text-xs font-medium text-muted-foreground">{t("admin_adrouter_total_shifts", "Toplam Kaydırma")}</p>
                  <div className="p-3 bg-cyan-500/20 rounded-lg"><ArrowRightLeft className="w-5 h-5 text-cyan-400" /></div>
                </div>
                <h3 className="text-2xl font-bold text-foreground">{stats.totalShifts}</h3>
                <p className="text-xs text-cyan-400 mt-1">{t("admin_adrouter_auto_shifts", "Otomatik bütçe yeniden dağılımı")}</p>
              </CardContent>
            </Card>
          </div>

          {arbitrage?.recommendations && arbitrage.recommendations.length > 0 && (
            <Card className="bg-card border-border">
              <CardHeader>
                <CardTitle className="text-foreground flex items-center gap-2">
                  <Brain className="w-5 h-5 text-cyan-400" />
                  {t("admin_adrouter_ai_recommendations", "Yapay Zeka Arbitraj Önerileri")}
                </CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                {arbitrage.recommendations.slice(0, 5).map((rec: any, i: number) => (
                  <div key={i} className="flex items-center justify-between p-4 bg-card rounded-xl border border-border">
                    <div className="flex items-center gap-4">
                      <div className={cn("p-2 rounded-lg", rec.priority === "HIGH" ? "bg-blue-500/20" : "bg-amber-500/20")}>
                        {rec.type === "SHIFT_BUDGET" ? <ArrowRightLeft className="w-4 h-4 text-cyan-400" /> : <TrendingUp className="w-4 h-4 text-success" />}
                      </div>
                      <div>
                        <p className="text-sm font-medium text-foreground">{rec.rationale}</p>
                        <p className="text-xs text-muted-foreground">{NETWORK_LABELS[rec.network] || rec.network} — {rec.type.replace(/_/g, " ")}</p>
                      </div>
                    </div>
                    <div className="flex items-center gap-3">
                      <span className="text-xs font-bold text-success">${Math.abs(rec.budgetImpact).toLocaleString()}</span>
                      <Badge className={cn("border-0", rec.priority === "HIGH" ? "bg-blue-500/20 text-success" : "bg-amber-500/20 text-warning")}>
                        {rec.priority}
                      </Badge>
                    </div>
                  </div>
                ))}
              </CardContent>
            </Card>
          )}
        </TabsContent>

        <TabsContent value="shifts" className="space-y-6">
          <Card className="bg-card border-border overflow-hidden">
            <CardContent className="p-0">
              <div className="overflow-x-auto">
                <Table>
                  <TableHeader className="bg-card border-b border-border">
                    <TableRow className="hover:bg-transparent border-none">
                      <TableHead className="text-xs font-medium text-muted-foreground py-4 px-6">{t("admin_adrouter_from", "Kimden")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6"></TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_to", "Kime")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_amount", "Tutar")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_cpet_improvement", "İşlem Maliyeti Δ")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_trigger", "Tetikleyen")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_reason", "Neden")}</TableHead>
                      <TableHead className="text-xs font-medium text-muted-foreground px-6">{t("admin_adrouter_time", "Zaman")}</TableHead>
                    </TableRow>
                  </TableHeader>
                  <TableBody>
                    {shifts.length === 0 ? (
                      <TableRow><TableCell colSpan={8} className="text-center py-8 text-muted-foreground">{t("admin_adrouter_no_shifts", "Henüz bütçe kayması kaydı yok")}</TableCell></TableRow>
                    ) : shifts.map((shift) => (
                      <TableRow key={shift.id} className="border-b border-border hover:bg-card transition-colors">
                        <TableCell className="py-4 px-6">
                          <Badge className={cn("border-0 text-[10px]", NETWORK_COLORS[shift.fromNetwork])}>
                            {NETWORK_LABELS[shift.fromNetwork] || shift.fromNetwork}
                          </Badge>
                        </TableCell>
                        <TableCell className="px-6"><ArrowRightLeft className="w-4 h-4 text-cyan-400" /></TableCell>
                        <TableCell className="px-6">
                          <Badge className={cn("border-0 text-[10px]", NETWORK_COLORS[shift.toNetwork])}>
                            {NETWORK_LABELS[shift.toNetwork] || shift.toNetwork}
                          </Badge>
                        </TableCell>
                        <TableCell className="px-6 text-sm font-bold text-foreground">${shift.amount.toLocaleString()}</TableCell>
                        <TableCell className="px-6">
                          <span className={cn("text-sm font-bold", shift.cpetAfter < shift.cpetBefore ? "text-success" : "text-red-400")}>
                            ${shift.cpetBefore.toFixed(2)} → ${shift.cpetAfter.toFixed(2)}
                          </span>
                        </TableCell>
                        <TableCell className="px-6">
                          <Badge className={cn("border-0 text-[10px]", shift.triggeredBy === "AI_ARBITRAGE" ? "bg-cyan-500/20 text-cyan-400" : "bg-muted0/20 text-muted-foreground")}>
                            {shift.triggeredBy === "AI_ARBITRAGE" ? "🤖 AI" : shift.triggeredBy}
                          </Badge>
                        </TableCell>
                        <TableCell className="px-6 text-xs text-muted-foreground max-w-[200px] truncate">{shift.reason}</TableCell>
                        <TableCell className="px-6 text-xs text-muted-foreground">{new Date(shift.timestamp).toLocaleString()}</TableCell>
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
