"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "avgQualityScore", label: "Avg Quality Score", icon: "Star", color: "text-blue-600", format: "decimal" },
  { key: "conversionRate", label: "Conversion Rate", icon: "Target", color: "text-green-600", format: "percent" },
  { key: "retentionRate", label: "Retention Rate", icon: "Heart", color: "text-brand", format: "percent" },
  { key: "totalOpportunities", label: "Opportunities", icon: "Lightbulb", color: "text-purple-600" },
];

export default function GrowthIntelligenceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Growth Intelligence OS Dashboard"
      description="Monitor growth metrics, channel performance, and opportunities"
      osName="growth-intelligence-os"
      kpiConfig={kpis}
    />
  );
}
