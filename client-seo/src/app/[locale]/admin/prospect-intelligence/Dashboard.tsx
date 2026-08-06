"use client";
import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { tEnum } from "@/lib/admin-enums";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { 
  TrendingUp, 
  Target, 
  AlertTriangle, 
  CheckCircle, 
  Filter,
  Download,
  Eye
} from "lucide-react";
import { prospectIntelligenceApi, PropertyProspect, ProspectStats } from "@/lib/api/prospect-intelligence";

export default function Dashboard() {
  const [selectedTier, setSelectedTier] = useState<string>("all");
  const [selectedUrgency, setSelectedUrgency] = useState<string>("all");
  const { t } = useTranslation();
  const orgId = "current-org"; // Replace with actual org ID

  const { data: stats } = useQuery({
    queryKey: ["prospect-stats", orgId],
    queryFn: () => prospectIntelligenceApi.getStats(orgId),
  });

  const { data: prospects, isLoading: prospectsLoading } = useQuery({
    queryKey: ["prospects", orgId, selectedTier, selectedUrgency],
    queryFn: () => prospectIntelligenceApi.getProspects({
      opportunityTier: selectedTier === "all" ? undefined : selectedTier,
      acquisitionUrgency: selectedUrgency === "all" ? undefined : selectedUrgency,
    }),
  });

  const getTierColor = (tier: string) => {
    switch (tier) {
      case "PREMIUM": return "bg-brand/100";
      case "HIGH_POTENTIAL": return "bg-blue-500";
      case "MONITOR": return "bg-yellow-500";
      case "LOW_POTENTIAL": return "bg-gray-500";
      default: return "bg-gray-400";
    }
  };

  const getUrgencyColor = (urgency: string) => {
    switch (urgency) {
      case "IMMEDIATE": return "text-red-600 bg-red-50";
      case "HIGH": return "text-orange-600 bg-orange-50";
      case "MEDIUM": return "text-yellow-600 bg-yellow-50";
      case "LOW": return "text-blue-600 bg-blue-50";
      default: return "text-muted-foreground bg-muted";
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">{t("admin_prospect_intelligence_title", "Prospect Zekası")}</h1>
          <p className="text-muted-foreground">
            {t("admin_prospect_intelligence_desc", "MLS müşteri adayı zekası ve satın alma fırsatı puanlaması")}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" size="sm">
            <Filter className="w-4 h-4 mr-2" />
            {t("admin_prospect_intelligence_advanced_filters", "Gelişmiş Filtreler")}
          </Button>
          <Button variant="outline" size="sm">
            <Download className="w-4 h-4 mr-2" />
            {t("admin_common_export", "Dışa Aktar")}
          </Button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin_prospect_intelligence_total_prospects", "Toplam Müşteri Adayı")}</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalProspects || 0}</div>
            <p className="text-xs text-muted-foreground">
              {stats?.analyzedProspects || 0} {t("admin_prospect_intelligence_ai_analyzed", "AI tarafından analiz edildi")}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin_prospect_intelligence_avg_acquisition_score", "Ort. Satın Alma Puanı")}</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {(stats?.avgAcquisitionScore || 0).toFixed(1)}
            </div>
            <p className="text-xs text-muted-foreground">
              {t("admin_prospect_intelligence_scale", "Ölçek: 0-100")}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin_prospect_intelligence_premium_opportunities", "Premium Fırsatlar")}</CardTitle>
            <CheckCircle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {stats?.opportunityDistribution.premium || 0}
            </div>
            <p className="text-xs text-muted-foreground">
              {t("admin_prospect_intelligence_high_priority_targets", "Yüksek öncelikli hedefler")}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("admin_prospect_intelligence_immediate_action", "Acil Eylem")}</CardTitle>
            <AlertTriangle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {stats?.urgencyDistribution.immediate || 0}
            </div>
            <p className="text-xs text-muted-foreground">
              {t("admin_prospect_intelligence_requires_immediate_attention", "Acil ilgi gerektirir")}
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Opportunity Distribution */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>{t("admin_prospect_intelligence_opportunity_tier_distribution", "Fırsat Kademesi Dağılımı")}</CardTitle>
            <CardDescription>{t("admin_prospect_intelligence_prospects_by_acquisition", "Satın alma potansiyeline göre müşteri adayları")}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[
                { label: "Premium", count: stats?.opportunityDistribution.premium || 0, color: "bg-brand/100" },
                { label: "High Potential", count: stats?.opportunityDistribution.highPotential || 0, color: "bg-blue-500" },
                { label: "Monitor", count: stats?.opportunityDistribution.monitor || 0, color: "bg-yellow-500" },
                { label: "Low Potential", count: stats?.opportunityDistribution.lowPotential || 0, color: "bg-gray-500" },
              ].map((tier) => (
                <div key={tier.label} className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <div className={`w-3 h-3 rounded-full ${tier.color}`} />
                    <span className="text-sm">{tEnum(t, tier.label)}</span>
                  </div>
                  <span className="text-sm font-medium">{tier.count}</span>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>{t("admin_prospect_intelligence_acquisition_urgency", "Satın Alma Aciliyeti")}</CardTitle>
            <CardDescription>{t("admin_prospect_intelligence_prospects_by_action_urgency", "Eylem aciliyetine göre müşteri adayları")}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[
                { label: "Immediate", count: stats?.urgencyDistribution.immediate || 0, color: "text-red-600" },
                { label: "High", count: stats?.urgencyDistribution.high || 0, color: "text-orange-600" },
                { label: "Medium", count: stats?.urgencyDistribution.medium || 0, color: "text-yellow-600" },
                { label: "Low", count: stats?.urgencyDistribution.low || 0, color: "text-blue-600" },
              ].map((urgency) => (
                <div key={urgency.label} className="flex items-center justify-between">
                  <span className="text-sm">{tEnum(t, urgency.label)}</span>
                  <span className={`text-sm font-medium ${urgency.color}`}>{urgency.count}</span>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Prospect List */}
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle>{t("admin_prospect_intelligence_prospect_list", "Müşteri Adayı Listesi")}</CardTitle>
              <CardDescription>
                {t("admin_prospect_intelligence_filtered", "Fırsat kademesine ve aciliyete göre filtrelendi")}
              </CardDescription>
            </div>
            <div className="flex gap-2">
              <select
                value={selectedTier}
                onChange={(e) => setSelectedTier(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">{t("admin_prospect_intelligence_all_tiers", "Tüm Kademeler")}</option>
                <option value="PREMIUM">{tEnum(t, "Premium")}</option>
                <option value="HIGH_POTENTIAL">{tEnum(t, "High Potential")}</option>
                <option value="MONITOR">{tEnum(t, "Monitor")}</option>
                <option value="LOW_POTENTIAL">{tEnum(t, "Low Potential")}</option>
              </select>
              <select
                value={selectedUrgency}
                onChange={(e) => setSelectedUrgency(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">{t("admin_prospect_intelligence_all_urgency", "Tüm Aciliyetler")}</option>
                <option value="IMMEDIATE">{tEnum(t, "Immediate")}</option>
                <option value="HIGH">{tEnum(t, "High")}</option>
                <option value="MEDIUM">{tEnum(t, "Medium")}</option>
                <option value="LOW">{tEnum(t, "Low")}</option>
              </select>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          {prospectsLoading ? (
            <div className="text-center py-8">{t("admin_prospect_intelligence_loading_prospects", "Müşteri adayları yükleniyor...")}</div>
          ) : (
            <div className="space-y-4">
              {prospects?.map((prospect) => (
                <div
                  key={prospect.id}
                  className="flex items-center justify-between p-4 border rounded-lg hover:bg-muted"
                >
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-2">
                      <Badge className={getTierColor(prospect.opportunityTier)}>
                        {tEnum(t, prospect.opportunityTier)}
                      </Badge>
                      <Badge className={getUrgencyColor(prospect.acquisitionUrgency)}>
                        {tEnum(t, prospect.acquisitionUrgency)}
                      </Badge>
                      <span className="text-sm text-muted-foreground">
                        {prospect.source}
                      </span>
                    </div>
                    <div className="text-sm font-medium">
                      {prospect.propertyFingerprint}
                    </div>
                    <div className="flex gap-4 mt-2 text-xs text-muted-foreground">
                      <span>{t("admin_prospect_intelligence_acquisition", "Satın Alma:")} {prospect.acquisitionScore.toFixed(1)}</span>
                      <span>{t("admin_prospect_intelligence_valuation", "Değerleme:")} {prospect.valuationScore.toFixed(1)}</span>
                      <span>{t("admin_prospect_intelligence_owner", "Sahip:")} {prospect.ownerConfidence.toFixed(1)}</span>
                      <span>{t("admin_prospect_intelligence_market", "Pazar:")} {prospect.marketOpportunityScore.toFixed(1)}</span>
                    </div>
                  </div>
                  <div className="flex gap-2">
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
