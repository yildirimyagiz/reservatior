"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "activePlans", label: "Active Plans", icon: "ShieldCheck", color: "text-emerald-600", format: "number" },
  { key: "averageReliabilityScore", label: "Reliability Score", icon: "Target", color: "text-purple-600", format: "number" },
  { key: "escrowBalance", label: "Escrow Balance", icon: "Lock", color: "text-amber-600", format: "currency" },
  { key: "latePayments", label: "Late Payments", icon: "AlertTriangle", color: "text-red-600", format: "number" },
];

export default function RentalFinanceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Rental Finance OS"
      description="Service plans, escrow, reliability scoring and payment health"
      osName="rental-finance-os"
      kpiConfig={kpis}
    />
  );
}
