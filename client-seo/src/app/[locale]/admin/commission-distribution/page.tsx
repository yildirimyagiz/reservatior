import type { Metadata } from "next";
import AdminCommissionDistributionPage from "./AdminCommissionDistributionPage";

export const metadata: Metadata = {
  title: "Commission Distribution - Admin Panel | Reservatior",
  description: "Manage sales commissions and agent payouts from the admin panel.",
  keywords: ["commissions", "sales", "payouts", "admin panel"],
  openGraph: {
    title: "Commission Distribution - Admin Panel | Reservatior",
    description: "Manage sales commissions and agent payouts from the admin panel.",
    type: "website",
  },
};

export default function AdminCommissionDistributionPageWrapper() {
  return <AdminCommissionDistributionPage />;
}
