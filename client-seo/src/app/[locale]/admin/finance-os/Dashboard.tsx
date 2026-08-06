"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useTranslation } from "react-i18next";
import { financeOSApi } from "@/lib/api/finance-os";
import CommissionRuleEngineDashboard from "@/components/financial/CommissionRuleEngineDashboard";
import { 
  DollarSign, 
  TrendingUp, 
  Briefcase, 
  CreditCard, 
  PieChart, 
  BarChart3,
  Calendar,
  Users,
  AlertCircle,
  CheckCircle,
  Clock,
  ArrowUpRight,
  ArrowDownRight
} from "lucide-react";

export default function FinanceOSDashboard() {
  const { user } = useAuth();
  const { currency, language } = useLocalization();
  const { t } = useTranslation();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["finance-os-dashboard", orgId],
    queryFn: () => financeOSApi.getDashboardStats(orgId),
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
    totalRevenue: 0,
    totalCommissions: 0,
    activeDeals: 0,
    closedDeals: 0,
    pendingCommissions: 0,
    paidCommissions: 0,
    averageDealValue: 0,
    commissionRate: 0,
  };

  const kpis = [
    {
      title: t("admin_finance_os_total_revenue", "Toplam Gelir"),
      value: formatCurrency(stats.totalRevenue),
      icon: DollarSign,
      color: "text-blue-600",
      trend: "+18.5% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_finance_os_total_commissions", "Toplam Komisyon"),
      value: formatCurrency(stats.totalCommissions),
      icon: Briefcase,
      color: "text-blue-600",
      trend: "+12.3% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_finance_os_active_deals", "Aktif Anlaşmalar"),
      value: formatNumber(stats.activeDeals),
      icon: Calendar,
      color: "text-brand",
      trend: "+8.7% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_finance_os_closed_deals", "Kapanan Anlaşmalar"),
      value: formatNumber(stats.closedDeals),
      icon: CheckCircle,
      color: "text-blue-600",
      trend: "+15.2% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_finance_os_pending_commissions", "Bekleyen Komisyonlar"),
      value: formatCurrency(stats.pendingCommissions),
      icon: Clock,
      color: "text-yellow-600",
      trend: "-5.4% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: false,
    },
    {
      title: t("admin_finance_os_paid_commissions", "Ödenen Komisyonlar"),
      value: formatCurrency(stats.paidCommissions),
      icon: CreditCard,
      color: "text-brand",
      trend: "+22.1% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_finance_os_average_deal_value", "Ortalama Anlaşma Değeri"),
      value: formatCurrency(stats.averageDealValue),
      icon: TrendingUp,
      color: "text-orange-600",
      trend: "+7.8% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
    {
      title: t("admin_finance_os_commission_rate", "Komisyon Oranı"),
      value: `${stats.commissionRate.toFixed(2)}%`,
      icon: PieChart,
      color: "text-pink-600",
      trend: "+0.5% " + t("admin_common_vs_last_month", "geçen aya göre"),
      trendUp: true,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_finance_os_title", "Finans OS Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_finance_os_desc", "Finansal operasyonları izleyin ve yönetin")}</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition">
            {t("admin_finance_os_new_deal", "Yeni Anlaşma")}
          </button>
          <button className="px-4 py-2 border border-border rounded-lg hover:bg-muted transition">
            {t("admin_finance_os_generate_report", "Rapor Oluştur")}
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
        {/* Revenue Trends Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_finance_os_revenue_trends", "Gelir Trendleri")}</h2>
            <BarChart3 className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_finance_os_revenue_trends_placeholder", "Gelir trendleri grafiği burada gösterilecek")}</p>
          </div>
        </div>

        {/* Commission Distribution Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_finance_os_commission_distribution", "Komisyon Dağılımı")}</h2>
            <PieChart className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_finance_os_commission_distribution_placeholder", "Komisyon dağılımı grafiği burada gösterilecek")}</p>
          </div>
        </div>
      </div>

      {/* Recent Deals */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_finance_os_recent_deals", "Son Anlaşmalar")}</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-muted rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Briefcase className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-foreground">{t("admin_finance_os_deal_label", "Anlaşma #")}{1000 + item}</p>
                  <p className="text-sm text-muted-foreground">{t("admin_finance_os_property_label", "Mülk #")}{500 + item}</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-foreground">{formatCurrency(250000 + item * 50000)}</p>
                <p className="text-sm text-muted-foreground">{item} {t("admin_common_days_ago", "gün önce")}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Commission Models */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_finance_os_commission_models", "Komisyon Modelleri")}</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">{t("admin_finance_os_model_traditional", "Geleneksel 1M")}</h3>
            <p className="text-sm text-blue-700 mt-1">{t("admin_finance_os_lump_sum_payment", "Tek seferde ödeme")}</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">45%</p>
            <p className="text-xs text-blue-600">{t("admin_finance_os_of_total_deals", "toplam anlaşmaların")}</p>
          </div>
          <div className="p-4 bg-brand/10 border border-purple-200 rounded-lg">
            <h3 className="font-semibold text-brand">{t("admin_finance_os_model_installment", "12 Taksit")}</h3>
            <p className="text-sm text-brand mt-1">{t("admin_finance_os_monthly_payments", "12 aylık ödeme")}</p>
            <p className="text-2xl font-bold text-brand mt-2">35%</p>
            <p className="text-xs text-brand">{t("admin_finance_os_of_total_deals", "toplam anlaşmaların")}</p>
          </div>
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">{t("admin_finance_os_model_hybrid", "Hibrit 50/6")}</h3>
            <p className="text-sm text-blue-700 mt-1">{t("admin_finance_os_hybrid_payments", "%50 peşin + 6 taksit")}</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">20%</p>
            <p className="text-xs text-blue-600">{t("admin_finance_os_of_total_deals", "toplam anlaşmaların")}</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_finance_os_commission_rule_engine", "Komisyon Kural Motoru")}</h2>
        <CommissionRuleEngineDashboard />
      </div>

      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground">{t("admin_finance_os_alerts", "Uyarılar ve Bildirimler")}</h2>
          <AlertCircle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertCircle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">{t("admin_finance_os_alert_pending_commissions", "Yüksek bekleyen komisyonlar")}</p>
              <p className="text-sm text-yellow-700">{t("admin_finance_os_alert_pending_commissions_detail", "Bekleyen komisyonlar bu hafta %15 arttı")}</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-blue-600 mt-0.5" />
            <div>
              <p className="font-medium text-blue-900">{t("admin_finance_os_alert_revenue_target", "Gelir hedefine ulaşıldı")}</p>
              <p className="text-sm text-blue-700">{t("admin_finance_os_alert_revenue_target_detail", "Aylık gelir hedefi %18 aşıldı")}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
