"use client";

import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { bookingOSApi } from "@/lib/api/booking-os";
import { 
  Calendar, 
  Users, 
  DollarSign, 
  TrendingUp, 
  Clock, 
  CheckCircle, 
  XCircle,
  AlertCircle,
  BarChart3,
  CreditCard
} from "lucide-react";

export default function BookingOSDashboard() {
  const { user } = useAuth();
  const { currency, language } = useLocalization();
  const orgId = user?.organizationId || "";

  const { data: dashboardStats, isLoading } = useQuery({
    queryKey: ["booking-os-dashboard", orgId],
    queryFn: () => bookingOSApi.getDashboardStats(orgId),
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
    totalBookings: 0,
    activeBookings: 0,
    pendingBookings: 0,
    completedBookings: 0,
    cancelledBookings: 0,
    totalRevenue: 0,
    averageBookingValue: 0,
    occupancyRate: 0,
    averageStayDuration: 0,
  };

  const kpis = [
    {
      title: "Total Bookings",
      value: formatNumber(stats.totalBookings),
      icon: Calendar,
      color: "text-blue-600",
      trend: "+12.5% vs last month",
    },
    {
      title: "Active Bookings",
      value: formatNumber(stats.activeBookings),
      icon: Users,
      color: "text-green-600",
      trend: "+8.3% vs last month",
    },
    {
      title: "Total Revenue",
      value: formatCurrency(stats.totalRevenue),
      icon: DollarSign,
      color: "text-purple-600",
      trend: "+15.2% vs last month",
    },
    {
      title: "Occupancy Rate",
      value: `${stats.occupancyRate.toFixed(1)}%`,
      icon: TrendingUp,
      color: "text-orange-600",
      trend: "+2.1% vs last month",
    },
    {
      title: "Pending Bookings",
      value: formatNumber(stats.pendingBookings),
      icon: Clock,
      color: "text-yellow-600",
      trend: "-3.2% vs last month",
    },
    {
      title: "Completed Bookings",
      value: formatNumber(stats.completedBookings),
      icon: CheckCircle,
      color: "text-emerald-600",
      trend: "+10.8% vs last month",
    },
    {
      title: "Cancelled Bookings",
      value: formatNumber(stats.cancelledBookings),
      icon: XCircle,
      color: "text-red-600",
      trend: "-5.4% vs last month",
    },
    {
      title: "Average Booking Value",
      value: formatCurrency(stats.averageBookingValue),
      icon: CreditCard,
      color: "text-indigo-600",
      trend: "+7.6% vs last month",
    },
  ];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-3xl font-bold text-gray-900">Booking OS Dashboard</h1>
          <p className="text-gray-600 mt-1">Monitor and manage booking operations</p>
        </div>
        <div className="flex gap-3">
          <button className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition">
            New Booking
          </button>
          <button className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition">
            Export Report
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
                  <p className="text-sm text-green-600 mt-1">{kpi.trend}</p>
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
        {/* Booking Trends Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Booking Trends</h2>
            <BarChart3 className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Booking trends chart will be rendered here</p>
          </div>
        </div>

        {/* Revenue Distribution Chart */}
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold text-gray-900">Revenue Distribution</h2>
            <DollarSign className="w-5 h-5 text-gray-500" />
          </div>
          <div className="h-64 flex items-center justify-center bg-gray-50 rounded-lg">
            <p className="text-gray-500">Revenue distribution chart will be rendered here</p>
          </div>
        </div>
      </div>

      {/* Recent Activity */}
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Recent Activity</h2>
        <div className="space-y-4">
          {[1, 2, 3, 4, 5].map((item) => (
            <div key={item} className="flex items-center justify-between p-4 bg-gray-50 rounded-lg">
              <div className="flex items-center gap-4">
                <div className="p-2 bg-blue-100 rounded-lg">
                  <Calendar className="w-5 h-5 text-blue-600" />
                </div>
                <div>
                  <p className="font-medium text-gray-900">New booking created</p>
                  <p className="text-sm text-gray-600">Booking #{1000 + item}</p>
                </div>
              </div>
              <div className="text-right">
                <p className="font-medium text-gray-900">{formatCurrency(500 + item * 100)}</p>
                <p className="text-sm text-gray-600">{item} hour(s) ago</p>
              </div>
            </div>
          ))}
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
              <p className="font-medium text-yellow-900">High cancellation rate detected</p>
              <p className="text-sm text-yellow-700">Cancellation rate increased by 5% this week</p>
            </div>
          </div>
          <div className="flex items-start gap-3 p-4 bg-blue-50 border border-blue-200 rounded-lg">
            <CheckCircle className="w-5 h-5 text-blue-600 mt-0.5" />
            <div>
              <p className="font-medium text-blue-900">Revenue target achieved</p>
              <p className="text-sm text-blue-700">Monthly revenue target exceeded by 12%</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
