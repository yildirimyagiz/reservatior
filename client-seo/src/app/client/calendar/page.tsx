import type { Metadata } from "next";
import CalendarPage from "@/app/[locale]/client/calendar/CalendarPage";

export const metadata: Metadata = {
  title: "Calendar - Property Schedule Management | Reservatior",
  description: "Manage property showings, bookings, and appointments with smart calendar tools.",
  keywords: ["calendar","schedule","property showings","appointments"],
  openGraph: {
    title: "Calendar - Property Schedule Management | Reservatior",
    description: "Manage property showings, bookings, and appointments with smart calendar tools.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function CalendarPageWrapper() {
  return <CalendarPage />;
}
