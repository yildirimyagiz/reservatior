import type { Metadata } from "next";
import AdminOrganizationsPage from "./AdminOrganizationsPage";

export const metadata: Metadata = {
  title: "Organizations - Admin Panel | Reservatior",
  description: "Manage organizations from the admin panel.",
  keywords: ["organizations","management","admin panel"],
  openGraph: {
    title: "Organizations - Admin Panel | Reservatior",
    description: "Manage organizations from the admin panel.",
    type: "website",
  },
};

export default function AdminOrganizationsPageWrapper() {
  return <AdminOrganizationsPage />;
}
