"use client";


import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { agentOSApi } from "@/lib/api/agent-os";
import { 
  Users, 
  TrendingUp, 
  DollarSign, 
  Shield, 
  Award,
  BarChart3,
  Network,
  MessageSquare,
  CheckCircle,
  AlertTriangle,
  ArrowUpRight,
  ArrowDownRight
} from "lucide-react";
import { useAuth } from "@/lib/auth";

export default function AgentOSDashboard() {
  const { user } = useAuth();
  const { currency, language } = useLocalization();
  const { t } = useTranslation();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["agent-os-dashboard", orgId],
    queryFn: () => agentOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

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
    totalAgents: 0,
    activeAgents: 0,
    totalCommissions: 0,
    averagePerformance: 0,
    averageTrustScore: 0,
    totalLeads: 0,
    conversionRate: 0,
    trainingCompletion: 0,
  };

  const kpis = [
    {
      title: t("admin_agent_os_total_agents", "Toplam Temsilci"),
      value: formatNumber(stats.totalAgents),
      icon: Users,
      color: "text-blue-600",
      trend: "+18.2% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_agent_os_active_agents", "Aktif Temsilciler"),
      value: formatNumber(stats.activeAgents),
      icon: CheckCircle,
      color: "text-blue-600",
      trend: "+15.8% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_agent_os_total_commissions", "Toplam Komisyon"),
      value: formatCurrency(stats.totalCommissions),
      icon: DollarSign,
      color: "text-brand",
      trend: "+22.5% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_agent_os_avg_performance", "Ort. Performans"),
      value: `${stats.averagePerformance.toFixed(1)}/100`,
      icon: Award,
      color: "text-orange-600",
      trend: "+5.3% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_agent_os_avg_trust_score", "Ort. Güven Puanı"),
      value: `${stats.averageTrustScore.toFixed(2)}`,
      icon: Shield,
      color: "text-blue-600",
      trend: "+3.7% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_agent_os_total_leads", "Toplam Müşteri Adayı"),
      value: formatNumber(stats.totalLeads),
      icon: Network,
      color: "text-brand",
      trend: "+28.1% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_agent_os_conversion_rate", "Dönüşüm Oranı"),
      value: `${stats.conversionRate.toFixed(1)}%`,
      icon: TrendingUp,
      color: "text-pink-600",
      trend: "+7.4% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_agent_os_training_completion", "Eğitim Tamamlama"),
      value: `${stats.trainingCompletion.toFixed(1)}%`,
      icon: BarChart3,
      color: "text-cyan-600",
      trend: "+12.2% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_agent_os_title", "Acente OS Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_agent_os_desc", "Acente operasyonlarını izleyin ve yönetin")}</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition">
            {t("admin_agent_os_invite_agent", "Temsilci Davet Et")}
          </button>
          <button className="px-4 py-2 border border-border rounded-lg hover:bg-muted transition">
            {t("admin_agent_os_view_leaderboard", "Liderlik Tablosunu Görüntüle")}
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
        {/* Performance Trends Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_agent_os_performance_trends", "Performans Trendleri")}</h2>
            <BarChart3 className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_agent_os_performance_trends_placeholder", "Performans trendleri grafiği burada gösterilecek")}</p>
          </div>
        </div>

        {/* Trust Score Distribution */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_agent_os_trust_score_distribution", "Güven Puanı Dağılımı")}</h2>
            <Shield className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_agent_os_trust_score_distribution_placeholder", "Güven puanı dağılımı grafiği burada gösterilecek")}</p>
          </div>
        </div>
      </div>

      {/* Top Performers */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_agent_os_top_performers", "En İyi Performans Gösterenler")}</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-muted rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-yellow-100 rounded-lg">
                  <Award className="w-5 h-5 text-yellow-600" />
                </div>
                <div>
                  <p className="font-medium text-foreground">{t("admin_agent_os_agent_label", "Temsilci #")}{1000 + item}</p>
                  <p className="text-sm text-muted-foreground">{item * 15} {t("admin_agent_os_deals_closed", "anlaşma tamamlandı")}</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-foreground">{formatCurrency(500000 + item * 100000)}</p>
                <p className="text-sm text-muted-foreground">{t("admin_agent_os_score_label", "Puan:")} {95 - item * 2}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Agent Network Activity */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_agent_os_network_activity", "Ağ Etkinliği")}</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">{t("admin_agent_os_high_activity", "Yüksek Etkinlik")}</h3>
            <p className="text-sm text-blue-700 mt-1">{t("admin_agent_os_strong_network", "Güçlü ağ bağlantıları")}</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">45%</p>
            <p className="text-xs text-blue-600">{t("admin_agent_os_of_agents", "temsilcinin")}</p>
          </div>
          <div className="p-4 bg-brand/10 border border-purple-200 rounded-lg">
            <h3 className="font-semibold text-brand">{t("admin_agent_os_moderate_activity", "Orta Etkinlik")}</h3>
            <p className="text-sm text-brand mt-1">{t("admin_agent_os_growing_network", "Büyüyen ağ")}</p>
            <p className="text-2xl font-bold text-brand mt-2">40%</p>
            <p className="text-xs text-brand">{t("admin_agent_os_of_agents", "temsilcinin")}</p>
          </div>
          <div className="p-4 bg-muted border border-border rounded-lg">
            <h3 className="font-semibold text-foreground">{t("admin_agent_os_low_activity", "Düşük Etkinlik")}</h3>
            <p className="text-sm text-muted-foreground mt-1">{t("admin_agent_os_limited_network", "Sınırlı ağ")}</p>
            <p className="text-2xl font-bold text-foreground mt-2">15%</p>
            <p className="text-xs text-muted-foreground">{t("admin_agent_os_of_agents", "temsilcinin")}</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground">{t("admin_agent_os_agent_alerts", "Temsilci Uyarıları")}</h2>
          <AlertTriangle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertTriangle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">{t("admin_agent_os_alert_performance_decline", "Performans düşüşü tespit edildi")}</p>
              <p className="text-sm text-yellow-700">{t("admin_agent_os_alert_performance_decline_detail", "Bu hafta performans düşüşü gösteren 3 temsilci")}</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-blue-600 mt-0.5" />
            <div>
              <p className="font-medium text-blue-900">{t("admin_agent_os_alert_training_milestone", "Eğitim hedefine ulaşıldı")}</p>
              <p className="text-sm text-blue-700">{t("admin_agent_os_alert_training_milestone_detail", "Temsilcilerin %85'i gerekli eğitimi tamamladı")}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
