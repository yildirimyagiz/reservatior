import type { Metadata } from "next";
import AdminAttachmentsPage from "./AdminAttachmentsPage";

export const metadata: Metadata = {
  title: "Attachments - Admin Panel | Reservatior",
  description: "Manage file attachments and uploads from the admin panel.",
  keywords: ["attachments", "files", "uploads", "admin panel"],
  openGraph: {
    title: "Attachments - Admin Panel | Reservatior",
    description: "Manage file attachments and uploads from the admin panel.",
    type: "website",
  },
};

export default function AdminAttachmentsPageWrapper() {
  return <AdminAttachmentsPage />;
}
