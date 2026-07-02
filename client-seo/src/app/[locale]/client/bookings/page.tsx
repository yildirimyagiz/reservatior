import type { Metadata } from "next";
import BookingsPage from "./BookingsPage";

export const metadata: Metadata = {
  title: "Bookings - Reservation Management | Reservatior",
  description: "Manage your property bookings, reservations, and scheduling with smart calendar integration.",
  keywords: ["bookings","reservations","property booking","calendar"],
  openGraph: {
    title: "Bookings - Reservation Management | Reservatior",
    description: "Manage your property bookings, reservations, and scheduling with smart calendar integration.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function BookingsPageWrapper() {
  return <BookingsPage />;
}
