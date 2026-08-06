"use client";
import { useState } from "react";
import { useTranslation } from "react-i18next";
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
import { consentOSApi, Consent, ConsentStats } from "@/lib/api/consent-os";
import { tEnum } from "@/lib/admin-enums";

export default function Dashboard() {
  const [selectedEntityType, setSelectedEntityType] = useState<string>("all");
  const [selectedStatus, setSelectedStatus] = useState<string>("all");
  const [selectedChannel, setSelectedChannel] = useState<string>("all");
  const orgId = "current-org";
  const { t } = useTranslation();

  const { data: stats } = useQuery({
    queryKey: ["consent-stats", orgId],
    queryFn: () => consentOSApi.getStats(orgId),
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
      case "ACTIVE": return "bg-blue-500";
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
          <h1 className="text-3xl font-bold">{t("consent_os.title", "Onay OS")}</h1>
          <p className="text-muted-foreground">
            {t("consent_os.subtitle", "GDPR, CCPA, KVKK uyumluluğu için varlık tabanlı onay yönetimi")}
          </p>
        </div>
        <div className="flex gap-2">
          <Button variant="outline" size="sm">
            <Filter className="w-4 h-4 mr-2" />
            {t("consent_os.advanced_filters", "Gelişmiş Filtreler")}
          </Button>
          <Button variant="outline" size="sm">
            <Download className="w-4 h-4 mr-2" />
            {t("admin_consent_os_export_report", "Raporu Dışa Aktar")}
          </Button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("consent_os.total_consents", "Toplam Onaylar")}</CardTitle>
            <Shield className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.totalConsents || 0}</div>
            <p className="text-xs text-muted-foreground">
              {stats?.activeConsents || 0} {t("consent_os.active", "aktif")}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("consent_os.gdpr_compliant", "GDPR Uyumlu")}</CardTitle>
            <CheckCircle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.gdprCompliant || 0}</div>
            <p className="text-xs text-muted-foreground">
              {t("consent_os.gdpr_compliant_desc", "Madde 6 & 7 uyumlu")}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("consent_os.ccpa_optout", "CCPA Vazgeçme")}</CardTitle>
            <AlertTriangle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.ccpaOptOut || 0}</div>
            <p className="text-xs text-muted-foreground">
              {t("consent_os.ccpa_optout_desc", "Veri satışı vazgeçmeleri")}
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">{t("consent_os.kvkk_compliant", "KVKK Uyumlu")}</CardTitle>
            <CheckCircle className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats?.kvkkCompliant || 0}</div>
            <p className="text-xs text-muted-foreground">
              {t("consent_os.kvkk_compliant_desc", "Türk hukukuna uyumlu")}
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Entity Type Distribution */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>{t("consent_os.consent_by_entity_type", "Varlık Türüne Göre Onay")}</CardTitle>
            <CardDescription>{t("consent_os.consent_by_entity_type_desc", "Varlık türleri genelinde dağılım")}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[
                { label: t("consent_os.entity.user", "Kullanıcı"), count: stats?.byEntityType.user || 0, icon: <User className="w-4 h-4" /> },
                { label: t("consent_os.entity.property_prospect", "Mülk Adayı"), count: stats?.byEntityType.propertyProspect || 0, icon: <FileText className="w-4 h-4" /> },
                { label: t("consent_os.entity.owner_profile", "Malik Profili"), count: stats?.byEntityType.ownerProfile || 0, icon: <FileText className="w-4 h-4" /> },
                { label: t("consent_os.entity.agent_profile", "Danışman Profili"), count: stats?.byEntityType.agentProfile || 0, icon: <FileText className="w-4 h-4" /> },
                { label: t("consent_os.entity.property", "Mülk"), count: stats?.byEntityType.property || 0, icon: <Building className="w-4 h-4" /> },
                { label: t("consent_os.entity.organization", "Organizasyon"), count: stats?.byEntityType.organization || 0, icon: <Building className="w-4 h-4" /> },
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
            <CardTitle>{t("consent_os.consent_by_channel", "Kanala Göre Onay")}</CardTitle>
            <CardDescription>{t("consent_os.consent_by_channel_desc", "İletişim kanalı dağılımı")}</CardDescription>
          </CardHeader>
          <CardContent>
            <div className="space-y-4">
              {[
                { label: t("consent_os.channel.email", "E-posta"), count: stats?.byChannel.email || 0 },
                { label: t("consent_os.channel.sms", "SMS"), count: stats?.byChannel.sms || 0 },
                { label: t("consent_os.channel.whatsapp", "WhatsApp"), count: stats?.byChannel.whatsapp || 0 },
                { label: t("consent_os.channel.ads", "Reklamlar"), count: stats?.byChannel.ads || 0 },
                { label: t("consent_os.channel.ai_communication", "Yapay Zeka İletişimi"), count: stats?.byChannel.aiCommunication || 0 },
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
              <CardTitle>{t("consent_os.records", "Onay Kayıtları")}</CardTitle>
              <CardDescription>
                {t("consent_os.records_desc", "Varlık türü, durum ve kanala göre filtrelenmiş")}
              </CardDescription>
            </div>
            <div className="flex gap-2">
              <select
                value={selectedEntityType}
                onChange={(e) => setSelectedEntityType(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">{t("consent_os.filter.all_entity_types", "Tüm Varlık Türleri")}</option>
                <option value="USER">{tEnum(t, "USER")}</option>
                <option value="PROPERTY_PROSPECT">{tEnum(t, "PROPERTY_PROSPECT")}</option>
                <option value="OWNER_PROFILE">{tEnum(t, "OWNER_PROFILE")}</option>
                <option value="AGENT_PROFILE">{tEnum(t, "AGENT_PROFILE")}</option>
                <option value="PROPERTY">{tEnum(t, "PROPERTY")}</option>
                <option value="ORGANIZATION">{tEnum(t, "ORGANIZATION")}</option>
              </select>
              <select
                value={selectedStatus}
                onChange={(e) => setSelectedStatus(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">{t("consent_os.filter.all_status", "Tüm Durumlar")}</option>
                <option value="ACTIVE">{tEnum(t, "ACTIVE")}</option>
                <option value="REVOKED">{tEnum(t, "REVOKED")}</option>
                <option value="EXPIRED">{tEnum(t, "EXPIRED")}</option>
                <option value="PENDING">{tEnum(t, "PENDING")}</option>
                <option value="DECLINED">{tEnum(t, "DECLINED")}</option>
              </select>
              <select
                value={selectedChannel}
                onChange={(e) => setSelectedChannel(e.target.value)}
                className="px-3 py-2 border rounded-md text-sm"
              >
                <option value="all">{t("consent_os.filter.all_channels", "Tüm Kanallar")}</option>
                <option value="EMAIL">{tEnum(t, "EMAIL")}</option>
                <option value="SMS">{tEnum(t, "SMS")}</option>
                <option value="WHATSAPP">{tEnum(t, "WHATSAPP")}</option>
                <option value="ADS">{tEnum(t, "ADS")}</option>
                <option value="AI_COMMUNICATION">{tEnum(t, "AI_COMMUNICATION")}</option>
              </select>
            </div>
          </div>
        </CardHeader>
        <CardContent>
          {consentsLoading ? (
            <div className="text-center py-8">{t("consent_os.loading", "Onaylar yükleniyor...")}</div>
          ) : (
            <div className="space-y-4">
              {consents?.map((consent) => (
                <div
                  key={consent.id}
                  className="flex items-center justify-between p-4 border rounded-lg hover:bg-muted"
                >
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-2">
                      <Badge className={getStatusColor(consent.status)}>
                        {tEnum(t, consent.status)}
                      </Badge>
                      <div className="flex items-center gap-1 text-sm text-muted-foreground">
                        {getEntityTypeIcon(consent.entityType)}
                        <span>{tEnum(t, consent.entityType)}</span>
                      </div>
                      <span className="text-sm text-muted-foreground">
                        {tEnum(t, consent.consentChannel)}
                      </span>
                    </div>
                    <div className="text-sm font-medium">
                      {consent.consentPurpose}
                    </div>
                    <div className="flex gap-4 mt-2 text-xs text-muted-foreground">
                      <span>{t("consent_os.granted", "Verildi")}: {new Date(consent.grantedAt).toLocaleDateString()}</span>
                      {consent.expiresAt && (
                        <span>{t("consent_os.expires", "Son Kullanma")}: {new Date(consent.expiresAt).toLocaleDateString()}</span>
                      )}
                    </div>
                    <div className="flex gap-2 mt-2">
                      {consent.gdprConsent && <Badge variant="outline" className="text-xs">{t("consent_os.badge.gdpr", "GDPR")}</Badge>}
                      {consent.ccpaOptOut && <Badge variant="outline" className="text-xs">{t("consent_os.badge.ccpa", "CCPA Opt-Out")}</Badge>}
                      {consent.kvkkConsent && <Badge variant="outline" className="text-xs">{t("consent_os.badge.kvkk", "KVKK")}</Badge>}
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
