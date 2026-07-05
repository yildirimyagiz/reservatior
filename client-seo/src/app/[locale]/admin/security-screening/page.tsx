import type { Metadata } from "next";
import AdminSecurityScreeningPage from "./AdminSecurityScreeningPage";

export const metadata: Metadata = {
  title: "Security Screening - Admin Panel | Reservatior",
  description: "Screen and verify user security from the admin panel.",
  keywords: ["security","screening","verification","admin panel"],
  openGraph: {
    title: "Security Screening - Admin Panel | Reservatior",
    description: "Screen and verify user security from the admin panel.",
    type: "website",
  },
};

export default function AdminSecurityScreeningPageWrapper() {
  return <AdminSecurityScreeningPage />;
}
