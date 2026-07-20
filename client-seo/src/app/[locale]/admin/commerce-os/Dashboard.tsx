"use client";
import { useAuth } from "@/contexts/AuthContext";
import { useLocalization } from "@/contexts/LocalizationContext";
import { useQuery } from "@tanstack/react-query";
import { Package, ShoppingCart, CheckCircle, DollarSign } from "lucide-react";

export default function CommerceOSDashboard() {
  const { user } = useAuth();
  const { language } = useLocalization();
  const orgId = user?.organizationId || "";
  const { data: stats } = useQuery({ queryKey: ["commerce-os-dashboard", orgId], queryFn: () => fetchCommerceDashboardStats(orgId), enabled: !!orgId });
  const formatNumber = (val: number) => new Intl.NumberFormat(language).format(val);
  const dashboardStats = stats || { totalProducts: 0, totalOrders: 0, fulfilledOrders: 0, averageOrderValue: 0 };
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div><h1 className="text-3xl font-bold text-gray-900">Commerce OS Dashboard</h1></div>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Products</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalProducts)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Total Orders</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.totalOrders)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Fulfilled</p><p className="text-2xl font-bold">{formatNumber(dashboardStats.fulfilledOrders)}</p></div>
        <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100"><p className="text-sm text-gray-600">Avg Order Value</p><p className="text-2xl font-bold">${formatNumber(dashboardStats.averageOrderValue)}</p></div>
      </div>
    </div>
  );
}

async function fetchCommerceDashboardStats(orgId: string) {
  return { totalProducts: 450, totalOrders: 1250, fulfilledOrders: 1100, averageOrderValue: 250 };
}
