import type { Metadata } from "next";
import AdminLeasesPage from "./AdminLeasesPage";

export const metadata: Metadata = {
  title: "Leases - Admin Panel | Reservatior",
  description: "Manage lease agreements, renewals, and terms from the admin panel.",
  keywords: ["leases","admin panel","lease agreements","renewals"],
  openGraph: {
    title: "Leases - Admin Panel | Reservatior",
    description: "Manage lease agreements, renewals, and terms from the admin panel.",
    type: "website",
  },
};

export default function AdminLeasesPageWrapper() {
  return <AdminLeasesPage />;
}
