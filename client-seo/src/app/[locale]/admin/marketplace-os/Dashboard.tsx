"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalMatches", label: "Total Matches", icon: "Users", color: "text-blue-600" },
  { key: "avgMatchScore", label: "Avg Match Score", icon: "Star", color: "text-brand", format: "decimal" },
  { key: "supplyDemandRatio", label: "Supply/Demand", icon: "BarChart", color: "text-green-600", format: "decimal" },
  { key: "activeListings", label: "Active Listings", icon: "Home", color: "text-purple-600" },
];

export default function MarketplaceOSDashboard() {
  return (
    <GenericOSDashboard
      title="Marketplace OS Dashboard"
      description="Monitor supply-demand matching and marketplace dynamics"
      osName="marketplace-os"
      kpiConfig={kpis}
    />
  );
}
