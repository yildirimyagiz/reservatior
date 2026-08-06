"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalUsers", label: "Total Users", icon: "Users", color: "text-blue-600" },
  { key: "activeUsers", label: "Active Users", icon: "Activity", color: "text-blue-600" },
  { key: "suspendedUsers", label: "Suspended", icon: "AlertCircle", color: "text-red-600" },
  { key: "userGrowthRate", label: "Growth Rate", icon: "TrendingUp", color: "text-brand", format: "percent" },
];

export default function UserOSDashboard() {
  return (
    <GenericOSDashboard
      title="User OS Dashboard"
      description="Monitor user activity and growth"
      osName="user-os"
      kpiConfig={kpis}
    />
  );
}
