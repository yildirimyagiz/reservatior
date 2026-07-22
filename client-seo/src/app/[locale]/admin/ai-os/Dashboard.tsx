"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";
import { PricingIntelligence } from "@/components/ai/PricingIntelligence";

const kpis: OSKpiConfig[] = [
  { key: "totalModels", label: "Total Models", icon: "Brain", color: "text-purple-600" },
  { key: "activeModels", label: "Active Models", icon: "Zap", color: "text-green-600" },
  { key: "predictionsMade", label: "Predictions", icon: "BarChart3", color: "text-blue-600", format: "number" },
  { key: "modelAccuracy", label: "Accuracy", icon: "Activity", color: "text-orange-600", format: "percent" },
];

export default function AIOSDashboard() {
  return (
    <GenericOSDashboard
      title="AI OS Dashboard"
      description="Monitor and manage AI models and predictions"
      osName="ai-os"
      kpiConfig={kpis}
    >
      <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Pricing Intelligence</h2>
        <PricingIntelligence listingId="demo-listing" currentPrice={28000} currency="USD" />
      </div>
    </GenericOSDashboard>
  );
}
