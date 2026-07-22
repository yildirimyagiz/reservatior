"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalPartners", label: "Total Partners", icon: "Users", color: "text-blue-600" },
  { key: "activePartners", label: "Active Partners", icon: "Activity", color: "text-green-600" },
  { key: "pendingPartners", label: "Pending", icon: "Clock", color: "text-yellow-600" },
  { key: "averagePartnerScore", label: "Avg Score", icon: "Star", color: "text-purple-600", format: "decimal" },
];

export default function PartnerOSDashboard() {
  return (
    <GenericOSDashboard
      title="Partner OS Dashboard"
      description="Monitor partner relationships"
      osName="partner-os"
      kpiConfig={kpis}
    />
  );
}
