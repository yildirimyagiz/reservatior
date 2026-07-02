import type { Metadata } from "next";
import AgentPerformancePage from "@/app/[locale]/client/agents/performance/AgentPerformancePage";

export const metadata: Metadata = {
  title: "Agent Performance - Analytics & Metrics | Reservatior",
  description: "Analyze real estate agent performance metrics, sales data, and productivity insights.",
  keywords: ["agent performance","analytics","metrics","sales data"],
  openGraph: {
    title: "Agent Performance - Analytics & Metrics | Reservatior",
    description: "Analyze real estate agent performance metrics, sales data, and productivity insights.",
    type: "website",
  },
};

export default function AgentPerformancePageWrapper() {
  return <AgentPerformancePage />;
}
