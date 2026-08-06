"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useTranslation } from "react-i18next";
import { tEnum } from "@/lib/admin-enums";
import { useQuery } from "@tanstack/react-query";
import { identityOSApi } from "@/lib/api/identity-os";
import { 
  Users, 
  Building2, 
  Shield, 
  Key, 
  Activity, 
  AlertTriangle,
  BarChart3,
  CheckCircle,
  TrendingUp,
  ArrowUpRight,
  ArrowDownRight
} from "lucide-react";

export default function IdentityOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const { t } = useTranslation();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["identity-os-dashboard", orgId],
    queryFn: () => identityOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const formatNumber = (val: number) =>
    new Intl.NumberFormat(language).format(val);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  const stats = dashboardStats || {
    totalUsers: 0,
    activeUsers: 0,
    totalOrganizations: 0,
    activeSessions: 0,
    failedLogins: 0,
    mfaAdoptionRate: 0,
    complianceScore: 0,
    securityIncidents: 0,
  };

  const kpis = [
    {
      title: t("admin_identity_os_total_users", "Toplam Kullanıcı"),
      value: formatNumber(stats.totalUsers),
      icon: Users,
      color: "text-blue-600",
      trend: `+15.2% ${t("admin_identity_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_identity_os_active_users", "Aktif Kullanıcılar"),
      value: formatNumber(stats.activeUsers),
      icon: Activity,
      color: "text-blue-600",
      trend: `+12.8% ${t("admin_identity_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_identity_os_organizations", "Organizasyonlar"),
      value: formatNumber(stats.totalOrganizations),
      icon: Building2,
      color: "text-brand",
      trend: `+8.5% ${t("admin_identity_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_identity_os_active_sessions", "Aktif Oturumlar"),
      value: formatNumber(stats.activeSessions),
      icon: Shield,
      color: "text-orange-600",
      trend: `+18.3% ${t("admin_identity_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_identity_os_failed_logins", "Başarısız Girişler"),
      value: formatNumber(stats.failedLogins),
      icon: AlertTriangle,
      color: "text-red-600",
      trend: `-12.4% ${t("admin_identity_os_vs_last_month", "geçen aya göre")}`,
      trendUp: false,
    },
    {
      title: t("admin_identity_os_mfa_adoption", "MFA Benimsenmesi"),
      value: `${stats.mfaAdoptionRate.toFixed(1)}%`,
      icon: Key,
      color: "text-brand",
      trend: `+5.7% ${t("admin_identity_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_identity_os_compliance_score", "Uyumluluk Puanı"),
      value: `${stats.complianceScore.toFixed(1)}/100`,
      icon: CheckCircle,
      color: "text-blue-600",
      trend: `+2.3% ${t("admin_identity_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_identity_os_security_incidents", "Güvenlik Olayları"),
      value: formatNumber(stats.securityIncidents),
      icon: Shield,
      color: "text-pink-600",
      trend: `-8.1% ${t("admin_identity_os_vs_last_month", "geçen aya göre")}`,
      trendUp: false,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_identity_os_dashboard_title", "Identity OS Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_identity_os_dashboard_desc", "Kimlik ve erişimi izleyin ve yönetin")}</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition">
            {t("admin_identity_os_new_user", "Yeni Kullanıcı")}
          </button>
          <button className="px-4 py-2 border border-border rounded-lg hover:bg-muted transition">
            {t("admin_identity_os_audit_report", "Denetim Raporu")}
          </button>
        </div>
      </div>

      {/* KPI Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-muted-foreground">{kpi.title}</p>
                  <p className="text-2xl font-bold text-foreground mt-2">{kpi.value}</p>
                  <div className="flex items-center gap-1 mt-1">
                    {kpi.trendUp ? (
                      <ArrowUpRight className="w-4 h-4 text-blue-600" />
                    ) : (
                      <ArrowDownRight className="w-4 h-4 text-red-600" />
                    )}
                    <p className={`text-sm ${kpi.trendUp ? 'text-blue-600' : 'text-red-600'}`}>
                      {kpi.trend}
                    </p>
                  </div>
                </div>
                <div className={`p-3 bg-muted rounded-lg ${kpi.color}`}>
                  <Icon className="w-6 h-6" />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      {/* Charts Section */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* User Activity Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_identity_os_user_activity", "Kullanıcı Etkinliği")}</h2>
            <BarChart3 className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_identity_os_user_activity_placeholder", "Kullanıcı etkinliği grafiği burada gösterilecek")}</p>
          </div>
        </div>

        {/* Security Trends Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_identity_os_security_trends", "Güvenlik Eğilimleri")}</h2>
            <TrendingUp className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_identity_os_security_trends_placeholder", "Güvenlik eğilimleri grafiği burada gösterilecek")}</p>
          </div>
        </div>
      </div>

      {/* Recent Organizations */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_identity_os_recent_organizations", "Son Organizasyonlar")}</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-muted rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Building2 className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-foreground">{t("admin_identity_os_organization_number", "Organizasyon #")}{1000 + item}</p>
                  <p className="text-sm text-muted-foreground">{t("admin_identity_os_agency", "Ajans")} • {item * 15} {t("admin_identity_os_users", "kullanıcı")}</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-foreground">{tEnum(t, "Active")}</p>
                <p className="text-sm text-muted-foreground">{item} {t("admin_common_days_ago", "gün önce")}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Security Overview */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_identity_os_security_overview", "Güvenlik Genel Bakış")}</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">{t("admin_common_excellent", "Mükemmel")}</h3>
            <p className="text-sm text-blue-700 mt-1">{t("admin_identity_os_high_mfa_adoption", "Yüksek MFA benimseme oranı")}</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">85%</p>
            <p className="text-xs text-blue-600">{t("admin_identity_os_mfa_enabled", "MFA etkin")}</p>
          </div>
          <div className="p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <h3 className="font-semibold text-yellow-900">{t("admin_common_good", "İyi")}</h3>
            <p className="text-sm text-yellow-700 mt-1">{t("admin_identity_os_compliance_score_label", "Uyumluluk puanı")}</p>
            <p className="text-2xl font-bold text-yellow-900 mt-2">92%</p>
            <p className="text-xs text-yellow-600">{t("admin_identity_os_compliance_rate", "uyumluluk oranı")}</p>
          </div>
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">{t("admin_common_low_risk", "Düşük Risk")}</h3>
            <p className="text-sm text-blue-700 mt-1">{t("admin_identity_os_security_incidents_label", "Güvenlik olayları")}</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">3</p>
            <p className="text-xs text-blue-600">{t("admin_identity_os_incidents_this_month", "bu ayki olaylar")}</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground">{t("admin_identity_os_security_alerts", "Güvenlik Uyarıları")}</h2>
          <AlertTriangle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertTriangle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">{t("admin_identity_os_unusual_login_activity", "Olağandışı giriş etkinliği tespit edildi")}</p>
              <p className="text-sm text-yellow-700">{t("admin_identity_os_multiple_failed_login", "Yeni konumdan birden fazla başarısız giriş denemesi")}</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-blue-600 mt-0.5" />
            <div>
              <p className="font-medium text-blue-900">{t("admin_identity_os_mfa_target_achieved", "MFA benimseme hedefine ulaşıldı")}</p>
              <p className="text-sm text-blue-700">{t("admin_identity_os_mfa_enabled_for_users", "Kullanıcıların %85'i için MFA etkinleştirildi")}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
