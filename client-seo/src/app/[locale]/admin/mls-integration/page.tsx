import type { Metadata } from "next";
import AdminMLSIntegrationPage from "./AdminMLSIntegrationPage";

export const metadata: Metadata = {
  title: "MLS Integration - Admin Panel | Reservatior",
  description: "Configure MLS (Multiple Listing Service) integrations from the admin panel.",
  keywords: ["MLS", "integration", "real estate", "admin panel"],
  openGraph: {
    title: "MLS Integration - Admin Panel | Reservatior",
    description: "Configure MLS (Multiple Listing Service) integrations from the admin panel.",
    type: "website",
  },
};

export default function AdminMLSIntegrationPageWrapper() {
  return <AdminMLSIntegrationPage />;
}
