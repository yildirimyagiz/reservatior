"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalInvestments", label: "Total Investments", icon: "DollarSign", color: "text-blue-600" },
  { key: "fundedInvestments", label: "Funded", icon: "CheckCircle", color: "text-blue-600" },
  { key: "pendingInvestments", label: "Pending", icon: "Clock", color: "text-yellow-600" },
  { key: "averageROI", label: "Avg ROI", icon: "TrendingUp", color: "text-brand", format: "percent" },
];

export default function InvestmentOSDashboard() {
  return (
    <GenericOSDashboard
      title="Investment OS Dashboard"
      description="Monitor investment portfolios and ROI"
      osName="investment-os"
      kpiConfig={kpis}
    />
  );
}
