import type { Metadata } from "next";
import AdminPayoutsPage from "./AdminPayoutsPage";

export const metadata: Metadata = {
  title: "Payouts - Admin Panel | Reservatior",
  description: "Manage platform payouts, payment processing, and transaction settlements.",
  keywords: ["payouts","admin panel","payments","settlements"],
  openGraph: {
    title: "Payouts - Admin Panel | Reservatior",
    description: "Manage platform payouts, payment processing, and transaction settlements.",
    type: "website",
  },
};

export default function AdminPayoutsPageWrapper() {
  return <AdminPayoutsPage />;
}
