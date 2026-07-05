import type { Metadata } from "next";
import AdminMLSPage from "./AdminMLSPage";

export const metadata: Metadata = {
  title: "MLS Integration - Admin Panel | Reservatior",
  description: "Manage Multiple Listing Service integrations from the admin panel.",
  keywords: ["mls","integration","admin panel"],
  openGraph: {
    title: "MLS Integration - Admin Panel | Reservatior",
    description: "Manage Multiple Listing Service integrations from the admin panel.",
    type: "website",
  },
};

export default function AdminMLSPageWrapper() {
  return <AdminMLSPage />;
}
