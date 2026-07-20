import type { Metadata } from "next";
import IdentityDashboard from "@/pages-spa/identity_os/Dashboard";

export const metadata: Metadata = {
  title: "Identity OS Dashboard | Reservatior",
  description: "IAM, SSO, and access management across all markets.",
};

export default function IdentityDashboardPage() {
  return <IdentityDashboard />;
}
