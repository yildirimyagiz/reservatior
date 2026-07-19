import type { Metadata } from "next";
import AgentMobilePage from "./AgentMobilePage";

export const metadata: Metadata = {
  title: "Agent Mobile Commerce - Admin Panel | Reservatior",
  description:
    "Mobile-optimized agent commerce: property scanning, offer generation, commission tracking",
  keywords: ["agent", "mobile", "commerce", "real estate", "offers"],
};

export default function AgentMobileWrapper() {
  return <AgentMobilePage />;
}
