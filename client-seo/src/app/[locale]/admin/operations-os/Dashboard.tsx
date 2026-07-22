"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalTasks", label: "Total Tasks", icon: "CheckSquare", color: "text-blue-600" },
  { key: "completedTasks", label: "Completed", icon: "CheckCircle", color: "text-green-600" },
  { key: "pendingTasks", label: "Pending", icon: "Clock", color: "text-yellow-600" },
  { key: "averageCompletionTime", label: "Avg Completion Time", icon: "Activity", color: "text-purple-600" },
];

export default function OperationsOSDashboard() {
  return (
    <GenericOSDashboard
      title="Operations OS Dashboard"
      description="Monitor operational tasks and efficiency"
      osName="operations-os"
      kpiConfig={kpis}
    />
  );
}
