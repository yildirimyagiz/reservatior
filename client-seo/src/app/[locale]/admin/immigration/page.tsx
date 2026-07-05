import type { Metadata } from "next";
import AdminImmigrationPage from "./AdminImmigrationPage";

export const metadata: Metadata = {
  title: "Immigration - Admin Panel | Reservatior",
  description: "Manage immigration cases, visa applications, and compliance documents.",
  keywords: ["immigration","admin panel","visa","compliance"],
  openGraph: {
    title: "Immigration - Admin Panel | Reservatior",
    description: "Manage immigration cases, visa applications, and compliance documents.",
    type: "website",
  },
};

export default function AdminImmigrationPageWrapper() {
  return <AdminImmigrationPage />;
}
