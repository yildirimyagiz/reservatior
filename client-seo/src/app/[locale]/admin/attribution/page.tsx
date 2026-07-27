import type { Metadata } from "next";
import Dashboard from "./Dashboard";

export const metadata: Metadata = {
  title: "Closed-Loop Attribution - Admin Panel | Reservatior",
  description: "Closed-loop attribution tracking and revenue attribution dashboard for the admin panel.",
  keywords: ["attribution", "revenue", "tracking", "capi", "google ads", "meta ads"],
  openGraph: {
    title: "Closed-Loop Attribution - Admin Panel | Reservatior",
    description: "Closed-loop attribution tracking and revenue attribution dashboard for the admin panel.",
    type: "website",
  },
};

export default function AttributionPage() {
  return <Dashboard />;
}
