"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "activePolicies", label: "Active Policies", icon: "ShieldCheck", color: "text-emerald-600", format: "number" },
  { key: "premiumRevenue", label: "Premium Revenue", icon: "DollarSign", color: "text-amber-600", format: "currency" },
  { key: "activeClaims", label: "Active Claims", icon: "AlertTriangle", color: "text-orange-600", format: "number" },
  { key: "providers", label: "Providers", icon: "Building2", color: "text-purple-600", format: "number" },
];

export default function InsuranceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Insurance OS"
      description="Global 2% Rent Guarantee Underwriting Fund, Zero-Deposit Surety Bonds, AI Risk Scoring & Claims Distribution"
      osName="insurance-os"
      kpiConfig={kpis}
    />
  );
}
