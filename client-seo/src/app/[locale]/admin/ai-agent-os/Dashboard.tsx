"use client";
import GenericOSDashboard from "@/components/GenericOSDashboard";
import { OSKpiConfig } from "@/lib/api/os-dashboard";

const kpis: OSKpiConfig[] = [
  { key: "totalAgents", label: "Total Agents", icon: "Bot", color: "text-blue-600" },
  { key: "activeAgents", label: "Active Agents", icon: "Zap", color: "text-green-600" },
  { key: "tasksCompleted", label: "Tasks Completed", icon: "CheckCircle", color: "text-brand" },
  { key: "avgSuccessRate", label: "Success Rate", icon: "Percent", color: "text-purple-600", format: "percent" },
];

export default function AIAgentOSDashboard() {
  return (
    <GenericOSDashboard
      title="AI Agent OS Dashboard"
      description="Monitor AI agents, tasks, and performance metrics"
      osName="ai-agent-os"
      kpiConfig={kpis}
    />
  );
}
