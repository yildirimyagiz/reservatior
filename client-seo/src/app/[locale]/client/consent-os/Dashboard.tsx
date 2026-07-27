"use client";
import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { 
  Shield, 
  CheckCircle, 
  AlertTriangle, 
  Filter,
  Download,
  Eye,
  User,
  Building,
  FileText
} from "lucide-react";
import { consentOSApi } from "@/lib/api/consent-os";

export default function Dashboard() {
  const [selectedEntityType, setSelectedEntityType] = useState<string>("all");
  const [selectedStatus, setSelectedStatus] = useState<string>("all");
  const [selectedChannel, setSelectedChannel] = useState<string>("all");
  const orgId = "current-org";

  const { data: stats } = useQuery({
    queryKey: ["consent-stats", orgId],
    queryFn: () => consentOSApi.getStats(orgId),
  });

  const { data: consentTrendsData } = useQuery({
    queryKey: ["consent-os-consent-trends", orgId],
    queryFn: () => consentOSApi.getConsentTrends(orgId),
  });

  const { data: complianceDistributionData } = useQuery({
    queryKey: ["consent-os-compliance-distribution", orgId],
    queryFn: () => consentOSApi.getComplianceDistribution(orgId),
  });

  const { data: consents, isLoading: consentsLoading } = useQuery({
    queryKey: ["consents", orgId, selectedEntityType, selectedStatus, selectedChannel],
    queryFn: () => consentOSApi.getConsents({
      entityType: selectedEntityType === "all" ? undefined : selectedEntityType,
      status: selectedStatus === "all" ? undefined : selectedStatus,
      channel: selectedChannel === "all" ? undefined : selectedChannel,
    }),
  });

  const getStatusColor = (status: string) => {
    switch (status) {
      case "ACTIVE": return "bg-green-500";
      case "REVOKED": return "bg-red-500";
      case "EXPIRED": return "bg-gray-500";
      case "PENDING": return "bg-yellow-500";
      case "DECLINED": return "bg-red-400";
      default: return "bg-gray-400";
    }
  };

  const getEntityTypeIcon = (entityType: string) => {
    switch (entityType) {
      case "USER": return <User className="w-4 h-4" />;
      case "PROPERTY": return <Building className="w-4 h-4" />;
      case "ORGANIZATION": return <Building className="w-4 h-4" />;
      default: return <FileText className="w-4 h-4" />;
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold">Consent OS</h1>
          <p className="text-muted-foreground">
            Entity-based consent management for GDPR, CCPA, KVKK compliance
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" size="sm">
            <Filter className="w-4 h-4 mr-2" />
            Advanced Filters
          </Button>
          <Button variant="outline" size="sm">
            <Download className="w-4 h-4 mr-2" />
            Export Report
          </Button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Consents</CardTitle>
            <Shield className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalConsents || 0}</div>
            <p className="text-xs text-muted-foreground">
              {stats?.activeConsents || 0} active
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">GDPR Compliant</CardTitle>
            <CheckCircle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.gdprCompliant || 0}</div>
            <p className="text-xs text-muted-foreground">
              Article 6 & 7 compliant
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">CCPA Opt-Out</CardTitle>
            <AlertTriangle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.ccpaOptOut || 0}</div>
            <p className="text-xs text-muted-foreground">
              Data sale opt-outs
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">KVKK Compliant</CardTitle>
            <CheckCircle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.kvkkCompliant || 0}</div>
            <p className="text-xs text-muted-foreground">
              Turkish law compliant
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Entity Type Distribution */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>Consent by Entity Type</CardTitle>
            <CardDescription>Distribution across entity types</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[
                { label: "User", count: stats?.byEntityType.user || 0, icon: <User className="w-4 h-4" /> },
                { label: "Property Prospect", count: stats?.byEntityType.propertyProspect || 0, icon: <FileText className="w-4 h-4" /> },
                { label: "Owner Profile", count: stats?.byEntityType.ownerProfile || 0, icon: <FileText className="w-4 h-4" /> },
                { label: "Agent Profile", count: stats?.byEntityType.agentProfile || 0, icon: <FileText className="w-4 h-4" /> },
                { label: "Property", count: stats?.byEntityType.property || 0, icon: <Building className="w-4 h-4" /> },
                { label: "Organization", count: stats?.byEntityType.organization || 0, icon: <Building className="w-4 h-4" /> },
              ].map((entity) => (
                <div key={entity.label} className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    {entity.icon}
                    <span className="text-sm">{entity.label}</span>
                  </div>
                  <span className="text-sm font-medium">{entity.count}</span>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle>Consent by Channel</CardTitle>
            <CardDescription>Communication channel breakdown</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[
                { label: "Email", count: stats?.byChannel.email || 0 },
                { label: "SMS", count: stats?.byChannel.sms || 0 },
                { label: "WhatsApp", count: stats?.byChannel.whatsapp || 0 },
                { label: "Ads", count: stats?.byChannel.ads || 0 },
                { label: "AI Communication", count: stats?.byChannel.aiCommunication || 0 },
              ].map((channel) => (
                <div key={channel.label} className="flex items-center justify-between">
                  <span className="text-sm">{channel.label}</span>
                  <span className="text-sm font-medium">{channel.count}</span>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Consent List */}
      <Card>
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle>Consent Records</CardTitle>
              <CardDescription>
                Filtered by entity type, status, and channel
              </CardDescription>
            </div>
            <div className="flex gap-2">
              <select
                value={selectedEntityType}
                onChange={(e) => setSelectedEntityType(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">All Entity Types</option>
                <option value="USER">User</option>
                <option value="PROPERTY_PROSPECT">Property Prospect</option>
                <option value="OWNER_PROFILE">Owner Profile</option>
                <option value="AGENT_PROFILE">Agent Profile</option>
                <option value="PROPERTY">Property</option>
                <option value="ORGANIZATION">Organization</option>
              </select>
              <select
                value={selectedStatus}
                onChange={(e) => setSelectedStatus(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">All Status</option>
                <option value="ACTIVE">Active</option>
                <option value="REVOKED">Revoked</option>
                <option value="EXPIRED">Expired</option>
                <option value="PENDING">Pending</option>
                <option value="DECLINED">Declined</option>
              </select>
              <select
                value={selectedChannel}
                onChange={(e) => setSelectedChannel(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">All Channels</option>
                <option value="EMAIL">Email</option>
                <option value="SMS">SMS</option>
                <option value="WHATSAPP">WhatsApp</option>
                <option value="ADS">Ads</option>
                <option value="AI_COMMUNICATION">AI Communication</option>
              </select>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          {consentsLoading ? (
            <div className="text-center py-8">Loading consents...</div>
          ) : (
            <div className="space-y-4">
              {consents?.map((consent) => (
                <div
                  key={consent.id}
                  className="flex items-center justify-between p-4 border rounded-lg hover:bg-gray-50"
                >
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-2">
                      <Badge className={getStatusColor(consent.status)}>
                        {consent.status}
                      </Badge>
                      <div className="flex items-center gap-1 text-sm text-muted-foreground">
                        {getEntityTypeIcon(consent.entityType)}
                        <span>{consent.entityType.replace(/_/g, " ")}</span>
                      </div>
                      <span className="text-sm text-muted-foreground">
                        {consent.consentChannel}
                      </span>
                    </div>
                    <div className="text-sm font-medium">
                      {consent.consentPurpose}
                    </div>
                    <div className="flex gap-4 mt-2 text-xs text-muted-foreground">
                      <span>Granted: {new Date(consent.grantedAt).toLocaleDateString()}</span>
                      {consent.expiresAt && (
                        <span>Expires: {new Date(consent.expiresAt).toLocaleDateString()}</span>
                      )}
                    </div>
                    <div className="flex gap-2 mt-2">
                      {consent.gdprConsent && <Badge variant="outline" className="text-xs">GDPR</Badge>}
                      {consent.ccpaOptOut && <Badge variant="outline" className="text-xs">CCPA Opt-Out</Badge>}
                      {consent.kvkkConsent && <Badge variant="outline" className="text-xs">KVKK</Badge>}
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
