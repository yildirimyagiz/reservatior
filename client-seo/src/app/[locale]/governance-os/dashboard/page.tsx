import type { Metadata } from "next";
import GovernanceDashboard from "@/pages-spa/governance_os/Dashboard";

export const metadata: Metadata = {
  title: "Governance OS Dashboard | Reservatior",
  description: "Rules engine, compliance management, and audit trail.",
};

export default function GovernanceDashboardPage() {
  return <GovernanceDashboard />;
}
