import type { Metadata } from "next";
import EventsPage from "./EventsPage";

export const metadata: Metadata = {
  title: "Events - Real Estate Event Management | Reservatior",
  description: "Manage and track real estate events, open houses, and property showcases.",
  keywords: ["events","open houses","property showcases","real estate events"],
  openGraph: {
    title: "Events - Real Estate Event Management | Reservatior",
    description: "Manage and track real estate events, open houses, and property showcases.",
    type: "website",
  },
  robots: { index: false, follow: false },
};

export default function EventsPageWrapper() {
  return <EventsPage />;
}
