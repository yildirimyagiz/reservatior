import type { Metadata } from "next";
import AdminDocumentManagementPage from "./AdminDocumentManagementPage";

export const metadata: Metadata = {
  title: "Document Management - Admin Panel | Reservatior",
  description: "Manage documents and files from the admin panel.",
  keywords: ["documents","management","admin panel"],
  openGraph: {
    title: "Document Management - Admin Panel | Reservatior",
    description: "Manage documents and files from the admin panel.",
    type: "website",
  },
};

export default function AdminDocumentManagementPageWrapper() {
  return <AdminDocumentManagementPage />;
}
