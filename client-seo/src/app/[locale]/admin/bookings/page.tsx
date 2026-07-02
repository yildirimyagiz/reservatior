import type { Metadata } from "next";
import AdminBookingsPage from "./AdminBookingsPage";

export const metadata: Metadata = {
  title: "Booking Management - Admin Panel | Reservatior",
  description: "Manage and oversee all platform bookings, reservations, and transactions.",
  keywords: ["booking management","admin panel","reservations","transactions"],
  openGraph: {
    title: "Booking Management - Admin Panel | Reservatior",
    description: "Manage and oversee all platform bookings, reservations, and transactions.",
    type: "website",
  },
};

export default function AdminBookingsPageWrapper() {
  return <AdminBookingsPage />;
}
