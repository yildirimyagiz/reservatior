import type { Metadata } from "next";
import AdminFacilitiesPage from "./AdminFacilitiesPage";

export const metadata: Metadata = {
  title: "Facilities Management - Admin Panel | Reservatior",
  description: "Manage property facilities from the admin panel.",
  keywords: ["facilities","management","admin panel"],
  openGraph: {
    title: "Facilities Management - Admin Panel | Reservatior",
    description: "Manage property facilities from the admin panel.",
    type: "website",
  },
};

export default function AdminFacilitiesPageWrapper() {
  return <AdminFacilitiesPage />;
}
