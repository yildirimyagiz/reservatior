"use client";
import { useState } from "react";
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

export default function Dashboard() {
  const [selectedStatus, setSelectedStatus] = useState<string>("all");
  const [selectedTrigger, setSelectedTrigger] = useState<string>("all");
  const orgId = "current-org";

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
      case "ACTIVE": return "bg-green-500";
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
          <h1 className="text-3xl font-bold">Marketing OS</h1>
          <p className="text-muted-foreground">
            Automated campaign generation and execution rules
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" size="sm">
            <Plus className="w-4 h-4 mr-2" />
            New Rule
          </Button>
          <Button variant="outline" size="sm">
            <Filter className="w-4 h-4 mr-2" />
            Filters
          </Button>
          <Button variant="outline" size="sm">
            <Download className="w-4 h-4 mr-2" />
            Export
          </Button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Active Rules</CardTitle>
            <Zap className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.activeRules || 0}</div>
            <p className="text-xs text-muted-foreground">
              of {stats?.totalRules || 0} total
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Campaigns Generated</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalCampaignsGenerated || 0}</div>
            <p className="text-xs text-muted-foreground">
              Auto-generated
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Spend</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              ${(stats?.totalSpend || 0).toLocaleString()}
            </div>
            <p className="text-xs text-muted-foreground">
              Across all platforms
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Conversions</CardTitle>
            <CheckCircle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalConversions || 0}</div>
            <p className="text-xs text-muted-foreground">
              {(stats?.avgConversionRate || 0).toFixed(1)}% avg rate
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Campaign Rules List */}
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle>Campaign Automation Rules</CardTitle>
              <CardDescription>
                Automated campaign generation and execution rules
              </CardDescription>
            </div>
            <div className="flex gap-2">
              <select
                value={selectedStatus}
                onChange={(e) => setSelectedStatus(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">All Status</option>
                <option value="ACTIVE">Active</option>
                <option value="PAUSED">Paused</option>
                <option value="DISABLED">Disabled</option>
                <option value="ARCHIVED">Archived</option>
              </select>
              <select
                value={selectedTrigger}
                onChange={(e) => setSelectedTrigger(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">All Triggers</option>
                <option value="PROPERTY_VACANCY_RISK">Vacancy Risk</option>
                <option value="VALUATION_INCREASE">Valuation Increase</option>
                <option value="MARKET_OPPORTUNITY">Market Opportunity</option>
                <option value="OWNER_CONSENT_GRANTED">Consent Granted</option>
              </select>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          {rulesLoading ? (
            <div className="text-center py-8">Loading campaign rules...</div>
          ) : (
            <div className="space-y-4">
              {rules?.map((rule) => (
                <div
                  key={rule.id}
                  className="flex items-center justify-between p-4 border rounded-lg hover:bg-gray-50"
                >
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-2">
                      <Badge className={getStatusColor(rule.status)}>
                        {rule.status}
                      </Badge>
                      <div className="flex items-center gap-1 text-sm text-muted-foreground">
                        {getTriggerIcon(rule.triggerType)}
                        <span>{rule.triggerType.replace(/_/g, " ")}</span>
                      </div>
                      <span className="text-sm text-muted-foreground">
                        {rule.targetEntityType}
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
                      <span>Campaigns: {rule.totalCampaignsGenerated}</span>
                      <span>Spend: ${(rule.totalSpend || 0).toLocaleString()}</span>
                      <span>Conversions: {rule.totalConversions}</span>
                    </div>
                    <div className="flex gap-2 mt-2">
                      {rule.googleAdsEnabled && <Badge variant="outline" className="text-xs">Google Ads</Badge>}
                      {rule.metaAdsEnabled && <Badge variant="outline" className="text-xs">Meta Ads</Badge>}
                      {rule.tiktokAdsEnabled && <Badge variant="outline" className="text-xs">TikTok Ads</Badge>}
                      {rule.autoGenerateCreative && <Badge variant="outline" className="text-xs">Auto Creative</Badge>}
                      {rule.autoBuildAudience && <Badge variant="outline" className="text-xs">Auto Audience</Badge>}
                    </div>
                  </div>
                  <div className="flex gap-2">
                    {rule.status === "ACTIVE" ? (
                      <Button variant="ghost" size="sm">
                        <Pause className="w-4 h-4" />
                      </Button>
                    ) : (
                      <Button variant="ghost" size="sm">
                        <Play className="w-4 h-4" />
                      </Button>
                    )}
                    <Button variant="ghost" size="sm">
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
