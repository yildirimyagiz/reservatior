"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalIntegrations", label: "Total Integrations", icon: "Plugin", color: "text-blue-600" },
  { key: "totalDevelopers", label: "Total Developers", icon: "Users", color: "text-green-600" },
  { key: "totalAPIKeys", label: "API Keys", icon: "Key", color: "text-brand" },
  { key: "totalCalls", label: "Total Calls", icon: "Zap", color: "text-purple-600" },
];

export default function EcosystemOSDashboard() {
  return (
    <GenericOSDashboard
      title="Ecosystem OS Dashboard"
      description="Monitor developer integrations, API economy, and ecosystem health"
      osName="ecosystem-os"
      kpiConfig={kpis}
    />
  );
}
