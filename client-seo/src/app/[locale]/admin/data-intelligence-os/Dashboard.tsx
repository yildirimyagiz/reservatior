"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalPredictions", label: "Total Predictions", icon: "Brain", color: "text-blue-600" },
  { key: "accuracyRate", label: "Accuracy Rate", icon: "Target", color: "text-green-600", format: "percent" },
  { key: "avgConfidence", label: "Avg Confidence", icon: "Zap", color: "text-brand", format: "decimal" },
  { key: "activeModels", label: "Active Models", icon: "Cpu", color: "text-purple-600" },
];

export default function DataIntelligenceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Data Intelligence OS Dashboard"
      description="Monitor predictive analytics and AI models"
      osName="data-intelligence-os"
      kpiConfig={kpis}
    />
  );
}
