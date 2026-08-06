"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalPolicies", label: "Total Policies", icon: "FileText", color: "text-blue-600", format: "number" },
  { key: "activePolicies", label: "Active Policies", icon: "ShieldCheck", color: "text-emerald-600", format: "number" },
  { key: "premiumRevenue", label: "Premium Revenue", icon: "DollarSign", color: "text-amber-600", format: "currency" },
  { key: "activeClaims", label: "Active Claims", icon: "AlertTriangle", color: "text-orange-600", format: "number" },
  { key: "providers", label: "Insurance Providers", icon: "Building2", color: "text-purple-600", format: "number" },
  { key: "products", label: "Products", icon: "Package", color: "text-indigo-600", format: "number" },
];

export default function InsuranceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Insurance OS Dashboard"
      description="Risk-based premium pricing, policy lifecycle, claims and provider distribution"
      osName="insurance-os"
      kpiConfig={kpis}
    />
  );
}
