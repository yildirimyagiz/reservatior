"use client";


import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { listingOSApi } from "@/lib/api/listing-os";
import { 
  Home, 
  Eye, 
  MessageSquare, 
  TrendingUp, 
  DollarSign, 
  Star,
  BarChart3,
  Calendar,
  CheckCircle,
  AlertCircle,
  ArrowUpRight,
  ArrowDownRight
} from "lucide-react";
import { useAuth } from "@/lib/auth";

export default function ListingOSDashboard() {
  const { user } = useAuth();
  const { currency, language } = useLocalization();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["listing-os-dashboard", orgId],
    queryFn: () => listingOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency, maximumFractionDigits: 0 }).format(val);

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
    totalViews: 0,
    totalInquiries: 0,
    averagePrice: 0,
    averageTimeToLease: 0,
    publishedListings: 0,
    pendingListings: 0,
  };

  const kpis = [
    {
      title: "Total Listings",
      value: formatNumber(stats.totalListings),
      icon: Home,
      color: "text-blue-600",
      trend: "+12.5% vs last month",
      trendUp: true,
    },
    {
      title: "Active Listings",
      value: formatNumber(stats.activeListings),
      icon: CheckCircle,
      color: "text-green-600",
      trend: "+8.3% vs last month",
      trendUp: true,
    },
    {
      title: "Total Views",
      value: formatNumber(stats.totalViews),
      icon: Eye,
      color: "text-purple-600",
      trend: "+22.1% vs last month",
      trendUp: true,
    },
    {
      title: "Total Inquiries",
      value: formatNumber(stats.totalInquiries),
      icon: MessageSquare,
      color: "text-orange-600",
      trend: "+15.7% vs last month",
      trendUp: true,
    },
    {
      title: "Average Price",
      value: formatCurrency(stats.averagePrice),
      icon: DollarSign,
      color: "text-emerald-600",
      trend: "+5.4% vs last month",
      trendUp: true,
    },
    {
      title: "Avg Time to Lease",
      value: `${stats.averageTimeToLease} days`,
      icon: Calendar,
      color: "text-indigo-600",
      trend: "-3.2% vs last month",
      trendUp: false,
    },
    {
      title: "Published Listings",
      value: formatNumber(stats.publishedListings),
      icon: Star,
      color: "text-yellow-600",
      trend: "+10.8% vs last month",
      trendUp: true,
    },
    {
      title: "Pending Listings",
      value: formatNumber(stats.pendingListings),
      icon: AlertCircle,
      color: "text-red-600",
      trend: "-7.5% vs last month",
      trendUp: false,
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Listing OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor and manage listing operations</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
            New Listing
          </button>
          <button className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition">
            Import from MLS
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
        {/* Listing Views Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Listing Views</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Listing views chart will be rendered here</p>
          </div>
        </div>

        {/* Inquiry Trends Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Inquiry Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Inquiry trends chart will be rendered here</p>
          </div>
        </div>
      </div>

      {/* Recent Listings */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Recent Listings</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Home className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-gray-900">Property #{1000 + item}</p>
                  <p className="text-sm text-gray-600">3BR • 2BA • 1,500 sqft</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-gray-900">{formatCurrency(2500000 + item * 100000)}</p>
                <p className="text-sm text-gray-600">{item} day(s) ago</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Listing Performance */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Listing Performance</h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="p-4 bg-green-50 border border-green-200 rounded-lg">
            <h3 className="font-semibold text-green-900">High Performance</h3>
            <p className="text-sm text-green-700 mt-1">Above average views and inquiries</p>
            <p className="text-2xl font-bold text-green-900 mt-2">35%</p>
            <p className="text-xs text-green-600">of listings</p>
          </div>
          <div className="p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <h3 className="font-semibold text-yellow-900">Average Performance</h3>
            <p className="text-sm text-yellow-700 mt-1">Meeting expected metrics</p>
            <p className="text-2xl font-bold text-yellow-900 mt-2">50%</p>
            <p className="text-xs text-yellow-600">of listings</p>
          </div>
          <div className="p-4 bg-red-50 border border-red-200 rounded-lg">
            <h3 className="font-semibold text-red-900">Low Performance</h3>
            <p className="text-sm text-red-700 mt-1">Below average views and inquiries</p>
            <p className="text-2xl font-bold text-red-900 mt-2">15%</p>
            <p className="text-xs text-red-600">of listings</p>
          </div>
        </div>
      </div>

      {/* Alerts Section */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-900">Alerts & Notifications</h2>
          <AlertCircle className="w-5 h-5 text-yellow-500" />
        </div>
        <div className="space-y-3">
          <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
            <AlertCircle className="w-5 h-5 text-yellow-600 mt-0.5" />
            <div>
              <p className="font-medium text-yellow-900">Low inquiry rate detected</p>
              <p className="text-sm text-yellow-700">Inquiry rate decreased by 8% this week</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-green-50 border border-green-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-green-600 mt-0.5" />
            <div>
              <p className="font-medium text-green-900">Views target achieved</p>
              <p className="text-sm text-green-700">Monthly views target exceeded by 22%</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
