import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Agent Passport - Intelligence & AI | Reservatior",
  description: "Agent performance intelligence with scoring, specialization radar, territory coverage, and AI coaching.",
};

export default function AgentPassportPage() {
  return <Dashboard />;
}
