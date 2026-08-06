"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalDecisions", label: "Total Decisions", icon: "Brain", color: "text-blue-600" },
  { key: "executedDecisions", label: "Executed", icon: "Play", color: "text-green-600" },
  { key: "avgConfidence", label: "Avg Confidence", icon: "Zap", color: "text-brand", format: "decimal" },
  { key: "autoActions", label: "Auto Actions", icon: "Bot", color: "text-purple-600" },
];

export default function DecisionIntelligenceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Decision Intelligence OS Dashboard"
      description="Monitor AI-powered decision making and automatic actions"
      osName="decision-intelligence-os"
      kpiConfig={kpis}
    />
  );
}
