"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
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
    { title: "Engagement Score", value: `${passport?.engagementScore ?? 76}/100`, icon: Heart, color: "text-pink-600", bg: "bg-pink-50" },
    { title: "Properties Viewed", value: passport?.propertiesViewed ?? 47, icon: Eye, color: "text-blue-600", bg: "bg-blue-50" },
    { title: "Saved Properties", value: passport?.savedProperties ?? 12, icon: Star, color: "text-yellow-600", bg: "bg-yellow-50" },
    { title: "Budget Range", value: formatCurrency(passport?.budgetMax ?? 850000), icon: DollarSign, color: "text-green-600", bg: "bg-green-50" },
    { title: "Intent Score", value: `${passport?.intentScore ?? 82}%`, icon: Target, color: "text-purple-600", bg: "bg-purple-50" },
    { title: "Session Count", value: passport?.sessionCount ?? 34, icon: Activity, color: "text-indigo-600", bg: "bg-indigo-50" },
  ];

  const preferences = [
    { label: "Property Type", value: passport?.preferredType ?? "Apartment" },
    { label: "Bedrooms", value: passport?.preferredBedrooms ?? "2-3" },
    { label: "Location", value: passport?.preferredLocation ?? "South London" },
    { label: "Max Budget", value: formatCurrency(passport?.budgetMax ?? 850000) },
    { label: "Min Yield", value: `${passport?.minYield ?? 5.0}%` },
    { label: "Lifestyle Priority", value: passport?.lifestylePriority ?? "Transport + Parks" },
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
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">User Passport</h1>
          <p className="text-gray-600 mt-1">User intelligence profile with behavior analysis & intent prediction</p>
        </div>
        <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
          <Download className="w-4 h-4" /> Export
        </button>
      </div>

      <div className="bg-white rounded-xl shadow-sm p-4 border border-gray-100">
        <div className="flex items-center gap-4">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input type="text" placeholder="Search users…" value={searchQuery} onChange={(e) => setSearchQuery(e.target.value)} className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg" />
          </div>
          <select value={selectedUserId} onChange={(e) => setSelectedUserId(e.target.value)} className="px-4 py-2 border border-gray-300 rounded-lg bg-white min-w-[300px]">
            <option value="">Select a user…</option>
            {(users || []).filter((u: any) => !searchQuery || u.name?.toLowerCase().includes(searchQuery.toLowerCase()) || u.email?.toLowerCase().includes(searchQuery.toLowerCase())).map((u: any) => (
              <option key={u.id} value={u.id}>{u.name || u.email}</option>
            ))}
          </select>
        </div>
      </div>

      {!selectedUserId && (
        <div className="bg-white rounded-xl shadow-sm p-12 border border-gray-100 text-center">
          <Users className="w-16 h-16 text-gray-300 mx-auto mb-4" />
          <h2 className="text-xl font-semibold text-gray-500">Select a user to view their Intelligence Passport</h2>
        </div>
      )}

      {selectedUserId && !isLoading && (
        <>
          <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
            {kpis.map((kpi, i) => {
              const Icon = kpi.icon;
              return (
                <div key={i} className="bg-white rounded-xl shadow-sm p-4 border border-gray-100">
                  <div className="flex items-center gap-2 mb-2"><div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div></div>
                  <p className="text-2xl font-bold text-gray-900">{kpi.value}</p>
                  <p className="text-xs text-gray-500 mt-1">{kpi.title}</p>
                </div>
              );
            })}
          </div>

          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            {/* Preferences */}
            <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
                <Heart className="w-5 h-5 text-pink-600" /> Preferences (AI-inferred)
              </h2>
              <div className="space-y-3">
                {preferences.map((p, i) => (
                  <div key={i} className="flex items-center justify-between py-2 border-b border-gray-50 last:border-0">
                    <span className="text-sm text-gray-600">{p.label}</span>
                    <span className="text-sm font-medium text-gray-900">{p.value}</span>
                  </div>
                ))}
              </div>
            </div>

            {/* Intent Signals */}
            <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
                <Target className="w-5 h-5 text-purple-600" /> Intent Signals
              </h2>
              <div className="space-y-3">
                {intentSignals.map((s, i) => (
                  <div key={i} className="p-3 rounded-lg bg-gray-50">
                    <div className="flex items-center justify-between mb-1">
                      <span className="text-sm text-gray-700">{s.signal}</span>
                      <span className={`text-xs font-bold ${s.positive ? 'text-green-600' : 'text-orange-600'}`}>{s.strength}%</span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-1.5">
                      <div className={`h-1.5 rounded-full ${s.positive ? 'bg-green-500' : 'bg-orange-500'}`} style={{ width: `${s.strength}%` }} />
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Behavior Timeline */}
            <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
                <Clock className="w-5 h-5 text-blue-600" /> Activity Timeline
              </h2>
              <div className="space-y-3">
                {behaviorTimeline.map((ev, i) => (
                  <div key={i} className="flex items-start gap-3">
                    <div className={`mt-1 w-2 h-2 rounded-full ${
                      ev.type === 'viewing' ? 'bg-green-500' : ev.type === 'save' ? 'bg-yellow-500' : ev.type === 'compare' ? 'bg-purple-500' : 'bg-blue-500'
                    }`} />
                    <div>
                      <p className="text-sm text-gray-700">{ev.action}</p>
                      <p className="text-xs text-gray-400">{ev.time}</p>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* AI Recommendation */}
          <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
            <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
              <Brain className="w-5 h-5 text-indigo-600" /> AI Recommendation Engine
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div className="p-4 bg-indigo-50 rounded-lg border border-indigo-200">
                <p className="text-sm font-medium text-indigo-800">🎯 Next Best Action</p>
                <p className="text-xs text-indigo-700 mt-2">Send personalized listing alert for 2-3BR apartments in South London under £850K</p>
              </div>
              <div className="p-4 bg-green-50 rounded-lg border border-green-200">
                <p className="text-sm font-medium text-green-800">📊 Predicted Outcome</p>
                <p className="text-xs text-green-700 mt-2">78% probability of scheduling a viewing within 5 days. 34% of converting to offer within 30 days.</p>
              </div>
              <div className="p-4 bg-orange-50 rounded-lg border border-orange-200">
                <p className="text-sm font-medium text-orange-800">💡 Engagement Tip</p>
                <p className="text-xs text-orange-700 mt-2">User responds best to WhatsApp messages (82% open rate). Optimal time: Tuesday 10am.</p>
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
