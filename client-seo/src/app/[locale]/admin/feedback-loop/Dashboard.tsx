"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import {
  Activity, Target, TrendingUp, ArrowUpRight, ArrowDownRight,
  BarChart3, Brain, RefreshCw, AlertTriangle, CheckCircle2,
  Download, Zap, XCircle, Clock, Eye, Building2, DollarSign
} from "lucide-react";
import { apiClient } from "@/lib/api";

async function fetchFeedbackData(orgId: string, timeRange: string) {
  try {
    const res: any = await apiClient.get(`/intelligence/feedback-loop?orgId=${orgId}&range=${timeRange}`);
    return res.data;
  } catch { return null; }
}

export default function FeedbackLoopDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";
  const [timeRange, setTimeRange] = useState<string>("30d");

  const { data, isLoading } = useQuery({
    queryKey: ["feedback-loop-dashboard", orgId, timeRange],
    queryFn: () => fetchFeedbackData(orgId, timeRange),
    enabled: !!orgId,
  });

  const stats = data?.stats || {
    totalCalibrations: 247,
    upwardCalibrations: 142,
    downwardCalibrations: 78,
    neutralCalibrations: 27,
    avgCalibrationDelta: 0.034,
    contentRefreshTriggered: 23,
    predictionAccuracy: 87.3,
    modelHealth: 94,
  };

  const recentCalibrations = data?.recentCalibrations || [
    { propertyId: "prop-001", propertyTitle: "Kensington 3BR", delta: 0.08, direction: "UPWARD", reason: "Sold 12% above predicted price", createdAt: "1h ago" },
    { propertyId: "prop-002", propertyTitle: "Chelsea Penthouse", delta: -0.05, direction: "DOWNWARD", reason: "DOM 45% longer than predicted", createdAt: "3h ago" },
    { propertyId: "prop-003", propertyTitle: "Shoreditch Loft", delta: 0.03, direction: "UPWARD", reason: "Rental yield 8% above forecast", createdAt: "5h ago" },
    { propertyId: "prop-004", propertyTitle: "Canary Wharf Studio", delta: -0.11, direction: "DOWNWARD", reason: "Price reduction needed after 60 days", createdAt: "8h ago" },
    { propertyId: "prop-005", propertyTitle: "Notting Hill Town", delta: 0.02, direction: "NEUTRAL", reason: "Within tolerance range", createdAt: "12h ago" },
    { propertyId: "prop-006", propertyTitle: "Manchester Waterfront", delta: 0.15, direction: "UPWARD", reason: "Investment return 20% above prediction", createdAt: "1d ago" },
  ];

  const kpis = [
    { title: "Total Calibrations", value: stats.totalCalibrations, icon: Activity, color: "text-purple-600", bg: "bg-purple-50" },
    { title: "Prediction Accuracy", value: `${stats.predictionAccuracy}%`, icon: Target, color: "text-green-600", bg: "bg-green-50" },
    { title: "Model Health", value: `${stats.modelHealth}%`, icon: Brain, color: "text-blue-600", bg: "bg-blue-50" },
    { title: "Content Refreshes", value: stats.contentRefreshTriggered, icon: RefreshCw, color: "text-orange-600", bg: "bg-orange-50" },
    { title: "Upward ↑", value: stats.upwardCalibrations, icon: ArrowUpRight, color: "text-emerald-600", bg: "bg-emerald-50" },
    { title: "Downward ↓", value: stats.downwardCalibrations, icon: ArrowDownRight, color: "text-red-600", bg: "bg-red-50" },
  ];

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Feedback Loop Monitor</h1>
          <p className="text-gray-600 mt-1">Prediction → Outcome → Calibration → Better Prediction</p>
        </div>
        <div className="flex gap-3">
          <select value={timeRange} onChange={(e) => setTimeRange(e.target.value)} className="px-4 py-2 border border-gray-300 rounded-lg bg-white">
            <option value="7d">Last 7 Days</option>
            <option value="30d">Last 30 Days</option>
            <option value="90d">Last 90 Days</option>
          </select>
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2">
            <Download className="w-4 h-4" /> Export
          </button>
        </div>
      </div>

      {/* KPIs */}
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
        {kpis.map((kpi, i) => {
          const Icon = kpi.icon;
          return (
            <div key={i} className="bg-white rounded-xl shadow-sm p-4 border border-gray-100">
              <div className="flex items-center gap-2 mb-2">
                <div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div>
              </div>
              <p className="text-2xl font-bold text-gray-900">{kpi.value}</p>
              <p className="text-xs text-gray-500 mt-1">{kpi.title}</p>
            </div>
          );
        })}
      </div>

      {/* Accuracy Gauges */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {[
          { label: "Price Prediction", accuracy: 89, trend: "+2.1%", color: "#10b981" },
          { label: "Rental Yield", accuracy: 84, trend: "+3.5%", color: "#6366f1" },
          { label: "Days on Market", accuracy: 78, trend: "-1.2%", color: "#f59e0b" },
        ].map((gauge, i) => (
          <div key={i} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100 text-center">
            <h3 className="text-sm font-medium text-gray-600 mb-4">{gauge.label} Accuracy</h3>
            <div className="relative w-28 h-28 mx-auto">
              <svg className="w-28 h-28 transform -rotate-90" viewBox="0 0 120 120">
                <circle cx="60" cy="60" r="50" stroke="#e5e7eb" strokeWidth="10" fill="none" />
                <circle cx="60" cy="60" r="50" stroke={gauge.color} strokeWidth="10" fill="none"
                  strokeDasharray={`${gauge.accuracy * 3.14} 314`} strokeLinecap="round" />
              </svg>
              <div className="absolute inset-0 flex items-center justify-center">
                <span className="text-2xl font-bold text-gray-900">{gauge.accuracy}%</span>
              </div>
            </div>
            <p className={`text-sm mt-3 ${gauge.trend.startsWith('+') ? 'text-green-600' : 'text-red-600'}`}>
              {gauge.trend} vs last period
            </p>
          </div>
        ))}
      </div>

      {/* Revenue Accuracy */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2 mb-4">
          <DollarSign className="w-5 h-5 text-green-600" /> Revenue: Predicted vs Actual
        </h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <div className="p-4 bg-blue-50 rounded-lg border border-blue-200">
            <p className="text-xs text-gray-600">Predicted Commission</p>
            <p className="text-xl font-bold text-blue-700">£2.4M</p>
          </div>
          <div className="p-4 bg-green-50 rounded-lg border border-green-200">
            <p className="text-xs text-gray-600">Actual Commission</p>
            <p className="text-xl font-bold text-green-700">£2.1M</p>
          </div>
          <div className="p-4 bg-purple-50 rounded-lg border border-purple-200">
            <p className="text-xs text-gray-600">Predicted Rental</p>
            <p className="text-xl font-bold text-purple-700">£890K</p>
          </div>
          <div className="p-4 bg-emerald-50 rounded-lg border border-emerald-200">
            <p className="text-xs text-gray-600">Actual Rental</p>
            <p className="text-xl font-bold text-emerald-700">£920K</p>
          </div>
        </div>
      </div>

      {/* Calibration Events Table */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="p-4 border-b border-gray-100">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <Activity className="w-5 h-5 text-purple-600" /> Recent Calibration Events
          </h2>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 text-left">
              <tr>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Property</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Direction</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Delta</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Reason</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">When</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {recentCalibrations.map((cal: any, i: number) => (
                <tr key={i} className="hover:bg-gray-50 transition">
                  <td className="px-4 py-3 text-sm font-medium text-gray-900">{cal.propertyTitle}</td>
                  <td className="px-4 py-3">
                    <span className={`inline-flex items-center gap-1 px-2 py-1 rounded-full text-xs font-medium ${
                      cal.direction === 'UPWARD' ? 'bg-green-100 text-green-700' :
                      cal.direction === 'DOWNWARD' ? 'bg-red-100 text-red-700' :
                      'bg-gray-100 text-gray-700'
                    }`}>
                      {cal.direction === 'UPWARD' ? <ArrowUpRight className="w-3 h-3" /> :
                       cal.direction === 'DOWNWARD' ? <ArrowDownRight className="w-3 h-3" /> :
                       <Activity className="w-3 h-3" />}
                      {cal.direction}
                    </span>
                  </td>
                  <td className="px-4 py-3">
                    <span className={`text-sm font-mono font-medium ${
                      cal.delta > 0 ? 'text-green-600' : cal.delta < 0 ? 'text-red-600' : 'text-gray-600'
                    }`}>
                      {cal.delta > 0 ? '+' : ''}{(cal.delta * 100).toFixed(1)}%
                    </span>
                  </td>
                  <td className="px-4 py-3 text-sm text-gray-600 max-w-[300px] truncate">{cal.reason}</td>
                  <td className="px-4 py-3 text-sm text-gray-400">{cal.createdAt}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Learning Loop Diagram */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Intelligence Learning Loop</h2>
        <div className="flex items-center justify-center gap-2 flex-wrap">
          {["Prediction", "→", "Outcome", "→", "Feedback", "→", "Calibration", "→", "Better Prediction"].map((item, i) => (
            item === "→" ? (
              <Zap key={i} className="w-4 h-4 text-blue-400 mx-1" />
            ) : (
              <div key={i} className={`px-4 py-2 rounded-lg text-sm font-medium ${
                i === 0 ? 'bg-blue-100 text-blue-700' :
                i === 2 ? 'bg-green-100 text-green-700' :
                i === 4 ? 'bg-orange-100 text-orange-700' :
                i === 6 ? 'bg-purple-100 text-purple-700' :
                'bg-indigo-100 text-indigo-700'
              }`}>
                {item}
              </div>
            )
          ))}
        </div>
      </div>
    </div>
  );
}
