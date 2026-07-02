import type { Metadata } from "next";
import AgentProfilePage from "@/app/[locale]/client/agents/profile/AgentProfilePage";

export const metadata: Metadata = {
  title: "Agent Profile - Real Estate Agent Details | Reservatior",
  description: "View and manage real estate agent profiles, credentials, and listings.",
  keywords: ["agent profile","real estate agent","credentials","listings"],
  openGraph: {
    title: "Agent Profile - Real Estate Agent Details | Reservatior",
    description: "View and manage real estate agent profiles, credentials, and listings.",
    type: "website",
  },
};

export default function AgentProfilePageWrapper() {
  return <AgentProfilePage />;
}
