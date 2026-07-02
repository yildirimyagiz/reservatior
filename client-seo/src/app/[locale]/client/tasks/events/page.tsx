import type { Metadata } from "next";
import { EventsContent } from "./EventsContent";

export const metadata: Metadata = {
  title: "Events - Events & Schedule | Reservatior",
  description: "Manage events and schedules. Track property events, inspections, and important dates.",
  keywords: ["events", "schedule", "property events", "inspections"],
  openGraph: {
    title: "Events - Events & Schedule | Reservatior",
    description: "Manage events and schedules.",
    type: "website",
  },
};

export default function EventsPage() {
  return <EventsContent />;
}
