"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "activePlans", label: "Active Plans", icon: "ShieldCheck", color: "text-emerald-600", format: "number" },
  { key: "totalPlans", label: "Total Plans", icon: "FileText", color: "text-blue-600", format: "number" },
  { key: "escrowBalance", label: "Escrow Balance", icon: "Lock", color: "text-amber-600", format: "currency" },
  { key: "heldAmount", label: "Held Amount", icon: "Hourglass", color: "text-orange-600", format: "currency" },
  { key: "averageReliabilityScore", label: "Avg Reliability", icon: "Target", color: "text-purple-600", format: "number" },
  { key: "latePayments", label: "Late Payments", icon: "AlertTriangle", color: "text-red-600", format: "number" },
  { key: "landlords", label: "Landlords", icon: "Building2", color: "text-indigo-600", format: "number" },
];

export default function RentalFinanceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Rental Finance OS Dashboard"
      description="Service plans, escrow, tenant scoring and payment flow"
      osName="rental-finance-os"
      kpiConfig={kpis}
    />
  );
}
