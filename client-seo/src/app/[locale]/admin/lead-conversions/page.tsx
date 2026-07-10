import type { Metadata } from "next";
import AdminLeadConversionsPage from "./AdminLeadConversionsPage";

export const metadata: Metadata = {
  title: "Lead Conversions - Admin Panel | Reservatior",
  description: "Track and manage lead conversions and scoring from the admin panel.",
  keywords: ["leads", "conversions", "scoring", "admin panel"],
  openGraph: {
    title: "Lead Conversions - Admin Panel | Reservatior",
    description: "Track and manage lead conversions and scoring from the admin panel.",
    type: "website",
  },
};

export default function AdminLeadConversionsPageWrapper() {
  return <AdminLeadConversionsPage />;
}
