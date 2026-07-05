import type { Metadata } from "next";
import AdminCommunicationLogsPage from "./AdminCommunicationLogsPage";

export const metadata: Metadata = {
  title: "Communication Logs - Admin Panel | Reservatior",
  description: "View and manage communication templates and logs from the admin panel.",
  keywords: ["communication","logs","templates","admin panel"],
  openGraph: {
    title: "Communication Logs - Admin Panel | Reservatior",
    description: "View and manage communication templates and logs from the admin panel.",
    type: "website",
  },
};

export default function AdminCommunicationLogsPageWrapper() {
  return <AdminCommunicationLogsPage />;
}
