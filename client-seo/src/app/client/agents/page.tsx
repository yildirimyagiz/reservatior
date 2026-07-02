import type { Metadata } from "next";
import AgentsPage from "@/app/[locale]/client/agents/AgentsPage";

export const metadata: Metadata = {
  title: "Agents - Real Estate Agent Network | Reservatior",
  description: "Manage your real estate agent network, team members, and agency profiles.",
  keywords: ["agents","real estate agents","agency network","team management"],
  openGraph: {
    title: "Agents - Real Estate Agent Network | Reservatior",
    description: "Manage your real estate agent network, team members, and agency profiles.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function AgentsPageWrapper() {
  return <AgentsPage />;
}
