import type { Metadata } from "next";
import AdminOrganizationsPage from "../organizations/AdminOrganizationsPage";

export const metadata: Metadata = {
  title: "Organization - Admin Panel | Reservatior",
  description: "Manage organizations from the admin panel.",
  keywords: ["organization","management","admin panel"],
  openGraph: {
    title: "Organization - Admin Panel | Reservatior",
    description: "Manage organizations from the admin panel.",
    type: "website",
  },
};

export default function AdminOrganizationPageWrapper() {
  return <AdminOrganizationsPage />;
}
