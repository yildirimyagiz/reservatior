"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalNodes", label: "Total Nodes", icon: "Users", color: "text-blue-600" },
  { key: "totalEdges", label: "Total Edges", icon: "Link", color: "text-green-600" },
  { key: "avgReputationScore", label: "Avg Reputation", icon: "Star", color: "text-brand", format: "decimal" },
  { key: "communitiesDetected", label: "Communities", icon: "Network", color: "text-purple-600" },
];

export default function ReputationGraphOSDashboard() {
  return (
    <GenericOSDashboard
      title="Reputation Graph OS Dashboard"
      description="Monitor reputation networks and relationship graphs"
      osName="reputation-graph-os"
      kpiConfig={kpis}
    />
  );
}
