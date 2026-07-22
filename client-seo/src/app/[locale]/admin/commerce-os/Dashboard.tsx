"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalProducts", label: "Total Products", icon: "Package", color: "text-blue-600" },
  { key: "totalOrders", label: "Total Orders", icon: "ShoppingCart", color: "text-green-600" },
  { key: "fulfilledOrders", label: "Fulfilled", icon: "CheckCircle", color: "text-purple-600" },
  { key: "averageOrderValue", label: "Avg Order Value", icon: "DollarSign", color: "text-orange-600", format: "currency" },
];

export default function CommerceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Commerce OS Dashboard"
      description="Monitor products, orders, and revenue"
      osName="commerce-os"
      kpiConfig={kpis}
    />
  );
}
