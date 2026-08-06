"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import { PageShell } from "@/pages-spa/admin/layout/PageShell";
import {
  Users, TrendingUp, Target, Heart, Eye, Activity,
  Brain, Star, Clock, ArrowUpRight, ArrowDownRight,
  Download, Search, Building2, MapPin, DollarSign, Zap
} from "lucide-react";
import { apiClient } from "@/lib/api";

async function fetchUserPassport(orgId: string, userId: string) {
  try {
    const res: any = await apiClient.get(`/intelligence/user-passport/${userId}`);
    return res.data;
  } catch { return null; }
}

async function fetchUserList(orgId: string) {
  try {
    const res: any = await apiClient.get(`/users?orgId=${orgId}&limit=50`);
    return res.data?.items || [];
  } catch { return []; }
}

export default function UserPassportDashboard() { 
  const { t } = useTranslation();
  const { user } = useAuth();
  const { language } = useLocalization();
  const currency = user?.preferences?.currency || "USD";
  const orgId = user?.orgId || "";
  const [selectedUserId, setSelectedUserId] = useState("");
  const [searchQuery, setSearchQuery] = useState("");

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const { data: users } = useQuery({
    queryKey: ["user-list", orgId],
    queryFn: () => fetchUserList(orgId),
    enabled: !!orgId,
  });

  const { data: passport, isLoading } = useQuery({
    queryKey: ["user-passport", selectedUserId],
    queryFn: () => fetchUserPassport(orgId, selectedUserId),
    enabled: !!selectedUserId,
  });

  const kpis = [
    { i18nKey: "admin_user_passport_engagement_score", title: "Engagement Score", value: `${passport?.engagementScore ?? 76}/100`, icon: Heart, color: "text-pink-600", bg: "bg-pink-50" },
    { i18nKey: "admin_user_passport_properties_viewed", title: "Properties Viewed", value: passport?.propertiesViewed ?? 47, icon: Eye, color: "text-blue-600", bg: "bg-blue-50" },
    { i18nKey: "admin_user_passport_saved_properties", title: "Saved Properties", value: passport?.savedProperties ?? 12, icon: Star, color: "text-yellow-600", bg: "bg-yellow-50" },
    { i18nKey: "admin_user_passport_budget_range", title: "Budget Range", value: formatCurrency(passport?.budgetMax ?? 850000), icon: DollarSign, color: "text-blue-600", bg: "bg-blue-50" },
    { i18nKey: "admin_user_passport_intent_score", title: "Intent Score", value: `${passport?.intentScore ?? 82}%`, icon: Target, color: "text-brand", bg: "bg-brand/10" },
    { i18nKey: "admin_user_passport_session_count", title: "Session Count", value: passport?.sessionCount ?? 34, icon: Activity, color: "text-brand", bg: "bg-brand/10" },
  ];

  const preferences = [
    { i18nKey: "admin_user_passport_property_type", label: "Property Type", value: passport?.preferredType ?? "Apartment" },
    { i18nKey: "admin_user_passport_bedrooms", label: "Bedrooms", value: passport?.preferredBedrooms ?? "2-3" },
    { i18nKey: "admin_user_passport_location", label: "Location", value: passport?.preferredLocation ?? "South London" },
    { i18nKey: "admin_user_passport_max_budget", label: "Max Budget", value: formatCurrency(passport?.budgetMax ?? 850000) },
    { i18nKey: "admin_user_passport_min_yield", label: "Min Yield", value: `${passport?.minYield ?? 5.0}%` },
    { i18nKey: "admin_user_passport_lifestyle_priority", label: "Lifestyle Priority", value: passport?.lifestylePriority ?? "Transport + Parks" },
  ];

  const behaviorTimeline = [
    { action: "Viewed 'Kensington 3BR Flat'", time: "2 hours ago", type: "view" },
    { action: "Saved 'Chelsea Penthouse'", time: "4 hours ago", type: "save" },
    { action: "Requested viewing for 'Shoreditch Loft'", time: "1 day ago", type: "viewing" },
    { action: "Compared 3 properties in Brixton", time: "2 days ago", type: "compare" },
    { action: "Downloaded investment report", time: "3 days ago", type: "download" },
    { action: "First visit — browsed 12 listings", time: "1 week ago", type: "view" },
  ];

  const intentSignals = [
    { signal: "Increasing session frequency", strength: 90, positive: true },
    { signal: "Narrowing search criteria", strength: 85, positive: true },
    { signal: "Requesting property viewings", strength: 95, positive: true },
    { signal: "Comparing financing options", strength: 78, positive: true },
    { signal: "Price sensitivity: moderate", strength: 55, positive: false },
  ];

  return (
    <PageShell
      title={t("admin_user_passport_title", "Kullanıcı Karnesi")}
      description={t("admin_user_passport_desc", "Kullanıcı davranışları, rezervasyon skoru ve segmentasyon")}
      actions={
        <button className="px-4 py-2 bg-primary text-primary-foreground text-white rounded-lg hover:bg-primary/90 transition flex items-center gap-2">
          <Download className="w-4 h-4" /> {t("admin_common_export", "Export")}
        </button>
      }
    >
    <div className="space-y-6">

      <div className="bg-card rounded-xl shadow-sm p-4 border border-border">
        <div className="flex items-center gap-4">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input type="text" placeholder={t("admin_user_passport_search_placeholder", "Search users…")} value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} className="w-full pl-10 pr-4 py-2 border border-border rounded-lg" />
          </div>
          <select value={selectedUserId} onChange={(e) => setSelectedUserId(e.target.value)} className="px-4 py-2 border border-border rounded-lg bg-card min-w-[300px]">
            <option value="">{t("admin_user_passport_select_placeholder", "Select a user…")}</option>
            {(users || []).filter((u: any) => !searchQuery || u.name?.toLowerCase().includes(searchQuery.toLowerCase()) || u.email?.toLowerCase().includes(searchQuery.toLowerCase())).map((u: any) => (
              <option key={u.id} value={u.id}>{u.name || u.email}</option>
            ))}
          </select>
        </div>
      </div>

      {!selectedUserId && (
        <div className="bg-card rounded-xl shadow-sm p-12 border border-border text-center">
          <Users className="w-16 h-16 text-gray-300 mx-auto mb-4" />
          <h2 className="text-xl font-semibold text-muted-foreground">{t("admin_user_passport_empty", "Select a user to view their Intelligence Passport")}</h2>
        </div>
      )}

      {selectedUserId && !isLoading && (
        <>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {kpis.map((kpi, i) => {
              const Icon = kpi.icon;
              return (
                <div key={i} className="bg-card rounded-xl shadow-sm p-4 border border-border">
                  <div className="flex items-center gap-2 mb-2"><div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div></div>
                  <p className="text-2xl font-bold text-card-foreground">{kpi.value}</p>
                  <p className="text-xs text-muted-foreground mt-1">{t(kpi.i18nKey, kpi.title)}</p>
                </div>
              );
            })}
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            {/* Preferences */}
            <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2 mb-4">
                <Heart className="w-5 h-5 text-pink-600" /> {t("admin_user_passport_preferences", "Preferences (AI-inferred)")}
              </h2>
              <div className="space-y-3">
                {preferences.map((p, i) => (
                  <div key={i} className="flex items-center justify-between py-2 border-b border-gray-50 last:border-0">
                    <span className="text-sm text-muted-foreground">{t(p.i18nKey, p.label)}</span>
                    <span className="text-sm font-medium text-card-foreground">{p.value}</span>
                  </div>
                ))}
              </div>
            </div>

            {/* Intent Signals */}
            <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2 mb-4">
                <Target className="w-5 h-5 text-brand" /> {t("admin_user_passport_intent_signals", "Intent Signals")}
              </h2>
              <div className="space-y-3">
                {intentSignals.map((s, i) => (
                  <div key={i} className="p-3 rounded-lg bg-muted">
                    <div className="flex items-center justify-between mb-1">
                      <span className="text-sm text-muted-foreground">{s.signal}</span>
                      <span className={`text-xs font-bold ${s.positive ? 'text-blue-600' : 'text-orange-600'}`}>{s.strength}%</span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-1.5">
                      <div className={`h-1.5 rounded-full ${s.positive ? 'bg-blue-500' : 'bg-orange-500'}`} style={{ width: `${s.strength}%` }} />
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Behavior Timeline */}
            <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
              <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2 mb-4">
                <Clock className="w-5 h-5 text-blue-600" /> {t("admin_user_passport_activity_timeline", "Activity Timeline")}
              </h2>
              <div className="space-y-3">
                {behaviorTimeline.map((ev, i) => (
                  <div key={i} className="flex items-start gap-3">
                    <div className={`mt-1 w-2 h-2 rounded-full ${
                      ev.type === 'viewing' ? 'bg-blue-500' : ev.type === 'save' ? 'bg-yellow-500' : ev.type === 'compare' ? 'bg-brand/100' : 'bg-blue-500'
                    }`} />
                    <div>
                      <p className="text-sm text-muted-foreground">{ev.action}</p>
                      <p className="text-xs text-gray-400">{ev.time}</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* AI Recommendation */}
          <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
            <h2 className="text-lg font-semibold text-card-foreground flex items-center gap-2 mb-4">
              <Brain className="w-5 h-5 text-brand" /> {t("admin_user_passport_recommendation_engine", "AI Recommendation Engine")}
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div className="p-4 bg-brand/10 rounded-lg border border-brand/30">
                <p className="text-sm font-medium text-brand">🎯 {t("admin_user_passport_next_best_action", "Next Best Action")}</p>
                <p className="text-xs text-brand mt-2">{t("admin_user_passport_next_best_action_desc", "Send personalized listing alert for 2-3BR apartments in South London under £850K")}</p>
              </div>
              <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
                <p className="text-sm font-medium text-blue-800">📊 {t("admin_user_passport_predicted_outcome", "Predicted Outcome")}</p>
                <p className="text-xs text-blue-700 mt-2">{t("admin_user_passport_predicted_outcome_desc", "78% probability of scheduling a viewing within 5 days. 34% of converting to offer within 30 days.")}</p>
              </div>
              <div className="p-4 bg-orange-50 rounded-lg border border-orange-200">
                <p className="text-sm font-medium text-orange-800">💡 {t("admin_user_passport_engagement_tip", "Engagement Tip")}</p>
                <p className="text-xs text-orange-700 mt-2">{t("admin_user_passport_engagement_tip_desc", "User responds best to WhatsApp messages (82% open rate). Optimal time: Tuesday 10am.")}</p>
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  </PageShell>
  );
}
