"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalVerifications", label: "Total Verifications", icon: "Shield", color: "text-blue-600" },
  { key: "completedVerifications", label: "Completed", icon: "CheckCircle", color: "text-green-600" },
  { key: "pendingVerifications", label: "Pending", icon: "Clock", color: "text-yellow-600" },
  { key: "averageTrustScore", label: "Avg Trust Score", icon: "Star", color: "text-purple-600", format: "decimal" },
];

export default function TrustOSDashboard() {
  return (
    <GenericOSDashboard
      title="Trust OS Dashboard"
      description="Monitor verifications and trust scores"
      osName="trust-os"
      kpiConfig={kpis}
    />
  );
}
