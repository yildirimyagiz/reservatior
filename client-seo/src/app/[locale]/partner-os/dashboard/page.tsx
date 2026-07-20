import type { Metadata } from "next";
import PartnerDashboard from "@/pages-spa/partner_os/Dashboard";

export const metadata: Metadata = {
  title: "Partner OS Dashboard | Reservatior",
  description: "Partner onboarding, API key management, and integration status.",
};

export default function PartnerDashboardPage() {
  return <PartnerDashboard />;
}
