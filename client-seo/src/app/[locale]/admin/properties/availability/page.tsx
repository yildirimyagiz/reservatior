import type { Metadata } from "next";
import PropertyAvailabilityPage from "./PropertyAvailabilityPage";

export const metadata: Metadata = {
  title: "Property Availability - Calendar Management | Reservatior",
  description: "Manage property availability calendars and booking schedules.",
  keywords: ["availability","calendar","booking schedule","property calendar"],
  openGraph: {
    title: "Property Availability - Calendar Management | Reservatior",
    description: "Manage property availability calendars and booking schedules.",
    type: "website",
  },
};

export default function PropertyAvailabilityPageWrapper() {
  return <PropertyAvailabilityPage />;
}
