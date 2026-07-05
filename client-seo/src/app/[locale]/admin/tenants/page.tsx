import type { Metadata } from "next";
import AdminTenantsPage from "./AdminTenantsPage";

export const metadata: Metadata = {
  title: "Tenants - Admin Panel | Reservatior",
  description: "Manage tenant profiles, lease agreements, and rental histories.",
  keywords: ["tenants","admin panel","lease","rental"],
  openGraph: {
    title: "Tenants - Admin Panel | Reservatior",
    description: "Manage tenant profiles, lease agreements, and rental histories.",
    type: "website",
  },
};

export default function AdminTenantsPageWrapper() {
  return <AdminTenantsPage />;
}
