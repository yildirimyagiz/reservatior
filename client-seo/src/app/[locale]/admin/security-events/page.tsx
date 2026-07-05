import type { Metadata } from "next";
import AdminSecurityEventsPage from "./AdminSecurityEventsPage";

export const metadata: Metadata = {
  title: "Security Events - Admin Panel | Reservatior",
  description: "Monitor and analyze security events from the admin panel.",
  keywords: ["security", "events", "monitoring", "admin panel"],
  openGraph: {
    title: "Security Events - Admin Panel | Reservatior",
    description: "Monitor and analyze security events from the admin panel.",
    type: "website",
  },
};

export default function AdminSecurityEventsPageWrapper() {
  return <AdminSecurityEventsPage />;
}
