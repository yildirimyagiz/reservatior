"use client";
import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { 
  Target, 
  TrendingUp, 
  Zap, 
  CheckCircle, 
  AlertTriangle,
  Filter,
  Download,
  Eye,
  Play,
  Pause,
  Plus
} from "lucide-react";
import { marketingOSApi, CampaignAutomationRule, CampaignRuleStats } from "@/lib/api/marketing-os";
import { tEnum } from "@/lib/admin-enums";

export default function Dashboard() {
  const [selectedStatus, setSelectedStatus] = useState<string>("all");
  const [selectedTrigger, setSelectedTrigger] = useState<string>("all");
  const orgId = "current-org";
  const { t } = useTranslation();

  const { data: stats } = useQuery({
    queryKey: ["marketing-stats", orgId],
    queryFn: () => marketingOSApi.getStats(orgId),
  });

  const { data: rules, isLoading: rulesLoading } = useQuery({
    queryKey: ["campaign-rules", orgId, selectedStatus, selectedTrigger],
    queryFn: () => marketingOSApi.getRules({
      status: selectedStatus === "all" ? undefined : selectedStatus,
      triggerType: selectedTrigger === "all" ? undefined : selectedTrigger,
    }),
  });

  const getStatusColor = (status: string) => {
    switch (status) {
      case "ACTIVE": return "bg-blue-500";
      case "PAUSED": return "bg-yellow-500";
      case "DISABLED": return "bg-red-500";
      case "ARCHIVED": return "bg-gray-500";
      default: return "bg-gray-400";
    }
  };

  const getTriggerIcon = (triggerType: string) => {
    switch (triggerType) {
      case "PROPERTY_VACANCY_RISK": return <AlertTriangle className="w-4 h-4" />;
      case "VALUATION_INCREASE": return <TrendingUp className="w-4 h-4" />;
      case "MARKET_OPPORTUNITY": return <Target className="w-4 h-4" />;
      case "OWNER_CONSENT_GRANTED": return <CheckCircle className="w-4 h-4" />;
      default: return <Zap className="w-4 h-4" />;
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">{t("admin_marketing_os_title", "Pazarlama OS")}</h1>
          <p className="text-muted-foreground">
            {t("admin_marketing_os_desc", "Otomatik kampanya oluşturma ve yürütme kuralları")}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" size="sm">
            <Plus className="w-4 h-4 mr-2" />
            {t("admin_marketing_os_new_rule", "Yeni Kural")}
          </Button>
          <Button variant="outline" size="sm">
            <Filter className="w-4 h-4 mr-2" />
            {t("admin_marketing_os_filters", "Filtreler")}
          </Button>
          <Button variant="outline" size="sm">
            <Download className="w-4 h-4 mr-2" />
            {t("admin_marketing_os_export", "Dışa Aktar")}
          </Button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin_marketing_os_active_rules", "Aktif Kurallar")}</CardTitle>
            <Zap className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.activeRules || 0}</div>
            <p className="text-xs text-muted-foreground">
              {t("admin_marketing_os_of", "toplam")} {stats?.totalRules || 0} {t("admin_marketing_os_total", "kural")}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin_marketing_os_campaigns_generated", "Oluşturulan Kampanyalar")}</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalCampaignsGenerated || 0}</div>
            <p className="text-xs text-muted-foreground">
              {t("admin_marketing_os_auto_generated", "Otomatik oluşturuldu")}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin_marketing_os_total_spend", "Toplam Harcama")}</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              ${(stats?.totalSpend || 0).toLocaleString()}
            </div>
            <p className="text-xs text-muted-foreground">
              {t("admin_marketing_os_across_platforms", "Tüm platformlarda")}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin_marketing_os_conversions", "Dönüşümler")}</CardTitle>
            <CheckCircle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalConversions || 0}</div>
            <p className="text-xs text-muted-foreground">
              {(stats?.avgConversionRate || 0).toFixed(1)}% {t("admin_marketing_os_avg_rate", "ort. oran")}
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Campaign Rules List */}
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle>{t("admin_marketing_os_rules_title", "Kampanya Otomasyon Kuralları")}</CardTitle>
              <CardDescription>
                {t("admin_marketing_os_desc", "Otomatik kampanya oluşturma ve yürütme kuralları")}
              </CardDescription>
            </div>
            <div className="flex gap-2">
              <select
                value={selectedStatus}
                onChange={(e) => setSelectedStatus(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">{t("admin_marketing_os_all_status", "Tüm Durumlar")}</option>
                <option value="ACTIVE">{tEnum(t, "ACTIVE")}</option>
                <option value="PAUSED">{tEnum(t, "PAUSED")}</option>
                <option value="DISABLED">{tEnum(t, "DISABLED")}</option>
                <option value="ARCHIVED">{tEnum(t, "ARCHIVED")}</option>
              </select>
              <select
                value={selectedTrigger}
                onChange={(e) => setSelectedTrigger(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">{t("admin_marketing_os_all_triggers", "Tüm Tetikleyiciler")}</option>
                <option value="PROPERTY_VACANCY_RISK">{tEnum(t, "PROPERTY_VACANCY_RISK")}</option>
                <option value="VALUATION_INCREASE">{tEnum(t, "VALUATION_INCREASE")}</option>
                <option value="MARKET_OPPORTUNITY">{tEnum(t, "MARKET_OPPORTUNITY")}</option>
                <option value="OWNER_CONSENT_GRANTED">{tEnum(t, "OWNER_CONSENT_GRANTED")}</option>
              </select>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          {rulesLoading ? (
            <div className="text-center py-8">{t("admin_marketing_os_loading_rules", "Kampanya kuralları yükleniyor...")}</div>
          ) : (
            <div className="space-y-4">
              {rules?.map((rule) => (
                <div
                  key={rule.id}
                  className="flex items-center justify-between p-4 border rounded-lg hover:bg-muted"
                >
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-2">
                      <Badge className={getStatusColor(rule.status)}>
                        {tEnum(t, rule.status)}
                      </Badge>
                      <div className="flex items-center gap-1 text-sm text-muted-foreground">
                        {getTriggerIcon(rule.triggerType)}
                        <span>{tEnum(t, rule.triggerType)}</span>
                      </div>
                      <span className="text-sm text-muted-foreground">
                        {tEnum(t, rule.targetEntityType)}
                      </span>
                    </div>
                    <div className="text-sm font-medium">
                      {rule.name}
                    </div>
                    {rule.description && (
                      <div className="text-sm text-muted-foreground mt-1">
                        {rule.description}
                      </div>
                    )}
                    <div className="flex gap-4 mt-2 text-xs text-muted-foreground">
                      <span>{t("admin_marketing_os_campaigns_label", "Kampanyalar")}: {rule.totalCampaignsGenerated}</span>
                      <span>{t("admin_marketing_os_spend_label", "Harcama")}: ${(rule.totalSpend || 0).toLocaleString()}</span>
                      <span>{t("admin_marketing_os_conversions_label", "Dönüşümler")}: {rule.totalConversions}</span>
                    </div>
                    <div className="flex gap-2 mt-2">
                      {rule.googleAdsEnabled && <Badge variant="outline" className="text-xs">{t("admin_marketing_os_google_ads", "Google Ads")}</Badge>}
                      {rule.metaAdsEnabled && <Badge variant="outline" className="text-xs">{t("admin_marketing_os_meta_ads", "Meta Ads")}</Badge>}
                      {rule.tiktokAdsEnabled && <Badge variant="outline" className="text-xs">{t("admin_marketing_os_tiktok_ads", "TikTok Ads")}</Badge>}
                      {rule.autoGenerateCreative && <Badge variant="outline" className="text-xs">{t("admin_marketing_os_auto_creative", "Otomatik Yaratıcı")}</Badge>}
                      {rule.autoBuildAudience && <Badge variant="outline" className="text-xs">{t("admin_marketing_os_auto_audience", "Otomatik Hedef Kitle")}</Badge>}
                    </div>
                  </div>
                  <div className="flex gap-2">
                    {rule.status === "ACTIVE" ? (
                      <Button variant="ghost" size="sm" aria-label={t("common.pause")}>
                        <Pause className="w-4 h-4" />
                      </Button>
                    ) : (
                      <Button variant="ghost" size="sm" aria-label={t("common.play")}>
                        <Play className="w-4 h-4" />
                      </Button>
                    )}
                    <Button variant="ghost" size="sm" aria-label={t("common.view")}>
                      <Eye className="w-4 h-4" />
                    </Button>
                  </div>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
