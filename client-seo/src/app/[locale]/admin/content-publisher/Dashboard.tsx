"use client";

import { useAuth } from "@/lib/auth";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { useState } from "react";
import {
  Globe, TrendingUp, Eye, CheckCircle2,
  Clock, Download, Target,
  FileText, Share2, Search, ExternalLink,
  Instagram, Youtube, Linkedin
} from "lucide-react";
import { apiClient } from "@/lib/api";

async function fetchPublishingData(orgId: string, timeRange: string) {
  try {
    const res: any = await apiClient.get(`/intelligence/content-publisher?orgId=${orgId}&range=${timeRange}`);
    return res.data;
  } catch { return null; }
}

export default function ContentPublisherDashboard() {
  const { user } = useAuth();
  useLocalization();
  const orgId = user?.orgId || "";
  const [timeRange, setTimeRange] = useState("30d");

  const { data, isLoading } = useQuery({
    queryKey: ["content-publisher", orgId, timeRange],
    queryFn: () => fetchPublishingData(orgId, timeRange),
    enabled: !!orgId,
  });

  const stats = data?.stats || {
    totalPublished: 342,
    pendingReview: 18,
    channelsActive: 7,
    avgSeoScore: 87,
    totalViews: 245000,
    conversionRate: 3.2,
  };

  const kpis = [
    { title: "Published", value: stats.totalPublished, icon: CheckCircle2, color: "text-green-600", bg: "bg-green-50" },
    { title: "Pending Review", value: stats.pendingReview, icon: Clock, color: "text-orange-600", bg: "bg-orange-50" },
    { title: "Active Channels", value: stats.channelsActive, icon: Share2, color: "text-blue-600", bg: "bg-blue-50" },
    { title: "Avg SEO Score", value: `${stats.avgSeoScore}/100`, icon: Target, color: "text-purple-600", bg: "bg-purple-50" },
    { title: "Total Views", value: `${(stats.totalViews / 1000).toFixed(0)}K`, icon: Eye, color: "text-indigo-600", bg: "bg-indigo-50" },
    { title: "Conversion", value: `${stats.conversionRate}%`, icon: TrendingUp, color: "text-emerald-600", bg: "bg-emerald-50" },
  ];

  const channels = [
    { name: "Website (SEO Pages)", published: 156, views: "120K", seoScore: 92, status: "active", icon: Globe },
    { name: "Google Business", published: 89, views: "45K", seoScore: 88, status: "active", icon: Search },
    { name: "Instagram", published: 67, views: "52K", seoScore: null, status: "active", icon: Instagram },
    { name: "LinkedIn", published: 34, views: "18K", seoScore: null, status: "active", icon: Linkedin },
    { name: "YouTube", published: 12, views: "8K", seoScore: null, status: "paused", icon: Youtube },
    { name: "Property Portals", published: 98, views: "89K", seoScore: 85, status: "active", icon: ExternalLink },
    { name: "Email Newsletter", published: 24, views: "12K", seoScore: null, status: "active", icon: FileText },
  ];

  const recentContent = [
    { title: "Kensington 3BR — Luxury Living Guide", type: "SEO Page", channels: 4, views: 2340, seoScore: 94, status: "published", publishedAt: "2h ago" },
    { title: "Chelsea Market Report Q3 2024", type: "Blog Post", channels: 3, views: 1890, seoScore: 91, status: "published", publishedAt: "5h ago" },
    { title: "Investment Guide: South London", type: "Landing Page", channels: 5, views: 4200, seoScore: 88, status: "published", publishedAt: "1d ago" },
    { title: "Agent Sarah's Listings Showcase", type: "Social Post", channels: 2, views: 890, seoScore: null, status: "published", publishedAt: "1d ago" },
    { title: "Manchester Waterfront Virtual Tour", type: "Video", channels: 3, views: 3100, seoScore: null, status: "pending", publishedAt: "—" },
    { title: "Dubai Investment Opportunities", type: "Newsletter", channels: 1, views: 0, seoScore: null, status: "draft", publishedAt: "—" },
  ];

  const statusColors: Record<string, string> = {
    published: "bg-green-100 text-green-700",
    pending: "bg-orange-100 text-orange-700",
    draft: "bg-gray-100 text-gray-700",
    paused: "bg-yellow-100 text-yellow-700",
    active: "bg-green-100 text-green-700",
  };

  if (isLoading) return <div className="flex items-center justify-center h-64"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div>;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Content Publisher</h1>
          <p className="text-gray-600 mt-1">Multi-channel AI content publishing & SEO performance</p>
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
              <div className="flex items-center gap-2 mb-2"><div className={`p-2 rounded-lg ${kpi.bg} ${kpi.color}`}><Icon className="w-4 h-4" /></div></div>
              <p className="text-2xl font-bold text-gray-900">{kpi.value}</p>
              <p className="text-xs text-gray-500 mt-1">{kpi.title}</p>
            </div>
          );
        })}
      </div>

      {/* Channel Performance */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="p-4 border-b border-gray-100">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <Share2 className="w-5 h-5 text-blue-600" /> Channel Performance
          </h2>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 text-left">
              <tr>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Channel</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Published</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Views</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">SEO Score</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Status</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {channels.map((ch, i) => {
                const Icon = ch.icon;
                return (
                  <tr key={i} className="hover:bg-gray-50 transition">
                    <td className="px-4 py-3 flex items-center gap-2">
                      <Icon className="w-4 h-4 text-gray-500" />
                      <span className="text-sm font-medium text-gray-900">{ch.name}</span>
                    </td>
                    <td className="px-4 py-3 text-sm text-gray-700">{ch.published}</td>
                    <td className="px-4 py-3 text-sm text-gray-700">{ch.views}</td>
                    <td className="px-4 py-3">
                      {ch.seoScore ? (
                        <span className={`text-sm font-bold ${ch.seoScore >= 85 ? 'text-green-600' : 'text-orange-600'}`}>{ch.seoScore}/100</span>
                      ) : <span className="text-xs text-gray-400">N/A</span>}
                    </td>
                    <td className="px-4 py-3">
                      <span className={`px-2 py-1 rounded-full text-xs font-medium ${statusColors[ch.status]}`}>{ch.status}</span>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>

      {/* Recent Content */}
      <div className="bg-white rounded-xl shadow-sm border border-gray-100 overflow-hidden">
        <div className="p-4 border-b border-gray-100">
          <h2 className="text-lg font-semibold text-gray-900 flex items-center gap-2">
            <FileText className="w-5 h-5 text-purple-600" /> Recent Content
          </h2>
        </div>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 text-left">
              <tr>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Title</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Type</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Channels</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Views</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">SEO</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">Status</th>
                <th className="px-4 py-3 text-xs font-medium text-gray-500 uppercase">When</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-100">
              {recentContent.map((c, i) => (
                <tr key={i} className="hover:bg-gray-50 transition cursor-pointer">
                  <td className="px-4 py-3 text-sm font-medium text-gray-900 max-w-[250px] truncate">{c.title}</td>
                  <td className="px-4 py-3 text-sm text-gray-600">{c.type}</td>
                  <td className="px-4 py-3 text-sm text-gray-600">{c.channels}</td>
                  <td className="px-4 py-3 text-sm text-gray-700">{c.views > 0 ? c.views.toLocaleString() : '—'}</td>
                  <td className="px-4 py-3">
                    {c.seoScore ? <span className={`text-sm font-bold ${c.seoScore >= 85 ? 'text-green-600' : 'text-orange-600'}`}>{c.seoScore}</span> : <span className="text-xs text-gray-400">—</span>}
                  </td>
                  <td className="px-4 py-3"><span className={`px-2 py-1 rounded-full text-xs font-medium ${statusColors[c.status]}`}>{c.status}</span></td>
                  <td className="px-4 py-3 text-sm text-gray-400">{c.publishedAt}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* AI Content Pipeline */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">AI Content Pipeline</h2>
        <div className="flex items-center justify-between">
          {["Brief Generated", "Content Created", "SEO Optimized", "Review & Approve", "Multi-Channel Publish", "Performance Track"].map((step, i) => (
            <div key={i} className="flex items-center">
              <div className="flex flex-col items-center">
                <div className={`w-10 h-10 rounded-full flex items-center justify-center text-sm font-bold ${
                  i <= 4 ? 'bg-green-600 text-white' : 'bg-gray-200 text-gray-500'
                }`}>{i + 1}</div>
                <span className="text-xs text-gray-600 mt-2 text-center max-w-[90px]">{step}</span>
              </div>
              {i < 5 && <div className={`w-8 h-0.5 mx-1 mt-[-16px] ${i < 4 ? 'bg-green-400' : 'bg-gray-300'}`} />}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
