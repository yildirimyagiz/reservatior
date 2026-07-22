"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalAPIKeys", label: "Total API Keys", icon: "Key", color: "text-blue-600" },
  { key: "activeAPIKeys", label: "Active Keys", icon: "Activity", color: "text-green-600" },
  { key: "revokedAPIKeys", label: "Revoked", icon: "AlertCircle", color: "text-red-600" },
  { key: "totalAPICalls", label: "Total Calls", icon: "BarChart3", color: "text-purple-600" },
];

export default function DevAPIOSSDashboard() {
  return (
    <GenericOSDashboard
      title="Developer API OS Dashboard"
      description="Monitor API keys and usage"
      osName="devapi-os"
      kpiConfig={kpis}
    />
  );
}
