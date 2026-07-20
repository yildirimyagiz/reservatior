"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
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
      title: "Total Documents",
      value: formatNumber(stats.totalDocuments),
      icon: FileText,
      color: "text-blue-600",
      trend: "+25.3% vs last month",
      trendUp: true,
    },
    {
      title: "Active Documents",
      value: formatNumber(stats.activeDocuments),
      icon: CheckCircle,
      color: "text-green-600",
      trend: "+18.7% vs last month",
      trendUp: true,
    },
    {
      title: "Pending Signatures",
      value: formatNumber(stats.pendingSignatures),
      icon: PenTool,
      color: "text-orange-600",
      trend: "-12.5% vs last month",
      trendUp: false,
    },
    {
      title: "Completed Signatures",
      value: formatNumber(stats.completedSignatures),
      icon: CheckCircle,
      color: "text-emerald-600",
      trend: "+22.1% vs last month",
      trendUp: true,
    },
    {
      title: "Templates",
      value: formatNumber(stats.totalTemplates),
      icon: Archive,
      color: "text-purple-600",
      trend: "+15.4% vs last month",
      trendUp: true,
    },
    {
      title: "Compliance Score",
      value: `${stats.complianceScore.toFixed(1)}/100`,
      icon: Shield,
      color: "text-indigo-600",
      trend: "+3.8% vs last month",
      trendUp: true,
    },
    {
      title: "Storage Used",
      value: `${(stats.storageUsed / 1024 / 1024).toFixed(1)} GB`,
      icon: BarChart3,
      color: "text-pink-600",
      trend: "+8.2% vs last month",
      trendUp: true,
    },
    {
      title: "Search Success",
      value: `${stats.searchSuccessRate.toFixed(1)}%`,
      icon: Search,
      color: "text-cyan-600",
      trend: "+5.6% vs last month",
      trendUp: true,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Document OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor and manage document operations</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
            Upload Document
          </button>
          <button className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition">
            Create Template
          </button>
        </div>
      </div>

      {/* KPI Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{kpi.title}</p>
                  <p className="text-2xl font-bold text-gray-900 mt-2">{kpi.value}</p>
                  <div className="flex items-center gap-1 mt-1">
                    {kpi.trendUp ? (
                      <ArrowUpRight className="w-4 h-4 text-green-600" />
                    ) : (
                      <ArrowDownRight className="w-4 h-4 text-red-600" />
                    )}
                    <p className={`text-sm ${kpi.trendUp ? 'text-green-600' : 'text-red-600'}`}>
                      {kpi.trend}
                    </p>
                  </div>
                </div>
                <div className={`p-3 bg-gray-50 rounded-lg ${kpi.color}`}>
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
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Document Trends</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Document trends chart will be rendered here</p>
          </div>
        </div>

        {/* Signature Status Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Signature Status</h2>
            <PenTool className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Signature status chart will be rendered here</p>
          </div>
        </div>
      </div>

      {/* Recent Documents */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Recent Documents</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <FileText className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-gray-900">Document #{1000 + item}</p>
                  <p className="text-sm text-gray-600">Lease Agreement • {item} signatures</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-gray-900">Pending</p>
                <p className="text-sm text-gray-600">{item} hour(s) ago</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Document Types */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Document Types</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <h3 className="font-semibold text-blue-900">Lease Agreements</h3>
            <p className="text-sm text-blue-700 mt-1">Rental contracts</p>
            <p className="text-2xl font-bold text-blue-900 mt-2">45%</p>
            <p className="text-xs text-blue-600">of documents</p>
          </div>
          <div className="p-4 bg-purple-50 border border-purple-200 rounded-lg">
            <h3 className="font-semibold text-purple-900">Purchase Agreements</h3>
            <p className="text-sm text-purple-700 mt-1">Sales contracts</p>
            <p className="text-2xl font-bold text-purple-900 mt-2">35%</p>
            <p className="text-xs text-purple-600">of documents</p>
          </div>
          <div className="p-4 bg-green-50 border border-green-200 rounded-lg">
            <h3 className="font-semibold text-green-900">Other Documents</h3>
            <p className="text-sm text-green-700 mt-1">Miscellaneous</p>
            <p className="text-2xl font-bold text-green-900 mt-2">20%</p>
            <p className="text-xs text-green-600">of documents</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900">Document Alerts</h2>
          <AlertTriangle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertTriangle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">Pending signatures expiring soon</p>
              <p className="text-sm text-yellow-700">5 documents have signatures expiring in 24 hours</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-green-50 border border-green-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-green-600 mt-0.5" />
            <div>
              <p className="font-medium text-green-900">Compliance score improved</p>
              <p className="text-sm text-green-700">Overall compliance score increased by 3.8%</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
