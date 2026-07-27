"use client";
import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
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
      case "PREMIUM": return "bg-purple-500";
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
      case "LOW": return "text-green-600 bg-green-50";
      default: return "text-gray-600 bg-gray-50";
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">Prospect Intelligence</h1>
          <p className="text-muted-foreground">
            MLS prospect intelligence and acquisition opportunity scoring
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" size="sm">
            <Filter className="w-4 h-4 mr-2" />
            Advanced Filters
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
            <CardTitle className="text-sm font-medium">Total Prospects</CardTitle>
            <Target className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalProspects || 0}</div>
            <p className="text-xs text-muted-foreground">
              {stats?.analyzedProspects || 0} AI analyzed
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Avg Acquisition Score</CardTitle>
            <TrendingUp className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {(stats?.avgAcquisitionScore || 0).toFixed(1)}
            </div>
            <p className="text-xs text-muted-foreground">
              Scale: 0-100
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Premium Opportunities</CardTitle>
            <CheckCircle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {stats?.opportunityDistribution.premium || 0}
            </div>
            <p className="text-xs text-muted-foreground">
              High priority targets
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Immediate Action</CardTitle>
            <AlertTriangle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">
              {stats?.urgencyDistribution.immediate || 0}
            </div>
            <p className="text-xs text-muted-foreground">
              Requires immediate attention
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Opportunity Distribution */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>Opportunity Tier Distribution</CardTitle>
            <CardDescription>Prospects by acquisition potential</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[
                { label: "Premium", count: stats?.opportunityDistribution.premium || 0, color: "bg-purple-500" },
                { label: "High Potential", count: stats?.opportunityDistribution.highPotential || 0, color: "bg-blue-500" },
                { label: "Monitor", count: stats?.opportunityDistribution.monitor || 0, color: "bg-yellow-500" },
                { label: "Low Potential", count: stats?.opportunityDistribution.lowPotential || 0, color: "bg-gray-500" },
              ].map((tier) => (
                <div key={tier.label} className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <div className={`w-3 h-3 rounded-full ${tier.color}`} />
                    <span className="text-sm">{tier.label}</span>
                  </div>
                  <span className="text-sm font-medium">{tier.count}</span>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Acquisition Urgency</CardTitle>
            <CardDescription>Prospects by action urgency</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[
                { label: "Immediate", count: stats?.urgencyDistribution.immediate || 0, color: "text-red-600" },
                { label: "High", count: stats?.urgencyDistribution.high || 0, color: "text-orange-600" },
                { label: "Medium", count: stats?.urgencyDistribution.medium || 0, color: "text-yellow-600" },
                { label: "Low", count: stats?.urgencyDistribution.low || 0, color: "text-green-600" },
              ].map((urgency) => (
                <div key={urgency.label} className="flex items-center justify-between">
                  <span className="text-sm">{urgency.label}</span>
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
              <CardTitle>Prospect List</CardTitle>
              <CardDescription>
                Filtered by opportunity tier and urgency
              </CardDescription>
            </div>
            <div className="flex gap-2">
              <select
                value={selectedTier}
                onChange={(e) => setSelectedTier(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">All Tiers</option>
                <option value="PREMIUM">Premium</option>
                <option value="HIGH_POTENTIAL">High Potential</option>
                <option value="MONITOR">Monitor</option>
                <option value="LOW_POTENTIAL">Low Potential</option>
              </select>
              <select
                value={selectedUrgency}
                onChange={(e) => setSelectedUrgency(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">All Urgency</option>
                <option value="IMMEDIATE">Immediate</option>
                <option value="HIGH">High</option>
                <option value="MEDIUM">Medium</option>
                <option value="LOW">Low</option>
              </select>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          {prospectsLoading ? (
            <div className="text-center py-8">Loading prospects...</div>
          ) : (
            <div className="space-y-4">
              {prospects?.map((prospect) => (
                <div
                  key={prospect.id}
                  className="flex items-center justify-between p-4 border rounded-lg hover:bg-gray-50"
                >
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-2">
                      <Badge className={getTierColor(prospect.opportunityTier)}>
                        {prospect.opportunityTier.replace(/_/g, " ")}
                      </Badge>
                      <Badge className={getUrgencyColor(prospect.acquisitionUrgency)}>
                        {prospect.acquisitionUrgency}
                      </Badge>
                      <span className="text-sm text-muted-foreground">
                        {prospect.source}
                      </span>
                    </div>
                    <div className="text-sm font-medium">
                      {prospect.propertyFingerprint}
                    </div>
                    <div className="flex gap-4 mt-2 text-xs text-muted-foreground">
                      <span>Acquisition: {prospect.acquisitionScore.toFixed(1)}</span>
                      <span>Valuation: {prospect.valuationScore.toFixed(1)}</span>
                      <span>Owner: {prospect.ownerConfidence.toFixed(1)}</span>
                      <span>Market: {prospect.marketOpportunityScore.toFixed(1)}</span>
                    </div>
                  </div>
                  <div className="flex gap-2">
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
