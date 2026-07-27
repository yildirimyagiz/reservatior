"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { documentOSApi } from "@/lib/api/document-os";
import { 
  FileText,
  CheckCircle,
  Clock,
  Activity,
  BarChart3,
  PieChart
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { PieChart as RechartsPieChart } from "@/components/charts/PieChart";

export default function DocumentOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["document-os-dashboard", orgId],
    queryFn: () => documentOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: documentTrendsData } = useQuery({
    queryKey: ["document-os-document-trends", orgId],
    queryFn: () => documentOSApi.getDocumentTrends(orgId),
    enabled: !!orgId,
  });

  const { data: documentTypesData } = useQuery({
    queryKey: ["document-os-document-types", orgId],
    queryFn: () => documentOSApi.getDocumentTypes(orgId),
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
    processedDocuments: 0,
    pendingDocuments: 0,
    storageUsed: 0,
  };

  const kpis = [
    {
      title: "Total Documents",
      value: formatNumber(stats.totalDocuments),
      icon: FileText,
      color: "text-blue-600",
    },
    {
      title: "Processed",
      value: formatNumber(stats.processedDocuments),
      icon: CheckCircle,
      color: "text-green-600",
    },
    {
      title: "Pending",
      value: formatNumber(stats.pendingDocuments),
      icon: Clock,
      color: "text-yellow-600",
    },
    {
      title: "Storage Used",
      value: `${formatNumber(stats.storageUsed)} MB`,
      icon: Activity,
      color: "text-purple-600",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Document OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage documents and files</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-600">{kpi.title}</p>
                  <p className="text-2xl font-bold text-gray-900 mt-2">{kpi.value}</p>
                </div>
                <div className={`p-3 bg-gray-50 rounded-lg ${kpi.color}`}>
                  <Icon className="w-6 h-6" />
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Document Trends</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={documentTrendsData} 
            dataKey="documents" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Document Types</h2>
            <PieChart className="w-5 h-5 text-gray-500" />
          </div>
          <RechartsPieChart 
            data={documentTypesData} 
            dataKey="value" 
            nameKey="name"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
