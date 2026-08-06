"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalRules", label: "Total Rules", icon: "FileText", color: "text-blue-600" },
  { key: "activeRules", label: "Active Rules", icon: "CheckCircle", color: "text-green-600" },
  { key: "complianceChecks", label: "Compliance Checks", icon: "Shield", color: "text-brand" },
  { key: "complianceRate", label: "Compliance Rate", icon: "Percent", color: "text-purple-600", format: "percent" },
];

export default function ComplianceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Compliance OS Dashboard"
      description="Monitor compliance rules and regulatory requirements"
      osName="compliance-os"
      kpiConfig={kpis}
    />
  );
}
