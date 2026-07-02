import type { Metadata } from "next";
import PropertyReservationsPage from "./PropertyReservationsPage";

export const metadata: Metadata = {
  title: "Reservations - Booking Management | Reservatior",
  description: "Manage property reservations, guest bookings, and occupancy schedules.",
  keywords: ["reservations","bookings","guest management","occupancy"],
  openGraph: {
    title: "Reservations - Booking Management | Reservatior",
    description: "Manage property reservations, guest bookings, and occupancy schedules.",
    type: "website",
  },
};

export default function PropertyReservationsPageWrapper() {
  return <PropertyReservationsPage />;
}
