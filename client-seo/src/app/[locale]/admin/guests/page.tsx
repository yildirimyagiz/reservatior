import type { Metadata } from "next";
import AdminGuestsPage from "./AdminGuestsPage";

export const metadata: Metadata = {
  title: "Guest Database - Admin Panel | Reservatior",
  description: "Manage guest profiles and bookings from the admin panel.",
  keywords: ["guests","database","bookings","admin panel"],
  openGraph: {
    title: "Guest Database - Admin Panel | Reservatior",
    description: "Manage guest profiles and bookings from the admin panel.",
    type: "website",
  },
};

export default function AdminGuestsPageWrapper() {
  return <AdminGuestsPage />;
}
