import type { Metadata } from "next";
import AdminCompliancePage from "./AdminCompliancePage";

export const metadata: Metadata = {
  title: "Compliance Dashboard - Admin Panel | Reservatior",
  description: "Monitor compliance status, regulatory requirements, and audit readiness.",
  keywords: ["compliance","admin panel","regulatory","audit"],
  openGraph: {
    title: "Compliance Dashboard - Admin Panel | Reservatior",
    description: "Monitor compliance status, regulatory requirements, and audit readiness.",
    type: "website",
  },
};

export default function AdminCompliancePageWrapper() {
  return <AdminCompliancePage />;
}
