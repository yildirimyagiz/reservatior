"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalLeads", label: "Total Leads", icon: "Users", color: "text-blue-600" },
  { key: "qualifiedLeads", label: "Qualified", icon: "Target", color: "text-blue-600" },
  { key: "convertedLeads", label: "Converted", icon: "CheckCircle", color: "text-brand" },
  { key: "conversionRate", label: "Conversion Rate", icon: "TrendingUp", color: "text-orange-600", format: "percent" },
];

export default function CRMOSDashboard() {
  return (
    <GenericOSDashboard
      title="CRM OS Dashboard"
      description="Monitor leads and conversions"
      osName="crm-os"
      kpiConfig={kpis}
    />
  );
}
