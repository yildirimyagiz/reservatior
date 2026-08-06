"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { bookingOSApi } from "@/lib/api/booking-os";
import { 
  Calendar,
  CheckCircle,
  Clock,
  DollarSign,
  BarChart3,
  TrendingUp
} from "lucide-react";
import { LineChart } from "@/components/charts/LineChart";
import { BarChart } from "@/components/charts/BarChart";

export default function BookingOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.orgId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["booking-os-dashboard", orgId],
    queryFn: () => bookingOSApi.getDashboardStats(orgId),
    enabled: !!orgId,
  });

  const { data: bookingTrendsData } = useQuery({
    queryKey: ["booking-os-booking-trends", orgId],
    queryFn: () => bookingOSApi.getBookingTrends(orgId),
    enabled: !!orgId,
  });

  const { data: revenueOverviewData } = useQuery({
    queryKey: ["booking-os-revenue-overview", orgId],
    queryFn: () => bookingOSApi.getRevenueOverview(orgId),
    enabled: !!orgId,
  });

  const formatCurrency = (val: number) =>
    new Intl.NumberFormat(language, { style: 'currency', currency: 'USD', maximumFractionDigits: 0 }).format(val);

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
    totalBookings: 0,
    confirmedBookings: 0,
    pendingBookings: 0,
    revenue: 0,
  };

  const kpis = [
    {
      title: "Total Bookings",
      value: formatNumber(stats.totalBookings),
      icon: Calendar,
      color: "text-brand",
    },
    {
      title: "Confirmed",
      value: formatNumber(stats.confirmedBookings),
      icon: CheckCircle,
      color: "text-blue-600",
    },
    {
      title: "Pending",
      value: formatNumber(stats.pendingBookings),
      icon: Clock,
      color: "text-yellow-600",
    },
    {
      title: "Revenue",
      value: formatCurrency(stats.revenue),
      icon: DollarSign,
      color: "text-brand",
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Booking OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Manage bookings and reservations</p>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, index) => {
          const Icon = kpi.icon;
          return (
            <div key={index} className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
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
        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Booking Trends</h2>
            <TrendingUp className="w-5 h-5 text-gray-500" />
          </div>
          <LineChart 
            data={bookingTrendsData} 
            dataKey="bookings" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>

        <div className="bg-card rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Revenue Overview</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <BarChart 
            data={revenueOverviewData} 
            dataKey="revenue" 
            xAxisKey="month" 
            color="#3b82f6"
            height={256}
          />
        </div>
      </div>
    </div>
  );
}
