import type { Metadata } from "next";
import AdminSolicitorsPage from "./AdminSolicitorsPage";

export const metadata: Metadata = {
  title: "Solicitors - Admin Panel | Reservatior",
  description: "Manage solicitor records, firm details, and legal contacts.",
  keywords: ["solicitors","admin panel","legal","law firms"],
  openGraph: {
    title: "Solicitors - Admin Panel | Reservatior",
    description: "Manage solicitor records, firm details, and legal contacts.",
    type: "website",
  },
};

export default function AdminSolicitorsPageWrapper() {
  return <AdminSolicitorsPage />;
}
