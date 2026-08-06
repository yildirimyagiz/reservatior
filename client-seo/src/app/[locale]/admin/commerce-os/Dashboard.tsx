"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";
import { useTranslation } from "react-i18next";

export default function CommerceOSDashboard() {
  const { t } = useTranslation();
  const kpis: OSKpiConfig[] = [
    { key: "totalProducts", label: t("commerce_os.total_products", "Toplam Ürünler"), icon: "Package", color: "text-blue-600" },
    { key: "totalOrders", label: t("commerce_os.total_orders", "Toplam Siparişler"), icon: "ShoppingCart", color: "text-blue-600" },
    { key: "fulfilledOrders", label: t("commerce_os.fulfilled_orders", "Teslim Edilen"), icon: "CheckCircle", color: "text-brand" },
    { key: "averageOrderValue", label: t("commerce_os.avg_order_value", "Ort. Sipariş Değeri"), icon: "DollarSign", color: "text-orange-600", format: "currency" },
  ];

  return (
    <GenericOSDashboard
      title={t("commerce_os.title", "Commerce OS Dashboard")}
      description={t("commerce_os.description", "Ürünleri, siparişleri ve geliri izleyin")}
      osName="commerce-os"
      kpiConfig={kpis}
    />
  );
}
