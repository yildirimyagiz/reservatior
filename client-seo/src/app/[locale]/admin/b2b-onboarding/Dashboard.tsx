"use client";

import { useState } from "react";
import { useTranslation } from "react-i18next";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { b2bBulkOnboardingApi } from "@/lib/api/b2b-bulk-onboarding";
import { tEnum } from "@/lib/admin-enums";
import { 
  Building2,
  Upload,
  Users,
  FileText,
  Mail,
  TrendingUp,
  DollarSign,
  Zap,
  Target,
  Settings,
  Download,
  Filter,
  CheckCircle,
  Clock,
  AlertTriangle,
  BarChart3,
  Globe,
  Sparkles
} from "lucide-react";

export default function B2BOnboardingDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const [activeTab, setActiveTab] = useState<"accounts" | "upload" | "invitations" | "pitch-decks" | "seattle-pilot">("accounts");
  const { t } = useTranslation();

  const { data: seattlePilotStats } = useQuery({
    queryKey: ["seattle-pilot-stats"],
    queryFn: () => b2bBulkOnboardingApi.getSeattlePilotStats(),
  });

  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const formatCurrency = (val: number) => new Intl.NumberFormat(language, { style: 'currency', currency: 'USD', maximumFractionDigits: 0 } as any).format(val);

  const seattleKPIs = seattlePilotStats ? [
    { title: t("admin_b2b_onboarding_targeted_accounts", "Hedeflenen Hesaplar"), value: formatNumber(seattlePilotStats.totalTargetedAccounts), icon: Building2, color: "text-blue-600", trend: "+12%" },
    { title: t("admin_b2b_onboarding_accepted_invitations", "Kabul Edilen Davetiyeler"), value: formatNumber(seattlePilotStats.acceptedInvitations), icon: CheckCircle, color: "text-blue-600", trend: "+8%" },
    { title: t("admin_b2b_onboarding_properties_imported", "İçe Aktarılan Mülkler"), value: formatNumber(seattlePilotStats.totalPropertiesImported), icon: Upload, color: "text-brand", trend: "+45%" },
    { title: t("admin_b2b_onboarding_estimated_revenue", "Tahmini Gelir"), value: formatCurrency(seattlePilotStats.estimatedRevenue), icon: DollarSign, color: "text-blue-600", trend: "+23%" },
  ] : [];

  const tabs = [
    { id: "accounts", label: t("admin_b2b_onboarding_tab_corporate_accounts", "Kurumsal Hesaplar"), icon: Building2 },
    { id: "upload", label: t("admin_b2b_onboarding_bulk_upload", "Toplu Yükleme"), icon: Upload },
    { id: "invitations", label: t("admin_b2b_onboarding_tab_invitations", "Davetiyeler"), icon: Mail },
    { id: "pitch-decks", label: t("admin_b2b_onboarding_tab_ai_pitch_decks", "AI Teklif Sunumları"), icon: FileText },
    { id: "seattle-pilot", label: t("admin_b2b_onboarding_tab_seattle_pilot", "Seattle Pilotu"), icon: Globe },
  ];

  const seattleTargetAccounts = [
    { name: "ABODA", type: "Corporate Housing", properties: 85, status: "Invited", priority: "High" },
    { name: "Sophari", type: "Corporate Housing", properties: 120, status: "Pending", priority: "High" },
    { name: "Seattle Corporate Rentals", type: "Multi-Family", properties: 65, status: "Contacted", priority: "Medium" },
    { name: "Roundtop", type: "Property Management", properties: 45, status: "Negotiating", priority: "Medium" },
    { name: "PNW Suites", type: "Corporate Housing", properties: 95, status: "Invited", priority: "High" },
    { name: "Met Tower", type: "High-Rise Building", properties: 200, status: "Pending", priority: "High" },
    { name: "AMLI SLU", type: "Multi-Family", properties: 350, status: "Contacted", priority: "High" },
    { name: "CityLine", type: "Multi-Family", properties: 180, status: "Pending", priority: "Medium" },
    { name: "AVA Queen Anne", type: "Multi-Family", properties: 150, status: "Invited", priority: "Medium" },
    { name: "Insignia", type: "High-Rise Building", properties: 275, status: "Pending", priority: "High" },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-foreground">{t("admin_b2b_onboarding_title", "B2B Toplu Kayıt")}</h1>
          <p className="text-muted-foreground mt-1">{t("admin_b2b_onboarding_desc", "Kurumsal konut sağlayıcısı toplu satın alma ve portföy yönetimi")}</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
            <Upload className="w-4 h-4" /> {t("admin_b2b_onboarding_bulk_upload", "Toplu Yükleme")}
          </button>
          <button className="px-4 py-2 bg-brand text-white rounded-lg hover:bg-brand transition flex items-center gap-2">
            <Mail className="w-4 h-4" /> {t("admin_b2b_onboarding_send_invitations", "Davetiyeleri Gönder")}
          </button>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex gap-2 border-b border-border">
        {tabs.map((tab) => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id as any)}
            className={`px-4 py-2 flex items-center gap-2 border-b-2 transition ${
              activeTab === tab.id
                ? "border-blue-600 text-blue-600 font-medium"
                : "border-transparent text-muted-foreground hover:text-foreground"
            }`}
          >
            <tab.icon className="w-4 h-4" />
            {tab.label}
          </button>
        ))}
      </div>

      {/* Seattle Pilot Tab */}
      {activeTab === "seattle-pilot" && (
        <div className="space-y-6">
          {/* Seattle Pilot KPIs */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            {seattleKPIs.map((kpi) => (
              <div key={kpi.title} className="bg-card rounded-xl shadow-sm p-6 border border-border">
                <div className="flex items-center justify-between mb-2">
                  <kpi.icon className={`w-5 h-5 ${kpi.color}`} />
                  <span className="text-xs font-medium text-blue-600 bg-blue-50 px-2 py-1 rounded-full">{kpi.trend}</span>
                </div>
                <p className="text-2xl font-bold text-foreground">{kpi.value}</p>
                <p className="text-sm text-muted-foreground">{kpi.title}</p>
              </div>
            ))}
          </div>

          {/* Seattle Target Accounts */}
          <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
            <div className="flex items-center justify-between mb-4">
              <h2 className="text-lg font-semibold text-foreground flex items-center gap-2">
                <Globe className="w-5 h-5 text-blue-600" /> {t("admin_b2b_onboarding_seattle_bellevue_target_accounts", "Seattle/Bellevue Hedef Hesaplar")}
              </h2>
              <div className="flex gap-2">
                <button className="px-3 py-1 bg-blue-100 text-blue-700 rounded-lg text-sm">{t("admin_b2b_onboarding_view_all", "Tümünü Gör")}</button>
                <button className="px-3 py-1 bg-brand/15 text-brand rounded-lg text-sm flex items-center gap-1">
                  <Sparkles className="w-3 h-3" /> {t("admin_b2b_onboarding_generate_ai_reports", "AI Raporları Oluştur")}
                </button>
              </div>
            </div>
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead>
                  <tr className="border-b border-border">
                    <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_b2b_onboarding_account_name", "Hesap Adı")}</th>
                    <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_common_type", "Tür")}</th>
                    <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_b2b_onboarding_properties", "Mülkler")}</th>
                    <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_common_status", "Durum")}</th>
                    <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_common_priority", "Öncelik")}</th>
                    <th className="text-left py-3 px-4 text-sm font-medium text-muted-foreground">{t("admin_common_actions", "İşlemler")}</th>
                  </tr>
                </thead>
                <tbody>
                  {seattleTargetAccounts.map((account) => (
                    <tr key={account.name} className="border-b border-border hover:bg-muted">
                      <td className="py-3 px-4">
                        <div className="flex items-center gap-3">
                          <div className="w-10 h-10 bg-gradient-to-br from-blue-500 to-purple-600 rounded-lg flex items-center justify-center text-white font-bold">
                            {account.name.charAt(0)}
                          </div>
                          <span className="font-medium text-foreground">{account.name}</span>
                        </div>
                      </td>
                      <td className="py-3 px-4 text-sm text-muted-foreground">{tEnum(t, account.type)}</td>
                      <td className="py-3 px-4 text-sm text-muted-foreground">{account.properties}</td>
                      <td className="py-3 px-4">
                        <span className={`text-xs px-2 py-1 rounded-full ${
                          account.status === "Invited" ? "bg-blue-100 text-blue-700" :
                          account.status === "Pending" ? "bg-yellow-100 text-yellow-700" :
                          account.status === "Contacted" ? "bg-brand/15 text-brand" :
                          account.status === "Negotiating" ? "bg-blue-100 text-blue-700" :
                          "bg-gray-100 text-muted-foreground"
                        }`}>
                          {tEnum(t, account.status)}
                        </span>
                      </td>
                      <td className="py-3 px-4">
                        <span className={`text-xs px-2 py-1 rounded-full ${
                          account.priority === "High" ? "bg-red-100 text-red-700" : "bg-gray-100 text-muted-foreground"
                        }`}>
                          {tEnum(t, account.priority)}
                        </span>
                      </td>
                      <td className="py-3 px-4">
                        <div className="flex gap-2">
                          <button className="p-2 hover:bg-gray-100 rounded-lg text-blue-600">
                            <Mail className="w-4 h-4" />
                          </button>
                          <button className="p-2 hover:bg-gray-100 rounded-lg text-brand">
                            <FileText className="w-4 h-4" />
                          </button>
                          <button className="p-2 hover:bg-gray-100 rounded-lg text-muted-foreground">
                            <Settings className="w-4 h-4" />
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>

          {/* Seattle Market Insights */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <h2 className="text-lg font-semibold text-foreground flex items-center gap-2 mb-4">
                <TrendingUp className="w-5 h-5 text-blue-600" /> {t("admin_b2b_onboarding_yield_opportunity_analysis", "Getiri Fırsatı Analizi")}
              </h2>
              <div className="space-y-4">
                <div className="p-4 bg-gradient-to-r from-blue-50 to-blue-50 rounded-lg border border-blue-200">
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-medium text-blue-900">South Lake Union (SLU)</span>
                    <span className="text-sm font-bold text-blue-700">+18.5% Yield</span>
                  </div>
                  <p className="text-sm text-blue-700">{t("admin_b2b_onboarding_corporate_housing_premium", "Kurumsal konut primi ve uzun süreli kiralama karşılaştırması")}</p>
                </div>
                <div className="p-4 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-lg border border-blue-200">
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-medium text-blue-900">Downtown Seattle</span>
                    <span className="text-sm font-bold text-blue-700">+15.2% Yield</span>
                  </div>
                  <p className="text-sm text-blue-700">{t("admin_b2b_onboarding_high_demand", "Amazon & Microsoft taşınmalarından kaynaklanan yüksek talep")}</p>
                </div>
                <div className="p-4 bg-gradient-to-r from-brand to-pink-50 rounded-lg border border-purple-200">
                  <div className="flex items-center justify-between mb-2">
                    <span className="font-medium text-brand">Bellevue</span>
                    <span className="text-sm font-bold text-brand">+12.8% Yield</span>
                  </div>
                  <p className="text-sm text-brand">{t("admin_b2b_onboarding_tech_corridor", "Premium kurumsal talebe sahip teknoloji koridoru")}</p>
                </div>
              </div>
            </div>

            <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <h2 className="text-lg font-semibold text-foreground flex items-center gap-2 mb-4">
                <Target className="w-5 h-5 text-red-600" /> {t("admin_b2b_onboarding_tech_tenant_demand", "Teknoloji Kiracı Talebi")}
              </h2>
              <div className="space-y-4">
                <div className="flex items-center justify-between p-3 bg-muted rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 bg-orange-500 rounded-lg flex items-center justify-center text-white font-bold text-sm">A</div>
                    <span className="font-medium text-foreground">Amazon</span>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-foreground">2,450 {t("admin_b2b_onboarding_units", "birim")}</p>
                    <p className="text-xs text-muted-foreground">{t("admin_b2b_onboarding_monthly_demand", "Aylık talep")}</p>
                  </div>
                </div>
                <div className="flex items-center justify-between p-3 bg-muted rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 bg-blue-500 rounded-lg flex items-center justify-center text-white font-bold text-sm">M</div>
                    <span className="font-medium text-foreground">Microsoft</span>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-foreground">1,890 {t("admin_b2b_onboarding_units", "birim")}</p>
                    <p className="text-xs text-muted-foreground">{t("admin_b2b_onboarding_monthly_demand", "Aylık talep")}</p>
                  </div>
                </div>
                <div className="flex items-center justify-between p-3 bg-muted rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 bg-red-500 rounded-lg flex items-center justify-center text-white font-bold text-sm">G</div>
                    <span className="font-medium text-foreground">Google</span>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-foreground">980 {t("admin_b2b_onboarding_units", "birim")}</p>
                    <p className="text-xs text-muted-foreground">{t("admin_b2b_onboarding_monthly_demand", "Aylık talep")}</p>
                  </div>
                </div>
                <div className="flex items-center justify-between p-3 bg-muted rounded-lg">
                  <div className="flex items-center gap-3">
                    <div className="w-8 h-8 bg-primary text-primary-foreground rounded-lg flex items-center justify-center text-white font-bold text-sm">F</div>
                    <span className="font-medium text-foreground">Meta</span>
                  </div>
                  <div className="text-right">
                    <p className="text-sm font-bold text-foreground">650 {t("admin_b2b_onboarding_units", "birim")}</p>
                    <p className="text-xs text-muted-foreground">{t("admin_b2b_onboarding_monthly_demand", "Aylık talep")}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}

      {/* Other tabs placeholder */}
      {activeTab !== "seattle-pilot" && (
        <div className="bg-card rounded-xl shadow-sm p-12 border border-border text-center">
          <div className="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <Settings className="w-8 h-8 text-gray-400" />
          </div>
          <h3 className="text-lg font-semibold text-foreground mb-2">{tabs.find(tab => tab.id === activeTab)?.label || activeTab}</h3>
          <p className="text-muted-foreground">{t("admin_b2b_onboarding_under_development", "Bu modül geliştirme aşamasındadır. Yakında kontrol edin.")}</p>
        </div>
      )}
    </div>
  );
}
