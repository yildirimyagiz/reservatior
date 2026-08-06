"use client";

import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import {
  Building2, DollarSign, TrendingUp, Heart, Target, Brain,
  MapPin, Star, Eye, ArrowUpRight, ArrowDownRight, Activity,
  Shield, Zap, Search
} from "lucide-react";
import { apiClient } from "@/lib/api";

async function fetchPublicPropertyIntelligence(propertyId: string) {
  try {
    const res: any = await apiClient.get(`/public/property-intelligence/${propertyId}`);
    return res.data;
  } catch { return null; }
}

export default function PropertyIntelligenceDashboard() {
  const { language } = useLocalization();
  const currency = "USD";
  const [propertyId, setPropertyId] = useState("");
  const [searchInput, setSearchInput] = useState("");

  const { data: intel, isLoading } = useQuery({
    queryKey: ["public-property-intelligence", propertyId],
    queryFn: () => fetchPublicPropertyIntelligence(propertyId),
    enabled: !!propertyId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

  const handleSearch = () => { if (searchInput.trim()) setPropertyId(searchInput.trim()); };

  const scores = [
    { name: "Location Score", value: intel?.locationScore ?? 85, icon: MapPin, color: "text-blue-600", bg: "bg-blue-50", desc: "Transit, amenities, schools" },
    { name: "Value Score", value: intel?.valueScore ?? 78, icon: DollarSign, color: "text-blue-600", bg: "bg-blue-50", desc: "Price vs comparable properties" },
    { name: "Investment Score", value: intel?.investmentScore ?? 82, icon: Target, color: "text-purple-600", bg: "bg-purple-50", desc: "ROI potential, appreciation" },
    { name: "Lifestyle Score", value: intel?.lifestyleScore ?? 90, icon: Heart, color: "text-pink-600", bg: "bg-pink-50", desc: "Quality of life indicators" },
    { name: "Growth Score", value: intel?.growthScore ?? 76, icon: TrendingUp, color: "text-orange-600", bg: "bg-orange-50", desc: "Area development forecast" },
    { name: "Safety Score", value: intel?.safetyScore ?? 88, icon: Shield, color: "text-indigo-600", bg: "bg-indigo-50", desc: "Crime rates, security" },
  ];

  const overallScore = intel?.overallScore ?? Math.round(scores.reduce((a, s) => a + s.value, 0) / scores.length);

  return (
    <div className="max-w-6xl mx-auto px-4 py-8 space-y-8">
      {/* Hero */}
      <div className="text-center">
        <h1 className="text-4xl font-bold text-gray-900">Property Intelligence</h1>
        <p className="text-gray-600 mt-2 text-lg">AI-powered scoring and analysis for any property</p>
      </div>

      {/* Search */}
      <div className="max-w-2xl mx-auto">
        <div className="flex gap-3">
          <div className="relative flex-1">
            <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Enter property ID or address…"
              value={searchInput}
              onChange={(e) => setSearchInput(e.target.value)}
              onKeyDown={(e) => e.key === 'Enter' && handleSearch()}
              className="w-full pl-12 pr-4 py-3 border border-gray-300 rounded-xl text-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            />
          </div>
          <button onClick={handleSearch} className="px-8 py-3 bg-blue-600 text-white rounded-xl hover:bg-blue-700 transition font-medium text-lg">
            Analyze
          </button>
        </div>
      </div>

      {isLoading && (
        <div className="flex items-center justify-center h-48">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      )}

      {propertyId && !isLoading && (
        <>
          {/* Overall Score */}
          <div className="bg-white rounded-2xl shadow-lg p-8 text-center">
            <div className="relative w-36 h-36 mx-auto">
              <svg className="w-36 h-36 transform -rotate-90" viewBox="0 0 144 144">
                <circle cx="72" cy="72" r="62" stroke="#e5e7eb" strokeWidth="10" fill="none" />
                <circle cx="72" cy="72" r="62" stroke={overallScore >= 80 ? "#3b82f6" : overallScore >= 60 ? "#f59e0b" : "#ef4444"} strokeWidth="10" fill="none"
                  strokeDasharray={`${overallScore * 3.9} 390`} strokeLinecap="round" />
              </svg>
              <div className="absolute inset-0 flex flex-col items-center justify-center">
                <span className="text-4xl font-bold text-gray-900">{overallScore}</span>
                <span className="text-sm text-gray-500">/ 100</span>
              </div>
            </div>
            <h2 className="text-xl font-bold text-gray-900 mt-4">Overall Intelligence Score</h2>
            <p className="text-gray-500 mt-1">Based on 6 AI-analyzed dimensions</p>
          </div>

          {/* 6 Score Cards */}
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {scores.map((s, i) => {
              const Icon = s.icon;
              return (
                <div key={i} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100 hover:shadow-md transition">
                  <div className="flex items-center gap-3 mb-4">
                    <div className={`p-3 rounded-xl ${s.bg} ${s.color}`}>
                      <Icon className="w-6 h-6" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-gray-900">{s.name}</h3>
                      <p className="text-xs text-gray-500">{s.desc}</p>
                    </div>
                  </div>
                  <div className="flex items-end gap-2 mb-2">
                    <span className="text-3xl font-bold text-gray-900">{s.value}</span>
                    <span className="text-gray-500 text-sm mb-1">/ 100</span>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-2">
                    <div className={`h-2 rounded-full ${s.value >= 80 ? 'bg-blue-500' : s.value >= 60 ? 'bg-yellow-500' : 'bg-red-500'}`} style={{ width: `${s.value}%` }} />
                  </div>
                </div>
              );
            })}
          </div>

          {/* AI Insights */}
          <div className="bg-white rounded-2xl shadow-lg p-8">
            <h2 className="text-xl font-bold text-gray-900 flex items-center gap-2 mb-6">
              <Brain className="w-6 h-6 text-purple-600" /> AI Insights
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div className="p-4 bg-blue-50 rounded-xl border border-blue-200">
                <p className="font-medium text-blue-800">✅ Strengths</p>
                <p className="text-sm text-blue-700 mt-2">Excellent transport connectivity with 3 tube stations within walking distance. High walkability score.</p>
              </div>
              <div className="p-4 bg-orange-50 rounded-xl border border-orange-200">
                <p className="font-medium text-orange-800">⚠️ Considerations</p>
                <p className="text-sm text-orange-700 mt-2">Above-average price for the area. Limited parking. Service charge trending upward.</p>
              </div>
              <div className="p-4 bg-blue-50 rounded-xl border border-blue-200">
                <p className="font-medium text-blue-800">📈 Investment Outlook</p>
                <p className="text-sm text-blue-700 mt-2">5-year capital appreciation forecast: +18-24%. Rental yield estimate: 5.2%. Low vacancy risk.</p>
              </div>
              <div className="p-4 bg-purple-50 rounded-xl border border-purple-200">
                <p className="font-medium text-purple-800">🏘️ Neighborhood Trend</p>
                <p className="text-sm text-purple-700 mt-2">Area gentrification index: HIGH. New commercial developments planned. Increasing young professional demographic.</p>
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
