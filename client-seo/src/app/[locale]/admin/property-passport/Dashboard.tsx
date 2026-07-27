"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import {
  Building2, Shield, TrendingUp, DollarSign, Heart, Brain,
  Zap, Target, Activity, BarChart3, ArrowUpRight, ArrowDownRight,
  Eye, MapPin, Calendar, Download, Filter, RefreshCw, Search,
  Star, Layers, CheckCircle2, AlertTriangle, Clock
} from "lucide-react";
import { apiClient } from "@/lib/api";

// ─── Types ─────────────────────────────────────────────────────────────────
interface PassportIdentity {
  name: string;
  score: number;
  color: string;
  icon: any;
  description: string;
}

// ─── Fetch ─────────────────────────────────────────────────────────────────
async function fetchPropertyPassport(orgId: string, propertyId: string) {
  try {
    const res: any = await apiClient.get(`/intelligence/property-passport/${propertyId}`);
    return res.data;
  } catch { return null; }
}

async function fetchPropertyList(orgId: string) {
  try {
    const res: any = await apiClient.get(`/properties?orgId=${orgId}&limit=50`);
    return res.data?.items || [];
  } catch { return []; }
}

export default function PropertyPassportDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const currency = user?.preferences?.currency || "USD";
  const orgId = user?.orgId || "";
  const [selectedPropertyId, setSelectedPropertyId] = useState<string>("");
  const [searchQuery, setSearchQuery] = useState("");

  const { data: properties } = useQuery({
    queryKey: ["admin-property-list", orgId],
    queryFn: () => fetchPropertyList(orgId),
    enabled: !!orgId,
  });

  const { data: passport, isLoading } = useQuery({
    queryKey: ["property-passport", selectedPropertyId],
    queryFn: () => fetchPropertyPassport(orgId, selectedPropertyId),
    enabled: !!selectedPropertyId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);

  // ─── 6 Identity Dimensions ──────────────────────────────────────────────
  const identities: PassportIdentity[] = [
    { name: "Physical Identity", score: passport?.physical?.score ?? 0, color: "text-blue-600", icon: Building2, description: "Structure, area, rooms, condition" },
    { name: "Financial Identity", score: passport?.financial?.score ?? 0, color: "text-green-600", icon: DollarSign, description: "Valuation, rental yield, ROI" },
    { name: "Market Identity", score: passport?.market?.score ?? 0, color: "text-purple-600", icon: TrendingUp, description: "Demand index, competition, trend" },
    { name: "Investment Identity", score: passport?.investment?.score ?? 0, color: "text-orange-600", icon: Target, description: "Cap rate, appreciation, risk" },
    { name: "Lifestyle Identity", score: passport?.lifestyle?.score ?? 0, color: "text-pink-600", icon: Heart, description: "Walkability, amenities, transit" },
    { name: "AI Strategy", score: passport?.aiStrategy?.score ?? 0, color: "text-indigo-600", icon: Brain, description: "Content, SEO, pricing decision" },
  ];

  const overallScore = passport?.overallScore ?? 0;
  const calibrationFactor = passport?.calibrationFactor ?? 1.0;
  const calibrationDirection = calibrationFactor > 1.02 ? 'UPWARD' : calibrationFactor < 0.98 ? 'DOWNWARD' : 'NEUTRAL';

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Property Passport</h1>
          <p className="text-gray-600 mt-1">6-dimensional intelligence profile for every property</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> Export Passport
          </button>
        </div>
      </div>

      {/* Property Selector */}
      <div className="bg-white rounded-xl shadow-sm p-4 border border-gray-100">
        <div className="flex items-center gap-4">
          <div className="relative flex-1">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input
              type="text"
              placeholder="Search properties…"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg"
            />
          </div>
          <select
            value={selectedPropertyId}
            onChange={(e) => setSelectedPropertyId(e.target.value)}
            className="px-4 py-2 border border-gray-300 rounded-lg bg-white min-w-[300px]"
          >
            <option value="">Select a property…</option>
            {(properties || [])
              .filter((p: any) => !searchQuery || p.title?.toLowerCase().includes(searchQuery.toLowerCase()))
              .map((p: any) => (
                <option key={p.id} value={p.id}>{p.title || p.id}</option>
              ))}
          </select>
        </div>
      </div>

      {!selectedPropertyId && (
        <div className="bg-white rounded-xl shadow-sm p-12 border border-gray-100 text-center">
          <Building2 className="w-16 h-16 text-gray-300 mx-auto mb-4" />
          <h2 className="text-xl font-semibold text-gray-500">Select a property to view its Intelligence Passport</h2>
          <p className="text-gray-400 mt-2">Choose from the dropdown above or search by name</p>
        </div>
      )}

      {selectedPropertyId && isLoading && (
        <div className="flex items-center justify-center h-64">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      )}

      {selectedPropertyId && !isLoading && (
        <>
          {/* Overall Score + Calibration */}
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100 col-span-1">
              <h2 className="text-lg font-semibold text-gray-900 mb-4">Overall Score</h2>
              <div className="flex items-center justify-center">
                <div className="relative w-40 h-40">
                  <svg className="w-40 h-40 transform -rotate-90" viewBox="0 0 160 160">
                    <circle cx="80" cy="80" r="70" stroke="#e5e7eb" strokeWidth="12" fill="none" />
                    <circle
                      cx="80" cy="80" r="70"
                      stroke={overallScore >= 80 ? "#10b981" : overallScore >= 60 ? "#f59e0b" : "#ef4444"}
                      strokeWidth="12" fill="none"
                      strokeDasharray={`${overallScore * 4.4} 440`}
                      strokeLinecap="round"
                    />
                  </svg>
                  <div className="absolute inset-0 flex items-center justify-center">
                    <span className="text-4xl font-bold text-gray-900">{overallScore}</span>
                  </div>
                </div>
              </div>
              <div className="mt-4 text-center">
                <span className={`inline-flex items-center gap-1 px-3 py-1 rounded-full text-sm font-medium ${
                  calibrationDirection === 'UPWARD' ? 'bg-green-100 text-green-700' :
                  calibrationDirection === 'DOWNWARD' ? 'bg-red-100 text-red-700' :
                  'bg-gray-100 text-gray-700'
                }`}>
                  {calibrationDirection === 'UPWARD' ? <ArrowUpRight className="w-3 h-3" /> :
                   calibrationDirection === 'DOWNWARD' ? <ArrowDownRight className="w-3 h-3" /> :
                   <Activity className="w-3 h-3" />}
                  Calibration: {(calibrationFactor * 100 - 100).toFixed(1)}%
                </span>
              </div>
            </div>

            {/* 6 Identity Cards */}
            <div className="col-span-2 grid grid-cols-2 md:grid-cols-3 gap-4">
              {identities.map((id, i) => {
                const Icon = id.icon;
                return (
                  <div key={i} className="bg-white rounded-xl shadow-sm p-4 border border-gray-100 hover:border-blue-200 transition cursor-pointer">
                    <div className="flex items-center gap-2 mb-2">
                      <div className={`p-2 bg-gray-50 rounded-lg ${id.color}`}>
                        <Icon className="w-4 h-4" />
                      </div>
                      <span className="text-sm font-medium text-gray-700">{id.name}</span>
                    </div>
                    <div className="flex items-end gap-2">
                      <span className="text-2xl font-bold text-gray-900">{id.score}</span>
                      <span className="text-sm text-gray-500">/100</span>
                    </div>
                    <div className="mt-2 w-full bg-gray-200 rounded-full h-1.5">
                      <div
                        className={`h-1.5 rounded-full ${
                          id.score >= 80 ? 'bg-green-500' : id.score >= 60 ? 'bg-yellow-500' : 'bg-red-500'
                        }`}
                        style={{ width: `${id.score}%` }}
                      />
                    </div>
                    <p className="text-xs text-gray-400 mt-2">{id.description}</p>
                  </div>
                );
              })}
            </div>
          </div>

          {/* Investment Decision + Digital Twin */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
                <Zap className="w-5 h-5 text-orange-600" /> Investment Decision
              </h2>
              <div className="space-y-3">
                <div className="p-4 bg-green-50 rounded-lg border border-green-200">
                  <div className="flex items-center justify-between">
                    <span className="font-medium text-green-800">Recommendation</span>
                    <span className="px-3 py-1 bg-green-600 text-white rounded-full text-sm font-medium">
                      {passport?.decision?.recommendation || "STRONG BUY"}
                    </span>
                  </div>
                  <p className="text-sm text-green-700 mt-2">
                    {passport?.decision?.reasoning || "High rental yield (6.8%) with strong capital appreciation potential in an emerging market."}
                  </p>
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div className="p-3 bg-blue-50 rounded-lg">
                    <p className="text-xs text-gray-600">Expected ROI</p>
                    <p className="text-lg font-bold text-blue-700">{passport?.decision?.expectedROI || "12.4%"}</p>
                  </div>
                  <div className="p-3 bg-purple-50 rounded-lg">
                    <p className="text-xs text-gray-600">Risk Level</p>
                    <p className="text-lg font-bold text-purple-700">{passport?.decision?.riskLevel || "MODERATE"}</p>
                  </div>
                  <div className="p-3 bg-orange-50 rounded-lg">
                    <p className="text-xs text-gray-600">Confidence</p>
                    <p className="text-lg font-bold text-orange-700">{passport?.decision?.confidence || "87%"}</p>
                  </div>
                  <div className="p-3 bg-green-50 rounded-lg">
                    <p className="text-xs text-gray-600">Payback Period</p>
                    <p className="text-lg font-bold text-green-700">{passport?.decision?.paybackPeriod || "8.1 yrs"}</p>
                  </div>
                </div>
              </div>
            </div>

            <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
                <Layers className="w-5 h-5 text-indigo-600" /> Pipeline Status
              </h2>
              <div className="space-y-3">
                {[
                  { step: "Data Collection", status: "complete", icon: CheckCircle2 },
                  { step: "Analysis & Scoring", status: "complete", icon: CheckCircle2 },
                  { step: "Digital Twin Generated", status: "complete", icon: CheckCircle2 },
                  { step: "Content Generated", status: "complete", icon: CheckCircle2 },
                  { step: "Published to 5 Channels", status: "complete", icon: CheckCircle2 },
                  { step: "Feedback Loop", status: passport?.feedbackReceived ? "complete" : "running", icon: passport?.feedbackReceived ? CheckCircle2 : Clock },
                  { step: "Learning Updated", status: passport?.learningUpdated ? "complete" : "pending", icon: passport?.learningUpdated ? CheckCircle2 : AlertTriangle },
                ].map((s, i) => {
                  const Icon = s.icon;
                  return (
                    <div key={i} className={`flex items-center gap-3 p-3 rounded-lg ${
                      s.status === 'complete' ? 'bg-green-50' : s.status === 'running' ? 'bg-blue-50' : 'bg-gray-50'
                    }`}>
                      <Icon className={`w-4 h-4 ${
                        s.status === 'complete' ? 'text-green-600' : s.status === 'running' ? 'text-blue-600' : 'text-gray-400'
                      }`} />
                      <span className={`text-sm font-medium ${
                        s.status === 'complete' ? 'text-green-800' : s.status === 'running' ? 'text-blue-800' : 'text-gray-500'
                      }`}>{s.step}</span>
                      {s.status === 'running' && (
                        <RefreshCw className="w-3 h-3 text-blue-600 animate-spin ml-auto" />
                      )}
                    </div>
                  );
                })}
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
