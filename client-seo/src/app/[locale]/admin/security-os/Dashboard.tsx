"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalAlerts", label: "Total Alerts", icon: "AlertCircle", color: "text-red-600" },
  { key: "resolvedAlerts", label: "Resolved", icon: "CheckCircle", color: "text-blue-600" },
  { key: "activeIncidents", label: "Active Incidents", icon: "Shield", color: "text-orange-600" },
  { key: "totalSecurityScans", label: "Security Scans", icon: "Activity", color: "text-blue-600" },
];

export default function SecurityOSDashboard() {
  return (
    <GenericOSDashboard
      title="Security OS Dashboard"
      description="Monitor security alerts and incidents"
      osName="security-os"
      kpiConfig={kpis}
    />
  );
}
