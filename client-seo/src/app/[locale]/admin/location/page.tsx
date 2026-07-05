import type { Metadata } from "next";
import AdminLocationPage from "./AdminLocationPage";

export const metadata: Metadata = {
  title: "Location Services - Admin Panel | Reservatior",
  description: "Manage location-based services from the admin panel.",
  keywords: ["location","services","admin panel"],
  openGraph: {
    title: "Location Services - Admin Panel | Reservatior",
    description: "Manage location-based services from the admin panel.",
    type: "website",
  },
};

export default function AdminLocationPageWrapper() {
  return <AdminLocationPage />;
}
