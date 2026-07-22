"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalPolicies", label: "Total Policies", icon: "FileText", color: "text-blue-600" },
  { key: "activePolicies", label: "Active Policies", icon: "CheckCircle", color: "text-green-600" },
  { key: "totalAudits", label: "Total Audits", icon: "Shield", color: "text-purple-600" },
  { key: "averageComplianceScore", label: "Avg Compliance", icon: "Target", color: "text-orange-600", format: "percent" },
];

export default function GovernanceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Governance OS Dashboard"
      description="Monitor policies, audits, and compliance"
      osName="governance-os"
      kpiConfig={kpis}
    />
  );
}
