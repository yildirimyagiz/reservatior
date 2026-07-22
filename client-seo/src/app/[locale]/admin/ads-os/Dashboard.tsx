"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalCampaigns", label: "Total Campaigns", icon: "Megaphone", color: "text-blue-600" },
  { key: "activeCampaigns", label: "Active", icon: "Play", color: "text-green-600" },
  { key: "pausedCampaigns", label: "Paused", icon: "Pause", color: "text-yellow-600" },
  { key: "averageCTR", label: "Avg CTR", icon: "TrendingUp", color: "text-purple-600", format: "percent" },
];

export default function AdsOSDashboard() {
  return (
    <GenericOSDashboard
      title="Ads OS Dashboard"
      description="Monitor advertising campaigns and performance"
      osName="ads-os"
      kpiConfig={kpis}
    />
  );
}
