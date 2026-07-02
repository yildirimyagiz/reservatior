import type { Metadata } from "next";
import AdminPropertiesPage from "./AdminPropertiesPage";

export const metadata: Metadata = {
  title: "Property Management - Admin Panel | Reservatior",
  description: "Manage all properties on the platform from the admin panel with comprehensive oversight.",
  keywords: ["property management","admin panel","real estate oversight"],
  openGraph: {
    title: "Property Management - Admin Panel | Reservatior",
    description: "Manage all properties on the platform from the admin panel with comprehensive oversight.",
    type: "website",
  },
};

export default function AdminPropertiesPageWrapper() {
  return <AdminPropertiesPage />;
}
