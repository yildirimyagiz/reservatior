"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";
import { useTranslation } from "react-i18next";

export default function CommerceOSDashboard() {
  const { t } = useTranslation();
  const kpis: OSKpiConfig[] = [
    { key: "totalProducts", label: t("commerce_os.total_products", "Total Products"), icon: "Package", color: "text-blue-600" },
    { key: "totalOrders", label: t("commerce_os.total_orders", "Total Orders"), icon: "ShoppingCart", color: "text-green-600" },
    { key: "fulfilledOrders", label: t("commerce_os.fulfilled_orders", "Fulfilled"), icon: "CheckCircle", color: "text-purple-600" },
    { key: "averageOrderValue", label: t("commerce_os.avg_order_value", "Avg Order Value"), icon: "DollarSign", color: "text-orange-600", format: "currency" },
  ];

  return (
    <GenericOSDashboard
      title={t("commerce_os.title", "Commerce OS Dashboard")}
      description={t("commerce_os.description", "Monitor products, orders, and revenue")}
      osName="commerce-os"
      kpiConfig={kpis}
    />
  );
}
