"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { listingOSApi } from "@/lib/api/listing-os";
import { 
  Briefcase,
  CheckCircle,
  Clock,
  Activity,
  BarChart3,
  TrendingUp
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { BarChart } from "@/components/charts/BarChart";

export default function ListingOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["listing-os-dashboard", orgId],
    queryFn: () => listingOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: listingTrendsData } = useQuery({
    queryKey: ["listing-os-listing-trends", orgId],
    queryFn: () => listingOSApi.getListingTrends(orgId),
    enabled: !!orgId,
  });

  const { data: viewAnalyticsData } = useQuery({
    queryKey: ["listing-os-view-analytics", orgId],
    queryFn: () => listingOSApi.getViewAnalytics(orgId),
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
    totalListings: 0,
    activeListings: 0,
    pendingListings: 0,
    views: 0,
  };

  const kpis = [
    {
      title: "Total Listings",
      value: formatNumber(stats.totalListings),
      icon: Briefcase,
      color: "text-blue-600",
    },
    {
      title: "Active",
      value: formatNumber(stats.activeListings),
      icon: CheckCircle,
      color: "text-green-600",
    },
    {
      title: "Pending",
      value: formatNumber(stats.pendingListings),
      icon: Clock,
      color: "text-yellow-600",
    },
    {
      title: "Total Views",
      value: formatNumber(stats.views),
      icon: Activity,
      color: "text-purple-600",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Listing OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage property listings</p>
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
            <h2 className="text-lg font-semibold text-gray-900">Listing Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={listingTrendsData} 
            dataKey="listings" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">View Analytics</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <BarChart 
            data={viewAnalyticsData} 
            dataKey="views" 
            xAxisKey="month" 
            color="#f59e0b"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
