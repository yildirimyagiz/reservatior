"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useTranslation } from "react-i18next";
import { tEnum } from "@/lib/admin-enums";
import { useQuery } from "@tanstack/react-query";
import { documentOSApi } from "@/lib/api/document-os";
import { 
  FileText, 
  PenTool, 
  Shield, 
  Clock, 
  CheckCircle,
  BarChart3,
  Archive,
  Search,
  AlertTriangle,
  ArrowUpRight,
  ArrowDownRight
} from "lucide-react";

export default function DocumentOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const { t } = useTranslation();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["document-os-dashboard", orgId],
    queryFn: () => documentOSApi.getDashboardStats(orgId),
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
    totalDocuments: 0,
    activeDocuments: 0,
    pendingSignatures: 0,
    completedSignatures: 0,
    totalTemplates: 0,
    complianceScore: 0,
    storageUsed: 0,
    searchSuccessRate: 0,
  };

  const kpis = [
    {
      title: t("admin_document_os_total_documents", "Toplam Belge"),
      value: formatNumber(stats.totalDocuments),
      icon: FileText,
      color: "text-blue-600",
      trend: `+25.3% ${t("admin_document_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_document_os_active_documents", "Aktif Belgeler"),
      value: formatNumber(stats.activeDocuments),
      icon: CheckCircle,
      color: "text-blue-600",
      trend: `+18.7% ${t("admin_document_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_document_os_pending_signatures", "Bekleyen İmzalar"),
      value: formatNumber(stats.pendingSignatures),
      icon: PenTool,
      color: "text-orange-600",
      trend: `-12.5% ${t("admin_document_os_vs_last_month", "geçen aya göre")}`,
      trendUp: false,
    },
    {
      title: t("admin_document_os_completed_signatures", "Tamamlanan İmzalar"),
      value: formatNumber(stats.completedSignatures),
      icon: CheckCircle,
      color: "text-blue-600",
      trend: `+22.1% ${t("admin_document_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_document_os_templates", "Şablonlar"),
      value: formatNumber(stats.totalTemplates),
      icon: Archive,
      color: "text-brand",
      trend: `+15.4% ${t("admin_document_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_document_os_compliance_score", "Uyumluluk Puanı"),
      value: `${stats.complianceScore.toFixed(1)}/100`,
      icon: Shield,
      color: "text-brand",
      trend: `+3.8% ${t("admin_document_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_document_os_storage_used", "Kullanılan Depolama"),
      value: `${(stats.storageUsed / 1024 / 1024).toFixed(1)} GB`,
      icon: BarChart3,
      color: "text-pink-600",
      trend: `+8.2% ${t("admin_document_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
    {
      title: t("admin_document_os_search_success", "Arama Başarısı"),
      value: `${stats.searchSuccessRate.toFixed(1)}%`,
      icon: Search,
      color: "text-cyan-600",
      trend: `+5.6% ${t("admin_document_os_vs_last_month", "geçen aya göre")}`,
      trendUp: true,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_document_os_dashboard_title", "Document OS Panosu")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_document_os_dashboard_desc", "Belge işlemlerini izleyin ve yönetin")}</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition">
            {t("admin_document_os_upload_document", "Belge Yükle")}
          </button>
          <button className="px-4 py-2 border border-border rounded-lg hover:bg-muted transition">
            {t("admin_document_os_create_template", "Şablon Oluştur")}
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
        {/* Document Trends Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_document_os_document_trends", "Belge Eğilimleri")}</h2>
            <BarChart3 className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_document_os_document_trends_placeholder", "Belge eğilimleri grafiği burada gösterilecek")}</p>
          </div>
        </div>

        {/* Signature Status Chart */}
        <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-foreground">{t("admin_document_os_signature_status", "İmza Durumu")}</h2>
            <PenTool className="w-5 h-5 text-muted-foreground" />
          </div>
          <div className="h-64 flex items-center justify-center bg-muted rounded-lg">
            <p className="text-muted-foreground">{t("admin_document_os_signature_status_placeholder", "İmza durumu grafiği burada gösterilecek")}</p>
          </div>
        </div>
      </div>

      {/* Recent Documents */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_document_os_recent_documents", "Son Belgeler")}</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-muted rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <FileText className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-foreground">{t("admin_document_os_document_number", "Belge #")}{1000 + item}</p>
                  <p className="text-sm text-muted-foreground">{t("admin_document_os_lease_agreement", "Kira Sözleşmesi")} • {item} {t("admin_document_os_signatures", "imza")}</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-foreground">{tEnum(t, "Pending")}</p>
                <p className="text-sm text-muted-foreground">{item} {t("admin_common_hours_ago", "saat önce")}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Document Types */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_document_os_document_types", "Belge Türleri")}</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">{t("admin_document_os_lease_agreements", "Kira Sözleşmeleri")}</h3>
            <p className="text-sm text-blue-700 mt-1">{t("admin_document_os_rental_contracts", "Kiralama sözleşmeleri")}</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">45%</p>
            <p className="text-xs text-blue-600">{t("admin_document_os_of_documents", "belgelerin")}</p>
          </div>
          <div className="p-4 bg-brand/10 border border-purple-200 rounded-lg">
            <h3 className="font-semibold text-brand">{t("admin_document_os_purchase_agreements", "Satın Alma Sözleşmeleri")}</h3>
            <p className="text-sm text-brand mt-1">{t("admin_document_os_sales_contracts", "Satış sözleşmeleri")}</p>
            <p className="text-2xl font-bold text-brand mt-2">35%</p>
            <p className="text-xs text-brand">{t("admin_document_os_of_documents", "belgelerin")}</p>
          </div>
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">{t("admin_document_os_other_documents", "Diğer Belgeler")}</h3>
            <p className="text-sm text-blue-700 mt-1">{t("admin_document_os_miscellaneous", "Çeşitli")}</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">20%</p>
            <p className="text-xs text-blue-600">{t("admin_document_os_of_documents", "belgelerin")}</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-foreground">{t("admin_document_os_document_alerts", "Belge Uyarıları")}</h2>
          <AlertTriangle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertTriangle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">{t("admin_document_os_pending_signatures_expiring", "Yakında süresi dolacak bekleyen imzalar")}</p>
              <p className="text-sm text-yellow-700">{t("admin_document_os_documents_expiring", "5 belgenin imzaları 24 saat içinde süresi dolacak")}</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-blue-600 mt-0.5" />
            <div>
              <p className="font-medium text-blue-900">{t("admin_document_os_compliance_score_improved", "Uyumluluk puanı iyileşti")}</p>
              <p className="text-sm text-blue-700">{t("admin_document_os_compliance_increased", "Genel uyumluluk puanı %3,8 arttı")}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
