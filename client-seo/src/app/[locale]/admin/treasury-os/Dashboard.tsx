"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalCash", label: "Total Cash", icon: "DollarSign", color: "text-blue-600", format: "currency" },
  { key: "escrowBalance", label: "Escrow Balance", icon: "Lock", color: "text-green-600", format: "currency" },
  { key: "reserveRatio", label: "Reserve Ratio", icon: "Shield", color: "text-brand", format: "percent" },
  { key: "liquidityRatio", label: "Liquidity Ratio", icon: "Droplet", color: "text-purple-600", format: "percent" },
];

export default function TreasuryOSDashboard() {
  return (
    <GenericOSDashboard
      title="Treasury OS Dashboard"
      description="Monitor cash flow, escrow, and treasury operations"
      osName="treasury-os"
      kpiConfig={kpis}
    />
  );
}
