import type { Metadata } from "next";
import { DashboardContent } from "./DashboardContent";

export const metadata: Metadata = {
  title: "Ambassador Dashboard | Reservatior",
  description: "Manage your referral campaigns, track affiliate links, and monitor your earnings.",
  robots: { index: false, follow: false },
};

export default function AmbassadorsPage() {
  return <DashboardContent />;
}
