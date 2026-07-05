import type { Metadata } from "next";
import AdminExportJobsPage from "./AdminExportJobsPage";

export const metadata: Metadata = {
  title: "Export Jobs - Admin Panel | Reservatior",
  description: "Monitor and manage data export jobs from the admin panel.",
  keywords: ["export","jobs","admin panel"],
  openGraph: {
    title: "Export Jobs - Admin Panel | Reservatior",
    description: "Monitor and manage data export jobs from the admin panel.",
    type: "website",
  },
};

export default function AdminExportJobsPageWrapper() {
  return <AdminExportJobsPage />;
}
