import type { Metadata } from "next";
import AgentCommissionsPage from "./AgentCommissionsPage";

export const metadata: Metadata = {
  title: "Agent Commissions - Commission Tracking | Reservatior",
  description: "Track and manage real estate agent commissions and earnings.",
  keywords: ["commissions","agent earnings","commission tracking"],
  openGraph: {
    title: "Agent Commissions - Commission Tracking | Reservatior",
    description: "Track and manage real estate agent commissions and earnings.",
    type: "website",
  },
};

export default function AgentCommissionsPageWrapper() {
  return <AgentCommissionsPage />;
}
