"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";
import { PricingIntelligence } from "@/components/ai/PricingIntelligence";
import { useTranslation } from "react-i18next";

const kpis: OSKpiConfig[] = [
  { key: "totalModels", label: "Total Models", icon: "Brain", color: "text-brand" },
  { key: "activeModels", label: "Active Models", icon: "Zap", color: "text-blue-600" },
  { key: "predictionsMade", label: "Predictions", icon: "BarChart3", color: "text-blue-600", format: "number" },
  { key: "modelAccuracy", label: "Accuracy", icon: "Activity", color: "text-orange-600", format: "percent" },
];

export default function AIOSDashboard() {
  const { t } = useTranslation();
  return (
    <GenericOSDashboard
      title="AI OS Dashboard"
      description="Monitor and manage AI models and predictions"
      osName="ai-os"
      kpiConfig={kpis}
    >
      <div className="bg-card rounded-xl shadow-sm p-6 border border-border">
        <h2 className="text-lg font-semibold text-foreground mb-4">{t("admin_ai_os_pricing_intelligence", "Fiyatlandırma Zekası")}</h2>
        <PricingIntelligence listingId="demo-listing" currentPrice={28000} currency="USD" />
      </div>
    </GenericOSDashboard>
  );
}
